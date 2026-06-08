Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751FE371D19
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897082; cv=none; b=OiENEmCaSyhg+ul0G3jbTXQ467btoCC0GlqIf5TMT+kJAAH/axM0Z0xFZUDpA44gVkoQ6eXA9WpsvRDw1p9bhQeejm0SoJrYDV0i5zC6lmYtuCUvsCoKyu7jn647usNKxB6CSTeqTrIstwjQz+SYaG6Xr7uOn8rK4VHGL1OvBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897082; c=relaxed/simple;
	bh=r36G4m/E6B7Vjb5Bdhfi3jbQETBUrN3CN6yf4CTtwNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmXRJqNjO0H/fqqtRNlr1ZSXqBMUPc5saqt6g/0erREGpHCjegHMWlpqVe31eY+Z6RCOu0Y0aJATBULWky6/UZKHzvh/QpctuKtvk1Y/0Hqq2/8AEG2+GUXet7+1Xxj0x1qwb7NY6t6XqEh1XNHEb7QP18naX7rU9H/a8Pb/EQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ig4ql0eA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ig4ql0eA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6576tdVi1477263
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T2K+DcuUZDGEPoYEW
	DEQ0fIN971OBzIoGH8du0G4TM4=; b=ig4ql0eAgXbx479VXi3uGqK32KoROFMba
	yZghYqwEZhzdClrXB9tW/AGPvVXxlBY+9BA1KgmjBCM2KC9DxVIIjR805ufgBim4
	eYn+3trKkVvdxJHBJmVsmqt87S65sB5u+PxKZuNE/8yUHLaLJ1yyk/QAttLykaHG
	y95PTPMpo/055x6KTy+x0C+Ogz/B4aqbsv2AuCv6mQMSnXD7WJELGfgtTWjjz2t7
	fKlJcLLMsUrArvUW/pzZxewhSwNaVu8vrldXHrmBNNPId4GoYfjkFjDC5XsbGmPA
	IDZrYmbs71MPJaDVNYpA5E1Z6A0qvG2TxY4EO5lgWRunaIwJo43CQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qdsfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:38:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585Z31h006214
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vv1uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585btwg58392902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01DD20043;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A27942004B;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 8/8] s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C
Date: Mon,  8 Jun 2026 07:37:54 +0200
Message-ID: <20260608053754.571282-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608053754.571282-1-hca@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a265538 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=D3IvRudVPZkSyVNiNrMA:9
X-Proofpoint-GUID: Im4Cqrlma7xArbNIKUdRS66ryfDvHtrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX8Ch+BbhLtaWU
 jwvw3vRScxVmuzMjhJtZWLL1b1NZeH4hAI9izqnHfYO91Rir4q5ROKm2Lu5/NdqfIoT/IDHIy7j
 T5j7VFQkic8K5e/UzNkaPHa7cHw2RLJkp0F21RmJpCmwL9fgIly2x+VDR3F1ZL6KXHfl0JE3881
 qUkHdvcszALREfbZsnwTa6oeim06CuMxEfIvLY1UlwOkSnSAaOyFteI+KL09PNdS/opT5JdUm/C
 ZAL7Ql6eSNI4MIhg9K/XvZldBDFfEYCU8ZkrAPtHp/Y3skI/3Lr0zdjP9+NdCT2xcz1SjbMzmpU
 nv8rhD9MIOQiQo6y2CVqJHsbT96Cf4sFvYDWkddGv1EVsnTbKvbInUrY/DO/+/KBNe51YmuTejE
 lXpidzxXiDHI6wodzcR5okC+0WSzqNtR2hDJZr3Ap1u9gk/QsgRTfVS0giKTyhbeD+ERIEoF0VN
 dvlt/GnCDMTYYKuwmlA==
X-Proofpoint-ORIG-GUID: Im4Cqrlma7xArbNIKUdRS66ryfDvHtrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049

There is no reason to have __ashlti3(), __ashrti3(), and __lshrti3()
implemented in C. Convert them all to C, which allows the compiler to
optimize the code if newer instructions allow that.

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

