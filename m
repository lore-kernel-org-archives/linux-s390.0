Return-Path: <linux-kernel-owner+w=401wt.eu-S964900AbXG0Lfo@vger.kernel.org>
Message-Id: <20070727113627.488693533@de.ibm.com>
References: <20070727113348.413110503@de.ibm.com>
Date: Fri, 27 Jul 2007 13:33:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/6] Fix sclp_vt220 error handling.
Content-Disposition: inline; filename=015-sclp-vt220.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Also convert to slab_is_available() as an indicator if
get_zeroed_page() will work or not.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_vt220.c |   61 ++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 21 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -621,10 +621,24 @@ sclp_vt220_flush_buffer(struct tty_struc
 /*
  * Initialize all relevant components and register driver with system.
  */
-static int __init_refok __sclp_vt220_init(int early)
+static void __init __sclp_vt220_cleanup(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_vt220_empty) {
+		list_del(page);
+		if (slab_is_available())
+			free_page((unsigned long) page);
+		else
+			free_bootmem((unsigned long) page, PAGE_SIZE);
+	}
+}
+
+static int __init __sclp_vt220_init(void)
 {
 	void *page;
 	int i;
+	int num_pages;
 
 	if (sclp_vt220_initialized)
 		return 0;
@@ -641,13 +655,16 @@ static int __init_refok __sclp_vt220_ini
 	sclp_vt220_flush_later = 0;
 
 	/* Allocate pages for output buffering */
-	for (i = 0; i < (early ? MAX_CONSOLE_PAGES : MAX_KMEM_PAGES); i++) {
-		if (early)
-			page = alloc_bootmem_low_pages(PAGE_SIZE);
-		else
+	num_pages = slab_is_available() ? MAX_KMEM_PAGES : MAX_CONSOLE_PAGES;
+	for (i = 0; i < num_pages; i++) {
+		if (slab_is_available())
 			page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
-		if (!page)
+		else
+			page = alloc_bootmem_low_pages(PAGE_SIZE);
+		if (!page) {
+			__sclp_vt220_cleanup();
 			return -ENOMEM;
+		}
 		list_add_tail((struct list_head *) page, &sclp_vt220_empty);
 	}
 	return 0;
@@ -661,14 +678,13 @@ static const struct tty_operations sclp_
 	.flush_chars = sclp_vt220_flush_chars,
 	.write_room = sclp_vt220_write_room,
 	.chars_in_buffer = sclp_vt220_chars_in_buffer,
-	.flush_buffer = sclp_vt220_flush_buffer
+	.flush_buffer = sclp_vt220_flush_buffer,
 };
 
 /*
  * Register driver with SCLP and Linux and initialize internal tty structures.
  */
-static int __init
-sclp_vt220_tty_init(void)
+static int __init sclp_vt220_tty_init(void)
 {
 	struct tty_driver *driver;
 	int rc;
@@ -678,18 +694,15 @@ sclp_vt220_tty_init(void)
 	driver = alloc_tty_driver(1);
 	if (!driver)
 		return -ENOMEM;
-	rc = __sclp_vt220_init(0);
-	if (rc) {
-		put_tty_driver(driver);
-		return rc;
-	}
+	rc = __sclp_vt220_init();
+	if (rc)
+		goto out_driver;
 	rc = sclp_register(&sclp_vt220_register);
 	if (rc) {
 		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
 		       "could not register tty - "
 		       "sclp_register returned %d\n", rc);
-		put_tty_driver(driver);
-		return rc;
+		goto out_init;
 	}
 
 	driver->owner = THIS_MODULE;
@@ -708,14 +721,20 @@ sclp_vt220_tty_init(void)
 		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
 		       "could not register tty - "
 		       "tty_register_driver returned %d\n", rc);
-		put_tty_driver(driver);
-		return rc;
+		goto out_sclp;
 	}
 	sclp_vt220_driver = driver;
 	return 0;
-}
 
-module_init(sclp_vt220_tty_init);
+out_sclp:
+	sclp_unregister(&sclp_vt220_register);
+out_init:
+	__sclp_vt220_cleanup();
+out_driver:
+	put_tty_driver(driver);
+	return rc;
+}
+__initcall(sclp_vt220_tty_init);
 
 #ifdef CONFIG_SCLP_VT220_CONSOLE
 
@@ -761,7 +780,7 @@ sclp_vt220_con_init(void)
 
 	if (!CONSOLE_IS_SCLP)
 		return 0;
-	rc = __sclp_vt220_init(1);
+	rc = __sclp_vt220_init();
 	if (rc)
 		return rc;
 	/* Attach linux console */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
