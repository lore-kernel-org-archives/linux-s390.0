Return-Path: <linux-kernel-owner+w=401wt.eu-S1754384AbYCLN2d@vger.kernel.org>
Message-Id: <20080312132703.979194690@de.ibm.com>
References: <20080312132132.520833247@de.ibm.com>
Date: Wed, 12 Mar 2008 14:21:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/6] Guest page hinting: writable page table entries.
Content-Disposition: inline; filename=004-hva-prot.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com, zach@vmware.com, frankeh@watson.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj

The volatile state for page cache and swap cache pages requires that
the host system needs to be able to determine if a volatile page is
dirty before removing it. This excludes almost all platforms from using
the scheme. What is needed is a way to distinguish between pages that
are purely read-only and pages that might get written to. This allows
platforms with per-pte dirty bits to use the scheme and platforms with
per-page dirty bits a small optimization.

Whenever a writable pte is created a check is added that allows to
move the page into the correct state. This needs to be done before
the writable pte is established. To avoid unnecessary state transitions
and the need for a counter, a new page flag PG_writable is added. Only
the creation of the first writable pte will do a page state change.
Even if all the writable ptes pointing to a page are removed again,
the page stays in the safe state until all read-only users of the page
have unmapped it as well. Only then is the PG_writable bit reset.

The state a page needs to have if a writable pte is present depends
on the platform. A platform with per-pte dirty bits wants to move the
page into stable state, a platform with per-page dirty bits like s390
can decide to move the page into a special state that requires the host
system to check the dirty bit before discarding a page.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 fs/exec.c                   |    1 
 include/linux/page-flags.h  |    6 ++++
 include/linux/page-states.h |   27 +++++++++++++++++++-
 mm/memory.c                 |    5 +++
 mm/mprotect.c               |    2 +
 mm/page-states.c            |   58 ++++++++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.c             |    3 +-
 mm/rmap.c                   |    1 
 8 files changed, 99 insertions(+), 4 deletions(-)

Index: linux-2.6/fs/exec.c
===================================================================
--- linux-2.6.orig/fs/exec.c
+++ linux-2.6/fs/exec.c
@@ -51,6 +51,7 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
+#include <linux/page-states.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -109,6 +109,7 @@
 #endif
 
 #define PG_discarded		20	/* Page discarded by the hypervisor. */
+#define PG_writable		21	/* Page is mapped writable. */
 
 /*
  * Manipulation of page state flags
@@ -309,6 +310,11 @@ static inline void __ClearPageTail(struc
 #define TestSetPageDiscarded(page)	0
 #endif
 
+#define PageWritable(page) test_bit(PG_writable, &(page)->flags)
+#define TestSetPageWritable(page) \
+		test_and_set_bit(PG_writable, &(page)->flags)
+#define ClearPageWritable(page) clear_bit(PG_writable, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 extern void cancel_dirty_page(struct page *page, unsigned int account_size);
Index: linux-2.6/include/linux/page-states.h
===================================================================
--- linux-2.6.orig/include/linux/page-states.h
+++ linux-2.6/include/linux/page-states.h
@@ -57,6 +57,9 @@ extern void page_discard(struct page *pa
 extern int  __page_make_stable(struct page *page);
 extern void __page_make_volatile(struct page *page, int offset);
 extern void __pagevec_make_volatile(struct pagevec *pvec);
+extern void __page_check_writable(struct page *page, pte_t pte,
+				  unsigned int offset);
+extern void __page_reset_writable(struct page *page);
 
 /*
  * Extended guest page hinting functions defined by using the
@@ -78,6 +81,12 @@ extern void __pagevec_make_volatile(stru
  *     from the LRU list and the radix tree of its mapping.
  *     page_discard uses page_unmap_all to remove all page table
  *     entries for a page.
+ * - page_check_writable:
+ *     Checks if the page states needs to be adapted because a new
+ *     writable page table entry refering to the page is established.
+ * - page_reset_writable:
+ *     Resets the page state after the last writable page table entry
+ *     refering to the page has been removed.
  */
 
 static inline int page_make_stable(struct page *page)
@@ -97,12 +106,26 @@ static inline void pagevec_make_volatile
 		__pagevec_make_volatile(pvec);
 }
 
+static inline void page_check_writable(struct page *page, pte_t pte,
+				       unsigned int offset)
+{
+	if (page_host_discards() && pte_write(pte) &&
+	    !test_bit(PG_writable, &page->flags))
+		__page_check_writable(page, pte, offset);
+}
+
+static inline void page_reset_writable(struct page *page)
+{
+	if (page_host_discards() && test_bit(PG_writable, &page->flags))
+		__page_reset_writable(page);
+}
+
 #else
 
 #define page_host_discards()			(0)
 #define page_set_unused(_page,_order)		do { } while (0)
 #define page_set_stable(_page,_order)		do { } while (0)
-#define page_set_volatile(_page)		do { } while (0)
+#define page_set_volatile(_page,_writable)	do { } while (0)
 #define page_set_stable_if_present(_page)	(1)
 #define page_discarded(_page)			(0)
 #define page_volatile(_page)			(0)
@@ -117,6 +140,8 @@ static inline void pagevec_make_volatile
 #define page_make_volatile(_page, offset)	do { } while (0)
 #define pagevec_make_volatile(_pagevec)	do { } while (0)
 #define page_discard(_page)			do { } while (0)
+#define page_check_writable(_page,_pte,_off)	do { } while (0)
+#define page_reset_writable(_page)		do { } while (0)
 
 #endif
 
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -1681,6 +1681,7 @@ static int do_wp_page(struct mm_struct *
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = pte_mkyoung(orig_pte);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		page_check_writable(old_page, entry, 1);
 		if (ptep_set_access_flags(vma, address, page_table, entry,1))
 			update_mmu_cache(vma, address, entry);
 		ret |= VM_FAULT_WRITE;
@@ -1728,6 +1729,7 @@ gotten:
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		page_check_writable(new_page, entry, 2);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
 		 * pte with the new entry. This will avoid a race condition
@@ -2147,6 +2149,7 @@ static int do_swap_page(struct mm_struct
 	}
 
 	flush_icache_page(vma, page);
+	page_check_writable(page, pte, 2);
 	set_pte_at(mm, address, page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
@@ -2204,6 +2207,7 @@ static int do_anonymous_page(struct mm_s
 
 	entry = mk_pte(page, vma->vm_page_prot);
 	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	page_check_writable(page, entry, 2);
 
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!pte_none(*page_table))
@@ -2365,6 +2369,7 @@ retry:
 		entry = mk_pte(page, vma->vm_page_prot);
 		if (flags & FAULT_FLAG_WRITE)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		page_check_writable(page, entry, 2);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
                         inc_mm_counter(mm, anon_rss);
Index: linux-2.6/mm/mprotect.c
===================================================================
--- linux-2.6.orig/mm/mprotect.c
+++ linux-2.6/mm/mprotect.c
@@ -21,6 +21,7 @@
 #include <linux/syscalls.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/page-states.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
@@ -52,6 +53,7 @@ static void change_pte_range(struct mm_s
 			 */
 			if (dirty_accountable && pte_dirty(ptent))
 				ptent = pte_mkwrite(ptent);
+			page_check_writable(pte_page(ptent), ptent, 1);
 			set_pte_at(mm, addr, pte, ptent);
 #ifdef CONFIG_MIGRATION
 		} else if (!pte_file(oldpte)) {
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -637,7 +637,8 @@ static int prep_new_page(struct page *pa
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_readahead |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_owner_priv_1 | 1 << PG_mappedtodisk);
+			1 << PG_owner_priv_1 | 1 << PG_mappedtodisk |
+			1 << PG_writable);
 	set_page_private(page, 0);
 	set_page_refcounted(page);
 
Index: linux-2.6/mm/page-states.c
===================================================================
--- linux-2.6.orig/mm/page-states.c
+++ linux-2.6/mm/page-states.c
@@ -82,7 +82,7 @@ void __page_make_volatile(struct page *p
 	preempt_disable();
 	if (!page_test_set_state_change(page)) {
 		if (check_bits(page) && check_counts(page, offset))
-			page_set_volatile(page);
+			page_set_volatile(page, PageWritable(page));
 		page_clear_state_change(page);
 	}
 	preempt_enable();
@@ -108,7 +108,7 @@ void __pagevec_make_volatile(struct page
 		page = pvec->pages[i];
 		if (!page_test_set_state_change(page)) {
 			if (check_bits(page) && check_counts(page, 1))
-				page_set_volatile(page);
+				page_set_volatile(page, PageWritable(page));
 			page_clear_state_change(page);
 		}
 	}
@@ -141,6 +141,60 @@ int __page_make_stable(struct page *page
 EXPORT_SYMBOL(__page_make_stable);
 
 /**
+ * __page_check_writable() - check page state for new writable pte
+ *
+ * @page: the page the new writable pte refers to
+ * @pte: the new writable pte
+ */
+void __page_check_writable(struct page *page, pte_t pte, unsigned int offset)
+{
+	int count_ok = 0;
+
+	preempt_disable();
+	while (page_test_set_state_change(page))
+		cpu_relax();
+
+	if (!TestSetPageWritable(page)) {
+		count_ok = check_counts(page, offset);
+		if (check_bits(page) && count_ok)
+			page_set_volatile(page, 1);
+		else
+			/*
+			 * If two processes create a write mapping at the
+			 * same time check_counts will return false or if
+			 * the page is currently isolated from the LRU
+			 * check_bits will return false but the page might
+			 * be in volatile state.
+			 * We have to take care about the dirty bit so the
+			 * only option left is to make the page stable but
+			 * we can try to make it volatile a bit later.
+			 */
+			page_set_stable_if_present(page);
+	}
+	page_clear_state_change(page);
+	if (!count_ok)
+		page_make_volatile(page, 1);
+	preempt_enable();
+}
+EXPORT_SYMBOL(__page_check_writable);
+
+/**
+ * __page_reset_writable() - clear the PageWritable bit
+ *
+ * @page: the page
+ */
+void __page_reset_writable(struct page *page)
+{
+	preempt_disable();
+	if (!page_test_set_state_change(page)) {
+		ClearPageWritable(page);
+		page_clear_state_change(page);
+	}
+	preempt_enable();
+}
+EXPORT_SYMBOL(__page_reset_writable);
+
+/**
  * __page_discard() - remove a discarded page from the cache
  *
  * @page: the page
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -695,6 +695,7 @@ void page_remove_rmap(struct page *page,
 
 		__dec_zone_page_state(page,
 				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
+		page_reset_writable(page);
 	}
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
