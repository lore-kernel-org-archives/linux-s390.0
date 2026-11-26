Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692026;
	b=QLd4xLL0AKAp1j6OuyNdpbsJ3H0eV02blw79xJzQ4GJE4uh/iMxCPhR63QNghDcboOTd
	 EwOIIpJoigV8QQxRghPJu6bXeeXV6F7N3c1a4Z/lDaHNY+PoexJqV9AFZ8NJpUKkQ7428
	 jL4m6W5gMAJxrbt28J2zpa3Us6AjH05dSvoo5EG54erPAttPuwDsw/Lg09FGbR9CAglgF
	 BdcF16Z+EPHOsSeiDDiq848DywJeqnCuI3tV9ReL8JpvsHhr9v3XK6cYcnu4nhuDNRuO+
	 UgRAEQrMJ/nK7tugvmffqmwDmhgIEvNssSgpzhMt+8HEcT/3OQzL3n1lRDOyLhyhClQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692026;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=HGpkwMSSBdHw0hjJcvg7ScFLxw/cXXPctNM1u/isMBg=;
	b=RutXMERNVIQCmATpBa4kc+lghJ4iiwPKMtbubYnRypMA6l3aogK3yzhsjr0sOoGaMIEr
	 Kj7nTw1RGnrisnGBs6qMlJIdJmX4rxRPJvEBKdPdhUWTgCHT+s8yA4/7vuUooxy7ny68M
	 7dwDVIBe//ghy/+S5YKR4sIVR3A/8wFIUW/LubXofJWSVxH/5Xft3lh7l98BgAm4vf3sV
	 L9FsqbST6cAQ3X5RxZj8jmncMKaV2Ixvlv686hVpNVNT8/41VVEmcNt2nq1fjgXdGODwM
	 cMNaP9FiHuc19MTIPDM++IyCCOXs1FIKoh3pRPXg5j49vRh264LLdWyr6KHx97QJ0cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1TJoT8r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E0606A332;
	Thu, 26 Nov 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1TJoT8r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3FB1F000C4;
	Thu, 26 Nov 2026 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692025;
	bh=HGpkwMSSBdHw0hjJcvg7ScFLxw/cXXPctNM1u/isMBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E1TJoT8rfxY4RKfkKoTv4gchUZwLK2Dx0k15Ppol9x6DQ+Czm3zQkgQ+GemeSZ9Sf
	 qCz67rIZWDRaOcrjmNSJG+RSk/fYjuNUnRi1qRMYYDGYCFR5B926udrFbyW+JQPZ9y
	 BFzSv23zzVZ3JsfXlIVzWUcrJPHAX3+RCiV/zFmcdE21b0JYQ9G1UTCb4S6D6C7e7J
	 3lQkoarGeF+zT6Yuh2JOCRVnuYIB5omdAF69m8p5HljFjcGGBSU5k77wsCbSC5merl
	 VtcPwSwA4Ox7w+wRkTejliEVb+aBZW61I2onfp405VoHoeUY2ztMHHn6YbmyzKkGQA
	 X+aD2454IOH1g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:50 +0200
Subject: [PATCH RFC v2 37/54] ARM: mm: use the generic CPA core
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-37-723f1e33c3d8@kernel.org>
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

The availability of the generic CPA core makes ARM's implementation of
set_memory_*() APIs unnecessary and it can be replaced with several hooks
required by CPA core.

This way the core can manage the policy decisions and the architecture only
has to take care of the page table manipulation.

Switch to the generic CPA core and its set_memory() entry points.
For ARM this means that:

* a hole in the range fails the request with a warning instead of getting a
  page table
* nothing is written or flushed when nothing changes
* a request on a section, which ioremap() may create in the vmalloc area on
  !SMP, still fails with a warning and -EINVAL
* a request on a static I/O mapping, which may use sections in the vmalloc
  area, fails with a warning and -EINVAL as well
* a request that fails flushes the entire TLB
* set_memory_rox() is a single request instead of set_memory_ro() followed
  by set_memory_x()
* lazily unmapped vmap areas and unused kmaps are purged before a request,
  so that they do not keep stale mappings or TLB entries with the old
  protection

ARM only changes ranges mapped with base pages: modules and vmalloc, as
checked before, and the KFENCE pool, which arch_kfence_init_pool() splits.

KFENCE keeps set_memory_valid(), which runs with interrupts disabled. It
now walks with apply_to_existing_page_range(), which never allocates,
rather than apply_to_page_range(), which allocates a page table for a hole
with GFP_KERNEL.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm/Kconfig                  |  1 +
 arch/arm/include/asm/set_memory.h |  6 +--
 arch/arm/mm/pageattr.c            | 96 +++++++++++++++++++++++++--------------
 3 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0cc289a7184a..7a7ccc113126 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -77,6 +77,7 @@ config ARM
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
+	select GENERIC_PAGEATTR if MMU
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/arm/include/asm/set_memory.h b/arch/arm/include/asm/set_memory.h
index 0211b9c5b14d..4f1988dad160 100644
--- a/arch/arm/include/asm/set_memory.h
+++ b/arch/arm/include/asm/set_memory.h
@@ -7,10 +7,8 @@
 #define _ASMARM_SET_MEMORY_H
 
 #ifdef CONFIG_MMU
-int set_memory_ro(unsigned long addr, int numpages);
-int set_memory_rw(unsigned long addr, int numpages);
-int set_memory_x(unsigned long addr, int numpages);
-int set_memory_nx(unsigned long addr, int numpages);
+#include <asm-generic/set_memory.h>
+
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index 064ad508c149..2147b58b19cb 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -4,10 +4,14 @@
  */
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/pageattr.h>
+#include <linux/vmalloc.h>
 
 #include <asm/tlbflush.h>
 #include <asm/set_memory.h>
 
+#include "mm.h"
+
 struct page_change_data {
 	pgprot_t set_mask;
 	pgprot_t clear_mask;
@@ -44,58 +48,82 @@ static int __change_memory_common(unsigned long start, unsigned long size,
 	data.set_mask = set_mask;
 	data.clear_mask = clear_mask;
 
-	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
-				  &data);
+	ret = apply_to_existing_page_range(&init_mm, start, size,
+					   change_page_range, &data);
 
 	flush_tlb_kernel_range(start, start + size);
 	return ret;
 }
 
-static int change_memory_common(unsigned long addr, int numpages,
-				pgprot_t set_mask, pgprot_t clear_mask)
+/* Only page mappings are changed: a section has a different format. */
+void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
-	unsigned long start = addr & PAGE_MASK;
-	unsigned long end = PAGE_ALIGN(addr) + numpages * PAGE_SIZE;
-	unsigned long size = end - start;
-
-	WARN_ON_ONCE(start != addr);
-
-	if (!size)
-		return 0;
+	pte_t pte = ptep_get(leaf->kpte);
 
-	if (!range_in_range(start, size, MODULES_VADDR, MODULES_END) &&
-	    !range_in_range(start, size, VMALLOC_START, VMALLOC_END))
-		return -EINVAL;
+	if (leaf->level != PGTABLE_LEVEL_PTE) {
+		leaf->pfn = 0;
+		leaf->prot = __pgprot(0);
+		return;
+	}
 
-	return __change_memory_common(start, size, set_mask, clear_mask);
+	leaf->pfn = pte_pfn(pte);
+	leaf->prot = __pgprot(pte_val(pte) & ~(PHYS_MASK & (s32)PAGE_MASK));
 }
 
-int set_memory_ro(unsigned long addr, int numpages)
+void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
 {
-	return change_memory_common(addr, numpages,
-					__pgprot(L_PTE_RDONLY),
-					__pgprot(0));
+	if (leaf->level == PGTABLE_LEVEL_PTE)
+		set_pte_ext(leaf->kpte, pfn_pte(leaf->pfn, prot), 0);
 }
 
-int set_memory_rw(unsigned long addr, int numpages)
+void arch_cpa_flush(struct cpa_data *cpa)
 {
-	return change_memory_common(addr, numpages,
-					__pgprot(0),
-					__pgprot(L_PTE_RDONLY));
-}
+	if (cpa->state & CPA_ST_FLUSH_ALL) {
+		flush_tlb_all();
+		return;
+	}
 
-int set_memory_nx(unsigned long addr, int numpages)
-{
-	return change_memory_common(addr, numpages,
-					__pgprot(L_PTE_XN),
-					__pgprot(0));
+	cpa_flush_tlb_kernel_range(cpa);
 }
 
-int set_memory_x(unsigned long addr, int numpages)
+static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
+	[CPA_OP_RO]	= { .set = __pgprot(L_PTE_RDONLY) },
+	[CPA_OP_RW]	= { .clr = __pgprot(L_PTE_RDONLY) },
+	[CPA_OP_X]	= { .clr = __pgprot(L_PTE_XN) },
+	[CPA_OP_NX]	= { .set = __pgprot(L_PTE_XN) },
+	[CPA_OP_ROX]	= { .set = __pgprot(L_PTE_RDONLY),
+			    .clr = __pgprot(L_PTE_XN) },
+};
+
+int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 {
-	return change_memory_common(addr, numpages,
-					__pgprot(0),
-					__pgprot(L_PTE_XN));
+	unsigned long end = PAGE_ALIGN(cpa->addr) + cpa->numpages * PAGE_SIZE;
+	unsigned long start = cpa->addr & PAGE_MASK;
+	unsigned long size = end - start;
+	bool in_modules, in_vmalloc;
+	struct vm_struct *area;
+
+	if (!size)
+		return 0;
+
+	/*
+	 * The sections of the linear map are copied to every page table, so
+	 * only the page mappings of the modules and vmalloc areas can change.
+	 * ioremap() and the static I/O mappings may use sections there.
+	 */
+	in_modules = range_in_range(start, size, MODULES_VADDR, MODULES_END);
+	in_vmalloc = range_in_range(start, size, VMALLOC_START, VMALLOC_END);
+	if (!in_modules && !in_vmalloc)
+		return -EINVAL;
+
+	area = find_vm_area((void *)start);
+	if (WARN_ON_ONCE(area && (area->flags & (VM_ARM_SECTION_MAPPING |
+						 VM_ARM_STATIC_MAPPING))))
+		return -EINVAL;
+
+	cpa_init_op(cpa, &cpa_ops[op]);
+
+	return 0;
 }
 
 int set_memory_valid(unsigned long addr, int numpages, int enable)

-- 
2.53.0

