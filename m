Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93195421F10;
	Fri, 22 May 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459197; cv=none; b=oPM0yrPsRK5vkzei1veh3tDHgV2QtyVlSith3wJ7LOF62vKgB9N307siZS9l0WuyaWYCyHae1oBA0T5tkvkt3jO63Y79YeKR3DZ1cFNMwB969CG3Q9Hkk+5dZ2mrC/nyP+mOyWNCf4JHFkkpfUrAc0KRaVqmWViurqokaDNFZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459197; c=relaxed/simple;
	bh=NpPn4ELfcR8XVH/mho/bZeNOVATbqfABoWtMd+c4jTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMEkbKWmCEJUEmKIcKjZ+GEZlMm3wuOBovpOBlEyR3FadJa5pdQmYvLVx+CHJZcvESajYU5DhIXA/ZzKUn78o3wJXf8lw5FgeAnUOdKzk+OwReN09nLB3eWbDdYaoFotb/h3xVIGN+TsVgbPEH+eHROfN2OBvytktDrdYZINBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h8xD0kea; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h8xD0kea"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8WfMJ1249248;
	Fri, 22 May 2026 14:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w4VLruBjFnqGeLxXB
	934mHc/udarqvdvuNRwsV+6fx4=; b=h8xD0kears7x5bGmdU3lpUlLfbd6rsb+f
	ifflWSmE/PhPgDV+DfdZUPhdBiKCfG05QZmuifbKuiGpUS2yNofoeVbhdDDSTTgK
	vnZArPsH3WtqpFAdFx8PAa1rcwLG927YOsGm3YrhOt7US4i22hVp7+DxY2m3eWa5
	bpoxnmIFVpC4YTSHKalOpWdEJj8ygCjDdcXqV9h4nEMs+X9yPn8D6f81a/G1tubo
	vYzlwGOBigkYUbHW44iMq+cfIRi9Bz5s3eZd/dArSb9JPNIJJ7DVJIXT3eEN7k8F
	95h/oOf41EKyXtkp+jkwDCAcVQIXBnnZ8b6wJRqLD0qg7uTYdc5gA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88ttnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME95uf030285;
	Fri, 22 May 2026 14:13:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj149u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MECxn727328920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:12:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0805320040;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBBF2004B;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        David Laight <david.laight.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 4/8] s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
Date: Fri, 22 May 2026 16:12:53 +0200
Message-ID: <20260522141257.303617-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522141257.303617-1-hca@linux.ibm.com>
References: <20260522141257.303617-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2dh4-TpR8FUbH5IScx-TqpkornKRClnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfXwJ5QdVAH42Ov
 rPDeFF4y2GDqU3PWJDs2j7rK14c8SuPnVtIzozg95QRIONK/SFGz676ZL617uIKbyQ771dfKDvR
 RzugJoR0DKV45HbAi/ll3dD0D3PSko6tVXbHRgUlpG9uh8kw9ayIBF6HBRqiXWL+uUYXnIqohJX
 1O038a/Wa5vjywGQPLBw4hHOsP5EkiqQ19CtpjkYtK6PBMtxHjUdfTNwQUObhHNw7/VPj7nSr71
 cuaHFWtazY8BdAbh7AuIwDQSzwplv5QpF82yZ4DkoElsj9+bIan6u4TnlUmWPpiQl1lFvfFWoAS
 YJEunLoVb7gPyYa80Q2+VU8IrL1VGcCNvsP+YcbuFc4yPCfyk6cAfKdubGktFYqXcZXsMw4Ru/b
 v90iceplJi74x5QEawSAsUumo3acJpeYljJHnrnl1VHJucKvVlrGeXbkeRf7pyO1i0fyAjKIpUs
 JpXXsnmMsZTBAfdYY9w==
X-Proofpoint-GUID: D2llKi9se_5JyLqMtwqo1k7p5bvT_3aN
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a10646f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rpl92wOeoJCnW_j-IKQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220141

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
index 9140d81b7efc..f2d0e0354582 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -185,17 +185,29 @@ do {										\
 
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
-	preempt_enable_notrace();						\
 	old__ + val__;							\
 })
 
-- 
2.51.0

