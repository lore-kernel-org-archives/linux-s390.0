Return-Path: <linux-kernel-owner+w=401wt.eu-S1755887AbXD0OIe@vger.kernel.org>
Message-Id: <20070427140520.601580274@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 37/38] Clean up smp code in preparation for some larger changes.
Content-Disposition: inline; filename=140-smp-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/smp.c |  259 ++++++++++++++++++-------------------------------
 include/asm-s390/smp.h |    5 
 2 files changed, 99 insertions(+), 165 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c	2007-04-27 16:05:00.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/smp.c	2007-04-27 16:05:02.000000000 +0200
@@ -1,12 +1,12 @@
 /*
  *  arch/s390/kernel/smp.c
  *
- *    Copyright (C) IBM Corp. 1999,2006
+ *    Copyright IBM Corp. 1999,2007
  *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
- *               Martin Schwidefsky (schwidefsky@de.ibm.com)
- *               Heiko Carstens (heiko.carstens@de.ibm.com)
+ *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *		 Heiko Carstens (heiko.carstens@de.ibm.com)
  *
- *  based on other smp stuff by 
+ *  based on other smp stuff by
  *    (c) 1995 Alan Cox, CymruNET Ltd  <alan@cymru.net>
  *    (c) 1998 Ingo Molnar
  *
@@ -43,16 +43,17 @@
 #include <asm/timer.h>
 #include <asm/lowcore.h>
 
-extern volatile int __cpu_logical_map[];
-
 /*
  * An array with a pointer the lowcore of every CPU.
  */
-
 struct _lowcore *lowcore_ptr[NR_CPUS];
+EXPORT_SYMBOL(lowcore_ptr);
 
 cpumask_t cpu_online_map = CPU_MASK_NONE;
+EXPORT_SYMBOL(cpu_online_map);
+
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
+EXPORT_SYMBOL(cpu_possible_map);
 
 static struct task_struct *current_set[NR_CPUS];
 
@@ -72,7 +73,7 @@
 	int wait;
 };
 
-static struct call_data_struct * call_data;
+static struct call_data_struct *call_data;
 
 /*
  * 'Call function' interrupt callback
@@ -152,8 +153,8 @@
  *
  * Run a function on all other CPUs.
  *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler. You may call it from a bottom half.
+ * You must not call this function with disabled interrupts, from a
+ * hardware interrupt handler or from a bottom half.
  */
 int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
 		      int wait)
@@ -179,11 +180,11 @@
  *
  * Run a function on one processor.
  *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler. You may call it from a bottom half.
+ * You must not call this function with disabled interrupts, from a
+ * hardware interrupt handler or from a bottom half.
  */
 int smp_call_function_on(void (*func) (void *info), void *info, int nonatomic,
-			  int wait, int cpu)
+			 int wait, int cpu)
 {
 	cpumask_t map = CPU_MASK_NONE;
 
@@ -197,9 +198,9 @@
 
 static void do_send_stop(void)
 {
-        int cpu, rc;
+	int cpu, rc;
 
-        /* stop all processors */
+	/* stop all processors */
 	for_each_online_cpu(cpu) {
 		if (cpu == smp_processor_id())
 			continue;
@@ -211,9 +212,9 @@
 
 static void do_store_status(void)
 {
-        int cpu, rc;
+	int cpu, rc;
 
-        /* store status of all processors in their lowcores (real 0) */
+	/* store status of all processors in their lowcores (real 0) */
 	for_each_online_cpu(cpu) {
 		if (cpu == smp_processor_id())
 			continue;
@@ -221,8 +222,8 @@
 			rc = signal_processor_p(
 				(__u32)(unsigned long) lowcore_ptr[cpu], cpu,
 				sigp_store_status_at_address);
-		} while(rc == sigp_busy);
-        }
+		} while (rc == sigp_busy);
+	}
 }
 
 static void do_wait_for_stop(void)
@@ -233,7 +234,7 @@
 	for_each_online_cpu(cpu) {
 		if (cpu == smp_processor_id())
 			continue;
-		while(!smp_cpu_not_running(cpu))
+		while (!smp_cpu_not_running(cpu))
 			cpu_relax();
 	}
 }
@@ -247,7 +248,7 @@
 	/* Disable all interrupts/machine checks */
 	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
 
-        /* write magic number to zero page (absolute 0) */
+	/* write magic number to zero page (absolute 0) */
 	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
 
 	/* stop other processors. */
@@ -263,8 +264,7 @@
 /*
  * Reboot, halt and power_off routines for SMP.
  */
-
-void machine_restart_smp(char * __unused) 
+void machine_restart_smp(char *__unused)
 {
 	smp_send_stop();
 	do_reipl();
@@ -295,17 +295,17 @@
 
 static void do_ext_call_interrupt(__u16 code)
 {
-        unsigned long bits;
+	unsigned long bits;
 
-        /*
-         * handle bit signal external calls
-         *
-         * For the ec_schedule signal we have to do nothing. All the work
-         * is done automatically when we return from the interrupt.
-         */
+	/*
+	 * handle bit signal external calls
+	 *
+	 * For the ec_schedule signal we have to do nothing. All the work
+	 * is done automatically when we return from the interrupt.
+	 */
 	bits = xchg(&S390_lowcore.ext_call_fast, 0);
 
-	if (test_bit(ec_call_function, &bits)) 
+	if (test_bit(ec_call_function, &bits))
 		do_call_function();
 }
 
@@ -315,11 +315,11 @@
  */
 static void smp_ext_bitcall(int cpu, ec_bit_sig sig)
 {
-        /*
-         * Set signaling bit in lowcore of target cpu and kick it
-         */
+	/*
+	 * Set signaling bit in lowcore of target cpu and kick it
+	 */
 	set_bit(sig, (unsigned long *) &lowcore_ptr[cpu]->ext_call_fast);
-	while(signal_processor(cpu, sigp_emergency_signal) == sigp_busy)
+	while (signal_processor(cpu, sigp_emergency_signal) == sigp_busy)
 		udelay(10);
 }
 
@@ -334,7 +334,7 @@
 
 void smp_ptlb_all(void)
 {
-        on_each_cpu(smp_ptlb_callback, NULL, 0, 1);
+	on_each_cpu(smp_ptlb_callback, NULL, 0, 1);
 }
 EXPORT_SYMBOL(smp_ptlb_all);
 #endif /* ! CONFIG_64BIT */
@@ -346,7 +346,7 @@
  */
 void smp_send_reschedule(int cpu)
 {
-        smp_ext_bitcall(cpu, ec_schedule);
+	smp_ext_bitcall(cpu, ec_schedule);
 }
 
 /*
@@ -360,11 +360,12 @@
 /*
  * callback for setting/clearing control bits
  */
-static void smp_ctl_bit_callback(void *info) {
+static void smp_ctl_bit_callback(void *info)
+{
 	struct ec_creg_mask_parms *pp = info;
 	unsigned long cregs[16];
 	int i;
-	
+
 	__ctl_store(cregs, 0, 15);
 	for (i = 0; i <= 15; i++)
 		cregs[i] = (cregs[i] & pp->andvals[i]) | pp->orvals[i];
@@ -383,6 +384,7 @@
 	parms.orvals[cr] = 1 << bit;
 	on_each_cpu(smp_ctl_bit_callback, &parms, 0, 1);
 }
+EXPORT_SYMBOL(smp_ctl_set_bit);
 
 /*
  * Clear a bit in a control register of all cpus
@@ -396,6 +398,7 @@
 	parms.andvals[cr] = ~(1L << bit);
 	on_each_cpu(smp_ctl_bit_callback, &parms, 0, 1);
 }
+EXPORT_SYMBOL(smp_ctl_clear_bit);
 
 #if defined(CONFIG_ZFCPDUMP) || defined(CONFIG_ZFCPDUMP_MODULE)
 
@@ -460,8 +463,7 @@
  * Lets check how many CPUs we have.
  */
 
-static unsigned int
-__init smp_count_cpus(void)
+static unsigned int __init smp_count_cpus(void)
 {
 	unsigned int cpu, num_cpus;
 	__u16 boot_cpu_addr;
@@ -477,31 +479,30 @@
 		if ((__u16) cpu == boot_cpu_addr)
 			continue;
 		__cpu_logical_map[1] = (__u16) cpu;
-		if (signal_processor(1, sigp_sense) ==
-		    sigp_not_operational)
+		if (signal_processor(1, sigp_sense) == sigp_not_operational)
 			continue;
 		num_cpus++;
 	}
 
-	printk("Detected %d CPU's\n",(int) num_cpus);
+	printk("Detected %d CPU's\n", (int) num_cpus);
 	printk("Boot cpu address %2X\n", boot_cpu_addr);
 
 	return num_cpus;
 }
 
 /*
- *      Activate a secondary processor.
+ *	Activate a secondary processor.
  */
 int __devinit start_secondary(void *cpuvoid)
 {
-        /* Setup the cpu */
-        cpu_init();
+	/* Setup the cpu */
+	cpu_init();
 	preempt_disable();
 	/* Enable TOD clock interrupts on the secondary cpu. */
-        init_cpu_timer();
+	init_cpu_timer();
 #ifdef CONFIG_VIRT_TIMER
 	/* Enable cpu timer interrupts on the secondary cpu. */
-        init_cpu_vtimer();
+	init_cpu_vtimer();
 #endif
 	/* Enable pfault pseudo page faults on this cpu. */
 	pfault_init();
@@ -510,11 +511,11 @@
 	cpu_set(smp_processor_id(), cpu_online_map);
 	/* Switch on interrupts */
 	local_irq_enable();
-        /* Print info about this processor */
-        print_cpu_info(&S390_lowcore.cpu_data);
-        /* cpu_idle will call schedule for us */
-        cpu_idle();
-        return 0;
+	/* Print info about this processor */
+	print_cpu_info(&S390_lowcore.cpu_data);
+	/* cpu_idle will call schedule for us */
+	cpu_idle();
+	return 0;
 }
 
 static void __init smp_create_idle(unsigned int cpu)
@@ -531,56 +532,13 @@
 	current_set[cpu] = p;
 }
 
-/* Reserving and releasing of CPUs */
-
-static DEFINE_SPINLOCK(smp_reserve_lock);
-static int smp_cpu_reserved[NR_CPUS];
-
-int
-smp_get_cpu(cpumask_t cpu_mask)
-{
-	unsigned long flags;
-	int cpu;
-
-	spin_lock_irqsave(&smp_reserve_lock, flags);
-	/* Try to find an already reserved cpu. */
-	for_each_cpu_mask(cpu, cpu_mask) {
-		if (smp_cpu_reserved[cpu] != 0) {
-			smp_cpu_reserved[cpu]++;
-			/* Found one. */
-			goto out;
-		}
-	}
-	/* Reserve a new cpu from cpu_mask. */
-	for_each_cpu_mask(cpu, cpu_mask) {
-		if (cpu_online(cpu)) {
-			smp_cpu_reserved[cpu]++;
-			goto out;
-		}
-	}
-	cpu = -ENODEV;
-out:
-	spin_unlock_irqrestore(&smp_reserve_lock, flags);
-	return cpu;
-}
-
-void
-smp_put_cpu(int cpu)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&smp_reserve_lock, flags);
-	smp_cpu_reserved[cpu]--;
-	spin_unlock_irqrestore(&smp_reserve_lock, flags);
-}
-
-static int
-cpu_stopped(int cpu)
+static int cpu_stopped(int cpu)
 {
 	__u32 status;
 
 	/* Check for stopped state */
-	if (signal_processor_ps(&status, 0, cpu, sigp_sense) == sigp_status_stored) {
+	if (signal_processor_ps(&status, 0, cpu, sigp_sense) ==
+	    sigp_status_stored) {
 		if (status & 0x40)
 			return 1;
 	}
@@ -589,14 +547,13 @@
 
 /* Upping and downing of CPUs */
 
-int
-__cpu_up(unsigned int cpu)
+int __cpu_up(unsigned int cpu)
 {
 	struct task_struct *idle;
-        struct _lowcore    *cpu_lowcore;
+	struct _lowcore *cpu_lowcore;
 	struct stack_frame *sf;
-        sigp_ccode          ccode;
-	int                 curr_cpu;
+	sigp_ccode ccode;
+	int curr_cpu;
 
 	for (curr_cpu = 0; curr_cpu <= 65535; curr_cpu++) {
 		__cpu_logical_map[cpu] = (__u16) curr_cpu;
@@ -609,7 +566,7 @@
 
 	ccode = signal_processor_p((__u32)(unsigned long)(lowcore_ptr[cpu]),
 				   cpu, sigp_set_prefix);
-	if (ccode){
+	if (ccode) {
 		printk("sigp_set_prefix failed for cpu %d "
 		       "with condition code %d\n",
 		       (int) cpu, (int) ccode);
@@ -617,9 +574,9 @@
 	}
 
 	idle = current_set[cpu];
-        cpu_lowcore = lowcore_ptr[cpu];
+	cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->kernel_stack = (unsigned long)
-		task_stack_page(idle) + (THREAD_SIZE);
+		task_stack_page(idle) + THREAD_SIZE;
 	sf = (struct stack_frame *) (cpu_lowcore->kernel_stack
 				     - sizeof(struct pt_regs)
 				     - sizeof(struct stack_frame));
@@ -631,11 +588,11 @@
 		"	stam	0,15,0(%0)"
 		: : "a" (&cpu_lowcore->access_regs_save_area) : "memory");
 	cpu_lowcore->percpu_offset = __per_cpu_offset[cpu];
-        cpu_lowcore->current_task = (unsigned long) idle;
-        cpu_lowcore->cpu_data.cpu_nr = cpu;
+	cpu_lowcore->current_task = (unsigned long) idle;
+	cpu_lowcore->cpu_data.cpu_nr = cpu;
 	eieio();
 
-	while (signal_processor(cpu,sigp_restart) == sigp_busy)
+	while (signal_processor(cpu, sigp_restart) == sigp_busy)
 		udelay(10);
 
 	while (!cpu_online(cpu))
@@ -682,18 +639,11 @@
 }
 early_param("possible_cpus", setup_possible_cpus);
 
-int
-__cpu_disable(void)
+int __cpu_disable(void)
 {
-	unsigned long flags;
 	struct ec_creg_mask_parms cr_parms;
 	int cpu = smp_processor_id();
 
-	spin_lock_irqsave(&smp_reserve_lock, flags);
-	if (smp_cpu_reserved[cpu] != 0) {
-		spin_unlock_irqrestore(&smp_reserve_lock, flags);
-		return -EBUSY;
-	}
 	cpu_clear(cpu, cpu_online_map);
 
 	/* Disable pfault pseudo page faults on this cpu. */
@@ -704,24 +654,23 @@
 
 	/* disable all external interrupts */
 	cr_parms.orvals[0] = 0;
-	cr_parms.andvals[0] = ~(1<<15 | 1<<14 | 1<<13 | 1<<12 |
-				1<<11 | 1<<10 | 1<< 6 | 1<< 4);
+	cr_parms.andvals[0] = ~(1 << 15 | 1 << 14 | 1 << 13 | 1 << 12 |
+				1 << 11 | 1 << 10 | 1 <<  6 | 1 <<  4);
 	/* disable all I/O interrupts */
 	cr_parms.orvals[6] = 0;
-	cr_parms.andvals[6] = ~(1<<31 | 1<<30 | 1<<29 | 1<<28 |
-				1<<27 | 1<<26 | 1<<25 | 1<<24);
+	cr_parms.andvals[6] = ~(1 << 31 | 1 << 30 | 1 << 29 | 1 << 28 |
+				1 << 27 | 1 << 26 | 1 << 25 | 1 << 24);
 	/* disable most machine checks */
 	cr_parms.orvals[14] = 0;
-	cr_parms.andvals[14] = ~(1<<28 | 1<<27 | 1<<26 | 1<<25 | 1<<24);
+	cr_parms.andvals[14] = ~(1 << 28 | 1 << 27 | 1 << 26 |
+				 1 << 25 | 1 << 24);
 
 	smp_ctl_bit_callback(&cr_parms);
 
-	spin_unlock_irqrestore(&smp_reserve_lock, flags);
 	return 0;
 }
 
-void
-__cpu_die(unsigned int cpu)
+void __cpu_die(unsigned int cpu)
 {
 	/* Wait until target cpu is down */
 	while (!smp_cpu_not_running(cpu))
@@ -729,13 +678,12 @@
 	printk("Processor %d spun down\n", cpu);
 }
 
-void
-cpu_die(void)
+void cpu_die(void)
 {
 	idle_task_exit();
 	signal_processor(smp_processor_id(), sigp_stop);
 	BUG();
-	for(;;);
+	for (;;);
 }
 
 #endif /* CONFIG_HOTPLUG_CPU */
@@ -748,36 +696,36 @@
 {
 	unsigned long stack;
 	unsigned int cpu;
-        int i;
+	int i;
 
-        /* request the 0x1201 emergency signal external interrupt */
-        if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
-                panic("Couldn't request external interrupt 0x1201");
-        memset(lowcore_ptr,0,sizeof(lowcore_ptr));  
-        /*
-         *  Initialize prefix pages and stacks for all possible cpus
-         */
+	/* request the 0x1201 emergency signal external interrupt */
+	if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
+		panic("Couldn't request external interrupt 0x1201");
+	memset(lowcore_ptr, 0, sizeof(lowcore_ptr));
+	/*
+	 *  Initialize prefix pages and stacks for all possible cpus
+	 */
 	print_cpu_info(&S390_lowcore.cpu_data);
 
-        for_each_possible_cpu(i) {
+	for_each_possible_cpu(i) {
 		lowcore_ptr[i] = (struct _lowcore *)
-			__get_free_pages(GFP_KERNEL|GFP_DMA, 
-					sizeof(void*) == 8 ? 1 : 0);
-		stack = __get_free_pages(GFP_KERNEL,ASYNC_ORDER);
-		if (lowcore_ptr[i] == NULL || stack == 0ULL)
+			__get_free_pages(GFP_KERNEL | GFP_DMA,
+					 sizeof(void*) == 8 ? 1 : 0);
+		stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
+		if (!lowcore_ptr[i] || !stack)
 			panic("smp_boot_cpus failed to allocate memory\n");
 
 		*(lowcore_ptr[i]) = S390_lowcore;
-		lowcore_ptr[i]->async_stack = stack + (ASYNC_SIZE);
-		stack = __get_free_pages(GFP_KERNEL,0);
-		if (stack == 0ULL)
+		lowcore_ptr[i]->async_stack = stack + ASYNC_SIZE;
+		stack = __get_free_pages(GFP_KERNEL, 0);
+		if (!stack)
 			panic("smp_boot_cpus failed to allocate memory\n");
-		lowcore_ptr[i]->panic_stack = stack + (PAGE_SIZE);
+		lowcore_ptr[i]->panic_stack = stack + PAGE_SIZE;
 #ifndef CONFIG_64BIT
 		if (MACHINE_HAS_IEEE) {
 			lowcore_ptr[i]->extended_save_area_addr =
-				(__u32) __get_free_pages(GFP_KERNEL,0);
-			if (lowcore_ptr[i]->extended_save_area_addr == 0)
+				(__u32) __get_free_pages(GFP_KERNEL, 0);
+			if (!lowcore_ptr[i]->extended_save_area_addr)
 				panic("smp_boot_cpus failed to "
 				      "allocate memory\n");
 		}
@@ -816,7 +764,7 @@
  */
 int setup_profiling_timer(unsigned int multiplier)
 {
-        return 0;
+	return 0;
 }
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
@@ -853,7 +801,7 @@
 }
 
 static struct notifier_block __cpuinitdata smp_cpu_nb = {
-	.notifier_call	= smp_cpu_notify,
+	.notifier_call = smp_cpu_notify,
 };
 
 static int __init topology_init(void)
@@ -875,13 +823,4 @@
 	}
 	return 0;
 }
-
 subsys_initcall(topology_init);
-
-EXPORT_SYMBOL(cpu_online_map);
-EXPORT_SYMBOL(cpu_possible_map);
-EXPORT_SYMBOL(lowcore_ptr);
-EXPORT_SYMBOL(smp_ctl_set_bit);
-EXPORT_SYMBOL(smp_ctl_clear_bit);
-EXPORT_SYMBOL(smp_get_cpu);
-EXPORT_SYMBOL(smp_put_cpu);
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h	2007-04-27 16:04:59.000000000 +0200
+++ quilt-2.6/include/asm-s390/smp.h	2007-04-27 16:05:02.000000000 +0200
@@ -54,9 +54,6 @@
 
 #define raw_smp_processor_id()	(S390_lowcore.cpu_data.cpu_nr)
 
-extern int smp_get_cpu(cpumask_t cpu_map);
-extern void smp_put_cpu(int cpu);
-
 static inline __u16 hard_smp_processor_id(void)
 {
         __u16 cpu_address;
@@ -114,8 +111,6 @@
 }
 
 #define smp_cpu_not_running(cpu)	1
-#define smp_get_cpu(cpu) ({ 0; })
-#define smp_put_cpu(cpu) ({ 0; })
 #define smp_setup_cpu_possible_map()	do { } while (0)
 #endif
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
