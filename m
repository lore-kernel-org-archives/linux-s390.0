Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A53CCFAB;
	Thu, 19 Mar 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921918; cv=none; b=TaDSPaD3FchcvZZRQVh5SBI7yvTiwIJ0XoMEJ8dSe4/UX24iJniADB/hyzF9eFtRnJ8ulavWUHgG9VC+4m144SAb94GZM+1qYExcZSMw0pxwOMpTAHd4TREFD5hr6Ceah3K/JjZiJN6PQfGdcfzuF6jFQwVAXM+RwYycPhyB+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921918; c=relaxed/simple;
	bh=Oqom8bfGkWsUwigzYFvslJlB2/rFM+gHvI80OX9zH6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+4XXtTyTIzgFaQYbdXydmWdmt/ailh70CLBkSNQB8co9D2ViVofKX0XcdN3aZoSyxUTqbOpgZCHAqKvDVn1cEAmgROXeOF5foB1K73se1cAFDZnRreRgWyCxuNqG0c8izoIdcL8ng5v6aiRLDw6viYPvL9Qq/Vc77h2qAPJFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPpXjPIN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPpXjPIN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J2mEvD1290637;
	Thu, 19 Mar 2026 12:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jYxXCDONXc96ylJ5G
	dz3ySZ9k032X8Xsx2ZFcK9zDkg=; b=lPpXjPINZSW/WDYz+EocHb/oEt6y1lY6b
	UDRWDQkEOE1bK3u8GQcw4Sj3IuQK3QT1EM1VgMdrwdFKNCATLkdr6iQ5WGFvK70e
	h+MuE531LUcu3NY8xxQTdpgZaME7vgiKAzrItmwjmAxqVmvKIz3qe95Cf0QoRson
	69kOVoR1HgQtI/d9kUUOfAU1shYLgNWxTgyMcWh+1GCAu337QEcNjTRZehrCyrgz
	GdQTRxqCyclTBAm0FRc2TCvQMF9QSbjBKtq/QhLG74Vj06s+5LFtPtwvey4eRwRC
	8V9tjIJ+jf6dJGjqfiU9AL6GUba0/TOf+LDHBZFxLeAvd4h2J4pSg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaup000-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J874S2005412;
	Thu, 19 Mar 2026 12:05:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sjf89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC54Il52298048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE25A20040;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B8ED2004D;
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
Subject: [PATCH v2 7/9] s390/percpu: Provide arch_this_cpu_read() implementation
Date: Thu, 19 Mar 2026 13:05:01 +0100
Message-ID: <20260319120503.4046659-8-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfX2A4nlQxm1ByD
 C78MN/pMh7wnrWWC0eq7ySxYS6dVXASkDu9kE+XrzTiJuKq+TzcePpBsoVvJ/GhiBLqnFdDbvmv
 6pOJ8SB8NuEUDl/D9Xcl7GIDDZGvqnR97xa5yyqa5xb3l/u68RYsG4gKi18RCpykXKSQX/WpkBi
 CnB3E7KWTCRX/DRGEN+kD0UGt0em+pk4rG6gXTi0tzA2+mFrngPqaDgY68oI1Vr2w9uDnLKK+N0
 5G57b8xntCnb0f90UItVf+QKXP7vmQBm8JZmv91Ls0WGe59I4ZPH7p1rpwTBSbkOp5wXu4TDcII
 ecDmfTB+gM8FjwSjqRAURPNdCT3dtWuVWl8RBdMFWFDxI21qt4xDDwFgMmdhf196Y9AftIQ+SAN
 HyQvysPqj35w3LGA5N844x/P0mC3bipCHxuqjgWVFJSp2loNGpd7ybuMribHbNyJqpNsjMkyCC7
 n+6T8XA5Hp4YJncB+KA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bbe675 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4bOSrtcVyj7iNoH5sBwA:9
X-Proofpoint-ORIG-GUID: YItMeilmNlWngxygYK66DIslMHpJkhbE
X-Proofpoint-GUID: YItMeilmNlWngxygYK66DIslMHpJkhbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190094

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
index 510d9ce1ee47..08c48fa97381 100644
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
+	ptr__ = PERCPU_PTR(&(pcp));					\
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

