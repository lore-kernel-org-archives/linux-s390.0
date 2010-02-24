Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084449.045600757@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/32] [PATCH] smp: always reboot on cpu 0
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=109-smp-reboot-cpu0.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Always reboot on logical cpu 0. This makes sure that the IPL cpu is
always the same and usually avoids strange numbering schemes between
physical and logical cpus.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/smp.h      |   12 +++++++
 arch/s390/kernel/Makefile        |    2 +
 arch/s390/kernel/ipl.c           |   31 +++++++++++++++-----
 arch/s390/kernel/machine_kexec.c |   10 +++++-
 arch/s390/kernel/smp.c           |   36 +++++++++++++++++++++++
 arch/s390/kernel/switch_cpu.S    |   59 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/switch_cpu64.S  |   52 ++++++++++++++++++++++++++++++++++
 7 files changed, 191 insertions(+), 11 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/smp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/smp.h	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/smp.h	2010-02-24 09:44:24.000000000 +0100
@@ -31,6 +31,18 @@
 
 extern struct save_area *zfcpdump_save_areas[NR_CPUS + 1];
 
+extern void smp_switch_to_ipl_cpu(void (*func)(void *), void *);
+extern void smp_switch_to_cpu(void (*)(void *), void *, unsigned long sp,
+			      int from, int to);
+extern void smp_restart_cpu(void);
+
+#else /* CONFIG_SMP */
+
+static inline void smp_switch_to_ipl_cpu(void (*func)(void *), void *data)
+{
+	func(data);
+}
+
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/ipl.c	2010-02-24 09:44:24.000000000 +0100
@@ -553,7 +553,7 @@
 	return rc;
 }
 
-static void ipl_run(struct shutdown_trigger *trigger)
+static void __ipl_run(void *unused)
 {
 	diag308(DIAG308_IPL, NULL);
 	if (MACHINE_IS_VM)
@@ -562,6 +562,11 @@
 		reipl_ccw_dev(&ipl_info.data.ccw.dev_id);
 }
 
+static void ipl_run(struct shutdown_trigger *trigger)
+{
+	smp_switch_to_ipl_cpu(__ipl_run, NULL);
+}
+
 static int __init ipl_init(void)
 {
 	int rc;
@@ -1039,7 +1044,7 @@
 		sprintf(dst + pos, " PARM %s", vmparm);
 }
 
-static void reipl_run(struct shutdown_trigger *trigger)
+static void __reipl_run(void *unused)
 {
 	struct ccw_dev_id devid;
 	static char buf[128];
@@ -1087,6 +1092,11 @@
 	disabled_wait((unsigned long) __builtin_return_address(0));
 }
 
+static void reipl_run(struct shutdown_trigger *trigger)
+{
+	smp_switch_to_ipl_cpu(__reipl_run, NULL);
+}
+
 static void reipl_block_ccw_init(struct ipl_parameter_block *ipb)
 {
 	ipb->hdr.len = IPL_PARM_BLK_CCW_LEN;
@@ -1369,20 +1379,18 @@
 
 static struct kset *dump_kset;
 
-static void dump_run(struct shutdown_trigger *trigger)
+static void __dump_run(void *unused)
 {
 	struct ccw_dev_id devid;
 	static char buf[100];
 
 	switch (dump_method) {
 	case DUMP_METHOD_CCW_CIO:
-		smp_send_stop();
 		devid.devno = dump_block_ccw->ipl_info.ccw.devno;
 		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
 	case DUMP_METHOD_CCW_VM:
-		smp_send_stop();
 		sprintf(buf, "STORE STATUS");
 		__cpcmd(buf, NULL, 0, NULL);
 		sprintf(buf, "IPL %X", dump_block_ccw->ipl_info.ccw.devno);
@@ -1396,10 +1404,17 @@
 		diag308(DIAG308_SET, dump_block_fcp);
 		diag308(DIAG308_DUMP, NULL);
 		break;
-	case DUMP_METHOD_NONE:
-		return;
+	default:
+		break;
 	}
-	printk(KERN_EMERG "Dump failed!\n");
+}
+
+static void dump_run(struct shutdown_trigger *trigger)
+{
+	if (dump_method == DUMP_METHOD_NONE)
+		return;
+	smp_send_stop();
+	smp_switch_to_ipl_cpu(__dump_run, NULL);
 }
 
 static int __init dump_ccw_init(void)
Index: quilt-2.6/arch/s390/kernel/machine_kexec.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/machine_kexec.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/machine_kexec.c	2010-02-24 09:44:24.000000000 +0100
@@ -54,11 +54,11 @@
 {
 }
 
-void machine_kexec(struct kimage *image)
+static void __machine_kexec(void *data)
 {
 	relocate_kernel_t data_mover;
+	struct kimage *image = data;
 
-	smp_send_stop();
 	pfault_fini();
 	s390_reset_system();
 
@@ -68,3 +68,9 @@
 	(*data_mover)(&image->head, image->start);
 	for (;;);
 }
+
+void machine_kexec(struct kimage *image)
+{
+	smp_send_stop();
+	smp_switch_to_ipl_cpu(__machine_kexec, image);
+}
Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/Makefile	2010-02-24 09:44:24.000000000 +0100
@@ -32,6 +32,8 @@
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o topology.o
+obj-$(CONFIG_SMP)		+= $(if $(CONFIG_64BIT),switch_cpu64.o, \
+							switch_cpu.o)
 obj-$(CONFIG_HIBERNATION)	+= suspend.o swsusp_asm64.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/smp.c	2010-02-24 09:44:24.000000000 +0100
@@ -90,6 +90,39 @@
 	return 0;
 }
 
+void smp_switch_to_ipl_cpu(void (*func)(void *), void *data)
+{
+	struct _lowcore *lc, *current_lc;
+	struct stack_frame *sf;
+	struct pt_regs *regs;
+	unsigned long sp;
+
+	if (smp_processor_id() == 0)
+		func(data);
+	__load_psw_mask(PSW_BASE_BITS | PSW_DEFAULT_KEY);
+	/* Disable lowcore protection */
+	__ctl_clear_bit(0, 28);
+	current_lc = lowcore_ptr[smp_processor_id()];
+	lc = lowcore_ptr[0];
+	if (!lc)
+		lc = current_lc;
+	lc->restart_psw.mask = PSW_BASE_BITS | PSW_DEFAULT_KEY;
+	lc->restart_psw.addr = PSW_ADDR_AMODE | (unsigned long) smp_restart_cpu;
+	if (!cpu_online(0))
+		smp_switch_to_cpu(func, data, 0, stap(), __cpu_logical_map[0]);
+	while (signal_processor(0, sigp_stop_and_store_status) == sigp_busy)
+		cpu_relax();
+	sp = lc->panic_stack;
+	sp -= sizeof(struct pt_regs);
+	regs = (struct pt_regs *) sp;
+	memcpy(&regs->gprs, &current_lc->gpregs_save_area, sizeof(regs->gprs));
+	memcpy(&regs->psw, &current_lc->st_status_fixed_logout, sizeof(psw_t));
+	sp -= STACK_FRAME_OVERHEAD;
+	sf = (struct stack_frame *) sp;
+	sf->back_chain = regs->gprs[15];
+	smp_switch_to_cpu(func, data, sp, stap(), __cpu_logical_map[0]);
+}
+
 void smp_send_stop(void)
 {
 	int cpu, rc;
@@ -752,7 +785,8 @@
 	get_online_cpus();
 	mutex_lock(&smp_cpu_state_mutex);
 	rc = -EBUSY;
-	if (cpu_online(cpu))
+	/* disallow configuration changes of online cpus and cpu 0 */
+	if (cpu_online(cpu) || cpu == 0)
 		goto out;
 	rc = 0;
 	switch (val) {
Index: quilt-2.6/arch/s390/kernel/switch_cpu64.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/kernel/switch_cpu64.S	2010-02-24 09:44:24.000000000 +0100
@@ -0,0 +1,52 @@
+/*
+ * 64-bit switch cpu code
+ *
+ * Copyright IBM Corp. 2009
+ *
+ */
+
+#include <asm/asm-offsets.h>
+#include <asm/lowcore.h>
+#include <asm/ptrace.h>
+
+# smp_switch_to_cpu switches to destination cpu and executes the passed function
+# Parameter: %r2 - function to call
+#	     %r3 - function parameter
+#	     %r4 - stack poiner
+#	     %r5 - current cpu
+#	     %r6 - destination cpu
+
+	.section .text
+	.align 4
+	.globl smp_switch_to_cpu
+smp_switch_to_cpu:
+	stmg	%r6,%r15,__SF_GPRS(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-STACK_FRAME_OVERHEAD
+	stg	%r1,__SF_BACKCHAIN(%r15)
+	larl	%r1,.gprregs
+	stmg	%r0,%r15,0(%r1)
+1:	sigp	%r0,%r6,__SIGP_RESTART	/* start destination CPU */
+	brc	2,1b			/* busy, try again */
+2:	sigp	%r0,%r5,__SIGP_STOP	/* stop current CPU */
+	brc	2,2b			/* busy, try again */
+3:	j	3b
+
+	.globl	smp_restart_cpu
+smp_restart_cpu:
+	larl	%r1,.gprregs
+	lmg	%r0,%r15,0(%r1)
+1:	sigp	%r0,%r5,__SIGP_SENSE	/* Wait for calling CPU */
+	brc	10,1b			/* busy, accepted (status 0), running */
+	tmll	%r0,0x40		/* Test if calling CPU is stopped */
+	jz	1b
+	ltgr	%r4,%r4			/* New stack ? */
+	jz	1f
+	lgr	%r15,%r4
+1:	basr	%r14,%r2
+
+	.section .data,"aw",@progbits
+.gprregs:
+	.rept	16
+	.quad	0
+	.endr
Index: quilt-2.6/arch/s390/kernel/switch_cpu.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/kernel/switch_cpu.S	2010-02-24 09:44:24.000000000 +0100
@@ -0,0 +1,59 @@
+/*
+ * 31-bit switch cpu code
+ *
+ * Copyright IBM Corp. 2009
+ *
+ */
+
+#include <asm/asm-offsets.h>
+#include <asm/lowcore.h>
+#include <asm/ptrace.h>
+
+# smp_switch_to_cpu switches to destination cpu and executes the passed function
+# Parameter: %r2 - function to call
+#	     %r3 - function parameter
+#	     %r4 - stack poiner
+#	     %r5 - current cpu
+#	     %r6 - destination cpu
+
+	.section .text
+	.align 4
+	.globl smp_switch_to_cpu
+smp_switch_to_cpu:
+	stm	%r6,%r15,__SF_GPRS(%r15)
+	lr	%r1,%r15
+	ahi	%r15,-STACK_FRAME_OVERHEAD
+	st	%r1,__SF_BACKCHAIN(%r15)
+	basr	%r13,0
+0:	la	%r1,.gprregs_addr-0b(%r13)
+	l	%r1,0(%r1)
+	stm	%r0,%r15,0(%r1)
+1:	sigp	%r0,%r6,__SIGP_RESTART	/* start destination CPU */
+	brc	2,1b			/* busy, try again */
+2:	sigp	%r0,%r5,__SIGP_STOP	/* stop current CPU */
+	brc	2,2b			/* busy, try again */
+3:	j	3b
+
+	.globl	smp_restart_cpu
+smp_restart_cpu:
+	basr	%r13,0
+0:	la	%r1,.gprregs_addr-0b(%r13)
+	l	%r1,0(%r1)
+	lm	%r0,%r15,0(%r1)
+1:	sigp	%r0,%r5,__SIGP_SENSE	/* Wait for calling CPU */
+	brc	10,1b			/* busy, accepted (status 0), running */
+	tmll	%r0,0x40		/* Test if calling CPU is stopped */
+	jz	1b
+	ltr	%r4,%r4			/* New stack ? */
+	jz	1f
+	lr	%r15,%r4
+1:	basr	%r14,%r2
+
+.gprregs_addr:
+	.long	.gprregs
+
+	.section .data,"aw",@progbits
+.gprregs:
+	.rept	16
+	.long	0
+	.endr
