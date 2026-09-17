Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B54E1C76;
	Thu, 17 Sep 2026 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672978; cv=none; b=ZeSFLo6vywi8Hafgz+S7gWvnPHmW3+0f7H3EFnJuiXq/F2pBbCAGjjkJV5FxzcWonqiCvTU1NyRuI/Mcv/u8kUYYosQox46eewszmd7y+H6V6iUHNuRGmqN/HEv4+/3u6a2QTjajHne9LfB6F8CTLHWOhg6tahS9UfjZwBWRzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672978; c=relaxed/simple;
	bh=xrGN8LeijjnGj5GORr4MnMawzfd6noZ622OIpsikzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWwhT/uKFpiif4LBqzi1krfBtwQ1Pommg1ULNUsY2UkPLXmGDkyQszsyafGA/O2mhxT2GVDvM1re5ANCFhMjE3mI5NR/6m+W0K9LkxeNyO84Kp7M998zhXbwTVJfmhhRZmZJzSbPOFJXNCE5K4C2Bppd7vzJVibQWOY9SKnEq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hWfyszTJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hWfyszTJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVQ7P3143228;
	Thu, 17 Sep 2026 19:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RmfRlMunYDrgwFNZI
	BvZC4D83yPI7wHTx0KNdHPuDbA=; b=hWfyszTJgvZkBwYxw7orB2SMD1jt6uPas
	ewYR+WyP4ose1xd9Fd/frJa/FvwTk2gS1krD69kFcP/sqEHxUoITwi+uibTj6/vv
	iNtRfzYfSV1TM7TDBlGnWRsvcssKCykfi0PpPJs05cFwJuHgo0bQRUi/0L8mrTfM
	VpsCk9+xl7rwLxIW1qqadoFjx/is9E2RA6trdmONhlC+e5kqp3RruM8VqS/z9EPl
	Y3vdW6l29MjXCyn8M0PearBq7Hr1QQzFqN1k9AvOmeazJds76NpfS6N8Bo3sdeJD
	ZqYf1fYVa7Ztdkt1IDjM2s45ADUuWBXZEhama58Uj+1gf6a3T7Hcg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx844d3j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH93oD3510145;
	Thu, 17 Sep 2026 19:22:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa3w6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMd3V31982274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EA3420040;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ACC82004D;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
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
Subject: [PATCH 10/12] s390/percpu: Use percpu code section for this_cpu_cmpxchg()
Date: Thu, 17 Sep 2026 21:22:35 +0200
Message-ID: <20260917192237.638324-11-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917192237.638324-1-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX/eTf3YqBsNZ7
 r1TYqhX5BZFX8j0eFiA6xfJf6ofhvYDf+Av0DQFYeGtyQO0X9xITaqMr40gSIAfjH/478UzJOqy
 W3JjAz/SUehQkXhA6oaou/Ub5WAD87xr0c2fY47+Fm2s3P3ElzE/mDiRamCFnplD/pDBBu8Yy4E
 ubOGyYVyKBDURTYLNS+hJfioxAwmFTG2pWzXSx5k2SfHdcC2Gz+xTVOrdFszYhFyBroV+YzZRyx
 81rD1y+fapKPSzvOZZrE078AdAbFrMfEGM2RmKswIzXR+nm+0cHgYJViAmKHA7OsqEEmvdE6rVY
 zx15t8/YfWyuwGjKMR7XcIlbxBDN96h+hRRXGaVS443Hr4h5NGcQr7uLkBiiCYcaJzn1KZp/ZBC
 4nj+PyW792R8Y1oLW/NWfmGYg9WMq/7MIZAXdHGraG3DkcHwLprza3tcbwWKpyc4TktGsMNsQrl
 M9dGCVo2dm0LfNcyc5w==
X-Proofpoint-ORIG-GUID: OGhhr72x05ULRZljzmO0-9yE9jjXbEZp
X-Proofpoint-GUID: OGhhr72x05ULRZljzmO0-9yE9jjXbEZp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX4XyAM7d/6XhG
 zLGJHDJ5jn8s8oMgYdPCMNyFyyX9447vDBLZosMirFNv+zkn8NaK5w5SC1IHW61x7zCUf+9ViT9
 pNNiKWDmKQEsBEZDeagQe1WFJfXroGs=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aac3e04 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=xum8VS0YelhL0tLUZrYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170272

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

