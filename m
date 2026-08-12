Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96F470E85;
	Wed, 12 Aug 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554602; cv=none; b=cuZE7bM8R+lwW6TCtVUQciyhHTJ4HPOsVNwQeTbpEV5VjBlKhfgblW05Zf4kyxryhC12lSp6glg0HjRXEALnNAcK3UR4ZovYx3/Nq27yqZL7jFxUHYi2bvn4vA1g8leXqCjkqiUpmLXDsfWFdpN7dI1E+1nMrYcJXEfO6jqjhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554602; c=relaxed/simple;
	bh=EDCwJV+IvNOFK32sSxnYNd78nS1ko9lbivW41h8Ix9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+WldhPFyS+OTAOQzaI6+SGO9hUkrmIf7zoOJf7vdB/koA6XdWbbAilfo/tAeqiNuXVRI9IvCSKpc8R7d8Uz08gca1sN5bcBYvsp+DzyW/ScKrBrV5DaT8j1bVgq+1llg9JpAQHA/KFVanuIlyAnLYXTSqcVJ0F4fpdHlGMnoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PH0Q5Z+e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PH0Q5Z+e"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1dlD2985352;
	Wed, 12 Aug 2026 17:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fp8CEaAw34Vga6mTt
	owRd3t8SDWSYYHYv/RZc9nbQlg=; b=PH0Q5Z+eT3BDsWXD14Ci1T6a06RQc0WL6
	hOqi6Fs1yt6MIfD/AYvPhVPX01WR6geldaHGLXRvEXHvpXJYHPTZOgJYc8TfDgnS
	RmLmae+QP+ETyAqqIXPn47AQDek5MDXAn9csYnA+8Qtz0PkNFwTnrgJse0+VLtrE
	hFvvI2xde6bfK5/n8lBOl4z6CdgPlUq02E3OZnWDu6jDjWNlRnQpdXXMklgSvLrT
	r267FCFpuU1yHCq4H+/OIKQNSZqzad16HP6GUywJk0/XIhkkhpHSE1/JXQbtqJa4
	+BzusJm5RffHXddxsr4OPODHoI86P4RLIjlqpp1Vor1AvnuUOPkmw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23v6w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGutOe006549;
	Wed, 12 Aug 2026 17:09:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6w11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH9r8x1704464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C88A58060;
	Wed, 12 Aug 2026 17:09:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 234D358055;
	Wed, 12 Aug 2026 17:09:52 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:52 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 5/9] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
Date: Wed, 12 Aug 2026 13:09:41 -0400
Message-ID: <20260812170945.738351-6-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7ca8e3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fkyveIzhjB74ZASU3MYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXxzaOjLs+AZBV
 w/gf2KhlV6QjlWZ+MDOtSiirgMBsPPj5Pn+rRG4fd1aINbkdpdEkTBGA9ri2pjstVw06OPBN1mQ
 orfrFkfeAo7aO5FVSszEglpHRi1TDUSZrED5m+6qFVld6S53u8Z9Z9F0EV1thIQjAeip7clkro3
 SaflWJwsnSboY4UclIE8EGOzZpRltq2YYGat2V5UgdAJDMTv20h2rI1C0+DIXAt7cGArhhE9KWG
 r8j3xoBhlPQ4uUekuW7HxZdoCDbsLHoiuLylu9gp9cO+fFq8NquTmQ7xAr83C4ay1rCyaUmqzyw
 0fEnAKa0BbFoUEOhe1uTgnFNCsOECXnDYVabUxI6oe5HlbTirjT5pDOW7RTDM3le4mP1C3EXXaG
 qwjPR6g0AkHX7RZJNUoJvDgQRxGkFdnGuMBK5nSl5pEt37YZcGvKe/R2nEBJ1sKcp7708fMjsIb
 K5Wq3UNXe+vI0c8KeJw==
X-Proofpoint-ORIG-GUID: 8ko3oj4cEiOTPAe0elS9fyd1hxQVYkLm
X-Proofpoint-GUID: 8ko3oj4cEiOTPAe0elS9fyd1hxQVYkLm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX/Wml1/74qxex
 mZ2coOI9mzE01TlbsbOBTbgb/TLsgYrXfFKApTRgwO5bGZd3CUI7RU63OghYfMYxMvZTixRMuBN
 VkTtBHPLazOpPbaixMqk1yNUIUvSCT8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138

The vfio_ap_config_remove function uses the bitmap_andnot function to clear
bits from the matrix_mdev->matrix.adm bitmap (specifies the control domains
assigned to the mdev). This prevents the explicitly unplugged control
domains from being removed the KVM guest. The bitmap_and function is used
instead.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 21c502598f8c..0f3537aadea8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2636,9 +2636,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
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

