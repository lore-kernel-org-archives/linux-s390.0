Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873371;
	b=AWuQbmDMGFSU2OdS9clvftistzD78mGJAgBzC84dFaclh5nQ0A+vhnlR2pH8uuhFXyJT
	 FEOdM0EtdwRds3iKbDuJY14cuDunwwdoTeUXd2+80sv3wtKvu5pPhw3neTK8+AIHqB7IS
	 fCDMB/8DTzaZnrhLd0UkABiAwD3MfCFSt9VZ4G0RaCo8bREd2w7nSXzaQ/OCKwV65DSpK
	 voFw8ld+qQW0QHDPU2pOQg2hfmpDtQG1YFXyULCtE+dAxXvSJCpigFsyHaBCGARrTurv/
	 veae/aAMZeRai8MJwRhGbM0nsNLbqastNIEUOHxad9mXGVwt7o4pCpOzlnXvlYwUfgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873371;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4Tk/v5gpTzKwsLKVRDGmpxrkowLSDGRraIN5KwKGaZM=;
	b=W7hqOLmtWnFOuPU+g3GsC9ZSP6+WrLQzefMW8hf8qSiQXq2aeOQcK160A2zHJSIzRzYa
	 bNlrpQyAS4F/S4wlyVYE6q0I6piMw8CUrT0jBBGUqgXCM3402WRSj3n2bVCTV/XoHPTPO
	 i3WfLClnpGMqM/QImkrTSBvUBRurzjanQkPTVFVhFlbeWh7WlQSBSWzFWwPo47Z0vUKbI
	 CJfFDMZVW3wlkHvkx97SCpY7AJUBne6EhTsLZD8hP25wl9V1DqLihNaqWZfyv7Pco0jzP
	 CBw3GbSzC/37JDKzbIx9B+TO4M8cNjHfEiBZmx4Iya33N2U431uT5or/ruF2V8CW0ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4zualqR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA54606CC83;
	Thu,  5 Nov 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4zualqR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91B61F000C1;
	Thu,  5 Nov 2026 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873370;
	bh=4Tk/v5gpTzKwsLKVRDGmpxrkowLSDGRraIN5KwKGaZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O4zualqRqzYR6q5TBp4RDY3Uev/qbLZYiqUSoShmgrVeIODLmDxMX+fNk80bYYcYm
	 HTxinqnpmG5SGB6VnDLYOUQsvXKbJuW90v70RKjYSQz/Royvgh7H5JCKtJnMB3uMXT
	 11FbBUWJlPOLWbug7+PgRqodAt4jjZsIQjC+Kmh4wvy99Nf/XJyRKLTH/dYsUtQ5kH
	 wdAnOVAMcGbT+bncBO3/Her8uDVGmGT9rh5On28u8ZOZ0iViXL6ea6DeW7X2B6+XaZ
	 jOdA3FTeCV2f64CLakn4dMPqLdtKaL5FKlIGDYK4zVit2UcvYM2uWxqlV/bydKinG3
	 MNKcdrYIUe9mg==
Message-ID: <1fb90b76-0691-49b4-a9e3-5292d1765c48@kernel.org>
Date: Thu, 5 Nov 2026 11:09:16 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] RFC: mm/hugetlb: account restored reservations
 before freeing folios
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Dave Airlie <airlied@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-14-a0a033db180f@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261028-fixes_hugetlb-v1-14-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 21:13, David Hildenbrand (Arm) wrote:
> Unmapping an anonymous folio restores its private VMA reservation
> immediately, but the global reservation count is only restored when the
> folio is freed.
> 
> If any folio reference delays freeing, closing the VMA or refaulting can
> decrement resv_huge_pages before it was incremented. This can underflow
> the counter or hide another mapping's reservation, allowing an unreserved
> allocation to consume its backing.
> 
> Increment resv_huge_pages when restoring the reserve map instead. Detach
> the folio from its subpool, since the restored reservation now owns that
> charge. Leave the restore-reserve flag clear so freeing the folio does not
> repeat the accounting. The folio only becomes free after its last reference
> is dropped.
> 
> Reservations can now temporarily outnumber free folios. Clamp available
> pages to zero in that case, including for demotion, and limit surplus
> releases to available pages so they cannot remove backing for remaining
> reservations.
> 
> Restore reservations even when surplus pages exist. free_huge_folio()
> already retains pages needed to back them. It is unclear why that was
> really added. The comment about i_mmap_lock_write can go as well, that
> doesn't really help for anonymous folios.
> 
> Two existing problems remain:
> 
> 1) Anonymous hugetlb migration temporarily drops the mapcount. A concurrent
>    unmap can observe zero and restore a reservation even though migration
>    will reinstall a mapping. i_mmap_lock_write() does not protect anonymous
>    folio mapcounts, so it does not prevent this race. This change fixes the
>    resulting counter underflow, but leaves premature restoration possible,
>    leading to (2). Maybe that anon_vma lock can help?
> 
> 2) A fault can allocate a replacement folio using the restored
>    reservation before the old folio is freed. Repeated vmsplice(),
>    MADV_DONTNEED and refaults can retain multiple folios for one
>    reservation and consume pages backing other reservations. This was
>    already possible; counter accounting is now fixed, but early reuse
>    remains. Removing the surplus check also allows it after unmaps that
>    previously skipped restoration.
> 
> Deferring reservation-map restoration until the final put is tricky:
> free_huge_folio() has no VMA context to update the private reserve map, and
> that VMA may already have been destroyed.
> 
> Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

This is the current updated patch I have:

From 8597f47aef9cbd7669ad893908b1218c2769469b Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 17:33:54 +0100
Subject: [PATCH] RFC: mm/hugetlb: account restored reservations before freeing
 folios

Unmapping an anonymous folio restores its private VMA reservation
immediately, but the global reservation count is only restored when the
folio is freed.

If any folio reference delays freeing, closing the VMA or refaulting can
decrement resv_huge_pages before it was incremented. This can underflow
the counter or hide another mapping's reservation, allowing an unreserved
allocation to consume its backing.

Increment resv_huge_pages when restoring the reserve map instead. Detach
the folio from its subpool, since the restored reservation now owns that
charge. Leave the restore-reserve flag clear so freeing the folio does not
repeat the accounting. The folio only becomes free after its last reference
is dropped.

Reservations can now temporarily outnumber free folios. Clamp available
pages to zero in that case, including for demotion, and limit releases of
pooled surplus pages to that availability so they cannot remove backing
for remaining reservations.

Use the same clamped availability when gathering surplus pages for a new
reservation. An existing deficit can be backed by unmapped folios that
are still referenced, so do not allocate replacement backing for it as
part of the new request. Otherwise, the request can allocate unnecessary
surplus pages or fail even when the overcommit limit has room for the new
reservation.

Free unused or aborted surplus allocations directly instead of passing
them to free_huge_folio(), which could retain them to cover the existing
deficit. These isolated folios have not backed any committed reservation.
Preserve pages promoted to persistent capacity by a concurrent pool resize,
and use the bulk freeing path to retain vmemmap restoration error handling.

Restore reservations even when surplus pages exist. free_huge_folio()
already retains pages needed to back them. It is unclear why that was
really added. The comment about i_mmap_lock_write can go as well, that
doesn't really help for anonymous folios.

Two existing problems remain:

1) Anonymous hugetlb migration temporarily drops the mapcount. A concurrent
   unmap can observe zero and restore a reservation even though migration
   will reinstall a mapping. i_mmap_lock_write() does not protect anonymous
   folio mapcounts, so it does not prevent this race. This change fixes the
   resulting counter underflow, but leaves premature restoration possible,
   leading to (2). Maybe that anon_vma lock can help?

2) A fault can allocate a replacement folio using the restored
   reservation before the old folio is freed. Repeated vmsplice(),
   MADV_DONTNEED and refaults can retain multiple folios for one
   reservation and consume pages backing other reservations. This was
   already possible; counter accounting is now fixed, but early reuse
   remains. Removing the surplus check also allows it after unmaps that
   previously skipped restoration.

Deferring reservation-map restoration until the final put is tricky:
free_huge_folio() has no VMA context to update the private reserve map, and
that VMA may already have been destroyed.

Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/mm/hugetlbfs_reserv.rst |   5 +-
 mm/hugetlb.c                          | 125 ++++++++++++++------------
 mm/hugetlb_internal.h                 |  24 +++++
 mm/hugetlb_sysfs.c                    |   2 +-
 4 files changed, 95 insertions(+), 61 deletions(-)

diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
index fbca6625ca50d..4711029bd067d 100644
--- a/Documentation/mm/hugetlbfs_reserv.rst
+++ b/Documentation/mm/hugetlbfs_reserv.rst
@@ -34,7 +34,8 @@ resv_huge_pages
 	This is a global (per-hstate) count of reserved huge pages.  Reserved
 	huge pages are only available to the task which reserved them.
 	Therefore, the number of huge pages generally available is computed
-	as (``free_huge_pages - resv_huge_pages``).
+	as (``free_huge_pages - resv_huge_pages``), clamped to zero when
+	reservations outnumber free huge pages.
 Reserve Map
 	A reserve map is described by the structure::
 
@@ -155,7 +156,7 @@ are enough free huge pages to accommodate the reservation.  If there are,
 the global reservation count resv_huge_pages is adjusted something like the
 following::
 
-	if (resv_needed <= (free_huge_pages - resv_huge_pages)
+	if (resv_needed <= available_huge_pages(h))
 		resv_huge_pages += resv_needed;
 
 Note that the global lock hugetlb_lock is held when checking and adjusting
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ee77994e31970..0a10d18c90c23 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1347,11 +1347,6 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	return NULL;
 }
 
-static unsigned long available_huge_pages(struct hstate *h)
-{
-	return h->free_huge_pages - h->resv_huge_pages;
-}
-
 static unsigned long persistent_huge_pages(const struct hstate *h)
 {
 	return h->nr_huge_pages - h->surplus_huge_pages - h->temporary_huge_pages;
@@ -2317,11 +2312,13 @@ static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
  */
 static long surplus_pages_needed(struct hstate *h, long delta, long allocated)
 {
-	long global_free = (long)h->free_huge_pages + allocated;
-	long allowed_free = (long)allowed_mems_nr(h) + allocated;
+	const long available = min(available_huge_pages(h), allowed_mems_nr(h));
 
-	return max((long)h->resv_huge_pages + delta - global_free,
-		   delta - allowed_free);
+	/*
+	 * Restored reservations can still be backed by folios that were not
+	 * freed yet.
+	 */
+	return delta - available - allocated;
 }
 
 /*
@@ -2332,6 +2329,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
 	LIST_HEAD(surplus_list);
+	LIST_HEAD(free_list);
 	struct folio *folio, *tmp;
 	int ret;
 	long i;
@@ -2411,14 +2409,26 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		enqueue_hugetlb_folio(h, folio);
 	}
 free:
-	spin_unlock_irq(&hugetlb_lock);
-
 	/*
-	 * Free unnecessary surplus pages to the buddy allocator.
-	 * Pages have no ref count, call free_huge_folio directly.
+	 * These folios are not required for any reservation. Don't use
+	 * free_huge_folio(), otherwise it might decide to keep them for
+	 * reservations that were restored before the original folios were
+	 * freed.
 	 */
-	list_for_each_entry_safe(folio, tmp, &surplus_list, lru)
-		free_huge_folio(folio);
+	list_for_each_entry_safe(folio, tmp, &surplus_list, lru) {
+		/*
+		 * If the pool was resized concurrently, these folios might now
+		 * count as persistent and we must keep them.
+		 */
+		if (!h->surplus_huge_pages_node[folio_nid(folio)]) {
+			enqueue_hugetlb_folio(h, folio);
+			continue;
+		}
+		remove_hugetlb_folio(h, folio, true);
+		list_add(&folio->lru, &free_list);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+	update_and_free_pages_bulk(h, &free_list);
 	spin_lock_irq(&hugetlb_lock);
 
 	return ret;
@@ -2449,7 +2459,8 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * Part (or even all) of the reservation could have been backed
 	 * by pre-allocated pages. Only free surplus pages.
 	 */
-	nr_pages = min(unused_resv_pages, h->surplus_huge_pages);
+	nr_pages = min3(unused_resv_pages, h->surplus_huge_pages,
+			available_huge_pages(h));
 
 	/*
 	 * We want to release as many surplus pages as possible, spread
@@ -5313,6 +5324,45 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	return len + old_addr - old_end;
 }
 
+/* Must be called after rmap removal. */
+static void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
+		struct folio *folio)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long address;
+	long rc;
+
+	/*
+	 * Restore only on the last unmap, otherwise the owner could reuse
+	 * the reservation while the folio is still mapped by a child.
+	 *
+	 * TODO: Handle migration temporarily dropping the mapcount to zero.
+	 * TODO: Prevent reservation reuse before the folio is freed.
+	 */
+	if (!folio_test_anon(folio) || !__vma_private_lock(vma) ||
+	    folio_mapped(folio))
+		return;
+
+	address = vma_anon_address(vma, folio->index, 1);
+	rc = vma_needs_reservation(h, vma, address);
+	if (!rc)
+		vma_end_reservation(h, vma, address);
+	if (rc <= 0)
+		return;
+
+	rc = vma_add_reservation(h, vma, address);
+	if (rc < 0)
+		return;
+
+	/* The restored reservation owns the subpool charge. */
+	hugetlb_set_folio_subpool(folio, NULL);
+
+	/* Account before the VMA can close or fault again. */
+	spin_lock_irq(&hugetlb_lock);
+	h->resv_huge_pages++;
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
 			    struct folio *folio, zap_flags_t zap_flags)
@@ -5325,7 +5375,6 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	bool adjust_reservation;
 	unsigned long last_addr_mask;
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
@@ -5418,47 +5467,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		hugetlb_remove_rmap(folio);
 		spin_unlock(ptl);
 
-		/*
-		 * Restore the reservation for anonymous page, otherwise the
-		 * backing page could be stolen by someone. Restore only on the
-		 * last unmap, otherwise the owner could empty its resv map
-		 * while the folio is still mapped by a child. Note that holding
-		 * i_mmap_lock_write is needed to check the number of mappings.
-		 * If there we are freeing a surplus, do not set the restore
-		 * reservation bit.
-		 */
-		adjust_reservation = false;
-
-		spin_lock_irq(&hugetlb_lock);
-		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
-		    !folio_mapped(folio) && folio_test_anon(folio)) {
-			folio_set_hugetlb_restore_reserve(folio);
-			/* Reservation to be adjusted after the spin lock */
-			adjust_reservation = true;
-		}
-		spin_unlock_irq(&hugetlb_lock);
-
-		/*
-		 * Adjust the reservation for the region that will have the
-		 * reserve restored. Keep in mind that vma_needs_reservation() changes
-		 * resv->adds_in_progress if it succeeds. If this is not done,
-		 * do_exit() will not see it, and will keep the reservation
-		 * forever.
-		 */
-		if (adjust_reservation) {
-			int rc = vma_needs_reservation(h, vma, address);
-
-			if (rc < 0)
-				/* Presumably allocate_file_region_entries failed
-				 * to allocate a file_region struct. Clear
-				 * hugetlb_restore_reserve so that global reserve
-				 * count will not be incremented by free_huge_folio.
-				 * Act as if we consumed the reservation.
-				 */
-				folio_clear_hugetlb_restore_reserve(folio);
-			else if (rc)
-				vma_add_reservation(h, vma, address);
-		}
+		hugetlb_folio_restore_rsv_on_unmap(vma, folio);
 
 		tlb_remove_page_size(tlb, folio_page(folio, 0),
 				     folio_size(folio));
diff --git a/mm/hugetlb_internal.h b/mm/hugetlb_internal.h
index 1d2f870deccfe..201028e08a46a 100644
--- a/mm/hugetlb_internal.h
+++ b/mm/hugetlb_internal.h
@@ -10,6 +10,30 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
 
+/**
+ * available_huge_pages - number of free huge pages not needed for reservations
+ * @h: huge page size state
+ *
+ * Global number of free huge pages that are not needed for existing
+ * reservations, available for allocations without reservations. Things like
+ * NUMA placement, cpusets, mempolicy and the usability of individual folios can
+ * further restrict allocation.
+ *
+ * Reservations of anon folios may be restored before their backing folios are
+ * actually freed, so the number of reserved pages can be bigger than the
+ * number of free pages. In such a scenario, the result is clamped to 0.
+ *
+ * Return: The number of free huge pages not needed for reservations.
+ */
+static inline unsigned long available_huge_pages(const struct hstate *h)
+{
+	lockdep_assert_held(&hugetlb_lock);
+
+	if (h->resv_huge_pages > h->free_huge_pages)
+		return 0;
+	return h->free_huge_pages - h->resv_huge_pages;
+}
+
 /*
  * Check if the hstate represents gigantic pages but gigantic page
  * runtime support is not available. This is a common condition used to
diff --git a/mm/hugetlb_sysfs.c b/mm/hugetlb_sysfs.c
index c89e4c8475756..9e0c5d3d0fcb6 100644
--- a/mm/hugetlb_sysfs.c
+++ b/mm/hugetlb_sysfs.c
@@ -211,7 +211,7 @@ static ssize_t demote_store(struct kobject *kobj,
 		 * Check for available pages to demote each time thorough the
 		 * loop as demote_pool_huge_page will drop hugetlb_lock.
 		 */
-		nr_available = h->free_huge_pages - h->resv_huge_pages;
+		nr_available = available_huge_pages(h);
 		if (nid != NUMA_NO_NODE)
 			nr_available = min(nr_available,
 					   h->free_huge_pages_node[nid]);
-- 
2.43.0


-- 
Cheers,

David
