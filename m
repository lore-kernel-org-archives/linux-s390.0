Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23923E23C;
	Tue, 27 Jan 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527200; cv=none; b=LbV1VGHbwAlyvYN7d2KN2lmDygXqDJk/erVN+cDoE1ZjCdfW251gOeYwAfLSKZCbQX0wON31vE4Zm2yimlXJMcid2i3s44dCSPaO7g9s/qgXNFWobxpQEKhjjTogjESVKzY3sTU0Xh3gNdXb8qla2tNg9ke4KcNrUp7vSNkEY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527200; c=relaxed/simple;
	bh=RT8EBSR8WUQAbyvZRvXCygdtoMjanu9p9cPL0JHiKSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vggo9FU5vnN14XYFjHd5Zdu++Ptv8Rd8JESRpX4BiSQy8HgX0LX+il7ZNnTYFMWVKYakJRjVvN/7sRuGNnhU7dkQrczNfjvgeGjlDqJsHL7V8mX9jAwLicCEqcrvhojC2umnfPUTfyRn1Fp94u7SNjaMta9wBs6p8pemSWdyguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X1W9jFj+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X1W9jFj+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R80wX1010200;
	Tue, 27 Jan 2026 15:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1TqPmQcpDe5apq/kR
	pvca83qGv9hWGr5mzGDqs1lLgI=; b=X1W9jFj+b26zgpaIINIlniXat7mR1Vy/3
	oMasOd4CsZktmzGfSjJd4Y1CFKgfzcQc9UgDOJw/R9GKutk25tj+VXh5+BDx2A02
	iGzptLL9Q/+xLnfiq58K8e6sKcfdQ7FU0n4bbOIU6J0lwdm44tidIlepfTsrwHDv
	/OqACNriQHAS8p35cPGNf/xcXPKq+l7nXQtNr7j9amdO+h7H/eAkk3870GR6Zw2t
	78RxhEyO9zxlXGAJ1KH7w/ou+/Ln+uHZ+seXF+rNhkzEaF3o0kKA+sVZ4FSzcRFJ
	BAV95Wyo0PkN/xLFS1uuPzOgnfVxzdSeLohoxRf/vBdJQTH//kPSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFD6S9025596;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REZjgE017966;
	Tue, 27 Jan 2026 15:19:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41rvgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJXJp14680446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D0B820040;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC60020043;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH v4 05/12] unwind_user: Enable archs that define CFA = SP_callsite + offset
Date: Tue, 27 Jan 2026 16:19:18 +0100
Message-ID: <20260127151926.2805123-6-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KyIC7bF4FuLeyIQSv9yvDDXMGlNmPLkq
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978d78a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=D-3WH5monn3MMgO2UeQA:9
X-Proofpoint-ORIG-GUID: JGPGDIlhc6TzCi6TuXKlwH2paykcZ1eT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfXxJ1Rn4mBPI46
 MvDaOth+MUyvapytBn/p9OcYA0ITq100qKf3vt56RfVBRpjy0rCuLZluFoOd2MxDQS5BAJXtMdo
 HOjwd2z612x9KiuhJAUivQNfL/6UhiKIdl/RKD4+xPujUlo1noqnVW9kCaackarEcMSNSmIFgh/
 m1M7m8n01+UnLBSGxtuaqioeL+bFgoQMCWsvdAGC4quWBt/WJkSmXLlLjXZ+X1SSEeWM3qHs9c7
 fMHpL3BMsKpvfAj/+QyDHfkWDIy2HLcHrpuxKlNBpAAUMPUfKZxoLkj3YQYsdy7ex04tt3vamXv
 /vZI0bBCZ6jeimjjnft59cupRLcrvXAeWF2Zm8Q3sOCuF5YSZPRBd/UIqQ11lk6XGqAUtFWklB7
 iNRZjBySw/DHhlUXzn/UkOHdCh7zP+L1JGKW38k37l5yL0/MTPNpU8Bp6BwKDyDeRnaDzXe6eEu
 yaE3vN80AutUCCycOiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

Most architectures define their CFA as the value of the stack pointer
(SP) at the call site in the previous frame, as suggested by the DWARF
standard.  Therefore the SP at call site can be unwound using an
implicitly assumed value offset from CFA rule with an offset of zero:

  .cfi_val_offset <SP>, 0

As a result the SP at call site computes as follows:

  SP = CFA

Enable unwinding of user space for architectures, such as s390, which
define their CFA as the value of the SP at the call site in the previous
frame with an offset.  Do so by enabling architectures to override the
default SP value offset from CFA of zero with an architecture-specific
one:

  .cfi_val_offset <SP>, offset

So that the SP at call site computes as follows:

  SP = CFA + offset

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/unwind_user.h        |  2 ++
 arch/x86/include/asm/unwind_user_sframe.h |  2 ++
 include/asm-generic/Kbuild                |  1 +
 include/asm-generic/unwind_user_sframe.h  | 12 ++++++++++++
 include/linux/unwind_user_types.h         |  1 +
 kernel/unwind/sframe.c                    |  1 +
 kernel/unwind/user.c                      | 11 ++++++-----
 7 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 include/asm-generic/unwind_user_sframe.h

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index ae46906c3b39..0650bcfae461 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -66,6 +66,7 @@ static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -2*(ws),		\
 			},				\
+	.sp_off		= 0,				\
 	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
@@ -80,6 +81,7 @@ static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
 	.fp		= {				\
 		.rule		= UNWIND_USER_RULE_RETAIN,\
 			},				\
+	.sp_off		= 0,				\
 	.outermost	= false,
 
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
diff --git a/arch/x86/include/asm/unwind_user_sframe.h b/arch/x86/include/asm/unwind_user_sframe.h
index d828ae1a4aac..40b03b482d1a 100644
--- a/arch/x86/include/asm/unwind_user_sframe.h
+++ b/arch/x86/include/asm/unwind_user_sframe.h
@@ -9,4 +9,6 @@
 
 #endif
 
+#include <asm-generic/unwind_user_sframe.h>
+
 #endif /* _ASM_X86_UNWIND_USER_SFRAME_H */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 9aff61e7b8f2..91f86dd84677 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -61,6 +61,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
+mandatory-y += unwind_user_sframe.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
new file mode 100644
index 000000000000..8c9ac47bc8bd
--- /dev/null
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_SFRAME_H
+#define _ASM_GENERIC_UNWIND_USER_SFRAME_H
+
+#include <linux/types.h>
+
+#ifndef SFRAME_SP_OFFSET
+/* Most archs/ABIs define CFA as SP at call site, so that SP = CFA + 0. */
+#define SFRAME_SP_OFFSET 0
+#endif
+
+#endif /* _ASM_GENERIC_UNWIND_USER_SFRAME_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 059e5c76f2f3..89c71a4553b2 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -65,6 +65,7 @@ struct unwind_user_frame {
 	struct unwind_user_cfa_rule_data cfa;
 	struct unwind_user_rule_data ra;
 	struct unwind_user_rule_data fp;
+	s32 sp_off;
 	bool outermost;
 };
 
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f24997e84e05..6a6221ce6d12 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -496,6 +496,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		return -EINVAL;
 	sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off);
 	sframe_init_rule_data(&frame->fp, fre->fp_ctl, fre->fp_off);
+	frame->sp_off  = SFRAME_SP_OFFSET;
 	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
 
 	return 0;
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index eb7d9489f671..e21d088f7543 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -30,7 +30,7 @@ get_user_word(unsigned long *word, unsigned long base, int off, unsigned int ws)
 static int unwind_user_next_common(struct unwind_user_state *state,
 				   const struct unwind_user_frame *frame)
 {
-	unsigned long cfa, fp, ra;
+	unsigned long cfa, sp, fp, ra;
 
 	/* Stop unwinding when reaching an outermost frame. */
 	if (frame->outermost) {
@@ -62,16 +62,17 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	    get_user_word(&cfa, cfa, 0, state->ws))
 		return -EINVAL;
 
+	/* Get the Stack Pointer (SP) */
+	sp = cfa + frame->sp_off;
 	/*
 	 * Make sure that stack is not going in wrong direction.  Allow SP
 	 * to be unchanged for the topmost frame, by subtracting topmost,
 	 * which is either 0 or 1.
 	 */
-	if (cfa <= state->sp - state->topmost)
+	if (sp <= state->sp - state->topmost)
 		return -EINVAL;
-
 	/* Make sure that the address is word aligned */
-	if (cfa & (state->ws - 1))
+	if (sp & (state->ws - 1))
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
@@ -122,7 +123,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	state->ip = ra;
-	state->sp = cfa;
+	state->sp = sp;
 	state->fp = fp;
 	state->topmost = false;
 	return 0;
-- 
2.51.0

