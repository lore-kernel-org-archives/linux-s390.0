Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691835;
	b=iutT/6i5SbZk3p1+c6ZWoJ4CzI1zXBjH3XzH4Y5cKU9laSAfp5g4PCC31GgqJL1hX38A
	 tPCGqdGLruIrxdpBBegULsCMWuLdXTNsTiuF1b9oqzBc6lRgnYTpKz+FFcT6YF5sG4RDs
	 pIsV8qD9c4aJcJ3wSXYJNeroNgq5t3JKD280dHH12jvHkx2jFsnDhewE0YHK9vI2awdsW
	 o5DKSucTim1uwhCXsyVp0HnRy7PS9bCzgrdLkll+UJBzevC5sbbhA+kFRN0gFPySV/VX5
	 XZF8cwOiZJxl0GyxAe52cMGIVJwnfqCwZqb1BMg77WrbnPM+h3MdqiGpEf0a7JIO7/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691835;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=cQR0I1fT91fdkigqZPutQaUEm76FjFQYRJKTMaWDoC4=;
	b=rbbfSUzwF+qVFtha+vUlcPuqE2aSDuD4RTODTwqCukBTnjrLcQ7KnK+aOSgoTIuJgN2C
	 ts45SCAEESfPvLuFRUF1P0VebFMHfXjyRyMxQhlhI2DMvLBUgvW7Qgoni5zzqZtFAKBzC
	 lsM2r8bvVUc8ba/s1+HsKbgT6amDPLK/qGv84ogATMwOK379kIPYu86uROoFwBGq8LBhK
	 up/GpxgUUwb6T/rzUDoKlJci3Bl2KQunHgrj82CENPtfJBnq8Xq8vvi7hIP2l0c0xiQj8
	 fa4fKMcICjLZGPX+66m1k74LT6HqJOQgY2R8SmqxQ5cVXRvVygbuRAKYkWvh2NroxsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcMfD6EF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E2606A329;
	Thu, 26 Nov 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcMfD6EF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F4B1F000F0;
	Thu, 26 Nov 2026 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691835;
	bh=cQR0I1fT91fdkigqZPutQaUEm76FjFQYRJKTMaWDoC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UcMfD6EFN4cKBwOaWtO5aL4DV8MYygih5LNqLm+tzLxTNRXOIvLqKtAzBF0ZhaBkE
	 P2kdK4uYNvbHbk6pVNxYE1FjzNfMHG6gxnBz/OopLg4NvjD1qBb9hAx1HHgPh1MDJl
	 4/+2/+eYx1sjhjoyQygyD3BZ6hozC+nZ+dMUxYLKPDBuHKo7ncu63jozL0IqyFg0jg
	 YMsINPJSowpwfRTpTGZTF+0CdZRBhRuBxLWVw+TSUdLixc04V+2tSLDZubH5VwwULB
	 rLT3p+AEd9I9ue+1l3ls31RF1BMEZz7p/y1XxEXtI0mI4OOwo/poT0TAUX5YZNj0oX
	 AcEClNpvIcfvw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:30 +0200
Subject: [PATCH RFC v2 17/54] x86/mm/pat: drop the check of existing
 mappings against static protections
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-17-723f1e33c3d8@kernel.org>
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

Before deciding whether to keep a large page, CPA checks that the existing
protection of the page satisfies the static protections. If it does not,
CPA warns, splits the page and fixes up the new PTEs.

The only reason commit f61c5ba2885e ("x86/mm/cpa: Add sanity check for
existing mappings") gave for adding the check was that

	... it is possible to do a quick verification that the current
	mapping is correct vs. the static protection areas.

The warning fired only once, on an earlier version of the same series, and
the series fixed the cause with commit 2a25dc7c79c9 ("x86/mm/init32: Mark
text and rodata RO in one go").

Back in 2018 much more code changed the permissions of kernel mappings.
ftrace made the whole kernel text writable and back on every update, any
module could call set_memory_x() and set_memory_nx(), and nothing warned
about W^X mappings.

Since then ftrace switched to text_poke(), the NX helpers are no longer
exported and W^X violations are detected late in boot and by each CPA call.

A mapping that violates static protections cannot appear today:
* CPA checks the requested protection against the static protections before
  it writes a large page
* the page tables built at boot map the kernel text executable and the BIOS
  area with 4K pages
* mark_rodata_ro() enables the read-only checks of static_protections()
  only once all mappings of rodata are read-only

Even if such a mapping appeared, the check would hardly fix it. It sees
only the large pages that later requests touch, and of a 1G page it repairs
only the 2M page around the request.

The check of the existing mappings also complicates how large pages are
split and stands in the way of moving core CPA logic from x86 to generic
code.

Drop the check of the existing mappings and leave only the checks of the
requested protection against the static protections.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 73 +++-----------------------------------------
 1 file changed, 5 insertions(+), 68 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 967d691ef1c0..9ccc08cf220f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -52,7 +52,6 @@ struct cpa_data {
 };
 
 enum cpa_warn {
-	CPA_CONFLICT,
 	CPA_PROTECT,
 	CPA_DETECT,
 };
@@ -76,7 +75,6 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_ST_FLUSHTLB		0x01 /* the TLB needs a flush */
 #define CPA_ST_FLUSH_ALL	0x02 /* flush the entire TLB */
 #define CPA_ST_ALIAS		0x04 /* the request is for an alias */
-#define CPA_ST_STATIC_PROT	0x08 /* enforce static protections in a split */
 
 static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
@@ -629,7 +627,6 @@ static inline void check_conflict(int warnlvl, pgprot_t prot, pgprotval_t val,
 				  unsigned long pfn, const char *txt)
 {
 	static const char *lvltxt[] = {
-		[CPA_CONFLICT]	= "conflict",
 		[CPA_PROTECT]	= "protect",
 		[CPA_DETECT]	= "detect",
 	};
@@ -976,7 +973,7 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 				   enum pg_level level, struct cpa_data *cpa)
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
-	pgprot_t old_prot, new_prot, req_prot, chk_prot;
+	pgprot_t old_prot, new_prot, req_prot;
 	pte_t new_pte;
 
 	if (cpa->flags & CPA_REQ_SPLIT)
@@ -1045,31 +1042,11 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	lpaddr = address & pmask;
 	numpages = psize >> PAGE_SHIFT;
 
-	/*
-	 * Sanity check that the existing mapping is correct versus the static
-	 * protections. static_protections() guards against !PRESENT, so no
-	 * extra conditional required here.
-	 */
-	chk_prot = static_protections(old_prot, lpaddr, old_pfn, numpages,
-				      psize, CPA_CONFLICT);
-
-	if (WARN_ON_ONCE(pgprot_val(chk_prot) != pgprot_val(old_prot))) {
-		/*
-		 * Split the large page and tell the split code to
-		 * enforce static protections.
-		 */
-		cpa->state |= CPA_ST_STATIC_PROT;
-		return 1;
-	}
-
 	/*
 	 * Optimization: If the requested pgprot is the same as the current
 	 * pgprot, then the large page can be preserved and no updates are
 	 * required independent of alignment and length of the requested
-	 * range. The above already established that the current pgprot is
-	 * correct, which in consequence makes the requested pgprot correct
-	 * as well if it is the same. The static protection scan below will
-	 * not come to a different conclusion.
+	 * range.
 	 */
 	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
 		cpa_inc_lp_sameprot(level);
@@ -1112,47 +1089,11 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	return 0;
 }
 
-static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
-			  pgprot_t ref_prot, unsigned long address,
-			  unsigned long size)
-{
-	unsigned int npg = PFN_DOWN(size);
-	pgprot_t prot;
-
-	/*
-	 * If should_split_large_page() discovered an inconsistent mapping,
-	 * remove the invalid protection in the split mapping.
-	 */
-	if (!(cpa->state & CPA_ST_STATIC_PROT))
-		goto set;
-
-	/* Hand in lpsize = 0 to enforce the protection mechanism */
-	prot = static_protections(ref_prot, address, pfn, npg, 0, CPA_PROTECT);
-
-	if (pgprot_val(prot) == pgprot_val(ref_prot))
-		goto set;
-
-	/*
-	 * If this is splitting a PMD, fix it up. PUD splits cannot be
-	 * fixed trivially as that would require to rescan the newly
-	 * installed PMD mappings after returning from split_large_page()
-	 * so an eventual further split can allocate the necessary PTE
-	 * pages. Warn for now and revisit it in case this actually
-	 * happens.
-	 */
-	if (size == PAGE_SIZE)
-		ref_prot = prot;
-	else
-		pr_warn_once("CPA: Cannot fixup static protections for PUD split\n");
-set:
-	set_pte(pte, pfn_pte(pfn, ref_prot));
-}
-
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		   unsigned int level, pte_t *pbase)
 {
-	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
+	unsigned long ref_pfn, pfn, pfninc = 1;
 	struct page *base = virt_to_page(pbase);
 	pgprot_t ref_prot;
 	unsigned int i;
@@ -1168,16 +1109,12 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		 */
 		ref_prot = pgprot_large_2_4k(ref_prot);
 		ref_pfn = pmd_pfn(*(pmd_t *)kpte);
-		lpaddr = address & PMD_MASK;
-		lpinc = PAGE_SIZE;
 		break;
 
 	case PG_LEVEL_1G:
 		ref_prot = pud_pgprot(*(pud_t *)kpte);
 		ref_pfn = pud_pfn(*(pud_t *)kpte);
 		pfninc = PMD_SIZE >> PAGE_SHIFT;
-		lpaddr = address & PUD_MASK;
-		lpinc = PMD_SIZE;
 		/*
 		 * Clear the PSE flags if the PRESENT flag is not set
 		 * otherwise pmd_present() will return true even on a non
@@ -1197,8 +1134,8 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * Get the target pfn from the original entry:
 	 */
 	pfn = ref_pfn;
-	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc, lpaddr += lpinc)
-		split_set_pte(cpa, pbase + i, pfn, ref_prot, lpaddr, lpinc);
+	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
+		set_pte(pbase + i, pfn_pte(pfn, ref_prot));
 
 	if (within(address, PAGE_OFFSET,
 		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))

-- 
2.53.0

