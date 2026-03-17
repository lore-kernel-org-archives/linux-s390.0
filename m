Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D6344057;
	Tue, 17 Mar 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777295; cv=none; b=NARXPIOK6HwyW7QKA3D9HSIPTgzwECywu3b2Pup/d9Dgq/DTkJZjEdDbfqBt6DeBYxRsMI/0gmcckyiczixswj5HYCYX8K6YD0T/iVz4c1yFSFsVIvqPgdX/YZSNkUi/PQ83shh3r9QoV435y25Wyp691ZHjAcXH+JWJDGy1L/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777295; c=relaxed/simple;
	bh=YBxhvxEpN/HTLz4ZjGnc5Y57lSjeh1Jdhu+6fKkajQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i51ZyioAljlrTDJYW4AUobkQIua962u7ZmsSNOBj4+vaUQbhST/mAnhtMt9d+MGuvMrVxFCYPYsXn39/qbVwBhXs01ctuGPTNc/kXjIBE06cCmz5UOp/viETdfxQagR2T9rkupMM7zj5mC4mRG78OJEhMEQpfk0W9zcqMy5GjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oKvKwIS/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oKvKwIS/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIKcNR617441;
	Tue, 17 Mar 2026 19:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xG2Ad3gUwaVAO7PyV
	lzDgxDYYf5LcnXNGAKdUk6zeYA=; b=oKvKwIS/MxDbhVk0x3BHdw+R9pl8I24QZ
	wYgdKtYML1pYXwDF0eFpFKhk0UdQzfdoZEWdGMRL3fu0quiLxrCfXvH3N5Z7n/HL
	iNnkaoN2GIHxFOWKGBI/eqACVEOvnduU7egKDMoGbenQR+G7GqPPICNGyaYMqFag
	H3SF34Q+zEirk+polukHa4LPOUtcTSReNlXXXNmLB9OP2RWcStT7/J1hLLxK6tQg
	vPGM8wuFltt78vTFlIijwViJKFyorwkQXCfw54XvvQhTU/cELrh2PdG394aGnmUK
	8aL+NdKswBLVO9MYJNEWdrUYjgBjYbiuOUMOsUaxXR1bO9WCrcv6Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs6m86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HIeQQE004563;
	Tue, 17 Mar 2026 19:54:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sawx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJscsH50987496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68FF920040;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 414C52004D;
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
Subject: [PATCH 6/9] s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
Date: Tue, 17 Mar 2026 20:54:33 +0100
Message-ID: <20260317195436.2276810-7-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b9b183 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4dLYTkTKlH5g-JvQF6AA:9
X-Proofpoint-ORIG-GUID: GO7A18wmWyi6hnPV3aYCTGmB12z1yBh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfX7/za8DarR/E3
 2K/X9RtEOn5hBl32zCEYFDAvSNVGE4vztVZk1Qns2SKAqk+ZFcp6JhfoGZukaOkyETtYmZAEnXV
 UX0PGimrxru1l1LlspW37CjxGnX9T0n6WOl94CFGHP72FrFDwzK7sf2/ONo/8qkWQkkuLArWVbs
 CZf4fOYbX2fhwcHp1YTmrdCPOoqxAZjd8b0Njpit/cG6KkLq79Ie3sIWACY11u+mpfxtZHP2bP1
 Lj9QMXB3qMqyQR6bDlDX2YKth4HCH1C8E0VJMemIJ6e38NuB4CZQfNugtIeWQ9t1BqWVpX+b0Bb
 LCWCFr64f/EEQ+yV4+P7chWqNHGZ+EMGdx260rC8hVsmpO45/Jp3tTJH0zdSQvVlxW7KAUpN0e1
 A2gYDfKRBiTfqOUA9NUZYyNuVTX+r7/Lw9MzJ0vP1JbravdjPBIwJfwUlhtiyN83dv4J+oO8VCp
 Bqd7T9syifHEmwVwG0Q==
X-Proofpoint-GUID: GO7A18wmWyi6hnPV3aYCTGmB12z1yBh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170174

Convert arch_this_cpu_[and|or]() to make use of the new percpu code
section infrastructure.

There is no user of this_cpu_and() and only one user of this_cpu_or()
within the kernel. Therefore this conversion has hardly any effect,
and also removes only preempt_schedule_notrace() function call.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 6e932f45f128..f26f03b0889c 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -208,17 +208,29 @@
 
 #define arch_this_cpu_to_op(pcp, val, op)				\
 {									\
+	unsigned long lc_pcpr, lc_pcpo;					\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp));	 				\
-	asm volatile(							\
-		op "    %[old__],%[val__],%[ptr__]"			\
-		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
-		: [val__] "d" (val__)					\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = &(pcp);							\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "    %[old__],%[val__],0(%[ptr__])\n"		\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+		: [old__] "=&d" (old__),				\
+		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [val__] "d" (val__),					\
+		  [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
-	preempt_enable_notrace();					\
 }
 
 #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
-- 
2.51.0

