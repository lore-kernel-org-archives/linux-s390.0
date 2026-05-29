Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7A3FCB05;
	Fri, 29 May 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070196; cv=none; b=Ed0LGfF/bnIoZtbApAMkpeFuKGDmI/DZOXAvIBXsRWoLZ+QOPUeSWnZ9tIMn1z0JD0wBgI7ZHFJ9EiYlyua743RG5t8jxMntCvyfye9E+ewC6XNDXOTvL0xX9f1k6Zahs5kSJQVnHkk39inalSmeu6/Au1P138sKVy1sD0KCAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070196; c=relaxed/simple;
	bh=08dDH/WQ5nCpUwhSaD4IpI4Ds/DHX915A/9pOS+YeJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCMm69/Un0dvaO6KQZ14ahmH/2/qzih64oXA28VDLHz0KEUbD72WHfMVsx1GFdwG7ivEvq3YYxUnPqGMnmJSD0Km+RH1/PWNzDiE7GXAH7TDED1PgCrRvtNadObZv99n+cerkTFkXjGk4vXg7hLcLVIHXQDKNBnK2+DEVkd+6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mN6mvRaV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mN6mvRaV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF3exw2418298;
	Fri, 29 May 2026 15:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wFi3vpS98Cj8L/89G
	xByeqkjSs7xfkPP7T3TglTvHvU=; b=mN6mvRaV/WU2ABvtdg9qy1lVex6VQvKCF
	UctlLCEnILwDfr1GyNn9b/7miC5mIaVJWbeeT7kzGk3rtCU54290uUMrePWDfeOl
	yIdE2YkzZjPqh4/4OmVRHhN+9lMiNofSrH1mRIuMqXVVYhS3PB+rzSnuvNG26v3q
	KRwjrzRaZhZctmnFO8BElxqclp7mRQDcwLYLDCssE9saAW5M4wgl+Y23EChTqdlS
	AtXGUXPjl14KLg1sJ+a2+22CoTJrUTiZOdNLr2XCMuA1VpStuqZUVfyKRoeo5cHF
	8vBOBw5JRauwpSBu4fv8g1whff7kZEKk/Z0gP/t45laIom4xCUSFQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884vkrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs5OA003161;
	Fri, 29 May 2026 15:56:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgmae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu9U450594192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1348820040;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA18D2004D;
	Fri, 29 May 2026 15:56:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:08 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 18/26] arm64: Extract cache definitions
Date: Fri, 29 May 2026 17:55:51 +0200
Message-ID: <20260529155601.2927240-19-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b721 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pRZW_VWv9im2awHLU-wA:9
X-Proofpoint-ORIG-GUID: slVjF5f-oq9tzH_qacJlnFctQDu0_ACn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX8oPtDgaMF3m/
 MK1rxSS24KimAM7XsXvGSzWrJUIQDlWN7vlqTJKBpq4YLq8slBqI21QltNLBxqL6sfhAYWDMkmn
 jX/TbdHyjz1bfKFB6mWCYOCXysOCkf0GM+kfz9F1UvX6lZPWlP0kesce3iV3o9EA5dZ2ICfO9PF
 lmHWj9khK3BOvHHKKJrens/l+KFqet1gMMLO0NKL9pnbMKOix2jizeCl48YESDv/pHUhCw/+C6L
 dq++JTdd8ckUxpzBagTClP5VP/LHq+0RMIOhsvyiWr4u6RU2v+9aqEqgewnrpXvI/NFyN3uI8r1
 TNBGtV1n63cM5DGg0XHURVH9I1jma47Yz3PNyuk7Xu8xSp2Au66orrd9iYGPMwIL1WKM1ONyU3/
 h/nmLRaakTdUQNPh63BJBCUD0n342it//rYPKiJaAaia1dEfoy/EVQkP7Ereh3zkaVxf28ToZgQ
 gFynb9FophKzvpV/E3w==
X-Proofpoint-GUID: slVjF5f-oq9tzH_qacJlnFctQDu0_ACn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Move CPU type definitions from arch/arm64/include/asm/cache.h.h to
include/arch/arm64/asm/cache-defs.h to prepare sharing with other
architectures. No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/cache.h      | 19 ++-----------------
 include/arch/arm64/asm/cache-defs.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)
 create mode 100644 include/arch/arm64/asm/cache-defs.h

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 10a7ffadee3d..0f67fe470c29 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -5,26 +5,11 @@
 #ifndef __ASM_CACHE_H
 #define __ASM_CACHE_H
 
+#include <asm/cache-defs.h>
+
 #define L1_CACHE_SHIFT		(6)
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-#define CLIDR_LOUU_SHIFT	27
-#define CLIDR_LOC_SHIFT		24
-#define CLIDR_LOUIS_SHIFT	21
-
-#define CLIDR_LOUU(clidr)	(((clidr) >> CLIDR_LOUU_SHIFT) & 0x7)
-#define CLIDR_LOC(clidr)	(((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
-#define CLIDR_LOUIS(clidr)	(((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
-
-/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
-#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
-#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
-#define CLIDR_CTYPE(clidr, level)	\
-	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
-
-/* Ttypen, bits [2(n - 1) + 34 : 2(n - 1) + 33], for n = 1 to 7 */
-#define CLIDR_TTYPE_SHIFT(level)	(2 * ((level) - 1) + CLIDR_EL1_Ttypen_SHIFT)
-
 /*
  * Memory returned by kmalloc() may be used for DMA, so we must make
  * sure that all such allocations are cache aligned. Otherwise,
diff --git a/include/arch/arm64/asm/cache-defs.h b/include/arch/arm64/asm/cache-defs.h
new file mode 100644
index 000000000000..bb0ab69a9cd6
--- /dev/null
+++ b/include/arch/arm64/asm/cache-defs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_CACHE_DEFS_H
+#define __ASM_CACHE_DEFS_H
+
+#define CLIDR_LOUU_SHIFT	27
+#define CLIDR_LOC_SHIFT		24
+#define CLIDR_LOUIS_SHIFT	21
+
+#define CLIDR_LOUU(clidr)	(((clidr) >> CLIDR_LOUU_SHIFT) & 0x7)
+#define CLIDR_LOC(clidr)	(((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
+#define CLIDR_LOUIS(clidr)	(((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
+
+/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
+#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
+#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
+#define CLIDR_CTYPE(clidr, level)	\
+	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
+
+/* Ttypen, bits [2(n - 1) + 34 : 2(n - 1) + 33], for n = 1 to 7 */
+#define CLIDR_TTYPE_SHIFT(level)	(2 * ((level) - 1) + CLIDR_EL1_Ttypen_SHIFT)
+
+#endif /* __ASM_CACHE_DEFS_H */
-- 
2.53.0

