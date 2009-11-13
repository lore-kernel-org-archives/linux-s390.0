Return-Path: <linux-kernel-owner+w=401wt.eu-S1756267AbZKMPJW@vger.kernel.org>
Message-Id: <20091113150910.155645204@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/52] [PATCH] Use do_exception() in pagetable walk usercopy functions.
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=105-mm-pt-walk.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

The pagetable walk usercopy functions have used a modified copy of the
do_exception() function for fault handling. This lead to inconsistencies
with recent changes to do_exception(), e.g. performance counters. This
patch changes the pagetable walk usercopy code to call do_exception()
directly, eliminating the redundancy. A new parameter is added to
do_exception() to specify the fault address.

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/uaccess.h |    2 
 arch/s390/lib/uaccess_pt.c      |  147 +++++++++++++---------------------------
 arch/s390/mm/fault.c            |   23 ++++++
 3 files changed, 76 insertions(+), 96 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/uaccess.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/uaccess.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/uaccess.h	2009-11-13 16:08:13.000000000 +0100
@@ -93,6 +93,8 @@
 extern struct uaccess_ops uaccess_mvcos_switch;
 extern struct uaccess_ops uaccess_pt;
 
+extern int __handle_fault(unsigned long, unsigned long, int);
+
 static inline int __put_user_fn(size_t size, void __user *ptr, void *x)
 {
 	size = uaccess.copy_to_user_small(size, ptr, x);
Index: quilt-2.6/arch/s390/lib/uaccess_pt.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/uaccess_pt.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/lib/uaccess_pt.c	2009-11-13 16:08:13.000000000 +0100
@@ -23,86 +23,21 @@
 
 	pgd = pgd_offset(mm, addr);
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return NULL;
+		return (pte_t *) 0x3a;
 
 	pud = pud_offset(pgd, addr);
 	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
-		return NULL;
+		return (pte_t *) 0x3b;
 
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		return NULL;
+		return (pte_t *) 0x10;
 
 	return pte_offset_map(pmd, addr);
 }
 
-static int __handle_fault(struct mm_struct *mm, unsigned long address,
-			  int write_access)
-{
-	struct vm_area_struct *vma;
-	int ret = -EFAULT;
-	int fault;
-
-	if (in_atomic())
-		return ret;
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, address);
-	if (unlikely(!vma))
-		goto out;
-	if (unlikely(vma->vm_start > address)) {
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			goto out;
-		if (expand_stack(vma, address))
-			goto out;
-	}
-
-	if (!write_access) {
-		/* page not present, check vm flags */
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
-			goto out;
-	} else {
-		if (!(vma->vm_flags & VM_WRITE))
-			goto out;
-	}
-
-survive:
-	fault = handle_mm_fault(mm, vma, address, write_access ? FAULT_FLAG_WRITE : 0);
-	if (unlikely(fault & VM_FAULT_ERROR)) {
-		if (fault & VM_FAULT_OOM)
-			goto out_of_memory;
-		else if (fault & VM_FAULT_SIGBUS)
-			goto out_sigbus;
-		BUG();
-	}
-	if (fault & VM_FAULT_MAJOR)
-		current->maj_flt++;
-	else
-		current->min_flt++;
-	ret = 0;
-out:
-	up_read(&mm->mmap_sem);
-	return ret;
-
-out_of_memory:
-	up_read(&mm->mmap_sem);
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", current->comm);
-	return ret;
-
-out_sigbus:
-	up_read(&mm->mmap_sem);
-	current->thread.prot_addr = address;
-	current->thread.trap_no = 0x11;
-	force_sig(SIGBUS, current);
-	return ret;
-}
-
-static size_t __user_copy_pt(unsigned long uaddr, void *kptr,
-			     size_t n, int write_user)
+static __always_inline size_t __user_copy_pt(unsigned long uaddr, void *kptr,
+					     size_t n, int write_user)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long offset, pfn, done, size;
@@ -114,12 +49,17 @@
 	spin_lock(&mm->page_table_lock);
 	do {
 		pte = follow_table(mm, uaddr);
-		if (!pte || !pte_present(*pte) ||
-		    (write_user && !pte_write(*pte)))
+		if ((unsigned long) pte < 0x1000)
 			goto fault;
+		if (!pte_present(*pte)) {
+			pte = (pte_t *) 0x11;
+			goto fault;
+		} else if (write_user && !pte_write(*pte)) {
+			pte = (pte_t *) 0x04;
+			goto fault;
+		}
 
 		pfn = pte_pfn(*pte);
-
 		offset = uaddr & (PAGE_SIZE - 1);
 		size = min(n - done, PAGE_SIZE - offset);
 		if (write_user) {
@@ -137,7 +77,7 @@
 	return n - done;
 fault:
 	spin_unlock(&mm->page_table_lock);
-	if (__handle_fault(mm, uaddr, write_user))
+	if (__handle_fault(uaddr, (unsigned long) pte, write_user))
 		return n - done;
 	goto retry;
 }
@@ -146,30 +86,31 @@
  * Do DAT for user address by page table walk, return kernel address.
  * This function needs to be called with current->mm->page_table_lock held.
  */
-static unsigned long __dat_user_addr(unsigned long uaddr)
+static __always_inline unsigned long __dat_user_addr(unsigned long uaddr)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long pfn, ret;
+	unsigned long pfn;
 	pte_t *pte;
 	int rc;
 
-	ret = 0;
 retry:
 	pte = follow_table(mm, uaddr);
-	if (!pte || !pte_present(*pte))
+	if ((unsigned long) pte < 0x1000)
 		goto fault;
+	if (!pte_present(*pte)) {
+		pte = (pte_t *) 0x11;
+		goto fault;
+	}
 
 	pfn = pte_pfn(*pte);
-	ret = (pfn << PAGE_SHIFT) + (uaddr & (PAGE_SIZE - 1));
-out:
-	return ret;
+	return (pfn << PAGE_SHIFT) + (uaddr & (PAGE_SIZE - 1));
 fault:
 	spin_unlock(&mm->page_table_lock);
-	rc = __handle_fault(mm, uaddr, 0);
+	rc = __handle_fault(uaddr, (unsigned long) pte, 0);
 	spin_lock(&mm->page_table_lock);
-	if (rc)
-		goto out;
-	goto retry;
+	if (!rc)
+		goto retry;
+	return 0;
 }
 
 size_t copy_from_user_pt(size_t n, const void __user *from, void *to)
@@ -234,8 +175,12 @@
 	spin_lock(&mm->page_table_lock);
 	do {
 		pte = follow_table(mm, uaddr);
-		if (!pte || !pte_present(*pte))
+		if ((unsigned long) pte < 0x1000)
+			goto fault;
+		if (!pte_present(*pte)) {
+			pte = (pte_t *) 0x11;
 			goto fault;
+		}
 
 		pfn = pte_pfn(*pte);
 		offset = uaddr & (PAGE_SIZE-1);
@@ -249,9 +194,8 @@
 	return done + 1;
 fault:
 	spin_unlock(&mm->page_table_lock);
-	if (__handle_fault(mm, uaddr, 0)) {
+	if (__handle_fault(uaddr, (unsigned long) pte, 0))
 		return 0;
-	}
 	goto retry;
 }
 
@@ -284,7 +228,7 @@
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long offset_from, offset_to, offset_max, pfn_from, pfn_to,
-		      uaddr, done, size;
+		      uaddr, done, size, error_code;
 	unsigned long uaddr_from = (unsigned long) from;
 	unsigned long uaddr_to = (unsigned long) to;
 	pte_t *pte_from, *pte_to;
@@ -298,17 +242,28 @@
 retry:
 	spin_lock(&mm->page_table_lock);
 	do {
+		write_user = 0;
+		uaddr = uaddr_from;
 		pte_from = follow_table(mm, uaddr_from);
-		if (!pte_from || !pte_present(*pte_from)) {
-			uaddr = uaddr_from;
-			write_user = 0;
+		error_code = (unsigned long) pte_from;
+		if (error_code < 0x1000)
+			goto fault;
+		if (!pte_present(*pte_from)) {
+			error_code = 0x11;
 			goto fault;
 		}
 
+		write_user = 1;
+		uaddr = uaddr_to;
 		pte_to = follow_table(mm, uaddr_to);
-		if (!pte_to || !pte_present(*pte_to) || !pte_write(*pte_to)) {
-			uaddr = uaddr_to;
-			write_user = 1;
+		error_code = (unsigned long) pte_to;
+		if (error_code < 0x1000)
+			goto fault;
+		if (!pte_present(*pte_to)) {
+			error_code = 0x11;
+			goto fault;
+		} else if (!pte_write(*pte_to)) {
+			error_code = 0x04;
 			goto fault;
 		}
 
@@ -329,7 +284,7 @@
 	return n - done;
 fault:
 	spin_unlock(&mm->page_table_lock);
-	if (__handle_fault(mm, uaddr, write_user))
+	if (__handle_fault(uaddr, error_code, write_user))
 		return n - done;
 	goto retry;
 }
Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
+++ quilt-2.6/arch/s390/mm/fault.c	2009-11-13 16:08:13.000000000 +0100
@@ -442,6 +442,29 @@
 }
 #endif
 
+int __handle_fault(unsigned long uaddr, unsigned long int_code, int write_user)
+{
+	struct pt_regs regs;
+	int access, fault;
+
+	regs.psw.mask = psw_kernel_bits;
+	if (!irqs_disabled())
+		regs.psw.mask |= PSW_MASK_IO | PSW_MASK_EXT;
+	regs.psw.addr = (unsigned long) __builtin_return_address(0);
+	regs.psw.addr |= PSW_ADDR_AMODE;
+	uaddr &= PAGE_MASK;
+	access = write_user ? VM_WRITE : VM_READ;
+	fault = do_exception(&regs, access, uaddr | 2);
+	if (unlikely(fault)) {
+		if (fault & VM_FAULT_OOM) {
+			pagefault_out_of_memory();
+			fault = 0;
+		} else if (fault & VM_FAULT_SIGBUS)
+			do_sigbus(&regs, int_code, uaddr);
+	}
+	return fault ? -EFAULT : 0;
+}
+
 #ifdef CONFIG_PFAULT 
 /*
  * 'pfault' pseudo page faults routines.
