From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 18/21] s390: vfio-ap: zeroize the AP queues.
Date: Fri, 29 Jun 2018 17:11:20 -0400
Message-ID: <1530306683-7270-19-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Let's call PAPQ(ZAPQ) to zeroize a queue:

* For each queue configured for a mediated matrix device
  when it is released.

* When an AP queue is unbound from the VFIO AP device driver.

Zeroizing a queue resets the queue, clears all pending
messages for the queue entries and disables adapter interruptions
associated with the queue.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |   12 +++++++++++-
 drivers/s390/crypto/vfio_ap_ops.c     |   33 ++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |   26 ++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index b6ff7a4..d09ffdc 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -53,7 +53,17 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 
 static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 {
-	/* Nothing to do yet */
+	struct ap_queue *ap_queue = to_ap_queue(&apdev->device);
+
+	vfio_ap_reset_queue(AP_QID_CARD(ap_queue->qid),
+			    AP_QID_QUEUE(ap_queue->qid));
+
+	/*
+	 * TODO: Ensure that no guest is using the queue and handle it
+	 * accordingly. The domain or possibly the adapter may have to
+	 * be removed from the guest's configuration which would require
+	 * hot unplug support which is forthcoming.
+	 */
 }
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 79ac0d4..e247491 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1054,6 +1054,37 @@ static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev)
 	return ret;
 }
 
+static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev, bool force)
+{
+	int ret;
+	int rc = 0;
+	unsigned long apid, apqi;
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_dev *matrix_dev =
+		to_ap_matrix_dev(mdev_parent_dev(mdev));
+
+	ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
+					     &matrix_mdev->matrix);
+	if (ret)
+		return ret;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			ret = vfio_ap_reset_queue(apid, apqi);
+			if (ret) {
+				if (force)
+					rc = ret;
+				else
+					return ret;
+			}
+		}
+	}
+
+	return rc;
+}
+
 static int vfio_ap_mdev_open(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
@@ -1107,7 +1138,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	kvm_ap_deconfigure_matrix(matrix_mdev);
-
+	vfio_ap_mdev_reset_queues(mdev, true);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	matrix_mdev->kvm = NULL;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 7792b45..97d80f3 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mdev.h>
+#include <linux/delay.h>
 
 #include "ap_bus.h"
 
@@ -68,4 +69,29 @@ struct ap_matrix_mdev {
 extern int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev);
 extern void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev);
 
+static inline int vfio_ap_reset_queue(unsigned long apid, unsigned long apqi)
+{
+	int count = 50;
+	struct ap_queue_status status;
+
+	while (count--) {
+		status = ap_zapq(AP_MKQID(apid, apqi));
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			return 0;
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			msleep(20);
+			break;
+		default:
+			pr_err("%s: error zeroizing %02lx.%04lx: response code %d ",
+			       VFIO_AP_MODULE_NAME, apid, apqi,
+			       status.response_code);
+			return -EIO;
+		}
+	};
+
+	return -EBUSY;
+}
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
1.7.1
