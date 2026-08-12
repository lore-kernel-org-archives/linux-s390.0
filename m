Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2D38238F;
	Wed, 12 Aug 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554598; cv=none; b=Nsoh7AOeEzmdyKtzTGoDbADbPrvVimHAWKQvLOZSyBVO9lkj6oG5UqYU7HJ/VkvZ9tkMupz87r979/57Sv4/r6useGsGzd5P1KBsnB/MNmVmZwekUgxZcl5VKNa3dNU7zS+XclzI2FZlYY8uzV0MY7vSH3q6hPjabHcvNgwkkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554598; c=relaxed/simple;
	bh=hAk5VFZTgMbDNPLe+AA+zMf0YOhx4PJoLsGEtIiKUxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoIg7WzeAoLTEJKVNYry6/fdcYJB89ueRqqL8xjuLyh+LhF1MyKDma3YtoZXAzRdVpwTeasQruYTtnLc/iyQl1Ts0m/zppzizAGCm1jS13xBDt23DZ0HMZ3n27RdufxTQ/dHAJdvuILVQZt8XLUfVJ8bir36TwHT+gADRQ2Ztd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OrD+e9Hz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OrD+e9Hz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1c692217969;
	Wed, 12 Aug 2026 17:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+1ReYvhFvHs/C9ZAt
	kBPmRv/N1oXc4R/xDf8I9N/tjo=; b=OrD+e9HzAWcoidOsIUQBPIpOGJenSTe5V
	qiNOBTgZnBhhdH+ZV5xDaMFNWZ5FR5whAuER0QIaXjEbWFe2vA5kqaYbRQdkROyI
	aD9oDSznWM/fLbstx0yUBjmYxXPEAzSi1Jr9CIy1b03DL8Usjic4g3lw2DTOANtE
	WUauHh7rjmvXcHky1vVgPF38o0qV3AvT/X5vb8UdQLrRvyjrkq5O4K9/bhZbhSI9
	5HbfVGq4SkdL3n99/OZkgjuUanh8i0/HnsJoDivnCqjvGJ5QHRY102I/L2DZzyQe
	7phhxh2GURt67CuenSrmNSfxY5Uc18p3x06sEjCqmGtFB8I5oD2LA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk03p23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGuoJG030559;
	Wed, 12 Aug 2026 17:09:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq78qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH9muZ62849282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89A0A5805E;
	Wed, 12 Aug 2026 17:09:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 791B458055;
	Wed, 12 Aug 2026 17:09:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:47 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 1/9] s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
Date: Wed, 12 Aug 2026 13:09:37 -0400
Message-ID: <20260812170945.738351-2-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX7xy8qKebL+QG
 HdsdOmzu+QeARkpp6Yc0MxM0Ecx6hm5oLpIMrmuEO2kiy0qesSEm2wDFufz3ITVvbqQ8dVgq7Ci
 eSQGX2E7mnoJidz2zbZUgKc6SB2bWg/nHvL83jry8wqVfILMeqqDifGHnEuZFYwuu/u7SonjT0R
 NmElGQaHXTOSPdIIdupslVkbPTPcjX9daPDv8SXIsUgkmEWXvMnfpcw6/ciqEOYO66BVKeQJlp4
 Zf6BZTWRcGGcFHPifNdqu3R5bw7SXRIbjX96cbV2bfpEeXAXc+AiN1LVeM864EjV3L14HPORT41
 fePqfiPeDT1BVpSwFlQuxBl4dmRt7UtIi9Vq6tYdWwfR2oY6FxaXoz+lAgeDEYZnveWQRul+Np4
 mZzohXsiodM653qXN8ob8fo9uJW3gtrhq164o3g3OIv7BbmYM2ubPIqTk58sXftXu12ucrcG4Br
 1ccZK1D2VzLkbrWZtgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX8/hl5pzNipOG
 dVsTpoiyiImZQaM36PiO54J4JlMPSZFV8IMUwoluiHDdR+57Gz7RyhOfR7zdISn2LA36n5STP/O
 umrrmoRwvDvWQY9JPyxmqA5UBngdGKI=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7ca8de cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dlTjfeu_wqJGreSUTgMA:9
X-Proofpoint-GUID: dZ0AZPyxHHBTl8jfGVxxJhtIM0bDC1jT
X-Proofpoint-ORIG-GUID: dZ0AZPyxHHBTl8jfGVxxJhtIM0bDC1jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138

The do_remove flag in vfio_ap_mdev_cfg_remove() is initialised to zero
before the loop that iterates over the list of matrix mdevs, but is
never reset at the start of each iteration. Since do_remove is
OR-accumulated across iterations, a positive result from one mdev
carries over to subsequent mdevs.

The fix is to set the do_remove flag with the first call to bitmap_and;
for example: do_remove = bitmap_an rather than do_remove |= bitmap_and.

Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..845c86ba8bc3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2603,15 +2603,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	DECLARE_BITMAP(aprem, AP_DEVICES);
 	DECLARE_BITMAP(aqrem, AP_DOMAINS);
 	DECLARE_BITMAP(cdrem, AP_DOMAINS);
-	int do_remove = 0;
+	int do_remove;
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		mutex_lock(&matrix_mdev->kvm->lock);
 		mutex_lock(&matrix_dev->mdevs_lock);
 
-		do_remove |= bitmap_and(aprem, ap_remove,
-					  matrix_mdev->matrix.apm,
-					  AP_DEVICES);
+		do_remove = bitmap_and(aprem, ap_remove,
+				       matrix_mdev->matrix.apm,
+				       AP_DEVICES);
 		do_remove |= bitmap_and(aqrem, aq_remove,
 					  matrix_mdev->matrix.aqm,
 					  AP_DOMAINS);
-- 
2.53.0

