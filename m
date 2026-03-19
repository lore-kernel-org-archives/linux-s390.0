Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414F38F95E;
	Thu, 19 Mar 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921919; cv=none; b=pL5Uiu2jKts4L4+1Gwuwhy0qlQVya7DCbq0hiHxwLU/yQPUUuVCL1aNLL8j2Ebm8+cEfna5QaNDSf8XkKnzWHSD0+kqVnMVQuo3/a1NHP6IDEH2rdy7f1I6o8s0LMCIxNYpz1474Za4XuuCJRA1qVYqszEFNzptpO/AAVrIRf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921919; c=relaxed/simple;
	bh=vXtUTowqziaicsjtIv7lvPZpUwK6soubRPCCqW1azRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbdu942eSkt0S9XoMBIgJaQxqFZ7UlZA0MLOdf/dfGk6iqS0xUSrlzHv0bG5fFINUQ4FuBJ4HOa8MvgrqR0MCFqYWLl1dTK0705uEz2kryUWqp+Y6fXY18YxAYNthCgWMbCJoAdH/wzrHgofkQWIjsvp3AfKW+Tslsi49R3DJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ifYuhh76; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ifYuhh76"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J250wT921100;
	Thu, 19 Mar 2026 12:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HJIc3+2rGvK7CufqI
	qAyPhxCgf2VMtEdXJhBQpESGcw=; b=ifYuhh76/4VOUIpdeTyIAzLqEdLw9K4sg
	xnKha60fH0NpvKJrJcsFO0ZDodjeeY/0cctPyNjuabscuWj5siLtnGjtdbCnRS3h
	Y8xYZRqGQthg8e3auZxFT2B2bulzVEjUqFJHYR0rLEC81h09mj/vqxuEO1jo7Kld
	oCJjk5BswMr79yf4vODdJoQEoVRJLupoV3gtn8UU9cWEGJF4UgG6F5c4gEldLOPb
	U1xhdG3OkWB4tMGBLAHjzwjIkF3EdElY9bETViwsapyvgW554H20c941egIC9KG0
	/dl9K0VvYkuFvjX72N1b/qLN31MCOWkRUZtpOQpWEwhIQX6zIUsrA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaunyyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J874S1005412;
	Thu, 19 Mar 2026 12:05:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sjf86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC54rg46596454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC3F20040;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C7062004D;
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
Subject: [PATCH v2 5/9] s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
Date: Thu, 19 Mar 2026 13:04:59 +0100
Message-ID: <20260319120503.4046659-6-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfXycnCVulmdYbU
 S/19ffV5nQbqyM7fOaGFWL05l0HWdFZH20KgzEuSrRTgYuHbf5nwe9x4a5zPDb/5YV1HzMQlS2P
 0aQ2R5zq/A7ORCETOLQhLjRqFZ4ijcalMsbO0GAJ0uotAFmwXvhI60wkRtcomK0g1vZdXD1xDHR
 jUIANTzkyIe/cfrUErNfqkSjT187sSqhuI3sgFmltOO/sSc5KZ+eaE6Paz4oMk3va/Qz49JNtUc
 48uIPn3vxRwiemwkl5NASLDkUjFtfw8vLAF7Bdsc3v5WrujyceNjjnBg2+M7QnziU1YJCFqOflQ
 5zQnYO7Y0sAk1q0b/nb2AR4UaS3ZmQC+UiEdRJ4rkgtZ8I7tDGIfHpLhFvmwu5tlPQr4A4SIBEB
 bwwfYdmU0I5/CBJv1CGpDnxYICfZXdmAbvKqMXD/WlrWC7wsZRgAA1omiacgCttFqiJpzlqQg5f
 x4/r6L6yxcs+ZCMfM1A==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bbe674 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=AksqfXeGXF_AYWYsu5gA:9
X-Proofpoint-ORIG-GUID: gbszMLxAqzqX1ucRdpv1FLs2QiVlWZig
X-Proofpoint-GUID: gbszMLxAqzqX1ucRdpv1FLs2QiVlWZig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190094

Convert arch_this_cpu_add_return() to make use of the new percpu code
section infrastructure.

With this the text size of the kernel image is reduced by ~4k
(defconfig). Also 66 generated preempt_schedule_notrace() function
calls within the kernel image (modules not counted) are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 3c5364475e3e..2479b4748510 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -177,17 +177,29 @@
 
 #define arch_this_cpu_add_return(pcp, val, op)				\
 ({									\
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
+		op "	%[old__],%[val__],0(%[ptr__])\n"		\
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
-	preempt_enable_notrace();						\
 	old__ + val__;							\
 })
 
-- 
2.51.0

