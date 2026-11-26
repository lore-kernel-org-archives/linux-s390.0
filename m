Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691760;
	b=DZIWjp8ekHG5raCzSrhEW4227yg7CcbkiUQVFnZHFOhuJ1bTtAD4qRFL2SOBaQDq1Pj/
	 eZzL1A3pYGBkIzUKIaOmsSOyHwqDkZCfcAjvLxY7fLT/TGcNrOi+2qbRzkpHFNeGorobD
	 xBvt17zU/MdR7siWiRd4Y41KIHJkFcKnmZQ+EC5Ufk2odK48mQ5QLh5Ls3CipFHjqK+ZC
	 E3sB7gqqzog4CbP9nY+GqpuH095gSQ9HWr7TLpjyEp8URLCTegPBFLI+GsSLFN+JJhPhU
	 qOdT7X9G1gFOA+UnONi5Hv0EjzP10o2lAAApC1sPflJiE0+LhWWdHOmNModFZJ6KjRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691760;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=fy5KZMztyzoKNgAg4JKAaRVyHwAm9TeHRfmGuZN5crU=;
	b=X4ttoPfe0ePPZtbutJvhCd4AOnpdIff1YpZo7KHvU+pk49MXAAXOOJ1oF+Te6QM48SNm
	 qnwGPkPIC6jU9flx3oKq43dLUgNRzqztwMWhoLfWYGU3lif5ixYscN9dcWjbZc/GLZidz
	 I6CUqf4PigrQ4/YGv1ieB/jUZPDivdRb33txu2F/J3Zcf3yIqxrYnJ0JzTBFSTaW5uMMA
	 rqAAO9+UB7IwcQlUZPsptZxjNno3WNzlrsuGDMX23yrQX59p8YWMwi5kMkVoWxQPRsgpO
	 GWF1nIRR0f7PFvIl7rgIY6/v6FpD7m4+L/+nfxHysgWuquWyczIU68UwFQ9o6mpvMhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxAcdhFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73353606A31C;
	Thu, 26 Nov 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxAcdhFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3481F000C4;
	Thu, 26 Nov 2026 11:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691760;
	bh=fy5KZMztyzoKNgAg4JKAaRVyHwAm9TeHRfmGuZN5crU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YxAcdhFAXulQBORxsJyF8xRuA4wXhFNKNIxSaH6yZCfpntpAPKL8Fw8bitNlCErrm
	 cCO5tgzMDCpg59xGeskkjki5d2LhF94Bjc//nKA4Os5cevMZdjOnMeLSewZ5Sfm7MF
	 J75NvYfEDDPJ+8duVPwQgs9vvdKaS53r5ED0dr2OGsVNlMS0T8tmCrNpWgBabF0fZZ
	 1Ky7Xz84B/n+7ZlpzeDhiEnIqwbQOJ+VSmddhLqZIoX7q9JNV+Z5hKXvjCUXtFOuK0
	 YQwf9/6Txmy6V4ouoAgW+eCwkQqlh6XlBp55GGcAWJ0H0gvXsA/XAooQQ3mJaYo4JL
	 UCafOt0SQi6fw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:22 +0200
Subject: [PATCH RFC v2 09/54] x86/mm/pat: separate CPA request flags from
 internal state
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-9-723f1e33c3d8@kernel.org>
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

struct cpa_data has a mixture of flags stored in the flags field and in
several bitfields, such as .force_split and .force_flush_all.

The use of plain flags and bitfields for caller-requested behaviour and
internal state management is inconsistent: .force_split is a caller
request, while the other bitfields are managed internally by CPA functions.

The same is true for CPA_ flags: CPA_FLUSHTLB is set internally when a TLB
flush is required, while the other flags express the desired behaviour.

Keep caller requests in cpa_data.flags and move internal bookkeeping to
cpa_data.state. Replace the bitfields with CPA_ flags.

To distinguish requests from the state prefix the request flags with
CPA_REQ_ and the state flags with CPA_ST_.

Pass forced splitting as a request flag and track alias recursion in state
instead of passing a separate primary argument. Preserve the existing
locking, protection and flushing behaviour.

Since all the defines are updated, also change their values to ease the
upcoming changes.

No functional change intended.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 167 ++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 81 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 217c739371ee..87c7c7934b42 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -48,10 +48,7 @@ struct cpa_data {
 	unsigned long	curpage;
 	unsigned long	pfn;
 	unsigned int	flags;
-	unsigned int	force_split		: 1,
-			force_static_prot	: 1,
-			force_flush_all		: 1,
-			init_mm_read_locked	: 1;
+	unsigned int	state;
 	struct page	**pages;
 };
 
@@ -70,11 +67,19 @@ static const int cpa_warn_level = CPA_PROTECT;
  */
 static DEFINE_SPINLOCK(cpa_lock);
 
-#define CPA_FLUSHTLB		0x01
-#define CPA_PAGES_ARRAY		0x04
-#define CPA_NO_CHECK_ALIAS	0x08 /* Do not search for aliases */
-#define CPA_COLLAPSE		0x10 /* try to collapse large pages */
-#define CPA_DEBUG_PAGEALLOC	0x20
+/* cpa_data::flags */
+#define CPA_REQ_NO_CHECK_ALIAS	0x01 /* Do not search for aliases */
+#define CPA_REQ_COLLAPSE	0x02 /* try to collapse large pages */
+#define CPA_REQ_SPLIT		0x04 /* split large pages */
+#define CPA_REQ_PAGES_ARRAY	0x08
+#define CPA_REQ_DEBUG_PAGEALLOC	0x10
+
+/* cpa_data::state */
+#define CPA_ST_FLUSHTLB		0x01 /* the TLB needs a flush */
+#define CPA_ST_FLUSH_ALL	0x02 /* flush the entire TLB */
+#define CPA_ST_ALIAS		0x04 /* the request is for an alias */
+#define CPA_ST_STATIC_PROT	0x08 /* enforce static protections in a split */
+#define CPA_ST_INIT_MM_LOCKED	0x10 /* init_mm's mmap lock is held */
 
 static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
@@ -305,7 +310,7 @@ static inline unsigned long fix_addr(unsigned long addr)
 
 static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
-	if (cpa->flags & CPA_PAGES_ARRAY) {
+	if (cpa->flags & CPA_REQ_PAGES_ARRAY) {
 		struct page *page = cpa->pages[idx];
 
 		if (unlikely(PageHighMem(page)))
@@ -415,7 +420,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 	int collapsed = 0;
 	int i;
 
-	if (cpa->flags & CPA_PAGES_ARRAY) {
+	if (cpa->flags & CPA_REQ_PAGES_ARRAY) {
 		for (i = 0; i < cpa->numpages; i++)
 			collapsed += collapse_large_pages(__cpa_addr(cpa, i),
 							  &pgtables);
@@ -458,7 +463,8 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 		return;
 	}
 
-	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
+	if ((cpa->state & CPA_ST_FLUSH_ALL) ||
+	    cpa->numpages > tlb_single_page_flush_ceiling)
 		flush_tlb_all();
 	else
 		on_each_cpu(__cpa_flush_tlb, cpa, 1);
@@ -1027,7 +1033,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 		 * Split the large page and tell the split code to
 		 * enforce static protections.
 		 */
-		cpa->force_static_prot = 1;
+		cpa->state |= CPA_ST_STATIC_PROT;
 		return 1;
 	}
 
@@ -1076,7 +1082,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	/* All checks passed. Update the large page mapping. */
 	new_pte = pfn_pte(old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);
-	cpa->flags |= CPA_FLUSHTLB;
+	cpa->state |= CPA_ST_FLUSHTLB;
 	cpa_inc_lp_preserved(level);
 	return 0;
 }
@@ -1084,7 +1090,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 static int should_split_large_page(pte_t *kpte, unsigned long address,
 				   struct cpa_data *cpa)
 {
-	if (cpa->force_split)
+	if (cpa->flags & CPA_REQ_SPLIT)
 		return 1;
 
 	guard(spinlock)(&pgd_lock);
@@ -1102,7 +1108,7 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 	 * If should_split_large_page() discovered an inconsistent mapping,
 	 * remove the invalid protection in the split mapping.
 	 */
-	if (!cpa->force_static_prot)
+	if (!(cpa->state & CPA_ST_STATIC_PROT))
 		goto set;
 
 	/* Hand in lpsize = 0 to enforce the protection mechanism */
@@ -1233,10 +1239,10 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	int ret;
 
 	spin_unlock(&cpa_lock);
-	if (cpa->init_mm_read_locked)
+	if (cpa->state & CPA_ST_INIT_MM_LOCKED)
 		mmap_read_unlock(&init_mm);
 	pte = pte_alloc_one_kernel(&init_mm);
-	if (cpa->init_mm_read_locked)
+	if (cpa->state & CPA_ST_INIT_MM_LOCKED)
 		mmap_read_lock(&init_mm);
 	spin_lock(&cpa_lock);
 	if (!pte)
@@ -1802,8 +1808,7 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 	return 0;
 }
 
-static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
-			       int primary)
+static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr)
 {
 	if (cpa->pgd) {
 		/*
@@ -1817,7 +1822,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 	/*
 	 * Ignore all non primary paths.
 	 */
-	if (!primary) {
+	if (cpa->state & CPA_ST_ALIAS) {
 		cpa->numpages = 1;
 		return 0;
 	}
@@ -1847,7 +1852,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 	}
 }
 
-static int __change_page_attr(struct cpa_data *cpa, int primary)
+static int __change_page_attr(struct cpa_data *cpa)
 {
 	unsigned long address;
 	int do_split, err;
@@ -1859,11 +1864,11 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 repeat:
 	kpte = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
 	if (!kpte)
-		return __cpa_process_fault(cpa, address, primary);
+		return __cpa_process_fault(cpa, address);
 
 	old_pte = *kpte;
 	if (pte_none(old_pte))
-		return __cpa_process_fault(cpa, address, primary);
+		return __cpa_process_fault(cpa, address);
 
 	if (level == PG_LEVEL_4K) {
 		pte_t new_pte;
@@ -1896,7 +1901,7 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		 */
 		if (pte_val(old_pte) != pte_val(new_pte)) {
 			set_pte_atomic(kpte, new_pte);
-			cpa->flags |= CPA_FLUSHTLB;
+			cpa->state |= CPA_ST_FLUSHTLB;
 		}
 		cpa->numpages = 1;
 		return 0;
@@ -1925,7 +1930,7 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 	return err;
 }
 
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary);
+static int __change_page_attr_set_clr(struct cpa_data *cpa);
 
 /*
  * Check the directmap and "high kernel map" 'aliases'.
@@ -1949,7 +1954,9 @@ static int cpa_process_alias(struct cpa_data *cpa)
 
 		alias_cpa = *cpa;
 		alias_cpa.addr = (unsigned long)__va(cpa->pfn << PAGE_SHIFT);
-		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_FLUSHTLB);
+		alias_cpa.flags &= ~CPA_REQ_PAGES_ARRAY;
+		alias_cpa.state &= ~CPA_ST_FLUSHTLB;
+		alias_cpa.state |= CPA_ST_ALIAS;
 		alias_cpa.curpage = 0;
 
 		/* Directmap always has NX set, do not modify. */
@@ -1958,11 +1965,9 @@ static int cpa_process_alias(struct cpa_data *cpa)
 			alias_cpa.mask_set.pgprot &= ~_PAGE_NX;
 		}
 
-		ret = __change_page_attr_set_clr(&alias_cpa, 0);
-		if (alias_cpa.flags & CPA_FLUSHTLB) {
-			cpa->flags |= CPA_FLUSHTLB;
-			cpa->force_flush_all = 1;
-		}
+		ret = __change_page_attr_set_clr(&alias_cpa);
+		if (alias_cpa.state & CPA_ST_FLUSHTLB)
+			cpa->state |= CPA_ST_FLUSHTLB | CPA_ST_FLUSH_ALL;
 		if (ret)
 			return ret;
 	}
@@ -1978,7 +1983,9 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa = *cpa;
 		alias_cpa.addr = (cpa->pfn << PAGE_SHIFT) +
 				 __START_KERNEL_map - phys_base;
-		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_FLUSHTLB);
+		alias_cpa.flags &= ~CPA_REQ_PAGES_ARRAY;
+		alias_cpa.state &= ~CPA_ST_FLUSHTLB;
+		alias_cpa.state |= CPA_ST_ALIAS;
 		alias_cpa.curpage = 0;
 
 		/*
@@ -1994,18 +2001,16 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		 * The high mapping range is imprecise, so ignore the
 		 * return value.
 		 */
-		__change_page_attr_set_clr(&alias_cpa, 0);
-		if (alias_cpa.flags & CPA_FLUSHTLB) {
-			cpa->flags |= CPA_FLUSHTLB;
-			cpa->force_flush_all = 1;
-		}
+		__change_page_attr_set_clr(&alias_cpa);
+		if (alias_cpa.state & CPA_ST_FLUSHTLB)
+			cpa->state |= CPA_ST_FLUSHTLB | CPA_ST_FLUSH_ALL;
 	}
 #endif
 
 	return 0;
 }
 
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
+static int __change_page_attr_set_clr(struct cpa_data *cpa)
 {
 	unsigned long numpages = cpa->numpages;
 	unsigned long rempages = numpages;
@@ -2016,7 +2021,7 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 	 * No changes, easy!
 	 */
 	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)) &&
-	    !cpa->force_split)
+	    !(cpa->flags & CPA_REQ_SPLIT))
 		return ret;
 
 	/*
@@ -2039,7 +2044,7 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 	 *
 	 * Therefore, it is safe to not take cpa_lock.
 	 */
-	if (debug_pagealloc_enabled() && (cpa->flags & CPA_DEBUG_PAGEALLOC))
+	if (debug_pagealloc_enabled() && (cpa->flags & CPA_REQ_DEBUG_PAGEALLOC))
 		lock = false;
 
 	while (rempages) {
@@ -2049,19 +2054,20 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 		 */
 		cpa->numpages = rempages;
 		/* for array changes, we can't use large page */
-		if (cpa->flags & CPA_PAGES_ARRAY)
+		if (cpa->flags & CPA_REQ_PAGES_ARRAY)
 			cpa->numpages = 1;
 
 		if (lock) {
 			guard(spinlock)(&cpa_lock);
-			ret = __change_page_attr(cpa, primary);
+			ret = __change_page_attr(cpa);
 		} else {
-			ret = __change_page_attr(cpa, primary);
+			ret = __change_page_attr(cpa);
 		}
 		if (ret)
 			goto out;
 
-		if (primary && !(cpa->flags & CPA_NO_CHECK_ALIAS)) {
+		if (!(cpa->state & CPA_ST_ALIAS) &&
+		    !(cpa->flags & CPA_REQ_NO_CHECK_ALIAS)) {
 			ret = cpa_process_alias(cpa);
 			if (ret)
 				goto out;
@@ -2088,8 +2094,7 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 
 static int change_page_attr_set_clr(unsigned long addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
-				    int force_split, int in_flag,
-				    struct page **pages)
+				    int in_flag, struct page **pages)
 {
 	struct cpa_data cpa;
 	int ret, cache;
@@ -2102,13 +2107,14 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 	 */
 	mask_set = canon_pgprot(mask_set);
 
-	if (!pgprot_val(mask_set) && !pgprot_val(mask_clr) && !force_split)
+	if (!pgprot_val(mask_set) && !pgprot_val(mask_clr) &&
+	    !(in_flag & CPA_REQ_SPLIT))
 		return 0;
 
 	/* Ensure we are PAGE_SIZE aligned */
-	if (!(in_flag & CPA_PAGES_ARRAY)) {
+	if (!(in_flag & CPA_REQ_PAGES_ARRAY)) {
 		/*
-		 * in_flag of CPA_PAGES_ARRAY implies it is aligned.
+		 * in_flag of CPA_REQ_PAGES_ARRAY implies it is aligned.
 		 * No need to check in that case
 		 */
 		if (addr & ~PAGE_MASK) {
@@ -2132,18 +2138,17 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 	cpa.mask_clr = mask_clr;
 	cpa.flags = in_flag;
 	cpa.curpage = 0;
-	cpa.force_split = force_split;
 
 	/* Avoid race with concurrent CPA collapse. */
-	cpa.init_mm_read_locked = true;
+	cpa.state = CPA_ST_INIT_MM_LOCKED;
 	scoped_guard(mmap_read_lock, &init_mm)
-		ret = __change_page_attr_set_clr(&cpa, 1);
-	cpa.init_mm_read_locked = false;
+		ret = __change_page_attr_set_clr(&cpa);
+	cpa.state &= ~CPA_ST_INIT_MM_LOCKED;
 
 	/*
 	 * Check whether we really changed something:
 	 */
-	if (!(cpa.flags & CPA_FLUSHTLB))
+	if (!(cpa.state & CPA_ST_FLUSHTLB))
 		goto out;
 
 	/*
@@ -2156,14 +2161,14 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 	 * On error; flush everything to be sure.
 	 */
 	if (ret)
-		cpa.force_flush_all = 1;
+		cpa.state |= CPA_ST_FLUSH_ALL;
 
 	cpa_flush(&cpa, cache);
 
 	if (ret)
 		goto out;
 
-	if (!(cpa.flags & CPA_COLLAPSE))
+	if (!(cpa.flags & CPA_REQ_COLLAPSE))
 		goto out;
 
 	/*
@@ -2184,28 +2189,28 @@ static inline int change_page_attr_set(unsigned long addr, int numpages,
 				       pgprot_t mask)
 {
 	return change_page_attr_set_clr(addr, numpages, mask, __pgprot(0), 0,
-					0, NULL);
+					NULL);
 }
 
 static inline int change_page_attr_clear(unsigned long addr, int numpages,
 					 pgprot_t mask)
 {
 	return change_page_attr_set_clr(addr, numpages, __pgprot(0), mask, 0,
-					0, NULL);
+					NULL);
 }
 
 static inline int cpa_set_pages_array(struct page **pages, int numpages,
 				       pgprot_t mask)
 {
-	return change_page_attr_set_clr(0, numpages, mask, __pgprot(0), 0,
-		CPA_PAGES_ARRAY, pages);
+	return change_page_attr_set_clr(0, numpages, mask, __pgprot(0),
+					CPA_REQ_PAGES_ARRAY, pages);
 }
 
 static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 					 pgprot_t mask)
 {
-	return change_page_attr_set_clr(0, numpages, __pgprot(0), mask, 0,
-		CPA_PAGES_ARRAY, pages);
+	return change_page_attr_set_clr(0, numpages, __pgprot(0), mask,
+					CPA_REQ_PAGES_ARRAY, pages);
 }
 
 int _set_memory_uc(unsigned long addr, int numpages)
@@ -2255,7 +2260,7 @@ int _set_memory_wc(unsigned long addr, int numpages)
 		ret = change_page_attr_set_clr(addr, numpages,
 					       cachemode2pgprot(_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
-					       0, 0, NULL);
+					       0, NULL);
 	}
 	return ret;
 }
@@ -2373,8 +2378,8 @@ int set_memory_rox(unsigned long addr, int numpages)
 	if (__supported_pte_mask & _PAGE_NX)
 		clr.pgprot |= _PAGE_NX;
 
-	return change_page_attr_set_clr(addr, numpages, __pgprot(0), clr, 0,
-					CPA_COLLAPSE, NULL);
+	return change_page_attr_set_clr(addr, numpages, __pgprot(0), clr,
+					CPA_REQ_COLLAPSE, NULL);
 }
 
 int set_memory_rw(unsigned long addr, int numpages)
@@ -2390,8 +2395,8 @@ int set_memory_np(unsigned long addr, int numpages)
 int set_memory_np_noalias(unsigned long addr, int numpages)
 {
 	return change_page_attr_set_clr(addr, numpages, __pgprot(0),
-					__pgprot(_PAGE_PRESENT), 0,
-					CPA_NO_CHECK_ALIAS, NULL);
+					__pgprot(_PAGE_PRESENT),
+					CPA_REQ_NO_CHECK_ALIAS, NULL);
 }
 
 int set_memory_p(unsigned long addr, int numpages)
@@ -2403,7 +2408,7 @@ int set_memory_4k(unsigned long addr, int numpages)
 {
 	return change_page_attr_set_clr(addr, numpages,
 					__pgprot(_PAGE_KERNEL_4K),
-					__pgprot(0), 1, 0, NULL);
+					__pgprot(0), CPA_REQ_SPLIT, NULL);
 }
 
 int set_memory_nonglobal(unsigned long addr, int numpages)
@@ -2449,7 +2454,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	if (ret)
 		goto vmm_fail;
 
-	ret = __change_page_attr_set_clr(&cpa, 1);
+	ret = __change_page_attr_set_clr(&cpa);
 
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
@@ -2571,7 +2576,7 @@ static int _set_pages_array(struct page **pages, int numpages,
 					       cachemode2pgprot(
 						_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
-					       0, CPA_PAGES_ARRAY, pages);
+					       CPA_REQ_PAGES_ARRAY, pages);
 	if (ret)
 		goto err_out;
 	return 0; /* Success */
@@ -2653,7 +2658,7 @@ static int __set_pages_p(struct page *page, int numpages, unsigned int cpa_flags
 				.numpages = numpages,
 				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
 				.mask_clr = __pgprot(0),
-				.flags = CPA_NO_CHECK_ALIAS | cpa_flags };
+				.flags = CPA_REQ_NO_CHECK_ALIAS | cpa_flags };
 
 	/*
 	 * No alias checking needed for setting present flag. otherwise,
@@ -2661,7 +2666,7 @@ static int __set_pages_p(struct page *page, int numpages, unsigned int cpa_flags
 	 * mappings (this adds to complexity if we want to do this from
 	 * atomic context especially). Let's keep it simple!
 	 */
-	return __change_page_attr_set_clr(&cpa, 1);
+	return __change_page_attr_set_clr(&cpa);
 }
 
 static int __set_pages_np(struct page *page, int numpages, unsigned int cpa_flags)
@@ -2671,7 +2676,7 @@ static int __set_pages_np(struct page *page, int numpages, unsigned int cpa_flag
 				.numpages = numpages,
 				.mask_set = __pgprot(0),
 				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
-				.flags = CPA_NO_CHECK_ALIAS | cpa_flags };
+				.flags = CPA_REQ_NO_CHECK_ALIAS | cpa_flags };
 
 	/*
 	 * No alias checking needed for setting not present flag. otherwise,
@@ -2679,7 +2684,7 @@ static int __set_pages_np(struct page *page, int numpages, unsigned int cpa_flag
 	 * mappings (this adds to complexity if we want to do this from
 	 * atomic context especially). Let's keep it simple!
 	 */
-	return __change_page_attr_set_clr(&cpa, 1);
+	return __change_page_attr_set_clr(&cpa);
 }
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
@@ -2708,9 +2713,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 	 * and hence no memory allocations during large page split.
 	 */
 	if (enable)
-		__set_pages_p(page, numpages, CPA_DEBUG_PAGEALLOC);
+		__set_pages_p(page, numpages, CPA_REQ_DEBUG_PAGEALLOC);
 	else
-		__set_pages_np(page, numpages, CPA_DEBUG_PAGEALLOC);
+		__set_pages_np(page, numpages, CPA_REQ_DEBUG_PAGEALLOC);
 
 	/*
 	 * We should perform an IPI and flush all tlbs, but that can
@@ -2758,7 +2763,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
 		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW|_PAGE_DIRTY)),
-		.flags = CPA_NO_CHECK_ALIAS,
+		.flags = CPA_REQ_NO_CHECK_ALIAS,
 	};
 
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
@@ -2771,7 +2776,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 
 	cpa.mask_set = __pgprot(_PAGE_PRESENT | page_flags);
 
-	retval = __change_page_attr_set_clr(&cpa, 1);
+	retval = __change_page_attr_set_clr(&cpa);
 	__flush_tlb_all();
 
 out:
@@ -2801,12 +2806,12 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 		.numpages	= numpages,
 		.mask_set	= __pgprot(0),
 		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
-		.flags		= CPA_NO_CHECK_ALIAS,
+		.flags		= CPA_REQ_NO_CHECK_ALIAS,
 	};
 
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
 
-	retval = __change_page_attr_set_clr(&cpa, 1);
+	retval = __change_page_attr_set_clr(&cpa);
 	__flush_tlb_all();
 
 	return retval;

-- 
2.53.0

