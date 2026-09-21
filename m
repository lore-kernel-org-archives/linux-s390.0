Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCAF4BE44F;
	Mon, 21 Sep 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006304; cv=none; b=DaFvOVXFshYB/mwokT4TcqFO6SbyzfTLjPC53RaVvBy3BqJ5PwhcrcIBabqPo/K6lLTmywBzXFQmwjfn7ynxG9fUOrOImcoi02EYJhm4cprsAewxHP7G31UafhLGpxaLpmX/rl03lbm5JvjlrQYodl2g5sON9L0lB0nhlCtt9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006304; c=relaxed/simple;
	bh=xrGN8LeijjnGj5GORr4MnMawzfd6noZ622OIpsikzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHf/gGYxFRcp1GtMg0N/qMhYfuAX+NvUPq0tMzilPJvmaeMcPI24bMeWbOGDkD/XHO4NgqPtA8Nr2BTo2r2g49vqJndzP2vusknKe8J0H03JngCotiw4iMKqvW0czfEE2NAbep7VYsHprPYI2S4mowBNY/sb8W8ckZh+i6dyZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=flFhtSEX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="flFhtSEX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8jRu1712115;
	Mon, 21 Sep 2026 15:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RmfRlMunYDrgwFNZI
	BvZC4D83yPI7wHTx0KNdHPuDbA=; b=flFhtSEXRi+nMwyJFVTXc5gAchO1nidII
	cbxYO5spE+HrMzWyUEI3QIhhS5Mr1r56zigx78duVFmT1TNkY7cre4XhiEMwGgtq
	tWA3Pi7H3LoP0AGpWdVd1XmvXNccKusDABLcM+1Hv/exUYehFO1iHZSb/cJg/R7h
	J9Z63xboN6BWpPO0pqZxqaUZJlpcdepRw8/81d5Y+HgA4JYl4By1QyPvQfE78q7O
	LRMb3PNB/UrFYBChs+F8LEN3973B3ZiQbU3FZxLzbYSudgkXrqvxvxnKla008xQs
	pUXuyRWGbyUNWqAPd+oiUa4gfdXISckS6muVtjTsjQu5n2GVurIeQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske19axh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHVTh1451389;
	Mon, 21 Sep 2026 15:58:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gnwsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw8Ra28377502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D7732004B;
	Mon, 21 Sep 2026 15:58:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C0920040;
	Mon, 21 Sep 2026 15:58:08 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 15:58:08 +0000 (GMT)
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
Subject: [PATCH v4 10/11] s390/percpu: Use percpu code section for this_cpu_cmpxchg()
Date: Mon, 21 Sep 2026 17:58:04 +0200
Message-ID: <20260921155806.2447506-11-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: relz430L0hx9avq29S2i4zIhgcpDDdCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXz/9LhG0U5yq3
 N+TSlIptZjsZH7s6bQG8Qre1oReXJWH5xRx4IUc5aXH8BqI+lVr2qpss8wEDnyrN0+ZrQZ6VfxE
 TR9gbgO4PO4tU0ABG/S1uqc9C8GMazXMCJXzyTYDiRBZlVtvpSk0oDagQmUJUPCYnStMbQiXD4Y
 9o5dDitWSZA3q42yJrA0Y5hASVcgEC/m4OFGrszv0IVVWqwwgDKHxHnytYU9wSyy7byUh02qvyn
 xfT6tG8WC8zOa9VVKLvzwLzWfvkNSlg4FPE4rFPcz4cvBACy7/wBdkziap5FpDxw7+sNFPx1HRM
 HwMRkkhpC2E7vd3RL9s8n220OJVj407PsWrnjwbTLpY4Dt/hNuJXG+a76GxxEq17JgrafKCE7ny
 gSQ+LvQ/NcBMgxfdHw90xBKd6bPDL/awTS4bE81XZ/MeD4rB+xhEIjUny89ciZ5P0doSHlikna/
 CDCbTn6hg1pxdQFW76g==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab15415 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=xum8VS0YelhL0tLUZrYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX5YAsHBC9XHSp
 VDqFOukBzQgkROZHB9cX2R8Lafj1gSnuq4rjNCEk06oIajxeNlXn9ZpfGY36q9JE5Q3ReyHmcK7
 ohXDEYXvmVZMDQzQY9I/+p9JZ2yav/g=
X-Proofpoint-GUID: relz430L0hx9avq29S2i4zIhgcpDDdCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210227

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

