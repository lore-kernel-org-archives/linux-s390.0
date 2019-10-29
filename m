Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfJ2WJO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 18:09:14 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH] s390: vfio-ap: disable IRQ in remove callback results in kernel OOPS
Date: Tue, 29 Oct 2019 18:09:06 -0400
Message-Id: <1572386946-22566-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com, aekrowia <akrowiak@linux.ibm.com>

From: aekrowia <akrowiak@linux.ibm.com>

When an AP adapter card is configured off via the SE or the SCLP
Deconfigure Adjunct Processor command and the AP bus subsequently detects
that the adapter card is no longer in the AP configuration, the card
device representing the adapter card as well as each of its associated
AP queue devices will be removed by the AP bus. If one or more of the
affected queue devices is bound to the VFIO AP device driver, its remove
callback will be invoked for each queue to be removed. The remove callback
resets the queue and disables IRQ processing. If interrupt processing was
never enabled for the queue, disabling IRQ processing will fail resulting
in a kernel OOPS.

This patch verifies IRQ processing is enabled before attempting to disable
interrupts for the queue.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Signed-off-by: aekrowia <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index be2520cc010b..42d8308fd3a1 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -79,7 +79,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	apid = AP_QID_CARD(q->apqn);
 	apqi = AP_QID_QUEUE(q->apqn);
 	vfio_ap_mdev_reset_queue(apid, apqi, 1);
-	vfio_ap_irq_disable(q);
+	if (q->saved_isc != VFIO_AP_ISC_INVALID)
+		vfio_ap_irq_disable(q);
 	kfree(q);
 	mutex_unlock(&matrix_dev->lock);
 }
-- 
2.7.4
