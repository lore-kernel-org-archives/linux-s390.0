Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAC46A5ED;
	Mon, 31 Aug 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196501; cv=none; b=A1dI/MFzOLZxagS7v8ZeaQ/sx9CQg/Plj/xVKwsmlLz6/oWHzkcNNTChPktOf33HQsLmHHwbG2tFs/DI68e7TSRalIy+EJrfGYko/kWMxcjanxRD/+D2eoCen6vIY+pLWRREIqSXode48nF3XMvBi5h20gHlMGCQKAFcRm32Oo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196501; c=relaxed/simple;
	bh=oM08gdJq3lTMby6bywff8KS4I4DaDsNi4i3+BPr2/4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwrFG6Liez3sLjFQqwAoYerBBbU57F6HXNPlpUma9+pipxcN5+uhuUdjyenw1f18ApxcCxMvYddn8Qcxgr+l3GfbShHYB/Lu4PY1FZ+KSvlCJkVZOkhxUBGcToO3yWa205Yo/la/cCqhEgkIBoCi7Y/kqTn6ShsclZSpi7X+AzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NqDZGrY5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NqDZGrY5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1nWm1615981;
	Mon, 31 Aug 2026 17:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UEDpNqqw0A5yeqsLX
	aFVLJvnjHyytvF0RzwLizSkGSs=; b=NqDZGrY5Poxdb3Z25b4nSg23rFIT+/JLT
	X1u+3fH+gcy66LL7a2XYO6FBIUQIpVjPzoqGGqvzbHrLruSfHJZZ+ZICtA93I1yC
	jINUqvKEH0ROdXXYv4g7qteEqdkpzH9s0DUNBEngho5zI7RfoB2l3ZKhbzxnAltx
	LT0pI0nEvzbIWRmGRwQn9aZVnoWnantYsKv2HqU77gbPYmlndNrG8DX0LZTJamGP
	KrW/BX9k7LklnD0PemFpVR9W/oH7L5R2ORGTMrP86tDT4UTRPSYup61muaso5ozV
	lqCucXNXe8HS+tbbQ120YU5t0HlnCagwOQCzJqM5Syg54z8T7pf0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudjs2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHBGOs031356;
	Mon, 31 Aug 2026 17:14:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexxwqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VHEpM521561986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 17:14:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AD8B58054;
	Mon, 31 Aug 2026 17:14:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7405805A;
	Mon, 31 Aug 2026 17:14:49 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.29.117])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 17:14:49 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Mon, 31 Aug 2026 13:14:42 -0400
Message-ID: <20260831171443.222225-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: pS08_G_wPH5-GhRuWPTMUWtQIv9C-JwX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX6kpNW/Au6Hwl
 1aT9tdAInJQtkbiwiT6yi1xUzuCNFGF0mbR5EDXjtO6ZaYH97pOE1EHe4S3Sw1EyEe4F8ySScKh
 kAMTSUdM4oIuwQsODx50GMck3y5SnaGpzwHpOqxny7AJ9mzYEQghELC62pvUPLHJVJm9+xdJ36v
 9sB4Hrog/FoZfhWRaq9JsRSTFTjSvmc3S33Wsy8IrDSnPQcQlS/8mx8bLM2Vp1qXNvRFJsOfgwd
 ylVlKz/hwcYTtBISlAwoe5SM2efEgYz4qOYiIfhx1hY0KID67ihtDj1C98Hew1dYU4dwejVneCV
 omBXlCrJ16j/r0s6FsL8Cb0L/dpfU4kCyfE8VkYnk489OpQo8XOJZXgr74iBK0oHNP6JgqLVFIX
 ROKJ6VBn3jwsDRyAgbrFPGmWl/4Xi+3I1Qw0I+X0NjJX7ZmVWSfduEARy47P27maKQtJ/Ff6ton
 R3TaDnAfHbbBAeEtMHQ==
X-Proofpoint-ORIG-GUID: pS08_G_wPH5-GhRuWPTMUWtQIv9C-JwX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX8LqniC87B3tt
 PPUO+5nXTO7dk/+tViSOMN0IHdXM1Qdhek2bqO/VBqCtDGWLJsu39ng0qDcRrSArGulojm5Zo34
 cOtSgG2gSejpURKQkLVfm9DSOnOGbeY=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95b68d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=xrMLxwH7pWkX3jLdfMEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310147

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
delivery until the reset completes; freeing the pinned page while the
hardware may still write to it would result in a use-after-free
kernel crash. If the reset eventually completes, interrupts will be
terminated, but the pinned NIB page and ISC registration will be leaked.
This is preferable to either a use-after-free kernel crash or waiting
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
 drivers/s390/crypto/vfio_ap_ops.c | 97 ++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a4980d993b68..6c315d7a0a08 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -34,6 +34,7 @@
 #define AP_IRQ_ENABLED	1
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -2025,12 +2026,31 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
+		/*
+		 * This response code only indicates that the PQAP-ZAPQ has
+		 * been initiated. The following bit settings in the status
+		 * returned from ZAPQ must be verified to indicate that the
+		 * queue has been zeroized.
+		 */
+		if (status->queue_empty && !status->replies_waiting &&
+		    !status->irq_enabled && !status->async)
+			return 0;
+
+		/* Still transitioning; keep waiting */
+		return -EBUSY;
+
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
+		/*
+		 * If the queue is non-operational, interrupts are not possible
+		 * and AQIC resources can be safely freed.
+		 */
 		return 0;
+
 	case AP_RESPONSE_RESET_IN_PROGRESS:
 	case AP_RESPONSE_BUSY:
 		return -EBUSY;
+
 	case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 	case AP_RESPONSE_ASSOC_FAILED:
 		/*
@@ -2041,6 +2061,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 		 * a value indicating a reset needs to be performed again.
 		 */
 		return -EAGAIN;
+
 	default:
 		WARN(true,
 		     "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
@@ -2050,6 +2071,33 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
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
@@ -2067,6 +2115,47 @@ static void apq_reset_check(struct work_struct *reset_work)
 		ret = apq_status_check(q->apqn, &status);
 		if (ret == -EIO)
 			return;
+		if (elapsed >= AP_RESET_MAX_WAIT) {
+			/*
+			 * If the status check determined that the reset completed
+			 * successfully or the queue is not operational, clean up
+			 * the AQIC resources because queue reset disables
+			 * interrupts and interrupts are not possible on a
+			 * non-operational queue.
+			 */
+			if (!ret)
+				goto done;
+			/*
+			 * Timed out without being able to verify reset completed.
+			 *
+			 * The AQIC resources associated with this queue - the pinned page
+			 * containing the NIB and the registered guest ISC - cannot be freed
+			 * here. The NIB is the active DMA target for AP interrupt delivery
+			 * until the reset completes; freeing the pinned page while the
+			 * hardware may still write to it would result in a use-after-free
+			 * kernel crash.
+			 *
+			 * If the reset eventually completes, interrupts will be terminated
+			 * and the pinned NIB page and ISC registration will be leaked. This
+			 * is preferable to either a use-after-free or waiting indefinitely:
+			 * the caller of apq_reset_check() holds mdevs_lock while flush_work()
+			 * blocks holds the matrix_dev->mdevs_lock mutex, which
+			 * serializes access to all mdev objects system-wide, so blocking
+			 * here would stall all other guests using AP queues.
+			 */
+			report_aqic_resource_leak(q);
+			/*
+			 * Report the actual non-zero hardware response code, or synthesize
+			 * AP_RESPONSE_RESET_IN_PROGRESS if TAPQ completed normally but
+			 * the status bits failed to transition to their post-reset states.
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
@@ -2083,11 +2172,13 @@ static void apq_reset_check(struct work_struct *reset_work)
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

