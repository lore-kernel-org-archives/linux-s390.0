Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218572;
	b=OHoajzblJ9GH3wgdnN4T5b49O7ilxPkpGc9GAKpbcB2+YrlUPIASpQqn1Wpu3R/UdH6+
	 YnfYk+Y4XRqs6PugNVLIX9XO0DvvpIahpZZrCm2/qSQYALKEIHqBYdq/YhuV4xz1gCWdi
	 lVAIDFRA4afPb1hli6/rMhB7N7ZK6pLwUi1w5xEsOrTAj8PUU5Pw5seOPDXDBdGr+urdN
	 8eUAn6J1WLr5yGPCRxf1fBVxaGzztZtpwFg1053tbqZWbXbvSlAFYb2kgtc2I9IM34Bni
	 RgT+Yrot0f8j8iNSg3bJzxbP1BhufLqXzV7GQ6kF++jL6hPQgrBjxgOdbWOeVZzPMUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218572;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YYFSf//7LtffTEdaInzbKHoueC9GaQed5S2F6XZ2m8Q=;
	b=q+Je7Gd6Rjl1ZqHnZqR9Tx5nYKj0UazniFGYB286WvpD5Ntrf78mKeDLV4KRLEgVL64z
	 E9rRiD85P0i1cbYHllFMjH4JU38c4GJHh5sZV+81d04vXLP2Edno5875AIRjF06E1Wgvn
	 eSnze3NtPXkvB4TCfSOtDTau5vduhYVXykT3nTfo1dfjEdtgoskxXW9wM+C4OOL+/grCO
	 zS6zG+loxzyyIKT/ENrXs+ayLOuu+DxXrRqH4bIZ+VankMBK1MBKxwNiKQALDA1RcWax3
	 dNgVKoyMhAm0Il798mLqhx9GHC3vousRb5lPD0OeKh19vSmKdHrrlTbJLNOVYioqREA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXDJAgPT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC7606A325;
	Wed, 28 Oct 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXDJAgPT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993821F031E3;
	Wed, 28 Oct 2026 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218571;
	bh=YYFSf//7LtffTEdaInzbKHoueC9GaQed5S2F6XZ2m8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PXDJAgPThItJ1aq5M+pH6y01S76Edy6t/jgE9JP0iQsIF9nXJwPANyzgeHXcnCzWF
	 9WbU2KYGlA/tTolQyfpz20oxrC5B2r//RUN+yNwmW9Wrqafi4X8fIDUDQ1synTJy3/
	 IetUwhBWDYLfW7m65Xnxg3Ye1uWdNnj+3VPqcyWCGVb3pabDO9YhheA+EQpxBPtydQ
	 hpknUPoxwEvCPWikqi8AYruhvwd50gD9PjWLudMPCCN/HDdSlH41lFNNBngZUQtOBJ
	 yAF7CwsvjPbdRP34AY9K/fOGK+s/gKBeDChuUf6HSH/Gu5rOV95F8wd/fcjkp3e23U
	 s9nN+44+zXtHg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:42 +0100
Subject: [PATCH 14/15] RFC: mm/hugetlb: account restored reservations
 before freeing folios
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
Message-Id: <20261028-fixes_hugetlb-v1-14-a0a033db180f@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9868; i=david@kernel.org;
 h=from:subject:message-id; bh=d5+zn1Hn3o3pWcjYFV3JXLw3TGIm0oEZelvRVfl19MA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZcpaTl+82X3LJQ/n8zA23Qs4OK75d4RK3M4H2Q7v
 ntwIMino5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIl0BTD8U5Bcw/npDYNsFktN
 aNSUU7uPFB5ccnL9pbUF72Y9v+G4UY2RYYfriTulSxP83qYvtar3ebdPs9+rl7fTV32qsuyXfTU
 8fAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

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
pages to zero in that case, including for demotion, and limit surplus
releases to available pages so they cannot remove backing for remaining
reservations.

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
 Documentation/mm/hugetlbfs_reserv.rst |  5 +-
 mm/hugetlb.c                          | 90 ++++++++++++++++-------------------
 mm/hugetlb_internal.h                 | 11 +++++
 mm/hugetlb_sysfs.c                    |  2 +-
 4 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
index fbca6625ca50..4711029bd067 100644
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
index 69a5d2c73ee1..06ef8ba41df7 100644
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
 static unsigned long persistent_huge_pages(struct hstate *h)
 {
 	return h->nr_huge_pages - h->surplus_huge_pages - h->temporary_huge_pages;
@@ -2449,7 +2444,8 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * Part (or even all) of the reservation could have been backed
 	 * by pre-allocated pages. Only free surplus pages.
 	 */
-	nr_pages = min(unused_resv_pages, h->surplus_huge_pages);
+	nr_pages = min3(unused_resv_pages, h->surplus_huge_pages,
+			available_huge_pages(h));
 
 	/*
 	 * We want to release as many surplus pages as possible, spread
@@ -5313,6 +5309,45 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
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
@@ -5325,7 +5360,6 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	bool adjust_reservation;
 	unsigned long last_addr_mask;
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
@@ -5418,47 +5452,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
index 1d2f870deccf..d307d472137c 100644
--- a/mm/hugetlb_internal.h
+++ b/mm/hugetlb_internal.h
@@ -10,6 +10,17 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
 
+static inline unsigned long available_huge_pages(struct hstate *h)
+{
+	/*
+	 * Restored reservations may outnumber free folios until the folios
+	 * return to the pool.
+	 */
+	if (h->resv_huge_pages > h->free_huge_pages)
+		return 0;
+	return h->free_huge_pages - h->resv_huge_pages;
+}
+
 /*
  * Check if the hstate represents gigantic pages but gigantic page
  * runtime support is not available. This is a common condition used to
diff --git a/mm/hugetlb_sysfs.c b/mm/hugetlb_sysfs.c
index c89e4c847575..9e0c5d3d0fcb 100644
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

