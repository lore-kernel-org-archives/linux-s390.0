Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C78C43462
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1926F61242
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhDMVY5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhDMVY4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:24:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59DC06138C;
        Tue, 13 Apr 2021 14:24:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so11400215pjb.0;
        Tue, 13 Apr 2021 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wc5IRBNne8C2XmNA9U+IAl0qbIJab2EVH7f3uWeh2Q0=;
        b=cnSFn8e/7YIOhJCL0peBqCqO/F2xOpHYeVSqs7XwH35oRl/sU691Hxtn7s+8V8pFNN
         RTOUMl8ptc1YFiaH3ge/utuI8JH+/kjBlI6Me/L3HubkDCBOBEegU5GGBa0muthFxZua
         +f8ILOzWRjXIH9JMDpWO9LmZVnjfnLPeeDdNX9WDiSXHedv1KzQDqmzg9cgiCLDgTSGC
         dsOjM/rR3Su7I+wl3lCYclIO6tXlH3vev46jZ9MzwdrLKAXhixYwhpdziEszSsCSfHTy
         U6+g0ymAEARA8DYlDEodxsDJQ5W0RdlXlnXSl5E5fLzt6/nrr+42UzX7nvxuzpOrxiYP
         023w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wc5IRBNne8C2XmNA9U+IAl0qbIJab2EVH7f3uWeh2Q0=;
        b=kKoeYe2NN30ksib00GbIaPPD3p5SP86v7V+zaMSn0TXLE6TBX6u/PfJIoQakV4S/+r
         N2MYk8LK/s1S7+Cj7ZAap8FcP8ycO7770uv2FueDu2XYDHghr8QscqN/9beEunCozlSW
         6ZEAFFZha3P9xeA2I9b5kXUdLggeBGJ2bWKATdsyxHT30EK02k8/WaZjNDpzbY7wNAIs
         ZhHMQb+T9yt2kLH7dFvMDkNSyWL9ppWtKk++kZT3bgnmBb9bi/6+ScnMtQaFoxCCickG
         DdB30qJ/ee8uAMJnGDpqZmpNhyMv8XlAJnWUNAKRdyLAEbwfquWYnHQ6dKHpXJWvRQ21
         ftzA==
X-Gm-Message-State: AOAM533XE/vc874ysxHC8i0U87eIRAumFup5IeHAem5LNviVLbXhqFWi
        iDMndcqzpwzsf2cmyYWrY7o=
X-Google-Smtp-Source: ABdhPJzI5xCP/F5TCOOwfoKrF4m3/lk+W8KUIg5JJeiTDHAbodlkr2XhPg4wIAsudbHMvYhzAISHLw==
X-Received: by 2002:a17:90a:5998:: with SMTP id l24mr2067909pji.76.1618349075209;
        Tue, 13 Apr 2021 14:24:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:34 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/7] mm: thp: refactor NUMA fault handling
Date:   Tue, 13 Apr 2021 14:24:12 -0700
Message-Id: <20210413212416.3273-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
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
  Prepare for migration (elevate page refcount)
  Release ptl
  Isolate page from lru and elevate page refcount
  Migrate the misplaced THP

If migration is failed just restore the old normal PMD.

In the old code anon_vma lock was needed to serialize THP migration
against THP split, but since then the THP code has been reworked a lot,
it seems anon_vma lock is not required anymore to avoid the race.

The page refcount elevation when holding ptl should prevent from THP
split.

Use migrate_misplaced_page() for both base page and THP NUMA hinting
fault and remove all the dead and duplicate code.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/migrate.h |  23 ------
 mm/huge_memory.c        | 143 ++++++++++----------------------
 mm/internal.h           |  18 ----
 mm/migrate.c            | 177 ++++++++--------------------------------
 4 files changed, 77 insertions(+), 284 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4bb4e519e3f5..163d6f2b03d1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -95,14 +95,9 @@ static inline void __ClearPageMovable(struct page *page)
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
-extern bool pmd_trans_migrating(pmd_t pmd);
 extern int migrate_misplaced_page(struct page *page,
 				  struct vm_area_struct *vma, int node);
 #else
-static inline bool pmd_trans_migrating(pmd_t pmd)
-{
-	return false;
-}
 static inline int migrate_misplaced_page(struct page *page,
 					 struct vm_area_struct *vma, int node)
 {
@@ -110,24 +105,6 @@ static inline int migrate_misplaced_page(struct page *page,
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
index 35cac4aeaf68..94981907fd4c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1418,93 +1418,21 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	pmd_t pmd = vmf->orig_pmd;
-	struct anon_vma *anon_vma = NULL;
+	pmd_t oldpmd;
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
+	if (unlikely(!pmd_same(pmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
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
-	/* Migration could have started since the pmd_trans_migrating check */
-	if (!page_locked) {
-		page_nid = NUMA_NO_NODE;
-		if (!get_page_unless_zero(page))
-			goto out_unlock;
-		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
-		goto out;
-	} else if (target_nid == NUMA_NO_NODE) {
-		/* There are no parallel migrations and page is in the right
-		 * node. Clear the numa hinting info in this pmd.
-		 */
-		goto clear_pmdnuma;
-	}
-
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
@@ -1531,43 +1459,60 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 					      haddr + HPAGE_PMD_SIZE);
 	}
 
-	/*
-	 * Migrate the THP to the requested node, returns with page unlocked
-	 * and access rights restored.
-	 */
+	oldpmd = pmd_modify(pmd, vma->vm_page_prot);
+	page = vm_normal_page_pmd(vma, haddr, oldpmd);
+	if (!page) {
+		spin_unlock(vmf->ptl);
+		goto out_map;
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
+	if (target_nid == NUMA_NO_NODE) {
+		put_page(page);
+		goto out_map;
+	}
+
 	spin_unlock(vmf->ptl);
 
-	migrated = migrate_misplaced_transhuge_page(vma->vm_mm, vma,
-				vmf->pmd, pmd, vmf->address, page, target_nid);
+	migrated = migrate_misplaced_page(page, vma, target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
-	} else
+	} else {
 		flags |= TNF_MIGRATE_FAIL;
+		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+		if (unlikely(!pmd_same(pmd, *vmf->pmd))) {
+			spin_unlock(vmf->ptl);
+			goto out;
+		}
+		goto out_map;
+	}
 
-	goto out;
-clear_pmdnuma:
-	BUG_ON(!PageLocked(page));
-	was_writable = pmd_savedwrite(pmd);
+out:
+	if (page_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
+				flags);
+
+	return 0;
+
+out_map:
+	/* Restore the PMD */
 	pmd = pmd_modify(pmd, vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (was_writable)
 		pmd = pmd_mkwrite(pmd);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-	unlock_page(page);
-out_unlock:
 	spin_unlock(vmf->ptl);
-
-out:
-	if (anon_vma)
-		page_unlock_anon_vma_read(anon_vma);
-
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
-				flags);
-
-	return 0;
+	goto out;
 }
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index b6f889d9c22d..c060551d6ebf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -381,23 +381,6 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
  */
 extern void clear_page_mlock(struct page *page);
 
-/*
- * mlock_migrate_page - called only from migrate_misplaced_transhuge_page()
- * (because that does not go through the full procedure of migration ptes):
- * to migrate the Mlocked page flag; update statistics.
- */
-static inline void mlock_migrate_page(struct page *newpage, struct page *page)
-{
-	if (TestClearPageMlocked(page)) {
-		int nr_pages = thp_nr_pages(page);
-
-		/* Holding pmd lock, no change in irq context: __mod is safe */
-		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
-		SetPageMlocked(newpage);
-		__mod_zone_page_state(page_zone(newpage), NR_MLOCK, nr_pages);
-	}
-}
-
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 /*
@@ -448,7 +431,6 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 #else /* !CONFIG_MMU */
 static inline void clear_page_mlock(struct page *page) { }
 static inline void mlock_vma_page(struct page *page) { }
-static inline void mlock_migrate_page(struct page *new, struct page *old) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..333448aa53f1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2042,6 +2042,23 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
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
@@ -2080,12 +2097,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	return 1;
 }
 
-bool pmd_trans_migrating(pmd_t pmd)
-{
-	struct page *page = pmd_page(pmd);
-	return PageLocked(page);
-}
-
 /*
  * Attempt to migrate a misplaced page to the specified destination
  * node. Caller is expected to have an elevated reference count on
@@ -2098,6 +2109,20 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	int isolated;
 	int nr_remaining;
 	LIST_HEAD(migratepages);
+	new_page_t *new;
+	bool compound;
+
+	/*
+	 * PTE mapped THP or HugeTLB page can't reach here so the page could
+	 * be either base page or THP.  And it must be head page if it is
+	 * THP.
+	 */
+	compound = PageTransHuge(page);
+
+	if (compound)
+		new = alloc_misplaced_dst_page_thp;
+	else
+		new = alloc_misplaced_dst_page;
 
 	/*
 	 * Don't migrate file pages that are mapped in multiple processes
@@ -2119,9 +2144,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
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
@@ -2140,141 +2164,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
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
-	put_page(page);
-	return 0;
-}
-#endif /* CONFIG_NUMA_BALANCING */
-
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_DEVICE_PRIVATE
-- 
2.26.2

