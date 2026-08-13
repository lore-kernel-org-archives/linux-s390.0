Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE94779B0;
	Thu, 13 Aug 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647232; cv=none; b=GuBikpX32CiGBN3ALtJBvOEjNXX/jbIX0m2qovaO8J6kQys0j6AldAwyWiWshnuuEamR/omy9PQwT3+76DxxZTTrU21jN4d4+BSrIrPf6SdYfmoraTR3KG0/KMB6Rd3jSfFtXZMgD9wKuW9G64muPgVmj/HGXo8Jhlj1UBkriKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647232; c=relaxed/simple;
	bh=+5+sNSCC8vMUcw/mXw+HntxvRCRaCRL39tNs4SJR12U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BYg7wGwzapBcOdAgOpV17wZ7VLvOBME3rqIkbKnku4ZfrK8PzQQxZCaS0ibukRtPBhU7tLdReBEaSbWDtvE0ZSpzG2koyLPwryQFiC1bOvd9FJ/khk8a32L1XOasOS/DsAlvhZVQl4rBPffKNSWpOXEJcA+fereCGbhYKOnn1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wnXpzrcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wnXpzrcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C1F1F000E9;
	Thu, 13 Aug 2026 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786647230;
	bh=ASPFIHOYv4kPq+fjPATiGtO6LZnVw52py5QygU3F5TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=wnXpzrcrikedp0SfWF39QJ5r8iLB1KBdiWswf4VbnJ5qOAuvlzbKrKSdgRPhOX6pk
	 TFxliHzt3nt6Kba0FcLL/pDXQLhkKftI6vVQfaXHg0qdArA9QGptZ3+YeCocOZqRQU
	 EMotp0MujU4LLk2hvsJE2MxQMvtrjw/KKUfa1QKE=
Date: Thu, 13 Aug 2026 11:53:46 -0700
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
Subject: Re: [PATCH v5 00/16] mm/rmap: index MAP_PRIVATE file-backed folios
 by anonymous pgoff
Message-Id: <20260813115346.2aaad419a351341a4f5f3ae0@linux-foundation.org>
In-Reply-To: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
References: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 18:32:17 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

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
> This series fixes issue 3.

Thanks.  I've updated mm.git's mm-unstable branch to this version. 
Looking good for the second week of the upcoming merge window.


You'll be mortified to hear that Sashiko wasn't able to find anything
to which to apply this.

Sashiko can be guided with a base-commit: tag but I'm not sure how to
tell it what tree/branch to try, or even if that's necessary.  Perhaps
someone can figure this out sometime.

maybe

hp2:/usr/src/linux-next> git log --oneline | grep "mm/vma: introduce VMA anon page offset field and add helpers"
249646a587dc mm/vma: introduce VMA anon page offset field and add helpers

base-commit: 249646a587dc^

But that requires that Sashiko be able to poke around in linux-next
from previous days.

> v5:
> * Accumulated tags (thanks everybody!)
> * Removed the final 4 patches to be handled later as there are nuances with
>   the /dev/zero stuff we need to figure out, as discussed with David.
> * Updated the cover letter to reflect this.
> * Added comments to vma_flags_is_cow_mapping(),
>   vma_[desc_]is_cow_mapping() as per Suren.
> * Correct typo as per Suren.
> * Reworded test comment in patch 16 from 'fault in' to 'trigger a CoW
>   fault' as per David.
> * Fix -> 75 char limit in patch 12's commit msg.

Here's how v5 altered mm.git.  It's rather substantial, but mainly
selftests:


 drivers/char/mem.c                                     |    8 
 include/linux/mm.h                                     |   18 -
 include/linux/pagemap.h                                |    3 
 mm/internal.h                                          |   17 -
 mm/vma.c                                               |   52 ----
 mm/vma.h                                               |    3 
 mm/vma_internal.h                                      |    1 
 tools/testing/selftests/mm/merge.c                     |  106 ----------
 tools/testing/selftests/proc/proc-self-map-files-001.c |    2 
 tools/testing/selftests/proc/proc-self-map-files-002.c |    2 
 tools/testing/vma/include/dup.h                        |   40 ---
 tools/testing/vma/tests/mmap.c                         |   50 ----
 12 files changed, 40 insertions(+), 262 deletions(-)

--- a/drivers/char/mem.c~b
+++ a/drivers/char/mem.c
@@ -506,7 +506,11 @@ static int mmap_zero_prepare(struct vm_a
 	if (vma_desc_test(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
-	/* MAP_PRIVATE semantics are taken care for us by core mm. */
+	/*
+	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
+	 * of /dev/zero anonymous, despite it not being.
+	 */
+	vma_desc_set_anonymous(desc);
 	return 0;
 }
 
@@ -694,7 +698,7 @@ static const struct memdev {
 #ifdef CONFIG_DEVPORT
 	[4] = { "port", &port_fops, 0, 0 },
 #endif
-	[DEVZERO_MINOR] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
+	[5] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
 	[7] = { "full", &full_fops, 0, 0666 },
 	[8] = { "random", &random_fops, FMODE_NOWAIT, 0666 },
 	[9] = { "urandom", &urandom_fops, FMODE_NOWAIT, 0666 },
--- a/include/linux/mm.h~b
+++ a/include/linux/mm.h
@@ -740,9 +740,6 @@ static inline bool fault_flag_allow_retr
 	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
 	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
-/* /dev/zero minor device number. Special due to MAP_PRIVATE semantics. */
-#define DEVZERO_MINOR	5
-
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
  * ->fault function. The vma's ->fault is responsible for returning a bitmask
@@ -1554,6 +1551,11 @@ static inline void vma_set_anonymous(str
 	vma->vm_ops = NULL;
 }
 
+static inline void vma_desc_set_anonymous(struct vm_area_desc *desc)
+{
+	desc->vm_ops = NULL;
+}
+
 static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
 {
 	return !vma->vm_ops;
@@ -2279,8 +2281,7 @@ void unpin_folios(struct folio **folios,
  * All mappings backed by anonymous folios (all anonymous mappings and most
  * MAP_PRIVATE-file backed ranges) are CoW mappings.
  *
- * All other mappings (including all writable MAP_SHARED mappings) are
- * non-CoW.
+ * All other mappings (including all MAP_SHARED mappings) are non-CoW.
  *
  * The criteria are !VMA_SHARED_BIT, VMA_MAYWRITE_BIT.
  *
@@ -2317,7 +2318,7 @@ static inline bool vma_flags_is_cow_mapp
 
 /**
  * vma_is_cow_mapping() - Is this VMA a CoW mapping?
- * @vma: The VMA to check.
+ * @desc: The VMA to check.
  *
  * See vma_flags_is_cow_mapping() for details.
  *
@@ -4407,8 +4408,9 @@ static inline unsigned long vma_pages(co
  * If @vma is a MAP_PRIVATE file-backed mapping, then this returns the
  * page offset within the file.
  *
- * Edge cases: nommu does not abide by these and CoW MAP_PRIVATE-pfnmap regions
- * have their page offset set to the first PFN in the range.
+ * Edge cases: nommu does not abide by these, MAP_PRIVATE-/dev/zero satisfies
+ * vma_is_anonymous() but has file-backed page offset, and MAP_PRIVATE-pfnmap
+ * regions have their page offset set to the first PFN in the range.
  *
  * Returns: The page offset of the start of @vma.
  */
--- a/include/linux/pagemap.h~b
+++ a/include/linux/pagemap.h
@@ -1128,7 +1128,8 @@ static inline pgoff_t linear_anon_page_i
 	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
 
 	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
-	if (vma_is_anonymous(vma))
+	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
+	if (vma_is_anonymous(vma) && !vma->vm_file)
 		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
 
 	return pgoff;
--- a/mm/internal.h~b
+++ a/mm/internal.h
@@ -240,18 +240,15 @@ static inline int mmap_file(struct file
 {
 	int err = vfs_mmap(file, vma);
 
+	if (likely(!err))
+		return 0;
+
 	/*
-	 * Either we tried to call the file hook for mmap() and an error arose
-	 * or a driver set vma->vm_ops = NULL intending there to be no VMA
-	 * operations.
-	 *
-	 * In the former case the VMA is in an inconsistent state and we mustn't
-	 * invoke any further hooks on it, in the latter case the hook actually
-	 * wanted no further hooks to be invoked, so fix both by setting dummy
-	 * VMA ops.
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we must not invoke
+	 * any further hooks on it.
 	 */
-	if (unlikely(err || !vma->vm_ops))
-		vma->vm_ops = &vma_dummy_vm_ops;
+	vma->vm_ops = &vma_dummy_vm_ops;
 
 	return err;
 }
--- a/mm/vma.c~b
+++ a/mm/vma.c
@@ -2621,36 +2621,6 @@ static int __mmap_new_file_vma(struct mm
 	return 0;
 }
 
-static bool map_is_dev_zero(const struct mmap_state *map)
-{
-	const struct file *file = map->file;
-	struct inode *inode;
-
-	if (!file)
-		return false;
-	inode = file_inode(file);
-	if (!S_ISCHR(inode->i_mode))
-		return false;
-	return imajor(inode) == MEM_MAJOR && iminor(inode) == DEVZERO_MINOR;
-}
-
-static void map_set_anon(struct mmap_state *map)
-{
-	map->file = NULL;
-	map->vm_ops = NULL;
-	map->pgoff = map->addr >> PAGE_SHIFT;
-}
-
-static bool map_is_private(const struct mmap_state *map)
-{
-	return !vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
-}
-
-static bool map_is_anon(const struct mmap_state *map)
-{
-	return map_is_private(map) && !map->file;
-}
-
 /*
  * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
  * possible.
@@ -2664,7 +2634,8 @@ static bool map_is_anon(const struct mma
 static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	struct mmap_action *action)
 {
-	const bool is_anon = map_is_anon(map);
+	const bool is_anon = !map->file &&
+		!vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
 	struct vma_iterator *vmi = map->vmi;
 	int error = 0;
 	struct vm_area_struct *vma;
@@ -2806,10 +2777,6 @@ static int call_mmap_prepare(struct mmap
 	if (err)
 		return err;
 
-	/* Hooks cannot mark themselves anonymous. */
-	if (!desc->vm_ops)
-		return -EINVAL;
-
 	err = call_action_prepare(map, desc);
 	if (err)
 		return err;
@@ -2826,21 +2793,16 @@ static int call_mmap_prepare(struct mmap
 	map->vm_ops = desc->vm_ops;
 	map->vm_private_data = desc->private_data;
 
-	/*
-	 * MAP_PRIVATE-/dev/zero mappings are an ancient way of getting
-	 * anonymous mappings. Rather than allowing these mappings to be odd
-	 * outliers, simply make them truly anonymous.
-	 */
-	if (map_is_private(map) && map_is_dev_zero(map))
-		map_set_anon(map);
-
 	return 0;
 }
 
 static void set_vma_user_defined_fields(struct vm_area_struct *vma,
 		struct mmap_state *map)
 {
-	vma->vm_ops = map->vm_ops;
+	if (map->vm_ops)
+		vma->vm_ops = map->vm_ops;
+	else	/* Only /dev/zero should do this. */
+		vma_set_anonymous(vma);
 	vma->vm_private_data = map->vm_private_data;
 }
 
@@ -2920,7 +2882,7 @@ static unsigned long __mmap_region(struc
 		allocated_new = true;
 	}
 
-	if (have_mmap_prepare && !map_is_anon(&map))
+	if (have_mmap_prepare)
 		set_vma_user_defined_fields(vma, &map);
 
 	__mmap_complete(&map, vma);
--- a/mm/vma.h~b
+++ a/mm/vma.h
@@ -267,6 +267,9 @@ static inline void assert_sane_pgoff(str
 	 */
 	if (!vma_is_anonymous(vma))
 		return;
+	/* MAP_PRIVATE-/dev/zero is anon, non-NULL vm_file, but has file pgoff. */
+	if (vma->vm_file)
+		return;
 	/* If faulted in, could have been remapped. */
 	if (vma->anon_vma)
 		return;
--- a/mm/vma_internal.h~b
+++ a/mm/vma_internal.h
@@ -23,7 +23,6 @@
 #include <linux/ksm.h>
 #include <linux/khugepaged.h>
 #include <linux/list.h>
-#include <linux/major.h>
 #include <linux/maple_tree.h>
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
--- a/tools/testing/selftests/mm/merge.c~b
+++ a/tools/testing/selftests/mm/merge.c
@@ -1324,7 +1324,7 @@ TEST_F(merge, anon_and_page_offset_misma
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/*
-	 * Map another separately and trigger a CoW fault, at page offset 5:
+	 * Map another separately and trigger a CoW fault at page offset 5:
 	 *
 	 * |-----------|           |---------|
 	 * | unfaulted |           | faulted |
@@ -1362,110 +1362,6 @@ TEST_F(merge, anon_and_page_offset_misma
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 5 * page_size);
 }
 
-TEST_F(merge, merge_map_private_dev_zero_unfaulted)
-{
-	struct procmap_fd *procmap = &self->procmap;
-	unsigned int page_size = self->page_size;
-	char *carveout = self->carveout;
-	char *ptr, *ptr2;
-	int fd_zero;
-
-	if (access("/dev/zero", F_OK))
-		SKIP(return, "No /dev/zero.");
-	fd_zero = open("/dev/zero", O_RDWR);
-	ASSERT_NE(fd_zero, -1);
-
-	/*
-	 * Map two MAP_PRIVATE-/dev/zero VMAs next to one another with offset 0
-	 * each.
-	 *
-	 * With these being made truly anonymous upon mapping, they will
-	 * merge. If they were file-backed VMAs the page offsets would prevent
-	 * merge:
-	 *
-	 * |-----||------|    |-------------|
-	 * | ptr || ptr2 | -> |     ptr     |
-	 * |-----||------|    |-------------|
-	 */
-	ptr = mmap(carveout, 5 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
-	if (ptr == MAP_FAILED) {
-		close(fd_zero);
-		ASSERT_TRUE(false);
-	}
-	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
-		   PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
-	if (ptr2 == MAP_FAILED) {
-		close(fd_zero);
-		ASSERT_TRUE(false);
-	}
-	close(fd_zero);
-
-	/* Assert that they merged. */
-	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
-	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
-	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
-}
-
-TEST_F(merge, merge_map_private_dev_zero_faulted_unfaulted)
-{
-	struct procmap_fd *procmap = &self->procmap;
-	unsigned int page_size = self->page_size;
-	char *carveout = self->carveout;
-	char *ptr, *ptr2;
-	int fd_zero;
-
-	if (access("/dev/zero", F_OK))
-		SKIP(return, "No /dev/zero.");
-	fd_zero = open("/dev/zero", O_RDWR);
-	ASSERT_NE(fd_zero, -1);
-
-	/*
-	 * Map a MAP_PRIVATE mapping of /dev/zero with page offset 0, then fault
-	 * it in:
-	 *
-	 * |-------------------------------|
-	 * |           faulted             |
-	 * |-------------------------------|
-	 */
-	ptr = mmap(carveout, 15 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
-	if (ptr == MAP_FAILED) {
-		close(fd_zero);
-		ASSERT_TRUE(false);
-	}
-	memset(ptr, 'x', 15 * page_size);
-
-	/*
-	 * Unmap the middle:
-	 *
-	 * |---------|           |---------|
-	 * | faulted |           | faulted |
-	 * |---------|           |---------|
-	 */
-	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
-
-	/*
-	 * Map in a new unfaulted mapping in the middle with page offset 0 -
-	 * this should merge and would not if it were treated as a file rather
-	 * than pure anon:
-	 *
-	 * |---------|-----------|---------|
-	 * | faulted | unfaulted | faulted |
-	 * |---------|-----------|---------|
-	 */
-	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
-		    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE,
-		    fd_zero, 0);
-	close(fd_zero);
-	ASSERT_NE(ptr2, MAP_FAILED);
-
-	/* Assert that they merged. */
-	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
-	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
-	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
-}
-
 TEST_F(merge_with_fork, mremap_faulted_to_unfaulted_prev)
 {
 	struct procmap_fd *procmap = &self->procmap;
--- a/tools/testing/selftests/proc/proc-self-map-files-001.c~b
+++ a/tools/testing/selftests/proc/proc-self-map-files-001.c
@@ -51,7 +51,7 @@ int main(void)
 	int fd;
 	unsigned long a, b;
 
-	fd = open("/proc/self/exe", O_RDONLY);
+	fd = open("/dev/zero", O_RDONLY);
 	if (fd == -1)
 		return 1;
 
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c~b
+++ a/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -57,7 +57,7 @@ int main(void)
 	int fd;
 	unsigned long a, b;
 
-	fd = open("/proc/self/exe", O_RDONLY);
+	fd = open("/dev/zero", O_RDONLY);
 	if (fd == -1)
 		return 1;
 
--- a/tools/testing/vma/include/dup.h~b
+++ a/tools/testing/vma/include/dup.h
@@ -15,21 +15,6 @@ struct task_struct *get_current(void);
 #define MMF_HAS_MDWE	28
 #define current get_current()
 
-#define MINORBITS	20
-#define MINORMASK	((1U << MINORBITS) - 1)
-
-#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
-#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
-#define MKDEV(ma, mi)	(((ma) << MINORBITS) | (mi))
-
-#define S_IFMT  00170000
-#define S_IFCHR  0020000
-
-#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
-
-#define MEM_MAJOR		1
-#define DEVZERO_MINOR	5
-
 /*
  * Define the task command name length as enum, then it can be visible to
  * BPF programs.
@@ -38,8 +23,6 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
-typedef unsigned short		umode_t;
-
 /* PARTIALLY implemented types. */
 struct mm_struct {
 	struct maple_tree mm_mt;
@@ -62,10 +45,6 @@ struct address_space {
 	unsigned long		flags;
 	atomic_t		i_mmap_writable;
 };
-struct inode {
-	umode_t			i_mode;
-	dev_t			i_rdev;
-};
 struct file_operations {
 	int (*mmap)(struct file *, struct vm_area_struct *);
 	int (*mmap_prepare)(struct vm_area_desc *);
@@ -73,7 +52,6 @@ struct file_operations {
 struct file {
 	struct address_space	*f_mapping;
 	const struct file_operations	*f_op;
-	struct inode			*f_inode;
 };
 struct anon_vma_chain {
 	struct anon_vma *anon_vma;
@@ -1660,23 +1638,9 @@ static inline pgoff_t linear_anon_page_i
 	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
 
 	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
-	if (vma_is_anonymous(vma))
+	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
+	if (vma_is_anonymous(vma) && !vma->vm_file)
 		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
 
 	return pgoff;
 }
-
-static inline struct inode *file_inode(const struct file *f)
-{
-	return f->f_inode;
-}
-
-static inline unsigned iminor(const struct inode *inode)
-{
-	return MINOR(inode->i_rdev);
-}
-
-static inline unsigned imajor(const struct inode *inode)
-{
-	return MAJOR(inode->i_rdev);
-}
--- a/tools/testing/vma/tests/mmap.c~b
+++ a/tools/testing/vma/tests/mmap.c
@@ -45,57 +45,7 @@ static bool test_mmap_region_basic(void)
 	return true;
 }
 
-static int dummy_mmap_prepare(struct vm_area_desc *desc)
-{
-	return 0;
-}
-
-static bool test_pure_anon_dev_zero(void)
-{
-	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
-	const struct file_operations f_op = {
-		.mmap_prepare = dummy_mmap_prepare,
-	};
-	struct inode inode = {
-		.i_mode = S_IFCHR,
-		.i_rdev = MKDEV(MEM_MAJOR, DEVZERO_MINOR),
-	};
-	struct file file = {
-		.f_inode = &inode,
-		.f_op = &f_op,
-	};
-	struct mm_struct mm = {};
-	struct vm_area_struct *vma;
-	unsigned long addr;
-	VMA_ITERATOR(vmi, &mm, 0);
-
-	current->mm = &mm;
-
-	/*
-	 * Map a MAP_PRIVATE-/dev/zero mapping at address 0x300000 with a page
-	 * offset of 0x10, which we expect to be reset to the anonymous page
-	 * offset.
-	 */
-	addr = __mmap_region(&file, 0x300000, 0x3000, vma_flags, 0x10, NULL);
-	ASSERT_EQ(addr, 0x300000);
-
-	/* Assert that it truly is an anonymous mapping. */
-	vma = vma_lookup(&mm, addr);
-	ASSERT_NE(vma, NULL);
-	ASSERT_TRUE(vma_is_anonymous(vma));
-	ASSERT_EQ(vma->vm_file, NULL);
-	ASSERT_EQ(vma->vm_private_data, NULL);
-	/* Expect anonymous page offsets. */
-	ASSERT_EQ(vma->vm_pgoff, 0x300);
-	ASSERT_EQ(vma_start_anon_pgoff(vma), 0x300);
-
-	cleanup_mm(&mm, &vmi);
-	return true;
-}
-
 static void run_mmap_tests(int *num_tests, int *num_fail)
 {
 	TEST(mmap_region_basic);
-	TEST(pure_anon_dev_zero);
 }
_

