Return-Path: <linux-kernel-owner+w=401wt.eu-S1756511AbYBEPnF@vger.kernel.org>
Message-Id: <20080205153912.819982302@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/18] Fix couple of section mismatches.
Content-Disposition: inline; filename=008-section.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix couple of section mismatches. And since we touch the code
anyway change the IPL code to use C99 initializers.

Cc: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |    7 ++-----
 arch/s390/kernel/entry64.S |    7 ++-----
 arch/s390/kernel/ipl.c     |   27 ++++++++++++++++++---------
 arch/s390/kernel/setup.c   |    2 +-
 arch/s390/kernel/smp.c     |    6 +++---
 arch/s390/mm/vmem.c        |    2 +-
 6 files changed, 27 insertions(+), 24 deletions(-)

Index: quilt-2.6/arch/s390/kernel/entry64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry64.S
+++ quilt-2.6/arch/s390/kernel/entry64.S
@@ -11,6 +11,7 @@
 
 #include <linux/sys.h>
 #include <linux/linkage.h>
+#include <linux/init.h>
 #include <asm/cache.h>
 #include <asm/lowcore.h>
 #include <asm/errno.h>
@@ -801,9 +802,7 @@ mcck_return:
  * Restart interruption handler, kick starter for additional CPUs
  */
 #ifdef CONFIG_SMP
-#ifndef CONFIG_HOTPLUG_CPU
-	.section .init.text,"ax"
-#endif
+	__CPUINIT
 	.globl restart_int_handler
 restart_int_handler:
 	lg	%r15,__LC_SAVE_AREA+120 # load ksp
@@ -814,9 +813,7 @@ restart_int_handler:
 	lmg	%r6,%r15,__SF_GPRS(%r15) # load registers from clone
 	stosm	__SF_EMPTY(%r15),0x04	# now we can turn dat on
 	jg	start_secondary
-#ifndef CONFIG_HOTPLUG_CPU
 	.previous
-#endif
 #else
 /*
  * If we do not run with SMP enabled, let the new CPU crash ...
Index: quilt-2.6/arch/s390/kernel/entry.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry.S
+++ quilt-2.6/arch/s390/kernel/entry.S
@@ -11,6 +11,7 @@
 
 #include <linux/sys.h>
 #include <linux/linkage.h>
+#include <linux/init.h>
 #include <asm/cache.h>
 #include <asm/lowcore.h>
 #include <asm/errno.h>
@@ -830,9 +831,7 @@ mcck_return:
  * Restart interruption handler, kick starter for additional CPUs
  */
 #ifdef CONFIG_SMP
-#ifndef CONFIG_HOTPLUG_CPU
-	.section .init.text,"ax"
-#endif
+	__CPUINIT
 	.globl restart_int_handler
 restart_int_handler:
 	l	%r15,__LC_SAVE_AREA+60	# load ksp
@@ -845,9 +844,7 @@ restart_int_handler:
 	br	%r14			# branch to start_secondary
 restart_addr:
 	.long	start_secondary
-#ifndef CONFIG_HOTPLUG_CPU
 	.previous
-#endif
 #else
 /*
  * If we do not run with SMP enabled, let the new CPU crash ...
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -439,7 +439,7 @@ static void ipl_run(struct shutdown_trig
 		reipl_ccw_dev(&ipl_info.data.ccw.dev_id);
 }
 
-static int ipl_init(void)
+static int __init ipl_init(void)
 {
 	int rc;
 
@@ -471,8 +471,11 @@ out:
 	return 0;
 }
 
-static struct shutdown_action ipl_action = {SHUTDOWN_ACTION_IPL_STR, ipl_run,
-					    ipl_init};
+static struct shutdown_action __refdata ipl_action = {
+	.name	= SHUTDOWN_ACTION_IPL_STR,
+	.fn	= ipl_run,
+	.init	= ipl_init,
+};
 
 /*
  * reipl shutdown action: Reboot Linux on shutdown.
@@ -792,7 +795,7 @@ static int __init reipl_fcp_init(void)
 	return 0;
 }
 
-static int reipl_init(void)
+static int __init reipl_init(void)
 {
 	int rc;
 
@@ -819,8 +822,11 @@ static int reipl_init(void)
 	return 0;
 }
 
-static struct shutdown_action reipl_action = {SHUTDOWN_ACTION_REIPL_STR,
-					      reipl_run, reipl_init};
+static struct shutdown_action __refdata reipl_action = {
+	.name	= SHUTDOWN_ACTION_REIPL_STR,
+	.fn	= reipl_run,
+	.init	= reipl_init,
+};
 
 /*
  * dump shutdown action: Dump Linux on shutdown.
@@ -998,7 +1004,7 @@ static int __init dump_fcp_init(void)
 	return 0;
 }
 
-static int dump_init(void)
+static int __init dump_init(void)
 {
 	int rc;
 
@@ -1020,8 +1026,11 @@ static int dump_init(void)
 	return 0;
 }
 
-static struct shutdown_action dump_action = {SHUTDOWN_ACTION_DUMP_STR,
-					     dump_run, dump_init};
+static struct shutdown_action __refdata dump_action = {
+	.name	= SHUTDOWN_ACTION_DUMP_STR,
+	.fn	= dump_run,
+	.init	= dump_init,
+};
 
 /*
  * vmcmd shutdown action: Trigger vm command on shutdown.
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -77,7 +77,7 @@ unsigned long machine_flags = 0;
 unsigned long elf_hwcap = 0;
 char elf_platform[ELF_PLATFORM_SIZE];
 
-struct mem_chunk __initdata memory_chunk[MEMORY_CHUNKS];
+struct mem_chunk __meminitdata memory_chunk[MEMORY_CHUNKS];
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
 static unsigned long __initdata memory_end;
 
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -1007,7 +1007,7 @@ static struct notifier_block __cpuinitda
 	.notifier_call = smp_cpu_notify,
 };
 
-static int smp_add_present_cpu(int cpu)
+static int __devinit smp_add_present_cpu(int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
@@ -1035,8 +1035,8 @@ out:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static ssize_t rescan_store(struct sys_device *dev, const char *buf,
-			    size_t count)
+static ssize_t __ref rescan_store(struct sys_device *dev,
+				  const char *buf, size_t count)
 {
 	cpumask_t newcpus;
 	int cpu;
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -62,7 +62,7 @@ void __meminit memmap_init(unsigned long
 	}
 }
 
-static void __init_refok *vmem_alloc_pages(unsigned int order)
+static void __ref *vmem_alloc_pages(unsigned int order)
 {
 	if (slab_is_available())
 		return (void *)__get_free_pages(GFP_KERNEL, order);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
