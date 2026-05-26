Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7203BFAD4;
	Tue, 26 May 2026 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775031; cv=none; b=rZv29kyheprpx+bQ/izCILRlKEJWlbgI43kiLgrVR9ZFBzAGYroLeS+BJH5V+Gqxa98SCdhU62EWA8taNO3flV3IbPzp1YcNHtImyD3AxTWBVfoX3ZP0rGmfrPIZCuUQnEyW4PkzfNn1ViYESpNuroXWuExuCXISjsncATaCh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775031; c=relaxed/simple;
	bh=sGHtPgqRyGymhZBuROEwH1odH0nmdeQ6hAqZerhhFHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgEJH+j1KdxL1XNkYBu7uGCkWJeyOissO1Jiew+webEde5Xe2DnVlGrWqqGLaKrKzGMHd8hbnFI4WTLqs1c+aiRewhii5oEupdUcplB1eb7s6+GTBg8ht+DGYeHH2BXXVaAdpmlM/emRMazOfhxh0VjdlyAFjJvHF3oXOHdYqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lmNy4HVI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lmNy4HVI"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PH5kDP1745959;
	Tue, 26 May 2026 05:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DdArDXsLaP5gy6DIj
	K0XhME+n5TSc7pgL2hQ0CfDqcY=; b=lmNy4HVIB8Cy5GqrKWx6W0V0Xx6Dj0j9Z
	8sfzedrMeUO2NXt2hMzKLFJN1EI6IDpeIL33AokIwymi2L7kw+IBh1b1MmNsuEKU
	1ryTAMdEnGsEw0HxRDE2WFtzPsAlpVERobKcKFtVcoMA11sX/V7HXsoNCnbkclGe
	EPudguwlHb38xpEkf+5DSV53dv32onRnKCqPygjYClzEtYBQ83+SGZmryqje37c2
	MyR1UJPrjGMyBhG+Yzz55wEsePb3Gcmq2UZGnuvnaIymf0G8v3v6UgiX5j8qRHf0
	q5LCP0aL7RrIrBHy/CCdVPrKOtUMZG+kmEsaVrPdjD6jMnS3Bse4Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2ajh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5sD19022574;
	Tue, 26 May 2026 05:57:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxw02xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5v3c953215632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:57:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A195F20043;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 869222004D;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 3/7] s390/percpu: Use new percpu code section for arch_this_cpu_add()
Date: Tue, 26 May 2026 07:56:58 +0200
Message-ID: <20260526055702.1429061-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526055702.1429061-1-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8WremlosdwRyTSQwgOCSUV9jMD2rS4B2
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a153634 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=SujZmW7ZfIunUtho7CIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NiBTYWx0ZWRfX0vkxVPg3PTCg
 KXuREn8uWycP2THGj681qFox47B3PdWTJlDw58oE9s2sH5TP2IixiPmXYcUpeBixgztOii086f5
 wPlW2YtAN9GjVDVShnkR72jV8G2DQ3CXd7Lw4tHgYK4fC/1jMVK0Le68sxfw6rJ2DtVL3IuMAlz
 xC+kkSDReMid0JevlD85aop/mMmfVg2PnOCvJVI1zVX13QBvGS0fRBuQlQu8tnMzeq09FrmLDYV
 WS5U35oSm+xtDQ3FkwzXsY0ZSaAxDuQ/uUui0A1xAHAGzBk1NJoQrLCOLAHo+d1NqyndwMGB9YH
 d1pIRotr2VLXjfCl3//6FJ3CITL7v5YNs3z4MxNk//Tkp7t0VV5PF5Cr9UpifTwfKdOMZwtf86E
 Z1vBGdHAoDJqIOHEF2tqgjScbR4xdhnjSIAD342ATVljYg6iXeeBVfrHyIzK1FI1/KjSaW6hkeG
 140EAUYcGeIl4NNTZsw==
X-Proofpoint-ORIG-GUID: 8WremlosdwRyTSQwgOCSUV9jMD2rS4B2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260046

Convert arch_this_cpu_add() to make use of the new percpu code section
infrastructure.

With this the text size of the kernel image is reduced by ~76kb
(defconfig). Also more than 5300 generated preempt_schedule_notrace()
function calls within the kernel image (modules not counted) are removed.

With:

DEFINE_PER_CPU(long, foo);
void bar(long a) { this_cpu_add(foo, a); }

Old arch_this_cpu_add() looks like this:

00000000000000c0 <bar>:
  c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
  c6:   eb 01 03 a8 00 6a       asi     936,1
  cc:   c4 18 00 00 00 00       lgrl    %r1,cc <bar+0xc>
                        ce: R_390_GOTENT        foo+0x2
  d2:   e3 10 03 b8 00 08       ag      %r1,952
  d8:   eb 22 10 00 00 e8       laag    %r2,%r2,0(%r1)
  de:   eb ff 03 a8 00 6e       alsi    936,-1
  e4:   a7 a4 00 05             jhe     ee <bar+0x2e>
  e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
                        ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2
  ee:   c0 f4 00 00 00 00       jg      ee <bar+0x2e>
                        f0: R_390_PLT32DBL      preempt_schedule_notrace+0x2

New arch_this_cpu_add() looks like this:

00000000000000c0 <bar>:
  c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
  c6:   c4 38 00 00 00 00       lgrl    %r3,c6 <bar+0x6>
                        c8: R_390_GOTENT        foo+0x2
  cc:   b9 04 00 43             lgr     %r4,%r3
  d0:   eb 00 43 c0 00 52       mviy    960(%r0),4
  d6:   e3 40 03 b8 00 08       ag      %r4,952
  dc:   eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
  e2:   eb 00 03 c0 00 52       mviy    960,0
  e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
                        ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2

Note that the conditional function call is removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 65 ++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 79d5a4460b18..9140d81b7efc 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -135,28 +135,49 @@
 
 #else /* MARCH_HAS_Z196_FEATURES */
 
-#define arch_this_cpu_add(pcp, val, op1, op2, szcast)			\
-do {									\
-	typedef typeof(pcp) pcp_op_T__; 				\
-	pcp_op_T__ val__ = (val);					\
-	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp)); 				\
-	if (__builtin_constant_p(val__) &&				\
-	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {		\
-		asm volatile(						\
-			op2 "   %[ptr__],%[val__]"			\
-			: [ptr__] "+Q" (*ptr__) 			\
-			: [val__] "i" ((szcast)val__)			\
-			: "cc");					\
-	} else {							\
-		asm volatile(						\
-			op1 "   %[old__],%[val__],%[ptr__]"		\
-			: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)	\
-			: [val__] "d" (val__)				\
-			: "cc");					\
-	}								\
-	preempt_enable_notrace();					\
+#define arch_this_cpu_add(pcp, val, op1, op2, szcast)				\
+do {										\
+	unsigned long lc_pcpr, lc_pcpo;						\
+	typedef typeof(pcp) pcp_op_T__;						\
+	pcp_op_T__ val__ = (val);						\
+	pcp_op_T__ old__, *ptr__;						\
+										\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);			\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);			\
+	ptr__ = PERCPU_PTR(&(pcp));						\
+	if (__builtin_constant_p(val__) &&					\
+	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
+		asm volatile(							\
+			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			op2 "   0(%[ptr__]),%[val__]\n"				\
+			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+			  "=m" (((struct lowcore *)0)->percpu_register)		\
+			: [val__] "i" ((szcast)val__),				\
+			  [disppcpr] "i" (lc_pcpr),				\
+			  [disppcpo] "i" (lc_pcpo),				\
+			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+			  "m" (((struct lowcore *)0)->percpu_offset)		\
+			: "cc");						\
+	} else {								\
+		asm volatile(							\
+			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			op1 "   %[old__],%[val__],0(%[ptr__])\n"		\
+			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+			: [old__] "=&d" (old__),				\
+			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
+			  "=m" (((struct lowcore *)0)->percpu_register)		\
+			: [val__] "d" (val__),					\
+			  [disppcpr] "i" (lc_pcpr),				\
+			  [disppcpo] "i" (lc_pcpo),				\
+			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+			  "m" (((struct lowcore *)0)->percpu_offset)		\
+			: "cc");						\
+	}									\
 } while (0)
 
 #define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
-- 
2.51.0

