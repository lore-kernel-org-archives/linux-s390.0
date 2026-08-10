Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BF282F06;
	Mon, 10 Aug 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389800; cv=none; b=fImia3xYwYbSqjpyauYDYQ/BudE4o7Pl3Fi9Gl1kd8D5bN7+uxDjnD3XsC8ZBtbTPI1heKPQklQsdIOBXTQ2MMQ5ykob9yKPIKYVqOzudOZJWdyYjxUHfeD8B4+RoOXVhN3ZfGKgcooC9bXBZqpgMdY+/ztAtzEi1ecJ2ZiQSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389800; c=relaxed/simple;
	bh=S+0Py54QPwwjxmTjKRphpYRFREkV9K/0Uu60dj0hMsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzSdfjrVKfA+GqbnXorp//VM/lCW0MIndEzHZWDXvms7KKc0pcpJzvGNQKMpzjsyZ92lCQXFIU8pwSEcSTZi/s5lari4Yx3RFTNJ63Lr7c6n4aPlFHFhtB7+pTVnb1qCXnp6ppuyjNQxW3vqivIVLqEeUs0Aj0y/7kq6lSNiIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hvwsBDqI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hvwsBDqI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2AR42432696;
	Mon, 10 Aug 2026 19:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=orXM1OrBDo65TknnI
	ovW003eex8NQqhw3By9QYQljIo=; b=hvwsBDqIi/YW/H/Z4koxACBdRQOPHfmEZ
	ucgZ+3a9F8ADgmigoG4/LmK7wqn7Lq+g1x/9Ruy2+vHPHSqiuE9RIPTz3rN24PhQ
	44ZWOghMiVQs2N2ZdFYmNq20S+du619cpCQqvzOZdTwhFsdwup0eDC+EhKx7pyY7
	2kJjbKu+svZSXq2msGjUpNsUQ7ln1ah3h+5zCnnb23eb1c8OSMtoILirEK4iE6oj
	FZmqAH1zC1SglNj3fkr+O8hUc+d+LCzk1Qf447lcngIBJnef8+MezqdUFwwIlicq
	CXkC/gTwtjajTrdPTvQqpYDkpP9xf9gB4t56aFOrjQjbJA4WpeISg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq99q91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBdBI002986;
	Mon, 10 Aug 2026 19:23:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxwwp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJN4Tr25428518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:23:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD5A58058;
	Mon, 10 Aug 2026 19:23:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBC6458057;
	Mon, 10 Aug 2026 19:23:03 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:23:03 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 5/8] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
Date: Mon, 10 Aug 2026 15:22:54 -0400
Message-ID: <20260810192257.1208410-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NHdc7HLIyVUjDW5AjzFQMSoJrngpUGt0
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a251a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fkyveIzhjB74ZASU3MYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX/RGKmYxdwaHZ
 3QiMly0Hcdy8gNqRIxx5nAs+c+7WqkqGYSl5ENyD7NvBpbygaLPyEz2hiO95wZTSpTIgJ5FjRxG
 +nHHUiJKcUH3Ir9xJuUsqooWR/dJ7aPKLYpCXmNAAj1bcDcsJIUyHpSwUTVXeCEa3s30A2XItPu
 WoKPFmERKKDGC0Cl7TERM9M7d0m78QYyaztBQNxescHnJovMBHs8YSPYnyuECrOrzCqL7E+kI0m
 lWrmwk79uAPC0fegYa8/k8ATd6NZn3RzMzIacQFd6MxDo+hsTmVglECH5BrXSih7mzuA0A90I4I
 eeYtgXs6LTSNgJ2jSvCkSCfnpkEfiCDzQvQV6NKMu/u42iidhWXLH2HcABqsvvrs+v8FjlE2kRr
 EcxEcdepd9t4o6BYNm+/R3luBzOUDxEG95W1Ew7R+K5YRSKK122x2R8ad7I6W/ghUro/rlPWo4j
 rAuT4kS3c8z0ANgjMXg==
X-Proofpoint-ORIG-GUID: NHdc7HLIyVUjDW5AjzFQMSoJrngpUGt0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX/Nicgw37BB4D
 4qifrhYXvIk885Ix6IyUmXeHsX6R5Zhj7hReZjvu/tRE0rultwS69IyZDwjifMSPJdvKg6VNiEX
 wvB8jGaSN2J40DQfzvVPzv8WtUaIPoE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

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

