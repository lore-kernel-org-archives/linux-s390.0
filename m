Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbgIOPnx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:53 -0400
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Date: Tue, 15 Sep 2020 17:43:40 +0200
Message-Id: <20200915154340.4215-5-hca@linux.ibm.com>
In-Reply-To: <20200915154340.4215-1-hca@linux.ibm.com>
References: <20200915154340.4215-1-hca@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

Remove set_fs() interface and therefore the possibility to use uaccess
primitives for kernel address space.  In order to safely access kernel
address space copy_to/from_kernel_nofault() or get_kernel_nofault()
have to be used.

Address spaces still have to switched/changed for machines without the
mvcos instructions and especially for instructions like e.g. compare
and swap (-> futex) which must be executed in kernel address space but
access user address space. For such instructions enable_sacf_uaccess()
and disable_sacf_uaccess() must be used like before.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                   |  1 -
 arch/s390/include/asm/futex.h       | 12 ++---
 arch/s390/include/asm/mmu_context.h |  7 +--
 arch/s390/include/asm/processor.h   |  4 +-
 arch/s390/include/asm/uaccess.h     | 18 -------
 arch/s390/kernel/entry.S            | 19 ++------
 arch/s390/kernel/entry.h            |  1 -
 arch/s390/kernel/process.c          | 15 +-----
 arch/s390/lib/uaccess.c             | 76 +++++++++++++----------------
 arch/s390/mm/fault.c                |  9 ++--
 arch/s390/mm/pgalloc.c              | 11 ++---
 arch/s390/pci/pci_mmio.c            | 12 ++---
 12 files changed, 63 insertions(+), 122 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index af72fca9ccd5..b29fcc66ec39 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -185,7 +185,6 @@ config S390
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
-	select SET_FS
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index 26f9144562c9..ea225b5a9c80 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -26,9 +26,9 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
 	int oldval = 0, newval, ret;
-	mm_segment_t old_fs;
+	bool old;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("lr %2,%5\n",
@@ -53,7 +53,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	default:
 		ret = -ENOSYS;
 	}
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 
 	if (!ret)
 		*oval = oldval;
@@ -64,10 +64,10 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 						u32 oldval, u32 newval)
 {
-	mm_segment_t old_fs;
+	bool old;
 	int ret;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	asm volatile(
 		"   sacf 256\n"
 		"0: cs   %1,%4,0(%5)\n"
@@ -77,7 +77,7 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		: "=d" (ret), "+d" (oldval), "=m" (*uaddr)
 		: "0" (-EFAULT), "d" (newval), "a" (uaddr), "m" (*uaddr)
 		: "cc", "memory");
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	*uval = oldval;
 	return ret;
 }
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index c9f3d8a52756..11b8557b1d1d 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -85,8 +85,9 @@ static inline void clear_user_asce(void)
 	set_cpu_flag(CIF_ASCE_PRIMARY);
 }
 
-mm_segment_t enable_sacf_uaccess(void);
-void disable_sacf_uaccess(mm_segment_t old_fs);
+void setup_address_spaces(void);
+bool enable_sacf_uaccess(void);
+void disable_sacf_uaccess(bool old);
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
@@ -122,7 +123,7 @@ static inline void finish_arch_post_lock_switch(void)
 		__tlb_flush_mm_lazy(mm);
 		preempt_enable();
 	}
-	set_fs(current->thread.mm_segment);
+	setup_address_spaces();
 }
 
 #define enter_lazy_tlb(mm,tsk)	do { } while (0)
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 962da04234af..5a951527f1bd 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -102,8 +102,6 @@ extern void __bpon(void);
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
-typedef unsigned int mm_segment_t;
-
 /*
  * Thread structure
  */
@@ -116,7 +114,7 @@ struct thread_struct {
 	unsigned long hardirq_timer;	/* task cputime in hardirq context */
 	unsigned long softirq_timer;	/* task cputime in softirq context */
 	unsigned long sys_call_table;	/* system call table address */
-	mm_segment_t mm_segment;
+	bool sacf_uaccess;		/* uaccess with sacf enabled */
 	unsigned long gmap_addr;	/* address of last gmap fault. */
 	unsigned int gmap_write_flag;	/* gmap fault write indication */
 	unsigned int gmap_int_code;	/* int code of last gmap fault */
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 3ef424bca082..f71e93e1ff73 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -18,24 +18,6 @@
 #include <asm/extable.h>
 #include <asm/facility.h>
 
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-
-#define KERNEL_DS	(0)
-#define KERNEL_DS_SACF	(1)
-#define USER_DS		(2)
-#define USER_DS_SACF	(3)
-
-#define get_fs()        (current->thread.mm_segment)
-#define uaccess_kernel() ((get_fs() & 2) == KERNEL_DS)
-
-void set_fs(mm_segment_t fs);
-
 static inline int __range_ok(unsigned long addr, unsigned long size)
 {
 	return 1;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 23edf196d3dc..434b059bb9fb 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -486,19 +486,13 @@ ENTRY(system_call)
 .Lsysc_asce:
 	ni	__LC_CPU_FLAGS+7,255-_CIF_ASCE_SECONDARY
 	lctlg	%c7,%c7,__LC_VDSO_ASCE		# load secondary asce
+#ifndef CONFIG_HAVE_MARCH_Z10_FEATURES
 	TSTMSK	__LC_CPU_FLAGS,_CIF_ASCE_PRIMARY
 	jz	.Lsysc_return
-#ifndef CONFIG_HAVE_MARCH_Z10_FEATURES
-	tm	__LC_STFLE_FAC_LIST+3,0x10	# has MVCOS ?
-	jnz	.Lsysc_set_fs_fixup
 	ni	__LC_CPU_FLAGS+7,255-_CIF_ASCE_PRIMARY
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
-	j	.Lsysc_return
-.Lsysc_set_fs_fixup:
 #endif
-	larl	%r14,.Lsysc_return
-	jg	set_fs_fixup
-
+	j	.Lsysc_return
 
 #
 # _TIF_SIGPENDING is set, call do_signal
@@ -877,18 +871,13 @@ ENTRY(io_int_handler)
 .Lio_asce:
 	ni	__LC_CPU_FLAGS+7,255-_CIF_ASCE_SECONDARY
 	lctlg	%c7,%c7,__LC_VDSO_ASCE		# load secondary asce
+#ifndef CONFIG_HAVE_MARCH_Z10_FEATURES
 	TSTMSK	__LC_CPU_FLAGS,_CIF_ASCE_PRIMARY
 	jz	.Lio_return
-#ifndef CONFIG_HAVE_MARCH_Z10_FEATURES
-	tm	__LC_STFLE_FAC_LIST+3,0x10	# has MVCOS ?
-	jnz	.Lio_set_fs_fixup
 	ni	__LC_CPU_FLAGS+7,255-_CIF_ASCE_PRIMARY
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
-	j	.Lio_return
-.Lio_set_fs_fixup:
 #endif
-	larl	%r14,.Lio_return
-	jg	set_fs_fixup
+	j	.Lio_return
 
 #
 # CIF_FPU is set, restore floating-point controls and floating-point registers.
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index faca269d5f27..2e9be5657120 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -86,7 +86,6 @@ long sys_s390_sthyi(unsigned long function_code, void __user *buffer, u64 __user
 DECLARE_PER_CPU(u64, mt_cycles[8]);
 
 void gs_load_bc_cb(struct pt_regs *regs);
-void set_fs_fixup(void);
 
 unsigned long stack_alloc(void);
 void stack_free(unsigned long stack);
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index ec801d3bbb37..2a87c2dde6fc 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -94,7 +94,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	/* Save access registers to new thread structure. */
 	save_access_regs(&p->thread.acrs[0]);
 	/* start new process with ar4 pointing to the correct address space */
-	p->thread.mm_segment = get_fs();
+	p->thread.sacf_uaccess = current->thread.sacf_uaccess;
 	/* Don't copy debug registers */
 	memset(&p->thread.per_user, 0, sizeof(p->thread.per_user));
 	memset(&p->thread.per_event, 0, sizeof(p->thread.per_event));
@@ -208,16 +208,3 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	ret = PAGE_ALIGN(mm->brk + brk_rnd());
 	return (ret > mm->brk) ? ret : mm->brk;
 }
-
-void set_fs_fixup(void)
-{
-	struct pt_regs *regs = current_pt_regs();
-	static bool warned;
-
-	set_fs(USER_DS);
-	if (warned)
-		return;
-	WARN(1, "Unbalanced set_fs - int code: 0x%x\n", regs->int_code);
-	show_registers(regs);
-	warned = true;
-}
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index 0267405ab7c6..eb5f2b7360e1 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -40,61 +40,51 @@ static inline int copy_with_mvcos(void)
 }
 #endif
 
-void set_fs(mm_segment_t fs)
+void setup_address_spaces(void)
 {
-	current->thread.mm_segment = fs;
-	if (fs == USER_DS) {
+	if (likely(!current->thread.sacf_uaccess)) {
 		__ctl_load(S390_lowcore.user_asce, 1, 1);
 		clear_cpu_flag(CIF_ASCE_PRIMARY);
 	} else {
 		__ctl_load(S390_lowcore.kernel_asce, 1, 1);
 		set_cpu_flag(CIF_ASCE_PRIMARY);
-	}
-	if (fs & 1) {
-		if (fs == USER_DS_SACF)
-			__ctl_load(S390_lowcore.user_asce, 7, 7);
-		else
-			__ctl_load(S390_lowcore.kernel_asce, 7, 7);
+		__ctl_load(S390_lowcore.user_asce, 7, 7);
 		set_cpu_flag(CIF_ASCE_SECONDARY);
 	}
 }
-EXPORT_SYMBOL(set_fs);
 
-mm_segment_t enable_sacf_uaccess(void)
+bool enable_sacf_uaccess(void)
 {
-	mm_segment_t old_fs;
 	unsigned long asce, cr;
 	unsigned long flags;
+	bool old;
 
-	old_fs = current->thread.mm_segment;
-	if (old_fs & 1)
-		return old_fs;
+	old = current->thread.sacf_uaccess;
+	if (old)
+		return old;
 	/* protect against a concurrent page table upgrade */
 	local_irq_save(flags);
-	current->thread.mm_segment |= 1;
-	asce = S390_lowcore.kernel_asce;
-	if (likely(old_fs == USER_DS)) {
-		__ctl_store(cr, 1, 1);
-		if (cr != S390_lowcore.kernel_asce) {
-			__ctl_load(S390_lowcore.kernel_asce, 1, 1);
-			set_cpu_flag(CIF_ASCE_PRIMARY);
-		}
-		asce = S390_lowcore.user_asce;
+	current->thread.sacf_uaccess = true;
+	__ctl_store(cr, 1, 1);
+	if (cr != S390_lowcore.kernel_asce) {
+		__ctl_load(S390_lowcore.kernel_asce, 1, 1);
+		set_cpu_flag(CIF_ASCE_PRIMARY);
 	}
+	asce = S390_lowcore.user_asce;
 	__ctl_store(cr, 7, 7);
 	if (cr != asce) {
 		__ctl_load(asce, 7, 7);
 		set_cpu_flag(CIF_ASCE_SECONDARY);
 	}
 	local_irq_restore(flags);
-	return old_fs;
+	return old;
 }
 EXPORT_SYMBOL(enable_sacf_uaccess);
 
-void disable_sacf_uaccess(mm_segment_t old_fs)
+void disable_sacf_uaccess(bool old)
 {
-	current->thread.mm_segment = old_fs;
-	if (old_fs == USER_DS && test_facility(27)) {
+	current->thread.sacf_uaccess = old;
+	if (!old && test_facility(27)) {
 		__ctl_load(S390_lowcore.user_asce, 1, 1);
 		clear_cpu_flag(CIF_ASCE_PRIMARY);
 	}
@@ -135,9 +125,9 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 						unsigned long size)
 {
 	unsigned long tmp1, tmp2;
-	mm_segment_t old_fs;
+	bool old;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	tmp1 = -256UL;
 	asm volatile(
 		"   sacf  0\n"
@@ -164,7 +154,7 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: : "cc", "memory");
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	return size;
 }
 
@@ -210,9 +200,9 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 					      unsigned long size)
 {
 	unsigned long tmp1, tmp2;
-	mm_segment_t old_fs;
+	bool old;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	tmp1 = -256UL;
 	asm volatile(
 		"   sacf  0\n"
@@ -239,7 +229,7 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: : "cc", "memory");
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	return size;
 }
 
@@ -277,10 +267,10 @@ static inline unsigned long copy_in_user_mvcos(void __user *to, const void __use
 static inline unsigned long copy_in_user_mvc(void __user *to, const void __user *from,
 					     unsigned long size)
 {
-	mm_segment_t old_fs;
 	unsigned long tmp1;
+	bool old;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	asm volatile(
 		"   sacf  256\n"
 		"   aghi  %0,-1\n"
@@ -304,7 +294,7 @@ static inline unsigned long copy_in_user_mvc(void __user *to, const void __user
 		EX_TABLE(1b,6b) EX_TABLE(2b,0b) EX_TABLE(4b,0b)
 		: "+a" (size), "+a" (to), "+a" (from), "=a" (tmp1)
 		: : "cc", "memory");
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	return size;
 }
 
@@ -346,10 +336,10 @@ static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size
 
 static inline unsigned long clear_user_xc(void __user *to, unsigned long size)
 {
-	mm_segment_t old_fs;
 	unsigned long tmp1, tmp2;
+	bool old;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	asm volatile(
 		"   sacf  256\n"
 		"   aghi  %0,-1\n"
@@ -378,7 +368,7 @@ static inline unsigned long clear_user_xc(void __user *to, unsigned long size)
 		EX_TABLE(1b,6b) EX_TABLE(2b,0b) EX_TABLE(4b,0b)
 		: "+a" (size), "+a" (to), "=a" (tmp1), "=a" (tmp2)
 		: : "cc", "memory");
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	return size;
 }
 
@@ -414,14 +404,14 @@ static inline unsigned long strnlen_user_srst(const char __user *src,
 
 unsigned long __strnlen_user(const char __user *src, unsigned long size)
 {
-	mm_segment_t old_fs;
 	unsigned long len;
+	bool old;
 
 	if (unlikely(!size))
 		return 0;
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	len = strnlen_user_srst(src, size);
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	return len;
 }
 EXPORT_SYMBOL(__strnlen_user);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4c8c063bce5b..86569da371a1 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -80,17 +80,14 @@ static enum fault_type get_fault_type(struct pt_regs *regs)
 		if (IS_ENABLED(CONFIG_PGSTE) &&
 		    test_pt_regs_flag(regs, PIF_GUEST_FAULT))
 			return GMAP_FAULT;
-		if (current->thread.mm_segment == USER_DS)
+		if (!current->thread.sacf_uaccess)
 			return USER_FAULT;
 		return KERNEL_FAULT;
 	}
 	if (trans_exc_code == 2) {
 		/* secondary space exception */
-		if (current->thread.mm_segment & 1) {
-			if (current->thread.mm_segment == USER_DS_SACF)
-				return USER_FAULT;
-			return KERNEL_FAULT;
-		}
+		if (current->thread.sacf_uaccess)
+			return USER_FAULT;
 		return VDSO_FAULT;
 	}
 	if (trans_exc_code == 1) {
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 11d2c8395e2a..0d748645694c 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -73,15 +73,14 @@ static void __crst_table_upgrade(void *arg)
 	/* we must change all active ASCEs to avoid the creation of new TLBs */
 	if (current->active_mm == mm) {
 		S390_lowcore.user_asce = mm->context.asce;
-		if (current->thread.mm_segment == USER_DS) {
-			__ctl_load(S390_lowcore.user_asce, 1, 1);
-			/* Mark user-ASCE present in CR1 */
-			clear_cpu_flag(CIF_ASCE_PRIMARY);
-		}
-		if (current->thread.mm_segment == USER_DS_SACF) {
+		if (current->thread.sacf_uaccess) {
 			__ctl_load(S390_lowcore.user_asce, 7, 7);
 			/* enable_sacf_uaccess does all or nothing */
 			WARN_ON(!test_cpu_flag(CIF_ASCE_SECONDARY));
+		} else {
+			__ctl_load(S390_lowcore.user_asce, 1, 1);
+			/* Mark user-ASCE present in CR1 */
+			clear_cpu_flag(CIF_ASCE_PRIMARY);
 		}
 	}
 	__tlb_flush_local();
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 401cf670a243..6fff2e5e27df 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -93,12 +93,12 @@ static inline int __memcpy_toio_inuser(void __iomem *dst,
 {
 	int size, rc = 0;
 	u8 status = 0;
-	mm_segment_t old_fs;
+	bool old;
 
 	if (!src)
 		return -EINVAL;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	while (n > 0) {
 		size = zpci_get_max_write_size((u64 __force) dst,
 					       (u64 __force) src, n,
@@ -113,7 +113,7 @@ static inline int __memcpy_toio_inuser(void __iomem *dst,
 		dst += size;
 		n -= size;
 	}
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	if (rc)
 		zpci_err_mmio(rc, status, (__force u64) dst);
 	return rc;
@@ -248,9 +248,9 @@ static inline int __memcpy_fromio_inuser(void __user *dst,
 {
 	int size, rc = 0;
 	u8 status;
-	mm_segment_t old_fs;
+	bool old;
 
-	old_fs = enable_sacf_uaccess();
+	old = enable_sacf_uaccess();
 	while (n > 0) {
 		size = zpci_get_max_write_size((u64 __force) src,
 					       (u64 __force) dst, n,
@@ -262,7 +262,7 @@ static inline int __memcpy_fromio_inuser(void __user *dst,
 		dst += size;
 		n -= size;
 	}
-	disable_sacf_uaccess(old_fs);
+	disable_sacf_uaccess(old);
 	if (rc)
 		zpci_err_mmio(rc, status, (__force u64) dst);
 	return rc;
-- 
2.17.1
