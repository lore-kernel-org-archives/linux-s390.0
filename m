Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10732D0D4
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577762; cv=none; b=MZe3r4y2Qwn2DwvkOag4mSIIvIEEIXsEcg2CKB1IMw55WvewCO1mdKMxeixbmbfNOlw+4M/nNob0xZfBFLm59UGeOjH/6SGHHslZClMYlzC6PkoO+VNEiIo5CILE0DfBV3TuaVrU1mjWgL3N8u0p3rWutQuoL7A73IfpcUu97jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577762; c=relaxed/simple;
	bh=FQEc69Q/+FrUrqq14aJmPyl26Cwkvf2VvjDzLT5nK0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJI5r1yYGbgt1V6tXVCA4ti0BZkNyFDzMA8DQXbL3g8irQV3rPIz4Uwib3B0pKQ0QgyLWmwgtO6X6UWHHXlzWiVNdIL4OXccOq9v7K4TsWItncGl51w5p+Qsc11+Zav3gnzQl4H8zEJpGC6uzpOcrfwSqCZWUHoHaDZtsJL1Gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=txcrfU3Z; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="txcrfU3Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYCwapbn/lTyj+e7LtoHxlqJFgqF7EX0syxt7rVM1Zo=;
	b=txcrfU3Z3cqsr4kM8egih5yBbs+GKiMnbBtOqZAy3/1n6NN5mRJoqoBLEB8uutYAh1MlPA
	wFv2iEWhRlMUDe5vOtRTYXLnTetgc+HQLwXlzSzSrbTfDFGJVHZvzzIk17r377TEYzDuFp
	CuXwGeRfuJ/IB9iX79ItYRHGbBpTagM=
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
Subject: [v3 18/24] mm: thp: remove pgtable_trans_huge_{deposit/withdraw} when not needed
Date: Thu, 26 Mar 2026 19:09:00 -0700
Message-ID: <20260327021403.214713-19-usama.arif@linux.dev>
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

Since the previous commit made deposit/withdraw only needed for
architectures where arch_needs_pgtable_deposit() returns true (currently
only powerpc hash MMU), the generic implementation in pgtable-generic.c
and the s390/sparc overrides are now dead code — all call sites are
guarded by arch_needs_pgtable_deposit() which is compile-time false on
those architectures. Remove them entirely and replace the extern
declarations with static inline no-op stubs for the default case.

pgtable_trans_huge_{deposit,withdraw}() are renamed to
arch_pgtable_trans_huge_{deposit,withdraw}().

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 12 +++---
 arch/s390/include/asm/pgtable.h              |  6 ---
 arch/s390/mm/pgtable.c                       | 41 --------------------
 arch/sparc/include/asm/pgtable_64.h          |  6 ---
 arch/sparc/mm/tlb.c                          | 36 -----------------
 include/linux/pgtable.h                      | 16 +++++---
 mm/debug_vm_pgtable.c                        |  4 +-
 mm/huge_memory.c                             | 26 ++++++-------
 mm/khugepaged.c                              |  2 +-
 mm/memory.c                                  |  2 +-
 mm/migrate_device.c                          |  2 +-
 mm/pgtable-generic.c                         | 32 ---------------
 12 files changed, 35 insertions(+), 150 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 60e283cf22be1..f1f36a4ed2bc8 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1360,18 +1360,18 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
 				   unsigned long addr,
 				   pud_t *pudp, int full);
 
-#define __HAVE_ARCH_PGTABLE_DEPOSIT
-static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
-					      pmd_t *pmdp, pgtable_t pgtable)
+#define arch_pgtable_trans_huge_deposit arch_pgtable_trans_huge_deposit
+static inline void arch_pgtable_trans_huge_deposit(struct mm_struct *mm,
+						   pmd_t *pmdp, pgtable_t pgtable)
 {
 	if (radix_enabled())
 		return radix__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
 	return hash__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
 }
 
-#define __HAVE_ARCH_PGTABLE_WITHDRAW
-static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
-						    pmd_t *pmdp)
+#define arch_pgtable_trans_huge_withdraw arch_pgtable_trans_huge_withdraw
+static inline pgtable_t arch_pgtable_trans_huge_withdraw(struct mm_struct *mm,
+							 pmd_t *pmdp)
 {
 	if (radix_enabled())
 		return radix__pgtable_trans_huge_withdraw(mm, pmdp);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 40a6fb19dd1dc..9394aabe0442b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1659,12 +1659,6 @@ pud_t pudp_xchg_direct(struct mm_struct *, unsigned long, pud_t *, pud_t);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-#define __HAVE_ARCH_PGTABLE_DEPOSIT
-void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable);
-
-#define __HAVE_ARCH_PGTABLE_WITHDRAW
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 
 #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4acd8b140c4bd..c9a9ab2c7d937 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -312,44 +312,3 @@ pud_t pudp_xchg_direct(struct mm_struct *mm, unsigned long addr,
 	return old;
 }
 EXPORT_SYMBOL(pudp_xchg_direct);
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable)
-{
-	struct list_head *lh = (struct list_head *) pgtable;
-
-	assert_spin_locked(pmd_lockptr(mm, pmdp));
-
-	/* FIFO */
-	if (!pmd_huge_pte(mm, pmdp))
-		INIT_LIST_HEAD(lh);
-	else
-		list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
-	pmd_huge_pte(mm, pmdp) = pgtable;
-}
-
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
-{
-	struct list_head *lh;
-	pgtable_t pgtable;
-	pte_t *ptep;
-
-	assert_spin_locked(pmd_lockptr(mm, pmdp));
-
-	/* FIFO */
-	pgtable = pmd_huge_pte(mm, pmdp);
-	lh = (struct list_head *) pgtable;
-	if (list_empty(lh))
-		pmd_huge_pte(mm, pmdp) = NULL;
-	else {
-		pmd_huge_pte(mm, pmdp) = (pgtable_t) lh->next;
-		list_del(lh);
-	}
-	ptep = (pte_t *) pgtable;
-	set_pte(ptep, __pte(_PAGE_INVALID));
-	ptep++;
-	set_pte(ptep, __pte(_PAGE_INVALID));
-	return pgtable;
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 74ede706fb325..60861560f8c40 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -987,12 +987,6 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 
-#define __HAVE_ARCH_PGTABLE_DEPOSIT
-void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable);
-
-#define __HAVE_ARCH_PGTABLE_WITHDRAW
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
 /*
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 6d9dd5eb13287..9049d54e6e2cb 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -275,40 +275,4 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	return old;
 }
 
-void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable)
-{
-	struct list_head *lh = (struct list_head *) pgtable;
-
-	assert_spin_locked(&mm->page_table_lock);
-
-	/* FIFO */
-	if (!pmd_huge_pte(mm, pmdp))
-		INIT_LIST_HEAD(lh);
-	else
-		list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
-	pmd_huge_pte(mm, pmdp) = pgtable;
-}
-
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
-{
-	struct list_head *lh;
-	pgtable_t pgtable;
-
-	assert_spin_locked(&mm->page_table_lock);
-
-	/* FIFO */
-	pgtable = pmd_huge_pte(mm, pmdp);
-	lh = (struct list_head *) pgtable;
-	if (list_empty(lh))
-		pmd_huge_pte(mm, pmdp) = NULL;
-	else {
-		pmd_huge_pte(mm, pmdp) = (pgtable_t) lh->next;
-		list_del(lh);
-	}
-	pte_val(pgtable[0]) = 0;
-	pte_val(pgtable[1]) = 0;
-
-	return pgtable;
-}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a9..f646414e801b7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1207,13 +1207,19 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
-#ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
-extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				       pgtable_t pgtable);
+#ifndef arch_pgtable_trans_huge_deposit
+static inline void arch_pgtable_trans_huge_deposit(struct mm_struct *mm,
+						   pmd_t *pmdp, pgtable_t pgtable)
+{
+}
 #endif
 
-#ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
-extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+#ifndef arch_pgtable_trans_huge_withdraw
+static inline pgtable_t arch_pgtable_trans_huge_withdraw(struct mm_struct *mm,
+							 pmd_t *pmdp)
+{
+	return NULL;
+}
 #endif
 
 #ifndef arch_needs_pgtable_deposit
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 23dc3ee095619..db58c5a1f4f48 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -240,7 +240,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	/* Align the address wrt HPAGE_PMD_SIZE */
 	vaddr &= HPAGE_PMD_MASK;
 
-	pgtable_trans_huge_deposit(args->mm, args->pmdp, args->start_ptep);
+	arch_pgtable_trans_huge_deposit(args->mm, args->pmdp, args->start_ptep);
 
 	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
@@ -276,7 +276,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 
 	/*  Clear the pte entries  */
 	pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
-	pgtable_trans_huge_withdraw(args->mm, args->pmdp);
+	arch_pgtable_trans_huge_withdraw(args->mm, args->pmdp);
 }
 
 static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2acedb1de7404..48c4884a6f386 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1343,7 +1343,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			return ret;
 		}
 		if (pgtable) {
-			pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd,
+			arch_pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd,
 						   pgtable);
 			mm_inc_nr_ptes(vma->vm_mm);
 		}
@@ -1444,7 +1444,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
 	entry = pmd_mkspecial(entry);
 	if (pgtable) {
-		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		arch_pgtable_trans_huge_deposit(mm, pmd, pgtable);
 		mm_inc_nr_ptes(mm);
 	}
 	set_pmd_at(mm, haddr, pmd, entry);
@@ -1577,7 +1577,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	if (pgtable) {
-		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		arch_pgtable_trans_huge_deposit(mm, pmd, pgtable);
 		mm_inc_nr_ptes(mm);
 		pgtable = NULL;
 	}
@@ -1839,7 +1839,7 @@ static void copy_huge_non_present_pmd(
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 	if (pgtable) {
 		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+		arch_pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 	}
 	if (!userfaultfd_wp(dst_vma))
 		pmd = pmd_swp_clear_uffd_wp(pmd);
@@ -1946,7 +1946,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 out_zero_page:
 	if (pgtable) {
 		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+		arch_pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 	}
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
 	if (!userfaultfd_wp(dst_vma))
@@ -2354,7 +2354,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 {
 	pgtable_t pgtable;
 
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	pgtable = arch_pgtable_trans_huge_withdraw(mm, pmd);
 	pte_free(mm, pgtable);
 	mm_dec_nr_ptes(mm);
 }
@@ -2434,7 +2434,7 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	/*
 	 * For architectures like ppc64 we look at deposited pgtable
 	 * when calling pmdp_huge_get_and_clear. So do the
-	 * pgtable_trans_huge_withdraw after finishing pmdp related
+	 * arch_pgtable_trans_huge_withdraw after finishing pmdp related
 	 * operations.
 	 */
 	orig_pmd = pmdp_huge_get_and_clear_full(vma, addr, pmd,
@@ -2530,8 +2530,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		if (pmd_move_must_withdraw(new_ptl, old_ptl, vma) &&
 		    arch_needs_pgtable_deposit()) {
 			pgtable_t pgtable;
-			pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
-			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
+			pgtable = arch_pgtable_trans_huge_withdraw(mm, old_pmd);
+			arch_pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		pmd = move_soft_dirty_pmd(pmd);
 		if (vma_has_uffd_without_event_remap(vma))
@@ -2838,8 +2838,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
 	if (arch_needs_pgtable_deposit()) {
-		src_pgtable = pgtable_trans_huge_withdraw(mm, src_pmd);
-		pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
+		src_pgtable = arch_pgtable_trans_huge_withdraw(mm, src_pmd);
+		arch_pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
 	}
 unlock_ptls:
 	double_pt_unlock(src_ptl, dst_ptl);
@@ -3001,7 +3001,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
 
 	if (arch_needs_pgtable_deposit()) {
-		pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+		pgtable = arch_pgtable_trans_huge_withdraw(mm, pmd);
 	} else {
 		VM_BUG_ON(!pgtable);
 		/*
@@ -3218,7 +3218,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * This's critical for some architectures (Power).
 	 */
 	if (arch_needs_pgtable_deposit()) {
-		pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+		pgtable = arch_pgtable_trans_huge_withdraw(mm, pmd);
 	} else {
 		VM_BUG_ON(!pgtable);
 		/*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 40b33263f6135..b6d5da4567fe0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1240,7 +1240,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
 	if (arch_needs_pgtable_deposit()) {
-		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		arch_pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	} else {
 		mm_dec_nr_ptes(mm);
 		pte_free(mm, pgtable);
diff --git a/mm/memory.c b/mm/memory.c
index b99ec3ffc18d1..583ca340cef43 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5551,7 +5551,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
+	arch_pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
 	/*
 	 * We are going to consume the prealloc table,
 	 * count that as nr_ptes.
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index b9242217a81b6..fb0f29a7c73bc 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -888,7 +888,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 		flush_cache_page(vma, addr, addr + HPAGE_PMD_SIZE);
 		pmdp_invalidate(vma, addr, pmdp);
 	} else if (pgtable) {
-		pgtable_trans_huge_deposit(vma->vm_mm, pmdp, pgtable);
+		arch_pgtable_trans_huge_deposit(vma->vm_mm, pmdp, pgtable);
 		mm_inc_nr_ptes(vma->vm_mm);
 	}
 	set_pmd_at(vma->vm_mm, addr, pmdp, entry);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c7..5dfdbe6488062 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -164,38 +164,6 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 #endif
 #endif
 
-#ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
-void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable)
-{
-	assert_spin_locked(pmd_lockptr(mm, pmdp));
-
-	/* FIFO */
-	if (!pmd_huge_pte(mm, pmdp))
-		INIT_LIST_HEAD(&pgtable->lru);
-	else
-		list_add(&pgtable->lru, &pmd_huge_pte(mm, pmdp)->lru);
-	pmd_huge_pte(mm, pmdp) = pgtable;
-}
-#endif
-
-#ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
-/* no "address" argument so destroys page coloring of some arch */
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
-{
-	pgtable_t pgtable;
-
-	assert_spin_locked(pmd_lockptr(mm, pmdp));
-
-	/* FIFO */
-	pgtable = pmd_huge_pte(mm, pmdp);
-	pmd_huge_pte(mm, pmdp) = list_first_entry_or_null(&pgtable->lru,
-							  struct page, lru);
-	if (pmd_huge_pte(mm, pmdp))
-		list_del(&pgtable->lru);
-	return pgtable;
-}
-#endif
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
 pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
-- 
2.52.0

