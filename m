Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C134E74D;
	Thu,  6 Aug 2026 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047919; cv=none; b=aqrUIM+3tpKqe5EdMX6kTsnR/5xbmRz4bjRs17PNUTHx7tNN7KEuRPOwuHqnROyuKa84sGundx02qb7ISwUnipWwdDbbfiDQ5/cr05NzrU7MuXOJpB5gooy0AhvSev2Lf1Y0SuAAEF5//HMWZMYdyZz9hVzne0N5T8888XHadvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047919; c=relaxed/simple;
	bh=AyIYrhzUHJF8dUestntVqmDUqdrez55Qr20v7Ceu/jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBGZesmdqA4qLwqJO6esscnl72gL1eX++nlvy4aDR1qzrHmjNVYKshWjkeBy7C83iUcZIwBIAC8wzss2NM8X5etO6hyjH1ZPmbgWrCsd1kW2ziGk+hdFZrfdIBVu7TeNouo432h8MLqwh64QOJy0z4Ws5WrDyloW7s5XyCx2Zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyn1wWwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyn1wWwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341AC1F00A3D;
	Thu,  6 Aug 2026 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047917;
	bh=oao9Xk4uxKSjDN12QXQzhenCGYwnNUJY+Ax5MPFwIgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jyn1wWwnnSZmZGtMbWal5DVN09uA80dzqH+jTdZBK2c9aHbS8UX6uXJC31yIhjfkI
	 X34d6flfVXmExy6Q5Iqkr5eFI1dbqNrK9Vj3GeziXy+VI1i8iH0IZYDdabTQBgqpLw
	 51UmpZ+Odp01c0O3WlD0MbavfrHd2cdGb2Qd1K7w+rpRwv8MU/WwEJJxkBWX7vT2wV
	 bgvUszqoPE4S/danJFigNLXiAGHlllFRda6KFYDF29sfgqtH3iaHTqd1jU0HXwcTcG
	 mNJgIVMGDGIo1iigKd7V3DxIQkW02z6aLgKnbc/JO/8CRh0E4k7VlcfrfUMBILx4U2
	 Aj5HjNsRCetaw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 06 Aug 2026 21:21:34 +0100
Subject: [PATCH v4 09/20] mm: propagate VMA anonymous page offset on map,
 remap, split + merge
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-9-ab318a350404@kernel.org>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20248; i=ljs@kernel.org;
 h=from:subject:message-id; bh=AyIYrhzUHJF8dUestntVqmDUqdrez55Qr20v7Ceu/jA=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3lxgC1rVGhxuceb5bRPbP+oRzEaL9ii75iR9NTVgO
 Tk7rj24o5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABPZPZ3hn6V3NM8p3eiUYzW5
 nXG3Nxxe/kF6aWBLo1Hsw4pgi4CzGxj+l7sfrF+Zz+Eru9+udNps3UrPMKfDawNdlj3f+GXDaaN
 9vAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

We must correctly update VMA anonymous page offset state on all VMA
operations that would result in it changing, with special attention given
to remapping.

We cover most cases by simply updating vma_set_range() to do so (with a new
anonymous page offset parameter), but also notably must update the merging
and mapping logic to propagate this parameter correctly.

The remap logic remains the same - we may update the anonymous page offset
if the VMA is unfaulted, but now this applies to MAP_PRIVATE file-backed
mappings too, so we update the code to reflect this.

Note that we use __linear_anon_page_index() upon remap as the VMA may be
shared, in order that we update the field consistently regardless of VMA
type.

Similarly, pass through anon page offset to the merge logic, updating the
vma_merge_struct struct to propagate it, and also use
__linear_anon_page_index() to obtain the anonymous page index so it can be
safely used for both shared and MAP_PRIVATE file-backed mappings.

In copy_vma(), the anonymous page offset is updated regardless of whether
the mapping is a CoW mapping or not. This is both to keep the anonymous
page offset consistent even for non-CoW mappings (it is set so should at
least remain correct) and makes the logic cleaner.

A self-merge however remains permitted only for mappings which can have a
populated vma->anon_vma and do not require alignment on a separate file
offset - that is pure anonymous VMAs, so only set can_self_merge if
vma_is_anonymous().

Finally, we update insert_vm_struct() to correctly set the anonymous page
offset on insertion of a VMA.

We simply ensure state is correctly propagated here, so no functional
changes are intended.

Also update VMA userland tests to reflect this change.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mremap.c                     |  6 ++--
 mm/vma.c                        | 52 ++++++++++++++++++----------
 mm/vma.h                        | 75 ++++++++++++++++++++++++-----------------
 mm/vma_exec.c                   |  2 +-
 tools/testing/vma/shared.c      |  3 +-
 tools/testing/vma/tests/merge.c |  4 ++-
 tools/testing/vma/tests/vma.c   | 10 +++---
 7 files changed, 95 insertions(+), 57 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index b64aa1f6e07e..9ea1707eafa5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1265,7 +1265,9 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
 static int copy_vma_and_data(struct vma_remap_struct *vrm,
 			     struct vm_area_struct **new_vma_ptr)
 {
-	const unsigned long new_pgoff = linear_page_index(vrm->vma, vrm->addr);
+	const pgoff_t new_pgoff = linear_page_index(vrm->vma, vrm->addr);
+	const pgoff_t new_anon_pgoff =
+		__linear_anon_page_index(vrm->vma, vrm->addr);
 	struct vm_area_struct *vma = vrm->vma;
 	struct vm_area_struct *new_vma;
 	unsigned long moved_len;
@@ -1273,7 +1275,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
 
 	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   &pmc.need_rmap_locks);
+			   new_anon_pgoff, &pmc.need_rmap_locks);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
diff --git a/mm/vma.c b/mm/vma.c
index 18c8f2546765..b55015952f0d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -18,6 +18,7 @@ struct mmap_state {
 	unsigned long addr;
 	unsigned long end;
 	pgoff_t pgoff;
+	pgoff_t anon_pgoff;
 	unsigned long pglen;
 	union {
 		vm_flags_t vm_flags;
@@ -46,13 +47,14 @@ struct mmap_state {
 	bool file_doesnt_need_get :1;
 };
 
-#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, vma_flags_, file_) \
+#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, anon_pgoff_, vma_flags_, file_) \
 	struct mmap_state name = {					\
 		.mm = mm_,						\
 		.vmi = vmi_,						\
 		.addr = addr_,						\
 		.end = (addr_) + (len_),				\
 		.pgoff = pgoff_,					\
+		.anon_pgoff = anon_pgoff_,				\
 		.pglen = PHYS_PFN(len_),				\
 		.vma_flags = vma_flags_,				\
 		.file = file_,						\
@@ -67,6 +69,7 @@ struct mmap_state {
 		.end = (map_)->end,					\
 		.vma_flags = (map_)->vma_flags,				\
 		.pgoff = (map_)->pgoff,					\
+		.anon_pgoff = (map_)->anon_pgoff,			\
 		.file = (map_)->file,					\
 		.prev = (map_)->prev,					\
 		.middle = vma_,						\
@@ -82,10 +85,11 @@ static void __vma_set_range(struct vm_area_struct *vma, unsigned long start,
 }
 
 static void vma_set_range(struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, pgoff_t pgoff)
+			  unsigned long end, pgoff_t pgoff, pgoff_t anon_pgoff)
 {
 	__vma_set_range(vma, start, end);
 	vma_set_pgoff(vma, pgoff);
+	vma_set_anon_pgoff(vma, anon_pgoff);
 }
 
 /* Was this VMA ever forked from a parent, i.e. maybe contains CoW mappings? */
@@ -812,7 +816,8 @@ static int commit_merge(struct vma_merge_struct *vmg)
 	 */
 	vma_adjust_trans_huge(vma, vmg->start, vmg->end,
 			      vmg->__adjust_middle_start ? vmg->middle : NULL);
-	vma_set_range(vma, vmg->start, vmg->end, vmg_start_pgoff(vmg));
+	vma_set_range(vma, vmg->start, vmg->end, vmg_start_pgoff(vmg),
+		      vmg_start_anon_pgoff(vmg));
 	vmg_adjust_set_range(vmg);
 	vma_iter_store_overwrite(vmg->vmi, vmg->target);
 
@@ -982,6 +987,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		vmg->start = prev->vm_start;
 		vmg->end = next->vm_end;
 		vmg->pgoff = vma_start_pgoff(prev);
+		vmg->anon_pgoff = vma_start_anon_pgoff(prev);
 
 		/*
 		 * We already ensured anon_vma compatibility above, so now it's
@@ -1000,6 +1006,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		 */
 		vmg->start = prev->vm_start;
 		vmg->pgoff = vma_start_pgoff(prev);
+		vmg->anon_pgoff = vma_start_anon_pgoff(prev);
 
 		if (!vmg->__remove_middle)
 			vmg->__adjust_middle_start = true;
@@ -1022,12 +1029,14 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		if (vmg->__remove_middle) {
 			vmg->end = next->vm_end;
 			vmg->pgoff = vma_start_pgoff(next) - pglen;
+			vmg->anon_pgoff = vma_start_anon_pgoff(next) - pglen;
 		} else {
 			/* We shrink middle and expand next. */
 			vmg->__adjust_next_start = true;
 			vmg->start = middle->vm_start;
 			vmg->end = start;
 			vmg->pgoff = vma_start_pgoff(middle);
+			vmg->anon_pgoff = vma_start_anon_pgoff(middle);
 		}
 
 		err = dup_anon_vma(next, middle, &anon_dup);
@@ -1137,6 +1146,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vmg->start = prev->vm_start;
 		vmg->target = prev;
 		vmg->pgoff = vma_start_pgoff(prev);
+		vmg->anon_pgoff = vma_start_anon_pgoff(prev);
 
 		/*
 		 * If this merge would result in removal of the next VMA but we
@@ -1908,7 +1918,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	pgoff_t anon_pgoff, bool *need_rmap_locks)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long old_vma_start = vma->vm_start;
@@ -1919,12 +1929,16 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
 
 	/*
-	 * If anonymous vma has not yet been faulted, update new pgoff
-	 * to match new location, to increase its chance of merging.
+	 * If a vma has not yet been faulted, update its anonymous pgoff to
+	 * match the new location to increase its chance of merging.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
-		pgoff = addr >> PAGE_SHIFT;
-		can_self_merge = true;
+	if (!vma->anon_vma) {
+		anon_pgoff = addr >> PAGE_SHIFT;
+
+		if (vma_is_anonymous(vma)) {
+			pgoff = anon_pgoff;
+			can_self_merge = true;
+		}
 	}
 
 	/*
@@ -1940,6 +1954,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		return NULL;	/* should never get here */
 
 	vmg.pgoff = pgoff;
+	vmg.anon_pgoff = anon_pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
 	new_vma = vma_merge_copied_range(&vmg);
 
@@ -1955,8 +1970,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			 * next to be removed and prev to be expanded to cover
 			 * the entire range.
 			 *
-			 * This should only be possible if the page offset was
-			 * updated, i.e. the VMA is unfaulted.
+			 * This should only be possible if the anonymous page
+			 * offset was updated, i.e. the VMA is unfaulted.
 			 */
 			VM_WARN_ON_ONCE_VMA(!can_self_merge, new_vma);
 			*vmap = vma = new_vma;
@@ -1967,7 +1982,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
 			goto out;
-		vma_set_range(new_vma, addr, addr + len, pgoff);
+		vma_set_range(new_vma, addr, addr + len, pgoff, anon_pgoff);
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
 		if (anon_vma_clone(new_vma, vma, VMA_OP_REMAP))
@@ -2609,7 +2624,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	if (is_anon)
 		vma_set_anonymous(vma);
 
-	vma_set_range(vma, map->addr, map->end, map->pgoff);
+	vma_set_range(vma, map->addr, map->end, map->pgoff, map->anon_pgoff);
 	vma->flags = map->vma_flags;
 	vma->vm_page_prot = map->page_prot;
 
@@ -2798,7 +2813,8 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *vma = NULL;
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
-	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vma_flags, file);
+	const pgoff_t anon_pgoff = addr >> PAGE_SHIFT;
+	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags, file);
 	struct vm_area_desc desc = {
 		.mm = mm,
 		.file = file,
@@ -2943,6 +2959,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		 unsigned long addr, unsigned long len, vma_flags_t vma_flags)
 {
 	struct mm_struct *mm = current->mm;
+	const pgoff_t pgoff = addr >> PAGE_SHIFT;
 
 	/*
 	 * Check against address space limits by the changed size
@@ -2967,7 +2984,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
 	if (vma && vma->vm_end == addr) {
-		VMG_STATE(vmg, mm, vmi, addr, addr + len, vma_flags, PHYS_PFN(addr));
+		VMG_STATE(vmg, mm, vmi, addr, addr + len, vma_flags, pgoff, pgoff);
 
 		vmg.prev = vma;
 		/* vmi is positioned at prev, which this mode expects. */
@@ -2987,7 +3004,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto unacct_fail;
 
 	vma_set_anonymous(vma);
-	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
+	vma_set_range(vma, addr, addr + len, pgoff, pgoff);
 	vma->flags = vma_flags;
 	vma->vm_page_prot = vm_get_page_prot(vma_flags_to_legacy(vma_flags));
 	vma_start_write(vma);
@@ -3379,6 +3396,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 		WARN_ON_ONCE(vma->anon_vma);
 		vma_set_pgoff(vma, vma->vm_start >> PAGE_SHIFT);
 	}
+	vma_set_anon_pgoff(vma, vma->vm_start >> PAGE_SHIFT);
 
 	if (vma_link(mm, vma)) {
 		if (vma_test(vma, VMA_ACCOUNT_BIT))
@@ -3434,7 +3452,7 @@ struct vm_area_struct *__install_special_mapping(
 
 	vma->vm_ops = ops;
 	vma->vm_private_data = priv;
-	vma_set_range(vma, addr, addr + len, 0);
+	vma_set_range(vma, addr, addr + len, 0, addr >> PAGE_SHIFT);
 
 	ret = insert_vm_struct(mm, vma);
 	if (ret)
diff --git a/mm/vma.h b/mm/vma.h
index 54ed7c744e3b..024fabe63560 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -104,6 +104,7 @@ struct vma_merge_struct {
 	unsigned long start;
 	unsigned long end;
 	pgoff_t pgoff;
+	pgoff_t anon_pgoff;
 
 	union {
 		/* Temporary while VMA flags are being converted. */
@@ -237,11 +238,6 @@ static inline bool vmg_nomem(struct vma_merge_struct *vmg)
 	return vmg->state == VMA_MERGE_ERROR_NOMEM;
 }
 
-static inline pgoff_t vmg_start_pgoff(const struct vma_merge_struct *vmg)
-{
-	return vmg->pgoff;
-}
-
 static inline pgoff_t vmg_pages(const struct vma_merge_struct *vmg)
 {
 	const unsigned long size = vmg->end - vmg->start;
@@ -249,6 +245,11 @@ static inline pgoff_t vmg_pages(const struct vma_merge_struct *vmg)
 	return size >> PAGE_SHIFT;
 }
 
+static inline pgoff_t vmg_start_pgoff(const struct vma_merge_struct *vmg)
+{
+	return vmg->pgoff;
+}
+
 static inline pgoff_t vmg_end_pgoff(const struct vma_merge_struct *vmg)
 {
 	return vmg_start_pgoff(vmg) + vmg_pages(vmg);
@@ -283,6 +284,16 @@ static inline void vma_set_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 	vma->vm_pgoff = pgoff;
 }
 
+static inline pgoff_t vmg_start_anon_pgoff(const struct vma_merge_struct *vmg)
+{
+	return vmg->anon_pgoff;
+}
+
+static inline pgoff_t vmg_end_anon_pgoff(const struct vma_merge_struct *vmg)
+{
+	return vmg_start_anon_pgoff(vmg) + vmg_pages(vmg);
+}
+
 static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 {
 #ifdef CONFIG_64BIT
@@ -301,44 +312,48 @@ static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t delta)
 {
 	vma_assert_can_modify(vma);
 	vma_set_pgoff(vma, vma_start_pgoff(vma) + delta);
+	vma_set_anon_pgoff(vma, vma_start_anon_pgoff(vma) + delta);
 }
 
 static inline void vma_sub_pgoff(struct vm_area_struct *vma, pgoff_t delta)
 {
 	vma_assert_can_modify(vma);
 	vma_set_pgoff(vma, vma_start_pgoff(vma) - delta);
-}
+	vma_set_anon_pgoff(vma, vma_start_anon_pgoff(vma) - delta);
+}
+
+#define VMG_STATE(name, mm_, vmi_, start_, end_, vma_flags_, pgoff_, anon_pgoff_) \
+	struct vma_merge_struct name = {					  \
+		.mm = mm_,							  \
+		.vmi = vmi_,							  \
+		.start = start_,						  \
+		.end = end_,							  \
+		.vma_flags = vma_flags_,					  \
+		.pgoff = pgoff_,						  \
+		.anon_pgoff = anon_pgoff_,					  \
+		.state = VMA_MERGE_START,					  \
+	}
 
-#define VMG_STATE(name, mm_, vmi_, start_, end_, vma_flags_, pgoff_)	\
+#define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)		\
 	struct vma_merge_struct name = {				\
-		.mm = mm_,						\
+		.mm = vma_->vm_mm,					\
 		.vmi = vmi_,						\
+		.prev = prev_,						\
+		.middle = vma_,						\
+		.next = NULL,						\
 		.start = start_,					\
 		.end = end_,						\
-		.vma_flags = vma_flags_,				\
-		.pgoff = pgoff_,					\
+		.vm_flags = vma_->vm_flags,				\
+		.pgoff = linear_page_index(vma_, start_),		\
+		.anon_pgoff = __linear_anon_page_index(vma_, start_),	\
+		.file = vma_->vm_file,					\
+		.anon_vma = vma_->anon_vma,				\
+		.policy = vma_policy(vma_),				\
+		.uffd_ctx = vma_->vm_userfaultfd_ctx,			\
+		.anon_name = anon_vma_name(vma_),			\
 		.state = VMA_MERGE_START,				\
 	}
 
-#define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
-	struct vma_merge_struct name = {			\
-		.mm = vma_->vm_mm,				\
-		.vmi = vmi_,					\
-		.prev = prev_,					\
-		.middle = vma_,					\
-		.next = NULL,					\
-		.start = start_,				\
-		.end = end_,					\
-		.vm_flags = vma_->vm_flags,			\
-		.pgoff = linear_page_index(vma_, start_),	\
-		.file = vma_->vm_file,				\
-		.anon_vma = vma_->anon_vma,			\
-		.policy = vma_policy(vma_),			\
-		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
-		.anon_name = anon_vma_name(vma_),		\
-		.state = VMA_MERGE_START,			\
-	}
-
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 void validate_mm(struct mm_struct *mm);
 #else
@@ -520,7 +535,7 @@ void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
 
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	pgoff_t anon_pgoff, bool *need_rmap_locks);
 
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma);
 
diff --git a/mm/vma_exec.c b/mm/vma_exec.c
index 7af1260689b9..586c52155942 100644
--- a/mm/vma_exec.c
+++ b/mm/vma_exec.c
@@ -41,7 +41,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	unsigned long new_end = old_end - shift;
 	VMA_ITERATOR(vmi, mm, new_start);
 	VMG_STATE(vmg, mm, &vmi, new_start, old_end, EMPTY_VMA_FLAGS,
-		  vma_start_pgoff(vma));
+		  vma_start_pgoff(vma), vma_start_anon_pgoff(vma));
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
 	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
index bea9ea6db02a..4a39c9d50489 100644
--- a/tools/testing/vma/shared.c
+++ b/tools/testing/vma/shared.c
@@ -23,7 +23,8 @@ struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 
 	vma->vm_start = start;
 	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
+	vma_set_pgoff(vma, pgoff);
+	vma_set_anon_pgoff(vma, start >> PAGE_SHIFT);
 	vma->flags = vma_flags;
 	vma_assert_detached(vma);
 
diff --git a/tools/testing/vma/tests/merge.c b/tools/testing/vma/tests/merge.c
index e357accc8499..48418b82b01d 100644
--- a/tools/testing/vma/tests/merge.c
+++ b/tools/testing/vma/tests/merge.c
@@ -45,6 +45,7 @@ void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
 	vmg->start = start;
 	vmg->end = end;
 	vmg->pgoff = pgoff;
+	vmg->anon_pgoff = start >> PAGE_SHIFT;
 	vmg->vma_flags = vma_flags;
 
 	vmg->just_expand = false;
@@ -108,6 +109,7 @@ static bool test_simple_merge(void)
 		.end = 0x2000,
 		.vma_flags = vma_flags,
 		.pgoff = 1,
+		.anon_pgoff = 1,
 	};
 
 	ASSERT_FALSE(attach_vma(&mm, vma_left));
@@ -1431,7 +1433,7 @@ static bool test_expand_only_mode(void)
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma_prev, *vma;
-	VMG_STATE(vmg, &mm, &vmi, 0x5000, 0x9000, vma_flags, 5);
+	VMG_STATE(vmg, &mm, &vmi, 0x5000, 0x9000, vma_flags, 5, 5);
 
 	/*
 	 * Place a VMA prior to the one we're expanding so we assert that we do
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 0d40d7ba2181..c8ef7b8cd46b 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -40,7 +40,7 @@ static bool test_copy_vma(void)
 	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, vma_flags);
 	vma_set_anonymous(vma);
 	vma_orig = vma;
-	vma_new = copy_vma(&vma, 0x2000, 0x1000, 1, &need_locks);
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 1, 1, &need_locks);
 	ASSERT_EQ(vma_new, vma_orig);
 	ASSERT_EQ(vma, vma_orig);
 	ASSERT_EQ(vma_new->vm_start, 0x1000);
@@ -53,7 +53,7 @@ static bool test_copy_vma(void)
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, vma_flags);
 	vma_set_anonymous(vma);
 	vma_orig = vma;
-	vma_new = copy_vma(&vma, 0x1000, 0x1000, 2, &need_locks);
+	vma_new = copy_vma(&vma, 0x1000, 0x1000, 2, 2, &need_locks);
 	ASSERT_EQ(vma_new, vma_orig);
 	ASSERT_EQ(vma, vma_orig);
 	ASSERT_EQ(vma_new->vm_start, 0x1000);
@@ -71,7 +71,7 @@ static bool test_copy_vma(void)
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vma_flags);
 	vma_set_anonymous(vma);
 	vma_orig = vma;
-	vma_new = copy_vma(&vma, 0x2000, 0x1000, 3, &need_locks);
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 3, 3, &need_locks);
 	ASSERT_NE(vma_new, vma_orig);
 	ASSERT_EQ(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0x1000);
@@ -82,7 +82,7 @@ static bool test_copy_vma(void)
 	/* Move backwards and do not merge. */
 
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vma_flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, 3, &need_locks);
 	ASSERT_NE(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0);
 	ASSERT_EQ(vma_new->vm_end, 0x2000);
@@ -95,7 +95,7 @@ static bool test_copy_vma(void)
 
 	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vma_flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vma_flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, 4, &need_locks);
 	vma_assert_attached(vma_new);
 
 	ASSERT_EQ(vma_new, vma_next);

-- 
2.55.0

