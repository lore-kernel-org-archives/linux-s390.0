Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <20200623083721.512673481@infradead.org>
Date: Tue, 23 Jun 2020 10:36:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to per-cpu variables
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

Currently all IRQ-tracking state is in task_struct, this means that
task_struct needs to be defined before we use it.

Especially for lockdep_assert_irq*() this can lead to header-hell.

Move the hardirq state into per-cpu variables to avoid the task_struct
dependency.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irqflags.h |   19 ++++++++++++-------
 include/linux/lockdep.h  |   34 ++++++++++++++++++----------------
 include/linux/sched.h    |    2 --
 kernel/fork.c            |    4 +---
 kernel/locking/lockdep.c |   30 +++++++++++++++---------------
 kernel/softirq.c         |    6 ++++++
 6 files changed, 52 insertions(+), 43 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -14,6 +14,7 @@
 
 #include <linux/typecheck.h>
 #include <asm/irqflags.h>
+#include <asm/percpu.h>
 
 /* Currently lockdep_softirqs_on/off is used only by lockdep */
 #ifdef CONFIG_PROVE_LOCKING
@@ -31,18 +32,22 @@
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+
+DECLARE_PER_CPU(int, hardirqs_enabled);
+DECLARE_PER_CPU(int, hardirq_context);
+
   extern void trace_hardirqs_on_prepare(void);
   extern void trace_hardirqs_off_finish(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define lockdep_hardirq_context(p)	((p)->hardirq_context)
+# define lockdep_hardirq_context(p)	(this_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
-# define lockdep_hardirqs_enabled(p)	((p)->hardirqs_enabled)
+# define lockdep_hardirqs_enabled(p)	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
-# define lockdep_hardirq_enter()		\
-do {						\
-	if (!current->hardirq_context++)	\
-		current->hardirq_threaded = 0;	\
+# define lockdep_hardirq_enter()			\
+do {							\
+	if (this_cpu_inc_return(hardirq_context) == 1)	\
+		current->hardirq_threaded = 0;		\
 } while (0)
 # define lockdep_hardirq_threaded()		\
 do {						\
@@ -50,7 +55,7 @@ do {						\
 } while (0)
 # define lockdep_hardirq_exit()			\
 do {						\
-	current->hardirq_context--;		\
+	this_cpu_dec(hardirq_context);		\
 } while (0)
 # define lockdep_softirq_enter()		\
 do {						\
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -20,6 +20,7 @@ extern int lock_stat;
 #define MAX_LOCKDEP_SUBCLASSES		8UL
 
 #include <linux/types.h>
+#include <asm/percpu.h>
 
 enum lockdep_wait_type {
 	LD_WAIT_INV = 0,	/* not checked, catch all */
@@ -703,28 +704,29 @@ do {									\
 	lock_release(&(lock)->dep_map, _THIS_IP_);			\
 } while (0)
 
-#define lockdep_assert_irqs_enabled()	do {				\
-		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  !current->hardirqs_enabled,			\
-			  "IRQs not enabled as expected\n");		\
-	} while (0)
+DECLARE_PER_CPU(int, hardirqs_enabled);
+DECLARE_PER_CPU(int, hardirq_context);
 
-#define lockdep_assert_irqs_disabled()	do {				\
-		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  current->hardirqs_enabled,			\
-			  "IRQs not disabled as expected\n");		\
-	} while (0)
+#define lockdep_assert_irqs_enabled()					\
+do {									\
+	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
+} while (0)
 
-#define lockdep_assert_in_irq() do {					\
-		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  !current->hardirq_context,			\
-			  "Not in hardirq as expected\n");		\
-	} while (0)
+#define lockdep_assert_irqs_disabled()					\
+do {									\
+	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
+} while (0)
+
+#define lockdep_assert_in_irq()						\
+do {									\
+	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
+} while (0)
 
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
 # define might_lock_nested(lock, subclass) do { } while (0)
+
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
@@ -734,7 +736,7 @@ do {									\
 
 # define lockdep_assert_RT_in_threaded_ctx() do {			\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  current->hardirq_context &&			\
+			  lockdep_hardirq_context(current) &&		\
 			  !(current->hardirq_threaded || current->irq_config),	\
 			  "Not in threaded context on PREEMPT_RT as expected\n");	\
 } while (0)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -991,8 +991,6 @@ struct task_struct {
 	unsigned long			hardirq_disable_ip;
 	unsigned int			hardirq_enable_event;
 	unsigned int			hardirq_disable_event;
-	int				hardirqs_enabled;
-	int				hardirq_context;
 	u64				hardirq_chain_key;
 	unsigned long			softirq_disable_ip;
 	unsigned long			softirq_enable_ip;
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1954,8 +1954,8 @@ static __latent_entropy struct task_stru
 
 	rt_mutex_init_task(p);
 
+	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
-	DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
 	retval = -EAGAIN;
@@ -2036,7 +2036,6 @@ static __latent_entropy struct task_stru
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
-	p->hardirqs_enabled = 0;
 	p->hardirq_enable_ip = 0;
 	p->hardirq_enable_event = 0;
 	p->hardirq_disable_ip = _THIS_IP_;
@@ -2046,7 +2045,6 @@ static __latent_entropy struct task_stru
 	p->softirq_enable_event = 0;
 	p->softirq_disable_ip = 0;
 	p->softirq_disable_event = 0;
-	p->hardirq_context = 0;
 	p->softirq_context = 0;
 #endif
 
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2062,9 +2062,9 @@ print_bad_irq_dependency(struct task_str
 	pr_warn("-----------------------------------------------------\n");
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
 		curr->comm, task_pid_nr(curr),
-		curr->hardirq_context, hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
 		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
-		curr->hardirqs_enabled,
+		lockdep_hardirqs_enabled(curr),
 		curr->softirqs_enabled);
 	print_lock(next);
 
@@ -3658,7 +3658,7 @@ void lockdep_hardirqs_on_prepare(unsigne
 	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
-	if (unlikely(current->hardirqs_enabled)) {
+	if (unlikely(lockdep_hardirqs_enabled(current))) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3686,7 +3686,7 @@ void lockdep_hardirqs_on_prepare(unsigne
 	 * Can't allow enabling interrupts while in an interrupt handler,
 	 * that's general bad form and such. Recursion, limited stack etc..
 	 */
-	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
+	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context(current)))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -3724,7 +3724,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
-	if (curr->hardirqs_enabled) {
+	if (lockdep_hardirqs_enabled(curr)) {
 		/*
 		 * Neither irq nor preemption are disabled here
 		 * so this is racy by nature but losing one hit
@@ -3751,7 +3751,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 
 skip_checks:
 	/* we'll do an OFF -> ON transition: */
-	curr->hardirqs_enabled = 1;
+	this_cpu_write(hardirqs_enabled, 1);
 	curr->hardirq_enable_ip = ip;
 	curr->hardirq_enable_event = ++curr->irq_events;
 	debug_atomic_inc(hardirqs_on_events);
@@ -3783,11 +3783,11 @@ void noinstr lockdep_hardirqs_off(unsign
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->hardirqs_enabled) {
+	if (lockdep_hardirqs_enabled(curr)) {
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
-		curr->hardirqs_enabled = 0;
+		this_cpu_write(hardirqs_enabled, 0);
 		curr->hardirq_disable_ip = ip;
 		curr->hardirq_disable_event = ++curr->irq_events;
 		debug_atomic_inc(hardirqs_off_events);
@@ -3832,7 +3832,7 @@ void lockdep_softirqs_on(unsigned long i
 	 * usage bit for all held locks, if hardirqs are
 	 * enabled too:
 	 */
-	if (curr->hardirqs_enabled)
+	if (lockdep_hardirqs_enabled(curr))
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 	lockdep_recursion_finish();
 }
@@ -3881,7 +3881,7 @@ mark_usage(struct task_struct *curr, str
 	 */
 	if (!hlock->trylock) {
 		if (hlock->read) {
-			if (curr->hardirq_context)
+			if (lockdep_hardirq_context(curr))
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_HARDIRQ_READ))
 					return 0;
@@ -3890,7 +3890,7 @@ mark_usage(struct task_struct *curr, str
 						LOCK_USED_IN_SOFTIRQ_READ))
 					return 0;
 		} else {
-			if (curr->hardirq_context)
+			if (lockdep_hardirq_context(curr))
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
 					return 0;
 			if (curr->softirq_context)
@@ -3928,7 +3928,7 @@ mark_usage(struct task_struct *curr, str
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context(task) +
 	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
@@ -4021,7 +4021,7 @@ static inline short task_wait_context(st
 	 * Set appropriate wait type for the context; for IRQs we have to take
 	 * into account force_irqthread as that is implied by PREEMPT_RT.
 	 */
-	if (curr->hardirq_context) {
+	if (lockdep_hardirq_context(curr)) {
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
@@ -4864,11 +4864,11 @@ static void check_flags(unsigned long fl
 		return;
 
 	if (irqs_disabled_flags(flags)) {
-		if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)) {
+		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled(current))) {
 			printk("possible reason: unannotated irqs-off.\n");
 		}
 	} else {
-		if (DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)) {
+		if (DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled(current))) {
 			printk("possible reason: unannotated irqs-on.\n");
 		}
 	}
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -107,6 +107,12 @@ static bool ksoftirqd_running(unsigned l
  * where hardirqs are disabled legitimately:
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
+
+DEFINE_PER_CPU(int, hardirqs_enabled);
+DEFINE_PER_CPU(int, hardirq_context);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
+
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
