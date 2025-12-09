Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97457322B67;
	Tue,  9 Dec 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282636; cv=none; b=jtBjlrEQrMQtZbbQ8unpSpXaBeUgJW/hMn+EuKFLNdd42PoF952QS4YWXsLvf79v2RoZ0hPaGpiQpzGMxpsIIdjnNR7+AZIyeCjwwqWcCNuk1NdAntneh0jh3mLQkN2rHm6HZzpcnvReqg8uGOQbzsYmCjR3L0/CmfYLR/F7pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282636; c=relaxed/simple;
	bh=5eFzsiFl/P17OXxhiM+WV1YJZTXLQzoSb9eZAyj/jIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muuZQtmZnOLNQWZWDY7DzS6Dpwsc11hjVXYt27s6WB3tS7lGrpDjYRGdN3F6Bk34L8Esntzrn2JjODMb4xzSqDoLO5eKww7V4Wgpfy/lyrAYnpDfl0/nKZcSwWd7bNmsnBu08ZkmP7D26LEeMdRJT2xgMZjeK437pZ4v3kfJ3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rTAw5mj8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rTAw5mj8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9AgGqe016858;
	Tue, 9 Dec 2025 12:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=74tm+C
	zkfwW6ByXYcCFxHiGIFYnJhJLfCO/A4PQjn9A=; b=rTAw5mj83EBRVfbDoY4hg7
	DhDMr/1lR1Sll5xxzHQxYTIP5r1U0hn1gPr6jyC0xbshML4QCVVDes2DIQa1RasP
	ht3RufaMdsT1TrpZDFHKGNv2U+PGPa6uNhr1mAOw0fKIa7nosAXKgTt+vcqdHWbF
	u5o356tQrLvzWAq2cl8PyqC7y2ikKLjGuXIuszQawW47CslGK3ROrHn9MBhHdFzE
	F7AOQL2KEvUI/y7Fe6MZ0GoD6aHRfzwgZPy+nrXEMyEF8VLZrNbEM6FZQLSbORkj
	z7L1p3j8VDmH5kuH1IW0/2THBUzq5EjYtfTX/PTuPPudf61xyJ3whMkhItI3fZJQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvmdnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9Aag4x030254;
	Tue, 9 Dec 2025 12:17:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxts2xjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH2Up24773330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07E2B2004E;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFA022004B;
	Tue,  9 Dec 2025 12:17:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 12:17:01 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/9] s390/bug: Convert to inline assembly with input operands
Date: Tue,  9 Dec 2025 13:16:54 +0100
Message-ID: <20251209121701.1856271-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4tbiLz7dGGWj4acycLqn-hJQDHHgi_zf
X-Proofpoint-ORIG-GUID: 4tbiLz7dGGWj4acycLqn-hJQDHHgi_zf
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=69381342 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=36klhH69ptpTDPabKO0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX5nAG4nwOJKV8
 W4z3dewj0Xi4vHYOEHoNYjqRixpFx+5Nkhhb39mKMjiUcGMlGpQn097NMSreLenbQH0V3R4QfyB
 eigqnNV6MF+35xN/BgS2mQoztORBrXUs3DZAbAD6LJI6MdOO2e+rQMdWzDlsGey25tCMNtYzgRN
 HnVUqRWaElZZQ9rrwvxaQfe2F/delW/5AtOb03hNucFDJ3Dxq81p2cJ8cUS0Z5/FUjFazJsLliW
 tyEIq0dkptktj4SxkwqhY8NmNjqxubxNkRdJueXHJvoHaW3/J+iJ9CEjBE2E/IlP5ddkYKVc6uf
 sD2gqZbSGgjkUFYQtZXyFFhcfzuVGbKepoOYeXJAw6VJeRagq7X/UIbYHTM4cgPJEUSZw6z4n/f
 C7wXmac4y8lLkRdwPfdAJoMLqYD2lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Rewrite the bug inline assembly so it uses input operands again instead of
pure macro replacements. This more or less reverts the conversion done when
'cond_str' support was added [1].

Reason for this is that the upcoming __WARN_printf() implementation
requires an inline assembly with an output operand. At the same time input
strings (format specifier and condition string) may contain the special '%'
character. As soon as an inline assembly is specified to have input/output
operands the '%' has a special meaning: e.g. converting the existing

 #define __BUG_FLAGS(cond_str, flags) \
   asm_inline volatile(__stringify(ASM_BUG_FLAGS(cond_str, flags)));

to

 #define __BUG_FLAGS(cond_str, flags) \
   asm_inline volatile(__stringify(ASM_BUG_FLAGS(cond_str, flags))::);

will result in a compile error as soon as 'cond_str' contains a '%'
character:

net/core/neighbour.c: In function ‘neigh_table_init’:
././include/linux/compiler_types.h:546:20: error: invalid 'asm': invalid %-code
...
net/core/neighbour.c:1838:17: note: in expansion of macro ‘WARN_ON’
 1838 |                 WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
      |                 ^~~~~~~

Convert the code, use immediate operands, and also add comments similar to
x86 which are emitted to the generated assembly file, which makes debugging
much easier.

[1] 6584ff203aec ("bugs/s390: Use 'cond_str' in __EMIT_BUG()")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 71 ++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index ee9221bb5d18..61496143a382 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -2,55 +2,44 @@
 #ifndef _ASM_S390_BUG_H
 #define _ASM_S390_BUG_H
 
-#include <linux/stringify.h>
+#include <linux/compiler.h>
 
 #ifdef CONFIG_BUG
 
-#ifndef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line)
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_ENTRY_VERBOSE(file, line)					\
+	"	.long	" file " - .	# bug_entry::file\n"		\
+	"	.short	" line "	# bug_entry::line\n"
 #else
-#define __BUGVERBOSE_LOCATION(file, line)			\
-		.pushsection .rodata.str, "aMS", @progbits, 1;	\
-		.align 2;					\
-	10002:	.ascii file "\0";				\
-		.popsection;					\
-								\
-		.long 10002b - .;				\
-		.short line;
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define __BUG_ENTRY_VERBOSE(file, line)
 #endif
 
-#ifndef CONFIG_GENERIC_BUG
-#define __BUG_ENTRY(cond_str, flags)
-#else
-#define __BUG_ENTRY(cond_str, flags)				\
-		.pushsection __bug_table, "aw";			\
-		.align 4;					\
-	10000:	.long 10001f - .;				\
-		_BUGVERBOSE_LOCATION(WARN_CONDITION_STR(cond_str) __FILE__, __LINE__) \
-		.short flags;					\
-		.popsection;					\
-	10001:
-#endif
-
-#define ASM_BUG_FLAGS(cond_str, flags)				\
-	__BUG_ENTRY(cond_str, flags)				\
-	mc		0,0
-
-#define ASM_BUG()	ASM_BUG_FLAGS("", 0)
-
-#define __BUG_FLAGS(cond_str, flags)				\
-	asm_inline volatile(__stringify(ASM_BUG_FLAGS(cond_str, flags)));
-
-#define __WARN_FLAGS(cond_str, flags)				\
-do {								\
-	__BUG_FLAGS(cond_str, BUGFLAG_WARNING|(flags));		\
+#define __BUG_ASM(cond_str, flags)					\
+do {									\
+	asm_inline volatile("\n"					\
+		"0:	mc	0,0\n"					\
+		"	.section __bug_table,\"aw\"\n"			\
+		"1:	.long	0b - .	# bug_entry::bug_addr\n"	\
+		__BUG_ENTRY_VERBOSE("%[file]", "%[line]")		\
+		"	.short	%[flgs]	# bug_entry::flags\n"		\
+		"	.org	1b+%[size]\n"				\
+		"	.previous"					\
+		:							\
+		: [file] "i" (WARN_CONDITION_STR(cond_str) __FILE__),	\
+		  [line] "i" (__LINE__),				\
+		  [flgs] "i" (flags),					\
+		  [size] "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
-#define BUG()							\
-do {								\
-	__BUG_FLAGS("", 0);					\
-	unreachable();						\
+#define BUG()								\
+do {									\
+	__BUG_ASM("", 0);						\
+	unreachable();							\
+} while (0)
+
+#define __WARN_FLAGS(cond_str, flags)					\
+do {									\
+	__BUG_ASM(cond_str, BUGFLAG_WARNING | (flags));			\
 } while (0)
 
 #define HAVE_ARCH_BUG
-- 
2.51.0

