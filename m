Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfHLUrZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Aug 2019 16:47:25 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH] s390: vfio-ap: remove unnecessary calls to disable queue interrupts
Date: Mon, 12 Aug 2019 16:47:09 -0400
Message-Id: <1565642829-20157-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>

When an AP queue is reset (zeroized), interrupts are disabled. The queue
reset function currently tries to disable interrupts unnecessarily. This patch
removes the unnecessary calls to disable interrupts after queue reset.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0604b49a4d32..407c2f0f25f9 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1114,18 +1114,19 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static void vfio_ap_irq_disable_apqn(int apqn)
+static struct vfio_ap_queue *vfio_ap_find_qdev(int apqn)
 {
 	struct device *dev;
-	struct vfio_ap_queue *q;
+	struct vfio_ap_queue *q = NULL;
 
 	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
 				 &apqn, match_apqn);
 	if (dev) {
 		q = dev_get_drvdata(dev);
-		vfio_ap_irq_disable(q);
 		put_device(dev);
 	}
+
+	return q;
 }
 
 int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
@@ -1164,6 +1165,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 	int rc = 0;
 	unsigned long apid, apqi;
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_queue *q;
 
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
 			     matrix_mdev->matrix.apm_max + 1) {
@@ -1177,7 +1179,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 			 */
 			if (ret)
 				rc = ret;
-			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
+
+			q = vfio_ap_find_qdev(AP_MKQID(apid, apqi));
+			if (q)
+				vfio_ap_free_aqic_resources(q);
 		}
 	}
 
-- 
2.7.4
