Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D537BE6B
	for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812570; cv=none; b=jlbYVbRDgpxy9zxbOLC3zHLOGkeYAd97E8viBjKANYHsZVCpWzWPwYK6L281dvM/hOCRrt1gwB8shEwTCctGim7v7W+HZ9doA2YwWCE6HsIk5Py7u26cT4/PsoB5G3JDMUzYfRdMdp+07eEztPfd36PggKGvyZIv71NFgSDlEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812570; c=relaxed/simple;
	bh=Mwv33OFn1P/G3Y2GF6fMvwNlS7lhrWXSX04G+ayxp10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIzlZ6Pa002LuKiPripvnwsS3LP70NGIh1xanyB2G/IuFSupnbrDn2iUIh2rO9bpjR/DseU0MMMElowJHKLNNGUgzX0Gy72MX6m5ggoil916M3Nx1EI2lh80zPJ2eqFsZqSlVc5JKZ5uRXIqQLxaEdU4Egoytiko1GPIVm1UZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNFa+W2V; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNFa+W2V"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c726f46baso5904042c88.1
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776812568; x=1777417368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdOzQUx1kuF/ItixYZyEN7MAejmBx2S9M5lxrAx/c7w=;
        b=aNFa+W2VnQz+F24fJVGirJAxv8qNhlU667QtvmiNEkGYG4GStY5IstlNX8OcZ7OZ6X
         r7ecNpL+0E4zcE1GnJaj/0QYP1HC75YveutpkjUedT1X4o9iJ3d4K3hU7rBiE09xUVfw
         CHJpzCKuM9pP9VuzRNpABXMsVnuQveEmr00L9EyISwqcU6dONj7sY+T1Y4taRXYmYtZ1
         r9gBPiwrb9eFPLN+oesXWdJELTJQ6Ek1aGs4P9jy7V3BBv9eGbZenLGViY+r39kZi4gH
         Q3GV9ZQKbfLqwl+WyRMBc0rHlhGNBhwjpaqeuxPq/M1o1ZQPP88jzUkMadzMRYNnaZOM
         YBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812568; x=1777417368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdOzQUx1kuF/ItixYZyEN7MAejmBx2S9M5lxrAx/c7w=;
        b=MzYJOh8x/68D9I5tf2LrAQ7IqaN/dH2eEgJgvhe+Xp8Vfvv0Pdedk/4sj1rL4Ocmog
         A1gmkf9tjOChEjRF8w83+Awze/XjYSYuIDqKMUBRq72zMeFh/QGo6b2y9OZOMs3lPPUt
         sURQ1Z0lO16YWL/urug0evcOIwrh/4ahE/SJ8qbDh26yOXUvPe5yVfVXmfBLX2scx/xQ
         B8TfD+xvlm72+R1a76GMM1qlS8P19LOgx8JoV5dTR1Mj6MACAr5dKS8FgDu4czmmstkq
         4RQB42d57UdvTanvsK7te5jbSQccE+/Lr+EzQq/HzdZvMJUOp4kFtpvloxqUAN/GE+dG
         8Dlg==
X-Forwarded-Encrypted: i=1; AFNElJ+uUbSngxakTdZwlmpiAFRQWKsVrku6Jw5OVqcapVE0uhRl8BZTiMW7+ONxXhXVLz+GrfbkTIiKq07Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuuB2bQlUm/b56mA0BYxf51bTWX/H/ilP8r0pgRBB2cpmo+Et
	rHXppmSsbQE/Pqbh1uAwQc/7Ciw9Jkt4A54HOXCSST0PcI7h926OZLMV
X-Gm-Gg: AeBDiet4ByDN9jSRvE70CZFcfdXdZajybylNlMKnYOvaafCxUfjSRHKwYs8tR1SscNz
	KS9i4o0GYcJLVvYu+LpOcOrdUtau8Mvv4KPWI2pbo7U0nkoxav8ODrPFEy/ZyPTSv20S0HmoJh/
	w+Tr5UxirTOHDPOtUDGa/UJ6GamSahbYo5aqJFR48kDsg229kXghCDndgIj+o1WiPKAKvKgZwSL
	U4u+KiusuXFlzerux5COpbpiUCB+/DlJSTfCSZpu0xYv9kFApvV1HtJ+8UtzNxaHod2Go9aoqK5
	XCmZF0mvEVtjQkOuuFV1QOiXzJ8TNoIGeaYar/QaKjKq+MEwkjb9bZNxjQTPkk0V5v4J57WHaBq
	UJRk6vF9kNTkdYG4ssoOPTXmrtuo8SpaDccWjrdO5kF9PcYEn8ntVIBmcoVqomhSj0B7lAe6PFH
	39M/cNUeXiEH0IjXwICODUNVSlhsvJyr1YxPtOLVyET3CzMKkbfs4yoT0hD4bTqVn0c+q1j3Q0A
	DhvaCyndRK+vw==
X-Received: by 2002:a05:7022:5f14:b0:12c:87f1:f40a with SMTP id a92af1059eb24-12c87f1f7dbmr3847202c88.18.1776812567826;
        Tue, 21 Apr 2026 16:02:47 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2a00:79e0:2e7c:8:4678:d28b:b946:bcc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm26453546c88.14.2026.04.21.16.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:02:47 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: akpm@linux-foundation.org
Cc: hca@linux.ibm.com,
	linux-s390@vger.kernel.org,
	david@kernel.org,
	mhocko@suse.com,
	brauner@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	timmurray@google.com,
	Minchan Kim <minchan@google.com>,
	Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio reclaim via mmu_gather
Date: Tue, 21 Apr 2026 16:02:37 -0700
Message-ID: <20260421230239.172582-2-minchan@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
In-Reply-To: <20260421230239.172582-1-minchan@kernel.org>
References: <20260421230239.172582-1-minchan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, process_mrelease() unmaps pages but file-backed pages are
not evicted and stay in the pagecache, relying on standard memory reclaim
(kswapd or direct reclaim) to eventually free them. This delays the
immediate recovery of system memory under Android's LMKD scenarios,
leading to redundant background apps kills.

This patch implements an expedited eviction mechanism for clean pagecache
folios in the mmu_gather code, similar to how swapcache folios are handled.
It drops them from the pagecache (i.e., evicting them) if they are completely
unmapped during reaping.

Within this single unified loop, anonymous pages are released via
free_swap_cache(), and file-backed folios are symmetrically released via
free_file_cache().

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/s390/include/asm/tlb.h |  2 +-
 include/linux/swap.h        |  5 ++---
 mm/mmu_gather.c             |  7 ++++---
 mm/swap.c                   | 42 +++++++++++++++++++++++++++++++++++++
 mm/swap_state.c             | 26 -----------------------
 5 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 619fd41e710e..2736dbb571a8 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -62,7 +62,7 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
 	VM_WARN_ON_ONCE(delay_rmap);
 	VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
 
-	free_pages_and_swap_cache(encoded_pages, ARRAY_SIZE(encoded_pages));
+	free_pages_and_caches(tlb->mm, encoded_pages, ARRAY_SIZE(encoded_pages));
 	return false;
 }
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 62fc7499b408..bdb784966343 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -414,7 +414,9 @@ extern int sysctl_min_unmapped_ratio;
 extern int sysctl_min_slab_ratio;
 #endif
 
+struct mm_struct;
 void check_move_unevictable_folios(struct folio_batch *fbatch);
+void free_pages_and_caches(struct mm_struct *mm, struct encoded_page **pages, int nr);
 
 extern void __meminit kswapd_run(int nid);
 extern void __meminit kswapd_stop(int nid);
@@ -433,7 +435,6 @@ static inline unsigned long total_swapcache_pages(void)
 
 void free_swap_cache(struct folio *folio);
 void free_folio_and_swap_cache(struct folio *folio);
-void free_pages_and_swap_cache(struct encoded_page **, int);
 /* linux/mm/swapfile.c */
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
@@ -510,8 +511,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
 #define free_folio_and_swap_cache(folio) \
 	folio_put(folio)
-#define free_pages_and_swap_cache(pages, nr) \
-	release_pages((pages), (nr));
 
 static inline void free_swap_cache(struct folio *folio)
 {
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index fe5b6a031717..3c6c315d3c48 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -100,7 +100,8 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
  */
 #define MAX_NR_FOLIOS_PER_FREE		512
 
-static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
+static void __tlb_batch_free_encoded_pages(struct mm_struct *mm,
+		struct mmu_gather_batch *batch)
 {
 	struct encoded_page **pages = batch->encoded_pages;
 	unsigned int nr, nr_pages;
@@ -135,7 +136,7 @@ static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
 			}
 		}
 
-		free_pages_and_swap_cache(pages, nr);
+		free_pages_and_caches(mm, pages, nr);
 		pages += nr;
 		batch->nr -= nr;
 
@@ -148,7 +149,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
-		__tlb_batch_free_encoded_pages(batch);
+		__tlb_batch_free_encoded_pages(tlb->mm, batch);
 	tlb->active = &tlb->local;
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index bb19ccbece46..e44bc8cefceb 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1043,6 +1043,48 @@ void release_pages(release_pages_arg arg, int nr)
 }
 EXPORT_SYMBOL(release_pages);
 
+static inline void free_file_cache(struct folio *folio)
+{
+	if (folio_trylock(folio)) {
+		mapping_evict_folio(folio_mapping(folio), folio);
+		folio_unlock(folio);
+	}
+}
+
+/*
+ * Passed an array of pages, drop them all from swapcache and then release
+ * them.  They are removed from the LRU and freed if this is their last use.
+ *
+ * If @try_evict_file_folios is true, this function will proactively evict clean
+ * file-backed folios if they are no longer mapped.
+ */
+void free_pages_and_caches(struct mm_struct *mm, struct encoded_page **pages, int nr)
+{
+	bool try_evict_file_folios = mm_flags_test(MMF_UNSTABLE, mm);
+	struct folio_batch folios;
+	unsigned int refs[PAGEVEC_SIZE];
+
+	folio_batch_init(&folios);
+	for (int i = 0; i < nr; i++) {
+		struct folio *folio = page_folio(encoded_page_ptr(pages[i]));
+
+		if (folio_test_anon(folio))
+			free_swap_cache(folio);
+		else if (unlikely(try_evict_file_folios))
+			free_file_cache(folio);
+
+		refs[folios.nr] = 1;
+		if (unlikely(encoded_page_flags(pages[i]) &
+			     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
+			refs[folios.nr] = encoded_nr_pages(pages[++i]);
+
+		if (folio_batch_add(&folios, folio) == 0)
+			folios_put_refs(&folios, refs);
+	}
+	if (folios.nr)
+		folios_put_refs(&folios, refs);
+}
+
 /*
  * The folios which we're about to release may be in the deferred lru-addition
  * queues.  That would prevent them from really being freed right now.  That's
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 6d0eef7470be..7576bf36d920 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -400,32 +400,6 @@ void free_folio_and_swap_cache(struct folio *folio)
 		folio_put(folio);
 }
 
-/*
- * Passed an array of pages, drop them all from swapcache and then release
- * them.  They are removed from the LRU and freed if this is their last use.
- */
-void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
-{
-	struct folio_batch folios;
-	unsigned int refs[PAGEVEC_SIZE];
-
-	folio_batch_init(&folios);
-	for (int i = 0; i < nr; i++) {
-		struct folio *folio = page_folio(encoded_page_ptr(pages[i]));
-
-		free_swap_cache(folio);
-		refs[folios.nr] = 1;
-		if (unlikely(encoded_page_flags(pages[i]) &
-			     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
-			refs[folios.nr] = encoded_nr_pages(pages[++i]);
-
-		if (folio_batch_add(&folios, folio) == 0)
-			folios_put_refs(&folios, refs);
-	}
-	if (folios.nr)
-		folios_put_refs(&folios, refs);
-}
-
 static inline bool swap_use_vma_readahead(void)
 {
 	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
-- 
2.54.0.rc1.555.g9c883467ad-goog

