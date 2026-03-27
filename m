Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FE3101B6
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577758; cv=none; b=eL+yKWxVl6ZeiQpe9AY8+JMoa/yVrnYnI+NbUlKAH62jL5ikb7gEuDDO4oVViBX36CWk06nZGAINwIrlZ/ekndHRe282N5DouUyxWNO1ttNATX1TTLiOW/EAnDlvOQIzq7j7tL283j280nA56L021Ve6GO1vC8wq/+aJe+ALISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577758; c=relaxed/simple;
	bh=4RNHDJsarktqazcp37gv2tFLbvHdmscrGWuxP6+aR2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnCX1oXMVG8lNjSV8VRH14COh6mpLyo5dIzw+FUZYhXPcM7rcRYoPPfApBlk+YGGxM7kKkNcjIW8Ysu4Lss88/Bj+ylJBZ/62As7k+GMVEs/QWBUAfLeR9dk0lsnURysaJNvsU8m9vlHLn7XjBC2G+zLVBAiZUWIF985NtGHkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w30DGB4U; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w30DGB4U"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39bZVeDLCZMGYPUr+EAc/EnS1HXbPGaYLlzIdJWQkDw=;
	b=w30DGB4UyGXLzwfa4i4fkjpzxE6aN3Qb/p4ZKaRsPTAiSqe7v4evtfAT7/BH1HS7bkR3ee
	TPIhwTi3UpYkcx8TXWvhJiBwvNzLsYzefVS4KGsbhlTKHaRYF6+xMyROiJO8FjJH7HcP1c
	VHlLz8MpZzAFWrBdFHiUuP22FNKzK2o=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 17/24] mm: thp: allocate PTE page tables lazily at split time
Date: Thu, 26 Mar 2026 19:08:59 -0700
Message-ID: <20260327021403.214713-18-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the kernel creates a PMD-level THP mapping for anonymous pages,
it pre-allocates a PTE page table and deposits it via
pgtable_trans_huge_deposit(). This deposited table is withdrawn during
PMD split or zap. The rationale was that split must not fail—if the
kernel decides to split a THP, it needs a PTE table to populate.

However, every anon THP wastes 4KB (one page table page) that sits
unused in the deposit list for the lifetime of the mapping. On systems
with many THPs, this adds up to significant memory waste. The original
rationale is also not an issue. It is ok for split to fail, and if the
kernel can't find an order 0 allocation for split, there are much bigger
problems. On large servers where you can easily have 100s of GBs of THPs,
the memory usage for these tables is 200M per 100G. This memory could be
used for any other usecase, which include allocating the pagetables
required during split.

This patch removes the pre-deposit for anonymous pages on architectures
where arch_needs_pgtable_deposit() returns false (every arch apart from
powerpc, and only when radix hash tables are not enabled) and allocates
the PTE table lazily—only when a split actually occurs. The split path
is modified to accept a caller-provided page table.

PowerPC exception:

It would have been great if we can completely remove the pagetable
deposit code and this commit would mostly have been a code cleanup patch,
unfortunately PowerPC has hash MMU, it stores hash slot information in
the deposited page table and pre-deposit is necessary. All deposit/
withdraw paths are guarded by arch_needs_pgtable_deposit(), so PowerPC
behavior is unchanged with this patch. On a better note,
arch_needs_pgtable_deposit will always evaluate to false at compile time
on non PowerPC architectures and the pre-deposit code will not be
compiled in.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/huge_mm.h |   4 +-
 mm/huge_memory.c        | 158 ++++++++++++++++++++++++++--------------
 mm/khugepaged.c         |   7 +-
 mm/migrate_device.c     |  15 ++--
 mm/rmap.c               |  39 +++++++++-
 5 files changed, 158 insertions(+), 65 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c4d0badc4ce27..c02ba9c4b8d5b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -561,7 +561,7 @@ static inline bool thp_migration_supported(void)
 }
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
-			   pmd_t *pmd, bool freeze);
+			   pmd_t *pmd, bool freeze, pgtable_t pgtable);
 bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 			   pmd_t *pmdp, struct folio *folio);
 void map_anon_folio_pmd_nopf(struct folio *folio, pmd_t *pmd,
@@ -660,7 +660,7 @@ static inline int split_huge_pmd_address(struct vm_area_struct *vma,
 		unsigned long address, bool freeze) { return 0; }
 static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
 					 unsigned long address, pmd_t *pmd,
-					 bool freeze) {}
+					 bool freeze, pgtable_t pgtable) {}
 
 static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
 					 unsigned long addr, pmd_t *pmdp,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f4be707c8cb0..2acedb1de7404 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1309,17 +1309,19 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
-	pgtable_t pgtable;
+	pgtable_t pgtable = NULL;
 	vm_fault_t ret = 0;
 
 	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
 	if (unlikely(!folio))
 		return VM_FAULT_FALLBACK;
 
-	pgtable = pte_alloc_one(vma->vm_mm);
-	if (unlikely(!pgtable)) {
-		ret = VM_FAULT_OOM;
-		goto release;
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (unlikely(!pgtable)) {
+			ret = VM_FAULT_OOM;
+			goto release;
+		}
 	}
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -1334,14 +1336,18 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		if (userfaultfd_missing(vma)) {
 			spin_unlock(vmf->ptl);
 			folio_put(folio);
-			pte_free(vma->vm_mm, pgtable);
+			if (pgtable)
+				pte_free(vma->vm_mm, pgtable);
 			ret = handle_userfault(vmf, VM_UFFD_MISSING);
 			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			return ret;
 		}
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		if (pgtable) {
+			pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd,
+						   pgtable);
+			mm_inc_nr_ptes(vma->vm_mm);
+		}
 		map_anon_folio_pmd_pf(folio, vmf->pmd, vma, haddr);
-		mm_inc_nr_ptes(vma->vm_mm);
 		spin_unlock(vmf->ptl);
 	}
 
@@ -1437,9 +1443,11 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 	pmd_t entry;
 	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
 	entry = pmd_mkspecial(entry);
-	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	if (pgtable) {
+		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		mm_inc_nr_ptes(mm);
+	}
 	set_pmd_at(mm, haddr, pmd, entry);
-	mm_inc_nr_ptes(mm);
 }
 
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
@@ -1458,16 +1466,19 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
 			transparent_hugepage_use_zero_page()) {
-		pgtable_t pgtable;
+		pgtable_t pgtable = NULL;
 		struct folio *zero_folio;
 		vm_fault_t ret;
 
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (unlikely(!pgtable))
-			return VM_FAULT_OOM;
+		if (arch_needs_pgtable_deposit()) {
+			pgtable = pte_alloc_one(vma->vm_mm);
+			if (unlikely(!pgtable))
+				return VM_FAULT_OOM;
+		}
 		zero_folio = mm_get_huge_zero_folio(vma->vm_mm);
 		if (unlikely(!zero_folio)) {
-			pte_free(vma->vm_mm, pgtable);
+			if (pgtable)
+				pte_free(vma->vm_mm, pgtable);
 			count_vm_event(THP_FAULT_FALLBACK);
 			return VM_FAULT_FALLBACK;
 		}
@@ -1477,10 +1488,12 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			ret = check_stable_address_space(vma->vm_mm);
 			if (ret) {
 				spin_unlock(vmf->ptl);
-				pte_free(vma->vm_mm, pgtable);
+				if (pgtable)
+					pte_free(vma->vm_mm, pgtable);
 			} else if (userfaultfd_missing(vma)) {
 				spin_unlock(vmf->ptl);
-				pte_free(vma->vm_mm, pgtable);
+				if (pgtable)
+					pte_free(vma->vm_mm, pgtable);
 				ret = handle_userfault(vmf, VM_UFFD_MISSING);
 				VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			} else {
@@ -1491,7 +1504,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			}
 		} else {
 			spin_unlock(vmf->ptl);
-			pte_free(vma->vm_mm, pgtable);
+			if (pgtable)
+				pte_free(vma->vm_mm, pgtable);
 		}
 		return ret;
 	}
@@ -1823,8 +1837,10 @@ static void copy_huge_non_present_pmd(
 	}
 
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	if (pgtable) {
+		mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	}
 	if (!userfaultfd_wp(dst_vma))
 		pmd = pmd_swp_clear_uffd_wp(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
@@ -1864,9 +1880,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!vma_is_anonymous(dst_vma))
 		return 0;
 
-	pgtable = pte_alloc_one(dst_mm);
-	if (unlikely(!pgtable))
-		goto out;
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(dst_mm);
+		if (unlikely(!pgtable))
+			goto out;
+	}
 
 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
 	src_ptl = pmd_lockptr(src_mm, src_pmd);
@@ -1884,7 +1902,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
-		pte_free(dst_mm, pgtable);
+		if (pgtable)
+			pte_free(dst_mm, pgtable);
 		goto out_unlock;
 	}
 	/*
@@ -1910,7 +1929,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, dst_vma, src_vma))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
 		folio_put(src_folio);
-		pte_free(dst_mm, pgtable);
+		if (pgtable)
+			pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 		/*
@@ -1924,8 +1944,10 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 out_zero_page:
-	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	if (pgtable) {
+		mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	}
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
 	if (!userfaultfd_wp(dst_vma))
 		pmd = pmd_clear_uffd_wp(pmd);
@@ -2376,22 +2398,13 @@ static struct folio *normal_or_softleaf_folio_pmd(struct vm_area_struct *vma,
 static bool has_deposited_pgtable(struct vm_area_struct *vma, pmd_t pmdval,
 		struct folio *folio)
 {
-	/* Some architectures require unconditional depositing. */
-	if (arch_needs_pgtable_deposit())
-		return true;
-
-	/*
-	 * Huge zero always deposited except for DAX which handles itself, see
-	 * set_huge_zero_folio().
-	 */
-	if (is_huge_zero_pmd(pmdval))
-		return !vma_is_dax(vma);
-
 	/*
-	 * Otherwise, only anonymous folios are deposited, see
-	 * __do_huge_pmd_anonymous_page().
+	 * With lazy PTE page table allocation, only architectures that
+	 * require unconditional depositing (powerpc hash MMU) will have
+	 * deposited page tables. All other architectures allocate PTE
+	 * page tables lazily at split time.
 	 */
-	return folio && folio_test_anon(folio);
+	return arch_needs_pgtable_deposit();
 }
 
 /**
@@ -2514,7 +2527,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			force_flush = true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
-		if (pmd_move_must_withdraw(new_ptl, old_ptl, vma)) {
+		if (pmd_move_must_withdraw(new_ptl, old_ptl, vma) &&
+		    arch_needs_pgtable_deposit()) {
 			pgtable_t pgtable;
 			pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
@@ -2823,8 +2837,10 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
-	src_pgtable = pgtable_trans_huge_withdraw(mm, src_pmd);
-	pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
+	if (arch_needs_pgtable_deposit()) {
+		src_pgtable = pgtable_trans_huge_withdraw(mm, src_pmd);
+		pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
+	}
 unlock_ptls:
 	double_pt_unlock(src_ptl, dst_ptl);
 	/* unblock rmap walks */
@@ -2966,10 +2982,9 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
-		unsigned long haddr, pmd_t *pmd)
+		unsigned long haddr, pmd_t *pmd, pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgtable_t pgtable;
 	pmd_t _pmd, old_pmd;
 	unsigned long addr;
 	pte_t *pte;
@@ -2985,7 +3000,16 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	 */
 	old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
 
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	} else {
+		VM_BUG_ON(!pgtable);
+		/*
+		 * Account for the freshly allocated (in __split_huge_pmd) pgtable
+		 * being used in mm.
+		 */
+		mm_inc_nr_ptes(mm);
+	}
 	pmd_populate(mm, &_pmd, pgtable);
 
 	pte = pte_offset_map(&_pmd, haddr);
@@ -3007,12 +3031,11 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 }
 
 static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long haddr, bool freeze)
+		unsigned long haddr, bool freeze, pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
 	struct page *page;
-	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
 	bool soft_dirty, uffd_wp = false, young = false, write = false;
 	bool anon_exclusive = false, dirty = false;
@@ -3036,6 +3059,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
+		if (pgtable)
+			pte_free(mm, pgtable);
 		if (vma_is_special_huge(vma))
 			return;
 		if (unlikely(pmd_is_migration_entry(old_pmd))) {
@@ -3068,7 +3093,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 * small page also write protected so it does not seems useful
 		 * to invalidate secondary mmu at this time.
 		 */
-		return __split_huge_zero_page_pmd(vma, haddr, pmd);
+		return __split_huge_zero_page_pmd(vma, haddr, pmd, pgtable);
 	}
 
 	if (pmd_is_migration_entry(*pmd)) {
@@ -3192,7 +3217,16 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * Withdraw the table only after we mark the pmd entry invalid.
 	 * This's critical for some architectures (Power).
 	 */
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	} else {
+		VM_BUG_ON(!pgtable);
+		/*
+		 * Account for the freshly allocated (in __split_huge_pmd) pgtable
+		 * being used in mm.
+		 */
+		mm_inc_nr_ptes(mm);
+	}
 	pmd_populate(mm, &_pmd, pgtable);
 
 	pte = pte_offset_map(&_pmd, haddr);
@@ -3288,11 +3322,13 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 }
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
-			   pmd_t *pmd, bool freeze)
+			   pmd_t *pmd, bool freeze, pgtable_t pgtable)
 {
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
 	if (pmd_trans_huge(*pmd) || pmd_is_valid_softleaf(*pmd))
-		__split_huge_pmd_locked(vma, pmd, address, freeze);
+		__split_huge_pmd_locked(vma, pmd, address, freeze, pgtable);
+	else if (pgtable)
+		pte_free(vma->vm_mm, pgtable);
 }
 
 int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
@@ -3300,13 +3336,24 @@ int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
+	pgtable_t pgtable = NULL;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address & HPAGE_PMD_MASK,
 				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
+
+	/* allocate pagetable before acquiring pmd lock */
+	if (vma_is_anonymous(vma) && !arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable) {
+			mmu_notifier_invalidate_range_end(&range);
+			return -ENOMEM;
+		}
+	}
+
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	split_huge_pmd_locked(vma, range.start, pmd, freeze);
+	split_huge_pmd_locked(vma, range.start, pmd, freeze, pgtable);
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
 
@@ -3442,7 +3489,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	}
 
 	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
-	zap_deposited_table(mm, pmdp);
+	if (arch_needs_pgtable_deposit())
+		zap_deposited_table(mm, pmdp);
 	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 	if (vma->vm_flags & VM_LOCKED)
 		mlock_drain_local();
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d06d84219e1b8..40b33263f6135 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1239,7 +1239,12 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	if (arch_needs_pgtable_deposit()) {
+		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	} else {
+		mm_dec_nr_ptes(mm);
+		pte_free(mm, pgtable);
+	}
 	map_anon_folio_pmd_nopf(folio, pmd, vma, address);
 	spin_unlock(pmd_ptl);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 00003fbe803df..b9242217a81b6 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -829,9 +829,13 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 
 	__folio_mark_uptodate(folio);
 
-	pgtable = pte_alloc_one(vma->vm_mm);
-	if (unlikely(!pgtable))
-		goto abort;
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (unlikely(!pgtable))
+			goto abort;
+	} else {
+		pgtable = NULL;
+	}
 
 	if (folio_is_device_private(folio)) {
 		swp_entry_t swp_entry;
@@ -879,10 +883,11 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 	folio_get(folio);
 
 	if (flush) {
-		pte_free(vma->vm_mm, pgtable);
+		if (pgtable)
+			pte_free(vma->vm_mm, pgtable);
 		flush_cache_page(vma, addr, addr + HPAGE_PMD_SIZE);
 		pmdp_invalidate(vma, addr, pmdp);
-	} else {
+	} else if (pgtable) {
 		pgtable_trans_huge_deposit(vma->vm_mm, pmdp, pgtable);
 		mm_inc_nr_ptes(vma->vm_mm);
 	}
diff --git a/mm/rmap.c b/mm/rmap.c
index 78b7fb5f367ce..efbcdd3b32632 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -76,6 +76,7 @@
 #include <linux/mm_inline.h>
 #include <linux/oom.h>
 
+#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 #define CREATE_TRACE_POINTS
@@ -1995,6 +1996,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long pfn;
 	unsigned long hsz = 0;
 	int ptes = 0;
+	pgtable_t prealloc_pte = NULL;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -2029,6 +2031,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	}
 	mmu_notifier_invalidate_range_start(&range);
 
+	if ((flags & TTU_SPLIT_HUGE_PMD) && vma_is_anonymous(vma) &&
+	    !arch_needs_pgtable_deposit())
+		prealloc_pte = pte_alloc_one(mm);
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
@@ -2078,12 +2084,21 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			}
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
+				pgtable_t pgtable = prealloc_pte;
+
+				prealloc_pte = NULL;
+				if (!arch_needs_pgtable_deposit() && !pgtable &&
+				    vma_is_anonymous(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
 				/*
 				 * We temporarily have to drop the PTL and
 				 * restart so we can process the PTE-mapped THP.
 				 */
 				split_huge_pmd_locked(vma, pvmw.address,
-						      pvmw.pmd, false);
+						      pvmw.pmd, false, pgtable);
 				flags &= ~TTU_SPLIT_HUGE_PMD;
 				page_vma_mapped_walk_restart(&pvmw);
 				continue;
@@ -2363,6 +2378,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		break;
 	}
 
+	if (prealloc_pte)
+		pte_free(mm, prealloc_pte);
+
 	mmu_notifier_invalidate_range_end(&range);
 
 	return ret;
@@ -2422,6 +2440,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	pgtable_t prealloc_pte = NULL;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -2456,6 +2475,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	}
 	mmu_notifier_invalidate_range_start(&range);
 
+	if ((flags & TTU_SPLIT_HUGE_PMD) && vma_is_anonymous(vma) &&
+	    !arch_needs_pgtable_deposit())
+		prealloc_pte = pte_alloc_one(mm);
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		/* PMD-mapped THP migration entry */
 		if (!pvmw.pte) {
@@ -2463,6 +2486,15 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			__maybe_unused pmd_t pmdval;
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
+				pgtable_t pgtable = prealloc_pte;
+
+				prealloc_pte = NULL;
+				if (!arch_needs_pgtable_deposit() && !pgtable &&
+				    vma_is_anonymous(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
 				/*
 				 * split_huge_pmd_locked() might leave the
 				 * folio mapped through PTEs. Retry the walk
@@ -2470,7 +2502,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 * abort the walk.
 				 */
 				split_huge_pmd_locked(vma, pvmw.address,
-						      pvmw.pmd, true);
+						      pvmw.pmd, true, pgtable);
 				flags &= ~TTU_SPLIT_HUGE_PMD;
 				page_vma_mapped_walk_restart(&pvmw);
 				continue;
@@ -2721,6 +2753,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		folio_put(folio);
 	}
 
+	if (prealloc_pte)
+		pte_free(mm, prealloc_pte);
+
 	mmu_notifier_invalidate_range_end(&range);
 
 	return ret;
-- 
2.52.0

