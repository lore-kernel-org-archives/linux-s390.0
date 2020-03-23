Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727011AbgCWSMy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Mar 2020 14:12:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NI2flh034404
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2020 14:12:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf0n4t68-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2020 14:12:53 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 23 Mar 2020 18:12:50 -0000
Date: Mon, 23 Mar 2020 19:12:45 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: s390: removal of hibernate support
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20200323181245.GJ4288@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pm@vger.kernel.org

Hi Rafael,

we are going to remove hibernate support on s390, since it is
- broken since many years
- there is no real use case which justifies keeping and maintaining
  the code

See also https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=394216275c7d503d966317da9a01ad6626a6091d

This in turn allows also to remove s390 specific hooks in generic
power management code (see patch below). The patch below is currently
also on the same features branch.
I silently assume(d) that you don't mind to get rid of otherwise dead
code, or do you have any objections?

From 086b2d78375cffe58f5341359bebec0650793811 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 18 Mar 2020 20:55:20 +0100
Subject: [PATCH] PM: remove s390 specific callbacks

ARCH_SAVE_PAGE_KEYS has been introduced in order to be able to save
and restore s390 specific storage keys into a hibernation image.
With hibernation support removed from s390 there is no point in
keeping the callbacks.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 include/linux/suspend.h | 34 ----------------------------------
 kernel/power/Kconfig    |  3 ---
 kernel/power/snapshot.c | 18 ------------------
 3 files changed, 55 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 2b2055b035ee..4fcc6fd0cbd6 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -566,38 +566,4 @@ static inline void queue_up_suspend_work(void) {}
 
 #endif /* !CONFIG_PM_AUTOSLEEP */
 
-#ifdef CONFIG_ARCH_SAVE_PAGE_KEYS
-/*
- * The ARCH_SAVE_PAGE_KEYS functions can be used by an architecture
- * to save/restore additional information to/from the array of page
- * frame numbers in the hibernation image. For s390 this is used to
- * save and restore the storage key for each page that is included
- * in the hibernation image.
- */
-unsigned long page_key_additional_pages(unsigned long pages);
-int page_key_alloc(unsigned long pages);
-void page_key_free(void);
-void page_key_read(unsigned long *pfn);
-void page_key_memorize(unsigned long *pfn);
-void page_key_write(void *address);
-
-#else /* !CONFIG_ARCH_SAVE_PAGE_KEYS */
-
-static inline unsigned long page_key_additional_pages(unsigned long pages)
-{
-	return 0;
-}
-
-static inline int  page_key_alloc(unsigned long pages)
-{
-	return 0;
-}
-
-static inline void page_key_free(void) {}
-static inline void page_key_read(unsigned long *pfn) {}
-static inline void page_key_memorize(unsigned long *pfn) {}
-static inline void page_key_write(void *address) {}
-
-#endif /* !CONFIG_ARCH_SAVE_PAGE_KEYS */
-
 #endif /* _LINUX_SUSPEND_H */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 7cbfbeacd68a..c208566c844b 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -80,9 +80,6 @@ config HIBERNATION
 
 	  For more information take a look at <file:Documentation/power/swsusp.rst>.
 
-config ARCH_SAVE_PAGE_KEYS
-	bool
-
 config PM_STD_PARTITION
 	string "Default resume partition"
 	depends on HIBERNATION
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index ddade80ad276..e99d13b0b8fc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1744,9 +1744,6 @@ int hibernate_preallocate_memory(void)
 	count += highmem;
 	count -= totalreserve_pages;
 
-	/* Add number of pages required for page keys (s390 only). */
-	size += page_key_additional_pages(saveable);
-
 	/* Compute the maximum number of saveable pages to leave in memory. */
 	max_size = (count - (size + PAGES_FOR_IO)) / 2
 			- 2 * DIV_ROUND_UP(reserved_size, PAGE_SIZE);
@@ -2075,8 +2072,6 @@ static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
 		buf[j] = memory_bm_next_pfn(bm);
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
-		/* Save page key for data page (s390 only). */
-		page_key_read(buf + j);
 	}
 }
 
@@ -2226,9 +2221,6 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
 
-		/* Extract and buffer page key for data page (s390 only). */
-		page_key_memorize(buf + j);
-
 		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
 			memory_bm_set_bit(bm, buf[j]);
 		else
@@ -2623,11 +2615,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 		if (error)
 			return error;
 
-		/* Allocate buffer for page keys. */
-		error = page_key_alloc(nr_copy_pages);
-		if (error)
-			return error;
-
 		hibernate_restore_protection_begin();
 	} else if (handle->cur <= nr_meta_pages + 1) {
 		error = unpack_orig_pfns(buffer, &copy_bm);
@@ -2649,8 +2636,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 		}
 	} else {
 		copy_last_highmem_page();
-		/* Restore page key for data page (s390 only). */
-		page_key_write(handle->buffer);
 		hibernate_restore_protect_page(handle->buffer);
 		handle->buffer = get_buffer(&orig_bm, &ca);
 		if (IS_ERR(handle->buffer))
@@ -2673,9 +2658,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 void snapshot_write_finalize(struct snapshot_handle *handle)
 {
 	copy_last_highmem_page();
-	/* Restore page key for data page (s390 only). */
-	page_key_write(handle->buffer);
-	page_key_free();
 	hibernate_restore_protect_page(handle->buffer);
 	/* Do that only if we have loaded the image entirely */
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages) {
-- 
2.17.1
