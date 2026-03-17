Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A555322B83;
	Tue, 17 Mar 2026 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777292; cv=none; b=KjyMuzeM9Lk46fMXW6g6uDWuM4co/4rpwhGH+nbivlKhDosun573ZEfqULwF4jXtWCSHkKHM1Vqv4WffOkD8vD+D365/2vD1MTxYbccn2s6TLkP7cIO4IsSbfpUH9mDTdLHreugEkgFyAondNlAUxionPY0bq50EkZ1FYvUERhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777292; c=relaxed/simple;
	bh=zMuIajSoxUlLt+udEfCDgyMqmfbpc/BWh05b1NnASl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLR0ZH0pWnxnR5utPrGgSHuEOe/+6CPx72fukQwbhI8v9LoSb6JHrhaDYgs7wv9+9WCt6w62veQ/LkPPFdUk43/fKQBCbQCHNbzgr4LbXhp0py3mHiNBGL448Oe9F/D8XqMJl1th6V8sKZZWiAjtJ2XhVDSHH3unS0nue4yvcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HAzHALBi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HAzHALBi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HHVE0w532485;
	Tue, 17 Mar 2026 19:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F21vk/vMMVdHdNApu
	r+5KHt3UCM5mJcfn8dG2Pxm3FI=; b=HAzHALBil2mdGJL6T4DKBDU3mSTtudasQ
	fFB4zZ6RpfFdaiYgDBKmynm5jnGRGfsec3Jd7GVRAoLQUrPAFNm21brm7+gQD4S1
	fHXPz0bAUwkT9Oh+GqHdkF+GBurlOvqh3mN3PxC7vl2YlWTn8jwuJm2osr97mjv8
	w7K7zR5jwN+9CGhaH7FxfiN3jrDW7MYip0bCkdyxF3IhVzfmB43tPjDvfeyn4a0q
	/+sn2pkFkHusIIxKun3TRAL9B4l95DLTfUttym7ZQDsARDI4RjWi7gzYtDve7ppj
	5STXUJVtoqey1vPZ+IHTjj4Fm9V4B9eBWsTqfOCFghWKdW2QYMC3g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cx497-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HJZ2gF028785;
	Tue, 17 Mar 2026 19:54:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkas7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJsc5450987498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96E692004D;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F36D2004B;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 7/9] s390/percpu: Provide arch_this_cpu_read() implementation
Date: Tue, 17 Mar 2026 20:54:34 +0100
Message-ID: <20260317195436.2276810-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317195436.2276810-1-hca@linux.ibm.com>
References: <20260317195436.2276810-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b9b183 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4bOSrtcVyj7iNoH5sBwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfX/DiTJ80GITua
 PZtiSehD6Tc4nSLxEnim4fm00sHGt7uESFTJXQ35MqQSjNcvUBmjsbD0MG5u6T9cnVJkOqaiKvG
 IFGha1H64U4nWwSkuXy7YqUFf4CSVReC70Yk5T0X2vbkVpzaigGguIcP4U42JPQaBeOm2ClOXLU
 nuOHKLEdpeOD1KOoyBTYwaOH8nZyZHfWxGVRcS84EkIz4QAkPTxeSFaH4FbrMwZToW9P2d1U9xq
 7Ai8a1kshP2J6+fshr/OycoHYJTAVUItAWgBFh4sY7x/T16f4USKVE75SqIjcXObG6ic2WyVDCL
 Ag9sK/k0Y6chkXkZQXXZ+HwSkerZDpDvfInxBQw/QoBKpSbDL2tUUeqx90P555mr5Z+SNlOsq3H
 suW4YJA9Hc3kcnjgWsdCLRrX/0iX7K7AgUIH0gSIQSEiLtZoZAcC6PKilDe5CpoEiTEjyloH1Vf
 HUsQ65MWWmptXw4NU5A==
X-Proofpoint-GUID: a96LXDpE5K0CGuaf59RMbApbgvNJEfGA
X-Proofpoint-ORIG-GUID: a96LXDpE5K0CGuaf59RMbApbgvNJEfGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170174

Provide an s390 specific implementation of arch_this_cpu_read() instead
of the generic variant. The generic variant uses preempt_disable() /
preempt_enable() pair and READ_ONCE().

Get rid of the preempt_disable() / preempt_enable() pairs by providing an
own variant which makes use of the new percpu code section infrastructure.

With this the text size of the kernel image is reduced by ~1k
(defconfig). Also 87 generated preempt_schedule_notrace() function
calls within the kernel image (modules not counted) are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index f26f03b0889c..35e48d193d99 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -240,6 +240,37 @@
 
 #endif /* MARCH_HAS_Z196_FEATURES */
 
+#define arch_this_cpu_read(pcp, op)					\
+({									\
+	unsigned long lc_pcpr, lc_pcpo;					\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ val__, *ptr__;					\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = &(pcp);							\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "	%[val__],0(%[ptr__])\n"				\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+		: [val__] "=&d" (val__), [ptr__] "+&a" (ptr__),		\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (*ptr__),						\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "cc");						\
+	val__;								\
+})
+
+#define this_cpu_read_1(pcp) arch_this_cpu_read(pcp, "ic")
+#define this_cpu_read_2(pcp) arch_this_cpu_read(pcp, "lh")
+#define this_cpu_read_4(pcp) arch_this_cpu_read(pcp, "l")
+#define this_cpu_read_8(pcp) arch_this_cpu_read(pcp, "lg")
+
 #define arch_this_cpu_cmpxchg(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-- 
2.51.0

