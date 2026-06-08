Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2636DA18
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897082; cv=none; b=OR2tKuxEP4sFt4L62Oq0+chNId5v/bCLApkin8vbQQ/9nZa1udgfgTbKf0ufHzxoyJdGcPffenwO78vrz6WH8C9/ql4hJNH6df7JJNaszrZiqk86dbxJf6NIDocARGgVHZn3R3fX+YGRwcYMTDIVVPEQlpccjaXx8mNlJyAUjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897082; c=relaxed/simple;
	bh=M3F3T93BcOGifLCXuTdbGVgy1iVHX3a3G/lcHIHBzf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqRi7IYN19hgpskm8qe0YzsStibau6WoX3rgutobO60KqjtFldw76lrfnCpfPURiTvS/KrRlLxHx8ddOCFBjMoSA02Oas6DPZadZSfwaSAALdoIvh21yzBCmN+BAjjImUzNBTXutnE5ggXvgXvNf6Gd6V6MQq9lfDLWoYFBla+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cePdOtQY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cePdOtQY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6579jpUS3404977
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zku+UpzP7KTNSFTGl
	VMD+DCscKGbK4cuo2U0kMnhSHg=; b=cePdOtQYBTKmAVSD1aV/6FX/yZkvMQWGf
	3IDCtAJ/0SeovT46/ysBwcEZ59nMCnm2nItIpygV+z19o3E6/UvrYPcuMHRNUN4R
	qP5VSnx9Z350NofWEOmt8ZL+Dhtl+op/d9Ump/rXL1x/6fgxSGS+B0DIz3hOSw17
	E38wUd0I1vwCdB0AiUMyJWOikNQHxoyL2g/yHLd/8sNoY4AKivRU+m/MxyqNWs4I
	0xagbjEHQ9QUgkx+04tTahaYzmEOvlkx2tQlj7lUT3yqysnen+vl6kc8euUj6QWe
	9gXNwFLvS7R4QYjqMjmXLnozo2lXS4rGCKOSuCGh3Vhb8YW55Prvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydwthj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585JhV2009916
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjkxfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585btR643057576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57B1D2004B;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3777020043;
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
Subject: [PATCH v2 5/8] s390/string: Convert memcpy() to C
Date: Mon,  8 Jun 2026 07:37:51 +0200
Message-ID: <20260608053754.571282-6-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX15CZNanNg/Dv
 ZnKV39Bs48gN/3nuUnfM7NOvxuM7k3Qj11DzfR6n7GCKjQTkTQ+hDahxL2uAB/gE9HrBBI1NPm3
 Pvvovqa42PXaU96BFv/qB+pusFQoBHZGwiIQK+8+P6ESrpXlwZBDKKVIRsCnbOFdIe011geiNiK
 GULssgGI4kk+LFQdsuTbxQdyDAW+Y32l7gsvP+J/rK9L1CE2SCZ3rTvAXAEtXioayKnrBCBvvqC
 oSFj60aUtQQpLuBFwT6YRleJAxHOQEbr3tIQ22QE66pdOOWwh5a5UYDpNEMeUOhMwNvW+8kTYU2
 79Re/bYp8E+JX/NiW/vfum6LICXETCu9bMwgaB8kBqwi1KTB5/TDXgTSGaX2nrDzpyy3Ew8WR2U
 onn9Y2KidbVZ9pCs/jmDXvu7sTFxzy45a4TAmqO2IMb8CRHYiXR4tJhkIhXMhD8s9FLkeBo+fxb
 oraQFS2HQmYqyHqsAmQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a265537 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pydQ_VjQ2XfJpekr5b0A:9
X-Proofpoint-GUID: RczFE8FFftiWpcm6McZcWQSonCgUl-4t
X-Proofpoint-ORIG-GUID: RczFE8FFftiWpcm6McZcWQSonCgUl-4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049

Convert memcpy() from assembler to C, which should make it easier to
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

