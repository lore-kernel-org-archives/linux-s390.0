Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A2402428;
	Fri, 22 May 2026 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459198; cv=none; b=f9uh1xrcIKwqGuvlL5puJnEZNK81vLqj6nsgsMli3p2qtRyjhYYUcfoLLItll8HSyVcpCuCoOUn/46DG6/BlrB8fKJmUcWVepNe/Tqdinq3cR488vExAPBwLWR9B+BzxkElyyPsA7E8QVLtVebr0+mmEXFxaeNjCp/sU8gwFE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459198; c=relaxed/simple;
	bh=sGHtPgqRyGymhZBuROEwH1odH0nmdeQ6hAqZerhhFHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOOlCScn78+fbbp63t3WsgqXJhTyg7hVDWWJOIRJv/yte+oClsvavwGSawEMfZmPFuw4b/U+KyaMDY2DhXXLuR0KMOPMDmrTmU+LUJlW4ERncq44RkLh+l4h3La5W0PlQ4m8CR1srIMdqVi23iSIVUPydBr59mnXN5l8XAGamAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eNURgifk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eNURgifk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M5vx3D3991718;
	Fri, 22 May 2026 14:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DdArDXsLaP5gy6DIj
	K0XhME+n5TSc7pgL2hQ0CfDqcY=; b=eNURgifkyvRGr4K2Ucvrrhuzuipn+aQCA
	WW0ICkvMlQtz5xvCKXQdxiFdyI122s4yRuErC7VnymWJDkydLTb/DTOJFeP1E1nJ
	pnaTdXArxZsPYPCZwS11roM8jzkmZlfiBP4qtzJdYBE8znM9EnO4oLKhAAk2Gtff
	0V2YWIXY2agh7uct2gYHqFPzJQd+4fhsgBVRm0vbzhDlLb5/ZTpVi+6BuYmV2wxZ
	vv94AnFA5hVYUCx/b/OlNev7UBYXC/CbjnkGDAyzBeBe6jaAi5fM0L/sVK73fWIW
	W6b191x6nqWb+v1os+MUL/LlJY9r2yIoV8eiYZJel4lOlcC0xdslw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8tsp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME94U0028422;
	Fri, 22 May 2026 14:13:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqhea6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MECw4262914972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:12:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5C012004D;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 966BD2004F;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        David Laight <david.laight.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 3/8] s390/percpu: Use new percpu code section for arch_this_cpu_add()
Date: Fri, 22 May 2026 16:12:52 +0200
Message-ID: <20260522141257.303617-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522141257.303617-1-hca@linux.ibm.com>
References: <20260522141257.303617-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfXxbWOYpepUwtM
 MgtUAacbL8fEA1TZgs/3gKPc7FAGYExjYk3P/hM8f5VvK2RfXr0ivNVd7JWH1J88TFYl6cr+Kcw
 z+qJqgWYF0D9IkxZge0E0eCGsEF2rehPVqs86ggA5rI6XoKORAIeeD12Q+uvufIwBBnOh4MGKs+
 pL6PdKh4BR0XiDTiebmIj+gfxoepD+kRTAF5zs9RrpxZew6tFC9hsN79ExdNnrUZLB8HI5DpSeS
 bYd4Kui/PbmewcG6SreW22p9X7Ksh5IgMgZwb5Yak9MJanBsKyqapzMz8TOkzqSrhnhTmUFINE5
 Ctj+hfDcAX/JqJwCF/doAb1dPlPtGXVNy19qrvQ8v9P3FLjgStKT0bD6MITWaUe/EiS7r3LRv4c
 YWB/AEEyn2ew4KuEF+szHeYrvVfwhNG/gy2p3XzahRYwdi1nH4E7bbG6+Co+ptmPQbxo1tXQguF
 0A5s0eATCSeXdcWl5rA==
X-Proofpoint-GUID: dj8UldCM0SnvQGqNeoVqmmXkdk9dwmPg
X-Proofpoint-ORIG-GUID: veREQf-N8j0MBtuHluveJHQUDTtcM7yf
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a10646f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SujZmW7ZfIunUtho7CIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220141

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

