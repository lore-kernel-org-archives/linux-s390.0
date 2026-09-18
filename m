Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD234B0E47;
	Fri, 18 Sep 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721343; cv=none; b=n64I3IaFqiheSnFlS3EptH+NoTX1V6QmWtAceyHAVuZjblDWMToWIV9MpvTiNZNpeL7xYVtvmqA1M4yVQN0Cw1+hujes7/vRSNs6uc8RwyDYfAbZ+b4IZP7Lh6oP0Rv9PJ+oQYtN0rlLeEU8KC5uOQHvQ90AeZgEeKu+3djheCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721343; c=relaxed/simple;
	bh=xrGN8LeijjnGj5GORr4MnMawzfd6noZ622OIpsikzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPot5ns0R1sIG62faeMZxvZthKTtMyeNUU00Ky95bLCKBiy6+AoB1Mmrr9CED3qtFlJpfob1Y7zPCr41grZg6HVwfXOj/uJe98OvjBVvKYkSWVwWaCl6yC3MpznXn2n78/Kw2BNkta9uQ5d+57fp7pjEnud4KPbfmsaqeBtP4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lIKSEq82; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lIKSEq82"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61XQN470404;
	Fri, 18 Sep 2026 08:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RmfRlMunYDrgwFNZI
	BvZC4D83yPI7wHTx0KNdHPuDbA=; b=lIKSEq82fxCNZFDXDn/hhHuGBI8JqvtPt
	XKUaZPAWnwp3HSm8PgHbOmZmQ0I1OKwkK8Fi8WuKggtTPNmQDIYbZgFxXSLA7751
	PPiNgN7Gd7yucqCaMd3Zg8Vge+bZ7DeDKBjcOZcrk54vSKKJd7iG+BFni6rnRw0Z
	dyxVEEhtuOS1/m9ZXNcIKb2hIjUnhUt8ExuGGgS2TmZeoMeAaaO25mZDldCn7Z+w
	IjbOYT5Rpn2yzxd2uQ8XvXKjJkkgeEK164ccZoT+LPi/L48JnH4R3e7M54AqLZOe
	MJGe6SffoStUBFtkHPVJLgLF7M5NVTc660gJfWY1tuSDrScZN6NIA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5f5hb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I6526u246078;
	Fri, 18 Sep 2026 08:48:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffeje3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8miXR32178458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE58120040;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A38A72004B;
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
Subject: [PATCH v2 10/12] s390/percpu: Use percpu code section for this_cpu_cmpxchg()
Date: Fri, 18 Sep 2026 10:48:40 +0200
Message-ID: <20260918084842.2333237-11-hca@linux.ibm.com>
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
X-Proofpoint-GUID: GmL2oLIvPuK3ISNLfN1mRGYD8dQJMTNU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXxnK7r71Nu+NJ
 KHAVkUCGVHfPD6owfGuJvZ3PGCWs1wkd2wk6JobrHUHbCbM1A/J2VQ7wmqOniqKmLZTr50ccSaP
 BApY+uUmsMrlZw6EfS2Bhknukp967n4=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aacfaf1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=xum8VS0YelhL0tLUZrYA:9
X-Proofpoint-ORIG-GUID: GmL2oLIvPuK3ISNLfN1mRGYD8dQJMTNU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXwibZEaI5OU3e
 N1yCaBFikwywPgSSAxgCU2wdSFTz/E3p5lgKaLTcTtYacr/ae5sQToSgpkp34xp/0Jims6zPyQY
 /5o1del/qGk0vCNZW5wZOTIimVeRH9fPIqpKm4SVkMYiilqrIfvyZx3nw2vPxvcogicYgXiPyAk
 WJmd0pa7oDLvwCr5k4QTdCXkZQhcEzkvPUCeXKqAglV/8V8F0tOlSxW9iZEhuzA7e4zbcqH4mBp
 Lv3Fs/A03m4rTcuJiNb7hqrCyeb92g7dJB2RmUPAggFGfWUxzdLTop0JcDIXWBax5BSzpUNs8IW
 Ewrr8rv3EL3ylkQrvAqNltSyclXJWkM2DIddiDsVlnZZcMxLtBV/ee8lafNC2t5QKYqfs/VKEM1
 IMe/ZYBEVUeJp/Yih5Y23oTBiLYwjenTxY6yn2BQrWRPBsNkc2GDutJ+alXW4Akc0kkGSdI2O0U
 J9S4kJAua8X8BeFMToQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

Convert this_cpu_cmpxchg() to make use of percpu code section
functionality in order to get rid of preempt_disable() and
preempt_enable() calls.

Consider only four and eight byte usages, since there are no compare
and swap instructions for one and two bytes available. For one and
two bytes use the previous simple implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 237bf8c80843..46368131b932 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -290,7 +290,7 @@ do {									\
 #define this_cpu_write_4(pcp, val) arch_this_cpu_write(pcp, val, "st")
 #define this_cpu_write_8(pcp, val) arch_this_cpu_write(pcp, val, "stg")
 
-#define arch_this_cpu_cmpxchg(pcp, oval, nval)				\
+#define arch_this_cpu_cmpxchg_simple(pcp, oval, nval)			\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ ret__;						\
@@ -302,10 +302,32 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_cmpxchg_1(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
+#define arch_this_cpu_cmpxchg(pcp, oval, nval, op)			\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ old__ = (oval), new__ = (nval);			\
+	pcp_op_T__ *ptr__;						\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		op "	%[old__],%[new__],0(%[ptr__])\n"		\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "+&d" (old__),				\
+		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [new__] "d" (new__),					\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "memory", "cc");					\
+	old__;								\
+})
+
+#define this_cpu_cmpxchg_1(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
+#define this_cpu_cmpxchg_2(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
+#define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval, "cs")
+#define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval, "csg")
 
 #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
 
-- 
2.53.0

