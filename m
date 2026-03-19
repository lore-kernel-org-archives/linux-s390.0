Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE013D1701;
	Thu, 19 Mar 2026 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921921; cv=none; b=BaOrh5vOoBSb6KhtoxHzPRFEy02Y7D46j1GXZuKmb4WrRSaw4KJw2h9BpbuUrKYvqvUgYeeqRaMGRSGMlfnBBVQEjvqnvseQRI/xAKghWDVQzGqFq6JLUC91h3qG/9n4a8LESf7tkVo6Mzz3PS866Xb5ro2CAP63aGu+wbLGHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921921; c=relaxed/simple;
	bh=yWVgz3Vqo70DLgRkPa0nVx949kF1zsRqNahtMIVo8nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOu79InOU1Dlj089Zq2x+8LMgdcEnWlAHB5jvgwxBkEBhtQamK0zBpzT392HnVtbGzgg+kGMPMatgcdh+GwZPW7WpBCK7mxbKDQoRQ+ENwgG0mxI+n9GTWIBqP8nwUkJpnsuehiIkMtsukj2KlS1ZAfhXV2mUur466BpMxHxPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cMSPP7oW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cMSPP7oW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J0ZsbT1188668;
	Thu, 19 Mar 2026 12:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KUCZUWot0q64d1Jv1
	ay9Jsjjy4iXkIDQg9rwMkYwFbM=; b=cMSPP7oWl4Gur05J8mwLGC/On0hideRL6
	UqlLzHI46iZ1rKYJ4WBa92Y43GjQahUsvHj9iFhuxeKnpWIyO/s2ZrGrXYIAbJ3G
	ma+TYkRC8MOWmmKDyhhtZwiVEOQ5IGQsi91vhDasI8BMpGLW7eyR+/WnsEulQIDZ
	fBTDUJ4UYyfCBEjGpT8myphIojrUESwhOYbRCGre/tN1vlK8tp2iCfJIptNMWDb8
	6a7xRcjJQNOU3tcTZDrAdUv+wtMJpTOku3kwJVTubDjqnWrwgrWRiG8tUl+CredN
	/vIWZfdP7MLog5WGxDZd/w8UU1YLTSHj9vu1gqnYkMYemgXJ8jllg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfs109-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J8qZTX015746;
	Thu, 19 Mar 2026 12:05:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0njb3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC54TV46596456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865A12004B;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6412320043;
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
Subject: [PATCH v2 6/9] s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
Date: Thu, 19 Mar 2026 13:05:00 +0100
Message-ID: <20260319120503.4046659-7-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rPWNwWVa92mKgaYZ6ZmJ2NiD6sR3zUYL
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bbe675 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4dLYTkTKlH5g-JvQF6AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfXwtODNm8rHCbw
 bUbOjwPtx6KeCXLaLzGDPyoj+1a6gBZ7ZVBSI80LbUfWMirzUHwlIk26VnVGv4rsWLCqpEKSCU9
 pRW8ug7Mh11eWzaJwZkWPNZ8NRfbpVsiAm02gRXzPxgHWxilLk5MXAPPqJWoYhyfdeBeVRVpiIh
 rFqzxqL3dOb/c1p6Yzg5wod1zkRsGob4mNCfhJdVxbGrJ5aJ47h0wePO6FqTLpijIAgk527lGPk
 IiQSVsL2CU5JhAkDMX2BPw3YT165vDUY9hlDpV7ebxRXcCSh1yrXFu9Wm7MS+b+/qsBQtGLgHhV
 wmnQna6HZllBpn5U1b0LNvw47KMZSgr7vQNa6XEMtLdWprGCnZL8bFzMDDCZ5BstD8Ws6Y5oXhn
 LtPy7KR/ikuFYRTvwOkKRR3CQfy07OildwBLRr2tjSHK0YABGX+bunwHOqUi3XWiNZXYuRHx/Ai
 MdCNCKndX8RNR0u2ReA==
X-Proofpoint-GUID: rPWNwWVa92mKgaYZ6ZmJ2NiD6sR3zUYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190094

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
index 2479b4748510..510d9ce1ee47 100644
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
+	ptr__ = PERCPU_PTR(&(pcp));					\
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

