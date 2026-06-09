Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051F3F4835
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001232; cv=none; b=iO8mPo86W1YTi94s6C20m/iujxAriniDyY0Quldn6+FL5rs0JS5qaxTeOpniT32OaE0IPIZyK8f2T3KkGd60v+xSchruV43mjp0UCvRgYQbKsF1ed1G1BGg4jXAXbBNwvcEuFQD2GLqlJufmH5hrEB5Tl91EITwTxvHwpJWw/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001232; c=relaxed/simple;
	bh=vAL73qFlESBEnrubi35Chez4+YUiHrp9bv7xoMRTSeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxhyTl6K+IkPd5JHOmUueNXH9W/3zyZyS/hou550TgRj5SQz5Uw6VBQEz5Uy93YWZt76v49oJSQ9vV2ESxIaiBZCGmW4yAWK0PBvsdCRTkcLLj487I0AsxrCv/5I6sNhchZuOg5HWAYMp4mRhgI1GVsSyJ6Wng0CLRlTFe3wcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=srqyGx0Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="srqyGx0Y"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596F0am3945916
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y9ARsuaelIDj2zzdo
	9ZI/sI4gnQtcgh1wJKok3NH/10=; b=srqyGx0YO+RDc4KNoFuA2www9U7JaeAlN
	mJSDaAgWtXrgnwsMSJJ+rYVaj2gUmXe7auGcvc4Jqz1d7a41XPN/txMs0Uze3O8x
	y1CmwzJmSN4AaEhR6oeD0zV8ptfhRwX9/xMNZYS4cpL9eHzlxyPcMKuOzjFHRqYO
	+Cfs51Njbv7px6YNxC4U33HXkKCBH3VFMbhPqUi3tZfUz64tXej8fU89VZPXtJws
	t7AzBFaMlpfUiOf73gB26jtPfUU+D9SYOzXTgCnm5TNl/AxzoFPvp0RgIkSjZKrm
	n0QQ3+xpj2SkmbEAPYcphM+cDi5g6mwWDX6KzCXN+ug/oziy2lf1g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sucmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJaCH009091
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq1q1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXjGx23658958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F5520040;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 277DB2005A;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 7/9] s390/string: Convert memset(16|32|64)() to C
Date: Tue,  9 Jun 2026 12:33:41 +0200
Message-ID: <20260609103343.107325-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609103343.107325-1-hca@linux.ibm.com>
References: <20260609103343.107325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PIJT0Tmn8nL4kAD6cT-oDqXXaoN4Couy
X-Proofpoint-GUID: PIJT0Tmn8nL4kAD6cT-oDqXXaoN4Couy
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a27ec0d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Ln8ekJ6lhIK6O7RAWtwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfXxDFOrQ99/fWG
 45GCfS0VNYKAW20gPwGoCBL8ubhiSqJF8MhGCPoBb9Wk4+vdGngqGFVTSpzwuG6ZpZrKeanhl+Q
 chtbYpVol0VADWZd8b9vzM/xwdD90yjwCF1PRiuPHu1ZT0xIm3lfKhMILOB5R8bTE812VZ1+3WS
 4Hc/svVjLbSmo6NcQDfpygZpIHHvRyuSj6Ahs3t7Tzfu0gVbGtMISDUtCTShWhAs81R+BMn0vTJ
 uaNfqd4ftVOfcy47IUxQeJsXRmLD5o4E3DjN1G6SMmZC+16MzX2BoG3jFfF5wq+uUSr9HIuBciP
 t5EPWUHoa0TogR/gwlfc3cJuAcvLBoHgusvF4chA4hLnrj6bY3bzuopl+mgKR4V4p7/QPY/93ep
 hXF3GqU6pGD2BlDQumeOcOtA5PnOT/SYDQq4zcXoB1YK4a+4DBEd/QbbYyI9Qt+MZD0fVdnKd6q
 MGdbwSyVSG+U+RntlZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090094

Convert memset(16|32|64)() from assembler to C, which should make it
easier to read and change, if required. And it allows the compiler to
optimize the code, and use different instructions, except for the used
inline assemblies.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
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
index e1f82d118bc9..10b75e053a6f 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -31,7 +31,7 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 CFLAGS_string.o = -ffreestanding
 
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
index c82aedef0272..aa6cc6a1fe88 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -10,7 +10,6 @@ CFLAGS_string.o = -ffreestanding
 
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

