Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935D27FD74;
	Mon, 12 Oct 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805378; cv=none; b=izoLTh70ADuxydNR9B4/ohXYbVUz5+HEHTpzVkFazB/A9C1NxjKvpKqaJLwYHE03/J+QopYBhV7zvHZUBcqLlRg4QpITH3fOPHugrlVschwoiBmEeSY/HCN2sDkVmF1pmswLqX1/KjSx8LueByZmJ6NIzYMkUhcZ7cO2e7wgLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805378; c=relaxed/simple;
	bh=S0G8Ve2Lpo3qVVWydc0w7z1/7ecyuI3Vue4DaGwKVpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G41gtH5jnmiC2i5XxJojFF+qnEArYqbaNbV0rtEWMCiCuNYlH1FMg6L6poRyeJxRXlvigAZ2ZhJ6E2c3UVe4CxRXxDmpgKSzC3vuZsX7XVfMdAX6tBnYzAlkeLVm9ps2MEtPgIJFmLwgmC47iEMzpW5Husx9WW3Mm4SofOjOuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rwsLFRhj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rwsLFRhj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iB8E2183696;
	Mon, 12 Oct 2026 11:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0yL4XYqmSXGNW+bAL
	FTHm1et6V8yPYlRqJ3BSM05DKA=; b=rwsLFRhjxP5hYx7xqFY4Lwk/FPEZBc4TR
	IK73bVwpAgqC4kiF6IN2GegaA6dc7dt2xfYjqijKb1JxEeAe8VZW5MZaK4SvaeXe
	uFP3q79eX4kkshBl+sLwXMZEPk+Wj/gSMzza+8bMyEKsPv2azB3GD7QM9gTZrepM
	1CN55GzMBZ7L9xFgv80+lZfqrmAK136dixBtd/1lgFu0FxSYkTK7frkDfhyaJ4X+
	OvPvdrq/BsLwfRwjiiTOwP/+EfdFPSCrjOVOrYB0MSyjPtprkqz33WgwbXPZni+W
	TYgXBi8o9PSWeqsAQ5qnsWQZ5L0YBp/BeKvBzSbRAExVYdjKeLpxQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh8n6j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K09s935424;
	Mon, 12 Oct 2026 11:42:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjmygg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CBgolw55902570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 11:42:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D3AD20040;
	Mon, 12 Oct 2026 11:42:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 027B82004B;
	Mon, 12 Oct 2026 11:42:50 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/4] s390/percpu: Implement this_cpu_try_cmpxchg()
Date: Mon, 12 Oct 2026 13:42:49 +0200
Message-ID: <20261012114249.2898572-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012114249.2898572-1-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX4nPPtKIT1+b7
 KTu7Ps3lQlzB2ps4OKjfIgIBBEqPmawD/EuqutJGJ2QvrBUh6jVSDkCQSKrbmzSPpYO6bSVCcg2
 ZnoQ2L2nkE2yD2yZcuEKwp5Wh0m8OY0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXz18HeHzRzlZB
 yDHuWq+RI6/S0NeK2CfLOFpm0/0p+QL/ykZWv8bGLRh8HuG7Gok+hZCzF1RfedGTfnJOlHsQCUe
 q3yIQsCcW8PEPtsDYMnm/lWEq7ooGthMacXLs1cXwnL8l01w/ZNb0EyZzB1imz4QJVxhJaVWnEY
 BOjCncn2GY1TheTKgWeXcQRI4NJRiyTZ9hY4Se6SGkPq/CA0BAuK4MVxKvdfJw/RByS5bxiGbXK
 RPYstWTiRc2LsJwFmPv9y1jI+hw3fJ9LozZ3hgp/TiC950CYVhBrX8gl3Ti6zuDNY1ERIgtL00j
 2Ip/48MLF2GLm/3wnyEoyVcFETNF5BhKnozkRP3g0hw3qmSPs0qCJx+9YtYQ5kenfg1pK59C1DH
 p1Ovc/co2Z7YzVmogEEm6A1jIwzxHwfKfxHkpAg94qUKzj2sXigwxYwvKSe//kHftR/ufTIer9+
 uzO5qaOQcNcb2T7oHfg==
X-Proofpoint-GUID: 1S7l9_Xp9UlyAYISrMQgEGX47odUJmE8
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6accc7bf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Fcq9ZEDtarF6NphyhgEA:9
X-Proofpoint-ORIG-GUID: 1S7l9_Xp9UlyAYISrMQgEGX47odUJmE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120044

Provide an s390 specific implementation of this_cpu_try_cmpxchg() for
the four and eight byte cases, if the compiler supports flag output
operands.

This variant uses the condition code set by cs/csg, which avoids a
compare instruction required by the generic variant and generates
slightly better code.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 7d87e0a262c3..7b7a8cb51daa 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -5,6 +5,7 @@
 #include <linux/preempt.h>
 #include <asm/cmpxchg.h>
 #include <asm/march.h>
+#include <asm/asm.h>
 
 /*
  * s390 uses its own implementation for per cpu data, the offset of
@@ -404,6 +405,44 @@ do {									\
 	old__;								\
 })
 
+#ifdef __HAVE_ASM_FLAG_OUTPUTS__
+
+#define arch_this_cpu_try_cmpxchg(pcp, ovalp, nval, op)			\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	typeof(ovalp) ovalp__ = (ovalp);				\
+	pcp_op_T__ old__ = *ovalp__;					\
+	pcp_op_T__ new__ = (nval);					\
+	union register_pair rp__;					\
+	pcp_op_T__ *ptr__;						\
+	int cc__;							\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			     "%[pair__]","%N[pair__]")			\
+		op "	%[old__],%[new__],0(%N[pair__])\n"		\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "+&d" (old__), [pair__] "=&a" (rp__.pair),	\
+		  "+m" (*ptr__), "=@cc" (cc__),				\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [new__] "d" (new__), [ptr__] "a" (ptr__),		\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "memory");						\
+	if (unlikely(cc__))						\
+		*ovalp__ = old__;					\
+	likely(cc__ == 0);						\
+})
+
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) arch_this_cpu_try_cmpxchg(pcp, ovalp, nval, "cs")
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) arch_this_cpu_try_cmpxchg(pcp, ovalp, nval, "csg")
+
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval) this_cpu_try_cmpxchg_8(pcp, ovalp, nval)
+
+#endif /* __HAVE_ASM_FLAG_OUTPUTS__ */
+
 #define arch_this_cpu_xchg_simple(pcp, nval)				\
 ({									\
 	typeof(pcp) *ptr__;						\
-- 
2.53.0

