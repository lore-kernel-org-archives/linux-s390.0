Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3A355F35;
	Fri, 28 Aug 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953627; cv=none; b=WWeBArGzdynCmUxhof+urHXp8bPy8XqueATh4OHGhgpzW0EmFv6RNYsb+7iSZVQFI07IMTcJ/+x8De+YmXEeISVooG9+57qSXLmpR2w6ltjutYntsSC5q0QY1JQU7mv2at0wnekv2ao8+HM1F9nQgLxhiN5Xa9R3+hTcUNFGR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953627; c=relaxed/simple;
	bh=eu7Cuj2YltU5X+0ytry+XH1NLU2ZDQNXc955su8ANfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCB2VMC3n70FN2DPtjn1e3NM5mHi0vRIr7rNrXSauuaZ66mU2rincT5p+JV57+Lu5f/TeU+DPJ44QQBum1484kbipRyxzLKpYgfgiRCEnYwzpPM8EhkTn7KgVJtOtkU7pFKHjKGgmKESIM3Vbz4jeeIAQnSiYuuW0OUSH0GPW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O4A111iO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O4A111iO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SJVoNj2906535;
	Fri, 28 Aug 2026 21:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JH/DxXvBVISBBL8hG
	Cj93r5pTsqPnB2I6ZLIVyPLFMA=; b=O4A111iOflip0RzTRJslV2TtDB4SEM6A9
	gM7CPEI1AIEVoz+i3ybjL+4wB6TpltdpEcLqLACbs1uKaSKL9RMR2fv0qE7FruIk
	Gdf304UVb2zPjv4jAFAQUrXHu3TluaZ8fpPSVOpL40ixjfacOmCFxHuwJ8HiT856
	+O+L2m+LldQXxWWEGnIMqY4YFm0VUBAfQnCEOUWF21v8IUIxAx+j32BClXCFuZ7V
	epD1TNqQzNJWqs9/Z+Pr5XRNJFc5b3/+SWb8ZfQcxri4VDaVkTpH5aQWY+D25rn2
	idTPhpjTabqRn7mtAhWZWQPZucovt717yOZUMprC3VuxM7C3H97CA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jfc44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:47:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SLfHiM012606;
	Fri, 28 Aug 2026 21:46:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhru3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:46:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SLkwOZ17039980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 21:46:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59ECA58059;
	Fri, 28 Aug 2026 21:46:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E03C58058;
	Fri, 28 Aug 2026 21:46:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.33.14])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 21:46:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable/disable()
Date: Fri, 28 Aug 2026 17:46:50 -0400
Message-ID: <20260828214653.1087009-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
References: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfX5rJ46Vey8ir+
 ZVOF2xaQALI/9gSiZUl/9Vq9yJdviNaWRL9EPVF+xECSRkUkA9zW6kdaWx0swo3SxzpbR186NLH
 q37WSp4YTAwElNm86PMqoQ5LlWsmfoI=
X-Proofpoint-GUID: t35JmfMFhvwedgJeAz-ODjdazHvKVenM
X-Proofpoint-ORIG-GUID: t35JmfMFhvwedgJeAz-ODjdazHvKVenM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfX2JkLUbZWfljP
 SyXBeWn1lzMbxtu65MDhI/kWT0bqHxRqs3wBKik/yUeDLfwVaFU9ekt0Md2ZJcZIxlxoo7dWNR5
 5nXJW/p4cf1Hx4qqiMOE8zeMzQZcUu+S+nfOnAma9m0tmpJN4DrIS0I8uhpf8s/ZqQ7AWJT4rdy
 zg7fGrsESBN+KQPgjQMSr/R+exOWkfjiGQlqjFwJ51/0o7eg8Ia8Bi0RQuGKCTehTxcRMQEmnH2
 OBr0eYdfuzWMWPnaTgmHqwbrotVkR+IsJgV261sTdSIDkm/TpHqmF6b9upaXwbEuhM3Hfwc/MOo
 SxYgz2Qf/zi3EXIM9s1MY4G7dZtJJe6C00mkoj7il5Jx5Ez7svZhiibZ2VcMczwjiv3oOebuSRR
 lVPqYSeyl1LuDDXevc3q2TgdCtvFNu3RRWCEFttt3053/TU0qkUTcQ0+1chyzJeNSpgYSMrS7r3
 mzpQGsgg+1Oh0cbGo0w==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a9201d4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mhE2La7kI1ux2J5OmX4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280187

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
index 940c0ff668be..24e93fb7f81a 100644
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
+		 * does not guarantee the IR bit is set yet.  Wait to confirm before
+		 * committing the new NIB and freeing the old resources.
+		 */
+		if (!vfio_ap_wait_for_irqstate(q->apqn, AP_IRQ_ENABLED)) {
+			/*
+			 * Timed out: the hardware may not have accepted the new
+			 * NIB.  Clean up the new resources and return
+			 * OTHERWISE_CHANGED to signal the guest to retry.
+			 */
+			ret = kvm_s390_gisc_unregister(kvm, isc);
+			if (ret) {
+				msg = "%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n";
+				VFIO_AP_DBF_WARN(msg, __func__, ret, isc, q->apqn);
+			}
+			vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
+			memset(&status, 0, sizeof(status));
+			status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
+			break;
+		}
+		/*
+		 * IR bit confirmed set. AQIC enable initiates an asynchronous
+		 * process; a CC=0 completion does not guarantee the process is
+		 * done. If the queue was already enabled for interrupts, the old
+		 * NIB (q->saved_iova) must not be freed until IR=1 is observed,
+		 * because until then the hardware has not completed its
+		 * transition to the new NIB. Now that IR=1 is confirmed, the
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

