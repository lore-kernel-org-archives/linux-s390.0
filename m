Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57838330E;
	Fri, 18 Sep 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721340; cv=none; b=nRpADxN2QJOH+hpuL8S1Par6lQH2K5AauGrIKKmI5R5PTaNJDo2VHhtlpG2DZnCn1rGTool5Em6RHRaH2JT6aPg37c/NGtwlrIsj6J+cT/rmffHlGEDziTQK8+5nVikbCDLs0RvPbIwLsGWRyk8jIWXbgieB5tP9pLFnN4Ge2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721340; c=relaxed/simple;
	bh=eRKI4hMcS2Wg6ZS51a9HVHd1Gm00mnYcLUI0HEzLMX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4ht7xcmiVFnLil+uvcwvNak9VmGvDVuDmHjC2GFPFMFkdIpXn+b672nlEQktJVwsURx5C9G9tHemoYhmkyUY+8zX8myaNKcxjuZPOyHLtRlHoWEUAErxTWmXrz6tc6tRidLSMa8DxoSJR2ohM1K67X2SIcmTcj1tkxjTykhieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hTUnCbv/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hTUnCbv/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61wxq313724;
	Fri, 18 Sep 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t7kkPPAQLSU9pnkgf
	BPz6kp1jSQR3q76w6P8dKTtqXQ=; b=hTUnCbv/QSsSVIxqTjAvP/5Crlq0IhRub
	tvb5VXgiQMPZuxy2L9ytp/ODznJQv3TskAH3ejDugK2w5QeLRnuoHKyC27xSmK8V
	Y3jUCGR+so63Yv4kgurpq+lYg79PxkDacKXw8QFElyRN++hoH56XHMKHJAzcDjFg
	g2CVzg1oGF2EhF/GGkZ8XrmU9jOFWvXUFOTwlgvX5eQfdR/kwzcHJ5/0JxsX+FkE
	2U71zU4RTM4tKR/R0qpyJc2ZH8dLmbkvIpggAjPF/sfuo1kDZVUgwXQaTctGfd32
	0uuHWtOtJsx+haKmrYvo+W6WqYpwO1GQAkHgD6WIOrzr2TMygYPPw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j6upd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I655nJ251904;
	Fri, 18 Sep 2026 08:48:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3ywm6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8miJg32178450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E0512004B;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7E9F20043;
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
Subject: [PATCH v2 06/12] s390/percpu: Rename inline assembly symbolic names
Date: Fri, 18 Sep 2026 10:48:36 +0200
Message-ID: <20260918084842.2333237-7-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX4DG0BHPZtreE
 ocxnQvYf5Z358wR1ESNNaXopSXUpcwLPCB+v3jK1dpW+a3kU2J1b5Rva0jnxkGdZ0OoufWYfTWf
 GxJU4t1HkifsJkVxlxuK8lUL8qaOn4/bhwV5meOPnJrf2ZYVP77s7eFaKfniB7WYkYIyITfGniL
 Dc4dsQRbv9mMsO1+ukOglq3oX1JH8EI7C0uc9cpygLqoW88rVGhGp536a9BTnKXxRKTnkV30WAD
 4jpK+O/4dBR1iwdOHCgPu73r+IHo+wpsQnDIYRrw2c2PWt7lm6Ufpq43xgDALTotZeEcThkJYPc
 kbvw8ge4EdIBQdRjtqYPwKbjnFb3Jzb84d9Wg7Zs1P4RcKACSFmGOuM+osgifulnFcGv6dfEekw
 FWRmiYGdobtTBftBTw+6QsGDZFfFJippJok1jW8lGdxkocE/OTGQfrt8whuZnKtuNaajVcOH1XO
 d59RBYI/RpUrGtZ1+pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX/hBiQ6ZFIaEA
 bSFqOdHpystdhsIYG2W6Su4yyP4AeIcHBUQVXCOapctljnP20cL/5sGoz1rdgIOksNb/sOQXCph
 kzfj2M8JQzhATs1gUSZtTF0/C8OB1cU=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aacfaf0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=4HBEOGDHSRqv0w81nQsA:9
X-Proofpoint-ORIG-GUID: 5Iuqbgl9mjihvIJLwh2hPAZzGjPMYu87
X-Proofpoint-GUID: 5Iuqbgl9mjihvIJLwh2hPAZzGjPMYu87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

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

