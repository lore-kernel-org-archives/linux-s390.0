Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876C3783C4;
	Fri, 18 Sep 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721343; cv=none; b=IiMl3HGA/qp7CCwez2fcjDBR/S90Ba5/Psy8ueR8Rhs9WJd4egs71pu6/Faysa8TpqWQ7FkVygjIsxSuKPZcZ7JvbAIYuXbu4N/0fMA37PA5G0GdNlnfCpje5VFMFmDcAe0qe0+BzjgfoVeciSYK3+M2/YdbEIX2T2KogxTJvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721343; c=relaxed/simple;
	bh=hsSTMnOkgCVsq5THFPEcnlXpX+RhuzOtkcCqcE7Vxus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1iS4HrmZxUS8nDhbxTIctuID3dZLrzedtUIRduuO7/VDMbgOXw5ZYBx7z5hIpBc90jypFj+KX/ug6pxJScLZcW15h7KpTBrGRB41YlclnZfGoTRZoTiwUadJNm3P81cJjGUBzMDN2FsHeuqisJ0S8Ypvb/RECTwaJ1ufytVBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PjhhKI7c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PjhhKI7c"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61fhx498317;
	Fri, 18 Sep 2026 08:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+aIXhE5xATl253AJX
	z4Do+ZDyBBQmjcdPIpnowKqkeI=; b=PjhhKI7c35Zx15/6au8BiUiLkwx2YiwTH
	xCCb8o8L755fpiypwhZVre6ol6Rv+QpiCbzE9xay6QALfh0Po47Dj9zH4Ag52Xff
	q/L9hISQlc4W9qu4kFgaeqvsVD+gCQrTdcOY3VxoAflCc9vEON3HzOWNyfSf+ezl
	oInlzz1eEPJZ5+4mmXPNr1IvXBzOBUEEWf+Ea/2cRIWgrNLUcQSeIH2x5kuVrLY7
	7e14ubgq4HlBE740zfIgw2+fm+6+miG1KvMFu0ITD1QBgTT5EEyEM0XWKb2VSjUb
	M8ptFjY7Krhzq03DnPhs0gN6PaSL58GECelUXyo1XOAy+hzjlPtMQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcveggk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I654pl251880;
	Fri, 18 Sep 2026 08:48:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3ywm6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8miKO32178456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E89920040;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 740C620043;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
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
Subject: [PATCH v2 09/12] s390/percpu: Use percpu code section for this_cpu_xchg()
Date: Fri, 18 Sep 2026 10:48:39 +0200
Message-ID: <20260918084842.2333237-10-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918084842.2333237-1-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX4e734ZXrRoyk
 I24zDUzGqj1h5sQDFU2MEvKqJJFSYB6aiyGxfKyVRsYtU5h0H05unSYqHHoQHfPNB1dmspBNhRg
 l4o437WR6Fof40mQI3EIJowX/fGZ7E4=
X-Proofpoint-ORIG-GUID: 5xCKCya4EeDuM_N1gzCzBfNvvNWfO5xH
X-Proofpoint-GUID: 5xCKCya4EeDuM_N1gzCzBfNvvNWfO5xH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX0GjDJ4IClgDc
 yrMwEBzg7POkF5b+hi36GKjXJo/dOU6MANeRSdVUnQ+ZPnhtyecODZK/OzNRALpFFBCC5+a6WIh
 +36ZlROYcC20tjXI9oUwaFv7hwE67xabbXsrpK5IvJ5fOgmBvel2rB2P2mb7SQDr/Vnbd6W8Xz9
 asY/M14ufvEYAYMm2yn4w6sVLhGFOJ8e4nv52NmrSM4e0Ypw2oZBT/tn1sAc/6SKW/E4OS6B/kB
 0bvic7+rghMLcB6/pDSEKTu0aUTnZhywwVmxYEUwx9cs15gF+/nFXpTJITUen6t3S3w9fkOmxMC
 jzD5dz2tL3s3GQtAmRkaXPCu0IyVeceiOajCoiA9zGQiXoh+40l2Q62eeNC2cZY2va00fCCo/v/
 obFVbQ1yZmMcyRAaQ3+pzoNyaSQa1wJQ/S92ibX3RSf8c333Y0RPBCKOQPMDb701yPUqW0XAoAF
 kBqw+/DYoslTiH/rQAw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aacfaf1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CR6qe3_hcmaCbRXVjxMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180117

Convert this_cpu_xchg() to make use of percpu code section
functionality in order to get rid of preempt_disable() and
preempt_enable() calls.

Consider only four and eight byte usages, since there are compare and
swap instructions for one and two bytes available. For one and two
byte use the previous simple implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 0eae65937c0d..237bf8c80843 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -331,7 +331,7 @@ do {									\
 	old__;								\
 })
 
-#define arch_this_cpu_xchg(pcp, nval)					\
+#define arch_this_cpu_xchg_simple(pcp, nval)				\
 ({									\
 	typeof(pcp) *ptr__;						\
 	typeof(pcp) ret__;						\
@@ -342,10 +342,34 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval)
+#define arch_this_cpu_xchg(pcp, nval, ldop, csop)			\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ old__, new__ = (nval);				\
+	pcp_op_T__ *ptr__;						\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		"	" ldop "	%[old__],0(%[ptr__])\n"		\
+		"0:	" csop "	%[old__],%[new__],0(%[ptr__])\n"\
+		"	jnz	0b\n"					\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "=&d" (old__),				\
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
+#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval, "l",  "cs")
+#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval, "lg", "csg")
 
 #include <asm-generic/percpu.h>
 
-- 
2.53.0

