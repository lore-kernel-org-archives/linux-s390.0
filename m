Return-Path: <linux-kernel-owner+w=401wt.eu-S1757254AbZKMPR4@vger.kernel.org>
Message-Id: <20091113150911.043897623@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/52] [PATCH] smp: remove unused typedef and defines
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=109-smp-unused.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove unused typedef, defines, update copyright, remove unneeded
includes, remove unneeded ifdefs.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/smp.h |   54 ++++++++------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/smp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/smp.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/smp.h	2009-11-13 16:08:14.000000000 +0100
@@ -1,57 +1,22 @@
 /*
- *  include/asm-s390/smp.h
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
- *               Martin Schwidefsky (schwidefsky@de.ibm.com)
- *               Heiko Carstens (heiko.carstens@de.ibm.com)
+ *    Copyright IBM Corp. 1999,2009
+ *    Author(s): Denis Joseph Barrow,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
  */
 #ifndef __ASM_SMP_H
 #define __ASM_SMP_H
 
-#include <linux/threads.h>
-#include <linux/cpumask.h>
-#include <linux/bitops.h>
+#ifdef CONFIG_SMP
 
-#if defined(__KERNEL__) && defined(CONFIG_SMP) && !defined(__ASSEMBLY__)
-
-#include <asm/lowcore.h>
-#include <asm/sigp.h>
-#include <asm/ptrace.h>
 #include <asm/system.h>
-
-/*
-  s390 specific smp.c headers
- */
-typedef struct
-{
-	int        intresting;
-	sigp_ccode ccode; 
-	__u32      status;
-	__u16      cpu;
-} sigp_info;
+#include <asm/sigp.h>
 
 extern void machine_restart_smp(char *);
 extern void machine_halt_smp(void);
 extern void machine_power_off_smp(void);
 
-#define NO_PROC_ID		0xFF		/* No processor magic marker */
-
-/*
- *	This magic constant controls our willingness to transfer
- *	a process across CPUs. Such a transfer incurs misses on the L1
- *	cache, and on a P6 or P5 with multiple L2 caches L2 hits. My
- *	gut feeling is this will vary by board in value. For a board
- *	with separate L2 cache it probably depends also on the RSS, and
- *	for a board with shared L2 cache it ought to decay fast as other
- *	processes are run.
- */
- 
-#define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
-
 #define raw_smp_processor_id()	(S390_lowcore.cpu_nr)
-#define cpu_logical_map(cpu)	(cpu)
 
 extern int __cpu_disable (void);
 extern void __cpu_die (unsigned int cpu);
@@ -64,7 +29,9 @@
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
-#endif
+extern union save_area *zfcpdump_save_areas[NR_CPUS + 1];
+
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern int smp_rescan_cpus(void);
@@ -72,5 +39,4 @@
 static inline int smp_rescan_cpus(void) { return 0; }
 #endif
 
-extern union save_area *zfcpdump_save_areas[NR_CPUS + 1];
-#endif
+#endif /* __ASM_SMP_H */
