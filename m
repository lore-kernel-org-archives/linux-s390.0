Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB14433059;
	Mon, 24 Aug 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579950; cv=none; b=GzTUU7UlVec0rNWf2dElMA0GvHgf0sMkpwsNdHdxsIHyLAzd3P20ibrZq0ZbxEg6zk8bNeNz93oMV//fxHYHzrqL/ia1lAJvlbbjSz1LzOiz7ZeQWdGI6+KXrtB3qyB598NWbIWVkr30SUWya+Nal8yCzbgaU5Ghgu2aFjIDUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579950; c=relaxed/simple;
	bh=z7XaBpLRVHhbKsLRsvraBZQSzuXhG8LXWCQZh0ebOtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7C2Weve7DWgdwxxRQeVA2nmiU3z4bvSdZX3Atr2QqR2LQrLLfW3jDN/PIpfnXPggFmW41eFs3/NMXNAi9VRLcD32uqQffNOS8NK9KBOlQ0frXxyEjSMGPwpuxyHXPq12IAv9/BT5hbfI4qfydgVLpvlGf9qmnaIovC55g0IM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fI+1fUTW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fI+1fUTW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1fCB1958092;
	Mon, 24 Aug 2026 13:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6OkkulEj2lwC+ZmQR
	X7bPTmTwcxpIn543p9y/SQLe10=; b=fI+1fUTWjrW9wQa0ilRaCkPGHkOKwH5PN
	4rMSCHi/WHuQom68TMBtb++vVltUckpyLspdfJ4yNzJ8uPO6Huw+sYt9S8az0rLU
	SjGLVIWwh5f36WRSEUXd3wfWrKGm0WJrAQfFEuUMie/nQv1VCioOLQLFBX3WUMbD
	Nstb38Y0hLF9Eg0S6SY3hNobnEscfCuohr0KOD86d5TSvFRB8CKe4HnNj54eUwfZ
	Fl9qjmdb7wfDYu417+3KhsFiMPDxVxGvojmiArWoC6MKDdpSeeYJ512Xn66C543h
	YSXofw3PqLl6Zt+W2TSmYsZFfdvW5Bt9CxkTFiTgooLnmLFXa95Aw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4hq68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:59:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODuIvX030621;
	Mon, 24 Aug 2026 13:59:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag636r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:59:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODwxKe3539676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:58:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26B1B58054;
	Mon, 24 Aug 2026 13:58:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 482FB58056;
	Mon, 24 Aug 2026 13:58:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:58:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Mon, 24 Aug 2026 09:58:49 -0400
Message-ID: <20260824135850.503728-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824135850.503728-1-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VU5VNhRIiXafo0sYIdv1UTAFMIRjWb8M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX5hkmW1n+CZtQ
 IjBtsrYELkfPxsVIujarHC3uFHdSL8pJ90hXJNauxYZexN6FtVlV0kT957/TJB+zez1ywGNbHfJ
 Ry7Tqn1vFE1deYIEJsUIHfuIS7CuAWg=
X-Proofpoint-GUID: VU5VNhRIiXafo0sYIdv1UTAFMIRjWb8M
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c4e25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KD7G0zD2dsexTIroXy8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfXxizVBYhFKV9o
 FwwiYxOfDYvl5IkpVqeRlGP3HkHXXZb/tg+BIHEzDzfXpF3U4zFv3lGxKnh1YZb7ZfvuhXaEBhh
 6ovJRD/ODZnSRP+rwDR91l248/Y1ShKZOSwEU+SKWAXF0sMZyeeyp3DHFZUodoUFKS2cg1yWXAi
 2p/DuRDeRdYlMz7X76eVoq4BTbTMFNyX90K09+8/sUVKJzWnNdvK/Hxb+aXWJlK0Yi8gqBKm8BC
 pQ/ruHRUih9aeNogsBaIMMVBLflfvjeXU//4sNxV0Nvkgbo7Isy2dny89Pt3c6RHhKrPSlsFJO9
 XrXwkdsRNP/q5TYi97sKUrrBnH/UGIW30YEhaa3uGhbNkim/CnHG1fIfvIPF8k1prmlTZDhwzZk
 Ip8d6kvrcvDrQIYTP5eeZIi+Wdxs48BQzSvl38agoGeBkz80eEEFs3YmT1ESxXdL8cVUMmd546a
 /WjZ8JySgcr+zQPndRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240114

The apq_reset_check() worker polls ap_tapq() in a while(true) loop
waiting for a queue reset to complete. When ap_tapq() returns
AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
apq_status_check() returns -EBUSY and the loop continues after
sleeping AP_RESET_INTERVAL (20ms). There is no upper bound on how
many times the loop iterates, so if the hardware continuously
returns a busy response the worker runs indefinitely.

This is particularly harmful because several callers of
vfio_ap_mdev_reset_queues() and vfio_ap_mdev_reset_qlist() call
flush_work() on each queue's reset_work while holding one or more
of the global matrix_dev locks (guests_lock, mdevs_lock) or the
KVM lock. An indefinitely spinning worker permanently blocks all
of those locks, hanging mdev removal, KVM guest teardown, and the
VFIO_DEVICE_RESET ioctl path.

Fix this by introducing AP_RESET_TIMEOUT (2000ms) and breaking out
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
 drivers/s390/crypto/vfio_ap_ops.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6e4569d6b975..c7eebbd0ed40 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -1973,6 +1974,12 @@ static void apq_reset_check(struct work_struct *reset_work)
 					      status.response_code,
 					      status.queue_empty,
 					      status.irq_enabled);
+			if (elapsed >= AP_RESET_MAX_WAIT) {
+				/* Timed out waiting for reset to complete */
+				memcpy(&q->reset_status, &status, sizeof(status));
+				vfio_ap_free_aqic_resources(q);
+				return;
+			}
 		} else {
 			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
 			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
-- 
2.53.0

