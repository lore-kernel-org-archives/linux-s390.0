Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92FB3DFC80;
	Thu, 17 Sep 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672976; cv=none; b=ubBdR2WfD2NpZRWMuGDSWfF7GAzTjrG3aZrWN90g768LG8CK51y6oSGwhc7S8wum7pygI2VTV/wkr+XVUXBJC11Te1QW1/sYv4XEjFpGQ3MigZ4bWnKkwdjdO9L651IANeaAhu00Y4LKURwbJVsiUG8Mq83KSjM1KspX5KQ+rlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672976; c=relaxed/simple;
	bh=hsSTMnOkgCVsq5THFPEcnlXpX+RhuzOtkcCqcE7Vxus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFKpfYWaoFuQqUC+Fl646rCluwMKIGz3OSQpN//sdm5/21OY17Cx/WjzQGBZUwZiKTRtYeLGDlghWCEz01g3VB3nz7gVQrgIiBMTb5PQiey1BYadskx1w/hWg/BwcQmNqUyRH6Uz1LoriZToZFzzMBU6bjj5oAv/wLKjZC/yEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n/L4MLtT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n/L4MLtT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVdtn3182136;
	Thu, 17 Sep 2026 19:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+aIXhE5xATl253AJX
	z4Do+ZDyBBQmjcdPIpnowKqkeI=; b=n/L4MLtT2KjsVN1O3i3FDSrtlpROp5lm4
	SwiilECJJ/o37omv0Aon2cIQgbR1QTYbQEUyaNjbUm1i55oQVcrM1EjaBe4rSQTK
	sM0Pj24NSl4+MUmodOUV/s/Vr6zGK7I5Wme+/Z8AMlcqmao3u+mN+CdEn2Db06Lw
	RTwO0d/1spgqAyVuYlOhaE0VVUmpW5TJ3H+fDYsHqcxdg+pkm9ZS3cRoiZ6L8Lm+
	ZUSR688Ghwfmcwxt6pAVwWuUbuqx/NM+CSTT6+41XZ7slKXBQF8EPjRa6qAsF4UH
	eBKf3BJZsaKk8QGfBoZFgAGM4W4wbQ06T/lwIh9MI+1TzsvNZopJw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvbsx6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH9PIc3494176;
	Thu, 17 Sep 2026 19:22:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjm08e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMdRP31982272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36EDD20049;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1342C2004B;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 09/12] s390/percpu: Use percpu code section for this_cpu_xchg()
Date: Thu, 17 Sep 2026 21:22:34 +0200
Message-ID: <20260917192237.638324-10-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917192237.638324-1-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX3QHPknr7cEJz
 6L0LZ5YmRMl+tEaYyXR6zJKIWSoutX35wzN5ZGKIK2OWNu3Z8f3OHgGERq6QCzg016nMNqQp7j1
 veIP51iXHD+eOZHF2E5SV8W/FWCpjyw=
X-Proofpoint-ORIG-GUID: TCcKDj5cmfRI2xw_Y22lf4eCEGg5O8rp
X-Proofpoint-GUID: TCcKDj5cmfRI2xw_Y22lf4eCEGg5O8rp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX2ymYAGTR0oSl
 lh3bbLP6d1aNQqpUXO+oNmptI/aPPfvjXR8DLiM1Xga6S0TlO4yNVvWYeSbxGK7d4PM4uLGbTS0
 o6u2Yz//LWGzsGUj37hEnC53gge3I0z0fjcSsTOSRsCcBF1rZt95h5OGO95qjQpVWRizaPnbi2T
 6IURG503oqZXbzA+vjq6gf3tSJSWPJKYzwtMc6qyyrd/F9w6L5CX9F/XtqtXPDW30H0WMLHQYyC
 7XREnMB28ofANUJMlpwMzWnvOLbiy1yaOyMhvPEoKndh15rJX1IBdauUv8iYQB39OmXBRF60hY6
 AjQhfa2JjC0kX2roL0WbfVYg5QJGsNDShL96YCQjCHe2yBGZ4GGA2TyjxFHgBMUA6gQUwNdB3Og
 A2wSB9t1jcfEjDxrNwk3R/6LiQGZm+Gn3TDoMfUu4Jrw8X72sU79J4Vgj90iNzAnbcfxQomBhnn
 MZkLB3Ez9dEsPjc887w==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aac3e03 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CR6qe3_hcmaCbRXVjxMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170272

Convert this_cpu_xchg() to make use of percpu code section
functionality in order to get rid of preempt_disable() and
preempt_enable() calls.

Consider only four and eight byte usages, since there are compare and
swap instructions for one and two bytes available. For one and two
byte use the previous simple implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 0eae65937c0d..237bf8c80843 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -331,7 +331,7 @@ do {									\
 	old__;								\
 })
 
-#define arch_this_cpu_xchg(pcp, nval)					\
+#define arch_this_cpu_xchg_simple(pcp, nval)				\
 ({									\
 	typeof(pcp) *ptr__;						\
 	typeof(pcp) ret__;						\
@@ -342,10 +342,34 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval)
+#define arch_this_cpu_xchg(pcp, nval, ldop, csop)			\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ old__, new__ = (nval);				\
+	pcp_op_T__ *ptr__;						\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		"	" ldop "	%[old__],0(%[ptr__])\n"		\
+		"0:	" csop "	%[old__],%[new__],0(%[ptr__])\n"\
+		"	jnz	0b\n"					\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "=&d" (old__),				\
+		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [new__] "d" (new__),					\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "memory", "cc");					\
+	old__;								\
+})
+
+#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval, "l",  "cs")
+#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval, "lg", "csg")
 
 #include <asm-generic/percpu.h>
 
-- 
2.53.0

