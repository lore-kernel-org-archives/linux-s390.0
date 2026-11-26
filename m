Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692159;
	b=GCq4ifKQ8lsVvcOZfW5Xa23m3ZPsPIhXL0JdYn/pDD3+xhlGXv0e9Mc4M8cRY2JOlsaF
	 5i9oxxCFJKo8u91epkSwdVlad1x/R+RvRxo+vfm9IiE1PVvOmdh+Q8AY9hh+nsmC8YmtM
	 tRYIdyu3UfI+jcwYyqgGmqlor/ZgDnlfEE+XrC8grvaKZJvKUBjpOOZZSRN+qmvuXJ/SO
	 ddLYSQqGbGjpHxMxigFSntyFw07xjFSuOdm71spC/BukMhCInUryafYIGJmJ7HLtI2FWH
	 mk4N7gSVDi8f+4UMEziaxuPVeQWixm3wBBC0mGy54zilqIT26Ktl/FiHuEHCHvOlVaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692159;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=x9nhB1RW8+V8Xp4nOlz+JVECnctRj+T1Gz/CePKun4g=;
	b=keEfqXgRoye+1LsZ6BLrTYfVl/w7uNJx7mQqWGVEHTJ7BfeAs4L59BNqG2G+zcCNAH0L
	 o3XbmSkkaDhVvrDx2ohbGirCOPdLPdGSVe6cy/LbGiltIQEZaJXwKFvdWLtxLRtxiRwOC
	 w5kp8BDVY3uXIymWFRwBdM23OS+RCVDpqfNtHweA7hGN8mdy2P1KQoQ72MAVvqHWHlXTa
	 Kw8O6amJ712x54KwV+o5x23gta4hpbePEtT5zDMZjbObPDyr+nXhPlNbruiCCZR95Bx/8
	 onT+qryH8AlSE+FRayVJoz0FGjZqgyeIwpiZRe1l0lyeWkUfztZaj9Y+0igqmr8tmYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OouPlr/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CA606A339;
	Thu, 26 Nov 2026 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OouPlr/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761211F00A3E;
	Thu, 26 Nov 2026 11:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692159;
	bh=x9nhB1RW8+V8Xp4nOlz+JVECnctRj+T1Gz/CePKun4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OouPlr/SAZWddhWz03Hx5JOd+oPtbY33NpRXwE5d7ae2uquSj5lbDn/AlNeEFLCTn
	 0EylNMwOIIMTzBn7R5350kHm1n4Z3FOEz2uS0csQrk2g7m+jh6DtGWnkCGAwYylWDD
	 gOK6Wl2ye6LnpJGYb1Ug+XRXogUmBXeZcNoToxEGcUodL91ZQcQ0iQ9Lf2l2bCA0WN
	 eO2gSzH1DRY3brbY+byxbloPguegH3B9JNxtxwgfqs69AKWGEBl/25D4rtkyZBLW8Q
	 Qutiv71ucCsvOWf75UIiVRU16q8Ni7tcNU2lzz0NkdYwb5cgTQUjY6YSOiWfdNx9Q8
	 VxfpImA2nLJrg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:15:04 +0200
Subject: [PATCH RFC v2 51/54] arm64: let the generic CPA core split large
 mappings
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-51-723f1e33c3d8@kernel.org>
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

When BBML3 is available, set_memory_*() calls split both ends of a request
to base pages before updating the protections, under a mutex, whether the
request needs that or not.

The KFENCE pool is split by a walk of its own under the same mutex.

Implement arch_cpa_can_split() and arch_cpa_split_leaf() hooks to let CPA
core logic decide which large mappings should be split and synchronize the
splits against other CPA operations.

The CPA core makes sure that only the blocks and contiguous entries that
must be split are actually split.

Before it splits a mapping, the core calls arch_cpa_can_split(), which
allows a split only where the CPU supports BBML3:

* after the capabilities are finalized, when system_supports_bbml3()
* before that, only on the boot CPU, when cpu_supports_bbml3()

With BBML3 a translation of the old size may linger in the TLB, so the
split needs no TLB flush, as before.

With that:

* the late KFENCE pool is split by a CPA_REQ_SPLIT request, straight to
  base pages, so that it cannot race with the splits of the core
* split_kernel_leaf_mapping(), the mutex and page_alloc_available go; a
  split before the page allocator is populated fails with -ENOMEM from the
  allocation instead of a warning
* the boot time split of the linear map keeps its current implementation

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/include/asm/mmu.h      |   3 -
 arch/arm64/include/asm/pageattr.h |   5 +
 arch/arm64/mm/init.c              |   3 -
 arch/arm64/mm/mmu.c               | 222 +++++++-------------------------------
 arch/arm64/mm/pageattr.c          |  22 +---
 5 files changed, 45 insertions(+), 210 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 5e1211c540ab..9b7f16fa24d0 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -70,7 +70,6 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
-extern int split_kernel_leaf_mapping(unsigned long start, unsigned long end);
 extern void linear_map_maybe_split_to_ptes(void);
 
 /*
@@ -104,7 +103,5 @@ void kpti_install_ng_mappings(void);
 static inline void kpti_install_ng_mappings(void) {}
 #endif
 
-extern bool page_alloc_available;
-
 #endif	/* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/include/asm/pageattr.h b/arch/arm64/include/asm/pageattr.h
index 9634cb523298..2f8c16d39d23 100644
--- a/arch/arm64/include/asm/pageattr.h
+++ b/arch/arm64/include/asm/pageattr.h
@@ -4,6 +4,11 @@
 
 #define cpa_is_direct_map(addr)	__is_lm_address(__tag_reset(addr))
 
+int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
+			void *table);
+bool arch_cpa_can_split(struct cpa_data *cpa, struct cpa_leaf *leaf);
+#define arch_cpa_can_split arch_cpa_can_split
+
 int arch_cpa_process_alias(struct cpa_data *cpa);
 #define arch_cpa_process_alias arch_cpa_process_alias
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4e7682dfe366..84ba461861c5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -379,11 +379,8 @@ void __init arch_mm_preinit(void)
 	}
 }
 
-bool page_alloc_available __ro_after_init;
-
 void __init mem_init(void)
 {
-	page_alloc_available = true;
 	swiotlb_update_mem_attributes();
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c8f3961b4555..40c5ac95f574 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -670,115 +670,44 @@ static void split_pud(pud_t *pudp, pud_t pud, pmd_t *pmdp, bool to_cont)
 	__pud_populate(pudp, pmd_phys, tableprot);
 }
 
-static void *split_pgtable_alloc(enum pgtable_level level, gfp_t gfp)
+bool arch_cpa_can_split(struct cpa_data *cpa, struct cpa_leaf *leaf)
 {
-	phys_addr_t phys;
+	if (system_capabilities_finalized())
+		return system_supports_bbml3();
 
-	phys = pgd_pgtable_alloc_init_mm_gfp(level, gfp);
-	if (phys == INVALID_PHYS_ADDR)
-		return NULL;
-
-	return phys_to_virt(phys);
+	return num_online_cpus() == 1 && cpu_supports_bbml3();
 }
 
-static int split_kernel_leaf_mapping_locked(unsigned long addr)
+int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
+			void *table)
 {
-	pgd_t *pgdp, pgd;
-	p4d_t *p4dp, p4d;
-	pud_t *pudp, pud;
-	pmd_t *pmdp, pmd;
-	pte_t *ptep, pte;
-	void *table;
-	int ret = 0;
-
-	/*
-	 * PGD: If addr is PGD aligned then addr already describes a leaf
-	 * boundary. If not present then there is nothing to split.
-	 */
-	if (ALIGN_DOWN(addr, PGDIR_SIZE) == addr)
-		goto out;
-	pgdp = pgd_offset_k(addr);
-	pgd = pgdp_get(pgdp);
-	if (!pgd_present(pgd))
-		goto out;
-
-	/*
-	 * P4D: If addr is P4D aligned then addr already describes a leaf
-	 * boundary. If not present then there is nothing to split.
-	 */
-	if (ALIGN_DOWN(addr, P4D_SIZE) == addr)
-		goto out;
-	p4dp = p4d_offset(pgdp, addr);
-	p4d = p4dp_get(p4dp);
-	if (!p4d_present(p4d))
-		goto out;
+	bool to_cont = !(cpa->flags & CPA_REQ_SPLIT);
+	enum pgtable_level level = leaf->level;
+	pmd_t *pmdp = (pmd_t *)leaf->kpte;
+	pud_t *pudp = (pud_t *)leaf->kpte;
+	pte_t *ptep = leaf->kpte;
+	pud_t pud;
 
-	/*
-	 * PUD: If addr is PUD aligned then addr already describes a leaf
-	 * boundary. If not present then there is nothing to split. Otherwise,
-	 * if we have a pud leaf, split to contpmd.
-	 */
-	if (ALIGN_DOWN(addr, PUD_SIZE) == addr)
-		goto out;
-	pudp = pud_offset(p4dp, addr);
-	pud = pudp_get(pudp);
-	if (!pud_present(pud))
-		goto out;
-	if (pud_leaf(pud)) {
-		table = split_pgtable_alloc(PGTABLE_LEVEL_PMD,
-					    GFP_PGTABLE_KERNEL);
-		if (!table) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		split_pud(pudp, pud, table, true);
+	if (leaf->size != pgtable_level_size(level)) {
+		if (level == PGTABLE_LEVEL_PTE)
+			split_contpte(ptep);
+		else
+			split_contpmd(pmdp);
+		return 0;
 	}
 
-	/*
-	 * CONTPMD: If addr is CONTPMD aligned then addr already describes a
-	 * leaf boundary. If not present then there is nothing to split.
-	 * Otherwise, if we have a contpmd leaf, split to pmd.
-	 */
-	if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
-		goto out;
-	pmdp = pmd_offset(pudp, addr);
-	pmd = pmdp_get(pmdp);
-	if (!pmd_present(pmd))
-		goto out;
-	if (pmd_leaf(pmd)) {
-		if (pmd_cont(pmd))
-			split_contpmd(pmdp);
-		/*
-		 * PMD: If addr is PMD aligned then addr already describes a
-		 * leaf boundary. Otherwise, split to contpte.
-		 */
-		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
-			goto out;
-		table = split_pgtable_alloc(PGTABLE_LEVEL_PTE,
-					    GFP_PGTABLE_KERNEL);
-		if (!table) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		split_pmd(pmdp, pmd, table, true);
+	if (level == PGTABLE_LEVEL_PMD) {
+		split_pmd(pmdp, pmdp_get(pmdp), table, to_cont);
+		return 0;
 	}
 
-	/*
-	 * CONTPTE: If addr is CONTPTE aligned then addr already describes a
-	 * leaf boundary. If not present then there is nothing to split.
-	 * Otherwise, if we have a contpte leaf, split to pte.
-	 */
-	if (ALIGN_DOWN(addr, CONT_PTE_SIZE) == addr)
-		goto out;
-	ptep = pte_offset_kernel(pmdp, addr);
-	pte = __ptep_get(ptep);
-	if (!pte_present(pte))
-		goto out;
-	if (pte_cont(pte))
-		split_contpte(ptep);
+	pud = pudp_get(pudp);
+	if (level == PGTABLE_LEVEL_PUD && pud_leaf(pud)) {
+		split_pud(pudp, pud, table, to_cont);
+		return 0;
+	}
 
-out:
-	return ret;
+	return -EINVAL;
 }
 
 static inline bool force_pte_mapping(void)
@@ -793,85 +722,17 @@ static inline bool force_pte_mapping(void)
 	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
-static DEFINE_MUTEX(pgtable_split_lock);
 static bool linear_map_requires_bbml3;
 
-int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
+static void *split_pgtable_alloc(enum pgtable_level level, gfp_t gfp)
 {
-	int ret;
-
-	/*
-	 * If the region is within a pte-mapped area, there is no need to try to
-	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
-	 * change permissions from atomic context so for those cases (which are
-	 * always pte-mapped), we must not go any further because taking the
-	 * mutex below may sleep. Do not call force_pte_mapping() here because
-	 * it could return a confusing result if called from a secondary cpu
-	 * prior to finalizing caps. Instead, linear_map_requires_bbml3 gives us
-	 * what we need.
-	 */
-	if (!linear_map_requires_bbml3 || is_kfence_address((void *)start))
-		return 0;
-
-	if (!system_supports_bbml3()) {
-		/*
-		 * BBML3 systems should not be trying to change
-		 * permissions on anything that is not pte-mapped in the first
-		 * place. Just return early and let the permission change code
-		 * raise a warning if not already pte-mapped.
-		 */
-		if (system_capabilities_finalized())
-			return 0;
-
-		/*
-		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
-		 * page allocator. Can't split until it's available.
-		 */
-		if (WARN_ON(!page_alloc_available))
-			return -EBUSY;
-
-		/*
-		 * Boot-time: Started secondary cpus but don't know if they
-		 * support BBML3 yet. Can't allow splitting in this window
-		 * in case they don't.
-		 */
-		if (WARN_ON(num_online_cpus() > 1))
-			return -EBUSY;
-	}
-
-	/*
-	 * Ensure start and end are at least page-aligned since this is the
-	 * finest granularity we can split to.
-	 */
-	if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
-		return -EINVAL;
-
-	mutex_lock(&pgtable_split_lock);
-	lazy_mmu_mode_enable();
+	phys_addr_t phys;
 
-	/*
-	 * The split_kernel_leaf_mapping_locked() may sleep, it is not a
-	 * problem for ARM64 since ARM64's lazy MMU implementation allows
-	 * sleeping.
-	 *
-	 * Optimize for the common case of splitting out a single page from a
-	 * larger mapping. Here we can just split on the "least aligned" of
-	 * start and end and this will guarantee that there must also be a split
-	 * on the more aligned address since the both addresses must be in the
-	 * same contpte block and it must have been split to ptes.
-	 */
-	if (end - start == PAGE_SIZE) {
-		start = __ffs(start) < __ffs(end) ? start : end;
-		ret = split_kernel_leaf_mapping_locked(start);
-	} else {
-		ret = split_kernel_leaf_mapping_locked(start);
-		if (!ret)
-			ret = split_kernel_leaf_mapping_locked(end);
-	}
+	phys = pgd_pgtable_alloc_init_mm_gfp(level, gfp);
+	if (phys == INVALID_PHYS_ADDR)
+		return NULL;
 
-	lazy_mmu_mode_disable();
-	mutex_unlock(&pgtable_split_lock);
-	return ret;
+	return phys_to_virt(phys);
 }
 
 static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
@@ -1088,12 +949,6 @@ static void mark_linear_data_alias_valid(bool valid)
 		.mask_clr = valid ? invalid_prot : valid_prot,
 		.flags = CPA_REQ_NO_CHECK_ALIAS,
 	};
-	int ret;
-
-	ret = split_kernel_leaf_mapping(cpa.addr,
-					cpa.addr + cpa.numpages * PAGE_SIZE);
-	if (WARN_ON_ONCE(ret))
-		return;
 
 	arm64_change_page_attr(&cpa);
 }
@@ -1177,8 +1032,11 @@ static void __init arm64_kfence_map_pool(void)
 
 bool arch_kfence_init_pool(void)
 {
-	unsigned long start = (unsigned long)__kfence_pool;
-	unsigned long end = start + KFENCE_POOL_SIZE;
+	struct cpa_data cpa = {
+		.addr = (unsigned long)__kfence_pool,
+		.numpages = KFENCE_POOL_SIZE >> PAGE_SHIFT,
+		.flags = CPA_REQ_SPLIT,
+	};
 	int ret;
 
 	/* Exit early if we know the linear map is already pte-mapped. */
@@ -1189,9 +1047,7 @@ bool arch_kfence_init_pool(void)
 	if (kfence_early_init)
 		return true;
 
-	mutex_lock(&pgtable_split_lock);
-	ret = range_split_to_ptes(start, end, GFP_PGTABLE_KERNEL);
-	mutex_unlock(&pgtable_split_lock);
+	ret = arm64_change_page_attr(&cpa);
 
 	/*
 	 * Since the system supports bbml3, tlb invalidation is not
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 14a791b8e645..a2f5266b77b2 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -130,7 +130,6 @@ int arch_cpa_process_alias(struct cpa_data *cpa)
 	pteval_t prot = pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr);
 	unsigned long vaddr = cpa_addr(cpa, cpa->curpage);
 	struct cpa_data alias_cpa;
-	unsigned long alias;
 	int ret;
 
 	if (!rodata_full || !(prot & PTE_RDONLY))
@@ -140,14 +139,8 @@ int arch_cpa_process_alias(struct cpa_data *cpa)
 	if (cpa_is_direct_map(vaddr) || !pfn_valid(cpa->pfn))
 		return 0;
 
-	alias = (unsigned long)page_address(pfn_to_page(cpa->pfn));
-	ret = split_kernel_leaf_mapping(alias,
-					alias + cpa->numpages * PAGE_SIZE);
-	if (WARN_ON_ONCE(ret))
-		return ret;
-
 	alias_cpa = *cpa;
-	alias_cpa.addr = alias;
+	alias_cpa.addr = (unsigned long)page_address(pfn_to_page(cpa->pfn));
 	pgprot_val(alias_cpa.mask_set) &= PTE_RDONLY | PTE_WRITE;
 	pgprot_val(alias_cpa.mask_clr) &= PTE_RDONLY | PTE_WRITE;
 
@@ -181,19 +174,11 @@ static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
 
 int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 {
-	unsigned long start = PAGE_ALIGN_DOWN(cpa->addr);
-	unsigned long end = start + cpa->numpages * PAGE_SIZE;
-	int ret;
-
 	/* Nothing in the linear map is invalid without can_set_direct_map() */
 	if ((op == CPA_OP_DIRECT_MAP_INVALID ||
 	     op == CPA_OP_DIRECT_MAP_DEFAULT) && !can_set_direct_map())
 		return 0;
 
-	ret = split_kernel_leaf_mapping(start, end);
-	if (WARN_ON_ONCE(ret))
-		return ret;
-
 	cpa_init_op(cpa, &cpa_ops[op]);
 
 	/*
@@ -297,11 +282,6 @@ static int __change_memory_common(unsigned long start, unsigned long size,
 		.mask_clr = clear_mask,
 		.flags = CPA_REQ_NO_CHECK_ALIAS,
 	};
-	int ret;
-
-	ret = split_kernel_leaf_mapping(start, start + size);
-	if (WARN_ON_ONCE(ret))
-		return ret;
 
 	return arm64_change_page_attr(&cpa);
 }

-- 
2.53.0

