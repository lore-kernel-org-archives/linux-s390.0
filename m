Return-Path: <linux-kernel-owner+w=401wt.eu-S1756031AbZHNL2F@vger.kernel.org>
Message-Id: <20090814112616.998889316@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/34] hibernation: merge files and move to kernel/
Content-Disposition: inline; filename=118-pm-merge-files.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Merge the nearly empty C files and move everything from power/ to
kernel/. That way the files are easier to handle.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Makefile              |    3 
 arch/s390/kernel/Makefile       |    2 
 arch/s390/kernel/suspend.c      |   73 +++++++++++++++
 arch/s390/kernel/swsusp_asm64.S |  184 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/power/Makefile        |    7 -
 arch/s390/power/suspend.c       |   40 --------
 arch/s390/power/swsusp.c        |   42 ---------
 arch/s390/power/swsusp_asm64.S  |  184 ----------------------------------------
 8 files changed, 259 insertions(+), 276 deletions(-)

Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -32,7 +32,7 @@ extra-y				+= head.o init_task.o vmlinux
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o topology.o
-
+obj-$(CONFIG_HIBERNATION)	+= suspend.o swsusp_asm64.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o \
Index: quilt-2.6/arch/s390/kernel/suspend.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/suspend.c
@@ -0,0 +1,73 @@
+/*
+ * Suspend support specific for s390.
+ *
+ * Copyright IBM Corp. 2009
+ *
+ * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
+ */
+
+#include <linux/suspend.h>
+#include <linux/reboot.h>
+#include <linux/pfn.h>
+#include <linux/mm.h>
+#include <asm/sections.h>
+#include <asm/system.h>
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
+
+void save_processor_state(void)
+{
+	/* swsusp_arch_suspend() actually saves all cpu register contents.
+	 * Machine checks must be disabled since swsusp_arch_suspend() stores
+	 * register contents to their lowcore save areas. That's the same
+	 * place where register contents on machine checks would be saved.
+	 * To avoid register corruption disable machine checks.
+	 * We must also disable machine checks in the new psw mask for
+	 * program checks, since swsusp_arch_suspend() may generate program
+	 * checks. Disabling machine checks for all other new psw masks is
+	 * just paranoia.
+	 */
+	local_mcck_disable();
+	/* Disable lowcore protection */
+	__ctl_clear_bit(0,28);
+	S390_lowcore.external_new_psw.mask &= ~PSW_MASK_MCHECK;
+	S390_lowcore.svc_new_psw.mask &= ~PSW_MASK_MCHECK;
+	S390_lowcore.io_new_psw.mask &= ~PSW_MASK_MCHECK;
+	S390_lowcore.program_new_psw.mask &= ~PSW_MASK_MCHECK;
+}
+
+void restore_processor_state(void)
+{
+	S390_lowcore.external_new_psw.mask |= PSW_MASK_MCHECK;
+	S390_lowcore.svc_new_psw.mask |= PSW_MASK_MCHECK;
+	S390_lowcore.io_new_psw.mask |= PSW_MASK_MCHECK;
+	S390_lowcore.program_new_psw.mask |= PSW_MASK_MCHECK;
+	/* Enable lowcore protection */
+	__ctl_set_bit(0,28);
+	local_mcck_enable();
+}
Index: quilt-2.6/arch/s390/kernel/swsusp_asm64.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/swsusp_asm64.S
@@ -0,0 +1,184 @@
+/*
+ * S390 64-bit swsusp implementation
+ *
+ * Copyright IBM Corp. 2009
+ *
+ * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
+ *	      Michael Holzheu <holzheu@linux.vnet.ibm.com>
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
+	.align	4
+	.globl swsusp_arch_suspend
+swsusp_arch_suspend:
+	stmg	%r6,%r15,__SF_GPRS(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-STACK_FRAME_OVERHEAD
+	stg	%r1,__SF_BACKCHAIN(%r15)
+
+	/* Deactivate DAT */
+	stnsm	__SF_EMPTY(%r15),0xfb
+
+	/* Store prefix register on stack */
+	stpx	__SF_EMPTY(%r15)
+
+	/* Save prefix register contents for lowcore */
+	llgf	%r4,__SF_EMPTY(%r15)
+
+	/* Get pointer to save area */
+	lghi	%r1,0x1000
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
+	lghi	%r2,0
+	lghi	%r3,2*PAGE_SIZE
+	lghi	%r5,2*PAGE_SIZE
+1:	mvcle	%r2,%r4,0
+	jo	1b
+
+	/* Save image */
+	brasl	%r14,swsusp_save
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
+#ifdef CONFIG_SMP
+	/* Save boot cpu number */
+	brasl	%r14,smp_get_phys_cpu_id
+	lgr	%r10,%r2
+#endif
+	/* Deactivate DAT */
+	stnsm	__SF_EMPTY(%r15),0xfb
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
+	/* Pointer to save area */
+	lghi	%r13,0x1000
+
+#ifdef CONFIG_SMP
+	/* Switch CPUs */
+	lgr	%r2,%r10		/* get cpu id */
+	llgf	%r3,0x318(%r13)
+	brasl	%r14,smp_switch_boot_cpu_in_resume
+#endif
+	/* Restore prefix register */
+	spx	0x318(%r13)
+
+	/* Activate DAT */
+	stosm	__SF_EMPTY(%r15),0x04
+
+	/* Return 0 */
+	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
+	lghi	%r2,0
+	br	%r14
Index: quilt-2.6/arch/s390/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/Makefile
+++ quilt-2.6/arch/s390/Makefile
@@ -88,8 +88,7 @@ LDFLAGS_vmlinux := -e start
 head-y		:= arch/s390/kernel/head.o arch/s390/kernel/init_task.o
 
 core-y		+= arch/s390/mm/ arch/s390/kernel/ arch/s390/crypto/ \
-		   arch/s390/appldata/ arch/s390/hypfs/ arch/s390/kvm/ \
-		   arch/s390/power/
+		   arch/s390/appldata/ arch/s390/hypfs/ arch/s390/kvm/
 
 libs-y		+= arch/s390/lib/
 drivers-y	+= drivers/s390/
Index: quilt-2.6/arch/s390/power/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/power/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for s390 PM support
-#
-
-obj-$(CONFIG_HIBERNATION) += suspend.o
-obj-$(CONFIG_HIBERNATION) += swsusp.o
-obj-$(CONFIG_HIBERNATION) += swsusp_asm64.o
Index: quilt-2.6/arch/s390/power/suspend.c
===================================================================
--- quilt-2.6.orig/arch/s390/power/suspend.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Suspend support specific for s390.
- *
- * Copyright IBM Corp. 2009
- *
- * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
- */
-
-#include <linux/mm.h>
-#include <linux/suspend.h>
-#include <linux/reboot.h>
-#include <linux/pfn.h>
-#include <asm/sections.h>
-#include <asm/ipl.h>
-
-/*
- * References to section boundaries
- */
-extern const void __nosave_begin, __nosave_end;
-
-/*
- *  check if given pfn is in the 'nosave' or in the read only NSS section
- */
-int pfn_is_nosave(unsigned long pfn)
-{
-	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
-	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end))
-					>> PAGE_SHIFT;
-	unsigned long eshared_pfn = PFN_DOWN(__pa(&_eshared)) - 1;
-	unsigned long stext_pfn = PFN_DOWN(__pa(&_stext));
-
-	if (pfn >= nosave_begin_pfn && pfn < nosave_end_pfn)
-		return 1;
-	if (pfn >= stext_pfn && pfn <= eshared_pfn) {
-		if (ipl_info.type == IPL_TYPE_NSS)
-			return 1;
-	} else if ((tprot(pfn * PAGE_SIZE) && pfn > 0))
-		return 1;
-	return 0;
-}
Index: quilt-2.6/arch/s390/power/swsusp_asm64.S
===================================================================
--- quilt-2.6.orig/arch/s390/power/swsusp_asm64.S
+++ /dev/null
@@ -1,184 +0,0 @@
-/*
- * S390 64-bit swsusp implementation
- *
- * Copyright IBM Corp. 2009
- *
- * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
- *	      Michael Holzheu <holzheu@linux.vnet.ibm.com>
- */
-
-#include <asm/page.h>
-#include <asm/ptrace.h>
-#include <asm/asm-offsets.h>
-
-/*
- * Save register context in absolute 0 lowcore and call swsusp_save() to
- * create in-memory kernel image. The context is saved in the designated
- * "store status" memory locations (see POP).
- * We return from this function twice. The first time during the suspend to
- * disk process. The second time via the swsusp_arch_resume() function
- * (see below) in the resume process.
- * This function runs with disabled interrupts.
- */
-	.section .text
-	.align	2
-	.globl swsusp_arch_suspend
-swsusp_arch_suspend:
-	stmg	%r6,%r15,__SF_GPRS(%r15)
-	lgr	%r1,%r15
-	aghi	%r15,-STACK_FRAME_OVERHEAD
-	stg	%r1,__SF_BACKCHAIN(%r15)
-
-	/* Deactivate DAT */
-	stnsm	__SF_EMPTY(%r15),0xfb
-
-	/* Store prefix register on stack */
-	stpx	__SF_EMPTY(%r15)
-
-	/* Save prefix register contents for lowcore */
-	llgf	%r4,__SF_EMPTY(%r15)
-
-	/* Get pointer to save area */
-	lghi	%r1,0x1000
-
-	/* Store registers */
-	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
-	stfpc	0x31c(%r1)			/* store fpu control */
-	std	0,0x200(%r1)			/* store f0 */
-	std	1,0x208(%r1)			/* store f1 */
-	std	2,0x210(%r1)			/* store f2 */
-	std	3,0x218(%r1)			/* store f3 */
-	std	4,0x220(%r1)			/* store f4 */
-	std	5,0x228(%r1)			/* store f5 */
-	std	6,0x230(%r1)			/* store f6 */
-	std	7,0x238(%r1)			/* store f7 */
-	std	8,0x240(%r1)			/* store f8 */
-	std	9,0x248(%r1)			/* store f9 */
-	std	10,0x250(%r1)			/* store f10 */
-	std	11,0x258(%r1)			/* store f11 */
-	std	12,0x260(%r1)			/* store f12 */
-	std	13,0x268(%r1)			/* store f13 */
-	std	14,0x270(%r1)			/* store f14 */
-	std	15,0x278(%r1)			/* store f15 */
-	stam	%a0,%a15,0x340(%r1)		/* store access registers */
-	stctg	%c0,%c15,0x380(%r1)		/* store control registers */
-	stmg	%r0,%r15,0x280(%r1)		/* store general registers */
-
-	stpt	0x328(%r1)			/* store timer */
-	stckc	0x330(%r1)			/* store clock comparator */
-
-	/* Activate DAT */
-	stosm	__SF_EMPTY(%r15),0x04
-
-	/* Set prefix page to zero */
-	xc	__SF_EMPTY(4,%r15),__SF_EMPTY(%r15)
-	spx	__SF_EMPTY(%r15)
-
-	lghi	%r2,0
-	lghi	%r3,2*PAGE_SIZE
-	lghi	%r5,2*PAGE_SIZE
-1:	mvcle	%r2,%r4,0
-	jo	1b
-
-	/* Save image */
-	brasl	%r14,swsusp_save
-
-	/* Restore prefix register and return */
-	lghi	%r1,0x1000
-	spx	0x318(%r1)
-	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
-	lghi	%r2,0
-	br	%r14
-
-/*
- * Restore saved memory image to correct place and restore register context.
- * Then we return to the function that called swsusp_arch_suspend().
- * swsusp_arch_resume() runs with disabled interrupts.
- */
-	.globl swsusp_arch_resume
-swsusp_arch_resume:
-	stmg	%r6,%r15,__SF_GPRS(%r15)
-	lgr	%r1,%r15
-	aghi	%r15,-STACK_FRAME_OVERHEAD
-	stg	%r1,__SF_BACKCHAIN(%r15)
-
-#ifdef CONFIG_SMP
-	/* Save boot cpu number */
-	brasl	%r14,smp_get_phys_cpu_id
-	lgr	%r10,%r2
-#endif
-	/* Deactivate DAT */
-	stnsm	__SF_EMPTY(%r15),0xfb
-
-	/* Set prefix page to zero */
-	xc	__SF_EMPTY(4,%r15),__SF_EMPTY(%r15)
-	spx	__SF_EMPTY(%r15)
-
-	/* Restore saved image */
-	larl	%r1,restore_pblist
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
-	jz	2f
-0:
-	lg	%r2,8(%r1)
-	lg	%r4,0(%r1)
-	lghi	%r3,PAGE_SIZE
-	lghi	%r5,PAGE_SIZE
-1:
-	mvcle	%r2,%r4,0
-	jo	1b
-	lg	%r1,16(%r1)
-	ltgr	%r1,%r1
-	jnz	0b
-2:
-	ptlb				/* flush tlb */
-
-	/* Restore registers */
-	lghi	%r13,0x1000		/* %r1 = pointer to save arae */
-
-	spt	0x328(%r13)		/* reprogram timer */
-	//sckc	0x330(%r13)		/* set clock comparator */
-
-	lctlg	%c0,%c15,0x380(%r13)	/* load control registers */
-	lam	%a0,%a15,0x340(%r13)	/* load access registers */
-
-	lfpc	0x31c(%r13)		/* load fpu control */
-	ld	0,0x200(%r13)		/* load f0 */
-	ld	1,0x208(%r13)		/* load f1 */
-	ld	2,0x210(%r13)		/* load f2 */
-	ld	3,0x218(%r13)		/* load f3 */
-	ld	4,0x220(%r13)		/* load f4 */
-	ld	5,0x228(%r13)		/* load f5 */
-	ld	6,0x230(%r13)		/* load f6 */
-	ld	7,0x238(%r13)		/* load f7 */
-	ld	8,0x240(%r13)		/* load f8 */
-	ld	9,0x248(%r13)		/* load f9 */
-	ld	10,0x250(%r13)		/* load f10 */
-	ld	11,0x258(%r13)		/* load f11 */
-	ld	12,0x260(%r13)		/* load f12 */
-	ld	13,0x268(%r13)		/* load f13 */
-	ld	14,0x270(%r13)		/* load f14 */
-	ld	15,0x278(%r13)		/* load f15 */
-
-	/* Load old stack */
-	lg	%r15,0x2f8(%r13)
-
-	/* Pointer to save area */
-	lghi	%r13,0x1000
-
-#ifdef CONFIG_SMP
-	/* Switch CPUs */
-	lgr	%r2,%r10		/* get cpu id */
-	llgf	%r3,0x318(%r13)
-	brasl	%r14,smp_switch_boot_cpu_in_resume
-#endif
-	/* Restore prefix register */
-	spx	0x318(%r13)
-
-	/* Activate DAT */
-	stosm	__SF_EMPTY(%r15),0x04
-
-	/* Return 0 */
-	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
-	lghi	%r2,0
-	br	%r14
Index: quilt-2.6/arch/s390/power/swsusp.c
===================================================================
--- quilt-2.6.orig/arch/s390/power/swsusp.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Support for suspend and resume on s390
- *
- * Copyright IBM Corp. 2009
- *
- * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
- *
- */
-
-#include <asm/system.h>
-
-void save_processor_state(void)
-{
-	/* swsusp_arch_suspend() actually saves all cpu register contents.
-	 * Machine checks must be disabled since swsusp_arch_suspend() stores
-	 * register contents to their lowcore save areas. That's the same
-	 * place where register contents on machine checks would be saved.
-	 * To avoid register corruption disable machine checks.
-	 * We must also disable machine checks in the new psw mask for
-	 * program checks, since swsusp_arch_suspend() may generate program
-	 * checks. Disabling machine checks for all other new psw masks is
-	 * just paranoia.
-	 */
-	local_mcck_disable();
-	/* Disable lowcore protection */
-	__ctl_clear_bit(0,28);
-	S390_lowcore.external_new_psw.mask &= ~PSW_MASK_MCHECK;
-	S390_lowcore.svc_new_psw.mask &= ~PSW_MASK_MCHECK;
-	S390_lowcore.io_new_psw.mask &= ~PSW_MASK_MCHECK;
-	S390_lowcore.program_new_psw.mask &= ~PSW_MASK_MCHECK;
-}
-
-void restore_processor_state(void)
-{
-	S390_lowcore.external_new_psw.mask |= PSW_MASK_MCHECK;
-	S390_lowcore.svc_new_psw.mask |= PSW_MASK_MCHECK;
-	S390_lowcore.io_new_psw.mask |= PSW_MASK_MCHECK;
-	S390_lowcore.program_new_psw.mask |= PSW_MASK_MCHECK;
-	/* Enable lowcore protection */
-	__ctl_set_bit(0,28);
-	local_mcck_enable();
-}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
