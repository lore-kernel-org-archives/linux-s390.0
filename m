Return-Path: <linux-kernel-owner+w=401wt.eu-S1756240AbZHNLb3@vger.kernel.org>
Message-Id: <20090814112620.072761945@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/34] xpram: Remove checksum validation for suspend/resume
Content-Disposition: inline; filename=131-xpram-remove-checksum.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently in the suspend process checksums for the XPRAM partitions are
created and stored. During the resume process it is checked,
if the checksums are still the same. If this is not the case, a kernel panic
is triggered. Unfortunately this prevents XPRAM from beeing used as suspend
device, because in this case after the checksum has been created, the
memory image is written to XPRAM and therefore the contents of the suspend
partition is changed. In order to allow XPRAM to be used as suspend device,
this patch removes the checksum validation.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/xpram.c |   65 ---------------------------------------------
 1 file changed, 65 deletions(-)

Index: quilt-2.6/drivers/s390/block/xpram.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/xpram.c
+++ quilt-2.6/drivers/s390/block/xpram.c
@@ -42,7 +42,6 @@
 #include <linux/suspend.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
-#include <asm/checksum.h>
 
 #define XPRAM_NAME	"xpram"
 #define XPRAM_DEVS	1	/* one partition */
@@ -51,7 +50,6 @@
 typedef struct {
 	unsigned int	size;		/* size of xpram segment in pages */
 	unsigned int	offset;		/* start page of xpram segment */
-	unsigned int	csum;		/* partition checksum for suspend */
 } xpram_device_t;
 
 static xpram_device_t xpram_devices[XPRAM_MAX_DEVS];
@@ -387,58 +385,6 @@ out:
 }
 
 /*
- * Save checksums for all partitions.
- */
-static int xpram_save_checksums(void)
-{
-	unsigned long mem_page;
-	int rc, i;
-
-	rc = 0;
-	mem_page = (unsigned long) __get_free_page(GFP_KERNEL);
-	if (!mem_page)
-		return -ENOMEM;
-	for (i = 0; i < xpram_devs; i++) {
-		rc = xpram_page_in(mem_page, xpram_devices[i].offset);
-		if (rc)
-			goto fail;
-		xpram_devices[i].csum = csum_partial((const void *) mem_page,
-						     PAGE_SIZE, 0);
-	}
-fail:
-	free_page(mem_page);
-	return rc ? -ENXIO : 0;
-}
-
-/*
- * Verify checksums for all partitions.
- */
-static int xpram_validate_checksums(void)
-{
-	unsigned long mem_page;
-	unsigned int csum;
-	int rc, i;
-
-	rc = 0;
-	mem_page = (unsigned long) __get_free_page(GFP_KERNEL);
-	if (!mem_page)
-		return -ENOMEM;
-	for (i = 0; i < xpram_devs; i++) {
-		rc = xpram_page_in(mem_page, xpram_devices[i].offset);
-		if (rc)
-			goto fail;
-		csum = csum_partial((const void *) mem_page, PAGE_SIZE, 0);
-		if (xpram_devices[i].csum != csum) {
-			rc = -EINVAL;
-			goto fail;
-		}
-	}
-fail:
-	free_page(mem_page);
-	return rc ? -ENXIO : 0;
-}
-
-/*
  * Resume failed: Print error message and call panic.
  */
 static void xpram_resume_error(const char *message)
@@ -458,21 +404,10 @@ static int xpram_restore(struct device *
 		xpram_resume_error("xpram disappeared");
 	if (xpram_pages != xpram_highest_page_index() + 1)
 		xpram_resume_error("Size of xpram changed");
-	if (xpram_validate_checksums())
-		xpram_resume_error("Data of xpram changed");
 	return 0;
 }
 
-/*
- * Save necessary state in suspend.
- */
-static int xpram_freeze(struct device *dev)
-{
-	return xpram_save_checksums();
-}
-
 static struct dev_pm_ops xpram_pm_ops = {
-	.freeze		= xpram_freeze,
 	.restore	= xpram_restore,
 };
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
