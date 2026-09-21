Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A145349C;
	Mon, 21 Sep 2026 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980026; cv=none; b=VasuL/RvvIP+mDTFHu1V42O5Z0pfA/hfgDg59+kXWVQVGQpXCTSwZIigzFaIlF3mIux5VIxFje5OWotfSXjPQSBKUxdnMTzrg55BSCBUf7aoZqVygNH8u1/trPiFYH46aCCUQ7II444x0xpdUSPNYPyqicSl2kM9XtGtoGkw73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980026; c=relaxed/simple;
	bh=L9Ij3getWBZq07w9zFlUy7KUk7sMBLlhVRMHwdYIPrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZEYvE+dR6QqiUnvYHyMgNb2dlctqmx/8k+FCJ2EZYKwZNcb6ILAgWEUhhOm13q4EK8RKG6MhZiIKkIlsa5SOpzk83WQYEv313VGaCcBUfDFCrpNug5MrpOQywOY99lMSxcpHQGXYHRG4+ytIYR7yzqf20RCsllDug5tMhi44N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NggU4CNu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NggU4CNu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZJFs829714;
	Mon, 21 Sep 2026 08:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6vkX4/4srtGVL00eB
	lnDW3Vf7ORPxfh/h7S4hVZQJQs=; b=NggU4CNuYT1IqkW3pHMZ3aVyNeapY6FXI
	f9ZamZR96qdcIc/ih+tpYLqTEQZoFB0tIUF5hLlBj4vaRKUqnh8dm+ZwkXxY/4fX
	ki7uiAmSQLCk/+N/mLdET6hFUpi4QfRZ/laXSFEQduT0znHNuHJzKwQ00x240n3l
	3jtvl1m6rNHaEv6yaH87Q7jsXWdHNP6mTGecOOoFdDe6rQTFLwZhTuHHSMuagNFv
	ZhuoKLac0He+98l3AlFV443invr/nv85t7dFgtq7U0ckBz8hS4etyXjnkaK0kdgP
	0ZDOI3QVi8ql62zuHuwLGIL9YkWVOnhFsSsGH+EzjnWd02XJoaeHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgryjan-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HeRE887375;
	Mon, 21 Sep 2026 08:40:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gme72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e7mQ55705892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6625320040;
	Mon, 21 Sep 2026 08:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FB6520043;
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
Subject: [PATCH v3 04/11] s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
Date: Mon, 21 Sep 2026 10:39:58 +0200
Message-ID: <20260921084005.4022574-5-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab0ed6c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WUj23-fQfn3YcGJ_ZbEA:9
X-Proofpoint-ORIG-GUID: ghlpNgB84xxYrOnKZqr_L8avsuWZ2qBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX9ttILk8AXVDc
 6oGXFiHcNGlhrNa9A1PCxm68rbvOtG8f8rs63R7pglH7ah1GQAnNs+HcGApfkTjarbnJ/qXmYxQ
 gFH1e/5S9U8rlQYUod/AW5oBKfic5k5u5skA5nutACAD4PteU+DSMPi+kvPQu0EIdFmBIe9jKah
 v5kaSrM4dfMWx1qwr8wCww1zGGUeFfXamE3vkIbj8PC30NaZpsgzthpRoEod1Xo6I5DimHlriru
 QLNXwT80Tl2k3hKHSo7OBvEooV9r0zox544XRtvqVsrtWqfRNTf/K5Huj5YJrNgPH6K3B44xlLZ
 1cjFv7W56Lh6FA73NsOPCjGEdH0lIfJDKxVRT0UNkhaPIykMBWqvQ2yKB00ah5LQs/LK9JD3UHf
 WZovCgvk0cOBkRDsWT4OONH83eGu+a5BGeb+uB+s6YcpvoJh1mtgkZS7HR8/iP+rQwH0xidc05W
 Tx6+yyLyfBnIDmQBPhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX34LNdJ2J4l9D
 7sXEOIZ4vlT/OML/rRG9M3skJlCzbxzLALrYbJKq/pLpNfGnXIuVPtybXGv7ULExEkNkwa4VVDJ
 ggksMltvwKWf2BLFk+T8laXqQn1pqlo=
X-Proofpoint-GUID: ghlpNgB84xxYrOnKZqr_L8avsuWZ2qBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

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

