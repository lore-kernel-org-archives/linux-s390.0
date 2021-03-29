Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A8C433E2
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82B661554
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhC2SeD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhC2Sdu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 14:33:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070CFC061574;
        Mon, 29 Mar 2021 11:33:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ay2so4818375plb.3;
        Mon, 29 Mar 2021 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29/H2A8xfgwNsEVym/wTOPWEPYxThWyLZ916L71Yy00=;
        b=mrmoTg7T8w2ewOZaujRQucTGGuKwCcmyMGPkK+fJqCDjBpKWyHWnHZFWACqWCEkwiH
         cUHSuyTUqNP6MtQdz9EX3FZtA0eyM0rfofkZqTqORPNdPlZ/qp70hMZ3l0uR3Li2BvBI
         nxFmgtpTbx4bpxpjf2I6eowQo4Ji2QZ/r7RZPZyqByrpip2VPHMk6xIJGb0Pb134TAJQ
         G6y8TGwicM/jwNtKC0CC117RjFSU7+8CtiDOZZuVNr2e+fPJBQwukYzAKYD2IUpvY7Nt
         eAMcwuM5ini3R8dkVeNQhX6cf9JHKsueug8CZ7BI8f6FnkGJJHnWDb6Xw4AFqWENv6o/
         qXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29/H2A8xfgwNsEVym/wTOPWEPYxThWyLZ916L71Yy00=;
        b=qJPJltLFTtZyZ9oPf9uLyAyR81K6HV5wzlUhO6gPiKo9T5uR4seLqbadFfokqlKGCW
         g5faZT72ct6PsF6eY3Q7ZatKaa19icFjPF4d6AcdzPGSg85tlh2TNYGlln7+d2S1TITb
         XMzQJYtn+5Z5DrZyJeraP+9RxAvTtcqiA/pIfCIeWHVzNvIKP2QBJ1mxgiAg7kehMSJr
         wfvtpTVwyCLt+HXnivxfIJD0UmRl151R6nanGB7M2RB6wXCiUxSbzUZBJKDHfWz+EYPN
         ze5CLDFmLPXBoizwgClRG60SROQ8ePXnVXR/oatuso3y2bljN6OE9FGrufMrqXvVPlpy
         Y2NA==
X-Gm-Message-State: AOAM5330m3/GsvMa5f/n0VBq5FjH9ozAosJDy5+KxyWzvLlBoqzzMK3k
        quMN+MChLQc7EpJdNHCq+d2cmFfKtjxs5A==
X-Google-Smtp-Source: ABdhPJzzGtILjPNCm+kpWPLTjkZtqjZWR1rcTVghha1v/37IKDj/4fa2DaB5UVX0VoofTQSBqcMHwQ==
X-Received: by 2002:a17:90b:203:: with SMTP id fy3mr490758pjb.32.1617042829545;
        Mon, 29 Mar 2021 11:33:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x11sm1151158pjh.0.2021.03.29.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:33:48 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm: thp: refactor NUMA fault handling
Date:   Mon, 29 Mar 2021 11:33:10 -0700
Message-Id: <20210329183312.178266-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329183312.178266-1-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When the THP NUMA fault support was added THP migration was not supported yet.
So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
THP migration has been supported so it doesn't make too much sense to still keep
another THP migration implementation rather than using the generic migration
code.

This patch reworked the NUMA fault handling to use generic migration implementation
to migrate misplaced page.  There is no functional change.

After the refactor the flow of NUMA fault handling looks just like its
PTE counterpart:
  Acquire ptl
  Restore PMD
  Prepare for migration (elevate page refcount)
  Release ptl
  Isolate page from lru and elevate page refcount
  Migrate the misplaced THP

In the old code anon_vma lock was needed to serialize THP migration
against THP split, but since then the THP code has been reworked a lot,
it seems anon_vma lock is not required anymore to avoid the race.

The page refcount elevation when holding ptl should prevent from THP
split.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/migrate.h |  23 ------
 mm/huge_memory.c        | 132 ++++++++----------------------
 mm/migrate.c            | 173 ++++++----------------------------------
 3 files changed, 57 insertions(+), 271 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6abd34986cc5..6c8640e9af4f 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -100,15 +100,10 @@ static inline void __ClearPageMovable(struct page *page)
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
-extern bool pmd_trans_migrating(pmd_t pmd);
 extern int migrate_misplaced_page(struct page *page,
 				  struct vm_area_struct *vma, int node,
 				  bool compound);
 #else
-static inline bool pmd_trans_migrating(pmd_t pmd)
-{
-	return false;
-}
 static inline int migrate_misplaced_page(struct page *page,
 					 struct vm_area_struct *vma, int node,
 					 bool compound)
@@ -117,24 +112,6 @@ static inline int migrate_misplaced_page(struct page *page,
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-#if defined(CONFIG_NUMA_BALANCING) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-extern int migrate_misplaced_transhuge_page(struct mm_struct *mm,
-			struct vm_area_struct *vma,
-			pmd_t *pmd, pmd_t entry,
-			unsigned long address,
-			struct page *page, int node);
-#else
-static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
-			struct vm_area_struct *vma,
-			pmd_t *pmd, pmd_t entry,
-			unsigned long address,
-			struct page *page, int node)
-{
-	return -EAGAIN;
-}
-#endif /* CONFIG_NUMA_BALANCING && CONFIG_TRANSPARENT_HUGEPAGE*/
-
-
 #ifdef CONFIG_MIGRATION
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 53f3843ce72a..157c63b0fd95 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1419,94 +1419,20 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	pmd_t pmd = vmf->orig_pmd;
-	struct anon_vma *anon_vma = NULL;
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	int page_nid = NUMA_NO_NODE, this_nid = numa_node_id();
+	int page_nid = NUMA_NO_NODE;
 	int target_nid, last_cpupid = -1;
-	bool page_locked;
 	bool migrated = false;
-	bool was_writable;
+	bool was_writable = pmd_savedwrite(pmd);
 	int flags = 0;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(pmd, *vmf->pmd)))
-		goto out_unlock;
-
-	/*
-	 * If there are potential migrations, wait for completion and retry
-	 * without disrupting NUMA hinting information. Do not relock and
-	 * check_same as the page may no longer be mapped.
-	 */
-	if (unlikely(pmd_trans_migrating(*vmf->pmd))) {
-		page = pmd_page(*vmf->pmd);
-		if (!get_page_unless_zero(page))
-			goto out_unlock;
-		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
-		goto out;
-	}
-
-	page = pmd_page(pmd);
-	BUG_ON(is_huge_zero_page(page));
-	page_nid = page_to_nid(page);
-	last_cpupid = page_cpupid_last(page);
-	count_vm_numa_event(NUMA_HINT_FAULTS);
-	if (page_nid == this_nid) {
-		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
-		flags |= TNF_FAULT_LOCAL;
-	}
-
-	/* See similar comment in do_numa_page for explanation */
-	if (!pmd_savedwrite(pmd))
-		flags |= TNF_NO_GROUP;
-
-	/*
-	 * Acquire the page lock to serialise THP migrations but avoid dropping
-	 * page_table_lock if at all possible
-	 */
-	page_locked = trylock_page(page);
-	target_nid = mpol_misplaced(page, vma, haddr);
-	if (target_nid == NUMA_NO_NODE) {
-		/* If the page was locked, there are no parallel migrations */
-		if (page_locked)
-			goto clear_pmdnuma;
-	}
-
-	/* Migration could have started since the pmd_trans_migrating check */
-	if (!page_locked) {
-		page_nid = NUMA_NO_NODE;
-		if (!get_page_unless_zero(page))
-			goto out_unlock;
+	if (unlikely(!pmd_same(pmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
-	/*
-	 * Page is misplaced. Page lock serialises migrations. Acquire anon_vma
-	 * to serialises splits
-	 */
-	get_page(page);
-	spin_unlock(vmf->ptl);
-	anon_vma = page_lock_anon_vma_read(page);
-
-	/* Confirm the PMD did not change while page_table_lock was released */
-	spin_lock(vmf->ptl);
-	if (unlikely(!pmd_same(pmd, *vmf->pmd))) {
-		unlock_page(page);
-		put_page(page);
-		page_nid = NUMA_NO_NODE;
-		goto out_unlock;
-	}
-
-	/* Bail if we fail to protect against THP splits for any reason */
-	if (unlikely(!anon_vma)) {
-		put_page(page);
-		page_nid = NUMA_NO_NODE;
-		goto clear_pmdnuma;
-	}
-
 	/*
 	 * Since we took the NUMA fault, we must have observed the !accessible
 	 * bit. Make sure all other CPUs agree with that, to avoid them
@@ -1533,38 +1459,44 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 					      haddr + HPAGE_PMD_SIZE);
 	}
 
-	/*
-	 * Migrate the THP to the requested node, returns with page unlocked
-	 * and access rights restored.
-	 */
-	spin_unlock(vmf->ptl);
-
-	migrated = migrate_misplaced_transhuge_page(vma->vm_mm, vma,
-				vmf->pmd, pmd, vmf->address, page, target_nid);
-	if (migrated) {
-		flags |= TNF_MIGRATED;
-		page_nid = target_nid;
-	} else
-		flags |= TNF_MIGRATE_FAIL;
-
-	goto out;
-clear_pmdnuma:
-	BUG_ON(!PageLocked(page));
-	was_writable = pmd_savedwrite(pmd);
+	/* Restore the PMD */
 	pmd = pmd_modify(pmd, vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (was_writable)
 		pmd = pmd_mkwrite(pmd);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-	unlock_page(page);
-out_unlock:
+
+	page = vm_normal_page_pmd(vma, haddr, pmd);
+	if (!page) {
+		spin_unlock(vmf->ptl);
+		goto out;
+	}
+
+	/* See similar comment in do_numa_page for explanation */
+	if (!was_writable)
+		flags |= TNF_NO_GROUP;
+
+	page_nid = page_to_nid(page);
+	last_cpupid = page_cpupid_last(page);
+	target_nid = numa_migrate_prep(page, vma, haddr, page_nid,
+				       &flags);
+
 	spin_unlock(vmf->ptl);
 
-out:
-	if (anon_vma)
-		page_unlock_anon_vma_read(anon_vma);
+	if (target_nid == NUMA_NO_NODE) {
+		put_page(page);
+		goto out;
+	}
+
+	migrated = migrate_misplaced_page(page, vma, target_nid, true);
+	if (migrated) {
+		flags |= TNF_MIGRATED;
+		page_nid = target_nid;
+	} else
+		flags |= TNF_MIGRATE_FAIL;
 
+out:
 	if (page_nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
 				flags);
diff --git a/mm/migrate.c b/mm/migrate.c
index 9c4ae5132919..86325c750c14 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2066,6 +2066,23 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
 	return newpage;
 }
 
+static struct page *alloc_misplaced_dst_page_thp(struct page *page,
+						 unsigned long data)
+{
+	int nid = (int) data;
+	struct page *newpage;
+
+	newpage = alloc_pages_node(nid, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
+				   HPAGE_PMD_ORDER);
+	if (!newpage)
+		goto out;
+
+	prep_transhuge_page(newpage);
+
+out:
+	return newpage;
+}
+
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int page_lru;
@@ -2104,12 +2121,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	return 1;
 }
 
-bool pmd_trans_migrating(pmd_t pmd)
-{
-	struct page *page = pmd_page(pmd);
-	return PageLocked(page);
-}
-
 static inline bool is_shared_exec_page(struct vm_area_struct *vma,
 				       struct page *page)
 {
@@ -2133,6 +2144,12 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	int isolated;
 	int nr_remaining;
 	LIST_HEAD(migratepages);
+	new_page_t *new;
+
+	if (compound)
+		new = alloc_misplaced_dst_page_thp;
+	else
+		new = alloc_misplaced_dst_page;
 
 	/*
 	 * Don't migrate file pages that are mapped in multiple processes
@@ -2153,9 +2170,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 		goto out;
 
 	list_add(&page->lru, &migratepages);
-	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
-				     NULL, node, MIGRATE_ASYNC,
-				     MR_NUMA_MISPLACED);
+	nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
+				     MIGRATE_ASYNC, MR_NUMA_MISPLACED);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
@@ -2174,145 +2190,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	return 0;
 }
 #endif /* CONFIG_NUMA_BALANCING */
-
-#if defined(CONFIG_NUMA_BALANCING) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-/*
- * Migrates a THP to a given target node. page must be locked and is unlocked
- * before returning.
- */
-int migrate_misplaced_transhuge_page(struct mm_struct *mm,
-				struct vm_area_struct *vma,
-				pmd_t *pmd, pmd_t entry,
-				unsigned long address,
-				struct page *page, int node)
-{
-	spinlock_t *ptl;
-	pg_data_t *pgdat = NODE_DATA(node);
-	int isolated = 0;
-	struct page *new_page = NULL;
-	int page_lru = page_is_file_lru(page);
-	unsigned long start = address & HPAGE_PMD_MASK;
-
-	if (is_shared_exec_page(vma, page))
-		goto out;
-
-	new_page = alloc_pages_node(node,
-		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
-		HPAGE_PMD_ORDER);
-	if (!new_page)
-		goto out_fail;
-	prep_transhuge_page(new_page);
-
-	isolated = numamigrate_isolate_page(pgdat, page);
-	if (!isolated) {
-		put_page(new_page);
-		goto out_fail;
-	}
-
-	/* Prepare a page as a migration target */
-	__SetPageLocked(new_page);
-	if (PageSwapBacked(page))
-		__SetPageSwapBacked(new_page);
-
-	/* anon mapping, we can simply copy page->mapping to the new page: */
-	new_page->mapping = page->mapping;
-	new_page->index = page->index;
-	/* flush the cache before copying using the kernel virtual address */
-	flush_cache_range(vma, start, start + HPAGE_PMD_SIZE);
-	migrate_page_copy(new_page, page);
-	WARN_ON(PageLRU(new_page));
-
-	/* Recheck the target PMD */
-	ptl = pmd_lock(mm, pmd);
-	if (unlikely(!pmd_same(*pmd, entry) || !page_ref_freeze(page, 2))) {
-		spin_unlock(ptl);
-
-		/* Reverse changes made by migrate_page_copy() */
-		if (TestClearPageActive(new_page))
-			SetPageActive(page);
-		if (TestClearPageUnevictable(new_page))
-			SetPageUnevictable(page);
-
-		unlock_page(new_page);
-		put_page(new_page);		/* Free it */
-
-		/* Retake the callers reference and putback on LRU */
-		get_page(page);
-		putback_lru_page(page);
-		mod_node_page_state(page_pgdat(page),
-			 NR_ISOLATED_ANON + page_lru, -HPAGE_PMD_NR);
-
-		goto out_unlock;
-	}
-
-	entry = mk_huge_pmd(new_page, vma->vm_page_prot);
-	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-
-	/*
-	 * Overwrite the old entry under pagetable lock and establish
-	 * the new PTE. Any parallel GUP will either observe the old
-	 * page blocking on the page lock, block on the page table
-	 * lock or observe the new page. The SetPageUptodate on the
-	 * new page and page_add_new_anon_rmap guarantee the copy is
-	 * visible before the pagetable update.
-	 */
-	page_add_anon_rmap(new_page, vma, start, true);
-	/*
-	 * At this point the pmd is numa/protnone (i.e. non present) and the TLB
-	 * has already been flushed globally.  So no TLB can be currently
-	 * caching this non present pmd mapping.  There's no need to clear the
-	 * pmd before doing set_pmd_at(), nor to flush the TLB after
-	 * set_pmd_at().  Clearing the pmd here would introduce a race
-	 * condition against MADV_DONTNEED, because MADV_DONTNEED only holds the
-	 * mmap_lock for reading.  If the pmd is set to NULL at any given time,
-	 * MADV_DONTNEED won't wait on the pmd lock and it'll skip clearing this
-	 * pmd.
-	 */
-	set_pmd_at(mm, start, pmd, entry);
-	update_mmu_cache_pmd(vma, address, &entry);
-
-	page_ref_unfreeze(page, 2);
-	mlock_migrate_page(new_page, page);
-	page_remove_rmap(page, true);
-	set_page_owner_migrate_reason(new_page, MR_NUMA_MISPLACED);
-
-	spin_unlock(ptl);
-
-	/* Take an "isolate" reference and put new page on the LRU. */
-	get_page(new_page);
-	putback_lru_page(new_page);
-
-	unlock_page(new_page);
-	unlock_page(page);
-	put_page(page);			/* Drop the rmap reference */
-	put_page(page);			/* Drop the LRU isolation reference */
-
-	count_vm_events(PGMIGRATE_SUCCESS, HPAGE_PMD_NR);
-	count_vm_numa_events(NUMA_PAGE_MIGRATE, HPAGE_PMD_NR);
-
-	mod_node_page_state(page_pgdat(page),
-			NR_ISOLATED_ANON + page_lru,
-			-HPAGE_PMD_NR);
-	return isolated;
-
-out_fail:
-	count_vm_events(PGMIGRATE_FAIL, HPAGE_PMD_NR);
-	ptl = pmd_lock(mm, pmd);
-	if (pmd_same(*pmd, entry)) {
-		entry = pmd_modify(entry, vma->vm_page_prot);
-		set_pmd_at(mm, start, pmd, entry);
-		update_mmu_cache_pmd(vma, address, &entry);
-	}
-	spin_unlock(ptl);
-
-out_unlock:
-	unlock_page(page);
-out:
-	put_page(page);
-	return 0;
-}
-#endif /* CONFIG_NUMA_BALANCING */
-
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_DEVICE_PRIVATE
-- 
2.26.2

