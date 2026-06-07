Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D882D9EED
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849784; cv=none; b=fpub/n8HL2ATJpDvtqz/gPsbtGxbtA9a9Ers/1ysBW95LsCYRVlO/RF38MgAPK2JK3wDth+D2Hlq4LpR26b+cJ1cvS0xXetTn4GHL1zerdike7BJ4s2CS6QZasoRPApDVT0Ezjh16bAZV0vIvsmZ4aD8u+OIViOkCNiWy0FQKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849784; c=relaxed/simple;
	bh=kwErJ/BxgqU6fuT4y9xc3KkVzkkZyfeqDJIbSm9UZHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1oXUCAg/Ba2OZk7qvMWYRoTcOxWmLKzaDZ95UsSKfGfqd1W/x7+f/9Se1vjSmlGjJaGfXwN4ffWdnBLczwIUuiyTAH49y8DZ/tZw7ACMf9Gta8gnL5jkBDXlx5oQTaKIN/0+8B3bAAsmuiEg94RyWJQhMvkKVpazJMd9GKC7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ENpH/ZEM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ENpH/ZEM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657AhYdH1634871
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wQ18PaDRVZA6dHLmf
	4f5VpRNCTufoL5PGIbREboayKQ=; b=ENpH/ZEM9Q+ABUNz55WdwXvSt5cRoq+wh
	CdXEQXHEAm75ra1Wz8YI+W1u1/ChgN2UOlgs+Hy+qx42q3f4SpjCn968uuvdT9u0
	3PtkB7R+lWJEH2xfYIO4Xo5AmkVLcAhA06btKrOSik3rPlx+HNm5PDajF0m9rnea
	jvzvPik444/6C9d7gsI/iKu/2vvsEcmtnMUL09vlOuEMc4c196oumGXDyF2E/tkd
	/5ye0bYYCEq4gCEHuURzUL93aaT9kMmafYG+zPDSULmliE5DLxlO/ppDE6kIpW6Z
	vhY0pCPvWvISKy1DPNUdFJZtI3OJb3A3WmEu0lw8NpwLb3uJdoXLw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95463p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJZwF025187
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgsyp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTbSv52494758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEC8120043;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FA5D2004D;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 1/8] s390/purgatory: Enforce z10 minimum architecture level
Date: Sun,  7 Jun 2026 18:29:30 +0200
Message-ID: <20260607162937.2927356-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260607162937.2927356-1-hca@linux.ibm.com>
References: <20260607162937.2927356-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a259c76 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=foj3guEW7u1rp_cjtnkA:9
X-Proofpoint-ORIG-GUID: q6RBk9QjJOy666ao4axKJ4h5ODEj--cJ
X-Proofpoint-GUID: q6RBk9QjJOy666ao4axKJ4h5ODEj--cJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfXzlVJNznsgD8w
 6jdv18sev4QdH6p2dQzeWBbtwSbKAo83BvQGoAQH7dagU7OvarsWr92iBCuRAZfSsTi6Sb5SSYK
 Y7I+Rsm80MaA8fcOjRTNM7BD0AuLy77p5wUcap8wpSJ+Ce7AzERNispUWKR2YpnTqOaJ22G7zso
 Qn1XeG1fGQpsO6wNcolMQ8iIa6baqy2OcEbI6Yiw4rjxhk4DK7Sk2QemgnPgoPJQaVxd5hML3tQ
 WB7+bopDm5VNTxfNQ3vFC9QWSkEiO9pXKJ04+NcLY/Nty5+wjpqXSwiItj89AM2vzRqXvNjshI5
 U5OWhJnE7n4ew12pgD+tSg7K9RhPcp8y48W4YSdXS+WJTqdmv8BlefeZmmZ/ZUcFbaZO2Gn4Nx4
 UW+QCNwma2BYzZhG6fqJatCLhRpxRkmXGbIsB+ngx4naBGBM/Lw1/tdwvLnxLE9RTb4yWMhtE+l
 A6j6z5b5hvItwT2VhNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070160

The purgatory code is compiled without the -march option. This means the
default architecture level of the compiler is used. This can cause
problems, e.g. if instructions used in inline assemblies are for a higher
architecture level than the default architecture level of the compiler.

Use z10 as minimum architecture level, similar to the boot code, to enforce
a defined architecture level set.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/purgatory/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 95a8ac45b67e..f55764d0c49e 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -13,18 +13,20 @@ CFLAGS_sha256.o := -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+CC_FLAGS_MARCH_MINIMUM := -march=z10
+
 KBUILD_CFLAGS := $(CC_FLAGS_DIALECT) -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS += -D__DISABLE_EXPORTS
+KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
-KBUILD_AFLAGS += -D__DISABLE_EXPORTS
+KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 
 # Since we link purgatory with -r unresolved symbols are not checked, so we
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-- 
2.53.0

