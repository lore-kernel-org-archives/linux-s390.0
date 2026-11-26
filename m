Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692169;
	b=dw3arcI1tqccXHDEjCe9pPjc9wKrKKqSob3xx2vTKWUZCqlo143QZ7Bzp2dI0THGYJqW
	 eJJH24UWKFki6zz1sS5JEjr+m5YosHTw19600ObyZ52I518wl3Ww0Z762Mt5FmxAOy8GL
	 tXCr6O+VhQUlcbOGruryJve5T8EZSXKixgOsSF2J5ZY4rnT8q0NnTClYYgRA9SNEJ6fcB
	 4pNV1qlO3j0ACpL9adJ45ZyyzV1DcPPD0y95W+5CpQh+4zU8fhCToy/sB7V493vPJwaRO
	 BHtgmBalcmOUBuGf18cslY+6986LU1CZKQhDC0lkfv6PjtpdoGMke464oRA987Mfn5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692169;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=6WYcKE+tNEbcV6PVwG1N7LpHdq4HcIVT1zq0dfG4sec=;
	b=xXMWBGm+Va22+7DzL5B6Hiw0lW2VmD0BZNVASwO/BUMs009CqU+y6BAZPSyOJkzdQUyc
	 TWGw0qsv60DZgUgMo/cFUe9WchXPJg2JUX27t3fyHmF4lgcUwUPBXaLldZElMV+828fdG
	 T5lXZN/PXkbsAzXaJqSWtg8wtvj2OTXX9zQwPOQW+OZoZ1uthF34QFzFmMyuer8ZG8GOL
	 pFWgkavFmHtDsHWNT3C5jArM98ebkdHUmORVGv/KjB6KLCOZREWJXJMWN8Xxxm8hJ0DJy
	 uk4GCm1xXlZZudg3ratWdSbQxQkR5bh6GkCC2noj8iV1BIATVyKhXBtdiYrNu+NHaGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl+CRlyx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7D606A321;
	Thu, 26 Nov 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl+CRlyx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB421F000CF;
	Thu, 26 Nov 2026 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692168;
	bh=6WYcKE+tNEbcV6PVwG1N7LpHdq4HcIVT1zq0dfG4sec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zl+CRlyx2I87IdbB1JjDCBPiNmKv4bM3IAC45ktE5s3I91L2jmCmRUoptnipGkKgl
	 BUE5kN97wXFLUC85uzwNpJJy7KixHU2IXlqkidLGKe+3woRJZHzcPXmlb+AxWDuKBB
	 UPGryb2k5YbIZxUqTu22JWldXgFR2GhweHJsnywyofX6FCMS+197XcSD+PpDSV91di
	 0Robh4VbtGiy65suWKd5uGtTAUBp0SYHIy2Y2NU+abhtWG5slvBzvF2XW7wLKh3XBs
	 MK+nfJOsSsKaW0gMv9BnXjO4gNsLD+feKOCcYwglUygk2LWwCivUbj7eMLAOX1Qa1b
	 ua3YBSB8LM7wg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:15:05 +0200
Subject: [PATCH RFC v2 52/54] arm64: count the mappings of the linear map
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-52-723f1e33c3d8@kernel.org>
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

The core keeps a counter of the direct map entries at every page table
level. A split moves an entry to the level below and counts a
direct_map_level2_splits or direct_map_level3_splits event in /proc/vmstat.
The counters start from what the architecture mapped.

arm64 never counts its linear map, so the core finds no large pages to take
a split from, and the split events stay at zero.

Count the linear map when it is created at boot and on memory hotplug, and
when memory is removed. map_mem() maps the kernel alias and the KFENCE pool
before it maps all of memory over them, so only the entries that were empty
count. The split of the linear map at boot, when not all CPUs support
BBML3, bypasses the core, so count its splits as well.

Report the counters in /proc/meminfo.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/mm/mmu.c      | 28 ++++++++++++++++++++++++++++
 arch/arm64/mm/pageattr.c | 13 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 40c5ac95f574..c415b81fb6f3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -160,9 +160,19 @@ static void init_clear_pgtable(void *table)
 	dsb(ishst);
 }
 
+static void linear_map_count(unsigned long addr, enum pgtable_level level,
+			     long nr)
+{
+	if (__is_lm_address(addr))
+		direct_map_count_update(level, nr);
+}
+
 static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
+	unsigned long start = addr;
+	long nr = 0;
+
 	do {
 		pte_t old_pte = __ptep_get(ptep);
 
@@ -179,8 +189,12 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		BUG_ON(!pgattr_change_is_safe(pte_val(old_pte),
 					      pte_val(__ptep_get(ptep))));
 
+		if (pte_none(old_pte))
+			nr++;
 		phys += PAGE_SIZE;
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
+
+	linear_map_count(start, PGTABLE_LEVEL_PTE, nr);
 }
 
 static bool pte_range_has_valid_noncont(pte_t *ptep)
@@ -274,6 +288,9 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			 */
 			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
 						      READ_ONCE(pmd_val(*pmdp))));
+
+			if (pmd_none(old_pmd))
+				linear_map_count(addr, PGTABLE_LEVEL_PMD, 1);
 		} else {
 			int ret;
 
@@ -410,6 +427,9 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			 */
 			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
 						      READ_ONCE(pud_val(*pudp))));
+
+			if (pud_none(old_pud))
+				linear_map_count(addr, PGTABLE_LEVEL_PUD, 1);
 		} else {
 			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
 						  pgtable_alloc, flags);
@@ -750,6 +770,7 @@ static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
 		return -ENOMEM;
 
 	split_pud(pudp, pud, pmdp, false);
+	direct_map_count_split(PGTABLE_LEVEL_PUD);
 
 	return 0;
 }
@@ -771,6 +792,7 @@ static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
 	if (pmd_cont(pmd))
 		split_contpmd(pmdp);
 	split_pmd(pmdp, pmd, ptep, false);
+	direct_map_count_split(PGTABLE_LEVEL_PMD);
 
 	/*
 	 * We have split the pmd directly to ptes so there is no need to
@@ -1424,6 +1446,8 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 			free_hotplug_page_range(pte_page(pte),
 						PAGE_SIZE, altmap);
+		} else {
+			direct_map_count_update(PGTABLE_LEVEL_PTE, -1);
 		}
 		/* unmap_hotplug_range() flushes TLB for !free_mapped */
 	} while (addr += PAGE_SIZE, addr < end);
@@ -1458,6 +1482,8 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 				flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 				free_hotplug_page_range(pmd_page(pmd),
 							PMD_SIZE, altmap);
+			} else {
+				direct_map_count_update(PGTABLE_LEVEL_PMD, -1);
 			}
 			/* unmap_hotplug_range() flushes TLB for !free_mapped */
 			continue;
@@ -1489,6 +1515,8 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 				flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 				free_hotplug_page_range(pud_page(pud),
 							PUD_SIZE, altmap);
+			} else {
+				direct_map_count_update(PGTABLE_LEVEL_PUD, -1);
 			}
 			/* unmap_hotplug_range() flushes TLB for !free_mapped */
 			continue;
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a2f5266b77b2..5e6782ef4b6c 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/pageattr.h>
+#include <linux/proc_fs.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable-prot.h>
@@ -16,6 +17,18 @@
 #include <asm/tlbflush.h>
 #include <asm/kfence.h>
 
+#ifdef CONFIG_PROC_FS
+void arch_report_meminfo(struct seq_file *m)
+{
+	unsigned long levels = BIT(PGTABLE_LEVEL_PTE) | BIT(PGTABLE_LEVEL_PMD);
+
+	if (pud_sect_supported())
+		levels |= BIT(PGTABLE_LEVEL_PUD);
+
+	cpa_report_meminfo(m, levels);
+}
+#endif
+
 void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
 	enum pgtable_level level = leaf->level;

-- 
2.53.0

