Return-Path: <linux-kernel-owner+w=401wt.eu-S1761165AbYEFQEe@vger.kernel.org>
Message-Id: <20080506155112.820321745@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 8/8] guest page hinting light
Content-Disposition: inline; filename=008-cmm2-light.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Use the existing arch_alloc_page/arch_free_page callbacks to do
the guest page state transitions between stable and unused.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig          |    7 +++
 arch/s390/mm/Makefile      |    1 
 arch/s390/mm/init.c        |    3 +
 arch/s390/mm/page-states.c |   79 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/page.h    |   11 ++++++
 include/asm-s390/system.h  |    6 +++
 6 files changed, 107 insertions(+)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -430,6 +430,13 @@ config CMM_IUCV
 	  Select this option to enable the special message interface to
 	  the cooperative memory management.
 
+config PAGE_STATES
+	bool "Unused page notification"
+	help
+	  This enables the notification of unused pages to the
+	  hypervisor. The ESSA instruction is used to do the states
+	  changes between a page that has content and the unused state.
+
 config VIRT_TIMER
 	bool "Virtual CPU timer support"
 	help
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -126,6 +126,9 @@ void __init mem_init(void)
         /* clear the zero-page */
         memset(empty_zero_page, 0, PAGE_SIZE);
 
+	/* Setup guest page hinting */
+	cmma_init();
+
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
Index: quilt-2.6/arch/s390/mm/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/mm/Makefile
+++ quilt-2.6/arch/s390/mm/Makefile
@@ -5,3 +5,4 @@
 obj-y	 := init.o fault.o extmem.o mmap.o vmem.o pgtable.o
 obj-$(CONFIG_CMM) += cmm.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+obj-$(CONFIG_PAGE_STATES) += page-states.o
Index: quilt-2.6/arch/s390/mm/page-states.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/mm/page-states.c
@@ -0,0 +1,79 @@
+/*
+ * arch/s390/mm/page-states.c
+ *
+ * (C) Copyright IBM Corp. 2008
+ *
+ * Guest page hinting for unused pages.
+ *
+ * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#define ESSA_SET_STABLE		1
+#define ESSA_SET_UNUSED		2
+
+int cmma_flag;
+
+static int __init cmma(char *str)
+{
+	char *parm;
+	parm = strstrip(str);
+	if (strcmp(parm, "yes") == 0 || strcmp(parm, "on") == 0) {
+		cmma_flag = 1;
+		return 1;
+	}
+	cmma_flag = 0;
+	if (strcmp(parm, "no") == 0 || strcmp(parm, "off") == 0)
+		return 1;
+	return 0;
+}
+
+__setup("cmma=", cmma);
+
+void __init cmma_init(void)
+{
+	register unsigned long tmp asm("0") = 0;
+	register int rc asm("1") = -ENOSYS;
+
+	if (!cmma_flag)
+		return;
+	asm volatile(
+		"       .insn rrf,0xb9ab0000,%1,%1,0,0\n"
+		"0:     la      %0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "+&d" (rc), "+&d" (tmp));
+	if (rc)
+		cmma_flag = 0;
+}
+
+void arch_free_page(struct page *page, int order)
+{
+	int i, rc;
+
+	if (!cmma_flag)
+		return;
+	for (i = 0; i < (1 << order); i++)
+		asm volatile(".insn rrf,0xb9ab0000,%0,%1,%2,0"
+			     : "=&d" (rc)
+			     : "a" ((page_to_pfn(page) + i) << PAGE_SHIFT),
+			       "i" (ESSA_SET_UNUSED));
+}
+
+void arch_alloc_page(struct page *page, int order)
+{
+	int i, rc;
+
+	if (!cmma_flag)
+		return;
+	for (i = 0; i < (1 << order); i++)
+		asm volatile(".insn rrf,0xb9ab0000,%0,%1,%2,0"
+			     : "=&d" (rc)
+			     : "a" ((page_to_pfn(page) + i) << PAGE_SHIFT),
+			       "i" (ESSA_SET_STABLE));
+}
Index: quilt-2.6/include/asm-s390/page.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/page.h
+++ quilt-2.6/include/asm-s390/page.h
@@ -125,6 +125,17 @@ page_get_storage_key(unsigned long addr)
 	return skey;
 }
 
+#ifdef CONFIG_PAGE_STATES
+
+struct page;
+void arch_free_page(struct page *page, int order);
+void arch_alloc_page(struct page *page, int order);
+
+#define HAVE_ARCH_FREE_PAGE
+#define HAVE_ARCH_ALLOC_PAGE
+
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
Index: quilt-2.6/include/asm-s390/system.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/system.h
+++ quilt-2.6/include/asm-s390/system.h
@@ -116,6 +116,12 @@ extern void pfault_fini(void);
 #define pfault_fini()		do { } while (0)
 #endif /* CONFIG_PFAULT */
 
+#ifdef CONFIG_PAGE_STATES
+extern void cmma_init(void);
+#else
+#define cmma_init()		do { } while (0)
+#endif
+
 #define finish_arch_switch(prev) do {					     \
 	set_fs(current->thread.mm_segment);				     \
 	account_vtime(prev);						     \

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
