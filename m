Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3815483;
	Thu, 11 Jan 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T9hpc5HTZzWm4Q;
	Thu, 11 Jan 2024 19:12:40 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DC5C180077;
	Thu, 11 Jan 2024 19:13:33 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 19:13:33 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-s390@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 7/8] mm: convert mm_counter() to take a folio
Date: Thu, 11 Jan 2024 19:12:38 +0800
Message-ID: <20240111111239.2453282-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
References: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Since all mm_counter() callers with a folio, let's convert
mm_counter() to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/s390/mm/pgtable.c |  2 +-
 include/linux/mm.h     |  6 +++---
 mm/memory.c            | 10 +++++-----
 mm/rmap.c              |  8 ++++----
 mm/userfaultfd.c       |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index e8fc5c55968e..4c92b08e3c59 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -723,7 +723,7 @@ static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 	else if (is_migration_entry(entry)) {
 		struct folio *folio = pfn_swap_entry_to_folio(entry);
 
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
index afba8b156457..2f858263e5a2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -808,7 +808,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	} else if (is_migration_entry(entry)) {
 		folio = pfn_swap_entry_to_folio(entry);
 
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
 			folio = pfn_swap_entry_to_folio(entry);
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
2.27.0

