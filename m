Return-Path: <linux-kernel-owner+w=401wt.eu-S1758623AbXEaPgD@vger.kernel.org>
Message-Id: <20070531153437.640366437@de.ibm.com>
References: <20070531142024.011160634@de.ibm.com>
Date: Thu, 31 May 2007 16:20:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/7] Fix section annotations.
Content-Disposition: inline; filename=005-sections.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use the __cpuinit instead of __devinit section annotations for code
that deals with cpu hotplug. In addition add some more annotations on
functions that have been left out so far.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |    4 ++--
 arch/s390/kernel/smp.c   |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -102,7 +102,7 @@ static struct resource data_resource = {
 /*
  * cpu_init() initializes state that is per-CPU.
  */
-void __devinit cpu_init (void)
+void __cpuinit cpu_init(void)
 {
         int addr = hard_smp_processor_id();
 
@@ -915,7 +915,7 @@ setup_arch(char **cmdline_p)
 	setup_zfcpdump(console_devno);
 }
 
-void print_cpu_info(struct cpuinfo_S390 *cpuinfo)
+void __cpuinit print_cpu_info(struct cpuinfo_S390 *cpuinfo)
 {
    printk("cpu %d "
 #ifdef CONFIG_SMP
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -492,7 +492,7 @@ static unsigned int __init smp_count_cpu
 /*
  *	Activate a secondary processor.
  */
-int __devinit start_secondary(void *cpuvoid)
+int __cpuinit start_secondary(void *cpuvoid)
 {
 	/* Setup the cpu */
 	cpu_init();
@@ -741,7 +741,7 @@ void __init smp_prepare_cpus(unsigned in
 			smp_create_idle(cpu);
 }
 
-void __devinit smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
 
@@ -750,7 +750,7 @@ void __devinit smp_prepare_boot_cpu(void
 	current_set[0] = current;
 }
 
-void smp_cpus_done(unsigned int max_cpus)
+void __init smp_cpus_done(unsigned int max_cpus)
 {
 	cpu_present_map = cpu_possible_map;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
