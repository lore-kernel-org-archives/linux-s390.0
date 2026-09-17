Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1284E06E5;
	Thu, 17 Sep 2026 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672980; cv=none; b=ueoPGY/MzQTvqBgAwhMOj42c5YYQlpR1lDRLFekq6Ysilt39nlgmY9VFnoFfuL+AsyIFT/OEU2qk3/CRYFt0G6Ov8iuz7hFhsVCSn5DMz+G8pYdB4sTN9HYDjOWwakhaDdeW2UlnqvnVXJa/LH22jXGclDIb9Zb8gSvpzSJiP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672980; c=relaxed/simple;
	bh=o9hPxOU9kHloIARfub1Nrx5KK2t//Hd+uRzDHhtzPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msVgjurc3Ud6cvpu5sETCJJ3pT5U8xvPhEH2sWwGbMdnjQZgTdiAQz6KLFM5Wf8Cq/TK2lQSuRtfLiUTurSJQyCVoJCsJdR4Qgk2UUXGze1bBMLb3AGWDusMW70U7ElZtq6SbzYYYa019YqpdPH9UJpRPFmiCi/V5YIBZ0aP/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ApGRfPH+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ApGRfPH+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVc0V2998394;
	Thu, 17 Sep 2026 19:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vfh+Ku1qHAtSrYARs
	L7UNTW+AGUl1eoke7UXxnSuWjU=; b=ApGRfPH+gTXBRZWoL3qhbYb86SjWM22Bv
	D0mlhAgiPqzgIxUcREuGQa9m45GwuXcOmxrRlUsS45wB/es04vGEuddT0B4OcDGO
	1mXdKt0S+lP86JWhWoLWv+3+qcXZwNeEgS/+xkogvgLFyoZmHwYZXxRilhHGqory
	dW5+D2cpSG3dvtdm0N8Qu2SKp/W0SGFNGmZg72sGcVGxBeYI9+RFFqsPCQ6aTY45
	vObtKniW+8v3IvfV9GbGaYIROuDm6b1oLGTVTbFnZtpwj8N1qyxwlYoTalShEsi6
	3G6puTDnM/ptYMM1m4gJcrBmEB2JPydk7aq6kU01fvgfZMrMpx73A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j458w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH90Uv3474533;
	Thu, 17 Sep 2026 19:22:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fb26q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMd3D13173218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC8820040;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFDC12004D;
	Thu, 17 Sep 2026 19:22:38 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:38 +0000 (GMT)
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
Subject: [PATCH 08/12] s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
Date: Thu, 17 Sep 2026 21:22:33 +0200
Message-ID: <20260917192237.638324-9-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX0nt+bWlPJbuJ
 aYvYi7VPC8u3HHyryDd/rwiMwE/gXZE7jhi7DqsIIgVC9xevin/bPZh+2bNh/pMGjWjzwuGkOHl
 oobC0ZJYzfP5+QzinlpbUXi0Z0UBxNnNmXWeafiRug1yyYpnBbzc9Xp+MtDk8xka4cjeTnYhDmM
 bU4SYVRpbJuOrqB2ScCsYQ0zVVJHCKt0ImTUvAVCAuXTkq5EzbcPBfr/FpTO1SGWaLKmaDM/t59
 UZxWigS+S4fRKn2S1amNzNkl+exT1gCdTf2N5lkXy22aCJKcMLeubZCWSQ1ApGGdavXMScpN+VO
 aQCJ7+syiVdrky7iepYlHokq9QS7RqblmosVi5kNlArGSmb3u2g+nR90sRv/90sAkCVZ7HK+jk7
 VPD17ak8v8oRKvDmBwtc8rLsAKKugkYjhOP/kmwTNaeAdGjg3xXdu79b+MkP1lm9Md+Bx3GiNNe
 EodTK3BW7m5X8YYoIQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX7LmyaVWNu2ei
 39BFGoea9fQDdVxxtajbqTvjH4RE2naaMKwRpbQriIj/0FHXuw8+u+uKMx6aolXCiZ4/JB0VS7v
 VASzRwkWPHtTAL1RqXX8qns5XUoRhJg=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aac3e03 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=sJK1A0fQ-n6IDXIElG0A:9
X-Proofpoint-ORIG-GUID: AHmXrSgG0nezzWDFeu38CZGapwlWUFRM
X-Proofpoint-GUID: AHmXrSgG0nezzWDFeu38CZGapwlWUFRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170272

Convert this_cpu_cmpxchg128() to make use of percpu code section
functionality. This is just for the sake of completeness, since
currently there is no in-kernel user of this_cpu_cmpxchg128().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 78c3aaa138f7..0eae65937c0d 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -312,15 +312,23 @@ do {									\
 #define this_cpu_cmpxchg128(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-	u128 old__, new__, ret__;					\
+	u128 old__ = (oval), new__ = (nval);				\
 	pcp_op_T__ *ptr__;						\
-	old__ = oval;							\
-	new__ = nval;							\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp));					\
-	ret__ = cmpxchg128((void *)ptr__, old__, new__);		\
-	preempt_enable_notrace();					\
-	ret__;								\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		"	cdsg	%[old__],%[new__],0(%[ptr__])\n"	\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "+&d" (old__), [ptr__] "+&a" (ptr__),		\
+		  "+m" (*ptr__),					\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [new__] "d" (new__),					\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "memory", "cc");					\
+	old__;								\
 })
 
 #define arch_this_cpu_xchg(pcp, nval)					\
-- 
2.53.0

