Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506C4C60A
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QVcPzKV1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SWPLe2lBFcOeS/R+eqUJaGE4qvmGFpI0sgm68JzAp2s=; b=QVcPzKV1YNnMfheJtChzwtL02f
	e1cC0RZvvMWJyb9EQAMOvxUDzRUQBNK5BJXla2PE1U1NLRw8rVNKwo77SOCCgrC1BJsUXABWJa4OB
	A0AvlidZpJNlFAHwwE0y83hZJQGO0OnYb8j1PpD3+BikP4MXlFPesDYOWP8IY7cTGJSdIdgEpjJ0m
	NAAPl2VFN/Dmamm2L6+UBRyzl9m6QJrpHjXKd2PezMG4OX+FDSZ2iesbd6gtdR3+A3cs5paiamyj6
	9/nbsEftVAL2/O9HLGsXgU1IV2Y04oWOasB4jZcz/44drZ52o+zh6IyXUu0eAGIauRzNkDdKy8+Vr
	r6v/heSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9sg-Aj; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	david@redhat.com,
	linux-s390@vger.kernel.org
Subject: [PATCH v3 01/10] mm: Add pfn_swap_entry_folio()
Date: Thu, 11 Jan 2024 15:24:20 +0000
Message-Id: <20240111152429.3374566-2-willy@infradead.org>
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

Thanks to the compound_head() hidden inside PageLocked(), this saves a
call to compound_head() over calling page_folio(pfn_swap_entry_to_page())

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swapops.h | 13 +++++++++++++
 mm/filemap.c            |  2 +-
 mm/huge_memory.c        |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index bff1e8d97de0..48b700ba1d18 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -468,6 +468,19 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 	return p;
 }
 
+static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
+{
+	struct folio *folio = pfn_folio(swp_offset_pfn(entry));
+
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding folio is locked
+	 */
+	BUG_ON(is_migration_entry(entry) && !folio_test_locked(folio));
+
+	return folio;
+}
+
 /*
  * A pfn swap entry is a special type of swap entry that always has a pfn stored
  * in the swap offset. They are used to represent unaddressable device memory
diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..c704085f29b6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1354,7 +1354,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 	unsigned long pflags;
 	bool in_thrashing;
 	wait_queue_head_t *q;
-	struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
+	struct folio *folio = pfn_swap_entry_folio(entry);
 
 	q = folio_waitqueue(folio);
 	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ef5c02b459..5b2da360ae0c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2035,7 +2035,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	if (is_swap_pmd(*pmd)) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
-		struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
+		struct folio *folio = pfn_swap_entry_folio(entry);
 		pmd_t newpmd;
 
 		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
-- 
2.43.0

