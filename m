Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F5470EB4;
	Fri, 25 Sep 2026 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340365; cv=none; b=di6H4KpqGhDnyZYgnaWUdkDIEeWihijGXXeoDrmEh5B0FMXPmtJdQcLd/EP07uSz5wRITOTUR+vlc3238SVX3V/nkfmYku9+ebdXJL1npuTY0QkdZKSIwK11LxeW08ySTP6ip9EljWOWjBv/p+QataAtH/KujgmsdiP95XLPFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340365; c=relaxed/simple;
	bh=cDepZvLCDsPrrmaXN8drU183B//q+1TemaLu15C21dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuCC0xPq9S7U4eTMIM+JWe+Ic+4kns68MU0wQ91OF+9AlIGLV1J4yQc/gNJOF2/OYg45O8YTPZpoXw6lskpGC44yXe9kLi0fM8DRq+REQLjCxshlzuM0VsCzqAUs1dbm7d3tIuP7ZL3Z2Oya9bXP41ekw0wkUHbnxn6LPDb9HyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K5lWJPtM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K5lWJPtM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a08h3083370;
	Fri, 25 Sep 2026 12:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dgWmgQ
	6lGVDbj8O5Ol1WIPPIVcga50UMh0bJP6YcDRs=; b=K5lWJPtMJQewkOYeA2qayj
	aaOSuSLQQy4rHb/ccTLWgrDpIl+3LVvef6xe9D3bsrAFI/n7GRXUwznufwOF9QQG
	+PW7Ji475vT/p0yL1MrSjpuBxPCSqMlIIkgZsI7ES7oIs2kc1SnMP2/ovLZ82UDO
	nNPxVOL/VJHac0x0JKsKjUvC75Qf22Ojsrg8S4wn7AsLTD/7sjBkBDu/c2HD5ZjZ
	yk5gELymYMPdiXElE30IhZdX+rtEVjX95toYzuVq41yipFe2dc5TSVFdJk6Oym68
	CmHrWWrIU4BRxRoO1jr80hHO7HK5SDa2NnefkVqbud54DbaXiPb6qZnluJwkd1OA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqx0s7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:45:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA457j3288221;
	Fri, 25 Sep 2026 12:45:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe22e1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:45:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCjsUG24248932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:45:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAFAB58062;
	Fri, 25 Sep 2026 12:45:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60EAF5805A;
	Fri, 25 Sep 2026 12:45:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.86.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:45:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v8 1/6] s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
Date: Fri, 25 Sep 2026 08:45:46 -0400
Message-ID: <20260925124551.665448-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925124551.665448-1-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab66d05 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=eS_XXSIdeN0PBYrJ018A:9 a=HbXCwHrqLsxgwAln:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX4XskuktfZiPB
 nE2vSr4sOOzTWTZ38Hh8v/nfbP5EDn8TV/+moIJ6+Sf+vG8LnCtiUgUmrx8fF9DJqxHKskwdINA
 bc6idxfVsLBHodnsk+587ouLqr5Q/gMnhnepv6mL1EunDBIQyi6oFSj4TJwd2mWQAc/TUEIKr/F
 qHS0wdKzjzPX2DI4mu19RuM2UEAJ6CXkJs2fTrbWyQmMwQAMt/an0rQMeJhfPil1GoS4aBI4Brd
 NNPtDlQR8GwnZVG0/9gqvYgyXMduuRtZIs5sqOAadFbolEZDx2frm7CtOgEqhjM7hFWDteOyFaq
 8uIE8M1ywISARU49dMZccHMIDOJxI7lFjNjAxbLug4fzTS6OgbE6FnMBvcl3/aRlpk7IxT1RVoW
 iB/qsqbTtJrfbR3tm6NGF5HVN0BjgqMgzBczrzzK+HuqoeJmLQdKuNSoY8op7y5SRBQS9gFNMKU
 bUVL70ODfXBm/iC/qsQ==
X-Proofpoint-ORIG-GUID: 4JW3jE_g9BST-fg2lWo2dyR6-dUQiQ7n
X-Proofpoint-GUID: 4JW3jE_g9BST-fg2lWo2dyR6-dUQiQ7n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX4Wk56uLK8yaR
 MkWFzdZWmtiARsrGiJqQm2eskqselWkM9vcevYmKlediwT71+DPotcwG+TfLyJ1GHAZUkfJXw70
 xfEL4UmZ2JfR/N0yciOpGq9HcMjhFrE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250050

Several code paths in the vfio_ap driver failed to free the AQIC
resources — the pinned guest NIB page and the registered guest ISC
used to enable interrupts for a queue — when a queue became unavailable
or when unexpected response codes were returned. This could cause memory
exhaustion and depletion of KVM interrupt subclass registrations over time
with repeated dynamic AP reconfiguration. On the other hand, there are
situations whereby these resources must be intentionally leaked.
If the page were unpinned and returned to the allocator, a subsequent
wild DMA-write to that physical address would corrupt memory belonging
to the new owner and could crash or compromise the host kernel.

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

AP_RESPONSE_BUSY is not a valid response code for a PQAP(ZAPQ)
instruction, so it is removed. This contradicts what is stated
in the following:

commit 411b0109daa52 ("s390/vfio-ap: wait for response code 05 to clear on queue reset")

A careful reading of the valid response code table in the architecture
documentation, however, clearly shows that response code 05 is not valid
for the PQAP-ZAPQ instruction. So in the apq_status_check() - which
examines the response codes that can be returned from PQAP-TAPQ - if the
response code is AP_RESPONSE_BUSY (05), it will return -EAGAIN which
instructs the caller (apq_reset_check()) to re-issue the PQAP-ZAPQ
instruction.

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
Keep in mind that apq_reset_check() - which calls
apq_status_check() - is called on a work queue when the status response
code from the ZAPQ is AP_RESPONSE_NORMAL, AP_RESPONSE_RESET_IN_PROGRESS,
or AP_RESPONSE_STATE_CHANGE_IN_PROGRESS. If the apq_reset_check() times
out before it can be verified that the asynchronous portion of the
reset completed, the response code returned will be one of those above,
so the status from the PQAP(TAPQ) is copied to q->reset_status so the
queue is marked as not-passable and not passed through to a guest.
~~~~~~~~~~~~~~~~~~~~~~~~~~~

vfio_ap_irq_disable()
~~~~~~~~~~~~~~~~~~~~~
The valid response codes for PQAP(AQIC) include
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS (0x0a),
AP_RESPONSE_INVALID_GISA (0x08),
AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE (0x35), and
AP_RESPONSE_ASSOC_FAILED (0x36), none of which were explicitly
handled. All four fell through to the default case and jumped to
end_free freed the AQIC resources. These each should be handled
differently:

* AP_RESPONSE_STATE_CHANGE_IN_PROGRESS indicates a transient
  condition, analogous to AP_RESPONSE_RESET_IN_PROGRESS and
  AP_RESPONSE_BUSY. It is added to the same case as the
  RESET_IN_PROGRESS AND RESPONSE_BUSY whereby the process
  sleeps for 20ms and the AQIC gets re-executed.

* AP_RESPONSE_INVALID_GISA indicates the AQIC instruction was
  rejected due to an invalid GISA address. The disable did not take
  effect and the hardware still holds the NIB page address, so the
  AQIC resources must be leaked. If the NIB page were unpinned and returned
  to the allocator, a subsequent wild DMA-write to that physical
  address would corrupt memory belonging to the new owner and could crash
  or compromise the host kernel; so the AQIC resources must be
  intentionally leaked.

* AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE and AP_RESPONSE_ASSOC_FAILED
  are asynchronous response codes from a previously executed
  association instruction. All subsequent AQIC calls will end with the
  asynchronous response code until the queue is reset; therefore the AQIC
  disable was not executed and the hardware still holds the NIB address.
  If the NIB page was unpinned and returned to the allocator, a subsequent
  wild DMA-write to that physical address would corrupt memory belonging
  to the new owner and could crash or compromise the host kernel;
  so the AQIC resources must be intentionally leaked.

After a return from the vfio_ap_wait_for_clear(), vfio_ap_irq_disable()
immediately frees the AQIC resources; however, vfio_ap_wait_for_clear()
can return for a number of reasons which require a different response:

* Timed out waiting for the I-bit (bit 7) in the AP queue status word
  returned from the TAPQ instruction to be cleared (indicates interrupts
  are disabled). In this case, the hardware still holds the NIB address.
  If the NIB page were unpinned and returned to the allocator, a subsequent
  wild DMA-write to that physical address would corrupt memory belonging
  to the new owner and could crash or compromise the host kernel;
  so the AQIC resources must be intentionally leaked.

* The response code from TAPQ is one of AP_RESPONSE_NORMAL,
  AP_RESPONSE_Q_NOT_AVAIL, AP_RESPONSE_DECONFIGURED, OR
  AP_RESPONSE_CHECKSTOPPED. In this case, the response code indicates the
  interrupts are disabled or the queue is either not in the host's
  AP configuration or is not functional. In any case, it is safe to free
  the AQIC resources.

* An invalid response code was returned from TAPQ. In this case, the
  hardware may still hold the NIB address. If so and the NIB page was
  unpinned and returned to the allocator, a subsequent wild DMA-write to
  that physical address would corrupt memory belonging to the new owner and
  could crash or compromise the host kernel; so the AQIC resources must be
  intentionally leaked.

The solution here is to change the vfio_ap_wait_for_clear() to reply with
a return code indicating the result, thus allowing vfio_ap_irq_disable()
to respond accordingly:
 * 0:		interrupt disablement is verified
 * -ENODEV:	the queue is not functional
 * -ETIMEDOUT:	the function timeout without verifying interrupts disabled
 * -EIO:	an invalid response code was returned from TAPQ

unmap_iova()
~~~~~~~~~~~~
Calls vfio_ap_irq_disable() to disable interrupts for the queue, but does
not check the result. If the IRQ disable failed or could not be
confirmed, then vfio_ap_irq_disable() leaks the NIB to prevent a wild
DMA-write; however, the vfio core requires that NIB page to be unpinned
before the dma_unmap returns, or it will BUG_ON after 10 re-notification
rounds.

The fix is to fall back to a bounded queue reset and zeroize (ZAPQ) which
zeroizes the NIB pointer in the hardware, eliminating the DMA risk that
justified the leak. Once the reset finishes or times out with a reset
confirmed in-progress, the hardware no longer holds a reference to
saved_iova and it is safe to unpin unconditionally.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 365 +++++++++++++++++++++++++-----
 1 file changed, 304 insertions(+), 61 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..6998bd0c88a2 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -226,27 +227,48 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
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
+ * @apqn:		the APQN of the queue
+ * @tapq_status:	used to return the TAPQ status to the caller
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
+ * 0		if the IR bit is clear (i.e., interrupts are disabled).
+ *
+ * -ENODEV	if the PQAP-TAPQ response code indicates the queue is not available,
+ *		is deconfigured, or is checkstopped (i.e., not operational).
+ *
+ * -ETIMEDOUT	the function timed out before the IR bit was cleared, or TAPQ
+ *		returned AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE or
+ *		AP_RESPONSE_ASSOC_FAILED, which mean the instruction was not
+ *		executed and will continue to be returned for all subsequent
+ *		instructions except ZAPQ until the queue is reset. Since IR=0
+ *		cannot be confirmed, the NIB must be treated as a potential DMA
+ *		target and leaked rather than freed.
+ *
+ * -EIO		PQAP-TAPQ returned an invalid response code
  */
-static void vfio_ap_wait_for_irqclear(int apqn)
+static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_status)
 {
 	struct ap_queue_status status;
 	int retry = 5;
 
 	do {
 		status = ap_tapq(apqn, NULL);
+		memcpy(tapq_status, &status, sizeof(status));
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 			if (!status.irq_enabled)
-				return;
+				return 0;
 			fallthrough;
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -254,15 +276,34 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ENODEV;
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
+			/*
+			 * The TAPQ instruction was not executed. Executing TAPQ
+			 * again will result in the same error until the queue
+			 * is reset. We should't, however, reset the queue in
+			 * this context, so log a warning and return -ETIMEDOUT
+			 * since that would happen anyway if we continued to
+			 * execute the TAPQ.
+			 */
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ETIMEDOUT;
 		default:
 			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
 				  status.response_code, apqn);
-			return;
+			return -EIO;
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
@@ -289,55 +330,139 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
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
 static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 {
 	union ap_qirq_ctrl aqic_gisa = { .value = 0 };
-	struct ap_queue_status status;
-	int retries = 5;
+	struct ap_queue_status status, tapq_status;
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
+			ret = vfio_ap_wait_for_irqclear(q->apqn, &tapq_status);
+			if (ret == 0 || ret == -ENODEV)
+				goto end_free;
+
+			if (ret == -EIO) {
+				/*
+				 * An unknown TAPQ response code was returned which
+				 * indicates a bug or some type of hardware I/O issue.
+				 * Since we don't know whether queue interrupts were
+				 * disabled or not, the AQIC resources must be leaked.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
+				goto end_fail;
+			}
+
+			/* Timed out waiting to confirm interrupts are disabled */
+			if (tapq_status.response_code == AP_RESPONSE_NORMAL ||
+			    tapq_status.response_code == AP_RESPONSE_BUSY) {
+				/*
+				 * If AQIC returned NORMAL, the guest would incorrectly
+				 * interpret that as a successful disable and may free or
+				 * reuse the NIB while hardware can still write to it.
+				 * AP_RESPONSE_BUSY is not valid for PQAP-AQIC.
+				 *
+				 * Return OTHERWISE_CHANGED to signal to the guest that
+				 * the disable interrupts operation did not complete.
+				 */
+				memset(&status, 0, sizeof(status));
+				status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
+			} else {
+				/*
+				 * For all other TAPQ response codes,
+				 * return the TAPQ status directly since those
+				 * codes are also valid for AQIC.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
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
@@ -401,22 +526,29 @@ static int ensure_nib_shared(unsigned long addr)
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
@@ -428,11 +560,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
@@ -489,27 +620,46 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
 	case AP_RESPONSE_OTHERWISE_CHANGED:
-		/* We could not modify IRQ settings: clear new configuration */
+		/*
+		 * Interrupts are already enabled or a prior async request is still
+		 * completing. Either way, the hardware's current NIB is the one
+		 * saved in q->saved_iova/q->saved_isc — not the newly prepared
+		 * resources. Release the newly pinned page and registered ISC;
+		 * leave saved_iova and saved_isc intact.
+		 */
+		fallthrough;
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
 
-	if (status.response_code != AP_RESPONSE_NORMAL) {
+	if (status.response_code != AP_RESPONSE_NORMAL &&
+	    status.response_code != AP_RESPONSE_OTHERWISE_CHANGED) {
 		VFIO_AP_DBF_WARN("%s: PQAP(AQIC) failed with status=%#02x: "
 				 "zone=%#x, ir=%#x, gisc=%#x, f=%#x,"
 				 "gisa=%#x, isc=%#x, apqn=%#04x\n",
@@ -635,7 +785,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	}
 
 	status = vcpu->run->s.regs.gprs[1];
-
 	/* If IR bit(16) is set we enable the interrupt */
 	if ((status >> (63 - 16)) & 0x01)
 		qstatus = vfio_ap_irq_enable(q, status & 0x07, vcpu);
@@ -1857,8 +2006,28 @@ static void unmap_iova(struct ap_matrix_mdev *matrix_mdev, u64 iova, u64 length)
 	int loop_cursor;
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
-		if (q->saved_iova >= iova && q->saved_iova < iova + length)
+		if (q->saved_iova >= iova && q->saved_iova < iova + length) {
 			vfio_ap_irq_disable(q);
+			/*
+			 * If IRQ disable failed or IR=0 could not be confirmed,
+			 * vfio_ap_irq_disable() intentionally leaks the NIB to
+			 * prevent a wild DMA write. But vfio core requires the
+			 * page to be unpinned before dma_unmap returns, or it
+			 * will BUG_ON after 10 re-notification rounds.
+			 *
+			 * Fall back to a bounded queue reset. The ZAPQ zeroizes
+			 * the NIB pointer in hardware, eliminating the DMA risk
+			 * that justified the leak. Once the worker finishes (or
+			 * times out with a reset confirmed in-progress), the
+			 * hardware no longer holds a reference to saved_iova and
+			 * it is safe to unpin unconditionally.
+			 */
+			if (q->saved_iova) {
+				vfio_ap_mdev_reset_queue(q);
+				flush_work(&q->reset_work);
+				vfio_ap_free_aqic_resources(q);
+			}
+		}
 	}
 }
 
@@ -1919,22 +2088,57 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
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
@@ -1959,8 +2163,25 @@ static void apq_reset_check(struct work_struct *reset_work)
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
 		ret = apq_status_check(q->apqn, &status);
-		if (ret == -EIO)
+		if (ret == -EIO) {
+			/*
+			 * TAPQ returned an invalid response code indicating a
+			 * hardware or firmware bug. Since we cannot determine
+			 * whether the queue can still DMA-write to the NIB, the
+			 * AQIC resources are intentionally leaked lest the NIB
+			 * page is reallocated to a new owner. A subsequent
+			 * wild DMA-write to that physical address would corrupt
+			 * the new owner's memory which could crash or compromise
+			 * the host kernel.
+			 *
+			 * Record the TAPQ status so the queue is marked
+			 * not-passable - _queue_passable() checks
+			 * reset_status.response_code == AP_RESPONSE_NORMAL -
+			 * and the queue is not passed through to a guest.
+			 */
+			memcpy(&q->reset_status, &status, sizeof(status));
 			return;
+		}
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
@@ -1977,8 +2198,12 @@ static void apq_reset_check(struct work_struct *reset_work)
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
-			if (q->saved_isc != VFIO_AP_ISC_INVALID)
-				vfio_ap_free_aqic_resources(q);
+			/*
+			 * We end up here when the ZAPQ has completed. ZAPQ
+			 * disables interrupts, so the AQIC resources must be
+			 * freed; otherwise they will be leaked.
+			 */
+			vfio_ap_free_aqic_resources(q);
 			break;
 		}
 	}
@@ -1995,18 +2220,27 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
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
+		 * An invalid response code indicates a hardware or firmware bug.
+		 * Since we cannot determine whether the queue can still
+		 * DMA-write to the NIB, the AQIC resources are intentionally
+		 * leaked lest the NIB page is reallocated to a new owner. A
+		 * subsequent hardware wild DMA-write to that physical address
+		 * would corrupt the new owner's memory which could crash or
+		 * compromise the host kernel.
+		 */
 		WARN(true,
 		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
 		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
@@ -2534,6 +2768,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
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

