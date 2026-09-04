Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3544AB99;
	Fri,  4 Sep 2026 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514493; cv=none; b=UkY2bvza0zkFhG5SSjp5HYUVlqHURBH86QwIw6XdatFNQtk6Su6tK1HoNpsLbUGir8fM7myHPHaFWa05XcqMmk8mAlEreiBea1PM2jLLYA48Oe5J25sUcblfYIqkSEFT1BD+lrVqYszoh+SfhxdX9akWjsPt2mLb+IA4QlE61vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514493; c=relaxed/simple;
	bh=VQ9YuhUFLxguD2kecXTmHBXBFCzjWANov1U9qxdGFSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4bztq5UkfnwGq1Ay/MRPjA+fBhj5vTZuInVeTI9Uzl+uTAPduHzqmtnv0LW8NWAnjpPEk7r9+bFBpat8TqeThSqXQDGWKd49+ojRJY8I4G/2+iLkgnZxMqnRhaz2nviruEdwhiUCPSEoPXFpqNcc09Sfp16rOgEuH6XSKRWG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CEHvDyYT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CEHvDyYT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Mrj3254202;
	Fri, 4 Sep 2026 09:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0mC/Bf
	yCSjfOhfZnuilTOW1udWUtnMWhmPwUsvm9MDs=; b=CEHvDyYTTv1HB30wufgMnX
	rM/K5gujQdD1VlVaOpTFcGXWe1lb3pCbgrlS+rZjv7jgYRQ2bsPSTLhOWg4zXo/x
	c566HPevNas1CMktVH1bRsGDWrG85smeNdf/VfsC3q0qFnV0wcjwGcn0PnqQNzuP
	iCbobu7evULRJceaEWNT+VwPactoVSMupzdGA99WDIOrOhgygBr8L/Sb0jhbdrAK
	bcGAQhpNn+LHzEoq+uaY+jSe79/hpR+DfeWjcD4DWyiekAcS9snD+cTS3b99JRdj
	kkTMGPu9Jqo0P7PtsM88e62DGp1yPdUCnq/g6v3R+ULWgv0MOrISc77QuhYonUBA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rswbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849QKhJ026486;
	Fri, 4 Sep 2026 09:34:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygv4es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849Yfw140567190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:34:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A24FA58056;
	Fri,  4 Sep 2026 09:34:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DBC558063;
	Fri,  4 Sep 2026 09:34:40 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:34:40 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 3/5] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Fri,  4 Sep 2026 05:30:52 -0400
Message-ID: <20260904093435.1161402-4-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a90b4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=qf4gfuq51q0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Q8sFNKbEVmlkk-m-RCoA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX8QWgipqnsEr4
 j3RenNIo9LCUNB9nZopPly9RO5zfDZ8nxwrVQQRlEP9AdEnVVFimhWMBbhHiqlXgUunYopKJg84
 xi0J73CMd5SZBhOe5g2p6JPRBWt4ih9Sb8BEt3vkyjHn1B2YXgrzo8YddP6VfYVA9VIUf5FVpC7
 g1kx2MSCuKSR2JNVncXpBg5LA7X/j3F/lUb6wT5Vjq5RiRkmqvQsqqu/PvHBcOzPTFDTY6YcgB5
 Ggp8NfUeqhHWxcOLE78HvSf9lWzmHx3rWhSVD+kZWQwsYDdPjnRhY26879BOnLg5MnGo46K2pFE
 +NcBPHZqAj8qJHrJtZOd/6qpeBrC7a4qN1TUlP+OZiwG7jcjwXMHkn89Ep+yNt8CUNeiqmE+KxK
 VH3XxXiER5Y/7KcWiOeint2s3Vndauc9q/yfiDcnqDxjz0nqOn1oY2PBS+kc9zhogbTIgG61tBl
 PbU/I44akFgA62xjg8Q==
X-Proofpoint-GUID: DwZ71JDUErxzYyXnw0lwLTxA-3697yyI
X-Proofpoint-ORIG-GUID: DwZ71JDUErxzYyXnw0lwLTxA-3697yyI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfXyRlPsf5CaCjT
 19dhnxGsgpSAja+yZ7h1NZzFAW/mvaWjd67WcJkx7gwguucelyAgXPtN/G+g5ylKo4vayyHgFx3
 nvrzKY4Jwmrg9S+Eu9xOw6hLDTQt/sA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040086

The apq_reset_check() worker polls ap_tapq() in a while(true) loop
waiting for a queue reset to complete. When ap_tapq() returns
AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
apq_status_check() returns -EBUSY and the loop continues after
sleeping AP_RESET_MAX_WAIT (20ms). There is no upper bound on how
many times the loop iterates, so if the hardware continuously
returns a busy response the worker runs indefinitely.

This is particularly harmful because several callers of
vfio_ap_reset_queue() - such as vfio_ap_mdev_reset_queues(),
vfio_ap_mdev_reset_qlist() and vfio_ap_mdev_remove_queue - call
flush_work() on the queue's reset_work while holding one or more
of the global matrix_dev locks (guests_lock, mdevs_lock) or the
KVM lock. An indefinitely spinning worker permanently blocks access
to all ap_matrix_mdev objects which could hang other guests that are
using them.

Fix this by introducing AP_RESET_MAX_WAIT (2000ms) and breaking out
of the poll loop when elapsed time reaches that threshold.

If the apq_reset_check() did not verify completion of the reset,
the AQIC resources associated with this queue cannot be freed
because the NIB is the active DMA target for AP interrupt
delivery until the reset completes; freeing the pinned page
would allow it to be reallocated to a new owner. A subsequent
hardware DMA write to that physical address would corrupt the
new owner's memory - a wild DMA write that could crash or compromise the
host kernel.

If the reset eventually completes, interrupts will be
terminated, but the pinned NIB page and ISC registration will be leaked.
This is preferable to a compromised kernel or kernel crash, or waiting
indefinitely and blocking access to all mdevs, hanging the guests to
which they are attached.

There is another bug in this code that is fixed via this patch. A
response code AP_RESPONSE_NORMAL (0) does not indicate that the
queue was zeroized; it only indicates the PQAP-ZAPQ was accepted.
The zeroizing of the queue is done asynchronously. To verify
completion, the following bits in the status word returned from
PQAP-ZAPQ must be verified:

status->irq_enabled == 0
status->queue_empty == 1
status->replies_waiting == 0
status->async == 0

Note that on timeout, q->reset_status will hold the status from the most
recent reset operation so that callers inspecting
q->reset_status.response_code after flush_work() will see the value
and can return an appropriate return code.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 123 ++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index ea0625f10c7e..32b80d91a643 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2008,12 +2008,47 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
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
+		/*
+		 * The queue is busy with something unrelated to a reset and our
+		 * ZAPQ was rejected outright. Re-issue the ZAPQ.
+		 */
+		return -EAGAIN;
+
 	case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 	case AP_RESPONSE_ASSOC_FAILED:
 		/*
@@ -2024,6 +2059,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 		 * a value indicating a reset needs to be performed again.
 		 */
 		return -EAGAIN;
+
 	default:
 		WARN(true,
 		     "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
@@ -2033,6 +2069,33 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
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
 
 static void apq_reset_check(struct work_struct *reset_work)
@@ -2050,6 +2113,54 @@ static void apq_reset_check(struct work_struct *reset_work)
 		ret = apq_status_check(q->apqn, &status);
 		if (ret == -EIO)
 			return;
+		if (elapsed >= AP_RESET_MAX_WAIT) {
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
+			if (!ret || ret == -ENODEV)
+				goto done;
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
+			 * Report the actual non-zero hardware response code, or
+			 * synthesize AP_RESPONSE_RESET_IN_PROGRESS if TAPQ
+			 * completed normally but the status bits failed to
+			 * transition to their post-reset states.
+			 */
+			if (status.response_code == AP_RESPONSE_NORMAL)
+				q->reset_status.response_code = AP_RESPONSE_RESET_IN_PROGRESS;
+			else
+				q->reset_status.response_code = status.response_code;
+
+			return;
+		}
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
@@ -2066,11 +2177,13 @@ static void apq_reset_check(struct work_struct *reset_work)
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
-			if (q->saved_isc != VFIO_AP_ISC_INVALID)
-				vfio_ap_free_aqic_resources(q);
-			break;
+			goto done;
 		}
 	}
+
+done:
+	if (q->saved_isc != VFIO_AP_ISC_INVALID)
+		vfio_ap_free_aqic_resources(q);
 }
 
 static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
-- 
2.53.0

