Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF823CCFCC;
	Thu, 19 Mar 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921918; cv=none; b=LCQ67KkNLYFSb9o9MHfGnkJt63W4puEDEtNSOUQlrGvYM0A+UNRzTpMexmoPFHvoqlsEgUgJKpPCodr8FRuiSD3mOp7YGipVU2kFhlHcpohZMZdHZD3c4luV0vVJH5AYrJVJjI5VqeOvmPiPgAhQKN88oe1c91xUtXllPC+vdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921918; c=relaxed/simple;
	bh=4/SQBSS8Itbjkdjiu7TQUdqMdqIBwjIyMhd0dKJy8ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilbPQT0qoHbPuclWAqhW2y09QOyHa1M+2UHBWRFjq9jk//xF6voU9VehDPjClUSRbQb9A5AuMYtftvqx7i6p/wg0Pcdr8sCxQ8H3hNQ8ZdalLm7+2W2SBTTPBrWdTmcQBnzkiAHZZiNFO4Okgj+eS9YcQ3Phdfol3tqlNk0dmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ab04MI7a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ab04MI7a"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62INMsDd753346;
	Thu, 19 Mar 2026 12:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/8Rr5nt+h+JSZbITk
	HB/FWQiemw5Hn5dCzjOLpsxcrQ=; b=Ab04MI7ann2UGjruto1rdBqIypytq0C5B
	oq9vKotOLWhejB1YyUIm51YKAQx24OawChmoJz/RxtKTAWRE+EEY4iA60Y9Gc4F6
	jTsuWyozeF7OGTpwJfAaHpG3mQJSJOWlnO1xP3Q/U9OPwh90R/ePu/3Gz9hjDxuW
	0W+N44V9ech59mUQ/391EIK6CNsqJkVB9IV/odzCbJ1p0qEvyirG2hpg5fhRYk+b
	8zkdrVWZzYYKwqSuhwWD54YM8zpGeLRNcfMq2ZBbsRvM43OtFZxrb7y7KTcPenb6
	pvM1Xx6QCboqRlOttGlXncWcmoesoY3rnwFe6+hickDMNQLVwRoqQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j652k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J9Tctt015644;
	Thu, 19 Mar 2026 12:05:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0njb3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC54Zp46596452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 370062004B;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1459B20043;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 4/9] s390/percpu: Use new percpu code section for arch_this_cpu_add()
Date: Thu, 19 Mar 2026 13:04:58 +0100
Message-ID: <20260319120503.4046659-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319120503.4046659-1-hca@linux.ibm.com>
References: <20260319120503.4046659-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dFfITtoFiG-2wNVHgkPN9CpOv8rBStbx
X-Proofpoint-ORIG-GUID: dFfITtoFiG-2wNVHgkPN9CpOv8rBStbx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfXxixSp/4wNlGf
 vINae4NNjm5LOj9bC126OMHLK5Fb7GO/FUpFWB2vVtr8DTEpHVpZljxJu2P74iJDpHA0MPp7kYr
 vw1G8zlBXrHNsB9GCCb21oUehrpE1RgF9w2pgo5/n0I3CCwkrbK9VuoCQvpzfFYe31RADbOuPiP
 8+oYCzA41GTQ6cl9z+/Gmo+om/7+GNlCVKZdESzoFqdm+Tb9gOFgs+AbN1MAMXf5F/2E4NCDWvp
 JFfEapCJ6aRK/kdAn9QKs1Edq/9TfhEJgmspV75lMTR3gGhxZEY/9dXwmuIpDK9Mydf4zU3TXlE
 5Y6MQn0ZDScCdTiDHQiT+GMKNBLZffkmax/JvSjgxh4B6HaiuqhCliBbE08Bf0tSpPQt+1PWDy+
 LEIUykHshemfo0agFtqHbNnVANfyJbJFweBjbmt09yEz4IqICvstDT8gKN38m0QGGNtl36Asgpg
 8wMpoJObcWSKRr1JBmw==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bbe674 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SujZmW7ZfIunUtho7CIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190094

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
index 05eb91428b42..3c5364475e3e 100644
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
+	ptr__ = PERCPU_PTR(&(pcp));						\
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

