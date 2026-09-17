Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2F4E36E5;
	Thu, 17 Sep 2026 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672980; cv=none; b=CXapN6FjmXpYXjLdC3pAIEN0g4SYVlVlwLVar1eT0jZ/SgQZCH6j8/QYf6LMb7hjaLIWuptbumiV7+Mv4IFe9LMJBl4VOYPG/RF0QmB1dgghLg3Sq+oJWW++WqsGHVzTIHtTDQV1KcgTbWTGd5fgQx6jVJtysfpmuhXOJ07tEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672980; c=relaxed/simple;
	bh=eRKI4hMcS2Wg6ZS51a9HVHd1Gm00mnYcLUI0HEzLMX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyrl7bQwomudNwsdnVq9vxxXqryaDWSv/OxPXFFcOy4IqT8JZq5fr94cew/qruocyKCHXCKuV6/kaNLD9HhNDZ9Var9VrIAZN43w8gmGVDg29vImAZ5lNch7W/Eq/KBc5pRVDx0Xj2vgnnicYP/a7OIV8IaG2sqsFTQ6LbxGcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ptE01mX8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ptE01mX8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVXJA3155780;
	Thu, 17 Sep 2026 19:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t7kkPPAQLSU9pnkgf
	BPz6kp1jSQR3q76w6P8dKTtqXQ=; b=ptE01mX8LsThg6vToattb2KVExpbt88uf
	mujX7LA/6a0d4VqlCgwugkB1DNDtbArtde/IokdpDP7TF7QP4kvnJgDq3t59x2aT
	4tXB3Q/YqWu8HjuCdD5JXDKOd33Jb+SfPOI1dcLyahv2QxRWIcfdxusRMR4PnrXL
	qi6NJNLsO0eLLLY01LfqZarlqw1wSRmVs1yIcGHIQQMrXJo+xQq0eRjuIvdNQdLW
	OXqgLHs007FlTf1pCTQfI26P5VUnWxvyCjbpo/ajGcckfh1uNli6M8AiEWjOo88m
	yDUysCkxroMUa3FyDMLzUz8RkFe1BwvrpjC2xHHljVj1h0lB8EyLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5cdux-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH9QkA3494183;
	Thu, 17 Sep 2026 19:22:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjm08c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMccn38142434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B306220040;
	Thu, 17 Sep 2026 19:22:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EA352004D;
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
Subject: [PATCH 06/12] s390/percpu: Rename inline assembly symbolic names
Date: Thu, 17 Sep 2026 21:22:31 +0200
Message-ID: <20260917192237.638324-7-hca@linux.ibm.com>
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
X-Proofpoint-GUID: lCq8UJc3IrJJXkLYxL4uN7esy56C0Hiq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX1gm0t6taxM/u
 C2ROMKgH2wNYvt75JOboO1Kbrs3GSLTtKdT3xZC62bmdEXlCfVp7O5HBpovYJvmZwCS0885wDEF
 JKRn6GgMJ/xV6ZC+aymDYdDFDrFgC98=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aac3e03 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4HBEOGDHSRqv0w81nQsA:9
X-Proofpoint-ORIG-GUID: lCq8UJc3IrJJXkLYxL4uN7esy56C0Hiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX13sM+hitwvKJ
 rk8+f/d/MnCbP1a8TeDTDyumIHKhjBnWaPgcyu7avK6BxvDq/UbcZ+tgXuV2PL9Qwznj4M/i365
 6h+4mKpnqV4M2dWdGdzJ+d/g6Z398tG7hobw3tGWVZFIlwAIBFp+nASwrCc0IA0Q/SxynMbrvaL
 YzMmmzpmzDduUYXDnLYsFi4TLMnHZ7Rw45L9zPq6oZgG+UZd+xpGT731Mod25SpQQGrffliF4i1
 VEGr449DQFBG4kKOM/HLnNIxs8R4bGq6QhnuEIma9umuhRIAYhdVSPZ6mZfocMyH8rDDwRpUZxg
 dsiQxq7WEB4bOC5EVD38+uX9tTY4rRu8iFeCFWCoGS3MhXhFMSpWpmlTiK9zvsMUJO5e8iXp0nk
 wMpXuYo8iBAVo5q4mkuqrG5G7+zIWhB0GuD+MNq7U124I1NLWXOv3EdmnlMRinBks3JG2C6LJRb
 WCtdQbtNmy+9SPNCkWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170272

Rename perpcu inline assembly symbolic names so they match (more) what is
specified with input operands. A trivial change which is supposed to make
the code a bit more readable.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 60 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 770fe4be65dc..0df47ec2e6c7 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -151,29 +151,29 @@ do {										\
 	if (__builtin_constant_p(val__) &&					\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
 		asm volatile(							\
-			MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
-			AG_ALT("%[disppcpo]", "%[ptr__]")			\
+			MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
+			AG_ALT("%[lcoff]", "%[ptr__]")				\
 			op2 "   0(%[ptr__]),%[val__]\n"				\
-			MVIY_ALT("%[disppcpr]")					\
+			MVIY_ALT("%[lcreg]")					\
 			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
 			: [val__] "i" ((szcast)val__),				\
-			  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
-			  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
+			  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+			  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	} else {								\
 		asm volatile(							\
-			MVIY_PERCPU("%[disppcpr]", "%[ptr__]")			\
-			AG_ALT("%[disppcpo]", "%[ptr__]")			\
+			MVIY_PERCPU("%[lcreg]", "%[ptr__]")			\
+			AG_ALT("%[lcoff]", "%[ptr__]")				\
 			op1 "   %[old__],%[val__],0(%[ptr__])\n"		\
-			MVIY_ALT("%[disppcpr]")					\
+			MVIY_ALT("%[lcreg]")					\
 			: [old__] "=&d" (old__),				\
 			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
 			: [val__] "d" (val__),					\
-			  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
-			  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
+			  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+			  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	}									\
@@ -190,16 +190,16 @@ do {										\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
-		AG_ALT("%[disppcpo]","%[ptr__]")			\
+		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
+		AG_ALT("%[lcoff]","%[ptr__]")				\
 		op "	%[old__],%[val__],0(%[ptr__])\n"		\
-		MVIY_ALT("%[disppcpr]")					\
+		MVIY_ALT("%[lcreg]")					\
 		: [old__] "=&d" (old__),				\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
-		  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
-		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 	old__ + val__;							\
@@ -216,16 +216,16 @@ do {									\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
-		AG_ALT("%[disppcpo]","%[ptr__]")			\
+		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
+		AG_ALT("%[lcoff]","%[ptr__]")				\
 		op "    %[old__],%[val__],0(%[ptr__])\n"		\
-		MVIY_ALT("%[disppcpr]")					\
+		MVIY_ALT("%[lcreg]")					\
 		: [old__] "=&d" (old__),				\
 		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
-		  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
-		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 } while (0)
@@ -245,14 +245,14 @@ do {									\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
-		AG_ALT("%[disppcpo]","%[ptr__]")			\
+		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
+		AG_ALT("%[lcoff]","%[ptr__]")				\
 		op "	%[res__],0(%[ptr__])\n"				\
-		MVIY_ALT("%[disppcpr]")					\
+		MVIY_ALT("%[lcreg]")					\
 		: [res__] "=&d" (res__), [ptr__] "+&a" (ptr__),		\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [disppcpr] "i" (LC_PERCPU_REGISTER),			\
-		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
+		: [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (*ptr__),						\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
@@ -271,15 +271,15 @@ do {									\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		MVIY_PERCPU("%[disppcpr]","%[ptr__]")			\
-		AG_ALT("%[disppcpo]","%[ptr__]")			\
+		MVIY_PERCPU("%[lcreg]","%[ptr__]")			\
+		AG_ALT("%[lcoff]","%[ptr__]")				\
 		op "    %[val__],0(%[ptr__])\n"				\
-		MVIY_ALT("%[disppcpr]")					\
+		MVIY_ALT("%[lcreg]")					\
 		: [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
 		: [val__] "d" (val__),					\
-		  [disppcpr] "i" (LC_PERCPU_REGISTER),			\
-		  [disppcpo] "i" (LC_PERCPU_OFFSET),			\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
 } while (0)
-- 
2.53.0

