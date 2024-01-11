Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E104C60B
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JGH+1Vk7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ICF9LS0a/Yck6c1d8aWnlAw0yJ+x3RGOq1LGLEZtkVo=; b=JGH+1Vk7AGOiSVpl5+BV2HzGX0
	9c1y8jIRfULhE2wJAq3YB/z0IPwlB7Xj5P9N76TNsquMxDfWMk3SFPMUduDwEOcyVlPhbG1Qcg5d5
	u/nI66o2/QajMLkwCPQVj7YSJMuxzJsM5xzdK5vFEG1ClahD2F2E2pnfgGFAZZFl4Q1bOKvcDSn3R
	wZWxNhkkkOZCWzS/de/AQ1C9UEjkAvgflelkgFXQcdVKbXq8RlFsmOJZ/alqdHIOVslNA2hNXx7az
	Rd4ow0Ot8KB6YV2318qqPoXHi1CvtujhQxs4PjvSIfxdK0p3ZJ18D1nS5UOIi17Q3mXR2s5VquvTs
	bNeC0CVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv2-00E9sw-21; Thu, 11 Jan 2024 15:24:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	david@redhat.com,
	linux-s390@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 09/10] mm: convert mm_counter() to take a folio
Date: Thu, 11 Jan 2024 15:24:28 +0000
Message-Id: <20240111152429.3374566-10-willy@infradead.org>
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

Now all callers of mm_counter() have a folio, convert mm_counter() to
take a folio.  Saves a call to compound_head() hidden inside PageAnon().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/mm/pgtable.c |  2 +-
 include/linux/mm.h     |  6 +++---
 mm/memory.c            | 10 +++++-----
 mm/rmap.c              |  8 ++++----
 mm/userfaultfd.c       |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 7e5dd4b17664..b71432b15d66 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -723,7 +723,7 @@ static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 	else if (is_migration_entry(entry)) {
 		struct folio *folio = pfn_swap_entry_folio(entry);
 
-		dec_mm_counter(mm, mm_counter(&folio->page));
+		dec_mm_counter(mm, mm_counter(folio));
 	}
 	free_swap_and_cache(entry);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..22e597b36b38 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2603,11 +2603,11 @@ static inline int mm_counter_file(struct page *page)
 	return MM_FILEPAGES;
 }
 
-static inline int mm_counter(struct page *page)
+static inline int mm_counter(struct folio *folio)
 {
-	if (PageAnon(page))
+	if (folio_test_anon(folio))
 		return MM_ANONPAGES;
-	return mm_counter_file(page);
+	return mm_counter_file(&folio->page);
 }
 
 static inline unsigned long get_mm_rss(struct mm_struct *mm)
diff --git a/mm/memory.c b/mm/memory.c
index b73322ab9fd6..53ef7ae96440 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -808,7 +808,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	} else if (is_migration_entry(entry)) {
 		folio = pfn_swap_entry_folio(entry);
 
-		rss[mm_counter(&folio->page)]++;
+		rss[mm_counter(folio)]++;
 
 		if (!is_readable_migration_entry(entry) &&
 				is_cow_mapping(vm_flags)) {
@@ -840,7 +840,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * keep things as they are.
 		 */
 		folio_get(folio);
-		rss[mm_counter(page)]++;
+		rss[mm_counter(folio)]++;
 		/* Cannot fail as these pages cannot get pinned. */
 		folio_try_dup_anon_rmap_pte(folio, page, src_vma);
 
@@ -1476,7 +1476,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				if (pte_young(ptent) && likely(vma_has_recency(vma)))
 					folio_mark_accessed(folio);
 			}
-			rss[mm_counter(page)]--;
+			rss[mm_counter(folio)]--;
 			if (!delay_rmap) {
 				folio_remove_rmap_pte(folio, page, vma);
 				if (unlikely(page_mapcount(page) < 0))
@@ -1504,7 +1504,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 * see zap_install_uffd_wp_if_needed().
 			 */
 			WARN_ON_ONCE(!vma_is_anonymous(vma));
-			rss[mm_counter(page)]--;
+			rss[mm_counter(folio)]--;
 			if (is_device_private_entry(entry))
 				folio_remove_rmap_pte(folio, page, vma);
 			folio_put(folio);
@@ -1519,7 +1519,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			folio = pfn_swap_entry_folio(entry);
 			if (!should_zap_folio(details, folio))
 				continue;
-			rss[mm_counter(&folio->page)]--;
+			rss[mm_counter(folio)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
 			/*
 			 * For anon: always drop the marker; for file: only
diff --git a/mm/rmap.c b/mm/rmap.c
index f5d43edad529..4648cf1d8178 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1780,7 +1780,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				set_huge_pte_at(mm, address, pvmw.pte, pteval,
 						hsz);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1795,7 +1795,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(folio));
 		} else if (folio_test_anon(folio)) {
 			swp_entry_t entry = page_swap_entry(subpage);
 			pte_t swp_pte;
@@ -2181,7 +2181,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				set_huge_pte_at(mm, address, pvmw.pte, pteval,
 						hsz);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -2196,7 +2196,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(folio));
 		} else {
 			swp_entry_t entry;
 			pte_t swp_pte;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 216ab4c8621f..662ab304cca3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -124,7 +124,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	 * Must happen after rmap, as mm_counter() checks mapping (via
 	 * PageAnon()), which is set by __page_set_anon_rmap().
 	 */
-	inc_mm_counter(dst_mm, mm_counter(page));
+	inc_mm_counter(dst_mm, mm_counter(folio));
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-- 
2.43.0

