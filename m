Return-Path: <linux-kernel-owner+w=401wt.eu-S1762179AbZBYPVZ@vger.kernel.org>
Message-Id: <20090225150827.607883184@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:25 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 03/46] page fault: invoke oom-killer
Content-Disposition: inline; filename=102-oom.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

s390 arch backend for 1c0fe6e3bda0464728c23c8d84aa47567e8b716c
"mm: invoke oom-killer from page fault".

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/fault.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c
+++ quilt-2.6/arch/s390/mm/fault.c
@@ -200,29 +200,6 @@ static void do_low_address(struct pt_reg
 	do_no_context(regs, error_code, 0);
 }
 
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
-static int do_out_of_memory(struct pt_regs *regs, unsigned long error_code,
-			    unsigned long address)
-{
-	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
-
-	up_read(&mm->mmap_sem);
-	if (is_global_init(tsk)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		return 1;
-	}
-	printk("VM: killing process %s\n", tsk->comm);
-	if (regs->psw.mask & PSW_MASK_PSTATE)
-		do_group_exit(SIGKILL);
-	do_no_context(regs, error_code, address);
-	return 0;
-}
-
 static void do_sigbus(struct pt_regs *regs, unsigned long error_code,
 		      unsigned long address)
 {
@@ -367,7 +344,6 @@ good_area:
 			goto bad_area;
 	}
 
-survive:
 	if (is_vm_hugetlb_page(vma))
 		address &= HPAGE_MASK;
 	/*
@@ -378,8 +354,8 @@ survive:
 	fault = handle_mm_fault(mm, vma, address, write);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM) {
-			if (do_out_of_memory(regs, error_code, address))
-				goto survive;
+			up_read(&mm->mmap_sem);
+			pagefault_out_of_memory();
 			return;
 		} else if (fault & VM_FAULT_SIGBUS) {
 			do_sigbus(regs, error_code, address);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
