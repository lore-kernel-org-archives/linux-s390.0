Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3A54705D;
	Fri, 18 Sep 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721343; cv=none; b=GOImRzrOIy7LoHt7cp/bLsH5CtZwAcU+zHDdebZqUeuFr1XPCvuryNmtJ7duUOhHLhFPQAmSeHv5sHdQtUhUK5ohCaM33dSfOPAHV/REC6saXiissAa/iMZsyCtG6HSZ1aE69B3TvS0WEvZYVmiu2+SHo1aGCsM7suS/R8YyWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721343; c=relaxed/simple;
	bh=q3feutpAnSLBiMlQsf+M6LwHgqq6gRLSOi0PSsAsJHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwqJQL0Bg4kZOoIkXCRwvb+dmec43fkE4/DNsFrmWaQGJTvZO+MhK1EGI5XgjpNMzHEFondOXUINScB4tlGOQ/04ww1i7kpkH/mJUjqKUQRMz6hrcMK91QfZ43z0GYqgqrCSPMy1Aazx0ZRtpMFTr6NE3/f9xx12F+VOilIa1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KG6ejvD3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KG6ejvD3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61YNL457233;
	Fri, 18 Sep 2026 08:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yFttNDr/jL+XKYy8C
	gRbemN5SwM72xNcqWL7fq27Vso=; b=KG6ejvD30+cGIsIMbJy0DyJDPzpPJQ+dd
	untJ6mG69toqvfDTEL9UrlHZgIcJukiEfot1At8lJ9YVocwyVb5D7wGZze+C5qfb
	eI/hB09e+xQqlzAYxaVgyCfaK9u5MOpxtw/i0vIaRYCFPTwowbr1xWySOce6x3k3
	17UAjdYeJ5k3GCRDC7bJk6LDf/kcX3MVKToxT8taC0tqcyxwZrfqxOYdFlUUS7of
	YBGPeYVmfzzVup3W+oeisv2yg9HaDSEDF6HBJjnrMCtsYDowBvxhz7zmnHTsiGxY
	3697WObGwFonRsmoKHUCfPK8F5hEx68yMb/sgPzD7DDQT0NYAKIMA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx8474j0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I654sj1154899;
	Fri, 18 Sep 2026 08:48:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gep530-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8mheR38011168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D28B420040;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D7E02004B;
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
Subject: [PATCH v2 05/12] s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
Date: Fri, 18 Sep 2026 10:48:35 +0200
Message-ID: <20260918084842.2333237-6-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX8NseTISAMJ39
 rs3aQkzkrEU88yiMYPpT2HMrGdvFN8M0ooaCbk2xLn6UNzhrti3E4KR4/OdH4j36MUhLov50kr+
 5EkLydFA3yu17iULwUQTR7SMMkxud/CuKiHgymFz5CZCrZ5rAV/bJoaOgRqwuAa+bWog7m1bgBO
 ssUGSTHLIrITtDR3K4DqrF6GE6/Na/xxoxAcFd2DOOJiz6F3Cmf9WOpvQry3UHWR87ZtYqh5j5M
 nG0m0TzWeRp8ZNZj0lh/0H71CRJ2I2+TBIkAXt94hTbKFw/EPnFZiIxcUa1W6d/Q1iSeeJdE5fd
 doSV24F5afeuZcDC/3mp8S/MX7DvjXSj4I6F4RRyjoiLq5q1yEHKziCJK2/IGnbiXiyaUsQ2CD/
 nes4z6vuYP1+focJZ6WfBpnRivd1QlN155D1hsd+lM/IO781wF0LOc7L/Fh2mQFGZGqQ34EnrZh
 IMMDMtM1T4cjUre2Kdg==
X-Proofpoint-ORIG-GUID: CZQYDhUZy3QUUiqg8nTKycYiANj96buP
X-Proofpoint-GUID: CZQYDhUZy3QUUiqg8nTKycYiANj96buP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX12MCoaWr7rIu
 kJ3AS+fFyVWwV2pmcqfZhHHz42smrVH4CFMgRlcUdMfIBl+0sX/rS1DWIZyueArOphueVZX6761
 WMzVa+iXQM7Vw4wOdlrPP612ZW1/fj0=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aacfaf1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-b3gUV1w4jwK8yCUv9wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180117

Define LC_PERCPU_OFFSET and LC_PERCPU_REGISTER offset defines and use
them in percpu code. This shortens the percpu inline assemblies and makes
them a bit more readable.

Note that because of header dependencies it is not possible to use
asm-offsets. However to avoid adding more dependencies to asm-offsets
it seems to be preferable to use the current approach in any way.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/entry-percpu.h |  2 +-
 arch/s390/include/asm/lowcore.h      |  3 ++
 arch/s390/include/asm/percpu.h       | 47 ++++++++++------------------
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/arch/s390/include/asm/entry-percpu.h b/arch/s390/include/asm/entry-percpu.h
index 4ef47265cfce..89c9e44f6f83 100644
--- a/arch/s390/include/asm/entry-percpu.h
+++ b/arch/s390/include/asm/entry-percpu.h
@@ -49,7 +49,7 @@ static __always_inline bool percpu_code_check(struct pt_regs *regs)
 	}
 	if ((insn & 0xff0f) != 0xe300)
 		return true;
-	disp = offsetof(struct lowcore, percpu_offset);
+	disp = LC_PERCPU_OFFSET;
 	if (machine_has_relocated_lowcore())
 		disp += LOWCORE_ALT_ADDRESS;
 	insn = (disp & 0xff000) >> 4 | (disp & 0x00fff) << 16 | 0x8;
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index f0364a9f8a19..f4517bbe405b 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -222,6 +222,9 @@ struct lowcore {
 	__u8	pad_0x1900[0x2000-0x1900];	/* 0x1900 */
 } __packed __aligned(8192);
 
+#define LC_PERCPU_OFFSET	offsetof(struct lowcore, percpu_offset)
+#define LC_PERCPU_REGISTER	offsetof(struct lowcore, percpu_register)
+
 static __always_inline struct lowcore *get_lowcore(void)
 {
 	struct lowcore *lc;
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 3bc448c4c2dd..770fe4be65dc 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -14,17 +14,16 @@
 
 #define arch_raw_cpu_ptr(_ptr)						\
 ({									\
-	unsigned long lc_percpu, tcp_ptr__;				\
+	unsigned long tcp_ptr__;					\
 									\
 	tcp_ptr__ = (__force unsigned long)(_ptr);			\
-	lc_percpu = offsetof(struct lowcore, percpu_offset);		\
 	asm_inline volatile(						\
 	ALTERNATIVE("ag		%[__ptr__],%[offzero](%%r0)\n",		\
 		    "ag		%[__ptr__],%[offalt](%%r0)\n",		\
 		    ALT_FEATURE(MFEATURE_LOWCORE))			\
 	: [__ptr__] "+d" (tcp_ptr__)					\
-	: [offzero] "i" (lc_percpu),					\
-	  [offalt] "i" (lc_percpu + LOWCORE_ALT_ADDRESS),		\
+	: [offzero] "i" (LC_PERCPU_OFFSET),				\
+	  [offalt] "i" (LC_PERCPU_OFFSET + LOWCORE_ALT_ADDRESS),	\
 	  "m" (((struct lowcore *)0)->percpu_offset)			\
 	: "cc");							\
 	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;		\
@@ -144,13 +143,10 @@
 
 #define arch_this_cpu_add(pcp, val, op1, op2, szcast)				\
 do {										\
-	unsigned long lc_pcpr, lc_pcpo;						\
 	typedef typeof(pcp) pcp_op_T__;						\
 	pcp_op_T__ val__ = (val);						\
 	pcp_op_T__ old__, *ptr__;						\
 										\
-	lc_pcpr = offsetof(struct lowcore, percpu_register);			\
-	lc_pcpo = offsetof(struct lowcore, percpu_offset);			\
 	ptr__ = PERCPU_PTR(&(pcp));						\
 	if (__builtin_constant_p(val__) &&					\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
@@ -162,8 +158,8 @@ do {										\
 			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
 			: [val__] "i" ((szcast)val__),				\
-			  [disppcpr] "i" (lc_pcpr),				\
-			  [disppcpo] "i" (lc_pcpo),				\
+			  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
+			  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	} else {								\
@@ -176,8 +172,8 @@ do {										\
 			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
 			: [val__] "d" (val__),					\
-			  [disppcpr] "i" (lc_pcpr),				\
-			  [disppcpo] "i" (lc_pcpo),				\
+			  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
+			  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	}									\
@@ -188,13 +184,10 @@ do {										\
 
 #define arch_this_cpu_add_return(pcp, val, op)				\
 ({									\
-	unsigned long lc_pcpr, lc_pcpo;					\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
 									\
-	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
-	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
 		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
@@ -205,8 +198,8 @@ do {										\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
-		  [disppcpr] "i" (lc_pcpr),				\
-		  [disppcpo] "i" (lc_pcpo),				\
+		  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
+		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 	old__ + val__;							\
@@ -217,13 +210,10 @@ do {										\
 
 #define arch_this_cpu_to_op(pcp, val, op)				\
 do {									\
-	unsigned long lc_pcpr, lc_pcpo;					\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
 									\
-	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
-	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
 		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
@@ -234,8 +224,8 @@ do {									\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
-		  [disppcpr] "i" (lc_pcpr),				\
-		  [disppcpo] "i" (lc_pcpo),				\
+		  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
+		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 } while (0)
@@ -249,12 +239,10 @@ do {									\
 
 #define arch_this_cpu_read(pcp, op)					\
 ({									\
-	unsigned long lc_pcpr, lc_pcpo, res__;				\
 	typedef typeof(pcp) pcp_op_T__;					\
+	unsigned long res__;						\
 	pcp_op_T__ *ptr__;						\
 									\
-	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
-	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
 		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
@@ -263,8 +251,8 @@ do {									\
 		MVIY_ALT("%[disppcpr]")					\
 		: [res__] "=&d" (res__), [ptr__] "+&a" (ptr__),		\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [disppcpr] "i" (lc_pcpr),				\
-		  [disppcpo] "i" (lc_pcpo),				\
+		: [disppcpr] "i" (LC_PERCPU_REGISTER),			\
+		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (*ptr__),						\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
@@ -278,12 +266,9 @@ do {									\
 
 #define arch_this_cpu_write(pcp, val, op)				\
 do {									\
-	unsigned long lc_pcpr, lc_pcpo;					\
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ *ptr__, val__ = (val);				\
 									\
-	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
-	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
 		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
@@ -293,8 +278,8 @@ do {									\
 		: [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
-		  [disppcpr] "i" (lc_pcpr),				\
-		  [disppcpo] "i" (lc_pcpo),				\
+		  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
+		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 } while (0)
-- 
2.53.0

