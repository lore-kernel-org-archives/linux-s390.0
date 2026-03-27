Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7630EF86
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577742; cv=none; b=pWDK3/UG9cDCyJhELtk+uSbNL+WXx4MrG+i8tkwZkw8IFBkIsN8mBS+eBJJXRDAYMxN1oINjNF8ykMB5MwEo9JyzimLG8gas8+VAlsfzyQmo+0Sy9qD4bQ8xQUcQOlM8NKx8Hu58TEWK7Lmx8h5QR6bhZ6Fj77PKyAGcQCAPUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577742; c=relaxed/simple;
	bh=jpuQVVXokoXedW4E3Rk2kXk+4m7MDI3R8N0U0vopra8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOdZhyV/SOXdn5jfYeTwVHvVPl9X6O3yXSy7JjGQ894g2QHuOIXGUhHXUMLmVM4oJAGc+EFY+gJxYzfg6KI5vf2EQ6AIYfB0HLSf2vUTWcgp6Ug5poVwt1HWtXqJB33BMtwAi9DoCDtrK1ZnNlmGlZ8RLYIVsO5Rp10PKCX18WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w7b0PFKI; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w7b0PFKI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DA9DXWIy9I9hYoDDZ6d9idv8WvO7k2GsFa78UasupfU=;
	b=w7b0PFKIYHL5VzgfVOmJaU8mndUe+9d3TAczYvwOPmlWZPC+YdbN4753/gZVXBv6rf/e2p
	hhxdxl4rOelbJ74Wb6vwZdxneuTlP5Mo2CuIkJfQOwBMurDfXHMHtfo4IP9DtIrgPBP2Dl
	uZc/JaknYWmWWlMxr4qMjjDLSrv/rhw=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [v3 14/24] powerpc/mm: handle split_huge_pmd failure in subpage_prot
Date: Thu, 26 Mar 2026 19:08:56 -0700
Message-ID: <20260327021403.214713-15-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

subpage_walk_pmd_entry() splits huge PMDs when the subpage_prot
syscall controls the access permissions on individual 4 kB.

In practice this cannot fail today: sys_subpage_prot() returns -ENOENT
early when radix is enabled, and on hash powerpc
arch_needs_pgtable_deposit() is true so split uses the pre-deposited
page table and always succeeds. The change is for __must_check
compliance introduced in a later patch and correctness if the call
chain ever becomes reachable on architectures with lazy PTE allocation.

Propagate the error through the full call chain up to the syscall.
The syscall already returns -ENOMEM in other places when it runs out
of memory.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 37d47282c3686..b3635a11ff433 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -139,8 +139,8 @@ static int subpage_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
-	split_huge_pmd(vma, pmd, addr);
-	return 0;
+
+	return split_huge_pmd(vma, pmd, addr);
 }
 
 static const struct mm_walk_ops subpage_walk_ops = {
@@ -148,11 +148,12 @@ static const struct mm_walk_ops subpage_walk_ops = {
 	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
-static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
-				    unsigned long len)
+static int subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
+				   unsigned long len)
 {
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, addr);
+	int err;
 
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
@@ -160,14 +161,17 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
 	 */
 	for_each_vma_range(vmi, vma, addr + len) {
 		vm_flags_set(vma, VM_NOHUGEPAGE);
-		walk_page_vma(vma, &subpage_walk_ops, NULL);
+		err = walk_page_vma(vma, &subpage_walk_ops, NULL);
+		if (err)
+			return err;
 	}
+	return 0;
 }
 #else
-static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
-				    unsigned long len)
+static int subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
+				   unsigned long len)
 {
-	return;
+	return 0;
 }
 #endif
 
@@ -229,7 +233,9 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
 		mm->context.hash_context->spt = spt;
 	}
 
-	subpage_mark_vma_nohuge(mm, addr, len);
+	err = subpage_mark_vma_nohuge(mm, addr, len);
+	if (err)
+		goto out;
 	for (limit = addr + len; addr < limit; addr = next) {
 		next = pmd_addr_end(addr, limit);
 		err = -ENOMEM;
-- 
2.52.0

