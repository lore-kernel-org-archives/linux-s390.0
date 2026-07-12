Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E46376BC5;
	Sun, 12 Jul 2026 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891537; cv=none; b=N4I/qP+F9iEY7WNvG5ale+qURsqxRkLeXqDNzQjBvdeof/8OBrAnc5K9B8m3jSpPVTNyM9eZc0FEHUetzt20rsev+Ac9FDnOVwJSkjtF/6R7nug06F8XlOsjY42ZI23OGsu9EKZnsK59D+2CVh1UYNdE+9KHN9XjtV+gNKRJSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891537; c=relaxed/simple;
	bh=Asvgx0JwKVJjV3R2bafHRGMczJnqFdg3KQc8+hTMs60=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QYMxlRtJSMNzSbc9EdI3i01B44o0g6UE532AkvGxQldK+I+EUv0DrRm5I4Csp2BY5htdwgGddIvQir2+9HhgVyQVVYvFimvJKWxb8lTdalcOKxpRxZDIj/vyfTStEBjzWJNl+RxoJwd7j9bC5oEQvp3jNat3dcViaMxv4xeTsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULDEH+ZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULDEH+ZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3151F000E9;
	Sun, 12 Jul 2026 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891535;
	bh=jivMYDxXpiwA3cut01lRa4UxTZlEBG7iWpRHqtzKrVo=;
	h=Date:From:To:Cc:Subject:References;
	b=ULDEH+ZELnoOzYAgeamKbQ7TvwpfrRxh/SEaWxPjoP2LXUfXVZA2Z5lgq4Kkkb8HF
	 MEiWqScTs29ODMGgZkhCTFFbfvJijQ05Hzk8KtYWMcQU/rhc+YYvZPmnl2weGWiS7B
	 ueZoJ2Fc1WtT8gBjPyvsKG+hW67vgwLhtXyg60df/BKAZf9rNspotBIHHjP01sD2CS
	 1snRVzCxKITqJ+SS8Gks2PodDMgcoWpTvkB2qTlnxnPpagRssivRSyQ2hb31CNPKiX
	 MvEeRAfdIhntqZk81AW1QegO4k33z3e0I4gTHLVMEKFwrpPLgvn0noMxwhQ5t49SAc
	 lfwF4QijEBRGw==
Date: Sun, 12 Jul 2026 23:25:32 +0200
Message-ID: <20260712141346.772209074@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 4/4] entry,
 treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall
 execution
References: <20260712134433.549076055@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The return values of syscall_enter_from_user_mode[_work]() are
non-intuitive. Both functions return the syscall number which should be
invoked by the architecture specific syscall entry code. The returned
number can be:

  - the unmodified syscall number which was handed in by the caller

  - a modified syscall number (ptrace, seccomp, trace/probe/bpf)

That has an additional twist. If the return value is -1L then the caller is
not allowed to modify the return value as that indicates that the modifying
entity requests to abort the syscall and set the return value already. That
can obviously not be differentiated from a syscall which handed in -1 as
syscall number.

The most trivial way to deal with that is:

    set_return_value(regs, -ENOSYS);
    nr = syscall_enter_from_user_mode(regs, nr);
    if (valid(nr))
    	handle_syscall(regs, nr);

That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
preset the return value, so when user space hands in -1 and there is
nothing setting the return value in the entry work code, then the syscall
is skipped but the return value is whatever random data has been in the
return value register.

Change the return values of syscall_enter_from_user_mode[_work]() to
boolean and return false, when either ptrace or seccomp request to skip the
syscall. If they return true, update the syscall number as it might have
been changed.

That results in slightly different behaviour of the architectures versus
tracing.

If the syscall tracepoint has probe/BPF attached, those might set the
syscall number to -1 and also set the return value. PowerPC and S390 will
then overwrite that value with -ENOSYS. The other architectures will just
ignore it like any other invalid syscall and use the modified one.

Originally-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
V2: Change the return logic so Power and S390 can insist on being special.
---
 Documentation/core-api/entry.rst |   45 ++++++++++++++++++++++++++++++---------
 arch/loongarch/kernel/syscall.c  |   14 ++++++------
 arch/powerpc/kernel/syscall.c    |    3 +-
 arch/riscv/kernel/traps.c        |   11 ++++-----
 arch/s390/kernel/syscall.c       |    7 ++++--
 arch/x86/entry/syscall_32.c      |   25 ++++++++++-----------
 arch/x86/entry/syscall_64.c      |   12 +++++-----
 include/linux/entry-common.h     |   32 +++++++++++++--------------
 8 files changed, 88 insertions(+), 61 deletions(-)
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -58,26 +58,51 @@ state transitions must run with interrup
 Syscalls
 --------
 
-Syscall-entry code starts in assembly code and calls out into low-level C code
-after establishing low-level architecture-specific state and stack frames. This
-low-level C code must not be instrumented. A typical syscall handling function
-invoked from low-level assembly code looks like this:
+Syscall-entry code starts in assembly code and calls out into low-level C
+code after establishing low-level architecture-specific state and stack
+frames. This low-level C code must not be instrumented. The recommended
+syscall handling function invoked from low-level assembly code looks like
+this:
 
 .. code-block:: c
 
-  noinstr void syscall(struct pt_regs *regs, int nr)
+  noinstr void syscall(struct pt_regs *regs, long nr)
   {
 	arch_syscall_enter(regs);
-	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
+	result_reg(regs) = -ENOSYS;
+	if (syscall_enter_from_user_mode_randomize_stack(regs, &nr)) {
+		instrumentation_begin();
+		if (valid(nr)
+			result_reg(regs) = invoke_syscall(regs, nr);
+		instrumentation_end();
+	}
+	syscall_exit_to_user_mode(regs);
+  }
 
-	instrumentation_begin();
-	if (!invoke_syscall(regs, nr) && nr != -1)
-	 	result_reg(regs) = __sys_ni_syscall(regs);
-	instrumentation_end();
+This is the most resilent variant as it has always a guaranteed valid
+return code. The alternative variant is:
+
+.. code-block:: c
 
+  noinstr void syscall(struct pt_regs *regs, long nr)
+  {
+	arch_syscall_enter(regs);
+	if (syscall_enter_from_user_mode_randomize_stack(regs, &nr)) {
+		instrumentation_begin();
+		if (valid(nr)
+			result_reg(regs) = invoke_syscall(regs, nr);
+		else
+			result_reg(regs) = -ENOSYS;
+		instrumentation_end();
+	}
 	syscall_exit_to_user_mode(regs);
   }
 
+That works for most situations except when a probe/BPF attached to the
+syscall tracepoint sets an invalid syscall number e.g. -1 and also modifies
+the result register. So this variant will obviously overwrite the modified
+result with -ENOSYS.
+
 syscall_enter_from_user_mode_randomize_stack() first invokes
 enter_from_user_mode_randomize_stack() which establishes state in the
 following order:
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -57,8 +57,8 @@ typedef long (*sys_call_fn)(unsigned lon
 
 void noinstr __no_stack_protector do_syscall(struct pt_regs *regs)
 {
-	unsigned long nr;
 	sys_call_fn syscall_fn;
+	unsigned long nr;
 
 	nr = regs->regs[11];
 	/* Set for syscall restarting */
@@ -69,12 +69,12 @@ void noinstr __no_stack_protector do_sys
 	regs->orig_a0 = regs->regs[4];
 	regs->regs[4] = -ENOSYS;
 
-	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
-
-	if (nr < NR_syscalls) {
-		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
-		regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
-					   regs->regs[7], regs->regs[8], regs->regs[9]);
+	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
+		if (nr < NR_syscalls) {
+			syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
+			regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
+						   regs->regs[7], regs->regs[8], regs->regs[9]);
+		}
 	}
 
 	syscall_exit_to_user_mode(regs);
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -18,7 +18,8 @@ notrace long system_call_exception(struc
 	long ret;
 	syscall_fn f;
 
-	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
+	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
+		return syscall_get_error(current, regs);
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -332,13 +332,12 @@ void do_trap_ecall_u(struct pt_regs *reg
 
 		riscv_v_vstate_discard(regs);
 
-		syscall = syscall_enter_from_user_mode_randomize_stack(regs, syscall);
-
-		if (syscall >= 0 && syscall < NR_syscalls) {
-			syscall = array_index_nospec(syscall, NR_syscalls);
-			syscall_handler(regs, syscall);
+		if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &syscall))) {
+			if (syscall >= 0 && syscall < NR_syscalls) {
+				syscall = array_index_nospec(syscall, NR_syscalls);
+				syscall_handler(regs, syscall);
+			}
 		}
-
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -96,6 +96,7 @@ SYSCALL_DEFINE0(ni_syscall)
 void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
 {
 	unsigned long nr;
+	bool permit;
 
 	enter_from_user_mode_randomize_stack(regs);
 
@@ -121,7 +122,9 @@ void noinstr __do_syscall(struct pt_regs
 		regs->psw.addr = current->restart_block.arch_data;
 		current->restart_block.arch_data = 1;
 	}
-	nr = syscall_enter_from_user_mode_work(regs, nr);
+
+	permit = syscall_enter_from_user_mode_work(regs, &nr);
+
 	/*
 	 * In the s390 ptrace ABI, both the syscall number and the return value
 	 * use gpr2. However, userspace puts the syscall number either in the
@@ -129,7 +132,7 @@ void noinstr __do_syscall(struct pt_regs
 	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checked here
 	 * and if set, the syscall will be skipped.
 	 */
-	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
+	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET) || !permit))
 		goto out;
 	regs->gprs[2] = -ENOSYS;
 	if (likely(nr < NR_syscalls)) {
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -161,8 +161,9 @@ static __always_inline bool int80_is_ext
 	nr = syscall_32_enter(regs);
 
 	local_irq_enable();
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-	do_syscall_32_irqs_on(regs, nr);
+
+	if (likely(syscall_enter_from_user_mode_work(regs, &nr)))
+		do_syscall_32_irqs_on(regs, nr);
 
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
@@ -223,8 +224,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 	nr = syscall_32_enter(regs);
 
 	local_irq_enable();
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-	do_syscall_32_irqs_on(regs, nr);
+	if (likely(syscall_enter_from_user_mode_work(regs, &nr)))
+		do_syscall_32_irqs_on(regs, nr);
 
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
@@ -243,13 +244,13 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 	 * orig_ax, the int return value truncates it. This matches
 	 * the semantics of syscall_get_nr().
 	 */
-	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
-
-	instrumentation_begin();
+	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
+		instrumentation_begin();
 
-	do_syscall_32_irqs_on(regs, nr);
+		do_syscall_32_irqs_on(regs, nr);
 
-	instrumentation_end();
+		instrumentation_end();
+	}
 	syscall_exit_to_user_mode(regs);
 }
 #endif /* !CONFIG_IA32_EMULATION */
@@ -286,10 +287,8 @@ static noinstr bool __do_fast_syscall_32
 		return false;
 	}
 
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-
-	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs, nr);
+	if (likely(syscall_enter_from_user_mode_work(regs, &nr)))
+		do_syscall_32_irqs_on(regs, nr);
 
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -78,14 +78,14 @@ static __always_inline void do_syscall_x
 /* Returns true to return using SYSRET, or false to use IRET */
 __visible noinstr bool do_syscall_64(struct pt_regs *regs, long nr)
 {
-	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
+	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
+		instrumentation_begin();
 
-	instrumentation_begin();
+		if (!do_syscall_x64(regs, nr))
+			do_syscall_x32(regs, nr);
 
-	if (!do_syscall_x64(regs, nr))
-		do_syscall_x32(regs, nr);
-
-	instrumentation_end();
+		instrumentation_end();
+	}
 	syscall_exit_to_user_mode(regs);
 
 	/*
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -111,16 +111,15 @@ static __always_inline long syscall_trac
  * @regs:	Pointer to currents pt_regs
  * @syscall:	The syscall number
  *
- * Invoked from architecture specific syscall entry code with interrupts
- * enabled after invoking enter_from_user_mode(), enabling interrupts and
- * extra architecture specific work.
+ * Invoked from architecture specific syscall entry code with interrupts enabled
+ * after invoking enter_from_user_mode(), enabling interrupts and extra
+ * architecture specific work with the syscall return value preset to -ENOSYS.
  *
- * Returns: The original or a modified syscall number
+ * Returns: True if the syscall should be invoked, False otherwise.
  *
- * If the returned syscall number is -1 then the syscall should be
- * skipped. In this case the caller may invoke syscall_set_error() or
- * syscall_set_return_value() first.  If neither of those are called and -1
- * is returned, then the syscall will fail with ENOSYS.
+ * If the return value is false, the caller must skip the syscall and leave the
+ * syscall return value unmodified as it might have been set by one of the entry
+ * work functions.
  *
  * It handles the following work items:
  *
@@ -128,19 +127,20 @@ static __always_inline long syscall_trac
  *     ptrace_report_syscall_permit_entry(), __seccomp_permit_syscall(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
-static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+static __always_inline bool syscall_enter_from_user_mode_work(struct pt_regs *regs, long *syscall)
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
-	if (work & SYSCALL_WORK_ENTER) {
-		if (!syscall_trace_enter(regs, work, syscall))
-			return -1L;
+	if (!(work & SYSCALL_WORK_ENTER))
+		return true;
 
-		/* Reread the syscall number as it might have been modified */
-		syscall = syscall_get_nr(current, regs);
-	}
+	if (unlikely(!syscall_trace_enter(regs, work, *syscall)))
+		return false;
 
-	return syscall;
+	/* Reread the syscall number as it might have been modified */
+	*syscall = syscall_get_nr(current, regs);
+
+	return true;
 }
 
 /**

