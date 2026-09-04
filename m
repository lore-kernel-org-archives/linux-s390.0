Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5F524AE6;
	Fri,  4 Sep 2026 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561347; cv=none; b=Mxk9jem3mkw9B6C0OYeXUm4R15xEpsPMNHymAQ27CIZ/9zys3IgiEzVjh+x0C/CqWvGRK4aWhizbh5/EZnuUfDjM+ExW5adMG9fgzvEb8MOSNEAo0HxTV2dZOI2b54CSmxBVKVVSOm6aS6fEEboPjAo/1w0Pq4es2qk+6MRrKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561347; c=relaxed/simple;
	bh=F9gk5BfzJvG4rH7kL57qJbaWkovs0vno87DSzyDGobA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJhaoVh+0FzakHw/cng7y+dj/7oXHgLVodlUrEHnnBykX5Lda2WO/uotQXaj0+UnPFDF+U5S/UhmyrHzg3jO+qMIfbdkEyKJpUDH0RAicgEY2HOXMZx+kSrwMaNFQkzThNz/dPz6mTItPyNrXFfloojnu60oOvmnBT+mrEn8Vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=USNyjYvw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="USNyjYvw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684L1vr62815882;
	Fri, 4 Sep 2026 22:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lfq6dI
	B0y0GS7qfsocQ5bwpe9EMZ4Zn7TnSFLlaWX5Y=; b=USNyjYvwVM17x1vFRLdvYz
	gje1MbFLeiZO6Y3F1WX6QlqVS2LxcX7W28jGuDLWzwzrXfZCQvG/kicKWGJVMtqr
	Uma2Pui+f+vz8FCVt1NwTDcQzNa1B6MBM29FYYVV3w3glcip1HbTL2fGD1zSnGwr
	O7gfguTH2hOKdaAQiffZaNsrnPiAaiC72y7IaFuutJl7AWYnsB/pkoGqPpvnkvs2
	4j80piZc6iRREEBSclXhjZDaYkvvWYWWvkHvbSUm0IHllSy+uTZknfkCwq3VKox3
	FzeibJopXcgHe9FwUiSBvfJLXSkKqz4u25Oh1DH3kPuGbSdLX687QYsfqozwP5+g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx65m3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684MQKRZ000716;
	Fri, 4 Sep 2026 22:35:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyqdv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684MZYsr32703194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 22:35:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3269458067;
	Fri,  4 Sep 2026 22:35:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FADF58056;
	Fri,  4 Sep 2026 22:35:33 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 22:35:32 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v7 1/6] s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
Date: Fri,  4 Sep 2026 18:35:26 -0400
Message-ID: <20260904223531.1611088-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9b47b8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2K4mVM8Jay714jXeKF0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mvfekuDBo-WpghpRFY0UU_NHT4vsOt5Q
X-Proofpoint-ORIG-GUID: mvfekuDBo-WpghpRFY0UU_NHT4vsOt5Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX9AuquvM0CVwz
 19fFvDocVNXbBnEtT0/TpYZb9qOKdVdOwiwO6MTrITwE+jkSbFIMIJH98z0LIaBkUAH6shBqCX+
 rS1BjH7uRfQYUQtwMT68do9lwRmla6A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX+VB7wOfPJY9s
 lNzKDveTBoGDTuoogaBFaRoC1J1gxhU5zBAyDmMVQKNaTDpvhv8cE3gwNUeuYa5Y05kCOE1MtmF
 hJ/9aY+w19tZ5/wLTqqUi6Y81alCjguPX2pyxM3bYIoo98o0QGMGZaJ3zfzpLT8R2gTsr1Ovbug
 XzrAAsrgk52OpOhotcMbsG+UcbuAQwuqHXOokP06CWBHNUwCa5EhdV0Q2JKra1FBu7j83R6P6AW
 ZmlRNxganx6sEBMr0BLsGEwgDBxk5EPAiRjahxF1XKnVeI70WSFKmcakpNZ5ZuMGNFH8LxXXeFy
 nz9zdEgTlD3biL7HrtvMqxE+t8YZ3MK8EWKgDPC7lKzG/QLUd2jYhbeBVbgUMQLhI4NC8X5GzYW
 VopL9xdlhbxa3HRc3LR6qkBu1pg3/2nQIXJOos+MvO1gkOyAnpx4M0OLfcdMIQ98i6S0jr3E8TF
 gOFVWGIEtH98OrrJ31w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040209

Several code paths in the vfio_ap driver failed to free the AQIC
resources — the pinned guest NIB page and the registered guest ISC
used to enable interrupts for a queue — when a queue became unavailable
or when unexpected response codes were returned. This could cause memory
exhaustion and depletion of KVM interrupt subclass registrations over time
with repeated dynamic AP reconfiguration.

vfio_ap_mdev_reset_queue()
~~~~~~~~~~~~~~~~~~~~~~~~~~
AP_RESPONSE_Q_NOT_AVAIL (0x01) was not handled, causing it to fall
through to the default case which only fired a WARN without calling
vfio_ap_free_aqic_resources(). When ap_zapq() returns this response
code the queue is physically unavailable and can no longer generate
AP interrupts or DMA-write to the NIB. Add AP_RESPONSE_Q_NOT_AVAIL
alongside AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED so
that AQIC resources are freed immediately for all three non-
operational cases.

The default case itself also failed to free AQIC resources. The
only valid response codes for PQAP-ZAPQ are 0x00, 0x01, 0x02, 0x03,
0x04, and 0x0a. Any other code indicates a hardware or firmware bug.
A malfunctioning queue cannot generate AP interrupts or DMA-write to
the NIB, so call vfio_ap_free_aqic_resources() in the default case rather
than leaking the resources.

vfio_ap_mdev_remove_queue()
~~~~~~~~~~~~~~~~~~~~~~~~~~~
When the AP bus scan detects a queue is no longer in the host AP
configuration, vfio_ap_mdev_remove_queue() skips the ZAPQ since
issuing it would return AP_RESPONSE_Q_NOT_AVAIL anyway. However,
vfio_ap_free_aqic_resources() was also never called, leaking the
pinned NIB page and registered guest ISC. Since the hardware is
gone and can no longer DMA-write to the NIB, it is safe to call
vfio_ap_free_aqic_resources() directly. Add an else branch to the
host-config test_bit_inv guard to free AQIC resources when the
queue is not in the host AP configuration. If the queue is not
assigned to an mdev, vfio_ap_free_aqic_resources() is a no-op.

apq_reset_check()
~~~~~~~~~~~~~~~~~
When apq_status_check() returns -EIO - indicating that PQAP(TAPQ)
returned an invalid response code - apq_reset_check() returned
immediately without freeing the AQIC resources. An invalid TAPQ
response code indicates a hardware or firmware bug. A malfunctioning
queue cannot generate AP interrupts or DMA-write to the NIB, so
call vfio_ap_free_aqic_resources() before returning in the -EIO
case.

vfio_ap_irq_disable()
~~~~~~~~~~~~~~~~~~~~~
The valid response codes for PQAP(AQIC) include
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS (0x0a),
AP_RESPONSE_INVALID_GISA (0x08),
AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE (0x35), and
AP_RESPONSE_ASSOC_FAILED (0x36), none of which were explicitly
handled. All four fell through to the default case and jumped to
end_fail without freeing resources.

AP_RESPONSE_STATE_CHANGE_IN_PROGRESS indicates a transient
condition, analogous to AP_RESPONSE_RESET_IN_PROGRESS and
AP_RESPONSE_BUSY. Add it to the retry case.

AP_RESPONSE_INVALID_GISA indicates the AQIC instruction was
rejected due to an invalid GISA address. The disable did not take
effect and the hardware still holds the NIB address.

AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE and AP_RESPONSE_ASSOC_FAILED
are asynchronous response codes from a previously executed
association instruction. All subsequent AP instructions, including
the current AQIC, end with the asynchronous response code until
the queue is reset. The AQIC disable was therefore not executed
and the hardware still holds the NIB address.

For all three of the above, end_fail is the correct disposition
since the NIB must not be freed while hardware may still write to
it. Add these as explicit cases above default to document the
intent.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 275 +++++++++++++++++++++++-------
 1 file changed, 216 insertions(+), 59 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..9d4f5b9e3301 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -226,16 +227,27 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 }
 
 /**
- * vfio_ap_wait_for_irqclear - clears the IR bit or gives up after 5 tries
- * @apqn: The AP Queue number
- *
- * Checks the IRQ bit for the status of this APQN using ap_tapq.
- * Returns if the ap_tapq function succeeded and the bit is clear.
- * Returns if ap_tapq function failed with invalid, deconfigured or
- * checkstopped AP.
- * Otherwise retries up to 5 times after waiting 20ms.
+ * vfio_ap_wait_for_irqclear - wait for the IR bit to clear after a disable
+ *
+ * @apqn: the APQN of the queue
+ *
+ * Repeatedly polls the AP queue status via PQAP(TAPQ) every 20ms until the IR
+ * bit is clear, the queue becomes non-operational, or 5 retries are exhausted.
+ *
+ * Because PQAP(AQIC) disable initiates an asynchronous process, a
+ * condition-code 0 completion does not guarantee the IR bit has been cleared.
+ * The host must confirm IR=0 before unpinning the NIB page to avoid a wild
+ * DMA write to a freed page.
+ *
+ * Return:
+ * - 0		if the IR bit is clear (i.e., interrupts are disabled).
+ *
+ * - -ENODEV	if the PQAP-TAPQ response code indicates the queue is not available,
+ *		is deconfigured, or is checkstopped (i.e., not operational).
+ *
+ * - -ETIMEDOUT	the function timed out before the IR bit was cleared.
  */
-static void vfio_ap_wait_for_irqclear(int apqn)
+static int vfio_ap_wait_for_irqclear(int apqn)
 {
 	struct ap_queue_status status;
 	int retry = 5;
@@ -246,7 +258,7 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 			if (!status.irq_enabled)
-				return;
+				return 0;
 			fallthrough;
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -257,12 +269,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		default:
 			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
 				  status.response_code, apqn);
-			return;
+			return -ENODEV;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
-		  __func__, status.response_code, apqn);
+	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
+		  __func__, status.response_code,
+		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	return -ETIMEDOUT;
 }
 
 /**
@@ -289,20 +304,28 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 }
 
 /**
- * vfio_ap_irq_disable - disables and clears an ap_queue interrupt
- * @q: The vfio_ap_queue
+ * vfio_ap_irq_disable - disable interrupts for an AP queue
+ * @q: the vfio_ap_queue
+ *
+ * Issues PQAP(AQIC) to disable interrupts for the AP queue. On success
+ * (AP_RESPONSE_NORMAL or AP_RESPONSE_OTHERWISE_CHANGED), polls via
+ * vfio_ap_wait_for_irqclear() until the IR bit is confirmed clear before
+ * freeing the pinned NIB page and unregistering the guest ISC. This wait is
+ * necessary because AQIC disable is asynchronous: freeing the NIB before IR=0
+ * is confirmed risks a wild DMA write to a freed host page.
  *
- * Uses ap_aqic to disable the interruption and in case of success, reset
- * in progress or IRQ disable command already proceeded: calls
- * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
- * and calls vfio_ap_free_aqic_resources() to free the resources associated
- * with the AP interrupt handling.
+ * Retries up to 5 times (with 20ms sleep) if the queue is busy or a reset is
+ * in progress.
  *
- * In the case the AP is busy, or a reset is in progress,
- * retries after 20ms, up to 5 times.
+ * If the IR bit cannot be confirmed clear (timeout), the NIB page and guest
+ * ISC are intentionally leaked. If the page were unpinned and returned to the
+ * allocator, a subsequent hardware DMA write to that physical address would
+ * corrupt memory belonging to a new owner — a wild DMA write that could crash
+ * or compromise the host kernel.
  *
- * Returns if ap_aqic function failed with invalid, deconfigured or
- * checkstopped AP.
+ * If the queue is non-operational (deconfigured, checkstopped, not available),
+ * resources are freed immediately since the hardware can no longer write to
+ * the NIB.
  *
  * Return: &struct ap_queue_status
  */
@@ -310,34 +333,90 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 {
 	union ap_qirq_ctrl aqic_gisa = { .value = 0 };
 	struct ap_queue_status status;
-	int retries = 5;
+	int retries = 5, ret;
 
 	do {
 		status = ap_aqic(q->apqn, aqic_gisa, 0);
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
+			ret = vfio_ap_wait_for_irqclear(q->apqn);
+			if (ret == 0 || ret == -ENODEV)
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
+		case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
 			msleep(20);
 			break;
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			/* AP not operational; no further interrupts possible */
+			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
+				  status.response_code);
+			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
+		case AP_RESPONSE_INVALID_GISA:
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
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
+	 * We are here either because the AQIC instruction failed to disable
+	 * interrupts, or because IR=0 could not be confirmed. In either case
+	 * the NIB page and guest ISC cannot be freed: hardware may still write
+	 * to the NIB, and unpinning the page would allow it to be reallocated
+	 * to a new owner. A subsequent hardware DMA write to that physical
+	 * address would corrupt the new owner's memory — a wild DMA write that
+	 * could crash or compromise the host kernel. The resources are
+	 * therefore intentionally leaked.
+	 */
+	return status;
+
 end_free:
+	/*
+	 * This label is reached because the queue was successfully disabled,
+	 * or because the queue is not operational or not available, in which case
+	 * interrupts can not be processed, so free the AQIC resources - the pinned NIB
+	 * page and the registered guest ISC - used to enable interrupts so they will
+	 * not be leaked.
+	 */
 	vfio_ap_free_aqic_resources(q);
 	return status;
 }
@@ -401,22 +480,29 @@ static int ensure_nib_shared(unsigned long addr)
 }
 
 /**
- * vfio_ap_irq_enable - Enable Interruption for a APQN
+ * vfio_ap_irq_enable - enable interrupts for an AP queue on behalf of a guest
  *
- * @q:	 the vfio_ap_queue holding AQIC parameters
+ * @q:	 the vfio_ap_queue for which interrupts are to be enabled
  * @isc: the guest ISC to register with the GIB interface
- * @vcpu: the vcpu object containing the registers specifying the parameters
- *	  passed to the PQAP(AQIC) instruction.
+ * @vcpu: the vcpu whose registers contain the PQAP(AQIC) parameters
  *
- * Pin the NIB saved in *q
- * Register the guest ISC to GIB interface and retrieve the
- * host ISC to issue the host side PQAP/AQIC
+ * Pins the guest NIB page, registers the guest ISC with the GIB to obtain a
+ * host ISC, and reissues PQAP(AQIC) with the translated host-absolute NIB
+ * address and host ISC on behalf of the guest.
  *
- * status.response_code may be set to AP_RESPONSE_INVALID_ADDRESS in case the
- * vfio_pin_pages or kvm_s390_gisc_register failed.
+ * The condition code and AP-queue status word returned by PQAP(AQIC) are
+ * reflected back to the guest as-is. IRQ state verification (polling until
+ * IR=1) is the responsibility of the guest AP bus, not the host.
  *
- * Otherwise return the ap_queue_status returned by the ap_aqic(),
- * all retry handling will be done by the guest.
+ * Resource management is based solely on whether hardware accepted the new NIB:
+ * - AP_RESPONSE_NORMAL (CC=0): hardware accepted the new NIB; the old pinned
+ *   NIB page and registered guest ISC are freed and the new ones saved.
+ * - All other responses: hardware did not accept the new NIB; the newly pinned
+ *   page and registered ISC are freed and the previously saved resources are
+ *   left intact.
+ *
+ * AP_RESPONSE_INVALID_ADDRESS is returned if vfio_pin_pages() or
+ * kvm_s390_gisc_register() fails before the AQIC instruction is issued.
  *
  * Return: &struct ap_queue_status
  */
@@ -428,11 +514,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	struct ap_queue_status status = {};
 	struct kvm_s390_gisa *gisa;
 	struct page *h_page;
-	int nisc;
+	int nisc, ret;
 	struct kvm *kvm;
 	phys_addr_t h_nib;
 	dma_addr_t nib;
-	int ret;
 
 	/* Verify that the notification indicator byte address is valid */
 	if (vfio_ap_validate_nib(vcpu, &nib)) {
@@ -489,24 +574,33 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		/* See if we did clear older IRQ configuration */
+		/*
+		 * Hardware accepted the new NIB address (CC=0). The old NIB and
+		 * guest ISC are no longer used by hardware and can be freed.
+		 * The new resources are saved for tracking and future teardown.
+		 *
+		 * IRQ state verification (polling until IR=1) is the
+		 * responsibility of the guest AP bus, not the host. The
+		 * condition code and status word are reflected back to the
+		 * guest to respond to the PQAP-AQIC instruction.
+		 */
 		vfio_ap_free_aqic_resources(q);
 		q->saved_iova = nib;
 		q->saved_isc = isc;
 		break;
-	case AP_RESPONSE_OTHERWISE_CHANGED:
-		/* We could not modify IRQ settings: clear new configuration */
+	default:
+		/*
+		 * Hardware did not accept the new NIB (CC=3 or error). The
+		 * previously saved NIB and guest ISC remain active and must
+		 * not be freed. Release the newly pinned page and registered
+		 * ISC that were prepared for this (rejected) request.
+		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
 		if (ret)
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
 					 __func__, ret, isc, q->apqn);
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
-	default:
-		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
-			status.response_code);
-		vfio_ap_irq_disable(q);
-		break;
 	}
 
 	if (status.response_code != AP_RESPONSE_NORMAL) {
@@ -635,7 +729,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	}
 
 	status = vcpu->run->s.regs.gprs[1];
-
 	/* If IR bit(16) is set we enable the interrupt */
 	if ((status >> (63 - 16)) & 0x01)
 		qstatus = vfio_ap_irq_enable(q, status & 0x07, vcpu);
@@ -1919,22 +2012,57 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
+		/*
+		 * This response code only indicates that the PQAP(ZAPQ) has
+		 * been initiated. The following bit settings in the status
+		 * returned from TAPQ must be verified to confirm that the
+		 * asynchronous portion of the queue zeroization has completed.
+		 */
+		if (status->queue_empty && !status->replies_waiting &&
+		    !status->irq_enabled && !status->async)
+			return 0;
+
+		/* Async zeroization still in progress; keep waiting */
+		return -EBUSY;
+
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
-		return 0;
+		/*
+		 * The queue is non-operational: interrupts are not possible so
+		 * AQIC resources can be safely freed. However, zeroization
+		 * cannot be confirmed because all status bits are zeroed when
+		 * these response codes are returned — there is no way to
+		 * distinguish a zeroized queue from one that has not been
+		 * zeroized. Return -ENODEV to signal that AQIC resources should
+		 * be freed but that zeroization has not been confirmed.
+		 */
+		return -ENODEV;
+
 	case AP_RESPONSE_RESET_IN_PROGRESS:
-	case AP_RESPONSE_BUSY:
+		/*
+		 * A reset is in progress. It may be the reset we issued or one
+		 * issued prior to ours; either way, once it completes the queue
+		 * will be zeroized, so keep waiting.
+		 */
 		return -EBUSY;
+
+	case AP_RESPONSE_BUSY:
 	case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 	case AP_RESPONSE_ASSOC_FAILED:
 		/*
+		 * AP_RESPONSE_BUSY:
+		 * The queue is busy with something unrelated to a reset and our
+		 * ZAPQ was rejected outright. Re-issue the ZAPQ.
+		 *
+		 * AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE
+		 * AP_RESPONSE_ASSOC_FAILED:
 		 * These asynchronous response codes indicate a PQAP(AAPQ)
 		 * instruction to associate a secret with the guest failed. All
 		 * subsequent AP instructions will end with the asynchronous
-		 * response code until the AP queue is reset; so, let's return
-		 * a value indicating a reset needs to be performed again.
+		 * response code until the AP queue is reset. Re-issue the ZAPQ.
 		 */
 		return -EAGAIN;
+
 	default:
 		WARN(true,
 		     "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
@@ -1959,8 +2087,16 @@ static void apq_reset_check(struct work_struct *reset_work)
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
 		ret = apq_status_check(q->apqn, &status);
-		if (ret == -EIO)
+		if (ret == -EIO) {
+			/*
+			 * TAPQ returned an invalid response code. This
+			 * indicates a hardware or firmware bug; the queue
+			 * cannot generate AP interrupts or DMA-write to the
+			 * NIB, so free the AQIC resources rather than leak them.
+			 */
+			vfio_ap_free_aqic_resources(q);
 			return;
+		}
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
@@ -1977,8 +2113,12 @@ static void apq_reset_check(struct work_struct *reset_work)
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
-			if (q->saved_isc != VFIO_AP_ISC_INVALID)
-				vfio_ap_free_aqic_resources(q);
+			/*
+			 * We end up here when the ZAPQ has completed. ZAPQ
+			 * disables interrupts, so if the AQIC resources must be
+			 * freed; otherwise they may be leaked.
+			 */
+			vfio_ap_free_aqic_resources(q);
 			break;
 		}
 	}
@@ -1995,22 +2135,30 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 	case AP_RESPONSE_RESET_IN_PROGRESS:
-	case AP_RESPONSE_BUSY:
 	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
 		/*
 		 * Let's verify whether the ZAPQ completed successfully on a work queue.
 		 */
 		queue_work(system_long_wq, &q->reset_work);
 		break;
+	case AP_RESPONSE_Q_NOT_AVAIL:
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
 		vfio_ap_free_aqic_resources(q);
 		break;
 	default:
+		/*
+		 * The architecture defines only the response codes above as
+		 * valid for ZAPQ. Any other response code indicates a hardware
+		 * or firmware bug. Since a malfunctioning queue cannot generate
+		 * AP interrupts or DMA-write to the NIB, free the AQIC resources
+		 * rather than leak them.
+		 */
 		WARN(true,
 		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
 		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
 		     status.response_code);
+		vfio_ap_free_aqic_resources(q);
 	}
 }
 
@@ -2534,6 +2682,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
+	} else {
+		/*
+		 * The queue is no longer in the host's AP configuration.
+		 * The hardware cannot DMA-write to the NIB, so it is safe
+		 * to free the AQIC resources directly without issuing a
+		 * ZAPQ. If the queue is not assigned to an mdev,
+		 * vfio_ap_free_aqic_resources() is a no-op.
+		 */
+		vfio_ap_free_aqic_resources(q);
 	}
 
 done:
-- 
2.53.0

