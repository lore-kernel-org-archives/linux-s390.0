Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86A471401;
	Thu, 27 Aug 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837105; cv=none; b=C6GvzTikSenAIxjRJGaqJ+qv2l/xCrHOtwl7s+TYy9M2CtiVCaPnOYkRDU3JYeAUp7fkXFmiMDUPvawg+DcrdJfmJZ1avPdOjc1XeXV2v30muEpSMzYszXl0C9qG9Ay78Dj9o4lqFGcV2XpEBJiLSDbEFmz/MeBWsLqfUXL4lqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837105; c=relaxed/simple;
	bh=Vj6TEpH754140Zk8NGOPD5XhRjpHB5zOygV7VtZHsi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGIerKLhrXdojEQ4qITAv5Zf2x4DiS4JWR81bV01AdmJP8uUAF72Jj+1KOALXxZWPBk0Wz0cJ3EsPG4Mob5dX/T/xSa3DmT5w5oDFBBCWDpXLy7pSsc5BnbJ7mZycoXZ0/iLRpx5oc7tvBVeUO53yOz0myTRrtwt0V5EI5//Kfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3M31WO9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3M31WO9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVSKB3001315;
	Thu, 27 Aug 2026 13:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QX7cDrPFlwXDSlsvF
	YYszKsDaHL6g+PXOll/E4cQIVg=; b=D3M31WO9nXVb7AOd5vu+6g0ER1UUiHwU1
	we+OjDCTkQt9gYP8EH3gSBvZYvgRK/2/3H6QKknLj7scJcmeFembVPoR9jecy+2G
	3rzz3/uMW8/LKZ/pmFI85Bl+CTf33HnKsAPsJ3cKmlMxTMSe3JZgUh31eOB8kXni
	EzNQcmnTYDNrX5nBCmpFXkvEz9v4gUw92ScPs71eneShJSGCUq39aTHEI4bnS+lu
	sC3CFHJ/0MtVU6VkelnWoLYM8XMu3ogFANx6WOSfRl51v73nBztcdUyJjA7269BS
	UzPSD1FE8ai0uIMbxPpOlI550UuFaHm2Unz6C1BNoKLqkrzoyaQgA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g55n1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RCuIdi031744;
	Thu, 27 Aug 2026 13:24:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhg6n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDOnsC17105610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:24:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC63658063;
	Thu, 27 Aug 2026 13:24:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10C458065;
	Thu, 27 Aug 2026 13:24:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.15.38])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 13:24:47 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Thu, 27 Aug 2026 09:24:30 -0400
Message-ID: <20260827132441.555866-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: KjSa6wO28bNNz6HGgg4CfZDpJ8DNXcF7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfXyQVZALFrxdXy
 3Ahdo614f9Ki4Tpq7v8m6SPl61h6YINhspRVwUGHOTbB0V0e7/n7wZw9cR1yD03unDN7rowknIo
 XqlP7Zk8JKP+VihmdZCIXx0iI+t2LoI=
X-Proofpoint-GUID: KjSa6wO28bNNz6HGgg4CfZDpJ8DNXcF7
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a903aa3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gReD5cTbzgwmqpVxveEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX2vTm7h++b5Fr
 7xUYSKhkB6igTxVCI8jiYTm36HBxPd3cW/xk5gvY0u2b+JxNGXU9kdPaoZiQrY90GfVP2rUgnK9
 cVbTYp2Bay0WlsVOzvGpfEzuBXjYkB8d23AKr6pxuTzEjg9q5rwJzNESbK0zct7KfIX6hVwObC2
 5LFKO0YZPHJIWApkMKUdGAbC6e7rpXiURjP5XFkCUKQVHWH+h2ePYGwsEbHJDNUD0W/c6DbZ7qS
 Il6kGELmoH3FaogEui8cB6qrc1wsabdsH/Pso4N2a0/dnZrgKRzUH28aX4VhpksWvq+2q+CpF4e
 qIeRXpBHOcPWhABk7rDd6R/zKclzQ1RqXR0syTtd5eULrXerdTOkkhPIDfGxVHpRHs8hMe9rZ2u
 gICSeewDoZJgmHqysfSWk+Eoxsa8Mvxvfdb0Xm1Yuce7ZFx1qwTkxeyKpJu492IiDKH8GX9yM74
 hoNmPdkHacWGG+wXJ4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270109

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
index a9a33f4949a0..85a59730019e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1468,7 +1468,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -2795,11 +2795,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
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
@@ -2910,7 +2910,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0

