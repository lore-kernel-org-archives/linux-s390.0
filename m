Return-Path: <linux-kernel-owner+w=401wt.eu-S1764841AbYEFPor@vger.kernel.org>
Subject: Re: [patch 0/6] Guest page hinting version 6.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.64.0803131627450.17244@blonde.site>
References: <20080312132132.520833247@de.ibm.com>
	 <Pine.LNX.4.64.0803131627450.17244@blonde.site>
Content-Type: text/plain
Date: Tue, 06 May 2008 17:33:02 +0200
Message-Id: <1210087982.31803.32.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, zach@vmware.com, frankeh@watson.ibm.com, rusty@rustcorp.com.au, jeremy@goop.org, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-03-13 at 16:57 +0000, Hugh Dickins wrote:
> It's very encouraging to see Jeremy and Rusty weighing in.  I hope
> Zach will too, and I've added Andrea: their support would count a lot.
> You have Nick on the list, good, I've added Christoph and Peter
> (if you do resend, linux-mm might prove more useful than linux-kernel).
> 
> With support from rival virtualizers,
> I do think you've a good chance of getting in.

Traffic on the guest page hinting patches died down again. Until another
user shows up I guess that's it for the full version. In the meantime I
push the patch below which is the poor mans version that can be done
without common code change. It uses the arch_alloc_page/arch_free_page
hooks to do the stable/unused state transitions. Better than nothing ..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---
Subject: [PATCH] guest page hinting light

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

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2008-05-06 17:38:14.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2008-05-06 17:38:28.000000000 +0200
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
diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2008-05-06 17:38:14.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/init.c	2008-05-06 17:38:28.000000000 +0200
@@ -126,6 +126,9 @@ void __init mem_init(void)
         /* clear the zero-page */
         memset(empty_zero_page, 0, PAGE_SIZE);
 
+	/* Setup guest page hinting */
+	cmma_init();
+
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
diff -urpN linux-2.6/arch/s390/mm/Makefile linux-2.6-patched/arch/s390/mm/Makefile
--- linux-2.6/arch/s390/mm/Makefile	2008-05-06 17:38:14.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/Makefile	2008-05-06 17:38:28.000000000 +0200
@@ -5,3 +5,4 @@
 obj-y	 := init.o fault.o extmem.o mmap.o vmem.o pgtable.o
 obj-$(CONFIG_CMM) += cmm.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+obj-$(CONFIG_PAGE_STATES) += page-states.o
diff -urpN linux-2.6/arch/s390/mm/page-states.c linux-2.6-patched/arch/s390/mm/page-states.c
--- linux-2.6/arch/s390/mm/page-states.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/page-states.c	2008-05-06 17:38:28.000000000 +0200
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
diff -urpN linux-2.6/include/asm-s390/page.h linux-2.6-patched/include/asm-s390/page.h
--- linux-2.6/include/asm-s390/page.h	2008-05-06 17:38:17.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/page.h	2008-05-06 17:38:28.000000000 +0200
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
diff -urpN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2008-05-06 17:38:17.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/system.h	2008-05-06 17:38:28.000000000 +0200
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
