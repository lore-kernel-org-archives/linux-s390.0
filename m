Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C13D3324;
	Mon, 20 Jul 2026 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537926; cv=none; b=LRchCj9zsQsit7qFgaRIMDHzw91Q/DwBqi/gFuXycQ3M2lC9ikmdMb88pGXqqF63MNtPNK8l/DdHUPm0TG12Wwxw2WdBKZ7/bwlvfvvhfXdcyPSzhuZFJBP4T39KclMQ0X98aJxk/pCW7d1HgyfR3/lXiEyGV7bUBxtAooHuuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537926; c=relaxed/simple;
	bh=mq+7Hjma1D/CJ3C7xoD4JKAYeJNhJFF8tW/av0J4vr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzoHDLxHRnqQ5KtLRQ5UPn82RUbp+fk2w5Iel2Sc91m+01yhluNWUpDaOXHrpelY/ZeJtFAeciuhTaRd1nu3FaDZTSZ6G0G7/WvMznjityPjfqQVaXGdOOy5do0f2iZOodEGfkBb4B5T647DifacjlqREaTNgjfJergsiEbEqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YQrc4AHB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YQrc4AHB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6g73i1471171;
	Mon, 20 Jul 2026 08:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=64/77CkVHpdXmw95j
	a1WPmh0G0GKWz5vBHXIbipy0jQ=; b=YQrc4AHBpXtWQwkszCyYjnTOyTkJMGLTI
	+1bYZzGhoEQr94PK1s13ob8kQIVEqAAal3LVeVpAtMd45yltd21m1YogycGdstz2
	NKjn3GxcsPIc8FLhDfw/9Ez8NdxwiTeGQFYGHtpF67TD0WFsUVv9EafykPW6sO4D
	jyuVQCemmuERf+qWFmmRxqAjUfjn+WYO3ujMUc/wZ5VHpFD0xoFRbr69Pgu9c5qN
	c1NOAVYupeCJBDg7c0LEeknOSFMZFTLvxI7t972Yqjb/RQ24hrNhe6hh6QNQ3hFF
	Rdz0/74VApfkGsoEXOvXWHj+J0tX0yL5vZ4E1Lq/HLeswRm9ghfvA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790pma7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8nejR030858;
	Mon, 20 Jul 2026 08:58:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vvxdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wanw50332156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6629620040;
	Mon, 20 Jul 2026 08:58:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 448502004D;
	Mon, 20 Jul 2026 08:58:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 08:58:36 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] s390: Add support for DCACHE_WORD_ACCESS (again)
Date: Mon, 20 Jul 2026 10:58:34 +0200
Message-ID: <20260720085834.898025-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720085834.898025-1-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m60J41a8HxGUtbb3P5_tJFyqvA7_BeCy
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5de342 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=iX4AGcIGDbhQ4BFKoYkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXwNp3ur+bQR1H
 +9dcpAYKJZdqUGjVV4Q9Ipxhun+F9jREmaVkPmib5FnxHEWrE99skfiLk3lSnV/57KtfV7M55LS
 IVjLFc4DSkLiKdEiVCx2u/Hx9ACwbZE=
X-Proofpoint-GUID: m60J41a8HxGUtbb3P5_tJFyqvA7_BeCy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX6BWk8y8cX4Dg
 3DRzmLCU47716ANPTd6N33yIIU2YyJdxuLkMShoG9pSHXBOsPS9FIgP4wnKnbjSvV8VYNfb7FkB
 XmKXdnokCkAGH4X4s30M3bePI1Z0Ts1V5Enw5d7+msClVBmItghtfagTfFu47wfzLKgYWv8S2q4
 wzFXPoJ54gRgU3rdG8Cs9iRLgTg8GJvRzPfolhCQpBxfHAtpVTSAgCPKwbLdd3uU2jCcn6IquFP
 Re0VN2tTRc71FMsR5MfOo7++pSHLxWQgUd5FmO6zC3pHH9KDdAeuzRhexGnUQym+KsE0X3mN9cF
 l0+V9XSQTcfCX8aGjcDxlHnTAC9aBYzBn62nq7iMVxLQAOw8TwA/YFJyJXurNK2d6ge5WlQ6A9i
 LNz4wtB7D4ItsnzvRqKZomQ06LBKr5q5zbaxEOypPqv+7B4FCrHmeDapx8hKzgLyYp0lflcDtRF
 X9GoOjFpDLLSFcjbLGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096

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

