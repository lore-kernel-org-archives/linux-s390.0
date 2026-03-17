Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEE2D780C;
	Tue, 17 Mar 2026 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777293; cv=none; b=CEreiH6Hs3zUp9C0PTuuTEaQn7oaEz8fk1Dn4IuVSsIe+ls19lEIbbR7Bs3ptBf0EW9Ncr4MfivFwszckA3Xv0U07ZS/RACL4+CUOF1CTWOo3sZje5XLe7CgL5P4UKP6plEBtbhHZD10yaStse79MdseQkW2/oFmTYHV9f+2E/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777293; c=relaxed/simple;
	bh=3gl86jo+8bIc3OfiiGsNB4ocleZ/BnIClnxir6Y4Ldk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpvFZR1JGuXUIoGydNgM+OCv45/kqOjFIC30EUDVUPjE+OQ+f49inJu4JPOTgWrSGX64fh2wM/thw7eRjPLrw9EaEBvP5460r9GZo/jsahW2Iu+SlPq53qkaKEjTBKNmaa8vpSiA6BsOnpIRbrr9+yvOHgSpdahfmBgx2PGaB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j6WB2TVI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j6WB2TVI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HJeIwf949953;
	Tue, 17 Mar 2026 19:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iNCx15pa7MH7X5LzS
	pxKLgGYfzmW3lUEW/2ZCCL1/kE=; b=j6WB2TVIWdO5S0P/74GY2dOZeTrA4Fyqr
	lw5LzHVsoilF5VYK7jZGpVnBtWbUICowrhSNNwUz0XyTYZD0Ddqa+Xiz54d8nyT0
	3iX7tKl35MxHDb2UGg2Yim/NKFjGsqM5lLSJGwIwyuccb5wnM1NPlD/r15babRBn
	7dWgQ6QF0b8sUh0PTQ/x9mrcaFL504XSrTpeZzdHV00yNpUALoviTT6cloytyTvF
	1HQrL4fMQgoIK6NmFcNBhh6ktL42KoH1D59wTWZET/7/p+6J7nQjrPgnfAWYSMFd
	2q6iUYe4bCgQt0WWR9B5vIB3jQc/LR//UfhP4hJ/scohJ8+rxmlBQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs6m85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HJjO3v015676;
	Tue, 17 Mar 2026 19:54:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nasq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJscLe50987490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DAA52004B;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA61F2004D;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/9] s390/percpu: Use new percpu code section for arch_this_cpu_add()
Date: Tue, 17 Mar 2026 20:54:31 +0100
Message-ID: <20260317195436.2276810-5-hca@linux.ibm.com>
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
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SujZmW7ZfIunUtho7CIA:9
X-Proofpoint-ORIG-GUID: T5ZNf9kT-SlQ1bw49jZC965DXJ2AEaUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfX5mPInKBvsUkp
 UR5N+l5zSr92h+zISTvrPOlOVHaFkFTXcATCt51x1Fj3aFkxNFgvxnWQhUxoZztFdOJCbjC209O
 od8QST2M18+fZCsn34dyfRIeZcH7fQn3qqzNryQki2A2PWOFkSRuhJ/uuVkrzVOL39JW1bC1s0O
 cRORDiVIK0bg2gqANAcWnmhJZTe7BuNP3Yp2HtQPzal70KBXa9MflEiCmyGHfyAq5cjVxhpDNl9
 rhhqL4jBqk4iaLQY6UOZRcADRR46aG79VCeyDaApxSx8PeDvbFLxbUyo/54JZ0kTqtArPe82Ixi
 2ABgUoFST9AewHT2aQh1+dpJLaD6eu1d2n6OL+ib5eM5ThDMHl5c/RG4nvByl89tAma2b61/MVZ
 dxZdrr0q6UGvhOQ1aLSCT7hgKJhDitPLVrGGQt3TmFiXfZwngUElb6FnBde1tl0lMa79yCz7MM9
 0tceivmIB/WGxpiV+Jw==
X-Proofpoint-GUID: T5ZNf9kT-SlQ1bw49jZC965DXJ2AEaUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170174

Convert arch_this_cpu_add() to make use of the new percpu code section
infrastructure.

With this the text size of the kernel image is reduced by ~76kb
(defconfig). Also more than 5300 generated preempt_schedule_notrace()
function calls within the kernel image (modules not counted) are removed.

With:

DEFINE_PER_CPU(long, foo);
void bar(long a) { this_cpu_add(foo, a); }

Old arch_this_cpu_add() looks like this:

00000000000000c0 <bar>:
  c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
  c6:   eb 01 03 a8 00 6a       asi     936,1
  cc:   c4 18 00 00 00 00       lgrl    %r1,cc <bar+0xc>
                        ce: R_390_GOTENT        foo+0x2
  d2:   e3 10 03 b8 00 08       ag      %r1,952
  d8:   eb 22 10 00 00 e8       laag    %r2,%r2,0(%r1)
  de:   eb ff 03 a8 00 6e       alsi    936,-1
  e4:   a7 a4 00 05             jhe     ee <bar+0x2e>
  e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
                        ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2
  ee:   c0 f4 00 00 00 00       jg      ee <bar+0x2e>
                        f0: R_390_PLT32DBL      preempt_schedule_notrace+0x2

New arch_this_cpu_add() looks like this:

00000000000000c0 <bar>:
  c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
  c6:   c4 38 00 00 00 00       lgrl    %r3,c6 <bar+0x6>
                        c8: R_390_GOTENT        foo+0x2
  cc:   b9 04 00 43             lgr     %r4,%r3
  d0:   eb 00 43 c0 00 52       mviy    960(%r4),0
  d6:   e3 40 03 b8 00 08       ag      %r4,952
  dc:   eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
  e2:   eb 00 03 c0 00 52       mviy    960,0
  e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
                        ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2

Note that the conditional function call is removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 65 ++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 05eb91428b42..c92b41efbc47 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -127,28 +127,49 @@
 
 #else /* MARCH_HAS_Z196_FEATURES */
 
-#define arch_this_cpu_add(pcp, val, op1, op2, szcast)			\
-{									\
-	typedef typeof(pcp) pcp_op_T__; 				\
-	pcp_op_T__ val__ = (val);					\
-	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp)); 				\
-	if (__builtin_constant_p(val__) &&				\
-	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {		\
-		asm volatile(						\
-			op2 "   %[ptr__],%[val__]"			\
-			: [ptr__] "+Q" (*ptr__) 			\
-			: [val__] "i" ((szcast)val__)			\
-			: "cc");					\
-	} else {							\
-		asm volatile(						\
-			op1 "   %[old__],%[val__],%[ptr__]"		\
-			: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)	\
-			: [val__] "d" (val__)				\
-			: "cc");					\
-	}								\
-	preempt_enable_notrace();					\
+#define arch_this_cpu_add(pcp, val, op1, op2, szcast)				\
+{										\
+	unsigned long lc_pcpr, lc_pcpo;						\
+	typedef typeof(pcp) pcp_op_T__;						\
+	pcp_op_T__ val__ = (val);						\
+	pcp_op_T__ old__, *ptr__;						\
+										\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);			\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);			\
+	ptr__ = &(pcp);								\
+	if (__builtin_constant_p(val__) &&					\
+	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
+		asm volatile(							\
+			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			op2 "   0(%[ptr__]),%[val__]\n"				\
+			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+			  "=m" (((struct lowcore *)0)->percpu_register)		\
+			: [val__] "i" ((szcast)val__),				\
+			  [disppcpr] "i" (lc_pcpr),				\
+			  [disppcpo] "i" (lc_pcpo),				\
+			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+			  "m" (((struct lowcore *)0)->percpu_offset)		\
+			: "cc");						\
+	} else {								\
+		asm volatile(							\
+			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			op1 "   %[old__],%[val__],0(%[ptr__])\n"		\
+			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+			: [old__] "=&d" (old__),				\
+			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
+			  "=m" (((struct lowcore *)0)->percpu_register)		\
+			: [val__] "d" (val__),					\
+			  [disppcpr] "i" (lc_pcpr),				\
+			  [disppcpo] "i" (lc_pcpo),				\
+			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+			  "m" (((struct lowcore *)0)->percpu_offset)		\
+			: "cc");						\
+	}									\
 }
 
 #define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
-- 
2.51.0

