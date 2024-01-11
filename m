Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0A4C60C
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+SXDLIm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/JVekdlGZM0tpkfZjc1ZJe7iyChUAelazfelkg1Lz/4=; b=D+SXDLImf7oLbCf33/4juKuCdQ
	/Rg+YVL1d9CbksbSStIW+tgYUeJaaSaR1Cz3+AsiHZF7J+aAPLVZdbCk1VozQw7ZVE4CojgcxnKPp
	Snd86to3yWKqDYI37Y595yE7Dysu7ivskJSWPoFPzffcwNOREYYi+DCa2M0029X9HoVb+WHRiAtDo
	0P2D12Pu5RUHU36D8emC6uGhbgCtDynzlxivWBXMvQS/3z2WgBewi0R4SjsrNxEMcslOS8Y5EsnWp
	6P/Mummf9EMFIEeXa4NROBsAVfdTkRkWSS9rlNxmCbqoX6RJ+VgEgy9GHaK/9nfINTFaNMcKM50pm
	OvwFJWrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv2-00E9sy-4k; Thu, 11 Jan 2024 15:24:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	david@redhat.com,
	linux-s390@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 10/10] mm: convert mm_counter_file() to take a folio
Date: Thu, 11 Jan 2024 15:24:29 +0000
Message-Id: <20240111152429.3374566-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240111152429.3374566-1-willy@infradead.org>
References: <20240111152429.3374566-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Now all callers of mm_counter_file() have a folio, convert
mm_counter_file() to take a folio.  Saves a call to compound_head()
hidden inside PageSwapBacked().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  8 ++++----
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  4 ++--
 mm/khugepaged.c         |  4 ++--
 mm/memory.c             | 10 +++++-----
 mm/rmap.c               |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 22e597b36b38..ac6b71cbdffb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2595,10 +2595,10 @@ static inline void dec_mm_counter(struct mm_struct *mm, int member)
 	mm_trace_rss_stat(mm, member);
 }
 
-/* Optimized variant when page is already known not to be PageAnon */
-static inline int mm_counter_file(struct page *page)
+/* Optimized variant when folio is already known not to be anon */
+static inline int mm_counter_file(struct folio *folio)
 {
-	if (PageSwapBacked(page))
+	if (folio_test_swapbacked(folio))
 		return MM_SHMEMPAGES;
 	return MM_FILEPAGES;
 }
@@ -2607,7 +2607,7 @@ static inline int mm_counter(struct folio *folio)
 {
 	if (folio_test_anon(folio))
 		return MM_ANONPAGES;
-	return mm_counter_file(&folio->page);
+	return mm_counter_file(folio);
 }
 
 static inline unsigned long get_mm_rss(struct mm_struct *mm)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 485bb0389b48..948c2e064ca3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -188,7 +188,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		dec_mm_counter(mm, MM_ANONPAGES);
 
 	if (!folio_test_anon(old_folio)) {
-		dec_mm_counter(mm, mm_counter_file(old_page));
+		dec_mm_counter(mm, mm_counter_file(old_folio));
 		inc_mm_counter(mm, MM_ANONPAGES);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4a17306c7dda..f40feb31b507 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1921,7 +1921,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		} else {
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
-			add_mm_counter(tlb->mm, mm_counter_file(&folio->page),
+			add_mm_counter(tlb->mm, mm_counter_file(folio),
 				       -HPAGE_PMD_NR);
 		}
 
@@ -2446,7 +2446,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			folio_remove_rmap_pmd(folio, page, vma);
 			folio_put(folio);
 		}
-		add_mm_counter(mm, mm_counter_file(&folio->page), -HPAGE_PMD_NR);
+		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
 		return;
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2b219acb528e..fe43fbc44525 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1634,7 +1634,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 3: set proper refcount and mm_counters. */
 	if (nr_ptes) {
 		folio_ref_sub(folio, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
+		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
 	}
 
 	/* step 4: remove empty page table */
@@ -1665,7 +1665,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (nr_ptes) {
 		flush_tlb_mm(mm);
 		folio_ref_sub(folio, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
+		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
 	}
 	if (start_pte)
 		pte_unmap_unlock(start_pte, ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 53ef7ae96440..b8bc09696cc9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -966,7 +966,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	} else if (page) {
 		folio_get(folio);
 		folio_dup_file_rmap_pte(folio, page);
-		rss[mm_counter_file(page)]++;
+		rss[mm_counter_file(folio)]++;
 	}
 
 	/*
@@ -1873,7 +1873,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	folio_get(folio);
-	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
+	inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 	folio_add_file_rmap_pte(folio, page, vma);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
@@ -3178,7 +3178,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 		if (old_folio) {
 			if (!folio_test_anon(old_folio)) {
-				dec_mm_counter(mm, mm_counter_file(&old_folio->page));
+				dec_mm_counter(mm, mm_counter_file(old_folio));
 				inc_mm_counter(mm, MM_ANONPAGES);
 			}
 		} else {
@@ -4463,7 +4463,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
+	add_mm_counter(vma->vm_mm, mm_counter_file(folio), HPAGE_PMD_NR);
 	folio_add_file_rmap_pmd(folio, page, vma);
 
 	/*
@@ -4526,7 +4526,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		folio_add_new_anon_rmap(folio, vma, addr);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
+		add_mm_counter(vma->vm_mm, mm_counter_file(folio), nr);
 		folio_add_file_rmap_ptes(folio, page, nr, vma);
 	}
 	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
diff --git a/mm/rmap.c b/mm/rmap.c
index 4648cf1d8178..1cf2bffa48ed 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1903,7 +1903,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 *
 			 * See Documentation/mm/mmu_notifier.rst
 			 */
-			dec_mm_counter(mm, mm_counter_file(&folio->page));
+			dec_mm_counter(mm, mm_counter_file(folio));
 		}
 discard:
 		if (unlikely(folio_test_hugetlb(folio)))
-- 
2.43.0

