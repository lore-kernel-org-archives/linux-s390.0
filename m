Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DC4C60A
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qm71Yl2Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CYYNkRTkd5xFX+VO5m2RjKXg1OSKu23U+VpXCiMR+DM=; b=Qm71Yl2ZL/hcUySturjDZKEqdM
	adPr7hRDRWEHj7lVE8ojtLUXWNtQuqjHlBJ2V1pGGZdU+ng9ARBTkBXMV76ySBdmtqCn0XYdmt68C
	xIQK3qM6KGSn+gDo/Ik1NUEorTGya3HIKcrc1uZJjCcsFft3nMBZDlatvvYDX0ztPJtphXgGpB41g
	JY/4olr8OI2etKVxeqdWRstBtP90bIh6YXJJOKy92bHFLBvB3bD5sF/7AIUAlf3szLm3TnhhAKas0
	sae8WGxzk9LizWHosQfkXTG765y5ozq/NxWX8pza5AJiRcLj9uPi/4aOPA3zeTEDsq5xyfbfxsvw7
	fVZbFYTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9sq-Nj; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	david@redhat.com,
	linux-s390@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 06/10] mm: use pfn_swap_entry_to_folio() in zap_huge_pmd()
Date: Thu, 11 Jan 2024 15:24:25 +0000
Message-Id: <20240111152429.3374566-7-willy@infradead.org>
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

Call pfn_swap_entry_to_folio() in zap_huge_pmd() as preparation for
converting mm counter functions to take a folio.  Saves a call to
compound_head() embedded inside PageAnon().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4ad1416b60e3..4a17306c7dda 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1895,12 +1895,14 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
-		struct page *page = NULL;
+		struct folio *folio = NULL;
 		int flush_needed = 1;
 
 		if (pmd_present(orig_pmd)) {
-			page = pmd_page(orig_pmd);
-			folio_remove_rmap_pmd(page_folio(page), page, vma);
+			struct page *page = pmd_page(orig_pmd);
+
+			folio = page_folio(page);
+			folio_remove_rmap_pmd(folio, page, vma);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else if (thp_migration_supported()) {
@@ -1908,23 +1910,24 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
 			entry = pmd_to_swp_entry(orig_pmd);
-			page = pfn_swap_entry_to_page(entry);
+			folio = pfn_swap_entry_folio(entry);
 			flush_needed = 0;
 		} else
 			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
 
-		if (PageAnon(page)) {
+		if (folio_test_anon(folio)) {
 			zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 		} else {
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
-			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
+			add_mm_counter(tlb->mm, mm_counter_file(&folio->page),
+				       -HPAGE_PMD_NR);
 		}
 
 		spin_unlock(ptl);
 		if (flush_needed)
-			tlb_remove_page_size(tlb, page, HPAGE_PMD_SIZE);
+			tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE);
 	}
 	return 1;
 }
-- 
2.43.0

