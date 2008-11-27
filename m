Return-Path: <linux-kernel-owner+w=401wt.eu-S1756807AbYK0Knz@vger.kernel.org>
Message-Id: <20081127103137.566617660@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 35/60] convert xpram printks to pr_xxx macros.
Content-Disposition: inline; filename=150-kmsg-xpram.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/xpram.c |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

Index: quilt-2.6/drivers/s390/block/xpram.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/xpram.c
+++ quilt-2.6/drivers/s390/block/xpram.c
@@ -25,6 +25,9 @@
  *   generic hard disk support to replace ad-hoc partitioning
  */
 
+#define KMSG_COMPONENT "xpram"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ctype.h>  /* isdigit, isxdigit */
@@ -42,12 +45,6 @@
 #define XPRAM_DEVS	1	/* one partition */
 #define XPRAM_MAX_DEVS	32	/* maximal number of devices (partitions) */
 
-#define PRINT_DEBUG(x...)	printk(KERN_DEBUG XPRAM_NAME " debug:" x)
-#define PRINT_INFO(x...)	printk(KERN_INFO XPRAM_NAME " info:" x)
-#define PRINT_WARN(x...)	printk(KERN_WARNING XPRAM_NAME " warning:" x)
-#define PRINT_ERR(x...)		printk(KERN_ERR XPRAM_NAME " error:" x)
-
-
 typedef struct {
 	unsigned int	size;		/* size of xpram segment in pages */
 	unsigned int	offset;		/* start page of xpram segment */
@@ -264,7 +261,7 @@ static int __init xpram_setup_sizes(unsi
 
 	/* Check number of devices. */
 	if (devs <= 0 || devs > XPRAM_MAX_DEVS) {
-		PRINT_ERR("invalid number %d of devices\n",devs);
+		pr_err("%d is not a valid number of XPRAM devices\n",devs);
 		return -EINVAL;
 	}
 	xpram_devs = devs;
@@ -295,22 +292,22 @@ static int __init xpram_setup_sizes(unsi
 			mem_auto_no++;
 	}
 	
-	PRINT_INFO("  number of devices (partitions): %d \n", xpram_devs);
+	pr_info("  number of devices (partitions): %d \n", xpram_devs);
 	for (i = 0; i < xpram_devs; i++) {
 		if (xpram_sizes[i])
-			PRINT_INFO("  size of partition %d: %u kB\n",
-				   i, xpram_sizes[i]);
+			pr_info("  size of partition %d: %u kB\n",
+				i, xpram_sizes[i]);
 		else
-			PRINT_INFO("  size of partition %d to be set "
-				   "automatically\n",i);
+			pr_info("  size of partition %d to be set "
+				"automatically\n",i);
 	}
-	PRINT_DEBUG("  memory needed (for sized partitions): %lu kB\n",
-		    mem_needed);
-	PRINT_DEBUG("  partitions to be sized automatically: %d\n",
-		    mem_auto_no);
+	pr_info("  memory needed (for sized partitions): %lu kB\n",
+		mem_needed);
+	pr_info("  partitions to be sized automatically: %d\n",
+		mem_auto_no);
 
 	if (mem_needed > pages * 4) {
-		PRINT_ERR("Not enough expanded memory available\n");
+		pr_err("Not enough expanded memory available\n");
 		return -EINVAL;
 	}
 
@@ -322,8 +319,8 @@ static int __init xpram_setup_sizes(unsi
 	 */
 	if (mem_auto_no) {
 		mem_auto = ((pages - mem_needed / 4) / mem_auto_no) * 4;
-		PRINT_INFO("  automatically determined "
-			   "partition size: %lu kB\n", mem_auto);
+		pr_info("  automatically determined "
+			"partition size: %lu kB\n", mem_auto);
 		for (i = 0; i < xpram_devs; i++)
 			if (xpram_sizes[i] == 0)
 				xpram_sizes[i] = mem_auto;
@@ -405,12 +402,12 @@ static int __init xpram_init(void)
 
 	/* Find out size of expanded memory. */
 	if (xpram_present() != 0) {
-		PRINT_WARN("No expanded memory available\n");
+		pr_err("No expanded memory available\n");
 		return -ENODEV;
 	}
 	xpram_pages = xpram_highest_page_index() + 1;
-	PRINT_INFO("  %u pages expanded memory found (%lu KB).\n",
-		   xpram_pages, (unsigned long) xpram_pages*4);
+	pr_info("  %u pages expanded memory found (%lu KB).\n",
+		xpram_pages, (unsigned long) xpram_pages*4);
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
