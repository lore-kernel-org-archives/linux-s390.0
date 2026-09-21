Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDDB4BF939;
	Mon, 21 Sep 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006305; cv=none; b=Dy7GeL1SRDe7AkGhmmBD7/A38qqobC6d11bz+1z8znOs12lALZHYRPwkjAuBhac8BTjjirdurEVmv2Xuc7i/Xd8cUwJpc9NTlW8GMxtTeHMdzqKewmuqKB8EPZmTRUHpeLozFgBKsFtwxLlgcNxllo1ysIyWMOmFyaxXSBPiSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006305; c=relaxed/simple;
	bh=dk15zW62dw4J4Iu1H7GOx3XtEAyR16DKh1/gZRelIDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDxou6e653+4UzYvCpU8usTI08o105pEHeLufVZ+1/xNPrp4LN7GOzxQh6Iz34ewgBaiqNqSnmx/2I8kvgB9bhY/hKgDZpsaV/rIFby86IMw0Br/nXsOxbNkm7cFkTxNbkBoMF0VRxOqicuF5iC2kkHzV1+NJ6VjaAZdqp8KY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nNSlPUPy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nNSlPUPy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8Gin1902954;
	Mon, 21 Sep 2026 15:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tAYE5G2sLX5gFTLq8
	Vi+M9XlI4kPloCQK/GSNSxPNyI=; b=nNSlPUPypNgli4VQo3+jDZQPDq3wgqshu
	YIyewa3aFGFWo4U4OAIRK8l+oQMY4EmcGqEyAZ0E2GvQgcvZ5v9I7+q+vZxBD7Rs
	XSFuyrOBdorJBH/JzA+BUAPMa7hRO+VLBeU9hsuGnNYM3T+q1te4MyC+WAmYWGae
	uHxOvB8/ToHIp2uXGmZ4q3VFdNrFojRxNvp7y/TmpN0duTB/uvjMnABf7hMhxeHH
	hCx+Kf0VcycivWNo2i12LYz3/dMTGat4/dLprjDLG8RUcz5TW/2qlbGNx+H8YlsI
	TwBedpwLSUhbosqDmk3Bu1KtUBWyva3ER7TkqdaqpJKa62PRvTLbA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv1akc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHUDD1408412;
	Mon, 21 Sep 2026 15:58:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjnyc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw7AX40042774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB5EA2004B;
	Mon, 21 Sep 2026 15:58:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9085820043;
	Mon, 21 Sep 2026 15:58:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 15:58:07 +0000 (GMT)
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
Subject: [PATCH v4 06/11] s390/percpu: Rename inline assembly symbolic names
Date: Mon, 21 Sep 2026 17:58:00 +0200
Message-ID: <20260921155806.2447506-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921155806.2447506-1-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WtovcMW8dG9wlfz0uJlTso37LyPS5G-_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX4yQyGe6jqWex
 Vp5pSbptyma0CAAZMFlCnVTiRi4jY+2S7fuS+znwupkXnaIMrKYS84LWUy1mQHaaTJ1dhhWAcAB
 djbpV52k0Wd0GU5VFhZkCrxrAcdhlq8=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab15414 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4HBEOGDHSRqv0w81nQsA:9
X-Proofpoint-GUID: WtovcMW8dG9wlfz0uJlTso37LyPS5G-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXyCpAa6YU9u/N
 ij+w6fnri9FsJ00NKRh6dIEcaOXfR0UMxDSqX00yApMhTiq8IyCnwqW6WWKNVkwihyqpihRuu+s
 6rkhUZeoNlMbf8EMxgPJIiARkmCEtpZJEdrmGbaoaCf6UxxlMmUs8ICkxYBhDkixfD89jsHS3dA
 2r5C8jcCvdVYKqylKiZvnGc4O7ytqs3VXLzzsQbIUWlcsTsAKj2ryusJhqDuAiTRpG74xZugV36
 oKiX4tt7JhGKc6Xq5Ul+gYDBjyG5UeZFuh2NPPQIE+uK0N+TSGxpKnz+zlfSVkQWSPLORVB440d
 R2IeW4d0fuvnI1cUXdSkGN2cjiGdddqTRs57Pa7dWpHn9uii6hOBNS+iKqkmhRU10OxFxY6zxvo
 1UTX5NGPXa/dpseUMf8hE5YexHMgjSgSfHjQZNz71MKtQnaC4JOfvtKMaNOMpQJgwnzl4IRXzWp
 D5AHh0AwQ72804IZxHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227

Rename percpu inline assembly symbolic names so they match (more) what is
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

