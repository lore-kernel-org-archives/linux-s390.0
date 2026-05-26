Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C433BFAD5;
	Tue, 26 May 2026 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775031; cv=none; b=RitstomDy/ydnlNuRn9hjX3g6AghLNptgO0wJSHwwEI9Xu6l4ERuOCKn+6+sDMM7y0XdwmTh8EA9Wro2FKqU9NSuTZPoBU3oKuvuKRjnDqaN5U/hnJyTbu4DjjAE1xXzsrX9q0pIlKeiTd6mlnOdq/eCq0F8v7D13G9P9YJPj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775031; c=relaxed/simple;
	bh=GaYj1K6sO65BvmgdyPCtcYf/B0XutCChjv7AN9LJEoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtFUcr3ii/Jrd2YHf6lBJjErgoswII0rnDzDZoUfPAorfiCV+fdcpSGJMB9x0iuAWtK8MyCAOvsFuXOYqRFF68DuHyGPZPSubCaN3/BQKX0Kc2eWtdb9jFIOiDmt+lhRS49InbUVIVRS/ofN8WqYBTJWFYJEMRGN/JQPOUv+vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nxnXQ0JK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nxnXQ0JK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PL0gel645442;
	Tue, 26 May 2026 05:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ca4EJwt3Fxr9YM+Gd
	7nvh+qnRJop56S/2rZYP22tEpw=; b=nxnXQ0JK2pj+/GJ+XZfozb9Ti5dHavwW5
	zRGDQyzQlT9/OcPYoHAI2+C4W/UdZIR2vDeRzacMFIGDcBBAd4Zz5gGIaRWvALTh
	EpwN0EZkJr+V5waX+XBqCtjYnD2iMtd5UvuinOS8/klcFd3DO/RGnFmv95NEZv8B
	V/eEZSu+rFVbCY5AfPFxQG5hI15CfTNQY1wpL3MUlYYG114YlUoqk3kjGCpHV6xz
	X/1/UUOM2Vt5RCTtZ/TqXwfqq+5tgG4DgpaCgtXz4FF04XFvs+QOGtH9mXIcSeR3
	4UBn0x/FOcmcs0dJOMk24wdKszDsjn3CLvPHxXZhDuNf1nEv6T8Gg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc1ng3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5sRH5022622;
	Tue, 26 May 2026 05:57:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxw02xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5v3mK52167020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:57:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD5A20043;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C492F2004D;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 5/7] s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
Date: Tue, 26 May 2026 07:57:00 +0200
Message-ID: <20260526055702.1429061-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526055702.1429061-1-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a153634 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4dLYTkTKlH5g-JvQF6AA:9
X-Proofpoint-ORIG-GUID: PSWQ13bMMSalE2ZEI7En-vpjHCh-x9ob
X-Proofpoint-GUID: PSWQ13bMMSalE2ZEI7En-vpjHCh-x9ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NiBTYWx0ZWRfX4F5egPZuA0Gn
 nIvJUqveNFRD0RbXavULVx2dAAD1lKgxK9xqVlWa3YFycQKX5weO5cJPd3a896W1ehcjMem8Du9
 neS/W41zLWBu1UQvgi5hS8L4gumLHMQSbp2gAIkr/8TJT1m3EzbdMGvO9oVXjbxUIRZfUginNmb
 iR7UXIp2CvJJrTc65U9fTQF1fEvA2Id65ECCaw2F5r6NrTi+RFORYfBBO/8s3BdM36FC6B3MWGc
 PZ8ZD6iK69Fs5CYUJQx1hr9q8sO7RF+XpUTpxu/3m7pG4I39yblgc08NaceBr2xcCyx9RfXYc3C
 CvbUfsqfcZulAxEQ8p+lB2vh84/FMOC8fD7q6fgayu8eqIswD1cJhFX40CzOheBkZaVygWBDMlW
 LecalnyL3aNJFgzXgjLxjGVaQHKK6hPDKexaQnoo3+ODHW2O/1S9ZHI8vJGKXHERtDr20c6q48a
 KV9TCh4WudDwzzwSzrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260046

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
index f2d0e0354582..5e0185e5960b 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -216,17 +216,29 @@ do {										\
 
 #define arch_this_cpu_to_op(pcp, val, op)				\
 do {									\
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
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "    %[old__],%[val__],0(%[ptr__])\n"		\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
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
 } while (0)
 
 #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
-- 
2.51.0

