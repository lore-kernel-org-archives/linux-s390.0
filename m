Return-Path: <linux-kernel-owner+w=401wt.eu-S1757185AbZFDQTf@vger.kernel.org>
Message-Id: <20090604161900.659762303@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/38] s390: hibernation support for s390
Content-Disposition: inline; filename=pm_backend.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hans-Joachim Picht <hans@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hans-Joachim Picht <hans@linux.vnet.ibm.com>

This patch introduces the hibernation backend support to the 
s390 architecture. Now it is possible to suspend a mainframe Linux 
guest using the following command:

echo disk > /sys/power/state

Signed-off-by: Hans-Joachim Picht <hans@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/Kconfig               |    9 +
 arch/s390/Makefile              |    4 
 arch/s390/include/asm/suspend.h |    5 +
 arch/s390/include/asm/system.h  |   22 +++-
 arch/s390/kernel/early.c        |    6 -
 arch/s390/kernel/mem_detect.c   |   19 ---
 arch/s390/kernel/smp.c          |   38 +++++++
 arch/s390/power/Makefile        |    8 +
 arch/s390/power/suspend.c       |   40 ++++++++
 arch/s390/power/swsusp.c        |   31 ++++++
 arch/s390/power/swsusp_64.c     |   17 +++
 arch/s390/power/swsusp_asm64.S  |  199 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 371 insertions(+), 27 deletions(-)

Index: linux-2.6/arch/s390/include/asm/suspend.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/suspend.h
+++ linux-2.6/arch/s390/include/asm/suspend.h
@@ -1,5 +1,10 @@
 #ifndef __ASM_S390_SUSPEND_H
 #define __ASM_S390_SUSPEND_H
 
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
 #endif
 
Index: linux-2.6/arch/s390/Kconfig
===================================================================
--- linux-2.6.orig/arch/s390/Kconfig
+++ linux-2.6/arch/s390/Kconfig
@@ -343,6 +343,9 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 
+config ARCH_HIBERNATION_POSSIBLE
+       def_bool y
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
@@ -587,6 +590,12 @@ config SECCOMP
 
 endmenu
 
+menu "Power Management"
+
+source "kernel/power/Kconfig"
+
+endmenu
+
 source "net/Kconfig"
 
 config PCMCIA
Index: linux-2.6/arch/s390/Makefile
===================================================================
--- linux-2.6.orig/arch/s390/Makefile
+++ linux-2.6/arch/s390/Makefile
@@ -88,7 +88,9 @@ LDFLAGS_vmlinux := -e start
 head-y		:= arch/s390/kernel/head.o arch/s390/kernel/init_task.o
 
 core-y		+= arch/s390/mm/ arch/s390/kernel/ arch/s390/crypto/ \
-		   arch/s390/appldata/ arch/s390/hypfs/ arch/s390/kvm/
+		   arch/s390/appldata/ arch/s390/hypfs/ arch/s390/kvm/ \
+		   arch/s390/power/
+
 libs-y		+= arch/s390/lib/
 drivers-y	+= drivers/s390/
 drivers-$(CONFIG_MATHEMU) += arch/s390/math-emu/
Index: linux-2.6/arch/s390/power/Makefile
===================================================================
--- /dev/null
+++ linux-2.6/arch/s390/power/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for s390 PM support
+#
+
+obj-$(CONFIG_HIBERNATION) += suspend.o
+obj-$(CONFIG_HIBERNATION) += swsusp.o
+obj-$(CONFIG_HIBERNATION) += swsusp_64.o
+obj-$(CONFIG_HIBERNATION) += swsusp_asm64.o
Index: linux-2.6/arch/s390/power/suspend.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/s390/power/suspend.c
@@ -0,0 +1,40 @@
+/*
+ * Suspend support specific for s390.
+ *
+ * Copyright IBM Corp. 2009
+ *
+ * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <linux/reboot.h>
+#include <linux/pfn.h>
+#include <asm/sections.h>
+#include <asm/ipl.h>
+
+/*
+ * References to section boundaries
+ */
+extern const void __nosave_begin, __nosave_end;
+
+/*
+ *  check if given pfn is in the 'nosave' or in the read only NSS section
+ */
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end))
+					>> PAGE_SHIFT;
+	unsigned long eshared_pfn = PFN_DOWN(__pa(&_eshared)) - 1;
+	unsigned long stext_pfn = PFN_DOWN(__pa(&_stext));
+
+	if (pfn >= nosave_begin_pfn && pfn < nosave_end_pfn)
+		return 1;
+	if (pfn >= stext_pfn && pfn <= eshared_pfn) {
+		if (ipl_info.type == IPL_TYPE_NSS)
+			return 1;
+	} else if ((tprot(pfn * PAGE_SIZE) && pfn > 0))
+		return 1;
+	return 0;
+}
Index: linux-2.6/arch/s390/power/swsusp_64.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/s390/power/swsusp_64.c
@@ -0,0 +1,17 @@
+/*
+ * Support for suspend and resume on s390
+ *
+ * Copyright IBM Corp. 2009
+ *
+ * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
+ *
+ */
+
+#include <asm/system.h>
+#include <linux/interrupt.h>
+
+void do_after_copyback(void)
+{
+	mb();
+}
+
Index: linux-2.6/arch/s390/power/swsusp_asm64.S
===================================================================
--- /dev/null
+++ linux-2.6/arch/s390/power/swsusp_asm64.S
@@ -0,0 +1,199 @@
+/*
+ * S390 64-bit swsusp implementation
+ *
+ * Copyright IBM Corp. 2009
+ *
+ * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
+ *            Michael Holzheu <holzheu@linux.vnet.ibm.com>
+ */
+
+#include <asm/page.h>
+#include <asm/ptrace.h>
+#include <asm/asm-offsets.h>
+
+/*
+ * Save register context in absolute 0 lowcore and call swsusp_save() to
+ * create in-memory kernel image. The context is saved in the designated
+ * "store status" memory locations (see POP).
+ * We return from this function twice. The first time during the suspend to
+ * disk process. The second time via the swsusp_arch_resume() function
+ * (see below) in the resume process.
+ * This function runs with disabled interrupts.
+ */
+	.section .text
+	.align  2
+	.globl swsusp_arch_suspend
+swsusp_arch_suspend:
+	stmg	%r6,%r15,__SF_GPRS(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-STACK_FRAME_OVERHEAD
+	stg	%r1,__SF_BACKCHAIN(%r15)
+
+	/* Deactivate DAT */
+ 	stnsm	__SF_EMPTY(%r15),0xfb
+
+	/* Switch off lowcore protection */
+	stctg	%c0,%c0,__SF_EMPTY(%r15)
+	ni	__SF_EMPTY+4(%r15),0xef
+	lctlg	%c0,%c0,__SF_EMPTY(%r15)
+
+	/* Store prefix register on stack */
+	stpx	__SF_EMPTY(%r15)
+
+	/* Setup base register for lowcore (absolute 0) */
+	llgf	%r1,__SF_EMPTY(%r15)
+
+	/* Get pointer to save area */
+	aghi	%r1,0x1000
+
+	/* Store registers */
+	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
+	stfpc	0x31c(%r1)			/* store fpu control */
+	std	0,0x200(%r1)			/* store f0 */
+	std	1,0x208(%r1)			/* store f1 */
+	std	2,0x210(%r1)			/* store f2 */
+	std	3,0x218(%r1)			/* store f3 */
+	std	4,0x220(%r1)			/* store f4 */
+	std	5,0x228(%r1)			/* store f5 */
+	std	6,0x230(%r1)			/* store f6 */
+	std	7,0x238(%r1)			/* store f7 */
+	std	8,0x240(%r1)			/* store f8 */
+	std	9,0x248(%r1)			/* store f9 */
+	std	10,0x250(%r1)			/* store f10 */
+	std	11,0x258(%r1)			/* store f11 */
+	std	12,0x260(%r1)			/* store f12 */
+	std	13,0x268(%r1)			/* store f13 */
+	std	14,0x270(%r1)			/* store f14 */
+	std	15,0x278(%r1)			/* store f15 */
+	stam	%a0,%a15,0x340(%r1)		/* store access registers */
+	stctg	%c0,%c15,0x380(%r1)		/* store control registers */
+	stmg	%r0,%r15,0x280(%r1)		/* store general registers */
+
+	stpt	0x328(%r1)			/* store timer */
+	stckc	0x330(%r1)			/* store clock comparator */
+
+	/* Activate DAT */
+	stosm	__SF_EMPTY(%r15),0x04
+
+	/* Set prefix page to zero */
+	xc	__SF_EMPTY(4,%r15),__SF_EMPTY(%r15)
+	spx	__SF_EMPTY(%r15)
+
+	/* Setup lowcore */
+	brasl	%r14,setup_lowcore_early
+
+	/* Save image */
+	brasl	%r14,swsusp_save
+
+	/* Switch on lowcore protection */
+	stctg	%c0,%c0,__SF_EMPTY(%r15)
+	oi	__SF_EMPTY+4(%r15),0x10
+	lctlg	%c0,%c0,__SF_EMPTY(%r15)
+
+	/* Restore prefix register and return */
+	lghi	%r1,0x1000
+	spx	0x318(%r1)
+	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
+	lghi	%r2,0
+	br	%r14
+
+/*
+ * Restore saved memory image to correct place and restore register context.
+ * Then we return to the function that called swsusp_arch_suspend().
+ * swsusp_arch_resume() runs with disabled interrupts.
+ */
+	.globl swsusp_arch_resume
+swsusp_arch_resume:
+	stmg	%r6,%r15,__SF_GPRS(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-STACK_FRAME_OVERHEAD
+	stg	%r1,__SF_BACKCHAIN(%r15)
+
+	/* Save boot cpu number */
+	brasl	%r14,smp_get_phys_cpu_id
+	lgr	%r10,%r2
+
+	/* Deactivate DAT */
+ 	stnsm	__SF_EMPTY(%r15),0xfb
+
+	/* Switch off lowcore protection */
+	stctg	%c0,%c0,__SF_EMPTY(%r15)
+	ni	__SF_EMPTY+4(%r15),0xef
+	lctlg	%c0,%c0,__SF_EMPTY(%r15)
+
+	/* Set prefix page to zero */
+	xc	__SF_EMPTY(4,%r15),__SF_EMPTY(%r15)
+	spx	__SF_EMPTY(%r15)
+
+	/* Restore saved image */
+	larl	%r1,restore_pblist
+	lg	%r1,0(%r1)
+	ltgr	%r1,%r1
+	jz	2f
+0:
+	lg	%r2,8(%r1)
+	lg	%r4,0(%r1)
+	lghi	%r3,PAGE_SIZE
+	lghi	%r5,PAGE_SIZE
+1:
+	mvcle	%r2,%r4,0
+	jo	1b
+	lg	%r1,16(%r1)
+	ltgr	%r1,%r1
+	jnz	0b
+2:
+	ptlb				/* flush tlb */
+
+	/* Restore registers */
+	lghi	%r13,0x1000		/* %r1 = pointer to save arae */
+
+	spt	0x328(%r13)		/* reprogram timer */
+	//sckc	0x330(%r13)		/* set clock comparator */
+
+	lctlg	%c0,%c15,0x380(%r13)	/* load control registers */
+	lam	%a0,%a15,0x340(%r13)	/* load access registers */
+
+	lfpc	0x31c(%r13)		/* load fpu control */
+	ld	0,0x200(%r13)		/* load f0 */
+	ld	1,0x208(%r13)		/* load f1 */
+	ld	2,0x210(%r13)		/* load f2 */
+	ld	3,0x218(%r13)		/* load f3 */
+	ld	4,0x220(%r13)		/* load f4 */
+	ld	5,0x228(%r13)		/* load f5 */
+	ld	6,0x230(%r13)		/* load f6 */
+	ld	7,0x238(%r13)		/* load f7 */
+	ld	8,0x240(%r13)		/* load f8 */
+	ld	9,0x248(%r13)		/* load f9 */
+	ld	10,0x250(%r13)		/* load f10 */
+	ld	11,0x258(%r13)		/* load f11 */
+	ld	12,0x260(%r13)		/* load f12 */
+	ld	13,0x268(%r13)		/* load f13 */
+	ld	14,0x270(%r13)		/* load f14 */
+	ld	15,0x278(%r13)		/* load f15 */
+
+	/* Load old stack */
+	lg	%r15,0x2f8(%r13)
+
+	/* Pointer to save arae */
+	lghi	%r13,0x1000
+
+	/* Switch CPUs */
+	lgr	%r2,%r10		/* get cpu id */
+	llgf	%r3,0x318(%r13)
+	brasl	%r14,smp_switch_boot_cpu_in_resume
+
+	/* Restore prefix register */
+	spx	0x318(%r13)
+
+	/* Switch on lowcore protection */
+	stctg	%c0,%c0,__SF_EMPTY(%r15)
+	oi	__SF_EMPTY+4(%r15),0x10
+	lctlg	%c0,%c0,__SF_EMPTY(%r15)
+
+	/* Activate DAT */
+	stosm	__SF_EMPTY(%r15),0x04
+
+	/* Return 0 */
+	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
+	lghi	%r2,0
+	br	%r14
Index: linux-2.6/arch/s390/power/swsusp.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/s390/power/swsusp.c
@@ -0,0 +1,31 @@
+/*
+ * Support for suspend and resume on s390
+ *
+ * Copyright IBM Corp. 2009
+ *
+ * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/gfp.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/cpumask.h>
+#include <asm/ipl.h>
+#include <asm/processor.h>
+
+/*
+ * save CPU registers before creating a hibernation image and before
+ * restoring the memory state from it
+ */
+void save_processor_state(void)
+{
+}
+
+/*
+ * restore the contents of CPU registers
+ */
+void restore_processor_state(void)
+{
+}
Index: linux-2.6/arch/s390/kernel/early.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/early.c
+++ linux-2.6/arch/s390/kernel/early.c
@@ -1,7 +1,7 @@
 /*
  *  arch/s390/kernel/early.c
  *
- *    Copyright IBM Corp. 2007
+ *    Copyright IBM Corp. 2007, 2009
  *    Author(s): Hongjie Yang <hongjie@us.ibm.com>,
  *		 Heiko Carstens <heiko.carstens@de.ibm.com>
  */
@@ -209,7 +209,7 @@ static noinline __init void detect_machi
 		machine_flags |= MACHINE_FLAG_VM;
 }
 
-static __init void early_pgm_check_handler(void)
+static void early_pgm_check_handler(void)
 {
 	unsigned long addr;
 	const struct exception_table_entry *fixup;
@@ -221,7 +221,7 @@ static __init void early_pgm_check_handl
 	S390_lowcore.program_old_psw.addr = fixup->fixup | PSW_ADDR_AMODE;
 }
 
-static noinline __init void setup_lowcore_early(void)
+void setup_lowcore_early(void)
 {
 	psw_t psw;
 
Index: linux-2.6/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/smp.c
+++ linux-2.6/arch/s390/kernel/smp.c
@@ -1,7 +1,7 @@
 /*
  *  arch/s390/kernel/smp.c
  *
- *    Copyright IBM Corp. 1999,2007
+ *    Copyright IBM Corp. 1999, 2009
  *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  *		 Heiko Carstens (heiko.carstens@de.ibm.com)
@@ -1030,6 +1030,42 @@ out:
 static SYSDEV_CLASS_ATTR(dispatching, 0644, dispatching_show,
 			 dispatching_store);
 
+/*
+ * If the resume kernel runs on another cpu than the suspended kernel,
+ * we have to switch the cpu IDs in the logical map.
+ */
+void smp_switch_boot_cpu_in_resume(u32 resume_phys_cpu_id,
+				   struct _lowcore *suspend_lowcore)
+{
+	int cpu, suspend_cpu_id, resume_cpu_id;
+	u32 suspend_phys_cpu_id;
+
+	suspend_phys_cpu_id = __cpu_logical_map[suspend_lowcore->cpu_nr];
+	suspend_cpu_id = suspend_lowcore->cpu_nr;
+
+	for_each_present_cpu(cpu) {
+		if (__cpu_logical_map[cpu] == resume_phys_cpu_id) {
+			resume_cpu_id = cpu;
+			goto found;
+		}
+	}
+	panic("Could not find resume cpu in logical map.\n");
+
+found:
+	printk("Resume  cpu ID: %i/%i\n", resume_phys_cpu_id, resume_cpu_id);
+	printk("Suspend cpu ID: %i/%i\n", suspend_phys_cpu_id, suspend_cpu_id);
+
+	__cpu_logical_map[resume_cpu_id] = suspend_phys_cpu_id;
+	__cpu_logical_map[suspend_cpu_id] = resume_phys_cpu_id;
+
+	lowcore_ptr[suspend_cpu_id]->cpu_addr = resume_phys_cpu_id;
+}
+
+u32 smp_get_phys_cpu_id(void)
+{
+	return __cpu_logical_map[smp_processor_id()];
+}
+
 static int __init topology_init(void)
 {
 	int cpu;
Index: linux-2.6/arch/s390/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/system.h
+++ linux-2.6/arch/s390/include/asm/system.h
@@ -1,11 +1,7 @@
 /*
- *  include/asm-s390/system.h
+ * Copyright IBM Corp. 1999, 2009
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- *
- *  Derived from "include/asm-i386/system.h"
+ * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #ifndef __ASM_SYSTEM_H
@@ -469,6 +465,20 @@ extern psw_t sysc_restore_trace_psw;
 extern psw_t io_restore_trace_psw;
 #endif
 
+static inline int tprot(unsigned long addr)
+{
+	int rc = -EFAULT;
+
+	asm volatile(
+		"	tprot	0(%1),0\n"
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "+d" (rc) : "a" (addr) : "cc");
+	return rc;
+}
+
 #endif /* __KERNEL__ */
 
 #endif
Index: linux-2.6/arch/s390/kernel/mem_detect.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/mem_detect.c
+++ linux-2.6/arch/s390/kernel/mem_detect.c
@@ -1,6 +1,7 @@
 /*
- *    Copyright IBM Corp. 2008
- *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ * Copyright IBM Corp. 2008, 2009
+ *
+ * Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
 #include <linux/kernel.h>
@@ -9,20 +10,6 @@
 #include <asm/sclp.h>
 #include <asm/setup.h>
 
-static inline int tprot(unsigned long addr)
-{
-	int rc = -EFAULT;
-
-	asm volatile(
-		"	tprot	0(%1),0\n"
-		"0:	ipm	%0\n"
-		"	srl	%0,28\n"
-		"1:\n"
-		EX_TABLE(0b,1b)
-		: "+d" (rc) : "a" (addr) : "cc");
-	return rc;
-}
-
 #define ADDR2G (1ULL << 31)
 
 static void find_memory_chunks(struct mem_chunk chunk[])

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
