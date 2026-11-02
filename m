Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626289;
	b=oYp5HheXg+9sOnGNjqveRh3tJhJt25RBy5/UVkHXeiPp6wlGFKyoLL+pZ93E/3u9GtQB
	 Z394ZfCXErTSGDx5n4r3UmbIfOirS7JbfHMV8nsX38Kv+kx8++zhC+YEe1Kfz0qxtdt7/
	 89fbaAHmwlrs1L9IqvHNTsafJGqi30YCI3T2G3O2397whzZtvC/g2C7/Qyg0M6r/L3+JA
	 9A5hy5h9ezjB1kVeEaknXzN3JK9UsU/GJi3cu0A61rz8G0rfiic4O+9PnR07fY3uEzV//
	 6FK7cnTyRw2yhNrBT/73+QGYWMDuNV9vDNBhrbOTWsTns/o5aNQEkDfaLi1mca/b1Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626289;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6l/5Q7V+G395n7qszK2Zqbz7twxOAQjD3Y28a75NNCY=;
	b=AbNDRTu892oEg2LpzUtLv9TiQy4iXfG89q/WKWiFqgl0fjjUH7Ka/d2yn/RB73Vf7w0m
	 SbjlDjOc8qj9cb4ec5lIXnqEHypm3wS7E6u4BvN62ktKKf3KJn5K94pbO+7zc3+IUEXWG
	 JVOD0We4OGIbTNFs0SSpE59xk1xla+oiG/+8uTlX7aL2GaY2U2d9/+JcsWTmn8tSgdQrf
	 cU9bOVP3vcR+A6azh+fHnliWD3FiDKfenRIBNNUUE0LwYe84rt0w/LnmURGVNIV/RgmNm
	 vniiT8LMrxxrZUe8npQdLm9SHy6NpMRe8hbIWIB4Z1S9oVrUjU9clDUYLAofkun+6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OjysKMwE;
	arc=none smtp.remote-ip=95.215.58.14
Received: from mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9D606A331
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 13:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C9D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OjysKMwE
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lF+VCblZ//xtA3m1I+S7udymzBDeLTRik/KSnJiaJWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793626285; v=1; x=1794231085;
 b=OjysKMwEB9pmMvUQjCWIeDB59z4ZaxfhtYvZMeptMBIjEbNqn7O4qw+t56CXR031HhkbItss
 BtPSCkWHUhxRtfn+QEYT8ZWKssUWVrM3A49Jnn9XJrhejmYOsCbRFU9AjLC2q5pn0/WKtj9PAdR
 aZ3kwFBiNGh787yuUpwyA2Gg=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0cc75e2f04caf587;
	Mon, 02 Nov 2026 13:31:25 +0000
X-Mizu-Trace-ID: 0cc75e2f04caf587
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: xu.xin@linux.dev
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	byungchul@sk.com,
	chengming.zhou@linux.dev,
	david@kernel.org,
	dev.jain@arm.com,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	gourry@gourry.net,
	harry@kernel.org,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jannh@google.com,
	jolsa@kernel.org,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	ljs@kernel.org,
	mark.rutland@arm.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	nico.pache@linux.dev,
	oleg@redhat.com,
	peterz@infradead.org,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	svens@linux.ibm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	xialonglong2025@163.com,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH v2 4/4] ksm: add find_mergeable_vma_locked() to use per-VMA locking
Date: Mon,  2 Nov 2026 21:31:03 +0800
Message-Id: <20261102133103.302832-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102132416.300084-1-xu.xin@linux.dev>
References: <20261102132416.300084-1-xu.xin@linux.dev>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Xin <xu.xin@linux.dev>

Longlong Xia reported that get_mergeable_page() takes mmap_read_lock()
on every merge, which becomes a contention point under load [1]. David
Hildenbrand suggested switching to per-VMA locking to avoid the
process-wide mmap lock [2].

Add find_mergeable_vma_locked(), which is similar to find_tcp_vma(),
using the universal per-VMA locking helper vma_start_read_unlocked() to
look up and read-lock a VM_MERGEABLE VMA without taking
mmap_read_lock().  All KSM call sites that previously used
find_mergeable_vma() under mmap_read_lock() are converted to the new
helper, and the locking in get_mergeable_page() is switched to
PGWALK_VMA_RDLOCK_VERIFY so that folio_walk_start() can verify the
per-VMA lock is held.

Switching to per-VMA locking also changes how ksmd is synchronized with
a process that is exiting.  __ksm_exit() previously relied on a plain
mmap_write_lock() to serialize against ksmd, but that no longer blocks
a ksmd walk that holds only a per-VMA read lock.  So __ksm_exit() now
also write-locks every VMA (vma_start_write()) while holding
mmap_write_lock(): this blocks until any in-flight ksmd walk drops its
per-VMA read lock, and prevents new ones from starting, since
vma_start_read_unlocked() backs out when a VMA is write-locked.  The
per-VMA write locks are released by mmap_write_unlock() via
vma_end_write_all().  This is safe because __mmput() runs ksm_exit()
after mm_users has gone to zero and before exit_mmap() frees the page
tables, so any new ksmd walk backs out via ksm_test_exit().

Performance
===========
As a test, I construct a testcase which follows the approach: Create
one victim and several churner threads sharing one mm_struct [3]; The
victim registers a 32 MiB anonymous VM_MERGEABLE region containing
8192 pages totally:churners hammer mmap_lock via mmap/munmap
repeatedly; ksmd merges the victim's pages; Compare latency baseline
VS this per-VMA patch.

                 Before patched         After Patched
0 churner:     1.627 seconds          1.426 seconds
4 churners:    72.45 seconds          36.61 seconds

In conclusion, when no mmap_lock contention (0 churner), there is little
difference between the baseline kernel and the per-VMA optimized kernel;
But under interference from 4 churner threads, the merge time of the
per-VMA KSM-optimized kernel is significantly reduced by 50%.

[1] https://lore.kernel.org/all/20260909023507.1408925-1-xialonglong2025@163.com/
[2] https://lore.kernel.org/all/91cf8129-d705-4ebd-b420-129bab7ed261@kernel.org/
[3] https://lore.kernel.org/all/20260911162242418ODBbr9wspxxIXDS8uvpeZ@zte.com.cn/

Reported-by: Longlong Xia <xialonglong@kylinos.cn>
Signed-off-by: Xu Xin <xu.xin@linux.dev>
---
 mm/ksm.c | 82 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 84d363dabdc8..64f9e803b99e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -669,6 +669,8 @@ enum ksm_walk_lock {
 	KSM_WALK_MMAP_RDLOCK,
 	/* walk under mmap_write_lock() */
 	KSM_WALK_MMAP_WRLOCK,
+	/* walk with the vma already read-locked (per-VMA locking) */
+	KSM_WALK_VMA_RDLOCK,
 };
 
 static enum page_walk_lock ksm_walk_lock_to_pgwalk(enum ksm_walk_lock lock)
@@ -676,6 +678,8 @@ static enum page_walk_lock ksm_walk_lock_to_pgwalk(enum ksm_walk_lock lock)
 	switch (lock) {
 	case KSM_WALK_MMAP_WRLOCK:
 		return PGWALK_WRLOCK;
+	case KSM_WALK_VMA_RDLOCK:
+		return PGWALK_VMA_RDLOCK_VERIFY;
 	default:
 		return PGWALK_RDLOCK;
 	}
@@ -784,15 +788,36 @@ static bool vma_ksm_compatible(struct vm_area_struct *vma)
 	return ksm_compatible(vma->vm_file, vma->flags);
 }
 
-static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
-		unsigned long addr)
+/**
+ * find_mergeable_vma_locked() - Find the VMA covering 'address' which is
+ * VM_MERGEABLE and read-lock it by per-VMA locks. Please use vma_end_read()
+ * to unlock vma after finishing reading the VMA (non-NULL).
+ *
+ * Return: If a VMA exists which spans @address, return that VMA, read-locked.
+ * If no VMA is mapped there or, very unlikely, a reference count overflow
+ * occurred, return NULL, and no read-locked.
+ *
+ * IMPORTANT: If a VMA exists but is not VM_MERGEABLE or has no anon_vma,
+ * this function releases the per-VMA read lock before returning NULL.
+ * Callers must NOT call vma_end_read() on a NULL return value.
+ */
+static struct vm_area_struct *find_mergeable_vma_locked(struct mm_struct *mm,
+		unsigned long address)
 {
 	struct vm_area_struct *vma;
+
 	if (ksm_test_exit(mm))
 		return NULL;
-	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
+
+	vma = vma_start_read_unlocked(mm, address);
+	if (!vma)
 		return NULL;
+
+	if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma) {
+		vma_end_read(vma);
+		return NULL;
+	}
+
 	return vma;
 }
 
@@ -818,11 +843,12 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	 */
 	rmap_item->linear_page_index = 0;
 
-	mmap_read_lock(mm);
-	vma = find_mergeable_vma(mm, addr);
-	if (vma)
-		break_ksm(vma, addr, addr + PAGE_SIZE, KSM_WALK_MMAP_RDLOCK);
-	mmap_read_unlock(mm);
+	vma = find_mergeable_vma_locked(mm, addr);
+	if (!vma)
+		return;
+
+	break_ksm(vma, addr, addr + PAGE_SIZE, KSM_WALK_VMA_RDLOCK);
+	vma_end_read(vma);
 }
 
 static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
@@ -833,13 +859,12 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 	struct page *page = NULL;
 	struct folio *folio;
 	struct folio_walk fw = {
-		.walk_lock  = PGWALK_RDLOCK,
+		.walk_lock  = PGWALK_VMA_RDLOCK_VERIFY,
 	};
 
-	mmap_read_lock(mm);
-	vma = find_mergeable_vma(mm, addr);
+	vma = find_mergeable_vma_locked(mm, addr);
 	if (!vma)
-		goto out;
+		return NULL;
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
@@ -850,12 +875,12 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 		}
 		folio_walk_end(&fw, vma);
 	}
-out:
+
 	if (page) {
 		flush_anon_page(vma, page, addr);
 		flush_dcache_page(page);
 	}
-	mmap_read_unlock(mm);
+	vma_end_read(vma);
 	return page;
 }
 
@@ -1596,14 +1621,14 @@ static int try_to_merge_with_zero_page(struct ksm_rmap_item *rmap_item,
 	if (ksm_use_zero_pages && (rmap_item->oldchecksum == zero_checksum)) {
 		struct vm_area_struct *vma;
 
-		mmap_read_lock(mm);
-		vma = find_mergeable_vma(mm, rmap_item->address);
+		vma = find_mergeable_vma_locked(mm, rmap_item->address);
 		if (vma) {
 			err = try_to_merge_one_page(vma, page,
 					ZERO_PAGE(rmap_item->address));
 			trace_ksm_merge_one_page(
 				page_to_pfn(ZERO_PAGE(rmap_item->address)),
 				rmap_item, mm, err);
+			vma_end_read(vma);
 		} else {
 			/*
 			 * If the vma is out of date, we do not need to
@@ -1611,7 +1636,6 @@ static int try_to_merge_with_zero_page(struct ksm_rmap_item *rmap_item,
 			 */
 			err = 0;
 		}
-		mmap_read_unlock(mm);
 	}
 
 	return err;
@@ -1630,10 +1654,9 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	struct vm_area_struct *vma;
 	int err = -EFAULT;
 
-	mmap_read_lock(mm);
-	vma = find_mergeable_vma(mm, rmap_item->address);
+	vma = find_mergeable_vma_locked(mm, rmap_item->address);
 	if (!vma)
-		goto out;
+		goto out_trace;
 
 	err = try_to_merge_one_page(vma, page, kpage);
 	if (err)
@@ -1653,7 +1676,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	rmap_item->linear_page_index = linear_anon_page_index(vma, rmap_item->address);
 	get_anon_vma(vma->anon_vma);
 out:
-	mmap_read_unlock(mm);
+	vma_end_read(vma);
+out_trace:
 	trace_ksm_merge_with_ksm_page(kpage, page_to_pfn(kpage ? kpage : page),
 				rmap_item, mm, err);
 	return err;
@@ -3119,6 +3143,7 @@ void __ksm_exit(struct mm_struct *mm)
 {
 	struct ksm_mm_slot *mm_slot = NULL;
 	struct mm_slot *slot;
+	struct vm_area_struct *vma;
 	int easy_to_free = 0;
 
 	/*
@@ -3153,7 +3178,20 @@ void __ksm_exit(struct mm_struct *mm)
 		mm_flags_clear(MMF_VM_MERGEABLE, mm);
 		mmdrop(mm);
 	} else if (mm_slot) {
+		/*
+		 * ksmd may be walking this mm's page tables under a per-VMA
+		 * read lock (see find_mergeable_vma_locked()).  A plain
+		 * mmap_write_lock() does not exclude such readers, so also
+		 * write-lock every VMA: this blocks until any in-flight ksmd
+		 * walk drops its per-VMA read lock, and prevents new ones
+		 * from starting (vma_start_read_unlocked() backs out when a
+		 * VMA is write-locked).  The per-VMA write locks are released
+		 * by mmap_write_unlock() via vma_end_write_all().
+		 */
 		mmap_write_lock(mm);
+		VMA_ITERATOR(vmi, mm, 0);
+		for_each_vma(vmi, vma)
+			vma_start_write(vma);
 		mmap_write_unlock(mm);
 	}
 
-- 
2.34.1

