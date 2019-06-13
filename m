Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v4 2/7] s390: vfio-ap: wait for queue empty on queue reset
Date: Thu, 13 Jun 2019 15:39:35 -0400
Message-Id: <1560454780-20359-3-git-send-email-akrowiak@linux.ibm.com>
In-Reply-To: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
References: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>

Refactors the AP queue reset function to wait until the queue is empty
after the PQAP(ZAPQ) instruction is executed to zero out the queue as
required by the AP architecture.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 49 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index bf2ab02b9a0b..60efd3d7896d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1128,23 +1128,46 @@ static void vfio_ap_irq_disable_apqn(int apqn)
 	}
 }
 
-int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
-			     unsigned int retry)
+static void vfio_ap_mdev_wait_for_qempty(ap_qid_t qid)
+{
+	struct ap_queue_status status;
+	int retry = 5;
+
+	do {
+		status = ap_tapq(qid, NULL);
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			if (status.queue_empty)
+				return;
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			msleep(20);
+			break;
+		default:
+			pr_warn("%s: tapq response %02x waiting for queue %04x.%02x empty\n",
+				__func__, status.response_code,
+				AP_QID_CARD(qid), AP_QID_QUEUE(qid));
+			return;
+		}
+	} while (--retry);
+
+	WARN_ON_ONCE(retry <= 0);
+}
+
+int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi)
 {
 	struct ap_queue_status status;
-	int retry2 = 2;
 	int apqn = AP_MKQID(apid, apqi);
+	int retry = 5;
 
 	do {
 		status = ap_zapq(apqn);
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
-			while (!status.queue_empty && retry2--) {
-				msleep(20);
-				status = ap_tapq(apqn, NULL);
-			}
-			WARN_ON_ONCE(retry <= 0);
+			vfio_ap_mdev_wait_for_qempty(AP_MKQID(apid, apqi));
 			return 0;
+		case AP_RESPONSE_DECONFIGURED:
+			return -ENODEV;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -1169,14 +1192,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 			     matrix_mdev->matrix.apm_max + 1) {
 		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
 				     matrix_mdev->matrix.aqm_max + 1) {
-			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
-			/*
-			 * Regardless whether a queue turns out to be busy, or
-			 * is not operational, we need to continue resetting
-			 * the remaining queues.
-			 */
+			ret = vfio_ap_mdev_reset_queue(apid, apqi);
 			if (ret)
 				rc = ret;
+
 			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
 		}
 	}
@@ -1326,7 +1345,7 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
 	dev_set_drvdata(&queue->ap_dev.device, NULL);
 	apid = AP_QID_CARD(q->apqn);
 	apqi = AP_QID_QUEUE(q->apqn);
-	vfio_ap_mdev_reset_queue(apid, apqi, 1);
+	vfio_ap_mdev_reset_queue(apid, apqi);
 	vfio_ap_irq_disable(q);
 	kfree(q);
 }
-- 
2.7.4
