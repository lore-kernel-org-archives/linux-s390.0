Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87779399342;
	Tue, 17 Mar 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735626; cv=none; b=bOhbaH8Azf3YiQrbSBrMDoXZzUVjwjq21uXqyQjTgcGUe3idXUBJrCpI+Sf2U2wE+WctkdEiSxUhyrFyH7RP7ZqxCbbxHwmJYBItPLxPQOB+he3Sk+kOhQTQyTsdPrpZ11yvkdzNuhbENF4FfErAtyuJyViMuX/aIQJbdRC7aLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735626; c=relaxed/simple;
	bh=g2P5kry99vr8cw61yDTqpGuFCBdmhJOjoQJItv6ps38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hczh+xU+3Uyb05P/AjP04sBVK2FhcUmsk6UDjLkVcCbNEElPGpUOSklmWcYM+L0K0SW3hLQ9UcXOlt0rf5Muo/BwmgFupoa2qZYjruZtgOahiggIasEBIKOwNL5E0zuDPLRoX25JBep97veFWdMFlqivCofx/6WoCZVB2psxdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uplXnx0C; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uplXnx0C"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kCbAK0miUhM9M7h0e+ohSl2GXkOQmbZWJph6U0/6ORw=;
	b=uplXnx0C55LxS+4tf9CMRpZH7S+iuqu6NlD9tg76Q5uJTgvcsRDqdr/gN7W/XpWnxBIm3ftL+
	WDNyAX4y7BMXGD7svc/nMdzA/wxXy4Lg91FAMzpHjX7Fwq2539Rsd0lHbe2Wp4SI/tvxXbiPvOJ
	BT93eA3RZg/HBg8P6GuM+ZE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fZlBf4H3Hz1cyPH;
	Tue, 17 Mar 2026 16:15:22 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CB0A40568;
	Tue, 17 Mar 2026 16:20:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:19 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<deller@gmx.de>, <macro@orcam.me.uk>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <ryan.roberts@arm.com>,
	<mark.rutland@arm.com>, <thuth@redhat.com>, <song@kernel.org>,
	<ada.coupriediaz@arm.com>, <linusw@kernel.org>, <broonie@kernel.org>,
	<pengcan@kylinos.cn>, <liqiang01@kylinos.cn>, <ziyao@disroot.org>,
	<guanwentao@uniontech.com>, <guoren@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<david@kernel.org>, <mathieu.desnoyers@efficios.com>, <edumazet@google.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 RESEND 09/14] arm64: entry: Convert to generic entry
Date: Tue, 17 Mar 2026 16:20:15 +0800
Message-ID: <20260317082020.737779-10-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317082020.737779-1-ruanjinjie@huawei.com>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Implement the generic entry framework for arm64 to handle system call
entry and exit. This follows the migration of x86, RISC-V, and LoongArch,
consolidating architecture-specific syscall tracing and auditing into
the common kernel entry infrastructure.

[Background]
Arm64 has already adopted generic IRQ entry. Completing the conversion
to the generic syscall entry framework reduces architectural divergence,
simplifies maintenance, and allows arm64 to automatically benefit from
improvements in the common entry code.

[Changes]

1. Kconfig and Infrastructure:
- Select GENERIC_ENTRY and remove GENERIC_IRQ_ENTRY (now implied).

- Migrate struct thread_info to use the syscall_work field instead
  of TIF flags for syscall-related tasks.

2. Thread Info and Flags:
- Remove definitions for TIF_SYSCALL_TRACE, TIF_SYSCALL_AUDIT,
  TIF_SYSCALL_TRACEPOINT, TIF_SECCOMP, and TIF_SYSCALL_EMU.

- Replace _TIF_SYSCALL_WORK and _TIF_SYSCALL_EXIT_WORK with the
  generic SYSCALL_WORK bitmask.

- Map single-step state to SYSCALL_EXIT_TRAP in debug-monitors.c.

3. Architecture-Specific Hooks (asm/entry-common.h):
- Implement arch_ptrace_report_syscall_entry() and _exit() by
  porting the existing arm64 logic to the generic interface.

- Add arch_syscall_is_vdso_sigreturn() to asm/syscall.h to
  support Syscall User Dispatch (SUD).

4. Differentiate between syscall and interrupt entry/exit paths to handle
   RSEQ slice extensions correctly.
- For irq/exception entry/exit: use irqentry_enter_from_user_mode() and
  irqentry_exit_to_user_mode_prepare().
- For syscall entry/exit: use enter_from_user_mode() and
  syscall_exit_to_user_mode_prepare().
- Remove exit_to_user_mode_prepare_legacy() which is no longer necessary.

5. rseq_syscall() will be replaced with the static key version, that is
   "rseq_debug_syscall_return()"

6. Cleanup and Refactoring:
- Remove redundant arm64-specific syscall tracing functions from
  ptrace.c, including syscall_trace_enter(), syscall_exit_work(),
  and related audit/step helpers.

- Update el0_svc_common() in syscall.c to use the generic
  syscall_work checks and entry/exit call sites.

[Why this matters]
- Unified Interface: Aligns arm64 with the modern kernel entry standard.

- Improved Maintainability: Bug fixes in kernel/entry/common.c now
  apply to arm64 automatically.

- Feature Readiness: Simplifies the implementation of future
  cross-architecture syscall features.

[Compatibility]
This conversion maintains full ABI compatibility with existing
userspace. The ptrace register-saving behavior, seccomp filtering, and
syscall tracing semantics remain identical to the previous implementation.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                    |   2 +-
 arch/arm64/include/asm/entry-common.h |  76 +++++++++++++
 arch/arm64/include/asm/syscall.h      |  19 +++-
 arch/arm64/include/asm/thread_info.h  |  19 +---
 arch/arm64/kernel/debug-monitors.c    |   7 ++
 arch/arm64/kernel/entry-common.c      |  25 ++++-
 arch/arm64/kernel/ptrace.c            | 154 --------------------------
 arch/arm64/kernel/signal.c            |   2 +-
 arch/arm64/kernel/syscall.c           |   6 +-
 include/linux/irq-entry-common.h      |   8 --
 include/linux/rseq_entry.h            |  18 ---
 11 files changed, 127 insertions(+), 209 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38dba5f7e4d2..96fef01598be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,9 +154,9 @@ config ARM64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ENTRY
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP
-	select GENERIC_IRQ_ENTRY
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm64/include/asm/entry-common.h b/arch/arm64/include/asm/entry-common.h
index cab8cd78f693..d8bf4bf342e8 100644
--- a/arch/arm64/include/asm/entry-common.h
+++ b/arch/arm64/include/asm/entry-common.h
@@ -3,14 +3,21 @@
 #ifndef _ASM_ARM64_ENTRY_COMMON_H
 #define _ASM_ARM64_ENTRY_COMMON_H
 
+#include <linux/ptrace.h>
 #include <linux/thread_info.h>
 
+#include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/fpsimd.h>
 #include <asm/mte.h>
 #include <asm/stacktrace.h>
 
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
 #define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_MTE_ASYNC_FAULT | _TIF_FOREIGN_FPSTATE)
 
 static __always_inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
@@ -54,4 +61,73 @@ static inline bool arch_irqentry_exit_need_resched(void)
 
 #define arch_irqentry_exit_need_resched arch_irqentry_exit_need_resched
 
+static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
+						     enum ptrace_syscall_dir dir,
+						     int *regno)
+{
+	unsigned long saved_reg;
+
+	/*
+	 * We have some ABI weirdness here in the way that we handle syscall
+	 * exit stops because we indicate whether or not the stop has been
+	 * signalled from syscall entry or syscall exit by clobbering a general
+	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
+	 * and restoring its old value after the stop. This means that:
+	 *
+	 * - Any writes by the tracer to this register during the stop are
+	 *   ignored/discarded.
+	 *
+	 * - The actual value of the register is not available during the stop,
+	 *   so the tracer cannot save it and restore it later.
+	 *
+	 * - Syscall stops behave differently to seccomp and pseudo-step traps
+	 *   (the latter do not nobble any registers).
+	 */
+	*regno = (is_compat_task() ? 12 : 7);
+	saved_reg = regs->regs[*regno];
+	regs->regs[*regno] = dir;
+
+	return saved_reg;
+}
+
+static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
+{
+	unsigned long saved_reg;
+	int regno, ret;
+
+	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
+	ret = ptrace_report_syscall_entry(regs);
+	if (ret)
+		forget_syscall(regs);
+	regs->regs[regno] = saved_reg;
+
+	return ret;
+}
+
+#define arch_ptrace_report_syscall_entry arch_ptrace_report_syscall_entry
+
+static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
+							    int step)
+{
+	unsigned long saved_reg;
+	int regno;
+
+	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
+	if (!step) {
+		ptrace_report_syscall_exit(regs, 0);
+		regs->regs[regno] = saved_reg;
+	} else {
+		regs->regs[regno] = saved_reg;
+
+		/*
+		 * Signal a pseudo-step exception since we are stepping but
+		 * tracer modifications to the registers may have rewound the
+		 * state machine.
+		 */
+		ptrace_report_syscall_exit(regs, 1);
+	}
+}
+
+#define arch_ptrace_report_syscall_exit arch_ptrace_report_syscall_exit
+
 #endif /* _ASM_ARM64_ENTRY_COMMON_H */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index dea392c081ca..240d45735cc5 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -9,6 +9,9 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 
+#include <asm/compat.h>
+#include <asm/vdso.h>
+
 typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
 extern const syscall_fn_t sys_call_table[];
@@ -120,7 +123,19 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-int syscall_trace_enter(struct pt_regs *regs, unsigned long flags);
-void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	unsigned long sigtramp;
+
+#ifdef CONFIG_COMPAT
+	if (is_compat_task()) {
+		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
+
+		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
+	}
+#endif
+	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
+	return regs->pc == (sigtramp + 8);
+}
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 4ae83cb620bb..f89a15dc6ad5 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -43,6 +43,7 @@ struct thread_info {
 	void			*scs_sp;
 #endif
 	u32			cpu;
+	unsigned long		syscall_work;   /* SYSCALL_WORK_ flags */
 };
 
 #define thread_saved_pc(tsk)	\
@@ -65,11 +66,6 @@ void arch_setup_new_exec(void);
 #define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
 #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
-#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
-#define TIF_SECCOMP		11	/* syscall secure computing */
-#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
@@ -91,27 +87,14 @@ void arch_setup_new_exec(void);
 #define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
 
-#define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_SYSCALL_EMU)
-
-#define _TIF_SYSCALL_EXIT_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SYSCALL_TRACEPOINT)
-
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 29307642f4c9..e67643a70405 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -385,11 +385,18 @@ void user_enable_single_step(struct task_struct *task)
 
 	if (!test_and_set_ti_thread_flag(ti, TIF_SINGLESTEP))
 		set_regs_spsr_ss(task_pt_regs(task));
+
+	/*
+	 * Ensure that a trap is triggered once stepping out of a system
+	 * call prior to executing any user instruction.
+	 */
+	set_task_syscall_work(task, SYSCALL_EXIT_TRAP);
 }
 NOKPROBE_SYMBOL(user_enable_single_step);
 
 void user_disable_single_step(struct task_struct *task)
 {
 	clear_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
+	clear_task_syscall_work(task, SYSCALL_EXIT_TRAP);
 }
 NOKPROBE_SYMBOL(user_disable_single_step);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 3625797e9ee8..b7ac88bb946c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -64,6 +64,12 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
  * instrumentable code, or any code which may trigger an exception.
  */
 static __always_inline void arm64_enter_from_user_mode(struct pt_regs *regs)
+{
+	irqentry_enter_from_user_mode(regs);
+	mte_disable_tco_entry(current);
+}
+
+static __always_inline void arm64_syscall_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
 	mte_disable_tco_entry(current);
@@ -78,7 +84,16 @@ static __always_inline void arm64_enter_from_user_mode(struct pt_regs *regs)
 static __always_inline void arm64_exit_to_user_mode(struct pt_regs *regs)
 {
 	local_irq_disable();
-	exit_to_user_mode_prepare_legacy(regs);
+	irqentry_exit_to_user_mode_prepare(regs);
+	local_daif_mask();
+	mte_check_tfsr_exit();
+	exit_to_user_mode();
+}
+
+static __always_inline void arm64_syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	local_irq_disable();
+	syscall_exit_to_user_mode_prepare(regs);
 	local_daif_mask();
 	mte_check_tfsr_exit();
 	exit_to_user_mode();
@@ -717,12 +732,12 @@ static void noinstr el0_brk64(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_svc(struct pt_regs *regs)
 {
-	arm64_enter_from_user_mode(regs);
+	arm64_syscall_enter_from_user_mode(regs);
 	cortex_a76_erratum_1463225_svc_handler();
 	fpsimd_syscall_enter();
 	local_daif_restore(DAIF_PROCCTX);
 	do_el0_svc(regs);
-	arm64_exit_to_user_mode(regs);
+	arm64_syscall_exit_to_user_mode(regs);
 	fpsimd_syscall_exit();
 }
 
@@ -869,11 +884,11 @@ static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_svc_compat(struct pt_regs *regs)
 {
-	arm64_enter_from_user_mode(regs);
+	arm64_syscall_enter_from_user_mode(regs);
 	cortex_a76_erratum_1463225_svc_handler();
 	local_daif_restore(DAIF_PROCCTX);
 	do_el0_svc_compat(regs);
-	arm64_exit_to_user_mode(regs);
+	arm64_syscall_exit_to_user_mode(regs);
 }
 
 static void noinstr el0_bkpt32(struct pt_regs *regs, unsigned long esr)
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 766de3584cff..9acc314bc376 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
-#include <linux/audit.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -18,7 +17,6 @@
 #include <linux/smp.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
-#include <linux/seccomp.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/signal.h>
@@ -28,7 +26,6 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
-#include <linux/rseq.h>
 
 #include <asm/compat.h>
 #include <asm/cpufeature.h>
@@ -38,13 +35,9 @@
 #include <asm/mte.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
-#include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -2339,153 +2332,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ptrace_request(child, request, addr, data);
 }
 
-enum ptrace_syscall_dir {
-	PTRACE_SYSCALL_ENTER = 0,
-	PTRACE_SYSCALL_EXIT,
-};
-
-static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
-						     enum ptrace_syscall_dir dir,
-						     int *regno)
-{
-	unsigned long saved_reg;
-
-	/*
-	 * We have some ABI weirdness here in the way that we handle syscall
-	 * exit stops because we indicate whether or not the stop has been
-	 * signalled from syscall entry or syscall exit by clobbering a general
-	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
-	 * and restoring its old value after the stop. This means that:
-	 *
-	 * - Any writes by the tracer to this register during the stop are
-	 *   ignored/discarded.
-	 *
-	 * - The actual value of the register is not available during the stop,
-	 *   so the tracer cannot save it and restore it later.
-	 *
-	 * - Syscall stops behave differently to seccomp and pseudo-step traps
-	 *   (the latter do not nobble any registers).
-	 */
-	*regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[*regno];
-	regs->regs[*regno] = dir;
-
-	return saved_reg;
-}
-
-static int report_syscall_entry(struct pt_regs *regs)
-{
-	unsigned long saved_reg;
-	int regno, ret;
-
-	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
-	ret = ptrace_report_syscall_entry(regs);
-	if (ret)
-		forget_syscall(regs);
-	regs->regs[regno] = saved_reg;
-
-	return ret;
-}
-
-static void report_syscall_exit(struct pt_regs *regs)
-{
-	unsigned long saved_reg;
-	int regno;
-
-	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
-	if (!test_thread_flag(TIF_SINGLESTEP)) {
-		ptrace_report_syscall_exit(regs, 0);
-		regs->regs[regno] = saved_reg;
-	} else {
-		regs->regs[regno] = saved_reg;
-
-		/*
-		 * Signal a pseudo-step exception since we are stepping but
-		 * tracer modifications to the registers may have rewound the
-		 * state machine.
-		 */
-		ptrace_report_syscall_exit(regs, 1);
-	}
-}
-
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
-
-int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
-{
-	long syscall;
-	int ret;
-
-	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		ret = report_syscall_entry(regs);
-		if (ret || (flags & _TIF_SYSCALL_EMU))
-			return NO_SYSCALL;
-	}
-
-	/* Do the secure computing after ptrace; failures should be fast. */
-	if (flags & _TIF_SECCOMP) {
-		ret = __secure_computing();
-		if (ret == -1)
-			return NO_SYSCALL;
-	}
-
-	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
-
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
-		trace_sys_enter(regs, syscall);
-
-		/*
-		 * Probes or BPF hooks in the tracepoint may have changed the
-		 * system call number as well.
-		 */
-		 syscall = syscall_get_nr(current, regs);
-	}
-
-	syscall_enter_audit(regs, syscall);
-
-	return ret ? : syscall;
-}
-
-static inline bool report_single_step(unsigned long flags)
-{
-	if (flags & _TIF_SYSCALL_EMU)
-		return false;
-
-	return flags & _TIF_SINGLESTEP;
-}
-
-static void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
-{
-	bool step;
-
-	audit_syscall_exit(regs);
-
-	if (flags & _TIF_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	step = report_single_step(flags);
-	if (step || flags & _TIF_SYSCALL_TRACE)
-		report_syscall_exit(regs);
-}
-
-void syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	unsigned long flags = read_thread_flags();
-
-	rseq_syscall(regs);
-
-	if (unlikely(flags & _TIF_SYSCALL_EXIT_WORK) || flags & _TIF_SINGLESTEP)
-		syscall_exit_work(regs, flags);
-}
-
 /*
  * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487D.a.
  * We permit userspace to set SSBS (AArch64 bit 12, AArch32 bit 23) which is
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 08ffc5a5aea4..7ca30ee41e7a 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -8,8 +8,8 @@
 
 #include <linux/cache.h>
 #include <linux/compat.h>
+#include <linux/entry-common.h>
 #include <linux/errno.h>
-#include <linux/irq-entry-common.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/freezer.h>
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index ec478fc37a9f..77d00a5cf0e9 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -2,6 +2,7 @@
 
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
@@ -68,6 +69,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long flags = read_thread_flags();
 
 	regs->orig_x0 = regs->regs[0];
@@ -101,7 +103,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		return;
 	}
 
-	if (unlikely(flags & _TIF_SYSCALL_WORK)) {
+	if (unlikely(work & SYSCALL_WORK_ENTER)) {
 		/*
 		 * The de-facto standard way to skip a system call using ptrace
 		 * is to set the system call to -1 (NO_SYSCALL) and set x0 to a
@@ -119,7 +121,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 */
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
-		scno = syscall_trace_enter(regs, flags);
+		scno = syscall_trace_enter(regs, work);
 		if (scno == NO_SYSCALL)
 			goto trace_exit;
 	}
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index d26d1b1bcbfb..6519b4a30dc1 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -236,14 +236,6 @@ static __always_inline void __exit_to_user_mode_validate(void)
 	lockdep_sys_exit();
 }
 
-/* Temporary workaround to keep ARM64 alive */
-static __always_inline void exit_to_user_mode_prepare_legacy(struct pt_regs *regs)
-{
-	__exit_to_user_mode_prepare(regs);
-	rseq_exit_to_user_mode_legacy();
-	__exit_to_user_mode_validate();
-}
-
 /**
  * syscall_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index c6831c93cd6e..e9c4108ac514 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -743,24 +743,6 @@ static __always_inline void rseq_irqentry_exit_to_user_mode(void)
 	ev->events = 0;
 }
 
-/* Required to keep ARM64 working */
-static __always_inline void rseq_exit_to_user_mode_legacy(void)
-{
-	struct rseq_event *ev = &current->rseq.event;
-
-	rseq_stat_inc(rseq_stats.exit);
-
-	if (static_branch_unlikely(&rseq_debug_enabled))
-		WARN_ON_ONCE(ev->sched_switch);
-
-	/*
-	 * Ensure that event (especially user_irq) is cleared when the
-	 * interrupt did not result in a schedule and therefore the
-	 * rseq processing did not clear it.
-	 */
-	ev->events = 0;
-}
-
 void __rseq_debug_syscall_return(struct pt_regs *regs);
 
 static __always_inline void rseq_debug_syscall_return(struct pt_regs *regs)
-- 
2.34.1

