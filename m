Return-Path: <linux-kernel-owner+w=401wt.eu-S1756346AbZKMPJh@vger.kernel.org>
Message-Id: <20091113150909.764850273@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:28 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/52] [PATCH] fault handler performance optimization.
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=103-mm-fault-error.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Slim down the do_exception function to handle only the fast path of a
fault and move the exceptional cases into a new function. That slightly
increases the performance of the fault handling.

Build fix for !CONFIG_COMPAT by
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/fault.c |  258 +++++++++++++++++++++++++--------------------------
 1 file changed, 129 insertions(+), 129 deletions(-)

Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
+++ quilt-2.6/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
@@ -34,16 +34,15 @@
 #include <asm/pgtable.h>
 #include <asm/s390_ext.h>
 #include <asm/mmu_context.h>
+#include <asm/compat.h>
 #include "../kernel/entry.h"
 
 #ifndef CONFIG_64BIT
 #define __FAIL_ADDR_MASK 0x7ffff000
-#define __FIXUP_MASK 0x7fffffff
 #define __SUBCODE_MASK 0x0200
 #define __PF_RES_FIELD 0ULL
 #else /* CONFIG_64BIT */
 #define __FAIL_ADDR_MASK -4096L
-#define __FIXUP_MASK ~0L
 #define __SUBCODE_MASK 0x0600
 #define __PF_RES_FIELD 0x8000000000000000ULL
 #endif /* CONFIG_64BIT */
@@ -52,6 +51,10 @@
 extern int sysctl_userprocess_debug;
 #endif
 
+#define VM_FAULT_BADCONTEXT	0x010000
+#define VM_FAULT_BADMAP		0x020000
+#define VM_FAULT_BADACCESS	0x040000
+
 static inline int notify_page_fault(struct pt_regs *regs)
 {
 	int ret = 0;
@@ -122,18 +125,22 @@
  * Send SIGSEGV to task.  This is an external routine
  * to keep the stack usage of do_page_fault small.
  */
-static void do_sigsegv(struct pt_regs *regs, unsigned long error_code,
-		       int si_code, unsigned long address)
+static noinline void do_sigsegv(struct pt_regs *regs, long int_code,
+				int si_code, unsigned long trans_exc_code)
 {
 	struct siginfo si;
+	unsigned long address;
 
+	address = trans_exc_code & __FAIL_ADDR_MASK;
+	current->thread.prot_addr = address;
+	current->thread.trap_no = int_code;
 #if defined(CONFIG_SYSCTL) || defined(CONFIG_PROCESS_DEBUG)
 #if defined(CONFIG_SYSCTL)
 	if (sysctl_userprocess_debug)
 #endif
 	{
 		printk("User process fault: interruption code 0x%lX\n",
-		       error_code);
+		       int_code);
 		printk("failing address: %lX\n", address);
 		show_regs(regs);
 	}
@@ -144,14 +151,14 @@
 	force_sig_info(SIGSEGV, &si, current);
 }
 
-static void do_no_context(struct pt_regs *regs, unsigned long error_code,
-			  unsigned long trans_exc_code)
+static noinline void do_no_context(struct pt_regs *regs, long int_code,
+				   unsigned long trans_exc_code)
 {
 	const struct exception_table_entry *fixup;
 	unsigned long address;
 
 	/* Are we prepared to handle this kernel fault?  */
-	fixup = search_exception_tables(regs->psw.addr & __FIXUP_MASK);
+	fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
 	if (fixup) {
 		regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
 		return;
@@ -169,107 +176,127 @@
 		printk(KERN_ALERT "Unable to handle kernel paging request"
 		       " at virtual user address %p\n", (void *)address);
 
-	die("Oops", regs, error_code);
+	die("Oops", regs, int_code);
 	do_exit(SIGKILL);
 }
 
-static void do_low_address(struct pt_regs *regs, unsigned long error_code,
-			   unsigned long trans_exc_code)
+static noinline void do_low_address(struct pt_regs *regs, long int_code,
+				    unsigned long trans_exc_code)
 {
 	/* Low-address protection hit in kernel mode means
 	   NULL pointer write access in kernel mode.  */
 	if (regs->psw.mask & PSW_MASK_PSTATE) {
 		/* Low-address protection hit in user mode 'cannot happen'. */
-		die ("Low-address protection", regs, error_code);
+		die ("Low-address protection", regs, int_code);
 		do_exit(SIGKILL);
 	}
 
-	do_no_context(regs, error_code, trans_exc_code);
+	do_no_context(regs, int_code, trans_exc_code);
 }
 
-static void do_sigbus(struct pt_regs *regs, unsigned long error_code,
-		      unsigned long trans_exc_code)
+static noinline void do_sigbus(struct pt_regs *regs, long int_code,
+			       unsigned long trans_exc_code)
 {
 	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
 
-	up_read(&mm->mmap_sem);
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
 	tsk->thread.prot_addr = trans_exc_code & __FAIL_ADDR_MASK;
-	tsk->thread.trap_no = error_code;
+	tsk->thread.trap_no = int_code;
 	force_sig(SIGBUS, tsk);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		do_no_context(regs, error_code, trans_exc_code);
 }
 
 #ifdef CONFIG_S390_EXEC_PROTECT
-static int signal_return(struct mm_struct *mm, struct pt_regs *regs,
-			 unsigned long address, unsigned long error_code)
+static noinline int signal_return(struct pt_regs *regs, long int_code,
+				  unsigned long trans_exc_code)
 {
 	u16 instruction;
 	int rc;
-#ifdef CONFIG_COMPAT
-	int compat;
-#endif
 
-	pagefault_disable();
 	rc = __get_user(instruction, (u16 __user *) regs->psw.addr);
-	pagefault_enable();
-	if (rc)
-		return -EFAULT;
 
-	up_read(&mm->mmap_sem);
-	clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
-#ifdef CONFIG_COMPAT
-	compat = is_compat_task();
-	if (compat && instruction == 0x0a77)
-		sys32_sigreturn();
-	else if (compat && instruction == 0x0aad)
-		sys32_rt_sigreturn();
-	else
-#endif
-	if (instruction == 0x0a77)
-		sys_sigreturn();
-	else if (instruction == 0x0aad)
-		sys_rt_sigreturn();
-	else {
-		current->thread.prot_addr = address;
-		current->thread.trap_no = error_code;
-		do_sigsegv(regs, error_code, SEGV_MAPERR, address);
-	}
+	if (!rc && instruction == 0x0a77) {
+		clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
+		if (is_compat_task())
+			sys32_sigreturn();
+		else
+			sys_sigreturn();
+	} else if (!rc && instruction == 0x0aad) {
+		clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
+		if (is_compat_task())
+			sys32_rt_sigreturn();
+		else
+			sys_rt_sigreturn();
+	} else
+		do_sigsegv(regs, int_code, SEGV_MAPERR, trans_exc_code);
 	return 0;
 }
 #endif /* CONFIG_S390_EXEC_PROTECT */
 
+static noinline void do_fault_error(struct pt_regs *regs, long int_code,
+				    unsigned long trans_exc_code, int fault)
+{
+	int si_code;
+
+	switch (fault) {
+	case VM_FAULT_BADACCESS:
+#ifdef CONFIG_S390_EXEC_PROTECT
+		if ((regs->psw.mask & PSW_MASK_ASC) == PSW_ASC_SECONDARY &&
+		    (trans_exc_code & 3) == 0) {
+			signal_return(regs, int_code, trans_exc_code);
+			break;
+		}
+#endif /* CONFIG_S390_EXEC_PROTECT */
+	case VM_FAULT_BADMAP:
+		/* Bad memory access. Check if it is kernel or user space. */
+		if (regs->psw.mask & PSW_MASK_PSTATE) {
+			/* User mode accesses just cause a SIGSEGV */
+			si_code = (fault == VM_FAULT_BADMAP) ?
+				SEGV_MAPERR : SEGV_ACCERR;
+			do_sigsegv(regs, int_code, si_code, trans_exc_code);
+			return;
+		}
+	case VM_FAULT_BADCONTEXT:
+		do_no_context(regs, int_code, trans_exc_code);
+		break;
+	default: /* fault & VM_FAULT_ERROR */
+		if (fault & VM_FAULT_OOM)
+			pagefault_out_of_memory();
+		else if (fault & VM_FAULT_SIGBUS) {
+			do_sigbus(regs, int_code, trans_exc_code);
+			/* Kernel mode? Handle exceptions or die */
+			if (!(regs->psw.mask & PSW_MASK_PSTATE))
+				do_no_context(regs, int_code, trans_exc_code);
+		} else
+			BUG();
+		break;
+	}
+}
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  *
- * error_code:
+ * interruption code (int_code):
  *   04       Protection           ->  Write-Protection  (suprression)
  *   10       Segment translation  ->  Not present       (nullification)
  *   11       Page translation     ->  Not present       (nullification)
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
-static inline void
-do_exception(struct pt_regs *regs, unsigned long error_code, int write,
-	     unsigned long trans_exc_code)
+static inline int do_exception(struct pt_regs *regs, int write,
+			       unsigned long trans_exc_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	unsigned long address;
-	int si_code;
 	int fault;
 
 	if (notify_page_fault(regs))
-		return;
+		return 0;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -279,8 +306,9 @@
 	 * we are not in an interrupt and that there is a 
 	 * user context.
 	 */
+	fault = VM_FAULT_BADCONTEXT;
 	if (unlikely(!user_space_fault(trans_exc_code) || in_atomic() || !mm))
-		goto no_context;
+		goto out;
 
 	address = trans_exc_code & __FAIL_ADDR_MASK;
 	/*
@@ -292,41 +320,35 @@
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, address);
 	down_read(&mm->mmap_sem);
 
-	si_code = SEGV_MAPERR;
+	fault = VM_FAULT_BADMAP;
 	vma = find_vma(mm, address);
 	if (!vma)
-		goto bad_area;
+		goto out_up;
 
+	if (unlikely(vma->vm_start > address)) {
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto out_up;
+		if (expand_stack(vma, address))
+			goto out_up;
+	}
+
+	/*
+	 * Ok, we have a good vm_area for this memory access, so
+	 * we can handle it..
+	 */
+	fault = VM_FAULT_BADACCESS;
 #ifdef CONFIG_S390_EXEC_PROTECT
 	if (unlikely((regs->psw.mask & PSW_MASK_ASC) == PSW_ASC_SECONDARY &&
 		     (trans_exc_code & 3) == 0 && !(vma->vm_flags & VM_EXEC)))
-		if (!signal_return(mm, regs, address, error_code))
-			/*
-			 * signal_return() has done an up_read(&mm->mmap_sem)
-			 * if it returns 0.
-			 */
-			return;
+		goto out_up;
 #endif
-
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
-/*
- * Ok, we have a good vm_area for this memory access, so
- * we can handle it..
- */
-good_area:
-	si_code = SEGV_ACCERR;
 	if (!write) {
 		/* page not present, check vm flags */
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
-			goto bad_area;
+			goto out_up;
 	} else {
 		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;
+			goto out_up;
 	}
 
 	if (is_vm_hugetlb_page(vma))
@@ -337,17 +359,9 @@
 	 * the fault.
 	 */
 	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
-	if (unlikely(fault & VM_FAULT_ERROR)) {
-		if (fault & VM_FAULT_OOM) {
-			up_read(&mm->mmap_sem);
-			pagefault_out_of_memory();
-			return;
-		} else if (fault & VM_FAULT_SIGBUS) {
-			do_sigbus(regs, error_code, address);
-			return;
-		}
-		BUG();
-	}
+	if (unlikely(fault & VM_FAULT_ERROR))
+		goto out_up;
+
 	if (fault & VM_FAULT_MAJOR) {
 		tsk->maj_flt++;
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, 0,
@@ -357,67 +371,55 @@
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, 0,
 				     regs, address);
 	}
-        up_read(&mm->mmap_sem);
 	/*
 	 * The instruction that caused the program check will
 	 * be repeated. Don't signal single step via SIGTRAP.
 	 */
 	clear_tsk_thread_flag(tsk, TIF_SINGLE_STEP);
-        return;
-
-/*
- * Something tried to access memory that isn't in our memory map..
- * Fix it, but check if it's kernel or user first..
- */
-bad_area:
+	fault = 0;
+out_up:
 	up_read(&mm->mmap_sem);
-
-	/* User mode accesses just cause a SIGSEGV */
-	if (regs->psw.mask & PSW_MASK_PSTATE) {
-		tsk->thread.prot_addr = address;
-		tsk->thread.trap_no = error_code;
-		do_sigsegv(regs, error_code, si_code, address);
-		return;
-	}
-
-no_context:
-	do_no_context(regs, error_code, trans_exc_code);
+out:
+	return fault;
 }
 
-void __kprobes do_protection_exception(struct pt_regs *regs,
-				       long error_code)
+void __kprobes do_protection_exception(struct pt_regs *regs, long int_code)
 {
 	unsigned long trans_exc_code = S390_lowcore.trans_exc_code;
+	int fault;
 
 	/* Protection exception is supressing, decrement psw address. */
-	regs->psw.addr -= (error_code >> 16);
+	regs->psw.addr -= (int_code >> 16);
 	/*
 	 * Check for low-address protection.  This needs to be treated
 	 * as a special case because the translation exception code
 	 * field is not guaranteed to contain valid data in this case.
 	 */
 	if (unlikely(!(trans_exc_code & 4))) {
-		do_low_address(regs, error_code, trans_exc_code);
+		do_low_address(regs, int_code, trans_exc_code);
 		return;
 	}
-	do_exception(regs, 4, 1, trans_exc_code);
+	fault = do_exception(regs, 1, trans_exc_code);
+	if (unlikely(fault))
+		do_fault_error(regs, 4, trans_exc_code, fault);
 }
 
-void __kprobes do_dat_exception(struct pt_regs *regs, long error_code)
+void __kprobes do_dat_exception(struct pt_regs *regs, long int_code)
 {
-	do_exception(regs, error_code & 0xff, 0, S390_lowcore.trans_exc_code);
+	unsigned long trans_exc_code = S390_lowcore.trans_exc_code;
+	int fault;
+
+	fault = do_exception(regs, 0, trans_exc_code);
+	if (unlikely(fault))
+		do_fault_error(regs, int_code & 255, trans_exc_code, fault);
 }
 
 #ifdef CONFIG_64BIT
-void __kprobes do_asce_exception(struct pt_regs *regs, unsigned long error_code)
+void __kprobes do_asce_exception(struct pt_regs *regs, long int_code)
 {
 	unsigned long trans_exc_code = S390_lowcore.trans_exc_code;
-	struct mm_struct *mm;
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long address;
-
-	mm = current->mm;
-	address = trans_exc_code & __FAIL_ADDR_MASK;
 
 	if (unlikely(!user_space_fault(trans_exc_code) || in_atomic() || !mm))
 		goto no_context;
@@ -425,7 +427,7 @@
 	local_irq_enable();
 
 	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, address);
+	vma = find_vma(mm, trans_exc_code & __FAIL_ADDR_MASK);
 	up_read(&mm->mmap_sem);
 
 	if (vma) {
@@ -435,14 +437,12 @@
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (regs->psw.mask & PSW_MASK_PSTATE) {
-		current->thread.prot_addr = address;
-		current->thread.trap_no = error_code;
-		do_sigsegv(regs, error_code, SEGV_MAPERR, address);
+		do_sigsegv(regs, int_code, SEGV_MAPERR, trans_exc_code);
 		return;
 	}
 
 no_context:
-	do_no_context(regs, error_code, trans_exc_code);
+	do_no_context(regs, int_code, trans_exc_code);
 }
 #endif
 
@@ -507,7 +507,7 @@
 		: : "a" (&refbk), "m" (refbk) : "cc");
 }
 
-static void pfault_interrupt(__u16 error_code)
+static void pfault_interrupt(__u16 int_code)
 {
 	struct task_struct *tsk;
 	__u16 subcode;
