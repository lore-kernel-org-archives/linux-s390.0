Return-Path: <linux-kernel-owner+w=401wt.eu-S1757847AbYBIMGQ@vger.kernel.org>
Message-Id: <20080209120310.858243859@de.ibm.com>
References: <20080209120157.885371603@de.ibm.com>
Date: Sat, 09 Feb 2008 13:02:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/11] sclp_vt220: Fix vt220 initialization
Content-Disposition: inline; filename=007-vt220.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

There are two problems in the vt220 intialization:

o Currently the vt220 console looses early printk events until the
  the vt220 tty is registered.
o console should work if tty_register fails

sclp_vt220_con_init calls __sclp_vt220_init and register_console.
It does not register the driver with the sclp core code via
sclp_register. That results in an sclp_send_mask=0. Therefore,
__sclp_vt220_emit will reject buffers with EIO. Unfortunately
register_console will cause the printk buffer to be sent to the
console and, therefore, every early message gets dropped. The
sclp_send_mask is set later during boot, when sclp_vt220_tty_init
calls sclp_register.

The solution is to move the sclp_register call from sclp_vt220_tty_init
to __sclp_vt220_init. This makes sure that the console is properly
registered with the sclp subsystem before the first log buffer messages
are passed to the vt220 console.

We also adopt the cleanup on error to keep the console alive if
tty_register fails.

Thanks to Peter Oberparleiter and Heiko Carstens for review and ideas
for improvement.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_vt220.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -3,7 +3,7 @@
  *    SCLP VT220 terminal driver.
  *
  *  S390 version
- *    Copyright (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright IBM Corp. 2003,2008
  *    Author(s): Peter Oberparleiter <Peter.Oberparleiter@de.ibm.com>
  */
 
@@ -632,6 +632,9 @@ static void __init __sclp_vt220_cleanup(
 		else
 			free_bootmem((unsigned long) page, PAGE_SIZE);
 	}
+	if (!list_empty(&sclp_vt220_register.list))
+		sclp_unregister(&sclp_vt220_register);
+	sclp_vt220_initialized = 0;
 }
 
 static int __init __sclp_vt220_init(void)
@@ -639,6 +642,7 @@ static int __init __sclp_vt220_init(void
 	void *page;
 	int i;
 	int num_pages;
+	int rc;
 
 	if (sclp_vt220_initialized)
 		return 0;
@@ -667,7 +671,14 @@ static int __init __sclp_vt220_init(void
 		}
 		list_add_tail((struct list_head *) page, &sclp_vt220_empty);
 	}
-	return 0;
+	rc = sclp_register(&sclp_vt220_register);
+	if (rc) {
+		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
+		       "could not register vt220 - "
+		       "sclp_register returned %d\n", rc);
+		__sclp_vt220_cleanup();
+	}
+	return rc;
 }
 
 static const struct tty_operations sclp_vt220_ops = {
@@ -688,22 +699,17 @@ static int __init sclp_vt220_tty_init(vo
 {
 	struct tty_driver *driver;
 	int rc;
+	int cleanup;
 
 	/* Note: we're not testing for CONSOLE_IS_SCLP here to preserve
 	 * symmetry between VM and LPAR systems regarding ttyS1. */
 	driver = alloc_tty_driver(1);
 	if (!driver)
 		return -ENOMEM;
+	cleanup = !sclp_vt220_initialized;
 	rc = __sclp_vt220_init();
 	if (rc)
 		goto out_driver;
-	rc = sclp_register(&sclp_vt220_register);
-	if (rc) {
-		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
-		       "could not register tty - "
-		       "sclp_register returned %d\n", rc);
-		goto out_init;
-	}
 
 	driver->owner = THIS_MODULE;
 	driver->driver_name = SCLP_VT220_DRIVER_NAME;
@@ -721,15 +727,14 @@ static int __init sclp_vt220_tty_init(vo
 		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
 		       "could not register tty - "
 		       "tty_register_driver returned %d\n", rc);
-		goto out_sclp;
+		goto out_init;
 	}
 	sclp_vt220_driver = driver;
 	return 0;
 
-out_sclp:
-	sclp_unregister(&sclp_vt220_register);
 out_init:
-	__sclp_vt220_cleanup();
+	if (cleanup)
+		__sclp_vt220_cleanup();
 out_driver:
 	put_tty_driver(driver);
 	return rc;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
