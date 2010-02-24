Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084450.396413374@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/32] [PATCH] smp: rework sigp code
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=115-smp-sigp-rework.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Rename signal_processor* functions to sigp*.
Add raw variants of each version, so we can get rid of the hacks played
in smp code which establish temporary cpu logical mappings so they could
call the sigp functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/sigp.h |  100 +++++++++++++++++++++----------------------
 arch/s390/include/asm/smp.h  |    4 -
 arch/s390/kernel/ipl.c       |    2 
 arch/s390/kernel/smp.c       |   54 ++++++++++-------------
 4 files changed, 76 insertions(+), 84 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/sigp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/sigp.h	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/sigp.h	2010-02-24 09:44:25.000000000 +0100
@@ -1,24 +1,19 @@
 /*
- *  include/asm-s390/sigp.h
+ *  Routines and structures for signalling other processors.
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
- *               Martin Schwidefsky (schwidefsky@de.ibm.com)
- *               Heiko Carstens (heiko.carstens@de.ibm.com)
- *
- *  sigp.h by D.J. Barrow (c) IBM 1999
- *  contains routines / structures for signalling other S/390 processors in an
- *  SMP configuration.
+ *    Copyright IBM Corp. 1999,2010
+ *    Author(s): Denis Joseph Barrow,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
  */
 
-#ifndef __SIGP__
-#define __SIGP__
+#ifndef __ASM_SIGP_H
+#define __ASM_SIGP_H
 
 #include <asm/system.h>
 
-/* get real cpu address from logical cpu number */
-extern int __cpu_logical_map[];
+/* Get real cpu address from logical cpu number. */
+extern unsigned short __cpu_logical_map[];
 
 static inline int cpu_logical_map(int cpu)
 {
@@ -29,8 +24,7 @@
 #endif
 }
 
-typedef enum
-{
+enum {
 	sigp_sense = 1,
 	sigp_external_call = 2,
 	sigp_emergency_signal = 3,
@@ -46,88 +40,92 @@
 	sigp_set_architecture = 18,
 	sigp_conditional_emergency_signal = 19,
 	sigp_sense_running = 21,
-} sigp_order_code;
-
-typedef __u32 sigp_status_word;
+};
 
-typedef enum
-{
+enum {
 	sigp_order_code_accepted = 0,
 	sigp_status_stored = 1,
 	sigp_busy = 2,
 	sigp_not_operational = 3,
-} sigp_ccode;
-
+};
 
 /*
- * Definitions for the external call
+ * Definitions for external call.
  */
-
-/* 'Bit' signals, asynchronous */
-typedef enum
-{
-	ec_schedule=0,
+enum {
+	ec_schedule = 0,
 	ec_call_function,
 	ec_call_function_single,
-} ec_bit_sig;
+};
 
 /*
- * Signal processor
+ * Signal processor.
  */
-static inline sigp_ccode
-signal_processor(__u16 cpu_addr, sigp_order_code order_code)
+static inline int raw_sigp(u16 cpu, int order)
 {
 	register unsigned long reg1 asm ("1") = 0;
-	sigp_ccode ccode;
+	int ccode;
 
 	asm volatile(
 		"	sigp	%1,%2,0(%3)\n"
 		"	ipm	%0\n"
 		"	srl	%0,28\n"
 		:	"=d"	(ccode)
-		: "d" (reg1), "d" (cpu_logical_map(cpu_addr)),
-		  "a" (order_code) : "cc" , "memory");
+		: "d" (reg1), "d" (cpu),
+		  "a" (order) : "cc" , "memory");
 	return ccode;
 }
 
 /*
- * Signal processor with parameter
+ * Signal processor with parameter.
  */
-static inline sigp_ccode
-signal_processor_p(__u32 parameter, __u16 cpu_addr, sigp_order_code order_code)
+static inline int raw_sigp_p(u32 parameter, u16 cpu, int order)
 {
 	register unsigned int reg1 asm ("1") = parameter;
-	sigp_ccode ccode;
+	int ccode;
 
 	asm volatile(
 		"	sigp	%1,%2,0(%3)\n"
 		"	ipm	%0\n"
 		"	srl	%0,28\n"
 		: "=d" (ccode)
-		: "d" (reg1), "d" (cpu_logical_map(cpu_addr)),
-		  "a" (order_code) : "cc" , "memory");
+		: "d" (reg1), "d" (cpu),
+		  "a" (order) : "cc" , "memory");
 	return ccode;
 }
 
 /*
- * Signal processor with parameter and return status
+ * Signal processor with parameter and return status.
  */
-static inline sigp_ccode
-signal_processor_ps(__u32 *statusptr, __u32 parameter, __u16 cpu_addr,
-		    sigp_order_code order_code)
+static inline int raw_sigp_ps(u32 *status, u32 parm, u16 cpu, int order)
 {
-	register unsigned int reg1 asm ("1") = parameter;
-	sigp_ccode ccode;
+	register unsigned int reg1 asm ("1") = parm;
+	int ccode;
 
 	asm volatile(
 		"	sigp	%1,%2,0(%3)\n"
 		"	ipm	%0\n"
 		"	srl	%0,28\n"
 		: "=d" (ccode), "+d" (reg1)
-		: "d" (cpu_logical_map(cpu_addr)), "a" (order_code)
+		: "d" (cpu), "a" (order)
 		: "cc" , "memory");
-	*statusptr = reg1;
+	*status = reg1;
 	return ccode;
 }
 
-#endif /* __SIGP__ */
+static inline int sigp(int cpu, int order)
+{
+	return raw_sigp(cpu_logical_map(cpu), order);
+}
+
+static inline int sigp_p(u32 parameter, int cpu, int order)
+{
+	return raw_sigp_p(parameter, cpu_logical_map(cpu), order);
+}
+
+static inline int sigp_ps(u32 *status, u32 parm, int cpu, int order)
+{
+	return raw_sigp_ps(status, parm, cpu_logical_map(cpu), order);
+}
+
+#endif /* __ASM_SIGP_H */
Index: quilt-2.6/arch/s390/include/asm/smp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/smp.h	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/smp.h	2010-02-24 09:44:25.000000000 +0100
@@ -42,9 +42,9 @@
  */
 static inline int smp_vcpu_scheduled(int cpu)
 {
-	__u32 status = 0;
+	u32 status;
 
-	switch (signal_processor_ps(&status, 0, cpu, sigp_sense_running)) {
+	switch (sigp_ps(&status, 0, cpu, sigp_sense_running)) {
 	case sigp_status_stored:
 		/* Check for running status */
 		if (status & 0x400)
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/ipl.c	2010-02-24 09:44:25.000000000 +0100
@@ -1610,7 +1610,7 @@
 {
 	if (strcmp(trigger->name, ON_PANIC_STR) == 0)
 		disabled_wait((unsigned long) __builtin_return_address(0));
-	while (signal_processor(smp_processor_id(), sigp_stop) == sigp_busy)
+	while (sigp(smp_processor_id(), sigp_stop) == sigp_busy)
 		cpu_relax();
 	for (;;);
 }
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/smp.c	2010-02-24 09:44:25.000000000 +0100
@@ -53,7 +53,7 @@
 #include "entry.h"
 
 /* logical cpu to cpu address */
-int __cpu_logical_map[NR_CPUS];
+unsigned short __cpu_logical_map[NR_CPUS];
 
 static struct task_struct *current_set[NR_CPUS];
 
@@ -72,13 +72,13 @@
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
-static void smp_ext_bitcall(int, ec_bit_sig);
+static void smp_ext_bitcall(int, int);
 
-static int cpu_stopped(int cpu)
+static int raw_cpu_stopped(int cpu)
 {
-	__u32 status;
+	u32 status;
 
-	switch (signal_processor_ps(&status, 0, cpu, sigp_sense)) {
+	switch (raw_sigp_ps(&status, 0, cpu, sigp_sense)) {
 	case sigp_status_stored:
 		/* Check for stopped and check stop state */
 		if (status & 0x50)
@@ -90,6 +90,11 @@
 	return 0;
 }
 
+static inline int cpu_stopped(int cpu)
+{
+	return raw_cpu_stopped(cpu_logical_map(cpu));
+}
+
 void smp_switch_to_ipl_cpu(void (*func)(void *), void *data)
 {
 	struct _lowcore *lc, *current_lc;
@@ -110,7 +115,7 @@
 	lc->restart_psw.addr = PSW_ADDR_AMODE | (unsigned long) smp_restart_cpu;
 	if (!cpu_online(0))
 		smp_switch_to_cpu(func, data, 0, stap(), __cpu_logical_map[0]);
-	while (signal_processor(0, sigp_stop_and_store_status) == sigp_busy)
+	while (sigp(0, sigp_stop_and_store_status) == sigp_busy)
 		cpu_relax();
 	sp = lc->panic_stack;
 	sp -= sizeof(struct pt_regs);
@@ -136,7 +141,7 @@
 		if (cpu == smp_processor_id())
 			continue;
 		do {
-			rc = signal_processor(cpu, sigp_stop);
+			rc = sigp(cpu, sigp_stop);
 		} while (rc == sigp_busy);
 
 		while (!cpu_stopped(cpu))
@@ -172,13 +177,13 @@
  * Send an external call sigp to another cpu and return without waiting
  * for its completion.
  */
-static void smp_ext_bitcall(int cpu, ec_bit_sig sig)
+static void smp_ext_bitcall(int cpu, int sig)
 {
 	/*
 	 * Set signaling bit in lowcore of target cpu and kick it
 	 */
 	set_bit(sig, (unsigned long *) &lowcore_ptr[cpu]->ext_call_fast);
-	while (signal_processor(cpu, sigp_emergency_signal) == sigp_busy)
+	while (sigp(cpu, sigp_emergency_signal) == sigp_busy)
 		udelay(10);
 }
 
@@ -272,13 +277,6 @@
 }
 EXPORT_SYMBOL(smp_ctl_clear_bit);
 
-/*
- * In early ipl state a temp. logically cpu number is needed, so the sigp
- * functions can be used to sense other cpus. Since NR_CPUS is >= 2 on
- * CONFIG_SMP and the ipl cpu is logical cpu 0, it must be 1.
- */
-#define CPU_INIT_NO	1
-
 #ifdef CONFIG_ZFCPDUMP
 
 static void __init smp_get_save_area(unsigned int cpu, unsigned int phy_cpu)
@@ -291,9 +289,7 @@
 		return;
 	}
 	zfcpdump_save_areas[cpu] = kmalloc(sizeof(struct save_area), GFP_KERNEL);
-	__cpu_logical_map[CPU_INIT_NO] = (__u16) phy_cpu;
-	while (signal_processor(CPU_INIT_NO, sigp_stop_and_store_status) ==
-	       sigp_busy)
+	while (raw_sigp(phy_cpu, sigp_stop_and_store_status) == sigp_busy)
 		cpu_relax();
 	memcpy(zfcpdump_save_areas[cpu],
 	       (void *)(unsigned long) store_prefix() + SAVE_AREA_BASE,
@@ -409,8 +405,7 @@
 		for (cpu = 0; cpu <= MAX_CPU_ADDRESS; cpu++) {
 			if (cpu == boot_cpu_addr)
 				continue;
-			__cpu_logical_map[CPU_INIT_NO] = cpu;
-			if (!cpu_stopped(CPU_INIT_NO))
+			if (!raw_cpu_stopped(cpu))
 				continue;
 			smp_get_save_area(c_cpus, cpu);
 			c_cpus++;
@@ -433,8 +428,7 @@
 		cpu_addr = info->cpu[cpu].address;
 		if (cpu_addr == boot_cpu_addr)
 			continue;
-		__cpu_logical_map[CPU_INIT_NO] = cpu_addr;
-		if (!cpu_stopped(CPU_INIT_NO)) {
+		if (!raw_cpu_stopped(cpu_addr)) {
 			s_cpus++;
 			continue;
 		}
@@ -553,18 +547,18 @@
 /* Upping and downing of CPUs */
 int __cpuinit __cpu_up(unsigned int cpu)
 {
-	struct task_struct *idle;
 	struct _lowcore *cpu_lowcore;
+	struct task_struct *idle;
 	struct stack_frame *sf;
-	sigp_ccode ccode;
 	u32 lowcore;
+	int ccode;
 
 	if (smp_cpu_state[cpu] != CPU_STATE_CONFIGURED)
 		return -EIO;
 	if (smp_alloc_lowcore(cpu))
 		return -ENOMEM;
 	do {
-		ccode = signal_processor(cpu, sigp_initial_cpu_reset);
+		ccode = sigp(cpu, sigp_initial_cpu_reset);
 		if (ccode == sigp_busy)
 			udelay(10);
 		if (ccode == sigp_not_operational)
@@ -572,7 +566,7 @@
 	} while (ccode == sigp_busy);
 
 	lowcore = (u32)(unsigned long)lowcore_ptr[cpu];
-	while (signal_processor_p(lowcore, cpu, sigp_set_prefix) == sigp_busy)
+	while (sigp_p(lowcore, cpu, sigp_set_prefix) == sigp_busy)
 		udelay(10);
 
 	idle = current_set[cpu];
@@ -598,7 +592,7 @@
 	cpu_lowcore->ftrace_func = S390_lowcore.ftrace_func;
 	eieio();
 
-	while (signal_processor(cpu, sigp_restart) == sigp_busy)
+	while (sigp(cpu, sigp_restart) == sigp_busy)
 		udelay(10);
 
 	while (!cpu_online(cpu))
@@ -660,7 +654,7 @@
 	/* Wait until target cpu is down */
 	while (!cpu_stopped(cpu))
 		cpu_relax();
-	while (signal_processor_p(0, cpu, sigp_set_prefix) == sigp_busy)
+	while (sigp_p(0, cpu, sigp_set_prefix) == sigp_busy)
 		udelay(10);
 	smp_free_lowcore(cpu);
 	pr_info("Processor %d stopped\n", cpu);
@@ -669,7 +663,7 @@
 void cpu_die(void)
 {
 	idle_task_exit();
-	while (signal_processor(smp_processor_id(), sigp_stop) == sigp_busy)
+	while (sigp(smp_processor_id(), sigp_stop) == sigp_busy)
 		cpu_relax();
 	for (;;);
 }
