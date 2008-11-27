Return-Path: <linux-kernel-owner+w=401wt.eu-S1755801AbYK0Kuy@vger.kernel.org>
Message-Id: <20081127103142.936494036@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 54/60] convert cpu related printks to pr_xxx macros.
Content-Disposition: inline; filename=169-kmsg-cpu.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/Makefile    |    4 -
 arch/s390/kernel/processor.c |   98 +++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/setup.c     |   88 --------------------------------------
 arch/s390/kernel/smp.c       |   17 +++----
 arch/s390/kernel/topology.c  |    5 +-
 5 files changed, 112 insertions(+), 100 deletions(-)

Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -17,8 +17,8 @@ CFLAGS_smp.o	:= -Wno-nonnull
 #
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
-obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o \
-            setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
+obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o setup.o \
+	    processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 	    s390_ext.o debug.o irq.o ipl.o dis.o diag.o mem_detect.o \
 	    vdso.o
 
Index: quilt-2.6/arch/s390/kernel/processor.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/processor.c
@@ -0,0 +1,98 @@
+/*
+ *  arch/s390/kernel/processor.c
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ */
+
+#define KMSG_COMPONENT "cpu"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+
+#include <asm/elf.h>
+#include <asm/lowcore.h>
+#include <asm/param.h>
+
+void __cpuinit print_cpu_info(struct cpuinfo_S390 *cpuinfo)
+{
+	pr_info("Processor %d started, address %d, identification %06X\n",
+		cpuinfo->cpu_nr, cpuinfo->cpu_addr, cpuinfo->cpu_id.ident);
+}
+
+/*
+ * show_cpuinfo - Get information on one CPU for use by procfs.
+ */
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	static const char *hwcap_str[8] = {
+		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp",
+		"edat"
+	};
+       struct cpuinfo_S390 *cpuinfo;
+       unsigned long n = (unsigned long) v - 1;
+       int i;
+
+       s390_adjust_jiffies();
+       preempt_disable();
+       if (!n) {
+	       seq_printf(m, "vendor_id       : IBM/S390\n"
+			  "# processors    : %i\n"
+			  "bogomips per cpu: %lu.%02lu\n",
+			  num_online_cpus(), loops_per_jiffy/(500000/HZ),
+			  (loops_per_jiffy/(5000/HZ))%100);
+	       seq_puts(m, "features\t: ");
+	       for (i = 0; i < 8; i++)
+		       if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
+			       seq_printf(m, "%s ", hwcap_str[i]);
+	       seq_puts(m, "\n");
+       }
+
+       if (cpu_online(n)) {
+#ifdef CONFIG_SMP
+	       if (smp_processor_id() == n)
+		       cpuinfo = &S390_lowcore.cpu_data;
+	       else
+		       cpuinfo = &lowcore_ptr[n]->cpu_data;
+#else
+	       cpuinfo = &S390_lowcore.cpu_data;
+#endif
+	       seq_printf(m, "processor %li: "
+			  "version = %02X,  "
+			  "identification = %06X,  "
+			  "machine = %04X\n",
+			  n, cpuinfo->cpu_id.version,
+			  cpuinfo->cpu_id.ident,
+			  cpuinfo->cpu_id.machine);
+       }
+       preempt_enable();
+       return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
+};
+
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -35,7 +35,6 @@
 #include <linux/bootmem.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
-#include <linux/seq_file.h>
 #include <linux/kernel_stat.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
@@ -826,90 +825,3 @@ setup_arch(char **cmdline_p)
 	/* Setup zfcpdump support */
 	setup_zfcpdump(console_devno);
 }
-
-void __cpuinit print_cpu_info(struct cpuinfo_S390 *cpuinfo)
-{
-   printk(KERN_INFO "cpu %d "
-#ifdef CONFIG_SMP
-           "phys_idx=%d "
-#endif
-           "vers=%02X ident=%06X machine=%04X unused=%04X\n",
-           cpuinfo->cpu_nr,
-#ifdef CONFIG_SMP
-           cpuinfo->cpu_addr,
-#endif
-           cpuinfo->cpu_id.version,
-           cpuinfo->cpu_id.ident,
-           cpuinfo->cpu_id.machine,
-           cpuinfo->cpu_id.unused);
-}
-
-/*
- * show_cpuinfo - Get information on one CPU for use by procfs.
- */
-
-static int show_cpuinfo(struct seq_file *m, void *v)
-{
-	static const char *hwcap_str[8] = {
-		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp",
-		"edat"
-	};
-        struct cpuinfo_S390 *cpuinfo;
-	unsigned long n = (unsigned long) v - 1;
-	int i;
-
-	s390_adjust_jiffies();
-	preempt_disable();
-	if (!n) {
-		seq_printf(m, "vendor_id       : IBM/S390\n"
-			       "# processors    : %i\n"
-			       "bogomips per cpu: %lu.%02lu\n",
-			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
-			       (loops_per_jiffy/(5000/HZ))%100);
-		seq_puts(m, "features\t: ");
-		for (i = 0; i < 8; i++)
-			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
-				seq_printf(m, "%s ", hwcap_str[i]);
-		seq_puts(m, "\n");
-	}
-
-	if (cpu_online(n)) {
-#ifdef CONFIG_SMP
-		if (smp_processor_id() == n)
-			cpuinfo = &S390_lowcore.cpu_data;
-		else
-			cpuinfo = &lowcore_ptr[n]->cpu_data;
-#else
-		cpuinfo = &S390_lowcore.cpu_data;
-#endif
-		seq_printf(m, "processor %li: "
-			       "version = %02X,  "
-			       "identification = %06X,  "
-			       "machine = %04X\n",
-			       n, cpuinfo->cpu_id.version,
-			       cpuinfo->cpu_id.ident,
-			       cpuinfo->cpu_id.machine);
-	}
-	preempt_enable();
-        return 0;
-}
-
-static void *c_start(struct seq_file *m, loff_t *pos)
-{
-	return *pos < NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
-}
-static void *c_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	++*pos;
-	return c_start(m, pos);
-}
-static void c_stop(struct seq_file *m, void *v)
-{
-}
-const struct seq_operations cpuinfo_op = {
-	.start	= c_start,
-	.next	= c_next,
-	.stop	= c_stop,
-	.show	= show_cpuinfo,
-};
-
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -20,6 +20,9 @@
  * cpu_number_map in other architectures.
  */
 
+#define KMSG_COMPONENT "cpu"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -251,8 +254,8 @@ static void __init smp_get_save_area(uns
 	if (ipl_info.type != IPL_TYPE_FCP_DUMP)
 		return;
 	if (cpu >= NR_CPUS) {
-		printk(KERN_WARNING "Registers for cpu %i not saved since dump "
-		       "kernel was compiled with NR_CPUS=%i\n", cpu, NR_CPUS);
+		pr_warning("CPU %i exceeds the maximum %i and is excluded from "
+			   "the dump\n", cpu, NR_CPUS - 1);
 		return;
 	}
 	zfcpdump_save_areas[cpu] = kmalloc(sizeof(union save_area), GFP_KERNEL);
@@ -425,7 +428,7 @@ static void __init smp_detect_cpus(void)
 	}
 out:
 	kfree(info);
-	printk(KERN_INFO "CPUs: %d configured, %d standby\n", c_cpus, s_cpus);
+	pr_info("%d configured CPUs, %d standby CPUs\n", c_cpus, s_cpus);
 	get_online_cpus();
 	__smp_rescan_cpus();
 	put_online_cpus();
@@ -553,12 +556,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 	ccode = signal_processor_p((__u32)(unsigned long)(lowcore_ptr[cpu]),
 				   cpu, sigp_set_prefix);
-	if (ccode) {
-		printk("sigp_set_prefix failed for cpu %d "
-		       "with condition code %d\n",
-		       (int) cpu, (int) ccode);
+	if (ccode)
 		return -EIO;
-	}
 
 	idle = current_set[cpu];
 	cpu_lowcore = lowcore_ptr[cpu];
@@ -641,7 +640,7 @@ void __cpu_die(unsigned int cpu)
 	while (!smp_cpu_not_running(cpu))
 		cpu_relax();
 	smp_free_lowcore(cpu);
-	printk(KERN_INFO "Processor %d spun down\n", cpu);
+	pr_info("Processor %d stopped\n", cpu);
 }
 
 void cpu_die(void)
Index: quilt-2.6/arch/s390/kernel/topology.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/topology.c
+++ quilt-2.6/arch/s390/kernel/topology.c
@@ -3,6 +3,9 @@
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "cpu"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -311,7 +314,7 @@ void __init s390_init_cpu_topology(void)
 	for (i = 0; i < info->mnest - 2; i++)
 		nr_cores *= info->mag[NR_MAG - 3 - i];
 
-	printk(KERN_INFO "CPU topology:");
+	pr_info("The CPU configuration topology of the machine is:");
 	for (i = 0; i < NR_MAG; i++)
 		printk(" %d", info->mag[i]);
 	printk(" / %d\n", info->mnest);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
