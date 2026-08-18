Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B036215F;
	Tue, 18 Aug 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054312; cv=none; b=t34RF9kPZjgRJ9ibDP7yzyTkJofOVZdmBf3eWtR2U3pI4QRogBQvQpmYvoaIoXYMS2uzcTX2MiH7Kih72S0lFrPhkpxnVkInsjr4p3BMy6WArBkjI4nORmfu3OzCnt9XbXWWeijuPxJJm3FXKtL5OW8dRNM66936Gvy1B0cFiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054312; c=relaxed/simple;
	bh=Q02RgQn+XA7wiYRHbPRhwQ2jPrScPBmVA1mNJjczpBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJqdOOB3ciSp0JP327NOcSbaLoOEuzCekkEOJsdtPT9ExJ+eWMoO5Y0IpMesdOr0o6MeK05Wgqno9d3eCKP1sT5+FUPGe8Wv4BeIeYLHuM3U1/yldLP2QKRKWqRg7a0432koGmQAA/6HBnM7xpOsfVJhhGuGgE2aoRrJUGcFJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ToVn7Rsc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ToVn7Rsc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVu0K3110069;
	Tue, 18 Aug 2026 11:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/bg8OMISfgohntaYXgzdETmdkQcktffO4dxJe7p60
	a4=; b=ToVn7RscxFbLHRxxMzn3vKfautY/y8dXVQvwkXCmiSIn0r14cbyfyAjdD
	seitlsVLAhfnUMDhkbozBDVc2lwbRhnWTISNRslFMnKD5owWGbU2KDOWY8kROX2g
	smEuVMhsC2yjqBUJruRAuAjot6jyiziZdiwH/BSDraHpbFT0pyHnbegKcIc4Ok0Z
	drAeaiBSbTgyxf+0Ftmh/fCMRHIKjoJajTpR2cBbyMP/UVjZbEtiGPHflGfH7K1M
	LMbCdtjLjn+zOfS4QivxnSM8kqhRp/T4sX50Qha5Rr4Z7aIID36Viu7WqmpOGmPx
	rWqZONlrLmcZYtPnIiCUUszDZIIbw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe7kyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:58:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBuHoP017525;
	Tue, 18 Aug 2026 11:58:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yasjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:58:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IBwM5Z35455438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 11:58:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F323B5803F;
	Tue, 18 Aug 2026 11:58:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 474325804E;
	Tue, 18 Aug 2026 11:58:20 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.26.94])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 11:58:20 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH] s390/vfio-ap: Fix leak of KVM GISC resources
Date: Tue, 18 Aug 2026 07:58:19 -0400
Message-ID: <20260818115819.1656595-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX2EzqcBrKuhvS
 XpHh5i72HwdU1BJ/mqpMmO+qB9NkzB0hqN8aBEFqSEv9sjzGGRMzDna7i1rhY58+PnZb7B1jWig
 9j+UqPV1TAsqkqC161ZtRdq+/ZiGggYDbVpp9DLXyLz2++4KnBnbNNboXFd4701eQkXiHAoA7EC
 feMbsvNl1MrzEVy1+P7lHpMm4NoCXaJVLKkKLp7I4Ke7nSehkPmV+z3TXMss2OQ3kd9uKsM2+CK
 BhzopblItr2TEgBBu7bUCQKMWgD5VMyVjsK50KdeRKDB/H0a/efRtRC3vTZy8CNcrhVSQ5H239N
 XZ52HSGio594Uq/AcpubIpfYDDfpwO3P3l/y3tKhI6o8IzonM/AWm9nCycOf3ymVAJtw2o9PRwo
 xIT7+Q9mV/3PVHARpQ2fFNLjFR5P30sywVUFCNEukfiidbqWpQoT1OIDq3B1cP5tHclQweAA8Yy
 CKJhPX/UJfwacZasr5A==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a8448e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dWikMghobCptM3iWzFMA:9
X-Proofpoint-ORIG-GUID: uQ8iEsBcJzv9tCGQe9NG0AzK7yKKN-KG
X-Proofpoint-GUID: uQ8iEsBcJzv9tCGQe9NG0AzK7yKKN-KG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX/XtY6tquMdhO
 9TjbThnfm2mEizqO31HblDLwXX9jTYaUXU9kDEPNtjjcLgRUd2L4HSuULve8zVN938ZPMrH5sJ5
 zw6t7MTh3klDb1GKuIuCLaoxHKSv0H8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180085

s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config

Two related problems exist in the handling of KVM interrupt and page
resources when a queue is removed from the host's AP configuration
while assigned to a mediated device (mdev).

Problem 1: AP_RESPONSE_Q_NOT_AVAIL not handled in
vfio_ap_mdev_reset_queue()

When the AP bus removes a queue device whose adapter or domain has
been removed from the host's AP configuration,
vfio_ap_mdev_remove_queue() is called. If the queue is still in the
host's AP configuration at that point, it calls
vfio_ap_mdev_reset_queue(), which issues a PQAP(ZAPQ). Since the
adapter is already gone from the host configuration, ap_zapq() returns
AP_RESPONSE_Q_NOT_AVAIL (0x01). This response code is not handled in
vfio_ap_mdev_reset_queue()'s switch statement and falls through to
the default case, which issues a WARN but does not call
vfio_ap_free_aqic_resources(). As a result, if IRQ handling was
enabled for the queue by the guest, the KVM GISC registration and
the pinned guest page holding the notification indicator byte (NIB)
are both leaked.

This is fixed by adding AP_RESPONSE_Q_NOT_AVAIL to the same case as
AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED in
vfio_ap_mdev_reset_queue(). Like those response codes, Q_NOT_AVAIL
indicates the queue is not operational and no further reset attempts
are possible; the correct action is to free the IRQ resources
immediately.

Problem 2: vfio_ap_free_aqic_resources() leaks saved_isc when
kvm is NULL

vfio_ap_free_aqic_resources() guards the call to
kvm_s390_gisc_unregister() with:

    if (q->saved_isc != VFIO_AP_ISC_INVALID &&
        !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm)))

If matrix_mdev->kvm is NULL -- which can happen when
vfio_ap_mdev_unset_kvm() has already run and cleared kvm before a
subsequent cleanup path reaches this function -- the WARN_ON fires
and the entire block is skipped. This leaves q->saved_isc set to a
non-invalid value, creating a potential double-free on any subsequent
call to this function.

When kvm is NULL the KVM guest is already torn down, so
kvm_s390_gisc_unregister() need not and cannot be called; however,
q->saved_isc must always be cleared. Fix this by separating the
kvm_s390_gisc_unregister() call from the q->saved_isc reset. The
WARN_ON now guards only the genuinely impossible case of matrix_mdev
being NULL. A NULL kvm is handled gracefully by skipping only the
unregister call, and q->saved_isc = VFIO_AP_ISC_INVALID is set
unconditionally whenever saved_isc was not already invalid.

Additionally, add an else clause to the host-config check in
vfio_ap_mdev_remove_queue() to call vfio_ap_free_aqic_resources()
directly when the queue is not in the host's AP configuration. This
serves as a backstop: when the AP bus fires the driver .remove
callback after an adapter is removed from the host config, the queue
is by definition no longer addressable, so vfio_ap_mdev_reset_queue()
would always return Q_NOT_AVAIL. The else clause handles this case
directly without the unnecessary ap_zapq() call, and ensures cleanup
occurs even if kvm has already been set to NULL by a prior call to
vfio_ap_mdev_unset_kvm().

Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..e277062e92be 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -270,9 +270,9 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
-	if (q->saved_isc != VFIO_AP_ISC_INVALID &&
-	    !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm))) {
-		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
+	if (q->saved_isc != VFIO_AP_ISC_INVALID) {
+		if (!WARN_ON(!q->matrix_mdev) && q->matrix_mdev->kvm)
+			kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
 		q->saved_isc = VFIO_AP_ISC_INVALID;
 	}
 	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
@@ -2004,6 +2004,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		break;
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
+	case AP_RESPONSE_Q_NOT_AVAIL:
 		vfio_ap_free_aqic_resources(q);
 		break;
 	default:
@@ -2499,12 +2500,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	/*
 	 * If the queue is not in the host's AP configuration, then resetting
 	 * it will fail with response code 01, (APQN not valid); so, let's make
-	 * sure it is in the host's config.
+	 * sure it is in the host's config. If it is not, free the KVM GISC
+	 * resources.
 	 */
 	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
 	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
+	} else {
+		vfio_ap_free_aqic_resources(q);
 	}
 
 done:
-- 
2.53.0

