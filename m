Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853930;
	b=e6QFgS+A3NM5zkXXVFA2zKVALzXzJL5vLEYkPQTwXaf/Rfq1LhU8/7YuK8ANW5D/V3yh
	 tc57qMG/DBokFdG/6/ACtaGzQSl1eygtfZdHSll+RXa3/CVwrzNlu9ZR4kHQvmGub3PeJ
	 B6KIczdiLyRKr2a6a7eUD8XcDSMc3snW1M8a5ivqJ8+Z3tEeflWjevDECXewvVYntOqtA
	 kvljlwZI08WywLNolQ8c12YI+nJSvmkOmrlaGDvOLR9DuoMuvMFrwwOG7h0kcH7SmMlvr
	 UIuMjczajy/4ta6fL93kmorw3BqSX5lD/TabmnIdEAno44CG3x0D9B5T7sUpkzqqd8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853930;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=M7YASCMfUojH4P76ZeJnAz/MiqFf5EnwJ9chjkp8J9o=;
	b=uCFsrpkLo+GK8A4ro2Kbc2hWstZBeIytD2aKOxEkrr9HiCurvXgzGyK6xXH3MFxZ/gcy
	 Lrg+uDAWAvQaUoEYQEjzOKt+3fbMu6hRUFbSv18mbaKYz3SJVSDJX1xXyiFtt8x+Inuo9
	 y/D0bnhnh2v/dv4eBdUWMcncbzNhkvu/Hw8OxzdZnptE6WuActB6u1cF/GHwswG/vLDHo
	 9n8TkFkfze7nM2ALopKCZRZ3wj8uYHArvF7ZZu0XQpLlfITaoc26ppL9TB+1dmgpg/rHg
	 7znd6Qi5o/ycAdoptW8eeMWZMeMt0T6rdjjXGhcDJaG4lj32Me0XqyNPbdS/yx3e7RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGTCUFTG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29821606A332;
	Mon, 16 Nov 2026 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGTCUFTG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE64A1F000C4;
	Mon, 16 Nov 2026 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853930;
	bh=M7YASCMfUojH4P76ZeJnAz/MiqFf5EnwJ9chjkp8J9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UGTCUFTGbnSjNyFX3sPH+u4fMWq+LyxfN7y963g+66H/XuKSyQHtfjOV33IipciXk
	 u+VAzVaxmN/j6uyVvvyzegKMe4kVdLm63tmUbDlx7f+GubSbyTwz3jsScwLMeu4YJj
	 7XToOXS2svLW9+r7TqAhh4x4vu/2t93u0PdarnGcVHSvXosZF2DtYhOM5Q5rUSig+w
	 T5MaM4azc+4iPBHGC0JfRlrAIFjSN9z1zc3Em0VjwAxLcKvc38oZ+h+DFmFqIITpL1
	 K+FTP+8LE84TY4SJrv+z5FNouIvqOBXQiV/vpvBgTeSwGJedAJuGBtjTeNV77m6i6T
	 GICPiHRyyMGQA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:36 +0100
Subject: [PATCH v2 15/15] mm/hugetlb: delay anon folio rmap removal until
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
Message-Id: <20261116-fixes_hugetlb-v2-15-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
In-Reply-To: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8957; i=david@kernel.org;
 h=from:subject:message-id; bh=ezVRlEOJn8tPlGFEYoemtNxCRaBfSpr7eSGJpjRYqKA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3ee2eKUpvrlrnVJlzLTsd+pBdvTj0wznj7jsUtiy
 +RD71KKO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjI8RUM/8vDBCu5+TaeqSrZ
 mr2/1uuQlcfc7ZLvbL+rLy3/cHj/sS2MDK90zh0/J/a+9Y3V5JrLxzOENhn8amoSfl6+1VODbVo
 vHzcA
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
 mm/hugetlb.c                | 39 ++++++++++++++++++++++++++++++++++-----
 mm/internal.h               |  9 +++++++++
 mm/mmu_gather.c             | 16 ++++++++++++----
 5 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 619fd41e710e9..3408ee400d23e 100644
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
index 3f4a180b48f3c..476fa3495eb29 100644
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
 
@@ -464,7 +465,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
-	if (__tlb_remove_page_size(tlb, page, page_size))
+	if (__tlb_remove_page_size(tlb, page, page_size, false))
 		tlb_flush_mmu(tlb);
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 94de63529cbc5..ec9eaaa13ada3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5340,7 +5340,7 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
 }
 
 /* Must be called after rmap removal. */
-static void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
+void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
 		struct folio *folio)
 {
 	struct hstate *h = hstate_vma(vma);
@@ -5401,6 +5401,8 @@ static void hugetlb_unmap_range(struct mmu_gather *tlb,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
+		bool delay_rmap = false;
+
 		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep) {
 			address |= last_addr_mask;
@@ -5473,19 +5475,46 @@ static void hugetlb_unmap_range(struct mmu_gather *tlb,
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
+
+	if (tlb->delayed_rmap) {
+		tlb_flush_mmu_tlbonly(tlb);
+		tlb_flush_rmaps(tlb, vma);
+		tlb_flush_mmu(tlb);
+	}
 }
 
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
diff --git a/mm/internal.h b/mm/internal.h
index e3f92883bf238..2f1a7b9b2c055 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -614,6 +614,15 @@ void zap_vma_range_batched(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long addr,
 		unsigned long size, struct zap_details *details);
 int zap_vma_for_reaping(struct vm_area_struct *vma);
+#ifdef CONFIG_HUGETLB_PAGE
+void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
+		struct folio *folio);
+#else
+static inline void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
+		struct folio *folio)
+{
+}
+#endif
 int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 			   gfp_t gfp);
 
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 9f353f0e2ef4d..8728e1764fc5a 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -15,6 +15,8 @@
 
 #include <asm/tlb.h>
 
+#include "internal.h"
+
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 
 static bool tlb_next_batch(struct mmu_gather *tlb)
@@ -59,14 +61,19 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
 
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
@@ -211,9 +218,10 @@ bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
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
2.56.1

