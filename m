Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49674F4740;
	Fri,  4 Sep 2026 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561346; cv=none; b=ZfaYRSZGvb+5FzH+WgFXA0vzO6dGnA6EgK5jh655Keq4EKSnLNxYTjD/sf55FXZmj98HkgY2Tda0nwcO+4p0+VMC8nylqlj6CPCusolaRAuZwXBhVuzJFuCseLJtoOOIB2wG/y57pyo1gQuLhrA4lGg4B+WRaxQdEhekWdhPba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561346; c=relaxed/simple;
	bh=kURVJ5KEDyY5YH97k04lXU1lI5EnPeB52R2y/YWARo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1Hs4JZXx7Q94N887/YodTljGtbxv/pZ/PkPpwuAFn6Lm/HJnNgX3YCmQ0kuo0qT/n2J0SJiA4PA0lZVjhHLeoI1aHgV2a3NoGZRjq9qv1cv/b9x4lx/7V8vGWQRoFXyTn7L21RP4Jo0t89n9ULOt470RkwWLKvSHNNSeLKgeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A1WawDUm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A1WawDUm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684L2NiT2816748;
	Fri, 4 Sep 2026 22:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TCMdEJXD1RUsYRptE
	uqZB7umVX95OPbgqOH3GpkS63U=; b=A1WawDUm0mio/XEWHGLPZc0sA+5Njxt65
	+etk7t21OqwUQuwYGW5C/OPrOQBYibV/1hJOgrxIo7soexwbhHEJrCSwLVRahXde
	AfEmAhIRgaNR+skORzRvvEoh1XBnutj8m0UJuMr+DQje2ycnPXprNXQEOvbefvjs
	LOQR+xho1H/v4Hcbej5SmA8s2R5Ml8cVmZ3Ui6ds9whuyy9koRLl0zFtY7yJ8bc6
	HBP9Anf4AnJLAjskwx+inXA+a4PUTgpAlV/I+b6FCNgRWs1PMN1iCd17Ctxs4eJC
	hlts7Aj6XvSYcaSQr71jAiMqoQhmbn3rwytSlInROM5v6nGXFeLlQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx65m3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684MQRiI011802;
	Fri, 4 Sep 2026 22:35:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjb009q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684MZaHA32506442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 22:35:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C275805D;
	Fri,  4 Sep 2026 22:35:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 786BA58056;
	Fri,  4 Sep 2026 22:35:35 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 22:35:35 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v7 3/6] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Fri,  4 Sep 2026 18:35:28 -0400
Message-ID: <20260904223531.1611088-4-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9b47bb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=759lh7Qq2uJCZsb0SykA:9
X-Proofpoint-GUID: 0jU_mQXiAPZvDNJEugyUMJJkkkSFMj58
X-Proofpoint-ORIG-GUID: 0jU_mQXiAPZvDNJEugyUMJJkkkSFMj58
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfXz0LMHrDejxeF
 91bTB50Pj/AwDMthbPlTcnvaNMPPyucahoAtrCPFMTLvd8uF7Tonct4/5JF/HYxqULyccQmRVcE
 9erarazROv01niEoWjNGULbq1IU7zd0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX1D37CMuJ58Jz
 onKBJxtQOUnK/FkgIRHsxlflvJ+iGb7ESa5rEWAPIaEoSAADYUboDS3spK8E/3bpLBDDthQ+g39
 5EpHHl7qKga5c4NTNAgjrd2e8UFVouhqHc87DiQM2ewTbS5cChyZKcjhjEg61xhPHuyUunXF7uZ
 jkabJUIt5Ra1bl83y97XSVU4xMOtuSGsC2RNuBVOn562A8aUu/KT8TzdK+FuaN6l1h1qkFk/uTO
 NNuUQ5VZ539WiEQ9x6b0nuSCH/7vtGIrofm3SsScPiRizdEcR2D1SI1zS8PWb9Hl40Cdb7H8oo8
 vQpmbKMf7AJye0YS6jt9sr/651kD4QvSygJ71hwJR4oSG/2Ifqd1aaYPAtzvy5OUYxS1vRYqbNu
 qZzviiv1rZkyjCiacj6IVpLRBgW4VMH3WNwjYZFfBC6A5J513uQQjtY5Eeh4lXGd5D/rSb+sknq
 3CTmYipnIXXCMLEqsCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040209

s390/vfio-ap: Fix unbounded loop in apq_reset_check()

The apq_reset_check() worker polls ap_tapq() in a while(true)
loop waiting for a queue reset to complete. When ap_tapq()
returns AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
apq_status_check() returns -EBUSY and the loop continues after
sleeping AP_RESET_INTERVAL (20ms). There is no upper bound on
how many times the loop iterates, so if the hardware
continuously returns a busy response the worker runs
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
hardware DMA write to that physical address would corrupt the
new owner's memory - a wild DMA write that could crash or
compromise the host kernel.

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
 drivers/s390/crypto/vfio_ap_ops.c | 91 ++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4a31454d725a..f9f35265b84f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2047,6 +2047,12 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
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
@@ -2072,6 +2078,33 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
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
@@ -2096,6 +2129,53 @@ static void apq_reset_check(struct work_struct *reset_work)
 			 */
 			vfio_ap_free_aqic_resources(q);
 			return;
+
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
 		}
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
@@ -2113,15 +2193,12 @@ static void apq_reset_check(struct work_struct *reset_work)
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
-			/*
-			 * We end up here when the ZAPQ has completed. ZAPQ
-			 * disables interrupts, so if the AQIC resources must be
-			 * freed; otherwise they may be leaked.
-			 */
-			vfio_ap_free_aqic_resources(q);
-			break;
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

