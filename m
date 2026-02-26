Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C93382DB
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105680; cv=none; b=ZEVPEJl0L88JzzQInp+CuCXa5F+ZqDEuztn6wSgxQwPheIzcLs4hPTNzqDVxkasyu63CnquOy641X6/3Mv95vrlUtegAhsy8gCN3HJkeefx4wZH+TLiTMKj7Lm6XoJPETZt8DuGJRbB2C9GGeNy0A3L/sL561brOy4QDy2xThtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105680; c=relaxed/simple;
	bh=LiNFup0IprikkUIxj+GWDz+rMzuFuPao6KbSTj438lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYnHZ9o50zRaohnxtWqujD9Ed84vTSlfJ3vjyNx290h8Kxg+R+gJYDeYvn31S9aEJSeksweFT5GIU7SXlKdYinXZlKlMSP+qN9NzsTenMY4GkqQU45A6YHxRVWhcbmmKKbKIAX8ceShoAZSJOuj2VFYAjx6y25j6cRRsscKG5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iwH65pKx; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iwH65pKx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caCWzkT51kBA+1b/gVecuRpXYDomBajxDOrSXa3U1jc=;
	b=iwH65pKxu5LpRPMNZ/vYDs9XIVBcTv1gPT58U+Rxwn3FgEXyxD998b65LSZo9fPSJ031aw
	nazqs8ps6h716yU5RmiIIzP9wPotaYiK6YjK6+WTiQmE9LiXwan6xsQU7f7pDuYB3FqmkI
	VFDnikYUT2941qf0s6DCUaGOhTZ0k/M=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [RFC v2 16/21] mm: thp: add THP_SPLIT_PMD_FAILED counter
Date: Thu, 26 Feb 2026 03:23:45 -0800
Message-ID: <20260226113233.3987674-17-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a vmstat counter to track PTE allocation failures during PMD split.
This enables monitoring of split failures due to memory pressure after
the lazy PTE page table allocation change.

The counter is incremented in three places:
- __split_huge_pmd(): Main entry point for splitting a PMD
- try_to_unmap_one(): When reclaim needs to split a PMD-mapped THP
- try_to_migrate_one(): When migration needs to split a PMD-mapped THP

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/vm_event_item.h | 1 +
 mm/huge_memory.c              | 1 +
 mm/rmap.c                     | 3 +++
 mm/vmstat.c                   | 1 +
 4 files changed, 6 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 03fe95f5a0201..ce696cf7d6321 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -98,6 +98,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_DEFERRED_SPLIT_PAGE,
 		THP_UNDERUSED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
+		THP_SPLIT_PMD_FAILED,
 		THP_SCAN_EXCEED_NONE_PTE,
 		THP_SCAN_EXCEED_SWAP_PTE,
 		THP_SCAN_EXCEED_SHARED_PTE,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 55b14ba244b1b..fc0a5e91b4d40 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3347,6 +3347,7 @@ int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	if (vma_is_anonymous(vma) && !arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
 		if (!pgtable) {
+			count_vm_event(THP_SPLIT_PMD_FAILED);
 			mmu_notifier_invalidate_range_end(&range);
 			return -ENOMEM;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 2519d579bc1d8..2dae46fff08ae 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2067,8 +2067,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				pgtable_t pgtable = prealloc_pte;
 
 				prealloc_pte = NULL;
+
 				if (!arch_needs_pgtable_deposit() && !pgtable &&
 				    vma_is_anonymous(vma)) {
+					count_vm_event(THP_SPLIT_PMD_FAILED);
 					page_vma_mapped_walk_done(&pvmw);
 					ret = false;
 					break;
@@ -2471,6 +2473,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				prealloc_pte = NULL;
 				if (!arch_needs_pgtable_deposit() && !pgtable &&
 				    vma_is_anonymous(vma)) {
+					count_vm_event(THP_SPLIT_PMD_FAILED);
 					page_vma_mapped_walk_done(&pvmw);
 					ret = false;
 					break;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 667474773dbc7..da276ef0072ed 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1408,6 +1408,7 @@ const char * const vmstat_text[] = {
 	[I(THP_DEFERRED_SPLIT_PAGE)]		= "thp_deferred_split_page",
 	[I(THP_UNDERUSED_SPLIT_PAGE)]		= "thp_underused_split_page",
 	[I(THP_SPLIT_PMD)]			= "thp_split_pmd",
+	[I(THP_SPLIT_PMD_FAILED)]		= "thp_split_pmd_failed",
 	[I(THP_SCAN_EXCEED_NONE_PTE)]		= "thp_scan_exceed_none_pte",
 	[I(THP_SCAN_EXCEED_SWAP_PTE)]		= "thp_scan_exceed_swap_pte",
 	[I(THP_SCAN_EXCEED_SHARED_PTE)]		= "thp_scan_exceed_share_pte",
-- 
2.47.3

