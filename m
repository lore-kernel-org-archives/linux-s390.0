Return-Path: <linux-kernel-owner+w=401wt.eu-S1755415AbYCLRep@vger.kernel.org>
Message-Id: <20080312173218.186436562@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
Date: Wed, 12 Mar 2008 18:32:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/10] Hugetlb common code update for System z.
Content-Disposition: inline; filename=109-hugetlb-defines.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <geraldsc@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <geraldsc@de.ibm.com>

Huge ptes have a special type on s390 and cannot be handled with the
standard pte functions in certain cases. This patch adds some new
architecture-specific definitions and functions to hugetlb common code,
as a prerequisite for the System z large page support. They won't
affect other architectures.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/hugetlb.h |   18 ++++++++++++++++++
 mm/hugetlb.c            |   36 +++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 15 deletions(-)

Index: quilt-2.6/include/linux/hugetlb.h
===================================================================
--- quilt-2.6.orig/include/linux/hugetlb.h
+++ quilt-2.6/include/linux/hugetlb.h
@@ -80,6 +80,24 @@ static inline int prepare_hugepage_range
 int prepare_hugepage_range(unsigned long addr, unsigned long len);
 #endif
 
+#ifndef ARCH_HAS_HUGE_PTE_TYPE
+#define huge_pte_none(pte)			pte_none(pte)
+#define huge_pte_wrprotect(pte)			pte_wrprotect(pte)
+#define huge_ptep_set_wrprotect(mm, addr, ptep)	\
+	ptep_set_wrprotect(mm, addr, ptep)
+#define huge_ptep_set_access_flags(vma, addr, ptep, pte, dirty)	\
+	ptep_set_access_flags(vma, addr, ptep, pte, dirty)
+#define huge_ptep_get(ptep)			(*ptep)
+#endif
+
+#ifndef ARCH_HAS_PREPARE_HUGEPAGE
+#define arch_prepare_hugepage(page)		0
+#define arch_release_hugepage(page)		do { } while (0)
+#else
+int arch_prepare_hugepage(struct page *page);
+void arch_release_hugepage(struct page *page);
+#endif
+
 #ifndef ARCH_HAS_HUGEPAGE_CLEAR_FLUSH
 #define huge_ptep_clear_flush(vma, addr, ptep)	do { } while (0)
 #endif
Index: quilt-2.6/mm/hugetlb.c
===================================================================
--- quilt-2.6.orig/mm/hugetlb.c
+++ quilt-2.6/mm/hugetlb.c
@@ -129,6 +129,7 @@ static void update_and_free_page(struct 
 	}
 	set_compound_page_dtor(page, NULL);
 	set_page_refcounted(page);
+	arch_release_hugepage(page);
 	__free_pages(page, HUGETLB_PAGE_ORDER);
 }
 
@@ -198,6 +199,10 @@ static struct page *alloc_fresh_huge_pag
 		htlb_alloc_mask|__GFP_COMP|__GFP_THISNODE|__GFP_NOWARN,
 		HUGETLB_PAGE_ORDER);
 	if (page) {
+		if (arch_prepare_hugepage(page)) {
+			__free_pages(page, HUGETLB_PAGE_ORDER);
+			return 0;
+		}
 		set_compound_page_dtor(page, free_huge_page);
 		spin_lock(&hugetlb_lock);
 		nr_huge_pages++;
@@ -707,7 +712,7 @@ static pte_t make_huge_pte(struct vm_are
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	} else {
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
+		entry = huge_pte_wrprotect(mk_pte(page, vma->vm_page_prot));
 	}
 	entry = pte_mkyoung(entry);
 	entry = pte_mkhuge(entry);
@@ -720,8 +725,8 @@ static void set_huge_ptep_writable(struc
 {
 	pte_t entry;
 
-	entry = pte_mkwrite(pte_mkdirty(*ptep));
-	if (ptep_set_access_flags(vma, address, ptep, entry, 1)) {
+	entry = pte_mkwrite(pte_mkdirty(huge_ptep_get(ptep)));
+	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1)) {
 		update_mmu_cache(vma, address, entry);
 	}
 }
@@ -751,10 +756,10 @@ int copy_hugetlb_page_range(struct mm_st
 
 		spin_lock(&dst->page_table_lock);
 		spin_lock(&src->page_table_lock);
-		if (!pte_none(*src_pte)) {
+		if (!huge_pte_none(huge_ptep_get(src_pte))) {
 			if (cow)
-				ptep_set_wrprotect(src, addr, src_pte);
-			entry = *src_pte;
+				huge_ptep_set_wrprotect(src, addr, src_pte);
+			entry = huge_ptep_get(src_pte);
 			ptepage = pte_page(entry);
 			get_page(ptepage);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
@@ -798,7 +803,7 @@ void __unmap_hugepage_range(struct vm_ar
 			continue;
 
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
-		if (pte_none(pte))
+		if (huge_pte_none(pte))
 			continue;
 
 		page = pte_page(pte);
@@ -862,7 +867,7 @@ static int hugetlb_cow(struct mm_struct 
 	spin_lock(&mm->page_table_lock);
 
 	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
-	if (likely(pte_same(*ptep, pte))) {
+	if (likely(pte_same(huge_ptep_get(ptep), pte))) {
 		/* Break COW */
 		huge_ptep_clear_flush(vma, address, ptep);
 		set_huge_pte_at(mm, address, ptep,
@@ -932,7 +937,7 @@ retry:
 		goto backout;
 
 	ret = 0;
-	if (!pte_none(*ptep))
+	if (!huge_pte_none(huge_ptep_get(ptep)))
 		goto backout;
 
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
@@ -974,8 +979,8 @@ int hugetlb_fault(struct mm_struct *mm, 
 	 * the same page in the page cache.
 	 */
 	mutex_lock(&hugetlb_instantiation_mutex);
-	entry = *ptep;
-	if (pte_none(entry)) {
+	entry = huge_ptep_get(ptep);
+	if (huge_pte_none(entry)) {
 		ret = hugetlb_no_page(mm, vma, address, ptep, write_access);
 		mutex_unlock(&hugetlb_instantiation_mutex);
 		return ret;
@@ -985,7 +990,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 
 	spin_lock(&mm->page_table_lock);
 	/* Check for a racing update before calling hugetlb_cow */
-	if (likely(pte_same(entry, *ptep)))
+	if (likely(pte_same(entry, huge_ptep_get(ptep))))
 		if (write_access && !pte_write(entry))
 			ret = hugetlb_cow(mm, vma, address, ptep, entry);
 	spin_unlock(&mm->page_table_lock);
@@ -1015,7 +1020,8 @@ int follow_hugetlb_page(struct mm_struct
 		 */
 		pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
 
-		if (!pte || pte_none(*pte) || (write && !pte_write(*pte))) {
+		if (!pte || huge_pte_none(huge_ptep_get(pte)) ||
+		    (write && !pte_write(huge_ptep_get(pte)))) {
 			int ret;
 
 			spin_unlock(&mm->page_table_lock);
@@ -1031,7 +1037,7 @@ int follow_hugetlb_page(struct mm_struct
 		}
 
 		pfn_offset = (vaddr & ~HPAGE_MASK) >> PAGE_SHIFT;
-		page = pte_page(*pte);
+		page = pte_page(huge_ptep_get(pte));
 same_page:
 		if (pages) {
 			get_page(page);
@@ -1080,7 +1086,7 @@ void hugetlb_change_protection(struct vm
 			continue;
 		if (huge_pmd_unshare(mm, &address, ptep))
 			continue;
-		if (!pte_none(*ptep)) {
+		if (!huge_pte_none(huge_ptep_get(ptep))) {
 			pte = huge_ptep_get_and_clear(mm, address, ptep);
 			pte = pte_mkhuge(pte_modify(pte, newprot));
 			set_huge_pte_at(mm, address, ptep, pte);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
