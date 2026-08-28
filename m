Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8339A073;
	Fri, 28 Aug 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953631; cv=none; b=kcklftwMX27msiBfPmNrCzF6MFhelmrLrGXTEPu8AoJfgaF3eo6Wy5BjMJwTmuHDyoit12WLW0FEG12UiKjXHIdrr9j/Yom1HWG4pM223rsRtnO23tZ3uZv91VUmtLIZ3DNM4+VsJrB93g8TulPBj2+uPJCmLTs0y42EPOjI6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953631; c=relaxed/simple;
	bh=5IP86hzRbbjhxxfQNEOYVuSqYDhdRiUR2Bns/Bl/xr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHQwm3BVZEachhr/N24YnvPFzRYS1UDlwZ4EmDraYfBifXSh/WxcXevhz2VptrnvL/iRmASHK/2QVSVW4g3pjUo8pPByqODUDCVXk1c392ibBdPi/CeRltSC66WkZWM03mZpJKqwWXTnjgo6XO1FgxPS+1ouv6vVDRyf8clTSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=irKkpzT/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="irKkpzT/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SJVkGM2906405;
	Fri, 28 Aug 2026 21:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6PvKm4sscKTZCn5rw
	plFou5k5vTrXQv6GtfdgHswfLE=; b=irKkpzT/nkU8PPQrKFl/O3fu15V0Ol+fG
	oUHiiQweq/iebdGx65RJMEUVzoVP9ujZa1lZEeD69fX1o+PVE4YToh+rQ0cJijHx
	FwcSp1BX4B24YTO+hsrHV7zMsLEtzq83FpuZg1a4GJtFvBZMuFCaFjsL6G6XdfkB
	d5nyQoT01Ng20Yd34ebtlBsQmpgla7GYMH6YB80w/sEUPwN/MNT8ABWwU79LH0Yt
	u9oz7WENB/LP3pIe87txOqfD/PA5Kb87ApzEs5lfDs0gwHeugFliKelOn6Vg0ZN1
	Gmb4snIk+ka71EKSkmJb7r/SRisshf1KJ+GRTj9I6UNh3vCmOXtTA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jfc4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:47:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SLfGHi003244;
	Fri, 28 Aug 2026 21:47:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rah0s01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:47:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SLl2k847972692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 21:47:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2270E58058;
	Fri, 28 Aug 2026 21:47:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9435805C;
	Fri, 28 Aug 2026 21:47:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.33.14])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 21:47:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Fri, 28 Aug 2026 17:46:52 -0400
Message-ID: <20260828214653.1087009-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfXz5/qKkvooyEf
 j1NeskfGAIK5vS1J9OEWMvjHUOFdupzG0hVe9ADmv/doO4VKyxjb0drPsUfH2JE6/2YiR/OvpsF
 hVrzpAjTIR+ZQoOrZqmC8XBpr3a4VO0=
X-Proofpoint-GUID: nNPGGOFxVeArsPRkcw1rfjp7axZFfYku
X-Proofpoint-ORIG-GUID: nNPGGOFxVeArsPRkcw1rfjp7axZFfYku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfX5vBEwZX9zOT+
 qn3c5rLMuR4Uqa4gkR4NcW0NsZO9nKDsGIAH9gNPnz4g5/VX/tGRlQBhSufW65ZWpcoSvfj/koJ
 O8r6ErsS18j7VP+e3KeqM9JRVuEM6wNOWIlJLjRhwif02H0+oauTLRgb/MauPBz3LuKxDsBlQP0
 GYNnxGA+87ktUTSfuRdJxFG/i5wgycbIW1kzq1NrksZTO+zpk8Q5bQvUz7Ll8GXWNbb6q1lsZNV
 5ki/sq1DQEC5+WqJ4ZCybbG2Z8c9QbMjzE5WB3JRzf4s1D5U23VpTXo09OWonA8BJTiXO0H1mSG
 6xbIc/NdwxGskrrltSlBlLdh3hEA2/kMTIf4fas0exDquwBHwle85hmQCL0RuCuG0LX6ElV23Uj
 z5wP+iHJK5zy6YRK3EDephVD3vGw+Bu+Q8cWexjO7sHDqmMCO1MKFTyW7a/R2Q17MseWpftJRe0
 WMdYlkvSXn1ER6FUA3g==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a9201d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QSCR_LEHqxABJDgvvGYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280187

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
of the poll loop when elapsed time reaches that threshold. On
timeout, if the apq_reset_check() on that last loop has determined
that the reset has completed or that the queue is not operational,
the AQIC resources associated with this queue - the pinned page
containing the NIB and the registered guest ISC - will be cleared
because a successful reset disables interrupts nor can interrupts
be signaled from a non-operational queue.

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

Note that on timeout, q->reset_status will hold the status from the most
recent reset operation so that callers inspecting
q->reset_status.response_code after flush_work() will see the value
and can return an appropriate return code.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 40 ++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 363d9e53e249..3f5b012be450 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -34,6 +34,7 @@
 #define AP_IRQ_ENABLED	1
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -2067,6 +2068,37 @@ static void apq_reset_check(struct work_struct *reset_work)
 		ret = apq_status_check(q->apqn, &status);
 		if (ret == -EIO)
 			return;
+		if (elapsed >= AP_RESET_MAX_WAIT) {
+			/*
+			 * If the status check determined that the reset completed
+			 * successfully or the queue is not operational, clean up
+			 * the AQIC resources because queue reset disables
+			 * interrupts, or because interrupts are not possible on a
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
+
+			return;
+		}
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
@@ -2083,11 +2115,13 @@ static void apq_reset_check(struct work_struct *reset_work)
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

