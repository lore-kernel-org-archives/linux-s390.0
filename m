Return-Path: <linux-kernel-owner+w=401wt.eu-S1756383AbYGAMvZ@vger.kernel.org>
Message-Id: <20080701124959.977414193@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/14] idle: remove idle notifier chain.
Content-Disposition: inline; filename=129-idle-notifier.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The idle notifier chain consists of at most one element. So there's
no point in having a notifier chain. Remove it and directly call the
function.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c   |   32 ++------------------------------
 arch/s390/kernel/vtime.c     |   25 ++-----------------------
 include/asm-s390/processor.h |   10 ----------
 include/asm-s390/timer.h     |   12 ++++++++++++
 4 files changed, 16 insertions(+), 63 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -75,46 +75,19 @@ unsigned long thread_saved_pc(struct tas
 	return sf->gprs[8];
 }
 
-/*
- * Need to know about CPUs going idle?
- */
-static ATOMIC_NOTIFIER_HEAD(idle_chain);
 DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 
-int register_idle_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&idle_chain, nb);
-}
-EXPORT_SYMBOL(register_idle_notifier);
-
-int unregister_idle_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_unregister(&idle_chain, nb);
-}
-EXPORT_SYMBOL(unregister_idle_notifier);
-
 static int s390_idle_enter(void)
 {
 	struct s390_idle_data *idle;
-	int nr_calls = 0;
-	void *hcpu;
-	int rc;
 
-	hcpu = (void *)(long)smp_processor_id();
-	rc = __atomic_notifier_call_chain(&idle_chain, S390_CPU_IDLE, hcpu, -1,
-					  &nr_calls);
-	if (rc == NOTIFY_BAD) {
-		nr_calls--;
-		__atomic_notifier_call_chain(&idle_chain, S390_CPU_NOT_IDLE,
-					     hcpu, nr_calls, NULL);
-		return rc;
-	}
 	idle = &__get_cpu_var(s390_idle);
 	spin_lock(&idle->lock);
 	idle->idle_count++;
 	idle->in_idle = 1;
 	idle->idle_enter = get_clock();
 	spin_unlock(&idle->lock);
+	vtime_stop_cpu_timer();
 	return NOTIFY_OK;
 }
 
@@ -122,13 +95,12 @@ void s390_idle_leave(void)
 {
 	struct s390_idle_data *idle;
 
+	vtime_start_cpu_timer();
 	idle = &__get_cpu_var(s390_idle);
 	spin_lock(&idle->lock);
 	idle->idle_time += get_clock() - idle->idle_enter;
 	idle->in_idle = 0;
 	spin_unlock(&idle->lock);
-	atomic_notifier_call_chain(&idle_chain, S390_CPU_NOT_IDLE,
-				   (void *)(long) smp_processor_id());
 }
 
 extern void s390_handle_mcck(void);
Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -136,7 +136,7 @@ static inline void set_vtimer(__u64 expi
 }
 #endif
 
-static void start_cpu_timer(void)
+void vtime_start_cpu_timer(void)
 {
 	struct vtimer_queue *vt_list;
 
@@ -150,7 +150,7 @@ static void start_cpu_timer(void)
 		set_vtimer(vt_list->idle);
 }
 
-static void stop_cpu_timer(void)
+void vtime_stop_cpu_timer(void)
 {
 	struct vtimer_queue *vt_list;
 
@@ -536,24 +536,6 @@ void init_cpu_vtimer(void)
 
 }
 
-static int vtimer_idle_notify(struct notifier_block *self,
-			      unsigned long action, void *hcpu)
-{
-	switch (action) {
-	case S390_CPU_IDLE:
-		stop_cpu_timer();
-		break;
-	case S390_CPU_NOT_IDLE:
-		start_cpu_timer();
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block vtimer_idle_nb = {
-	.notifier_call = vtimer_idle_notify,
-};
-
 void __init vtime_init(void)
 {
 	/* request the cpu timer external interrupt */
@@ -561,9 +543,6 @@ void __init vtime_init(void)
 					      &ext_int_info_timer) != 0)
 		panic("Couldn't request external interrupt 0x1005");
 
-	if (register_idle_notifier(&vtimer_idle_nb))
-		panic("Couldn't register idle notifier");
-
 	/* Enable cpu timer interrupts on the boot cpu. */
 	init_cpu_vtimer();
 }
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -336,16 +336,6 @@ extern void (*s390_base_mcck_handler_fn)
 extern void (*s390_base_pgm_handler_fn)(void);
 extern void (*s390_base_ext_handler_fn)(void);
 
-/*
- * CPU idle notifier chain.
- */
-#define S390_CPU_IDLE		0
-#define S390_CPU_NOT_IDLE	1
-
-struct notifier_block;
-int register_idle_notifier(struct notifier_block *nb);
-int unregister_idle_notifier(struct notifier_block *nb);
-
 #define ARCH_LOW_ADDRESS_LIMIT	0x7fffffffUL
 
 #endif
Index: quilt-2.6/include/asm-s390/timer.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/timer.h
+++ quilt-2.6/include/asm-s390/timer.h
@@ -48,6 +48,18 @@ extern int del_virt_timer(struct vtimer_
 extern void init_cpu_vtimer(void);
 extern void vtime_init(void);
 
+#ifdef CONFIG_VIRT_TIMER
+
+extern void vtime_start_cpu_timer(void);
+extern void vtime_stop_cpu_timer(void);
+
+#else
+
+static inline void vtime_start_cpu_timer(void) { }
+static inline void vtime_stop_cpu_timer(void) { }
+
+#endif /* CONFIG_VIRT_TIMER */
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_S390_TIMER_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
