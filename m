Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4865208B3;
	Tue, 29 Sep 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684337; cv=none; b=i/tx9KzuG1BCQQLC4OJbiqRXBDxMrov3x+fGcze9F65yh3Me+Uj0xO80HdiXSxamXXhevi40Zpovmgm1YJYb+Nke+tsqcd/YstxwomUYGMzFwSmoQ7vy3kLsQkD2rHpO23eEXul7vNdN23xyGkv5Jgs1nu7mnZQiaF0JDbzLiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684337; c=relaxed/simple;
	bh=hnAtNqJ9xgDiWpSDTwDDHJWu4yaG77mLre6SaHZxdFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAZVVYnZae5tN2oSI2h/N/9GEwkzbUOqEz8FssW7zXtcTsNSD0wduVL3bozXX4hzRqzOKZ7MA6TP16NlRc9XiKbuZB6qObvgIfbQP8L0HExKp480yLiHs8NuJPvgPkVHB08Dm3bKuYVMvick+QvjtyT1ki35COKFD2MWsuJFlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nZbXksSO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nZbXksSO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5W4c4017569;
	Tue, 29 Sep 2026 12:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=flQpzDQ0vnaPrueX6
	QDoRnZ9E9UhT/0CHh6yAwgIr90=; b=nZbXksSONJoF5fpgU4YEMqaeWzoeVSwxB
	AcHSskgJ6Ofvm/SNnmOUlMK+QLEZgjx0HjyN8RsuP+rwWFfC7qWeWVXw2GbUDxMU
	WQGXyU7245tkkXr6qEFgzR4ZJJdIWaua9Q1ywfq0Ld/GzJmIwQhTuz6DBVFXRoBF
	6TH1Gc9VfMX92XLwqwS4EYiell1gMuvUnUs1Q1sQRk8eG488nS0+jD6tV1FuDQmw
	xakhMfqkcRpyVu9s0QQDgbG2WfTbRFy370EDJey4/IMOxM765RDc/kRceuF8gUC+
	00iKdt6wB4Gxv45KTa8WKgNTrriKuo0Ict0HrYgYTzavakmN782ZA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt65s5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlVev350342;
	Tue, 29 Sep 2026 12:18:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg9fp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCIjKI34537908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:18:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FD625805D;
	Tue, 29 Sep 2026 12:18:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ECBD58065;
	Tue, 29 Sep 2026 12:18:44 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.24.130])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:18:43 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v9 4/6] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Tue, 29 Sep 2026 08:18:35 -0400
Message-ID: <20260929121837.2715710-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NU3_7AQ2MYrCDUiSKwaEahQQeNm4ARAR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX/isT28GEvAzq
 GaP4s4KwPacuyYtp8U6qOBznvL+NtpSW3ClX6Pk8G7M1O/dRP680HaSgX0id3YJaQYqxDRpKU1g
 pwluyPrDCWJClPHro7vn/up7CVeWkcA+Lb6eP1+O5tphAXhViTKlmw9sWU34gjlbQ5NhuWLOk44
 KRrR6zayCAHCgb1eoN2J4f6kDuRaForsOhc1N9jTGs36KyVvW/GbvuKpCA9cjj30JlTMYEmmHB8
 m7z2j5kg3J9yaEqLV9iu19EqKuU5uxzPlmWE+8U+RVwFQVQE3D3h+HpzFdc4HjSo06geIj/lhwE
 2aNuhey3Q2F7qRy+l6tRmoASFxOnSZip9hEnVDSJ7f5FH9YDh1hOJKHxvZIiak/h2yx3PMh1Wo6
 uAUP9ClCvW8BpFAFkKG5lXeMc22AzU3LNb3j0Rvwex+NCJUINiHOqQU15J0zjXTAS2xJf69BadH
 Bl9pVKP8kRfGP5DV5sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXy/Ozf44uj7P6
 8t1oLCpEdtBdRhRsLQeNr4e8/qRCUFS652VJuocqJHg2ioXsWm/er9z2TbevVWZgzmVmwmDqqU2
 dEx2a71AIvfbfUI4s53glYUIeOh4WLk=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbaca7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=D0hz_wQ1kplqRd9WN9EA:9
X-Proofpoint-GUID: NU3_7AQ2MYrCDUiSKwaEahQQeNm4ARAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048

Domain and control domain bitmaps are sized by the AP_DOMAINS
constant, not AP_DEVICES. The two constants are both 256 today
so there is no functional impact, but using the wrong constant
is inconsistent with every other operation on aqm/adm bitmaps
in the driver.

Use AP_DOMAINS wherever domain and control domain bitmaps are
sized to keep the code consistent and correct in case the two
constants ever diverge.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 07fbfa6f1015..ad19d44a67bc 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1599,7 +1599,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -3100,11 +3100,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
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
@@ -3215,7 +3215,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0

