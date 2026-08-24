Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A8393DE2;
	Mon, 24 Aug 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608584; cv=none; b=bNNgPhTzX8VIzYZtf3OSfC2+QAcsggEp577Hr7cBUDwt3a31bj/A1lVXh++4rTuLFyeW9xauQKNOS449H054hJgsRKMV6mJ88u0EFWZXLNN9Bl7eLtCDwF2y/uXy3NBesFzgyWXmRXfszXSJWfsvk1/NQJ24l0/10Gt/z+IRmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608584; c=relaxed/simple;
	bh=F9W9GlmdN4Ps18czqNl37cNBvPaUjb2DlghZg3hDGwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYGz6ftQydkpOpO0h8EJr4AvtXEQIYIFhamKQhG0NKiGMqQLmrWq+GorZK+r4KBQEcEylHzootl2aPdfSUjlgF1VOU3LKVMcxVQkA9QEvI/NB92JwvRc2uTzeKdYD4QWpaDkr7W+2YM0BPc0hv01oTCDol5tlmrPlTNHwyePSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y7/rtje6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y7/rtje6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVwJr2904969;
	Mon, 24 Aug 2026 21:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LzB2TqBJAxvotGL+6
	eHP/QguJboiB2pp74KOhywSW4k=; b=Y7/rtje6EkeNwfLy6Uk2a9U/rz1a5Vx3J
	Xl1qoDQhuznAKltQfEmag7ENY1n90UuEXwLYb7q/tfvs+AV12rEpjMYZsYuqjvDW
	fPunULDx+HlEisOywDFuvLSsP4uSHR0ATMS0B45oGo1IvyrZtbEpP1w4ZcfUvZ8H
	6OH2k/rHg/aVZm7aidDGmJYC9UESQSaAVL16no5H8YiIxMWFHS6fTlyM9yMfVDiy
	ZR/V+wkoWHzICAWlT82EKZZUZndrCptXwTwbx3QhrkbYLwy88m8yFtR0ASObzK2r
	GqeMF3fPqNX4W2suVUNquCE0B+fPo/hEOdpzJDxJPnOfIzmzHKTKQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx46nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLuGMh007115;
	Mon, 24 Aug 2026 21:56:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q0whg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OLuEt928639756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 21:56:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80A0158043;
	Mon, 24 Aug 2026 21:56:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C46DE58053;
	Mon, 24 Aug 2026 21:56:12 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 21:56:12 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Mon, 24 Aug 2026 17:56:03 -0400
Message-ID: <20260824215603.819379-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX4BRGUW6BTA8b
 sJtagWgnD8rAQE7mTUAyv/OinfCCFt1LyIPXHILPJl4AsjbZVnXNkayUlFvmOhyNPW2cIhPZljc
 FePMG2/nuIGxttYrQ/JonY/ldjNzwWM=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8cbe00 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=gReD5cTbzgwmqpVxveEA:9
X-Proofpoint-ORIG-GUID: QFcQRgpyrDjyJ4K_3bCh03XQKyj2W2FF
X-Proofpoint-GUID: QFcQRgpyrDjyJ4K_3bCh03XQKyj2W2FF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX2BVURvVZuJpf
 aNv5YKTZYQkdOkpAL+NoSINC5ay8v6MIxzjRQZq8ZP4/9f/13DK39XQAPjF32Sy4/9k8LgHNIY2
 W69WYI5wLcno1SfkGLVUlI5tnYhEK5qmiZ9FyXE0i2yzPU8i16zg/yvYwM3P1zuJUDROBPlrz+W
 h4l9O+k0h9NTow0foLeOL144pJVREAbiQ9j2wgzgBo3NsvBOUL/Yn0Slj/RavObCvs1NNJ5NCFI
 GlfibgPT9usUHS5Rm3EWu1Z1jMQyxuPQ89HcoTomREoppkCf3GFCuDRyzSJu2LiOpJVitL1STd1
 /UlP7878TtgGL/3Lrjnw/ZlBx78p0hh0d27OuDHnzpV8+7745xXdcn4bQNWhUjrDL66NiQJ7nL1
 mhu7cAmHLVhsIDozCqXFWyfVlS9OQynz0U/VnblQ+FUcBTrqeQyoRMLb1FziwONQ3ecPYshbYXu
 4VeL3P03r+iJlNuDQ0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240182

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
index 7a9b5448e90a..a41d55146db1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1414,7 +1414,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -2738,11 +2738,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
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
@@ -2853,7 +2853,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0

