Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2301548D;
	Thu, 11 Jan 2024 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T9hqH5C5vz1wn3P;
	Thu, 11 Jan 2024 19:13:15 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 368751400E8;
	Thu, 11 Jan 2024 19:13:32 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 19:13:31 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-s390@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 4/8] mm: huge_memory: use pfn_swap_entry_to_folio() in zap_huge_pmd()
Date: Thu, 11 Jan 2024 19:12:35 +0800
Message-ID: <20240111111239.2453282-5-wangkefeng.wang@huawei.com>
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

Using pfn_swap_entry_to_folio() in zap_huge_pmd(), which is a
preparetion for converting mm counter functions to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6139887933a7..b024edb55855 100644
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
+			folio = pfn_swap_entry_to_folio(entry);
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
2.27.0

