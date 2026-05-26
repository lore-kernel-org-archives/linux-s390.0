Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3983BFAD7;
	Tue, 26 May 2026 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775032; cv=none; b=I6FICdMTY65PlphhQEY9BssxVrfXRSrV9SJ0BDekK+5RiOFojlHKd2E0sxL7AXRqd/6SafeeVxesdN2Yxv5uzuiDR/zIlcmg7a2+qQddo247PR6d5H1PuayKz+Q1k12F0sHPPhbIkdoELH3Ei9FHdAeC3DV3mHKyPxMpN3tF4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775032; c=relaxed/simple;
	bh=8snD0Rp33NTlrJHQS9WPfU5G9iNcR8DL4dp7/u1tK0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgw7dideNfqfkPVfHX9rjLrgT7jMTYoqpaoaZ2V4dvrya5ejbW4PokrapbNVXWlA6x/M/z54A2YKrlWYsT4aYe0SNrrgKkg2t6/x4L5koTCLKKF9SkiBfWM4L1EOa1hJfLVK5TxCyUxXcIuaPpldVLLRnWSzBXdHan1arDtYMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XoIJJAgJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XoIJJAgJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PIc9jD3938475;
	Tue, 26 May 2026 05:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aAiJWe1ptyRsqDIAA
	Zzjje5rg3egV0JixWRTUR8qANE=; b=XoIJJAgJFHXnOlgdwVasuw90xkyqWF/WK
	/UldO1BkDuCThZPj65ofqpuenra39TF5aJ8L4mbu7NEMP1IHKX0IC7mHPRbPjtxd
	+wyATKo2JtaRKq+2Sa1XF1hERbS4Ixuwv2q3yfGbhDT5aKa8oM/aa6B3GzaMTSUH
	sXnoiiVqjU95z5xciQiorLtEgjU6XnnaJSdZVqHLDi7pasH8gTlk3MDdChGedmpD
	1cuddboVrmiIfeNQWkmjSrCMTjQCmD0Tid0t0QMieXvVptHb1Tma2p3qQZ4IlFIi
	mQUHFbQNjEtZtJ36qr7umooIKCBdRelko3+ULqBczx8l3SP77Jo3A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq1pq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5sD1A022574;
	Tue, 26 May 2026 05:57:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxw02xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5v48C21103220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:57:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A73320040;
	Tue, 26 May 2026 05:57:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E39372004B;
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
Subject: [PATCH v5 6/7] s390/percpu: Provide arch_this_cpu_read() implementation
Date: Tue, 26 May 2026 07:57:01 +0200
Message-ID: <20260526055702.1429061-7-hca@linux.ibm.com>
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
X-Proofpoint-GUID: lX4ZbP0K-bTkLRJGr-4JaWAcvZYmbukT
X-Proofpoint-ORIG-GUID: lX4ZbP0K-bTkLRJGr-4JaWAcvZYmbukT
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a153634 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=4bOSrtcVyj7iNoH5sBwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NiBTYWx0ZWRfX/RdYwO/x0dXO
 ehCDPgFUUbFu5UplGnQvg8wBZdFC02FWh9stk2MPXpK1eSvqWkf3m8Rq7UphjCdX3gwWWSdynCK
 8Hnjtr+aSUUEyUGeO+cEsuA6Dm0acGNRzkW47x9K5oqVG8DccMGplaTidXCCJoLeTrvoOKQrHH5
 5TG6FyMLYGocbrEtwvTolApfQCRc2tqk4MbKwxXmFqgNY/h/UVB6gDeg8zcN7GgL92WGU4r9qkJ
 pCXVdJGKjAtc4Qd0UuEicxdOzYz1viIx2D3aRpEeafpAclDVha44kQaWObdjAmm2FWBJz/It2RN
 RKA0rOSylh659qoVHhBHpV40oo232NJZ9z5MivSqfbqe1ECq04igaVEY/u+FJomRQSu+kTiT6CL
 DePaNLmFlu6w7j0KPDBXsE/fKfkFmURkOva91L3hIwTHRWe8PAGbyM8KuTXAEjkjxCh7GK+xugB
 VSFcnEqzvf5d/caJvfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260046

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
index 5e0185e5960b..83195a5dc409 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -248,6 +248,37 @@ do {									\
 
 #endif /* MARCH_HAS_Z196_FEATURES */
 
+#define arch_this_cpu_read(pcp, op)					\
+({									\
+	unsigned long lc_pcpr, lc_pcpo, res__;				\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ *ptr__;						\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "	%[res__],0(%[ptr__])\n"				\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+		: [res__] "=&d" (res__), [ptr__] "+&a" (ptr__),		\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (*ptr__),						\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "cc");						\
+	(pcp_op_T__)res__;						\
+})
+
+#define this_cpu_read_1(pcp) arch_this_cpu_read(pcp, "llgc")
+#define this_cpu_read_2(pcp) arch_this_cpu_read(pcp, "llgh")
+#define this_cpu_read_4(pcp) arch_this_cpu_read(pcp, "llgf")
+#define this_cpu_read_8(pcp) arch_this_cpu_read(pcp, "lg")
+
 #define arch_this_cpu_cmpxchg(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-- 
2.51.0

