Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D252BE5D;
	Fri,  4 Sep 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561348; cv=none; b=h42yUFkQWS/HpyH1ZugJ+7BuCihN4zh9yt1B1l6BkwURxgLb0ZdtIiAiJS+Zf3wDcFPCupRZaQBTT3jf79FmB4z+VAly8jzxyZAf2NmV6Z5qL73qfLUMo7bsY3wnNE7PdZWnzKawwm+2vw+TodBV4KF79mGbbmqCsIsaXA4k4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561348; c=relaxed/simple;
	bh=Pq5tIgbE8U9N+lb68/T1GoUSxmKiFGqYKP9oa9lNakY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPIYbEUqgYkAwTA/hoTRZ0Pt0Ubnw3fxU13a+ePv3HvmajAn93AKA+KXkyxLOfL0JHrltuqABdZKkWqNcJyQwyimh6tnQtlkGBn/Vduah7b040Vbc0HMhhFsMPThO+KN5fZ/RGjSHRejwHvgAPVIXzTAegNZ55jvATnmKviuIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3csYYbQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3csYYbQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684L1dJo2857489;
	Fri, 4 Sep 2026 22:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5OP1YRGVIwlfMSzqY
	P0/PwIKv3UjBFBzE0gocjFnpIU=; b=S3csYYbQ/bDfnUggG8q5T7GvHHTB+iZPs
	VmwwWR2LOjNdyjVdcsyUSzdYOSu99svXvCNaPVTibIZIyu5jF6EAc/duKLvc1WVa
	LchGZ0oljzC69wwg2xnFwY26vq0QKzkcpu8/cM6otVFISzh97VAQ/7dWMqYmK7qQ
	Gkj3000ri8Ft43B9ueh37kuaaK6tXjYj1IB58XI/Q4dWCkPYFAs406IPLTGTc2r9
	3wan7eYg9xPaGelr7Ci2FAhEk5wFxBfVXFVK7HB/DZLXn1ff8bVUCccxS7M9R7MC
	+oPGJLxrsgfVldGR5T7xr3A2eoDUyE58gPqQFcg6I5lIj/wBkzf4A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tvu8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684MQJjq026196;
	Fri, 4 Sep 2026 22:35:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkqm4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684MZbWR19530372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 22:35:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE7E25805D;
	Fri,  4 Sep 2026 22:35:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B348858056;
	Fri,  4 Sep 2026 22:35:36 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 22:35:36 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 4/6] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Fri,  4 Sep 2026 18:35:29 -0400
Message-ID: <20260904223531.1611088-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9b47bc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=gReD5cTbzgwmqpVxveEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX8lwjvvVIs+3e
 M0DdqFS50v1HIpDzCY8RTBAPM3Hy/A/CBcnOZ6iGdwCNR3kWnbwUWnzMbnTPXer1f34gZaHSvB7
 dLysAut2dXTvHKKe65bwfNhH1p2NB6o=
X-Proofpoint-ORIG-GUID: 8XmXtRgpN5YMen4TGIwTq8LmcX1S76eW
X-Proofpoint-GUID: 8XmXtRgpN5YMen4TGIwTq8LmcX1S76eW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX55YjA+w+WvIP
 YFd1ZKe4BacJb6iQCEBKNs/Iaop1csjGiz6oYsFiQOWflLlWZx3N/0ds9dP26tkpyHsqlt13Iqw
 jP/+Yx5Na4YQS4p9oWqizvo74+TShMWuldK1Vr0C1ig1fAvXiQV+TswBohBSY0km/VAeMgLk31A
 nllpfeHo3Y+nsdAsR0BMQ3V2CwftH8pH2gQZwrLn41xMqKbBe6uO/tEtAMFCNYTY257XBFDz70G
 ZF7Dy4LBLOn19u0FclzqZEB9O03n4L1/ThUKHTnDFzTpaDvY20RZ4L3Tn8CzhChzl0dTEkFZ+VQ
 M3JAExj+sfl0BkrTn32hA5I5SHjMDSmE08gNsbkigpP5nK/fj7ZGkMLUBYsHyXST2EeVBT5xYKh
 1lcjFUQ7TRdQuKjVjquybVl6tS610vtyEdxNHLzz1u75HpaqW1Rx4774bxvFrOieZzeqwJ8dsMi
 DIVZjDP//V4qM0v9BEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040209

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
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index f9f35265b84f..672fae69739a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1503,7 +1503,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -2947,11 +2947,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
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
@@ -3062,7 +3062,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0

