Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626252;
	b=wJy1PiANtp0amuPfzfhNZ5ctM4lpDMmryloaVWFXMw39BOvpbAGoGBL1qzNcn8lTDz7s
	 +A0be6Pl2nbOx55VG6vSaSXr6zv13IrL+8qZsPUpEPThAeqLwbM1+VB4ByNJcFsGCcdqO
	 Hkxc+lEJQtkvP8C9Sdqa4R/FEOca+R/RWIcnAnyfHzMVjDxxvGcFiFQ3Y8BSkIr6HW0SR
	 Or+MnVU2rcN2ZgCHgNby7FGyrf2auUqFcRFiXJgQ7FKFeWzPOugJ/nDqs/pTvQUYe45gX
	 FJLmJkYVgIcGuXtIo+cUeCeO5V8+oYrYPNw1PoipXNQ+vunFQkP/28IeZQ+yLnoVlNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626252;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xd4Zxt0dW9wnj47lwp9JjLaVdRyyCLyZMnAjVqO7/fo=;
	b=Nn/nfPJa0Ex5TV3IORn0t1iohR+DK8n8kRk8sgl1aTVZ/AcvBkp1D6J+1gM58v3iyq8N
	 t1X/o6QIjLjLR0nva2Fool6Kg1NLslcHmoiRQSBYacvC48h6uA2ZIdvcfrVO/deu+mm2a
	 BqQisxv3C22xqeFDaai/Wpya/fyB/ftUZXwqrlyE52XTm5BEhpCh8xvrjIWhT0z+Wt7vZ
	 Zfe9EJy+bzIgmbxP/5WY914srhhv5WK8O/xeO4tiExXiQr312P50pwGnAf9p72YTfWNSP
	 lpjm7vZpeEOtZVBdRMaqRXSyoQVEHE726sEXknr1Y/8AeFT6bqyiwb8+rNKUPSI3F3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PnEnqxrA;
	arc=none smtp.remote-ip=91.218.175.21
Received: from mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F7606A326
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 13:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 537F7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PnEnqxrA
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s4yg0ta58nGIz9mkSZjODrgZj5rI7gGZ4K62KqyBrVw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793626249; v=1; x=1794231049;
 b=PnEnqxrAP5VOtUyELIfWq4qwptJNvXCBq4ilsG0BQAgbPgJ8iF1bxQjKQD6v0j4tjlKlYioP
 HE0BVpYXunM2xhA7wUZO+T/S/OVW2fTSPEqktvA2dtQ9d5pv1MREBZglruTkXQYj6r8xawAmpT3
 K5HoqaVw2EB3qpLxPQbDfmZs=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 931b8975140fde70;
	Mon, 02 Nov 2026 13:30:19 +0000
X-Mizu-Trace-ID: 931b8975140fde70
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
	xialonglong2025@163.com
Subject: [PATCH v2 3/4] mm/ksm: make break_ksm() more scalable
Date: Mon,  2 Nov 2026 21:29:56 +0800
Message-Id: <20261102132956.302480-1-xu.xin@linux.dev>
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

break_ksm() currently takes a boolean 'lock_vma' to select between two
static mm_walk_ops tables.  This is fragile: the ops struct is full of
function pointers and making it mutable (to switch walk_lock at runtime)
turns it into a juicy target for attackers.

Replace the boolean with a KSM-local enum ksm_walk_lock and build the
mm_walk_ops on the stack, so the table stays const and there is no
shared mutable state.  This also prepares for the later patch that
switches break_ksm() to per-VMA read-locking, where a third locking
mode will be needed.

No functional change intended.

Signed-off-by: Xu Xin <xu.xin@linux.dev>
---
 mm/ksm.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index d4fc0b0965aa..84d363dabdc8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -661,15 +661,25 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long en
 	return found;
 }
 
-static const struct mm_walk_ops break_ksm_ops = {
-	.pmd_entry = break_ksm_pmd_entry,
-	.walk_lock = PGWALK_RDLOCK,
+/*
+ * Locking contexts in which break_ksm() may walk the page tables.
+ */
+enum ksm_walk_lock {
+	/* walk under mmap_read_lock() */
+	KSM_WALK_MMAP_RDLOCK,
+	/* walk under mmap_write_lock() */
+	KSM_WALK_MMAP_WRLOCK,
 };
 
-static const struct mm_walk_ops break_ksm_lock_vma_ops = {
-	.pmd_entry = break_ksm_pmd_entry,
-	.walk_lock = PGWALK_WRLOCK,
-};
+static enum page_walk_lock ksm_walk_lock_to_pgwalk(enum ksm_walk_lock lock)
+{
+	switch (lock) {
+	case KSM_WALK_MMAP_WRLOCK:
+		return PGWALK_WRLOCK;
+	default:
+		return PGWALK_RDLOCK;
+	}
+}
 
 /*
  * Though it's very tempting to unmerge rmap_items from stable tree rather
@@ -697,17 +707,19 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
  * protection keys here anyway.
  */
 static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long end, bool lock_vma)
+		unsigned long end, enum ksm_walk_lock walk_lock)
 {
 	vm_fault_t ret = 0;
-	const struct mm_walk_ops *ops = lock_vma ?
-				&break_ksm_lock_vma_ops : &break_ksm_ops;
+	struct mm_walk_ops ops = {
+		.pmd_entry = break_ksm_pmd_entry,
+		.walk_lock = ksm_walk_lock_to_pgwalk(walk_lock),
+	};
 
 	do {
 		int ksm_page;
 
 		cond_resched();
-		ksm_page = walk_page_range_vma(vma, addr, end, ops, &addr);
+		ksm_page = walk_page_range_vma(vma, addr, end, &ops, &addr);
 		if (ksm_page <= 0)
 			return ksm_page;
 		ret = handle_mm_fault(vma, addr,
@@ -809,7 +821,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr, addr + PAGE_SIZE, false);
+		break_ksm(vma, addr, addr + PAGE_SIZE, KSM_WALK_MMAP_RDLOCK);
 	mmap_read_unlock(mm);
 }
 
@@ -1247,7 +1259,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		for_each_vma(vmi, vma) {
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
 				continue;
-			err = break_ksm(vma, vma->vm_start, vma->vm_end, false);
+			err = break_ksm(vma, vma->vm_start, vma->vm_end, KSM_WALK_MMAP_RDLOCK);
 			if (err)
 				goto error;
 		}
@@ -2896,7 +2908,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma_has_anon_rmap(vma)) {
-		err = break_ksm(vma, vma->vm_start, vma->vm_end, true);
+		err = break_ksm(vma, vma->vm_start, vma->vm_end, KSM_WALK_MMAP_WRLOCK);
 		if (err)
 			return err;
 	}
@@ -3048,7 +3060,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 			return 0;		/* just ignore the advice */
 
 		if (vma_has_anon_rmap(vma)) {
-			err = break_ksm(vma, start, end, true);
+			err = break_ksm(vma, start, end, KSM_WALK_MMAP_WRLOCK);
 			if (err)
 				return err;
 		}
-- 
2.34.1

