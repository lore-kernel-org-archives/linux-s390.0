Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692121;
	b=UawAbky+YqV09LA7V//+MPfpGFPov+8NDCo9Zx10NhD73O4cZNmoeoCnbFRLl3qaNY2A
	 8a9iuaZHBP9ZR8L7oGTLfN9qxMWhbBsmNem41TzHpZjYEkFazq7LMAQ5OFRiuiHi/PbRt
	 HWyhYu8xpMICemFBhLPN1Nx+O6YAaMAbLS54xzHhjhA6+HIN3ihg/kWl8/IlvYtJkyt7M
	 JB39RRdfkjrgW/OHLQhcEdBq7yEFCoeoQX8BGHj35UK8fOorlhyhRhFylOL3xvr5xmJf+
	 u/wjWHUcMxQ9yZoLSWBLUbz4c9upSkkTTG5/Y1OEzcstDtLNHMGh2WuIZ81gzxn23mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692121;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=nDkrPi3FH5qAyEqalTD/J1JnKIB1f1zkiR/jsMjGXnk=;
	b=njlP4Oa22khkQR1Jg0OB8ZpX/HKtXKzHu0KqI+2SaScN+Vh46O0889sz9icn/geRe0PJ
	 +qk4w02b6THUvYVv1azEBl5jqKvlh/pWzZj5rdxDQd7rNl/dDoU4zQagYlF58Haiw/LaJ
	 GymzMn/2BrKJHhGz+tCNuvULxBUieAc0G8vEQyGl/Poaaitvha2LOiWwBn4d7PLhvX/Xl
	 MhvotsgQ25pQH9EXcU2dWo8cTOLSCyHP5OZrVHgjq31smUhUvFb0PyUqfNUYYehsRQ3ho
	 Hbs4jJCuk4nXFdvLE+0VMKnEoV+KUzP6tf1gHTBJx9u4U+Xn0Xy/SRRGfDHKwhZ++lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJUtXYys;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561FC606A32A;
	Thu, 26 Nov 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJUtXYys
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEED1F000D4;
	Thu, 26 Nov 2026 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692120;
	bh=nDkrPi3FH5qAyEqalTD/J1JnKIB1f1zkiR/jsMjGXnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RJUtXYysCLsxLeTBw4cphDw0OflNK355zNiQQxhW/x0IpP9ebbpB6/mbiwii4bp+e
	 ExpuwoSOpFtZvGmgszhQDjx1T7ZoBIyKXGddtbrI36hE5ffZVv5dAfsRtbh5jyp6D0
	 26f3BEc1MkhChy/MPzQyaTfX10+AErfH7LrMKYT+2R4XxFHttlYtlGZRj0v6OHoptO
	 xfu7Lwj5lEwb/aOge6HBnP/WNQKC9xBizX0cNnPmCvY++0oSwVoAvaG4PECJBjI79f
	 kvH8puDlD9vFAOveHi7/IB8/uiyLtWnLYqS10Ah/LmG86Xqe7BI4NbVgs2L8R+XSVO
	 ZKwMUe2PBKDfg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:15:00 +0200
Subject: [PATCH RFC v2 47/54] s390: use the generic CPA core
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-47-723f1e33c3d8@kernel.org>
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

s390 implementation of set_memory_*() APIs has a few shortcomings:

* it splits every large page that a request touches, even when the request
  covers it with one protection
* it writes every entry of the range, whether anything changes or not
* only VM_ALLOC areas change their identity map alias, so the identity map
  alias of the kernel image stays writable after the image is write
  protected

The availability of the generic CPA core makes s390's implementation of
set_memory_*() APIs unnecessary and it can be replaced with several hooks
required by CPA core.

This way the core can manage the policy decisions and the architecture only
has to take care of the page table manipulation.

Switch to the generic CPA core and its set_memory() entry points.
For s390 this means that:

* a large page is kept when a request covers it with one protection and
  split only otherwise
* nothing is written when nothing changes
* a hole in the identity map is skipped
* an unmapped address outside of the identity map is reported with a
  warning and -EFAULT
* the identity map alias follows read-only and read-write changes of any
  mapping of RAM outside the identity map, the kernel image included
* set_memory_4k() is implemented using a split request to the core
* the direct map counters are the generic ones; the DirectMap lines of
  /proc/meminfo do not change
* requests are serialized by the core, rather than by cpa_mutex; the page
  table dump may now run during a split by set_direct_map_*_noflush(),
  which never frees a table, and sees either the leaf or a complete table
* lazily unmapped vmap areas are purged before a request, so that they do
  not keep stale TLB entries with the old protection

The page table modification hooks write entries with pgt_set(), which uses
CRDTE or CSPG, so there is no need to flush the TLB at the end of a CPA
request.

vmem.c keeps split_pud_page() for memory hot-remove, built from the same
hooks.

The boot time counts of the decompressor are folded into the generic
counters in paging_init(), before the first split.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/Kconfig                  |   1 +
 arch/s390/include/asm/pageattr.h   |  21 ++
 arch/s390/include/asm/set_memory.h |  55 +---
 arch/s390/mm/dump_pagetables.c     |   2 -
 arch/s390/mm/init.c                |  15 ++
 arch/s390/mm/pageattr.c            | 496 ++++++++++++++++---------------------
 arch/s390/mm/vmem.c                |  10 +-
 7 files changed, 272 insertions(+), 328 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7138d923d86f..413b886a9e9a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -180,6 +180,7 @@ config S390
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_PAGEATTR
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IOREMAP
 	select GLOB
diff --git a/arch/s390/include/asm/pageattr.h b/arch/s390/include/asm/pageattr.h
new file mode 100644
index 000000000000..83c4a40a9b20
--- /dev/null
+++ b/arch/s390/include/asm/pageattr.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_PAGEATTR_H
+#define _ASM_S390_PAGEATTR_H
+
+void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf);
+void arch_cpa_free_pgtable(struct cpa_leaf *leaf, void *table);
+#define arch_cpa_alloc_pgtable arch_cpa_alloc_pgtable
+
+int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
+			void *table);
+static inline bool arch_cpa_can_split(struct cpa_data *cpa,
+				      struct cpa_leaf *leaf)
+{
+	return true;
+}
+#define arch_cpa_can_split arch_cpa_can_split
+
+int arch_cpa_process_alias(struct cpa_data *cpa);
+#define arch_cpa_process_alias arch_cpa_process_alias
+
+#endif /* _ASM_S390_PAGEATTR_H */
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index 23987b721ed9..30bfc8305f5d 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -2,65 +2,32 @@
 #ifndef _ASMS390_SET_MEMORY_H
 #define _ASMS390_SET_MEMORY_H
 
-#include <linux/mutex.h>
+#include <asm-generic/set_memory.h>
 
-extern struct mutex cpa_mutex;
-
-enum {
-	_SET_MEMORY_RO_BIT,
-	_SET_MEMORY_RW_BIT,
-	_SET_MEMORY_NX_BIT,
-	_SET_MEMORY_X_BIT,
-	_SET_MEMORY_4K_BIT,
-	_SET_MEMORY_INV_BIT,
-	_SET_MEMORY_DEF_BIT,
-};
-
-#define SET_MEMORY_RO	BIT(_SET_MEMORY_RO_BIT)
-#define SET_MEMORY_RW	BIT(_SET_MEMORY_RW_BIT)
-#define SET_MEMORY_NX	BIT(_SET_MEMORY_NX_BIT)
-#define SET_MEMORY_X	BIT(_SET_MEMORY_X_BIT)
-#define SET_MEMORY_4K	BIT(_SET_MEMORY_4K_BIT)
-#define SET_MEMORY_INV	BIT(_SET_MEMORY_INV_BIT)
-#define SET_MEMORY_DEF	BIT(_SET_MEMORY_DEF_BIT)
-
-int __set_memory(unsigned long addr, unsigned long numpages, unsigned long flags);
-
-#define set_memory_rox set_memory_rox
+int set_memory_4k(unsigned long addr, unsigned long numpages);
 
 /*
- * Generate two variants of each set_memory() function:
+ * Generate a variant of each set_memory() function:
  *
- * set_memory_yy(unsigned long addr, int numpages);
  * __set_memory_yy(void *start, void *end);
  *
- * The second variant exists for both convenience to avoid the usual
- * (unsigned long) casts, but unlike the first variant it can also be used
- * for areas larger than 8TB, which may happen at memory initialization.
+ * It exists for convenience to avoid the usual (unsigned long) casts.
  */
-#define __SET_MEMORY_FUNC(fname, flags)					\
-static inline int fname(unsigned long addr, int numpages)		\
-{									\
-	return __set_memory(addr, numpages, (flags));			\
-}									\
-									\
+#define __SET_MEMORY_FUNC(fname)					\
 static inline int __##fname(void *start, void *end)			\
 {									\
 	unsigned long numpages;						\
 									\
 	numpages = (end - start) >> PAGE_SHIFT;				\
-	return __set_memory((unsigned long)start, numpages, (flags));	\
+	return fname((unsigned long)start, numpages);			\
 }
 
-__SET_MEMORY_FUNC(set_memory_ro, SET_MEMORY_RO)
-__SET_MEMORY_FUNC(set_memory_rw, SET_MEMORY_RW)
-__SET_MEMORY_FUNC(set_memory_nx, SET_MEMORY_NX)
-__SET_MEMORY_FUNC(set_memory_x, SET_MEMORY_X)
-__SET_MEMORY_FUNC(set_memory_rox, SET_MEMORY_RO | SET_MEMORY_X)
-__SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
+__SET_MEMORY_FUNC(set_memory_ro)
+__SET_MEMORY_FUNC(set_memory_rw)
+__SET_MEMORY_FUNC(set_memory_nx)
+__SET_MEMORY_FUNC(set_memory_x)
+__SET_MEMORY_FUNC(set_memory_rox)
 
-int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
-int set_direct_map_default_noflush(struct page *page, unsigned int nr);
 bool kernel_page_present(struct page *page);
 
 #endif
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index a23a0bd4d8a8..7533dc22e0e9 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -247,9 +247,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 		.marker = markers,
 	};
 
-	mutex_lock(&cpa_mutex);
 	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
-	mutex_unlock(&cpa_mutex);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index be7e009e7b59..ce51c2ca8e3b 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/memblock.h>
+#include <linux/pageattr.h>
 #include <linux/memory.h>
 #include <linux/pfn.h>
 #include <linux/poison.h>
@@ -95,11 +96,25 @@ void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 }
 
+static long __init direct_pages(int type)
+{
+	return atomic_long_read(&direct_pages_count[type]);
+}
+
 /*
  * paging_init() sets up the page tables
  */
 void __init paging_init(void)
 {
+	if (IS_ENABLED(CONFIG_PROC_FS)) {
+		direct_map_count_update(PGTABLE_LEVEL_PTE,
+					direct_pages(PG_DIRECT_MAP_4K));
+		direct_map_count_update(PGTABLE_LEVEL_PMD,
+					direct_pages(PG_DIRECT_MAP_1M));
+		direct_map_count_update(PGTABLE_LEVEL_PUD,
+					direct_pages(PG_DIRECT_MAP_2G));
+	}
+
 	vmem_map_init();
 	zone_dma_limit = DMA_BIT_MASK(31);
 }
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 80e834e8b8e1..d3e91b9d391e 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -5,6 +5,7 @@
  */
 #include <linux/cpufeature.h>
 #include <linux/hugetlb.h>
+#include <linux/pageattr.h>
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
@@ -42,12 +43,8 @@ atomic_long_t __bootdata_preserved(direct_pages_count[PG_DIRECT_MAP_MAX]);
 
 void arch_report_meminfo(struct seq_file *m)
 {
-	seq_printf(m, "DirectMap4k:    %8lu kB\n",
-		   atomic_long_read(&direct_pages_count[PG_DIRECT_MAP_4K]) << 2);
-	seq_printf(m, "DirectMap1M:    %8lu kB\n",
-		   atomic_long_read(&direct_pages_count[PG_DIRECT_MAP_1M]) << 10);
-	seq_printf(m, "DirectMap2G:    %8lu kB\n",
-		   atomic_long_read(&direct_pages_count[PG_DIRECT_MAP_2G]) << 21);
+	cpa_report_meminfo(m, BIT(PGTABLE_LEVEL_PTE) | BIT(PGTABLE_LEVEL_PMD) |
+			   BIT(PGTABLE_LEVEL_PUD));
 }
 #endif /* CONFIG_PROC_FS */
 
@@ -76,320 +73,261 @@ static void pgt_set(unsigned long *old, unsigned long new, unsigned long addr,
 	}
 }
 
-static int walk_pte_level(pmd_t *pmdp, unsigned long addr, unsigned long end,
-			  unsigned long flags)
+static unsigned long cpa_large_to_pte(unsigned long val)
 {
-	pte_t *ptep, new;
-
-	if (flags == SET_MEMORY_4K)
-		return 0;
-	ptep = pte_offset_kernel(pmdp, addr);
-	do {
-		new = ptep_get(ptep);
-		if (pte_none(new))
-			return -EINVAL;
-		if (flags & SET_MEMORY_RO)
-			new = pte_wrprotect(new);
-		else if (flags & SET_MEMORY_RW)
-			new = pte_mkwrite_novma(pte_mkdirty(new));
-		if (flags & SET_MEMORY_NX)
-			new = set_pte_bit(new, __pgprot(_PAGE_NOEXEC));
-		else if (flags & SET_MEMORY_X)
-			new = clear_pte_bit(new, __pgprot(_PAGE_NOEXEC));
-		if (flags & SET_MEMORY_INV) {
-			new = set_pte_bit(new, __pgprot(_PAGE_INVALID));
-		} else if (flags & SET_MEMORY_DEF) {
-			new = __pte(pte_val(new) & PAGE_MASK);
-			new = set_pte_bit(new, PAGE_KERNEL);
-		}
-		pgt_set((unsigned long *)ptep, pte_val(new), addr, CRDTE_DTT_PAGE);
-		ptep++;
-		addr += PAGE_SIZE;
-	} while (addr < end);
-	return 0;
+	unsigned long prot = 0;
+
+	if (val & _SEGMENT_ENTRY_PRESENT)
+		prot |= _PAGE_PRESENT;
+	if (val & _SEGMENT_ENTRY_INVALID)
+		prot |= _PAGE_INVALID;
+	if (val & _SEGMENT_ENTRY_PROTECT)
+		prot |= _PAGE_PROTECT;
+	if (val & _SEGMENT_ENTRY_NOEXEC)
+		prot |= _PAGE_NOEXEC;
+	if (val & _SEGMENT_ENTRY_SOFT_DIRTY)
+		prot |= _PAGE_SOFT_DIRTY;
+	if (val & _SEGMENT_ENTRY_YOUNG)
+		prot |= _PAGE_YOUNG;
+	if (val & _SEGMENT_ENTRY_DIRTY)
+		prot |= _PAGE_DIRTY;
+	if (val & _SEGMENT_ENTRY_READ)
+		prot |= _PAGE_READ;
+	if (val & _SEGMENT_ENTRY_WRITE)
+		prot |= _PAGE_WRITE;
+
+	return prot;
 }
 
-static int split_pmd_page(pmd_t *pmdp, unsigned long addr)
+static unsigned long cpa_pte_to_large(unsigned long prot)
 {
-	unsigned long pte_addr, prot;
-	pte_t *pt_dir, *ptep;
-	pmd_t new, pmd;
-	int i, ro, nx;
+	unsigned long val = _SEGMENT_ENTRY_LARGE;
+
+	if (prot & _PAGE_PRESENT)
+		val |= _SEGMENT_ENTRY_PRESENT;
+	if (prot & _PAGE_INVALID)
+		val |= _SEGMENT_ENTRY_INVALID;
+	if (prot & _PAGE_PROTECT)
+		val |= _SEGMENT_ENTRY_PROTECT;
+	if (prot & _PAGE_NOEXEC)
+		val |= _SEGMENT_ENTRY_NOEXEC;
+	if (prot & _PAGE_SOFT_DIRTY)
+		val |= _SEGMENT_ENTRY_SOFT_DIRTY;
+	if (prot & _PAGE_YOUNG)
+		val |= _SEGMENT_ENTRY_YOUNG;
+	if (prot & _PAGE_DIRTY)
+		val |= _SEGMENT_ENTRY_DIRTY;
+	if (prot & _PAGE_READ)
+		val |= _SEGMENT_ENTRY_READ;
+	if (prot & _PAGE_WRITE)
+		val |= _SEGMENT_ENTRY_WRITE;
+
+	return val;
+}
 
-	pt_dir = vmem_pte_alloc();
-	if (!pt_dir)
-		return -ENOMEM;
-	pmd = pmdp_get(pmdp);
-	pte_addr = pmd_pfn(pmd) << PAGE_SHIFT;
-	ro = !!(pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT);
-	nx = !!(pmd_val(pmd) & _SEGMENT_ENTRY_NOEXEC);
-	prot = pgprot_val(ro ? PAGE_KERNEL_RO : PAGE_KERNEL);
-	if (!nx)
-		prot &= ~_PAGE_NOEXEC;
-	ptep = pt_dir;
-	for (i = 0; i < PTRS_PER_PTE; i++) {
-		set_pte(ptep, __pte(pte_addr | prot));
-		pte_addr += PAGE_SIZE;
-		ptep++;
+void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
+{
+	unsigned long val = pte_val(ptep_get(leaf->kpte));
+	enum pgtable_level level = leaf->level;
+
+	switch (level) {
+	case PGTABLE_LEVEL_PTE:
+		leaf->pfn = pte_pfn(__pte(val));
+		leaf->prot = __pgprot(val & ~PAGE_MASK);
+		break;
+	case PGTABLE_LEVEL_PMD:
+		leaf->pfn = pmd_pfn(__pmd(val));
+		leaf->prot = __pgprot(cpa_large_to_pte(val));
+		break;
+	case PGTABLE_LEVEL_PUD:
+		leaf->pfn = pud_pfn(__pud(val));
+		leaf->prot = __pgprot(cpa_large_to_pte(val));
+		break;
+	default:
+		leaf->pfn = 0;
+		leaf->prot = __pgprot(0);
+		break;
 	}
-	new = __pmd(__pa(pt_dir) | _SEGMENT_ENTRY);
-	pgt_set((unsigned long *)pmdp, pmd_val(new), addr, CRDTE_DTT_SEGMENT);
-	update_page_count(PG_DIRECT_MAP_4K, PTRS_PER_PTE);
-	update_page_count(PG_DIRECT_MAP_1M, -1);
-	return 0;
 }
 
-static void modify_pmd_page(pmd_t *pmdp, unsigned long addr,
-			    unsigned long flags)
+void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
 {
-	pmd_t new = pmdp_get(pmdp);
-
-	if (flags & SET_MEMORY_RO)
-		new = pmd_wrprotect(new);
-	else if (flags & SET_MEMORY_RW)
-		new = pmd_mkwrite_novma(pmd_mkdirty(new));
-	if (flags & SET_MEMORY_NX)
-		new = set_pmd_bit(new, __pgprot(_SEGMENT_ENTRY_NOEXEC));
-	else if (flags & SET_MEMORY_X)
-		new = clear_pmd_bit(new, __pgprot(_SEGMENT_ENTRY_NOEXEC));
-	if (flags & SET_MEMORY_INV) {
-		new = set_pmd_bit(new, __pgprot(_SEGMENT_ENTRY_INVALID));
-	} else if (flags & SET_MEMORY_DEF) {
-		new = __pmd(pmd_val(new) & PMD_MASK);
-		new = set_pmd_bit(new, SEGMENT_KERNEL);
+	unsigned long *entry = (unsigned long *)leaf->kpte;
+	unsigned long val = PFN_PHYS(leaf->pfn);
+	enum pgtable_level level = leaf->level;
+	unsigned long lpaddr = leaf->addr;
+
+	switch (level) {
+	case PGTABLE_LEVEL_PTE:
+		pgt_set(entry, val | pgprot_val(prot), lpaddr, CRDTE_DTT_PAGE);
+		break;
+	case PGTABLE_LEVEL_PMD:
+		pgt_set(entry, val | cpa_pte_to_large(pgprot_val(prot)),
+			lpaddr, CRDTE_DTT_SEGMENT);
+		break;
+	case PGTABLE_LEVEL_PUD:
+		pgt_set(entry, val | _REGION_ENTRY_TYPE_R3 |
+			cpa_pte_to_large(pgprot_val(prot)),
+			lpaddr, CRDTE_DTT_REGION3);
+		break;
+	default:
+		break;
 	}
-	pgt_set((unsigned long *)pmdp, pmd_val(new), addr, CRDTE_DTT_SEGMENT);
 }
 
-static int walk_pmd_level(pud_t *pudp, unsigned long addr, unsigned long end,
-			  unsigned long flags)
+void arch_cpa_flush(struct cpa_data *cpa)
 {
-	unsigned long next;
-	pmd_t *pmdp, pmd;
-	int need_split;
-	int rc = 0;
-
-	pmdp = pmd_offset(pudp, addr);
-	do {
-		pmd = pmdp_get(pmdp);
-		if (pmd_none(pmd))
-			return -EINVAL;
-		next = pmd_addr_end(addr, end);
-		if (pmd_leaf(pmd)) {
-			need_split  = !!(flags & SET_MEMORY_4K);
-			need_split |= !!(addr & ~PMD_MASK);
-			need_split |= !!(addr + PMD_SIZE > next);
-			if (need_split) {
-				rc = split_pmd_page(pmdp, addr);
-				if (rc)
-					return rc;
-				continue;
-			}
-			modify_pmd_page(pmdp, addr, flags);
-		} else {
-			rc = walk_pte_level(pmdp, addr, next, flags);
-			if (rc)
-				return rc;
-		}
-		pmdp++;
-		addr = next;
-	} while (addr < end);
-	return rc;
 }
 
-int split_pud_page(pud_t *pudp, unsigned long addr)
+void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf)
 {
-	unsigned long pmd_addr, prot;
-	pmd_t *pm_dir, *pmdp;
-	pud_t new, pud;
-	int i, ro, nx;
+	enum pgtable_level level = leaf->level;
+	void *table;
 
-	pm_dir = vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
-	if (!pm_dir)
-		return -ENOMEM;
-	pud = pudp_get(pudp);
-	pmd_addr = pud_pfn(pud) << PAGE_SHIFT;
-	ro = !!(pud_val(pud) & _REGION_ENTRY_PROTECT);
-	nx = !!(pud_val(pud) & _REGION_ENTRY_NOEXEC);
-	prot = pgprot_val(ro ? SEGMENT_KERNEL_RO : SEGMENT_KERNEL);
-	if (!nx)
-		prot &= ~_SEGMENT_ENTRY_NOEXEC;
-	pmdp = pm_dir;
-	for (i = 0; i < PTRS_PER_PMD; i++) {
-		set_pmd(pmdp, __pmd(pmd_addr | prot));
-		pmd_addr += PMD_SIZE;
-		pmdp++;
-	}
-	new = __pud(__pa(pm_dir) | _REGION3_ENTRY);
-	pgt_set((unsigned long *)pudp, pud_val(new), addr, CRDTE_DTT_REGION3);
-	update_page_count(PG_DIRECT_MAP_1M, PTRS_PER_PMD);
-	update_page_count(PG_DIRECT_MAP_2G, -1);
-	return 0;
-}
+	if (level == PGTABLE_LEVEL_PMD)
+		table = vmem_pte_alloc();
+	else
+		table = vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
 
-static void modify_pud_page(pud_t *pudp, unsigned long addr,
-			    unsigned long flags)
-{
-	pud_t new = pudp_get(pudp);
-
-	if (flags & SET_MEMORY_RO)
-		new = pud_wrprotect(new);
-	else if (flags & SET_MEMORY_RW)
-		new = pud_mkwrite(pud_mkdirty(new));
-	if (flags & SET_MEMORY_NX)
-		new = set_pud_bit(new, __pgprot(_REGION_ENTRY_NOEXEC));
-	else if (flags & SET_MEMORY_X)
-		new = clear_pud_bit(new, __pgprot(_REGION_ENTRY_NOEXEC));
-	if (flags & SET_MEMORY_INV) {
-		new = set_pud_bit(new, __pgprot(_REGION_ENTRY_INVALID));
-	} else if (flags & SET_MEMORY_DEF) {
-		new = __pud(pud_val(new) & PUD_MASK);
-		new = set_pud_bit(new, REGION3_KERNEL);
-	}
-	pgt_set((unsigned long *)pudp, pud_val(new), addr, CRDTE_DTT_REGION3);
+	return table;
 }
 
-static int walk_pud_level(p4d_t *p4d, unsigned long addr, unsigned long end,
-			  unsigned long flags)
+void arch_cpa_free_pgtable(struct cpa_leaf *leaf, void *table)
 {
-	unsigned long next;
-	pud_t *pudp, pud;
-	int need_split;
-	int rc = 0;
-
-	pudp = pud_offset(p4d, addr);
-	do {
-		pud = pudp_get(pudp);
-		if (pud_none(pud))
-			return -EINVAL;
-		next = pud_addr_end(addr, end);
-		if (pud_leaf(pud)) {
-			need_split  = !!(flags & SET_MEMORY_4K);
-			need_split |= !!(addr & ~PUD_MASK);
-			need_split |= !!(addr + PUD_SIZE > next);
-			if (need_split) {
-				rc = split_pud_page(pudp, addr);
-				if (rc)
-					break;
-				continue;
-			}
-			modify_pud_page(pudp, addr, flags);
-		} else {
-			rc = walk_pmd_level(pudp, addr, next, flags);
-		}
-		pudp++;
-		addr = next;
-	} while (addr < end && !rc);
-	return rc;
-}
+	enum pgtable_level level = leaf->level;
 
-static int walk_p4d_level(pgd_t *pgd, unsigned long addr, unsigned long end,
-			  unsigned long flags)
-{
-	unsigned long next;
-	p4d_t *p4dp;
-	int rc = 0;
-
-	p4dp = p4d_offset(pgd, addr);
-	do {
-		if (p4d_none(p4dp_get(p4dp)))
-			return -EINVAL;
-		next = p4d_addr_end(addr, end);
-		rc = walk_pud_level(p4dp, addr, next, flags);
-		p4dp++;
-		addr = next;
-	} while (addr < end && !rc);
-	return rc;
+	if (level == PGTABLE_LEVEL_PMD)
+		page_table_free(&init_mm, table);
+	else
+		free_pages((unsigned long)table, CRST_ALLOC_ORDER);
 }
 
-DEFINE_MUTEX(cpa_mutex);
-
-static int change_page_attr(unsigned long addr, unsigned long end,
-			    unsigned long flags)
+int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
+			void *table)
 {
-	unsigned long next;
-	int rc = -EINVAL;
-	pgd_t *pgdp;
+	unsigned long *entry = (unsigned long *)leaf->kpte;
+	unsigned long prot = pgprot_val(leaf->prot);
+	unsigned long addr = PFN_PHYS(leaf->pfn);
+	enum pgtable_level level = leaf->level;
+	unsigned long lpaddr = leaf->addr;
+	unsigned long i;
+
+	switch (level) {
+	case PGTABLE_LEVEL_PMD:
+		for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE)
+			set_pte((pte_t *)table + i, __pte(addr | prot));
+		pgt_set(entry, __pa(table) | _SEGMENT_ENTRY, lpaddr,
+			CRDTE_DTT_SEGMENT);
+		break;
+	case PGTABLE_LEVEL_PUD:
+		prot = cpa_pte_to_large(prot);
+		for (i = 0; i < PTRS_PER_PMD; i++, addr += PMD_SIZE)
+			set_pmd((pmd_t *)table + i, __pmd(addr | prot));
+		pgt_set(entry, __pa(table) | _REGION3_ENTRY, lpaddr,
+			CRDTE_DTT_REGION3);
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	pgdp = pgd_offset_k(addr);
-	do {
-		if (pgd_none(pgdp_get(pgdp)))
-			break;
-		next = pgd_addr_end(addr, end);
-		rc = walk_p4d_level(pgdp, addr, next, flags);
-		if (rc)
-			break;
-	} while (pgdp++, addr = next, addr < end && !rc);
-	return rc;
+	return 0;
 }
 
-static int change_page_attr_alias(unsigned long addr, unsigned long end,
-				  unsigned long flags)
+/*
+ * Memory hot-remove splits a region-third entry of the identity map that
+ * it removes only a part of. It calls the hooks outside of a request,
+ * under vmem_mutex and without cpa_lock.
+ */
+int split_pud_page(pud_t *pudp, unsigned long addr)
 {
-	unsigned long alias, offset, va_start, va_end;
-	struct vm_struct *area;
-	int rc = 0;
-
-	/*
-	 * Changes to read-only permissions on kernel VA mappings are also
-	 * applied to the kernel direct mapping. Execute permissions are
-	 * intentionally not transferred to keep all allocated pages within
-	 * the direct mapping non-executable.
-	 */
-	flags &= SET_MEMORY_RO | SET_MEMORY_RW;
-	if (!flags)
-		return 0;
-	area = NULL;
-	while (addr < end) {
-		if (!area)
-			area = find_vm_area((void *)addr);
-		if (!area || !(area->flags & VM_ALLOC))
-			return 0;
-		va_start = (unsigned long)area->addr;
-		va_end = va_start + area->nr_pages * PAGE_SIZE;
-		offset = (addr - va_start) >> PAGE_SHIFT;
-		alias = (unsigned long)page_address(area->pages[offset]);
-		rc = change_page_attr(alias, alias + PAGE_SIZE, flags);
-		if (rc)
-			break;
-		addr += PAGE_SIZE;
-		if (addr >= va_end)
-			area = NULL;
+	struct cpa_leaf leaf = {
+		.kpte = (pte_t *)pudp,
+		.level = PGTABLE_LEVEL_PUD,
+		.addr = addr,
+		.size = PUD_SIZE,
+	};
+	void *table;
+	int rc;
+
+	arch_cpa_decode_leaf(&leaf);
+	table = arch_cpa_alloc_pgtable(&leaf);
+	if (!table)
+		return -ENOMEM;
+
+	rc = arch_cpa_split_leaf(NULL, &leaf, table);
+	if (rc) {
+		arch_cpa_free_pgtable(&leaf, table);
+		return rc;
 	}
-	return rc;
+
+	direct_map_count_split(PGTABLE_LEVEL_PUD);
+
+	return 0;
 }
 
-int __set_memory(unsigned long addr, unsigned long numpages, unsigned long flags)
+/*
+ * Changes to read-only permissions on kernel VA mappings are also
+ * applied to the kernel direct mapping. Execute permissions are
+ * intentionally not transferred to keep all allocated pages within
+ * the direct mapping non-executable.
+ */
+#define CPA_ALIAS_PROT	(_PAGE_PROTECT | _PAGE_WRITE | _PAGE_DIRTY | \
+			 _PAGE_SOFT_DIRTY)
+
+int arch_cpa_process_alias(struct cpa_data *cpa)
 {
-	unsigned long end;
-	int rc;
+	unsigned long set = pgprot_val(cpa->mask_set) & CPA_ALIAS_PROT;
+	unsigned long clr = pgprot_val(cpa->mask_clr) & CPA_ALIAS_PROT;
+	unsigned long vaddr = cpa_addr(cpa, cpa->curpage);
+	struct cpa_data alias_cpa;
 
-	if (!cpu_has_nx())
-		flags &= ~(SET_MEMORY_NX | SET_MEMORY_X);
-	if (!flags)
-		return 0;
-	if (!numpages)
+	/* The identity map covers the memory below ident_map_size. */
+	if (cpa_is_direct_map(vaddr) || PFN_PHYS(cpa->pfn) >= ident_map_size)
 		return 0;
-	addr &= PAGE_MASK;
-	end = addr + numpages * PAGE_SIZE;
-	mutex_lock(&cpa_mutex);
-	rc = change_page_attr(addr, end, flags);
-	if (rc)
-		goto out;
-	rc = change_page_attr_alias(addr, end, flags);
-out:
-	mutex_unlock(&cpa_mutex);
-	return rc;
+
+	alias_cpa = *cpa;
+	alias_cpa.addr = (unsigned long)__va(PFN_PHYS(cpa->pfn));
+	alias_cpa.mask_set = __pgprot(set);
+	alias_cpa.mask_clr = __pgprot(clr);
+
+	return cpa_change_alias(cpa, &alias_cpa);
 }
 
-int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
+static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
+	[CPA_OP_RO]	= { .set = __pgprot(_PAGE_PROTECT),
+			    .clr = __pgprot(_PAGE_WRITE) },
+	[CPA_OP_RW]	= { .set = __pgprot(_PAGE_WRITE | _PAGE_DIRTY |
+					   _PAGE_SOFT_DIRTY),
+			    .clr = __pgprot(_PAGE_PROTECT) },
+	[CPA_OP_X]	= { .clr = __pgprot(_PAGE_NOEXEC) },
+	[CPA_OP_NX]	= { .set = __pgprot(_PAGE_NOEXEC) },
+	[CPA_OP_ROX]	= { .set = __pgprot(_PAGE_PROTECT),
+			    .clr = __pgprot(_PAGE_WRITE | _PAGE_NOEXEC) },
+	[CPA_OP_DIRECT_MAP_INVALID] = { .set = __pgprot(_PAGE_INVALID) },
+	[CPA_OP_DIRECT_MAP_DEFAULT] = { .set = __pgprot(__PAGE_KERNEL),
+					.clr = __pgprot(~PAGE_MASK) },
+};
+
+int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 {
-	return __set_memory((unsigned long)page_to_virt(page), nr, SET_MEMORY_INV);
+	cpa_init_op(cpa, &cpa_ops[op]);
+
+	/* _PAGE_NOEXEC needs the instruction-execution-protection facility */
+	cpa->mask_set = __pgprot(pgprot_val(cpa->mask_set) & page_noexec_mask);
+	cpa->mask_clr = __pgprot(pgprot_val(cpa->mask_clr) & page_noexec_mask);
+
+	return 0;
 }
 
-int set_direct_map_default_noflush(struct page *page, unsigned int nr)
+int set_memory_4k(unsigned long addr, unsigned long numpages)
 {
-	return __set_memory((unsigned long)page_to_virt(page), nr, SET_MEMORY_DEF);
+	struct cpa_data cpa = {
+		.addr = addr,
+		.numpages = numpages,
+		.flags = CPA_REQ_SPLIT,
+	};
+
+	return change_page_attr(&cpa);
 }
 
 bool kernel_page_present(struct page *page)
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 191326ee7ec8..3cf4e6987ac0 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -6,6 +6,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/cpufeature.h>
 #include <linux/memblock.h>
+#include <linux/pageattr.h>
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -198,7 +199,8 @@ static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
 	ret = 0;
 out:
 	if (direct)
-		update_page_count(PG_DIRECT_MAP_4K, add ? pages : -pages);
+		direct_map_count_update(PGTABLE_LEVEL_PTE,
+					add ? pages : -pages);
 	return ret;
 }
 
@@ -295,7 +297,8 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 	ret = 0;
 out:
 	if (direct)
-		update_page_count(PG_DIRECT_MAP_1M, add ? pages : -pages);
+		direct_map_count_update(PGTABLE_LEVEL_PMD,
+					add ? pages : -pages);
 	return ret;
 }
 
@@ -365,7 +368,8 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 	ret = 0;
 out:
 	if (direct)
-		update_page_count(PG_DIRECT_MAP_2G, add ? pages : -pages);
+		direct_map_count_update(PGTABLE_LEVEL_PUD,
+					add ? pages : -pages);
 	return ret;
 }
 

-- 
2.53.0

