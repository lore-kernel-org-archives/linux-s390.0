Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1E427F99;
	Thu,  6 Aug 2026 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058868; cv=none; b=khcpbRH+3QYoyBQsAPuGYVOHZVewM1fTQXdCBoWWrzanpPv/p5yBdpLJkdJW60OIARih/HkrRT/nhIgd3B9Egurxeh1jsDBR9TEkQufni6U4gm0mdcsNxdhtx/jXJkJ58AUFHaK3qhuCxd/P7wgmL4SQYoMm2rGuinY/6pUUYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058868; c=relaxed/simple;
	bh=HNLYPEhcwPzVDIexJ+svtIUDx83mU1GNRxrBDoTFQtY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IbTDgWimgeU/8BlLxjJ2z3ks0bO8E+cgJXaBjvWC1v4lbDgefSo5QqT0AqTNmNm5quf+WZVt09QROiMEcEALCKHaqODL9RNwYeQozDMWCGO02KF0JpS1wf98ROaP7ujbK2EZDSArHZBZACjSJ4b3SAx7GVd4JJ7dmJliX/39IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uej4he46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uej4he46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F71F1F000E9;
	Thu,  6 Aug 2026 23:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786058863;
	bh=QOexAOdt39X5EbqgvgXRk/eJlkz/7TxkfO67E3zteA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Uej4he4633WD4YmmRYPxBhZbUVu2joNtnlrh86gmeFKohl0AkBu9Mv4CrN1y5BtOs
	 idRdaa0kzUQ/d8PkQhhzXkIJTVDdqSpdKmBcHxtQiu+uiriTlK0/ib9yuP1V17mv/K
	 YHolVuy50sNOkQ5j2uA1VyqXmXCqtkN59oXT9Oj0=
Date: Thu, 6 Aug 2026 16:27:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, Kees Cook
 <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, John
 Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park
 <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 00/20] mm/rmap: index MAP_PRIVATE file-backed folios
 by anonymous pgoff
Message-Id: <20260806162740.1d3d50dafd572445949a7f76@linux-foundation.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 21:21:25 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> In memory management we've managed to manufacture a great deal of confusion
> around the concept of anonymous memory. We have:
> 
> 1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
>    swap-backed (thus for reclaim purposes, treated as anonymous). These are
>    simple enough.
> 
> 2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
>    present in the page cache and mapped by an address_space object, but
>    whose folios are also swap-backed (thus treated as anonymous for reclaim
>    purposes).
> 
> 3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
>    vma->vm_file set, but which clears vma->vm_ops to satisfy
>    vma_is_anonymous(), resulting in VMAs that were mmap()'d referencing a
>    file, but are in every other sense anonymous, including the folios.
> 
> 4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
>    and have file-backed folios until CoW'd, at which point those CoW'd
>    folios are anonymous.
> 
> This series fixes issues 3 and 4.

Thanks, I've updated mm.git's mm-unstable branch to this version.

It's about 450 patches away from head-of-queue, so it will be a
second-week-of-merge-window thing.  Three weeks to go.

> v4:
> - Updated tags (thanks everyone!)
> - Adjusted some prose as per David.
> - Adjusted whitespace to 2 tabs in 2/15 as per David.
> - Improved linear_page_index(), __linear_anon_page_index() to be more
>   succinct in 2/15 as per David and updated commit message to reflect it.
> - Added commit to provide vma_[flags_]is_cow_mapping() - nearly all callers
>   are calling is_cow_mapping() as is_cow_mapping(vma->vm_flags) so just
>   provide a helper to do this for them.
> - In the same commit update all is_cow_mapping() callers and remove the
>   now-unused function.
> - Change linear_anon_page_index() to assert on !CoW mapping using
>   vma_is_cow_mapping() in 2/15 as per David.
> - Updated 4/15 to output index differently depending on whether the VMA is
>   a CoW mapping or not or whether the file index differs from the anon
>   index as per Gregory.
> - Updated 6/15 to change the 'update page offset' logic in copy_vma() to
>   not be gated on CoW or VMA_SHARED_BIT as discussed with David.
> - Updated 6/15 to improve the 'faulted in anon vma' assert stuff. It was
>   very unclear so rename the variable sensibly and update the comment.
> - Added a separate commit to fix the mess that is the faulted_in_anon_vma
>   and the VM_WARN_ON_ONCE_VMA() assert in copy_vma() - make it actually
>   only update the vmap in cases where the VMA was replaced (backwards
>   remap), update the checks to reflect this in a way that's actually
>   understandable and improve the comment.
> - Updated needs_adjacent_anon_gpoff() in 9/15 to use
>   vma_flags_is_cow_mapping() as per David. Updated the comment to reflect
>   it.
> - Broke out changes to vma_address_end() into a separate patch as per David.
> - Eliminated pgoff in vma_address_end() as it adds confusion - just use
>   pgoff_end, which was what pgoff used to be (confusingly).
> - Placed more variables in vma_address_end() as constants at the start of
>   the function.
> - Dropped KSM comment in 9/15 as per David.
> - Dropped linear_folio_page_index() patch altogether as per
>   David.
> - Realised all off uffd is only anon so use linear_anon_page_index()
>   throughout there and also the huge memory case for the same reason.
> - Added a patch to make remove_migration_pmd() accept a folio instead of a
>   page.
> - Added a patch to calculate large folio index using PFN as suggested by
>   David, eliminating the need for linear page index lookup at all.
> - Added a patch to add self merge VMA userland tests.

Well this grew up.  Here's how v4 altered mm.git:


 arch/s390/mm/gmap_helpers.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                |    4 
 drivers/gpu/drm/drm_gem_shmem_helper.c                 |    2 
 drivers/gpu/drm/panthor/panthor_gem.c                  |    2 
 drivers/gpu/drm/ttm/ttm_bo_vm.c                        |    2 
 drivers/gpu/drm/xe/xe_device.c                         |    2 
 fs/proc/task_mmu.c                                     |    2 
 include/linux/mm.h                                     |   61 ++---
 include/linux/mm_types.h                               |   12 -
 include/linux/pagemap.h                                |   61 +----
 include/linux/rmap.h                                   |    6 
 include/linux/swapops.h                                |    6 
 kernel/events/uprobes.c                                |    2 
 mm/gup.c                                               |    2 
 mm/huge_memory.c                                       |   27 +-
 mm/hugetlb.c                                           |    2 
 mm/internal.h                                          |   45 +--
 mm/interval_tree.c                                     |    4 
 mm/ksm.c                                               |    7 
 mm/memory.c                                            |   40 +--
 mm/mempolicy.c                                         |    2 
 mm/migrate.c                                           |   23 -
 mm/mremap.c                                            |    6 
 mm/rmap.c                                              |    8 
 mm/userfaultfd.c                                       |    6 
 mm/vma.c                                               |  118 +++++-----
 mm/vma.h                                               |   70 -----
 mm/vma_init.c                                          |    2 
 tools/testing/selftests/mm/merge.c                     |   10 
 tools/testing/selftests/proc/proc-self-map-files-001.c |    2 
 tools/testing/selftests/proc/proc-self-map-files-002.c |    2 
 tools/testing/vma/include/dup.h                        |   41 ++-
 tools/testing/vma/shared.c                             |    2 
 tools/testing/vma/tests/merge.c                        |   59 ++---
 tools/testing/vma/tests/mmap.c                         |    6 
 tools/testing/vma/tests/vma.c                          |   46 +++
 36 files changed, 337 insertions(+), 357 deletions(-)

--- a/arch/s390/mm/gmap_helpers.c~b
+++ a/arch/s390/mm/gmap_helpers.c
@@ -200,7 +200,7 @@ static int find_zeropage_pte_entry(pte_t
 		 * currently only works in COW mappings, which is also where
 		 * mm_forbids_zeropage() is checked.
 		 */
-		if (!is_cow_mapping(walk->vma->vm_flags))
+		if (!vma_is_cow_mapping(walk->vma))
 			return -EFAULT;
 
 		*found_addr = addr;
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c~b
+++ a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -377,9 +377,9 @@ static int amdgpu_gem_object_mmap(struct
 	/* Workaround for Thunk bug creating PROT_NONE,MAP_PRIVATE mappings
 	 * for debugger access to invisible VRAM. Should have used MAP_SHARED
 	 * instead. Clearing VM_MAYWRITE prevents the mapping from ever
-	 * becoming writable and makes is_cow_mapping(vm_flags) false.
+	 * becoming writable and makes vma_is_cow_mapping(vma) false.
 	 */
-	if (is_cow_mapping(vma->vm_flags) &&
+	if (vma_is_cow_mapping(vma) &&
 	    !(vma->vm_flags & VM_ACCESS_FLAGS))
 		vm_flags_clear(vma, VM_MAYWRITE);
 
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c~b
+++ a/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -753,7 +753,7 @@ int drm_gem_shmem_mmap(struct drm_gem_sh
 		return ret;
 	}
 
-	if (is_cow_mapping(vma->vm_flags))
+	if (vma_is_cow_mapping(vma))
 		return -EINVAL;
 
 	dma_resv_lock(shmem->base.resv, NULL);
--- a/drivers/gpu/drm/panthor/panthor_gem.c~b
+++ a/drivers/gpu/drm/panthor/panthor_gem.c
@@ -761,7 +761,7 @@ static int panthor_gem_mmap(struct drm_g
 		return ret;
 	}
 
-	if (is_cow_mapping(vma->vm_flags))
+	if (vma_is_cow_mapping(vma))
 		return -EINVAL;
 
 	if (!refcount_inc_not_zero(&bo->cmap.mmap_count)) {
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c~b
+++ a/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -489,7 +489,7 @@ static const struct vm_operations_struct
 int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
 {
 	/* Enforce no COW since would have really strange behavior with it. */
-	if (is_cow_mapping(vma->vm_flags))
+	if (vma_is_cow_mapping(vma))
 		return -EINVAL;
 
 	drm_gem_object_get(&bo->base);
--- a/drivers/gpu/drm/xe/xe_device.c~b
+++ a/drivers/gpu/drm/xe/xe_device.c
@@ -330,7 +330,7 @@ static int xe_pci_barrier_mmap(struct fi
 	if (vma->vm_end - vma->vm_start > SZ_4K)
 		return -EINVAL;
 
-	if (is_cow_mapping(vma->vm_flags))
+	if (vma_is_cow_mapping(vma))
 		return -EINVAL;
 
 	if (vma->vm_flags & (VM_READ | VM_EXEC))
--- a/fs/proc/task_mmu.c~b
+++ a/fs/proc/task_mmu.c
@@ -1693,7 +1693,7 @@ static inline bool pte_is_pinned(struct
 
 	if (!pte_write(pte))
 		return false;
-	if (!is_cow_mapping(vma->vm_flags))
+	if (!vma_is_cow_mapping(vma))
 		return false;
 	if (likely(!mm_flags_test(MMF_HAS_PINNED, vma->vm_mm)))
 		return false;
--- a/include/linux/mm.h~b
+++ a/include/linux/mm.h
@@ -2269,17 +2269,20 @@ void unpin_user_pages(struct page **page
 void unpin_user_folio(struct folio *folio, unsigned long npages);
 void unpin_folios(struct folio **folios, unsigned long nfolios);
 
-static inline bool is_cow_mapping(vm_flags_t flags)
+static inline bool vma_flags_is_cow_mapping(const vma_flags_t *flags)
 {
-	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
+	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
+		!vma_flags_test(flags, VMA_SHARED_BIT);
 }
 
-static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
+static inline bool vma_is_cow_mapping(const struct vm_area_struct *vma)
 {
-	const vma_flags_t *flags = &desc->vma_flags;
+	return vma_flags_is_cow_mapping(&vma->flags);
+}
 
-	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
-		!vma_flags_test(flags, VMA_SHARED_BIT);
+static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
+{
+	return vma_flags_is_cow_mapping(&desc->vma_flags);
 }
 
 #ifndef CONFIG_MMU
@@ -4391,62 +4394,62 @@ static inline pgoff_t vma_last_pgoff(con
 }
 
 /**
- * vma_start_virt_pgoff() - Get the virtual page offset of the start of @vma
- * @vma: The VMA whose virtual page offset is required.
+ * vma_start_anon_pgoff() - Get the anonymous page offset of the start of @vma
+ * @vma: The VMA whose anonymous page offset is required.
  *
  * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted then the
- * virtual page offset at the time of first fault.
+ * anonymous page offset at the time of first fault.
  *
  * If the VMA is anonymous, this returns the same value as vma_start_pgoff().
  *
  * This value is used for tracking MAP_PRIVATE file-backed mappings by their
- * virtual page offset.
+ * anonymous page offset.
  *
- * Returns: The virtual page offset of the start of @vma.
+ * Returns: The anonymous page offset of the start of @vma.
  */
-static inline pgoff_t vma_start_virt_pgoff(const struct vm_area_struct *vma)
+static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *vma)
 {
 	pgoff_t pgoff = 0;
 
 #ifdef CONFIG_64BIT
-	pgoff += vma->__vm_virt_pgoff_hi;
+	pgoff += vma->__vm_anon_pgoff_hi;
 	pgoff <<= 32;
 #endif
-	pgoff += vma->__vm_virt_pgoff_lo;
+	pgoff += vma->__vm_anon_pgoff_lo;
 	return pgoff;
 }
 
 /**
- * vma_end_virt_pgoff() - Get the virtual page offset of the exclusive end of
+ * vma_end_anon_pgoff() - Get the anonymous page offset of the exclusive end of
  * @vma.
- * @vma: The VMA whose end virtual page offset is required.
+ * @vma: The VMA whose end anonymous page offset is required.
  *
- * This returns the virtual exclusive end page offset of @vma, which is useful
+ * This returns the anonymous exclusive end page offset of @vma, which is useful
  * for expressing page offset ranges.
  *
- * See the description of vma_start_virt_pgoff() for a description of VMA
- * virtual page offsets.
+ * See the description of vma_start_anon_pgoff() for a description of VMA
+ * anonymous page offsets.
  *
- * Returns: The exclusive end virtual page offset of @vma.
+ * Returns: The exclusive end anonymous page offset of @vma.
  */
-static inline pgoff_t vma_end_virt_pgoff(const struct vm_area_struct *vma)
+static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vma)
 {
-	return vma_start_virt_pgoff(vma) + vma_pages(vma);
+	return vma_start_anon_pgoff(vma) + vma_pages(vma);
 }
 
 /**
- * vma_last_virt_pgoff() - Get the virtual page offset of the last page in
+ * vma_last_anon_pgoff() - Get the anonymous page offset of the last page in
  * @vma.
- * @vma: The VMA whose last virtual page offset is required.
+ * @vma: The VMA whose last anonymous page offset is required.
  *
- * See the description of vma_start_virt_pgoff() for a description of VMA
- * virtual page offsets.
+ * See the description of vma_start_anon_pgoff() for a description of VMA
+ * anonymous page offsets.
  *
- * Returns: The last virtual page offset of @vma.
+ * Returns: The last anonymous page offset of @vma.
  */
-static inline pgoff_t vma_last_virt_pgoff(const struct vm_area_struct *vma)
+static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *vma)
 {
-	return vma_end_virt_pgoff(vma) - 1;
+	return vma_end_anon_pgoff(vma) - 1;
 }
 
 static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
--- a/include/linux/mm_types.h~b
+++ a/include/linux/mm_types.h
@@ -968,10 +968,10 @@ struct vm_area_struct {
 	unsigned int vm_lock_seq;
 #endif
 	/*
-	 * Low 32-bits of virtual page offset.
-	 * See vma_start_virt_pgoff() comment for details.
+	 * Low 32-bits of anonymous page offset.
+	 * See vma_start_anon_pgoff() comment for details.
 	 */
-	unsigned int __vm_virt_pgoff_lo;
+	unsigned int __vm_anon_pgoff_lo;
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
 	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
@@ -1049,10 +1049,10 @@ struct vm_area_struct {
 #endif
 #ifdef CONFIG_64BIT
 	/*
-	 * High 32-bits of virtual page offset.
-	 * See vma_start_virt_pgoff() comment for details.
+	 * High 32-bits of anonymous page offset.
+	 * See vma_start_anon_pgoff() comment for details.
 	 */
-	unsigned int __vm_virt_pgoff_hi;
+	unsigned int __vm_anon_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
--- a/include/linux/pagemap.h~b
+++ a/include/linux/pagemap.h
@@ -1094,79 +1094,46 @@ static inline pgoff_t linear_page_delta(
 static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
 					const unsigned long address)
 {
-	pgoff_t pgoff;
-
-	pgoff = linear_page_delta(vma, address);
-	pgoff += vma_start_pgoff(vma);
-	return pgoff;
+	return linear_page_delta(vma, address) + vma_start_pgoff(vma);
 }
 
-static inline pgoff_t __linear_virt_page_index(const struct vm_area_struct *vma,
-					       const unsigned long address)
+static inline pgoff_t __linear_anon_page_index(const struct vm_area_struct *vma,
+		const unsigned long address)
 {
-	pgoff_t pgoff;
-
-	pgoff = linear_page_delta(vma, address);
-	pgoff += vma_start_virt_pgoff(vma);
-	return pgoff;
+	return linear_page_delta(vma, address) + vma_start_anon_pgoff(vma);
 }
 
 /**
- * linear_virt_page_index() - Determine the absolute virtual page offset of
+ * linear_anon_page_index() - Determine the absolute anonymous page offset of
  * @address within @vma.
  * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @address resides.
  * @address: The address whose absolute page offset is required.
  *
- * This returns the virtual page offset of @address, which is the page offset
+ * This returns the anonymous page offset of @address, which is the page offset
  * the address possessed at the time the VMA was first faulted.
  *
  * For anonymous mappings, this returns the same value as linear_page_index().
  *
- * For MAP_PRIVATE file-backed mappings, this returns the virtual page offset of
- * @address, which is the page offset the address possessed at the time the VMA
- * was first faulted.
+ * For MAP_PRIVATE file-backed mappings, this returns the anonymous page offset
+ * of @address, which is the page offset the address possessed at the time the
+ * VMA was first faulted.
  *
  * It is not valid to call this function for shared file-backed mappings.
  *
- * Returns: The absolute virtual page offset of @address within @vma.
+ * Returns: The absolute anonymous page offset of @address within @vma.
  */
-static inline pgoff_t linear_virt_page_index(const struct vm_area_struct *vma,
-					     const unsigned long address)
+static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
+		const unsigned long address)
 {
-	const pgoff_t pgoff = __linear_virt_page_index(vma, address);
+	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
 
-	VM_WARN_ON_ONCE(vma_test(vma, VMA_SHARED_BIT));
+	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
 	if (vma_is_anonymous(vma))
 		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
 
 	return pgoff;
 }
 
-/**
- * linear_folio_page_index() - Determine the absolute page offset of
- * @address within @vma from @folio.
- * @folio: The folio whose linear page index is sought.
- * @vma: The VMA in which @address resides.
- * @address: The address whose absolute page offset is required.
- *
- * Determines whether to obtain the virtual linear page index based on whether
- * @folio is anonymous or not.
- *
- * See the descriptions of linear_virt_page_index() and linear_page_index() for
- * details of each.
- *
- * Returns: The absolute page offset of @address within @vma.
- */
-static inline pgoff_t linear_folio_page_index(const struct folio *folio,
-					      const struct vm_area_struct *vma,
-					      const unsigned long address)
-{
-	if (folio_test_anon(folio))
-		return linear_virt_page_index(vma, address);
-
-	return linear_page_index(vma, address);
-}
-
 struct wait_page_key {
 	struct folio *folio;
 	int bit_nr;
--- a/include/linux/rmap.h~b
+++ a/include/linux/rmap.h
@@ -864,14 +864,14 @@ struct page *make_device_exclusive(struc
 struct page_vma_mapped_walk {
 	unsigned long pfn;
 	unsigned long nr_pages;
-	pgoff_t pgoff;
+	pgoff_t pgoff;	/* Only meaningful if nr_pages > 1 and not a KSM walk */
 	struct vm_area_struct *vma;
 	unsigned long address;
 	pmd_t *pmd;
 	pte_t *pte;
 	spinlock_t *ptl;
 	unsigned int flags;
-	bool is_anon_walk;
+	bool pgoff_is_anon : 1;
 };
 
 #define DEFINE_FOLIO_VMA_WALK(name, _folio, _vma, _address, _flags)	\
@@ -882,7 +882,7 @@ struct page_vma_mapped_walk {
 		.vma = _vma,						\
 		.address = _address,					\
 		.flags = _flags,					\
-		.is_anon_walk = folio_test_anon(_folio),		\
+		.pgoff_is_anon = folio_test_anon(_folio),		\
 	}
 
 static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
--- a/include/linux/swapops.h~b
+++ a/include/linux/swapops.h
@@ -325,8 +325,8 @@ struct page_vma_mapped_walk;
 extern int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page);
 
-extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
-		struct page *new);
+void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
+		struct folio *folio);
 
 extern void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd);
 
@@ -346,7 +346,7 @@ static inline int set_pmd_migration_entr
 }
 
 static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
-		struct page *new)
+		struct folio *folio)
 {
 	BUILD_BUG();
 }
--- a/kernel/events/uprobes.c~b
+++ a/kernel/events/uprobes.c
@@ -513,7 +513,7 @@ int uprobe_write(struct arch_uprobe *aup
 
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
-	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
+	if (WARN_ON_ONCE(!vma_is_cow_mapping(vma)))
 		return -EINVAL;
 
 	/*
--- a/mm/gup.c~b
+++ a/mm/gup.c
@@ -1236,7 +1236,7 @@ static int check_vma_flags(struct vm_are
 			 * Anon pages in shared mappings are surprising: now
 			 * just reject it.
 			 */
-			if (!is_cow_mapping(vm_flags))
+			if (!vma_is_cow_mapping(vma))
 				return -EFAULT;
 		}
 	} else if (!(vm_flags & VM_READ)) {
--- a/mm/huge_memory.c~b
+++ a/mm/huge_memory.c
@@ -1681,7 +1681,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+	BUG_ON((vma->vm_flags & VM_PFNMAP) && vma_is_cow_mapping(vma));
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
@@ -1789,7 +1789,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+	BUG_ON((vma->vm_flags & VM_PFNMAP) && vma_is_cow_mapping(vma));
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
@@ -1931,7 +1931,7 @@ int copy_huge_pmd(struct mm_struct *dst_
 		 * applied special bit, or we made the PRIVATE mapping be
 		 * able to wrongly write to the backend MMIO.
 		 */
-		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
+		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
 		goto set_pmd;
 	}
 
@@ -2052,7 +2052,7 @@ int copy_huge_pud(struct mm_struct *dst_
 	 * TODO: once we support anonymous pages, use
 	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
 	 */
-	if (is_cow_mapping(vma->vm_flags) && pud_write(pud)) {
+	if (vma_is_cow_mapping(vma) && pud_write(pud)) {
 		pudp_set_wrprotect(src_mm, addr, src_pud);
 		pud = pud_wrprotect(pud);
 	}
@@ -2930,8 +2930,7 @@ int move_pages_huge_pmd(struct mm_struct
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
-							   dst_addr);
+		src_folio->index = linear_anon_page_index(dst_vma, dst_addr);
 
 		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
@@ -5078,9 +5077,8 @@ int set_pmd_migration_entry(struct page_
 	return 0;
 }
 
-void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
+void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct folio *folio)
 {
-	struct folio *folio = page_folio(new);
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address = pvmw->address;
@@ -5116,11 +5114,9 @@ void remove_migration_pmd(struct page_vm
 		swp_entry_t entry;
 
 		if (pmd_write(pmde))
-			entry = make_writable_device_private_entry(
-							page_to_pfn(new));
+			entry = make_writable_device_private_entry(folio_pfn(folio));
 		else
-			entry = make_readable_device_private_entry(
-							page_to_pfn(new));
+			entry = make_readable_device_private_entry(folio_pfn(folio));
 		pmde = softleaf_to_pmd(entry);
 
 		if (pmd_swp_soft_dirty(*pvmw->pmd))
@@ -5135,11 +5131,12 @@ void remove_migration_pmd(struct page_vm
 		if (!softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
-		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
+		folio_add_anon_rmap_pmd(folio, &folio->page, vma, haddr, rmap_flags);
 	} else {
-		folio_add_file_rmap_pmd(folio, new, vma);
+		folio_add_file_rmap_pmd(folio, &folio->page, vma);
 	}
-	VM_BUG_ON(pmd_write(pmde) && folio_test_anon(folio) && !PageAnonExclusive(new));
+	VM_WARN_ON_ONCE(pmd_write(pmde) && folio_test_anon(folio) &&
+			!PageAnonExclusive(&folio->page));
 	set_pmd_at(mm, haddr, pvmw->pmd, pmde);
 
 	/* No need to invalidate - it was non-present before */
--- a/mm/hugetlb.c~b
+++ a/mm/hugetlb.c
@@ -4898,7 +4898,7 @@ int copy_hugetlb_page_range(struct mm_st
 	pte_t *src_pte, *dst_pte, entry;
 	struct folio *pte_folio;
 	unsigned long addr;
-	bool cow = is_cow_mapping(src_vma->vm_flags);
+	bool cow = vma_is_cow_mapping(src_vma);
 	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
--- a/mm/internal.h~b
+++ a/mm/internal.h
@@ -240,19 +240,18 @@ static inline int mmap_file(struct file
 {
 	int err = vfs_mmap(file, vma);
 
-	/* Hooks cannot mark themselves anonymous. */
-	if (WARN_ON_ONCE(vma_is_anonymous(vma)))
-		err = -EINVAL;
-
-	if (likely(!err))
-		return 0;
-
 	/*
-	 * OK, we tried to call the file hook for mmap(), but an error
-	 * arose. The mapping is in an inconsistent state and we must not invoke
-	 * any further hooks on it.
+	 * Either we tried to call the file hook for mmap() and an error arose
+	 * or a driver set vma->vm_ops = NULL intending there to be no VMA
+	 * operations.
+	 *
+	 * In the former case the VMA is in an inconsistent state and we mustn't
+	 * invoke any further hooks on it, in the latter case the hook actually
+	 * wanted no further hooks to be invoked, so fix both by setting dummy
+	 * VMA ops.
 	 */
-	vma->vm_ops = &vma_dummy_vm_ops;
+	if (unlikely(err || !vma->vm_ops))
+		vma->vm_ops = &vma_dummy_vm_ops;
 
 	return err;
 }
@@ -950,7 +949,7 @@ folio_within_range(struct folio *folio,
 
 	pgoff_folio = folio_pgoff(folio);
 	pgoff_vma_start = folio_test_anon(folio) ?
-		vma_start_virt_pgoff(vma) : vma_start_pgoff(vma);
+		vma_start_anon_pgoff(vma) : vma_start_pgoff(vma);
 
 	if (start < vma->vm_start)
 		start = vma->vm_start;
@@ -1064,20 +1063,20 @@ static inline unsigned long vma_fileback
  * vma_anon_address - Find the virtual address an anonymous page range is mapped
  * at.
  * @vma: The vma which maps this object.
- * @pgoff_virt: The virtual page index belonging to the folio.
+ * @pgoff_anon: The anonymous page index belonging to the folio.
  * @nr_pages: The number of pages to consider.
  *
  * This is only valid for anonymous or MAP_PRIVATE-mapped file-backed VMAs.
  *
- * Returns: If any page in this range is mapped by this VMA, return the first address
- * where any of these pages appear. Otherwise, return -EFAULT.
+ * Returns: If any page in this range is mapped by this VMA, return the first
+ * address where any of these pages appear. Otherwise, return -EFAULT.
  */
 static inline unsigned long vma_anon_address(const struct vm_area_struct *vma,
-		pgoff_t pgoff_virt, unsigned long nr_pages)
+		pgoff_t pgoff_anon, unsigned long nr_pages)
 {
-	VM_WARN_ON_ONCE(!vma_is_anonymous(vma) && vma_test(vma, VMA_SHARED_BIT));
+	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
 
-	return __vma_address(vma, pgoff_virt, vma_start_virt_pgoff(vma), nr_pages);
+	return __vma_address(vma, pgoff_anon, vma_start_anon_pgoff(vma), nr_pages);
 }
 
 /*
@@ -1086,22 +1085,20 @@ static inline unsigned long vma_anon_add
  */
 static inline unsigned long vma_address_end(struct page_vma_mapped_walk *pvmw)
 {
+	const pgoff_t pgoff_end = pvmw->pgoff + pvmw->nr_pages;
 	const struct vm_area_struct *vma = pvmw->vma;
-	const pgoff_t pgoff = pvmw->pgoff;
 	pgoff_t pgoff_vma_start;
 	unsigned long address;
-	pgoff_t pgoff_end;
 
 	/* Common case, plus ->pgoff is invalid for KSM */
 	if (pvmw->nr_pages == 1)
 		return pvmw->address + PAGE_SIZE;
 
-	if (pvmw->is_anon_walk)
-		pgoff_vma_start = vma_start_virt_pgoff(vma);
+	if (pvmw->pgoff_is_anon)
+		pgoff_vma_start = vma_start_anon_pgoff(vma);
 	else
 		pgoff_vma_start = vma_start_pgoff(vma);
 
-	pgoff_end = pgoff + pvmw->nr_pages;
 	address = vma->vm_start +
 		((pgoff_end - pgoff_vma_start) << PAGE_SHIFT);
 	/* Check for address beyond vma (or wrapped through 0?) */
@@ -1393,7 +1390,7 @@ static inline bool gup_must_unshare(stru
 		 * ... because we only care about writable private ("COW")
 		 * mappings where we have to break COW early.
 		 */
-		return is_cow_mapping(vma->vm_flags);
+		return vma_is_cow_mapping(vma);
 	}
 
 	/* Paired with a memory barrier in folio_try_share_anon_rmap_*(). */
--- a/mm/interval_tree.c~b
+++ a/mm/interval_tree.c
@@ -83,12 +83,12 @@ mapping_rmap_tree_iter_next(struct vm_ar
 
 static pgoff_t avc_start_pgoff(struct anon_vma_chain *avc)
 {
-	return vma_start_virt_pgoff(avc->vma);
+	return vma_start_anon_pgoff(avc->vma);
 }
 
 static pgoff_t avc_last_pgoff(struct anon_vma_chain *avc)
 {
-	return vma_last_virt_pgoff(avc->vma);
+	return vma_last_anon_pgoff(avc->vma);
 }
 
 INTERVAL_TREE_DEFINE(struct anon_vma_chain, rb, pgoff_t, rb_subtree_last,
--- a/mm/ksm.c~b
+++ a/mm/ksm.c
@@ -1625,8 +1625,7 @@ static int try_to_merge_with_ksm_page(st
 	 * stable_tree, break_cow() will clean it up.
 	 */
 	rmap_item->anon_vma = vma->anon_vma;
-	/* The VMA is always anon/MAP_PRIVATE-file backed so use anon index. */
-	rmap_item->linear_page_index = linear_virt_page_index(vma, rmap_item->address);
+	rmap_item->linear_page_index = linear_anon_page_index(vma, rmap_item->address);
 	get_anon_vma(vma->anon_vma);
 out:
 	mmap_read_unlock(mm);
@@ -3153,7 +3152,7 @@ struct folio *ksm_might_need_to_copy(str
 			return folio;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return folio;		/* no need to copy it */
-	} else if (folio->index == linear_virt_page_index(vma, addr) &&
+	} else if (folio->index == linear_anon_page_index(vma, addr) &&
 			anon_vma->root == vma->anon_vma->root) {
 		return folio;		/* still no need to copy it */
 	}
@@ -3223,7 +3222,7 @@ again:
 		/*
 		 * Currently, KSM folios are always small folios, so it's
 		 * sufficient to search for a single page. We can simply use
-		 * the linear_virt_page_index of the original de-duplicate
+		 * the linear_anon_page_index of the original de-duplicate
 		 * anonymous page that we remembered in the rmap_item while
 		 * de-duplicating. Note that mremap() always de-duplicates KSM
 		 * folios: so if there was mremap() in our parent or our child,
--- a/mm/memory.c~b
+++ a/mm/memory.c
@@ -631,14 +631,14 @@ static void print_bad_page_map(struct vm
 {
 	struct address_space *mapping;
 	char entry_str[PTVAL_STR_MAX];
-	pgoff_t index, virt_index;
+	pgoff_t index, anon_index;
 
 	if (is_bad_page_map_ratelimited())
 		return;
 
 	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 	index = linear_page_index(vma, addr);
-	virt_index = __linear_virt_page_index(vma, addr);
+	anon_index = __linear_anon_page_index(vma, addr);
 
 	ptval_bytes_to_hex_str(entry_str, sizeof(entry_str), entry, entry_size);
 	pr_alert("BUG: Bad page map in process %s  %s:%s", current->comm,
@@ -646,9 +646,14 @@ static void print_bad_page_map(struct vm
 	__print_bad_page_map_pgtable(vma->vm_mm, addr);
 	if (page)
 		dump_page(page, "bad page map");
-	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx virt_index:%lx\n",
-		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index,
-		 virt_index);
+	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px",
+		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping);
+	if (!vma_is_cow_mapping(vma) || index == anon_index) {
+		pr_cont(" index:%lx\n", index);
+	} else {
+		pr_cont(" index:%lx (file) %lx (anon)\n", index, anon_index);
+	}
+
 	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
@@ -782,7 +787,7 @@ static inline struct page *__vm_normal_p
 				/* Only CoW'ed anon folios are "normal". */
 				if (pfn == index)
 					return NULL;
-				if (!is_cow_mapping(vma->vm_flags))
+				if (!vma_is_cow_mapping(vma))
 					return NULL;
 			}
 		}
@@ -1004,7 +1009,6 @@ copy_nonpresent_pte(struct mm_struct *ds
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
 {
-	vm_flags_t vm_flags = dst_vma->vm_flags;
 	pte_t orig_pte = ptep_get(src_pte);
 	softleaf_t entry = softleaf_from_pte(orig_pte);
 	pte_t pte = orig_pte;
@@ -1028,7 +1032,7 @@ copy_nonpresent_pte(struct mm_struct *ds
 		rss[mm_counter(folio)]++;
 
 		if (!softleaf_is_migration_read(entry) &&
-				is_cow_mapping(vm_flags)) {
+				vma_is_cow_mapping(dst_vma)) {
 			/*
 			 * COW mappings require pages in both parent and child
 			 * to be set to read. A previously exclusive entry is
@@ -1069,7 +1073,7 @@ copy_nonpresent_pte(struct mm_struct *ds
 		 * save and restore device driver state).
 		 */
 		if (softleaf_is_device_private_write(entry) &&
-		    is_cow_mapping(vm_flags)) {
+		    vma_is_cow_mapping(dst_vma)) {
 			entry = make_readable_device_private_entry(
 							swp_offset(entry));
 			pte = swp_entry_to_pte(entry);
@@ -1084,7 +1088,7 @@ copy_nonpresent_pte(struct mm_struct *ds
 		 * exclusive entries currently only support private writable
 		 * (ie. COW) mappings.
 		 */
-		VM_BUG_ON(!is_cow_mapping(src_vma->vm_flags));
+		VM_BUG_ON(!vma_is_cow_mapping(src_vma));
 		if (try_restore_exclusive_pte(src_vma, addr, src_pte, orig_pte))
 			return -EBUSY;
 		return -ENOENT;
@@ -1183,7 +1187,7 @@ static __always_inline void __copy_prese
 	}
 
 	/* If it's a COW mapping, write protect it both processes. */
-	if (is_cow_mapping(src_vma->vm_flags) && writable) {
+	if (vma_is_cow_mapping(src_vma) && writable) {
 		wrprotect_ptes(src_mm, addr, src_pte, nr);
 		pte = pte_wrprotect(pte);
 	}
@@ -1604,9 +1608,9 @@ copy_page_range(struct vm_area_struct *d
 	 * We need to invalidate the secondary MMU mappings only when
 	 * there could be a permission downgrade on the ptes of the
 	 * parent mm. And a permission downgrade will only happen if
-	 * is_cow_mapping() returns true.
+	 * vma_is_cow_mapping() returns true.
 	 */
-	is_cow = is_cow_mapping(src_vma->vm_flags);
+	is_cow = vma_is_cow_mapping(src_vma);
 
 	if (is_cow) {
 		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
@@ -2439,7 +2443,7 @@ static bool vm_mixed_zeropage_allowed(st
 	if (mm_forbids_zeropage(vma->vm_mm))
 		return false;
 	/* zeropages in COW mappings are common and unproblematic. */
-	if (is_cow_mapping(vma->vm_flags))
+	if (vma_is_cow_mapping(vma))
 		return true;
 	/* Mappings that do not allow for writable PTEs are unproblematic. */
 	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
@@ -2890,7 +2894,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+	BUG_ON((vma->vm_flags & VM_PFNMAP) && vma_is_cow_mapping(vma));
 	BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn));
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
@@ -3302,7 +3306,7 @@ static int remap_pfn_range_prepare_vma(s
 				       unsigned long size)
 {
 	const unsigned long end = addr + PAGE_ALIGN(size);
-	const bool is_cow = is_cow_mapping(vma->vm_flags);
+	const bool is_cow = vma_is_cow_mapping(vma);
 	int err;
 
 	err = get_remap_pgoff(is_cow, addr, end, vma->vm_start, vma->vm_end,
@@ -6802,7 +6806,7 @@ static vm_fault_t sanitize_fault_flags(s
 		 * FAULT_FLAG_UNSHARE only applies to COW mappings. Let's
 		 * just treat it like an ordinary read-fault otherwise.
 		 */
-		if (!is_cow_mapping(vma->vm_flags))
+		if (!vma_is_cow_mapping(vma))
 			*flags &= ~FAULT_FLAG_UNSHARE;
 	} else if (*flags & FAULT_FLAG_WRITE) {
 		/* Write faults on read-only mappings are impossible ... */
@@ -6810,7 +6814,7 @@ static vm_fault_t sanitize_fault_flags(s
 			return VM_FAULT_SIGSEGV;
 		/* ... and FOLL_FORCE only applies to COW mappings. */
 		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE) &&
-				 !is_cow_mapping(vma->vm_flags)))
+				 !vma_is_cow_mapping(vma)))
 			return VM_FAULT_SIGSEGV;
 	}
 #ifdef CONFIG_PER_VMA_LOCK
--- a/mm/mempolicy.c~b
+++ a/mm/mempolicy.c
@@ -844,7 +844,7 @@ bool folio_can_map_prot_numa(struct foli
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-	if (is_cow_mapping(vma->vm_flags) && folio_maybe_mapped_shared(folio))
+	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
 		return false;
 
 	/* Folios are pinned and can't be migrated */
--- a/mm/migrate.c~b
+++ a/mm/migrate.c
@@ -356,25 +356,18 @@ static bool remove_migration_pte(struct
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
-		pte_t old_pte;
-		pte_t pte;
+		unsigned long idx = 0;
 		softleaf_t entry;
 		struct page *new;
-		unsigned long idx = 0;
-
-		/* pgoff is invalid for ksm pages, but they are never large */
-		if (folio_test_large(folio) && !folio_test_hugetlb(folio)) {
-			idx += linear_folio_page_index(folio, vma, pvmw.address);
-			idx -= pvmw.pgoff;
-		}
-		new = folio_page(folio, idx);
+		pte_t old_pte;
+		pte_t pte;
 
 #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
 		/* PMD-mapped THP migration entry */
 		if (!pvmw.pte) {
 			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
 					!folio_test_pmd_mappable(folio), folio);
-			remove_migration_pmd(&pvmw, new);
+			remove_migration_pmd(&pvmw, folio);
 			continue;
 		}
 #endif
@@ -383,14 +376,18 @@ static bool remove_migration_pte(struct
 						pvmw.pte);
 		else
 			old_pte = ptep_get(pvmw.pte);
+
+		entry = softleaf_from_pte(old_pte);
+		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+			idx = softleaf_to_pfn(entry) - pvmw.pfn;
+
 		if (rmap_walk_arg->map_unused_to_zeropage &&
 		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
 
 		folio_get(folio);
+		new = folio_page(folio, idx);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-
-		entry = softleaf_from_pte(old_pte);
 		if (!softleaf_is_migration_young(entry))
 			pte = pte_mkold(pte);
 		if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
--- a/mm/mremap.c~b
+++ a/mm/mremap.c
@@ -1266,8 +1266,8 @@ static int copy_vma_and_data(struct vma_
 			     struct vm_area_struct **new_vma_ptr)
 {
 	const pgoff_t new_pgoff = linear_page_index(vrm->vma, vrm->addr);
-	const pgoff_t new_virt_pgoff =
-		__linear_virt_page_index(vrm->vma, vrm->addr);
+	const pgoff_t new_anon_pgoff =
+		__linear_anon_page_index(vrm->vma, vrm->addr);
 	struct vm_area_struct *vma = vrm->vma;
 	struct vm_area_struct *new_vma;
 	unsigned long moved_len;
@@ -1275,7 +1275,7 @@ static int copy_vma_and_data(struct vma_
 	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
 
 	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   new_virt_pgoff, &pmc.need_rmap_locks);
+			   new_anon_pgoff, &pmc.need_rmap_locks);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
--- a/mm/rmap.c~b
+++ a/mm/rmap.c
@@ -1240,7 +1240,7 @@ static bool mapping_wrprotect_range_one(
 		.vma		= vma,
 		.address	= address,
 		.flags		= PVMW_SYNC,
-		.is_anon_walk   = false,
+		.pgoff_is_anon	= false,
 	};
 
 	state->cleaned += page_vma_mkclean_one(&pvmw);
@@ -1318,7 +1318,7 @@ int pfn_mkclean_range(unsigned long pfn,
 		.pgoff		= pgoff,
 		.vma		= vma,
 		.flags		= PVMW_SYNC,
-		.is_anon_walk   = false,
+		.pgoff_is_anon	= false,
 	};
 
 	if (invalid_mkclean_vma(vma, NULL))
@@ -1485,7 +1485,7 @@ static void __folio_set_anon(struct foli
 	 */
 	anon_vma = (void *) anon_vma + FOLIO_MAPPING_ANON;
 	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
-	folio->index = linear_virt_page_index(vma, address);
+	folio->index = linear_anon_page_index(vma, address);
 }
 
 /**
@@ -1513,7 +1513,7 @@ static void __page_check_anon_rmap(const
 	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
 			folio);
 	VM_BUG_ON_PAGE(page_pgoff(folio, page) !=
-		       linear_virt_page_index(vma, address), page);
+		       linear_anon_page_index(vma, address), page);
 }
 
 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
--- a/mm/userfaultfd.c~b
+++ a/mm/userfaultfd.c
@@ -1352,8 +1352,7 @@ static long move_present_ptes(struct mm_
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
-							   dst_addr);
+		src_folio->index = linear_anon_page_index(dst_vma, dst_addr);
 
 		orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 		/* Set soft dirty bit so userspace can notice the pte was moved */
@@ -1429,8 +1428,7 @@ static int move_swap_pte(struct mm_struc
 	 */
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
-							   dst_addr);
+		src_folio->index = linear_anon_page_index(dst_vma, dst_addr);
 	} else {
 		/*
 		 * Check if the swap entry is cached after acquiring the src_pte
--- a/mm/vma.c~b
+++ a/mm/vma.c
@@ -18,7 +18,7 @@ struct mmap_state {
 	unsigned long addr;
 	unsigned long end;
 	pgoff_t pgoff;
-	pgoff_t virt_pgoff;
+	pgoff_t anon_pgoff;
 	unsigned long pglen;
 	union {
 		vm_flags_t vm_flags;
@@ -47,22 +47,14 @@ struct mmap_state {
 	bool file_doesnt_need_get :1;
 };
 
-static inline pgoff_t map_anon_pgoff(const struct mmap_state *map)
-{
-	if (vma_flags_test(&map->vma_flags, VMA_SHARED_BIT))
-		return map->pgoff;
-
-	return map->virt_pgoff;
-}
-
-#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, virt_pgoff_, vma_flags_, file_) \
+#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, anon_pgoff_, vma_flags_, file_) \
 	struct mmap_state name = {					\
 		.mm = mm_,						\
 		.vmi = vmi_,						\
 		.addr = addr_,						\
 		.end = (addr_) + (len_),				\
 		.pgoff = pgoff_,					\
-		.virt_pgoff = virt_pgoff_,				\
+		.anon_pgoff = anon_pgoff_,				\
 		.pglen = PHYS_PFN(len_),				\
 		.vma_flags = vma_flags_,				\
 		.file = file_,						\
@@ -77,7 +69,7 @@ static inline pgoff_t map_anon_pgoff(con
 		.end = (map_)->end,					\
 		.vma_flags = (map_)->vma_flags,				\
 		.pgoff = (map_)->pgoff,					\
-		.anon_pgoff = map_anon_pgoff(map_),			\
+		.anon_pgoff = (map_)->anon_pgoff,			\
 		.file = (map_)->file,					\
 		.prev = (map_)->prev,					\
 		.middle = vma_,						\
@@ -93,11 +85,11 @@ static void __vma_set_range(struct vm_ar
 }
 
 static void vma_set_range(struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, pgoff_t pgoff, pgoff_t virt_pgoff)
+			  unsigned long end, pgoff_t pgoff, pgoff_t anon_pgoff)
 {
 	__vma_set_range(vma, start, end);
 	vma_set_pgoff(vma, pgoff);
-	vma_set_virt_pgoff(vma, virt_pgoff);
+	vma_set_anon_pgoff(vma, anon_pgoff);
 }
 
 /* Was this VMA ever forked from a parent, i.e. maybe contains CoW mappings? */
@@ -213,6 +205,25 @@ static void init_multi_vma_prep(struct v
 }
 
 /*
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
+/*
  * Return true if we can merge this (vma_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
  *
@@ -233,7 +244,8 @@ static bool can_vma_merge_before(struct
 		return false;
 	if (vmg_end_pgoff(vmg) != vma_start_pgoff(vmg->next))
 		return false;
-	if (vmg_end_anon_pgoff(vmg) != vma_start_anon_pgoff(vmg->next))
+	if (needs_adjacent_anon_pgoff(vmg) &&
+	    vmg_end_anon_pgoff(vmg) != vma_start_anon_pgoff(vmg->next))
 		return false;
 	return true;
 }
@@ -255,7 +267,8 @@ static bool can_vma_merge_after(struct v
 		return false;
 	if (vma_end_pgoff(vmg->prev) != vmg_start_pgoff(vmg))
 		return false;
-	if (vma_end_anon_pgoff(vmg->prev) != vmg_start_anon_pgoff(vmg))
+	if (needs_adjacent_anon_pgoff(vmg) &&
+	    vma_end_anon_pgoff(vmg->prev) != vmg_start_anon_pgoff(vmg))
 		return false;
 	return true;
 }
@@ -1930,27 +1943,27 @@ static int vma_link(struct mm_struct *mm
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	pgoff_t virt_pgoff, bool *need_rmap_locks)
+	pgoff_t anon_pgoff, bool *need_rmap_locks)
 {
 	struct vm_area_struct *vma = *vmap;
-	const bool is_shared = vma_test(vma, VMA_SHARED_BIT);
-	unsigned long vma_start = vma->vm_start;
+	unsigned long old_vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma;
-	bool faulted_in_anon_vma = true;
+	bool can_self_merge = false;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
 
 	/*
-	 * If a vma has not yet been faulted, update its virtual pgoff to match
-	 * the new location to increase its chance of merging.
+	 * If a vma has not yet been faulted, update its anonymous pgoff to
+	 * match the new location to increase its chance of merging.
 	 */
-	if (!vma->anon_vma && !is_shared) {
-		virt_pgoff = addr >> PAGE_SHIFT;
+	if (!vma->anon_vma) {
+		anon_pgoff = addr >> PAGE_SHIFT;
 
-		if (vma_is_anonymous(vma))
-			pgoff = virt_pgoff;
-		faulted_in_anon_vma = false;
+		if (vma_is_anonymous(vma)) {
+			pgoff = anon_pgoff;
+			can_self_merge = true;
+		}
 	}
 
 	/*
@@ -1966,39 +1979,35 @@ struct vm_area_struct *copy_vma(struct v
 		return NULL;	/* should never get here */
 
 	vmg.pgoff = pgoff;
-	vmg.anon_pgoff = is_shared ? pgoff : virt_pgoff;
+	vmg.anon_pgoff = anon_pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
 	new_vma = vma_merge_copied_range(&vmg);
 
 	if (new_vma) {
-		/*
-		 * Source vma may have been merged into new_vma
-		 */
-		if (unlikely(vma_start >= new_vma->vm_start &&
-			     vma_start < new_vma->vm_end)) {
+		/* Self-merged and VMA replaced. */
+		if (unlikely(new_vma->vm_start < old_vma_start &&
+			     new_vma->vm_end > old_vma_start)) {
 			/*
-			 * The only way we can get a vma_merge with
-			 * self during an mremap is if the vma hasn't
-			 * been faulted in yet and we were allowed to
-			 * reset the dst vma->vm_pgoff to the
-			 * destination address of the mremap to allow
-			 * the merge to happen. mremap must change the
-			 * vm_pgoff linearity between src and dst vmas
-			 * (in turn preventing a vma_merge) to be
-			 * safe. It is only safe to keep the vm_pgoff
-			 * linear if there are no pages mapped yet.
+			 * The only way a VMA can both self-merge and be
+			 * replaced is if the remap places the new VMA
+			 * immediately prior to its old self ('next') and
+			 * immediately after another VMA ('prev') causing the
+			 * next to be removed and prev to be expanded to cover
+			 * the entire range.
+			 *
+			 * This should only be possible if the anonymous page
+			 * offset was updated, i.e. the VMA is unfaulted.
 			 */
-			VM_WARN_ON_ONCE_VMA(faulted_in_anon_vma, new_vma);
+			VM_WARN_ON_ONCE_VMA(!can_self_merge, new_vma);
 			*vmap = vma = new_vma;
 		}
 		*need_rmap_locks =
-			(vma_start_pgoff(new_vma) <= vma_start_pgoff(vma)) ||
-			(vma_start_anon_pgoff(new_vma) <= vma_start_anon_pgoff(vma));
+			(vma_start_pgoff(new_vma) <= vma_start_pgoff(vma));
 	} else {
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
 			goto out;
-		vma_set_range(new_vma, addr, addr + len, pgoff, virt_pgoff);
+		vma_set_range(new_vma, addr, addr + len, pgoff, anon_pgoff);
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
 		if (anon_vma_clone(new_vma, vma, VMA_OP_REMAP))
@@ -2066,7 +2075,7 @@ static int anon_vma_compatible(struct vm
 	/* Page offset must align. */
 	if (vma_end_pgoff(a) != vma_start_pgoff(b))
 		return false;
-	/* Anon page offset must align. */
+	/* Only reached from anon path, so either MAP_PRIVATE file or anon. */
 	if (vma_end_anon_pgoff(a) != vma_start_anon_pgoff(b))
 		return false;
 	return true;
@@ -2615,8 +2624,11 @@ static int __mmap_new_file_vma(struct mm
 static bool map_is_dev_zero(const struct mmap_state *map)
 {
 	const struct file *file = map->file;
-	const struct inode *inode = file_inode(file);
+	struct inode *inode;
 
+	if (!file)
+		return false;
+	inode = file_inode(file);
 	if (!S_ISCHR(inode->i_mode))
 		return false;
 	return imajor(inode) == MEM_MAJOR && iminor(inode) == DEVZERO_MINOR;
@@ -2671,7 +2683,7 @@ static int __mmap_new_vma(struct mmap_st
 	if (is_anon)
 		vma_set_anonymous(vma);
 
-	vma_set_range(vma, map->addr, map->end, map->pgoff, map->virt_pgoff);
+	vma_set_range(vma, map->addr, map->end, map->pgoff, map->anon_pgoff);
 	vma->flags = map->vma_flags;
 	vma->vm_page_prot = map->page_prot;
 
@@ -2869,8 +2881,8 @@ static unsigned long __mmap_region(struc
 	struct vm_area_struct *vma = NULL;
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
-	const pgoff_t virt_pgoff = addr >> PAGE_SHIFT;
-	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, virt_pgoff, vma_flags, file);
+	const pgoff_t anon_pgoff = addr >> PAGE_SHIFT;
+	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags, file);
 	struct vm_area_desc desc = {
 		.mm = mm,
 		.file = file,
@@ -3452,7 +3464,7 @@ int insert_vm_struct(struct mm_struct *m
 		WARN_ON_ONCE(vma->anon_vma);
 		vma_set_pgoff(vma, vma->vm_start >> PAGE_SHIFT);
 	}
-	vma_set_virt_pgoff(vma, vma->vm_start >> PAGE_SHIFT);
+	vma_set_anon_pgoff(vma, vma->vm_start >> PAGE_SHIFT);
 
 	if (vma_link(mm, vma)) {
 		if (vma_test(vma, VMA_ACCOUNT_BIT))
--- a/mm/vma.h~b
+++ a/mm/vma.h
@@ -291,86 +291,32 @@ static inline pgoff_t vmg_end_anon_pgoff
 	return vmg_start_anon_pgoff(vmg) + vmg_pages(vmg);
 }
 
-static inline void __vma_set_virt_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 {
 #ifdef CONFIG_64BIT
-	vma->__vm_virt_pgoff_hi = pgoff >> 32;
+	vma->__vm_anon_pgoff_hi = pgoff >> 32;
 #endif
-	vma->__vm_virt_pgoff_lo = pgoff & GENMASK(31, 0);
+	vma->__vm_anon_pgoff_lo = pgoff & GENMASK(31, 0);
 }
 
-static inline void vma_set_virt_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+static inline void vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 {
 	vma_assert_can_modify(vma);
-	__vma_set_virt_pgoff(vma, pgoff);
+	__vma_set_anon_pgoff(vma, pgoff);
 }
 
 static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t delta)
 {
 	vma_assert_can_modify(vma);
 	vma_set_pgoff(vma, vma_start_pgoff(vma) + delta);
-	vma_set_virt_pgoff(vma, vma_start_virt_pgoff(vma) + delta);
+	vma_set_anon_pgoff(vma, vma_start_anon_pgoff(vma) + delta);
 }
 
 static inline void vma_sub_pgoff(struct vm_area_struct *vma, pgoff_t delta)
 {
 	vma_assert_can_modify(vma);
 	vma_set_pgoff(vma, vma_start_pgoff(vma) - delta);
-	vma_set_virt_pgoff(vma, vma_start_virt_pgoff(vma) - delta);
-}
-
-/**
- * vma_anon_pgoff_addr() - Calculates the absolute anonymous page offset of
- * @address.
- * @vma: The VMA whose anonymous page offset is required.
- * @address: The address whose absolute page offset is required.
- *
- * If the VMA is a shared file-backed mapping, then the file-based page offset
- * is returned.
- *
- * Otherwise, the virtual page offset is returned.
- *
- * This means that shared file-backed mappings are correctly merged based on
- * their file page offset compatibility.
- *
- * Returns: The absolute anonymous page offset of @address within @vma.
- */
-static inline pgoff_t vma_anon_pgoff_addr(const struct vm_area_struct *vma,
-					  unsigned long address)
-{
-	if (vma_test(vma, VMA_SHARED_BIT))
-		return linear_page_index(vma, address);
-
-	return linear_virt_page_index(vma, address);
-}
-
-/**
- * vma_start_anon_pgoff() - Calculates the absolute anonymous page offset used
- * for purposes of merge compatibility.
- * @vma: The VMA whose anonymous page offset is required.
- *
- * See vma_anon_pgoff_addr().
- *
- * Returns: The absolute anonymous page offset of @vma for purposes of merging.
- */
-static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *vma)
-{
-	return vma_anon_pgoff_addr(vma, vma->vm_start);
-}
-
-/**
- * vma_end_anon_pgoff() - Calculates the absolute exclusive end anonymous page
- * offset used for purposes of merge compatibility.
- * @vma: The VMA whose anonymous end page offset is required.
- *
- * See vma_start_anon_pgoff().
- *
- * Returns: The absolute exclusive end anonymous page offset of @vma for
- * purposes of merging.
- */
-static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vma)
-{
-	return vma_start_anon_pgoff(vma) + vma_pages(vma);
+	vma_set_anon_pgoff(vma, vma_start_anon_pgoff(vma) - delta);
 }
 
 #define VMG_STATE(name, mm_, vmi_, start_, end_, vma_flags_, pgoff_, anon_pgoff_) \
@@ -396,7 +342,7 @@ static inline pgoff_t vma_end_anon_pgoff
 		.end = end_,						\
 		.vm_flags = vma_->vm_flags,				\
 		.pgoff = linear_page_index(vma_, start_),		\
-		.anon_pgoff = vma_anon_pgoff_addr(vma_, start_),	\
+		.anon_pgoff = __linear_anon_page_index(vma_, start_),	\
 		.file = vma_->vm_file,					\
 		.anon_vma = vma_->anon_vma,				\
 		.policy = vma_policy(vma_),				\
--- a/mm/vma_init.c~b
+++ a/mm/vma_init.c
@@ -51,7 +51,7 @@ static void vm_area_init_from(const stru
 	dest->vm_end = src->vm_end;
 	dest->anon_vma = src->anon_vma;
 	dest->vm_pgoff = vma_start_pgoff(src);
-	__vma_set_virt_pgoff(dest, vma_start_virt_pgoff(src));
+	__vma_set_anon_pgoff(dest, vma_start_anon_pgoff(src));
 	dest->vm_file = src->vm_file;
 	dest->vm_private_data = src->vm_private_data;
 	vm_flags_init(dest, src->vm_flags);
--- a/tools/testing/selftests/mm/merge.c~b
+++ a/tools/testing/selftests/mm/merge.c
@@ -1305,7 +1305,7 @@ TEST_F(merge, merge_vmas_with_mseal)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
 }
 
-TEST_F(merge, virt_and_page_offset_mismatch_memfd)
+TEST_F(merge, anon_and_page_offset_mismatch_memfd)
 {
 	struct procmap_fd *procmap = &self->procmap;
 	unsigned int page_size = self->page_size;
@@ -1314,7 +1314,7 @@ TEST_F(merge, virt_and_page_offset_misma
 	int fd;
 
 	/* Create a 10 page memfd descriptor. */
-	fd = memfd_create("virt_page_offset_test", MFD_CLOEXEC);
+	fd = memfd_create("anon_page_offset_test", MFD_CLOEXEC);
 	ASSERT_NE(fd, -1);
 	ASSERT_EQ(ftruncate(fd, 10 * page_size), 0);
 
@@ -1346,10 +1346,10 @@ TEST_F(merge, virt_and_page_offset_misma
 	 * | unfaulted |           | faulted |
 	 * |-----------|           |---------|
 	 *
-	 * Because virtual page offset of the faulted region is now
+	 * Because the anonymous page offset of the faulted region is now
 	 * &carveout[10 * page_size], despite the two regions being mergeable
-	 * due to file page offset, they are NOT mergeable due to virtual page
-	 * offset.
+	 * due to file page offset, they are NOT mergeable due to anonymous
+	 * page offset.
 	 */
 	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
 			  MREMAP_MAYMOVE | MREMAP_FIXED,
--- a/tools/testing/selftests/proc/proc-self-map-files-001.c~b
+++ a/tools/testing/selftests/proc/proc-self-map-files-001.c
@@ -51,7 +51,7 @@ int main(void)
 	int fd;
 	unsigned long a, b;
 
-	fd = open("/dev/zero", O_RDONLY);
+	fd = open("/proc/self/exe", O_RDONLY);
 	if (fd == -1)
 		return 1;
 
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c~b
+++ a/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -57,7 +57,7 @@ int main(void)
 	int fd;
 	unsigned long a, b;
 
-	fd = open("/dev/zero", O_RDONLY);
+	fd = open("/proc/self/exe", O_RDONLY);
 	if (fd == -1)
 		return 1;
 
--- a/tools/testing/vma/include/dup.h~b
+++ a/tools/testing/vma/include/dup.h
@@ -599,7 +599,7 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
-	unsigned int __vm_virt_pgoff_lo;
+	unsigned int __vm_anon_pgoff_lo;
 
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
@@ -637,7 +637,7 @@ struct vm_area_struct {
 	refcount_t vm_refcnt;
 #endif
 #ifdef CONFIG_64BIT
-	unsigned int __vm_virt_pgoff_hi;
+	unsigned int __vm_anon_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
@@ -1184,6 +1184,17 @@ static inline bool vma_is_shared_maywrit
 	return is_shared_maywrite(&vma->flags);
 }
 
+static inline bool vma_flags_is_cow_mapping(const vma_flags_t *flags)
+{
+	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
+		!vma_flags_test(flags, VMA_SHARED_BIT);
+}
+
+static inline bool vma_is_cow_mapping(const struct vm_area_struct *vma)
+{
+	return vma_flags_is_cow_mapping(&vma->flags);
+}
+
 static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 {
 	/*
@@ -1346,26 +1357,26 @@ static inline pgoff_t vma_end_pgoff(cons
 	return vma_start_pgoff(vma) + vma_pages(vma);
 }
 
-static inline pgoff_t vma_start_virt_pgoff(const struct vm_area_struct *vma)
+static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *vma)
 {
 	pgoff_t pgoff = 0;
 
 #ifdef CONFIG_64BIT
-	pgoff += vma->__vm_virt_pgoff_hi;
+	pgoff += vma->__vm_anon_pgoff_hi;
 	pgoff <<= 32;
 #endif
-	pgoff += vma->__vm_virt_pgoff_lo;
+	pgoff += vma->__vm_anon_pgoff_lo;
 	return pgoff;
 }
 
-static inline pgoff_t vma_end_virt_pgoff(const struct vm_area_struct *vma)
+static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vma)
 {
-	return vma_start_virt_pgoff(vma) + vma_pages(vma);
+	return vma_start_anon_pgoff(vma) + vma_pages(vma);
 }
 
-static inline pgoff_t vma_last_virt_pgoff(const struct vm_area_struct *vma)
+static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *vma)
 {
-	return vma_end_virt_pgoff(vma) - 1;
+	return vma_end_anon_pgoff(vma) - 1;
 }
 
 static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
@@ -1633,22 +1644,22 @@ static inline pgprot_t vma_get_page_prot
 	return vma_flags_to_page_prot(vma->flags);
 }
 
-static inline pgoff_t __linear_virt_page_index(const struct vm_area_struct *vma,
+static inline pgoff_t __linear_anon_page_index(const struct vm_area_struct *vma,
 					       const unsigned long address)
 {
 	pgoff_t pgoff;
 
 	pgoff = linear_page_delta(vma, address);
-	pgoff += vma_start_virt_pgoff(vma);
+	pgoff += vma_start_anon_pgoff(vma);
 	return pgoff;
 }
 
-static inline pgoff_t linear_virt_page_index(const struct vm_area_struct *vma,
-					     const unsigned long address)
+static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
+		const unsigned long address)
 {
-	const pgoff_t pgoff = __linear_virt_page_index(vma, address);
+	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
 
-	VM_WARN_ON_ONCE(vma_test(vma, VMA_SHARED_BIT));
+	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
 	if (vma_is_anonymous(vma))
 		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
 
--- a/tools/testing/vma/shared.c~b
+++ a/tools/testing/vma/shared.c
@@ -24,7 +24,7 @@ struct vm_area_struct *alloc_vma(struct
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma_set_pgoff(vma, pgoff);
-	vma_set_virt_pgoff(vma, start >> PAGE_SHIFT);
+	vma_set_anon_pgoff(vma, start >> PAGE_SHIFT);
 	vma->flags = vma_flags;
 	vma_assert_detached(vma);
 
--- a/tools/testing/vma/tests/merge.c~b
+++ a/tools/testing/vma/tests/merge.c
@@ -121,7 +121,7 @@ static bool test_simple_merge(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 	ASSERT_FLAGS_SAME_MASK(&vma->flags, vma_flags);
 
 	detach_free_vma(vma);
@@ -154,7 +154,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0x1000);
 	ASSERT_EQ(vma->vm_end, 0x2000);
 	ASSERT_EQ(vma_start_pgoff(vma), 1);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 1);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 1);
 
 	/*
 	 * Now walk through the three split VMAs and make sure they are as
@@ -167,7 +167,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 
 	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
@@ -177,7 +177,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0x1000);
 	ASSERT_EQ(vma->vm_end, 0x2000);
 	ASSERT_EQ(vma_start_pgoff(vma), 1);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 1);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 1);
 
 	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
@@ -187,7 +187,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0x2000);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 2);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 2);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 2);
 
 	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
@@ -217,7 +217,7 @@ static bool test_simple_expand(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 
 	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
@@ -240,7 +240,7 @@ static bool test_simple_shrink(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 
 	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
@@ -353,7 +353,7 @@ static bool __test_merge_new(bool is_sti
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x5000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
@@ -375,7 +375,7 @@ static bool __test_merge_new(bool is_sti
 	ASSERT_EQ(vma->vm_start, 0x6000);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma), 6);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 6);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 6);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
@@ -396,7 +396,7 @@ static bool __test_merge_new(bool is_sti
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -417,7 +417,7 @@ static bool __test_merge_new(bool is_sti
 	ASSERT_EQ(vma->vm_start, 0xa000);
 	ASSERT_EQ(vma->vm_end, 0xc000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0xa);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0xa);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0xa);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -437,7 +437,7 @@ static bool __test_merge_new(bool is_sti
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0xc000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
@@ -458,7 +458,7 @@ static bool __test_merge_new(bool is_sti
 		ASSERT_EQ(vma->vm_start, 0);
 		ASSERT_EQ(vma->vm_end, 0xc000);
 		ASSERT_EQ(vma_start_pgoff(vma), 0);
-		ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+		ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 
 		detach_free_vma(vma);
@@ -655,7 +655,8 @@ static bool test_vma_merge_with_close(vo
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x5000);
-	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_start_pgoff(vma_prev), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_prev), 0);
 
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
 
@@ -766,7 +767,8 @@ static bool test_vma_merge_with_close(vo
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x5000);
-	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_start_pgoff(vma_prev), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_prev), 0);
 
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
 
@@ -821,7 +823,7 @@ static bool test_vma_merge_new_with_clos
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x5000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 	ASSERT_EQ(vma->vm_ops, &vm_ops);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -878,12 +880,12 @@ static bool __test_merge_existing(bool p
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma_next), 3);
-	ASSERT_EQ(vma_start_virt_pgoff(vma_next), 3);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_next), 3);
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_EQ(vma->vm_start, 0x2000);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 2);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 2);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 2);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 2);
@@ -913,7 +915,8 @@ static bool __test_merge_existing(bool p
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x2000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
-	ASSERT_EQ(vma_next->vm_pgoff, 2);
+	ASSERT_EQ(vma_start_pgoff(vma_next), 2);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_next), 2);
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 1);
@@ -946,12 +949,12 @@ static bool __test_merge_existing(bool p
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x6000);
 	ASSERT_EQ(vma_start_pgoff(vma_prev), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma_prev), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_prev), 0);
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_EQ(vma->vm_start, 0x6000);
 	ASSERT_EQ(vma->vm_end, 0x7000);
 	ASSERT_EQ(vma_start_pgoff(vma), 6);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 6);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 6);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -983,7 +986,7 @@ static bool __test_merge_existing(bool p
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_start_pgoff(vma_prev), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma_prev), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_prev), 0);
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
@@ -1016,7 +1019,7 @@ static bool __test_merge_existing(bool p
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma_prev), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma_prev), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_prev), 0);
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
@@ -1146,7 +1149,8 @@ static bool test_anon_vma_non_mergeable(
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
-	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_start_pgoff(vma_prev), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_prev), 0);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_FALSE(vma_write_started(vma_next));
 
@@ -1177,7 +1181,8 @@ static bool test_anon_vma_non_mergeable(
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
-	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_start_pgoff(vma_prev), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma_prev), 0);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_FALSE(vma_write_started(vma_next));
 
@@ -1439,7 +1444,7 @@ static bool test_merge_extend(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x4000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
 
@@ -1480,7 +1485,7 @@ static bool test_expand_only_mode(void)
 	ASSERT_EQ(vma->vm_start, 0x3000);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma), 3);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 3);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 3);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(vma_iter_addr(&vmi), 0x3000);
 	vma_assert_attached(vma);
--- a/tools/testing/vma/tests/mmap.c~b
+++ a/tools/testing/vma/tests/mmap.c
@@ -74,7 +74,7 @@ static bool test_pure_anon_dev_zero(void
 
 	/*
 	 * Map a MAP_PRIVATE-/dev/zero mapping at address 0x300000 with a page
-	 * offset of 0x10, which we expect to be reset to the virtual page
+	 * offset of 0x10, which we expect to be reset to the anonymous page
 	 * offset.
 	 */
 	addr = __mmap_region(&file, 0x300000, 0x3000, vma_flags, 0x10, NULL);
@@ -86,9 +86,9 @@ static bool test_pure_anon_dev_zero(void
 	ASSERT_TRUE(vma_is_anonymous(vma));
 	ASSERT_EQ(vma->vm_file, NULL);
 	ASSERT_EQ(vma->vm_private_data, NULL);
-	/* Expect virtual page offsets. */
+	/* Expect anonymous page offsets. */
 	ASSERT_EQ(vma->vm_pgoff, 0x300);
-	ASSERT_EQ(vma_start_virt_pgoff(vma), 0x300);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0x300);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
--- a/tools/testing/vma/tests/vma.c~b
+++ a/tools/testing/vma/tests/vma.c
@@ -33,7 +33,51 @@ static bool test_copy_vma(void)
 	struct mm_struct mm = {};
 	bool need_locks = false;
 	VMA_ITERATOR(vmi, &mm, 0);
-	struct vm_area_struct *vma, *vma_new, *vma_next;
+	struct vm_area_struct *vma, *vma_prev, *vma_new, *vma_next, *vma_orig;
+
+	/* Move forwards, adjacent to old self - self-merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, vma_flags);
+	vma_set_anonymous(vma);
+	vma_orig = vma;
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 1, 1, &need_locks);
+	ASSERT_EQ(vma_new, vma_orig);
+	ASSERT_EQ(vma, vma_orig);
+	ASSERT_EQ(vma_new->vm_start, 0x1000);
+	ASSERT_EQ(vma_new->vm_end, 0x3000);
+
+	cleanup_mm(&mm, &vmi);
+
+	/* Move backwards, adjacent to old self - self-merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, vma_flags);
+	vma_set_anonymous(vma);
+	vma_orig = vma;
+	vma_new = copy_vma(&vma, 0x1000, 0x1000, 2, 2, &need_locks);
+	ASSERT_EQ(vma_new, vma_orig);
+	ASSERT_EQ(vma, vma_orig);
+	ASSERT_EQ(vma_new->vm_start, 0x1000);
+	ASSERT_EQ(vma_new->vm_end, 0x3000);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * Move backwards between prior VMA and old self - self-merge and vma
+	 * updated to a new VMA.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, vma_flags);
+	vma_set_anonymous(vma_prev);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vma_flags);
+	vma_set_anonymous(vma);
+	vma_orig = vma;
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 3, 3, &need_locks);
+	ASSERT_NE(vma_new, vma_orig);
+	ASSERT_EQ(vma_new, vma);
+	ASSERT_EQ(vma_new->vm_start, 0x1000);
+	ASSERT_EQ(vma_new->vm_end, 0x4000);
+
+	cleanup_mm(&mm, &vmi);
 
 	/* Move backwards and do not merge. */
 
_



