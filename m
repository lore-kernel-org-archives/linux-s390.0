From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
Date: Fri, 22 Feb 2019 16:29:59 +0100
Message-ID: <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

When the device is remove, we must make sure to
clear the interruption and reset the AP device.

We also need to clear the CRYCB of the guest.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 35 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
 drivers/s390/crypto/vfio_ap_private.h |  3 +++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index eca0ffc..e5d91ff 100644
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
@@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
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
@@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 
 	q = dev_get_drvdata(&apdev->device);
+	if (!q)
+		return;
+
+	vfio_ap_update_crycb(q);
+	vfio_ap_mdev_reset_queue(q);
 	list_del(&q->list);
 	kfree(q);
 }
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0196065..5b9bb33 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -59,6 +59,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 			if (retry <= 0)
 				pr_warn("%s: queue 0x%04x not empty\n",
 					__func__, q->apqn);
+			vfio_ap_free_irq(q);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
@@ -83,7 +84,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
  * Unregister the ISC from the GIB alert
  * Clear the vfio_ap_queue intern fields
  */
-static void vfio_ap_free_irq(struct vfio_ap_queue *q)
+void vfio_ap_free_irq(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index e2fd2c0..cc18215 100644
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
@@ -98,4 +99,6 @@ struct vfio_ap_queue {
 	int	apqn;
 	unsigned char isc;
 };
+void vfio_ap_free_irq(struct vfio_ap_queue *q);
+int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
