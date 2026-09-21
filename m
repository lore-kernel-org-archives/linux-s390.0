Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D53455629;
	Mon, 21 Sep 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980028; cv=none; b=R1r0Rx2TIO4JgdGZcx72MlSb6lyaWDv/c/nR66LhZD3gTv/5Ht7w7Fw0ww1TpKLAArVWt7Ky4fxZP/GR42ZvF/6GqWz2qeI1ScSKV07a8oCNbMcUgtwSxNm9Fzb3dKF8qIT5N9d0TUMFplBuz2v7lyT+4ZMLk+qhu4tDSQQOXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980028; c=relaxed/simple;
	bh=t9TxXk816GExzNpVYSmqUlYBgG7VeW2N+Tjgtmdde0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZfnoBIAqWk4TVerzpjEoNCOmmTwAQj+lzJ174mFmaEdreZiP+aJZhOc1ibJe4jncbKzClbKs+rwgNvkcniCkAnnjF1Qa+oJiCX5oMGX6YL0grZ5mGJE4fXHjO8TWYa6uUiuideLHDAtSaOeapu4JhkhHdHhZ6dUvH9d9lYniRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oU1U1djO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oU1U1djO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZOpQ818865;
	Mon, 21 Sep 2026 08:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I+wMOHFy9NdvIWSnv
	NOdy1HIVwDhgSU6cyZy/p8fcK0=; b=oU1U1djOWFE0NExBQpARbqWmNgb2vQ6TI
	kP1wFKz+9IR6lP4WJVCF3h115pXOknA6ovxvho7PVhSoBkP86BbuoBYvhXy1TDOp
	Q0QPMkqUKOow7SzQ3tpkTb7+3OwZGDRa9fxRirNeujv3VL5ozSzS2BEG2RaRIFXY
	m16+9ix9CbTXZTIR6DLzbwH4XoGAipMQnJGmazMilu7zvj2I+BlC7qr1GdXGOTJd
	Prt8OGP6kNGbLJ/YUDM1IvECajmYyQ8cpi3gLC1O73Es0Y7qdSrMxhF6jlp4LUZd
	0lMDtN29eIxb1KCn8wgrZeH8euJsTzDJFiKzTZY6kpz8dbd0KqEwQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg27jpk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HUGc930583;
	Mon, 21 Sep 2026 08:40:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt6xgcaam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e86L51380556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A5AD20043;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D413E20040;
	Mon, 21 Sep 2026 08:40:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:40:07 +0000 (GMT)
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
Subject: [PATCH v3 07/11] s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
Date: Mon, 21 Sep 2026 10:40:01 +0200
Message-ID: <20260921084005.4022574-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921084005.4022574-1-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2iziLwF8xrZuSOa9ZTiTRMtE3FZsZoSr
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab0ed6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=7qROLAO0VneCJbZu0JoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX+mNaNEty+t6Z
 LJA76BZR5WTiIoKxVhDzUj9UBbzkvrwqZ6n33jyZx2ovlVav+deJcCVH67nit80gpRPhxixMIuc
 VZQUxGyupTdtSfPWhiLQ3w2Xh4dmD3i+jHzNBf2tOTYS+vTd8ThDWnym2Xn7bdQetIoAdDD2vKa
 IEdknjf69/EXu7eRZud0Mm5Wuw2knddiiJ4RJMwjDl848wZalgQnk4B/ClPeU4N3bYlR0P9/A9p
 7ITn0UZbUvoh4leem6wSWGnxiYuJ9wRkbCzpHFVmcer4QFwrdKLsuORd+1vb2pH9koB83oueHw1
 Xw3HEo4uPGQm52Xw2fmSgrw0FmOzhSp55dSiLNQBb1BiffL/31dx9IK86A2D3dJHNIP3WubJD1b
 D0awGyXLD7c1+zUq9LuZZ+/z7DxGUYcRGqy280LrrBHkL3DGskE22EeoTkHO7HAVHb/XVkLMtOG
 dbXpihEx727Uz5fC7gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX45EsuLofuCYR
 XCDVs4/Cjl5ws73sw3Ceb4KRVyo2HVdJJLePntPgIluU1GazXGQom9Xc4VaTdovCjcbrdMabKKK
 LWJOFrHQCObAYCKbswWvHm7ornpUxuo=
X-Proofpoint-GUID: 2iziLwF8xrZuSOa9ZTiTRMtE3FZsZoSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

Replace the use of MVIY_PERCPU(), AG_ALT(), and MVIY_ALT() within all
percpu inline assemblies with __PCPU_BEGIN() and __PCPU_END(), since
the begin and end of each inline assembly is the same.

Also use consistent names: e.g. __PCPU_MVIY() and __PCPU_AG() instead of
the previous MVIY_PERCPU() and AG_ALT().

Furthermore extract DEFINE_GR_NUM and UNDEF_GR_NUM which are used to
convert register strings to register numbers.

All of this should make the code more readable. No functional change.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 83 +++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 0df47ec2e6c7..78c3aaa138f7 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -92,42 +92,49 @@
  *
  * Inline assemblies making use of this typically have a code sequence like:
  *
- *   MVIY_PERCPU(...) <- start of percpu code section
- *   AG_ALT(...)      <- add percpu offset; must be the second instruction
- *   atomic_op	      <- atomic op
- *   MVIY_ALT(...)    <- end of percpu code section
+ *   __PCPU_BEGIN(...) <- start of percpu code section
+ *   atomic_op	       <- atomic op
+ *   __PCPU_END(...)   <- end of percpu code section
  */
 
 #define LC_ALT_ADDR	__stringify(LOWCORE_ALT_ADDRESS)
 
-#define MVIY_PERCPU(disp, reg)							\
-	".macro GEN_MVIY disp, reg\n"						\
-	".set	.Lreg,255\n"							\
-	".irp	rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"			\
-	"	.ifc \\reg,%%r\\rs\n"						\
-	"		.set	.Lreg,\\rs\n"					\
+#define DEFINE_GR_NUM								\
+	".macro _GR_NUM opd, gr\n"						\
+	".set	\\opd,255\n"							\
+	".irp rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"			\
+	"	.ifc \\gr,%%r\\rs\n"						\
+	"		\\opd = \\rs\n"						\
 	"	.endif\n"							\
 	".endr\n"								\
-	".if .Lreg == 255\n"							\
+	".if \\opd == 255\n"							\
 	"	.error \"Illegal register number\"\n"				\
 	".endif\n"								\
-	"mviy	\\disp(%%r0),.Lreg\n"						\
-	".endm\n"								\
-	ALTERNATIVE("GEN_MVIY " disp		     " , " reg "\n",		\
-		    "GEN_MVIY " disp "+" LC_ALT_ADDR " , " reg "\n",		\
-		    ALT_FEATURE(MFEATURE_LOWCORE))				\
-	".purgem GEN_MVIY\n"
+	".endm\n"
 
-#define MVIY_ALT(disp)								\
-	ALTERNATIVE("	mviy	" disp		       "(%%r0),0\n",		\
-		    "	mviy	" disp "+" LC_ALT_ADDR "(%%r0),0\n",		\
+#define UNDEF_GR_NUM								\
+	".purgem _GR_NUM\n"
+
+#define __PCPU_MVIY(lcreg, imm)							\
+	ALTERNATIVE("	mviy	" lcreg			"(%%r0)," imm "\n",	\
+		    "	mviy	" lcreg "+" LC_ALT_ADDR "(%%r0)," imm "\n",	\
 		    ALT_FEATURE(MFEATURE_LOWCORE))
 
-#define AG_ALT(disp, reg)							\
-	ALTERNATIVE("	ag	" reg ", " disp			"(%%r0)\n",	\
-		    "	ag	" reg ", " disp "+" LC_ALT_ADDR "(%%r0)\n",	\
+#define __PCPU_AG(reg, lcoff)							\
+	ALTERNATIVE("	ag	" reg ", " lcoff		 "(%%r0)\n",	\
+		    "	ag	" reg ", " lcoff "+" LC_ALT_ADDR "(%%r0)\n",	\
 		    ALT_FEATURE(MFEATURE_LOWCORE))
 
+#define __PCPU_BEGIN(lcreg, lcoff, reg)						\
+	DEFINE_GR_NUM								\
+	"_GR_NUM .Lreg, " reg "\n"						\
+	UNDEF_GR_NUM								\
+	__PCPU_MVIY(lcreg, ".Lreg")						\
+	__PCPU_AG(reg, lcoff)
+
+#define __PCPU_END(lcreg)							\
+	__PCPU_MVIY(lcreg, "0")
+
 #ifndef MARCH_HAS_Z196_FEATURES
 
 #define this_cpu_add_4(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
@@ -151,10 +158,9 @@ do {										\
 	if (__builtin_constant_p(val__) &&					\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
 		asm volatile(							\
-			MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
-			AG_ALT("%[lcoff]", "%[ptr__]")				\
+			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
 			op2 "   0(%[ptr__]),%[val__]\n"				\
-			MVIY_ALT("%[lcreg]")					\
+			__PCPU_END("%[lcreg]")					\
 			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
 			: [val__] "i" ((szcast)val__),				\
@@ -164,10 +170,9 @@ do {										\
 			: "cc");						\
 	} else {								\
 		asm volatile(							\
-			MVIY_PERCPU("%[lcreg]", "%[ptr__]")			\
-			AG_ALT("%[lcoff]", "%[ptr__]")				\
+			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
 			op1 "   %[old__],%[val__],0(%[ptr__])\n"		\
-			MVIY_ALT("%[lcreg]")					\
+			__PCPU_END("%[lcreg]")					\
 			: [old__] "=&d" (old__),				\
 			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
@@ -190,10 +195,9 @@ do {										\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
-		AG_ALT("%[lcoff]","%[ptr__]")				\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
 		op "	%[old__],%[val__],0(%[ptr__])\n"		\
-		MVIY_ALT("%[lcreg]")					\
+		__PCPU_END("%[lcreg]")					\
 		: [old__] "=&d" (old__),				\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
@@ -216,10 +220,9 @@ do {									\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
-		AG_ALT("%[lcoff]","%[ptr__]")				\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
 		op "    %[old__],%[val__],0(%[ptr__])\n"		\
-		MVIY_ALT("%[lcreg]")					\
+		__PCPU_END("%[lcreg]")					\
 		: [old__] "=&d" (old__),				\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
@@ -245,10 +248,9 @@ do {									\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
-		AG_ALT("%[lcoff]","%[ptr__]")				\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
 		op "	%[res__],0(%[ptr__])\n"				\
-		MVIY_ALT("%[lcreg]")					\
+		__PCPU_END("%[lcreg]")					\
 		: [res__] "=&d" (res__), [ptr__] "+&a" (ptr__),		\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [lcreg] "i" (LC_PERCPU_REGISTER),			\
@@ -271,10 +273,9 @@ do {									\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
-		AG_ALT("%[lcoff]","%[ptr__]")				\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
 		op "    %[val__],0(%[ptr__])\n"				\
-		MVIY_ALT("%[lcreg]")					\
+		__PCPU_END("%[lcreg]")					\
 		: [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
-- 
2.53.0

