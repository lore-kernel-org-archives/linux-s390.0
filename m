Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 1/7] s390: vfio-ap: wait for queue empty on queue reset
Date: Fri,  3 May 2019 17:14:27 -0400
Message-Id: <1556918073-13171-2-git-send-email-akrowiak@linux.ibm.com>
In-Reply-To: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Refactors the AP queue reset function to wait until the queue is empty
after the PQAP(ZAPQ) instruction is executed to zero out the queue as
required by the AP architecture.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 900b9cf20ca5..b88a2a2ba075 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -271,6 +271,32 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
+static void vfio_ap_mdev_wait_for_qempty(unsigned long apid, unsigned long apqi)
+{
+	struct ap_queue_status status;
+	ap_qid_t qid = AP_MKQID(apid, apqi);
+	int retry = 5;
+
+	do {
+		status = ap_tapq(qid, NULL);
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			if (status.queue_empty)
+				return;
+			msleep(20);
+			break;
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			msleep(20);
+			break;
+		default:
+			pr_warn("%s: tapq err %02x: %04lx.%02lx may not be empty\n",
+				__func__, status.response_code, apid, apqi);
+			return;
+		}
+	} while (--retry);
+}
+
 /**
  * assign_adapter_store
  *
@@ -790,15 +816,18 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
-				    unsigned int retry)
+int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi)
 {
 	struct ap_queue_status status;
+	int retry = 5;
 
 	do {
 		status = ap_zapq(AP_MKQID(apid, apqi));
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
+			vfio_ap_mdev_wait_for_qempty(apid, apqi);
+			return 0;
+		case AP_RESPONSE_DECONFIGURED:
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
@@ -824,7 +853,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 			     matrix_mdev->matrix.apm_max + 1) {
 		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
 				     matrix_mdev->matrix.aqm_max + 1) {
-			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
+			ret = vfio_ap_mdev_reset_queue(apid, apqi);
 			/*
 			 * Regardless whether a queue turns out to be busy, or
 			 * is not operational, we need to continue resetting
-- 
2.7.4
