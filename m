Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D32EC09F
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849784; cv=none; b=Rl8Sl/7GFaUsDFBsZ8h14NbpzGa7nKE7gLZmlMLpCpj7yvD4OmoBu83h5uGlMm/f9L4zN0NaPO0TRsccUr0DwU9oRJhZISrB3gJutpdFDOKsvWXctL9/AXWn9ZWd8IEjiapbACHvdfDW8cc2Fj/j0rFvNlZyUQO+AhFPtAkrB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849784; c=relaxed/simple;
	bh=QDPHdiou1jPKxJ328lrjeajIJWzDO3yHgc2VeVKvM7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iumr1yOo9R2IJ7qtO0HCnjYWoc5h/13epTsUULkEDIddB5+6739umCURCrGM6SuN1UDO57jDwWSXO4GhxQHHzAwjSX3Yfi5dQjuW9G92ryNRDovTcT47kI42L9nvfkSslCz1HxxgSmFiE/jJm4UtBPQME6nzx2JfAipOpYyA7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X9cen2fy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X9cen2fy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6571Yeor2044612
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=deSG1GTY5XaZl5QEo
	EzCIfUi4hReJENzeNNY25VdR2Y=; b=X9cen2fyaFt/nCgFhcQuupFLe48Ay/xw9
	Lsyo5/WCwmaDadPB8H+rIJiggMv7n8QnQzlCqqEJLMwp4ebHTtbDTUnNBJta45OR
	Ie8jXMXsuGQpt6xoPXu+Uw6PU/O3ggzbIkjJAhI1SR8xn1WRgtaB5yPagsHhisGx
	hGS9s7Zll0gUZnldw0PmtUMI8IdNvpjKwdbepO17QAlfVoJPOCjhBoG09TE1R1We
	lSYcmajCHAzL9AxXN2/vbmYDmGeDDFFkNj3ISweHE/Ypf86Ulx4AMl+SFqydOYKu
	VPqAcJKSfYBB/LRM56CeFeNuaxJUJ/wRQYyCLfB893Kb2EpC03Fcw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhmch2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJlDP012523
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vt5am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTcZc52429170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C79C20040;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E176F2004B;
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
Subject: [PATCH 3/8] s390/string: Convert memmove() to C
Date: Sun,  7 Jun 2026 18:29:32 +0200
Message-ID: <20260607162937.2927356-4-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfX7hZaaXi0BKIQ
 mjUbXNDjC4mHA4eFyIbVKCEHznGgoMFBARiPzlnzYXahcPKQ/MmkS2OcfGqSzBX634bJYB7rnJO
 Wca2ZxSX6Epv5DEde0/J1VcPzXQA/VUXxhOj53e061r13UkvkazLZvkfP1QI1Tm0QV/9le2cVcf
 MkomFUsmKzt0ULeOQuiCUtR7jPP0QSTX55WkxvCpqruEh/Z2f9g4SjE51WxZY+Fvj4+ulDuGXWE
 /G1yAiMFknMvEO7a12tIJ2/s/S8Kgt1MFvOp78LZBhLwsXIUtcibNXNNO2Gcoji/yJf+Iamzbix
 LckY1Yi3ob8Woe6auF5wGLncjQohYKTY5GdfKk8S/33o82VQu9soy3YR9P4oMpUULLpr4jTdGyM
 U4MKbX28/+MQvPk3MeWN3d67WDRsR4wIZ8v42mJpsCBbFuimqDnqWYjqOCrKW84XPaMUbW7Qyas
 aqRlo0voLIubjBpJJ9Q==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a259c76 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pydQ_VjQ2XfJpekr5b0A:9
X-Proofpoint-ORIG-GUID: aBZmE2ht22uieLLq1hmjsxrkhyrNdPYO
X-Proofpoint-GUID: aBZmE2ht22uieLLq1hmjsxrkhyrNdPYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070160

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
index 757f58960198..c4fa71a341a7 100644
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
+	if ((d <= s || d > s + n)) {
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

