Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E63201113;
	Wed, 13 Nov 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512431; cv=none; b=NJBCIy5QNGB/9rQfonyYQHauK485lLXvegg6NoLTgprUkwWnQTpvuS7kEFyqWIk45THD2csVRT7fJuas3yuw/mYBIzOqAFt8mvdKZheeDn1NcOlY0Pm9C3mg9Mv2gZSVR/1yzT2q3oC7IIcJEsqHpAxrCg8gmUN82VyNWanozH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512431; c=relaxed/simple;
	bh=KlgB7xmR1Ah+qJqeizkv3rLuDnV36l03U+jPPAMApLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoFaMde9XETnEpjCIIur/DqIo0HYAa6Nm65bmxIjylnCnEO1pnqtOOYnFQobyB8uM84XFwJ+jzdpV6+aYxcKQ/miX0GK8s7d6m9+JzU1PfXaUpGc9R1KR6uJpkiSBuRLOoBMGxMRS+l0cDP2ulK0uSyAhbuUzHgirrpCCElMcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=icn8+W9k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="icn8+W9k"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDI9Fk026128;
	Wed, 13 Nov 2024 15:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2HkGV6w4byABm+hmP
	8/IZ/Ewh/QFGl5Tppc7Xsbbv5Y=; b=icn8+W9kgjUUgXOJBrp3Sure32o5FKSpp
	G/qZrQ9diNibM1imDfrCHyEcjqdiFE5/k4oHLr3Y8QUxS52DY4KbAWRheONn1/Bt
	3tdpyzpNP97hozCoVyQ1K4OcfltvAZUV8vVJH+A2EjXoxj57tRuVQZyS/dOpccW7
	QQI6jdlFT/fzuCg2EDPJFk0w5wjFwqmGsfUq4RcnWZ4AmfdF3OxYoASzCjTi4htV
	4/1yKu2Y4+lU9cZx5O311gaXxdOlHKPeEOlg8TAXQlhYA5UyOVOeAn44vxgoRHn4
	XPEEHnSKjFovOdyk98fvfkTmUN6VfaxtnVkUoS5DZjik3WMI+IzvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdcev55y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ADFeJo0023191;
	Wed, 13 Nov 2024 15:40:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdcev55w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADEOhE1011017;
	Wed, 13 Nov 2024 15:40:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s6gf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADFeFsm34276036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:40:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52F4320040;
	Wed, 13 Nov 2024 15:40:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C231A2004B;
	Wed, 13 Nov 2024 15:40:14 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 15:40:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 2/2] s390/fpu: Remove inline assembly variants for old clang versions
Date: Wed, 13 Nov 2024 16:40:13 +0100
Message-ID: <20241113154013.961113-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113154013.961113-1-hca@linux.ibm.com>
References: <20241113154013.961113-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7YI3lzoyiA8ijf05xvv_GYUVhgedHZEo
X-Proofpoint-ORIG-GUID: zX7SWwZqL8RQ-wjYYSuKj7zos35a24xZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=962
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130131

With the minimal clang version raised to 19.1.0 there is no need to keep
the inline assemblies for old clang versions which do not support the O
and R inline assembly format flags.

Support for those flags was added with llvm-project commit 9c75a981554d
("[SystemZ] Implement A, O and R inline assembly format flags (#80685)").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/fpu-insn.h | 124 -------------------------------
 1 file changed, 124 deletions(-)

diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index c1e2e521d9af..e57d80981f13 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -183,22 +183,6 @@ static __always_inline void fpu_vgfmg(u8 v1, u8 v2, u8 v3)
 		     : "memory");
 }
 
-#ifdef CONFIG_CC_IS_CLANG
-
-static __always_inline void fpu_vl(u8 v1, const void *vxr)
-{
-	instrument_read(vxr, sizeof(__vector128));
-	asm volatile("\n"
-		"	la	1,%[vxr]\n"
-		"	VL	%[v1],0,,1\n"
-		:
-		: [vxr] "R" (*(__vector128 *)vxr),
-		  [v1] "I" (v1)
-		: "memory", "1");
-}
-
-#else /* CONFIG_CC_IS_CLANG */
-
 static __always_inline void fpu_vl(u8 v1, const void *vxr)
 {
 	instrument_read(vxr, sizeof(__vector128));
@@ -209,8 +193,6 @@ static __always_inline void fpu_vl(u8 v1, const void *vxr)
 		     : "memory");
 }
 
-#endif /* CONFIG_CC_IS_CLANG */
-
 static __always_inline void fpu_vleib(u8 v, s16 val, u8 index)
 {
 	asm volatile("VLEIB	%[v],%[val],%[index]"
@@ -238,26 +220,6 @@ static __always_inline u64 fpu_vlgvf(u8 v, u16 index)
 	return val;
 }
 
-#ifdef CONFIG_CC_IS_CLANG
-
-static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
-{
-	unsigned int size;
-
-	size = min(index + 1, sizeof(__vector128));
-	instrument_read(vxr, size);
-	asm volatile("\n"
-		"	la	1,%[vxr]\n"
-		"	VLL	%[v1],%[index],0,1\n"
-		:
-		: [vxr] "R" (*(u8 *)vxr),
-		  [index] "d" (index),
-		  [v1] "I" (v1)
-		: "memory", "1");
-}
-
-#else /* CONFIG_CC_IS_CLANG */
-
 static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
 {
 	unsigned int size;
@@ -272,30 +234,6 @@ static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
 		     : "memory");
 }
 
-#endif /* CONFIG_CC_IS_CLANG */
-
-#ifdef CONFIG_CC_IS_CLANG
-
-#define fpu_vlm(_v1, _v3, _vxrs)					\
-({									\
-	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
-	struct {							\
-		__vector128 _v[(_v3) - (_v1) + 1];			\
-	} *_v = (void *)(_vxrs);					\
-									\
-	instrument_read(_v, size);					\
-	asm volatile("\n"						\
-		"	la	1,%[vxrs]\n"				\
-		"	VLM	%[v1],%[v3],0,1\n"			\
-		:							\
-		: [vxrs] "R" (*_v),					\
-		  [v1] "I" (_v1), [v3] "I" (_v3)			\
-		: "memory", "1");					\
-	(_v3) - (_v1) + 1;						\
-})
-
-#else /* CONFIG_CC_IS_CLANG */
-
 #define fpu_vlm(_v1, _v3, _vxrs)					\
 ({									\
 	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
@@ -312,8 +250,6 @@ static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
 	(_v3) - (_v1) + 1;						\
 })
 
-#endif /* CONFIG_CC_IS_CLANG */
-
 static __always_inline void fpu_vlr(u8 v1, u8 v2)
 {
 	asm volatile("VLR	%[v1],%[v2]"
@@ -362,21 +298,6 @@ static __always_inline void fpu_vsrlb(u8 v1, u8 v2, u8 v3)
 		     : "memory");
 }
 
-#ifdef CONFIG_CC_IS_CLANG
-
-static __always_inline void fpu_vst(u8 v1, const void *vxr)
-{
-	instrument_write(vxr, sizeof(__vector128));
-	asm volatile("\n"
-		"	la	1,%[vxr]\n"
-		"	VST	%[v1],0,,1\n"
-		: [vxr] "=R" (*(__vector128 *)vxr)
-		: [v1] "I" (v1)
-		: "memory", "1");
-}
-
-#else /* CONFIG_CC_IS_CLANG */
-
 static __always_inline void fpu_vst(u8 v1, const void *vxr)
 {
 	instrument_write(vxr, sizeof(__vector128));
@@ -386,26 +307,6 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
 		     : "memory");
 }
 
-#endif /* CONFIG_CC_IS_CLANG */
-
-#ifdef CONFIG_CC_IS_CLANG
-
-static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
-{
-	unsigned int size;
-
-	size = min(index + 1, sizeof(__vector128));
-	instrument_write(vxr, size);
-	asm volatile("\n"
-		"	la	1,%[vxr]\n"
-		"	VSTL	%[v1],%[index],0,1\n"
-		: [vxr] "=R" (*(u8 *)vxr)
-		: [index] "d" (index), [v1] "I" (v1)
-		: "memory", "1");
-}
-
-#else /* CONFIG_CC_IS_CLANG */
-
 static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 {
 	unsigned int size;
@@ -418,29 +319,6 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 		     : "memory");
 }
 
-#endif /* CONFIG_CC_IS_CLANG */
-
-#ifdef CONFIG_CC_IS_CLANG
-
-#define fpu_vstm(_v1, _v3, _vxrs)					\
-({									\
-	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
-	struct {							\
-		__vector128 _v[(_v3) - (_v1) + 1];			\
-	} *_v = (void *)(_vxrs);					\
-									\
-	instrument_write(_v, size);					\
-	asm volatile("\n"						\
-		"	la	1,%[vxrs]\n"				\
-		"	VSTM	%[v1],%[v3],0,1\n"			\
-		: [vxrs] "=R" (*_v)					\
-		: [v1] "I" (_v1), [v3] "I" (_v3)			\
-		: "memory", "1");					\
-	(_v3) - (_v1) + 1;						\
-})
-
-#else /* CONFIG_CC_IS_CLANG */
-
 #define fpu_vstm(_v1, _v3, _vxrs)					\
 ({									\
 	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
@@ -456,8 +334,6 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 	(_v3) - (_v1) + 1;						\
 })
 
-#endif /* CONFIG_CC_IS_CLANG */
-
 static __always_inline void fpu_vupllf(u8 v1, u8 v2)
 {
 	asm volatile("VUPLLF	%[v1],%[v2]"
-- 
2.45.2

