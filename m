Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E131F3D56;
	Sun, 19 Jul 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466018; cv=none; b=VTUqdQHKmP27GZS9ADlVXIxcERFEQ8xS2IJHDaUwzr1331WCEBtPZF5vZE67QbzCncSgh5poPHRLl62zhXSwzxix1QrJMAFuRTvMQI/cVOahuOj8JwWIPs72bRttKgMy9ZUHFjKLiW26oNeHBXFOD3rI2Y84q1nKz99SoRzS/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466018; c=relaxed/simple;
	bh=mq+7Hjma1D/CJ3C7xoD4JKAYeJNhJFF8tW/av0J4vr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD5Q56JDkCyDUKSsIrFT609eeIBoCKXf0ThAfFlVlfWWxJvFUB4jGyYIwZ4PDJwu/6RzYq7AdqVDixZ6g9IK+PMhzQ5iojiNW9dQe2d/kvIg3hd43ainkmu4EzLfKFCcCyPLzBIFoYyMiX94YtDni6a3t0hsLdUaKgUGbvNeHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HMsNKqRH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HMsNKqRH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBC3e43258135;
	Sun, 19 Jul 2026 13:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=64/77CkVHpdXmw95j
	a1WPmh0G0GKWz5vBHXIbipy0jQ=; b=HMsNKqRH94HFqMVwrIzd/P0Of5di6tVbn
	QzNjvTTiWbsJwmXm6TUVmKPrb1F3WMJCyeEmDHahz8fv9xYXOtPQoGswbBzx+lkg
	r72XnKavw59MyeDDc/4BlNpeG6iMp7jWLKmmyEEK4uujMZySB2jHzFZrzD6X6iaU
	9Qecx/5pitecYkDfAzKW9NQEjYPQVQEkPQ82TrP34KpzFu+Zrjm2chMjEHB7HQ0M
	R9ts1vbQz0UV0JWCA4DxKkbYs0b3D94kIdxJ998VRyiWzVgEQas3lwNNiuXgFS3D
	mspdGdGAoQp6PS0hBr6EXi2pE11cQEAoNu07f4fTOYTuIjkAI4rjQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fucae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnjoE016751;
	Sun, 19 Jul 2026 13:00:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpstjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD08fF26935774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:00:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3EBD20043;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C75032004E;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] s390: Add support for DCACHE_WORD_ACCESS (again)
Date: Sun, 19 Jul 2026 15:00:06 +0200
Message-ID: <20260719130006.3882764-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130006.3882764-1-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX3Fici64kNAAK
 EKfBv773lAQvBNbjsQHVghnwmf9fJPD4rBHd8KkAWkTm9RzOeXsZ+hCaa8nFet9U1bYrPQP3xMP
 I47xRPZ+x//XbNAt3qC8Ezu7MZ1emFocT7KDbwibL1f/wpKk1JNWu2l2Yg9mHhtWk2kMR0nGYPl
 r0ahiEJnGaWuhOLc9uM3vWBPRzjEqB/+ekIfYO7My0A3+CzkBivYqY3wTh+P6RwEnnAUs9pj3xA
 t0dWAs+Xs1Nf9Z8A4vtrw0Yv341v3+wbc24ppgWPcAczcAVWTOL5uPcIf+Lp/94mEXwxW5QctBe
 n6S2inpY/cBrh+UqfOAJ0h2JK9r009//pXUrQFExycUMv2aaoShnWjZnOBTf4Z82yyMEcuaWXaA
 U4mr5COL9Y7Il3ed+1OCwiSCIQBopObxGFgaWYFhoejSMcUoVwhEQGWH7cbHDkpLMSFM1ccG8Nz
 OSRsTpZE/VFY62QEdHQ==
X-Proofpoint-GUID: dzBqHHgR2lSW4AToSAqVdW8SXbMokrVw
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5cca5c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=iX4AGcIGDbhQ4BFKoYkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfXzOyCAvCXWAze
 gSK3VugGPQtEOWasMHZ952Z9c87KpKn9djNxft4pR28/BVQpADDPmj5MEacS//GwxdhWB0QlNSM
 loRHGDwUASOlnAdcDpstGCtLr+HzduA=
X-Proofpoint-ORIG-GUID: dzBqHHgR2lSW4AToSAqVdW8SXbMokrVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

Implement load_unaligned_zeropad() and enable DCACHE_WORD_ACCESS to
speed up string operations in fs/dcache.c and fs/namei.c.

With the secure storage access exception cases addressed, add support
for DCACHE_WORD_ACCESS again.

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                      |  1 +
 arch/s390/include/asm/asm-extable.h    |  4 ++++
 arch/s390/include/asm/word-at-a-time.h | 22 ++++++++++++++++++++++
 arch/s390/mm/extable.c                 | 18 ++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..fe81c539ef2f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -163,6 +163,7 @@ config S390
 	select ARCH_WANTS_THP_SWAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
+	select DCACHE_WORD_ACCESS if !KMSAN
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select FUNCTION_ALIGNMENT_8B if CC_IS_GCC
 	select FUNCTION_ALIGNMENT_16B if !CC_IS_GCC
diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index 99748c20e767..d23ea0c94e4e 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -12,6 +12,7 @@
 #define EX_TYPE_UA_FAULT	3
 #define EX_TYPE_UA_LOAD_REG	5
 #define EX_TYPE_UA_LOAD_REGPAIR	6
+#define EX_TYPE_ZEROPAD		7
 #define EX_TYPE_FPC		8
 #define EX_TYPE_UA_MVCOS_TO	9
 #define EX_TYPE_UA_MVCOS_FROM	10
@@ -79,6 +80,9 @@
 #define EX_TABLE_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero)	\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REGPAIR, _regerr, _regzero, 0)
 
+#define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
+	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
+
 #define EX_TABLE_FPC(_fault, _target)					\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
 
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index e9287036392d..eaa19dee7699 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -4,6 +4,7 @@
 
 #include <linux/bitops.h>
 #include <linux/wordpart.h>
+#include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
 struct word_at_a_time {
@@ -40,4 +41,25 @@ static inline unsigned long zero_bytemask(unsigned long data)
 	return ~1UL << data;
 }
 
+/*
+ * Load an unaligned word from kernel space.
+ *
+ * In the (very unlikely) case of the word being a page-crosser
+ * and the next page not being mapped, take the exception and
+ * return zeroes in the non-existing part.
+ */
+static inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	unsigned long data;
+
+	asm_inline volatile(
+		"0:	lg	%[data],0(%[addr])\n"
+		"1:	nopr	%%r7\n"
+		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
+		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
+		: [data] "=d" (data)
+		: [addr] "a" (addr), "m" (*(unsigned long *)addr));
+	return data;
+}
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 063b4346742d..7498e858c401 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -50,6 +50,22 @@ static bool ex_handler_ua_load_reg(const struct exception_table_entry *ex,
 	return true;
 }
 
+static bool ex_handler_zeropad(const struct exception_table_entry *ex, struct pt_regs *regs)
+{
+	unsigned int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
+	unsigned int reg_data = FIELD_GET(EX_DATA_REG_ERR, ex->data);
+	unsigned long data, addr, offset;
+
+	addr = regs->gprs[reg_addr];
+	offset = addr & (sizeof(unsigned long) - 1);
+	addr &= ~(sizeof(unsigned long) - 1);
+	data = *(unsigned long *)addr;
+	data <<= BITS_PER_BYTE * offset;
+	regs->gprs[reg_data] = data;
+	regs->psw.addr = extable_fixup(ex);
+	return true;
+}
+
 static bool ex_handler_fpc(const struct exception_table_entry *ex, struct pt_regs *regs)
 {
 	fpu_sfpc(0);
@@ -118,6 +134,8 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_ua_load_reg(ex, false, regs);
 	case EX_TYPE_UA_LOAD_REGPAIR:
 		return ex_handler_ua_load_reg(ex, true, regs);
+	case EX_TYPE_ZEROPAD:
+		return ex_handler_zeropad(ex, regs);
 	case EX_TYPE_FPC:
 		return ex_handler_fpc(ex, regs);
 	case EX_TYPE_UA_MVCOS_TO:
-- 
2.53.0

