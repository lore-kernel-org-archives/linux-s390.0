Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F812F8E8C
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849785; cv=none; b=gGyI/+utIStNobRz2SqR4jM5J4NdM6lPBV4NWdIsfDcQncwG2zShppc1Ejok4yXxy/BK2GEZtwDyc7g+wAYfMmx31P5LrgKb0MVSdYiNH+PAtwm8zgJm3sHJNrGzqLcAK1eEWA4ig5mSCgi4RXlTkZIYJRxgut1SmFHzoHnLzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849785; c=relaxed/simple;
	bh=+KerS6qo8l0KV1tmC6QiPpeOdscReXCd47txIsWuxYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOhib0xR6VLl/huQS1Jk/zvH8SdlRBFRlSzf/Tw5Xgu6DAtr2Z9Gz0CWupWiBQo5LBAVI/l6qzzBC5VDodYUz2LQuwWuezrBJ9IC5Xaz5a9mL4JZsMcHz6JSLE4LEap7D+QyUVs7tq3mswH7lHlEmNd1OSQunqSAA90U2Lql65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JJvx17BQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JJvx17BQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6575bhAW3233093
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TANiplTgCrBY+epn5
	li63eaEZx0BEuzFNkoU8QfjKAs=; b=JJvx17BQrnxDwOspgtKeHB3Bz44umDg+x
	obmOzkPL8v68oZluVcfmgP6aj6tYViDoNVtqBkQBXDPwYmUdc2pwBKWeWmWeklQA
	CiM3IJy8a69UV41eVa3ANMspRqNvgTpQeLx7hEG6fYbd5aP2zsS4nZ63X5Gk0yxD
	dNWGEXA4PIUCOhGewWyMj38ekfAtx6Eqv7CnFlZJ7TWoCAB/MTbpiKrb+bxLsppb
	QQe3V8mFrJRrpAULV/On1qBQyCZ9Dk3D+5zh8Lh0se5tL22/E9JKEsDHnOKqDTw0
	cg7676MTXjnNAletKj8w94+7ocA4UAwUuXTSF8iooxr/f0LXe5IMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhmch4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJfoB027410
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjj1xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTcRm48628196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5403720043;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3598C20040;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 5/8] s390/string: Convert memset() to C
Date: Sun,  7 Jun 2026 18:29:34 +0200
Message-ID: <20260607162937.2927356-6-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfXwwvWkNX3nBl/
 EPqvADN14mMoaykUcZm+gKjF/GjMc9vHfqtQ8LUhowmOtT2tCdJHuCz1Wb4UYSYC5ZA5aDEhNut
 dsJqZiknwmXFCDocJB3fzBTPd7s4GyzxlicagZemSZtUcpwB8ItkKGV4S8KmKJzaQjZdL764VcP
 o4QmpfYkkSKqz0/oPvvtkzLR7DR48c6R9MA3QgMWIWAkgK33LJlgV5Otco4fGRHZMlsDv1083gK
 Vzxj6B0g2MieqAFNG8VGVgL/7WkfpzESslvvlL5cXxx1DO6gLqdFiRp/7nz2A2j/nj3MWYWUezg
 u63jGmvQzOAXR/KvYGIvbLtkjN5ogfKl34sNEyKNqCcwobDhvlRmwGSOFVxtfCCcqB1gr80VW6i
 ubcGkGrEUdg2JCCCDZWVNWNZ1Ic2dewDf2nEgB2mEbpVdJYs8EjqOli7vUaumhIy5+3JqKwpFZW
 Hr8Vdz36kerADZQ1zlQ==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a259c76 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pydQ_VjQ2XfJpekr5b0A:9
X-Proofpoint-ORIG-GUID: 8zMXvoIe2AMm7qZisbd0HKkImGSRXZ8B
X-Proofpoint-GUID: 8zMXvoIe2AMm7qZisbd0HKkImGSRXZ8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070160

Convert memset() from assembler to C, which should make it easier to
read and change, if required. And it allows the compiler to optimize
the code, and use different instructions, except for the used inline
assemblies.

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
index 557ef2e5a16f..957a27bc2aae 100644
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

