Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E244B0E49;
	Fri, 18 Sep 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721340; cv=none; b=G0y040FNruS/r227N7TzVD1aJm5M7dbkZGZx/GaASRTXzpwxh4ji/6G1i3nJqyMSjV2G9FbJFolCJORW8Da/c9XgfSReJl+uaYcdyiyHhYW7mbwlDpWEX5WAPumtznTxoQtvAupZytMjZnAcuVjkhDsjLBWE5T07sGMjBy45dMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721340; c=relaxed/simple;
	bh=L9Ij3getWBZq07w9zFlUy7KUk7sMBLlhVRMHwdYIPrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knL+ub6zigm0mDtf/LPco7wd1Y0KUmg/VPy177sjOY8V1bO3uGcswww9NWsGACHURyd4ki6Q5FiKioHDbXrmmtv+apxWuRI7Cff97rZims9eutZYx4Jyce3XlXKMbwm50NmOA89BF2ZOWJI04owWa7rNI9v/4vv94SmG/0BDyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=USzqvRr2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="USzqvRr2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61fsK3490016;
	Fri, 18 Sep 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6vkX4/4srtGVL00eB
	lnDW3Vf7ORPxfh/h7S4hVZQJQs=; b=USzqvRr24CHcQN119BA9FbIg7EkZQZYWI
	q1oct3x4PDlv7xdeKwgdu80IjcVEXntmAPKYwQOsuqRqwodKf66MTxmu+cZBw+4g
	HVsz6k9evRND6ZJE9AD75YUB+wdcmfjuFJerTMihSQQ8yKPTVKOiJ5ieOP3APXMK
	XCoMbkthtgUZEvZpJ1yVvCT+/sfD1+Od8PVehJ7RCnMY2oMwejHDPL9thbaVcdww
	rhTB8lmZrlXWODJoOZu+DODF7jAp9PEXLzKNH4acmCQHjRrBqjJ8Sr5sZyVU0dT/
	Fq4xln8uf5//wi5CjoJEwtVgbQOypdyfJriAREhkO1QBviE8HLHMw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eendn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I655eq208479;
	Fri, 18 Sep 2026 08:48:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa6ewe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8mhnA38011166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9810120040;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62CBA20043;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
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
Subject: [PATCH v2 04/12] s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
Date: Fri, 18 Sep 2026 10:48:34 +0200
Message-ID: <20260918084842.2333237-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918084842.2333237-1-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX0qpMPW6Z3F5m
 nvhHkIUDzG7P58H2NnWYn6t78udmy5NNb5px5EqkHgWIBlcXcy3El261ukBGmJgvTcasMOd7GCR
 EqVqZFVxFwo3sy81Hu/SmMdllF+bAp6ii4uZBp7xQ2VTwzAZ90qEUgCYGLrj3AudTkHNm+DKP6L
 QcD6WKw1rUSLOjz9iCy/Q1s/2nEsWeYK2FKh5hEX70YOpEKX46ef9IVqLwwP2BzdxAj3/lVfOGX
 0bSDwZ3SouJLMw0bwlEk8EMyj2EU1M/VZCOipPX9IBSHoJUmVC0iDBjueLZg1hQ/yxrobduZPL6
 372uXVV+s+LUPN0hRjwyaYHqlnJ52Ma+BmwzBzUd46+3Mj5qSfMBHABqn5a0uiJNK9vw7uLFCsj
 JK2zg0y7Eg3ZaxP405LLqdpDWTCup4DIgkrqZEVX/4ykHau50itzYG40k20/SrLEF2dYE1XWQdK
 AwMxdmwxo1BlcnGaTkg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aacfaf0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=WUj23-fQfn3YcGJ_ZbEA:9
X-Proofpoint-ORIG-GUID: jtZjQXOskH2ppQ1dFX39kXF4IhdF70Us
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXygQhBdXsvlzw
 6gCtcujJODwkyqtnvi6bILESs3gteSzfw0YfirzbJib+2sa8e7BU/Dx/NGPQl9PKBvi6EduEKBQ
 r5uhLS7QJ1eFhvRT3NAyxXGr/1uPqnM=
X-Proofpoint-GUID: jtZjQXOskH2ppQ1dFX39kXF4IhdF70Us
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

Let MVIY_PERCPU() calculate the alternative lowcore displacement instead
of passing the same value(s) again and again in all percpu inline
assemblies.

This shortens the inline assemblies and makes them a bit more readable.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 68 +++++++++++++++-------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 9888b38dedab..3bc448c4c2dd 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -99,7 +99,9 @@
  *   MVIY_ALT(...)    <- end of percpu code section
  */
 
-#define MVIY_PERCPU(disp, dispalt, reg)						\
+#define LC_ALT_ADDR	__stringify(LOWCORE_ALT_ADDRESS)
+
+#define MVIY_PERCPU(disp, reg)							\
 	".macro GEN_MVIY disp, reg\n"						\
 	".set	.Lreg,255\n"							\
 	".irp	rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"			\
@@ -112,19 +114,19 @@
 	".endif\n"								\
 	"mviy	\\disp(%%r0),.Lreg\n"						\
 	".endm\n"								\
-	ALTERNATIVE("GEN_MVIY " disp    ", " reg "\n",				\
-		    "GEN_MVIY " dispalt ", " reg "\n",				\
+	ALTERNATIVE("GEN_MVIY " disp		     " , " reg "\n",		\
+		    "GEN_MVIY " disp "+" LC_ALT_ADDR " , " reg "\n",		\
 		    ALT_FEATURE(MFEATURE_LOWCORE))				\
 	".purgem GEN_MVIY\n"
 
-#define MVIY_ALT(disp, dispalt)							\
-	ALTERNATIVE("	mviy	" disp	  "(%%r0),0\n",				\
-		    "	mviy	" dispalt "(%%r0),0\n",				\
+#define MVIY_ALT(disp)								\
+	ALTERNATIVE("	mviy	" disp		       "(%%r0),0\n",		\
+		    "	mviy	" disp "+" LC_ALT_ADDR "(%%r0),0\n",		\
 		    ALT_FEATURE(MFEATURE_LOWCORE))
 
-#define AG_ALT(disp, dispalt, reg)						\
-	ALTERNATIVE("	ag	" reg ", " disp	   "(%%r0)\n",			\
-		    "	ag	" reg ", " dispalt "(%%r0)\n",			\
+#define AG_ALT(disp, reg)							\
+	ALTERNATIVE("	ag	" reg ", " disp			"(%%r0)\n",	\
+		    "	ag	" reg ", " disp "+" LC_ALT_ADDR "(%%r0)\n",	\
 		    ALT_FEATURE(MFEATURE_LOWCORE))
 
 #ifndef MARCH_HAS_Z196_FEATURES
@@ -153,33 +155,29 @@ do {										\
 	if (__builtin_constant_p(val__) &&					\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
 		asm volatile(							\
-			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
-			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
+			AG_ALT("%[disppcpo]", "%[ptr__]")			\
 			op2 "   0(%[ptr__]),%[val__]\n"				\
-			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+			MVIY_ALT("%[disppcpr]")					\
 			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
 			: [val__] "i" ((szcast)val__),				\
 			  [disppcpr] "i" (lc_pcpr),				\
 			  [disppcpo] "i" (lc_pcpo),				\
-			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
-			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	} else {								\
 		asm volatile(							\
-			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
-			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			MVIY_PERCPU("%[disppcpr]", "%[ptr__]")			\
+			AG_ALT("%[disppcpo]", "%[ptr__]")			\
 			op1 "   %[old__],%[val__],0(%[ptr__])\n"		\
-			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+			MVIY_ALT("%[disppcpr]")					\
 			: [old__] "=&d" (old__),				\
 			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
 			: [val__] "d" (val__),					\
 			  [disppcpr] "i" (lc_pcpr),				\
 			  [disppcpo] "i" (lc_pcpo),				\
-			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
-			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	}									\
@@ -199,18 +197,16 @@ do {										\
 	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
-		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
+		AG_ALT("%[disppcpo]","%[ptr__]")			\
 		op "	%[old__],%[val__],0(%[ptr__])\n"		\
-		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+		MVIY_ALT("%[disppcpr]")					\
 		: [old__] "=&d" (old__),				\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
 		  [disppcpr] "i" (lc_pcpr),				\
 		  [disppcpo] "i" (lc_pcpo),				\
-		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
-		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 	old__ + val__;							\
@@ -230,18 +226,16 @@ do {									\
 	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
-		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
+		AG_ALT("%[disppcpo]","%[ptr__]")			\
 		op "    %[old__],%[val__],0(%[ptr__])\n"		\
-		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+		MVIY_ALT("%[disppcpr]")					\
 		: [old__] "=&d" (old__),				\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
 		  [disppcpr] "i" (lc_pcpr),				\
 		  [disppcpo] "i" (lc_pcpo),				\
-		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
-		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 } while (0)
@@ -263,16 +257,14 @@ do {									\
 	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
-		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
+		AG_ALT("%[disppcpo]","%[ptr__]")			\
 		op "	%[res__],0(%[ptr__])\n"				\
-		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+		MVIY_ALT("%[disppcpr]")					\
 		: [res__] "=&d" (res__), [ptr__] "+&a" (ptr__),		\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [disppcpr] "i" (lc_pcpr),				\
 		  [disppcpo] "i" (lc_pcpo),				\
-		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
-		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
 		  "m" (*ptr__),						\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
@@ -294,17 +286,15 @@ do {									\
 	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
-		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
+		AG_ALT("%[disppcpo]","%[ptr__]")			\
 		op "    %[val__],0(%[ptr__])\n"				\
-		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+		MVIY_ALT("%[disppcpr]")					\
 		: [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
 		  [disppcpr] "i" (lc_pcpr),				\
 		  [disppcpo] "i" (lc_pcpo),				\
-		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
-		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 } while (0)
-- 
2.53.0

