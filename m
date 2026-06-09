Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410DE3F44CB
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001232; cv=none; b=qspiSLqf9RuMKZ1L+7t4kKDmS/lyMEMKjlIyLBRFsPwSJpbJdLwfC6dO4oMc2SkedZt/w1yHtDTDfFIY1zR2aQZE57gEzqisH1S31P1tljjz3keNhGDlIAklaHLh1E8O5k5POhHIlRFdcUztECJtvsor/QxTHKI/KtVAgjYO7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001232; c=relaxed/simple;
	bh=lysENYoHh3MDOQhpcDyEOx625vpujoEcq+P51XsBG9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQhrYXl2rCSpHI3QNeGaOCao08EoJ8kbsFO987fvjPXL5blluok92ogTzlD/UBlOOfy+qi2YP/UOX4O1sWMpS0tk181d3fdtZ3FAQ5ExObi06NwUkDyJocUdRCEDZLp1Dfr/BqyvtiTD3MRzKF0DQ0H3bdEespv15U3GcA4VfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TBlORvD4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TBlORvD4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LNG472714682
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Rn4StBVck3XjzgdKE
	ka/R4IpfeDJYyTBQkT1fO8junE=; b=TBlORvD4ODZBa1+g3QItExf6C5oO0Q9/v
	I0Ypg7ghCJZ1JLMgxBO5tuvDym31lOlprk1OttotWiZC/B0hLMnUk9mnHMNTu8kZ
	ssNt7ZEtD6xYB10QemxjSCw6w5Ubl6rJUNefIbocL2iazhxGp6SdCSJoolAW4mwB
	0TuUqoSzLNAxfLi32nU0tVEQ9j0viXfXcrdSvCAZkLn5jjUsB8jiiTeCdhn4VaII
	BbOI5dNckxztihjFDjHlj63j6I5WFzJjyAgnm3/4t8UEoNXGq6UXjHyy0c+5qISi
	e57rMMzqVGYsF65sSp8nz950XOGtqBjpe7GAvY2xtSmvdACtelOYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sucmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJcZs009192
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjshfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXi6a47841744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0CDA20040;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31E62004F;
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
Subject: [PATCH v3 4/9] s390/string: Convert memmove() to C
Date: Tue,  9 Jun 2026 12:33:38 +0200
Message-ID: <20260609103343.107325-5-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 389j4_fwrfRk1SY6-jNmyG2MX8PhmV6Y
X-Proofpoint-GUID: 389j4_fwrfRk1SY6-jNmyG2MX8PhmV6Y
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a27ec0d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=g10tabKwrLm7Pky2vL4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfXxaOButX4Y+xE
 3cshhmb1fMzQgI419x7xYHQQ6k3BECTgQVBuB4vevA70x08SLgkWORJB2Q24Z4bCpnh9fltVlFB
 ltZ1e/4qw36FE57HZMyEo1Z3D3rTQnPoBOxp7f2wrROQFAl1vdSQ7NiBPKQpHyWmAUrsVXpCljA
 U5q7cnMseoFmRJRSYP+528x2LQ0YCc1d8UgHcFUOpxs03yrS3UbjzRBPicswbPIenLLBvWuQfA6
 fonpQ1RFnPGLb4nHiP0RjAgcx23z9BN1ibdcZ1eMg2v9gvpdTDHMEh62oQt8O2qJBrQv9ngU/Fy
 Kj8UqBHGMswaq08AvRzLcOZm6TSQAVZGY9mPqNrVkEwk6AQLqrW7tvb3rnvesfQPYIYRaGu1AHa
 NE+Tejn/gyqCsalIw4cZCHVq4RDk5Kmeq5twki90QI+2m1VJ+bvgZXRVasKkWtrpTTeZdbzEgqe
 KKRpcL4AB9cO5Oz7EhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090094

Convert memmove() from assembler to C, which should make it easier to
read and change, if required. And it allows the compiler to optimize
the code, and use different instructions, except for the used inline
assemblies.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
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

