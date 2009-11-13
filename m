Return-Path: <linux-kernel-owner+w=401wt.eu-S1757242AbZKMPRF@vger.kernel.org>
Message-Id: <20091113150909.974908124@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/52] [PATCH] fault handler access flags check.
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=104-mm-fault-access.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Simplify the check of the vma->flags in do_exception for the
different fault types.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/fault.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
+++ quilt-2.6/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
@@ -286,7 +286,7 @@
  *   11       Page translation     ->  Not present       (nullification)
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
-static inline int do_exception(struct pt_regs *regs, int write,
+static inline int do_exception(struct pt_regs *regs, int access,
 			       unsigned long trans_exc_code)
 {
 	struct task_struct *tsk;
@@ -337,19 +337,8 @@
 	 * we can handle it..
 	 */
 	fault = VM_FAULT_BADACCESS;
-#ifdef CONFIG_S390_EXEC_PROTECT
-	if (unlikely((regs->psw.mask & PSW_MASK_ASC) == PSW_ASC_SECONDARY &&
-		     (trans_exc_code & 3) == 0 && !(vma->vm_flags & VM_EXEC)))
+	if (unlikely(!(vma->vm_flags & access)))
 		goto out_up;
-#endif
-	if (!write) {
-		/* page not present, check vm flags */
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
-			goto out_up;
-	} else {
-		if (!(vma->vm_flags & VM_WRITE))
-			goto out_up;
-	}
 
 	if (is_vm_hugetlb_page(vma))
 		address &= HPAGE_MASK;
@@ -358,7 +347,8 @@
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	fault = handle_mm_fault(mm, vma, address,
+				(access == VM_WRITE) ? FAULT_FLAG_WRITE : 0);
 	if (unlikely(fault & VM_FAULT_ERROR))
 		goto out_up;
 
@@ -399,7 +389,7 @@
 		do_low_address(regs, int_code, trans_exc_code);
 		return;
 	}
-	fault = do_exception(regs, 1, trans_exc_code);
+	fault = do_exception(regs, VM_WRITE, trans_exc_code);
 	if (unlikely(fault))
 		do_fault_error(regs, 4, trans_exc_code, fault);
 }
@@ -407,9 +397,15 @@
 void __kprobes do_dat_exception(struct pt_regs *regs, long int_code)
 {
 	unsigned long trans_exc_code = S390_lowcore.trans_exc_code;
-	int fault;
+	int access, fault;
 
-	fault = do_exception(regs, 0, trans_exc_code);
+	access = VM_READ | VM_EXEC | VM_WRITE;
+#ifdef CONFIG_S390_EXEC_PROTECT
+	if ((regs->psw.mask & PSW_MASK_ASC) == PSW_ASC_SECONDARY &&
+	    (trans_exc_code & 3) == 0)
+		access = VM_EXEC;
+#endif
+	fault = do_exception(regs, access, trans_exc_code);
 	if (unlikely(fault))
 		do_fault_error(regs, int_code & 255, trans_exc_code, fault);
 }
