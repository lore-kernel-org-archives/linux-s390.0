Return-Path: <linux-kernel-owner+w=401wt.eu-S1760502AbYBSOrt@vger.kernel.org>
Message-Id: <20080219144504.392301782@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/13] Initialize per cpu lowcores on cpu hotplug.
Content-Disposition: inline; filename=007-lowcore.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Just copy the first 512 read-only bytes of the current cpu lowcore if
a new cpu gets onlined. The rest is zeroed out and must be explicitly
initialized. Current code just copies the entire lowcore and
initializes the needed fields.
This should reveal bugs in future enhancements quite early.
Also when the lowcore of the first cpu is replaced this is now done
atomically (no interrupts, no machine checks).

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |   53 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 15 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -626,13 +626,17 @@ static int __cpuinit smp_alloc_lowcore(i
 	if (!lowcore)
 		return -ENOMEM;
 	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
-	if (!async_stack)
-		goto out_async_stack;
 	panic_stack = __get_free_page(GFP_KERNEL);
-	if (!panic_stack)
-		goto out_panic_stack;
-
-	*lowcore = S390_lowcore;
+	if (!panic_stack || !async_stack)
+		goto out;
+	/*
+	 * Only need to copy the first 512 bytes from address 0. But since
+	 * the compiler emits a warning if src == NULL for memcpy use copy_page
+	 * instead. Copies more than needed but this code is not performance
+	 * critical.
+	 */
+	copy_page(lowcore, &S390_lowcore);
+	memset((void *)lowcore + 512, 0, sizeof(*lowcore) - 512);
 	lowcore->async_stack = async_stack + ASYNC_SIZE;
 	lowcore->panic_stack = panic_stack + PAGE_SIZE;
 
@@ -653,9 +657,8 @@ static int __cpuinit smp_alloc_lowcore(i
 out_save_area:
 	free_page(panic_stack);
 #endif
-out_panic_stack:
+out:
 	free_pages(async_stack, ASYNC_ORDER);
-out_async_stack:
 	free_pages((unsigned long) lowcore, lc_order);
 	return -ENOMEM;
 }
@@ -719,8 +722,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	cpu_lowcore->percpu_offset = __per_cpu_offset[cpu];
 	cpu_lowcore->current_task = (unsigned long) idle;
 	cpu_lowcore->cpu_data.cpu_nr = cpu;
-	cpu_lowcore->softirq_pending = 0;
-	cpu_lowcore->ext_call_fast = 0;
+	cpu_lowcore->kernel_asce = S390_lowcore.kernel_asce;
+	cpu_lowcore->ipl_device = S390_lowcore.ipl_device;
 	eieio();
 
 	while (signal_processor(cpu, sigp_restart) == sigp_busy)
@@ -797,23 +800,43 @@ void cpu_die(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+#ifndef CONFIG_64BIT
+	unsigned long save_area = 0;
+#endif
+	unsigned long async_stack, panic_stack;
+	struct _lowcore *lowcore;
 	unsigned int cpu;
+	int lc_order;
 
 	smp_detect_cpus();
 
 	/* request the 0x1201 emergency signal external interrupt */
 	if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
 		panic("Couldn't request external interrupt 0x1201");
-	memset(lowcore_ptr, 0, sizeof(lowcore_ptr));
 	print_cpu_info(&S390_lowcore.cpu_data);
-	smp_alloc_lowcore(smp_processor_id());
 
+	/* Reallocate current lowcore, but keep its contents. */
+	lc_order = sizeof(long) == 8 ? 1 : 0;
+	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, lc_order);
+	panic_stack = __get_free_page(GFP_KERNEL);
+	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
-		ctl_set_bit(14, 29); /* enable extended save area */
+		save_area = get_zeroed_page(GFP_KERNEL);
 #endif
-	set_prefix((u32)(unsigned long) lowcore_ptr[smp_processor_id()]);
-
+	local_irq_disable();
+	local_mcck_disable();
+	lowcore_ptr[smp_processor_id()] = lowcore;
+	*lowcore = S390_lowcore;
+	lowcore->panic_stack = panic_stack + PAGE_SIZE;
+	lowcore->async_stack = async_stack + ASYNC_SIZE;
+#ifndef CONFIG_64BIT
+	if (MACHINE_HAS_IEEE)
+		lowcore->extended_save_area_addr = (u32) save_area;
+#endif
+	set_prefix((u32)(unsigned long) lowcore);
+	local_mcck_enable();
+	local_irq_enable();
 	for_each_possible_cpu(cpu)
 		if (cpu != smp_processor_id())
 			smp_create_idle(cpu);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
