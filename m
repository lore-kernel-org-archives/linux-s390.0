Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8E45560C;
	Mon, 21 Sep 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980028; cv=none; b=PlBIs3wmyCwlJkgEU/tkcHD+iyJFjlJvJDHFr/dFc/qMvKxom17TligZICXeU7ZCFNpPgWc2C7bM6z8f45/lzQSpNSBye0GeH5fHhUMNgrt5O40R6eXSYkoE2pmp+S8Zcq4foZN1Pr9VrPh3E3f8NRg3vxxRWje/GKoz3hsxIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980028; c=relaxed/simple;
	bh=dk15zW62dw4J4Iu1H7GOx3XtEAyR16DKh1/gZRelIDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE0x75CEKhaeMYHoJ6wfdG/5e6MceyDqhYgr2EjJgwHAf19IQJVW2nEQztTfktgB8ek4ONCT8bB/2MZgd97yxRWAUVt2MWMKSZlTS7djqu9To2xYGf9S3abx1gTJ2UWZw7N9YJ19T084QKbSpRTf7P78qAF1dBFuLAUAA+4HnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oISE8IHm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oISE8IHm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZSD5830148;
	Mon, 21 Sep 2026 08:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tAYE5G2sLX5gFTLq8
	Vi+M9XlI4kPloCQK/GSNSxPNyI=; b=oISE8IHmvxbti4TNjVqh+9xTNc+HnGrVP
	t5xV1PLfB1LJ7L41eB9X8VVOeF+4X9oicC8/H3WpSHAD13Ln7V9HiXUcmSyVEQHQ
	Jx2MN0x/GroZOBPhjj94niAwwJAZ3d5h2tzOIxlB0jm1abhJ08Nfu16heGRqMR+f
	7oYCZH7Qfy2pYev5Id3XVXMc7Z6apyNofTx1FROSJKF37C7GiIGLreD1daOCN1iA
	Akl0aQ154eAGunGLgwmUHsAOtExv2oVB5pyKzRg6w8qIAxRVvEEvnKD+N4TfCz7u
	Y7fn9AOu1TZ4kuyOtC0uI72vfxKhe0Riw/2aTfj8eFDvzkqgzU8tQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgryjap-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HiXR1835697;
	Mon, 21 Sep 2026 08:40:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy4814-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e7Ox55705896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEDF72004B;
	Mon, 21 Sep 2026 08:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A503920043;
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
Subject: [PATCH v3 06/11] s390/percpu: Rename inline assembly symbolic names
Date: Mon, 21 Sep 2026 10:40:00 +0200
Message-ID: <20260921084005.4022574-7-hca@linux.ibm.com>
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
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4HBEOGDHSRqv0w81nQsA:9
X-Proofpoint-ORIG-GUID: EhbSxV38t75PSG5C-zdq4JXw0GEBoZ_7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX0LswzUhPc2vU
 1ax8dPmUxIZimx4FBFV5viUdl8EMp6G3iWz5eOzmncF2JxjclhKzw2qmftxJdYJ1/ztnDWFvg8G
 OyuSqgTdTwzMVg5FaJ1LjfnY8aFmpKoWI0FXBTaq/232Z/YHVjn9AFv8c7hKxULkHrD5LqHeRJK
 DcJhd7b/6l0U1fttssdT+QT+LwJpfEF0Mf1I73jPlJK9OEc7z1gAufX7YhB4kJf0BNfk/GzHtKH
 5ai6Nnh3GfWd7see2MfFGVjAUKV+ZiQel5eTttl4zXAdq9Dp1snHsrd9vi0fEyzFCOPSM0mLn44
 lwz31U09MVeVE4FyYzEk/sztJv2qX/jH2BUVGemIffBElkZZbTNfpn4TohPsQL0wcQK7hYTdTcH
 1j5fJeQnBdnxh9fbjClFgsxdArc+tIqidUvdk8F7pAuqTljc1+DD05fUVqZb1jPWXFYQU+jlzE0
 P/Jf+wByDyklfGIgPnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX7k68HB4cXlCP
 ou7nSGSZ5QW0AigA0nQY3620CP0ZgNAXiblrfwguiWb1eQYiwaag3YLNVC3244cxkSK2f+kKGdw
 /gbaND+9bqIbmAx/8FHgwIGIeYbD3Tg=
X-Proofpoint-GUID: EhbSxV38t75PSG5C-zdq4JXw0GEBoZ_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

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

