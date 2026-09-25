Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE52443E56;
	Fri, 25 Sep 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340367; cv=none; b=m8PJDCobhTkkgW/XsqJvcEr33D13oAjIkRbd+GzQbIXW8aix4h9PUgIZsgc69ZBHvxeIFXyzaTk7+Ae7Ww7OdKQoy4LYa97rhsGRCuER47l38Vf9BBIOFuf2vtm1OqQ5SJIorIw+np6ZY5/o2kvMK2dt6qKnhM1o8IAVO4WvFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340367; c=relaxed/simple;
	bh=y2Fed0C7y84JK0q/u00j/avv34yOALzuiq61AjFqUU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl2gDIEajrLzZLinpUAhXRNfFhVMCpyKf3aBMHTAS4QZSdKRGHg0xtY56EhWya0SM6eAdrpaaEf1Ce+jS15OZFvJRYPIV9kWBbEVVRXOhlAiIrYQNqBTUEEv7KYqNDW5+LK/Qy7L2q4nYNgpk5Nmaw/+5LNGAKPltd78ojs9wuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bKfb3Fde; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bKfb3Fde"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4ac6u061841;
	Fri, 25 Sep 2026 12:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=03cZ3eQMUH71OX1oD
	x93QiyUJdNHzXpfkzyYZKdQa/Y=; b=bKfb3FdepzDQH+HPdr1s5b19u/9qxkidO
	LL5AeSLd2tMTJwecP/MbM615vUuCaQxDDlfWTSQWL8I8ydkVG2sroUHNRhva4lqA
	ngOO2L+RJZuCpO2OmmfYO2dnbfT/PmZ4A3uhcFboQg2gKB0LNCc6q8h2SKEyDGT3
	Yo4pWVyYv4tS8llsODI1hwzgaBfgtBwPicJodTLJq24V9nqpBzvcWg0ELC1dvn6n
	pV8ERYcLysawlCudEc/AvXSjK6Zkc0KGBEplTSFKc5bFxREYF31HzL+/bUex3I8Y
	B72m56s4ELiFUE9iaOAo370hLRL/M/4CCatQ16hSUMd8GCY6jgQcA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsq096-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:45:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9uA9K3298386;
	Fri, 25 Sep 2026 12:45:58 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k2e87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:45:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCjv0j25035404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:45:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83DCE58063;
	Fri, 25 Sep 2026 12:45:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44BF558062;
	Fri, 25 Sep 2026 12:45:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.86.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:45:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v8 3/6] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Fri, 25 Sep 2026 08:45:48 -0400
Message-ID: <20260925124551.665448-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925124551.665448-1-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab66d07 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=LCzJTBHBofSmWOAAFuYA:9
X-Proofpoint-ORIG-GUID: cJpxmXoIMX9A9XxvaD_DjVahBC1tx72L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfXyOpqOkqrksbq
 s1krNSzt1i41fS5RDy2SmBq+zheyCZ6xR1gAoPaLfnAH0ht27Iu9DT3HM2iJaER4SVGQDtxg5vL
 ACOz3PGMlHqfTTyAN5OJ70L1OjV/h1grqW9lsI+0tnuT6pKPenffBAz0EBCr4VbQo9MEdNBsahL
 4He1CB6mh1i7GmZduryUvKFoXLUAjT66CpTl15rHROQxMr1TC60LiWgJTulX1C141rsqbxQUqSM
 zUAZR2hE+17tjvSQrjAHJw2YiUq/G4faoFMI21hEvuJlZ65b7f3lZdLUKAHSMaMaT7pIgesfklF
 NlYJuozH0ZnC91+Dhfwq/h/fCWn+fCeyMTIR9aH/YzqhuXlro9p++lTy059Z6NKGQtBezYShfK+
 TS8l8kYbBCKXkAS2zwQzSDoaEXnMdBJ5bnZ/hTNEn8LeeCbCiQzGCw/dP/B2EavNUcZn32JAhLr
 CbsaWBE8p0kjQo+vG2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX0LU/obyMhv22
 IPsemc20cFuXPpo7iws3ZB3/D2ImnQPVGXykyLHhocm2ElvNR2UCBIqSiZpcBLrW6q4+aE49xra
 UwnyR3ZW943HFiwJSEGCpZbVw8QwiAE=
X-Proofpoint-GUID: cJpxmXoIMX9A9XxvaD_DjVahBC1tx72L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250050

s390/vfio-ap: Fix unbounded loop in apq_reset_check()

The apq_reset_check() worker polls ap_tapq() in a while(true)
loop waiting for a queue reset to complete. When ap_tapq()
returns AP_RESPONSE_BUSY, AP_RESPONSE_RESET_IN_PROGRESS, or
AP_RESPONSE_BUSY, apq_status_check() returns -EBUSY and the
loop continues after sleeping AP_RESET_INTERVAL (20ms). There
is no upper bound on how many times the loop iterates, so if the
hardware continuously returns a busy response the worker runs
indefinitely.

This is particularly harmful because several callers of
vfio_ap_mdev_reset_queue() - such as vfio_ap_mdev_reset_queues(),
vfio_ap_mdev_reset_qlist() and vfio_ap_mdev_remove_queue() -
call flush_work() on the queue's reset_work while holding one
or more of the global matrix_dev locks (guests_lock,
mdevs_lock) or the KVM lock. An indefinitely spinning worker
permanently blocks access to all ap_matrix_mdev objects, which
could hang other guests that are using them.

Fix this by introducing AP_RESET_MAX_WAIT (2000ms) and breaking
out of the poll loop when elapsed time reaches that threshold.

If apq_reset_check() times out before verifying completion of
the reset, the AQIC resources associated with the queue cannot
be freed. The NIB is the active DMA target for AP interrupt
delivery until the reset completes; freeing the pinned page
would allow it to be reallocated to a new owner. A subsequent
hardware wild DMA-write to that physical address would corrupt the
new owner's memory and could crash or compromise the host kernel.

If the reset eventually completes, interrupts will be
terminated, but the pinned NIB page and ISC registration will
be leaked. This is preferable to a compromised kernel or kernel
crash, or waiting indefinitely and blocking access to all
mdevs, hanging the guests to which they are attached.
On timeout, q->reset_status.response_code is set to
AP_RESPONSE_RESET_IN_PROGRESS. This is used internally to
signal that the reset did not complete, and ensures that if
the queue is reset again, the re-issue logic in
apq_reset_check() will re-issue the ZAPQ.

This patch also fixes a bug whereby AP_RESPONSE_NORMAL (0)
returned from PQAP(ZAPQ) was incorrectly treated as
confirmation that the queue was zeroized. AP_RESPONSE_NORMAL
only indicates that the ZAPQ was accepted; zeroization is
performed asynchronously. To confirm completion, the following
bits in the status word returned from PQAP(TAPQ) must all
be verified:

status->irq_enabled == 0
status->queue_empty == 1
status->replies_waiting == 0
status->async == 0

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 134 ++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index cbe2fb564a7e..47d4936fb9d7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2123,6 +2123,12 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 		return -EBUSY;
 
 	case AP_RESPONSE_BUSY:
+		/*
+		 * The queue is busy with something unrelated to a reset and our
+		 * ZAPQ was rejected outright. Re-issue the ZAPQ.
+		 */
+		return -EAGAIN;
+
 	case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 	case AP_RESPONSE_ASSOC_FAILED:
 		/*
@@ -2148,8 +2154,59 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 	}
 }
 
+static void report_aqic_resource_leak(struct vfio_ap_queue *q)
+{
+	if (q->saved_isc != VFIO_AP_ISC_INVALID || q->saved_iova) {
+		if (q->matrix_mdev) {
+			dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+					     "Reset timed out for APQN %02x.%04x: leaking AQIC resources (NIB page & GISC) to prevent host crash\n",
+					     AP_QID_CARD(q->apqn),
+					     AP_QID_QUEUE(q->apqn));
+		} else {
+			pr_warn_ratelimited("Reset timed out for APQN %02x.%04x: leaking AQIC resources (NIB page & GISC) to prevent host crash\n",
+					    AP_QID_CARD(q->apqn),
+					    AP_QID_QUEUE(q->apqn));
+		}
+	} else {
+		if (q->matrix_mdev) {
+			dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+					     "Reset timed out for APQN %02x.%04x\n",
+					     AP_QID_CARD(q->apqn),
+					     AP_QID_QUEUE(q->apqn));
+		} else {
+			pr_warn_ratelimited("Reset timed out for APQN %02x.%04x\n",
+					    AP_QID_CARD(q->apqn),
+					    AP_QID_QUEUE(q->apqn));
+		}
+	}
+}
+
 #define WAIT_MSG "Waited %dms for reset of queue %02x.%04x (%u, %u, %u)"
 
+/**
+ * apq_reset_finalize - store final TAPQ status and free AQIC resources.
+ * @q:      the vfio_ap_queue
+ * @status: the final AP queue status returned by PQAP(TAPQ)
+ * @ret:    the return value from apq_status_check()
+ *
+ * Copies the full TAPQ status word to q->reset_status so that all status
+ * bits reflect the confirmed end state of the queue. If ret == 0,
+ * zeroization was confirmed and the response code is overridden with
+ * AP_RESPONSE_NORMAL so that _queue_passable() returns true. For
+ * ret == -ENODEV (DECONFIGURED or CHECKSTOPPED), the non-zero response
+ * code is left intact so _queue_passable() correctly returns false.
+ * AQIC resources are then freed.
+ */
+static void apq_reset_finalize(struct vfio_ap_queue *q,
+			       struct ap_queue_status *status, int ret)
+{
+	memcpy(&q->reset_status, status, sizeof(*status));
+	if (!ret)
+		q->reset_status.response_code = AP_RESPONSE_NORMAL;
+
+	vfio_ap_free_aqic_resources(q);
+}
+
 static void apq_reset_check(struct work_struct *reset_work)
 {
 	int ret = -EBUSY, elapsed = 0;
@@ -2182,6 +2239,58 @@ static void apq_reset_check(struct work_struct *reset_work)
 			memcpy(&q->reset_status, &status, sizeof(status));
 			return;
 		}
+
+		if (!ret || ret == -ENODEV) {
+			/*
+			 * Zeroization confirmed (ret == 0): the TAPQ status bits
+			 * indicate the async portion of the ZAPQ completed
+			 * successfully. Free AQIC resources and return.
+			 *
+			 * Queue non-operational (ret == -ENODEV): the queue is
+			 * deconfigured or checkstopped; interrupts are not
+			 * possible so AQIC resources can be safely freed.
+			 * Zeroization cannot be confirmed in this state, but the
+			 * queue cannot generate interrupts, so the NIB page is
+			 * no longer a DMA target and it is safe to free it.
+			 */
+			apq_reset_finalize(q, &status, ret);
+			return;
+		}
+
+		if (elapsed >= AP_RESET_MAX_WAIT) {
+			/*
+			 * Timed out without being able to verify zapq completed.
+			 *
+			 * The AQIC resources associated with this queue - the pinned
+			 * page containing the NIB and the registered guest ISC -
+			 * cannot be freed here. The NIB is the active DMA target
+			 * for AP interrupt delivery until the reset completes;
+			 * freeing the pinned page while the hardware may still
+			 * write to it would result in a wild DMA write that could
+			 * corrupt host memory.
+			 *
+			 * If the reset eventually completes, interrupts will be
+			 * terminated and the pinned NIB page and ISC registration
+			 * will be leaked. This is preferable to either a wild DMA
+			 * write or waiting indefinitely: flush_work() callers hold
+			 * the matrix_dev->mdevs_lock mutex which serializes access
+			 * to all mdev objects system-wide, so blocking here would
+			 * hang all guests to which those mdevs are attached.
+			 */
+			report_aqic_resource_leak(q);
+			/*
+			 * Zeroization could not be confirmed; set
+			 * reset_status to AP_RESPONSE_RESET_IN_PROGRESS.
+			 * This is used internally to signal that the reset
+			 * did not complete, and ensures that if the queue
+			 * is reset again, the re-issue logic in
+			 * apq_reset_check() will re-issue the ZAPQ.
+			 */
+			q->reset_status.response_code = AP_RESPONSE_RESET_IN_PROGRESS;
+
+			return;
+		}
+
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
@@ -2189,22 +2298,15 @@ static void apq_reset_check(struct work_struct *reset_work)
 					      status.response_code,
 					      status.queue_empty,
 					      status.irq_enabled);
-		} else {
-			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
-			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
-			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
-			    ret == -EAGAIN) {
-				status = ap_zapq(q->apqn, 0);
-				memcpy(&q->reset_status, &status, sizeof(status));
-				continue;
-			}
-			/*
-			 * We end up here when the ZAPQ has completed. ZAPQ
-			 * disables interrupts, so the AQIC resources must be
-			 * freed; otherwise they will be leaked.
-			 */
-			vfio_ap_free_aqic_resources(q);
-			break;
+			continue;
+		}
+
+		if (ret == -EAGAIN ||
+		    q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
+		    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS) {
+			status = ap_zapq(q->apqn, 0);
+			memcpy(&q->reset_status, &status, sizeof(status));
+			elapsed = 0;
 		}
 	}
 }
-- 
2.53.0

