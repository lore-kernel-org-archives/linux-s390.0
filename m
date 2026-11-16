Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853861;
	b=5lxX5GdBUbys9LMI3BKRVs288wr55Zl4svvVTMLZeZiWyLKo9I3rkYKTPe6vw/kRRlh2
	 yjXcu7Cg+WlEsT1RTFtx6vWu5nLUZXqbSvrjCq22kEGRRFLxPXKrwEVRCX2MF7lmcQj5h
	 I2rSGCicqU8q0VWrSUxvvESfnc5h0D5H1yNLL2l8fVm7O57pFfpLEbJjg4tOdd0SrfvRv
	 lXuQG0zXWx4o4fsd/U+z9WV4whEfYnwwz3/xEuNvU/l7qGSj+VLvMvbnVGoAIK3zA1EyA
	 Ihujgn6ML8/PsJv04hk3CF8op92MDxHkoJEiH7925Z97DgkIGF21aheD54f8jxtBE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853861;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8q5kmPUUla6tErFHjcVANn5bpZocet614lo1LZa83J8=;
	b=x7YYkCsE73PmggZwEbSpMz5zD7BlYPlptmoxIrgtAx7oKnwkY+8cu6kJwJs+U/fRc6nO
	 0DvIByRacoDBAX2OLVztfqhGY/lgGtXl6bzlnPwYZ6g9smJ8qF7xWHVIuLDospcJ3huGn
	 7cKqJ6mc8C5ELOxxhpH/VNSvHl3xIW5QZltRLwD00h2LqZXAGpzk9y8R6xl52a95oadTb
	 Q1ljm0pr+b/23U+CmOia5iJNHN4hLpnEwHYynTDhw4x8C8ojJ55jnCdMxHM24fsFqJFpO
	 jjYEpa3JZv7zXtKzlpeCkrlW9NAPKFM2yOdgiYgYR5jKdq4BMpr5MZa98aMmOeoluzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRwuxZzu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB58606A322;
	Mon, 16 Nov 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRwuxZzu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786541F000C4;
	Mon, 16 Nov 2026 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853861;
	bh=8q5kmPUUla6tErFHjcVANn5bpZocet614lo1LZa83J8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TRwuxZzukgAMoPYPLWLtljlyfSI9BuopUy/Wa7NyXoqzkH4d4qq8KLJS2C3jDLI+2
	 mxI+z2XGmp+3p3E59RysvUj/61AvTjPOTBwTEVFf81eUUS5BUL03vPZrPsYKrwSh7Y
	 8kJ+kn04vCqOPuKTbFTaAQAOzHS7e4/6ZJHcfYPB08uin/u+yWpsKzaNJR7UkluL4h
	 8xZ3pOP6H1jH8VPZKhyWDVnDEGBegctsz9+LWNl3Jl/J3tB9ZXRsLv+O5uOVstO4th
	 qCYVuTWWIJaYGRWUpS8/Itaym2gyuXbhQnOlijJwO1I2j8dhv6YVP7jeZBiBwqKaEp
	 OL/i0jFjQX7HQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:29 +0100
Subject: [PATCH v2 08/15] mm/hugetlb: serialize page-cache allocations with
 truncation
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
Message-Id: <20261116-fixes_hugetlb-v2-8-4dd9e94ea9ac@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10958; i=david@kernel.org;
 h=from:subject:message-id; bh=B/fSPJ4V/9JmeAZF9RkznevkFZTGuP0X2xC5HdwbTrU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3esF1Sas9TZx7/x726tiNrEBZ31F66fPvRir7Nml
 eHdJ/cPdpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARlj6G/yU3t11b8GIFS1/+
 jL0cSZdlMvR/CM15aHRMR2yu9TaPVyoM/50LbRqPXFd6I/R50sn6xz8nl1r9rzh3kmvOx7hzO94
 8mMwBAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Truncation can remove an inode reservation while a fault is still
allocating its folio. UFFDIO_COPY and memfd pinning can also consume
reservations beyond the new i_size. This can underflow resv_huge_pages
and leave folios beyond EOF.

The main issue is that truncation takes the fault mutex for folios in
the page-cache, but it has no clue about faults that are still being
processed concurrently.

Matthew Wilcox raised mapping->invalidate_lock in a different upstream
hugetlb locking discussion:

  "although I wonder if we still need the fault mutex array, given that we
   now have mapping->invalidate_lock?"

While it likely cannot remove the mutex array entirely (concurrent page
faults have to sync ... ), we can at least use it to fix this problem.

Hold mapping->invalidate_lock shared across the size check, allocation
and page cache insertion or reservation rollback. Truncation takes it
exclusively around i_size_write() only for now: it waits for concurrent
allocations to finish updating the page-cache or rolling back reservations
before changing the size. Subsequent allocations see the updated i_size.

Let truncation release the lock for now before unmapping and removing
folios to preserve the existing lock ordering. Cached-folio faults and
private allocations do not acquire the new lock.

Use it to synchronize with truncation, keeping the fault mutexes to
serialize allocations for the same index.

Locking order is now:

  fault mutex -> hugetlb VMA lock (read) -> invalidate lock (read) ->
  folio lock -> PTE lock

And on truncation:

  i_rwsem (write) -> invalidate lock (write)

Add hugetlb_pgoff_valid() to not repeat the same size check multiple
times. Memfd needs a bit of care, as it traditionally allowed partial
folios to be pinned: the size check in memfd_pin_folios() allows for
that.

Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
Fixes: 188a39725ad7 ("hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race")
Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/all/ajMfdQf-Fspwmstr@casper.infradead.org/
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c    | 15 +++++++++++----
 include/linux/hugetlb.h | 12 ++++++++++++
 mm/hugetlb.c            | 45 +++++++++++++++++++++++++++++++++------------
 mm/memfd.c              |  8 ++++++++
 4 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1d0c35e639e80..7f64bdc07aa80 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -546,10 +546,9 @@ static void remove_inode_single_folio(struct hstate *h, struct inode *inode,
  * truncation is indicated by end of range being LLONG_MAX
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
- *	maps and global counts.  Page faults can race with truncation.
- *	During faults, hugetlb_no_page() checks i_size before page allocation,
- *	and again after obtaining page table lock.  It will 'back out'
- *	allocations in the truncated range.
+ *	maps and global counts.  hugetlb_vmtruncate() updates i_size under
+ *	invalidate_lock to synchronize with new page cache allocations from
+ *	page faults, uffd, etc.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserve map
@@ -623,7 +622,15 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
+	filemap_invalidate_lock(mapping);
 	i_size_write(inode, offset);
+	/*
+	 * The size check now prevents new page-cache allocations in the
+	 * truncated range. Existing folios and reservations are cleaned up
+	 * below.
+	 */
+	filemap_invalidate_unlock(mapping);
+
 	i_mmap_lock_write(mapping);
 	if (mapping_mapped(mapping))
 		hugetlb_vmdelete_list(mapping, pgoff, 0, ZAP_FLAG_DROP_MARKER);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 80ae65c7849b9..1d2dd10074d7a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -820,6 +820,18 @@ static inline unsigned huge_page_shift(struct hstate *h)
 	return h->order + PAGE_SHIFT;
 }
 
+static inline bool hugetlb_pgoff_valid(struct address_space *mapping,
+		pgoff_t idx, bool partial)
+{
+	struct hstate *h = hstate_inode(mapping->host);
+	u64 size = i_size_read(mapping->host);
+
+	if (partial)
+		size = round_up(size, huge_page_size(h));
+
+	return idx < (size >> huge_page_shift(h));
+}
+
 /**
  * hugetlb_linear_page_index() - linear_page_index() but in hugetlb
  *				 page size granularity.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a24819733730..3d8eebdca5136 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5887,6 +5887,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm, unsigned
 static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			struct vm_fault *vmf)
 {
+	const bool pagecache_folio = vmf->vma->vm_flags & VM_MAYSHARE;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 	bool new_folio, new_anon_folio = false;
 	struct vm_area_struct *vma = vmf->vma;
@@ -5895,7 +5896,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	bool folio_locked = true;
 	struct folio *folio;
-	unsigned long size;
 	pte_t new_pte;
 
 	/*
@@ -5917,8 +5917,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	new_folio = false;
 	folio = filemap_lock_hugetlb_folio(h, mapping, vmf->pgoff);
 	if (IS_ERR(folio)) {
-		size = i_size_read(mapping->host) >> huge_page_shift(h);
-		if (vmf->pgoff >= size)
+		if (!hugetlb_pgoff_valid(mapping, vmf->pgoff, /* partial= */ false))
 			goto out;
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
@@ -5948,10 +5947,17 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 							VM_UFFD_MISSING);
 		}
 
-		if (!(vma->vm_flags & VM_MAYSHARE)) {
+		if (!pagecache_folio) {
 			ret = __vmf_anon_prepare(vmf);
 			if (unlikely(ret))
 				goto out;
+		} else {
+			/* Recheck EOF before consuming an inode reservation. */
+			filemap_invalidate_lock_shared(mapping);
+			if (!hugetlb_pgoff_valid(mapping, vmf->pgoff, /* partial= */ false)) {
+				filemap_invalidate_unlock_shared(mapping);
+				goto out;
+			}
 		}
 
 		folio = alloc_hugetlb_folio(vma, vmf->address, false);
@@ -5972,13 +5978,15 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
+			if (pagecache_folio)
+				filemap_invalidate_unlock_shared(mapping);
 			goto out;
 		}
 		folio_zero_user(folio, vmf->real_address);
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
-		if (vma->vm_flags & VM_MAYSHARE) {
+		if (pagecache_folio) {
 			int err = hugetlb_add_to_page_cache(folio, mapping,
 							vmf->pgoff);
 			if (err) {
@@ -5993,8 +6001,10 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 							folio);
 				folio_put(folio);
 				ret = VM_FAULT_SIGBUS;
+				filemap_invalidate_unlock_shared(mapping);
 				goto out;
 			}
+			filemap_invalidate_unlock_shared(mapping);
 		} else {
 			new_anon_folio = true;
 			folio_lock(folio);
@@ -6419,14 +6429,15 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     uffd_flags_t flags,
 			     struct folio **foliop)
 {
+	const int vm_shared = dst_vma->vm_flags & VM_SHARED;
+	const bool is_continue = uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE);
+	const bool alloc_pagecache_folio = vm_shared && !is_continue;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
-	bool is_continue = uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE);
 	bool wp_enabled = (flags & MFILL_ATOMIC_WP);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
 	unsigned long size = huge_page_size(h);
-	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
@@ -6454,6 +6465,18 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		return 0;
 	}
 
+	if (alloc_pagecache_folio) {
+		filemap_invalidate_lock_shared(mapping);
+		if (!hugetlb_pgoff_valid(mapping, idx, /* partial= */ false)) {
+			if (*foliop) {
+				folio_put(*foliop);
+				*foliop = NULL;
+			}
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+
 	if (is_continue) {
 		ret = -EFAULT;
 		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
@@ -6551,11 +6574,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		WARN_ON_ONCE(!folio_test_uptodate(folio));
 
 	/* Add shared, newly allocated pages to the page cache. */
-	if (vm_shared && !is_continue) {
-		ret = -EFAULT;
-		if (idx >= (i_size_read(mapping->host) >> huge_page_shift(h)))
-			goto out_release_nounlock;
-
+	if (alloc_pagecache_folio) {
 		/*
 		 * Serialization between remove_inode_hugepages() and
 		 * hugetlb_add_to_page_cache() below happens through the
@@ -6626,6 +6645,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	spin_unlock(ptl);
 	ret = 0;
 out:
+	if (alloc_pagecache_folio)
+		filemap_invalidate_unlock_shared(mapping);
 	return ret;
 out_release_unlock:
 	spin_unlock(ptl);
diff --git a/mm/memfd.c b/mm/memfd.c
index 0e3ff3eebfa82..f03d12aa71f7a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -96,6 +96,12 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
+		filemap_invalidate_lock_shared(memfd->f_mapping);
+		if (!hugetlb_pgoff_valid(memfd->f_mapping, idx, /* partial= */ true)) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+
 		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
 		if (nr_resv < 0) {
 			err = nr_resv;
@@ -131,6 +137,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 
 			hugetlb_set_folio_subpool(folio, subpool_inode(inode));
 			folio_unlock(folio);
+			filemap_invalidate_unlock_shared(memfd->f_mapping);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			return folio;
 		}
@@ -138,6 +145,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		if (nr_resv > 0)
 			hugetlb_unreserve_pages(inode, idx, idx + 1, 0);
 out_unlock:
+		filemap_invalidate_unlock_shared(memfd->f_mapping);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return ERR_PTR(err);
 	}

-- 
2.56.1

