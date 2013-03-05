From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/8] s390/mm,gmap: implement gmap_translate()
Date: Tue,  5 Mar 2013 13:14:41 +0100
Message-ID: <1362485687-2799-3-git-send-email-borntraeger@de.ibm.com>
References: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Implement gmap_translate() function which translates a guest absolute address
to a user space process address without establishing the guest page table
entries.

This is useful for kvm guest address translations where no memory access
is expected to happen soon (e.g. tprot exception handler).

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |   2 +
 arch/s390/mm/pgtable.c          | 107 +++++++++++++++++++++++++++++++---------
 2 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 4a29308..75b8750 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -759,6 +759,8 @@ void gmap_disable(struct gmap *gmap);
 int gmap_map_segment(struct gmap *gmap, unsigned long from,
 		     unsigned long to, unsigned long length);
 int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len);
+unsigned long __gmap_translate(unsigned long address, struct gmap *);
+unsigned long gmap_translate(unsigned long address, struct gmap *);
 unsigned long __gmap_fault(unsigned long address, struct gmap *);
 unsigned long gmap_fault(unsigned long address, struct gmap *);
 void gmap_discard(unsigned long from, unsigned long to, struct gmap *);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index ae44d2a..2accf71 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -379,45 +379,108 @@ out_unmap:
 }
 EXPORT_SYMBOL_GPL(gmap_map_segment);
 
+static unsigned long *gmap_table_walk(unsigned long address, struct gmap *gmap)
+{
+	unsigned long *table;
+
+	table = gmap->table + ((address >> 53) & 0x7ff);
+	if (unlikely(*table & _REGION_ENTRY_INV))
+		return ERR_PTR(-EFAULT);
+	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	table = table + ((address >> 42) & 0x7ff);
+	if (unlikely(*table & _REGION_ENTRY_INV))
+		return ERR_PTR(-EFAULT);
+	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	table = table + ((address >> 31) & 0x7ff);
+	if (unlikely(*table & _REGION_ENTRY_INV))
+		return ERR_PTR(-EFAULT);
+	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	table = table + ((address >> 20) & 0x7ff);
+	return table;
+}
+
+/**
+ * __gmap_translate - translate a guest address to a user space address
+ * @address: guest address
+ * @gmap: pointer to guest mapping meta data structure
+ *
+ * Returns user space address which corresponds to the guest address or
+ * -EFAULT if no such mapping exists.
+ * This function does not establish potentially missing page table entries.
+ * The mmap_sem of the mm that belongs to the address space must be held
+ * when this function gets called.
+ */
+unsigned long __gmap_translate(unsigned long address, struct gmap *gmap)
+{
+	unsigned long *segment_ptr, vmaddr, segment;
+	struct gmap_pgtable *mp;
+	struct page *page;
+
+	current->thread.gmap_addr = address;
+	segment_ptr = gmap_table_walk(address, gmap);
+	if (IS_ERR(segment_ptr))
+		return PTR_ERR(segment_ptr);
+	/* Convert the gmap address to an mm address. */
+	segment = *segment_ptr;
+	if (!(segment & _SEGMENT_ENTRY_INV)) {
+		page = pfn_to_page(segment >> PAGE_SHIFT);
+		mp = (struct gmap_pgtable *) page->index;
+		return mp->vmaddr | (address & ~PMD_MASK);
+	} else if (segment & _SEGMENT_ENTRY_RO) {
+		vmaddr = segment & _SEGMENT_ENTRY_ORIGIN;
+		return vmaddr | (address & ~PMD_MASK);
+	}
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(__gmap_translate);
+
+/**
+ * gmap_translate - translate a guest address to a user space address
+ * @address: guest address
+ * @gmap: pointer to guest mapping meta data structure
+ *
+ * Returns user space address which corresponds to the guest address or
+ * -EFAULT if no such mapping exists.
+ * This function does not establish potentially missing page table entries.
+ */
+unsigned long gmap_translate(unsigned long address, struct gmap *gmap)
+{
+	unsigned long rc;
+
+	down_read(&gmap->mm->mmap_sem);
+	rc = __gmap_translate(address, gmap);
+	up_read(&gmap->mm->mmap_sem);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gmap_translate);
+
 /*
  * this function is assumed to be called with mmap_sem held
  */
 unsigned long __gmap_fault(unsigned long address, struct gmap *gmap)
 {
-	unsigned long *table, vmaddr, segment;
-	struct mm_struct *mm;
+	unsigned long *segment_ptr, vmaddr, segment;
+	struct vm_area_struct *vma;
 	struct gmap_pgtable *mp;
 	struct gmap_rmap *rmap;
-	struct vm_area_struct *vma;
+	struct mm_struct *mm;
 	struct page *page;
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 
 	current->thread.gmap_addr = address;
-	mm = gmap->mm;
-	/* Walk the gmap address space page table */
-	table = gmap->table + ((address >> 53) & 0x7ff);
-	if (unlikely(*table & _REGION_ENTRY_INV))
-		return -EFAULT;
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((address >> 42) & 0x7ff);
-	if (unlikely(*table & _REGION_ENTRY_INV))
+	segment_ptr = gmap_table_walk(address, gmap);
+	if (IS_ERR(segment_ptr))
 		return -EFAULT;
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((address >> 31) & 0x7ff);
-	if (unlikely(*table & _REGION_ENTRY_INV))
-		return -EFAULT;
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((address >> 20) & 0x7ff);
-
 	/* Convert the gmap address to an mm address. */
-	segment = *table;
-	if (likely(!(segment & _SEGMENT_ENTRY_INV))) {
+	segment = *segment_ptr;
+	if (!(segment & _SEGMENT_ENTRY_INV)) {
 		page = pfn_to_page(segment >> PAGE_SHIFT);
 		mp = (struct gmap_pgtable *) page->index;
 		return mp->vmaddr | (address & ~PMD_MASK);
 	} else if (segment & _SEGMENT_ENTRY_RO) {
+		mm = gmap->mm;
 		vmaddr = segment & _SEGMENT_ENTRY_ORIGIN;
 		vma = find_vma(mm, vmaddr);
 		if (!vma || vma->vm_start > vmaddr)
@@ -441,12 +504,12 @@ unsigned long __gmap_fault(unsigned long address, struct gmap *gmap)
 		/* Link gmap segment table entry location to page table. */
 		page = pmd_page(*pmd);
 		mp = (struct gmap_pgtable *) page->index;
-		rmap->entry = table;
+		rmap->entry = segment_ptr;
 		spin_lock(&mm->page_table_lock);
 		list_add(&rmap->list, &mp->mapper);
 		spin_unlock(&mm->page_table_lock);
 		/* Set gmap segment table entry to page table. */
-		*table = pmd_val(*pmd) & PAGE_MASK;
+		*segment_ptr = pmd_val(*pmd) & PAGE_MASK;
 		return vmaddr | (address & ~PMD_MASK);
 	}
 	return -EFAULT;
-- 
1.8.0.1
