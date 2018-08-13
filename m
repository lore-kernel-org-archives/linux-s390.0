From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v9 17/22] s390: vfio-ap: zeroize the AP queues.
Date: Mon, 13 Aug 2018 17:48:14 -0400
Message-ID: <1534196899-16987-18-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Let's call PAPQ(ZAPQ) to zeroize a queue:

* For each queue configured for a mediated matrix device
  when it is released.

Zeroizing a queue resets the queue, clears all pending
messages for the queue entries and disables adapter interruptions
associated with the queue.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     |   25 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 368b559..cc90323 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -758,6 +758,30 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev, bool force)
+{
+	int ret;
+	int rc = 0;
+	unsigned long apid, apqi;
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			ret = vfio_ap_reset_queue(apid, apqi, 1);
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
@@ -788,6 +812,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	if (matrix_mdev->kvm)
 		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 
+	vfio_ap_mdev_reset_queues(mdev, true);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	matrix_mdev->kvm = NULL;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 3e8534b..34f982a 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -74,4 +74,29 @@ struct ap_matrix_mdev {
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
+static inline int vfio_ap_reset_queue(unsigned int apid, unsigned int apqi,
+				      unsigned int retry)
+{
+	struct ap_queue_status status;
+
+	do {
+		status = ap_zapq(AP_MKQID(apid, apqi));
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			return 0;
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			msleep(20);
+			break;
+		default:
+			pr_warn("%s: error zeroizing %02x.%04x: response code %d\n",
+				VFIO_AP_MODULE_NAME, apid, apqi,
+				status.response_code);
+			return -EIO;
+		}
+	} while (retry--);
+
+	return -EBUSY;
+}
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
1.7.1
