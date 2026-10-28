Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218514;
	b=zaufZyV/XIVi+EZ9q+IqdAS6g/KqgcWdC3SnFBqBTd8+RqiIICAdI61CCjoq6rwhjb5u
	 wkMPVoZF+a/EeoJdmQ3M1Vew8qtpt/1JAsiJJIJW0Oc+Tl5QHCHRLHCFdUkGA9VfW+lrz
	 8eDAYDZKfSvBHaXS/MtzpXIxpC6OPrd8uoA4SShd/IOZ4najV7sC8N2Agowb45WIHucN5
	 5y/r//yDdOcsmApht9DESgcMnpqDMDd5TzcJdhS/22QEZO0MtzZGF0tKMxQ1d81ym+UxM
	 LWmlf5cK1lnktewktKoHDR12ezWtuVET9J2l0s0DPU9ddb1hOHGM3EXaodr6sc5RanA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218514;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fJbEER7vzoOAwM+mPhIWBPKSIqjL5RqV9BeY0Wx0m0k=;
	b=fXSAHJx7iTLu+mBl0NhdgTVio1LwGlB8FiGU+C7Mycy12eCNNhClHXj+i4/gvFA9444y
	 2b/wqWyHzoIDgLbgg2EHFc46W/cgd0kpkEncbPxWjqO6E1t8E3YLSCIMWy4d+L7X9j6xB
	 gmINQYnTksJOi+5hJUaUkBfFC/e+qZ6ZRyi/5Wb577WYRsUc+B1WVOf6U+HnLM+L60A4l
	 zvQJE3Abtlezra6aGhZAGVTnHvoeMnt0xcFXhak+8kpgoP+DvsRGYzjYs9ek8YpqxAv0u
	 G60STRn1dkc9z8Z9a2IWaeT6CskFkUm+l70p1uQG6ky27J7YZsniWfwAJ2ItoRVcTWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td2Z7PJG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5B606A32C;
	Wed, 28 Oct 2026 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td2Z7PJG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAD31F031E3;
	Wed, 28 Oct 2026 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218513;
	bh=fJbEER7vzoOAwM+mPhIWBPKSIqjL5RqV9BeY0Wx0m0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Td2Z7PJG1wX0MP4iiflVKGRwmNWuqcmTi3gw8+jfO++FuDSJUd8jjBn08UWi63J2/
	 dCwBF7cTzU+cDAKM1xEwzW27ENbq/S+6TUyModUEkC8t3WaBVhs9dLRDSYavM3TJrL
	 zUy4XIkMUUP3rmQ508pm7R88laRhAxA5YlQYRHrTfy7q3Iqm59XQCmNfFu9lJj3IbU
	 JNq8xmWN3pytmAbAP0jOr15Cf+kHTeNTSA8np8GJm1LlQ5IyK5o6CsnmE3FPSv8ib9
	 QUea7AijNxg6TKXgRg/V2eSNbMniprLfbK/epuh18x4BcTELCkHnzPQMknj3TsQqAY
	 N9CmUQEHWWcDQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:36 +0100
Subject: [PATCH 08/15] mm/hugetlb: serialize page-cache allocations with
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
Message-Id: <20261028-fixes_hugetlb-v1-8-a0a033db180f@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10950; i=david@kernel.org;
 h=from:subject:message-id; bh=KYQmOO3hIaWySsr+CMtBC6qneUQ6Sjm+iDm4MQVro9M=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZdp7N62Lknif5/HCuP7SbfPBy6J/TLn1RQf9u97p
 rCGMJmwdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARxUJGhtcXrtTlebiFflid
 m+u/lvv7is9PexamPMv3lul2shQ72cvI8OTN5zrB80vmHWDQnlN94HCa3W2Nph9etZuYW6vCp0r
 qcwMA
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
index fa367fc9e019..174455e10d0f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -545,10 +545,9 @@ static void remove_inode_single_folio(struct hstate *h, struct inode *inode,
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
@@ -622,7 +621,15 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
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
index d49cb15d13e6..2a3fde411d74 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -823,6 +823,18 @@ static inline unsigned huge_page_shift(struct hstate *h)
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
index 2fdd72897db8..7f240cd7dea0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5869,6 +5869,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm, unsigned
 static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			struct vm_fault *vmf)
 {
+	const bool pagecache_folio = vmf->vma->vm_flags & VM_MAYSHARE;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 	bool new_folio, new_anon_folio = false;
 	struct vm_area_struct *vma = vmf->vma;
@@ -5877,7 +5878,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	bool folio_locked = true;
 	struct folio *folio;
-	unsigned long size;
 	pte_t new_pte;
 
 	/*
@@ -5899,8 +5899,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	new_folio = false;
 	folio = filemap_lock_hugetlb_folio(h, mapping, vmf->pgoff);
 	if (IS_ERR(folio)) {
-		size = i_size_read(mapping->host) >> huge_page_shift(h);
-		if (vmf->pgoff >= size)
+		if (!hugetlb_pgoff_valid(mapping, vmf->pgoff, /* partial= */ false))
 			goto out;
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
@@ -5930,10 +5929,17 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
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
@@ -5954,13 +5960,15 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
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
@@ -5975,8 +5983,10 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
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
@@ -6401,14 +6411,15 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
@@ -6435,6 +6446,18 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
@@ -6532,11 +6555,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
@@ -6607,6 +6626,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	spin_unlock(ptl);
 	ret = 0;
 out:
+	if (alloc_pagecache_folio)
+		filemap_invalidate_unlock_shared(mapping);
 	return ret;
 out_release_unlock:
 	spin_unlock(ptl);
diff --git a/mm/memfd.c b/mm/memfd.c
index 0f6fff004f5e..4650a69aa7a6 100644
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
2.43.0

