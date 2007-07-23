Return-Path: <linux-kernel-owner+w=401wt.eu-S1758381AbXGWIyP@vger.kernel.org>
Message-Id: <20070723085633.808339051@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/9] Convert to smp_call_function_single.
Content-Disposition: inline; filename=001-smp-single.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

smp_call_function_single now has the same semantics as s390's
smp_call_function_on. Therefore convert to the *single variant
and get rid of some architecture specific code.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |   12 ++++++------
 arch/s390/kernel/smp.c             |   16 +++++++---------
 arch/s390/kernel/vtime.c           |    2 +-
 include/asm-s390/smp.h             |   11 +----------
 net/iucv/iucv.c                    |   15 ++++++++-------
 5 files changed, 23 insertions(+), 33 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -173,7 +173,7 @@ int appldata_diag(char record_nr, u16 fu
 /*
  * appldata_mod_vtimer_wrap()
  *
- * wrapper function for mod_virt_timer(), because smp_call_function_on()
+ * wrapper function for mod_virt_timer(), because smp_call_function_single()
  * accepts only one parameter.
  */
 static void __appldata_mod_vtimer_wrap(void *p) {
@@ -208,9 +208,9 @@ __appldata_vtimer_setup(int cmd)
 					  num_online_cpus()) * TOD_MICRO;
 		for_each_online_cpu(i) {
 			per_cpu(appldata_timer, i).expires = per_cpu_interval;
-			smp_call_function_on(add_virt_timer_periodic,
-					     &per_cpu(appldata_timer, i),
-					     0, 1, i);
+			smp_call_function_single(i, add_virt_timer_periodic,
+						 &per_cpu(appldata_timer, i),
+						 0, 1);
 		}
 		appldata_timer_active = 1;
 		P_INFO("Monitoring timer started.\n");
@@ -236,8 +236,8 @@ __appldata_vtimer_setup(int cmd)
 			} args;
 			args.timer = &per_cpu(appldata_timer, i);
 			args.expires = per_cpu_interval;
-			smp_call_function_on(__appldata_mod_vtimer_wrap,
-					     &args, 0, 1, i);
+			smp_call_function_single(i, __appldata_mod_vtimer_wrap,
+						 &args, 0, 1);
 		}
 	}
 }
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -170,30 +170,28 @@ int smp_call_function(void (*func) (void
 EXPORT_SYMBOL(smp_call_function);
 
 /*
- * smp_call_function_on:
+ * smp_call_function_single:
+ * @cpu: the CPU where func should run
  * @func: the function to run; this must be fast and non-blocking
  * @info: an arbitrary pointer to pass to the function
  * @nonatomic: unused
  * @wait: if true, wait (atomically) until function has completed on other CPUs
- * @cpu: the CPU where func should run
  *
  * Run a function on one processor.
  *
  * You must not call this function with disabled interrupts, from a
  * hardware interrupt handler or from a bottom half.
  */
-int smp_call_function_on(void (*func) (void *info), void *info, int nonatomic,
-			 int wait, int cpu)
+int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
+			     int nonatomic, int wait)
 {
-	cpumask_t map = CPU_MASK_NONE;
-
 	preempt_disable();
-	cpu_set(cpu, map);
-	__smp_call_function_map(func, info, nonatomic, wait, map);
+	__smp_call_function_map(func, info, nonatomic, wait,
+				cpumask_of_cpu(cpu));
 	preempt_enable();
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_on);
+EXPORT_SYMBOL(smp_call_function_single);
 
 static void do_send_stop(void)
 {
Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -415,7 +415,7 @@ EXPORT_SYMBOL(add_virt_timer_periodic);
 
 /*
  * If we change a pending timer the function must be called on the CPU
- * where the timer is running on, e.g. by smp_call_function_on()
+ * where the timer is running on, e.g. by smp_call_function_single()
  *
  * The original mod_timer adds the timer if it is not pending. For compatibility
  * we do the same. The timer will be added on the current CPU as a oneshot timer.
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h
+++ quilt-2.6/include/asm-s390/smp.h
@@ -36,8 +36,7 @@ extern void machine_halt_smp(void);
 extern void machine_power_off_smp(void);
 
 extern void smp_setup_cpu_possible_map(void);
-extern int smp_call_function_on(void (*func) (void *info), void *info,
-				int nonatomic, int wait, int cpu);
+
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
 /*
@@ -96,14 +95,6 @@ extern int __cpu_up (unsigned int cpu);
 #endif
 
 #ifndef CONFIG_SMP
-static inline int
-smp_call_function_on(void (*func) (void *info), void *info,
-		     int nonatomic, int wait, int cpu)
-{
-	func(info);
-	return 0;
-}
-
 static inline void smp_send_stop(void)
 {
 	/* Disable all interrupts/machine checks */
Index: quilt-2.6/net/iucv/iucv.c
===================================================================
--- quilt-2.6.orig/net/iucv/iucv.c
+++ quilt-2.6/net/iucv/iucv.c
@@ -479,7 +479,8 @@ static void iucv_setmask_mp(void)
 		/* Enable all cpus with a declared buffer. */
 		if (cpu_isset(cpu, iucv_buffer_cpumask) &&
 		    !cpu_isset(cpu, iucv_irq_cpumask))
-			smp_call_function_on(iucv_allow_cpu, NULL, 0, 1, cpu);
+			smp_call_function_single(cpu, iucv_allow_cpu,
+						 NULL, 0, 1);
 	preempt_enable();
 }
 
@@ -497,7 +498,7 @@ static void iucv_setmask_up(void)
 	cpumask = iucv_irq_cpumask;
 	cpu_clear(first_cpu(iucv_irq_cpumask), cpumask);
 	for_each_cpu_mask(cpu, cpumask)
-		smp_call_function_on(iucv_block_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_block_cpu, NULL, 0, 1);
 }
 
 /**
@@ -522,7 +523,7 @@ static int iucv_enable(void)
 	rc = -EIO;
 	preempt_disable();
 	for_each_online_cpu(cpu)
-		smp_call_function_on(iucv_declare_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_declare_cpu, NULL, 0, 1);
 	preempt_enable();
 	if (cpus_empty(iucv_buffer_cpumask))
 		/* No cpu could declare an iucv buffer. */
@@ -578,7 +579,7 @@ static int __cpuinit iucv_cpu_notify(str
 	case CPU_ONLINE_FROZEN:
 	case CPU_DOWN_FAILED:
 	case CPU_DOWN_FAILED_FROZEN:
-		smp_call_function_on(iucv_declare_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_declare_cpu, NULL, 0, 1);
 		break;
 	case CPU_DOWN_PREPARE:
 	case CPU_DOWN_PREPARE_FROZEN:
@@ -587,10 +588,10 @@ static int __cpuinit iucv_cpu_notify(str
 		if (cpus_empty(cpumask))
 			/* Can't offline last IUCV enabled cpu. */
 			return NOTIFY_BAD;
-		smp_call_function_on(iucv_retrieve_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_retrieve_cpu, NULL, 0, 1);
 		if (cpus_empty(iucv_irq_cpumask))
-			smp_call_function_on(iucv_allow_cpu, NULL, 0, 1,
-					     first_cpu(iucv_buffer_cpumask));
+			smp_call_function_single(first_cpu(iucv_buffer_cpumask),
+						 iucv_allow_cpu, NULL, 0, 1);
 		break;
 	}
 	return NOTIFY_OK;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
