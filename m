Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15488C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCA861039
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 21:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhG1V0b (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:26:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231784AbhG1V0a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 17:26:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SK9t3g115015;
        Wed, 28 Jul 2021 17:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SuYxz0Qd8dniNSsnC0i5/EYjxRVG47KhdzXEr1eZvuo=;
 b=UrsGV3uAmhJP3MGaERunhlG8LHMal6ooL/LpBoUVhYkOJb6AvdPzTBUu5Q3DOWKubiwK
 SGM+Z2WUv5c1zyST7v24T1XhXMFNjTzU5bu/nWW0Q3tyAm4jRfkKJikCqqFmhpsT2uT7
 E27Jr625xKkM5o+F78jX/OcpKOPCAxTCc6t7SwTNVmFztNfn+XETcBIEPNB8M/B012us
 cylD2GldEWs7vFDOJSayJnRh51AumdEqOKYJynqouqj4kPsCRpY+OMVF3axSQTKC3etV
 ruwriVvJ9zMAfUqHlh7RU1i/GuOC4+fmZhJbfs4X+4ZqpVnPpvZSydNPyuzriRNO9x5q yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3970t9p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 17:26:02 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SLQ1HU092048;
        Wed, 28 Jul 2021 17:26:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3970t9nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 17:26:01 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJmvdj008925;
        Wed, 28 Jul 2021 21:26:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m1a3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 21:25:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SLPucK30409156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 21:25:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C3FAE045;
        Wed, 28 Jul 2021 21:25:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C20DAE056;
        Wed, 28 Jul 2021 21:25:56 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 21:25:56 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] s390/ftrace: implement hotpatching
Date:   Wed, 28 Jul 2021 23:25:46 +0200
Message-Id: <20210728212546.128248-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728212546.128248-1-iii@linux.ibm.com>
References: <20210728212546.128248-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oCeuVszPmJ0Nf7M63msLpcusf6Wr7FLX
X-Proofpoint-ORIG-GUID: fkIO8SsbtpZfW-NAGXWGiowEGjYu9xEN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_10:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280113
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

s390 allows hotpatching the mask of a conditional jump instruction.
Make use of this feature in order to avoid the expensive stop_machine()
call.

The new trampolines are split in 3 stages:

- A first stage is a 6-byte relative conditional long branch located at
  each function's entry point. Its offset always points to the second
  stage for the corresponding function, and its mask is either all 0s
  (ftrace off) or all 1s (ftrace on). The code for flipping the mask is
  borrowed from ftrace_{enable,disable}_ftrace_graph_caller. After
  flipping, ftrace_arch_code_modify_post_process() syncs with all the
  other CPUs by sending SIGPs.

- Second stages for vmlinux are stored in a separate part of the .text
  section reserved by the linker script, and in dynamically allocated
  memory for modules. This prevents the icache pollution. The total
  size of second stages is about 1.5% of that of the kernel image.

  Putting second stages in the .bss section is possible and decreases
  the size of the non-compressed vmlinux, but splits the kernel 1:1
  mapping, which is a bad tradeoff.

  Each second stage contains a call to the third stage, a pointer to
  the part of the intercepted function right after the first stage, and
  a pointer to an interceptor function (e.g. ftrace_caller).

  Second stages are 8-byte aligned for the future direct calls
  implementation.

- There are only two copies of the third stage: in the .text section
  for vmlinux and in dynamically allocated memory for modules. It can be
  an expoline, which is relatively large, so inlining it into each
  second stage is prohibitively expensive.

As a result of this organization, phoronix-test-suite with ftrace off
does not show any performance degradation.

At least a couple things are missing right now, but can be implemented
separately later:

- Expoline version of the third stage is supported only for z10+.
  Implementing it for earlier machines is possible, but is relatively
  complicated due to the lack of available registers.

- On z15+ trampolines may use a BIC instruction, which loads an address
  from memory and jumps to it.

Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Suggested-by: Vasily Gorbik <gor@linux.ibm.com>
Co-developed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/ftrace.h     |  46 +------
 arch/s390/include/asm/ftrace.lds.h |  21 +++
 arch/s390/include/asm/module.h     |   8 ++
 arch/s390/kernel/ftrace.c          | 207 ++++++++++++++++++++++++++---
 arch/s390/kernel/ftrace.h          |  24 ++++
 arch/s390/kernel/module.c          |  45 +++++++
 arch/s390/kernel/vmlinux.lds.S     |   2 +
 7 files changed, 296 insertions(+), 57 deletions(-)
 create mode 100644 arch/s390/include/asm/ftrace.lds.h
 create mode 100644 arch/s390/kernel/ftrace.h

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 345cbe982a8b..e8b460f39c58 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -18,7 +18,6 @@
 void ftrace_caller(void);
 
 extern char ftrace_graph_caller_end;
-extern unsigned long ftrace_plt;
 extern void *ftrace_func;
 
 struct dyn_arch_ftrace { };
@@ -31,10 +30,11 @@ struct dyn_arch_ftrace { };
 
 struct module;
 struct dyn_ftrace;
-/*
- * Either -mhotpatch or -mnop-mcount is used - no explicit init is required
- */
-static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec) { return 0; }
+
+bool ftrace_need_init_nop(void);
+#define ftrace_need_init_nop ftrace_need_init_nop
+
+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
@@ -42,42 +42,6 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
-struct ftrace_insn {
-	u16 opc;
-	s32 disp;
-} __packed;
-
-static inline void ftrace_generate_nop_insn(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_FUNCTION_TRACER
-	/* brcl 0,0 */
-	insn->opc = 0xc004;
-	insn->disp = 0;
-#endif
-}
-
-static inline int is_ftrace_nop(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_FUNCTION_TRACER
-	if (insn->disp == 0)
-		return 1;
-#endif
-	return 0;
-}
-
-static inline void ftrace_generate_call_insn(struct ftrace_insn *insn,
-					     unsigned long ip)
-{
-#ifdef CONFIG_FUNCTION_TRACER
-	unsigned long target;
-
-	/* brasl r0,ftrace_caller */
-	target = is_module_addr((void *) ip) ? ftrace_plt : FTRACE_ADDR;
-	insn->opc = 0xc005;
-	insn->disp = (target - ip) / 2;
-#endif
-}
-
 /*
  * Even though the system call numbers are identical for s390/s390x a
  * different system call table is used for compat tasks. This may lead
diff --git a/arch/s390/include/asm/ftrace.lds.h b/arch/s390/include/asm/ftrace.lds.h
new file mode 100644
index 000000000000..90b3d86227ca
--- /dev/null
+++ b/arch/s390/include/asm/ftrace.lds.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef DIV_ROUND_UP
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#endif
+
+#define SIZEOF_MCOUNT_LOC_ENTRY 8
+#define SIZEOF_FTRACE_HOTPATCH_TRAMPOLINE 24
+#define FTRACE_HOTPATCH_TRAMPOLINES_SIZE(n)                                    \
+	DIV_ROUND_UP(SIZEOF_FTRACE_HOTPATCH_TRAMPOLINE * (n),                  \
+		     SIZEOF_MCOUNT_LOC_ENTRY)
+
+#ifdef CONFIG_FUNCTION_TRACER
+#define FTRACE_HOTPATCH_TRAMPOLINES_TEXT                                       \
+	. = ALIGN(8);                                                          \
+	__ftrace_hotpatch_trampolines_start = .;                               \
+	. = . + FTRACE_HOTPATCH_TRAMPOLINES_SIZE(__stop_mcount_loc -           \
+						 __start_mcount_loc);          \
+	__ftrace_hotpatch_trampolines_end = .;
+#else
+#define FTRACE_HOTPATCH_TRAMPOLINES_TEXT
+#endif
diff --git a/arch/s390/include/asm/module.h b/arch/s390/include/asm/module.h
index 71e57b8af757..9f1eea15872c 100644
--- a/arch/s390/include/asm/module.h
+++ b/arch/s390/include/asm/module.h
@@ -28,6 +28,14 @@ struct mod_arch_specific {
 	int nsyms;
 	/* Additional symbol information (got and plt offsets). */
 	struct mod_arch_syminfo *syminfo;
+#ifdef CONFIG_FUNCTION_TRACER
+	/* Start of memory reserved for ftrace hotpatch trampolines. */
+	struct ftrace_hotpatch_trampoline *trampolines_start;
+	/* End of memory reserved for ftrace hotpatch trampolines. */
+	struct ftrace_hotpatch_trampoline *trampolines_end;
+	/* Next unused ftrace hotpatch trampoline slot. */
+	struct ftrace_hotpatch_trampoline *next_trampoline;
+#endif /* CONFIG_FUNCTION_TRACER */
 };
 
 #endif /* _ASM_S390_MODULE_H */
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 2d8f595d9196..5d3fa255533a 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -18,8 +18,11 @@
 #include <trace/syscall.h>
 #include <asm/asm-offsets.h>
 #include <asm/cacheflush.h>
+#include <asm/ftrace.lds.h>
+#include <asm/nospec-branch.h>
 #include <asm/set_memory.h>
 #include "entry.h"
+#include "ftrace.h"
 
 /*
  * To generate function prologue either gcc's hotpatch feature (since gcc 4.8)
@@ -41,7 +44,115 @@
  */
 
 void *ftrace_func __read_mostly = ftrace_stub;
-unsigned long ftrace_plt;
+struct ftrace_insn {
+	u16 opc;
+	s32 disp;
+} __packed;
+
+asm(
+	"ftrace_shared_hotpatch_trampoline_br:\n"
+	"	lmg	%r0,%r1,2(%r1)\n"
+	"	br	%r1\n"
+	"ftrace_shared_hotpatch_trampoline_br_end:\n"
+);
+
+#ifdef CONFIG_EXPOLINE
+asm(
+	"ftrace_shared_hotpatch_trampoline_exrl:\n"
+	"	lmg	%r0,%r1,2(%r1)\n"
+	"	.insn	ril,0xc60000000000,%r0,0f\n" /* exrl */
+	"	j	.\n"
+	"0:	br	%r1\n"
+	"ftrace_shared_hotpatch_trampoline_exrl_end:\n"
+);
+#endif /* CONFIG_EXPOLINE */
+
+#ifdef CONFIG_MODULES
+static char *ftrace_plt;
+
+asm(
+	"	.data\n"
+	"ftrace_plt_template:\n"
+	"	basr	%r1,%r0\n"
+	"	lg	%r1,0f-.(%r1)\n"
+	"	br	%r1\n"
+	"0:	.quad	ftrace_caller\n"
+	"ftrace_plt_template_end:\n"
+	"	.previous\n"
+);
+#endif /* CONFIG_MODULES */
+
+static const char *ftrace_shared_hotpatch_trampoline(const char **end)
+{
+#ifdef CONFIG_EXPOLINE
+	if (!nospec_disable) {
+		if (test_facility(18)) {
+			if (end)
+				*end = ftrace_shared_hotpatch_trampoline_exrl_end;
+			return ftrace_shared_hotpatch_trampoline_exrl;
+		}
+		return NULL;
+	}
+#endif /* CONFIG_EXPOLINE */
+	if (end)
+		*end = ftrace_shared_hotpatch_trampoline_br_end;
+	return ftrace_shared_hotpatch_trampoline_br;
+}
+
+bool ftrace_need_init_nop(void)
+{
+	return ftrace_shared_hotpatch_trampoline(NULL);
+}
+
+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
+{
+	static struct ftrace_hotpatch_trampoline *next_vmlinux_trampoline =
+		__ftrace_hotpatch_trampolines_start;
+	static const char orig[6] = { 0xc0, 0x04, 0x00, 0x00, 0x00, 0x00 };
+	static struct ftrace_hotpatch_trampoline *trampoline;
+	struct ftrace_hotpatch_trampoline **next_trampoline;
+	struct ftrace_hotpatch_trampoline *trampolines_end;
+	struct ftrace_hotpatch_trampoline tmp;
+	struct ftrace_insn *insn;
+	const char *shared;
+	s32 disp;
+
+	BUILD_BUG_ON(sizeof(struct ftrace_hotpatch_trampoline) !=
+		     SIZEOF_FTRACE_HOTPATCH_TRAMPOLINE);
+
+	next_trampoline = &next_vmlinux_trampoline;
+	trampolines_end = __ftrace_hotpatch_trampolines_end;
+	shared = ftrace_shared_hotpatch_trampoline(NULL);
+#ifdef CONFIG_MODULES
+	if (mod) {
+		next_trampoline = &mod->arch.next_trampoline;
+		trampolines_end = mod->arch.trampolines_end;
+		shared = ftrace_plt;
+	}
+#endif
+
+	if (WARN_ON_ONCE(*next_trampoline >= trampolines_end))
+		return -ENOMEM;
+	trampoline = (*next_trampoline)++;
+
+	/* Check for the compiler-generated fentry nop (brcl 0, .). */
+	if (WARN_ON_ONCE(memcmp((const void *)rec->ip, &orig, sizeof(orig))))
+		return -EINVAL;
+
+	/* Generate the trampoline. */
+	tmp.brasl_opc = 0xc015; /* brasl %r1, shared */
+	tmp.brasl_disp = (shared - (const char *)&trampoline->brasl_opc) / 2;
+	tmp.interceptor = FTRACE_ADDR;
+	tmp.rest_of_intercepted_function = rec->ip + sizeof(struct ftrace_insn);
+	s390_kernel_write(trampoline, &tmp, sizeof(tmp));
+
+	/* Generate a jump to the trampoline. */
+	disp = ((char *)trampoline - (char *)rec->ip) / 2;
+	insn = (struct ftrace_insn *)rec->ip;
+	s390_kernel_write(&insn->disp, &disp, sizeof(disp));
+
+	return 0;
+}
 
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
@@ -49,11 +160,45 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	return 0;
 }
 
+static void ftrace_generate_nop_insn(struct ftrace_insn *insn)
+{
+	/* brcl 0,0 */
+	insn->opc = 0xc004;
+	insn->disp = 0;
+}
+
+static void ftrace_generate_call_insn(struct ftrace_insn *insn,
+				      unsigned long ip)
+{
+	unsigned long target;
+
+	/* brasl r0,ftrace_caller */
+	target = FTRACE_ADDR;
+#ifdef CONFIG_MODULES
+	if (is_module_addr((void *)ip))
+		target = (unsigned long)ftrace_plt;
+#endif /* CONFIG_MODULES */
+	insn->opc = 0xc005;
+	insn->disp = (target - ip) / 2;
+}
+
+static void brcl_disable(void *brcl)
+{
+	u8 op = 0x04; /* set mask field to zero */
+
+	s390_kernel_write((char *)brcl + 1, &op, sizeof(op));
+}
+
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
 	struct ftrace_insn orig, new, old;
 
+	if (ftrace_shared_hotpatch_trampoline(NULL)) {
+		brcl_disable((void *)rec->ip);
+		return 0;
+	}
+
 	if (copy_from_kernel_nofault(&old, (void *) rec->ip, sizeof(old)))
 		return -EFAULT;
 	/* Replace ftrace call with a nop. */
@@ -67,10 +212,22 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	return 0;
 }
 
+static void brcl_enable(void *brcl)
+{
+	u8 op = 0xf4; /* set mask field to all ones */
+
+	s390_kernel_write((char *)brcl + 1, &op, sizeof(op));
+}
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	struct ftrace_insn orig, new, old;
 
+	if (ftrace_shared_hotpatch_trampoline(NULL)) {
+		brcl_enable((void *)rec->ip);
+		return 0;
+	}
+
 	if (copy_from_kernel_nofault(&old, (void *) rec->ip, sizeof(old)))
 		return -EFAULT;
 	/* Replace nop with an ftrace call. */
@@ -95,22 +252,44 @@ int __init ftrace_dyn_arch_init(void)
 	return 0;
 }
 
+void arch_ftrace_update_code(int command)
+{
+	if (ftrace_shared_hotpatch_trampoline(NULL))
+		ftrace_modify_all_code(command);
+	else
+		ftrace_run_stop_machine(command);
+}
+
+static void __ftrace_sync(void *dummy)
+{
+}
+
+int ftrace_arch_code_modify_post_process(void)
+{
+	if (ftrace_shared_hotpatch_trampoline(NULL)) {
+		/* Send SIGP to the other CPUs, so they see the new code. */
+		smp_call_function(__ftrace_sync, NULL, 1);
+	}
+	return 0;
+}
+
 #ifdef CONFIG_MODULES
 
 static int __init ftrace_plt_init(void)
 {
-	unsigned int *ip;
+	const char *start, *end;
 
-	ftrace_plt = (unsigned long) module_alloc(PAGE_SIZE);
+	ftrace_plt = module_alloc(PAGE_SIZE);
 	if (!ftrace_plt)
 		panic("cannot allocate ftrace plt\n");
-	ip = (unsigned int *) ftrace_plt;
-	ip[0] = 0x0d10e310; /* basr 1,0; lg 1,10(1); br 1 */
-	ip[1] = 0x100a0004;
-	ip[2] = 0x07f10000;
-	ip[3] = FTRACE_ADDR >> 32;
-	ip[4] = FTRACE_ADDR & 0xffffffff;
-	set_memory_ro(ftrace_plt, 1);
+
+	start = ftrace_shared_hotpatch_trampoline(&end);
+	if (!start) {
+		start = ftrace_plt_template;
+		end = ftrace_plt_template_end;
+	}
+	memcpy(ftrace_plt, start, end - start);
+	set_memory_ro((unsigned long)ftrace_plt, 1);
 	return 0;
 }
 device_initcall(ftrace_plt_init);
@@ -147,17 +326,13 @@ NOKPROBE_SYMBOL(prepare_ftrace_return);
  */
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	u8 op = 0x04; /* set mask field to zero */
-
-	s390_kernel_write(__va(ftrace_graph_caller)+1, &op, sizeof(op));
+	brcl_disable(__va(ftrace_graph_caller));
 	return 0;
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	u8 op = 0xf4; /* set mask field to all ones */
-
-	s390_kernel_write(__va(ftrace_graph_caller)+1, &op, sizeof(op));
+	brcl_enable(__va(ftrace_graph_caller));
 	return 0;
 }
 
diff --git a/arch/s390/kernel/ftrace.h b/arch/s390/kernel/ftrace.h
new file mode 100644
index 000000000000..7f75a9616406
--- /dev/null
+++ b/arch/s390/kernel/ftrace.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _FTRACE_H
+#define _FTRACE_H
+
+#include <asm/types.h>
+
+struct ftrace_hotpatch_trampoline {
+	u16 brasl_opc;
+	s32 brasl_disp;
+	s16: 16;
+	u64 rest_of_intercepted_function;
+	u64 interceptor;
+} __packed;
+
+extern struct ftrace_hotpatch_trampoline __ftrace_hotpatch_trampolines_start[];
+extern struct ftrace_hotpatch_trampoline __ftrace_hotpatch_trampolines_end[];
+extern const char ftrace_shared_hotpatch_trampoline_br[];
+extern const char ftrace_shared_hotpatch_trampoline_br_end[];
+extern const char ftrace_shared_hotpatch_trampoline_exrl[];
+extern const char ftrace_shared_hotpatch_trampoline_exrl_end[];
+extern const char ftrace_plt_template[];
+extern const char ftrace_plt_template_end[];
+
+#endif /* _FTRACE_H */
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 4055f1c49814..b01ba460b7ca 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -14,6 +14,7 @@
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <linux/ftrace.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/kasan.h>
@@ -23,6 +24,8 @@
 #include <asm/alternative.h>
 #include <asm/nospec-branch.h>
 #include <asm/facility.h>
+#include <asm/ftrace.lds.h>
+#include <asm/set_memory.h>
 
 #if 0
 #define DEBUGP printk
@@ -48,6 +51,13 @@ void *module_alloc(unsigned long size)
 	return p;
 }
 
+#ifdef CONFIG_FUNCTION_TRACER
+void module_arch_cleanup(struct module *mod)
+{
+	module_memfree(mod->arch.trampolines_start);
+}
+#endif
+
 void module_arch_freeing_init(struct module *mod)
 {
 	if (is_livepatch_module(mod) &&
@@ -466,6 +476,30 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 				    write);
 }
 
+#ifdef CONFIG_FUNCTION_TRACER
+static int module_alloc_ftrace_hotpatch_trampolines(struct module *me,
+						    const Elf_Shdr *s)
+{
+	char *start, *end;
+	int numpages;
+	size_t size;
+
+	size = FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
+	numpages = DIV_ROUND_UP(size, PAGE_SIZE);
+	start = module_alloc(numpages * PAGE_SIZE);
+	if (!start)
+		return -ENOMEM;
+	set_memory_ro((unsigned long)start, numpages);
+	end = start + size;
+
+	me->arch.trampolines_start = (struct ftrace_hotpatch_trampoline *)start;
+	me->arch.trampolines_end = (struct ftrace_hotpatch_trampoline *)end;
+	me->arch.next_trampoline = me->arch.trampolines_start;
+
+	return 0;
+}
+#endif /* CONFIG_FUNCTION_TRACER */
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
@@ -473,6 +507,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s;
 	char *secstrings, *secname;
 	void *aseg;
+#ifdef CONFIG_FUNCTION_TRACER
+	int ret;
+#endif
 
 	if (IS_ENABLED(CONFIG_EXPOLINE) &&
 	    !nospec_disable && me->arch.plt_size) {
@@ -507,6 +544,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
 		    (str_has_prefix(secname, ".s390_return")))
 			nospec_revert(aseg, aseg + s->sh_size);
+
+#ifdef CONFIG_FUNCTION_TRACER
+		if (!strcmp(FTRACE_CALLSITE_SECTION, secname)) {
+			ret = module_alloc_ftrace_hotpatch_trampolines(me, s);
+			if (ret < 0)
+				return ret;
+		}
+#endif /* CONFIG_FUNCTION_TRACER */
 	}
 
 	jump_label_apply_nops(me);
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index b18288d26ca8..b6caa810af3a 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -5,6 +5,7 @@
 
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/ftrace.lds.h>
 
 /*
  * Put .bss..swapper_pg_dir as the first thing in .bss. This will
@@ -46,6 +47,7 @@ SECTIONS
 		KPROBES_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+		FTRACE_HOTPATCH_TRAMPOLINES_TEXT
 		*(.text.*_indirect_*)
 		*(.fixup)
 		*(.gnu.warning)
-- 
2.31.1

