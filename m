Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692045;
	b=WSxsqYpMckeYnr9gShlzB5O3lhMIimxN/igmc1rwy5f1NKqnre0h09rroul1B/dfgXoU
	 JPXCSYwub+GAzUCdOGkV1zj7IyBhCnTquJATC6vonvzv4EQXgpQbnvxyGG+hUqPU1zd8d
	 Lx1LYv9Ok61CY9ZdfOQXaMqExb4rhHEG2mnxUjwRUP8SXTQ/OBiaMB3S9hTk0Yr2oUFFW
	 0ZEliMdLYXg0oSprubP746f9B1TPJQ6ig4Thdo2KlblrH6bYAKpQWw+Wpy/AlZxjw19u+
	 BJ2nbBZbRC8gshbf/6ZZX0YGEqQg1TymBLwqStDbaVYLgy06jruCU4+PNuVEdYDAahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692045;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2eqedx79FOGytQwfFsw3rLLlGoNSMXbaKddEvY8fQE0=;
	b=5J32n/fPZGtuFsYHyljKx82CE3ONI99ZKLuvkrzyYIoewq2juZlxkj3rDOwZKp6/Nc6d
	 SKnnBSXQ+4stufx5Tuqq3Xy9k13D8PvA4zo0DE8U2UPLsgWAfGyx27yNie59Qtfid+v4k
	 UfiUynUpxPfAMX61Z6CryGN+hMChl7GMywCwYoh4nIl23heBWRSoOx9Y2xic4DKPN3SeA
	 n0AnCk4/Jpl2BG7OjmJ9HLG6jjRCF9maUmFiIVZgkAyecook3PBiPFWSNdyZnSHmNf3Us
	 4+ZB/jFn5vsrRTvQezTbo7mdHaj443EFXtj7QpDOit5X3zPc9PecLf2pzz29ZdDw0Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0Xkhg1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD35606A31E;
	Thu, 26 Nov 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0Xkhg1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FC21F01562;
	Thu, 26 Nov 2026 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692045;
	bh=2eqedx79FOGytQwfFsw3rLLlGoNSMXbaKddEvY8fQE0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q0Xkhg1TUF8rTMMI4BbrKu/g9CRAgi+on2guJ3KisSOOEAiojVW0mcSOnNl5BB8SQ
	 JVJNq/pCFyCujNJgHRK2pMnqLOc/lz1KCam2t+yw1HZ2pFhF9LAitckRcDQR8yh5UX
	 c+hdX/CidQJPUepbr2BONoM03B5FXPMydL0gdU4Y9e9aq5jHa/08DntWjDfKG1pMiZ
	 YGTNiNG+/lWMq/ut9hRrfKKLkQYbq6JqVG8BWKQWS8hdwzG/79G9KDWRtKYYZDlAol
	 mBBpDcrNQMQXJFefCr3YUfJY0XRu5+oViv1/0wGsLdbmH3GCrKqjwyb1DZqrfY5uQx
	 a0BT0tND+Wlgg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:52 +0200
Subject: [PATCH RFC v2 39/54] powerpc: use the generic CPA core
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-39-723f1e33c3d8@kernel.org>
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

powerpc changes kernel page protections with apply_to_existing_page_range()
and a callback that updates one PTE and flushes it.

A request flushes the TLB once for every page, and large mappings cannot be
changed at all, so huge vmalloc ranges are refused up front.

On hash, only the start of a request is checked to be in the vmalloc or the
I/O region.

The availability of the generic CPA core makes powerpc's implementation of
set_memory_*() APIs unnecessary and it can be replaced with several hooks
required by the CPA core.

This way the core can manage the policy decisions and the architecture only
has to take care of the page table manipulation.

Switch to the generic CPA core and its set_memory() entry points.
For powerpc this means that:

* the TLB is flushed once per request, after a ptesync on radix
* a large mapping is changed in place when a request covers it entirely; a
  request for a part of it fails with a warning and -EINVAL, because
  powerpc cannot split
* huge vmalloc ranges are no longer refused up front; on 8xx a 16K, 512K or
  8M page changes as one
* on hash, the whole request has to be in the vmalloc or the I/O region
* an empty PTE in a vmalloc range is reported with a warning and -EFAULT
  where the old walk skipped it
* requests are serialized by the core; the old walk ran without a lock
* lazily unmapped vmap areas and unused kmaps are purged before a request,
  so that they do not keep stale mappings or TLB entries with the old
  protection; set_memory_*() may now sleep there

The hooks decode an entry with pte_pfn() and pte_pgprot(), which work for
the leaves of every level on book3s64, and write it with pte_update(),
which keeps the bits the hardware updates and removes the hash page table
entry where there is one.

On 8xx the decode hook extends a leaf to its block with __pte_leaf_size(),
and pte_update() writes the whole block. An 8M page spans two page tables,
and pte_update() takes it by its first PMD entry.

__kernel_map_pages() runs in the page allocator with interrupts disabled.
It keeps changing the PTEs with apply_to_existing_page_range(), now with
one flush per call. It was the only user of set_memory_np() and
set_memory_p(), so they are removed.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/powerpc/Kconfig                  |   1 +
 arch/powerpc/include/asm/set_memory.h |  46 +---------
 arch/powerpc/mm/pageattr.c            | 160 +++++++++++++++++++---------------
 3 files changed, 94 insertions(+), 113 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3b6cd655606..fbe3a3abeea8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -211,6 +211,7 @@ config PPC
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
+	select GENERIC_PAGEATTR
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select HAS_IOPORT			if PCI
diff --git a/arch/powerpc/include/asm/set_memory.h b/arch/powerpc/include/asm/set_memory.h
index 9c8d5747755d..d049d48157a0 100644
--- a/arch/powerpc/include/asm/set_memory.h
+++ b/arch/powerpc/include/asm/set_memory.h
@@ -2,50 +2,6 @@
 #ifndef _ASM_POWERPC_SET_MEMORY_H
 #define _ASM_POWERPC_SET_MEMORY_H
 
-#define SET_MEMORY_RO	0
-#define SET_MEMORY_RW	1
-#define SET_MEMORY_NX	2
-#define SET_MEMORY_X	3
-#define SET_MEMORY_NP	4	/* Set memory non present */
-#define SET_MEMORY_P	5	/* Set memory present */
-#define SET_MEMORY_ROX	6
-
-int change_memory_attr(unsigned long addr, int numpages, long action);
-
-static inline int __must_check set_memory_ro(unsigned long addr, int numpages)
-{
-	return change_memory_attr(addr, numpages, SET_MEMORY_RO);
-}
-
-static inline int __must_check set_memory_rw(unsigned long addr, int numpages)
-{
-	return change_memory_attr(addr, numpages, SET_MEMORY_RW);
-}
-
-static inline int __must_check set_memory_nx(unsigned long addr, int numpages)
-{
-	return change_memory_attr(addr, numpages, SET_MEMORY_NX);
-}
-
-static inline int __must_check set_memory_x(unsigned long addr, int numpages)
-{
-	return change_memory_attr(addr, numpages, SET_MEMORY_X);
-}
-
-static inline int __must_check set_memory_np(unsigned long addr, int numpages)
-{
-	return change_memory_attr(addr, numpages, SET_MEMORY_NP);
-}
-
-static inline int __must_check set_memory_p(unsigned long addr, int numpages)
-{
-	return change_memory_attr(addr, numpages, SET_MEMORY_P);
-}
-
-static inline int __must_check set_memory_rox(unsigned long addr, int numpages)
-{
-	return change_memory_attr(addr, numpages, SET_MEMORY_ROX);
-}
-#define set_memory_rox set_memory_rox
+#include <asm-generic/set_memory.h>
 
 #endif
diff --git a/arch/powerpc/mm/pageattr.c b/arch/powerpc/mm/pageattr.c
index ac22bf28086f..a2da183aa575 100644
--- a/arch/powerpc/mm/pageattr.c
+++ b/arch/powerpc/mm/pageattr.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/pageattr.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 
@@ -16,109 +17,132 @@
 
 #include <mm/mmu_decl.h>
 
-static pte_basic_t pte_update_delta(pte_t *ptep, unsigned long addr,
-				    unsigned long old, unsigned long new)
+void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
-	return pte_update(&init_mm, addr, ptep, old & ~new, new & ~old, 0);
+	pte_t pte = ptep_get(leaf->kpte);
+	unsigned long size, nr;
+	pmd_t *pmdp;
+
+	/*
+	 * A 16K or 512K page of 8xx is a contiguous block of entries in one
+	 * page table, each mapping its part of the page. An 8M page spans two
+	 * tables, and pte_update() takes it by its first PMD entry.
+	 */
+	if (IS_ENABLED(CONFIG_PPC_8xx) && leaf->level == PGTABLE_LEVEL_PTE) {
+		size = __pte_leaf_size(pmdp_get(pmd_off_k(leaf->addr)), pte);
+		if (size > PAGE_SIZE && size < PMD_SIZE) {
+			nr = size / PAGE_SIZE;
+			leaf->kpte = PTR_ALIGN_DOWN(leaf->kpte,
+						    nr * sizeof(pte_t));
+			leaf->size = size;
+			leaf->addr &= ~(size - 1);
+			pte = ptep_get(leaf->kpte);
+		} else if (size > PMD_SIZE) {
+			leaf->size = size;
+			leaf->addr &= ~(size - 1);
+			pmdp = pmd_off_k(leaf->addr);
+			pte = ptep_get(pte_offset_kernel(pmdp, leaf->addr));
+			leaf->kpte = (pte_t *)pmdp;
+		}
+	}
+
+	leaf->pfn = pte_pfn(pte);
+	leaf->prot = pte_pgprot(pte);
 }
 
-/*
- * Updates the attributes of a page atomically.
- *
- * This sequence is safe against concurrent updates, and also allows updating the
- * attributes of a page currently being executed or accessed.
- */
-static int change_page_attr(pte_t *ptep, unsigned long addr, void *data)
+void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
 {
-	long action = (long)data;
-
-	addr &= PAGE_MASK;
-	/* modify the PTE bits as desired */
-	switch (action) {
-	case SET_MEMORY_RO:
-		/* Don't clear DIRTY bit */
-		pte_update_delta(ptep, addr, _PAGE_KERNEL_RW & ~_PAGE_DIRTY, _PAGE_KERNEL_RO);
-		break;
-	case SET_MEMORY_ROX:
-		/* Don't clear DIRTY bit */
-		pte_update_delta(ptep, addr, _PAGE_KERNEL_RW & ~_PAGE_DIRTY, _PAGE_KERNEL_ROX);
-		break;
-	case SET_MEMORY_RW:
-		pte_update_delta(ptep, addr, _PAGE_KERNEL_RO, _PAGE_KERNEL_RW);
-		break;
-	case SET_MEMORY_NX:
-		pte_update_delta(ptep, addr, _PAGE_KERNEL_ROX, _PAGE_KERNEL_RO);
-		break;
-	case SET_MEMORY_X:
-		pte_update_delta(ptep, addr, _PAGE_KERNEL_RO, _PAGE_KERNEL_ROX);
-		break;
-	case SET_MEMORY_NP:
-		pte_update(&init_mm, addr, ptep, _PAGE_PRESENT, 0, 0);
-		break;
-	case SET_MEMORY_P:
-		pte_update(&init_mm, addr, ptep, 0, _PAGE_PRESENT, 0);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
+	unsigned long old = pgprot_val(leaf->prot), new = pgprot_val(prot);
 
+	pte_update(&init_mm, leaf->addr, leaf->kpte, old & ~new, new & ~old,
+		   leaf->size > PAGE_SIZE);
+}
+
+void arch_cpa_flush(struct cpa_data *cpa)
+{
 	/* See ptesync comment in radix__set_pte_at() */
 	if (radix_enabled())
 		asm volatile("ptesync": : :"memory");
 
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-
-	return 0;
+	cpa_flush_tlb_kernel_range(cpa);
 }
 
-int change_memory_attr(unsigned long addr, int numpages, long action)
+#define CPA_OP_TRANS(old, new)	{ .set = __pgprot((new) & ~(old)),	\
+				  .clr = __pgprot((old) & ~(new)) }
+
+static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
+	/* Don't clear DIRTY bit */
+	[CPA_OP_RO]	= CPA_OP_TRANS(_PAGE_KERNEL_RW & ~_PAGE_DIRTY,
+				       _PAGE_KERNEL_RO),
+	[CPA_OP_RW]	= CPA_OP_TRANS(_PAGE_KERNEL_RO, _PAGE_KERNEL_RW),
+	[CPA_OP_X]	= CPA_OP_TRANS(_PAGE_KERNEL_RO, _PAGE_KERNEL_ROX),
+	[CPA_OP_NX]	= CPA_OP_TRANS(_PAGE_KERNEL_ROX, _PAGE_KERNEL_RO),
+	/* Don't clear DIRTY bit */
+	[CPA_OP_ROX]	= CPA_OP_TRANS(_PAGE_KERNEL_RW & ~_PAGE_DIRTY,
+				       _PAGE_KERNEL_ROX),
+};
+
+int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 {
-	unsigned long start = ALIGN_DOWN(addr, PAGE_SIZE);
-	unsigned long size = numpages * PAGE_SIZE;
-
-	if (!numpages)
-		return 0;
-
-	if (WARN_ON_ONCE(is_vmalloc_or_module_addr((void *)addr) &&
-			 is_vm_area_hugepages((void *)addr)))
-		return -EINVAL;
-
 #ifdef CONFIG_PPC_BOOK3S_64
+	unsigned long end = cpa->addr + cpa->numpages * PAGE_SIZE;
+
 	/*
 	 * On hash, the linear mapping is not in the Linux page table so
-	 * apply_to_existing_page_range() will have no effect. If in the future
-	 * the set_memory_* functions are used on the linear map this will need
+	 * changing its protections has no effect. If in the future the
+	 * set_memory_* functions are used on the linear map this will need
 	 * to be updated.
 	 */
-	if (!radix_enabled()) {
-		int region = get_region_id(addr);
+	if (!radix_enabled() && cpa->numpages) {
+		int region = get_region_id(cpa->addr);
+		int end_region = get_region_id(end - 1);
 
-		if (WARN_ON_ONCE(region != VMALLOC_REGION_ID && region != IO_REGION_ID))
+		if (WARN_ON_ONCE((region != VMALLOC_REGION_ID &&
+				  region != IO_REGION_ID) ||
+				 end_region != region))
 			return -EINVAL;
 	}
 #endif
 
-	return apply_to_existing_page_range(&init_mm, start, size,
-					    change_page_attr, (void *)action);
+	cpa_init_op(cpa, &cpa_ops[op]);
+
+	return 0;
 }
 
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
 #ifdef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC
+static int change_present(pte_t *ptep, unsigned long addr, void *data)
+{
+	if (data)
+		pte_update(&init_mm, addr, ptep, 0, _PAGE_PRESENT, 0);
+	else
+		pte_update(&init_mm, addr, ptep, _PAGE_PRESENT, 0, 0);
+
+	return 0;
+}
+
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	int err;
 	unsigned long addr = (unsigned long)page_address(page);
+	unsigned long size = numpages * PAGE_SIZE;
 
 	if (PageHighMem(page))
 		return;
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled())
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled()) {
 		err = hash__kernel_map_pages(page, numpages, enable);
-	else if (enable)
-		err = set_memory_p(addr, numpages);
-	else
-		err = set_memory_np(addr, numpages);
+	} else {
+		err = apply_to_existing_page_range(&init_mm, addr, size,
+						   change_present,
+						   (void *)(long)enable);
+
+		/* See ptesync comment in radix__set_pte_at() */
+		if (radix_enabled())
+			asm volatile("ptesync": : :"memory");
+
+		flush_tlb_kernel_range(addr, addr + size);
+	}
 
 	if (err)
 		panic("%s: changing memory protections failed\n", __func__);

-- 
2.53.0

