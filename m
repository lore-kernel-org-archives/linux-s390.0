Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529839A7FE;
	Fri, 28 Aug 2026 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953632; cv=none; b=Eqwncf3b1JTFjH00vyP+jKYd9GGwDU+XqrjVtTsL0QCJFVAp7Zq8YfZKMHhgBk9Dlc2LrgZPCW8f8DLfpP+UzQFqRSj2isKwoI62UJf3UqTXW1z2fz0x3gCo7IjxcbcZhH46zpLuW2Tcnn4MmmPWJRjG37wJ++Ehk0vfYz49zKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953632; c=relaxed/simple;
	bh=Se9FKOPpwlll3rGeNoVs4JCnXUH+ThM3MGOUnYeXV2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W40hQhaGNbqFepfO1yCpvoRd7cnW70jodw3OMZfuAFPoOfhdPWHmvW4pCHUTIT2JGYVSWPgy9Ie0N1EUOvt5Xzf7Y3Gkh/JV3r71AYgKq6pfn9V2NYExtGogb0CkhDE/Ddpps2flusq+HscOnWft+V2ESlcCnvfEwQedIAYGWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B6XaHAx4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B6XaHAx4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SJVimF2906391;
	Fri, 28 Aug 2026 21:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CWXPw+tf4gRxPN3GA
	vBZzDnxuTBqj+yfz1VUEm4lCVU=; b=B6XaHAx4D6QKDWpNqM4jQESoXMmfjNpIO
	xBto/QikALOLDF2w1RL/4gZI0/6JBPxhubmPdoao4znPGrcC/y4J2ftWT+eEX506
	beskpCLwcph+M4VprVXXwXfDlt/2P+GUdnJOoDeKM8bM2ZuMC4yq9uvcmFofdFyy
	9QtJVv19zBLJZRKUfQeIlT6SXJ5b8iA+E7Fie2UD9Y9roNApiMR27fE6au43NxXH
	ZyE5LnyT3wWPR+6IFT8rSJ+SkTUNdLJxyZrdkFE4Pi8YJfTLk+ujFcekX08URrAf
	PsT4XPK/M8+Vo1i+Jgb/j2QpESlXsiDrj2r6Gctnue9TH0pCP9n/g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jfc4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:47:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SLfGHA003236;
	Fri, 28 Aug 2026 21:47:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rah0s08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:47:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SLl45M33817336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 21:47:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F00B05805E;
	Fri, 28 Aug 2026 21:47:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E8585805B;
	Fri, 28 Aug 2026 21:47:02 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.33.14])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 21:47:02 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Fri, 28 Aug 2026 17:46:53 -0400
Message-ID: <20260828214653.1087009-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfX683J5DmJFkA1
 aLWBuRG9wYF8yHNfFAzjX8v/DbTpxy9h++O45QwNt5OSt74GMX5Qj1IczUYBkJ7PzKVP2raulXL
 CRs4YF+5KaORKtG2Ft2SgD47caSWawM=
X-Proofpoint-GUID: UxiT4iamRjZodyVhJoTQe_iWKEgcNJvM
X-Proofpoint-ORIG-GUID: UxiT4iamRjZodyVhJoTQe_iWKEgcNJvM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfX9X2RvBpZOqZZ
 ZlS6u71sIcofwJGa0fSAj79D4BqjQq+tt78blC+XLueUAiFs8Aqr+0I/gzObWbJi6bW7ekTL2M7
 EIhEt8EiX85c7vPKya43l6rtmiPMOdliBqMZPBlnwHTqRUcqo0MjeUiLob8Pcuoko9rvMtmyBeL
 EH3rA9DwNdSA8RurFNBd+RiG/0OtxMcl/GCvlyKHV3UhpvFLqLliBAwys+3ULso3B5uQTzfaq7A
 fF6//TOvj/LlodruaRumYn39STR24Ge/aZoFTkSbXb5x+DPE+Xq45lC141nZhdxNMlE9/Q0a4vY
 8YWgqcoT/VKfe3ba4L+MQIwXRv2zn3vebxfB90N4iFxDw08fZW/rTrXa7KhMoO2Mh/mhTWhG0pE
 rP6e2tJ+bTHnZheZ6tVL7cJHbrYUDa8gQD34Z9OAMG20iyyeHEW+m3lz2bPFEGhhXoRwVcwBjWm
 NvS7Gl43i96/Totv0zA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a9201da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=gReD5cTbzgwmqpVxveEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280187

Domain and control domain bitmaps are sized by the AP_DOMAINS constant, not
AP_DEVICES. The two constants are both 256 today so there is no functional
impact, but using the wrong constant is inconsistent with every operation
on aqm/adm bitmaps.

Use AP_DOMAINS to keep the code consistent and correct in case
the two constants ever diverge.

Note:
This patch was submitted in response to a sashiko review comment pointing
out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
fixes included here for those also. The subject line was kept the same
since this is in v2 of this patch.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 3f5b012be450..d9a8844020bd 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1517,7 +1517,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -2853,11 +2853,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
 	do_remove |= bitmap_andnot(aqrem,
 				   (unsigned long *)prev_config_info->aqm,
 				   (unsigned long *)cur_config_info->aqm,
-				   AP_DEVICES);
+				   AP_DOMAINS);
 	do_remove |= bitmap_andnot(cdrem,
 				   (unsigned long *)prev_config_info->adm,
 				   (unsigned long *)cur_config_info->adm,
-				   AP_DEVICES);
+				   AP_DOMAINS);
 
 	if (do_remove)
 		vfio_ap_mdev_cfg_remove(aprem, aqrem, cdrem);
@@ -2968,7 +2968,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0

