Return-Path: <linux-kernel-owner+w=401wt.eu-S1758291AbZFDQ1M@vger.kernel.org>
Message-Id: <20090604161902.573576302@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/38] pm: xpram driver power management callbacks
Content-Disposition: inline; filename=pm_xpram.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/block/xpram.c |  129 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/s390/block/xpram.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/xpram.c
+++ linux-2.6/drivers/s390/block/xpram.c
@@ -39,7 +39,10 @@
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/sysdev.h>
 #include <linux/bio.h>
+#include <linux/suspend.h>
+#include <linux/platform_device.h>
 #include <asm/uaccess.h>
+#include <asm/checksum.h>
 
 #define XPRAM_NAME	"xpram"
 #define XPRAM_DEVS	1	/* one partition */
@@ -48,6 +51,7 @@
 typedef struct {
 	unsigned int	size;		/* size of xpram segment in pages */
 	unsigned int	offset;		/* start page of xpram segment */
+	unsigned int	csum;		/* partition checksum for suspend */
 } xpram_device_t;
 
 static xpram_device_t xpram_devices[XPRAM_MAX_DEVS];
@@ -138,7 +142,7 @@ static long xpram_page_out (unsigned lon
 /*
  * Check if xpram is available.
  */
-static int __init xpram_present(void)
+static int xpram_present(void)
 {
 	unsigned long mem_page;
 	int rc;
@@ -154,7 +158,7 @@ static int __init xpram_present(void)
 /*
  * Return index of the last available xpram page.
  */
-static unsigned long __init xpram_highest_page_index(void)
+static unsigned long xpram_highest_page_index(void)
 {
 	unsigned int page_index, add_bit;
 	unsigned long mem_page;
@@ -383,6 +387,106 @@ out:
 }
 
 /*
+ * Save checksums for all partitions.
+ */
+static int xpram_save_checksums(void)
+{
+	unsigned long mem_page;
+	int rc, i;
+
+	rc = 0;
+	mem_page = (unsigned long) __get_free_page(GFP_KERNEL);
+	if (!mem_page)
+		return -ENOMEM;
+	for (i = 0; i < xpram_devs; i++) {
+		rc = xpram_page_in(mem_page, xpram_devices[i].offset);
+		if (rc)
+			goto fail;
+		xpram_devices[i].csum = csum_partial((const void *) mem_page,
+						     PAGE_SIZE, 0);
+	}
+fail:
+	free_page(mem_page);
+	return rc ? -ENXIO : 0;
+}
+
+/*
+ * Verify checksums for all partitions.
+ */
+static int xpram_validate_checksums(void)
+{
+	unsigned long mem_page;
+	unsigned int csum;
+	int rc, i;
+
+	rc = 0;
+	mem_page = (unsigned long) __get_free_page(GFP_KERNEL);
+	if (!mem_page)
+		return -ENOMEM;
+	for (i = 0; i < xpram_devs; i++) {
+		rc = xpram_page_in(mem_page, xpram_devices[i].offset);
+		if (rc)
+			goto fail;
+		csum = csum_partial((const void *) mem_page, PAGE_SIZE, 0);
+		if (xpram_devices[i].csum != csum) {
+			rc = -EINVAL;
+			goto fail;
+		}
+	}
+fail:
+	free_page(mem_page);
+	return rc ? -ENXIO : 0;
+}
+
+/*
+ * Resume failed: Print error message and call panic.
+ */
+static void xpram_resume_error(const char *message)
+{
+	pr_err("Resume error: %s\n", message);
+	panic("xpram resume error\n");
+}
+
+/*
+ * Check if xpram setup changed between suspend and resume.
+ */
+static int xpram_restore(struct device *dev)
+{
+	if (!xpram_pages)
+		return 0;
+	if (xpram_present() != 0)
+		xpram_resume_error("xpram disappeared");
+	if (xpram_pages != xpram_highest_page_index() + 1)
+		xpram_resume_error("Size of xpram changed");
+	if (xpram_validate_checksums())
+		xpram_resume_error("Data of xpram changed");
+	return 0;
+}
+
+/*
+ * Save necessary state in suspend.
+ */
+static int xpram_freeze(struct device *dev)
+{
+	return xpram_save_checksums();
+}
+
+static struct dev_pm_ops xpram_pm_ops = {
+	.freeze		= xpram_freeze,
+	.restore	= xpram_restore,
+};
+
+static struct platform_driver xpram_pdrv = {
+	.driver = {
+		.name	= XPRAM_NAME,
+		.owner	= THIS_MODULE,
+		.pm	= &xpram_pm_ops,
+	},
+};
+
+static struct platform_device *xpram_pdev;
+
+/*
  * Finally, the init/exit functions.
  */
 static void __exit xpram_exit(void)
@@ -394,6 +498,8 @@ static void __exit xpram_exit(void)
 		put_disk(xpram_disks[i]);
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
+	platform_device_unregister(xpram_pdev);
+	platform_driver_unregister(&xpram_pdrv);
 }
 
 static int __init xpram_init(void)
@@ -411,7 +517,24 @@ static int __init xpram_init(void)
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;
-	return xpram_setup_blkdev();
+	rc = platform_driver_register(&xpram_pdrv);
+	if (rc)
+		return rc;
+	xpram_pdev = platform_device_register_simple(XPRAM_NAME, -1, NULL, 0);
+	if (IS_ERR(xpram_pdev)) {
+		rc = PTR_ERR(xpram_pdev);
+		goto fail_platform_driver_unregister;
+	}
+	rc = xpram_setup_blkdev();
+	if (rc)
+		goto fail_platform_device_unregister;
+	return 0;
+
+fail_platform_device_unregister:
+	platform_device_unregister(xpram_pdev);
+fail_platform_driver_unregister:
+	platform_driver_unregister(&xpram_pdrv);
+	return rc;
 }
 
 module_init(xpram_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
