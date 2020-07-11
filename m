Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 11 Jul 2020 10:09:56 -0000
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: locking/core] x86/entry: Fix NMI vs IRQ state tracking
In-Reply-To: <20200623083721.216740948@infradead.org>
References: <20200623083721.216740948@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219664.4006.7079542709989198544.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ba1f2b2eaa2a529dba722507c55ff3d761d325dd
Gitweb:        https://git.kernel.org/tip/ba1f2b2eaa2a529dba722507c55ff3d761d325dd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 27 May 2020 15:50:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:01 +02:00

x86/entry: Fix NMI vs IRQ state tracking

While the nmi_enter() users did
trace_hardirqs_{off_prepare,on_finish}() there was no matching
lockdep_hardirqs_*() calls to complete the picture.

Introduce idtentry_{enter,exit}_nmi() to enable proper IRQ state
tracking across the NMIs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
---
 arch/x86/entry/common.c         | 42 ++++++++++++++++++++++++++++----
 arch/x86/include/asm/idtentry.h |  3 ++-
 arch/x86/kernel/nmi.c           |  9 +++----
 arch/x86/kernel/traps.c         | 17 ++++---------
 include/linux/hardirq.h         | 28 ++++++++++++++-------
 5 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 0521546..63c607d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -592,7 +592,7 @@ SYSCALL_DEFINE0(ni_syscall)
  * The return value must be fed into the state argument of
  * idtentry_exit().
  */
-idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
+noinstr idtentry_state_t idtentry_enter(struct pt_regs *regs)
 {
 	idtentry_state_t ret = {
 		.exit_rcu = false,
@@ -687,7 +687,7 @@ static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
  * Counterpart to idtentry_enter(). The return value of the entry
  * function must be fed into the @state argument.
  */
-void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
+noinstr void idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -731,7 +731,7 @@ void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
  * Invokes enter_from_user_mode() to establish the proper context for
  * NOHZ_FULL. Otherwise scheduling on exit would not be possible.
  */
-void noinstr idtentry_enter_user(struct pt_regs *regs)
+noinstr void idtentry_enter_user(struct pt_regs *regs)
 {
 	check_user_regs(regs);
 	enter_from_user_mode();
@@ -749,13 +749,47 @@ void noinstr idtentry_enter_user(struct pt_regs *regs)
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
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 7227225..2b04974 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -20,6 +20,9 @@ typedef struct idtentry_state {
 idtentry_state_t idtentry_enter(struct pt_regs *regs);
 void idtentry_exit(struct pt_regs *regs, idtentry_state_t state);
 
+bool idtentry_enter_nmi(struct pt_regs *regs);
+void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index d7c5e44..4fc9954 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -330,7 +330,6 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
@@ -417,8 +416,6 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 		unknown_nmi_error(reason, regs);
 
 out:
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
 	instrumentation_end();
 }
 
@@ -478,6 +475,8 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
+	bool irq_state;
+
 	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
 
@@ -491,14 +490,14 @@ nmi_restart:
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	nmi_enter();
+	irq_state = idtentry_enter_nmi(regs);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4627f82..cdd7382 100644
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
 
@@ -865,9 +862,8 @@ out:
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
-	nmi_enter();
+	bool irq_state = idtentry_enter_nmi(regs);
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
 
 	/*
 	 * If something gets miswired and we end up here for a user mode
@@ -884,10 +880,8 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 
 	handle_debug(regs, dr6, false);
 
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 }
 
 static __always_inline void exc_debug_user(struct pt_regs *regs,
@@ -903,6 +897,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	instrumentation_begin();
 
 	handle_debug(regs, dr6, true);
+
 	instrumentation_end();
 	idtentry_exit_user(regs);
 }
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 03c9fec..754f67a 100644
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
