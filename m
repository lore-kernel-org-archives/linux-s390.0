Return-Path: <linux-kernel-owner+w=401wt.eu-S1764541AbXGJJav@vger.kernel.org>
Message-Id: <20070710093112.332755494@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/16] smp: Merge smp_count_cpus() and smp_get_save_areas().
Content-Disposition: inline; filename=007-smp-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Merge smp_count_cpus() and smp_get_save_areas() so we save a loop over
all potentially present cpus.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |   63 ++++++++++++++++---------------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -410,58 +410,40 @@ EXPORT_SYMBOL(smp_ctl_clear_bit);
 unsigned int zfcpdump_prefix_array[NR_CPUS + 1] \
 	__attribute__((__section__(".data")));
 
-static void __init smp_get_save_areas(void)
+static void __init smp_get_save_area(unsigned int cpu, unsigned int phy_cpu)
 {
-	unsigned int cpu, cpu_num, rc;
-	__u16 boot_cpu_addr;
-
 	if (ipl_info.type != IPL_TYPE_FCP_DUMP)
 		return;
-	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
-	cpu_num = 1;
-	for (cpu = 0; cpu <= 65535; cpu++) {
-		if ((u16) cpu == boot_cpu_addr)
-			continue;
-		__cpu_logical_map[1] = (__u16) cpu;
-		if (signal_processor(1, sigp_sense) == sigp_not_operational)
-			continue;
-		if (cpu_num >= NR_CPUS) {
-			printk("WARNING: Registers for cpu %i are not "
-			       "saved, since dump kernel was compiled with"
-			       "NR_CPUS=%i!\n", cpu_num, NR_CPUS);
-			continue;
-		}
-		zfcpdump_save_areas[cpu_num] =
-			alloc_bootmem(sizeof(union save_area));
-		while (1) {
-			rc = signal_processor(1, sigp_stop_and_store_status);
-			if (rc != sigp_busy)
-				break;
-			cpu_relax();
-		}
-		memcpy(zfcpdump_save_areas[cpu_num],
-		       (void *)(unsigned long) store_prefix() +
-		       SAVE_AREA_BASE, SAVE_AREA_SIZE);
-#ifdef __s390x__
-		/* copy original prefix register */
-		zfcpdump_save_areas[cpu_num]->s390x.pref_reg =
-			zfcpdump_prefix_array[cpu_num];
-#endif
-		cpu_num++;
+	if (cpu >= NR_CPUS) {
+		printk(KERN_WARNING "Registers for cpu %i not saved since dump "
+		       "kernel was compiled with NR_CPUS=%i\n", cpu, NR_CPUS);
+		return;
 	}
+	zfcpdump_save_areas[cpu] = alloc_bootmem(sizeof(union save_area));
+	__cpu_logical_map[1] = (__u16) phy_cpu;
+	while (signal_processor(1, sigp_stop_and_store_status) == sigp_busy)
+		cpu_relax();
+	memcpy(zfcpdump_save_areas[cpu],
+	       (void *)(unsigned long) store_prefix() + SAVE_AREA_BASE,
+	       SAVE_AREA_SIZE);
+#ifdef CONFIG_64BIT
+	/* copy original prefix register */
+	zfcpdump_save_areas[cpu]->s390x.pref_reg = zfcpdump_prefix_array[cpu];
+#endif
 }
 
 union save_area *zfcpdump_save_areas[NR_CPUS + 1];
 EXPORT_SYMBOL_GPL(zfcpdump_save_areas);
 
 #else
-#define smp_get_save_areas() do { } while (0)
-#endif
+
+static inline void smp_get_save_area(unsigned int cpu, unsigned int phy_cpu) { }
+
+#endif /* CONFIG_ZFCPDUMP || CONFIG_ZFCPDUMP_MODULE */
 
 /*
  * Lets check how many CPUs we have.
  */
-
 static unsigned int __init smp_count_cpus(void)
 {
 	unsigned int cpu, num_cpus;
@@ -470,7 +452,6 @@ static unsigned int __init smp_count_cpu
 	/*
 	 * cpu 0 is the boot cpu. See smp_prepare_boot_cpu.
 	 */
-
 	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
 	current_thread_info()->cpu = 0;
 	num_cpus = 1;
@@ -480,12 +461,11 @@ static unsigned int __init smp_count_cpu
 		__cpu_logical_map[1] = (__u16) cpu;
 		if (signal_processor(1, sigp_sense) == sigp_not_operational)
 			continue;
+		smp_get_save_area(num_cpus, cpu);
 		num_cpus++;
 	}
-
 	printk("Detected %d CPU's\n", (int) num_cpus);
 	printk("Boot cpu address %2X\n", boot_cpu_addr);
-
 	return num_cpus;
 }
 
@@ -606,7 +586,6 @@ void __init smp_setup_cpu_possible_map(v
 {
 	unsigned int phy_cpus, pos_cpus, cpu;
 
-	smp_get_save_areas();
 	phy_cpus = smp_count_cpus();
 	pos_cpus = min(phy_cpus + additional_cpus, (unsigned int) NR_CPUS);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
