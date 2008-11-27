Return-Path: <linux-kernel-owner+w=401wt.eu-S1755933AbYK0Ki0@vger.kernel.org>
Message-Id: <20081127103129.355671541@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/60] convert s390 to generic IPI infrastructure
Content-Disposition: inline; filename=105-generic-ipi.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Since etr/stp don't need the old smp_call_function semantics anymore
we can convert s390 to the generic IPI infrastructure.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig            |    1 
 arch/s390/include/asm/sigp.h |    1 
 arch/s390/include/asm/smp.h  |    5 -
 arch/s390/kernel/smp.c       |  175 ++++---------------------------------------
 4 files changed, 24 insertions(+), 158 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/sigp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/sigp.h
+++ quilt-2.6/arch/s390/include/asm/sigp.h
@@ -61,6 +61,7 @@ typedef enum
 {
 	ec_schedule=0,
 	ec_call_function,
+	ec_call_function_single,
 	ec_bit_last
 } ec_bit_sig;
 
Index: quilt-2.6/arch/s390/include/asm/smp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/smp.h
+++ quilt-2.6/arch/s390/include/asm/smp.h
@@ -91,8 +91,9 @@ extern int __cpu_up (unsigned int cpu);
 extern struct mutex smp_cpu_state_mutex;
 extern int smp_cpu_polarization[];
 
-extern int smp_call_function_mask(cpumask_t mask, void (*func)(void *),
-	void *info, int wait);
+extern void arch_send_call_function_single_ipi(int cpu);
+extern void arch_send_call_function_ipi(cpumask_t mask);
+
 #endif
 
 #ifndef CONFIG_SMP
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -73,6 +73,7 @@ mainmenu "Linux Kernel Configuration"
 
 config S390
 	def_bool y
+	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -77,159 +77,6 @@ static DEFINE_PER_CPU(struct cpu, cpu_de
 
 static void smp_ext_bitcall(int, ec_bit_sig);
 
-/*
- * Structure and data for __smp_call_function_map(). This is designed to
- * minimise static memory requirements. It also looks cleaner.
- */
-static DEFINE_SPINLOCK(call_lock);
-
-struct call_data_struct {
-	void (*func) (void *info);
-	void *info;
-	cpumask_t started;
-	cpumask_t finished;
-	int wait;
-};
-
-static struct call_data_struct *call_data;
-
-/*
- * 'Call function' interrupt callback
- */
-static void do_call_function(void)
-{
-	void (*func) (void *info) = call_data->func;
-	void *info = call_data->info;
-	int wait = call_data->wait;
-
-	cpu_set(smp_processor_id(), call_data->started);
-	(*func)(info);
-	if (wait)
-		cpu_set(smp_processor_id(), call_data->finished);;
-}
-
-static void __smp_call_function_map(void (*func) (void *info), void *info,
-				    int wait, cpumask_t map)
-{
-	struct call_data_struct data;
-	int cpu, local = 0;
-
-	/*
-	 * Can deadlock when interrupts are disabled or if in wrong context.
-	 */
-	WARN_ON(irqs_disabled() || in_irq());
-
-	/*
-	 * Check for local function call. We have to have the same call order
-	 * as in on_each_cpu() because of machine_restart_smp().
-	 */
-	if (cpu_isset(smp_processor_id(), map)) {
-		local = 1;
-		cpu_clear(smp_processor_id(), map);
-	}
-
-	cpus_and(map, map, cpu_online_map);
-	if (cpus_empty(map))
-		goto out;
-
-	data.func = func;
-	data.info = info;
-	data.started = CPU_MASK_NONE;
-	data.wait = wait;
-	if (wait)
-		data.finished = CPU_MASK_NONE;
-
-	call_data = &data;
-
-	for_each_cpu_mask(cpu, map)
-		smp_ext_bitcall(cpu, ec_call_function);
-
-	/* Wait for response */
-	while (!cpus_equal(map, data.started))
-		cpu_relax();
-	if (wait)
-		while (!cpus_equal(map, data.finished))
-			cpu_relax();
-out:
-	if (local) {
-		local_irq_disable();
-		func(info);
-		local_irq_enable();
-	}
-}
-
-/*
- * smp_call_function:
- * @func: the function to run; this must be fast and non-blocking
- * @info: an arbitrary pointer to pass to the function
- * @wait: if true, wait (atomically) until function has completed on other CPUs
- *
- * Run a function on all other CPUs.
- *
- * You must not call this function with disabled interrupts, from a
- * hardware interrupt handler or from a bottom half.
- */
-int smp_call_function(void (*func) (void *info), void *info, int wait)
-{
-	cpumask_t map;
-
-	spin_lock(&call_lock);
-	map = cpu_online_map;
-	cpu_clear(smp_processor_id(), map);
-	__smp_call_function_map(func, info, wait, map);
-	spin_unlock(&call_lock);
-	return 0;
-}
-EXPORT_SYMBOL(smp_call_function);
-
-/*
- * smp_call_function_single:
- * @cpu: the CPU where func should run
- * @func: the function to run; this must be fast and non-blocking
- * @info: an arbitrary pointer to pass to the function
- * @wait: if true, wait (atomically) until function has completed on other CPUs
- *
- * Run a function on one processor.
- *
- * You must not call this function with disabled interrupts, from a
- * hardware interrupt handler or from a bottom half.
- */
-int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
-			     int wait)
-{
-	spin_lock(&call_lock);
-	__smp_call_function_map(func, info, wait, cpumask_of_cpu(cpu));
-	spin_unlock(&call_lock);
-	return 0;
-}
-EXPORT_SYMBOL(smp_call_function_single);
-
-/**
- * smp_call_function_mask(): Run a function on a set of other CPUs.
- * @mask: The set of cpus to run on.  Must not include the current cpu.
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed on other CPUs.
- *
- * Returns 0 on success, else a negative status code.
- *
- * If @wait is true, then returns once @func has returned; otherwise
- * it returns just before the target cpu calls @func.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.
- */
-int smp_call_function_mask(cpumask_t mask, void (*func)(void *), void *info,
-			   int wait)
-{
-	spin_lock(&call_lock);
-	cpu_clear(smp_processor_id(), mask);
-	__smp_call_function_map(func, info, wait, mask);
-	spin_unlock(&call_lock);
-	return 0;
-}
-EXPORT_SYMBOL(smp_call_function_mask);
-
 void smp_send_stop(void)
 {
 	int cpu, rc;
@@ -271,7 +118,10 @@ static void do_ext_call_interrupt(__u16 
 	bits = xchg(&S390_lowcore.ext_call_fast, 0);
 
 	if (test_bit(ec_call_function, &bits))
-		do_call_function();
+		generic_smp_call_function_interrupt();
+
+	if (test_bit(ec_call_function_single, &bits))
+		generic_smp_call_function_single_interrupt();
 }
 
 /*
@@ -288,6 +138,19 @@ static void smp_ext_bitcall(int cpu, ec_
 		udelay(10);
 }
 
+void arch_send_call_function_ipi(cpumask_t mask)
+{
+	int cpu;
+
+	for_each_cpu_mask(cpu, mask)
+		smp_ext_bitcall(cpu, ec_call_function);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	smp_ext_bitcall(cpu, ec_call_function_single);
+}
+
 #ifndef CONFIG_64BIT
 /*
  * this function sends a 'purge tlb' signal to another CPU.
@@ -588,9 +451,9 @@ int __cpuinit start_secondary(void *cpuv
 	/* call cpu notifiers */
 	notify_cpu_starting(smp_processor_id());
 	/* Mark this cpu as online */
-	spin_lock(&call_lock);
+	ipi_call_lock();
 	cpu_set(smp_processor_id(), cpu_online_map);
-	spin_unlock(&call_lock);
+	ipi_call_unlock();
 	/* Switch on interrupts */
 	local_irq_enable();
 	/* Print info about this processor */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
