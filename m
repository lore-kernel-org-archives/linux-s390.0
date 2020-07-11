Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 11 Jul 2020 10:09:53 -0000
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: locking/core] lockdep: Remove
 lockdep_hardirq{s_enabled,_context}() argument
In-Reply-To: <20200623083721.571835311@infradead.org>
References: <20200623083721.571835311@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219309.4006.16573680750106787417.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f9ad4a5f3f20bee022b1bdde94e5ece6dc0b0edc
Gitweb:        https://git.kernel.org/tip/f9ad4a5f3f20bee022b1bdde94e5ece6dc0b0edc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 27 May 2020 13:03:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:02 +02:00

lockdep: Remove lockdep_hardirq{s_enabled,_context}() argument

Now that the macros use per-cpu data, we no longer need the argument.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200623083721.571835311@infradead.org
---
 arch/x86/entry/common.c        |  2 +-
 include/linux/irqflags.h       |  8 ++++----
 include/linux/lockdep.h        |  2 +-
 kernel/locking/lockdep.c       | 30 +++++++++++++++---------------
 kernel/softirq.c               |  2 +-
 tools/include/linux/irqflags.h |  4 ++--
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 63c607d..4ea6403 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -758,7 +758,7 @@ noinstr void idtentry_exit_user(struct pt_regs *regs)
 
 noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
 {
-	bool irq_state = lockdep_hardirqs_enabled(current);
+	bool irq_state = lockdep_hardirqs_enabled();
 
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 255444f..5811ee8 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -40,9 +40,9 @@ DECLARE_PER_CPU(int, hardirq_context);
   extern void trace_hardirqs_off_finish(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define lockdep_hardirq_context(p)	(this_cpu_read(hardirq_context))
+# define lockdep_hardirq_context()	(this_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
-# define lockdep_hardirqs_enabled(p)	(this_cpu_read(hardirqs_enabled))
+# define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
@@ -109,9 +109,9 @@ do {						\
 # define trace_hardirqs_off_finish()		do { } while (0)
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
-# define lockdep_hardirq_context(p)	0
+# define lockdep_hardirq_context()	0
 # define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_hardirqs_enabled()	0
 # define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_threaded()	do { } while (0)
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index be6cb17..fd04b9e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -562,7 +562,7 @@ do {									\
 
 # define lockdep_assert_RT_in_threaded_ctx() do {			\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  lockdep_hardirq_context(current) &&		\
+			  lockdep_hardirq_context() &&			\
 			  !(current->hardirq_threaded || current->irq_config),	\
 			  "Not in threaded context on PREEMPT_RT as expected\n");	\
 } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ab4ffbe..c9ea05e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2062,9 +2062,9 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_warn("-----------------------------------------------------\n");
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
 		curr->comm, task_pid_nr(curr),
-		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_hardirq_context(), hardirq_count() >> HARDIRQ_SHIFT,
 		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
-		lockdep_hardirqs_enabled(curr),
+		lockdep_hardirqs_enabled(),
 		curr->softirqs_enabled);
 	print_lock(next);
 
@@ -3331,9 +3331,9 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] takes:\n",
 		curr->comm, task_pid_nr(curr),
-		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_hardirq_context(), hardirq_count() >> HARDIRQ_SHIFT,
 		lockdep_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
-		lockdep_hardirqs_enabled(curr),
+		lockdep_hardirqs_enabled(),
 		lockdep_softirqs_enabled(curr));
 	print_lock(this);
 
@@ -3658,7 +3658,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
-	if (unlikely(lockdep_hardirqs_enabled(current))) {
+	if (unlikely(lockdep_hardirqs_enabled())) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3686,7 +3686,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	 * Can't allow enabling interrupts while in an interrupt handler,
 	 * that's general bad form and such. Recursion, limited stack etc..
 	 */
-	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context(current)))
+	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context()))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -3724,7 +3724,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
-	if (lockdep_hardirqs_enabled(curr)) {
+	if (lockdep_hardirqs_enabled()) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3783,7 +3783,7 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (lockdep_hardirqs_enabled(curr)) {
+	if (lockdep_hardirqs_enabled()) {
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
@@ -3832,7 +3832,7 @@ void lockdep_softirqs_on(unsigned long ip)
 	 * usage bit for all held locks, if hardirqs are
 	 * enabled too:
 	 */
-	if (lockdep_hardirqs_enabled(curr))
+	if (lockdep_hardirqs_enabled())
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 	lockdep_recursion_finish();
 }
@@ -3881,7 +3881,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 	 */
 	if (!hlock->trylock) {
 		if (hlock->read) {
-			if (lockdep_hardirq_context(curr))
+			if (lockdep_hardirq_context())
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_HARDIRQ_READ))
 					return 0;
@@ -3890,7 +3890,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 						LOCK_USED_IN_SOFTIRQ_READ))
 					return 0;
 		} else {
-			if (lockdep_hardirq_context(curr))
+			if (lockdep_hardirq_context())
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
 					return 0;
 			if (curr->softirq_context)
@@ -3928,7 +3928,7 @@ lock_used:
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context(task) +
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context() +
 	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
@@ -4021,7 +4021,7 @@ static inline short task_wait_context(struct task_struct *curr)
 	 * Set appropriate wait type for the context; for IRQs we have to take
 	 * into account force_irqthread as that is implied by PREEMPT_RT.
 	 */
-	if (lockdep_hardirq_context(curr)) {
+	if (lockdep_hardirq_context()) {
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
@@ -4864,11 +4864,11 @@ static void check_flags(unsigned long flags)
 		return;
 
 	if (irqs_disabled_flags(flags)) {
-		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled(current))) {
+		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())) {
 			printk("possible reason: unannotated irqs-off.\n");
 		}
 	} else {
-		if (DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled(current))) {
+		if (DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())) {
 			printk("possible reason: unannotated irqs-on.\n");
 		}
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 342c53f..5e9aaa6 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -230,7 +230,7 @@ static inline bool lockdep_softirq_start(void)
 {
 	bool in_hardirq = false;
 
-	if (lockdep_hardirq_context(current)) {
+	if (lockdep_hardirq_context()) {
 		in_hardirq = true;
 		lockdep_hardirq_exit();
 	}
diff --git a/tools/include/linux/irqflags.h b/tools/include/linux/irqflags.h
index 67e01bb..501262a 100644
--- a/tools/include/linux/irqflags.h
+++ b/tools/include/linux/irqflags.h
@@ -2,9 +2,9 @@
 #ifndef _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 #define _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 
-# define lockdep_hardirq_context(p)	0
+# define lockdep_hardirq_context()	0
 # define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_hardirqs_enabled()	0
 # define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_exit()		do { } while (0)
