Return-Path: <linux-kernel-owner+w=401wt.eu-S965370AbXLTP1l@vger.kernel.org>
Message-Id: <20071220152108.340182373@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/47] DEBUG_PAGEALLOC support for s390.
Content-Disposition: inline; filename=123-debug-pagealloc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig.debug       |    8 ++++++++
 arch/s390/defconfig           |    1 +
 arch/s390/kernel/traps.c      |    5 ++++-
 arch/s390/mm/init.c           |   27 +++++++++++++++++++++++++++
 include/asm-s390/cacheflush.h |    4 ++++
 5 files changed, 44 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig
+++ quilt-2.6/arch/s390/defconfig
@@ -727,6 +727,7 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_LKDTM is not set
 # CONFIG_FAULT_INJECTION is not set
 CONFIG_SAMPLES=y
+# CONFIG_DEBUG_PAGEALLOC is not set
 
 #
 # Security options
Index: quilt-2.6/arch/s390/Kconfig.debug
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig.debug
+++ quilt-2.6/arch/s390/Kconfig.debug
@@ -6,4 +6,12 @@ config TRACE_IRQFLAGS_SUPPORT
 
 source "lib/Kconfig.debug"
 
+config DEBUG_PAGEALLOC
+	bool "Debug page memory allocations"
+	depends on DEBUG_KERNEL
+	help
+	  Unmap pages from the kernel linear mapping after free_pages().
+	  This results in a slowdown, but helps to find certain types of
+	  memory corruptions.
+
 endmenu
Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -271,7 +271,10 @@ void die(const char * str, struct pt_reg
 	printk("PREEMPT ");
 #endif
 #ifdef CONFIG_SMP
-	printk("SMP");
+	printk("SMP ");
+#endif
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	printk("DEBUG_PAGEALLOC");
 #endif
 	printk("\n");
 	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV);
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -167,6 +167,33 @@ void __init mem_init(void)
 	       PFN_ALIGN((unsigned long)&_eshared) - 1);
 }
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+void kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long address;
+	int i;
+
+	for (i = 0; i < numpages; i++) {
+		address = page_to_phys(page + i);
+		pgd = pgd_offset_k(address);
+		pud = pud_offset(pgd, address);
+		pmd = pmd_offset(pud, address);
+		pte = pte_offset_kernel(pmd, address);
+		if (!enable) {
+			ptep_invalidate(address, pte);
+			continue;
+		}
+		*pte = mk_pte_phys(address, __pgprot(_PAGE_TYPE_RW));
+		/* Flush cpu write queue. */
+		mb();
+	}
+}
+#endif
+
 void free_initmem(void)
 {
         unsigned long addr;
Index: quilt-2.6/include/asm-s390/cacheflush.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cacheflush.h
+++ quilt-2.6/include/asm-s390/cacheflush.h
@@ -24,4 +24,8 @@
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	memcpy(dst, src, len)
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+void kernel_map_pages(struct page *page, int numpages, int enable);
+#endif
+
 #endif /* _S390_CACHEFLUSH_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
