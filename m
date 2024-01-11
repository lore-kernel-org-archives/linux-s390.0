Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088515491;
	Thu, 11 Jan 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T9hpt1TpfzNkrX;
	Thu, 11 Jan 2024 19:12:54 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1346914040D;
	Thu, 11 Jan 2024 19:13:33 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 19:13:32 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-s390@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 6/8] mm: memory: convert to should_zap_folio()
Date: Thu, 11 Jan 2024 19:12:37 +0800
Message-ID: <20240111111239.2453282-7-wangkefeng.wang@huawei.com>
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

Make should_zap_page() to take a folio and convert it to
should_zap_folio() which is preparetion for converting mm
counter functions to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7b3fbeb21534..afba8b156457 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1369,19 +1369,20 @@ static inline bool should_zap_cows(struct zap_details *details)
 	return details->even_cows;
 }
 
-/* Decides whether we should zap this page with the page pointer specified */
-static inline bool should_zap_page(struct zap_details *details, struct page *page)
+/* Decides whether we should zap this folio with the folio pointer specified */
+static inline bool should_zap_folio(struct zap_details *details,
+				    struct folio *folio)
 {
-	/* If we can make a decision without *page.. */
+	/* If we can make a decision without *folio.. */
 	if (should_zap_cows(details))
 		return true;
 
-	/* E.g. the caller passes NULL for the case of a zero page */
-	if (!page)
+	/* E.g. the caller passes NULL for the case of a zero folio */
+	if (!folio)
 		return true;
 
-	/* Otherwise we should only zap non-anon pages */
-	return !PageAnon(page);
+	/* Otherwise we should only zap non-anon folios */
+	return !folio_test_anon(folio);
 }
 
 static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
@@ -1447,7 +1448,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			unsigned int delay_rmap;
 
 			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(!should_zap_page(details, page)))
+			if (page)
+				folio = page_folio(page);
+
+			if (unlikely(!should_zap_folio(details, folio)))
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
@@ -1460,7 +1464,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			}
 
-			folio = page_folio(page);
 			delay_rmap = 0;
 			if (!folio_test_anon(folio)) {
 				if (pte_dirty(ptent)) {
@@ -1492,7 +1495,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		    is_device_exclusive_entry(entry)) {
 			page = pfn_swap_entry_to_page(entry);
 			folio = page_folio(page);
-			if (unlikely(!should_zap_page(details, page)))
+			if (unlikely(!should_zap_folio(details, folio)))
 				continue;
 			/*
 			 * Both device private/exclusive mappings should only
@@ -1513,10 +1516,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (unlikely(!free_swap_and_cache(entry)))
 				print_bad_pte(vma, addr, ptent, NULL);
 		} else if (is_migration_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
-			if (!should_zap_page(details, page))
+			folio = pfn_swap_entry_to_folio(entry);
+			if (!should_zap_folio(details, folio))
 				continue;
-			rss[mm_counter(page)]--;
+			rss[mm_counter(&folio->page)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
 			/*
 			 * For anon: always drop the marker; for file: only
-- 
2.27.0

