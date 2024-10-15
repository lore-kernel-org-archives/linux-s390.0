Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFB1D9A7B;
	Tue, 15 Oct 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982065; cv=none; b=FjYdjeI2Pdnv03oO+k3aVKXGu0CwsNKdIAoVxXAo5ZjhQ/dpnqQUXvlkFaoP23VDDVCyIdI5xf6ljgPwDxH5ZjE9/OVM0rPqOp6mfgGvldTG/E8ebzsEQpn5d6cZ/NymYfnV5bbpgKSDXxeljwjvpyWlF+e2k6F+tXMP60UIQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982065; c=relaxed/simple;
	bh=iguEBDl8q+O3eYgeqHRt+q0bauQl/22Of+lo5GWS9OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqlYcSAV+Ujgu+qhSctxdCWsrdt9kD8/Dpbd8zyM0O4TiPxazJ0OVaXFxEpVFid5spbHVzLf8C0enXR6s7d94L7fgckWiZinBEEFoa/xtlvg1LT5Sgru6iHx7ZSeVppCBnsvCdpt3Tf/hlMTf7IkyyKQ0q4w4daOEoJf16OPSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kk4HHBPv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kk4HHBPv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7nhVx029174;
	Tue, 15 Oct 2024 08:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E+k3UV0GeMDRIFZTg
	pu8BxXs0tZH4a0UJwOSzoCuvas=; b=Kk4HHBPvBIqJeGnSi4ABcZt4J2fJeHhFa
	hBl5wp/wpx+xq+m82kE4U59ZMinJV8/lIDlUqj5DnzV7XNgX+x1Z+HCTjXs8MHSX
	+OsWxgrJocYk9hQvylOZCiunRpkHFrX3H691HxlKmGrZN+A/7G6khwcXfQIH1+Ru
	9NN95r0q9OtUGhRdW77EAmOGGPKmTpBedNJuf0axC+qfK71IGMPpGAerKF9YUvjE
	+haihVbrQr9MMnnNPRrUZUOpHkzEDm8Bsu/P17MIfuLjpLm8dSf88discdRhVpA8
	MxDGmre5TuVaAFQ0uEkJP3NYoRMn6WUEQnUqLtsLt1HVMMc4rlpCA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mbmr9g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8FLmg007025;
	Tue, 15 Oct 2024 08:47:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk2qft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8lYdu54133182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:47:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BCBE20043;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C7FB20040;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 30AD4E0125; Tue, 15 Oct 2024 10:47:34 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] s390/time: Add clocksource id to TOD clock
Date: Tue, 15 Oct 2024 10:47:23 +0200
Message-ID: <20241015084728.1833876-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015084728.1833876-1-svens@linux.ibm.com>
References: <20241015084728.1833876-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1e0d43_04NRlvrcE-LkLcap3GUjk3t1Q
X-Proofpoint-ORIG-GUID: 1e0d43_04NRlvrcE-LkLcap3GUjk3t1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=962 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

To allow specifying the clock source in the upcoming PtP driver,
add a clocksource ID to the s390 TOD clock.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/kernel/time.c         | 1 +
 include/linux/clocksource_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b713effe0579..4214901c3ab0 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -255,6 +255,7 @@ static struct clocksource clocksource_tod = {
 	.shift		= 24,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.vdso_clock_mode = VDSO_CLOCKMODE_TOD,
+	.id		= CSID_S390_TOD,
 };
 
 struct clocksource * __init clocksource_default_clock(void)
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index 2bb4d8c2f1b0..c4ef4ae2eded 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -6,6 +6,7 @@
 enum clocksource_ids {
 	CSID_GENERIC		= 0,
 	CSID_ARM_ARCH_COUNTER,
+	CSID_S390_TOD,
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
 	CSID_X86_KVM_CLK,
-- 
2.43.0

