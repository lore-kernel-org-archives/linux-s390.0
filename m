Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1D3F8709;
	Thu,  1 Oct 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850788; cv=none; b=RXweW78QeZ6J5nFSwpZsu2llJ457jtFGaTCy+F4dlUxobcR/J5gQglanuz2lsaIX3sVs6V4rfNPGuMwo9F2xzHzyyKrgw5MjbKSTGuyfYmwff1WQ485psJoXu0gYbZ1Z5SqfnxQVH8WSbJpXNSub0mRvl6Ci4OD0yDHJgtaspKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850788; c=relaxed/simple;
	bh=rL2Z48uyuG6J4+WkkSftmwk3tHJeQbjDpQwUKa6cP7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFZ6vrmHLlnUJod+a8npu+SZ4+uUyM8VOr/iK+V8k0YIdPyV01/0+OVQrW2xsQlAv1B8gxXT/KqedKUuKT6xPRjgKGkEZC+Av+19XPZtUXFMcFnGnS24vzKpWLdVfH5x8BjIixKKIoUHSiVfAf5Z/qQh9IPoFIj23zKrmIHMN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E/DwG8jv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E/DwG8jv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175gew3446339;
	Thu, 1 Oct 2026 10:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OTNcQFBWspnP8NuLX
	DjxCgjgHn4vsmsqyYXr9zKVCtw=; b=E/DwG8jvLn+unCZZ7fkzCBpDJGIJjpzUW
	4/1UFgaKbOsEEdrmIPD0PUFqwsQc5GegZNR7x/wtPPkJfkBhHlYclfOM3Fu7sCLG
	YZGsMvF5FRyxyHu1CXp90stYLoqFWytz+PdAJz+VX112UCVEaw3RIe1/7zoKFZB2
	noYmhq55rZi03ePWKs6EcVjiho0wi3qi6EsEqh+RWENJifq3SP6gGQeFoAg1RFIx
	FJrDCe8WbaHYO5n2K//juMTUTVBCWeSCpaE353B7kRCYlkbizjjzDtOhF5dKBX2c
	dGRBl4ct9iG3bKKn5WdYNx8ycZ+FLIto+zZb6/5TywJHd1sgb6E/A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrjkk0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6917HnIm545787;
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsdg0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWpt928181078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41BA52004D;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 058052004B;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 11/32] s390/uaccess: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:26 +0200
Message-ID: <20261001103247.1989111-12-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX/dTQwxtN0vOD
 Qk5Q28xqu4FHNBG49vmaMfSUMMob2qAJlYK6Zw6wDNc4NdC8k+Qh1rWsEFZ2QtSq3X1sJzuZ0RW
 Syk9P9Z/qmgD7qJ+uORj/fRsCoChxE9fZg5YhL8NWqGVP6hlciY7Vr8BxHx7Vya1Oh/bT7wQRDo
 IV+uxQ37lKF8lp95++1ngMKd08vKa2+83RiR68WmEAXefG9sG32tR9R6LD5D4XK9guVyG2oYOON
 u8oRzNeU5Q087DOM6MRiFO0zM64zogaYhmB7Saz0hVVZL1+5pgCicWY6/ylnnWQbInBHsHC6ex/
 p77Wo1FeB+mwuHPYyon8X9EFz0D5ZI0kyIkTrH9Xs2IF4t02hmL+ZqSiQrul+EA4JFNrY+L6zmj
 r+LVOg6j296XdPDEGQJQJOsTf8GgeUgYcngvMyZrGybFiCCtTKMG1uolIvVxHJc3o8Vm/nOvEVT
 jpuwUe/ACQ9Dxhxl6vw==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abe36d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=W46yw3GHh4Jkhn1-SKQA:9
X-Proofpoint-ORIG-GUID: mQtlDQomm8bcit6BYRrN4vl4_pS2ZWkP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXxrBo5ZjIybPj
 CHCMJXTe2iXBRpp6/OvH2rmZlse8k2JJNSClRLURemWV22Lkys9D/dPlaJapPpg96rwwdzeqiIj
 MSGkTbokTIEa+TYFPT+OXBjO6r+g4Nw=
X-Proofpoint-GUID: mQtlDQomm8bcit6BYRrN4vl4_pS2ZWkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all uaccess exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so duplicate entries and nopr padding are no longer needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 45 +++++++++++----------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index a9f32c53f699..ac99b32c6ceb 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -43,10 +43,8 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long size)
 		asm_inline volatile(
 			"	lhi	%%r0,%[spec]\n"
 			"0:	mvcos	%[to],%[from],%[size]\n"
-			"1:	nopr	%%r7\n"
 			CC_IPM(cc)
-			EX_TABLE_UA_MVCOS_FROM(0b, 0b)
-			EX_TABLE_UA_MVCOS_FROM(1b, 0b)
+			EX_TABLE_INSN_UA_MVCOS_FROM(0b, 0b)
 			: CC_OUT(cc, cc), [size] "+d" (size), [to] "=Q" (*(char *)to)
 			: [spec] "I" (0x81), [from] "Q" (*(const char __user *)from)
 			: CC_CLOBBER_LIST("memory", "0"));
@@ -71,10 +69,8 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long size)
 		asm_inline volatile(
 			"	llilh	%%r0,%[spec]\n"
 			"0:	mvcos	%[to],%[from],%[size]\n"
-			"1:	nopr	%%r7\n"
 			CC_IPM(cc)
-			EX_TABLE_UA_MVCOS_TO(0b, 0b)
-			EX_TABLE_UA_MVCOS_TO(1b, 0b)
+			EX_TABLE_INSN_UA_MVCOS_TO(0b, 0b)
 			: CC_OUT(cc, cc), [size] "+d" (size), [to] "=Q" (*(char __user *)to)
 			: [spec] "I" (0x81), [from] "Q" (*(const char *)from)
 			: CC_CLOBBER_LIST("memory", "0"));
@@ -123,9 +119,7 @@ __put_user_##type##_noinstr(unsigned type __user *to,			\
 	asm goto(							\
 		"	llilh	%%r0,%[spec]\n"				\
 		"0:	mvcos	%[to],%[from],%[size]\n"		\
-		"1:	nopr	%%r7\n"					\
-		EX_TABLE(0b, %l[Efault])				\
-		EX_TABLE(1b, %l[Efault])				\
+		EX_TABLE_INSN(0b, %l[Efault])				\
 		: [to] "+Q" (*to)					\
 		: [size] "d" (size), [from] "Q" (*from),		\
 		  [spec] "I" (0x81)					\
@@ -150,10 +144,9 @@ __put_user_##type##_noinstr(unsigned type __user *to,			\
 	asm_inline volatile(						\
 		"	llilh	%%r0,%[spec]\n"				\
 		"0:	mvcos	%[to],%[from],%[size]\n"		\
-		"1:	lhi	%[rc],0\n"				\
-		"2:\n"							\
-		EX_TABLE_UA_FAULT(0b, 2b, %[rc])			\
-		EX_TABLE_UA_FAULT(1b, 2b, %[rc])			\
+		"	lhi	%[rc],0\n"				\
+		"1:\n"							\
+		EX_TABLE_INSN_UA_FAULT(0b, 1b, %[rc])			\
 		: [rc] "=d" (rc), [to] "+Q" (*to)			\
 		: [size] "d" (size), [from] "Q" (*from),		\
 		  [spec] "I" (0x81)					\
@@ -238,9 +231,7 @@ __get_user_##type##_noinstr(unsigned type *to,				\
 	asm goto(							\
 		"	lhi	%%r0,%[spec]\n"				\
 		"0:	mvcos	%[to],%[from],%[size]\n"		\
-		"1:	nopr	%%r7\n"					\
-		EX_TABLE(0b, %l[Efault])				\
-		EX_TABLE(1b, %l[Efault])				\
+		EX_TABLE_INSN(0b, %l[Efault])				\
 		: [to] "=Q" (*to)					\
 		: [size] "d" (size), [from] "Q" (*from),		\
 		  [spec] "I" (0x81)					\
@@ -266,10 +257,9 @@ __get_user_##type##_noinstr(unsigned type *to,				\
 	asm_inline volatile(						\
 		"	lhi	%%r0,%[spec]\n"				\
 		"0:	mvcos	%[to],%[from],%[size]\n"		\
-		"1:	lhi	%[rc],0\n"				\
-		"2:\n"							\
-		EX_TABLE_UA_FAULT(0b, 2b, %[rc])			\
-		EX_TABLE_UA_FAULT(1b, 2b, %[rc])			\
+		"	lhi	%[rc],0\n"				\
+		"1:\n"							\
+		EX_TABLE_INSN_UA_FAULT(0b, 1b, %[rc])			\
 		: [rc] "=d" (rc), [to] "=Q" (*to)			\
 		: [size] "d" (size), [from] "Q" (*from),		\
 		  [spec] "I" (0x81)					\
@@ -374,10 +364,8 @@ __clear_user(void __user *to, unsigned long size)
 		asm_inline volatile(
 			"	llilh	%%r0,%[spec]\n"
 			"0:	mvcos	%[to],%[from],%[size]\n"
-			"1:	nopr	%%r7\n"
 			CC_IPM(cc)
-			EX_TABLE_UA_MVCOS_TO(0b, 0b)
-			EX_TABLE_UA_MVCOS_TO(1b, 0b)
+			EX_TABLE_INSN_UA_MVCOS_TO(0b, 0b)
 			: CC_OUT(cc, cc), [size] "+d" (size), [to] "=Q" (*(char __user *)to)
 			: [spec] "I" (0x81), [from] "Q" (*(const char *)empty_zero_page)
 			: CC_CLOBBER_LIST("memory", "0"));
@@ -418,9 +406,7 @@ do {									\
 	case 8:								\
 		asm goto(						\
 			"0:	mvc	%O[_dst](%[_len],%R[_dst]),%[_src]\n" \
-			"1:	nopr	%%r7\n"				\
-			EX_TABLE(0b, %l[err_label])			\
-			EX_TABLE(1b, %l[err_label])			\
+			EX_TABLE_INSN(0b, %l[err_label])		\
 			: [_dst] "=Q" (*(type *)dst)			\
 			: [_src] "Q" (*(type *)(src)),			\
 			  [_len] "I" (sizeof(type))			\
@@ -447,10 +433,9 @@ do {									\
 	case 8:								\
 		asm_inline volatile(					\
 			"0:	mvc	0(%[_len],%[_dst]),%[_src]\n"	\
-			"1:	lhi	%[_rc],0\n"			\
-			"2:\n"						\
-			EX_TABLE_UA_FAULT(0b, 2b, %[_rc])		\
-			EX_TABLE_UA_FAULT(1b, 2b, %[_rc])		\
+			"	lhi	%[_rc],0\n"			\
+			"1:\n"						\
+			EX_TABLE_INSN_UA_FAULT(0b, 1b, %[_rc])		\
 			: [_rc] "=d" (__rc),				\
 			  "=m" (*__dst)					\
 			: [_src] "Q" (*(type *)(src)),			\
-- 
2.53.0

