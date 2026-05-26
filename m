Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953313BFAE1;
	Tue, 26 May 2026 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775031; cv=none; b=E6xIZYUTyHfVdNSZmbOz0Et2zrOgGjIoakI52GoQJW8f5by3H76690UrG0+eawVoHoWiY4CvBR4P8zXAgq9eLoSsDDoylI/gcbkj+B/UyZC8rpLsmXCCCeMEKFmx3rAUVdOvno5nrH+nONQ7Tjt5rB9JbHelbzFsNTSSc4EI3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775031; c=relaxed/simple;
	bh=NpPn4ELfcR8XVH/mho/bZeNOVATbqfABoWtMd+c4jTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+uuqdiAAtVgV5jimNy0EKNV+dvOwjkQd2KKR4arHHBBarJ0CD8E8x0N2R1KeSGPj/ltPU681FeKD3wjqpRk0snAYpyj0ZSiIXyTqy0GddhIy0yly5qQf4HkRNZcl5iqoGzJXwPXyJI5oMGmdNcxW+PiVt2Foqm2gy8mKi1IwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nSI4D+xN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nSI4D+xN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PLQ9sf3804509;
	Tue, 26 May 2026 05:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w4VLruBjFnqGeLxXB
	934mHc/udarqvdvuNRwsV+6fx4=; b=nSI4D+xNCahkpg7ytqNc2/Aut1McuxeST
	qnYaX9ML62UtQqJVjVY8cOKLOAk0JOodm1S620IedzQ08UW2hao7ooBa8SWksmER
	irbP9Z3urGoagpYUsiDhdKAEWnTkoUOCjlZKiutLx9T6J5qe+l1kF87FJFgQoyB7
	gNSRkV4ng663/PokwxZpEBLAc7fAE2I3KK3lj3HK7SZFgD/ahTonGx4FmvROuSa5
	eBelLbvnICh2rMyN4lxoK+8J+9JH25kDb+XGO3ytblWFFRT9AD/ZlET8K3MePpIU
	1kHaARrYafmIWZfw65pPhL8uEMVnEAfjjOKNwXpSRv4yn+YeHK2CQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qbthbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5sCH4031341;
	Tue, 26 May 2026 05:57:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebr2gyvu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5v3jh33816920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:57:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C098020040;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A57F22004B;
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
Subject: [PATCH v5 4/7] s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
Date: Tue, 26 May 2026 07:56:59 +0200
Message-ID: <20260526055702.1429061-5-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NiBTYWx0ZWRfX/DBIUf688vhe
 k07XpiRnHgn6WqtRfwLAOuM7xx3LdRJVzrT4ALIuaLFEF+/Z+cBq13ZW9nwJ7Dess2z+Y0OkQ/t
 yUT5mbD1c2UQlebp25UMQiejfCwfHB818pj865y0UTJHJquTU5borQxwZ0lgOeh8WM/7ikG9u5I
 zz3uXgrqZgbPNWy38KvSo6pCA725Z2kE3KSdHQJWtMhbv0s7HRiE05jOPMP0uo95DQBin2FOrIa
 RUoShJFzjAslBfUiVKaDzlfYGNeDGusq2bPbWWMPtLBdz/zPFQiEIyGdUZ2QfEmHaJCzFM1Szcu
 FL2z0d+EKifDNXxDWq2Z/B8HHfLqEzGlYQrElHaQLYDTeZaNB6EYAQ9sOpoYaez+k8Pv6uVh0TS
 HuWf0yI8ZZ8TmA7f3Emp134EFgBDFdKTT1Q41PLrKREechEeZk0s/mHX1Fo/jzk6x361wYoj6R6
 Uxv+X4njQMHRS39haBQ==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a153634 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rpl92wOeoJCnW_j-IKQA:9
X-Proofpoint-ORIG-GUID: 12h1JfXv8IuLUVc8BuafzjQ81vpTPX23
X-Proofpoint-GUID: 12h1JfXv8IuLUVc8BuafzjQ81vpTPX23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260046

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

