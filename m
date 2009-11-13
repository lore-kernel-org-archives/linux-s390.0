Return-Path: <linux-kernel-owner+w=401wt.eu-S1757300AbZKMPUR@vger.kernel.org>
Message-Id: <20091113150909.239905899@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:25 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/52] [PATCH] Improve address space check.
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=100-mm-check-space.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

A data access in access-register mode always is a user mode access,
the code to inspect the access-registers can be removed. The second
change is to use a different test to check for no-execute fault.
The third change is to pass the translation exception identification
as parameter, in theory the trans_exc_code in the lowcore could have
been overwritten by the time the call to check_space from do_no_context
is done.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/fault.c |   99 +++++++++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 54 deletions(-)

Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
@@ -100,39 +100,28 @@
 
 /*
  * Returns the address space associated with the fault.
- * Returns 0 for kernel space, 1 for user space and
- * 2 for code execution in user space with noexec=on.
+ * Returns 0 for kernel space and 1 for user space.
  */
-static inline int check_space(struct task_struct *tsk)
+static inline int user_space_fault(unsigned long trans_exc_code)
 {
 	/*
-	 * The lowest two bits of S390_lowcore.trans_exc_code
-	 * indicate which paging table was used.
+	 * The lowest two bits of the translation exception
+	 * identification indicate which paging table was used.
 	 */
-	int desc = S390_lowcore.trans_exc_code & 3;
-
-	if (desc == 3)	/* Home Segment Table Descriptor */
-		return switch_amode == 0;
-	if (desc == 2)	/* Secondary Segment Table Descriptor */
-		return tsk->thread.mm_segment.ar4;
-#ifdef CONFIG_S390_SWITCH_AMODE
-	if (unlikely(desc == 1)) { /* STD determined via access register */
-		/* %a0 always indicates primary space. */
-		if (S390_lowcore.exc_access_id != 0) {
-			save_access_regs(tsk->thread.acrs);
-			/*
-			 * An alet of 0 indicates primary space.
-			 * An alet of 1 indicates secondary space.
-			 * Any other alet values generate an
-			 * alen-translation exception.
-			 */
-			if (tsk->thread.acrs[S390_lowcore.exc_access_id])
-				return tsk->thread.mm_segment.ar4;
-		}
-	}
-#endif
-	/* Primary Segment Table Descriptor */
-	return switch_amode << s390_noexec;
+	trans_exc_code &= 3;
+	if (trans_exc_code == 2)
+		/* Access via secondary space, set_fs setting decides */
+		return current->thread.mm_segment.ar4;
+	if (!switch_amode)
+		/* User space if the access has been done via home space. */
+		return trans_exc_code == 3;
+	/*
+	 * If the user space is not the home space the kernel runs in home
+	 * space. Access via secondary space has already been covered,
+	 * access via primary space or access register is from user space
+	 * and access via home space is from the kernel.
+	 */
+	return trans_exc_code != 3;
 }
 
 /*
@@ -162,9 +151,10 @@
 }
 
 static void do_no_context(struct pt_regs *regs, unsigned long error_code,
-			  unsigned long address)
+			  unsigned long trans_exc_code)
 {
 	const struct exception_table_entry *fixup;
+	unsigned long address;
 
 	/* Are we prepared to handle this kernel fault?  */
 	fixup = search_exception_tables(regs->psw.addr & __FIXUP_MASK);
@@ -177,7 +167,8 @@
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice.
 	 */
-	if (check_space(current) == 0)
+	address = trans_exc_code & __FAIL_ADDR_MASK;
+	if (user_space_fault(trans_exc_code) == 0)
 		printk(KERN_ALERT "Unable to handle kernel pointer dereference"
 		       " at virtual kernel address %p\n", (void *)address);
 	else
@@ -188,7 +179,8 @@
 	do_exit(SIGKILL);
 }
 
-static void do_low_address(struct pt_regs *regs, unsigned long error_code)
+static void do_low_address(struct pt_regs *regs, unsigned long error_code,
+			   unsigned long trans_exc_code)
 {
 	/* Low-address protection hit in kernel mode means
 	   NULL pointer write access in kernel mode.  */
@@ -198,11 +190,11 @@
 		do_exit(SIGKILL);
 	}
 
-	do_no_context(regs, error_code, 0);
+	do_no_context(regs, error_code, trans_exc_code);
 }
 
 static void do_sigbus(struct pt_regs *regs, unsigned long error_code,
-		      unsigned long address)
+		      unsigned long trans_exc_code)
 {
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
@@ -212,13 +204,13 @@
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	tsk->thread.prot_addr = address;
+	tsk->thread.prot_addr = trans_exc_code & __FAIL_ADDR_MASK;
 	tsk->thread.trap_no = error_code;
 	force_sig(SIGBUS, tsk);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		do_no_context(regs, error_code, address);
+		do_no_context(regs, error_code, trans_exc_code);
 }
 
 #ifdef CONFIG_S390_EXEC_PROTECT
@@ -272,13 +264,13 @@
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
 static inline void
-do_exception(struct pt_regs *regs, unsigned long error_code, int write)
+do_exception(struct pt_regs *regs, unsigned long error_code, int write,
+	     unsigned long trans_exc_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	unsigned long address;
-	int space;
 	int si_code;
 	int fault;
 
@@ -288,18 +280,15 @@
 	tsk = current;
 	mm = tsk->mm;
 
-	/* get the failing address and the affected space */
-	address = S390_lowcore.trans_exc_code & __FAIL_ADDR_MASK;
-	space = check_space(tsk);
-
 	/*
 	 * Verify that the fault happened in user space, that
 	 * we are not in an interrupt and that there is a 
 	 * user context.
 	 */
-	if (unlikely(space == 0 || in_atomic() || !mm))
+	if (unlikely(!user_space_fault(trans_exc_code) || in_atomic() || !mm))
 		goto no_context;
 
+	address = trans_exc_code & __FAIL_ADDR_MASK;
 	/*
 	 * When we get here, the fault happened in the current
 	 * task's user address space, so we can switch on the
@@ -315,7 +304,8 @@
 		goto bad_area;
 
 #ifdef CONFIG_S390_EXEC_PROTECT
-	if (unlikely((space == 2) && !(vma->vm_flags & VM_EXEC)))
+	if (unlikely((regs->psw.mask & PSW_MASK_ASC) == PSW_ASC_SECONDARY &&
+		     (trans_exc_code & 3) == 0 && !(vma->vm_flags & VM_EXEC)))
 		if (!signal_return(mm, regs, address, error_code))
 			/*
 			 * signal_return() has done an up_read(&mm->mmap_sem)
@@ -397,12 +387,14 @@
 	}
 
 no_context:
-	do_no_context(regs, error_code, address);
+	do_no_context(regs, error_code, trans_exc_code);
 }
 
 void __kprobes do_protection_exception(struct pt_regs *regs,
 				       long error_code)
 {
+	unsigned long trans_exc_code = S390_lowcore.trans_exc_code;
+
 	/* Protection exception is supressing, decrement psw address. */
 	regs->psw.addr -= (error_code >> 16);
 	/*
@@ -410,31 +402,30 @@
 	 * as a special case because the translation exception code
 	 * field is not guaranteed to contain valid data in this case.
 	 */
-	if (unlikely(!(S390_lowcore.trans_exc_code & 4))) {
-		do_low_address(regs, error_code);
+	if (unlikely(!(trans_exc_code & 4))) {
+		do_low_address(regs, error_code, trans_exc_code);
 		return;
 	}
-	do_exception(regs, 4, 1);
+	do_exception(regs, 4, 1, trans_exc_code);
 }
 
 void __kprobes do_dat_exception(struct pt_regs *regs, long error_code)
 {
-	do_exception(regs, error_code & 0xff, 0);
+	do_exception(regs, error_code & 0xff, 0, S390_lowcore.trans_exc_code);
 }
 
 #ifdef CONFIG_64BIT
 void __kprobes do_asce_exception(struct pt_regs *regs, unsigned long error_code)
 {
+	unsigned long trans_exc_code = S390_lowcore.trans_exc_code;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	unsigned long address;
-	int space;
 
 	mm = current->mm;
-	address = S390_lowcore.trans_exc_code & __FAIL_ADDR_MASK;
-	space = check_space(current);
+	address = trans_exc_code & __FAIL_ADDR_MASK;
 
-	if (unlikely(space == 0 || in_atomic() || !mm))
+	if (unlikely(!user_space_fault(trans_exc_code) || in_atomic() || !mm))
 		goto no_context;
 
 	local_irq_enable();
@@ -457,7 +448,7 @@
 	}
 
 no_context:
-	do_no_context(regs, error_code, address);
+	do_no_context(regs, error_code, trans_exc_code);
 }
 #endif
 
