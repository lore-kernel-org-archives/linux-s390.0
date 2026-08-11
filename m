Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF730ACF0;
	Tue, 11 Aug 2026 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422115; cv=none; b=Qqxfznuo4IsaWwFbNhOKxl6bQriFLIwKK0HMFw/tSHGR16hWixZJDNRa7LXljXU6v7ukQ195H3xPrB6oDZjaMvYn4qt8WpyJgstbLLt7TkLOYUem1UwZ0QyGr9dKwdl5QXmqkWFLH3R4jiPEQ7+8eKuOOoi6jBER7EY9QxmvurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422115; c=relaxed/simple;
	bh=9A0/zP6yMr1RYmnH8Jrt+EEKvBbwd6Mo9B1k6peAylk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKDSZWLNq4fy1Xy/PdCqkJhYuQF9zN8X0jYx1iA5udJ1dP0cO0TOhknMiWqHcPnitDuiF2MMxvnkBPoeOX3KANQKRWyalz1xWLr3vndwWPhTi7luMBkUS/H+yFQjql11L6/UojSOtSosi8EUhsNlvG+q3xzUFvnwgmCd/s5j3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YEDdpbgS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YEDdpbgS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3601692;
	Mon, 10 Aug 2026 21:21:43 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093C43F673;
	Mon, 10 Aug 2026 21:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422107; bh=9A0/zP6yMr1RYmnH8Jrt+EEKvBbwd6Mo9B1k6peAylk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEDdpbgSs9AmgfF7HAzdvDUcWznpSY5+T18/4etSIL8bycx5dY+qq1KSql7p+IecT
	 YaIK6gD1QMcei5E2lNKVRJKcK0gUt0StlPCJR/0NfMc4I0eG82yEUXiMZuVyhuSeh0
	 4j/XHFcnPTWFzpCeOth7WkBRZUUqYhLlQgh9nMFM=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC V2 6/6] mm: Drop pxd_ERROR()
Date: Tue, 11 Aug 2026 09:51:19 +0530
Message-ID: <20260811042119.3652929-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxd_ERROR() has been used in generic mm just to print the page table entry
in pxd_clear_bad() before clearing those out with pxd_clear() later. These
pxd_ERROR() macros have been provided by all platforms which basically did
the same thing.

Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
page table entries thus completely dropping dependency on platform provided
pxd_ERROR() macros which can then be dropped off. First move all required
helpers in core MM into a header file which could then be used else where.

Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/alpha/include/asm/pgtable.h              |  7 ----
 arch/arc/include/asm/pgtable-levels.h         | 11 -----
 arch/arm/include/asm/pgtable.h                |  7 ----
 arch/arm/kernel/traps.c                       | 17 --------
 arch/arm64/include/asm/pgtable.h              | 15 -------
 arch/csky/include/asm/pgtable.h               |  4 --
 arch/hexagon/include/asm/pgtable.h            |  3 --
 arch/loongarch/include/asm/pgtable.h          | 11 -----
 arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
 arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
 arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
 arch/microblaze/include/asm/pgtable.h         |  7 ----
 arch/mips/include/asm/pgtable-32.h            | 10 -----
 arch/mips/include/asm/pgtable-64.h            | 13 ------
 arch/nios2/include/asm/pgtable.h              |  7 ----
 arch/openrisc/include/asm/pgtable.h           |  7 ----
 arch/parisc/include/asm/pgtable.h             |  9 ----
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  2 -
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 ----
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  2 -
 .../include/asm/nohash/64/pgtable-4k.h        |  3 --
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 ---
 arch/riscv/include/asm/pgtable-64.h           |  9 ----
 arch/riscv/include/asm/pgtable.h              |  4 --
 arch/s390/include/asm/pgtable.h               | 11 -----
 arch/sh/include/asm/pgtable-3level.h          |  3 --
 arch/sh/include/asm/pgtable_32.h              |  8 ----
 arch/sparc/include/asm/pgtable_32.h           |  3 --
 arch/sparc/include/asm/pgtable_64.h           | 10 -----
 arch/um/include/asm/pgtable-2level.h          |  7 ----
 arch/um/include/asm/pgtable-4level.h          | 13 ------
 arch/x86/include/asm/pgtable-2level.h         |  5 ---
 arch/x86/include/asm/pgtable-3level.h         | 11 -----
 arch/x86/include/asm/pgtable_64.h             | 18 --------
 arch/xtensa/include/asm/pgtable.h             |  4 --
 include/asm-generic/pgtable-nop4d.h           |  1 -
 include/asm-generic/pgtable-nopmd.h           |  1 -
 include/asm-generic/pgtable-nopud.h           |  1 -
 include/linux/mm_types.h                      | 41 +++++++++++++++++++
 mm/memory.c                                   | 41 +------------------
 mm/pgtable-generic.c                          | 21 ++++++++--
 41 files changed, 59 insertions(+), 321 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 8e00cf9dc39d..7cac8241ee67 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -357,13 +357,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 extern void paging_init(void);
 
 /* We have our own get_unmapped_area */
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index c8f9273372c0..167b82fcfafe 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -98,8 +98,6 @@
 /*
  * 1st level paging: pgd
  */
-#define pgd_ERROR(e) \
-	pr_crit("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
@@ -115,9 +113,6 @@
 /*
  * 2nd level paging: pud
  */
-#define pud_ERROR(e) \
-	pr_crit("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
-
 #endif
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -137,9 +132,6 @@
 /*
  * 3rd level paging: pmd
  */
-#define pmd_ERROR(e) \
-	pr_crit("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
-
 #define pmd_pfn(pmd)		((pmd_val(pmd) & PMD_MASK) >> PAGE_SHIFT)
 #define pfn_pmd(pfn,prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
@@ -165,9 +157,6 @@
 /*
  * 4th level paging: pte
  */
-#define pte_ERROR(e) \
-	pr_crit("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-
 #define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pte_none(x)		(!pte_val(x))
 #define pte_present(x)		(pte_val(x) & _PAGE_PRESENT)
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 982795cf4563..8dd17d20faa3 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -44,13 +44,6 @@
 #define LIBRARY_TEXT_START	0x0c000000
 
 #ifndef __ASSEMBLY__
-extern void __pte_error(const char *file, int line, pte_t);
-extern void __pmd_error(const char *file, int line, pmd_t);
-extern void __pgd_error(const char *file, int line, pgd_t);
-
-#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte)
-#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd)
-#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd)
 
 /*
  * This is the lowest virtual address we can permit any user space
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index afbd2ebe5c39..ad04c806cc9d 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -753,23 +753,6 @@ void __readwrite_bug(const char *fn)
 }
 EXPORT_SYMBOL(__readwrite_bug);
 
-#ifdef CONFIG_MMU
-void __pte_error(const char *file, int line, pte_t pte)
-{
-	pr_err("%s:%d: bad pte %08llx.\n", file, line, (long long)pte_val(pte));
-}
-
-void __pmd_error(const char *file, int line, pmd_t pmd)
-{
-	pr_err("%s:%d: bad pmd %08llx.\n", file, line, (long long)pmd_val(pmd));
-}
-
-void __pgd_error(const char *file, int line, pgd_t pgd)
-{
-	pr_err("%s:%d: bad pgd %08llx.\n", file, line, (long long)pgd_val(pgd));
-}
-#endif
-
 asmlinkage void __div0(void)
 {
 	pr_err("Division by zero in kernel.\n");
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 27689c62bd25..93557f52ae69 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -107,9 +107,6 @@ static inline void arch_leave_lazy_mmu_mode(void)
 	__flush_tlb_range(vma, address, address + PMD_SIZE, PMD_SIZE, 2,	\
 			  TLBF_NOBROADCAST | TLBF_NONOTIFY | TLBF_NOWALKCACHE)
 
-#define pte_ERROR(e)	\
-	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
-
 #ifdef CONFIG_ARM64_PA_BITS_52
 static inline phys_addr_t __pte_to_phys(pte_t pte)
 {
@@ -865,9 +862,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
-#define pmd_ERROR(e)	\
-	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
-
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		((pud_val(pud) & PUD_TYPE_MASK) != \
 				 PUD_TYPE_TABLE)
@@ -959,9 +953,6 @@ static inline bool mm_pud_folded(const struct mm_struct *mm)
 }
 #define mm_pud_folded  mm_pud_folded
 
-#define pud_ERROR(e)	\
-	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
-
 #define p4d_none(p4d)		(pgtable_l4_enabled() && !p4d_val(p4d))
 #define p4d_bad(p4d)		(pgtable_l4_enabled() && \
 				((p4d_val(p4d) & P4D_TYPE_MASK) != \
@@ -1087,9 +1078,6 @@ static inline bool mm_p4d_folded(const struct mm_struct *mm)
 }
 #define mm_p4d_folded  mm_p4d_folded
 
-#define p4d_ERROR(e)	\
-	pr_err("%s:%d: bad p4d %016llx.\n", __FILE__, __LINE__, p4d_val(e))
-
 #define pgd_none(pgd)		(pgtable_l5_enabled() && !pgd_val(pgd))
 #define pgd_bad(pgd)		(pgtable_l5_enabled() && \
 				((pgd_val(pgd) & PGD_TYPE_MASK) != \
@@ -1216,9 +1204,6 @@ p4d_t *p4d_offset_lockless_folded(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
 
 #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
 
-#define pgd_ERROR(e)	\
-	pr_err("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
-
 #define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
 #define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
 
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index bafcd5823531..5ca77ff89ef9 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -23,10 +23,6 @@
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 #define PFN_PTE_SHIFT	PAGE_SHIFT
 #define pmd_pfn(pmd)	(pmd_phys(pmd) >> PAGE_SHIFT)
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 27b269e2870d..2fdb27afe703 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -94,9 +94,6 @@
 #endif
 
 /*  Any bigger and the PTE disappears.  */
-#define pgd_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__,\
-		pgd_val(e))
 
 /*
  * Page Protection Constants. Includes (in this variant) cache attributes.
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index a32a8fff70c1..c575e29c0b48 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -128,17 +128,6 @@ struct vm_area_struct;
 #define ptep_get(ptep) READ_ONCE(*(ptep))
 #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
 
-#ifndef __PAGETABLE_PMD_FOLDED
-#define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
-#endif
-#ifndef __PAGETABLE_PUD_FOLDED
-#define pud_ERROR(e) \
-	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
-#endif
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
 
 #ifndef __PAGETABLE_PUD_FOLDED
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 189bb7b1e663..f45a882238db 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -137,12 +137,6 @@ static inline int pmd_bad2(pmd_t *pmd) { return 0; }
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
 static inline void pmd_clear(pmd_t *pmdp) { pmd_val(*pmdp) = 0; }
 
-#define pte_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pte %08lx.\n",	\
-	__FILE__, __LINE__, pte_val(e))
-#define pgd_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pgd %08lx.\n",	\
-	__FILE__, __LINE__, pgd_val(e))
 
 /*
  * The following only work if pte_present() is true.
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index dcf6829b3eab..d9393b310add 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -131,14 +131,6 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 #define pud_clear(pudp)		({ pud_val(*pudp) = 0; })
 #define pud_page(pud)		(mem_map + ((unsigned long)(__va(pud_val(pud)) - PAGE_OFFSET) >> PAGE_SHIFT))
 
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
-
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 80ca185a18a1..704442a391fd 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -119,13 +119,6 @@ static inline int pmd_present2 (pmd_t *pmd) { return pmd_val (*pmd) & SUN3_PMD_V
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
 static inline void pmd_clear (pmd_t *pmdp) { pmd_val (*pmdp) = 0; }
 
-
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
-
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not...
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 7678c040a2fd..72708f9af1c0 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -103,13 +103,6 @@ extern pte_t *va_to_pte(unsigned long address);
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
 #define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
 
-#define pte_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pte "PTE_FMT".\n", \
-		__FILE__, __LINE__, pte_val(e))
-#define pgd_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pgd %08lx.\n", \
-		__FILE__, __LINE__, pgd_val(e))
-
 /*
  * Bits in a linux-style PTE.  These match the bits in the
  * (hardware-defined) PTE as closely as possible.
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 92b7591aac2a..ef1001ab09c5 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -104,16 +104,6 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 # define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
 #endif
 
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %016Lx.\n", __FILE__, __LINE__, pte_val(e))
-#else
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#endif
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 extern void load_pgd(unsigned long pg_dir);
 
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 6e854bb11f37..785fc37bab94 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -151,19 +151,6 @@
 #define MODULES_END	(FIXADDR_START-2*PAGE_SIZE)
 #endif
 
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
-#ifndef __PAGETABLE_PMD_FOLDED
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
-#endif
-#ifndef __PAGETABLE_PUD_FOLDED
-#define pud_ERROR(e) \
-	printk("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
-#endif
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
 
 #ifndef __PAGETABLE_PUD_FOLDED
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index d389aa9ca57c..272707d48f1b 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -223,13 +223,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return pmd_val(pmd);
 }
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %08lx.\n", \
-		__FILE__, __LINE__, pte_val(e))
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", \
-		__FILE__, __LINE__, pgd_val(e))
-
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
  * are !pte_none() && !pte_present().
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 6b89996d0b62..13afcc0bd863 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -338,13 +338,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pte_pfn(x)		((unsigned long)(((x).pte)) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)  __pte((((pfn) << PAGE_SHIFT)) | pgprot_val(prot))
 
-#define pte_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pte %p(%08lx).\n", \
-	       __FILE__, __LINE__, &(e), pte_val(e))
-#define pgd_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pgd %p(%08lx).\n", \
-	       __FILE__, __LINE__, &(e), pgd_val(e))
-
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD]; /* defined in head.S */
 
 struct vm_area_struct;
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 467b8547ac8b..f6899375cb43 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -75,15 +75,6 @@ extern void __update_cache(pte_t pte);
 
 #endif /* !__ASSEMBLER__ */
 
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#if CONFIG_PGTABLE_LEVELS == 3
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, (unsigned long)pmd_val(e))
-#endif
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, (unsigned long)pgd_val(e))
-
 /* This is the size of the initially mapped kernel memory */
 #if defined(CONFIG_64BIT) || defined(CONFIG_KALLSYMS)
 #define KERNEL_INITIAL_ORDER	26	/* 1<<26 = 64MB */
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index e18a4fa282a1..835e84caee13 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -203,8 +203,6 @@ void unmap_kernel_page(unsigned long va);
 /* Bits to mask out from a PGD to get to the PUD page */
 #define PGD_MASKED_BITS		0
 
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 /*
  * Bits in a linux-style PTE.  These match the bits in the
  * (hardware-defined) PowerPC PTE as closely as possible.
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e67e64ac6e8c..94ce6529652c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -991,13 +991,6 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 	return (pmd_t *)__va(pud_val(pud) & ~PUD_MASKED_BITS);
 }
 
-#define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
-#define pud_ERROR(e) \
-	pr_err("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 static inline int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 {
 	if (radix_enabled()) {
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 496ecc65ac25..f17afde89fa1 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -51,8 +51,6 @@
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08llx.\n", __FILE__, __LINE__, (unsigned long long)pgd_val(e))
 
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index fb6fa1d4e074..75cf3c331b92 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -82,9 +82,6 @@ extern struct page *p4d_page(p4d_t p4d);
 
 #endif /* !__ASSEMBLER__ */
 
-#define pud_ERROR(e) \
-	pr_err("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
-
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range() */
 #define remap_4k_pfn(vma, addr, pfn, prot)	\
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 661eb3820d12..446dde8b6ead 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -159,11 +159,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	__young;							\
 })
 
-#define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
  * are !pte_none() && !pte_present().
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 6e789fa58514..ae23182b572c 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -264,15 +264,6 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 	return __page_val_to_pfn(pmd_val(pmd));
 }
 
-#define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
-
-#define pud_ERROR(e)   \
-	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
-
-#define p4d_ERROR(e)   \
-	pr_err("%s:%d: bad p4d %016lx.\n", __FILE__, __LINE__, p4d_val(e))
-
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	if (pgtable_l4_enabled)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5d5756bda82e..993a6505eb8f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -559,10 +559,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
 }
 
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd " PTE_FMT ".\n", __FILE__, __LINE__, pgd_val(e))
-
-
 /* Commit new configuration to MMU hardware */
 static inline void update_mmu_cache_range(struct vm_fault *vmf,
 		struct vm_area_struct *vma, unsigned long address,
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 859ce7c7d454..46b2a1adc2ae 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -68,17 +68,6 @@ extern unsigned long zero_page_mask;
 
 /* TODO: s390 cannot support io_remap_pfn_range... */
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
-#define pud_ERROR(e) \
-	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
-#define p4d_ERROR(e) \
-	pr_err("%s:%d: bad p4d %016lx.\n", __FILE__, __LINE__, p4d_val(e))
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 /*
  * The vmalloc and module area will always be on the topmost area of the
  * kernel mapping. 512GB are reserved for vmalloc by default.
diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index d1ce73f3bd85..3f4d747f30f4 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -25,9 +25,6 @@
 
 #define PTRS_PER_PMD	((1 << PGDIR_SHIFT) / PMD_SIZE)
 
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
-
 typedef union {
 	struct {
 		unsigned long pmd_low;
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index c8eb9a7a4c4c..cde1bf0c6734 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -400,14 +400,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pmd_pfn(pmd)		(__pa(pmd_val(pmd)) >> PAGE_SHIFT)
 #define pmd_page(pmd)		(virt_to_page(pmd_val(pmd)))
 
-#ifdef CONFIG_X2TLB
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
-#else
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-#endif
-
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
  * are !pte_none() && !pte_present().
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index f89b1250661d..5a5f54a090f5 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -40,9 +40,6 @@ void load_mmu(void);
 unsigned long calc_highpages(void);
 unsigned long __init bootmem_init(unsigned long *pages_avail);
 
-#define pte_ERROR(e)   __builtin_trap()
-#define pmd_ERROR(e)   __builtin_trap()
-#define pgd_ERROR(e)   __builtin_trap()
 
 #define PTRS_PER_PTE    	64
 #define PTRS_PER_PMD    	64
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 74ede706fb32..9b0ac8722a46 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -96,16 +96,6 @@ bool kern_addr_valid(unsigned long addr);
 #define PTRS_PER_PUD	(1UL << PUD_BITS)
 #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
 
-#define pmd_ERROR(e)							\
-	pr_err("%s:%d: bad pmd %p(%016lx) seen at (%pS)\n",		\
-	       __FILE__, __LINE__, &(e), pmd_val(e), __builtin_return_address(0))
-#define pud_ERROR(e)							\
-	pr_err("%s:%d: bad pud %p(%016lx) seen at (%pS)\n",		\
-	       __FILE__, __LINE__, &(e), pud_val(e), __builtin_return_address(0))
-#define pgd_ERROR(e)							\
-	pr_err("%s:%d: bad pgd %p(%016lx) seen at (%pS)\n",		\
-	       __FILE__, __LINE__, &(e), pgd_val(e), __builtin_return_address(0))
-
 #endif /* !(__ASSEMBLER__) */
 
 /* PTE bits which are the same in SUN4U and SUN4V format.  */
diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index 14ec16f92ce4..fa625f5b5ef7 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -24,13 +24,6 @@
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define PTRS_PER_PGD	1024
 
-#define pte_ERROR(e) \
-        printk("%s:%d: bad pte %p(%08lx).\n", __FILE__, __LINE__, &(e), \
-	       pte_val(e))
-#define pgd_ERROR(e) \
-        printk("%s:%d: bad pgd %p(%08lx).\n", __FILE__, __LINE__, &(e), \
-	       pgd_val(e))
-
 static inline int pgd_needsync(pgd_t pgd)	{ return 0; }
 static inline void pgd_mkuptodate(pgd_t pgd)	{ }
 
diff --git a/arch/um/include/asm/pgtable-4level.h b/arch/um/include/asm/pgtable-4level.h
index 7a271b7b83d2..ff82f99c80fa 100644
--- a/arch/um/include/asm/pgtable-4level.h
+++ b/arch/um/include/asm/pgtable-4level.h
@@ -42,19 +42,6 @@
 
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 
-#define pte_ERROR(e) \
-        printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), \
-	       pte_val(e))
-#define pmd_ERROR(e) \
-        printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
-	       pmd_val(e))
-#define pud_ERROR(e) \
-        printk("%s:%d: bad pud %p(%016lx).\n", __FILE__, __LINE__, &(e), \
-	       pud_val(e))
-#define pgd_ERROR(e) \
-        printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
-	       pgd_val(e))
-
 #define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEEDSYNC))
 #define	pud_bad(x)	((pud_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define pud_present(x)	(pud_val(x) & _PAGE_PRESENT)
diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index e9482a11ac52..83427765cfbf 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -2,11 +2,6 @@
 #ifndef _ASM_X86_PGTABLE_2LEVEL_H
 #define _ASM_X86_PGTABLE_2LEVEL_H
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %08lx\n", __FILE__, __LINE__, (e).pte_low)
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx\n", __FILE__, __LINE__, pgd_val(e))
-
 /*
  * Certain architectures need to do special things when PTEs
  * within a page table are directly modified.  Thus, the following
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index dabafba957ea..d6729911e09a 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -8,17 +8,6 @@
  *
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
  */
-
-#define pte_ERROR(e)							\
-	pr_err("%s:%d: bad pte %p(%08lx%08lx)\n",			\
-	       __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
-#define pmd_ERROR(e)							\
-	pr_err("%s:%d: bad pmd %p(%016Lx)\n",				\
-	       __FILE__, __LINE__, &(e), pmd_val(e))
-#define pgd_ERROR(e)							\
-	pr_err("%s:%d: bad pgd %p(%016Lx)\n",				\
-	       __FILE__, __LINE__, &(e), pgd_val(e))
-
 #define pxx_xchg64(_pxx, _ptr, _val) ({					\
 	_pxx##val_t *_p = (_pxx##val_t *)_ptr;				\
 	_pxx##val_t _o = *_p;						\
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index ce45882ccd07..c861f3832bed 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -29,24 +29,6 @@ extern pgd_t init_top_pgt[];
 extern void paging_init(void);
 static inline void sync_initial_page_table(void) { }
 
-#define pte_ERROR(e)					\
-	pr_err("%s:%d: bad pte %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pte_val(e))
-#define pmd_ERROR(e)					\
-	pr_err("%s:%d: bad pmd %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pmd_val(e))
-#define pud_ERROR(e)					\
-	pr_err("%s:%d: bad pud %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pud_val(e))
-
-#define p4d_ERROR(e)					\
-	pr_err("%s:%d: bad p4d %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), p4d_val(e))
-
-#define pgd_ERROR(e)					\
-	pr_err("%s:%d: bad pgd %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pgd_val(e))
-
 struct mm_struct;
 
 #define mm_p4d_folded mm_p4d_folded
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index f00a879dc298..60fb67a99729 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -204,10 +204,6 @@
  */
 #ifndef __ASSEMBLER__
 
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd entry %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 #ifdef CONFIG_MMU
 extern pgd_t swapper_pg_dir[PAGE_SIZE/sizeof(pgd_t)];
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd4..fbd032aa4315 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -22,7 +22,6 @@ static inline int pgd_none(pgd_t pgd)		{ return 0; }
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 static inline void pgd_clear(pgd_t *pgd)	{ }
-#define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
 
 #define pgd_populate(mm, pgd, p4d)		do { } while (0)
 #define pgd_populate_safe(mm, pgd, p4d)		do { } while (0)
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24c..d107a9f03b97 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -33,7 +33,6 @@ static inline int pud_present(pud_t pud)	{ return 1; }
 static inline int pud_user(pud_t pud)		{ return 0; }
 static inline int pud_leaf(pud_t pud)		{ return 0; }
 static inline void pud_clear(pud_t *pud)	{ }
-#define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
 
 #define pud_populate(mm, pmd, pte)		do { } while (0)
 
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff..868218f3210c 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -29,7 +29,6 @@ static inline int p4d_none(p4d_t p4d)		{ return 0; }
 static inline int p4d_bad(p4d_t p4d)		{ return 0; }
 static inline int p4d_present(p4d_t p4d)	{ return 1; }
 static inline void p4d_clear(p4d_t *p4d)	{ }
-#define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
 
 #define p4d_populate(mm, p4d, pud)		do { } while (0)
 #define p4d_populate_safe(mm, p4d, pud)		do { } while (0)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..5f5bc860266a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -2001,4 +2001,45 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
 	return flags & MMF_INIT_LEGACY_MASK;
 }
 
+static inline void
+ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
+{
+	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
+		snprintf(buf, buf_size, "overflow");
+		return;
+	}
+
+	switch (entry_size) {
+	case sizeof(u32):
+		snprintf(buf, buf_size, "%08x", *(const u32 *)entry);
+		break;
+	case sizeof(u64):
+		snprintf(buf, buf_size, "%016llx", *(const u64 *)entry);
+		break;
+#if defined(__SIZEOF_INT128__)
+	case sizeof(u128):
+		snprintf(buf, buf_size, "%016llx%016llx",
+			 (unsigned long long)(*(const u128 *)entry >> 64),
+			 (unsigned long long)*(const u128 *)entry);
+		break;
+#endif
+	default:
+		snprintf(buf, buf_size, "unsupported");
+		break;
+	}
+}
+
+#define ptval_to_str(buf, val)								\
+	do {										\
+		auto __val = (val);							\
+											\
+		ptval_bytes_to_hex_str((buf), sizeof(buf), &__val, sizeof(__val));	\
+	} while (0)
+
+#if defined(__SIZEOF_INT128__)
+#define PTVAL_STR_MAX	(32 + 1) /* Max 128-bit value in hex + NUL */
+#else
+#define PTVAL_STR_MAX	(16 + 1) /* Max 64-bit value in hex + NUL */
+#endif
+
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/memory.c b/mm/memory.c
index 01893720b6d8..be464e486ab9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -46,6 +46,7 @@
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
 #include <linux/hugetlb.h>
+#include <linux/mm_types.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/highmem.h>
@@ -519,46 +520,6 @@ static bool is_bad_page_map_ratelimited(void)
 	return false;
 }
 
-static void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
-{
-	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
-		snprintf(buf, buf_size, "overflow");
-		return;
-	}
-
-	switch (entry_size) {
-	case sizeof(u32):
-		snprintf(buf, buf_size, "%08x", *(const u32 *)entry);
-		break;
-	case sizeof(u64):
-		snprintf(buf, buf_size, "%016llx", *(const u64 *)entry);
-		break;
-#if defined(__SIZEOF_INT128__)
-	case sizeof(u128):
-		snprintf(buf, buf_size, "%016llx%016llx",
-			 (unsigned long long)(*(const u128 *)entry >> 64),
-			 (unsigned long long)*(const u128 *)entry);
-		break;
-#endif
-	default:
-		snprintf(buf, buf_size, "unsupported");
-		break;
-	}
-}
-
-#define ptval_to_str(buf, val)								\
-	do {										\
-		auto __val = (val);							\
-											\
-		ptval_bytes_to_hex_str((buf), sizeof(buf), &__val, sizeof(__val));	\
-	} while (0)
-
-#if defined(__SIZEOF_INT128__)
-#define PTVAL_STR_MAX	(32 + 1) /* Max 128-bit value in hex + NUL */
-#else
-#define PTVAL_STR_MAX	(16 + 1) /* Max 64-bit value in hex + NUL */
-#endif
-
 static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
 {
 	char pgd_str[PTVAL_STR_MAX];
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..f093e2474f4f 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mm_inline.h>
+#include <linux/mm_types.h>
 #include <linux/iommu.h>
 #include <linux/pgalloc.h>
 
@@ -26,14 +27,20 @@
 
 void pgd_clear_bad(pgd_t *pgd)
 {
-	pgd_ERROR(*pgd);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pgd_val(*pgd));
+	pr_err("bad pgd %s.\n", str);
 	pgd_clear(pgd);
 }
 
 #ifndef __PAGETABLE_P4D_FOLDED
 void p4d_clear_bad(p4d_t *p4d)
 {
-	p4d_ERROR(*p4d);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, p4d_val(*p4d));
+	pr_err("bad p4d %s.\n", str);
 	p4d_clear(p4d);
 }
 #endif
@@ -41,7 +48,10 @@ void p4d_clear_bad(p4d_t *p4d)
 #ifndef __PAGETABLE_PUD_FOLDED
 void pud_clear_bad(pud_t *pud)
 {
-	pud_ERROR(*pud);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pud_val(*pud));
+	pr_err("bad pud %s.\n", str);
 	pud_clear(pud);
 }
 #endif
@@ -53,7 +63,10 @@ void pud_clear_bad(pud_t *pud)
  */
 void pmd_clear_bad(pmd_t *pmd)
 {
-	pmd_ERROR(*pmd);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pmd_val(*pmd));
+	pr_err("bad pmd %s.\n", str);
 	pmd_clear(pmd);
 }
 
-- 
2.43.0

