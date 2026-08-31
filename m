Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637046984E;
	Mon, 31 Aug 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196497; cv=none; b=PaqR3QsbehCjbfzTDNDu6W7MXK1wvLskpa5jKSKOBVt1p+lzpTNNo0nb22JsOjsPdgTF/uS1VXAInkbRnXOygT3JMbDVCsotVMZvlBjD9rlpepz01XxNZau00O8WHAoq7ttWCcRq22q5Lq7Wyj9hCGXf+DUtAJ4WXTYi/lDw8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196497; c=relaxed/simple;
	bh=UtE/4n1qiFPm7xyLR+d5HjV4rEDtuaT0rENZL7pkNZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9jbyCnIdViScjZ3g3+siE12qknUioHg0Cwy+5XQNCgALtGVea+yg1jCkcOf1FZF6cdLzCo7s8yxmZ2xzJOW+xm3smtRcdU8EHC0cHBGso+yP9tOyrI74q5umxlHqAv8j/M0QxsqWcpQg9l7FO8Ax1RwCNxgUDajCpJbBLEGvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jz7+YDZt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jz7+YDZt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1mpP2801042;
	Mon, 31 Aug 2026 17:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7CX8xtKid2KGN08xm
	hMEtD8qbqmCWjuVQwE06cOUqo0=; b=jz7+YDZtz76bh6Kk+zFpc3mOQGKOXyFFR
	MPGoGPU4FM4ojbTIlrq1Rb+gNA8MmP33WS0J5ury7kBfoPL8i2IPvtyff+0BB0vP
	cXwRkfXR2iBSD65//rzTA63viYeaBW7VDlwj8NuS2dIGHo8DTzJwWjReuTqgNRCm
	7ML16bEKO3NCf1N/SAzjFT1HAeIAFKXETEIeIVF1WTj2/IgyXf2rbXCkTySi+/fz
	WXV7ZMi4xaKhmJa8Z/N5FTXyLdObTOhxI/4qKEEl5myqi9xC+K4YFKxcQdjB6dBQ
	adheyhzLP8rUR2+3gqNn4DIpBZT9tTBAAn3pnYs5REAYMZTg/PJFg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t2k0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHBG5T016310;
	Mon, 31 Aug 2026 17:14:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq7a59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VHEljE16122554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 17:14:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 494495805C;
	Mon, 31 Aug 2026 17:14:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08AC5805A;
	Mon, 31 Aug 2026 17:14:45 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.29.117])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 17:14:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable/disable()
Date: Mon, 31 Aug 2026 13:14:40 -0400
Message-ID: <20260831171443.222225-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831171443.222225-1-akrowiak@linux.ibm.com>
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a95b689 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mhE2La7kI1ux2J5OmX4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX3Ev0SaT4R9QU
 /zjCEAbGrCmh66rfaMAM1GUdKlVljbH6dk8I6CBDos23cTMAGZIrDtv+0wcM0/ogEWCPjwRZhLF
 AVOwR2PNAowS6ixWhkIgCuBaArKH3jQ=
X-Proofpoint-ORIG-GUID: 94GSqBMlMg5wCRJtLwntVJhUQeZro7Aa
X-Proofpoint-GUID: 94GSqBMlMg5wCRJtLwntVJhUQeZro7Aa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX8Ajn4vSrmQkl
 XJaNriEvn4S263Z7wN+wAN2pGrdnUBGFJ0ensw/L+iSEBR44/SUN3AHhOLSTXqrhta+0Lfkg3rW
 76khu+hcMnpDeFQWDDTT0Pe6ddfB1F55V3SpGaU84x6O32kL8vyVJpfZonNBDhJWIX5ClkxVYSG
 PHrfFj13e9Uxd7pQQLiYbBwpb7wSkg/d4PExqE1Co619j6zspOzTDrJXSgCjw0xZ4B8ZQAB5Nco
 mG8NjbkoHK9glZkhHFh7RdyhmQD/N29sxScKcLtjejVLnAAe10J/GmWg3zvmpGuMwgrVXKu9EF+
 saZAxhr9XQEFmoX8/HYCk4C+cWQZYiMG6g4bs0iVBxlV7YYHQrKpHriKaYerVtP3QnabpZcosmQ
 pRGxdJQEnaJVOL1BN+doQ/NEi6uTrRz6plFMPgUfR8G0i6KIQCLvEVxIaHEkZ5mz//SVWxwMg3c
 T4OLFSdb390MJUFTMZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310147

The vfio_ap_irq_enable() and vfio_ap_disable() functions execute the
PQAP(AQIC) instructions to enable/disable interrupts for an AP queue.
A switch statement is used to examine the status response code returned
from the instruction to determine whether it succeeded or failed and react
accordingly.

vfio_ap_irq_enable()
~~~~~~~~~~~~~~~~~~~~
For the default case, the vfio_ap_irq_disable function is invoked to
disable interrupts for the queue and clean up the AQIC resources (i.e.,
unpin the NIB and unregister the NISC) that are stored with the
vfio_ap_queue object. There are a number of problems with this:

1. Neither the q->saved_iova nor q->saved_isc has been set for the current
   AQIC call, so the AQIC resources - assuming those values have been
   previously set - will be the NIB and NISC resources from a prior call;
   the NIB and NISC from the current call are therefore leaked.

2. Interrupts may never have been enabled. Sending a disable instruction to
   a queue that the hardware just told you is in a bad state (CHECKSTOPPED,
   DECONFIGURED, Q_NOT_AVAIL) is at best wasted work and at worst generates
   a further WARN_ONCE from inside vfio_ap_irq_disable's own default.

3. The hardware just rejected the new ap_aqic() enable attempt with an
   unexpected status. Disabling a previously-working IRQ config - assuming
   that is even possible - as a reaction to a failed enable attempt does
   not make sense; it is actively destructive, tearing down something that
   was working for no valid reason.

The fix is to unregister the NISC and an unpin the NIB used in the AQIC
call in the default case of the switch statement and leave the AQIC
resources stored with the vfio_ap_queue object alone.

Another problem with vfio_ap_irq_enable() is that the old NIB stored in
q->saved_iova from a previous AQIC are immediately freed - assuming they
are stored - as soon as the AQIC response status returns
AP_RESPONSE_NORMAL. The problem with this is, AQIC is an asynchronous
operation; the only way to tell if it has completed is to check the
I-bit (7) in the status returned from AQIC. This bit indicates whether
interrupts are enabled (1) or disabled (0).

The fix for this is to wait a specified period of time until the I-bit is
set, similar to vfio_ap_wait_for_irqclear() - waits for I-bit==0 - which
is called from vfio_ap_irq_disable() to verify the operation has completed.
If verification of I-bit == 1 occurs within a specified period of time,
freeing the old NIB (q->saved_iova) because once the I-bit is set, the new
NIB is made available for queue interrupts and any old NIB will no longer
be used. If the verification times out, then the new NIB will
be freed and the old NIB will be allowed to leak which is preferable
because the queue might still have in-flight DMA writes directed to the
old NIB which would result in a use-after-free kernel crash.

vfio_ap_irq_disable()
~~~~~~~~~~~~~~~~~~~~~
There are two problems with the way this function handles the response
code returned from the PQAP(AQIC) instruction:

1. For response codes AP_RESPONSE_NORMAL or AP_RESPONSE_OTHERWISE_CHANGED,
   a call is made to vfio_ap_wait_for_irqclear() which waits for the
   I-bit (7) - indicates whether interrupts are enabled (1) or
   disabled (0) - to be cleared. That function does not return anything, so
   there is no way to determine whether it succeeded or not. The
   vfio_ap_irq_disable() function then frees the AQIC resources. This is a
   problem because the hardware may still write to the NIB resulting in a
   use-after-free kernel crash.

   The fix for this is to add a boolean return code from
   vfio_ap_wait_for_irqclear(). This will be checked in
   vfio_ap_irq_disable() and if clearing of the IR bit could not be
   verified, the AQIC resources will be allowed to leak. This is
   preferable to a kernel crash.

2. For response code AP_RESPONSE_INVALID_ADDRESS - indicates the NIB
   address passed to PQAP(AQIC) is not valid - as well as the default case,
   the vfio_ap_irq_disable() frees the AQIC resources. Since the AQIC
   disable was rejected, the IRQ is still enabled and the hardware still
   holds the NIB address, so freeing the NIB could result in a
   use-after-free kernel crash.

   The fix for this is to allow the AQIC resources to be leaked. This is
   preferable to a kernel crash.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 152 +++++++++++++++++++++++++-----
 1 file changed, 129 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..8fb0476e3d39 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -30,6 +30,9 @@
 #define AP_QUEUE_UNASSIGNED "unassigned"
 #define AP_QUEUE_IN_USE "in use"
 
+#define AP_IRQ_DISABLED	0
+#define AP_IRQ_ENABLED	1
+
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
@@ -226,16 +229,27 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 }
 
 /**
- * vfio_ap_wait_for_irqclear - clears the IR bit or gives up after 5 tries
- * @apqn: The AP Queue number
+ * vfio_ap_wait_for_irqstate - wait for the IR bit to reach the requested state
  *
- * Checks the IRQ bit for the status of this APQN using ap_tapq.
- * Returns if the ap_tapq function succeeded and the bit is clear.
- * Returns if ap_tapq function failed with invalid, deconfigured or
- * checkstopped AP.
- * Otherwise retries up to 5 times after waiting 20ms.
+ * @apqn: the APQN of the queue
+ * @ir: the expected state of the IR bit: AP_IRQ_DISABLED or AP_IRQ_ENABLED
+ *
+ * Repeatedly polls the AP queue status via PQAP(TAPQ) every 20ms until the IR
+ * bit matches @ir, the queue becomes non-operational, or 5 retries are
+ * exhausted.
+ *
+ * Because PQAP(AQIC) initiates an asynchronous process, a condition-code 0
+ * completion does not guarantee the IR bit has reached the requested state.
+ * The caller must use this function to confirm the state before proceeding.
+ *
+ * Return:
+ * - true if the IR bit matches @ir, or the AP is non-operational (in which
+ *   case no further interrupts can be generated)
+ *
+ * - false if the IR bit still does not match @ir after all retries are
+ *   exhausted
  */
-static void vfio_ap_wait_for_irqclear(int apqn)
+static bool vfio_ap_wait_for_irqstate(int apqn, int ir)
 {
 	struct ap_queue_status status;
 	int retry = 5;
@@ -245,8 +259,8 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
-			if (!status.irq_enabled)
-				return;
+			if (status.irq_enabled == ir)
+				return true;
 			fallthrough;
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -257,12 +271,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		default:
 			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
 				  status.response_code, apqn);
-			return;
+			return true;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
-		  __func__, status.response_code, apqn);
+	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts %s for %02x.%04x\n",
+		  __func__, status.response_code,
+		  ir ? "enabled" : "disabled",
+		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	return false;
 }
 
 /**
@@ -317,8 +334,30 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		switch (status.response_code) {
 		case AP_RESPONSE_OTHERWISE_CHANGED:
 		case AP_RESPONSE_NORMAL:
-			vfio_ap_wait_for_irqclear(q->apqn);
-			goto end_free;
+			/*
+			 * AQIC disable was accepted (NORMAL), or the queue was
+			 * already disabled or a prior async request is still
+			 * completing (OTHERWISE_CHANGED).  In both cases, we must
+			 * wait until interrupt processing has been disabled
+			 * before proceeding.
+			 */
+			if (vfio_ap_wait_for_irqstate(q->apqn, AP_IRQ_DISABLED))
+				goto end_free;
+			/*
+			 * Timed out waiting to confirm interrupts are disabled.
+			 * If ap_aqic returned NORMAL, the guest would incorrectly
+			 * interpret that as a successful disable and may free or
+			 * reuse the NIB while hardware can still write to it.
+			 * Zero the status word and set OTHERWISE_CHANGED to mimic
+			 * what the hardware does for that response code. This
+			 * signals to the guest that the reset operation did not
+			 * complete.
+			 */
+			if (status.response_code == AP_RESPONSE_NORMAL) {
+				memset(&status, 0, sizeof(status));
+				status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
+			}
+			goto end_fail;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -326,18 +365,46 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			/* AP not operational; no further interrupts possible */
+			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
+				  status.response_code);
+			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
 		default:
-			/* All cases in default means AP not operational */
+			/*
+			 * The AQIC disable was rejected; IRQ is still enabled
+			 * and the hardware still holds the NIB address. Do not
+			 * free resources.
+			 */
 			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 				  status.response_code);
-			goto end_free;
+			goto end_fail;
 		}
 	} while (retries--);
 
 	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 		  status.response_code);
+
+end_fail:
+	/*
+	 * We are here either because of a failure to verify that
+	 * interrupts have been disabled, or because the AQIC instruction
+	 * failed to disable them. The AQIC resources - the pinned NIB page
+	 * and the registered guest ISC - cannot be freed here. The hardware
+	 * may still write to the NIB; freeing the pinned page would result
+	 * in a use-after-free kernel crash. The resources will therefore be
+	 * leaked. This is preferable to a use-after-free.
+	 */
+	return status;
+
 end_free:
+	/*
+	 * This label is reached because the queue was successfully disabled,
+	 * or because the queue is not operational, in which case interrupts
+	 * can not be processed, so free the AQIC resources - the pinned NIB
+	 * page and the registered guest ISC - used to enable interrupts
+	 * so they will not be leaked.
+	 */
 	vfio_ap_free_aqic_resources(q);
 	return status;
 }
@@ -432,6 +499,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	struct kvm *kvm;
 	phys_addr_t h_nib;
 	dma_addr_t nib;
+	char *msg;
 	int ret;
 
 	/* Verify that the notification indicator byte address is valid */
@@ -489,13 +557,49 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		/* See if we did clear older IRQ configuration */
+		/*
+		 * AQIC initiates an asynchronous process; however, AP_RESPONSE_NORMAL
+		 * does not guarantee interrupts are enabled yet (i.e., IR bit (7)
+		 * is set). Wait to confirm before committing the new NIB and
+		 * freeing the old resources.
+		 */
+		if (!vfio_ap_wait_for_irqstate(q->apqn, AP_IRQ_ENABLED)) {
+			/*
+			 * Timed out waiting to verify IRQs are enabled. If the
+			 * hardware is merely stalled, it might eventually complete
+			 * and write interrupt status bytes to the new NIB.
+			 *
+			 * If the NIB page is unpinned and freed here, this delayed
+			 * hardware write would result in a host use-after-free/wild
+			 * DMA write and a host kernel crash.
+			 *
+			 * To prevent this, we must leak the new resources (leave the
+			 * NIB page pinned and Guest ISC registered) and return
+			 * AP_RESPONSE_OTHERWISE_CHANGED to signal the guest to retry.
+			 */
+			msg = "%s: Timed out waiting to verify IRQs enabled for apqn=%#04x\n";
+			VFIO_AP_DBF_WARN(msg, __func__, q->apqn);
+			memset(&status, 0, sizeof(status));
+			status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
+			break;
+		}
+		/*
+		 * Now that IR=1 is confirmed (IRQs enabled), the
+		 * new NIB is in use for this queue, so no interrupts can be made
+		 * pending via any previously-registered NIB and the old
+		 * resources can be safely freed.
+		 */
 		vfio_ap_free_aqic_resources(q);
 		q->saved_iova = nib;
 		q->saved_isc = isc;
 		break;
 	case AP_RESPONSE_OTHERWISE_CHANGED:
-		/* We could not modify IRQ settings: clear new configuration */
+		/*
+		 * IRQ control is already set as requested or a prior async
+		 * request has not yet completed; in either case, this response
+		 * comes with CC=3 indicating the new NIB and ISC were not accepted by
+		 * the hardware, so clean them up.
+		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
 		if (ret)
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
@@ -503,9 +607,12 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	default:
-		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
-			status.response_code);
-		vfio_ap_irq_disable(q);
+		/* We could not modify IRQ settings: clear new configuration */
+		ret = kvm_s390_gisc_unregister(kvm, isc);
+		if (ret)
+			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
+					 __func__, ret, isc, q->apqn);
+		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	}
 
@@ -635,7 +742,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	}
 
 	status = vcpu->run->s.regs.gprs[1];
-
 	/* If IR bit(16) is set we enable the interrupt */
 	if ((status >> (63 - 16)) & 0x01)
 		qstatus = vfio_ap_irq_enable(q, status & 0x07, vcpu);
-- 
2.53.0

