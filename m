Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249AC253B58;
	Tue, 18 Aug 2026 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081647; cv=none; b=RcuizoZWBdBjCoXWefEXEwTlYM2nwP4EebpKydYQGd3Ppu5HjvKCuw0kdcRUz57jg2ZuqHjxek+nXNXcdYIpgjyh42SzPyE+qYbnyjMyL4Qiq6tmnhynbFfSE9VPPLZW+ji4iLHlV+OV1IjxIP9JsocrLDArnvGU3pe+BLtLSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081647; c=relaxed/simple;
	bh=vaIxF/+FNPZzHNQXlPZ2Ml3Notq8TvIi5NaYLNxULJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP/CivtlQU986E+UQmkx/P2l4EnCHZRMTIdEn6XJQMgddGdlZYVmKzPq457xIhX8+GwcrvXsee49TwM0kxtaJd+IaSFVH8O4jTeUXpd1q731tDN5VJCyf1IVtO/9bUya4R+Cdkmdjsg8dc51y740GBJLsE+UVFR9J0yTDgU2oH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YuoMTlDd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YuoMTlDd"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IJW2O1139655;
	Tue, 18 Aug 2026 19:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pPNPZaULBzzhdf1YB
	sj3yxx1dxvYlxHh2yIQhjkywfo=; b=YuoMTlDdDebMsHlsHCzkBmQi8i4d0SJKS
	TgVUK2czOJupZrlzeqEd2KRnNIO5CIOwDXw0NiRPpovgtQbqnIBEiysZRoEZP1Fq
	7WfSGCxGFumlcNMoDzYBbb2LNANJdsIefmiziyorIOtG5f5IYHMITEBOfsQjFAA2
	mfwufMHCNeOWKR+F4q8hLNT1d4jWtJmwUf8Rz+nuNrzuZDbqxLsy5Dwb9AIW0cj6
	Xl1LoasJVL6N3mOFpwCT0+D+p56LKCZvJ9C5G3/ck6iJEyvY3VFiM5Faw2eWKkh3
	ZhC5HvXvzuSPggcFtMHeGlKqiBeI7o9lyWFKdlKuDmUuLfX7Dq7Ig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehea2vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:33:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJV9Zs026232;
	Tue, 18 Aug 2026 19:33:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ycuxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:33:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJXrkl33358536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:33:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBEE458060;
	Tue, 18 Aug 2026 19:33:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B586A5803F;
	Tue, 18 Aug 2026 19:33:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.26.94])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:33:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 1/1] s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config
Date: Tue, 18 Aug 2026 15:33:49 -0400
Message-ID: <20260818193349.1877940-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
References: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX7DR6A8dpf2FL
 rwfSYdxE1rY54dY48z7agcZCB0nTM57ON0O+hOUUINNV7HDBG1eDejaM1BKuIIxb4JmuDQfPsKx
 UlJMy2SUVGqXl/l0CNE3BnXuH2eDgtOMBuVofCfBb03WJzB10QVLCvXy3GScYC1XYG2IEAHi3SQ
 k1594wb5prEc5UQkp8cz9vPKjMxmtbyz7hgHntbDR6BakNKwQDrmwL/faoV+dR+83qU3Q/Rm2kv
 wPKnq09GPmDfK+P5Jw+lPTvjWx5z31TmNJe1KnO7TQ5q0xBTYMVeZveCQ6OOZK/aAYttdLdgBwZ
 E1QtIVAwnyrS3WjQJpStML54vO8SZw51kXI7irH/zNkAUBmQtOhr3ern2l0VtnhLn9J+x69yiR+
 m2jXPW2J//lBXKWddNM3APPr4UZLqXT091YPlcLu5cvxjnqxmyoHPQXwBGXL9hySr30dfhj18D4
 fcH3qcGTh1zZ6RT14tQ==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a84b3a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QrY7-kXp_XPG7wcOw4EA:9
X-Proofpoint-ORIG-GUID: _-NrxQ9rVV60-B-F7l4twAh1ZGP0hPzz
X-Proofpoint-GUID: _-NrxQ9rVV60-B-F7l4twAh1ZGP0hPzz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX4W94IGJAKycd
 CdUyj76TxRP/1j0QfrjoIbCUcR1U26O99kzC0cWiSXPHKmUsUDO2hC4NcwEipe+EPiIsCSF09Xb
 0YiaxalqXuzJviYCcIfW0RkWnHZh1z4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180143

Three related problems exist in the handling of KVM interrupt and page
resources when a queue is removed from the host's AP configuration
while assigned to a mediated device (mdev).

Problem 1:
~~~~~~~~~
AP_RESPONSE_Q_NOT_AVAIL not handled in vfio_ap_mdev_reset_queue()

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

Problem 2:
~~~~~~~~~
 AP_RESPONSE_Q_NOT_AVAIL not handled in apq_status_check()

In vfio_ap_mdev_reset_queue(), there are four cases that indicate a queue
reset has not yet completed, in which case apq_reset_check() is queued to
a work queue to verify completion of the reset operation. This function
uses the PQAP(TAPQ) function to get the queue's status and calls
apq_status_check() to verify whether the reset has completed, failed or
needs to be executed again. As described in Problem #1 above,
apq_reset_check() does not specifically check for AP_RESPONSE_Q_NOT_AVAIL,
thereby potentially leaking KVM GISC registration and the pinned guest page
holding the NIB.

This is fixed by adding a case statement for AP_RESPONSE_Q_NOT_AVAIL to
apq_status_check() and returning -ENODEV for that case. The caller,
apq_reset_check() will then check for this return code and call
vfio_ap_free_aqic_resources() to prevent the leak.

Problem 3:
~~~~~~~~~
vfio_ap_free_aqic_resources() leaks saved_isc when kvm is NULL

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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..cf904993c441 100644
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
@@ -1935,6 +1935,8 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 		 * a value indicating a reset needs to be performed again.
 		 */
 		return -EAGAIN;
+	case AP_RESPONSE_Q_NOT_AVAIL:
+		return -ENODEV;
 	default:
 		WARN(true,
 		     "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
@@ -1961,6 +1963,10 @@ static void apq_reset_check(struct work_struct *reset_work)
 		ret = apq_status_check(q->apqn, &status);
 		if (ret == -EIO)
 			return;
+		if (ret == -ENODEV) {
+			vfio_ap_free_aqic_resources(q);
+			return;
+		}
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
@@ -2004,6 +2010,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		break;
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
+	case AP_RESPONSE_Q_NOT_AVAIL:
 		vfio_ap_free_aqic_resources(q);
 		break;
 	default:
@@ -2499,12 +2506,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
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

