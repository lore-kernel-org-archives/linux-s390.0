Return-Path: <linux-kernel-owner+w=401wt.eu-S1755879AbXD0OOl@vger.kernel.org>
Message-Id: <20070427140516.523272684@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/38] Minor fault path optimization.
Content-Disposition: inline; filename=123-minor-fault.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The minor fault path has grown a lot in terms of cycles. In particular
the kprobes hook is very costly. Optimize the path to save a couple of
cycles. If kprobes is enabled more than 300 cycles can be avoided if 
kprobes_running() is false.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/mm/fault.c |  259 +++++++++++++++++++++++++++------------------------
 1 files changed, 141 insertions(+), 118 deletions(-)

Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/mm/fault.c	2007-04-27 16:04:57.000000000 +0200
@@ -63,21 +63,25 @@
 	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
 }
 
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
+static int __kprobes __notify_page_fault(struct pt_regs *regs, long err)
 {
-	struct die_args args = {
-		.regs = regs,
-		.str = str,
-		.err = err,
-		.trapnr = trap,
-		.signr = sig
-	};
-	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+	struct die_args args = { .str = "page fault",
+				 .trapnr = 14,
+				 .signr = SIGSEGV };
+	args.regs = regs;
+	args.err = err;
+	return atomic_notifier_call_chain(&notify_page_fault_chain,
+					  DIE_PAGE_FAULT, &args);
+}
+
+static inline int notify_page_fault(struct pt_regs *regs, long err)
+{
+	if (unlikely(kprobe_running()))
+		return __notify_page_fault(regs, err);
+	return NOTIFY_DONE;
 }
 #else
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
+static inline int notify_page_fault(struct pt_regs *regs, long err)
 {
 	return NOTIFY_DONE;
 }
@@ -170,6 +174,89 @@
 	force_sig_info(SIGSEGV, &si, current);
 }
 
+static void do_no_context(struct pt_regs *regs, unsigned long error_code,
+			  unsigned long address)
+{
+	const struct exception_table_entry *fixup;
+
+	/* Are we prepared to handle this kernel fault?  */
+	fixup = search_exception_tables(regs->psw.addr & __FIXUP_MASK);
+	if (fixup) {
+		regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
+		return;
+	}
+
+	/*
+	 * Oops. The kernel tried to access some bad page. We'll have to
+	 * terminate things with extreme prejudice.
+	 */
+	if (check_space(current) == 0)
+		printk(KERN_ALERT "Unable to handle kernel pointer dereference"
+		       " at virtual kernel address %p\n", (void *)address);
+	else
+		printk(KERN_ALERT "Unable to handle kernel paging request"
+		       " at virtual user address %p\n", (void *)address);
+
+	die("Oops", regs, error_code);
+	do_exit(SIGKILL);
+}
+
+static void do_low_address(struct pt_regs *regs, unsigned long error_code)
+{
+	/* Low-address protection hit in kernel mode means
+	   NULL pointer write access in kernel mode.  */
+	if (regs->psw.mask & PSW_MASK_PSTATE) {
+		/* Low-address protection hit in user mode 'cannot happen'. */
+		die ("Low-address protection", regs, error_code);
+		do_exit(SIGKILL);
+	}
+
+	do_no_context(regs, error_code, 0);
+}
+
+/*
+ * We ran out of memory, or some other thing happened to us that made
+ * us unable to handle the page fault gracefully.
+ */
+static int do_out_of_memory(struct pt_regs *regs, unsigned long error_code,
+			    unsigned long address)
+{
+	struct task_struct *tsk = current;
+	struct mm_struct *mm = tsk->mm;
+
+	up_read(&mm->mmap_sem);
+	if (is_init(tsk)) {
+		yield();
+		down_read(&mm->mmap_sem);
+		return 1;
+	}
+	printk("VM: killing process %s\n", tsk->comm);
+	if (regs->psw.mask & PSW_MASK_PSTATE)
+		do_exit(SIGKILL);
+	do_no_context(regs, error_code, address);
+	return 0;
+}
+
+static void do_sigbus(struct pt_regs *regs, unsigned long error_code,
+		      unsigned long address)
+{
+	struct task_struct *tsk = current;
+	struct mm_struct *mm = tsk->mm;
+
+	up_read(&mm->mmap_sem);
+	/*
+	 * Send a sigbus, regardless of whether we were in kernel
+	 * or user mode.
+	 */
+	tsk->thread.prot_addr = address;
+	tsk->thread.trap_no = error_code;
+	force_sig(SIGBUS, tsk);
+
+	/* Kernel mode? Handle exceptions or die */
+	if (!(regs->psw.mask & PSW_MASK_PSTATE))
+		do_no_context(regs, error_code, address);
+}
+
 #ifdef CONFIG_S390_EXEC_PROTECT
 extern long sys_sigreturn(struct pt_regs *regs);
 extern long sys_rt_sigreturn(struct pt_regs *regs);
@@ -253,49 +340,23 @@
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
 static inline void
-do_exception(struct pt_regs *regs, unsigned long error_code, int is_protection)
+do_exception(struct pt_regs *regs, unsigned long error_code, int write)
 {
-        struct task_struct *tsk;
-        struct mm_struct *mm;
-        struct vm_area_struct * vma;
-        unsigned long address;
-	const struct exception_table_entry *fixup;
-	int si_code;
+	struct task_struct *tsk;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned long address;
 	int space;
+	int si_code;
 
-        tsk = current;
-        mm = tsk->mm;
-	
-	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-					SIGSEGV) == NOTIFY_STOP)
+	if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
 		return;
 
-	/* 
-         * Check for low-address protection.  This needs to be treated
-	 * as a special case because the translation exception code 
-	 * field is not guaranteed to contain valid data in this case.
-	 */
-	if (is_protection && !(S390_lowcore.trans_exc_code & 4)) {
-
-		/* Low-address protection hit in kernel mode means 
-		   NULL pointer write access in kernel mode.  */
- 		if (!(regs->psw.mask & PSW_MASK_PSTATE)) {
-			address = 0;
-			space = 0;
-			goto no_context;
-		}
-
-		/* Low-address protection hit in user mode 'cannot happen'.  */
-		die ("Low-address protection", regs, error_code);
-        	do_exit(SIGKILL);
-	}
+	tsk = current;
+	mm = tsk->mm;
 
-        /* 
-         * get the failing address 
-         * more specific the segment and page table portion of 
-         * the address 
-         */
-        address = S390_lowcore.trans_exc_code & __FAIL_ADDR_MASK;
+	/* get the failing address and the affected space */
+	address = S390_lowcore.trans_exc_code & __FAIL_ADDR_MASK;
 	space = check_space(tsk);
 
 	/*
@@ -313,7 +374,7 @@
 	 */
 	local_irq_enable();
 
-        down_read(&mm->mmap_sem);
+	down_read(&mm->mmap_sem);
 
 	si_code = SEGV_MAPERR;
 	vma = find_vma(mm, address);
@@ -330,19 +391,19 @@
 			return;
 #endif
 
-        if (vma->vm_start <= address) 
-                goto good_area;
-        if (!(vma->vm_flags & VM_GROWSDOWN))
-                goto bad_area;
-        if (expand_stack(vma, address))
-                goto bad_area;
+	if (vma->vm_start <= address)
+		goto good_area;
+	if (!(vma->vm_flags & VM_GROWSDOWN))
+		goto bad_area;
+	if (expand_stack(vma, address))
+		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
  */
 good_area:
 	si_code = SEGV_ACCERR;
-	if (!is_protection) {
+	if (!write) {
 		/* page not present, check vm flags */
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
@@ -357,7 +418,7 @@
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	switch (handle_mm_fault(mm, vma, address, is_protection)) {
+	switch (handle_mm_fault(mm, vma, address, write)) {
 	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
@@ -365,9 +426,12 @@
 		tsk->maj_flt++;
 		break;
 	case VM_FAULT_SIGBUS:
-		goto do_sigbus;
+		do_sigbus(regs, error_code, address);
+		return;
 	case VM_FAULT_OOM:
-		goto out_of_memory;
+		if (do_out_of_memory(regs, error_code, address))
+			goto survive;
+		return;
 	default:
 		BUG();
 	}
@@ -385,75 +449,34 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-        up_read(&mm->mmap_sem);
+	up_read(&mm->mmap_sem);
 
-        /* User mode accesses just cause a SIGSEGV */
-        if (regs->psw.mask & PSW_MASK_PSTATE) {
-                tsk->thread.prot_addr = address;
-                tsk->thread.trap_no = error_code;
+	/* User mode accesses just cause a SIGSEGV */
+	if (regs->psw.mask & PSW_MASK_PSTATE) {
+		tsk->thread.prot_addr = address;
+		tsk->thread.trap_no = error_code;
 		do_sigsegv(regs, error_code, si_code, address);
-                return;
+		return;
 	}
 
 no_context:
-        /* Are we prepared to handle this kernel fault?  */
-	fixup = search_exception_tables(regs->psw.addr & __FIXUP_MASK);
-	if (fixup) {
-		regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
-                return;
-        }
-
-/*
- * Oops. The kernel tried to access some bad page. We'll have to
- * terminate things with extreme prejudice.
- */
-	if (space == 0)
-                printk(KERN_ALERT "Unable to handle kernel pointer dereference"
-        	       " at virtual kernel address %p\n", (void *)address);
-        else
-                printk(KERN_ALERT "Unable to handle kernel paging request"
-		       " at virtual user address %p\n", (void *)address);
-
-        die("Oops", regs, error_code);
-        do_exit(SIGKILL);
-
-
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
-*/
-out_of_memory:
-	up_read(&mm->mmap_sem);
-	if (is_init(tsk)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", tsk->comm);
-	if (regs->psw.mask & PSW_MASK_PSTATE)
-		do_exit(SIGKILL);
-	goto no_context;
-
-do_sigbus:
-	up_read(&mm->mmap_sem);
-
-	/*
-	 * Send a sigbus, regardless of whether we were in kernel
-	 * or user mode.
-	 */
-        tsk->thread.prot_addr = address;
-        tsk->thread.trap_no = error_code;
-	force_sig(SIGBUS, tsk);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		goto no_context;
+	do_no_context(regs, error_code, address);
 }
 
 void __kprobes do_protection_exception(struct pt_regs *regs,
 				       unsigned long error_code)
 {
+	/* Protection exception is supressing, decrement psw address. */
 	regs->psw.addr -= (error_code >> 16);
+	/*
+	 * Check for low-address protection.  This needs to be treated
+	 * as a special case because the translation exception code
+	 * field is not guaranteed to contain valid data in this case.
+	 */
+	if (unlikely(!(S390_lowcore.trans_exc_code & 4))) {
+		do_low_address(regs, error_code);
+		return;
+	}
 	do_exception(regs, 4, 1);
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
