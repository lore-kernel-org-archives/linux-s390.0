Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57D4BFE89;
	Mon, 21 Sep 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006305; cv=none; b=t/TTVYVxZxNq1KvJdBgpss52V1K+Kkwk4k2r2+57R1muLDZ0H8RHJAf37i2AUCWHZSrKYh4oaTrulMXKehD+CWMSKNsY/4ypId9wh7d+LSrdyk+AYUIrgxJEuGT8qskJHtbWbn7rCZsGKicquAO9ZlI7EbGGqpeprORs70bL69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006305; c=relaxed/simple;
	bh=o9hPxOU9kHloIARfub1Nrx5KK2t//Hd+uRzDHhtzPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ0GtIDnc5x8MhO6Qa7DMzdyNRB6TzFrUynUsUa/6x02PNmjMSouIDH82cwrjn02BKzC1eQbeEGTf2LpX+hAbR80VEThsXol1/Qvn25jtJew8zcpQQljad91ghm1E0HUEzUH3oySfMvJZVsYd0yIvwfGe4sIdfAA1kr6RYBM3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b2Tzq9eQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b2Tzq9eQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8iSp1903397;
	Mon, 21 Sep 2026 15:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vfh+Ku1qHAtSrYARs
	L7UNTW+AGUl1eoke7UXxnSuWjU=; b=b2Tzq9eQUodh+HgRnzh+kxcvdFuBtnJsK
	kxoleJQfXTLUIIsqj9ub8KnhPhNBC4qUBaAh/yIKdBZbvfkYJh9SvzQTzPKa5jqE
	SkSTLj27+HBJPt943oANxcLz2QxNOUh38fakUeJRIxsUcnssBDqU1ZJhQORVZ/Ki
	PPdKbEhQAsGl3FXsJTNh8OJ0FqjCqUUZ65PmDkCtG9hzPdiKpaTb4iT7FxrRldoD
	DOtZYjkj6O62FAH+yXfnj9L+AaMaQaTMppc0d/PgHEK+VaqlPNnDSbcm48imPkV+
	/ydyOZIKOoyyX0jctWCRTs6vDj/OUOnXfQG62peA3iJaUQoO4r0DA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv1akd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHXN51408451;
	Mon, 21 Sep 2026 15:58:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjnyc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw8sC28377498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29D6220040;
	Mon, 21 Sep 2026 15:58:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F26652004D;
	Mon, 21 Sep 2026 15:58:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 15:58:07 +0000 (GMT)
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
Subject: [PATCH v4 08/11] s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
Date: Mon, 21 Sep 2026 17:58:02 +0200
Message-ID: <20260921155806.2447506-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921155806.2447506-1-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: di08qZYQy9CiqURQ7bZ8p30kjItRJ7Y7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX2QeilbggXnMT
 7pEobCswEi/fkue0jXj/q7+T3X/gEy4kfAamvBuv2E2iYaIn+kwvZqekd/M6KbPYRzjahmxs+53
 erB2PhW3jIS2VwMC3AEK9+KnLb5efew=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab15414 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=sJK1A0fQ-n6IDXIElG0A:9
X-Proofpoint-GUID: di08qZYQy9CiqURQ7bZ8p30kjItRJ7Y7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX8aPFMxTPLavc
 mBEaEL2uLubDMjckLjsoQejYej4ASzJtClezKGpPdYAcxUKw07JoMj+/jIDaj2sPQ34+MXn25nS
 /QSzX2XhYNzvDF5kAFkIz5Z4yBKEt+bOEEvI1KuCh8mXr17fSyJfLYFVtUpckX1uakt3S1/VDr6
 0K8O3s8KApEAnf2/wfPwMpnsDv+7QAnyEzNX2SjFjBA3B11S0sZuz6vTXYQuOnDsimUVO7+g70v
 RimlHp65fIe/TrXiv4K5mUaQfzZ6ewVOqK3p/6HLoSFMMVXRYkwJyQ99iDrVw5JGazL8jtwOp/s
 RrKHcaWMGKzK3j2PVa/8KptHfOmorF6SokGDovk8lvyQz1+7tPXs7vnWQYkMfgsYlEnwNAiKtCX
 BFj29a8btQHcxdu6qwsUhV6tA3CJfhXMnEbjXHIJG/csXQ2QQ+f8vLhzRSg1XuZXK4QHB6TYMiH
 H4nXAEqZof9Ih1eGw/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227

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

