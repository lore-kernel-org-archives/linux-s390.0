Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218533;
	b=kKf0b982wvMX+L5VbHbpx3QM+3uTRV84mt8KDAY7DWVM8NE5r7anXCDSBqdmPnkK1j6h
	 Q2DyKkkP9sTaP0Gz9Tmw59QjyKLQngLSXL+J91AfFIom/Olmk4acmuGeZz+Vh3rwKDRe3
	 17QnTo2WO/ba8qa5mdl3Gc51gyFcJcaoHQu1MUSBRmQrdL+iJz7vl5N/uNdlbW9s8BwYw
	 QMUeLw3XyqWxFdyyOBMS3izaf9UB3D2COcBURsoFn8lIqMLD1eiXHNrVReym51JzvxmTO
	 HlKMtNZO230i2rjYe7xHP10Bdj1ZFwx0K3CAuLt8zmSqpeDU7bnd21XviYs5qAzL+qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218533;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=U9COBRxd2nr1hsxeOTWoNKKoSqjE21lpsMn2gQskWh4=;
	b=ro5v3x4RhFKPLKNt/U4RgjhKWl27sa9DcBH3kw0Y2aDeVTPNKHnYUwYNdpGkU3uOJdWn
	 outZvYHTFJvbWgEc3stCME0OaAuOa+o04QeHp4zep8BAbVhPHQNx8cLQzC5F2pdO3/3+l
	 2Ksxw8KyQ4xHeee+gf+TqGiPtM6SItMaNIaxLQq4MNZ9j5bkJ7gPFUQOTFO1aPEpKUh8X
	 kOTd8aHAf82v9xPI97ZmtWIsXNI3gELwN2fN77H8N5damoKjjVNB6p+jOc9M03Y2qE6PJ
	 bQo2jsUMkTBxz7RyZgZdwgHlGD3MPlmgjx8RWu1wRb3P7FXeEVCeWLe1ftbHB61D15Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZX19F6g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC1606A31E;
	Wed, 28 Oct 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZX19F6g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E0A1F01829;
	Wed, 28 Oct 2026 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218532;
	bh=U9COBRxd2nr1hsxeOTWoNKKoSqjE21lpsMn2gQskWh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JZX19F6gA5CN+NMYFtdVEv0u3QnOUGu4iWEpYStl/W0tES+fgQpo5XoWs8s/oyEQ4
	 5qhQpyiyfFoxA0diKnC7Ridn6ph+eBszx7zbBu6XVtid/IwSi/8UMCYCbTHdnIfXV0
	 ily5aiaR+QrO4L8gmzXp8QI2G2G7HLkNK+3IyAGipcYBBKuU/6hlOxSxhVnKUu3C1N
	 k/R/piabG0DyjRO98AhejgbAJRB+eGPPqwh3X12RE+3UCPk71le1HzT6FVWKzS3d71
	 9iJGVrjneCkR/cjFZYglek6RUdg2xkxarsQANF1Nxj3L8UH3vo4iLKNuh71xlP6brj
	 Eu4gAp/l6J0nA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:38 +0100
Subject: [PATCH 10/15] mm/hugetlb: count again if the reserve map shrank
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
Message-Id: <20261028-fixes_hugetlb-v1-10-a0a033db180f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6749; i=david@kernel.org;
 h=from:subject:message-id; bh=PTBhJG9rK1MoJYbu6w43UaDUSDaQ1jMI/kOQ7J0Q9XI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZd96A/mnrj1mafNk5V9s88+3e72bYlGa5EST6/7t
 HKrLeKtHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzkhA7DH67bOwz3qO5uffyX
 d7/GX5MJ9082/tzyqNboxBFlr9OTKwQZGfZ/Mj8jeNPo9dG3Vvfvdm6bIXTmQo6Cho7z0sXcjbk
 R//kA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

hugetlb_reserve_pages() asks region_chg() how many pages of the range are
missing in the reserve map, charges the cgroup, the subpool and the pool
for that many, and then lets region_add() fill the gaps.

It copes with region_add() adding less, because a concurrent fault added
an entry in the meantime; however, it does not expect it to add more.

Since restore_reserve_on_error() can delete the entry of an allocation
that failed later on, entries also disappear without the inode lock that
mmap() holds. For a previously unreserved page, UFFDIO_COPY can do this
when the source is not resident: it allocates a folio, which adds the
entry, fails to copy with page faults disabled, and takes both back.
memfd_alloc_folio() does it when it has made a reservation and gets no
folio it may pin.

If region_chg() sees such an entry and region_add() does not, an entry is
added that nothing was charged for. When we later delete it,
we decrement resv_huge_pages and uncharge the cgroup once too often:

  WARNING: mm/page_counter.c:60 at page_counter_uncharge+0xe2/0x160

Similarly, HugePages_Rsvd will underflow.

Tell region_add() how much has been accounted for and let it refuse to
add more. Convert it to a region_add_limited() for that purpose.
hugetlb_reserve_pages() then undoes what it has done, as for any other
failure of region_add(), and starts again.

Note that we move hugetlb_vma_lock_free() so we can retain the allocated
VMA lock object as we retry.

Limit retries to 10 to avoid livelock under repeated concurrent rollbacks.
Return -ENOMEM if the retries are exhausted.

Fixes: 846be08578ed ("mm/hugetlb: expand restore_reserve_on_error functionality")
Cc: stable@kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 58 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7f240cd7dea0..06d2a78c7170 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -735,26 +735,36 @@ static int allocate_file_region_entries(struct resv_map *resv,
  * region_del.  The extra needed entries will be allocated.
  *
  * regions_needed is the out value provided by a previous call to region_chg.
+ * limit is what the caller has accounted for.  If more huge pages would have
+ * to be added, because somebody has deleted from the range since region_chg,
+ * nothing is added and -EAGAIN is returned.
  *
  * Return the number of new huge pages added to the map.  This number is greater
  * than or equal to zero.  If file_region entries needed to be allocated for
  * this operation and we were not able to allocate, it returns -ENOMEM.
- * region_add of regions of length 1 never allocate file_regions and cannot
- * fail; region_chg will always allocate at least 1 entry and a region_add for
- * 1 page will only require at most 1 entry.
+ * Ranges of length 1 never require allocating file_regions and cannot fail
+ * if limit is at least 1; region_chg will always allocate at least 1 entry
+ * and adding 1 page will only require at most 1 entry.
  */
-static long region_add(struct resv_map *resv, long f, long t,
-		       long in_regions_needed, struct hstate *h,
-		       struct hugetlb_cgroup *h_cg)
+static long region_add_limited(struct resv_map *resv, long f, long t,
+		long in_regions_needed, struct hstate *h,
+		struct hugetlb_cgroup *h_cg, long limit)
 {
 	long add = 0, actual_regions_needed = 0;
 
 	spin_lock(&resv->lock);
 retry:
 
-	/* Count how many regions are actually needed to execute this add. */
-	add_reservation_in_range(resv, f, t, NULL, NULL,
-				 &actual_regions_needed);
+	/*
+	 * Count how many regions are actually needed to execute this add.
+	 * Fail if the number of huge pages to add exceeds limit.
+	 */
+	add = add_reservation_in_range(resv, f, t, NULL, NULL,
+				       &actual_regions_needed);
+	if (add > limit) {
+		spin_unlock(&resv->lock);
+		return -EAGAIN;
+	}
 
 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -790,6 +800,13 @@ static long region_add(struct resv_map *resv, long f, long t,
 	return add;
 }
 
+static long region_add(struct resv_map *resv, long f, long t,
+		long in_regions_needed, struct hstate *h,
+		struct hugetlb_cgroup *h_cg)
+{
+	return region_add_limited(resv, f, t, in_regions_needed, h, h_cg, t - f);
+}
+
 /*
  * Examine the existing reserve map and determine how many
  * huge pages in the specified range [f, t) are NOT currently
@@ -6828,7 +6845,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;
-	int err;
+	int err, retries = 0;
 
 	/* This should never happen */
 	if (from > to) {
@@ -6850,6 +6867,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (vma_flags_test(&vma_flags, VMA_NORESERVE_BIT))
 		return 0;
 
+retry:
 	/*
 	 * Shared mappings base their reservation on the number of pages that
 	 * are already allocated on behalf of the file. Private mappings need
@@ -6928,7 +6946,8 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma_test(vma, VMA_MAYSHARE_BIT)) {
-		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
+		add = region_add_limited(resv_map, from, to, regions_needed, h,
+					 h_cg, chg);
 
 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
@@ -6991,17 +7010,28 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	hugetlb_vma_lock_free(vma);
-	if (!vma || vma_test(vma, VMA_MAYSHARE_BIT))
+	if (!vma || vma_test(vma, VMA_MAYSHARE_BIT)) {
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+		/*
+		 * A concurrent rollback removed entries after region_chg()
+		 * counted the range, so we charged for too few pages and
+		 * have to recount, recharge, and try again. Limit retries
+		 * to avoid livelock under repeated rollbacks.
+		 */
+		if (err == -EAGAIN) {
+			if (retries++ < 10)
+				goto retry;
+			err = -ENOMEM;
+		}
+	} else if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
 		set_vma_resv_map(vma, NULL);
 	}
+	hugetlb_vma_lock_free(vma);
 	return err;
 }
 

-- 
2.43.0

