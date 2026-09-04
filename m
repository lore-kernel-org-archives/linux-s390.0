Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1144A3FE;
	Fri,  4 Sep 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514489; cv=none; b=U1L6OrPXtcSOlhkXkEjixLAZBq8r09sX6H/YFn1ksNjf1KFgF81Tc7Iw0WOMohKvtrpLoYAmEh3c4A3fezPp6qgMsOOhjCJOlhQDQYfX5/7WGquPkrlAWx82ONYtlGjH86+41HD7GxDOyVfyOklxo8H39l+2UtIlh//JT1wshN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514489; c=relaxed/simple;
	bh=Y4j9k5Qem6jqykSUDDsG9E/I3RAGKgaIxprMOHMhH3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDNSBpKU1GcHeym/i1PvX+uuglGVQ+prpsAlkCLAX7VuvtGShCzbbOYrTwFQl811ouJF3I6k6YEfKyVyuP8nAcLSxck2RQ2gx8BRvrQbhfqaz50EAL9j+gby9OOfmNrdKjWNWimSrX+92PZEp473IeMKHVKnr3smK59apoHzTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VHWfFJ6C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VHWfFJ6C"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464LrW3254183;
	Fri, 4 Sep 2026 09:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FPxzTq
	EN9f0/4sJdJ5y33Z7e6IcUQAOom3W6gkywZCs=; b=VHWfFJ6CypQfhrZA95yIgg
	xaZzgOdhFV3cKZsO/bKpviMUS8TE/aETeIgOHLELLTn8qU4W8zB8aV2hBZq1gtOi
	oW6G4V365K98phq1wtjunfI8Qtcx6kQqPcd47U07w61oeuCbDXaQRNH7QbZZ3DJS
	qMAjWuAqL3D1tXnvhxfrC4dZfoSs2y4aYAhEZC+Z4qfpq0ivFOSzUC0zhEsRAkRi
	krxu5xkUW2qj0ukTYXzuiBgBFgzor75PqzE8ErPPayXhrAqW+YnuSftK3ldqO1Ki
	HHpczKCvdXUiAht4tD/EdV9FjkbIoPSZsv8OjB3AdHypSfTAsB2WZT4FLfbULMQA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rswbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849V36D008450;
	Fri, 4 Sep 2026 09:34:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkm9cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849YdF210289674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:34:39 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E963658064;
	Fri,  4 Sep 2026 09:34:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACC3058056;
	Fri,  4 Sep 2026 09:34:37 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:34:37 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 1/5] s390/vfio-ap: Fix leak of pinned NIB and registered GISC in vfio_ap_irq_enable/disable()
Date: Fri,  4 Sep 2026 05:30:50 -0400
Message-ID: <20260904093435.1161402-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a90b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=qf4gfuq51q0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=kQtz2XuaSNiWsjsa4-sA:9 a=XKUFjzADyDXMbQ7k:21
 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfXxXSNCid2Qty3
 cR+ls3Cx3jHfRzTLIZ7iu0x8nSflWYlN8ZwrYgD9M5kLE9vNrRACAAui8Q7FHxTzOIy8US3xHv4
 Tld5LPWAB6Dpv3+3jqC98tp50yUibQ5QGxlhXpa/w4tAAUif3Py2jmihSTRi3fwqmVL1FYOjGex
 y0xMq4fE7eZZpmDannS2uNkRbGXB2Q8GsRtTTEBsTKw+pCCHs1FLzQqF+rWqWPhPqrnfMOENbJA
 5OPfTwuX+sdshvbe+RnmXSJLJ8HJZ+Si7hyH+99+cIBQF0ibNxCOOwebkxMAww02G2aAQWBcHS+
 ZK7iiOTGAUp+68QQJ5sgMFsD/GdiTf8UoWAWjBCQPYwkZmUyziUKX+9OVszjy2Lfb6l5E1y/YJ2
 JMub+ZuHFQwWIlc9sfngD2dj5sqlHeD6R0nqUtJ8gidXYAR9LtT3WwEMVhAtkfpG7HKL+D1JLF2
 lq7gbUbaOEVtbco3PIA==
X-Proofpoint-GUID: 87J5RxRPCijKF4TwKZe3gyE5FTG9jP49
X-Proofpoint-ORIG-GUID: 87J5RxRPCijKF4TwKZe3gyE5FTG9jP49
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX5QIKYG/IWRN+
 np2OzjiRpwuM4SjO22ybFRr08932ywM2sSx4R5i52qUtHiZVm0L3WVt3MpPZl5sEUlZPodVEiSy
 56QjajFNw0EQLrV9z3zF116Fo2wjbuE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040086

The PQAP-AQIC instruction is used to enable or disable interrupts for an
AP queue device. When executed on a guest, the SIE intercepts the
instruction and calls a function designated to handle it; in this case,
it's handle_pqap() in the vfio_ap device driver (vfio_ap_ops.c).

A struct kvm_vcpu instance is passed to handle_pqap(); it contains the
registers containing the input parameters to the PQAP-AQIC instruction
executed on the guest:
* GR0 contains the APQN identifying the queue
* GR1 contains the interruption request (IR) bit specifying whether
  interrupts are to be enabled (1) or disabled (0), as well as the
  interruption subclass (ISC).
* GR2 contains the address of the notification indicator byte (NIB)

When the PQAP-AQIC to enable interrupts is intercepted, a page containing
the NIB has to be pinned and the guest ISC (GISC) registered with KVM.
These values are stored with the struct vfio_ap_queue instance in the
saved_iova and saved_isc fields respectively.

There are two functions that get called by handle_pqap():
* vfio_irq_enable() handles enabling IRQs on behalf of a guest
* vfio_irq_disable() handles disabling IRQs on behalf of a guest

Both of these functions have issues related to managing the
saved_iova and saved_isc fields of the vfio_ap_queue object when interrupts
are enabled/disabled for a queue device. If the NIB page is unpinned while
interrupts are still enabled, the page can be pinned to another process.
If the queue signals an interrupt, a DMA wild write is performed to the now
freed page which will result in memory corruption or possibly a kernel
crash. This patch ensures proper handling of the stored NIB page and GISC.

vfio_ap_irq_enable()
~~~~~~~~~~~~~~~~~~~~
The responsibilities of this function are:
1. To set up the input parameters to the PQAP-AQIC instruction to enable
   queue interrupts and ensure they are signaled to the guest.
2. Execute the AQIC instruction on behalf of the guest
3. Return the status word returned from the AQIC instruction to the guest
   along with the appropriate condition code.

The AQIC instruction returns synchronously, so it is the responsibility of
the guest to verify that the queue was enabled for interrupts by using the
PQAP-TAPQ instruction to verify the I-bit (7) in the status word returned
from TAPQ is set to 1 indicating the queue is enabled for interrupts.

After executing the AQIC, vfio_ap_irq_enable() examines the response code
returned and takes action based upon its value:

* AP_RESPONSE_NORMAL:
  ~ The NIB page saved_iova stored by a previous PQAP-AQIC enable is
    unpinned and the saved_isc is unregistered. This is correct behavior
    because the response code indicates the enable request was accepted,
    .
    This response code is returned synchronously, but it is up to the
    guest to ensure the queue is enabled by executing PQAP-TAPQ and
    verifying the I-bit (7) in the status returned from TAPQ is set to
    one, which indicates the queue is enabled for interrupts.
  ~ Store the address of the page containing the NIB and the
    GISC passed to PQAP-AQIC in the saved_iova and saved_isc fields of
    the vfio_ap_queue instance representing the queue.

* All other PQAP-AQIC response codes:
  ~ These response codes indicate that the hardware rejected the PQAP-AQIC
    command, so the input AQIC resources for the enable attempt must be
    freed; i.e., page containing the NIB unpinned and the GISC
    unregistered.
  ~ We don't free the saved_iova nor unregister the saved_isc for the
    following reasons:
    - AP_RESPONSE_OTHERWISE_CHANGED indicates that the queue is already
      enabled or is in the process of being enabled. Presumably this is
      because the response code resulted from enable request made using
      the page address saved in saved_iova and the GISC saved in saved_isc.
      Freeing them could result in a DMA wild write to the now free page.
    - We leave it up to the guest to handle the other response codes. If
      they attempt to enable interrupts again an it succeeds, the saved_iov
      an saved_isc will be freed. In any case, a queue reset zeroize when
      the queue is unbound from the device driver, unassigned from the
      mdev, or the mdev is removed. A successful reset will disable queue
      interrupts. If the reset fails, the resources will be leaked, but
      if that is the case, there's probably something broken causing the
      AP instructions directed at the queue to fail.

vfio_ap_irq_disable()
~~~~~~~~~~~~~~~~~~~~~
The AQIC call returns synchronously to let the caller know whether the
command was accepted by the hardware or not; however, interrupts are
disabled asynchronously. Until the hardware sets the irq_enabled bit in
the AP queue status word to 0, interrupts are not yet disabled despite
the response code from AQIC.

ap_irq_disable() calls vfio_ap_wait_for_irqclear() which executes
PQAP-TAPQ in a loop until it verifies that the irq_enabled bit is 0
or a response code is returned that indicates the queue is not accessible.
It retries the TAPQ up to 5 iterations with a 20ms sleep in between.
If the irq_enabled bit is not set to 0 in that time period, the function
returns.

The problem here is there is no way to know whether the function
verified the irq_enabled bit is 0, returned because the response code
from TAPQ indicated the queue is not accessible, or timed out. In any case,
vfio_ap_irq_disable() unpins the NIB page and unregisters the GISC used to
enable queue interrupts upon return from vfio_wait_for_irqclear().
If it returned due to a time out, hardware may still write to the NIB and
unpinning the page would allow it to be reallocated to a new owner. A
subsequent hardware DMA write to that physical address would corrupt the
new owner's memory - a wild DMA write that could crash or compromise the
host kernel.

The fix is for the vfio_ap_wait to respond with a return code indicating
why it returned and responding accordingly:

0          - confirmed the irq_enabled bit is 0
-ENODEV    - the response code from TAPQ indicates the queue is not
             accessible
-ETIMEDOUT - the function timed out

If the return code is 0 or -ENODEV, the NIB page and GISC previously used
to enable interrupts will be freed; they are no longer needed since
interrupts are either disabled or because interrupts can not be processed
on an inaccessible queue.

If the return code is -ETIMEDOUT, the AQIC resources previously used to
enable interrupts will be leaked to avoid a DMA wild write. This is
perferable to a corrupted kernel or kernel crash.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 191 ++++++++++++++++++++++--------
 1 file changed, 140 insertions(+), 51 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..383ec9f5c810 100644
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
  *
- * Uses ap_aqic to disable the interruption and in case of success, reset
- * in progress or IRQ disable command already proceeded: calls
- * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
- * and calls vfio_ap_free_aqic_resources() to free the resources associated
- * with the AP interrupt handling.
+ * Issues PQAP(AQIC) to disable interrupts for the AP queue. On success
+ * (AP_RESPONSE_NORMAL or AP_RESPONSE_OTHERWISE_CHANGED), polls via
+ * vfio_ap_wait_for_irqclear() until the IR bit is confirmed clear before
+ * freeing the pinned NIB page and unregistering the guest ISC. This wait is
+ * necessary because AQIC disable is asynchronous: freeing the NIB before IR=0
+ * is confirmed risks a wild DMA write to a freed host page.
  *
- * In the case the AP is busy, or a reset is in progress,
- * retries after 20ms, up to 5 times.
+ * Retries up to 5 times (with 20ms sleep) if the queue is busy or a reset is
+ * in progress.
  *
- * Returns if ap_aqic function failed with invalid, deconfigured or
- * checkstopped AP.
+ * If the IR bit cannot be confirmed clear (timeout), the NIB page and guest
+ * ISC are intentionally leaked. If the page were unpinned and returned to the
+ * allocator, a subsequent hardware DMA write to that physical address would
+ * corrupt memory belonging to a new owner — a wild DMA write that could crash
+ * or compromise the host kernel.
+ *
+ * If the queue is non-operational (deconfigured, checkstopped, not available),
+ * resources are freed immediately since the hardware can no longer write to
+ * the NIB.
  *
  * Return: &struct ap_queue_status
  */
@@ -310,15 +333,38 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
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
 			msleep(20);
@@ -326,18 +372,47 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
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
@@ -401,22 +476,29 @@ static int ensure_nib_shared(unsigned long addr)
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
@@ -428,11 +510,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
@@ -489,24 +570,33 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
@@ -635,7 +725,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	}
 
 	status = vcpu->run->s.regs.gprs[1];
-
 	/* If IR bit(16) is set we enable the interrupt */
 	if ((status >> (63 - 16)) & 0x01)
 		qstatus = vfio_ap_irq_enable(q, status & 0x07, vcpu);
-- 
2.53.0

