Return-Path: <linux-kernel-owner+w=401wt.eu-S1755555AbYE2NBX@vger.kernel.org>
Message-Id: <20080529125729.607377419@de.ibm.com>
References: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/11] showmem: Only walk spanned pages.
Content-Disposition: inline; filename=006-showmem.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert show_mem() so its nearly the same as on x86/powerpc.
Gives us proper locking and we get also rid of the only use of max_mapnr.
Also the number of pages was contained in an int which might not be
sufficient not too far in the future.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/init.c |   42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -44,30 +44,34 @@ char  empty_zero_page[PAGE_SIZE] __attri
 
 void show_mem(void)
 {
-	int i, total = 0, reserved = 0;
-	int shared = 0, cached = 0;
+	unsigned long i, total = 0, reserved = 0;
+	unsigned long shared = 0, cached = 0;
+	unsigned long flags;
 	struct page *page;
+	pg_data_t *pgdat;
 
 	printk("Mem-info:\n");
 	show_free_areas();
-	i = max_mapnr;
-	while (i-- > 0) {
-		if (!pfn_valid(i))
-			continue;
-		page = pfn_to_page(i);
-		total++;
-		if (PageReserved(page))
-			reserved++;
-		else if (PageSwapCache(page))
-			cached++;
-		else if (page_count(page))
-			shared += page_count(page) - 1;
+	for_each_online_pgdat(pgdat) {
+		pgdat_resize_lock(pgdat, &flags);
+		for (i = 0; i < pgdat->node_spanned_pages; i++) {
+			if (!pfn_valid(pgdat->node_start_pfn + i))
+				continue;
+			page = pfn_to_page(pgdat->node_start_pfn + i);
+			total++;
+			if (PageReserved(page))
+				reserved++;
+			else if (PageSwapCache(page))
+				cached++;
+			else if (page_count(page))
+				shared += page_count(page) - 1;
+		}
+		pgdat_resize_unlock(pgdat, &flags);
 	}
-	printk("%d pages of RAM\n", total);
-	printk("%d reserved pages\n", reserved);
-	printk("%d pages shared\n", shared);
-	printk("%d pages swap cached\n", cached);
-
+	printk("%ld pages of RAM\n", total);
+	printk("%ld reserved pages\n", reserved);
+	printk("%ld pages shared\n", shared);
+	printk("%ld pages swap cached\n", cached);
 	printk("%lu pages dirty\n", global_page_state(NR_FILE_DIRTY));
 	printk("%lu pages writeback\n", global_page_state(NR_WRITEBACK));
 	printk("%lu pages mapped\n", global_page_state(NR_FILE_MAPPED));

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
