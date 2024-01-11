Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054D4C3DC
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLvKEMaR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cwPZenCs5tEi8Hk4LaFtzjhgBXHRX0Dio8DzNCbpitA=; b=WLvKEMaRcwYqspQuMwl4Svoq82
	xeKIGrZQRRsfMMMHvf6/3AFadgthcHgwL97RUZJaRAdfi5LruvSjkRw9Zect0ZFXF8M4ztGYFwdwf
	vtyLZwZVZ29gp9+SXupcdt1Z5UrUpp74WiqkObEXeyQlLoAD7DB0kfZPjl33bUjkPQmge4izvgTfy
	b1mg/RvGWLB0Dfhh9wlbIbxg/lgXeQFw8aAC2pej+Aaq5dx4uEPM+i+14+X333cogocV8ydnBvCc4
	M8SIPWknkQtsyBZoasDv0qZey7CoqJ6chamKz5y7sI5sdlBhPqCuDSCihr7ag1R0dwXAKaVPmC72j
	onE9uwFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9su-VZ; Thu, 11 Jan 2024 15:24:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	david@redhat.com,
	linux-s390@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 08/10] mm: Convert to should_zap_page() to should_zap_folio()
Date: Thu, 11 Jan 2024 15:24:27 +0000
Message-Id: <20240111152429.3374566-9-willy@infradead.org>
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

Make should_zap_page() take a folio and rename it to should_zap_folio()
as preparation for converting mm counter functions to take a folio.
Saves a call to compound_head() hidden inside PageAnon().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 60aa08f2ccdc..b73322ab9fd6 100644
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
+			folio = pfn_swap_entry_folio(entry);
+			if (!should_zap_folio(details, folio))
 				continue;
-			rss[mm_counter(page)]--;
+			rss[mm_counter(&folio->page)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
 			/*
 			 * For anon: always drop the marker; for file: only
-- 
2.43.0

