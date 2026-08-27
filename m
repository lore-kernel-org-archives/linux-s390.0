Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8A4746B3;
	Thu, 27 Aug 2026 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837103; cv=none; b=GeM+TaHUgXf+rVQiuvk22CK1dS/gY7mUishDs34YddemsVJQVHfDHQHZblnQZRwCq81teDyWj+akJCA268rAMsOJ5P0M7dCpQunUM+L8bL4m3E4geeELmGhEKXHe6ooy66EyigUv38r+5HTWZpV05QJTxvtkiE1BRrGEXObwtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837103; c=relaxed/simple;
	bh=DW5ur2GDgaG0fQ1YnY1EXxVbeJL9kHSUUwchijPqb08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS5r3LPEz8eMTqXpVw8IiyQ5dB63wqW9oYb7dUDeydCloI9m24LUK5R0yPs4lT99BWLfELlyraiRd6Df1QaR/qRVuV33vDs8AnRnNepYbqGRPU5l9Xdfp/XjJr0/3jr6KVzFFCD2mYmx1zz7l5gL7rPB66KNZfe3ugiaEdbeP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2JcyhzH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2JcyhzH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVfGM3056500;
	Thu, 27 Aug 2026 13:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y//a/1dejuvCbPOiC
	esY4wmqgti970P35/cIGN/9af4=; b=T2JcyhzHL3SeLLzYFlDwbwxfM/cRKrSU9
	FP+s2A2v+dpDSF2FGs4r52nnaYtBBrxkOC4iQe4l0bfsE5lU7dqabzYLtJAP0+zj
	8ytw3B3hGTn+p7vuzBR+jTIhaJYFLE3BzA7e008jZk7p87rvNjljvjAQwhhb9uHR
	1AMWWmmqyAesTw0eM6tFfdTaPxq5k4M47RV+jJ3KbMO9q8V1ib+sJ003ba+6Yex2
	8toO1Wm+fyU6x+8cgzGX4zjoeXUFd7Lm/8TnWqkoICJfInY56GZtk0D6XdVOAhHC
	LudBeyBAv+p1m7GifiaTvVWZK3caIXBMtgNUnJS8zZXdAKA15YmPg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxn84g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RCuGYJ031730;
	Thu, 27 Aug 2026 13:24:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhg6n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDOlxH33817288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:24:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A35535806B;
	Thu, 27 Aug 2026 13:24:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71F7F58057;
	Thu, 27 Aug 2026 13:24:46 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.15.38])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 13:24:46 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Thu, 27 Aug 2026 09:24:29 -0400
Message-ID: <20260827132441.555866-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827132441.555866-1-akrowiak@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX8izkl8UHCXN/
 NGjmIX1VQT+sIn1lX8br1Wjf0J5eb4fC+MKCCgSQcfhqgSSSDVaoDKmyVxzhZfjZIn6B4pmLFR+
 MGMercti2jQTIRzq0kYYyfi2e7u98Rs=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a903aa1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qRifxZYimwebPS9KaUgA:9
X-Proofpoint-ORIG-GUID: XJUstwI26qh1Kac69caNV2xLmf0rIPjG
X-Proofpoint-GUID: XJUstwI26qh1Kac69caNV2xLmf0rIPjG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfXwJPId3/NJsAj
 YJeHBeBcvMhhKBE+Vwq2sW7iQY9GBhj9Sb/uimUJQSqWzvj60pQTzJO+MOyq9trAoqy1jxENHwP
 n0Qi8P3WOwFiFbX0bRgCY4AKWay9GpR3bbqCSGts46OjdzKMQ+K49OHbF7loBkvLwqJgiyqv+8v
 ZyWH+mVpqtXgpREUM+MPbnHsXGLcf/uMNxE+9t7/giohBZpuTtrQJD3FzPUGnjLYaURH2FNoskB
 o2IPXMnBI7xAM6sbMHj4ToYRsF+lXTHIZG+uLmFALPCEmJUOg3Z6OIMWyYHtZHxaSpgyy26/+8O
 7ZoOL69LnETKCtk+ZS4eNAgzr++FplU5U24eHBvPL7qGFE0LJDbyTzCtmewdGmdilNWZD5GXnNh
 9peTdBpROhAsKbImSilLPiqw3k0vw4kv/qGGKus5VFqY3iTEL3bFvT76zyyj5f5HcXitePD5TfR
 BnhWGNMcsyJ0/s4WYtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270109

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
error.

The AQIC resources associated with this queue - the pinned page
containing the NIB and the registered guest ISC - cannot be freed
in this case. The NIB is the active DMA target for AP interrupt
delivery until the reset completes; freeing the pinned page while the
hardware may still write to it would result in a use-after-free
kernel crash. If the reset eventually completes, interrupts will be
terminated, but the pinned NIB page and ISC registration will be leaked.
This is preferable to either a use-after-free or waiting indefinitely.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4c32fd6eaaa6..a9a33f4949a0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -2016,8 +2017,32 @@ static void apq_reset_check(struct work_struct *reset_work)
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
 		ret = apq_status_check(q->apqn, &status);
-		if (ret == -EIO)
+		if (ret == -EIO) {
+			memcpy(&q->reset_status, &status, sizeof(status));
 			return;
+		}
+		if (elapsed >= AP_RESET_MAX_WAIT) {
+		/*
+		 * Timed out waiting for reset to complete.
+		 *
+		 * The AQIC resources associated with this queue - the pinned page
+		 * containing the NIB and the registered guest ISC - cannot be freed
+		 * here. The NIB is the active DMA target for AP interrupt delivery
+		 * until the reset completes; freeing the pinned page while the
+		 * hardware may still write to it would result in a use-after-free
+		 * kernel crash.
+		 *
+		 * If the reset eventually completes, interrupts will be terminated
+		 * and the pinned NIB page and ISC registration will be leaked. This
+		 * is preferable to either a use-after-free or waiting indefinitely:
+		 * the caller of apq_reset_check() holds mdevs_lock while flush_work()
+		 * blocks holds the matrix_dev->mdevs_lock mutex, which
+		 * serializes access to all mdev objects system-wide, so blocking
+		 * here would stall all other guests using AP queues.
+		 */
+			memcpy(&q->reset_status, &status, sizeof(status));
+			return;
+		}
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
-- 
2.53.0

