Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC5431480;
	Tue,  7 Jul 2026 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451211; cv=none; b=JiFpR7tIVieAGy+updm3bIfeNJb75y+BHMDNx6mOv834OiDLDyOlcKf2IcB+a5Ncp6VWBP+p5ImMZQWAPUg8W1drbFgwvat7iLYR40o6AW5CsBvvY62weG7F9iC/wd0KqkeBoe1U2beyDCGC/BrY+q3prSi55KKT/uT7TaKa3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451211; c=relaxed/simple;
	bh=hAFxAndvXMeK2dcx0frd4KaIjDCCFsErqEGszaOX1Hs=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sOggrW3RBDEp8UC+oldCc1IUo5rcuaSihzBE7Gt7KBAdWPqpGL+iQPLNEzz3SA9Gd/DkXMMMEcDz+McZ82+H+dYWRTft4Udf/41A1IhsXdkSGavm46q+IrkrUsn98fCB4cZALeHdhCqDq9WCl2PU4RXoTmgkT4ZVrnsTLl50nW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfCulhdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfCulhdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3528B1F00A3D;
	Tue,  7 Jul 2026 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451203;
	bh=6D2Pxi8RSEBoRyNcuCQ2JVdJhDpShBhPy9SF31OJvno=;
	h=Date:From:To:Cc:Subject:References;
	b=LfCulhdW6T4roZlEA3eAclXSc2KWewR9sFqXW8Kh6fvurkaa7ggG/IN1nxxFO+ZAu
	 voNbob+Yo2RJ4bzWvhQYgN+u4o8/cCZQCxEoSXp0cnNVsgas5pbO0yliak2IhEcktF
	 3d3dAxVFAej+i7VrMo2tMfSH41Rxgxf5P1B56eQG8bx7mMfw9ecPCNz4pL5DTOau0/
	 RkrpuQjCUf2jKeAzX/e9AVSfPTO2KDJ1oGTNTqoCrgq4nCr5/BPDi4JK89qOaN6iMH
	 hejTCd24fZ0iobb0x49ZRkRekr9uuFdb6wKGC+7NrpTi3WqwBYYRYd8W8OwKZzBjOn
	 kBw8uo5/6yVOg==
Date: Tue, 07 Jul 2026 21:06:40 +0200
Message-ID: <20260707190254.230735780@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Kees Cook <kees@kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
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
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 11/18] seccomp,
 treewide: Rename and convert __secure_computing() to return boolean
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jinjie Ruan <ruanjinjie@huawei.com>

The return value of __secure_computing() currently uses 0 to indicate
that a system call should be allowed, and -1 to indicate that it should
be blocked/killed. This 0/-1 pattern is non-intuitive for a security
check function and makes the control flow at the call sites less readable.

Furthermore, any potential future changes to these return values would
require a high-risk, error-prone audit of all its users across different
architectures.

Sanitize this logic by converting the return type of __secure_computing()
to a proper boolean, where 'true' explicitly means 'allow' and 'false'
means 'fail/deny'.

Update all the two dozen or so call sites across the tree to align with
this new boolean semantic. No functional changes are intended, as the
callers still return -1 to the lower-level assembly entry code upon
seccomp denial.

Rename the function to __seccomp_permit_syscall() so that the purpose is
entirely clear.

[ tglx: Rename the function ]

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Richard Weinberger <richard@nod.at>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-csky@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-um@lists.infradead.org
---
 arch/alpha/kernel/ptrace.c            |    2 -
 arch/arm/kernel/ptrace.c              |    2 -
 arch/arm64/kernel/ptrace.c            |    2 -
 arch/csky/kernel/ptrace.c             |    2 -
 arch/m68k/kernel/ptrace.c             |    2 -
 arch/mips/kernel/ptrace.c             |    2 -
 arch/parisc/kernel/ptrace.c           |    2 -
 arch/sh/kernel/ptrace_32.c            |    2 -
 arch/um/kernel/skas/syscall.c         |    2 -
 arch/x86/entry/vsyscall/vsyscall_64.c |   14 ++++++-------
 arch/xtensa/kernel/ptrace.c           |    3 --
 include/linux/entry-common.h          |    9 +++-----
 include/linux/seccomp.h               |   12 +++++------
 kernel/seccomp.c                      |   35 +++++++++++++++++-----------------
 14 files changed, 45 insertions(+), 46 deletions(-)
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -387,7 +387,7 @@ asmlinkage unsigned long syscall_trace_e
 	 * If this fails, seccomp may already have set up the return value
 	 * (e.g. SECCOMP_RET_ERRNO / TRACE).
 	 */
-	if (secure_computing() == -1) {
+	if (!seccomp_permit_syscall()) {
 		if (regs->r19 == 0 && regs->r0 == (unsigned long)-1)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
 		syscall_set_nr(current, regs, -1);
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -855,7 +855,7 @@ asmlinkage int syscall_trace_enter(struc
 
 	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-	if (secure_computing() == -1)
+	if (!seccomp_permit_syscall())
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2420,7 +2420,7 @@ int syscall_trace_enter(struct pt_regs *
 	}
 
 	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
+	if (!seccomp_permit_syscall())
 		return NO_SYSCALL;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -323,7 +323,7 @@ asmlinkage int syscall_trace_enter(struc
 		if (ptrace_report_syscall_entry(regs))
 			return -1;
 
-	if (secure_computing() == -1)
+	if (!seccomp_permit_syscall())
 		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -281,7 +281,7 @@ asmlinkage int syscall_trace_enter(void)
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ret = ptrace_report_syscall_entry(task_pt_regs(current));
 
-	if (secure_computing() == -1)
+	if (!seccomp_permit_syscall())
 		return -1;
 
 	return ret;
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1328,7 +1328,7 @@ asmlinkage long syscall_trace_enter(stru
 			return -1;
 	}
 
-	if (secure_computing())
+	if (!seccomp_permit_syscall())
 		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -351,7 +351,7 @@ long do_syscall_trace_enter(struct pt_re
 	}
 
 	/* Do the secure computing check after ptrace. */
-	if (secure_computing() == -1)
+	if (!seccomp_permit_syscall())
 		return -1;
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -460,7 +460,7 @@ asmlinkage long do_syscall_trace_enter(s
 		return -1;
 	}
 
-	if (secure_computing() == -1)
+	if (!seccomp_permit_syscall())
 		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -27,7 +27,7 @@ void handle_syscall(struct uml_pt_regs *
 		goto out;
 
 	/* Do the seccomp check after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
+	if (!seccomp_permit_syscall())
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -118,10 +118,10 @@ static bool write_ok_or_segv(unsigned lo
 
 static bool __emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 {
-	unsigned long caller;
-	int vsyscall_nr, syscall_nr, tmp;
+	unsigned long caller, orig_dx;
+	int vsyscall_nr, syscall_nr;
+	bool skip;
 	long ret;
-	unsigned long orig_dx;
 
 	/* Confirm that the fault happened in 64-bit user mode */
 	if (!user_64bit_mode(regs))
@@ -197,16 +197,16 @@ static bool __emulate_vsyscall(struct pt
 	 */
 	regs->orig_ax = syscall_nr;
 	regs->ax = -ENOSYS;
-	tmp = secure_computing();
-	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
+	skip = !seccomp_permit_syscall();
+	if ((!skip && regs->orig_ax != syscall_nr) || regs->ip != address) {
 		warn_bad_vsyscall(KERN_DEBUG, regs,
 				  "seccomp tried to change syscall nr or ip");
 		force_exit_sig(SIGSYS);
 		return true;
 	}
 	regs->orig_ax = -1;
-	if (tmp)
-		goto do_ret;  /* skip requested */
+	if (skip)
+		goto do_ret;
 
 	/*
 	 * With a real vsyscall, page faults cause SIGSEGV.
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -553,8 +553,7 @@ int do_syscall_trace_enter(struct pt_reg
 		return 0;
 	}
 
-	if (regs->syscall == NO_SYSCALL ||
-	    secure_computing() == -1) {
+	if (regs->syscall == NO_SYSCALL || !seccomp_permit_syscall()) {
 		do_syscall_trace_leave(regs);
 		return 0;
 	}
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -102,9 +102,8 @@ static __always_inline long syscall_trac
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
 	if (work & SYSCALL_WORK_SECCOMP) {
-		ret = __secure_computing();
-		if (ret == -1L)
-			return ret;
+		if (!__seccomp_permit_syscall())
+			return -1L;
 	}
 
 	/* Either of the above might have changed the syscall number */
@@ -115,7 +114,7 @@ static __always_inline long syscall_trac
 
 	syscall_enter_audit(regs, syscall);
 
-	return ret ? : syscall;
+	return syscall;
 }
 
 /**
@@ -138,7 +137,7 @@ static __always_inline long syscall_trac
  * It handles the following work items:
  *
  *  1) syscall_work flag dependent invocations of
- *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
+ *     ptrace_report_syscall_entry(), __seccomp_permit_syscall(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
 static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -22,14 +22,14 @@
 #include <linux/atomic.h>
 #include <asm/seccomp.h>
 
-extern int __secure_computing(void);
+extern bool __seccomp_permit_syscall(void);
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-static inline int secure_computing(void)
+static __always_inline bool seccomp_permit_syscall(void)
 {
 	if (unlikely(test_syscall_work(SECCOMP)))
-		return  __secure_computing();
-	return 0;
+		return  __seccomp_permit_syscall();
+	return true;
 }
 #else
 extern void secure_computing_strict(int this_syscall);
@@ -50,11 +50,11 @@ static inline int seccomp_mode(struct se
 struct seccomp_data;
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-static inline int secure_computing(void) { return 0; }
+static inline bool seccomp_permit_syscall(void) { return true; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
-static inline int __secure_computing(void) { return 0; }
+static inline bool __seccomp_permit_syscall(void) { return true; }
 
 static inline long prctl_get_seccomp(void)
 {
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1100,12 +1100,13 @@ void secure_computing_strict(int this_sy
 	else
 		BUG();
 }
-int __secure_computing(void)
+
+bool __seccomp_permit_syscall(void)
 {
 	int this_syscall = syscall_get_nr(current, current_pt_regs());
 
 	secure_computing_strict(this_syscall);
-	return 0;
+	return true;
 }
 #else
 
@@ -1256,7 +1257,7 @@ static int seccomp_do_user_notification(
 	return -1;
 }
 
-static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
+static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
 	struct seccomp_data sd;
@@ -1294,7 +1295,7 @@ static int __seccomp_filter(int this_sys
 	case SECCOMP_RET_TRACE:
 		/* We've been put in this state by the ptracer already. */
 		if (recheck_after_trace)
-			return 0;
+			return true;
 
 		/* ENOSYS these calls if there is no tracer attached. */
 		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
@@ -1330,19 +1331,19 @@ static int __seccomp_filter(int this_sys
 		 * a skip would have already been reported.
 		 */
 		if (__seccomp_filter(this_syscall, true))
-			return -1;
+			return false;
 
-		return 0;
+		return true;
 
 	case SECCOMP_RET_USER_NOTIF:
 		if (seccomp_do_user_notification(this_syscall, match, &sd))
 			goto skip;
 
-		return 0;
+		return true;
 
 	case SECCOMP_RET_LOG:
 		seccomp_log(this_syscall, 0, action, true);
-		return 0;
+		return true;
 
 	case SECCOMP_RET_ALLOW:
 		/*
@@ -1350,7 +1351,7 @@ static int __seccomp_filter(int this_sys
 		 * this action since SECCOMP_RET_ALLOW is the starting
 		 * state in seccomp_run_filters().
 		 */
-		return 0;
+		return true;
 
 	case SECCOMP_RET_KILL_THREAD:
 	case SECCOMP_RET_KILL_PROCESS:
@@ -1367,46 +1368,46 @@ static int __seccomp_filter(int this_sys
 		} else {
 			do_exit(SIGSYS);
 		}
-		return -1; /* skip the syscall go directly to signal handling */
+		return false; /* skip the syscall go directly to signal handling */
 	}
 
 	unreachable();
 
 skip:
 	seccomp_log(this_syscall, 0, action, match ? match->log : false);
-	return -1;
+	return false;
 }
 #else
-static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
+static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 {
 	BUG();
 
-	return -1;
+	return false;
 }
 #endif
 
-int __secure_computing(void)
+bool __seccomp_permit_syscall(void)
 {
 	int mode = current->seccomp.mode;
 	int this_syscall;
 
 	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
 	    unlikely(current->ptrace & PT_SUSPEND_SECCOMP))
-		return 0;
+		return true;
 
 	this_syscall = syscall_get_nr(current, current_pt_regs());
 
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
-		return 0;
+		return true;
 	case SECCOMP_MODE_FILTER:
 		return __seccomp_filter(this_syscall, false);
 	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
 	case SECCOMP_MODE_DEAD:
 		WARN_ON_ONCE(1);
 		do_exit(SIGKILL);
-		return -1;
+		return false;
 	default:
 		BUG();
 	}

