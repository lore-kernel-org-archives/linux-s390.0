Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E145562A;
	Mon, 21 Sep 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980029; cv=none; b=c5VH3zh1jgiAZxxvS+TrEzchq5yRmE9XxQh+FHqLauubhtsrUisxVS1A59zsru6zzv0bqHWSic0RJ0FNyPYcglXm+TqDUPG1vYPC89TFOKKRLQrFKEK1KtYo+6AsDumUyHCNhNpsUje02iQVa90zDXnZcjKJ6VyYQ7kHW1tiw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980029; c=relaxed/simple;
	bh=xrGN8LeijjnGj5GORr4MnMawzfd6noZ622OIpsikzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLfpGnAZUCPOKgoGfWFu4VHQiEH8cULlQ7r5H5FDV3H65bthTMb5g67wR0LZqP9K+A2ngLe//qghqH6HCgAaIup+E+rEDoSFSrV5r2x12nVMEHBasJGY28ash8p1rb61R1Dc0ZcUN1UlWndyGM8DAmCcUD2CFRM9Ihspjg0g5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NRPZW1aX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NRPZW1aX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZXFL830222;
	Mon, 21 Sep 2026 08:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RmfRlMunYDrgwFNZI
	BvZC4D83yPI7wHTx0KNdHPuDbA=; b=NRPZW1aXSr7RzdpmYtMRjsWiHJCQaQixL
	WoibIiUeopGt7FGbUENqH2iv5mGDtffojCcIzdSQJ3viFbhaPFdE1wTNDnqZEhpj
	ZAaXPNOiRM6Slx/YoMHBOcUYwkF41f1onpZXWXxOJhVZDsM7I1MenpHh9OITjz0m
	BaDMPuJAPb4XKleNm2W8q8rbANarCEGg8z6vaQdqp5qq3ir1iVUPEV0jU9v8uWd5
	qD9T76velckfI5FW8ksZVZn3W0nRYm9gARxJtq6w+th0HZWjHsCrIEwS5AarG1oR
	XOIFVZ32cjTgnXsNxusbDpJjXrSe5ndJw2HcbW7zwak1DCWm45o+Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgryjat-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HbCa867736;
	Mon, 21 Sep 2026 08:40:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vckkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e8Dg51380562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ADCE20040;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 706AE2004D;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
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
Subject: [PATCH v3 10/11] s390/percpu: Use percpu code section for this_cpu_cmpxchg()
Date: Mon, 21 Sep 2026 10:40:04 +0200
Message-ID: <20260921084005.4022574-11-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab0ed6d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=xum8VS0YelhL0tLUZrYA:9
X-Proofpoint-ORIG-GUID: ju0TJJSwKm0qZ3_xW2dsI4jJJmnNf2zq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfXz46mJ3GQ3JJj
 G2Z2ai8mvCMo2bhArKsP8ld8vsegEUxICEeIfD2kZkIR6K40n2LJ1a30qdVTHmvh8CBRrXWfhNf
 olWgdPbn5JTL2lC/ytBg3/tTjdmIIfLUj4l65QFBE8npkUiadrU0yB5MbTPQ4JlNFnsVxXxwzDR
 4iiZH6pcOxnd9q3KXkDonb7IZhCthOwTTdUhSnprNwKQ22FCBDUuccSN25S0ABD+dHDCxq8GVxI
 REaA8qf2BnJpKahHgBL7QGZ1jn5AfnJtCxA5HsaGf1KWlXemRDNV+3WDbs/3b76ac636piX+7K7
 1aUnuSVMgHevRJQhRQZ7YFYLHuaD57E+YiCSksce+uId938nDxshP2DLQ8xvgXeEDpjzpkLxRKo
 kMI8ug9o48D88Ig7wKQzEUmZcixj91wVG1+VvWbcAxWE+TI6MHkvqKPFmcQ80HFdeWCLA9+VaTP
 liTJ9KHvf3CDtAG3Zew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX1tmrSPRGPAZN
 /6ojni+0zHkmq5cg2tq2qjm6QwOIN9ryKQMoPIkyABu3n85wcKYgIbHroQUS5gQQcAdiCkcdvx2
 mwaPeWoWhjD/gVbBhw/2RzWIprN5HLE=
X-Proofpoint-GUID: ju0TJJSwKm0qZ3_xW2dsI4jJJmnNf2zq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

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

