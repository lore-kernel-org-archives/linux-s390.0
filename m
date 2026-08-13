Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9D3955EA;
	Thu, 13 Aug 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642670; cv=none; b=p60jAg1ljzCJEAA31Oyo36HqV2k9+Dm191TeR1v2kXM7bDuw9KlqTJQuc0cpwmtDD6N08RWMR0/R0avFXQp6eKPQLkzX+mIKvyWJW+QVCaSMDBnSTDTG33yOZjPHkT6SevPrxhGZxt+zmz3Wh0DskZr5zJn+SVTo/6bS6BoTgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642670; c=relaxed/simple;
	bh=21X8tD3ymqApiXmdDvrPodzuRSm0jreU8242LYwalmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tu9MA85a8Q/lxT1T5rKC7WhPGhcTNMJajzmMMrzUs+HYk9ZxIPMlBsPQoTO5bpiKDcbLq5OWl5jrTZl2f84jv2Z6J0c2T307XrLeE8ZTYrWI+nDdzYtiGD3nix5fv4mRGWp8vZs5U2TdosChJpFCEUKphgofMSYI7d1+CS0sMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjDtfCZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjDtfCZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6983A1F00A3A;
	Thu, 13 Aug 2026 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786642668;
	bh=k7V3KbJWuqhI1wrXEM1lc4hRJ9fsgJc7Eafz5Ed8bps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EjDtfCZwSgC5n/poUhpAkUiu22SB+fza++HAtn/5Tnu+tDvuPXsEU2S4fdHF0gHbq
	 dyCUERBZ4xjE0SOp5SN0GKrNzUpVJhagbUkMiTLZLohzCfA4D8QK9DxzRWPD8QUsUJ
	 oxtF6c06T61iML2LjWvQZgD/tf6ZyDGmQfBNpreQHZpackHxoWN9zXiRxnDMLv+yOF
	 TMc12Xwi2HKHOMI82+SuOvcbCyKKJTgpOcNPZ/ur2fHPYJkzh294+nzl8epupHWFZu
	 emR3UOI9M1eSf8M6V42YUbUmJ16JKUeHmt9lIfxBhIwtoLI1XxvwZ6VXELg8in9k8I
	 FDW5X9LgkCv1g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 13 Aug 2026 18:32:31 +0100
Subject: [PATCH v5 14/16] mm/rmap: use anon pgoff to track MAP_PRIVATE
 file-backed anon folios
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-b4-scalable-cow-virt-pgoff-v5-14-c21581c0c3c8@kernel.org>
References: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
In-Reply-To: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14135; i=ljs@kernel.org;
 h=from:subject:message-id; bh=21X8tD3ymqApiXmdDvrPodzuRSm0jreU8242LYwalmY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJq/6/ZWzo/1POEjZHw5SLNL3+PRXSLJZ+6p2Z1pURjj
 sSHrOWyHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZgIiwjDf9/ljS7xdr6qjx8v
 OzHlnFsud/S5at3D2kzT/u4/f9JYQoCRYU1x/cL2vAlOHB8+5P44M+Hlwh1yZ7bNi+WrX12WePJ
 oJBMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Currently anonymous folios belonging to CoW'd MAP_PRIVATE file-backed
mappings are indexed by their page offset within the file in which they
were originally mapped.

This differs from anonymous folios belonging to pure anon mappings which
are indexed by their anonymous page offset (the address at which they'd
belong in the VMA when first faulted).

This change fixes this inconsistency, always indexing anonymous folios by
their anonymous page offset regardless of the VMA to which they belong.

The foundations have been laid such that we need only switch this
functionality on such by:

* Using linear_anon_page_index() in __folio_set_anon() to assign the
  folio's index to the anonymous linear index rather than the file-backed
  one.

* Otherwise using linear_anon_page_index() in all instances where
  anonymous folios are being referenced or manipulated.

* Replacing vma_address() with vma_filebacked_address() or
  vma_anon_address() as appropriate.

* Updating the merging logic to check that anonymous page offsets are
  aligned as well as filebacked ones for MAP_PRIVATE file-backed VMAs,
  introducing needs_adjacent_anon_pgoff() to figure out when this is
  required.

* Updating linear_folio_page_index() to invoke linear_anon_page_index()
  if the folio is anonymous.

* Updating vma_address_end() to use the VMA's anonymous page offset when
  pvmw->pgoff is anonymous.

* Correcting folio_within_range() to use anonymous page offset for
  anonymous folios.

This will have no impact on merging of anonymous VMAs, whose page offset
and anonymous page offset are identical, nor will it impact shared
file-backed VMAs, which will continue to be merged based on the file-backed
page offset.

However, MAP_PRIVATE file-backed mappings must now be aligned on anonymous
page offset as well.

In most instances this should have no impact on merging of file-backed
mappings, which are usually not merged all that often, let alone
MAP_PRIVATE mapped ones, and rarely remapped and faulted before being moved
back in place (the case in which a merge may now fail).

One subtle impact of this change is in NUMA interleaving - since commit
88c91dc58582 ("mempolicy: migration attempt to match interleave nodes"),
migration heuristically tries to maintain interleaving behaviour matching
the policy using folio indices.

When doing migration of CoW'd MAP_PRIVATE-file backed ranges, the 'base'
upon which the interleaving behaviour is performed will vary for these
ranges. However the commit notes that ranges spanning multiple VMAs will
already cause varying bases, and that this is an acceptable approximation.

It is very unlikely real world use-cases will be impacted by
this (MAP_PRIVATE file-backed mappings are already an edge case), and all
that will happen is that such ranges will cause interleaving to be rotated
over the CoW'd range, with little to no impact.

This commit lays the foundations for future scalable CoW work which needs
to track some remaps, meaning that most remap tracking can be avoided, and
in nearly all cases the anonymous page offset will be able to be used to
quickly find the VMA in an mm.

Note that the need_rmap_locks check doesn't need to be updated, as any
remapping will offset both the anonymous and file-backed page offset, so it
suffices to check only one.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c     |  2 +-
 mm/internal.h        | 27 ++++++++-------------------
 mm/interval_tree.c   |  4 ++--
 mm/ksm.c             |  6 +++---
 mm/page_vma_mapped.c |  2 +-
 mm/rmap.c            | 12 ++++++------
 mm/userfaultfd.c     |  4 ++--
 mm/vma.c             | 32 +++++++++++++++++++++++++++++++-
 8 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 47c9c6e32eba..e46b3a4750ee 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2887,7 +2887,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_anon_page_index(dst_vma, dst_addr);
 
 		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
diff --git a/mm/internal.h b/mm/internal.h
index 98b067472ceb..5892b7453b54 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -933,7 +933,8 @@ folio_within_range(struct folio *folio, struct vm_area_struct *vma,
 		return false;
 
 	pgoff_folio = folio_pgoff(folio);
-	pgoff_vma_start = vma_start_pgoff(vma);
+	pgoff_vma_start = folio_test_anon(folio) ?
+		vma_start_anon_pgoff(vma) : vma_start_pgoff(vma);
 
 	if (start < vma->vm_start)
 		start = vma->vm_start;
@@ -1044,23 +1045,8 @@ static inline unsigned long vma_filebacked_address(const struct vm_area_struct *
 }
 
 /**
- * vma_address - Find the virtual address a page range is mapped at.
- * @vma: The vma which maps this object.
- * @pgoff: The page offset within its object.
- * @nr_pages: The number of pages to consider.
- *
- * If any page in this range is mapped by this VMA, return the first address
- * where any of these pages appear.  Otherwise, return -EFAULT.
- */
-static inline unsigned long vma_address(const struct vm_area_struct *vma,
-		pgoff_t pgoff, unsigned long nr_pages)
-{
-	return __vma_address(vma, pgoff, vma_start_pgoff(vma), nr_pages);
-}
-
-/**
- * vma_anon_address - Find the address an anonymous folio with index @pgoff_anon
- * is mapped at.
+ * vma_anon_address - Find the virtual address an anonymous page range is mapped
+ * at.
  * @vma: The vma which maps this object.
  * @pgoff_anon: The anonymous page index belonging to the folio.
  * @nr_pages: The number of pages to consider.
@@ -1093,7 +1079,10 @@ static inline unsigned long vma_address_end(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->nr_pages == 1)
 		return pvmw->address + PAGE_SIZE;
 
-	pgoff_vma_start = vma_start_pgoff(vma);
+	if (pvmw->pgoff_is_anon)
+		pgoff_vma_start = vma_start_anon_pgoff(vma);
+	else
+		pgoff_vma_start = vma_start_pgoff(vma);
 
 	address = vma->vm_start +
 		((pgoff_end - pgoff_vma_start) << PAGE_SHIFT);
diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 3ae9e106d3af..7bbbf15cfbf0 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -83,12 +83,12 @@ mapping_rmap_tree_iter_next(struct vm_area_struct *vma,
 
 static pgoff_t avc_start_pgoff(struct anon_vma_chain *avc)
 {
-	return vma_start_pgoff(avc->vma);
+	return vma_start_anon_pgoff(avc->vma);
 }
 
 static pgoff_t avc_last_pgoff(struct anon_vma_chain *avc)
 {
-	return vma_last_pgoff(avc->vma);
+	return vma_last_anon_pgoff(avc->vma);
 }
 
 INTERVAL_TREE_DEFINE(struct anon_vma_chain, rb, pgoff_t, rb_subtree_last,
diff --git a/mm/ksm.c b/mm/ksm.c
index 47006f494fcb..99738a213243 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1625,7 +1625,7 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	 * stable_tree, break_cow() will clean it up.
 	 */
 	rmap_item->anon_vma = vma->anon_vma;
-	rmap_item->linear_page_index = linear_page_index(vma, rmap_item->address);
+	rmap_item->linear_page_index = linear_anon_page_index(vma, rmap_item->address);
 	get_anon_vma(vma->anon_vma);
 out:
 	mmap_read_unlock(mm);
@@ -3152,7 +3152,7 @@ struct folio *ksm_might_need_to_copy(struct folio *folio,
 			return folio;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return folio;		/* no need to copy it */
-	} else if (folio->index == linear_page_index(vma, addr) &&
+	} else if (folio->index == linear_anon_page_index(vma, addr) &&
 			anon_vma->root == vma->anon_vma->root) {
 		return folio;		/* still no need to copy it */
 	}
@@ -3222,7 +3222,7 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 		/*
 		 * Currently, KSM folios are always small folios, so it's
 		 * sufficient to search for a single page. We can simply use
-		 * the linear_page_index of the original de-duplicate
+		 * the linear_anon_page_index of the original de-duplicate
 		 * anonymous page that we remembered in the rmap_item while
 		 * de-duplicating. Note that mremap() always de-duplicates KSM
 		 * folios: so if there was mremap() in our parent or our child,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 081e483cc7bf..4e964545e5e8 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -365,7 +365,7 @@ unsigned long page_mapped_in_vma(const struct page *page,
 	};
 
 	if (folio_test_anon(folio))
-		pvmw.address = vma_address(vma, pgoff, 1);
+		pvmw.address = vma_anon_address(vma, pgoff, 1);
 	else
 		pvmw.address = vma_filebacked_address(vma, pgoff, 1);
 	if (pvmw.address == -EFAULT)
diff --git a/mm/rmap.c b/mm/rmap.c
index ab3f879454de..2a9ae25ae72d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -866,7 +866,7 @@ unsigned long page_address_in_vma(const struct folio *folio,
 		    vma->anon_vma->root != anon_vma->root)
 			return -EFAULT;
 		/* KSM folios don't reach here because of the !anon_vma check */
-		return vma_address(vma, page_pgoff(folio, page), 1);
+		return vma_anon_address(vma, page_pgoff(folio, page), 1);
 	} else if (!vma->vm_file) {
 		return -EFAULT;
 	} else if (vma->vm_file->f_mapping != folio->mapping) {
@@ -1485,7 +1485,7 @@ static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
 	 */
 	anon_vma = (void *) anon_vma + FOLIO_MAPPING_ANON;
 	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
-	folio->index = linear_page_index(vma, address);
+	folio->index = linear_anon_page_index(vma, address);
 }
 
 /**
@@ -1512,8 +1512,8 @@ static void __page_check_anon_rmap(const struct folio *folio,
 	 */
 	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
 			folio);
-	VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address),
-		       page);
+	VM_BUG_ON_PAGE(page_pgoff(folio, page) !=
+		       linear_anon_page_index(vma, address), page);
 }
 
 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
@@ -3040,10 +3040,10 @@ static void rmap_walk_anon(struct folio *folio,
 	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
 	anon_rmap_tree_foreach(avc, anon_vma, pgoff_start, pgoff_end) {
 		struct vm_area_struct *vma = avc->vma;
-		unsigned long address = vma_address(vma, pgoff_start,
+		const unsigned long address = vma_anon_address(vma, pgoff_start,
 				folio_nr_pages(folio));
 
-		VM_BUG_ON_VMA(address == -EFAULT, vma);
+		VM_WARN_ON_ONCE_VMA(address == -EFAULT, vma);
 		cond_resched();
 
 		if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8fd24c8b428e..24a4d92ffa3c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1352,7 +1352,7 @@ static long move_present_ptes(struct mm_struct *mm,
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_anon_page_index(dst_vma, dst_addr);
 
 		orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 		/* Set soft dirty bit so userspace can notice the pte was moved */
@@ -1428,7 +1428,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	 */
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_anon_page_index(dst_vma, dst_addr);
 	} else {
 		/*
 		 * Check if the swap entry is cached after acquiring the src_pte
diff --git a/mm/vma.c b/mm/vma.c
index b55015952f0d..117ca94fc907 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -204,6 +204,25 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 		vp->skip_vma_uprobe = true;
 }
 
+/*
+ * Does this merge require that adjacent VMAs must have adjacent anonymous page
+ * offsets in addition to having adjacent vma->vm_pgoff?
+ *
+ * This is only required for MAP_PRIVATE-file backed mappings as the page offset
+ * for pure anonymous VMAs is equal to the anonymous page offset.
+ *
+ * Read-only shared mappings (with VMA_SHARED_BIT cleared) are always unfaulted
+ * so automatically have correct anonymous page offset (as it is always updated
+ * on remap).
+ *
+ * 'Special' mappings in the sense of VDSO, VVAR etc. have !file but would in
+ * any case not be candidates for merge nor be mergeable.
+ */
+static bool needs_adjacent_anon_pgoff(const struct vma_merge_struct *vmg)
+{
+	return vmg->file && vma_flags_is_cow_mapping(&vmg->vma_flags);
+}
+
 /*
  * Return true if we can merge this (vma_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -225,6 +244,9 @@ static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 		return false;
 	if (vmg_end_pgoff(vmg) != vma_start_pgoff(vmg->next))
 		return false;
+	if (needs_adjacent_anon_pgoff(vmg) &&
+	    vmg_end_anon_pgoff(vmg) != vma_start_anon_pgoff(vmg->next))
+		return false;
 	return true;
 }
 
@@ -245,6 +267,9 @@ static bool can_vma_merge_after(struct vma_merge_struct *vmg)
 		return false;
 	if (vma_end_pgoff(vmg->prev) != vmg_start_pgoff(vmg))
 		return false;
+	if (needs_adjacent_anon_pgoff(vmg) &&
+	    vma_end_anon_pgoff(vmg->prev) != vmg_start_anon_pgoff(vmg))
+		return false;
 	return true;
 }
 
@@ -2048,7 +2073,12 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 	if (!vma_flags_empty(&diff))
 		return false;
 	/* Page offset must align. */
-	return vma_end_pgoff(a) == vma_start_pgoff(b);
+	if (vma_end_pgoff(a) != vma_start_pgoff(b))
+		return false;
+	/* Only reached from anon path, so either MAP_PRIVATE file or anon. */
+	if (vma_end_anon_pgoff(a) != vma_start_anon_pgoff(b))
+		return false;
+	return true;
 }
 
 /*

-- 
2.55.0

