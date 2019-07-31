Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbfGaWl2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 18:41:28 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v5 1/7] s390: vfio-ap: Refactor vfio_ap driver probe and remove callbacks
Date: Wed, 31 Jul 2019 18:41:11 -0400
Message-Id: <1564612877-7598-2-git-send-email-akrowiak@linux.ibm.com>
In-Reply-To: <1564612877-7598-1-git-send-email-akrowiak@linux.ibm.com>
References: <1564612877-7598-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>

In order to limit the number of private mdev functions called from the
vfio_ap device driver as well as to provide a landing spot for dynamic
configuration code related to binding/unbinding AP queue devices to/from
the vfio_ap driver, the following changes are being introduced:

* Move code from the vfio_ap driver's probe callback into a function
  defined in the mdev private operations file.

* Move code from the vfio_ap driver's remove callback into a function
  defined in the mdev private operations file.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 23 +++--------
 drivers/s390/crypto/vfio_ap_ops.c     | 78 ++++++++++++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_private.h |  6 +--
 3 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 003662aa8060..9e61d4c6e6b5 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -49,15 +49,9 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
  */
 static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 {
-	struct vfio_ap_queue *q;
-
-	q = kzalloc(sizeof(*q), GFP_KERNEL);
-	if (!q)
-		return -ENOMEM;
-	dev_set_drvdata(&apdev->device, q);
-	q->apqn = to_ap_queue(&apdev->device)->qid;
-	q->saved_isc = VFIO_AP_ISC_INVALID;
-	return 0;
+	struct ap_queue *queue = to_ap_queue(&apdev->device);
+
+	return vfio_ap_mdev_probe_queue(queue);
 }
 
 /**
@@ -68,17 +62,10 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
  */
 static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 {
-	struct vfio_ap_queue *q;
-	int apid, apqi;
+	struct ap_queue *queue = to_ap_queue(&apdev->device);
 
 	mutex_lock(&matrix_dev->lock);
-	q = dev_get_drvdata(&apdev->device);
-	dev_set_drvdata(&apdev->device, NULL);
-	apid = AP_QID_CARD(q->apqn);
-	apqi = AP_QID_QUEUE(q->apqn);
-	vfio_ap_mdev_reset_queue(apid, apqi, 1);
-	vfio_ap_irq_disable(q);
-	kfree(q);
+	vfio_ap_mdev_remove_queue(queue);
 	mutex_unlock(&matrix_dev->lock);
 }
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0604b49a4d32..e9a6a7d8395d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -144,7 +144,7 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
  * Returns if ap_aqic function failed with invalid, deconfigured or
  * checkstopped AP.
  */
-struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
+static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 {
 	struct ap_qirq_ctrl aqic_gisa = {};
 	struct ap_queue_status status;
@@ -1128,23 +1128,47 @@ static void vfio_ap_irq_disable_apqn(int apqn)
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
+			break;
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
@@ -1169,14 +1193,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
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
@@ -1302,3 +1322,31 @@ void vfio_ap_mdev_unregister(void)
 {
 	mdev_unregister_device(&matrix_dev->device);
 }
+
+int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
+{
+	struct vfio_ap_queue *q;
+
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+	dev_set_drvdata(&queue->ap_dev.device, q);
+	q->apqn = queue->qid;
+	q->saved_isc = VFIO_AP_ISC_INVALID;
+
+	return 0;
+}
+
+void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
+{
+	struct vfio_ap_queue *q;
+	int apid, apqi;
+
+	q = dev_get_drvdata(&queue->ap_dev.device);
+	dev_set_drvdata(&queue->ap_dev.device, NULL);
+	apid = AP_QID_CARD(q->apqn);
+	apqi = AP_QID_QUEUE(q->apqn);
+	vfio_ap_mdev_reset_queue(apid, apqi);
+	vfio_ap_irq_disable(q);
+	kfree(q);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index f46dde56b464..5cc3c2ebf151 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -90,8 +90,6 @@ struct ap_matrix_mdev {
 
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
-int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
-			     unsigned int retry);
 
 struct vfio_ap_queue {
 	struct ap_matrix_mdev *matrix_mdev;
@@ -100,5 +98,7 @@ struct vfio_ap_queue {
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
 };
-struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);
+int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
+void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
