Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7836402D
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105590; cv=none; b=oaGXdm8a8EUjy2ZpvxYGZIfSEwKLDEtw6/RmUhsZjQA9S5Ef5r33xdCC9uIo8TerjLIwYhwve4RKv/P0VxxVcsrqM7nONunUM2da9A0c53xgc6Nlo4N+XCWMdVcl3wUGigi6XCp0IESO5zVUiD2VYWUPdNIQfyaR/ryPOuw3wTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105590; c=relaxed/simple;
	bh=3xK3nv46f+X94PDmNkXeCzSfCx/kdX4uY/kt9nTWGOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l43Nd0R+vZSyas4q/k1obvKS3mKE3b8rD08tH6FAv8tv4wkImDopRkXO98CrqLZhpt+WIp3zUPuOJ8XkT8p9IdNYI1tfgmc6KHuFqcw6DvJFOUXtt8FFCWZnEtprnNOf78bREKYSi8h8dqy1meCiY25orAp9cIGgwKsix9PvInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BFSudpBQ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BFSudpBQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMeF9FuOGiVcaeEE8TLIVYSd2ZWdyqQJ2YusxNRO8Vw=;
	b=BFSudpBQsSSTYRqfYn30RDkrmyvD8a82qVH1sYA5NyNZ7scTnnsWMO+aILfSxqwHerqizH
	saC0LYcAFWnkoLmEVnGKpnBUc4oq6xsaL9QCJjM/OgvgRBSPnqALRaNrYVJuxt2Tse2yM9
	17DCCv6gSxumhU6zBvHKgBtRtW9lMQc=
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
Subject: [RFC v2 01/21] mm: thp: make split_huge_pmd functions return int for error propagation
Date: Thu, 26 Feb 2026 03:23:30 -0800
Message-ID: <20260226113233.3987674-2-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently split cannot fail, but future patches will add lazy PTE page
table allocation. With lazy PTE page table allocation at THP split time
__split_huge_pmd() calls pte_alloc_one() which can fail if order-0
allocation cannot be satisfied.
Split functions currently return void, so callers have no way to detect
this failure.  The PMD would remain huge, but callers assumed the split
succeeded and proceeded to operate on that basis — interpreting a huge PMD
entry as a page table pointer could result in a kernel bug.

Change __split_huge_pmd(), split_huge_pmd(), split_huge_pmd_if_needed()
and split_huge_pmd_address() to return 0 on success (-ENOMEM on
allocation failure in later patch).  Convert the split_huge_pmd macro
to a static inline function that propagates the return value. The return
values will be handled by the callers in future commits.

The CONFIG_TRANSPARENT_HUGEPAGE=n stubs are changed to return 0.

No behaviour change is expected with this patch.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/huge_mm.h | 34 ++++++++++++++++++----------------
 mm/huge_memory.c        | 16 ++++++++++------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a4d9f964dfdea..e4cbf5afdbe7e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -419,7 +419,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped);
 void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 #endif
 
-void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
+int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
 
 /**
@@ -448,15 +448,15 @@ static inline bool pmd_is_huge(pmd_t pmd)
 	return false;
 }
 
-#define split_huge_pmd(__vma, __pmd, __address)				\
-	do {								\
-		pmd_t *____pmd = (__pmd);				\
-		if (pmd_is_huge(*____pmd))				\
-			__split_huge_pmd(__vma, __pmd, __address,	\
-					 false);			\
-	}  while (0)
+static inline int split_huge_pmd(struct vm_area_struct *vma,
+					     pmd_t *pmd, unsigned long address)
+{
+	if (pmd_is_huge(*pmd))
+		return __split_huge_pmd(vma, pmd, address, false);
+	return 0;
+}
 
-void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
+int split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 		bool freeze);
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
@@ -651,13 +651,15 @@ static inline int try_folio_split_to_order(struct folio *folio,
 
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
-#define split_huge_pmd(__vma, __pmd, __address)	\
-	do { } while (0)
-
-static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long address, bool freeze) {}
-static inline void split_huge_pmd_address(struct vm_area_struct *vma,
-		unsigned long address, bool freeze) {}
+static inline int split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
+				unsigned long address)
+{
+	return 0;
+}
+static inline int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long address, bool freeze) { return 0; }
+static inline int split_huge_pmd_address(struct vm_area_struct *vma,
+		unsigned long address, bool freeze) { return 0; }
 static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
 					 unsigned long address, pmd_t *pmd,
 					 bool freeze) {}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8003d3a498220..125ff36f475de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3273,7 +3273,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 }
 
-void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
+int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze)
 {
 	spinlock_t *ptl;
@@ -3287,20 +3287,22 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	split_huge_pmd_locked(vma, range.start, pmd, freeze);
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
+
+	return 0;
 }
 
-void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
+int split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 		bool freeze)
 {
 	pmd_t *pmd = mm_find_pmd(vma->vm_mm, address);
 
 	if (!pmd)
-		return;
+		return 0;
 
-	__split_huge_pmd(vma, pmd, address, freeze);
+	return __split_huge_pmd(vma, pmd, address, freeze);
 }
 
-static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
+static inline int split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
 {
 	/*
 	 * If the new address isn't hpage aligned and it could previously
@@ -3309,7 +3311,9 @@ static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned
 	if (!IS_ALIGNED(address, HPAGE_PMD_SIZE) &&
 	    range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
 			 ALIGN(address, HPAGE_PMD_SIZE)))
-		split_huge_pmd_address(vma, address, false);
+		return split_huge_pmd_address(vma, address, false);
+
+	return 0;
 }
 
 void vma_adjust_trans_huge(struct vm_area_struct *vma,
-- 
2.47.3

