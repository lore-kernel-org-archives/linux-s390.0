Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701039A4B3;
	Sat,  8 Aug 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208859; cv=none; b=jG/tbw8s/L6c901gDGquN3DWn4mrtCOAdaV496/u6SkWCN6ibo8NH81lzxUpoMaZCWbp2Tk2YB4XPbg4isnGN1AyBptS6YX8VPPj0ammVf2ezFqewost/q4hSa4w1yL7dfzItIcUW2CZV/OpCaMrQn9+fjTZNM0OqCCDpU6thLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208859; c=relaxed/simple;
	bh=S+0Py54QPwwjxmTjKRphpYRFREkV9K/0Uu60dj0hMsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy42cbqLiSuOgTNWhroGtZCxWoiE0WU0Z5v21Q0QtlA7CEWHXNIAOFKCOuB3ok6cDJLMy7YZAwOz+j3kiwUzofFoqro1skeIjnfJBGBqMBLLXXBjhbh0RXRcg7W+sWfJ0CNBh/Z4EOy+p3mTpTmNyYK8hP3fo1OhXZ1koux8E8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KHUimw45; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KHUimw45"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678H1n0O625794;
	Sat, 8 Aug 2026 17:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=orXM1OrBDo65TknnI
	ovW003eex8NQqhw3By9QYQljIo=; b=KHUimw45EJtoFWOOjNmO3ld7qwypBESwp
	KniZAsA0S5GO5zO8nMp77s73bbKGM+W99SiyVMWqlJZOmbG4Lu9Q3HQ9nRKBfq3D
	veWGwvL5g9rxLPzG/m2ARB25FjD9Y8CFbhUcYNCO0wJWlH67JOZnTvsFOzSU0Qf1
	xWTholAYKsUijMeTqyC3RA7XvwdbA4tbA9y0ACa74r4BZLs62aZGsDJyUycbJBVy
	ALCmd5ye/r2/GEUvKmkzNl8tE76+NyNZEtcIXZd7vlHF3VBSKTxrfRxBcWKWJUDr
	vd43MaprjJO/HkCJvnY8THXP5uwKGKSLpUOX1CNuWgFkRL/dcIBEA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2hn1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GudO6015818;
	Sat, 8 Aug 2026 17:07:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4km4m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678H7O0g12714652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 17:07:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A478C58050;
	Sat,  8 Aug 2026 17:07:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E39E458045;
	Sat,  8 Aug 2026 17:07:22 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.94.189])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 17:07:22 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 5/5] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
Date: Sat,  8 Aug 2026 13:07:12 -0400
Message-ID: <20260808170712.839066-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808170712.839066-1-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a77624e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fkyveIzhjB74ZASU3MYA:9
X-Proofpoint-GUID: EGHw3iLd-9i4O3AWSkvnyK1oUH5IsNMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX+KPEJNcR7436
 kbgBwAcZuprtLrlqZ7emCG0T99G32XQ2Su6D7m4sm1+Jn2nT3CrQLCaX3ne4KYMypKR/Ue2EyFb
 N+4Lt7y8zDWrkCIYSl3SV60y1ruH42BNX1GT+faEqpzpzIimnJijuBK1mf1w5z1EHyueUvq0w5c
 VpBbRMnXXvkQ/zP0ZqH56NliHUkId7e0NeSuaQ3XGEkxs4jSzyeKurLjeoVyY+V8V7zmUTMdLbH
 pbeFxlG3wsE81KVaMNN4bl8zqHKMqyrJPnhq/k2Ss6oyVX/xa1yurSeJ58Rmyte+mbwnQs9enpF
 pz6+GyMsotCoRAe52b+et2zf2pmVo8x/tKIn++Zifv1p31q219WeyButV9YA2Wzhpc3JvL2IKEL
 5VU+eOL4lNpGb0fIrs/AaLiCxzU96hDD1SaUNNiEi1oNH1JReM1EJpjPcpwdXTEaBRYDK2aMwAI
 8nJa4YixWz0zX3KMujQ==
X-Proofpoint-ORIG-GUID: EGHw3iLd-9i4O3AWSkvnyK1oUH5IsNMU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfXweiRPntf9bjR
 ogJd+tCXn0nU1OpiBeJD+B/1NIHxF45CwgbqR0OQTH0wzgmrrIlJPbtKXA7OIl+gqWSGSnsbBDS
 7EnkD7veQc8M1HsD9Jw623Oef2k0tjY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080146

The vfio_ap_config_remove function uses the bitmap_andnot function to clear
bits from the matrix_mdev->matrix.adm bitmap (specifies the control domains
assigned to the mdev). This prevents the explicitly unplugged control
domains from being removed the KVM guest. The bitmap_and function is used
instead.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 897518b88c28..9c7257c179a7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2621,9 +2621,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 		do_remove |= bitmap_and(aqrem, aq_remove,
 					  matrix_mdev->matrix.aqm,
 					  AP_DOMAINS);
-		do_remove |= bitmap_andnot(cdrem, cd_remove,
-					     matrix_mdev->matrix.adm,
-					     AP_DOMAINS);
+		do_remove |= bitmap_and(cdrem, cd_remove,
+					matrix_mdev->matrix.adm,
+					AP_DOMAINS);
 
 		if (do_remove)
 			vfio_ap_mdev_hot_unplug_cfg(matrix_mdev, aprem, aqrem,
-- 
2.53.0

