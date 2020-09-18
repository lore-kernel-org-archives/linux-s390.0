Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgIRRCn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Sep 2020 13:02:43 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH] s390/vfio-ap: fix unregister GISC when KVM is already gone results in OOPS
Date: Fri, 18 Sep 2020 13:02:34 -0400
Message-Id: <20200918170234.5807-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, kwankhede@nvidia.com, borntraeger@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Attempting to unregister Guest Interruption Subclass (GISC) when the
link between the matrix mdev and KVM has been removed results in the
following:

   "Kernel panic -not syncing: Fatal exception: panic_on_oops"

This patch fixes this bug by verifying the matrix mdev and KVM are still
linked prior to unregistering the GISC.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e0bde8518745..847a88642644 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -119,11 +119,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
  */
 static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 {
-	if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev)
-		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
-	if (q->saved_pfn && q->matrix_mdev)
-		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
-				 &q->saved_pfn, 1);
+	if (q->matrix_mdev) {
+		if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev->kvm)
+			kvm_s390_gisc_unregister(q->matrix_mdev->kvm,
+						 q->saved_isc);
+		if (q->saved_pfn)
+			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
+					 &q->saved_pfn, 1);
+	}
+
 	q->saved_pfn = 0;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
 }
-- 
2.21.1
