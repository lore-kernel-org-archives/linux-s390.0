Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692150;
	b=LRRVBi/xjsgxDF7H8QTaVAFdsi7ahhgOBfDeEr1MELOJ71nJrBrtPP/CafV6apkBXOh9
	 civ1cbCXk01EkiyGUYuxg32S3wBr3QZpKRXvntKZ9PIUcTpXPwrLWX8eP6AEIYuCDTdWX
	 0GCkIyM00NZ/qNlj9AP08yHOpHa8QCYc0TG0U9pL19US+8t7LketjYEKI+vOqoakTrJJJ
	 YUAcZ8wK3MKy/Gbm2CxJl4cwnFk4o3ns/9xwXP4Q4KmiR4O9/Z+rwDFVWkWgry9Z99hYb
	 LZEXY5MBqPESYyO3M4C+UYhcDD0aVRcasGUFTnCFFjFk9JFVGV2mZGOOB9CrkGwzgzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692150;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vTUzC6jse1/uWBZS2E4r76zLClqKhduPa+hgi40lrUo=;
	b=gNL8/5CON5HXWYaKg4ARD8IBfMdhM78I0zci0i7/my8/FlYPJh+RRccrFWGN+6YCYidF
	 ulOUY5ODcQ8VFUuKiwrmF6xFI7i+bkQP2Zjixy6BcbSIYJOHp5kfodf43k1wLd7nwh6pi
	 EIUC2QUOo3OnfOWgb7aRZiiESB9q3MVOtBPEU+Fshzbmj3ktunHFm4x2w3xdA/dFulseZ
	 f0a0giYyfLBkoljRl+d/zd93vtfewxIycL8u3ilRbO09RY4rYabKHRbOFByIt3ael6SeI
	 OLSfzCHNDVJfaJLWeWkUJsXmDnpmHMHvFLSi9DSpybANXAJOzAPPxF6qtY7VbDkdp3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzEl8tFs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D9606A323;
	Thu, 26 Nov 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzEl8tFs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D262B1F0093E;
	Thu, 26 Nov 2026 11:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692149;
	bh=vTUzC6jse1/uWBZS2E4r76zLClqKhduPa+hgi40lrUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XzEl8tFsXVj9BAAaIUtUGRinOitdJkT0iWw23K1beI9eLYMWSr5Ym3ud2iOjYrznO
	 aLhLxjvRPw3yiT6bbIslM+V6XpUHc+RqVkx5Cb/ipMIL9dFeLMTRot29bRlxe687Pq
	 E9TVxowbXa6Yf1UZn4VTf+dFXfJzV9TqlAnUiouHRmSeOFmgsOj3GJYF3p5/MA0TP1
	 AiOiruVIht3ba+gCJKbn3bPelvZZFU3VjdvIQBZi8hhh9caJRyIRtAR+KgLFgtBUSx
	 fWWEefDszLbQ5S4h6JmVi1EUHxSe+9zWJrd8gDyuj83zYka5hcI0Aq2zcbJjASfmK1
	 sGbbZv0lKcSSQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:15:03 +0200
Subject: [PATCH RFC v2 50/54] arm64: use the generic CPA core
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-50-723f1e33c3d8@kernel.org>
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

arm64 implementation of set_memory_*() APIs has a few shortcomings:

* the page table walk that changes kernel page protections is preceded by
  another walk that splits the mappings at both ends of a request down to
  base pages, whether the request needs that or not
* the linear alias of a vmalloc area is changed and flushed page by page
* set_memory_*() refuse anything but a single VM_ALLOC area, a check that
  dates from when a live mapping could not be split at all and makes arm64
  the odd one out among the architectures

The availability of the generic CPA core makes arm64's implementation of
set_memory_*() APIs unnecessary and it can be replaced with several hooks
required by CPA core.

This way the core can manage the policy decisions and the architecture only
has to take care of the page table manipulation.

Switch to the generic CPA core and its set_memory() entry points.
For arm64 this means that:

* set_memory_*() accept any kernel mapping; a request that needs a split
  arm64 cannot do fails with a warning and -EINVAL
* a contiguous block of entries is kept or changed like a large page; its
  entries are rewritten one by one, so the block has mixed permissions for
  a few stores, the same window every change has before its TLB flush
* the linear alias follows read-only and read-write changes when
  rodata_full is set, as before, for any mapping of RAM
* a request and its aliases run in one lazy MMU section
* requests are serialized by the core; the old walk ran without a lock
* KFENCE and debug_pagealloc change the linear map with interrupts disabled
  and keep a lockless set_memory_valid()
* the linear alias of data and bss, which may use block mappings, is mapped
  and unmapped for hibernation by a request of its own

The mappings at both ends of a request are still split to base pages before
the walk, so the core does not split yet.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/pageattr.h   |  18 ++
 arch/arm64/include/asm/set_memory.h |   2 -
 arch/arm64/mm/mmu.c                 |  21 +-
 arch/arm64/mm/pageattr.c            | 387 +++++++++++++++++++-----------------
 5 files changed, 246 insertions(+), 183 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9b08b2457a55..846fae788b3c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -138,6 +138,7 @@ config ARM64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
+	select GENERIC_PAGEATTR
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/arm64/include/asm/pageattr.h b/arch/arm64/include/asm/pageattr.h
new file mode 100644
index 000000000000..9634cb523298
--- /dev/null
+++ b/arch/arm64/include/asm/pageattr.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PAGEATTR_H
+#define __ASM_PAGEATTR_H
+
+#define cpa_is_direct_map(addr)	__is_lm_address(__tag_reset(addr))
+
+int arch_cpa_process_alias(struct cpa_data *cpa);
+#define arch_cpa_process_alias arch_cpa_process_alias
+
+void arch_cpa_enter(void);
+#define arch_cpa_enter arch_cpa_enter
+
+void arch_cpa_leave(void);
+#define arch_cpa_leave arch_cpa_leave
+
+int arm64_change_page_attr(struct cpa_data *cpa);
+
+#endif /* __ASM_PAGEATTR_H */
diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 0091ba12200e..4c4ca9cd50c8 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -11,8 +11,6 @@ bool can_set_direct_map(void);
 
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
-int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
-int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
 bool kernel_page_present(struct page *page);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0f96efea9057..c8f3961b4555 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/kexec.h>
+#include <linux/pageattr.h>
 #include <linux/libfdt.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -1078,9 +1079,23 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
 
 static void mark_linear_data_alias_valid(bool valid)
 {
-	set_memory_valid((unsigned long)lm_alias(__init_end),
-			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
-			 valid);
+	pgprot_t valid_prot = __pgprot(PTE_PRESENT_VALID_KERNEL);
+	pgprot_t invalid_prot = __pgprot(PTE_PRESENT_INVALID);
+	struct cpa_data cpa = {
+		.addr = (unsigned long)lm_alias(__init_end),
+		.numpages = (__bss_stop - __init_end) / PAGE_SIZE,
+		.mask_set = valid ? valid_prot : invalid_prot,
+		.mask_clr = valid ? invalid_prot : valid_prot,
+		.flags = CPA_REQ_NO_CHECK_ALIAS,
+	};
+	int ret;
+
+	ret = split_kernel_leaf_mapping(cpa.addr,
+					cpa.addr + cpa.numpages * PAGE_SIZE);
+	if (WARN_ON_ONCE(ret))
+		return;
+
+	arm64_change_page_attr(&cpa);
 }
 
 static int arm64_hibernate_pm_notify(struct notifier_block *nb,
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index de7bf95003ea..14a791b8e645 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -8,7 +8,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
-#include <linux/pagewalk.h>
+#include <linux/pageattr.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable-prot.h>
@@ -16,75 +16,94 @@
 #include <asm/tlbflush.h>
 #include <asm/kfence.h>
 
-struct page_change_data {
-	pgprot_t set_mask;
-	pgprot_t clear_mask;
-};
-
-static ptval_t set_pageattr_masks(ptval_t val, struct mm_walk *walk)
+void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
-	struct page_change_data *masks = walk->private;
+	enum pgtable_level level = leaf->level;
+	pte_t pte = __ptep_get(leaf->kpte);
+	pteval_t prot, ns_shared;
+	unsigned int nr;
+
+	if (pte_cont(pte)) {
+		nr = level == PGTABLE_LEVEL_PTE ? CONT_PTES : CONT_PMDS;
+		leaf->kpte = PTR_ALIGN_DOWN(leaf->kpte, nr * sizeof(pte_t));
+		leaf->size *= nr;
+		leaf->addr &= ~(leaf->size - 1);
+		pte = __ptep_get(leaf->kpte);
+	}
 
 	/*
-	 * Some users clear and set bits which alias each other (e.g. PTE_NG and
-	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
-	 * first then set.
+	 * The NS shared bit of a Realm is an address bit that selects the
+	 * unprotected alias of the same memory.
 	 */
-	val &= ~(pgprot_val(masks->clear_mask));
-	val |= (pgprot_val(masks->set_mask));
+	ns_shared = pte_val(pte) & PROT_NS_SHARED;
+	pte = __pte(pte_val(pte) & ~ns_shared);
+
+	switch (level) {
+	case PGTABLE_LEVEL_PTE:
+		leaf->pfn = pte_pfn(pte);
+		break;
+	case PGTABLE_LEVEL_PMD:
+		leaf->pfn = pmd_pfn(pte_pmd(pte));
+		break;
+	default:
+		leaf->pfn = pud_pfn(pte_pud(pte));
+		break;
+	}
 
-	return val;
+	prot = pgprot_val(pte_pgprot(pte)) | ns_shared;
+	leaf->prot = __pgprot((prot & ~PTE_TYPE_MASK) | (prot & PTE_VALID));
 }
 
-static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
+void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
 {
-	pud_t val = pudp_get(pud);
-
-	if (pud_leaf(val)) {
-		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
-			return -EINVAL;
-		val = __pud(set_pageattr_masks(pud_val(val), walk));
-		set_pud(pud, val);
-		walk->action = ACTION_CONTINUE;
-	}
+	unsigned int nr = leaf->size / pgtable_level_size(leaf->level);
+	enum pgtable_level level = leaf->level;
+	pteval_t val = pgprot_val(prot);
+	unsigned long pfn = leaf->pfn;
+	pte_t *kpte = leaf->kpte;
+	unsigned long pfninc;
+	unsigned int i;
 
-	return 0;
-}
+	pfninc = pgtable_level_size(level) >> PAGE_SHIFT;
 
-static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
-{
-	pmd_t val = pmdp_get(pmd);
-
-	if (pmd_leaf(val)) {
-		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
-			return -EINVAL;
-		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
-		set_pmd(pmd, val);
-		walk->action = ACTION_CONTINUE;
-	}
+	if (level == PGTABLE_LEVEL_PTE)
+		val |= PTE_TYPE_PAGE & ~PTE_VALID;
+	prot = __pgprot(val);
 
-	return 0;
+	/*
+	 * The entries of a contiguous block are rewritten one by one, so the
+	 * block has mixed permissions until the last store, as any mapping has
+	 * until the TLB flush of the request.
+	 */
+	for (i = 0; i < nr; i++, pfn += pfninc) {
+		switch (level) {
+		case PGTABLE_LEVEL_PTE:
+			__set_pte(kpte + i, pfn_pte(pfn, prot));
+			break;
+		case PGTABLE_LEVEL_PMD:
+			set_pmd((pmd_t *)kpte + i, pfn_pmd(pfn, prot));
+			break;
+		default:
+			set_pud((pud_t *)kpte + i, pfn_pud(pfn, prot));
+			break;
+		}
+	}
 }
 
-static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
+void arch_cpa_flush(struct cpa_data *cpa)
 {
-	pte_t val = __ptep_get(pte);
-
-	val = __pte(set_pageattr_masks(pte_val(val), walk));
-	__set_pte(pte, val);
+	/*
+	 * If the memory is being switched from present-invalid to valid without
+	 * changing any other bits then a TLBI isn't required as a non-valid
+	 * entry cannot be cached in the TLB.
+	 */
+	if (pgprot_val(cpa->mask_set) == PTE_PRESENT_VALID_KERNEL &&
+	    pgprot_val(cpa->mask_clr) == PTE_PRESENT_INVALID)
+		return;
 
-	return 0;
+	cpa_flush_tlb_kernel_range(cpa);
 }
 
-static const struct mm_walk_ops pageattr_ops = {
-	.pud_entry	= pageattr_pud_entry,
-	.pmd_entry	= pageattr_pmd_entry,
-	.pte_entry	= pageattr_pte_entry,
-};
-
 bool rodata_full __ro_after_init = true;
 
 bool can_set_direct_map(void)
@@ -102,177 +121,189 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
-static int update_range_prot(unsigned long start, unsigned long size,
-			     pgprot_t set_mask, pgprot_t clear_mask)
+/*
+ * If we are manipulating read-only permissions, apply the same
+ * change to the linear mapping of the pages that back this VM area.
+ */
+int arch_cpa_process_alias(struct cpa_data *cpa)
 {
-	struct page_change_data data;
+	pteval_t prot = pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr);
+	unsigned long vaddr = cpa_addr(cpa, cpa->curpage);
+	struct cpa_data alias_cpa;
+	unsigned long alias;
 	int ret;
 
-	data.set_mask = set_mask;
-	data.clear_mask = clear_mask;
+	if (!rodata_full || !(prot & PTE_RDONLY))
+		return 0;
 
-	ret = split_kernel_leaf_mapping(start, start + size);
+	/* Memory that is not RAM, like ioremap(), has no linear map alias. */
+	if (cpa_is_direct_map(vaddr) || !pfn_valid(cpa->pfn))
+		return 0;
+
+	alias = (unsigned long)page_address(pfn_to_page(cpa->pfn));
+	ret = split_kernel_leaf_mapping(alias,
+					alias + cpa->numpages * PAGE_SIZE);
 	if (WARN_ON_ONCE(ret))
 		return ret;
 
-	lazy_mmu_mode_enable();
+	alias_cpa = *cpa;
+	alias_cpa.addr = alias;
+	pgprot_val(alias_cpa.mask_set) &= PTE_RDONLY | PTE_WRITE;
+	pgprot_val(alias_cpa.mask_clr) &= PTE_RDONLY | PTE_WRITE;
 
-	/*
-	 * The caller must ensure that the range we are operating on does not
-	 * partially overlap a block mapping, or a cont mapping. Any such case
-	 * must be eliminated by splitting the mapping.
-	 */
-	ret = walk_kernel_page_table_range_lockless(start, start + size,
-						    &pageattr_ops, NULL, &data);
-	lazy_mmu_mode_disable();
+	ret = cpa_change_alias(cpa, &alias_cpa);
+	if (alias_cpa.state & CPA_ST_FLUSHTLB)
+		arch_cpa_flush(&alias_cpa);
 
 	return ret;
 }
 
-static int __change_memory_common(unsigned long start, unsigned long size,
-				  pgprot_t set_mask, pgprot_t clear_mask)
-{
-	int ret;
-
-	ret = update_range_prot(start, size, set_mask, clear_mask);
-
-	/*
-	 * If the memory is being switched from present-invalid to valid without
-	 * changing any other bits then a TLBI isn't required as a non-valid
-	 * entry cannot be cached in the TLB.
-	 */
-	if (pgprot_val(set_mask) != PTE_PRESENT_VALID_KERNEL ||
-	    pgprot_val(clear_mask) != PTE_PRESENT_INVALID)
-		flush_tlb_kernel_range(start, start + size);
-	return ret;
-}
+static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
+	[CPA_OP_RO]	= { .set = __pgprot(PTE_RDONLY),
+			    .clr = __pgprot(PTE_WRITE) },
+	[CPA_OP_RW]	= { .set = __pgprot(PTE_WRITE),
+			    .clr = __pgprot(PTE_RDONLY) },
+	[CPA_OP_X]	= { .set = __pgprot(PTE_GP),
+			    .clr = __pgprot(PTE_PXN) },
+	[CPA_OP_NX]	= { .set = __pgprot(PTE_PXN),
+			    .clr = __pgprot(PTE_GP) },
+	[CPA_OP_ROX]	= { .set = __pgprot(PTE_RDONLY | PTE_GP),
+			    .clr = __pgprot(PTE_WRITE | PTE_PXN) },
+	[CPA_OP_DIRECT_MAP_INVALID] = {
+		.set = __pgprot(PTE_PRESENT_INVALID),
+		.clr = __pgprot(PTE_VALID | PTE_NG),
+	},
+	[CPA_OP_DIRECT_MAP_DEFAULT] = {
+		.set = __pgprot(PTE_VALID | PTE_NG | PTE_WRITE),
+		.clr = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY),
+	},
+};
 
-static int change_memory_common(unsigned long addr, int numpages,
-				pgprot_t set_mask, pgprot_t clear_mask)
+int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 {
-	unsigned long start = addr;
-	unsigned long size = PAGE_SIZE * numpages;
-	unsigned long end = start + size;
-	struct vm_struct *area;
+	unsigned long start = PAGE_ALIGN_DOWN(cpa->addr);
+	unsigned long end = start + cpa->numpages * PAGE_SIZE;
 	int ret;
 
-	if (!PAGE_ALIGNED(addr)) {
-		start &= PAGE_MASK;
-		end = start + size;
-		WARN_ON_ONCE(1);
-	}
-
-	/*
-	 * Kernel VA mappings are always live, and splitting live section
-	 * mappings into page mappings may cause TLB conflicts. This means
-	 * we have to ensure that changing the permission bits of the range
-	 * we are operating on does not result in such splitting.
-	 *
-	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
-	 * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
-	 * mappings are updated and splitting is never needed.
-	 *
-	 * So check whether the [addr, addr + size) interval is entirely
-	 * covered by precisely one VM area that has the VM_ALLOC flag set.
-	 */
-	area = find_vm_area((void *)addr);
-	if (!area ||
-	    ((unsigned long)kasan_reset_tag((void *)end) >
-	     (unsigned long)kasan_reset_tag(area->addr) + area->size) ||
-	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
-		return -EINVAL;
-
-	if (!numpages)
+	/* Nothing in the linear map is invalid without can_set_direct_map() */
+	if ((op == CPA_OP_DIRECT_MAP_INVALID ||
+	     op == CPA_OP_DIRECT_MAP_DEFAULT) && !can_set_direct_map())
 		return 0;
 
-	/*
-	 * If we are manipulating read-only permissions, apply the same
-	 * change to the linear mapping of the pages that back this VM area.
-	 */
-	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
-			    pgprot_val(clear_mask) == PTE_RDONLY)) {
-		unsigned long idx = ((unsigned long)kasan_reset_tag((void *)start) -
-				     (unsigned long)kasan_reset_tag(area->addr))
-				    >> PAGE_SHIFT;
-		for (; numpages; idx++, numpages--) {
-			ret = __change_memory_common((u64)page_address(area->pages[idx]),
-						     PAGE_SIZE, set_mask, clear_mask);
-			if (ret)
-				return ret;
-		}
-	}
+	ret = split_kernel_leaf_mapping(start, end);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	cpa_init_op(cpa, &cpa_ops[op]);
 
 	/*
-	 * Get rid of potentially aliasing lazily unmapped vm areas that may
-	 * have permissions set that deviate from the ones we are setting here.
+	 * A valid kernel entry has nG only with nG mappings and GP only with
+	 * BTI, see PTE_MAYBE_NG and PTE_MAYBE_GP.
 	 */
-	vm_unmap_aliases();
+	if (!arm64_use_ng_mappings &&
+	    (pgprot_val(cpa->mask_set) & PTE_VALID))
+		pgprot_val(cpa->mask_set) &= ~PTE_NG;
+	if (!system_supports_bti_kernel())
+		pgprot_val(cpa->mask_set) &= ~PTE_GP;
 
-	return __change_memory_common(start, size, set_mask, clear_mask);
+	return 0;
 }
 
-int set_memory_ro(unsigned long addr, int numpages)
+void arch_cpa_enter(void)
 {
-	return change_memory_common(addr, numpages,
-					__pgprot(PTE_RDONLY),
-					__pgprot(PTE_WRITE));
+	lazy_mmu_mode_enable();
 }
 
-int set_memory_rw(unsigned long addr, int numpages)
+void arch_cpa_leave(void)
 {
-	return change_memory_common(addr, numpages,
-					__pgprot(PTE_WRITE),
-					__pgprot(PTE_RDONLY));
+	lazy_mmu_mode_disable();
 }
 
-int set_memory_nx(unsigned long addr, int numpages)
+static int set_valid_pte(pte_t *ptep, unsigned long addr, void *data)
 {
-	return change_memory_common(addr, numpages,
-					__pgprot(PTE_PXN),
-					__pgprot(PTE_MAYBE_GP));
-}
+	struct cpa_op_prot *prot = data;
+	pte_t pte = __ptep_get(ptep);
 
-int set_memory_x(unsigned long addr, int numpages)
-{
-	return change_memory_common(addr, numpages,
-					__pgprot(PTE_MAYBE_GP),
-					__pgprot(PTE_PXN));
+	/*
+	 * Some users clear and set bits which alias each other (e.g. PTE_NG and
+	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
+	 * first then set.
+	 */
+	pte = clear_pte_bit(pte, prot->clr);
+	pte = set_pte_bit(pte, prot->set);
+	__set_pte(ptep, pte);
+
+	return 0;
 }
 
+/*
+ * KFENCE and debug_pagealloc change the linear map with interrupts
+ * disabled. Their pages are mapped with PTEs that nothing splits or
+ * collapses.
+ */
 int set_memory_valid(unsigned long addr, int numpages, int enable)
 {
-	if (enable)
-		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(PTE_PRESENT_VALID_KERNEL),
-					__pgprot(PTE_PRESENT_INVALID));
-	else
-		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(PTE_PRESENT_INVALID),
-					__pgprot(PTE_PRESENT_VALID_KERNEL));
+	unsigned long size = PAGE_SIZE * numpages;
+	struct cpa_op_prot prot;
+	int ret;
+
+	if (enable) {
+		prot.set = __pgprot(PTE_PRESENT_VALID_KERNEL);
+		prot.clr = __pgprot(PTE_PRESENT_INVALID);
+	} else {
+		prot.set = __pgprot(PTE_PRESENT_INVALID);
+		prot.clr = __pgprot(PTE_PRESENT_VALID_KERNEL);
+	}
+
+	ret = apply_to_existing_page_range(&init_mm, addr, size, set_valid_pte,
+					   &prot);
+
+	/*
+	 * If the memory is being switched from present-invalid to valid without
+	 * changing any other bits then a TLBI isn't required as a non-valid
+	 * entry cannot be cached in the TLB.
+	 */
+	if (!enable)
+		flush_tlb_kernel_range(addr, addr + size);
+
+	return ret;
 }
 
-int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
+/*
+ * Unlike set_memory_*(), the arm64 users of the core don't purge the
+ * lazily freed vmap aliases first.
+ */
+int arm64_change_page_attr(struct cpa_data *cpa)
 {
-	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
-	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
+	int ret;
 
-	if (!can_set_direct_map())
-		return 0;
+	arch_cpa_enter();
+	ret = change_page_attr_noflush(cpa);
+	arch_cpa_leave();
+
+	if (cpa->state & CPA_ST_FLUSHTLB)
+		arch_cpa_flush(cpa);
 
-	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE * numpages, set_mask, clear_mask);
+	return ret;
 }
 
-int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
+static int __change_memory_common(unsigned long start, unsigned long size,
+				  pgprot_t set_mask, pgprot_t clear_mask)
 {
-	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
-	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
+	struct cpa_data cpa = {
+		.addr = start,
+		.numpages = size >> PAGE_SHIFT,
+		.mask_set = set_mask,
+		.mask_clr = clear_mask,
+		.flags = CPA_REQ_NO_CHECK_ALIAS,
+	};
+	int ret;
 
-	if (!can_set_direct_map())
-		return 0;
+	ret = split_kernel_leaf_mapping(start, start + size);
+	if (WARN_ON_ONCE(ret))
+		return ret;
 
-	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE * numpages, set_mask, clear_mask);
+	return arm64_change_page_attr(&cpa);
 }
 
 int __set_memory_enc_dec(unsigned long addr, int numpages, bool encrypt)

-- 
2.53.0

