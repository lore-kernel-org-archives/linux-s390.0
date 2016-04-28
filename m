Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 10:08:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.6-rc6
Message-ID: <20160428100819.39b39b7a@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Three more bug fixes for 4.6
  * Due to a race in the dynamic page table code a multi-threaded program
    can cause a translation specification exception. With panic_on_oops a
    user space program can crash the system.
  * An information leak with the /dev/sclp device.
  * A use after free in the s390 PCI code.

Gerald Schaefer (1):
      s390/mm: fix asce_bits handling with dynamic pagetable levels

Martin Schwidefsky (1):
      s390/sclp_ctl: fix potential information leak with /dev/sclp

Sebastian Ott (1):
      s390/pci: fix use after free in dma_init

 arch/s390/include/asm/mmu.h         |  2 +-
 arch/s390/include/asm/mmu_context.h | 28 +++++++++---
 arch/s390/include/asm/pgalloc.h     |  4 +-
 arch/s390/include/asm/processor.h   |  2 +-
 arch/s390/include/asm/tlbflush.h    |  9 ++--
 arch/s390/mm/init.c                 |  3 +-
 arch/s390/mm/mmap.c                 |  6 +--
 arch/s390/mm/pgalloc.c              | 85 ++++++++++++-------------------------
 arch/s390/pci/pci_dma.c             | 16 ++++---
 drivers/s390/char/sclp_ctl.c        | 12 +++---
 10 files changed, 79 insertions(+), 88 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index d29ad95..081b2ad 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -11,7 +11,7 @@ typedef struct {
 	spinlock_t list_lock;
 	struct list_head pgtable_list;
 	struct list_head gmap_list;
-	unsigned long asce_bits;
+	unsigned long asce;
 	unsigned long asce_limit;
 	unsigned long vdso_base;
 	/* The mmu context allocates 4K page tables. */
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index d321469..c837b79 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -26,12 +26,28 @@ static inline int init_new_context(struct task_struct *tsk,
 	mm->context.has_pgste = 0;
 	mm->context.use_skey = 0;
 #endif
-	if (mm->context.asce_limit == 0) {
+	switch (mm->context.asce_limit) {
+	case 1UL << 42:
+		/*
+		 * forked 3-level task, fall through to set new asce with new
+		 * mm->pgd
+		 */
+	case 0:
 		/* context created by exec, set asce limit to 4TB */
-		mm->context.asce_bits = _ASCE_TABLE_LENGTH |
-			_ASCE_USER_BITS | _ASCE_TYPE_REGION3;
 		mm->context.asce_limit = STACK_TOP_MAX;
-	} else if (mm->context.asce_limit == (1UL << 31)) {
+		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				   _ASCE_USER_BITS | _ASCE_TYPE_REGION3;
+		break;
+	case 1UL << 53:
+		/* forked 4-level task, set new asce with new mm->pgd */
+		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				   _ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+		break;
+	case 1UL << 31:
+		/* forked 2-level compat task, set new asce with new mm->pgd */
+		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
+		/* pgd_alloc() did not increase mm->nr_pmds */
 		mm_inc_nr_pmds(mm);
 	}
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
@@ -42,7 +58,7 @@ static inline int init_new_context(struct task_struct *tsk,
 
 static inline void set_user_asce(struct mm_struct *mm)
 {
-	S390_lowcore.user_asce = mm->context.asce_bits | __pa(mm->pgd);
+	S390_lowcore.user_asce = mm->context.asce;
 	if (current->thread.mm_segment.ar4)
 		__ctl_load(S390_lowcore.user_asce, 7, 7);
 	set_cpu_flag(CIF_ASCE);
@@ -71,7 +87,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	int cpu = smp_processor_id();
 
-	S390_lowcore.user_asce = next->context.asce_bits | __pa(next->pgd);
+	S390_lowcore.user_asce = next->context.asce;
 	if (prev == next)
 		return;
 	if (MACHINE_HAS_TLB_LC)
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 9b3d9b6..da34cb6 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -52,8 +52,8 @@ static inline unsigned long pgd_entry_type(struct mm_struct *mm)
 	return _REGION2_ENTRY_EMPTY;
 }
 
-int crst_table_upgrade(struct mm_struct *, unsigned long limit);
-void crst_table_downgrade(struct mm_struct *, unsigned long limit);
+int crst_table_upgrade(struct mm_struct *);
+void crst_table_downgrade(struct mm_struct *);
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index d6fd22e..18cdede 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -175,7 +175,7 @@ extern __vector128 init_task_fpu_regs[__NUM_VXRS];
 	regs->psw.mask	= PSW_USER_BITS | PSW_MASK_BA;			\
 	regs->psw.addr	= new_psw;					\
 	regs->gprs[15]	= new_stackp;					\
-	crst_table_downgrade(current->mm, 1UL << 31);			\
+	crst_table_downgrade(current->mm);				\
 	execve_tail();							\
 } while (0)
 
diff --git a/arch/s390/include/asm/tlbflush.h b/arch/s390/include/asm/tlbflush.h
index ca148f7..a2e6ef3 100644
--- a/arch/s390/include/asm/tlbflush.h
+++ b/arch/s390/include/asm/tlbflush.h
@@ -110,8 +110,7 @@ static inline void __tlb_flush_asce(struct mm_struct *mm, unsigned long asce)
 static inline void __tlb_flush_kernel(void)
 {
 	if (MACHINE_HAS_IDTE)
-		__tlb_flush_idte((unsigned long) init_mm.pgd |
-				 init_mm.context.asce_bits);
+		__tlb_flush_idte(init_mm.context.asce);
 	else
 		__tlb_flush_global();
 }
@@ -133,8 +132,7 @@ static inline void __tlb_flush_asce(struct mm_struct *mm, unsigned long asce)
 static inline void __tlb_flush_kernel(void)
 {
 	if (MACHINE_HAS_TLB_LC)
-		__tlb_flush_idte_local((unsigned long) init_mm.pgd |
-				       init_mm.context.asce_bits);
+		__tlb_flush_idte_local(init_mm.context.asce);
 	else
 		__tlb_flush_local();
 }
@@ -148,8 +146,7 @@ static inline void __tlb_flush_mm(struct mm_struct * mm)
 	 * only ran on the local cpu.
 	 */
 	if (MACHINE_HAS_IDTE && list_empty(&mm->context.gmap_list))
-		__tlb_flush_asce(mm, (unsigned long) mm->pgd |
-				 mm->context.asce_bits);
+		__tlb_flush_asce(mm, mm->context.asce);
 	else
 		__tlb_flush_full(mm);
 }
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index c7b0451..2489b2e 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -89,7 +89,8 @@ void __init paging_init(void)
 		asce_bits = _ASCE_TYPE_REGION3 | _ASCE_TABLE_LENGTH;
 		pgd_type = _REGION3_ENTRY_EMPTY;
 	}
-	S390_lowcore.kernel_asce = (__pa(init_mm.pgd) & PAGE_MASK) | asce_bits;
+	init_mm.context.asce = (__pa(init_mm.pgd) & PAGE_MASK) | asce_bits;
+	S390_lowcore.kernel_asce = init_mm.context.asce;
 	clear_table((unsigned long *) init_mm.pgd, pgd_type,
 		    sizeof(unsigned long)*2048);
 	vmem_map_init();
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 45c4daa..89cf09e 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -174,7 +174,7 @@ int s390_mmap_check(unsigned long addr, unsigned long len, unsigned long flags)
 	if (!(flags & MAP_FIXED))
 		addr = 0;
 	if ((addr + len) >= TASK_SIZE)
-		return crst_table_upgrade(current->mm, TASK_MAX_SIZE);
+		return crst_table_upgrade(current->mm);
 	return 0;
 }
 
@@ -191,7 +191,7 @@ s390_get_unmapped_area(struct file *filp, unsigned long addr,
 		return area;
 	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < TASK_MAX_SIZE) {
 		/* Upgrade the page table to 4 levels and retry. */
-		rc = crst_table_upgrade(mm, TASK_MAX_SIZE);
+		rc = crst_table_upgrade(mm);
 		if (rc)
 			return (unsigned long) rc;
 		area = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
@@ -213,7 +213,7 @@ s390_get_unmapped_area_topdown(struct file *filp, const unsigned long addr,
 		return area;
 	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < TASK_MAX_SIZE) {
 		/* Upgrade the page table to 4 levels and retry. */
-		rc = crst_table_upgrade(mm, TASK_MAX_SIZE);
+		rc = crst_table_upgrade(mm);
 		if (rc)
 			return (unsigned long) rc;
 		area = arch_get_unmapped_area_topdown(filp, addr, len,
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index f6c3de2..e8b5962 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -76,81 +76,52 @@ static void __crst_table_upgrade(void *arg)
 	__tlb_flush_local();
 }
 
-int crst_table_upgrade(struct mm_struct *mm, unsigned long limit)
+int crst_table_upgrade(struct mm_struct *mm)
 {
 	unsigned long *table, *pgd;
-	unsigned long entry;
-	int flush;
 
-	BUG_ON(limit > TASK_MAX_SIZE);
-	flush = 0;
-repeat:
+	/* upgrade should only happen from 3 to 4 levels */
+	BUG_ON(mm->context.asce_limit != (1UL << 42));
+
 	table = crst_table_alloc(mm);
 	if (!table)
 		return -ENOMEM;
+
 	spin_lock_bh(&mm->page_table_lock);
-	if (mm->context.asce_limit < limit) {
-		pgd = (unsigned long *) mm->pgd;
-		if (mm->context.asce_limit <= (1UL << 31)) {
-			entry = _REGION3_ENTRY_EMPTY;
-			mm->context.asce_limit = 1UL << 42;
-			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
-						_ASCE_USER_BITS |
-						_ASCE_TYPE_REGION3;
-		} else {
-			entry = _REGION2_ENTRY_EMPTY;
-			mm->context.asce_limit = 1UL << 53;
-			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
-						_ASCE_USER_BITS |
-						_ASCE_TYPE_REGION2;
-		}
-		crst_table_init(table, entry);
-		pgd_populate(mm, (pgd_t *) table, (pud_t *) pgd);
-		mm->pgd = (pgd_t *) table;
-		mm->task_size = mm->context.asce_limit;
-		table = NULL;
-		flush = 1;
-	}
+	pgd = (unsigned long *) mm->pgd;
+	crst_table_init(table, _REGION2_ENTRY_EMPTY);
+	pgd_populate(mm, (pgd_t *) table, (pud_t *) pgd);
+	mm->pgd = (pgd_t *) table;
+	mm->context.asce_limit = 1UL << 53;
+	mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+			   _ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+	mm->task_size = mm->context.asce_limit;
 	spin_unlock_bh(&mm->page_table_lock);
-	if (table)
-		crst_table_free(mm, table);
-	if (mm->context.asce_limit < limit)
-		goto repeat;
-	if (flush)
-		on_each_cpu(__crst_table_upgrade, mm, 0);
+
+	on_each_cpu(__crst_table_upgrade, mm, 0);
 	return 0;
 }
 
-void crst_table_downgrade(struct mm_struct *mm, unsigned long limit)
+void crst_table_downgrade(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 
+	/* downgrade should only happen from 3 to 2 levels (compat only) */
+	BUG_ON(mm->context.asce_limit != (1UL << 42));
+
 	if (current->active_mm == mm) {
 		clear_user_asce();
 		__tlb_flush_mm(mm);
 	}
-	while (mm->context.asce_limit > limit) {
-		pgd = mm->pgd;
-		switch (pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) {
-		case _REGION_ENTRY_TYPE_R2:
-			mm->context.asce_limit = 1UL << 42;
-			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
-						_ASCE_USER_BITS |
-						_ASCE_TYPE_REGION3;
-			break;
-		case _REGION_ENTRY_TYPE_R3:
-			mm->context.asce_limit = 1UL << 31;
-			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
-						_ASCE_USER_BITS |
-						_ASCE_TYPE_SEGMENT;
-			break;
-		default:
-			BUG();
-		}
-		mm->pgd = (pgd_t *) (pgd_val(*pgd) & _REGION_ENTRY_ORIGIN);
-		mm->task_size = mm->context.asce_limit;
-		crst_table_free(mm, (unsigned long *) pgd);
-	}
+
+	pgd = mm->pgd;
+	mm->pgd = (pgd_t *) (pgd_val(*pgd) & _REGION_ENTRY_ORIGIN);
+	mm->context.asce_limit = 1UL << 31;
+	mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+			   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
+	mm->task_size = mm->context.asce_limit;
+	crst_table_free(mm, (unsigned long *) pgd);
+
 	if (current->active_mm == mm)
 		set_user_asce(mm);
 }
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index e595e89..1ea8c07 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -457,7 +457,7 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 	zdev->dma_table = dma_alloc_cpu_table();
 	if (!zdev->dma_table) {
 		rc = -ENOMEM;
-		goto out_clean;
+		goto out;
 	}
 
 	/*
@@ -477,18 +477,22 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 	zdev->iommu_bitmap = vzalloc(zdev->iommu_pages / 8);
 	if (!zdev->iommu_bitmap) {
 		rc = -ENOMEM;
-		goto out_reg;
+		goto free_dma_table;
 	}
 
 	rc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				(u64) zdev->dma_table);
 	if (rc)
-		goto out_reg;
-	return 0;
+		goto free_bitmap;
 
-out_reg:
+	return 0;
+free_bitmap:
+	vfree(zdev->iommu_bitmap);
+	zdev->iommu_bitmap = NULL;
+free_dma_table:
 	dma_free_cpu_table(zdev->dma_table);
-out_clean:
+	zdev->dma_table = NULL;
+out:
 	return rc;
 }
 
diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index 648cb86..ea607a4 100644
--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -56,6 +56,7 @@ static int sclp_ctl_ioctl_sccb(void __user *user_area)
 {
 	struct sclp_ctl_sccb ctl_sccb;
 	struct sccb_header *sccb;
+	unsigned long copied;
 	int rc;
 
 	if (copy_from_user(&ctl_sccb, user_area, sizeof(ctl_sccb)))
@@ -65,14 +66,15 @@ static int sclp_ctl_ioctl_sccb(void __user *user_area)
 	sccb = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
-	if (copy_from_user(sccb, u64_to_uptr(ctl_sccb.sccb), sizeof(*sccb))) {
+	copied = PAGE_SIZE -
+		copy_from_user(sccb, u64_to_uptr(ctl_sccb.sccb), PAGE_SIZE);
+	if (offsetof(struct sccb_header, length) +
+	    sizeof(sccb->length) > copied || sccb->length > copied) {
 		rc = -EFAULT;
 		goto out_free;
 	}
-	if (sccb->length > PAGE_SIZE || sccb->length < 8)
-		return -EINVAL;
-	if (copy_from_user(sccb, u64_to_uptr(ctl_sccb.sccb), sccb->length)) {
-		rc = -EFAULT;
+	if (sccb->length < 8) {
+		rc = -EINVAL;
 		goto out_free;
 	}
 	rc = sclp_sync_request(ctl_sccb.cmdw, sccb);
