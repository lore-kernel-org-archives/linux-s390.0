Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363D51DDFC;
	Tue, 29 Sep 2026 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684333; cv=none; b=I4tQn+iTr6o768LVPVX8zRI3clZm25VmsK8mOdrYrgkFnzg7V2bxBYEcFrSREwKxAGxo6XMc0AlLMkQWOWizmCqARYomA7DRKbmqQmNqt/mrkFWjZZsOUVTx+JiQgW8DOMEg2ju3v5/fGyo6Bpsm8nCJs77SDLfJMEh0AxQnb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684333; c=relaxed/simple;
	bh=wjCmyAwGwxnZ/JGUOBOrI4yScmQpXedRHj8I/4EszxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDzUIeW18s7UbNZhnzWtg0lakKDC5Ch1aQJ/b82IidP72KL5c6jSNZ5G4++9tHdQBSx38fytUV1VSV7vEAww+hRbbsuyP9S/xjK3fC4ssAek7lC6rF1sOo9CD6kuk1mlIvqLlouOvKzn4zAhORKxDRGa4in2nfMg9Vx7+jR8gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GZj6p6R2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GZj6p6R2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5m6U4018014;
	Tue, 29 Sep 2026 12:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mJQNL8WovEa8gtU/0
	E2T62/O9Zy5z82zbFA/F4icwMs=; b=GZj6p6R2Y0uC/2v+i253W9PZFDSumzkHa
	MKRw9oIZ/BJmhvB3+v265gG06Cih04KZNB96EugV/ZxQpWzaH0fsD+P3aEJCwG/j
	xofmow1KW02NMeUI9MwCSDiiFyBvtTXiqyz7ZyAFHr4uf3vVb74j1wMEfSRqUJtL
	ElphoBod9udwSNx2E3cRs5rN7I7UZM4Fuup6vjGF7C9br24cIFesalbdRc6b04ft
	O18sgq1JiCF8UtxudUQslojqKpGceAtSx7FHYOkm6GjsJEe8EVrMp04poIE5+dbm
	6cy7fSnbuxJcmQ31IZZODxPJB3nAVgnMQPoELtHW/SGOCNjKOLq4Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt65s2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlXKT1667688;
	Tue, 29 Sep 2026 12:18:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhhjts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCIiAY56689032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:18:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3BEB5805D;
	Tue, 29 Sep 2026 12:18:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E98B58056;
	Tue, 29 Sep 2026 12:18:42 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.24.130])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:18:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v9 3/6] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Tue, 29 Sep 2026 08:18:34 -0400
Message-ID: <20260929121837.2715710-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tGItlCPyLAivQoW-Ijh79NKtHc0jbuCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX0s1uq5pWkI7/
 BDQ3iL9BlTtxvtEbFyfMCsaOHIIJq+szZwDPQ+2IZojWLCWK86nE1YqaRwndIEKVp68BLzv+rcj
 VJ8AsRawmyfNIaATdGsvIucLnzFyxxWpG88lS6snC80htQzxTrBJV28L/13XdnI9Cxas5XZbbeh
 sZISOi+ClXmafiZD/2Dlvn4xJoVWjOUrzSIQL1aJQrYNRSQi7lJbAEvtA9LJwI8Tbm8wjTJGz+I
 ciRriJIMjkAFfoxRmyYoLL72OHYRD91Jd47rH2e/p3mNIi1XEViPg7YNfowWSUObhtHo4c1C0J6
 AE0q4y2e68Gfqlu8qqn3KfVClhkKryRtC8y/ux70CDgi+3blhubrmYDOCAEVKmUD0yeUGplettN
 ePfE650BLXETAUQCl+uAOZ37WiIurVjw5bGsVBNuZL8UDTh49oJ3A3tFBqsYU3TMzJOx15QWXKO
 KTdB+g2PlCCwOL0eufA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX05LbbasS++Ue
 ZcbAqR/AaNr5ZfA17iKlUxFEJCNV2huALLtAbmb0dACpVMAytSOiY9WWwct1Kd/nXnrYOBVJD0j
 z2D1qlqOB7wJ0JOzp8feAkckp5rzDxA=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbaca5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eFsuE5GGs7WHm1Q7U0AA:9
X-Proofpoint-GUID: tGItlCPyLAivQoW-Ijh79NKtHc0jbuCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048

The apq_reset_check() worker polls ap_tapq() in a while(true)
loop waiting for a queue reset to complete. When ap_tapq()
returns AP_RESPONSE_BUSY, AP_RESPONSE_RESET_IN_PROGRESS, or
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS, apq_status_check() returns
-EBUSY and the loop continues after sleeping AP_RESET_INTERVAL (20ms).
There is no upper bound on how many times the loop iterates, so if the
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
 drivers/s390/crypto/vfio_ap_ops.c | 122 +++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 087e8474a34a..07fbfa6f1015 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2164,6 +2164,12 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
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
@@ -2190,8 +2196,59 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 	}
 }
 
+static void report_apq_reset_check_timeout(struct vfio_ap_queue *q)
+{
+	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID || q->aqic_resources.iova) {
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
@@ -2223,30 +2280,73 @@ static void apq_reset_check(struct work_struct *reset_work)
 			 */
 			memcpy(&q->reset_status, &status, sizeof(status));
 			return;
-		}
-		if (ret == -EBUSY) {
+		} else if (elapsed >= AP_RESET_MAX_WAIT) {
+			/*Timed out without being able to verify zapq completed */
+			if (!ret || ret == -ENODEV) {
+				/*
+				 * Zeroization confirmed (ret == 0): the TAPQ status bits
+				 * indicate the async portion of the ZAPQ completed
+				 * successfully. Free AQIC resources and return.
+				 *
+				 * Queue non-operational (ret == -ENODEV): the queue is
+				 * deconfigured or checkstopped; interrupts are not
+				 * possible so AQIC resources can be safely freed.
+				 * Zeroization cannot be confirmed in this state, but the
+				 * queue cannot generate interrupts, so the NIB page is
+				 * no longer a DMA target and it is safe to free it.
+				 */
+				apq_reset_finalize(q, &status, ret);
+				return;
+			}
+
+			report_apq_reset_check_timeout(q);
+
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
+		} else if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
 					      AP_QID_QUEUE(q->apqn),
 					      status.response_code,
 					      status.queue_empty,
 					      status.irq_enabled);
+			continue;
 		} else {
-			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
-			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
-			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
-			    ret == -EAGAIN) {
+			if (ret == -EAGAIN ||
+			    q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
+			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS) {
 				status = ap_zapq(q->apqn, 0);
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
+
 			/*
-			 * We end up here when the ZAPQ has completed. ZAPQ
-			 * disables interrupts, so the AQIC resources must be
-			 * freed; otherwise they will be leaked.
+			 * We are here for one of two reasons:
+			 *
+			 * Zeroization confirmed (ret == 0): the TAPQ status bits
+			 * indicate the async portion of the ZAPQ completed
+			 * successfully.
+			 *
+			 * Queue non-operational (ret == -ENODEV): the queue is
+			 * deconfigured or checkstopped; interrupts are not
+			 * possible. Zeroization cannot be confirmed in this state,
+			 * but the queue cannot generate interrupts, so the
+			 * NIB page is no longer a DMA.
+			 *
+			 * In either case, it is safe to free up the AQIC
+			 * resources.
 			 */
-			vfio_ap_free_aqic_resources(q);
-			break;
+			apq_reset_finalize(q, &status, ret);
+			return;
 		}
 	}
 }
-- 
2.53.0

