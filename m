Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8A3F4DE6
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001232; cv=none; b=aVCHNawUi5hH9NFVjVNV0eQVg61s2JZq3N28TNHaSF9fBcz2QBScDDektUGQ9Ob3PJGxa4miP4hXhBSKuhNl43arIqgbYRfWs6wcPYDwyl30qbsI3C3Aym3eaCXToWGv0y87c/bJ0vpDDEfa2MGcTY0Uf6eIvrPnrpHhSwT9TCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001232; c=relaxed/simple;
	bh=AbyR1cv5Qc6cIJRNnSrhFShKy8v7FKIzFdSm2dbPED8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV+E9r9Rk8ITDL3jZ+N2KjQA2nhp8O0rcNPdVZQWTV7aherqvVewmYuuwJFgJ4eRHpd/Q/Srb5iyyzgk03dwgdmroYHcbtr86SL8gEDO77DhlMZSMCfiZb5jmcVC9IU8c9eBxlwEXkiNwafFaHn72fwUD7XIFAXt9p13aiNVegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E0vMEN2S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E0vMEN2S"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65936S8f3886183
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s+vFWLnSW5qr6j+UH
	UhVK2JgcVCzQjwFvRorY9UzvfA=; b=E0vMEN2SN5Mc4zepOuCDUe2UG1s3dejr9
	FzNQ2ErhSItOaStCZU0AOJhyxvlVC9xvIvDBBN7PIJi3qZXrp33yrDRFPEbJD0n0
	GPLs9smDo4fSBLP9XPyb7YcSa4OD7prcxOf1UQNLn9yToVVwFyMsz98WGWdmRxmk
	0F8DUHA7jaz25fmIKvIXkhyZBrNI9HriXNWMBPHlrCDsu+qop5+88ppY9jCWh7fF
	Tj0XlBsxIYbx8hF2c5DiONflzG3N238ZESsbr1CY0LN+GPKv4i6zfHuF7Jc9qkfM
	kgmqchN8ZE+Ov9ItGzChsURuxw3Wi8QiT9knuVk5izrExYj0pgZhA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23upnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJbRH005403
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych1fd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXjUt24052002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A0B920040;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C5AB2004E;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 9/9] s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C
Date: Tue,  9 Jun 2026 12:33:43 +0200
Message-ID: <20260609103343.107325-10-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609103343.107325-1-hca@linux.ibm.com>
References: <20260609103343.107325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a27ec0e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=D3IvRudVPZkSyVNiNrMA:9
X-Proofpoint-ORIG-GUID: De-fU9M7c7aD3go2K2uJ7-qFoMUVaZpG
X-Proofpoint-GUID: De-fU9M7c7aD3go2K2uJ7-qFoMUVaZpG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX6OU2ToO2+5KI
 e339pAJ9qhOnHMwAk13ycMJ9ENHiVOLQudPlwZJPY9aS3k9btupytdNNcXV/jx4kHLByhQnLCBf
 j2R+Nwx+0qCnp9u8eCXT6HZXNJzHXelP5btqxQpbTZZWsPfVEQFEdpkyA5chOhzYoVtXMCVYBSf
 qGqcIuuG6veybYAovpLClVzgC/vy2GuNpjr+kFofH5xmxgzGBwbtKf4krooKbjVazQAFb5OiMdN
 vhrj6Mk+d/8N3GhR/d8B/zyyyCBsSDQO/l16ZOxh+Oq+o3hqi9WMNrj2kKq+QfCiAzY9+x3pSqo
 koChXNgKNQ6oBD8SkHdByKyGP0eG/0MSxQdgKwaSrMhTJI/z+xQ8ZOu6RdMNXrmXHXgG4eZL/Vk
 lUVaT+gon78DFIvQS9Muqeh1R+GW5Ukmf5OZv23thIP4t89Kf/20kdDHLGzYaFphVA6IQZ3N7aR
 V9cdmIw0NvWR29gtCUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090094

There is no reason to have __ashlti3(), __ashrti3(), and __lshrti3()
implemented in C. Convert them all to C, which allows the compiler to
optimize the code if newer instructions allow that.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/asm-prototypes.h |  4 --
 arch/s390/lib/tishift.S                | 63 -------------------------
 arch/s390/lib/tishift.c                | 64 ++++++++++++++++++++++++++
 arch/s390/lib/tishift.h                |  9 ++++
 4 files changed, 73 insertions(+), 67 deletions(-)
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
index 000000000000..bb16cf639af3
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
+noinstr __int128_t __ashlti3(__int128_t a, int shift)
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
+noinstr __int128_t __ashrti3(__int128_t a, int shift)
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
+noinstr __int128_t __lshrti3(__int128_t a, int shift)
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
index 000000000000..43a9b8c8e545
--- /dev/null
+++ b/arch/s390/lib/tishift.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _S390_LIB_TISHIFT_H
+#define _S390_LIB_TISHIFT_H
+
+__int128_t __ashlti3(__int128_t a, int b);
+__int128_t __ashrti3(__int128_t a, int b);
+__int128_t __lshrti3(__int128_t a, int b);
+
+#endif /* _S390_LIB_TISHIFT_H */
-- 
2.53.0

