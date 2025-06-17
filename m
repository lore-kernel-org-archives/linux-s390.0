Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84FC2D1;
	Tue, 17 Jun 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168253; cv=none; b=tdfOKnF7kbSX2ie6Pd/aBl1aykOWjopwqxQtrOsO7B434ffTBsJYtVLS+ursISYrA1F3FLJn+8jJ0R1j9lOt4snZbtDOzqdKQsoJSbbzjoU4oUF/er+RuNd+vtY8Ps5Lcw6rga//FpaZM2+fXNVh53k/13uVFFr3c/o3E3uC9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168253; c=relaxed/simple;
	bh=/47o7M3S+OQoulJrD0lkawhmygMPD+5PF/LF7xGewEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm19Mnkn8MU1DNnQIcXK2N8wrHI45cClU+vvLrky86cVYRK4e0uIyHVJNMRfSlYjOv8RiapHB1SbIM4vEG2JQw7yy0/RpoPDgVPDY8MpI2gBDJHB5PYHhLkXkn8NIWVfYUu4KwcfAsCw+bugzXNUYPLCYIITMvMgQLd3dRWCcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fGjD2qgR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fGjD2qgR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H6Ngu8032405;
	Tue, 17 Jun 2025 13:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cHzrZsvFK4whXNTSj
	12pjV0dNmM1yjgf2XuVdqOGHUc=; b=fGjD2qgRrQW7uv5lvESez2j4Xl1nNutOk
	NL7PY0SC50cC2WLrDEMfGMcQDtt4uhqH5ZZekKQDUJu1+fl3mh7cK+Pr76UVabpN
	WMU1Mlxdu/RnAEfg8TltBnWAULORnDU2U+d5A+SHW1vQbxZecrefAnmKayxPdIuy
	t6r1irS0pNrsNYwd4hbSfU9zm1mCwtU+8mnctHXUGEe6Xl23xnaJB0ozRN/RBcLV
	s00Yas2VtE9V5+Yv9N0vHf7swYg7ukSKgLWAjjx5BgOdyWPL+AI516YELum7iJJ4
	s9yozB3l4Ic3g55LsNtC+BnLGSAHE2/WGcWz+zQ90wGkTPMzEbnJA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r20808-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:50:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HD2E5k025755;
	Tue, 17 Jun 2025 13:50:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5sv87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:50:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HDoiB956361412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:50:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24C1C2004B;
	Tue, 17 Jun 2025 13:50:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1C2A2004E;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/2] bugs/s390: Use inline assembly without input operands
Date: Tue, 17 Jun 2025 15:50:42 +0200
Message-ID: <20250617135042.1878068-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250617135042.1878068-1-hca@linux.ibm.com>
References: <20250617135042.1878068-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HbySWjrcG6IYLCoCxao2DFMsA8HpJ383
X-Proofpoint-ORIG-GUID: HbySWjrcG6IYLCoCxao2DFMsA8HpJ383
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=685172b8 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=8zdudlHCA158U1X2FqQA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEwNyBTYWx0ZWRfX8ioyAijkP/E2 G4ZNIwNF3xKaAJ/uVgbgfn/oQpsZQEbW3/5Nt4ePRiAHD7Mk5skFL0VB3yDTuOIss+hK/9PpK6V buJ5+KzGZLkeJmyhPqhCerxCKjGdGatBGi3mCXSrKyCUSMTIUSVtznqwv1Ueh4g6DWjhOaxA89Q
 tAQo/YFfXJj/eOsYTIVgDiol3zYVoz/dM6vWTGTDoTGS1ft+rN51NxQwOt5p6x2eTCzdJl4fB3E wBL0gYBOyYJhHnUc55Qu05Lk6KRFoBABrqoxvEp/nxCZlD5X9rlxVuUYtlvXAd/U5D9nWIUg6wL kBwSWr2lel7Gmud+U7xrrubu7oGwNpHYSZZh1YbM41IKjmsgktLEkQpPvgkUJZQmh84sTu28MWw
 ZbtWKBlzDfaEb3YRs61nrTIDV+Rhf9+aE9X/zORRv7Tv6lxMC5+XDDOW9CRKQHoUoK7nE1BW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=972 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170107

The recent change which adds DEBUG_BUGVERBOSE_DETAILED support for s390
changed the __EMIT_BUG() inline assembly so it has a string as immediate
input operand. Some older gcc variants cannot handle strings as immediate
input operands for inline assemblies. Doing so may result in compile
errors:

mm/mempool.c: In function 'remove_element':
include/linux/compiler_types.h:497:20: warning: asm operand 0 probably
doesn't match constraints
 #define asm_inline asm __inline
                    ^~~
arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
  asm_inline volatile(     \
  ^~~~~~~~~~
arch/s390/include/asm/bug.h:43:2: note: in expansion of macro '__EMIT_BUG'
  __EMIT_BUG("", 0);    \
  ^~~~~~~~~~
include/asm-generic/bug.h:77:57: note: in expansion of macro 'BUG'
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                                         ^~~
mm/mempool.c:149:2: note: in expansion of macro 'BUG_ON'
  BUG_ON(pool->curr_nr < 0);
  ^~~~~~
include/linux/compiler_types.h:497:20: error: impossible constraint in 'asm'
 #define asm_inline asm __inline
                    ^~~

Rewrite the s390 generic bug support very similar to arm64 and loongarch,
and get rid of all input operands to fix this.

Fixes: 45c79ca947c9 ("bugs/s390: Use 'cond_str' in __EMIT_BUG()")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYuu5r34=bndUYWNxe_yLgBaPGXmK9WP3WTtoXMs_2LX-Q@mail.gmail.com
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 81 +++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 58ab4efd9dd5..a185855ab158 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -2,54 +2,55 @@
 #ifndef _ASM_S390_BUG_H
 #define _ASM_S390_BUG_H
 
-#include <linux/compiler.h>
+#include <linux/stringify.h>
 
-#ifdef CONFIG_BUG
+#ifndef CONFIG_DEBUG_BUGVERBOSE
+#define _BUGVERBOSE_LOCATION(file, line)
+#else
+#define __BUGVERBOSE_LOCATION(file, line)			\
+		.pushsection .rodata.str, "aMS", @progbits, 1;	\
+	10002:	.string file;					\
+		.popsection;					\
+								\
+		.long 10002b - .;				\
+		.short line;
+#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#endif
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
+#ifndef CONFIG_GENERIC_BUG
+#define __BUG_ENTRY(cond_str, flags)
+#else
+#define __BUG_ENTRY(cond_str, flags)				\
+		.pushsection __bug_table, "aw";			\
+		.align 4;					\
+	10000:	.long 10001f - .;				\
+		_BUGVERBOSE_LOCATION(WARN_CONDITION_STR(cond_str) __FILE__, __LINE__) \
+		.short flags;					\
+		.popsection;					\
+	10001:
+#endif
 
-#define __EMIT_BUG(cond_str, x) do {				\
-	asm_inline volatile(					\
-		"0:	mc	0,0\n"				\
-		".section __bug_table,\"aw\"\n"			\
-		"1:	.long	0b-.\n"				\
-		"	.long	%0-.\n"				\
-		"	.short	%1,%2\n"			\
-		"	.org	1b+%3\n"			\
-		".previous\n"					\
-		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__),\
-		    "i" (__LINE__),				\
-		    "i" (x),					\
-		    "i" (sizeof(struct bug_entry)));		\
+#define ASM_BUG_FLAGS(cond_str, flags)				\
+	__BUG_ENTRY(cond_str, flags)				\
+	mc		0,0
+
+#define ASM_BUG()	ASM_BUG_FLAGS("", 0)
+
+#define __BUG_FLAGS(cond_str, flags)				\
+	asm_inline volatile(__stringify(ASM_BUG_FLAGS(cond_str, flags)));
+
+#define __WARN_FLAGS(cond_str, flags)				\
+do {								\
+	__BUG_FLAGS(cond_str, BUGFLAG_WARNING|(flags));		\
 } while (0)
 
-#else /* CONFIG_DEBUG_BUGVERBOSE */
-
-#define __EMIT_BUG(cond_str, x) do {				\
-	asm_inline volatile(					\
-		"0:	mc	0,0\n"				\
-		".section __bug_table,\"aw\"\n"			\
-		"1:	.long	0b-.\n"				\
-		"	.short	%0\n"				\
-		"	.org	1b+%1\n"			\
-		".previous\n"					\
-		: : "i" (x),					\
-		    "i" (sizeof(struct bug_entry)));		\
-} while (0)
-
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
-
-#define BUG() do {					\
-	__EMIT_BUG("", 0);				\
-	unreachable();					\
-} while (0)
-
-#define __WARN_FLAGS(cond_str, flags) do {		\
-	__EMIT_BUG(cond_str, BUGFLAG_WARNING|(flags));	\
+#define BUG()							\
+do {								\
+	__BUG_FLAGS("", 0);					\
+	unreachable();						\
 } while (0)
 
 #define HAVE_ARCH_BUG
-#endif /* CONFIG_BUG */
 
 #include <asm-generic/bug.h>
 
-- 
2.48.1

