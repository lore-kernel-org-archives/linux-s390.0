Return-Path: <linux-kernel-owner+w=401wt.eu-S965706AbXLTPek@vger.kernel.org>
Message-Id: <20071220152110.940620461@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:01 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 36/47] Allocate and free cpu lowcores and stacks when needed/possible.
Content-Disposition: inline; filename=135-cpu-lowcores.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

No need to preallocate the per cpu lowcores and stacks.
Savings are 28-32k per offline cpu.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |  106 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 34 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -589,8 +589,72 @@ static void __init smp_create_idle(unsig
 	spin_lock_init(&(&per_cpu(s390_idle, cpu))->lock);
 }
 
+static int __cpuinit smp_alloc_lowcore(int cpu)
+{
+	unsigned long async_stack, panic_stack;
+	struct _lowcore *lowcore;
+	int lc_order;
+
+	lc_order = sizeof(long) == 8 ? 1 : 0;
+	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, lc_order);
+	if (!lowcore)
+		return -ENOMEM;
+	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
+	if (!async_stack)
+		goto out_async_stack;
+	panic_stack = __get_free_page(GFP_KERNEL);
+	if (!panic_stack)
+		goto out_panic_stack;
+
+	*lowcore = S390_lowcore;
+	lowcore->async_stack = async_stack + ASYNC_SIZE;
+	lowcore->panic_stack = panic_stack + PAGE_SIZE;
+
+#ifndef CONFIG_64BIT
+	if (MACHINE_HAS_IEEE) {
+		unsigned long save_area;
+
+		save_area = get_zeroed_page(GFP_KERNEL);
+		if (!save_area)
+			goto out_save_area;
+		lowcore->extended_save_area_addr = (u32) save_area;
+	}
+#endif
+	lowcore_ptr[cpu] = lowcore;
+	return 0;
+
+#ifndef CONFIG_64BIT
+out_save_area:
+	free_page(panic_stack);
+#endif
+out_panic_stack:
+	free_pages(async_stack, ASYNC_ORDER);
+out_async_stack:
+	free_pages((unsigned long) lowcore, lc_order);
+	return -ENOMEM;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void smp_free_lowcore(int cpu)
+{
+	struct _lowcore *lowcore;
+	int lc_order;
+
+	lc_order = sizeof(long) == 8 ? 1 : 0;
+	lowcore = lowcore_ptr[cpu];
+#ifndef CONFIG_64BIT
+	if (MACHINE_HAS_IEEE)
+		free_page((unsigned long) lowcore->extended_save_area_addr);
+#endif
+	free_page(lowcore->panic_stack - PAGE_SIZE);
+	free_pages(lowcore->async_stack - ASYNC_SIZE, ASYNC_ORDER);
+	free_pages((unsigned long) lowcore, lc_order);
+	lowcore_ptr[cpu] = NULL;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /* Upping and downing of CPUs */
-int __cpu_up(unsigned int cpu)
+int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct task_struct *idle;
 	struct _lowcore *cpu_lowcore;
@@ -599,6 +663,8 @@ int __cpu_up(unsigned int cpu)
 
 	if (smp_cpu_state[cpu] != CPU_STATE_CONFIGURED)
 		return -EIO;
+	if (smp_alloc_lowcore(cpu))
+		return -ENOMEM;
 
 	ccode = signal_processor_p((__u32)(unsigned long)(lowcore_ptr[cpu]),
 				   cpu, sigp_set_prefix);
@@ -613,6 +679,7 @@ int __cpu_up(unsigned int cpu)
 	cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->kernel_stack = (unsigned long)
 		task_stack_page(idle) + THREAD_SIZE;
+	cpu_lowcore->thread_info = (unsigned long) task_thread_info(idle);
 	sf = (struct stack_frame *) (cpu_lowcore->kernel_stack
 				     - sizeof(struct pt_regs)
 				     - sizeof(struct stack_frame));
@@ -626,6 +693,8 @@ int __cpu_up(unsigned int cpu)
 	cpu_lowcore->percpu_offset = __per_cpu_offset[cpu];
 	cpu_lowcore->current_task = (unsigned long) idle;
 	cpu_lowcore->cpu_data.cpu_nr = cpu;
+	cpu_lowcore->softirq_pending = 0;
+	cpu_lowcore->ext_call_fast = 0;
 	eieio();
 
 	while (signal_processor(cpu, sigp_restart) == sigp_busy)
@@ -686,6 +755,7 @@ void __cpu_die(unsigned int cpu)
 	/* Wait until target cpu is down */
 	while (!smp_cpu_not_running(cpu))
 		cpu_relax();
+	smp_free_lowcore(cpu);
 	printk(KERN_INFO "Processor %d spun down\n", cpu);
 }
 
@@ -699,15 +769,9 @@ void cpu_die(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-/*
- *	Cycle through the processors and setup structures.
- */
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned long stack;
 	unsigned int cpu;
-	int i;
 
 	smp_detect_cpus();
 
@@ -715,35 +779,9 @@ void __init smp_prepare_cpus(unsigned in
 	if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
 		panic("Couldn't request external interrupt 0x1201");
 	memset(lowcore_ptr, 0, sizeof(lowcore_ptr));
-	/*
-	 *  Initialize prefix pages and stacks for all possible cpus
-	 */
 	print_cpu_info(&S390_lowcore.cpu_data);
+	smp_alloc_lowcore(smp_processor_id());
 
-	for_each_possible_cpu(i) {
-		lowcore_ptr[i] = (struct _lowcore *)
-			__get_free_pages(GFP_KERNEL | GFP_DMA,
-					 sizeof(void*) == 8 ? 1 : 0);
-		stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
-		if (!lowcore_ptr[i] || !stack)
-			panic("smp_boot_cpus failed to allocate memory\n");
-
-		*(lowcore_ptr[i]) = S390_lowcore;
-		lowcore_ptr[i]->async_stack = stack + ASYNC_SIZE;
-		stack = __get_free_pages(GFP_KERNEL, 0);
-		if (!stack)
-			panic("smp_boot_cpus failed to allocate memory\n");
-		lowcore_ptr[i]->panic_stack = stack + PAGE_SIZE;
-#ifndef CONFIG_64BIT
-		if (MACHINE_HAS_IEEE) {
-			lowcore_ptr[i]->extended_save_area_addr =
-				(__u32) __get_free_pages(GFP_KERNEL, 0);
-			if (!lowcore_ptr[i]->extended_save_area_addr)
-				panic("smp_boot_cpus failed to "
-				      "allocate memory\n");
-		}
-#endif
-	}
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
 		ctl_set_bit(14, 29); /* enable extended save area */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
