Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92F52120D;
	Tue, 29 Sep 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684340; cv=none; b=iMRCUE1/xuXAHRdKXT3jq5Q6AuFN8Sv0tMhimpbAnvbtcZyvMI6h5pgHOykIChQf7UNveiujKEyOxguJ1+1Qf3S4ZtW7oHMsgI9mx5vaPF1tukADjC7QHC3ZGkkNBIdmYoNR1A9U1V38cYby6e6qEWOVd/OM6JzBu7P76P/TWmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684340; c=relaxed/simple;
	bh=MQgNhmup97W2EeizBnoWLdb5DeIZZgukltsVhGCcrBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEn4vZ2iKQkv6XXg0ZtflPxWrGxXPnXw3/olIJTzSM7+9huhbN58cUjPYr8RdCx4wrP2vUbsrR0Ai04Ek4VcQX0cQQVHNjyMRfHctggTFsJSRM1PAeI71ERaELa4l9+tCeVsU6WcLbpaqo6w7qLYAO1pkMnuw+rU5q5bjK64W5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TwNQ8ce3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TwNQ8ce3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5s0A2188999;
	Tue, 29 Sep 2026 12:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nldoVzS2XRUpuOsAI
	KnIdxUDEMJC1qFSP38w8eH8LjI=; b=TwNQ8ce3lqTMgmEWxv4iXOuo3w61FuWQ1
	2sDVmi/MdEpBpyyy03Yq/sLn1SmdEilrHhBWTXud2BgyiWCP6VPQ7t9EJjXcY5q7
	vnVL/Xpu3Ay7pGpBPrMz8j6JUwsrtVL6GtNz25E77DCqPT2AMaDUcyigiOKo0n5o
	mcVpU2XMxTui/6f4D6df0rDV8zeFZbWVl6OZDF1KL0xPWru3yM3w1xiu64m9sfW2
	MF3uvm5LT6cNnW/vECEyqzGJC4KNy5ZUXxuYhWmFmqqAokuzO+ncK0nXDVlKmK10
	ZpyKh1m7LBzEdw8irTKNPC3mNIgtt8ItmuTU4qcIC4uv6xPi0GJSA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr6vdc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlo391647411;
	Tue, 29 Sep 2026 12:18:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y9dee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCIm6F34013864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:18:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECC3B5805D;
	Tue, 29 Sep 2026 12:18:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B525358056;
	Tue, 29 Sep 2026 12:18:46 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.24.130])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:18:46 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v9 6/6] s390/vfio-ap: replace guest-reachable WARNs with ratelimited warnings
Date: Tue, 29 Sep 2026 08:18:37 -0400
Message-ID: <20260929121837.2715710-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX9SUKZy5dv6+v
 t33HTbTbqHcWZqHF1ynpyyz5OKueAr9O1XbbrQVS0J7FojWczkFXltZyDkz+WhKss0c0+So5L7R
 5rxpsaIbUzskiBQiULVuXs3WaniOb26DrQWOieuwhCqT0JUh9xDtn8YRHdVmjlfruFcaQg8Y5sQ
 NTD9PUTqxJb8AyfXT7gJ8/znh3Y8Auq6vK3+XTpDQIS0EA+OfnQVfF4t4OqZ+pVsHv7bmrmGQJh
 35CQyXnjaM2lOoEJ/XRs61WicM2TvIf64VJJ7MoE5O0kFMEAgskPraUxDvXZi4yqjz4kQxCATxc
 pliggetHiuoJANwNv3vvR3p9BJjJYQe9UETTKJuFAVIlq5hJ4TXDGj3AnuZFifDIPCLP2uCuucy
 KA31w4mj9oIVphS/DGB/URf0epSeSZKkj7RKCsGqLcb3fNsnXZntQozzxB0088TDiLq6oopCjEY
 c4Yz9drdFxOYIhqJarA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbacaa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ZuJQWQwoYw3vcLB7AWsA:9
X-Proofpoint-ORIG-GUID: FN0C9scwkd0iGOTfqc5rROKZSmOaN7UJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX8uh7O/TnZzL1
 cFYlC8imNn3AvUg+uE34Mq2JL/Nc+TPDlRgUH5Hmp9+VERqFeQ7RDsCBYvUvScqs88q57yqVq2D
 OSuFuCmNxmqrx0mzttd0XZobKzunkws=
X-Proofpoint-GUID: FN0C9scwkd0iGOTfqc5rROKZSmOaN7UJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290048

WARN and WARN_ONCE macros in code paths reachable by a guest
can be triggered repeatedly by a malicious or misbehaving guest,
flooding the kernel log and potentially impacting system
stability. Replace all WARN and WARN_ONCE calls reachable from
the guest AP interrupt enable/disable and queue reset paths with
ratelimited warning functions. When the queue is assigned to
an mdev, dev_warn_ratelimited() is used so the mdev device name
(which includes the UUID) appears in the message. Otherwise,
pr_warn_ratelimited() is used.

Five reporting functions are introduced:

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

report_gisc_unregister_failure() - reports a failure to
unregister the guest ISC due to the fact that
q->matrix_mdev or q->matrix_mdev->kvm is NULL.

handle_pqap() is refactored to address the concern that
per-call-site ratelimit state allows a misbehaving guest to
suppress warning messages for other guests. A new helper,
vfio_ap_mdev_for_apqn(), is introduced to look up the
matrix_mdev assigned to an APQN under matrix_dev->guests_lock
and matrix_dev->mdevs_lock. handle_pqap() now takes both
locks at the top, calls vfio_ap_mdev_for_apqn() once, and
uses a single out_unlock exit point. All warning paths use
dev_warn_ratelimited() scoped to the mdev device, so the
ratelimit state is per-mdev rather than per-call-site,
preventing one guest's mdev from suppressing messages for
another.

The former pr_warn_ratelimited() fallback paths (for the case
where no matrix_mdev could be found) are eliminated: if no
matrix_mdev is found or it has no KVM attached, handle_pqap()
returns -ENODEV immediately with no dmesg noise, since neither
condition is actionable by an operator in real time.

A consistency check is added after the matrix_mdev lookup:
if pqap_hook is registered, the matrix_mdev it belongs to
(via container_of) and its KVM instance are compared against
the matrix_mdev found by vfio_ap_mdev_for_apqn() and the
vCPU's KVM. A mismatch indicates a driver bug and is logged
to the s390 debug feature ring buffer via VFIO_AP_DBF_WARN().

vfio_ap_mdev_for_queue() is refactored to delegate to
vfio_ap_mdev_for_apqn(), eliminating duplicate list-walk
logic.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 250 ++++++++++++++++++------------
 1 file changed, 148 insertions(+), 102 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 89efb73d7035..7b1da9614627 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -226,6 +226,58 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 	return NULL;
 }
 
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
 /**
  * vfio_ap_wait_for_irqclear - wait for the IR bit to clear after a disable
  *
@@ -256,14 +308,16 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
  *
  * -EIO		PQAP-TAPQ returned an invalid response code
  */
-static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_status)
+static int vfio_ap_wait_for_irqclear(struct vfio_ap_queue *q,
+				     struct ap_queue_status *tapq_status)
 {
 	struct ap_queue_status status;
 	int retry = 5;
 
 	do {
-		status = ap_tapq(apqn, NULL);
+		status = ap_tapq(q->apqn, NULL);
 		memcpy(tapq_status, &status, sizeof(status));
+
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
@@ -276,8 +330,6 @@ static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_stat
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
 			return -ENODEV;
 		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 		case AP_RESPONSE_ASSOC_FAILED:
@@ -289,19 +341,15 @@ static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_stat
 			 * since that would happen anyway if we continued to
 			 * execute the TAPQ.
 			 */
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
+			report_tapq_rc(q, status.response_code);
 			return -ETIMEDOUT;
 		default:
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
+			report_tapq_rc(q, status.response_code);
 			return -EIO;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
-		  __func__, status.response_code,
-		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	report_irqclear_timeout(q, status.response_code);
 
 	return -ETIMEDOUT;
 }
@@ -411,7 +459,8 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 			 * wait until interrupt processing has been disabled
 			 * before proceeding.
 			 */
-			ret = vfio_ap_wait_for_irqclear(q->apqn, &tapq_status);
+			ret = vfio_ap_wait_for_irqclear(q, &tapq_status);
+
 			if (ret == 0 || ret == -ENODEV)
 				goto end_free;
 
@@ -458,8 +507,7 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
 			/* AP not operational; no further interrupts possible */
-			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
-				  status.response_code);
+			report_aqic_disable_error(q, status.response_code);
 			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
 		case AP_RESPONSE_INVALID_GISA:
@@ -471,14 +519,12 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
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
@@ -607,7 +653,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
@@ -622,7 +671,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
@@ -645,7 +697,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
@@ -691,9 +746,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
@@ -707,51 +767,40 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
 }
 
 /**
- * vfio_ap_le_guid_to_be_uuid - convert a little endian guid array into an array
- *				of big endian elements that can be passed by
- *				value to an s390dbf sprintf event function to
- *				format a UUID string.
- *
- * @guid: the object containing the little endian guid
- * @uuid: a six-element array of long values that can be passed by value as
- *	  arguments for a formatting string specifying a UUID.
- *
- * The S390 Debug Feature (s390dbf) allows the use of "%s" in the sprintf
- * event functions if the memory for the passed string is available as long as
- * the debug feature exists. Since a mediated device can be removed at any
- * time, it's name can not be used because %s passes the reference to the string
- * in memory and the reference will go stale once the device is removed .
- *
- * The s390dbf string formatting function allows a maximum of 9 arguments for a
- * message to be displayed in the 'sprintf' view. In order to use the bytes
- * comprising the mediated device's UUID to display the mediated device name,
- * they will have to be converted into an array whose elements can be passed by
- * value to sprintf. For example:
- *
- * guid array: { 83, 78, 17, 62, bb, f1, f0, 47, 91, 4d, 32, a2, 2e, 3a, 88, 04 }
- * mdev name: 62177883-f1bb-47f0-914d-32a22e3a8804
- * array returned: { 62177883, f1bb, 47f0, 914d, 32a2, 2e3a8804 }
- * formatting string: "%08lx-%04lx-%04lx-%04lx-%02lx%04lx"
+ * vfio_ap_mdev_for_apqn - find the matrix mdev to which an APQN is assigned.
+ *
+ * @apqn: the APQN to look up.
+ *
+ * Must be called with matrix_dev->guests_lock held to protect the
+ * mdev_list traversal.
+ *
+ * Return: the ap_matrix_mdev to which @apqn is assigned, or NULL if it is
+ *	   not assigned to any matrix mdev.
  */
-static void vfio_ap_le_guid_to_be_uuid(guid_t *guid, unsigned long *uuid)
+static struct ap_matrix_mdev *vfio_ap_mdev_for_apqn(int apqn)
 {
-	/*
-	 * The input guid is ordered in little endian, so it needs to be
-	 * reordered for displaying a UUID as a string. This specifies the
-	 * guid indices in proper order.
-	 */
-	uuid[0] = le32_to_cpup((__le32 *)guid);
-	uuid[1] = le16_to_cpup((__le16 *)&guid->b[4]);
-	uuid[2] = le16_to_cpup((__le16 *)&guid->b[6]);
-	uuid[3] = *((__u16 *)&guid->b[8]);
-	uuid[4] = *((__u16 *)&guid->b[10]);
-	uuid[5] = *((__u32 *)&guid->b[12]);
+	struct ap_matrix_mdev *matrix_mdev;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (test_bit_inv(AP_QID_CARD(apqn),
+				 matrix_mdev->matrix.apm) &&
+		    test_bit_inv(AP_QID_QUEUE(apqn),
+				 matrix_mdev->matrix.aqm))
+			return matrix_mdev;
+	}
+
+	return NULL;
 }
 
 /**
@@ -777,9 +826,9 @@ static void vfio_ap_le_guid_to_be_uuid(guid_t *guid, unsigned long *uuid)
  */
 static int handle_pqap(struct kvm_vcpu *vcpu)
 {
+	int ret = 0;
 	uint64_t status;
 	uint16_t apqn;
-	unsigned long uuid[6];
 	struct vfio_ap_queue *q;
 	struct ap_queue_status qstatus = {
 			       .response_code = AP_RESPONSE_Q_NOT_AVAIL, };
@@ -787,32 +836,39 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 
 	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
 
-	/* If we do not use the AIV facility just go to userland */
-	if (!(vcpu->arch.sie_block->eca & ECA_AIV)) {
-		VFIO_AP_DBF_WARN("%s: AIV facility not installed: apqn=0x%04x, eca=0x%04x\n",
-				 __func__, apqn, vcpu->arch.sie_block->eca);
-
-		return -EOPNOTSUPP;
-	}
-
+	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = vfio_ap_mdev_for_apqn(apqn);
+	if (!matrix_mdev || !matrix_mdev->kvm) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 
-	if (!vcpu->kvm->arch.crypto.pqap_hook) {
-		VFIO_AP_DBF_WARN("%s: PQAP(AQIC) hook not registered with the vfio_ap driver: apqn=0x%04x\n",
+	/*
+	 * Verify that the pqap_hook registered with this vCPU's KVM belongs
+	 * to the matrix_mdev found via the APQN lookup, and that the KVM
+	 * instance matches. These should always agree; a mismatch indicates
+	 * an inconsistency between the APQN assignment and the hook
+	 * registration that warrants investigation.
+	 */
+	if (vcpu->kvm->arch.crypto.pqap_hook &&
+	    (container_of(vcpu->kvm->arch.crypto.pqap_hook,
+			  struct ap_matrix_mdev, pqap_hook) != matrix_mdev ||
+	     vcpu->kvm != matrix_mdev->kvm)) {
+		VFIO_AP_DBF_WARN("%s: pqap_hook/kvm mismatch for apqn=0x%04x\n",
 				 __func__, apqn);
-
+		ret = -EINVAL;
 		goto out_unlock;
 	}
 
-	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
-				   struct ap_matrix_mdev, pqap_hook);
-
-	/* If the there is no guest using the mdev, there is nothing to do */
-	if (!matrix_mdev->kvm) {
-		vfio_ap_le_guid_to_be_uuid(&matrix_mdev->mdev->uuid, uuid);
-		VFIO_AP_DBF_WARN("%s: mdev %08lx-%04lx-%04lx-%04lx-%04lx%08lx not in use: apqn=0x%04x\n",
-				 __func__, uuid[0],  uuid[1], uuid[2],
-				 uuid[3], uuid[4], uuid[5], apqn);
+	/* If we do not use the AIV facility just go to userland */
+	if (!(vcpu->arch.sie_block->eca & ECA_AIV)) {
+		VFIO_AP_DBF_WARN("%s: AIV facility not installed: apqn=0x%04x, eca=0x%04x\n",
+				 __func__, apqn, vcpu->arch.sie_block->eca);
+		dev_warn_ratelimited(mdev_dev(matrix_mdev->mdev),
+				     "PQAP(AQIC) for %02x.%04x: AIV facility not installed\n",
+				     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
 
@@ -821,6 +877,10 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 		VFIO_AP_DBF_WARN("%s: Queue %02x.%04x not bound to the vfio_ap driver\n",
 				 __func__, AP_QID_CARD(apqn),
 				 AP_QID_QUEUE(apqn));
+		dev_warn_ratelimited(mdev_dev(matrix_mdev->mdev),
+				     "PQAP(AQIC) for %02x.%04x: queue not bound to the vfio_ap driver\n",
+				     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		ret = -ENODEV;
 		goto out_unlock;
 	}
 
@@ -835,7 +895,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
 	vcpu->run->s.regs.gprs[1] >>= 32;
 	mutex_unlock(&matrix_dev->mdevs_lock);
-	return 0;
+	mutex_unlock(&matrix_dev->guests_lock);
+	return ret;
 }
 
 static void vfio_ap_matrix_init(struct ap_config_info *info,
@@ -2125,7 +2186,8 @@ static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
 	return q;
 }
 
-static int apq_status_check(int apqn, struct ap_queue_status *status)
+static int apq_status_check(struct vfio_ap_queue *q,
+			    struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
@@ -2188,10 +2250,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 	case AP_RESPONSE_Q_NOT_AVAIL:
 		return -ENODEV;
 	default:
-		WARN(true,
-		     "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
-		     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
-		     status->response_code);
+		report_tapq_rc(q, status->response_code);
 		return -EIO;
 	}
 }
@@ -2261,7 +2320,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 		msleep(AP_RESET_INTERVAL);
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
-		ret = apq_status_check(q->apqn, &status);
+		ret = apq_status_check(q, &status);
 		if (ret == -EIO) {
 			/*
 			 * TAPQ returned an invalid response code indicating a
@@ -2383,10 +2442,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		 * would corrupt the new owner's memory which could crash or
 		 * compromise the host kernel.
 		 */
-		WARN(true,
-		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
-		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
-		     status.response_code);
+		report_zapq_rc(q, status.response_code);
 	}
 }
 
@@ -2685,19 +2741,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 
 static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
 {
-	struct ap_matrix_mdev *matrix_mdev;
-	unsigned long apid = AP_QID_CARD(q->apqn);
-	unsigned long apqi = AP_QID_QUEUE(q->apqn);
-
 	lockdep_assert_held(&matrix_dev->guests_lock);
 
-	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
-		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
-		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
-			return matrix_mdev;
-	}
-
-	return NULL;
+	return vfio_ap_mdev_for_apqn(q->apqn);
 }
 
 static ssize_t status_show(struct device *dev,
-- 
2.53.0

