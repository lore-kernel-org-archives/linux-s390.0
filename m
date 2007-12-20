Return-Path: <linux-kernel-owner+w=401wt.eu-S936904AbXLTPil@vger.kernel.org>
Message-Id: <20071220152108.951967398@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/47] Get rid of additional_cpus kernel parameter.
Content-Disposition: inline; filename=126-additional-cpus.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

It caused only a lot of confusion. From now on cpu hotplug of up to
NR_CPUS will work by default. If somebody wants to limit that then
the possible_cpus parameter can be used.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/cpu-hotplug.txt |    2 
 arch/s390/kernel/early.c      |    1 
 arch/s390/kernel/setup.c      |    1 
 arch/s390/kernel/smp.c        |  178 +++++++++++++++++-------------------------
 drivers/s390/char/sclp_cmd.c  |   46 ----------
 include/asm-s390/sclp.h       |    1 
 include/asm-s390/smp.h        |    3 
 7 files changed, 78 insertions(+), 154 deletions(-)

Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -278,7 +278,6 @@ void __init startup_init(void)
 	setup_lowcore_early();
 	sclp_read_info_early();
 	sclp_facilities_detect();
-	sclp_read_cpu_info_early();
 	memsize = sclp_memory_detect();
 #ifndef CONFIG_64BIT
 	/*
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -922,7 +922,6 @@ setup_arch(char **cmdline_p)
 
         cpu_init();
         __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
-	smp_setup_cpu_possible_map();
 
 	/*
 	 * Setup capabilities (ELF_HWCAP & ELF_PLATFORM).
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -54,7 +54,7 @@ EXPORT_SYMBOL(lowcore_ptr);
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 EXPORT_SYMBOL(cpu_online_map);
 
-cpumask_t cpu_possible_map = CPU_MASK_NONE;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
 EXPORT_SYMBOL(cpu_possible_map);
 
 static struct task_struct *current_set[NR_CPUS];
@@ -399,7 +399,7 @@ static void __init smp_get_save_area(uns
 		       "kernel was compiled with NR_CPUS=%i\n", cpu, NR_CPUS);
 		return;
 	}
-	zfcpdump_save_areas[cpu] = alloc_bootmem(sizeof(union save_area));
+	zfcpdump_save_areas[cpu] = kmalloc(sizeof(union save_area), GFP_KERNEL);
 	__cpu_logical_map[CPU_INIT_NO] = (__u16) phy_cpu;
 	while (signal_processor(CPU_INIT_NO, sigp_stop_and_store_status) ==
 	       sigp_busy)
@@ -435,67 +435,6 @@ static int cpu_stopped(int cpu)
 	return 0;
 }
 
-/*
- * Lets check how many CPUs we have.
- */
-static void __init smp_count_cpus(unsigned int *configured_cpus,
-				  unsigned int *standby_cpus)
-{
-	unsigned int cpu;
-	struct sclp_cpu_info *info;
-	u16 boot_cpu_addr, cpu_addr;
-
-	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
-	current_thread_info()->cpu = 0;
-	*configured_cpus = 1;
-	*standby_cpus = 0;
-
-	info = alloc_bootmem_pages(sizeof(*info));
-	if (!info)
-		disabled_wait((unsigned long) __builtin_return_address(0));
-
-	/* Use sigp detection algorithm if sclp doesn't work. */
-	if (sclp_get_cpu_info(info)) {
-		smp_use_sigp_detection = 1;
-		for (cpu = 0; cpu <= 65535; cpu++) {
-			if (cpu == boot_cpu_addr)
-				continue;
-			__cpu_logical_map[CPU_INIT_NO] = cpu;
-			if (cpu_stopped(CPU_INIT_NO))
-				(*configured_cpus)++;
-		}
-		goto out;
-	}
-
-	if (info->has_cpu_type) {
-		for (cpu = 0; cpu < info->combined; cpu++) {
-			if (info->cpu[cpu].address == boot_cpu_addr) {
-				smp_cpu_type = info->cpu[cpu].type;
-				break;
-			}
-		}
-	}
-	/* Count cpus. */
-	for (cpu = 0; cpu < info->combined; cpu++) {
-		if (info->has_cpu_type && info->cpu[cpu].type != smp_cpu_type)
-			continue;
-		cpu_addr = info->cpu[cpu].address;
-		if (cpu_addr == boot_cpu_addr)
-			continue;
-		__cpu_logical_map[CPU_INIT_NO] = cpu_addr;
-		if (!cpu_stopped(CPU_INIT_NO)) {
-			(*standby_cpus)++;
-			continue;
-		}
-		smp_get_save_area(*configured_cpus, cpu_addr);
-		(*configured_cpus)++;
-	}
-out:
-	printk(KERN_INFO "CPUs: %d configured, %d standby\n",
-	       *configured_cpus, *standby_cpus);
-	free_bootmem((unsigned long) info, sizeof(*info));
-}
-
 static int cpu_known(int cpu_id)
 {
 	int cpu;
@@ -529,7 +468,7 @@ static int smp_rescan_cpus_sigp(cpumask_
 	return 0;
 }
 
-static int __init_refok smp_rescan_cpus_sclp(cpumask_t avail)
+static int smp_rescan_cpus_sclp(cpumask_t avail)
 {
 	struct sclp_cpu_info *info;
 	int cpu_id, logical_cpu, cpu;
@@ -538,10 +477,7 @@ static int __init_refok smp_rescan_cpus_
 	logical_cpu = first_cpu(avail);
 	if (logical_cpu == NR_CPUS)
 		return 0;
-	if (slab_is_available())
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
-	else
-		info = alloc_bootmem(sizeof(*info));
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	rc = sclp_get_cpu_info(info);
@@ -564,10 +500,7 @@ static int __init_refok smp_rescan_cpus_
 			break;
 	}
 out:
-	if (slab_is_available())
-		kfree(info);
-	else
-		free_bootmem((unsigned long) info, sizeof(*info));
+	kfree(info);
 	return rc;
 }
 
@@ -575,15 +508,71 @@ static int smp_rescan_cpus(void)
 {
 	cpumask_t avail;
 
-	cpus_setall(avail);
-	cpus_and(avail, avail, cpu_possible_map);
-	cpus_andnot(avail, avail, cpu_present_map);
+	cpus_xor(avail, cpu_possible_map, cpu_present_map);
 	if (smp_use_sigp_detection)
 		return smp_rescan_cpus_sigp(avail);
 	else
 		return smp_rescan_cpus_sclp(avail);
 }
 
+static void __init smp_detect_cpus(void)
+{
+	unsigned int cpu, c_cpus, s_cpus;
+	struct sclp_cpu_info *info;
+	u16 boot_cpu_addr, cpu_addr;
+
+	c_cpus = 1;
+	s_cpus = 0;
+	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		panic("smp_detect_cpus failed to allocate memory\n");
+	/* Use sigp detection algorithm if sclp doesn't work. */
+	if (sclp_get_cpu_info(info)) {
+		smp_use_sigp_detection = 1;
+		for (cpu = 0; cpu <= 65535; cpu++) {
+			if (cpu == boot_cpu_addr)
+				continue;
+			__cpu_logical_map[CPU_INIT_NO] = cpu;
+			if (!cpu_stopped(CPU_INIT_NO))
+				continue;
+			smp_get_save_area(c_cpus, cpu);
+			c_cpus++;
+		}
+		goto out;
+	}
+
+	if (info->has_cpu_type) {
+		for (cpu = 0; cpu < info->combined; cpu++) {
+			if (info->cpu[cpu].address == boot_cpu_addr) {
+				smp_cpu_type = info->cpu[cpu].type;
+				break;
+			}
+		}
+	}
+
+	for (cpu = 0; cpu < info->combined; cpu++) {
+		if (info->has_cpu_type && info->cpu[cpu].type != smp_cpu_type)
+			continue;
+		cpu_addr = info->cpu[cpu].address;
+		if (cpu_addr == boot_cpu_addr)
+			continue;
+		__cpu_logical_map[CPU_INIT_NO] = cpu_addr;
+		if (!cpu_stopped(CPU_INIT_NO)) {
+			s_cpus++;
+			continue;
+		}
+		smp_get_save_area(c_cpus, cpu_addr);
+		c_cpus++;
+	}
+out:
+	kfree(info);
+	printk(KERN_INFO "CPUs: %d configured, %d standby\n", c_cpus, s_cpus);
+	lock_cpu_hotplug();
+	smp_rescan_cpus();
+	unlock_cpu_hotplug();
+}
+
 /*
  *	Activate a secondary processor.
  */
@@ -674,41 +663,20 @@ int __cpu_up(unsigned int cpu)
 	return 0;
 }
 
-static unsigned int __initdata additional_cpus;
-static unsigned int __initdata possible_cpus;
-
-void __init smp_setup_cpu_possible_map(void)
+static int __init setup_possible_cpus(char *s)
 {
-	unsigned int pos_cpus, cpu;
-	unsigned int configured_cpus, standby_cpus;
+	int pcpus, cpu;
 
-	smp_count_cpus(&configured_cpus, &standby_cpus);
-	pos_cpus = min(configured_cpus + standby_cpus + additional_cpus,
-		       (unsigned int) NR_CPUS);
-	if (possible_cpus)
-		pos_cpus = min(possible_cpus, (unsigned int) NR_CPUS);
-	for (cpu = 0; cpu < pos_cpus; cpu++)
+	pcpus = simple_strtoul(s, NULL, 0);
+	cpu_possible_map = cpumask_of_cpu(0);
+	for (cpu = 1; cpu < pcpus && cpu < NR_CPUS; cpu++)
 		cpu_set(cpu, cpu_possible_map);
-	cpu_present_map = cpumask_of_cpu(0);
-	smp_rescan_cpus();
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-static int __init setup_additional_cpus(char *s)
-{
-	additional_cpus = simple_strtoul(s, NULL, 0);
-	return 0;
-}
-early_param("additional_cpus", setup_additional_cpus);
-
-static int __init setup_possible_cpus(char *s)
-{
-	possible_cpus = simple_strtoul(s, NULL, 0);
 	return 0;
 }
 early_param("possible_cpus", setup_possible_cpus);
 
+#ifdef CONFIG_HOTPLUG_CPU
+
 int __cpu_disable(void)
 {
 	struct ec_creg_mask_parms cr_parms;
@@ -768,6 +736,8 @@ void __init smp_prepare_cpus(unsigned in
 	unsigned int cpu;
 	int i;
 
+	smp_detect_cpus();
+
 	/* request the 0x1201 emergency signal external interrupt */
 	if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
 		panic("Couldn't request external interrupt 0x1201");
@@ -816,6 +786,8 @@ void __init smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
 
+	current_thread_info()->cpu = 0;
+	cpu_set(0, cpu_present_map);
 	cpu_set(0, cpu_online_map);
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	current_set[0] = current;
Index: quilt-2.6/Documentation/cpu-hotplug.txt
===================================================================
--- quilt-2.6.orig/Documentation/cpu-hotplug.txt
+++ quilt-2.6/Documentation/cpu-hotplug.txt
@@ -50,7 +50,7 @@ additional_cpus=n (*)	Use this to limit 
   			cpu_possible_map = cpu_present_map + additional_cpus
 
 (*) Option valid only for following architectures
-- x86_64, ia64, s390
+- x86_64, ia64
 
 ia64 and x86_64 use the number of disabled local apics in ACPI tables MADT
 to determine the number of potentially hot-pluggable cpus. The implementation
Index: quilt-2.6/drivers/s390/char/sclp_cmd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_cmd.c
+++ quilt-2.6/drivers/s390/char/sclp_cmd.c
@@ -191,9 +191,6 @@ struct read_cpu_info_sccb {
 	u8	reserved[4096 - 16];
 } __attribute__((packed, aligned(PAGE_SIZE)));
 
-static struct read_cpu_info_sccb __initdata early_read_cpu_info_sccb;
-static struct sclp_cpu_info __initdata sclp_cpu_info;
-
 static void sclp_fill_cpu_info(struct sclp_cpu_info *info,
 			       struct read_cpu_info_sccb *sccb)
 {
@@ -208,48 +205,16 @@ static void sclp_fill_cpu_info(struct sc
 	       info->combined * sizeof(struct sclp_cpu_entry));
 }
 
-void __init sclp_read_cpu_info_early(void)
+int sclp_get_cpu_info(struct sclp_cpu_info *info)
 {
 	int rc;
 	struct read_cpu_info_sccb *sccb;
 
 	if (!SCLP_HAS_CPU_INFO)
-		return;
-
-	sccb = &early_read_cpu_info_sccb;
-	do {
-		memset(sccb, 0, sizeof(*sccb));
-		sccb->header.length = sizeof(*sccb);
-		rc = sclp_cmd_sync_early(SCLP_CMDW_READ_CPU_INFO, sccb);
-	} while (rc == -EBUSY);
-
-	if (rc)
-		return;
-	if (sccb->header.response_code != 0x10)
-		return;
-	sclp_fill_cpu_info(&sclp_cpu_info, sccb);
-}
-
-static int __init sclp_get_cpu_info_early(struct sclp_cpu_info *info)
-{
-	if (!SCLP_HAS_CPU_INFO)
 		return -EOPNOTSUPP;
-	*info = sclp_cpu_info;
-	return 0;
-}
-
-static int sclp_get_cpu_info_late(struct sclp_cpu_info *info)
-{
-	int rc;
-	struct read_cpu_info_sccb *sccb;
-
-	if (!SCLP_HAS_CPU_INFO)
-		return -EOPNOTSUPP;
-	sccb = (struct read_cpu_info_sccb *)  __get_free_page(GFP_KERNEL
-							      | GFP_DMA);
+	sccb = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
-	memset(sccb, 0, sizeof(*sccb));
 	sccb->header.length = sizeof(*sccb);
 	rc = do_sync_request(SCLP_CMDW_READ_CPU_INFO, sccb);
 	if (rc)
@@ -266,13 +231,6 @@ out:
 	return rc;
 }
 
-int __init_refok sclp_get_cpu_info(struct sclp_cpu_info *info)
-{
-	if (slab_is_available())
-		return sclp_get_cpu_info_late(info);
-	return sclp_get_cpu_info_early(info);
-}
-
 struct cpu_configure_sccb {
 	struct sccb_header header;
 } __attribute__((packed, aligned(8)));
Index: quilt-2.6/include/asm-s390/sclp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/sclp.h
+++ quilt-2.6/include/asm-s390/sclp.h
@@ -46,7 +46,6 @@ int sclp_get_cpu_info(struct sclp_cpu_in
 int sclp_cpu_configure(u8 cpu);
 int sclp_cpu_deconfigure(u8 cpu);
 void sclp_read_info_early(void);
-void sclp_read_cpu_info_early(void);
 void sclp_facilities_detect(void);
 unsigned long long sclp_memory_detect(void);
 int sclp_sdias_blk_count(void);
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h
+++ quilt-2.6/include/asm-s390/smp.h
@@ -35,8 +35,6 @@ extern void machine_restart_smp(char *);
 extern void machine_halt_smp(void);
 extern void machine_power_off_smp(void);
 
-extern void smp_setup_cpu_possible_map(void);
-
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
 /*
@@ -103,7 +101,6 @@ static inline void smp_send_stop(void)
 
 #define hard_smp_processor_id()		0
 #define smp_cpu_not_running(cpu)	1
-#define smp_setup_cpu_possible_map()	do { } while (0)
 #endif
 
 extern union save_area *zfcpdump_save_areas[NR_CPUS + 1];

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
