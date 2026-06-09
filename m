Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ADD3EF0D3
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001231; cv=none; b=nKMaBRPOzYaKw69UUqR1MiUwyY+T9efh/OrYU7WMsmNp0rw+BAg12KG0ebQ8W8i1u3pFF70vh9IkbJ2i0vTMBmaiG7uCczhJubB09N4fr6XVuo3bE+1uqE7UXyN7t54kf4zmXdw+aaWUNm1YCOrFVM9k0bp9tm1ZygD0uJ887Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001231; c=relaxed/simple;
	bh=rV0AHTCO5kzU9DsNUwJuf8voXEBhEmQzl0X7TvrxbZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1jjIn/Ebx4iAcvBuNSQUneDZzdGEng8LhtnpzYZ9oGEHspumgj2dyDHUgzJkqCvYTMjK/qDTBI8kpJBvudpvDObVEOQNLwcStTpzRfV1zmaJ1WUYrJaNi08G3n2XK5M6LJk9f7IGoZsnlmIKOQd+VNHaKno0hwU3BTBYwc5QlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QaoQ3o/h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QaoQ3o/h"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658KQhH01202310
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ky2hWRkyHzsOvHkpu
	2HeQIJL67ig//gX+qHx13EYid4=; b=QaoQ3o/h4GZ+ljuzoj2ki6p4ie0LbKbwV
	5TUc+QQ3KmcE7a7kWJW1BGJO1L4qadaMneDxSzAMjjDJH9kRMZFvCtaWbsoZfzQS
	Hn6d3b/4pzKQermnDnwcP+0qs5asm9xG4mS/tKI3hG2ziu/+JmVT+VLQY4gQwBrA
	3Bfb7bkzK3JSPuq65CJckKIgoAPhCZNxu44g99l2NwyIX6fcpya5XRChbNZcQlwt
	PvCQ6oyZJJ0O0rLuMWWorypg2yzEqk+bISRIwLpinGERnZCxv8mvB6xgSW4Wl/+/
	ab0nTdm0SWQSWTzeea4T18aaRzgNAplYIMOdhXyowbjyQ8gbnTQOw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95bmyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJd4r003626
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g1bry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXjWl24051996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F40332004E;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5D4B2004B;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 5/9] s390/string: Convert memset() to C
Date: Tue,  9 Jun 2026 12:33:39 +0200
Message-ID: <20260609103343.107325-6-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a27ec0d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gsTiIhmxh3G2lPJPIkIA:9
X-Proofpoint-ORIG-GUID: x8NKhyfMuUmz3ZtHeoGRUuK1Xh9DS3ab
X-Proofpoint-GUID: x8NKhyfMuUmz3ZtHeoGRUuK1Xh9DS3ab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX6ktVkkOha7ol
 j6X42zUuznlSt1yC//uJeLVZyomTf11XPYB+7/lJ//7BXtkRP+I+CqerPdjUE4OXusuh9klcgOK
 iWIXtvzlCb1GE5X9VJJL7TPezPpKu9QcZiRyddOrhCL3L1lU7Qr9zkC0oTG1boYfLxlnMZGB0q+
 FyG3awMYKWPGLaEbS+aPSpE7xfwBYKPpkkhTg9I1/9QfZ+Y7ZAFo1Lqm0JKlhVjWArIvYWfLPgO
 I+daT2IqOIFeR4jt08cItUAcoafD8z7iG9TcULmxGEqaEQIhYw0weArLpQC9i1zJ4SM9YgzAayo
 HopDg+P+sUnRDf7qAWDQf1gBj7G/tBndNe9tlZCrMfarp1n725qsKcqnUCrhR6RFeRELQi6rLrh
 SyJIzDY/6aeIiUT13O0Eh38ELjE9Rmm9PviD3PT4InpVOMOZnA0xaqyJgrrEhWqYINUqNV4572W
 H3EzgNTOlr3Tg7s4Gsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090094

Convert memset() from assembler to C, which should make it easier to
read and change, if required. And it allows the compiler to optimize
the code, and use different instructions, except for the used inline
assemblies.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/mem.S    | 63 ------------------------------------------
 arch/s390/lib/string.c | 61 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 63 deletions(-)

diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
index 712b955ea9b4..a27b103d7450 100644
--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -11,69 +11,6 @@
 
 	GEN_BR_THUNK %r14
 
-/*
- * memset implementation
- *
- * This code corresponds to the C construct below. We do distinguish
- * between clearing (c == 0) and setting a memory array (c != 0) simply
- * because nearly all memset invocations in the kernel clear memory and
- * the xc instruction is preferred in such cases.
- *
- * void *memset(void *s, int c, size_t n)
- * {
- *	if (likely(c == 0))
- *		return __builtin_memset(s, 0, n);
- *	return __builtin_memset(s, c, n);
- * }
- */
-SYM_FUNC_START(__memset)
-	ltgr	%r4,%r4
-	jz	.Lmemset_exit
-	ltgr	%r3,%r3
-	jnz	.Lmemset_fill
-	aghi	%r4,-1
-	srlg	%r3,%r4,8
-	ltgr	%r3,%r3
-	lgr	%r1,%r2
-	jz	.Lmemset_clear_remainder
-.Lmemset_clear_loop:
-	xc	0(256,%r1),0(%r1)
-	la	%r1,256(%r1)
-	brctg	%r3,.Lmemset_clear_loop
-.Lmemset_clear_remainder:
-	exrl	%r4,.Lmemset_xc
-.Lmemset_exit:
-	BR_EX	%r14
-.Lmemset_fill:
-	cghi	%r4,1
-	lgr	%r1,%r2
-	je	.Lmemset_fill_exit
-	aghi	%r4,-2
-	srlg	%r5,%r4,8
-	ltgr	%r5,%r5
-	jz	.Lmemset_fill_remainder
-.Lmemset_fill_loop:
-	stc	%r3,0(%r1)
-	mvc	1(255,%r1),0(%r1)
-	la	%r1,256(%r1)
-	brctg	%r5,.Lmemset_fill_loop
-.Lmemset_fill_remainder:
-	stc	%r3,0(%r1)
-	exrl	%r4,.Lmemset_mvc
-	BR_EX	%r14
-.Lmemset_fill_exit:
-	stc	%r3,0(%r1)
-	BR_EX	%r14
-.Lmemset_xc:
-	xc	0(1,%r1),0(%r1)
-.Lmemset_mvc:
-	mvc	1(1,%r1),0(%r1)
-SYM_FUNC_END(__memset)
-EXPORT_SYMBOL(__memset)
-
-SYM_FUNC_ALIAS(memset, __memset)
-EXPORT_SYMBOL(memset)
-
 /*
  * memcpy implementation
  *
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 66286d486ef8..ff9c4b57b6f1 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -63,6 +63,67 @@ EXPORT_SYMBOL(__memmove);
 EXPORT_SYMBOL(memmove);
 #endif
 
+#ifdef __HAVE_ARCH_MEMSET
+noinstr void *__memset(void *s, int c, size_t n)
+{
+	char *xs = s;
+
+	if (!n)
+		return s;
+	if (!c) {
+		/* Clear memory */
+		while (n >= 256) {
+			asm volatile(
+				"	xc	 0(256,%[xs]),0(%[xs])"
+				:
+				: [xs] "a" (xs)
+				: "cc", "memory");
+			xs += 256;
+			n -= 256;
+		}
+		if (!n)
+			return s;
+		asm volatile(
+			"	exrl	%[n],0f\n"
+			"	j	1f\n"
+			"0:	xc	0(1,%[xs]),0(%[xs])\n"
+			"1:"
+			:
+			: [xs] "a" (xs), [n] "a" (n - 1)
+			: "cc", "memory");
+	} else {
+		/* Fill memory */
+		while (n >= 256) {
+			*xs = c;
+			asm volatile(
+				"	mvc	1(255,%[xs]),0(%[xs])"
+				:
+				: [xs] "a" (xs)
+				: "memory");
+			xs += 256;
+			n -= 256;
+		}
+		if (!n)
+			return s;
+		*xs = c;
+		if (n == 1)
+			return s;
+		asm volatile(
+			"	exrl	%[n],0f\n"
+			"	j	1f\n"
+			"0:	mvc	1(1,%[xs]),0(%[xs])\n"
+			"1:"
+			:
+			: [xs] "a" (xs), [n] "a" (n - 2)
+			: "memory");
+	}
+	return s;
+}
+SYMBOL_FUNCTION_ALIAS(memset, __memset);
+EXPORT_SYMBOL(__memset);
+EXPORT_SYMBOL(memset);
+#endif
+
 /*
  * Helper functions to find the end of a string
  */
-- 
2.53.0

