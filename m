Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE33C1F4F;
	Wed, 20 May 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268996; cv=none; b=EnpSmvjrDEUn85yjsNgUZoy5lcY1aBTccoG3tKCVlX8gDrXwTMt2e1SnSL4tsd75PXXkZad1U9jp+rV6UkAUKu/o5ge13xGl0AJPqh8E7M2SvbE4M6ovMUqGzJ1ehNJSIJEF2i1T4YZLHacsF/bk+1GksiiYgFGWhc1MyNb0uQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268996; c=relaxed/simple;
	bh=kzT4GgF9TOm1SzSZAp0GUl4LgLUdpgjBPWkgjzhwqmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNVUkqnvExZMlnK4p/IukE8k0iVRE7r3rfUb6g6I/0R5XCSwl1O3fhQmtSA/Vw0Xd22mEKg6/+u4T3xTFnzB1/9yVPtI0Y71ddVTx9V2Ok6QHEY2YwhNtwVyS2wdDkWGja6VOfxiiJEsyA53SvMVhR/jh5J/HY9GFNjEZYesxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KG4zIwr3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KG4zIwr3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JJpaxc069628;
	Wed, 20 May 2026 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aNuC9aZ0O1QMyLAoh
	8AbEsJP6D3xOXXADPlZtT+pV30=; b=KG4zIwr3Nmoa9CJ7d2iJ0SVa2sXfy3ZZH
	RkJuwaX8WAASBK9mZ9bSOPfJEYg9kMmecaCpXgWjUssuV4NnC7kilMzzMcv8yQ4q
	2gHZmbHGz9nFzrlodDBQDW9k6iRDPoQOOTNGhmuoGUyxKvB9SN//DElicH6wjCBT
	an/EF8BP69v03a8XmPa8k3DyrAmiIOuhYKdLt6E10HCRdkKr1CkHiTI8Rbec+xe9
	I68yacz6x+Fsxwafkbnpk8sozGrjbDRPQtzVYZ+AUe9Cjk4u4UEca6VbDCqbpjrD
	zZXMO07kSCOT/Vq82wuGZhwCfEYuTlMmf3uezuzzCeCo0p4lmQ1+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8ms95p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K997Hk002414;
	Wed, 20 May 2026 09:22:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky6dbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9MjBs55116218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6920020040;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C95520043;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 5/9] s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
Date: Wed, 20 May 2026 11:22:39 +0200
Message-ID: <20260520092243.264847-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520092243.264847-1-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vZiFTyv7LifXqyfj1ckzHsmaWIl8VL7O
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0d7d69 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=gp5uoB9lSsFOMp1OYIcA:9
X-Proofpoint-ORIG-GUID: vZiFTyv7LifXqyfj1ckzHsmaWIl8VL7O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfX/mFR7XGklOmF
 ZZVjaYLtbZOmbfJLKCM3kMnroFR7XnFz5S+oimnrluRxD2ikL48S46WPus1bgmJQtsAWQFShvB7
 w1mynhPqz3whbLdnOl9OAT3A0oK2AqvCZcSljyy/hKVIksf0TN1ubB45s9IXXUY2bQ5de5LIbxR
 fg29iyUEDSHz7xe08V0b7ExlOLz2S+EcJj1byUzQ+mraowV/hPIaBYYZXnL1p+JWTWQSROzx2Xh
 0esFqfHTaDokEP9MESWvGOD7+gYTZeNpjQfiwDN83vEJ4bDuDTFt6nJHaqdsV26vLVJtDLTQEuG
 TVEy6MtmRjvIsaiDf7pVbO893lp5FGf2KQ9Gqph443QHq2qc6lc/e0ax0q46LHCjuThtCq2kRv3
 OJBVPLTym7ft+AG3Xx2IxS9EFAbaA8rdSk73eizY+GjynkseCRthzP5TUd7eFK61P8sigzT9UiD
 Nc9L/bzPS7vaM1vCtyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200087

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
index 459603c7305a..b3da863954c5 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -177,17 +177,29 @@ do {										\
 
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

