Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C913F483E
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001232; cv=none; b=d8IUd7D7YpJnCXoeeOBwrI8mBM73jz/DUI/il+tmA8hWHWAZMYyXgtn3Sryompk2xSVtqvCygBL7d0/RqkLUGtwqByMICtZ0g3S3VNNePx/p43Hw48wbLQE9COIMG7Ndj6KG1His5yujdVOaWYd31G7zNUztXPg2o6I/uGW175w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001232; c=relaxed/simple;
	bh=lirww1YR/RHQgU/C6EwYmKJPPJC7A8ht2RWvwRlBJVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rln6ibLw2PrD6EwF0IsEsNFGaiqqN22nzm23WiLkNEO6bnrt0Rl95US2w5PW1t5hUJiYWexQua0ENsHMfznCl+BnmRfmjdAeIJpKvt2aaf+qN30/TnxCddu6FEQVlLQTFVsXDxp6HOT4XQB1V+/HdonAYpK6FueViXh13HIgINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kug0iLgL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kug0iLgL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658JNGXA2688319
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jdBDm/vO7rpRk9X32
	8CRhlfUtWW4F8apLvDhPfTaNK4=; b=Kug0iLgLRJr7livHQvHNZomKWSeFk2oqV
	hgn2q6lnYYqR5t09ErEQyP50qAfO47OYnoF4XVsIqV1E86aJ5LhBENoSJyRhbIkF
	4+NQgwoUwHTQXLtoSnHfi2YFxolIGmEV7tOqMin091rbY9HRJlKkgpM/+LL4EAYx
	T8CakrLTC6+egOi8y/k5EfWTjxpCGC0eeoBvCedsARqGf6VfuLb/j9p4q/WDxNk5
	5dPj0i+ViZEb6cqTpZu9Aasc2eP7kJJTXcC3LYmfNBC8Ucgl/UyKko8dBiOruqgT
	3pZVamdq1s21M8mexC6YyvcBkbC1AHgna982UfKlmILdD9J2Z82YQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye3h2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJaUh003693
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy99n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXjIe25559508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 247832004B;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04E802004F;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 6/9] s390/string: Convert memcpy() to C
Date: Tue,  9 Jun 2026 12:33:40 +0200
Message-ID: <20260609103343.107325-7-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX4WHsUO0BFM+J
 QZMVw01jy8nfmk6rLPgUOOqpdTj8MxPmXBNFr/J2PSkwvOKwpu4iUx7csHziBY9TU6CnguzxF1O
 EcQe24qI0tU2LS6IAoHBZhhZ3me86R+w5ClxR3gTe/KbHyUsGxQ9MftATCHchkR9ls+ziwvCSNW
 L6GYlfpSv8FRdkPCFtaS/XnvybHQDlypvmAobTnwCuPTz4x2mHUY4kqnI3pCnDLIGEwgPp7ooaO
 mLA6JTVQAJvuKsnpZhRYdUDdbQIdscK9YR7LvOC+4KT99lgV4akPVplk8QiU8QZKVKterD+qVEE
 lsDkj0C9gIYz2SjZPHV6OUOThH5vij3k4rbA01QDwV4U2fRgcqWhAbujy4eK7pObtrNjyg/s4bC
 PXJ9u9mmOJMannpvZVqWKamK90CzQ68PDdGdffOCvynW/pLHOLfZduw4UsRj3KKX9RljNubEHnr
 IZbwBBatYgavv+mmcnQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27ec0d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=g10tabKwrLm7Pky2vL4A:9
X-Proofpoint-GUID: afz3TVVZPttYI2A8k-eYkFI_iTwS4-44
X-Proofpoint-ORIG-GUID: afz3TVVZPttYI2A8k-eYkFI_iTwS4-44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090094

Convert memcpy() from assembler to C, which should make it easier to
read and change, if required. And it allows the compiler to optimize
the code, and use different instructions, except for the used inline
assemblies.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/mem.S    | 31 -------------------------------
 arch/s390/lib/string.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
index a27b103d7450..d2e1ca87a568 100644
--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -11,37 +11,6 @@
 
 	GEN_BR_THUNK %r14
 
-/*
- * memcpy implementation
- *
- * void *memcpy(void *dest, const void *src, size_t n)
- */
-SYM_FUNC_START(__memcpy)
-	ltgr	%r4,%r4
-	jz	.Lmemcpy_exit
-	aghi	%r4,-1
-	srlg	%r5,%r4,8
-	ltgr	%r5,%r5
-	lgr	%r1,%r2
-	jnz	.Lmemcpy_loop
-.Lmemcpy_remainder:
-	exrl	%r4,.Lmemcpy_mvc
-.Lmemcpy_exit:
-	BR_EX	%r14
-.Lmemcpy_loop:
-	mvc	0(256,%r1),0(%r3)
-	la	%r1,256(%r1)
-	la	%r3,256(%r3)
-	brctg	%r5,.Lmemcpy_loop
-	j	.Lmemcpy_remainder
-.Lmemcpy_mvc:
-	mvc	0(1,%r1),0(%r3)
-SYM_FUNC_END(__memcpy)
-EXPORT_SYMBOL(__memcpy)
-
-SYM_FUNC_ALIAS(memcpy, __memcpy)
-EXPORT_SYMBOL(memcpy)
-
 /*
  * __memset16/32/64
  *
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index ff9c4b57b6f1..4dd524cdef5f 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -124,6 +124,40 @@ EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(memset);
 #endif
 
+#ifdef __HAVE_ARCH_MEMCPY
+noinstr void *__memcpy(void *dest, const void *src, size_t n)
+{
+	void *d = dest;
+
+	if (!n)
+		return d;
+	while (n >= 256) {
+		asm volatile(
+			"	mvc	0(256,%[dest]),0(%[src])"
+			:
+			: [dest] "a" (dest), [src] "a" (src)
+			: "memory");
+		dest += 256;
+		src += 256;
+		n -= 256;
+	}
+	if (!n)
+		return d;
+	asm volatile(
+		"	exrl	%[n],1f\n"
+		"	j	2f\n"
+		"1:	mvc	0(1,%[dest]),0(%[src])\n"
+		"2:"
+		:
+		: [dest] "a" (dest), [src] "a" (src), [n] "a" (n - 1)
+		: "memory");
+	return d;
+}
+SYMBOL_FUNCTION_ALIAS(memcpy, __memcpy);
+EXPORT_SYMBOL(__memcpy);
+EXPORT_SYMBOL(memcpy);
+#endif
+
 /*
  * Helper functions to find the end of a string
  */
-- 
2.53.0

