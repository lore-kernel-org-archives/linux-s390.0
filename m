Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B2D4ADDA7;
	Fri, 18 Sep 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721341; cv=none; b=fGnrs3oJtAACgq2hqVBSyLidnEMX3zwDOdncc1q9mmof4uWVjeAO15/0i5SHDg+PIpADsYddTzfZ1vQQUTpiOh5yzeQqKvO3j7I0IHUxLXw1n4BZN0AE8mEOKrc58GFMCTcjc2UV4+gDgfkSQy2vGSHuGwx5lZ0+jrCKZt9ipP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721341; c=relaxed/simple;
	bh=o9hPxOU9kHloIARfub1Nrx5KK2t//Hd+uRzDHhtzPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFRhRdaigR8LBsefM47NH4QpJ1DS8pfi0BhLpazCEOmQdp8Fz22p2SsjWZAjF3HX3XPQcOZLDcdCK8zv77ub2h5+TgAfuIzAeKU3ldRqmeXrNJwU0rnr63z1BCqcL+CY55ulLkmvMr/KtBCUME7P6uHZICJQUBGokkUF1EKL9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AGuA34gP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AGuA34gP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61pe33490262;
	Fri, 18 Sep 2026 08:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vfh+Ku1qHAtSrYARs
	L7UNTW+AGUl1eoke7UXxnSuWjU=; b=AGuA34gPXafIgV6atKVACZXc0HJdzchcX
	l4U0WM8vqVvQ2zFLAZ2fj4Z4pfhlSgAxj+8vcYkbtVUGCNpOTJOAc8al7J98XJeP
	Kp+WtyzTIJcc/5OZ+/BiZ1ZRScEpeqOXf6AAn1ND7LsW2ry+uzDh9HLs146tlvXv
	Imia3eKzuMfP4A9wy9QN0w3waXqiVSvSpzRbQF8nOrWqf3cJ70ffFEO7SV/nruJ1
	jUgZXrV6ORm1Vjbael2IYyAKawlV3iuAFnBnUjqzlwbe61RcA2I9sTGo9zj+RyZK
	wvI/L1hjC6uIMs9LSPCa6jj4NALvTdHBRyyIj1CEcP0qizc4a9YLA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eendp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I652Tf1154834;
	Fri, 18 Sep 2026 08:48:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gep52y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8miWR32178454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6CF20040;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 444FD2004B;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
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
Subject: [PATCH v2 08/12] s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
Date: Fri, 18 Sep 2026 10:48:38 +0200
Message-ID: <20260918084842.2333237-9-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX7f3i6pc87c8v
 zyc99wEteTeppWsC/AwVN29Wvu5KJrREPzGH5zj6HMNg4MoHEGNklZj4wlax7EIiui/V5/l6QmN
 h1ZRE6/LkHR9UgQoxIl8L/sZwLZGiabwTuTyAB5hdk0SC1EOEGVyEH2nF8SJ+hQqe36x2bRz97M
 AbEHp2gNkl5Ex9CGJ5nTuS9x1Muxp4NA4KGVBT/U1bzdk7ILv4s50M1iS3aJDrwZ1xU87nbgyv4
 6bDW5csDs4vqzr2WTHo3Eu35CMejGu63Ae3PRlvXdoxyrGeY1cb62Fbb+YdSMX4w5RUb4slhOfH
 4lnAPaBxYwfp5jiTWyvHY06sf9HwExNPvPOhtFrW0pZfE001lY7cgUB25mozMIhF2sXDdt0zN5J
 IC3rSIF3MEdK5vSUWD69JQyz1/dymfVkrJowcWJXsEngvvO9O3CpcCMVJevbZ6Z8DQ7jJY/qDsC
 IkGM8MXj3lGXQ/jxEGw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aacfaf0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=sJK1A0fQ-n6IDXIElG0A:9
X-Proofpoint-ORIG-GUID: 8jOmzdyW5zcrLr_e1MLw85bU8TEmUxsy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX0yXk2iWUAA4T
 oBTdgAImTiPTTwgP9/e3OtGT51qrf0TLJubjNP+EFw9squwLtkrYH8EFeBRcBkqjM7TRPBmIIwa
 ZVen7g9eGnM+o5DPha0zSg+E8ApTEpo=
X-Proofpoint-GUID: 8jOmzdyW5zcrLr_e1MLw85bU8TEmUxsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

Convert this_cpu_cmpxchg128() to make use of percpu code section
functionality. This is just for the sake of completeness, since
currently there is no in-kernel user of this_cpu_cmpxchg128().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 78c3aaa138f7..0eae65937c0d 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -312,15 +312,23 @@ do {									\
 #define this_cpu_cmpxchg128(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-	u128 old__, new__, ret__;					\
+	u128 old__ = (oval), new__ = (nval);				\
 	pcp_op_T__ *ptr__;						\
-	old__ = oval;							\
-	new__ = nval;							\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp));					\
-	ret__ = cmpxchg128((void *)ptr__, old__, new__);		\
-	preempt_enable_notrace();					\
-	ret__;								\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		"	cdsg	%[old__],%[new__],0(%[ptr__])\n"	\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "+&d" (old__), [ptr__] "+&a" (ptr__),		\
+		  "+m" (*ptr__),					\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [new__] "d" (new__),					\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "memory", "cc");					\
+	old__;								\
 })
 
 #define arch_this_cpu_xchg(pcp, nval)					\
-- 
2.53.0

