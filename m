From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v6 6/7] s390: ap: Cleanup on removing the AP device
Date: Fri, 22 Mar 2019 15:43:47 +0100
Message-ID: <1553265828-27823-7-git-send-email-pmorel@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

When a AP device is remove, clear the queue's APID bit in the guest CRYCB.
to be sure that the guest will not access the AP queue anymore.

Then we clear the interruptions and reset the AP device properly.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 36 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c     | 16 +++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  3 +++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 796e73d4..850ba6e 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2018
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  */
 
 #include <linux/module.h>
@@ -12,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <asm/facility.h>
+#include <linux/bitops.h>
+#include <linux/kvm_host.h>
 #include "vfio_ap_private.h"
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
@@ -65,6 +68,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 }
 
 /**
+ * vfio_ap_update_crycb
+ * @q: A pointer to the queue being removed
+ *
+ * We clear the APID of the queue, making this queue unusable for the guest.
+ * After this function we can reset the queue without to fear a race with
+ * the guest to access the queue again.
+ * We do not fear race with the host as we still get the device.
+ */
+static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
+{
+	struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
+
+	if (!matrix_mdev)
+		return;
+
+	clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
+
+	if (!matrix_mdev->kvm)
+		return;
+
+	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
+				  matrix_mdev->matrix.apm,
+				  matrix_mdev->matrix.aqm,
+				  matrix_mdev->matrix.adm);
+}
+
+/**
  * vfio_ap_queue_dev_remove:
  *
  * Free the associated vfio_ap_queue structure
@@ -74,7 +104,13 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 
 	q = dev_get_drvdata(&apdev->device);
+	if (!q)
+		return;
+
 	mutex_lock(&matrix_dev->lock);
+	vfio_ap_update_crycb(q);
+	vfio_ap_mdev_reset_queue(q);
+	vfio_ap_free_irq(q);
 	list_del(&q->list);
 	mutex_unlock(&matrix_dev->lock);
 	kfree(q);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 7559b84..5db671c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -63,15 +63,22 @@ static int vfio_ap_find_any_domain(int apqi)
 	return 0;
 }
 
-static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
+int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 {
 	struct ap_queue_status status;
-	int retry = 1;
+	int retry = 20;
 
 	do {
 		status = ap_zapq(q->apqn);
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
+			while (!status.queue_empty && retry--) {
+				msleep(20);
+				status = ap_tapq(q->apqn, NULL);
+			}
+			if (retry <= 0)
+				pr_warn("%s: queue 0x%04x not empty\n",
+					__func__, q->apqn);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
@@ -94,7 +101,7 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
  * Unregister the ISC from the GIB alert
  * Clear the vfio_ap_queue intern fields
  */
-static void vfio_ap_free_irq(struct vfio_ap_queue *q)
+void vfio_ap_free_irq(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
@@ -320,6 +327,7 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 	list_for_each_entry_safe(q, qtmp, &matrix_mdev->qlist, list) {
 		q->matrix_mdev = NULL;
 		vfio_ap_mdev_reset_queue(q);
+		vfio_ap_free_irq(q);
 		list_move(&q->list, &matrix_dev->free_list);
 	}
 	list_del(&matrix_mdev->node);
@@ -382,6 +390,7 @@ static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev *matrix_mdev)
 		return;
 	q->matrix_mdev = NULL;
 	vfio_ap_mdev_reset_queue(q);
+	vfio_ap_free_irq(q);
 	list_move(&q->list, &matrix_dev->free_list);
 }
 
@@ -1036,6 +1045,7 @@ static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
 
 	list_for_each_entry(q, &matrix_mdev->qlist, list) {
 		ret = vfio_ap_mdev_reset_queue(q);
+		vfio_ap_free_irq(q);
 		/*
 		 * Regardless whether a queue turns out to be busy, or
 		 * is not operational, we need to continue resetting
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 968d8aa..9fe580b 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -4,6 +4,7 @@
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
  *	      Halil Pasic <pasic@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  *
  * Copyright IBM Corp. 2018
  */
@@ -103,4 +104,6 @@ struct vfio_ap_queue {
 	unsigned char a_isc;
 	unsigned char p_isc;
 };
+void vfio_ap_free_irq(struct vfio_ap_queue *q);
+int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
