Return-Path: <linux-kernel-owner+w=401wt.eu-S933885AbXCSNCR@vger.kernel.org>
Date: Mon, 19 Mar 2007 14:02:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] no execute support cleanup.
Message-ID: <20070319130226.GD1292@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] no execute support cleanup.

Simplify the signal_return function that checks for the two special
system calls sigreturn and rt_sigreturn. No need to do a page table
walk, a call to copy_from_user while disabled page faults will work
as well.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/fault.c |   72 ++++++++++++++-------------------------------------
 1 files changed, 21 insertions(+), 51 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2007-03-19 13:09:35.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/fault.c	2007-03-19 13:09:35.000000000 +0100
@@ -26,9 +26,9 @@
 #include <linux/module.h>
 #include <linux/hardirq.h>
 #include <linux/kprobes.h>
+#include <linux/uaccess.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
 #include <asm/s390_ext.h>
@@ -263,68 +263,38 @@ extern long sys_rt_sigreturn(struct pt_r
 extern long sys32_sigreturn(struct pt_regs *regs);
 extern long sys32_rt_sigreturn(struct pt_regs *regs);
 
-static inline void do_sigreturn(struct mm_struct *mm, struct pt_regs *regs,
-				int rt)
+static int signal_return(struct mm_struct *mm, struct pt_regs *regs,
+			 unsigned long address, unsigned long error_code)
 {
+	u16 instruction;
+	int rc, compat;
+
+	pagefault_disable();
+	rc = __get_user(instruction, (u16 __user *) regs->psw.addr);
+	pagefault_enable();
+	if (rc)
+		return -EFAULT;
+
 	up_read(&mm->mmap_sem);
 	clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
 #ifdef CONFIG_COMPAT
-	if (test_tsk_thread_flag(current, TIF_31BIT)) {
-		if (rt)
-			sys32_rt_sigreturn(regs);
-		else
-			sys32_sigreturn(regs);
-		return;
-	}
-#endif /* CONFIG_COMPAT */
-	if (rt)
-		sys_rt_sigreturn(regs);
+	compat = test_tsk_thread_flag(current, TIF_31BIT);
+	if (compat && instruction == 0x0a77)
+		sys32_sigreturn(regs);
+	else if (compat && instruction == 0x0aad)
+		sys32_rt_sigreturn(regs);
 	else
+#endif
+	if (instruction == 0x0a77)
 		sys_sigreturn(regs);
-	return;
-}
-
-static int signal_return(struct mm_struct *mm, struct pt_regs *regs,
-			 unsigned long address, unsigned long error_code)
-{
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte;
-	u16 *instruction;
-	unsigned long pfn, uaddr = regs->psw.addr;
-
-	spin_lock(&mm->page_table_lock);
-	pgd = pgd_offset(mm, uaddr);
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		goto out_fault;
-	pmd = pmd_offset(pgd, uaddr);
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		goto out_fault;
-	pte = pte_offset_map(pmd_offset(pgd_offset(mm, uaddr), uaddr), uaddr);
-	if (!pte || !pte_present(*pte))
-		goto out_fault;
-	pfn = pte_pfn(*pte);
-	if (!pfn_valid(pfn))
-		goto out_fault;
-	spin_unlock(&mm->page_table_lock);
-
-	instruction = (u16 *) ((pfn << PAGE_SHIFT) + (uaddr & (PAGE_SIZE-1)));
-	if (*instruction == 0x0a77)
-		do_sigreturn(mm, regs, 0);
-	else if (*instruction == 0x0aad)
-		do_sigreturn(mm, regs, 1);
+	else if (instruction == 0x0aad)
+		sys_rt_sigreturn(regs);
 	else {
-		printk("- XXX - do_exception: task = %s, primary, NO EXEC "
-		       "-> SIGSEGV\n", current->comm);
-		up_read(&mm->mmap_sem);
 		current->thread.prot_addr = address;
 		current->thread.trap_no = error_code;
 		do_sigsegv(regs, error_code, SEGV_MAPERR, address);
 	}
 	return 0;
-out_fault:
-	spin_unlock(&mm->page_table_lock);
-	return -EFAULT;
 }
 #endif /* CONFIG_S390_EXEC_PROTECT */
 
