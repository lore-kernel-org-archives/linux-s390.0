Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218562;
	b=bNK2k5tFyrTBnhrVzwOgOq3qBmy5yUQGjep0n7sy+kTDx7y7dCxhCV6T0xBcD+lFrBp0
	 MFz4g9ew3bOse6vG4dK3ytVMsx3TGxSJjoKq9aE0ekoeUi5PTKY5eg5f8eNziMTx/r1DO
	 xJI6pw3NSGBJUWn4Jw8I181ePYjKHxC+kvbpGYwKKXWzbqGRuXcP0nxHYbbGCbeHlM5yB
	 1ZfHgh62dcq8brg5r4HVHKRTl82TjclzsU/NB7Umt4Dim9uxDGBFWEO43qNYxMFvnwXLz
	 FecbbUj04mU/RakhmjpfxwJ5nSvOs0vYIWb+TNIOWrxe0/Uddr7bf35NmmpYkeUY+2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218562;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FQrXG0hBF/E00y3DiV9ZkP9WeaYq+wc3xIIhWYQpVjE=;
	b=5m14kXsVOl+3RdC7Q7Haivd2plSSPX71zNcEehlOiT8/1AbZd48JDgtJTSKMhBdJV8Y1
	 jgqXrc3ZN2cp10L3+2smdReyV6QM0hZxBUv5tjAGInotOmMxP3sfbnXusfJtURjcjmLIy
	 7cgxMNRlM5heeoV8O40Gp9gt5w7W0bDhRkF9i47LZvvvW6fEujo/GrR+ylzD6czkDT2+j
	 o46DNrieB342zBwVcGUN2DcCAAxZ2YNDUFIImj8EA3xVE7OUH8wXHS9+6ugvCBSEqhIlw
	 l0mm3+wi8f1nfwKWFoeiEWn0e2ghEMSEzZUrIWU4cb+ryCbWpakldf9dMAAuyNBcM9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ln9Nsz11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36842606A31E;
	Wed, 28 Oct 2026 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ln9Nsz11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE56E1F031E2;
	Wed, 28 Oct 2026 20:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218562;
	bh=FQrXG0hBF/E00y3DiV9ZkP9WeaYq+wc3xIIhWYQpVjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ln9Nsz11sQSofutgxCUth7eaiTXOM7ZZxeJJKJ5Aw4dW6zrblyRc0iIrcbIxTCryl
	 xyO9loKu6fYLkrAG7zRt0vsz3FH5w3yE7ICju/XFbkMXi+837UZXvZeaLdIww+RGFZ
	 0d31jdKKOX2umFntPBR+P6Lx8a4+PE4Lmp10RPbbUdtVDf94o18xpFWyYc7qiKP1ct
	 H9ysoaHkC5/gtcOVKwNhD2M9kahhlowYq+PKzUJbxmCqsHtY0G17/PrUcLj6g+pMxv
	 IrVv7XcLsK3VDroPQCB8hlyf2/p74TQdFmp7Pl8YUPygWvcfwU+KbwumpactCA0GM/
	 c6P6Ktl/wChHw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:41 +0100
Subject: [PATCH 13/15] mm/hugetlb: fix reservation leak on min_size= mounts
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
Message-Id: <20261028-fixes_hugetlb-v1-13-a0a033db180f@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8867; i=david@kernel.org;
 h=from:subject:message-id; bh=hPeu4XFgIxpqptAMkVO/zQ+wRyE3vH8v83lPlAJo1KQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZddj5v/28pLazLju38WcotL8zqZZK9Vb33MsbdD1
 f3ft7/vOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiIqDDDP8293Yk9C+dHbhLM
 vVzVn7ZpvWNfWqyste1rlSqmazmTvzMyHO/OKbnLy68ewiobHbuvpOrS78IaX5lVkQ73TwRZXFN
 iAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Failed allocations for CoW mappings can leak reservations on hugetlbfs
mounts with min_size= and no size=. The leaked reservations survive
unmount.

HPG_restore_reserve makes free_huge_folio() restore the global
reservation without returning it to the subpool. This assumes the
reserve map holds the reservation. However, a CoW mapping may have no
reserve map, or the map may already account for another folio at the
same index.

Commit 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking
folio from subpool") allowed owner CoW allocations to consume subpool
reservations. Commit 51e1de00acdb ("mm/hugetlb: simplify
vma_has_reserves()") later extended this to CoW mappings without a
reserve map.

For example, with a subpool minimum of one page and a
MAP_PRIVATE|MAP_NORESERVE mapping:

                                      subpool       global
                                      rsv_hpages    resv_huge_pages
  1. Mount                             1             1
  2. Allocate using subpool reserve    0             0
  3. Free on error with flag set       0             1
  4. Allocate without a reservation    0             1
  5. Free and return to subpool        1             2

Call folio_clear_hugetlb_restore_reserve() for CoW mappings when
map_chg != MAP_CHG_REUSE, meaning no reserve-map reservation was consumed.
This lets free_huge_folio() return subpool reservations to the subpool
on error.

Do not set the flag again if region-cache allocation fails during
rollback: that would undo the flag clearing and skip returning the
reservation to the subpool. This also fixes the older case where setting
the flag invents a reservation for an unreserved allocation for a CoW
mapping.

The doc still mentions PagePrivate at various places: future work should
clean that up.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 846be08578ed ("mm/hugetlb: expand restore_reserve_on_error functionality")
Fixes: 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking folio from subpool")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify comments and improve description; updated Fixes ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/mm/hugetlbfs_reserv.rst | 25 ++++++++++++++-----------
 include/linux/hugetlb.h               |  2 ++
 mm/hugetlb.c                          | 34 +++++++++++++++-------------------
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
index a49115db18c7..fbca6625ca50 100644
--- a/Documentation/mm/hugetlbfs_reserv.rst
+++ b/Documentation/mm/hugetlbfs_reserv.rst
@@ -201,10 +201,10 @@ The value returned from vma_needs_reservation() is generally
 If a reservation does not exist, and there is a subpool associated with the
 mapping the subpool is consulted to determine if it contains reservations.
 If the subpool contains reservations, one can be used for this allocation.
-However, in every case the avoid_reserve argument overrides the use of
-a reservation for the allocation.  After determining whether a reservation
-exists and can be used for the allocation, the routine dequeue_huge_page_vma()
-is called.  This routine takes two arguments related to reservations:
+However, avoid_reserve only applies to reservations from the reservation map.
+After determining whether a reservation exists and can be used for the
+allocation, the routine dequeue_huge_page_vma() is called.  This routine takes
+two arguments related to reservations:
 
 - avoid_reserve, this is the same value/argument passed to
   alloc_hugetlb_folio().
@@ -256,6 +256,10 @@ compensate.  See the section
 :ref:`Reservation Map Helper Routines <resv_map_helpers>` for more
 information on these routines.
 
+For CoW mappings, alloc_hugetlb_folio() calls
+folio_clear_hugetlb_restore_reserve() if the reservation came from the subpool.
+This makes free_huge_folio() return the reservation to the subpool on error.
+
 
 Instantiate Huge Pages
 ======================
@@ -284,14 +288,13 @@ be adjusted (see the section
 :ref:`Consuming Reservations/Allocating a Huge Page <consume_resv>`
 for information on how these are set).
 
-The routine first calls hugepage_subpool_put_pages() for the page.  If this
-routine returns a value of 0 (which does not equal the value passed 1) it
-indicates reserves are associated with the subpool, and this newly free page
-must be used to keep the number of subpool reserves above the minimum size.
-Therefore, the global resv_huge_pages counter is incremented in this case.
+If folio_test_hugetlb_restore_reserve() is false, hugepage_subpool_put_pages()
+returns the page to the subpool.  A return value of 0 means the page must restore
+a subpool reservation, so the global resv_huge_pages counter is incremented.
 
-If the PagePrivate flag was set in the page, the global resv_huge_pages counter
-will always be incremented.
+Otherwise, resv_huge_pages is incremented without calling
+hugepage_subpool_put_pages(): the restored reservation still counts as used in
+the subpool.
 
 .. _sub_pool_resv:
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2a3fde411d74..badb8790653e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -593,6 +593,8 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
  *	allocation time.  Cleared when page is fully instantiated.  Free
  *	routine checks flag to restore a reservation on error paths.
+ *	Cleared when allocating for a CoW mapping using a subpool
+ *	reservation, which the free routine returns to the subpool.
  *	Synchronization:  Examined or modified by code that knows it has
  *	the only reference to page.  i.e. After allocation but before use
  *	or when the page is being freed.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 32ecac4e0d3e..69a5d2c73ee1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2631,7 +2631,7 @@ static long vma_del_reservation(struct hstate *h,
  * 1) A reservation was in place and the folio consumed the reservation.
  *    hugetlb_restore_reserve is set in the folio.
  * 2) No reservation was in place for the page, so hugetlb_restore_reserve is
- *    not set.  However, alloc_hugetlb_folio always updates the reserve map.
+ *    not set.  However, alloc_hugetlb_folio may have updated the reserve map.
  *
  * In case 1, free_huge_folio later in the error path will increment the
  * global reserve count.  But, free_huge_folio does not have enough context
@@ -2641,6 +2641,10 @@ static long vma_del_reservation(struct hstate *h,
  * reserve map indicates there is a reservation present.
  *
  * In case 2, simply undo reserve map modifications done by alloc_hugetlb_folio.
+ *
+ * For CoW mappings, allocations using a subpool reservation leave the
+ * flag clear and the reserve map unchanged.  free_huge_folio returns the
+ * reservation to the subpool.
  */
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			unsigned long address, struct folio *folio)
@@ -2688,25 +2692,9 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				folio_set_hugetlb_restore_reserve(folio);
 		} else if (rc < 0) {
 			/*
-			 * Rare out of memory condition from
-			 * vma_needs_reservation call.  Memory allocation is
-			 * only attempted if a new entry is needed.  Therefore,
-			 * this implies there is not an entry in the
-			 * reserve map.
-			 *
-			 * For shared mappings, no entry in the map indicates
-			 * no reservation.  We are done.
+			 * Region cache allocation can fail even if an entry exists.
+			 * Leave the flag and reserve map unchanged.
 			 */
-			if (!(vma->vm_flags & VM_MAYSHARE))
-				/*
-				 * For private mappings, no entry indicates
-				 * a reservation is present.  Since we can
-				 * not add an entry, set hugetlb_restore_reserve
-				 * on the folio so reserve count will be
-				 * incremented when freed.  This reserve will
-				 * be consumed on a subsequent allocation.
-				 */
-				folio_set_hugetlb_restore_reserve(folio);
 		} else {
 			/*
 			 * No reservation present, do nothing
@@ -3161,6 +3149,14 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
+	/*
+	 * Return subpool reservations to the subpool on error. A CoW mapping
+	 * might not have a reserve map, or it might already account for
+	 * another folio at this index.
+	 */
+	if (map_chg != MAP_CHG_REUSE && vma_is_cow_mapping(vma))
+		folio_clear_hugetlb_restore_reserve(folio);
+
 	return folio;
 
 out_subpool_put:

-- 
2.43.0

