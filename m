Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BF45562F;
	Mon, 21 Sep 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980028; cv=none; b=se2dtwnCERkPg8gtBm2xsMudp5jB4t7ku2w5rFJizivZpFZfIT72S6di3/Ffg+XdVVP6uIaQ5r0LnV42iwBYEB4JjmXqlSKYDTzfWcCDOxRKmh0/pLM7/lGATzbtEOOtWj34reus8jKUHtX4G7Izb2wZz+FEvprLd0mFTJETSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980028; c=relaxed/simple;
	bh=BmJWJ7W+k9H+fQskDn+IIdJ98XUmWR1/SWYsvLXi+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKA4Vus5qPnCrEktlAtiM+9smTfGdoAlwp6wr9Hzag7sF40vs37lh7ILuNPutcUrvgYnvx7L7WInhNmg3hezWT1reoqnpmPVSVtG4TvHVe+MdwwxEVqUpXvo1cztSwmtBlVIlszffvGLJx9dQn6WFzvkLUzgaw1doQGrF+49LqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m6v1E4od; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m6v1E4od"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZWD03153922;
	Mon, 21 Sep 2026 08:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wmRVBXxhNWwSdCLks
	rWnt9f7rQDOreYtdYAPiaccpwo=; b=m6v1E4oda/Xfqa7juv29asns1DkJ0sMQ/
	5RIpCggNmUzsaZmEYw1rmDXwdEfi55fSAPHOrUD6GJS5WKsX00tPJfZDEliFm6ew
	tu9Js+wnO/FUNW9+c7k1vvq8CSXE2fr+z40e/eRPyH+9NBuc8/mUPeK7dYapuwU7
	Y60Vn/t9ORnHBEMHmUbz55NYYFBwTMijPA7rIK4YiuuWDmJKIXtXvUugHFVIEit0
	PJITH4beFpELKulcfPHC/vEvdKxvUJ1J2NiRaa7au8BhCVVmscdg8RmY/zS0aP9B
	7531nefY776TBbmgJYkK0ufNL9C6C8G29byOYDOexef7EchLLKBmg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fjuf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HaJC1835330;
	Mon, 21 Sep 2026 08:40:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy4815-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e8vS51380560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A85A20040;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F81A20043;
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
Subject: [PATCH v3 09/11] s390/percpu: Use percpu code section for this_cpu_xchg()
Date: Mon, 21 Sep 2026 10:40:03 +0200
Message-ID: <20260921084005.4022574-10-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _T0WFYjxgMcKNGmwJmmkTY5TOu9cOZKg
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab0ed6c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1_S2mAAb8jf74u_WUuMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX2eSazONAX1CE
 kLITr2piRNbllF+UFdir6QyFZUrn7KVUYnQk1HB3F7TKEkZ6HJBz69kxOb3stRdbYw6xlZFxSKg
 Mj+VSlJSWuWXOXFnSX2yVTo6yfi+D0k=
X-Proofpoint-GUID: _T0WFYjxgMcKNGmwJmmkTY5TOu9cOZKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX4YCtYDqlY4Rl
 m/pAMPnqg5wcwPu5Cowf1O9BjrRoPNk5Qm1pqs8Xcy5WS7uT9ush8bw1C9RjaTAEzW31uK54He8
 EUFRDqEsS6RgAXYFxy0Ff0OY0YZk4CnmaXMytLZdWgXTdJIxTtALEzmM61M0rtaE6W2oFXO/CjK
 jQ9nLhtZX4+RtuVQsV7LxijXcYoMxdXIveQ1wrdNpRTFEBt2QJNt1p9ZQynf0WdhlxW8xzuZhdN
 L+YFy3behXulD6dANnWhsWqKAjGwkHX6wJHIXWfXV+M8Sx+lELPwkO+MdozR5EPyWUFioRb/Gbx
 Lu1HjeO6Yg9FiB2477BNBFaqBl9QVpVXWMVQnCMHdHQ0jPel9GHHvT1LmhCNBXo9OcjT3cteBlf
 yBa+x65rh2LvnVTRU2m6VrHqZE2wwvYuTH+Y/4JCqcEIzXFGr9Y93h9/vE+h0i2jyrI3zUqBeCC
 7B49b4tcKK8MmOJ5V5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

Convert this_cpu_xchg() to make use of percpu code section
functionality in order to get rid of preempt_disable() and
preempt_enable() calls.

Consider only four and eight byte usages, since there are no compare and
swap instructions for one and two bytes available. For one and two byte
use the previous simple implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 0eae65937c0d..237bf8c80843 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -331,7 +331,7 @@ do {									\
 	old__;								\
 })
 
-#define arch_this_cpu_xchg(pcp, nval)					\
+#define arch_this_cpu_xchg_simple(pcp, nval)				\
 ({									\
 	typeof(pcp) *ptr__;						\
 	typeof(pcp) ret__;						\
@@ -342,10 +342,34 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval)
+#define arch_this_cpu_xchg(pcp, nval, ldop, csop)			\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ old__, new__ = (nval);				\
+	pcp_op_T__ *ptr__;						\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		"	" ldop "	%[old__],0(%[ptr__])\n"		\
+		"0:	" csop "	%[old__],%[new__],0(%[ptr__])\n"\
+		"	jnz	0b\n"					\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "=&d" (old__),				\
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
+#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval, "l",  "cs")
+#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval, "lg", "csg")
 
 #include <asm-generic/percpu.h>
 
-- 
2.53.0

