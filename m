Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853881;
	b=EkH10Hh9lD3OzsrZtAH/UiRg3Gmgh1hli9tq0oNfKAZ+WiH54snXoEwviRu8KhVDmbwB
	 EM1tmf2YIbVjs/wQ3sotvVhByTQWmAw4xNgsjOF07fQXxtUxZELnmIeXJQ9cRlQ3LXbvF
	 D6G4e0Dayf1RejKFXrzkYpJXyxVVLGLFsTajijq/MBmH6kiOokorvQmQ2ZmOLrf7w9Gii
	 AGweovhxaXjgSdUYdv+ivSqrUivegLjSV2SOjd5cZRR0ZkKHox13MLdyfDxcrx6WuNsUV
	 1Xv3AXRIb+xHK2HNXJE12lLSLIEG3lhxo6vK2AKIjqZJA2CpEF22Ox8w9oQoB3VEAJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853881;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ll3asYuiuZ79eATlz0yEAcompJfGJnlC9CkPVberbcg=;
	b=FKgRnTxZyNqfZ4DTELLadYDW2zYzvsmNo24CzEttFzQI/1YBGmGQz/w3tmyzgA8K8Gdj
	 fnRjty8E4QsBqdOyTvyYV0N8BQWX9gGp3JH6sUT1K5czZHjpiCKBsqldCpm2wPzBgxtfN
	 msCYUF6hhy0D4tBR5+tlGw+jqh3MQjM+9LVt6hW/7eZR6ks2gsXUat0JxDTcrc6xUFyEg
	 aFuKl9l2TugXonOlmfmSC+dUEY9HSBequxoYQuMr33hbZ5jf28rOZdod3OLctg6DLG2My
	 2of10FIbewbIbEG/g0vAC3/G1QlFnGdgNd3tTyKp+tAFkmfnqZ42QTXIcgvEmKSo7Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aV6LHwkJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044BC606A32C;
	Mon, 16 Nov 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aV6LHwkJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC6A1F000C9;
	Mon, 16 Nov 2026 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853880;
	bh=ll3asYuiuZ79eATlz0yEAcompJfGJnlC9CkPVberbcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aV6LHwkJ65YIOBZzlGD2MLT816Fhf7JiPdkgh9tZNaCgbT8HNSC1K9+I4/0gjqRK1
	 cVt8ZI5h9r0Br8OUrwGsPOtMHUlWnvTED5hkhFLCzMSpz7x2xIK4uE4P0JSSNzfUmG
	 24Yqjo6x0GHwxY9K7LZPpKqqor2oN8sYJ1n0Ga1BLgA3XBwqu3zP6g7QSIaugXpb+w
	 MT86UsoghGDyQfJU6uFNFwETHiQOP0BgtnG9NcWGBR34EpLxfg5fIlo3sRR+FOXOy0
	 CM83pYgPHFll+SfnIaPhVVy6m++XI15nfp4Zw2rKbyGQ1dJ1P369m28AujKxA2hluX
	 tsKXUN37L1pfw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:31 +0100
Subject: [PATCH v2 10/15] mm/hugetlb: count again if the reserve map shrank
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
Message-Id: <20261116-fixes_hugetlb-v2-10-4dd9e94ea9ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6751; i=david@kernel.org;
 h=from:subject:message-id; bh=pjdR88mv7+rpLICVRcSvJB2NuhqdX1kITUt5B5uk0C4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3c6nm8Q/Wp546FVUle8uvfENI+8ax6hrfriLDvv6
 kxb5+DTUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwEQsbjP8d3t5cIX6/cXr/e/8
 9pzewRpX9ETChzX4Z4f6KcOfz/UPHWNkuBpspJz/T/B1UKMnX1FjnPPlp5M9KtKuM+Xc/XdR/+w
 CTgA=
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
index 3d8eebdca5136..112fa25f36833 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -739,26 +739,36 @@ static int allocate_file_region_entries(struct resv_map *resv,
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
@@ -794,6 +804,13 @@ static long region_add(struct resv_map *resv, long f, long t,
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
@@ -6847,7 +6864,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;
-	int err;
+	int err, retries = 0;
 
 	/* This should never happen */
 	if (from > to) {
@@ -6869,6 +6886,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (vma_flags_test(&vma_flags, VMA_NORESERVE_BIT))
 		return 0;
 
+retry:
 	/*
 	 * Shared mappings base their reservation on the number of pages that
 	 * are already allocated on behalf of the file. Private mappings need
@@ -6947,7 +6965,8 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma_test(vma, VMA_MAYSHARE_BIT)) {
-		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
+		add = region_add_limited(resv_map, from, to, regions_needed, h,
+					 h_cg, chg);
 
 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
@@ -7010,17 +7029,28 @@ long hugetlb_reserve_pages(struct inode *inode,
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
2.56.1

