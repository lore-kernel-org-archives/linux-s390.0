Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C035F5E5
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897081; cv=none; b=scYMJoGlGKvu5XrZr9td3qTOHIiq4kBvYD3mifimX5XTRiAMdYItAK/MPhSoyRgNaQZuKK7kKRlNS/pwEDSg3aOMGwRPHxcVIMMoqbnSTcYA1MTUSsgXfteGM0kKbObM/yWLW/P0dLRMgFdMjodcZb7ao/Ub5WwDJuBL/YuENnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897081; c=relaxed/simple;
	bh=F1Cy1mn84Sw+kTUZ/xQwo+jzgk+iLdGuRsK9ZD1FIgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh/m4dQF9uN7oI4+jfYvnbAjRm/8OoG7obnS+JiShW0vBZr4nk1AXbzyt3XeFp8aw8PPoG9bTz7P/7SF5g75EyssuTI4t9X+hkBlKF6zvxA6PH2jZoaX2i4xEmxw1QhYvkqN1i1PPOB4w05ClPop1sgIC9cKAD9TJtFjjKrnc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WhJZi1KG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WhJZi1KG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6579tdwE2567161
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fT4zYONtjPlWgkeay
	mRlIqzJpK8pMOlPX8XIXpEmpXs=; b=WhJZi1KGBqarJY45yPMorKiKyKLJdnWbs
	vD4lkMr9mAtzmWb6GKtuHU6Swaus5BYQSDwWjUWSIUu8sLf0AdTf1AqGWOoRMk5s
	NKeX/1HcECOyv+BWJ0LUkaAqVdncU3XsqLOCwErRqCO5TNK1raY665IKJz2jW2qK
	H8f3EBBaN8jy7eGA8vB8Iwr/YHyJwGjpRPqPZgGeeuDKfb+hdkiqB79LnmReWv6o
	8FXXxg2QyXmAbamvomp6BZQSTbk890iXwDm/aXJKZDJsQrNdIXSa7c+QrudCkfhU
	WJzsZJeTb1nPJzPryFjZzcru7sNMfg4sDO70Y73LS0LzKq5wyYpbg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23nu0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585YedI021777
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03furjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585btIQ58392894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 324DA20040;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1495A2004D;
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
Subject: [PATCH v2 4/8] s390/string: Convert memset() to C
Date: Mon,  8 Jun 2026 07:37:50 +0200
Message-ID: <20260608053754.571282-5-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a265537 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=WQ5kpAm36ODPKkmjWIAA:9
X-Proofpoint-ORIG-GUID: 2UlEGgvyviMknM1ez2WwVcBlnL1EkR3_
X-Proofpoint-GUID: 2UlEGgvyviMknM1ez2WwVcBlnL1EkR3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX5eOuxKRtE/NP
 0N8BOxfsQHL5I/G5fsi+5CEkAvqqkiBbfbDm4EhYKWFEV1WHokPGc0PY3/UzfEXdI+GvgfCsZL4
 IvQfMRQdJ44I3euWsQIYQ1YruUj57ougJmMzqlzViS6WRKFhs95n+nSmAbApN8vsKre8Nz4Q0ij
 OKgaIRkFnzt9kNjPp+4whek/Wwe7mrQhEnUZ1uVrZb+BbMCFDsS0iAZBkELFbiH6mZHW0XqVkV0
 zA2tY129N0xEcTfpmCJak5RvxiL6vfepsxf65CDaqSy34qxxiylcEr0EpDghn9zOERR7zY74V7h
 UXZofpoDyYrq3U8GDgvb14aeYVLQ/PCpw3M8ZEmcLeQ6WbY8VZa4K+tB1eVNcL8+REldAlpIMwD
 nTI0KOV59boBDHR8vuxa5qmcryA9W20iluZ3OfrBPZ7rd2Ifuytv4COkjw50F1UKElTN5/4XTFE
 BOA9IudcspsbP206nSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049

Convert memset() from assembler to C, which should make it easier to
read and change, if required. And it allows the compiler to optimize
the code, and use different instructions, except for the used inline
assemblies.

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

