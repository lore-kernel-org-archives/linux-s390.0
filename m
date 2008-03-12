Return-Path: <linux-kernel-owner+w=401wt.eu-S1753985AbYCLN1h@vger.kernel.org>
Message-Id: <20080312132703.689828503@de.ibm.com>
References: <20080312132132.520833247@de.ibm.com>
Date: Wed, 12 Mar 2008 14:21:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/6] Guest page hinting: mlocked pages.
Content-Disposition: inline; filename=003-hva-mlock.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com, zach@vmware.com, frankeh@watson.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj

Add code to get mlock() working with guest page hinting. The problem
with mlock is that locked pages may not be removed from page cache.
That means they need to be stable. page_make_volatile needs a way to
check if a page has been locked. To avoid traversing vma lists - which
would hurt performance a lot - a field is added in the struct
address_space. This field is set in mlock_fixup if a vma gets mlocked.
The bit never gets removed - once a file had an mlocked vma all future
pages added to it will stay stable.

The pages of an mlocked area are made present in the linux page table by
a call to make_pages_present which calls get_user_pages and follow_page.
The follow_page function is called for each page in the mlocked vma,
if the VM_LOCKED bit in the vma flags is set the page is made stable.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/fs.h |   10 ++++++++++
 mm/memory.c        |    5 +++--
 mm/mlock.c         |    3 +++
 mm/page-states.c   |    5 ++++-
 mm/rmap.c          |   13 +++++++++++--
 5 files changed, 31 insertions(+), 5 deletions(-)

Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -513,6 +513,9 @@ struct address_space {
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+#ifdef CONFIG_PAGE_STATES
+	unsigned int		mlocked;	/* set if VM_LOCKED vmas present */
+#endif
 } __attribute__((aligned(sizeof(long))));
 	/*
 	 * On most architectures that alignment is already the case; but
@@ -520,6 +523,13 @@ struct address_space {
 	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
 	 */
 
+static inline void mapping_set_mlocked(struct address_space *mapping)
+{
+#ifdef CONFIG_PAGE_STATES
+	mapping->mlocked = 1;
+#endif
+}
+
 struct block_device {
 	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
 	struct inode *		bd_inode;	/* will die */
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -987,9 +987,10 @@ struct page *follow_page(struct vm_area_
 	if (flags & FOLL_GET)
 		get_page(page);
 
-	if (flags & FOLL_GET) {
+	if ((flags & FOLL_GET) || (vma->vm_flags & VM_LOCKED)) {
 		/*
-		 * The page is made stable if a reference is acquired.
+		 * The page is made stable if a reference is acquired or
+		 * the vm area is locked.
 		 * If the caller does not get a reference it implies that
 		 * the caller can deal with page faults in case the page
 		 * is swapped out. In this case the caller can deal with
Index: linux-2.6/mm/mlock.c
===================================================================
--- linux-2.6.orig/mm/mlock.c
+++ linux-2.6/mm/mlock.c
@@ -12,6 +12,7 @@
 #include <linux/syscalls.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/fs.h>
 
 int can_do_mlock(void)
 {
@@ -71,6 +72,8 @@ success:
 	 */
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
+		if (vma->vm_file && vma->vm_file->f_mapping)
+			mapping_set_mlocked(vma->vm_file->f_mapping);
 		pages = -pages;
 		if (!(newflags & VM_IO))
 			ret = make_pages_present(start, end);
Index: linux-2.6/mm/page-states.c
===================================================================
--- linux-2.6.orig/mm/page-states.c
+++ linux-2.6/mm/page-states.c
@@ -29,6 +29,8 @@
  */
 static inline int check_bits(struct page *page)
 {
+	struct address_space *mapping;
+
 	/*
 	 * There are several conditions that prevent a page from becoming
 	 * volatile. The first check is for the page bits.
@@ -52,7 +54,8 @@ static inline int check_bits(struct page
 	 * it volatile. It will be freed soon. And if the mapping ever
 	 * had locked pages all pages of the mapping will stay stable.
 	 */
-	return page_mapping(page) != NULL;
+	mapping = page_mapping(page);
+	return mapping && !mapping->mlocked;
 }
 
 /*
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -722,8 +722,17 @@ static int try_to_unmap_one(struct page 
 	 */
 	if (!migration && ((vma->vm_flags & VM_LOCKED) ||
 			(ptep_clear_flush_young(vma, address, pte)))) {
-		ret = SWAP_FAIL;
-		goto out_unmap;
+		/*
+		 * Check for discarded pages. This can happen if there have
+		 * been discarded pages before a vma gets mlocked. The code
+		 * in make_pages_present will force all discarded pages out
+		 * and reload them. That happens after the VM_LOCKED bit
+		 * has been set.
+		 */
+		if (likely(!PageDiscarded(page))) {
+			ret = SWAP_FAIL;
+			goto out_unmap;
+		}
 	}
 
 	/* Nuke the page table entry. */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
