Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82D393DC7;
	Mon, 24 Aug 2026 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608600; cv=none; b=uTBkA+I5LbVPnnTMWQoRl0eGSmMuoymMtP5rCvH+QrsCikMh3vJ96b2+vUFFODAyGH5Ste1G8Qcw+Lb7AgONal0Zw05U7QIRrQK3C8rdnFRICcVivy5ge/xTycV/nG1o3QtP/bRvkGCw4tE9vvHvlC8hJjjwPVRe0MMnUOFDxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608600; c=relaxed/simple;
	bh=tFulEEdlyFB5a8pEXmgRywNNstCIO1qZlDoadWGMYNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjwEibk6/05zC/1FURIfjj8CdvGH15XxuaoyteTDhfCaBTMa8ehTxm8ZwfMu/Nawppz79ccKxGtGuplrNsT1oKDd44cTdKuEzoXj6hYh96S82eHlxWAxbAYgl+JjQ7nXaYm68Q6Ik9h137uIO4xp/HpQIebJXwNR6EVpphKnBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A0o4Ptre; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A0o4Ptre"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVSSt2857838;
	Mon, 24 Aug 2026 21:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iaxnCMCWScUbqw4i3
	HTGIrEeljHRN9KNGUjxik8eoCE=; b=A0o4PtreK5yktuDwla1ZF4OxkcHHaC/uQ
	HIvCTl/ljnwNhLDe9F5s+pUM/1bwTpcbjHP2+TzrVumN7aSwkixEGw96Flljaot7
	dtjiPVogMasVvTFlY7vVMJUsSKlRlOJue2CNDcvUWaqbMWkGzQvlSTvJWaO+GDWn
	Hxwnhoq0im8ZAHqGEC3npxXMSGe3K/mMG94xV7AUNUr3mAwxbPfZL/HNtsdA9zUj
	BQeNE1RLxrwQfZ6AyRzSNlzue2jd3R4AG8Rch6GRSpwyuT2xJVmjUN81eD6fNoCx
	gHJkERYUCaB4HKVmoDAgffzUQdAGTMW/9fH/2T2RhMuWg4DRWp1Vw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4mdva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLfGsJ022136;
	Mon, 24 Aug 2026 21:56:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jrqax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OLuC2Z32506370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 21:56:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9573558043;
	Mon, 24 Aug 2026 21:56:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B303D58065;
	Mon, 24 Aug 2026 21:56:10 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 21:56:10 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Mon, 24 Aug 2026 17:56:02 -0400
Message-ID: <20260824215603.819379-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824215603.819379-1-akrowiak@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fXA-4VpoV58SSSGvFE2dY0jJ4UaR3pYf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfXzHhI1iOcNbi0
 U4WAgWmUfmakwLw6yg++E7I2iklB+lcjsGCn9lamsptMw9Dbb4JgefODupCa4TTCheq363j7fXN
 l52izQdV3rLZ58hJjWCgxiZnjUmwPdY=
X-Proofpoint-GUID: fXA-4VpoV58SSSGvFE2dY0jJ4UaR3pYf
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8cbdff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=y3d8e9OS9Gm2Uli4ifAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfXwVsJPukXNVtx
 txy8Hee8V11GpxiESY9Sq3/idECO7XSxhmTqzHq1NsIqS0yxWdmIxIBaIsnnZxOBbfdvRnEcJYK
 4gXEAV7/Ez9RcKu2TJVcctnaJVf2SAoNOe5nqQVQ6+ttbUYcDlgNKEASD9tCXDTqGYYqoU9m2Tr
 QRshbyt9VLtoMA+g7fXIk5fjsEDJF4EL5C4FC1gN83d/SMgN3MqANXylV0LC80VySvIbzEC1ej3
 fKlOdMwJk5lghXodz5mDqJJid7w0lFahU03/QPhbVvGoi8iIiL6o81Q36BYN8wk2DyPT21F29Eu
 f6Wl/FXxD7C61lHHP3bfKgWfP64NQKo596Ct8sHd3gGY608CurvF4hV8kqTrsEuqYolDEx/jjNS
 7EradTVx/+ASNpwCG7d6CqH+h4/FN9jNhCZ8QRdgGS+bJP3OCsyOTCX53mEK6QY8eMZNIcXTBZW
 wI6FHhZy+xVUin6yaFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182

The apq_reset_check() worker polls ap_tapq() in a while(true) loop
waiting for a queue reset to complete. When ap_tapq() returns
AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
apq_status_check() returns -EBUSY and the loop continues after
sleeping AP_RESET_MAX_WAIT (20ms). There is no upper bound on how
many times the loop iterates, so if the hardware continuously
returns a busy response the worker runs indefinitely.

This is particularly harmful because several callers of
vfio_ap_mdev_reset_queues() and vfio_ap_mdev_reset_qlist() call
flush_work() on each queue's reset_work while holding one or more
of the global matrix_dev locks (guests_lock, mdevs_lock) or the
KVM lock. An indefinitely spinning worker permanently blocks all
of those locks, hanging mdev removal, KVM guest teardown, and the
VFIO_DEVICE_RESET ioctl path.

Fix this by introducing AP_RESET_MAX_WAIT (2000ms) and breaking out
of the poll loop when elapsed time reaches that threshold. On
timeout the final busy status is written back to q->reset_status
so that callers inspecting reset_status.response_code after
flush_work() see a non-zero value and can return an appropriate
error. vfio_ap_free_aqic_resources() is called before returning
to release any KVM ISC registration and pinned NIB page,
consistent with all other early-exit paths in the function.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 3f99b239fa95..7a9b5448e90a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -1971,6 +1972,27 @@ static void apq_reset_check(struct work_struct *reset_work)
 					      status.response_code,
 					      status.queue_empty,
 					      status.irq_enabled);
+			if (elapsed >= AP_RESET_MAX_WAIT) {
+				/*
+				 * Timed out waiting for reset to complete.
+				 *
+				 * The AQIC resources associated with this queue - the pinned page
+				 * containing the NIB and the registered guest ISC - cannot be freed
+				 * here. The NIB is the active DMA target for AP interrupt delivery
+				 * until the reset completes; freeing the pinned page while the
+				 * hardware may still write to it would result in a use-after-free
+				 * kernel crash.
+				 *
+				 * If the reset eventually completes, interrupts will be terminated
+				 * and the pinned NIB page and ISC registration will be leaked. This
+				 * is preferable to either a use-after-free or waiting indefinitely:
+				 * apq_reset_check() holds the matrix_dev->mdevs_lock mutex, which
+				 * serializes access to all mdev objects system-wide, so blocking
+				 * here would stall all other guests using AP queues.
+				 */
+				memcpy(&q->reset_status, &status, sizeof(status));
+				return;
+			}
 		} else {
 			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
 			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
-- 
2.53.0

