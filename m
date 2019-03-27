Return-Path: <SRS0=MWzg=R6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless of
 the configuration
Date: Wed, 27 Mar 2019 02:36:26 -0400
Message-Id: <20190327063626.18421-5-alex@ghiti.fr>
In-Reply-To: <20190327063626.18421-1-alex@ghiti.fr>
References: <20190327063626.18421-1-alex@ghiti.fr>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
Cc: Alexandre Ghiti <alex@ghiti.fr>
List-ID: <linux-s390.vger.kernel.org>

On systems without CONTIG_ALLOC activated but that support gigantic pages,
boottime reserved gigantic pages can not be freed at all. This patch
simply enables the possibility to hand back those pages to memory
allocator.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: David S. Miller <davem@davemloft.net> [sparc]
---
 arch/arm64/Kconfig                           |  2 +-
 arch/arm64/include/asm/hugetlb.h             |  4 --
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  5 +-
 arch/powerpc/platforms/Kconfig.cputype       |  2 +-
 arch/s390/Kconfig                            |  2 +-
 arch/s390/include/asm/hugetlb.h              |  8 +--
 arch/sh/Kconfig                              |  2 +-
 arch/sparc/Kconfig                           |  2 +-
 arch/x86/Kconfig                             |  2 +-
 arch/x86/include/asm/hugetlb.h               |  4 --
 include/asm-generic/hugetlb.h                |  7 +++
 include/linux/gfp.h                          |  2 +-
 mm/hugetlb.c                                 | 54 ++++++++++++++------
 mm/page_alloc.c                              |  4 +-
 14 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a8380629cb3f..d33c6a7b9fc5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -18,7 +18,7 @@ config ARM64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
-	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
+	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index c6a07a3b433e..4aad6382f631 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -70,8 +70,4 @@ extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #include <asm-generic/hugetlb.h>
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static inline bool gigantic_page_supported(void) { return true; }
-#endif
-
 #endif /* __ASM_HUGETLB_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index ec2a55a553c7..7013284f0f1b 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -36,8 +36,8 @@ static inline int hstate_get_psize(struct hstate *hstate)
 	}
 }
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static inline bool gigantic_page_supported(void)
+#define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
+static inline bool gigantic_page_runtime_supported(void)
 {
 	/*
 	 * We used gigantic page reservation with hypervisor assist in some case.
@@ -49,7 +49,6 @@ static inline bool gigantic_page_supported(void)
 
 	return true;
 }
-#endif
 
 /* hugepd entry valid bit */
 #define HUGEPD_VAL_BITS		(0x8000000000000000UL)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index eb0f592cde69..03ca91439473 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -325,7 +325,7 @@ config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
-	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
+	select ARCH_HAS_GIGANTIC_PAGE
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1c8cb55b4e5d..5a9cc12c32c6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -69,7 +69,7 @@ config S390
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
-	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
+	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 2d1afa58a4b6..bb59dd964590 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -116,7 +116,9 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static inline bool gigantic_page_supported(void) { return true; }
-#endif
+static inline bool gigantic_page_runtime_supported(void)
+{
+	return true;
+}
+
 #endif /* _ASM_S390_HUGETLB_H */
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 67931bdaf32f..6d3db745ab7c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -53,7 +53,7 @@ config SUPERH
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
 	select NEED_SG_DMA_LENGTH
-	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
+	select ARCH_HAS_GIGANTIC_PAGE
 
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 52193cfb0f32..98f8dd663fd8 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -91,7 +91,7 @@ config SPARC64
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
-	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
+	select ARCH_HAS_GIGANTIC_PAGE
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 749bab313dc1..1b7584d17a5a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -21,7 +21,7 @@ config X86_64
 	def_bool y
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
-	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
+	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 7469d321f072..f65cfb48cfdd 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -17,8 +17,4 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static inline bool gigantic_page_supported(void) { return true; }
-#endif
-
 #endif /* _ASM_X86_HUGETLB_H */
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 71d7b77eea50..822f433ac95c 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -126,4 +126,11 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
 }
 #endif
 
+#ifndef __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
+static inline bool gigantic_page_runtime_supported(void)
+{
+	return IS_ENABLED(CONFIG_ARCH_HAS_GIGANTIC_PAGE);
+}
+#endif /* __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED */
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e77ab30e9328..fb07b503dc45 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -589,8 +589,8 @@ static inline bool pm_suspended_storage(void)
 /* The below functions must be run on a range from a single zone. */
 extern int alloc_contig_range(unsigned long start, unsigned long end,
 			      unsigned migratetype, gfp_t gfp_mask);
-extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
 #endif
+void free_contig_range(unsigned long pfn, unsigned int nr_pages);
 
 #ifdef CONFIG_CMA
 /* CMA stuff */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 97b1e0290c66..f3e84c1bef11 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1059,6 +1059,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
 	free_contig_range(page_to_pfn(page), 1 << order);
 }
 
+#ifdef CONFIG_CONTIG_ALLOC
 static int __alloc_gigantic_page(unsigned long start_pfn,
 				unsigned long nr_pages, gfp_t gfp_mask)
 {
@@ -1143,11 +1144,20 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
 static void prep_compound_gigantic_page(struct page *page, unsigned int order);
+#else /* !CONFIG_CONTIG_ALLOC */
+static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
+					int nid, nodemask_t *nodemask)
+{
+	return NULL;
+}
+#endif /* CONFIG_CONTIG_ALLOC */
 
 #else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
-static inline bool gigantic_page_supported(void) { return false; }
 static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nodemask) { return NULL; }
+					int nid, nodemask_t *nodemask)
+{
+	return NULL;
+}
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
 static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
@@ -1157,7 +1167,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_supported())
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
 	h->nr_huge_pages--;
@@ -2277,13 +2287,27 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 }
 
 #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
-static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
-						nodemask_t *nodes_allowed)
+static int set_max_huge_pages(struct hstate *h, unsigned long count,
+			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_supported())
-		return h->max_huge_pages;
+	spin_lock(&hugetlb_lock);
+
+	/*
+	 * Gigantic pages runtime allocation depend on the capability for large
+	 * page range allocation.
+	 * If the system does not provide this feature, return an error when
+	 * the user tries to allocate gigantic pages but let the user free the
+	 * boottime allocated gigantic pages.
+	 */
+	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
+		if (count > persistent_huge_pages(h)) {
+			spin_unlock(&hugetlb_lock);
+			return -EINVAL;
+		}
+		/* Fall through to decrease pool */
+	}
 
 	/*
 	 * Increase the pool size
@@ -2296,7 +2320,6 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
 	 * pool might be one hugepage larger than it needs to be, but
 	 * within all the constraints specified by the sysctls.
 	 */
-	spin_lock(&hugetlb_lock);
 	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, -1))
 			break;
@@ -2351,9 +2374,10 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
 			break;
 	}
 out:
-	ret = persistent_huge_pages(h);
+	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
-	return ret;
+
+	return 0;
 }
 
 #define HSTATE_ATTR_RO(_name) \
@@ -2405,7 +2429,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
 
-	if (hstate_is_gigantic(h) && !gigantic_page_supported()) {
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -2429,15 +2453,13 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	} else
 		nodes_allowed = &node_states[N_MEMORY];
 
-	h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
+	err = set_max_huge_pages(h, count, nodes_allowed);
 
+out:
 	if (nodes_allowed != &node_states[N_MEMORY])
 		NODEMASK_FREE(nodes_allowed);
 
-	return len;
-out:
-	NODEMASK_FREE(nodes_allowed);
-	return err;
+	return err ? err : len;
 }
 
 static ssize_t nr_hugepages_store_common(bool obey_mempolicy,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ecb115a74a9d..cad000879f14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8318,8 +8318,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 				pfn_max_align_up(end), migratetype);
 	return ret;
 }
+#endif /* CONFIG_CONTIG_ALLOC */
 
-void free_contig_range(unsigned long pfn, unsigned nr_pages)
+void free_contig_range(unsigned long pfn, unsigned int nr_pages)
 {
 	unsigned int count = 0;
 
@@ -8331,7 +8332,6 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
 	}
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
-#endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
