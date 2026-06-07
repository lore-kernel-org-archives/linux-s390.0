Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3092F8EA1
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849785; cv=none; b=k236TsAu7PHGubl8TY12Ykpo5V5tUjJt5pa1ijLtWGGy/K+N3VYp8r6MnUpQzaW28D+dXPA4Do3OFppuyj4fFiWs3h1UJnEQb4qIEZe8dfzjqZjnioEoo6zwm7vCHX1S4zWBMO7suRZ7b26/kCdnp/j5C9GrEgzJWKEN7lnZwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849785; c=relaxed/simple;
	bh=fqOJTLlpZq4XTliveg3asHJ2aT4z58honGDAcKKS4h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrXtPyMRX11rbAeSpKGspyF470OlmlBR+aD0SVz3D0kcLVmj5A/pO3nLEIGBxGIKYWJqmEzsUjkBDQfZwAXYwzRbj6fT9+OZh4LAqByYmQ4PKolUOvDP2kvTXaUTTWcmAAIkWMfAYarmI/3mBBp9g6Cm/8okakMgxIZ0fsPGcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cZ7jPiub; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cZ7jPiub"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6575lpLC2521613
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WW5dMlnsgLMLdiGUX
	et8xsEybymmTcFpB0SUmxoKXQo=; b=cZ7jPiub2VYTG4PLg/9ViU5+frHYhXuy7
	yql9bAS/Xq3Y1kkIkBCLZ725RWOT8wLpX0alqG6IFPp3XOzdguMrzDj7Gqz3PbPl
	jJrAG+nZW06gZ0aSY34NdRQj9SjzTHkrkmuGGOAsXWfFB4kHo5koC5d88ZVpMQyy
	9ykOPtolZ6R3eHIQiAsN5pVH4TxNztWShyt0W/s5PfsXvzEK9ObIJqw/eC+ahY0h
	70Kg5vScGWL/TVq5WnLJMxIri/YsyA87Q/ouZSb2RO5SLVM1wqAsGsigG33QtL+V
	YjyGxHwJLe/dmPuSFLBGKW1Kt8W48HZS6gLXeVP9f6BdYmbFFyhcw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhmch5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJlDQ012523
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vt5an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTcSc48628202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6DF20040;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0C902004D;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 8/8] s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C
Date: Sun,  7 Jun 2026 18:29:37 +0200
Message-ID: <20260607162937.2927356-9-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfX24jboVsTh3fs
 qLd7VyWYAJeTUNkeOePquATSFmwrOmHnouBK9lX5K1A4t8qOVE7FGA3qhft1WhPiCk1rfjx7dSa
 eXu3+IjTjHIPAHSM+1zZTwwUmFaHbLneHOPNdz9eOh1nA3JCbCP4tZOUQ9wZ118BPYS5gAuY9ET
 zDy0+qdzpf/s0NLObyUWSpGymk6MJ8qeeRwTq9226XvXNSKQu7eHpvuXJ7mkTBpzlEfmT3zqDTf
 ddWtptbPbFc98JA9csfAESrwCGydB/RGEInbsSTXD6g53K3jS2TfkaswJgzrTTHtu86E2uQ5AJj
 2hZBSp9dtuxU++WMUGJk8KiSCJ68OU0yITvw4FOBp18/pohuW6MQjJ6rgWcEYcjU9kgQFohOB2W
 ufvdC+f8uXn3oo+J++xdI7TuSbhEgfWwj5eEssPNg83xVFuFo7b5VmkTes/N+nhI6T9YsSKLioJ
 Tj5ro9qPmkfip/nCBZA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a259c77 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=kAdJr_umsJ99syYC5_AA:9
X-Proofpoint-ORIG-GUID: tOSHTzGY_J80W7mt7VIQBt5ra1CnZZsc
X-Proofpoint-GUID: tOSHTzGY_J80W7mt7VIQBt5ra1CnZZsc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070160

There is no reason to have __ashlti3(), __ashrti3(), and __lshrti3()
implemented in C. Convert them all to C, which allows the compiler to
optimize the code if newer instructions allow that.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/asm-prototypes.h |  4 --
 arch/s390/lib/tishift.S                | 63 -------------------------
 arch/s390/lib/tishift.c                | 64 ++++++++++++++++++++++++++
 arch/s390/lib/tishift.h                |  8 ++++
 4 files changed, 72 insertions(+), 67 deletions(-)
 delete mode 100644 arch/s390/lib/tishift.S
 create mode 100644 arch/s390/lib/tishift.c
 create mode 100644 arch/s390/lib/tishift.h

diff --git a/arch/s390/include/asm/asm-prototypes.h b/arch/s390/include/asm/asm-prototypes.h
index 7bd1801cf241..d4da4436d02b 100644
--- a/arch/s390/include/asm/asm-prototypes.h
+++ b/arch/s390/include/asm/asm-prototypes.h
@@ -8,8 +8,4 @@
 #include <asm/nospec-branch.h>
 #include <asm-generic/asm-prototypes.h>
 
-__int128_t __ashlti3(__int128_t a, int b);
-__int128_t __ashrti3(__int128_t a, int b);
-__int128_t __lshrti3(__int128_t a, int b);
-
 #endif /* _ASM_S390_PROTOTYPES_H */
diff --git a/arch/s390/lib/tishift.S b/arch/s390/lib/tishift.S
deleted file mode 100644
index 96214f51f49b..000000000000
--- a/arch/s390/lib/tishift.S
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#include <linux/export.h>
-#include <linux/linkage.h>
-#include <asm/nospec-insn.h>
-
-	.section .noinstr.text, "ax"
-
-	GEN_BR_THUNK %r14
-
-SYM_FUNC_START(__ashlti3)
-	lmg	%r0,%r1,0(%r3)
-	cije	%r4,0,1f
-	lhi	%r3,64
-	sr	%r3,%r4
-	jnh	0f
-	srlg	%r3,%r1,0(%r3)
-	sllg	%r0,%r0,0(%r4)
-	sllg	%r1,%r1,0(%r4)
-	ogr	%r0,%r3
-	j	1f
-0:	sllg	%r0,%r1,-64(%r4)
-	lghi	%r1,0
-1:	stmg	%r0,%r1,0(%r2)
-	BR_EX	%r14
-SYM_FUNC_END(__ashlti3)
-EXPORT_SYMBOL(__ashlti3)
-
-SYM_FUNC_START(__ashrti3)
-	lmg	%r0,%r1,0(%r3)
-	cije	%r4,0,1f
-	lhi	%r3,64
-	sr	%r3,%r4
-	jnh	0f
-	sllg	%r3,%r0,0(%r3)
-	srlg	%r1,%r1,0(%r4)
-	srag	%r0,%r0,0(%r4)
-	ogr	%r1,%r3
-	j	1f
-0:	srag	%r1,%r0,-64(%r4)
-	srag	%r0,%r0,63
-1:	stmg	%r0,%r1,0(%r2)
-	BR_EX	%r14
-SYM_FUNC_END(__ashrti3)
-EXPORT_SYMBOL(__ashrti3)
-
-SYM_FUNC_START(__lshrti3)
-	lmg	%r0,%r1,0(%r3)
-	cije	%r4,0,1f
-	lhi	%r3,64
-	sr	%r3,%r4
-	jnh	0f
-	sllg	%r3,%r0,0(%r3)
-	srlg	%r1,%r1,0(%r4)
-	srlg	%r0,%r0,0(%r4)
-	ogr	%r1,%r3
-	j	1f
-0:	srlg	%r1,%r0,-64(%r4)
-	lghi	%r0,0
-1:	stmg	%r0,%r1,0(%r2)
-	BR_EX	%r14
-SYM_FUNC_END(__lshrti3)
-EXPORT_SYMBOL(__lshrti3)
diff --git a/arch/s390/lib/tishift.c b/arch/s390/lib/tishift.c
new file mode 100644
index 000000000000..668819531459
--- /dev/null
+++ b/arch/s390/lib/tishift.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/types.h>
+#include "tishift.h"
+
+union ti {
+	__int128_t val;
+	struct {
+		u64 high;
+		u64 low;
+	};
+};
+
+__int128_t __ashlti3(__int128_t a, int shift)
+{
+	union ti ti = { .val = a };
+
+	if (!shift)
+		return ti.val;
+	if (shift < 64) {
+		ti.high = (ti.high << shift) | (ti.low >> (64 - shift));
+		ti.low = ti.low << shift;
+	} else {
+		ti.high = ti.low << (shift - 64);
+		ti.low = 0;
+	}
+	return ti.val;
+}
+EXPORT_SYMBOL(__ashlti3);
+
+__int128_t __ashrti3(__int128_t a, int shift)
+{
+	union ti ti = { .val = a };
+
+	if (!shift)
+		return ti.val;
+	if (shift < 64) {
+		ti.low = (ti.low >> shift) | (ti.high << (64 - shift));
+		ti.high = (int64_t)ti.high >> shift;
+	} else {
+		ti.low = (int64_t)ti.high >> (shift - 64);
+		ti.high = (int64_t)ti.high >> 63;
+	}
+	return ti.val;
+}
+EXPORT_SYMBOL(__ashrti3);
+
+__int128_t __lshrti3(__int128_t a, int shift)
+{
+	union ti ti = { .val = a };
+
+	if (!shift)
+		return ti.val;
+	if (shift < 64) {
+		ti.low = (ti.low >> shift) | (ti.high << (64 - shift));
+		ti.high = ti.high >> shift;
+	} else {
+		ti.low = ti.high >> (shift - 64);
+		ti.high = 0;
+	}
+	return ti.val;
+}
+EXPORT_SYMBOL(__lshrti3);
diff --git a/arch/s390/lib/tishift.h b/arch/s390/lib/tishift.h
new file mode 100644
index 000000000000..c93327bc74f6
--- /dev/null
+++ b/arch/s390/lib/tishift.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _S390_LIB_TISHIFT_H
+
+__int128_t __ashlti3(__int128_t a, int b);
+__int128_t __ashrti3(__int128_t a, int b);
+__int128_t __lshrti3(__int128_t a, int b);
+
+#endif /* _S390_LIB_TISHIFT_H */
-- 
2.53.0

