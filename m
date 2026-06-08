Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9D365A14
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897082; cv=none; b=W3sPuJXVdfmKzuUFNvBaZgQMOcVyGeVM4TL+91e1RGLrSd7qRBKcpGa4SE/HueB/9s6brgL1Ty13CGr5R8RJ78OJ/QZRyfpyCMC0xFnC/LZEyJTh2zX0vnI/LzxFn7SjMjoryfYhdbxvKgCS5b5JLCRFg5MazrQRESknL6zD8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897082; c=relaxed/simple;
	bh=+MPJ/u3HWw29kcOhw/7owYa4tN9xsvIow5QJw0Pg4wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8FRqMbfZVPM8+vpqNII20+x/BvhUGiaCySwOW8RLswh/hqbcVIClY0EVx1VQ/RyLcm/IpVcWRqT7P1nmadY6xm1hxqTC7bkEuJhO072ubmqby7xSgHmiZKgbljb6h5pi0RGIWFu9TIQNStkou1fl4mEd0oDS+H7vF2GseKhqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHcXIDH3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHcXIDH3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657FKLOI3069284
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XukeUaJ/91mmvYuzR
	iLOQUgsBGlz3VFm9GNse8cDLm8=; b=LHcXIDH3fl48soQzbN3Bz1kw74yMpIXAi
	MdDzRUyjNKB7EfFcINEpZPQnUAFE4mN1/SfeXoNb2hSwky03U7HNHlQ5BLkW30Za
	+tQO6hyEfMSoVURl/pp5H8QPhRaMGgEcE9lRz6xAeU2q4oN7I8qnvMQbO52Q6rhb
	Yv2E6/2du64xFXCdz1TGr3IoPk1RF/0/ahddWuLAplf+maiNPooxP1vglHFaDMCW
	+HMkceqxjI8beNrhWzUMK/QqRKAKSYttC58Sv3ftCNFBv/vCisoQy1mtKjWvBHmO
	+CXOj1XEZVkTW8bhkVYqyHtaEKDh33PuVHaWdCRe7NMUC+fFgDmeQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6snp59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585Yf6C021784
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03furk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585btEq43057578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ACB920043;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CE4D20040;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 6/8] s390/string: Convert memset(16|32|64)() to C
Date: Mon,  8 Jun 2026 07:37:52 +0200
Message-ID: <20260608053754.571282-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608053754.571282-1-hca@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QNTf7hkR5wzHcasoXQPI4gxwraKUzVlw
X-Proofpoint-GUID: QNTf7hkR5wzHcasoXQPI4gxwraKUzVlw
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a265537 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2XASNfKs-svsWAi9s9kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX0C7wPqKhMIeO
 vIynkN7isI0Ixnqiklkg+GdsTdDOowGPxh5CualUpiGrrWmqizhAaP4H46y0WBlgUmIqHadgdnP
 zTx0Vqi29WI2cW+ynXHEa3ipVv/1HjaxEWOW6qUkDJYg3JAypjziSiU3lQ0je7ipoI9JEuz5GLm
 gunWta38xM6lEew5Edzq67y7Io+kD0D8S6Ud969UBxABtLDPLXrjS53+HvEvLnFESxfv6tRXBaG
 priJfIEotrFAIvRv5FMEnEHk6qwl/zM2lIciHvRH2J9H1BDdr+/eDT2UDGrsATO+EBYFGHCBQzL
 5Q6eYnDcHix6ztsF8PQ1CzTIfGhsk5VNcWHdFC7RWWbxdq0qOT8vWVnUvQ6x6z3wxcDdxaevwiz
 Gl8HnbtiVYwfnq6tsDodnHGtcEko2rMcshJeYkRg+dxaDYZlo6RwPyW02a9niiKTZxZmiVCAiDi
 Ez/ye3Z740v1KmPbsEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080049

Convert memset(16|32|64)() from assembler to C, which should make it
easier to read and change, if required. And it allows the compiler to
optimize the code, and use different instructions, except for the used
inline assemblies.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/Makefile      |  2 +-
 arch/s390/boot/mem.S         |  2 --
 arch/s390/boot/string.c      |  6 +---
 arch/s390/lib/Makefile       |  1 -
 arch/s390/lib/mem.S          | 57 ------------------------------------
 arch/s390/lib/string.c       | 47 +++++++++++++++++++++++++++++
 arch/s390/purgatory/Makefile |  5 +---
 7 files changed, 50 insertions(+), 70 deletions(-)
 delete mode 100644 arch/s390/boot/mem.S
 delete mode 100644 arch/s390/lib/mem.S

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index a1e719a79d38..08bcee4025e6 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -26,7 +26,7 @@ KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
 obj-y	:= head.o als.o startup.o physmem_info.o ipl_parm.o ipl_report.o vmem.o
-obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
+obj-y	+= string.o ebcdic.o sclp_early_core.o ipl_vmparm.o cmdline.o
 obj-y	+= version.o pgm_check.o ctype.o ipl_data.o relocs.o alternative.o
 obj-y	+= uv.o printk.o trampoline.o
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
diff --git a/arch/s390/boot/mem.S b/arch/s390/boot/mem.S
deleted file mode 100644
index b33463633f03..000000000000
--- a/arch/s390/boot/mem.S
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include "../lib/mem.S"
diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
index bd68161434a6..e4ad196cb720 100644
--- a/arch/s390/boot/string.c
+++ b/arch/s390/boot/string.c
@@ -43,11 +43,7 @@ ssize_t sized_strscpy(char *dst, const char *src, size_t count)
 
 void *memset64(uint64_t *s, uint64_t v, size_t count)
 {
-	uint64_t *xs = s;
-
-	while (count--)
-		*xs++ = v;
-	return s;
+	return __memset64(s, v, count * sizeof(v));
 }
 
 char *skip_spaces(const char *str)
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index 2bf47204f6ab..81bfc746931c 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -5,7 +5,6 @@
 
 lib-y += delay.o string.o uaccess.o find.o spinlock.o tishift.o
 lib-y += csum-partial.o
-obj-y += mem.o
 lib-$(CONFIG_KPROBES) += probes.o
 lib-$(CONFIG_UPROBES) += probes.o
 obj-$(CONFIG_S390_KPROBES_SANITY_TEST) += test_kprobes_s390.o
diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
deleted file mode 100644
index d2e1ca87a568..000000000000
--- a/arch/s390/lib/mem.S
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * String handling functions.
- *
- * Copyright IBM Corp. 2012
- */
-
-#include <linux/export.h>
-#include <linux/linkage.h>
-#include <asm/nospec-insn.h>
-
-	GEN_BR_THUNK %r14
-
-/*
- * __memset16/32/64
- *
- * void *__memset16(uint16_t *s, uint16_t v, size_t count)
- * void *__memset32(uint32_t *s, uint32_t v, size_t count)
- * void *__memset64(uint64_t *s, uint64_t v, size_t count)
- */
-.macro __MEMSET bits,bytes,insn
-SYM_FUNC_START(__memset\bits)
-	ltgr	%r4,%r4
-	jz	.L__memset_exit\bits
-	cghi	%r4,\bytes
-	je	.L__memset_store\bits
-	aghi	%r4,-(\bytes+1)
-	srlg	%r5,%r4,8
-	ltgr	%r5,%r5
-	lgr	%r1,%r2
-	jz	.L__memset_remainder\bits
-.L__memset_loop\bits:
-	\insn	%r3,0(%r1)
-	mvc	\bytes(256-\bytes,%r1),0(%r1)
-	la	%r1,256(%r1)
-	brctg	%r5,.L__memset_loop\bits
-.L__memset_remainder\bits:
-	\insn	%r3,0(%r1)
-	exrl	%r4,.L__memset_mvc\bits
-	BR_EX	%r14
-.L__memset_store\bits:
-	\insn	%r3,0(%r2)
-.L__memset_exit\bits:
-	BR_EX	%r14
-.L__memset_mvc\bits:
-	mvc	\bytes(1,%r1),0(%r1)
-SYM_FUNC_END(__memset\bits)
-.endm
-
-__MEMSET 16,2,sth
-EXPORT_SYMBOL(__memset16)
-
-__MEMSET 32,4,st
-EXPORT_SYMBOL(__memset32)
-
-__MEMSET 64,8,stg
-EXPORT_SYMBOL(__memset64)
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 4dd524cdef5f..2f9e9e886016 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -158,6 +158,53 @@ EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(memcpy);
 #endif
 
+#define DEFINE_MEMSET(_bits, _bytes, _type)					\
+void *__memset##_bits(_type *s, _type v, size_t n)				\
+{										\
+	_type *xs = s;								\
+										\
+	if (!n)									\
+		return s;							\
+	while (n >= 256) {							\
+		*xs = v;							\
+		asm volatile(							\
+			"	mvc	%[_b](256-%[_b],%[xs]),0(%[xs])\n"	\
+			:							\
+			: [xs] "a" (xs), [_b] "i" (_bytes)			\
+			: "memory");						\
+		xs = (_type *)((char *)xs + 256);				\
+		n -= 256;							\
+	}									\
+	if (!n)									\
+		return s;							\
+	*xs = v;								\
+	if (n == _bytes)							\
+		return s;							\
+	n -= _bytes + 1;							\
+	asm volatile(								\
+		"	exrl	 %[n],1f\n"					\
+		"	j	 2f\n"						\
+		"1:	mvc	 %[_b](1,%[xs]),0(%[xs])\n"			\
+		"2:"								\
+		:								\
+		: [n] "a" (n), [xs] "a" (xs), [_b] "i" (_bytes)			\
+		: "memory");							\
+	return s;								\
+}										\
+EXPORT_SYMBOL(__memset##_bits)
+
+#ifdef __HAVE_ARCH_MEMSET16
+DEFINE_MEMSET(16, 2, uint16_t);
+#endif
+
+#ifdef __HAVE_ARCH_MEMSET32
+DEFINE_MEMSET(32, 4, uint32_t);
+#endif
+
+#ifdef __HAVE_ARCH_MEMSET64
+DEFINE_MEMSET(64, 8, uint64_t);
+#endif
+
 /*
  * Helper functions to find the end of a string
  */
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index f55764d0c49e..e74410bb1b88 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-purgatory-y := head.o purgatory.o string.o sha256.o mem.o
+purgatory-y := head.o purgatory.o string.o sha256.o
 
 targets += $(purgatory-y) purgatory.lds purgatory purgatory.chk purgatory.ro
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
@@ -10,9 +10,6 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__NO_FORTIFY
 
-$(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
-	$(call if_changed_rule,as_o_S)
-
 CC_FLAGS_MARCH_MINIMUM := -march=z10
 
 KBUILD_CFLAGS := $(CC_FLAGS_DIALECT) -fno-strict-aliasing -Wall -Wstrict-prototypes
-- 
2.53.0

