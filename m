Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218582;
	b=U+uATjdQB49Swl5LBzL+XvNwNrYrjfmBAI65xQMk3XOZmvUD476arbV/0iKeRrsC7D/C
	 dR24pNJ40d5AcDMcNEleold+WzF4Jid+u3yYEh0pkq8I5ZCefK4T4WtKY9hrUxPgNbROp
	 Xp3zRmuZzgiwzvc9u0bSU+X8yobHELmruIzfnsbmh8GhRwcieuw6n8JuzEyr191EqMJfY
	 vaHwhERWNPih7nOFyzVQH2ZegDvrEmR5uGnfxgCkYc25+mV3A3rrPuf7hQLMI0eUAlON5
	 2iWNkJr0oZt4tw8IFT1Ht4cOQx4uHSCtyGQLbV9RLiuW/JTeP1pwUeVSDKjFYP1ulxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218582;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zVNhQTz4P8YErSCLT2d+RLkWNh4QNHlHkejr3ylktPI=;
	b=kKzroczttMw/D5ql34hLqq6S8eFHU5JYwYWEjW4demzpouopzPf5no4xLjDfgUIO66U/
	 bNR0HdtklAiYa531gSalvbFKv/HTRi+LqUPPUplI6U4i7HVxez8K2DElqh+w/ddzJDTOl
	 zgTYtBknS8QNeHiaevfgwZHH/wtAgou8u8wEjG4iJ3a8zWohw2MCESp8X4EYqw2TnekSn
	 ngHSnondnbhmPgeVqrMuUOgyJuFt+sNU/yJZQi79pfe7OVtA00Ci0ZXFJUxxbPWCkrrY6
	 mUWLeazk3r0VSwJnrHb/1feyGHwy7Vab3wSzbW2nOx4mPV5dCq4E59Z6olUCLQJK6ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBOiiwUW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BD606A31D;
	Wed, 28 Oct 2026 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBOiiwUW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7093F1F031E1;
	Wed, 28 Oct 2026 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218581;
	bh=zVNhQTz4P8YErSCLT2d+RLkWNh4QNHlHkejr3ylktPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aBOiiwUW+1oShy4wpMapm/OmigTyXlwV71WiJYy0joVOtsxscBOIh4CrTbWU1y26E
	 Qh3SXfmyynsjDqDUS6VO6r1Zl30nflHLTpUKvNpO/qRhf2L8YmTPAiO9JbqvWqfIIt
	 +DEk91d75sdTgp90FOhuSDercjGUai18sC4+wzlPGJ3JX76YdAsk5rbRUZoLnYnsIr
	 oUfB7DdLNNmG7sl+ro6ef45/wlEP0aibZihxpe8RR5fU/Ub1zfHen4T8csLBShjybg
	 I8HWXXX9nNakee72T/ztM4cVghmeWufhV6OmujHWMoeP0+28u2AsMibCrw5JZ96zKQ
	 oFZRrmQ2gOozQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:43 +0100
Subject: [PATCH 15/15] RFC: mm/hugetlb: delay anon folio rmap removal until
 after the TLB flush
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-fixes_hugetlb-v1-15-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
In-Reply-To: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9027; i=david@kernel.org;
 h=from:subject:message-id; bh=/QKVObd/U9vskx+gsp/U8jaY46gGzOnFlcmK4jcuyIA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZcda+TP28LS9rxom+I+lpQZ+1Lv6eTwHtRuZjo/9
 cahH0xKHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExE5BQjw8F1rYf0c+2X8tYl
 Vs75/fEDM7/IzIOS55yzm6JEFz57WM3IML1RYF2DX9DUsjen9mY+1tWXeHpR6Wny0xcHavb6tXt
 I8QEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

After fork(), parent and child map anonymous folios read-only shared
by CoW. On a write fault, hugetlb_wp() reuses an anonymous page instead of
copying it if its mapcount is 1. As documented, switching to the safer
refcount would cause more harm than help with these scarce resources.

munmap() and MADV_DONTNEED unmap such folios and decrement the mapcount
before the TLB is flushed. Until then, another thread of the process can
still read the page through a stale TLB entry:

    child: reader        child: munmap()       parent: writer
    =============        ===============       ==============
    reads the page
                         clears the entry
                         mapcount drops to 1
                                               store to the page
                                                 hugetlb_wp() reuses it
    reads the store
      /* leak */
                         flushes the TLB

Similar observations are also known and possible with things like
vmsplice().

Extend the mmu_gather delayed-rmap machinery to handle hugetlb folios.
Defer anonymous hugetlb rmap removal until after the batched TLB flush.

Flush the TLB and remove pending rmaps when the batch fills and before
leaving the VMA, then drain the batch so later rmap flushes cannot process
the same entries again. This is very similar to how zap_present_ptes()
operates.

Skip deferral at exit. On UP, flush before removing the rmap. With
MMU_GATHER_NO_GATHER, clearing the entry already flushes the TLB.

Restore reservations after the actual rmap removal, preserving the existing
mapcount check.

This is very likely not stable-worthy, as hugetlb is commonly not used
for applications with different parent vs. child trust boundaries.

Fixes: 24669e58477e ("hugetlb: use mmu_gather instead of a temporary linked list for accumulating pages")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/s390/include/asm/tlb.h |  5 +++--
 include/asm-generic/tlb.h   |  5 +++--
 include/linux/hugetlb.h     |  7 +++++++
 mm/hugetlb.c                | 38 +++++++++++++++++++++++++++++++++-----
 mm/mmu_gather.c             | 14 ++++++++++----
 5 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 619fd41e710e..3408ee400d23 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -24,7 +24,7 @@
 
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-		struct page *page, int page_size);
+		struct page *page, int page_size, bool delay_rmap);
 static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
 		struct page *page, unsigned int nr_pages, bool delay_rmap);
 
@@ -45,8 +45,9 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
  * s390 doesn't delay rmap removal.
  */
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-		struct page *page, int page_size)
+		struct page *page, int page_size, bool delay_rmap)
 {
+	VM_WARN_ON_ONCE(delay_rmap);
 	free_folio_and_swap_cache(page_folio(page));
 	return false;
 }
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fbe1114e9a44..0fd51970a87e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -245,7 +245,8 @@ struct mmu_gather_batch {
  */
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
-extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size);
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+		int page_size, bool delay_rmap);
 bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
 		unsigned int nr_pages, bool delay_rmap);
 
@@ -465,7 +466,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
-	if (__tlb_remove_page_size(tlb, page, page_size))
+	if (__tlb_remove_page_size(tlb, page, page_size, false))
 		tlb_flush_mmu(tlb);
 }
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index badb8790653e..96a83fe0b7d6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -275,6 +275,8 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long cp_flags);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void fixup_hugetlb_reservations(struct vm_area_struct *vma);
+void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
+		struct folio *folio);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 unsigned int arch_hugetlb_cma_order(void);
@@ -460,6 +462,11 @@ static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 {
 }
 
+static inline void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
+		struct folio *folio)
+{
+}
+
 static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
 
 #endif /* !CONFIG_HUGETLB_PAGE */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 06ef8ba41df7..c8e3b8a6421a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5310,7 +5310,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 }
 
 /* Must be called after rmap removal. */
-static void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
+void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
 		struct folio *folio)
 {
 	struct hstate *h = hstate_vma(vma);
@@ -5377,6 +5377,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
+		bool delay_rmap = false;
+
 		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep) {
 			address |= last_addr_mask;
@@ -5449,19 +5451,45 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					make_pte_marker(PTE_MARKER_UFFD_WP),
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		hugetlb_remove_rmap(folio);
+		/*
+		 * hugetlb_wp() uses mapcount to decide whether an anonymous
+		 * folio can be reused. Delay rmap removal until stale TLB
+		 * entries are gone, unless the mm has no users left.
+		 */
+		if (folio_test_anon(folio) && !tlb->fullmm) {
+			delay_rmap = tlb_delay_rmap(tlb);
+			/*
+			 * Without delay-rmap support, just flush before
+			 * dropping the PTL. Except with MMU_GATHER_NO_GATHER
+			 * where clearing already flushed the TLB.
+			 */
+			if (!delay_rmap && !IS_ENABLED(CONFIG_MMU_GATHER_NO_GATHER))
+				flush_hugetlb_tlb_range(vma, address, address + sz);
+		}
+		if (!delay_rmap)
+			hugetlb_remove_rmap(folio);
 		spin_unlock(ptl);
 
-		hugetlb_folio_restore_rsv_on_unmap(vma, folio);
+		if (!delay_rmap)
+			hugetlb_folio_restore_rsv_on_unmap(vma, folio);
 
-		tlb_remove_page_size(tlb, folio_page(folio, 0),
-				     folio_size(folio));
+		if (__tlb_remove_page_size(tlb, folio_page(folio, 0), sz,
+					   delay_rmap)) {
+			tlb_flush_mmu_tlbonly(tlb);
+			tlb_flush_rmaps(tlb, vma);
+			tlb_flush_mmu(tlb);
+		}
 		/*
 		 * If we were instructed to unmap a specific folio, we're done.
 		 */
 		if (folio_provided)
 			break;
 	}
+	if (tlb->delayed_rmap) {
+		tlb_flush_mmu_tlbonly(tlb);
+		tlb_flush_rmaps(tlb, vma);
+		tlb_flush_mmu(tlb);
+	}
 	tlb_end_vma(tlb, vma);
 
 	huge_pmd_unshare_flush(tlb, vma);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 9f353f0e2ef4..b1f9f935e3b1 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -59,14 +59,19 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
 
 		if (encoded_page_flags(enc) & ENCODED_PAGE_BIT_DELAY_RMAP) {
 			struct page *page = encoded_page_ptr(enc);
+			struct folio *folio = page_folio(page);
 			unsigned int nr_pages = 1;
 
 			if (unlikely(encoded_page_flags(enc) &
 				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
 				nr_pages = encoded_nr_pages(pages[++i]);
 
-			folio_remove_rmap_ptes(page_folio(page), page, nr_pages,
-					       vma);
+			if (folio_test_hugetlb(folio)) {
+				hugetlb_remove_rmap(folio);
+				hugetlb_folio_restore_rsv_on_unmap(vma, folio);
+			} else {
+				folio_remove_rmap_ptes(folio, page, nr_pages, vma);
+			}
 		}
 	}
 }
@@ -211,9 +216,10 @@ bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
 					     PAGE_SIZE);
 }
 
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+		int page_size, bool delay_rmap)
 {
-	return __tlb_remove_folio_pages_size(tlb, page, 1, false, page_size);
+	return __tlb_remove_folio_pages_size(tlb, page, 1, delay_rmap, page_size);
 }
 
 #endif /* MMU_GATHER_NO_GATHER */

-- 
2.43.0

