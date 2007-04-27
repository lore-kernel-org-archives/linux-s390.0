Return-Path: <linux-kernel-owner+w=401wt.eu-S1755933AbXD0OJk@vger.kernel.org>
Message-Id: <20070427140519.911265225@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 34/38] split page_test_and_clear_dirty.
Content-Disposition: inline; filename=137-test-clear-dirty.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The page_test_and_clear_dirty primitive really consists of two
operations, page_test_dirty and the page_clear_dirty. The combination
of the two is not an atomic operation, so it makes more sense to have
two separate operations instead of one.
In addition to the improved readability of the s390 version of
SetPageUptodate, it now avoids the page_test_dirty operation which is
an insert-storage-key-extended (iske) instruction which is an expensive
operation.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-generic/pgtable.h |   11 +++++++++--
 include/asm-s390/pgtable.h    |   15 ++++++++-------
 include/linux/page-flags.h    |    2 +-
 mm/rmap.c                     |    8 ++++++--
 4 files changed, 24 insertions(+), 12 deletions(-)

Index: quilt-2.6/include/asm-generic/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-generic/pgtable.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-generic/pgtable.h	2007-04-27 16:05:01.000000000 +0200
@@ -139,8 +139,15 @@
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 #endif
 
-#ifndef __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
-#define page_test_and_clear_dirty(page) (0)
+#ifndef __HAVE_ARCH_PAGE_TEST_DIRTY
+#define page_test_dirty(page)		(0)
+#endif
+
+#ifndef __HAVE_ARCH_PAGE_CLEAR_DIRTY
+#define page_clear_dirty(page)		do { } while (0)
+#endif
+
+#ifndef __HAVE_ARCH_PAGE_TEST_DIRTY
 #define pte_maybe_dirty(pte)		pte_dirty(pte)
 #else
 #define pte_maybe_dirty(pte)		(1)
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/pgtable.h	2007-04-27 16:05:01.000000000 +0200
@@ -753,14 +753,14 @@
  * should therefore only be called if it is not mapped in any
  * address space.
  */
-static inline int page_test_and_clear_dirty(struct page *page)
+static inline int page_test_dirty(struct page *page)
 {
-	unsigned long physpage = page_to_phys(page);
-	int skey = page_get_storage_key(physpage);
+	return (page_get_storage_key(page_to_phys(page)) & _PAGE_CHANGED) != 0;
+}
 
-	if (skey & _PAGE_CHANGED)
-		page_set_storage_key(physpage, skey & ~_PAGE_CHANGED);
-	return skey & _PAGE_CHANGED;
+static inline void page_clear_dirty(struct page *page)
+{
+	page_set_storage_key(page_to_phys(page), PAGE_DEFAULT_KEY);
 }
 
 /*
@@ -953,7 +953,8 @@
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
-#define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
+#define __HAVE_ARCH_PAGE_TEST_DIRTY
+#define __HAVE_ARCH_PAGE_CLEAR_DIRTY
 #define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_YOUNG
 #include <asm-generic/pgtable.h>
 
Index: quilt-2.6/include/linux/page-flags.h
===================================================================
--- quilt-2.6.orig/include/linux/page-flags.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/linux/page-flags.h	2007-04-27 16:05:01.000000000 +0200
@@ -133,7 +133,7 @@
 static inline void SetPageUptodate(struct page *page)
 {
 	if (!test_and_set_bit(PG_uptodate, &page->flags))
-		page_test_and_clear_dirty(page);
+		page_clear_dirty(page);
 }
 #else
 #define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
Index: quilt-2.6/mm/rmap.c
===================================================================
--- quilt-2.6.orig/mm/rmap.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/mm/rmap.c	2007-04-27 16:05:01.000000000 +0200
@@ -498,8 +498,10 @@
 		struct address_space *mapping = page_mapping(page);
 		if (mapping)
 			ret = page_mkclean_file(mapping, page);
-		if (page_test_and_clear_dirty(page))
+		if (page_test_dirty(page)) {
+			page_clear_dirty(page);
 			ret = 1;
+		}
 	}
 
 	return ret;
@@ -605,8 +607,10 @@
 		 * Leaving it set also helps swapoff to reinstate ptes
 		 * faster for those pages still in swapcache.
 		 */
-		if (page_test_and_clear_dirty(page))
+		if (page_test_dirty(page)) {
+			page_clear_dirty(page);
 			set_page_dirty(page);
+		}
 		__dec_zone_page_state(page,
 				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
