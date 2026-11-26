Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691789;
	b=jrmvL5gNK9qZHUlVssAJqjisXCfLq4l5aXRze6436K+hnRW2w9+pMDSIRUHl/4hs6uIk
	 gSAL2BnX7v4zDh0GixseThHj1RHm/s+J/xVlwcaDKUcVp1GJnPnGmT5U/T0oNTxqcnna0
	 8AK/hdJpIqMJ9zXr0Z2hZ4xkyu16ZxRkA7HeKKVfuaTH19Yj+l6oLEefjLY8WupQUg/sz
	 ro+wAUElC75HAYZK1+MAcxk4H3lAIjwlVGHd4qwG3D1PDDW3q7uI9Qfg0xoaizfY00M0u
	 u5RNigt4laT+Ax1a1EoRRzFaRTtVEC/6nIgK2UyGqNn9MVVnO5UzInhtNLmzEFLtDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691789;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=g7+G25h7JB/VdJKGT10uzFSZXJehzXr1o5C1pbOXKCo=;
	b=T3J+wPuvInUxNVkbMC8GSD7ZlzsN6ztsLtq7bB8EO34loRZpeq1i+qb68hgcxrVRRGt1
	 QX+xJAaIouiQ2g0udnKOxDfJUQYND/ym2GXRogxQ0MNiDd39ZMj7kLePoIxGcxfyiGrU9
	 NSQbieCkdli9kJ98J/clLicijZKON8DGEOslgrppHp+tl+M9pLpPu7gZJq1reUVS55MFZ
	 KutqTXpFLeBxfpWBF3dqOl2xG+tvNwbZZKARcxkGzSM3i7PzX96Kvo/EV0Ed6W+ysY4dv
	 xKKLfT0RduUtwzM3XGoyNAIkqozV0t8A4Y2i9TDBQ6pshzoWDoBCwTBDXovXwGlWbkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJTmgF9h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DC606A31C;
	Thu, 26 Nov 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJTmgF9h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64B31F000D1;
	Thu, 26 Nov 2026 11:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691788;
	bh=g7+G25h7JB/VdJKGT10uzFSZXJehzXr1o5C1pbOXKCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JJTmgF9hCDloI4+C9h9XvD40HTS73PHevQ/AL1GPsnk5uRiOh0Xtwz/5NgaWA3TQd
	 MhWF3uq8pOpyod+MeWUnBV+pluBsiCPrOiXQ6Gy2JuHY+eeB136zaAgdmRIBRHpArj
	 xX9Pj8dnVkGzTfZ1P+3Xe8N9xqP1v86DauxGOJeKSJiIJcAHVE4MUggm1zKcR/bMrC
	 CjoZMblWz3YnlXQU2MAi0Kp4nkCN12bw+vipoHgMvlvtK0322zGJ5Ja8RESYSBssgy
	 BfJ8zyrYkmvuNYpAy8Ir0rc+KgNMUwONUWMrt3fK4eOR3FMphFviDpfly9rHAYJEip
	 NLfXyYa2Uo6/w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:25 +0200
Subject: [PATCH RFC v2 12/54] x86/mm/pat: introduce
 change_page_attr_pages()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-12-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

CPA takes either a range of addresses or, with CPA_REQ_PAGES_ARRAY, an
array of pages.

CPA_REQ_PAGES_ARRAY is used by set_pages_array_*() APIs to change the cache
mode of the direct map of the pages.

Changing the cache mode of the direct map is very x86 specific and no other
architecture does it.

With the upcoming move of the CPA core to the generic code, it is best to
keep arrays of pages in x86, so that generic core deals only with ranges
and is simpler to reason about.

Besides, its current implementation is suboptimal. CPA walks an array page
at a time and splits every large page it touches, even when the pages are
contiguous. For instance, TTM passes arrays that may contain high order
pages.

Introduce change_page_attr_pages() that changes the pages that are
contiguous in the direct map as a single range, so a range that covers a
large page keeps it, and drop CPA_REQ_PAGES_ARRAY.

Purge the vmap aliases once before the ranges and flush the TLB and the
caches once after them, as before.

change_page_attr_pages() flushes once for the entire pages array, so the
flush can no longer take a struct cpa_data. Introduce struct cpa_flush_req
that describes either a range or an array of pages, and use it for both
change_page_attr_set_clr() and change_page_attr_pages().

A highmem page has no address in the direct map. CPA looked up address 0
for it, which on 32-bit ends in the "CPA: called for zero pte" warning and
-EFAULT since commit 16ebf031e8ab ("x86/mm/cpa: Add __cpa_addr() helper").
Skip highmem pages.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 191 ++++++++++++++++++++++++++++---------------
 1 file changed, 124 insertions(+), 67 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e1abc0d1d143..5e3c1152d202 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -49,7 +49,6 @@ struct cpa_data {
 	unsigned long	pfn;
 	unsigned int	flags;
 	unsigned int	state;
-	struct page	**pages;
 };
 
 enum cpa_warn {
@@ -72,7 +71,6 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_REQ_NO_CHECK_ALIAS	0x01 /* Do not search for aliases */
 #define CPA_REQ_COLLAPSE	0x02 /* try to collapse large pages */
 #define CPA_REQ_SPLIT		0x04 /* split large pages */
-#define CPA_REQ_PAGES_ARRAY	0x08
 
 /* cpa_data::state */
 #define CPA_ST_FLUSHTLB		0x01 /* the TLB needs a flush */
@@ -309,15 +307,6 @@ static inline unsigned long fix_addr(unsigned long addr)
 
 static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
-	if (cpa->flags & CPA_REQ_PAGES_ARRAY) {
-		struct page *page = cpa->pages[idx];
-
-		if (unlikely(PageHighMem(page)))
-			return 0;
-
-		return (unsigned long)page_address(page);
-	}
-
 	return cpa->addr + idx * PAGE_SIZE;
 }
 
@@ -400,13 +389,33 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
+/* The pages to flush: @numpages pages from @addr, or those in @pages */
+struct cpa_flush_req {
+	unsigned long	addr;
+	struct page	**pages;
+	unsigned long	numpages;
+	unsigned int	state;
+};
+
+/*
+ * A highmem page in @pages is not changed, but flushing it is harmless:
+ * page_address() returns NULL or its kmap address.
+ */
+static unsigned long cpa_flush_addr(struct cpa_flush_req *req, unsigned int i)
+{
+	if (req->pages)
+		return (unsigned long)page_address(req->pages[i]);
+
+	return req->addr + i * PAGE_SIZE;
+}
+
 static void __cpa_flush_tlb(void *data)
 {
-	struct cpa_data *cpa = data;
+	struct cpa_flush_req *req = data;
 	unsigned int i;
 
-	for (i = 0; i < cpa->numpages; i++)
-		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
+	for (i = 0; i < req->numpages; i++)
+		flush_tlb_one_kernel(fix_addr(cpa_flush_addr(req, i)));
 }
 
 static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
@@ -417,20 +426,13 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 	struct ptdesc *ptdesc, *tmp;
 	LIST_HEAD(pgtables);
 	int collapsed = 0;
-	int i;
 
-	if (cpa->flags & CPA_REQ_PAGES_ARRAY) {
-		for (i = 0; i < cpa->numpages; i++)
-			collapsed += collapse_large_pages(__cpa_addr(cpa, i),
-							  &pgtables);
-	} else {
-		addr = __cpa_addr(cpa, 0);
-		start = addr & PMD_MASK;
-		end = addr + PAGE_SIZE * cpa->numpages;
+	addr = __cpa_addr(cpa, 0);
+	start = addr & PMD_MASK;
+	end = addr + PAGE_SIZE * cpa->numpages;
 
-		for (addr = start; within(addr, start, end); addr += PMD_SIZE)
-			collapsed += collapse_large_pages(addr, &pgtables);
-	}
+	for (addr = start; within(addr, start, end); addr += PMD_SIZE)
+		collapsed += collapse_large_pages(addr, &pgtables);
 
 	if (!collapsed)
 		return;
@@ -451,7 +453,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 	}
 }
 
-static void cpa_flush(struct cpa_data *cpa, int cache)
+static void __cpa_flush(struct cpa_flush_req *req, int cache)
 {
 	unsigned int i;
 
@@ -462,18 +464,18 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 		return;
 	}
 
-	if ((cpa->state & CPA_ST_FLUSH_ALL) ||
-	    cpa->numpages > tlb_single_page_flush_ceiling)
+	if ((req->state & CPA_ST_FLUSH_ALL) ||
+	    req->numpages > tlb_single_page_flush_ceiling)
 		flush_tlb_all();
 	else
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
+		on_each_cpu(__cpa_flush_tlb, req, 1);
 
 	if (!cache)
 		return;
 
 	mb();
-	for (i = 0; i < cpa->numpages; i++) {
-		unsigned long addr = __cpa_addr(cpa, i);
+	for (i = 0; i < req->numpages; i++) {
+		unsigned long addr = cpa_flush_addr(req, i);
 		unsigned int level;
 
 		pte_t *pte = lookup_address(addr, &level);
@@ -487,6 +489,17 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 	mb();
 }
 
+static void cpa_flush(struct cpa_data *cpa, int cache)
+{
+	struct cpa_flush_req req = {
+		.addr = cpa->addr,
+		.numpages = cpa->numpages,
+		.state = cpa->state,
+	};
+
+	__cpa_flush(&req, cache);
+}
+
 static bool overlaps(unsigned long r1_start, unsigned long r1_end,
 		     unsigned long r2_start, unsigned long r2_end)
 {
@@ -1949,7 +1962,6 @@ static int cpa_process_alias(struct cpa_data *cpa)
 
 		alias_cpa = *cpa;
 		alias_cpa.addr = (unsigned long)__va(cpa->pfn << PAGE_SHIFT);
-		alias_cpa.flags &= ~CPA_REQ_PAGES_ARRAY;
 		alias_cpa.state &= ~CPA_ST_FLUSHTLB;
 		alias_cpa.state |= CPA_ST_ALIAS;
 		alias_cpa.curpage = 0;
@@ -1978,7 +1990,6 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa = *cpa;
 		alias_cpa.addr = (cpa->pfn << PAGE_SHIFT) +
 				 __START_KERNEL_map - phys_base;
-		alias_cpa.flags &= ~CPA_REQ_PAGES_ARRAY;
 		alias_cpa.state &= ~CPA_ST_FLUSHTLB;
 		alias_cpa.state |= CPA_ST_ALIAS;
 		alias_cpa.curpage = 0;
@@ -2024,9 +2035,6 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa)
 		 * preservation check.
 		 */
 		cpa->numpages = rempages;
-		/* for array changes, we can't use large page */
-		if (cpa->flags & CPA_REQ_PAGES_ARRAY)
-			cpa->numpages = 1;
 
 		scoped_guard(spinlock, &cpa_lock)
 			ret = __change_page_attr(cpa);
@@ -2061,7 +2069,7 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa)
 
 static int change_page_attr_set_clr(unsigned long addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
-				    int in_flag, struct page **pages)
+				    int in_flag)
 {
 	struct cpa_data cpa;
 	int ret, cache;
@@ -2079,18 +2087,12 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 		return 0;
 
 	/* Ensure we are PAGE_SIZE aligned */
-	if (!(in_flag & CPA_REQ_PAGES_ARRAY)) {
+	if (addr & ~PAGE_MASK) {
+		addr &= PAGE_MASK;
 		/*
-		 * in_flag of CPA_REQ_PAGES_ARRAY implies it is aligned.
-		 * No need to check in that case
+		 * People should not be passing in unaligned addresses:
 		 */
-		if (addr & ~PAGE_MASK) {
-			addr &= PAGE_MASK;
-			/*
-			 * People should not be passing in unaligned addresses:
-			 */
-			WARN_ON_ONCE(1);
-		}
+		WARN_ON_ONCE(1);
 	}
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -2099,7 +2101,6 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 	vm_unmap_aliases();
 
 	cpa.addr = addr;
-	cpa.pages = pages;
 	cpa.numpages = numpages;
 	cpa.mask_set = mask_set;
 	cpa.mask_clr = mask_clr;
@@ -2151,29 +2152,88 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 static inline int change_page_attr_set(unsigned long addr, int numpages,
 				       pgprot_t mask)
 {
-	return change_page_attr_set_clr(addr, numpages, mask, __pgprot(0), 0,
-					NULL);
+	return change_page_attr_set_clr(addr, numpages, mask, __pgprot(0), 0);
 }
 
 static inline int change_page_attr_clear(unsigned long addr, int numpages,
 					 pgprot_t mask)
 {
-	return change_page_attr_set_clr(addr, numpages, __pgprot(0), mask, 0,
-					NULL);
+	return change_page_attr_set_clr(addr, numpages, __pgprot(0), mask, 0);
+}
+
+/* The number of pages from @pages[0] that are contiguous in the direct map */
+static int nr_contig_pages(struct page **pages, int numpages)
+{
+	void *addr = page_address(pages[0]);
+	int n;
+
+	for (n = 1; n < numpages; n++) {
+		if (page_address(pages[n]) != addr + n * PAGE_SIZE)
+			break;
+	}
+
+	return n;
+}
+
+/*
+ * Change the pages in ranges that are contiguous in the direct map, so that
+ * a range that covers a large page keeps it. Purge the vmap aliases once
+ * before the ranges and flush once after them.
+ */
+static int change_page_attr_pages(struct page **pages, int numpages,
+				  pgprot_t mask_set, pgprot_t mask_clr)
+{
+	struct cpa_flush_req req = { .pages = pages, .numpages = numpages };
+	struct cpa_data cpa = {
+		.mask_set = canon_pgprot(mask_set),
+		.mask_clr = mask_clr,
+	};
+	int i, n, ret = 0;
+
+	if (!pgprot_val(cpa.mask_set) && !pgprot_val(cpa.mask_clr))
+		return 0;
+
+	kmap_flush_unused();
+	vm_unmap_aliases();
+
+	for (i = 0; i < numpages; i += n) {
+		n = 1;
+		if (PageHighMem(pages[i]))
+			continue;
+
+		n = nr_contig_pages(pages + i, numpages - i);
+		cpa.addr = (unsigned long)page_address(pages[i]);
+		cpa.numpages = n;
+		cpa.curpage = 0;
+		cpa.state = 0;
+		ret = __change_page_attr_set_clr(&cpa);
+		req.state |= cpa.state;
+		if (ret)
+			break;
+	}
+
+	if (!(req.state & CPA_ST_FLUSHTLB))
+		return ret;
+
+	/* On error, flush everything to be sure */
+	if (ret)
+		req.state |= CPA_ST_FLUSH_ALL;
+
+	__cpa_flush(&req, !!pgprot2cachemode(cpa.mask_set));
+
+	return ret;
 }
 
 static inline int cpa_set_pages_array(struct page **pages, int numpages,
 				       pgprot_t mask)
 {
-	return change_page_attr_set_clr(0, numpages, mask, __pgprot(0),
-					CPA_REQ_PAGES_ARRAY, pages);
+	return change_page_attr_pages(pages, numpages, mask, __pgprot(0));
 }
 
 static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 					 pgprot_t mask)
 {
-	return change_page_attr_set_clr(0, numpages, __pgprot(0), mask,
-					CPA_REQ_PAGES_ARRAY, pages);
+	return change_page_attr_pages(pages, numpages, __pgprot(0), mask);
 }
 
 int _set_memory_uc(unsigned long addr, int numpages)
@@ -2222,8 +2282,7 @@ int _set_memory_wc(unsigned long addr, int numpages)
 	if (!ret) {
 		ret = change_page_attr_set_clr(addr, numpages,
 					       cachemode2pgprot(_PAGE_CACHE_MODE_WC),
-					       __pgprot(_PAGE_CACHE_MASK),
-					       0, NULL);
+					       __pgprot(_PAGE_CACHE_MASK), 0);
 	}
 	return ret;
 }
@@ -2342,7 +2401,7 @@ int set_memory_rox(unsigned long addr, int numpages)
 		clr.pgprot |= _PAGE_NX;
 
 	return change_page_attr_set_clr(addr, numpages, __pgprot(0), clr,
-					CPA_REQ_COLLAPSE, NULL);
+					CPA_REQ_COLLAPSE);
 }
 
 int set_memory_rw(unsigned long addr, int numpages)
@@ -2359,7 +2418,7 @@ int set_memory_np_noalias(unsigned long addr, int numpages)
 {
 	return change_page_attr_set_clr(addr, numpages, __pgprot(0),
 					__pgprot(_PAGE_PRESENT),
-					CPA_REQ_NO_CHECK_ALIAS, NULL);
+					CPA_REQ_NO_CHECK_ALIAS);
 }
 
 int set_memory_p(unsigned long addr, int numpages)
@@ -2371,7 +2430,7 @@ int set_memory_4k(unsigned long addr, int numpages)
 {
 	return change_page_attr_set_clr(addr, numpages,
 					__pgprot(_PAGE_KERNEL_4K),
-					__pgprot(0), CPA_REQ_SPLIT, NULL);
+					__pgprot(0), CPA_REQ_SPLIT);
 }
 
 int set_memory_nonglobal(unsigned long addr, int numpages)
@@ -2535,11 +2594,9 @@ static int _set_pages_array(struct page **pages, int numpages,
 	ret = cpa_set_pages_array(pages, numpages,
 				  cachemode2pgprot(set_type));
 	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(0, numpages,
-					       cachemode2pgprot(
-						_PAGE_CACHE_MODE_WC),
-					       __pgprot(_PAGE_CACHE_MASK),
-					       CPA_REQ_PAGES_ARRAY, pages);
+		ret = change_page_attr_pages(pages, numpages,
+				cachemode2pgprot(_PAGE_CACHE_MODE_WC),
+				__pgprot(_PAGE_CACHE_MASK));
 	if (ret)
 		goto err_out;
 	return 0; /* Success */

-- 
2.53.0

