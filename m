Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21D414A2A;
	Fri,  4 Sep 2026 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502024; cv=none; b=JfD0kEhbatMhlBPFo7PR22AgcO7oUHAU6fb6OfPv+SqgrcqvyOE4mpal1u/C8ymmJuJCVGRL4B+Rnx3L6sclImFYfV/JEzMGxOxDuctyWalGOR8KfvQZ+hSJC7ChMr3D9dy1gaOm9ZAJpsMvdQ2aLTgNX3tCaL833TFhgg4CJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502024; c=relaxed/simple;
	bh=M2o/W4+HMFcjQpyUn/hT+VBynojxz/D+hEJgLvWHFcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkXq1R8WB9rtB0Orf/11LO+iolI0ZPSfjnfT1aiI1y0zxKvEHBTnY2z9+1cFoZfVL3Gw05e9f6wy9jVRv3Zlt90z2q8hg5BEfwOf3o/zwyqCz8ILj2BA+0BClKcMhiY/Wj1OhmxdOOzJxotI8bFfpGUGu1p3oo5JWeqG7PGBcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a8UNjAYg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a8UNjAYg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464bt3940826;
	Fri, 4 Sep 2026 06:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sS/Skj+asxcJdSa1c
	Hdr9SGi0cR2mr89UyCDVWrZQmM=; b=a8UNjAYgPzmswoPjnPKss4gyrZyNHyHWI
	fds+/AdlL1+rYvqWikByynzbpSIOyDsrcc/iBFAimMwVJwxKkSeMvQa2IEv/l0nZ
	lmcKcv5Ky/SOn0Ots0Umkk5Bw6FgCwKOAFt4DGYIX9ljSUlczBHF+Zwd4MBjEXEX
	9oQRviiww4prnEMd/Dwo3+T8RHjccdL4NYIiK553sXbFp+1uNHFNjkKGHQoC2teG
	zA1uJUK5SnWSLjUGY9doDUpIgsPeLIkHMnUxcw8QqS4TWcsyPu2QEA9zb17EB6D5
	oo1aFK1SjwPlElXGr/cs6HAQiw3ZyGq14bFSgNkc3HFfefIEpqdzQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq55939b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:07:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uJFf031315;
	Fri, 4 Sep 2026 06:06:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkkfu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466rlQ45351340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 496152004D;
	Fri,  4 Sep 2026 06:06:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D810120049;
	Fri,  4 Sep 2026 06:06:52 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 09/11] s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config
Date: Fri,  4 Sep 2026 08:06:45 +0200
Message-ID: <20260904060647.562443-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX6gd+BpPHd6z9
 cYH2AJ8r17r6pKhqIPQ1U50GX+pjqidnuR9y9ZPQ7Zf0BsgwZzkx0UYh2RKTnxsRVDwuKLtd9yd
 ILFgMF22GDJgC63luRUa7f4Qct2xVEWzlTNBQ9jZaoEZZKm2Vn748evJw2IPh8jEhQBcNhkm+OR
 Naw+qqSZxD5sKteLxkRPeuXICLtDtBhOg11YxUgovkVeiBQYcP5j52Yvjaci6eeI7DeC4s4XMF0
 My3U/uVzrk67e+vbry8H8hvNuwZMZe/r3TvlhW1Q6IX0yV9FZC4CJIUPxoovCIq3RCh8D5yuR31
 TcxYwp3mPYod1vM16Yi7ANmwFfbfAItBlUZ3d2CTHXR8xA+Rj69PvSO2STm5yvHsg+3vYaLEpub
 Dj3CUeowjV77tLZtOQ955J6L7I6lK7ROX/JCHvXVDYKFBNsxDvHaZKIq81xgb1CB7JO5W5kOkxr
 G+yCn/p4DkuqZ45dQsg==
X-Proofpoint-ORIG-GUID: 7f4wU8e-zgDSd1D9vBPcrhgpgk9Ng7cA
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9a6004 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=QrY7-kXp_XPG7wcOw4EA:9
X-Proofpoint-GUID: 7f4wU8e-zgDSd1D9vBPcrhgpgk9Ng7cA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX0VlTydo1qgVW
 Ht2/CM90d86lYj6X+GYajPkYmDZLwjgu+XvgAQsI6637VPM5AWc/T8OQ5+2WVoRoknz3ON+ySRn
 No0VdbEhCWw27LV2sgg0tLYZGEJa6Xo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054

From: Anthony Krowiak <akrowiak@linux.ibm.com>

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
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260818193349.1877940-2-akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..4db878c18f41 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -277,9 +277,9 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
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
@@ -2528,12 +2535,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
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
2.55.0

