Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A335E926
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897081; cv=none; b=TCb78jdCBBPkzeJN1n0Zd/II0bC97bIVv9SiTXE31GcSbcRQpgoDW8f60aFzOQ5RTCDhWKwJo2AgRjJDwxk630YeojoDa/hSXls91IMayA7g6PJ1jLZrgYcgY7S2Jf/rkwR2GnNhVCs2EnAV/dCr6pqIlLwHFlL/uQDbP3ij/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897081; c=relaxed/simple;
	bh=oCon/2tzk2q6rIzAy30EzdfSQQqfMqkKCgEPc+btb9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS8UIpA5lz326BSOpjDpPZNJLB9QEXs9IcRj5RsZUhsBGpIH5rVf/BFO33UIrx/Q6SzP2VTah5rjvFbFuBFcWH6n/cnnw+t2ZSsPYdn/s65iBLJjeV0GOo2u7FMibLqvgqJyR4ut84zvDxSItITcW4RMWzv0GwGSI3mooo9e3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kpWbbazJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kpWbbazJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6579r1BG3420508
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NEosrVYmabr8apihq
	93z1C/FmHIgtrdUMx5D97LMrx8=; b=kpWbbazJbmfc/1mmsqwk5TGF8kb2q2xrp
	S0Tud4nC0pdQ23OykPa/LPJRQmEKnUg90gXlEsIJZjvKDSeOfuDWLMErkAao2qy4
	lAv37B1Xz8PFqKaBRnRyl2MlmS0yM3UzFFlsGxMO48EjLjrSMIGoUXzNe0m4Ep1n
	wM7Qv5CBD/z3+/ytM5HQuma/18vncK5QizIHtapvf5H2nx17QOkxw9OpfJwVXZq/
	hPL/BF98OyqbBJbfy8QdsW57jBy7GbUVknkLqHew+p+FZ+SU1TeKqDt6DxLdglX6
	1a3t/+m3fEIu3cfVnfGXSnz4uYJ35LjUNvZMQdGkrwLVcDuKRtyvQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydwthh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585K0vH010426
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjkxff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585btJ358392892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FA2620043;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E59872004B;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 3/8] s390/string: Convert memmove() to C
Date: Mon,  8 Jun 2026 07:37:49 +0200
Message-ID: <20260608053754.571282-4-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX7zv8fOBZOuT7
 TK1NvbAjM1nOBsR8sprnpL7v08le18BN5uqGT7i+a8QIbSg55cp9sQwHeudNcXGNFlOKpIhaSWQ
 mXuyP3/kqiUl8yCoFDso4GJZAHdIGBS5ieEWmkecl+8O1imX5SQ2ZRRT1ssNvZkR9/2yG2urXGC
 U/eOhsuYK94+MhCjoVqLfvBVga81eRFhsZvVb+LiAAWZRHt/z994WeJ0eraOhqeQL3YHyQ0F6gO
 B8nmvLwibM4DtjlwQaNynZcGuHqPPFz4fzERFrp9Eki0NEbEdqvizz/+LLlC1o2gMluJcWyPm/3
 iGdK7gM4EmvQJMY7XjyLlx0VlqbiF1fr1rb+CZ7RCYSvcIQTRQQbtP/psOzNFI8Z8k8jg5yiXTx
 NpxL/CNJJs02aSCkfJdzvR/lTO4v4AK0F1kB54I78DV7IsoNhcSOzOlrFgLMrw46R+0RYxmCkkH
 uNQhw66pV4LXAzHIy+A==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a265537 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pydQ_VjQ2XfJpekr5b0A:9
X-Proofpoint-GUID: JQ5LktGlq1VL_xICaL03yX9O42eNjvkY
X-Proofpoint-ORIG-GUID: JQ5LktGlq1VL_xICaL03yX9O42eNjvkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049

Convert memmove() from assembler to C, which should make it easier to
read and change, if required. And it allows the compiler to optimize
the code, and use different instructions, except for the used inline
assemblies.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/mem.S    | 41 -------------------------------------
 arch/s390/lib/string.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
index d026debf250c..712b955ea9b4 100644
--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -11,47 +11,6 @@
 
 	GEN_BR_THUNK %r14
 
-/*
- * void *memmove(void *dest, const void *src, size_t n)
- */
-SYM_FUNC_START(__memmove)
-	ltgr	%r4,%r4
-	lgr	%r1,%r2
-	jz	.Lmemmove_exit
-	aghi	%r4,-1
-	clgr	%r2,%r3
-	jnh	.Lmemmove_forward
-	la	%r5,1(%r4,%r3)
-	clgr	%r2,%r5
-	jl	.Lmemmove_reverse
-.Lmemmove_forward:
-	srlg	%r0,%r4,8
-	ltgr	%r0,%r0
-	jz	.Lmemmove_forward_remainder
-.Lmemmove_forward_loop:
-	mvc	0(256,%r1),0(%r3)
-	la	%r1,256(%r1)
-	la	%r3,256(%r3)
-	brctg	%r0,.Lmemmove_forward_loop
-.Lmemmove_forward_remainder:
-	exrl	%r4,.Lmemmove_mvc
-.Lmemmove_exit:
-	BR_EX	%r14
-.Lmemmove_reverse:
-	ic	%r0,0(%r4,%r3)
-	stc	%r0,0(%r4,%r1)
-	brctg	%r4,.Lmemmove_reverse
-	ic	%r0,0(%r4,%r3)
-	stc	%r0,0(%r4,%r1)
-	BR_EX	%r14
-.Lmemmove_mvc:
-	mvc	0(1,%r1),0(%r3)
-SYM_FUNC_END(__memmove)
-EXPORT_SYMBOL(__memmove)
-
-SYM_FUNC_ALIAS(memmove, __memmove)
-EXPORT_SYMBOL(memmove)
-
 /*
  * memset implementation
  *
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 757f58960198..66286d486ef8 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -17,6 +17,52 @@
 #include <linux/export.h>
 #include <asm/asm.h>
 
+#define SYMBOL_FUNCTION_ALIAS(alias, name)		\
+asm(".globl " __stringify(alias) "\n\t"			\
+    ".set   " __stringify(alias) "," __stringify(name))
+
+#ifdef __HAVE_ARCH_MEMMOVE
+noinstr void *__memmove(void *dest, const void *src, size_t n)
+{
+	const char *s = src;
+	char *d = dest;
+
+	if (!n)
+		return dest;
+	if ((d <= s || d >= s + n)) {
+		/* Forward copy */
+		while (n >= 256) {
+			asm volatile(
+				"	mvc	0(256,%[d]),0(%[s])\n"
+				:
+				: [d] "a" (d), [s] "a" (s)
+				: "memory");
+			d += 256;
+			s += 256;
+			n -= 256;
+		}
+		if (n) {
+			asm volatile(
+				"	exrl	%[n],0f\n"
+				"	j	1f\n"
+				"0:	mvc	0(1,%[d]),0(%[s])\n"
+				"1:"
+				:
+				: [d] "a" (d), [s] "a" (s), [n] "a" (n - 1)
+				: "memory");
+		}
+	} else {
+		/* Backward copy */
+		while (n--)
+			d[n] = s[n];
+	}
+	return dest;
+}
+SYMBOL_FUNCTION_ALIAS(memmove, __memmove);
+EXPORT_SYMBOL(__memmove);
+EXPORT_SYMBOL(memmove);
+#endif
+
 /*
  * Helper functions to find the end of a string
  */
-- 
2.53.0

