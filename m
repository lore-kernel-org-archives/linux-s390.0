Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C883B6BFF;
	Fri, 17 Jul 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280267; cv=none; b=gVgiJJnF9EAZ4BaA953WpYrP77K6ndtXFSMRpSdd0JWE6nk9cmN29v3966noy3RLNy7Ih5s/CB985rSRcilEvDyY6bCIeFliOR/tUBRei11YLyVtXpPhtbfX8LY3EfiaFt0xd/6m+6NxBlj0pKgztk6iZ5tw/PxsCZ4GNSv7G80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280267; c=relaxed/simple;
	bh=zEiwKaXMbPZ11XxOmdgSOBAY1vv4wF2nd62M/NN1IiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFdq6RWq9zHBqgVUpcuiWhmX8eml1gpdaKTioI4p+mX1uLAyZpi0Xm1l4VHZCf/L37mlyFoKkTvZkp+XPXstxesGaGjrXmmS5RC2M3jovnKa2QZM4Qq4+Q9Tru+cVRjahxAuf97niZpx/HSEi4Lo5M+0l5mYgvCaN1TsQsSsNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qqe73Zl5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qqe73Zl5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6fmLG1299620;
	Fri, 17 Jul 2026 09:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+MXo+NOGjI4Y6r1/g
	x1ahV3bSTRNhyUjZw1SnQZJUO0=; b=qqe73Zl5hwAg+eZNKy5qI2TKh6OVdkA6e
	ZLHaq028Eyp4r0zVYKVcL0G/lW6TQ9Wfn7kVhoYlRG/Edvb9tCt79dgi+d1UlZQj
	7GXWqlb+R3KG0+KS+d848HUcK6Bn62PwDa/mn72chCewqDM4hkI0HtTOnKX+WqR3
	eYhL3gS+zleFS6YIZFUCkuIVtS43oLcsTw1Fx24U90L2aK8S1rIM2EIf1966UOFO
	XrxdB0J7hWlZQL/qoXiBJcNZEpLh18z9YaX8mHz7fb1fUrXJ7S6z7C8CYuf8GI5K
	MsQeK6hy1CyaAE+jqSn5MEGNyHWjM2qKyZYjw7IZpxZ8H7uA3ix+A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtnrfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H9JiLk020177;
	Fri, 17 Jul 2026 09:24:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k90fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H9OH5Y51577316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:24:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E22552005A;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAF422004F;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] s390: Add support for DCACHE_WORD_ACCESS (again)
Date: Fri, 17 Jul 2026 11:24:15 +0200
Message-ID: <20260717092415.3039699-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717092415.3039699-1-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JuGxmwsCVxTqi3RNl1UB94jyQ1Q4sIc7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX2bWyISBEuxSH
 u4rEVSpXXiLek4jFtMuod6errOCThn4w7A7bp3BpnXsOYY7aSAXu/oPjhdcnQMviX84QcUjBVcc
 j0u6ByEGtH2kbIoTRh4EMwfEWWEDRHQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX3GSz+8mFGHxK
 1hg0QNaOAT53iitDKle4aLSfLOGmsR59MQyP+8HHtMnkFKB1BLMTTB42way2Yf+bJCAghpCVgJT
 8gseOJLBEj5sxsrH01ZACV1TPQtiR1UPLms0FZmCI0zvM2yJj4a0p4adxKKvdaqO5j+IteZ2RYo
 MYoUKMMXrH9GFhVntFm0qKCGY5RGMr1472fmqpKqLau7Hmkcf+J0EIQ4jjmPA81c0JANGfh9bh6
 nyOtDyxg7JHc5SSYp7WHZIk672CevZKlGDxagzsnygnHL56gFEoY2OgPOBIWotPEtZsDJpYJY9E
 c4i867TZ6ZiqFIg4irvmxvJJQHO0Z4N4D0WqjN8P3InXx+DwoqZc+7KfEiilGdXHCZlFJZFEBDa
 KR7uSf13F+EE0Uw39pSfMroBiosISZPChlT4wW5MyURi0A4lwO1ez6TkNKzoN8msIFdFDyt6ycY
 BQdXOhS2JZ+oZHTN7sg==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a59f4c6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=iX4AGcIGDbhQ4BFKoYkA:9
X-Proofpoint-GUID: JuGxmwsCVxTqi3RNl1UB94jyQ1Q4sIc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170091

Implement load_unaligned_zeropad() and enable DCACHE_WORD_ACCESS to
speed up string operations in fs/dcache.c and fs/namei.c.

With the secure storage access exception cases addressed, add support
for DCACHE_WORD_ACCESS again.

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

