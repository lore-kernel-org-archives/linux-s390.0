Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6D4E36F0;
	Thu, 17 Sep 2026 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672982; cv=none; b=nHVL+6zIQRR7bz5kwY/AnMx3fxcWArgRt4PxEYF1zN3CWlo1kQrKS/UysQR52G72+fUM1+4sYH2iRBeiKbv1iNvUUNB1KJVdtEMxeXbcjGng61e2iy2aKiKG2Qe/uzpXeYoi0uhSRHOF3x/YF9CKFQR5g+lURvHD9T4BvLGja1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672982; c=relaxed/simple;
	bh=L9Ij3getWBZq07w9zFlUy7KUk7sMBLlhVRMHwdYIPrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgFU8iTMN1HTcXpaRZLzx4sViojtEGpwMEh4y+9pUYQWtpEYn2rlCFiq1yMMGGleV2NQfgW6h6nXFNwwvHFLsgyqTa/yATSlfoUb5Z21fGcENzYdXS0JD1MVsoo0pb1M+yb4UAt2Vdr1zEZ3OvJyZm0vHtw/8p2PdrtB+VvR9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L3ubibzX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L3ubibzX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVfWd2998433;
	Thu, 17 Sep 2026 19:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6vkX4/4srtGVL00eB
	lnDW3Vf7ORPxfh/h7S4hVZQJQs=; b=L3ubibzXtEfUw9jm9eYLv0i+D2BtnQt9v
	5iRvU861YJmUV+WWSDiQyXcAIK/0PE1qUGDsNAaXRqQlNgHV0XWmcKWTASa+bhCS
	VgpLhbGNl/JzPPD/5ZC4Sd2qI2JmHNv0akbOwQ/bkdmJzR7obBk60xfvFnEY5KU8
	scUz9xbRviuFVoDmjJnH6B4OmZf/e5HH50TBRbbfYXbT/jMmZsO7vyXdTOC1GMQ/
	ONM6ki+GlwUlO1x+6XwJ7LMXvK5pI+e4DQgvN51MgVicXfgfTaGADpmSg81gPXLe
	bIjr6gpHWRdow3NYN6bp/Msq3TzhvIuhI1KGLqFO/MciGksLuhucg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j458v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH9JeC3494081;
	Thu, 17 Sep 2026 19:22:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjm08b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMcEv38142430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57D5F20040;
	Thu, 17 Sep 2026 19:22:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F8120049;
	Thu, 17 Sep 2026 19:22:38 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:38 +0000 (GMT)
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
Subject: [PATCH 04/12] s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
Date: Thu, 17 Sep 2026 21:22:29 +0200
Message-ID: <20260917192237.638324-5-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfXzLoyztQWquHV
 YQUuc8BFkB8TcAJSSG2oZK7IKI0RtPRvCoN9X0sBaG7jC0rp2VAmUcT3eVu72MShl1k2HOW6Jdq
 LC4O1LK/wDqtiv4eAymznYmEBYvBFmlqzNOTG3qu3xrrSsX+hY9w3flTJbvP1lkLL/LmNMK15kS
 y0v5pJczrUMQpYTtDM5FVMGPc4u4GYrAZkvIEQ4SC7nAm1Gnf0DTH86+JU62k6Rw5HqcprgmAZ+
 ZwI/7IxFlTQe68E3y3whe5KzQLoI8uA2xof1gaqW0ImVOHLKoZDkrxOxrIP0xbbm7YP8hNpcLqz
 ybEmk7QwjFUvhBG/z6op7uOI2nR2f1zNCvTpfzLbi7mJCSEsOOaCs0YbO7MquBPOHeIpgcRpp5W
 81rz6LMRNTWVhJL4A6uKTLmdCSbzyU1YCEkV1ftQsUVLGl9xgOmUdxxkR4R+ugk3uxjAnU2xw9i
 aMFryAH3KyYO8MotSQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX8zSHW8tpiZDO
 WVdkLppdAz3qk+wmZkOFjwBVS87p2TE3yuF6qkhY0qNmNqPssYYgA60wCEkfYyUuKbq8GgDDfwR
 IQjuVisgf3+WSMW/ABdKRJgHoL+NI/0=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aac3e02 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=WUj23-fQfn3YcGJ_ZbEA:9
X-Proofpoint-ORIG-GUID: G8b-dYoKcWs_XPiIEYZuDSOAd9XG4bR4
X-Proofpoint-GUID: G8b-dYoKcWs_XPiIEYZuDSOAd9XG4bR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170272

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

