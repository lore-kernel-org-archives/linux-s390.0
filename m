Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943F517BC6;
	Fri,  4 Sep 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561351; cv=none; b=dX3cITLw8HieEFeHYfTE1ax2t1h3z2n+Mb8NxlEoSL/uy58FE5s+D2JZubyR6y5zmpmoXZIiHVzBV424dj/4pUw0I6V6cftg+9D7lTUwoxR9wr8fzzW9wNokQURrDVhnNMK5in3m14XalGyWL8e4U/FeEOgcdHhp85C6I3s4SCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561351; c=relaxed/simple;
	bh=+xAjD3VNBKge45c8VIwjmsj0pIq0x8NRPc3aLsbltDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JElgwpE2o+j3Jm4gM0OCvPsNA+FQzxzSnG8CaSu5+UJScIb80HqZ2dfxDANq6/Jbbiq6ARPNBuEW3pARAmB5Mw4ellxVhst5g4bQn0Wtrk6AoWPAX4zXSFHwQJ9Y/mnmaZJV/8yeqEDU9NmgCjZ6isMZ5aY8DTgRSgYJpC20DP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GeW2WTfR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GeW2WTfR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684L2F5i940226;
	Fri, 4 Sep 2026 22:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/hxX3p5Pzq5SDfpej
	FbvO1lArc0064pJJ9wwyi1axtU=; b=GeW2WTfRbiCAV6lwNeXYtioEPjz3Rds0t
	//tNcEfXzeIIfy0C7/nTEtbdaGfB85gKCVTuOHGkAXfckG3tfJ31DyT9jPLq2Kz0
	xN7JtffIhRnpyyLbdi0I4GQxtfTwNrZIGO0hmS6YzP2j9uUQKYrBx+xOqwW96JlS
	RtjLJSNzySqn+yLDNJVNbaL2DrvRVzXKnn2AusacjmC/3+VhdInO648SuuaqwLJe
	PemirulDq9QddEe/FaqnnNuVBOZf746fb1Zv19UUnI+nFdtMEis7AIU4UjO6KJQ8
	ldjj6P6DF71nedzDbDH0v4Ry844eGrW+l5QiXZObWCHOHj07Y2IlA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rwkq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684MQIte028349;
	Fri, 4 Sep 2026 22:35:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqysqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684MZekM65667486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 22:35:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12E9C5806A;
	Fri,  4 Sep 2026 22:35:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11E3458065;
	Fri,  4 Sep 2026 22:35:39 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 22:35:38 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 6/6] s390/vfio-ap: replace guest-reachable WARNs with ratelimited               warnings and add dmesg visibility to DBF_WARNs
Date: Fri,  4 Sep 2026 18:35:31 -0400
Message-ID: <20260904223531.1611088-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9b47be cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=IoIihqLE2SIwnEfGGcUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX0ZPP1dXu3zVq
 vGf+czjSiN7VJvV1bpt6TaDE+0Cxpb0t43R1/6n9z4OIfTqjyRrkjUcVtCswC1cP+xk4cSQXO9K
 HJpPYgjrb9RUgt+cqN6EXNpLi/1edXAS2a93cd8R4R/GScMTwuSOPVARFHjw9XZ8ds2X6gdJDi+
 +AJ4vzQXXmwKClI5LSfXwr4gV28KKK44iHiwLHzNifN5pV2rESmSKj1UVKrzReQp/dWBpm1MYEB
 FJJqIs8+jOvcRRc4V3W1Jm9bWLNAwgX8hQG4wh8X1uWKpxygUa01yQZDP11+vgGmmnfJPKt7l4a
 1nZ5dMYY56GrnM7wiYRK/TfDlsfNYWwH9lZxfsuvvZ/iH1NimmuH+9qDQbgmTArI0R9Wg646yiU
 o5zBT8S1p5OuQBp7z2aLe4tbPEheukMJ4VCgSzFkuq2BDjGdFBbagN683TNpiNabJx6hOnWj+hE
 /MUix/IXC04EngxXd5A==
X-Proofpoint-GUID: ZYvP7p96ElAzMaouNy2wgKiFHUGkhrn2
X-Proofpoint-ORIG-GUID: ZYvP7p96ElAzMaouNy2wgKiFHUGkhrn2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX5x/H77ng6Mqv
 a6KKX7w0h/YFyxOa1nu+K7TUj2bddsgG+qRxqtuyyUGyvNhreMHevVbv8NpsE9bzg29n1nbVdiU
 LampvEt4tbOrLMewevVpV7ljE++UQGk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040209

WARN and WARN_ONCE macros in code paths reachable by a guest
can be triggered repeatedly by a malicious or misbehaving guest,
flooding the kernel log and potentially impacting system
stability. Replace all WARN and WARN_ONCE calls reachable from
the guest AP interrupt enable/disable and queue reset paths with
ratelimited warning functions. When the queue is assigned to
an mdev, dev_warn_ratelimited() is used so the mdev device name
(which includes the UUID) appears in the message. Otherwise,
pr_warn_ratelimited() is used.

Four reporting functions are introduced:

report_tapq_rc() - reports an invalid or unexpected response
code from PQAP(TAPQ). Used in vfio_ap_wait_for_irqclear() and
apq_status_check(). The signatures of both functions are changed
to accept a struct vfio_ap_queue pointer instead of an apqn so
the queue's mdev context is available for reporting.

report_irqclear_timeout() - reports a timeout waiting for the
IR bit to clear after a PQAP(AQIC) disable in
vfio_ap_wait_for_irqclear().

report_aqic_disable_error() - reports a failed PQAP(AQIC)
disable operation in vfio_ap_irq_disable(). Replaces three
WARN_ONCE calls covering the non-operational queue, rejected
disable, and retry exhaustion cases.

report_zapq_rc() - reports an invalid response code from
PQAP(ZAPQ) in vfio_ap_mdev_reset_queue().

The VFIO_AP_DBF_WARN() calls in vfio_ap_irq_enable() and
handle_pqap() are retained but augmented with companion
dev_warn_ratelimited() or pr_warn_ratelimited() calls.
VFIO_AP_DBF_WARN() writes only to the s390 debug feature
ring buffer, which requires a sysadmin to know to look in
/sys/kernel/debug/s390dbf/ to find the messages. The companion
dmesg log entries ensure that warning conditions are immediately
visible in the kernel log without requiring familiarity with
the s390 debug feature infrastructure.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 128 +++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 100ec011497f..d037632df80e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -247,13 +247,65 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
  *
  * - -ETIMEDOUT	the function timed out before the IR bit was cleared.
  */
-static int vfio_ap_wait_for_irqclear(int apqn)
+static void report_tapq_rc(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(TAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(TAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
+static void report_irqclear_timeout(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(TAPQ) timed out waiting for IRQ clear on %02x.%04x: rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(TAPQ) timed out waiting for IRQ clear on %02x.%04x: rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
+static void report_aqic_disable_error(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) disable for %02x.%04x failed with rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(AQIC) disable for %02x.%04x failed with rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
+static void report_zapq_rc(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(ZAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(ZAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
+static int vfio_ap_wait_for_irqclear(struct vfio_ap_queue *q)
 {
 	struct ap_queue_status status;
 	int retry = 5;
 
 	do {
-		status = ap_tapq(apqn, NULL);
+		status = ap_tapq(q->apqn, NULL);
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
@@ -267,15 +319,12 @@ static int vfio_ap_wait_for_irqclear(int apqn)
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
 		default:
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
+			report_tapq_rc(q, status.response_code);
 			return -ENODEV;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
-		  __func__, status.response_code,
-		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	report_irqclear_timeout(q, status.response_code);
 
 	return -ETIMEDOUT;
 }
@@ -347,7 +396,7 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 			 * wait until interrupt processing has been disabled
 			 * before proceeding.
 			 */
-			ret = vfio_ap_wait_for_irqclear(q->apqn);
+			ret = vfio_ap_wait_for_irqclear(q);
 			if (ret == 0 || ret == -ENODEV)
 				goto end_free;
 			/*
@@ -374,8 +423,7 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
 			/* AP not operational; no further interrupts possible */
-			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
-				  status.response_code);
+			report_aqic_disable_error(q, status.response_code);
 			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
 		case AP_RESPONSE_INVALID_GISA:
@@ -387,14 +435,12 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 			 * and the hardware still holds the NIB address. Do not
 			 * free resources.
 			 */
-			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
-				  status.response_code);
+			report_aqic_disable_error(q, status.response_code);
 			goto end_fail;
 		}
 	} while (retries--);
 
-	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
-		  status.response_code);
+	report_aqic_disable_error(q, status.response_code);
 
 end_fail:
 	/*
@@ -523,7 +569,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	if (vfio_ap_validate_nib(vcpu, &nib)) {
 		VFIO_AP_DBF_WARN("%s: invalid NIB address: nib=%pad, apqn=%#04x\n",
 				 __func__, &nib, q->apqn);
-
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x: invalid NIB address %pad\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), &nib);
 		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
 		return status;
 	}
@@ -538,7 +587,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		VFIO_AP_DBF_WARN("%s: vfio_pin_pages failed: rc=%d,"
 				 "nib=%pad, apqn=%#04x\n",
 				 __func__, ret, &nib, q->apqn);
-
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x: vfio_pin_pages failed rc=%d\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), ret);
 		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
 		return status;
 	}
@@ -561,7 +613,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	if (nisc < 0) {
 		VFIO_AP_DBF_WARN("%s: gisc registration failed: nisc=%d, isc=%d, apqn=%#04x\n",
 				 __func__, nisc, isc, q->apqn);
-
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x: GISC registration failed rc=%d isc=%d\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), nisc, isc);
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
 		return status;
@@ -596,9 +651,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		 * ISC that were prepared for this (rejected) request.
 		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
-		if (ret)
+		if (ret) {
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
 					 __func__, ret, isc, q->apqn);
+			dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+					     "PQAP(AQIC) enable for %02x.%04x: GISC unregister failed rc=%d isc=%d\n",
+					     AP_QID_CARD(q->apqn),
+					     AP_QID_QUEUE(q->apqn), ret, isc);
+		}
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	}
@@ -611,6 +671,11 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 				 aqic_gisa.zone, aqic_gisa.ir, aqic_gisa.gisc,
 				 aqic_gisa.gf, aqic_gisa.gisa, aqic_gisa.isc,
 				 q->apqn);
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x failed with rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn),
+				     status.response_code);
 	}
 
 	return status;
@@ -695,7 +760,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.sie_block->eca & ECA_AIV)) {
 		VFIO_AP_DBF_WARN("%s: AIV facility not installed: apqn=0x%04x, eca=0x%04x\n",
 				 __func__, apqn, vcpu->arch.sie_block->eca);
-
+		pr_warn_ratelimited("PQAP(AQIC) for %02x.%04x: AIV facility not installed\n",
+				    AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		return -EOPNOTSUPP;
 	}
 
@@ -704,7 +770,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	if (!vcpu->kvm->arch.crypto.pqap_hook) {
 		VFIO_AP_DBF_WARN("%s: PQAP(AQIC) hook not registered with the vfio_ap driver: apqn=0x%04x\n",
 				 __func__, apqn);
-
+		pr_warn_ratelimited("PQAP(AQIC) for %02x.%04x: hook not registered with the vfio_ap driver\n",
+				    AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		goto out_unlock;
 	}
 
@@ -717,6 +784,9 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 		VFIO_AP_DBF_WARN("%s: mdev %08lx-%04lx-%04lx-%04lx-%04lx%08lx not in use: apqn=0x%04x\n",
 				 __func__, uuid[0],  uuid[1], uuid[2],
 				 uuid[3], uuid[4], uuid[5], apqn);
+		dev_warn_ratelimited(mdev_dev(matrix_mdev->mdev),
+				     "PQAP(AQIC) for %02x.%04x: mdev not in use\n",
+				     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		goto out_unlock;
 	}
 
@@ -725,6 +795,9 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 		VFIO_AP_DBF_WARN("%s: Queue %02x.%04x not bound to the vfio_ap driver\n",
 				 __func__, AP_QID_CARD(apqn),
 				 AP_QID_QUEUE(apqn));
+		dev_warn_ratelimited(mdev_dev(matrix_mdev->mdev),
+				     "PQAP(AQIC) for %02x.%04x: queue not bound to the vfio_ap driver\n",
+				     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		goto out_unlock;
 	}
 
@@ -2008,7 +2081,8 @@ static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
 	return q;
 }
 
-static int apq_status_check(int apqn, struct ap_queue_status *status)
+static int apq_status_check(struct vfio_ap_queue *q,
+			    struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
@@ -2070,10 +2144,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 		return -EAGAIN;
 
 	default:
-		WARN(true,
-		     "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
-		     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
-		     status->response_code);
+		report_tapq_rc(q, status->response_code);
 		return -EIO;
 	}
 }
@@ -2143,7 +2214,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 		msleep(AP_RESET_INTERVAL);
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
-		ret = apq_status_check(q->apqn, &status);
+		ret = apq_status_check(q, &status);
 		if (ret == -EIO) {
 			/*
 			 * TAPQ returned an invalid response code. This
@@ -2255,10 +2326,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		 * AP interrupts or DMA-write to the NIB, free the AQIC resources
 		 * rather than leak them.
 		 */
-		WARN(true,
-		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
-		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
-		     status.response_code);
+		report_zapq_rc(q, status.response_code);
 		vfio_ap_free_aqic_resources(q);
 	}
 }
-- 
2.53.0

