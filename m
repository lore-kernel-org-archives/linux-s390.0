Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbgFWIjZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 04:39:25 -0400
Message-ID: <20200623083721.216740948@infradead.org>
Date: Tue, 23 Jun 2020 10:36:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 2/8] x86/entry: Fix NMI vs IRQ state tracking
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

While the nmi_enter() users did
trace_hardirqs_{off_prepare,on_finish}() there was no matching
lockdep_hardirqs_*() calls to complete the picture.

Introduce idtentry_{enter,exit}_nmi() to enable proper IRQ state
tracking across the NMIs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c         |   42 ++++++++++++++++++++++++++++++++++++----
 arch/x86/include/asm/idtentry.h |    3 ++
 arch/x86/kernel/nmi.c           |    9 +++-----
 arch/x86/kernel/traps.c         |   17 +++++-----------
 include/linux/hardirq.h         |   28 ++++++++++++++++++--------
 5 files changed, 70 insertions(+), 29 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -550,7 +550,7 @@ SYSCALL_DEFINE0(ni_syscall)
  * The return value must be fed into the rcu_exit argument of
  * idtentry_exit_cond_rcu().
  */
-bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
+noinstr bool idtentry_enter_cond_rcu(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		enter_from_user_mode();
@@ -640,7 +640,7 @@ static void idtentry_exit_cond_resched(s
  * Counterpart to idtentry_enter_cond_rcu(). The return value of the entry
  * function must be fed into the @rcu_exit argument.
  */
-void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
+noinstr void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -684,7 +684,7 @@ void noinstr idtentry_exit_cond_rcu(stru
  * Invokes enter_from_user_mode() to establish the proper context for
  * NOHZ_FULL. Otherwise scheduling on exit would not be possible.
  */
-void noinstr idtentry_enter_user(struct pt_regs *regs)
+noinstr void idtentry_enter_user(struct pt_regs *regs)
 {
 	enter_from_user_mode();
 }
@@ -701,13 +701,47 @@ void noinstr idtentry_enter_user(struct
  *
  * Counterpart to idtentry_enter_user().
  */
-void noinstr idtentry_exit_user(struct pt_regs *regs)
+noinstr void idtentry_exit_user(struct pt_regs *regs)
 {
 	lockdep_assert_irqs_disabled();
 
 	prepare_exit_to_usermode(regs);
 }
 
+noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
+{
+	bool irq_state = lockdep_hardirqs_enabled(current);
+
+	__nmi_enter();
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirq_enter();
+	rcu_nmi_enter();
+
+	instrumentation_begin();
+	trace_hardirqs_off_finish();
+	ftrace_nmi_enter();
+	instrumentation_end();
+
+	return irq_state;
+}
+
+noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
+{
+	instrumentation_begin();
+	ftrace_nmi_exit();
+	if (restore) {
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	}
+	instrumentation_end();
+
+	rcu_nmi_exit();
+	lockdep_hardirq_exit();
+	if (restore)
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	__nmi_exit();
+}
+
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -16,6 +16,9 @@ void idtentry_exit_user(struct pt_regs *
 bool idtentry_enter_cond_rcu(struct pt_regs *regs);
 void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
 
+bool idtentry_enter_nmi(struct pt_regs *regs);
+void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -330,7 +330,6 @@ static noinstr void default_do_nmi(struc
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
@@ -417,8 +416,6 @@ static noinstr void default_do_nmi(struc
 		unknown_nmi_error(reason, regs);
 
 out:
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
 	instrumentation_end();
 }
 
@@ -478,6 +475,8 @@ static DEFINE_PER_CPU(unsigned long, nmi
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
+	bool irq_state;
+
 	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
 
@@ -491,14 +490,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	nmi_enter();
+	irq_state = idtentry_enter_nmi(regs);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -403,7 +403,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	nmi_enter();
+	idtentry_enter_nmi(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -649,15 +649,12 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		idtentry_exit_user(regs);
 	} else {
-		nmi_enter();
+		bool irq_state = idtentry_enter_nmi(regs);
 		instrumentation_begin();
-		trace_hardirqs_off_finish();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
-		if (regs->flags & X86_EFLAGS_IF)
-			trace_hardirqs_on_prepare();
 		instrumentation_end();
-		nmi_exit();
+		idtentry_exit_nmi(regs, irq_state);
 	}
 }
 
@@ -865,9 +862,8 @@ static void handle_debug(struct pt_regs
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
-	nmi_enter();
+	bool irq_state = idtentry_enter_nmi(regs);
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
 
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
@@ -878,10 +874,8 @@ static __always_inline void exc_debug_ke
 
 	handle_debug(regs, dr6, false);
 
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 }
 
 static __always_inline void exc_debug_user(struct pt_regs *regs,
@@ -891,6 +885,7 @@ static __always_inline void exc_debug_us
 	instrumentation_begin();
 
 	handle_debug(regs, dr6, true);
+
 	instrumentation_end();
 	idtentry_exit_user(regs);
 }
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -111,32 +111,42 @@ extern void rcu_nmi_exit(void);
 /*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
-#define nmi_enter()						\
+#define __nmi_enter()						\
 	do {							\
+		lockdep_off();					\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
-		lockdep_off();					\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		rcu_nmi_enter();				\
+	} while (0)
+
+#define nmi_enter()						\
+	do {							\
+		__nmi_enter();					\
 		lockdep_hardirq_enter();			\
+		rcu_nmi_enter();				\
 		instrumentation_begin();			\
 		ftrace_nmi_enter();				\
 		instrumentation_end();				\
 	} while (0)
 
+#define __nmi_exit()						\
+	do {							\
+		BUG_ON(!in_nmi());				\
+		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		printk_nmi_exit();				\
+		arch_nmi_exit();				\
+		lockdep_on();					\
+	} while (0)
+
 #define nmi_exit()						\
 	do {							\
 		instrumentation_begin();			\
 		ftrace_nmi_exit();				\
 		instrumentation_end();				\
-		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
-		BUG_ON(!in_nmi());				\
-		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		lockdep_on();					\
-		printk_nmi_exit();				\
-		arch_nmi_exit();				\
+		lockdep_hardirq_exit();				\
+		__nmi_exit();					\
 	} while (0)
 
 #endif /* LINUX_HARDIRQ_H */
