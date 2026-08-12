Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AE38238F;
	Wed, 12 Aug 2026 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554602; cv=none; b=gLzFOg0Pomf9Uu8onz8Tdq5m9BnPkxnJnf1YleRr1eYSVUX+7AgsJFDvp47tfVNAQdUp07yZKCWbT4CwMAswDP/EMvlm6TvetO/VzHT5xJti2viRCIOaqHeExWBZdH7H8nOZFETtncfdgJimTtkEZvcryKu8pPXIzkIeX9uECSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554602; c=relaxed/simple;
	bh=h3HrRTfDZXmhYYsK40T/QjDbLSUMRSd2z58bV1vXTC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+XDW/l7xO3AQAH28N7qzcOVgOhk/SXKBZpVtn+atFbNC4NCRHh8JutypzTomo3FLeg4oTvxKM+DkyYot+dtjbEGIOOVLt4jwsJFKpW0wMx3IFwx3Bdi7nsl2Z9eKYLa1yAw/X8myGyzdLWFUVIJ+mQET6Xq61cA+xbLYMiAHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fehCFD5W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fehCFD5W"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1twT4120761;
	Wed, 12 Aug 2026 17:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ynarWxGMXhj6Ih6Rs
	R1tzlw/ljsTB/gbaRfr5yDpPtE=; b=fehCFD5W/1beApczKKZ8RUF7AZIFcM8Yq
	5Yq51xsH2o+r9f1hDmvFWBu4RW8TieHI9mZ3iTpgqiM9yJgNy8iWi1K5AFXAXePV
	FkFuS5cA5+Q9EBajUofWDG4Fcys6NSANtEjo6RWg9BG9+vNks9G+2jj4Pj0xc6f8
	KQIOu9gShJy4I25JuPE4qECDsjaGH/FDfhvgjlApnmbblb1rhqa2VPGoNG2tIimO
	L1HqwTOF0UAnz4p02cKy1M4lMGIHhkwpzmWNunWd0lQPQOXja5vZNMTNBW5VnKVw
	x1Ph4NHGP4h8HNT04ohb2hdGcI8luDGGb36ZHVGlq4dIDp59NlEhw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwaubb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGulkL031219;
	Wed, 12 Aug 2026 17:09:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h71fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH9s8465405378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5031658043;
	Wed, 12 Aug 2026 17:09:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4706358059;
	Wed, 12 Aug 2026 17:09:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 6/9] s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
Date: Wed, 12 Aug 2026 13:09:42 -0400
Message-ID: <20260812170945.738351-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812170945.738351-1-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ca8e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=bGM9o4fjUnjFpbELYA8A:9
X-Proofpoint-GUID: 72qeSOPsRckPQxYCeCMzlZWaGdQ_-aXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXz/qxE4UKmxXd
 7uKBpdKMCxCu+ReNZ6gtLcV5Yr9dkW9M8se5b38JcqCO0EkYKz9o1+B3yimeJsUl+DaOCvtB4M0
 P+EfwOftm0DWQK0yirHaMhq/5eOQ3szA7Do7LbH60ysufhz9TYouwcPavI6c/e8DX1tvj96T2cF
 NHNkWJNFvJPCseEWT+HOYdQbotAuDDIBYnF7L2s9CERqTm8ZRnTgVFb5UbCS5ooIOqyP9mhdXlY
 RyPFJIeKnca4RGSN5PbxKX/3bRyFjo9HeLqwHKTVqRl4ZavAkm4cDqbqpU+Geq8FsqIEGtjfZw5
 D0FmAEbHFo0AgOnMlFxqVLE1A0T/Rxsz4bLptAUi9jOOSB4DLNDK7yANSFGfsh8srHikOhvr7qH
 bLLt6x8Ww8hdPivmOO4s15v1xjRzD9x2cr/eEfmISMHluUE6Q+cLNzUmujtZjFrzWiO8/kh4ORR
 ELNnrVd0iERVfU4mSQg==
X-Proofpoint-ORIG-GUID: 72qeSOPsRckPQxYCeCMzlZWaGdQ_-aXP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX0nf5iTVX8fCV
 ZnqWSzb4eT1rP6gTwbG3Wv/0/Ft95BElBFFHXlYG1xYm2mVIyp8jx4M8uoKr3TeZSb5r+iXUrsv
 jgfDEhphw0pV9FI6p8eeTYAxI8xvPOE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138

The DECLARE_BITMAP(apm_filtered, AP_DEVICES) macro allocates the bitmap
on the stack without zero-initializing it.

In vfio_ap_mdev_hot_plug_cfg(), the vfio_ap_mdev_filter_matrix() function
is only called to initialize and populate apm_filtered if either
filter_adapters or filter_domains is true. If the hot plug configuration
change only adds control domains (meaning filter_cdoms is true, but
filter_adapters and filter_domains are both false),
vfio_ap_mdev_filter_matrix() is bypassed.

Consequently, apm_filtered is passed to reset_queues_for_apids() with
uninitialized stack garbage. This can cause reset_queues_for_apids() to
interpret arbitrary stack garbage bits as valid APIDs to reset, potentially
performing unintended guest hardware queue resets.

Fix this by zero-initializing the apm_filtered bitmap at the beginning of
vfio_ap_mdev_hot_plug_cfg() using bitmap_zero().

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0f3537aadea8..d667ad4bbf70 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2861,6 +2861,15 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
+	/*
+	 * Zero out the apm_filtered bitmap in case there are no adapters or
+	 * domains to be added, but only control domains. In that case,
+	 * vfio_ap_mdev_filter_matrix() - which initializes apm_filtered - will
+	 * not get called and the reset_queues_for_apids will crash because it
+	 * will access an uninitialized bitmap.
+	 */
+	bitmap_zero(apm_filtered, AP_DEVICES);
+
 	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
 					    matrix_mdev->apm_add, AP_DEVICES);
 	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
-- 
2.53.0

