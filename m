Return-Path: <linux-kernel-owner+w=401wt.eu-S1756675AbYIYQq4@vger.kernel.org>
Message-Id: <20080925163020.344040426@de.ibm.com>
References: <20080925162827.818261893@de.ibm.com>
Date: Thu, 25 Sep 2008 18:28:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/6] kmsg: convert xpram messages to kmsg api.
Content-Disposition: inline; filename=803-kmsg-xpram.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/kmsg/s390/xpram |   61 ++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/block/xpram.c    |   41 +++++++++++++---------------
 2 files changed, 80 insertions(+), 22 deletions(-)

Index: kmsg-2.6/Documentation/kmsg/s390/xpram
===================================================================
--- /dev/null
+++ kmsg-2.6/Documentation/kmsg/s390/xpram
@@ -0,0 +1,61 @@
+/*?
+ * Tag: xpram.ab9aa4
+ * Text: "%d is not a valid number of XPRAM devices\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: number of partitions
+ * Description:
+ * The number of XPRAM partitions specified for the 'devs' module parameter
+ * or with the 'xpram.parts' kernel parameter must be an integer in the
+ * range 1 to 32. The XPRAM device driver created a maximum of 32 partitions
+ * that are probably not configured as intended.
+ * User action:
+ * If the XPRAM device driver has been compiled as a separate module,
+ * unload the module and load it again with a correct value for the
+ * 'devs' module parameter. If the XPRAM device driver has been compiled
+ * into the kernel, correct the 'xpram.parts' parameter in the kernel
+ * command line and restart Linux.
+ */
+
+/*?
+ * Tag: xpram.f004d1
+ * Text: "Not enough expanded memory available\n"
+ * Severity: Error
+ * Description:
+ * The amount of expanded memory required to set up your XPRAM partitions
+ * depends on the 'sizes' parameter specified for the xpram module or on
+ * the specifications for the 'xpram.parts' parameter if the XPRAM device
+ * driver has been compiled into the kernel. Your
+ * current specification exceed the amount of available expanded memory.
+ * Your XPRAM partitions are probably not configured as intended.
+ * User action:
+ * If the XPRAM device driver has been compiled as a separate module,
+ * unload the xpram module and load it again with an appropriate value
+ * for the 'sizes' module parameter. If the XPRAM device driver has been
+ * compiled into the kernel, adjust the 'xpram.parts' parameter in the
+ * kernel command line and restart Linux. If you need more than the
+ * available expanded memory, increase the expanded memory allocation for
+ * your virtual hardware or LPAR.
+ */
+
+/*?
+ * Tag: xpram.f6ae78
+ * Text: "No expanded memory available\n"
+ * Severity: Error
+ * Description:
+ * The XPRAM device driver has been loaded in a Linux instance that runs
+ * in an LPAR or virtual hardware without expanded memory.
+ * are created.
+ * User action:
+ * Allocate expanded memory for your LPAR or virtual hardware or do not
+ * load the xpram module. You can ignore this message, if you do not want
+ * to create XPRAM partitions.
+ */
+
+/*? Tag: xpram.fc5e30 Text: "  number of devices (partitions): %d \n" */
+/*? Tag: xpram.9a3d44 Text: "  size of partition %d: %u kB\n" */
+/*? Tag: xpram.d1b9da Text: "  size of partition %d to be set automatically\n" */
+/*? Tag: xpram.758fd6 Text: "  memory needed (for sized partitions): %lu kB\n" */
+/*? Tag: xpram.3fc92b Text: "  partitions to be sized automatically: %d\n" */
+/*? Tag: xpram.6cdcc1 Text: "  automatically determined partition size: %lu kB\n" */
+/*? Tag: xpram.546055 Text: "  %u pages expanded memory found (%lu KB).\n" */
Index: kmsg-2.6/drivers/s390/block/xpram.c
===================================================================
--- kmsg-2.6.orig/drivers/s390/block/xpram.c
+++ kmsg-2.6/drivers/s390/block/xpram.c
@@ -25,6 +25,8 @@
  *   generic hard disk support to replace ad-hoc partitioning
  */
 
+#define KMSG_COMPONENT "xpram"
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ctype.h>  /* isdigit, isxdigit */
@@ -36,18 +38,13 @@
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/sysdev.h>
 #include <linux/bio.h>
+#include <linux/kmsg.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
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
@@ -263,7 +260,7 @@ static int __init xpram_setup_sizes(unsi
 
 	/* Check number of devices. */
 	if (devs <= 0 || devs > XPRAM_MAX_DEVS) {
-		PRINT_ERR("invalid number %d of devices\n",devs);
+		kmsg_err("%d is not a valid number of XPRAM devices\n",devs);
 		return -EINVAL;
 	}
 	xpram_devs = devs;
@@ -294,22 +291,22 @@ static int __init xpram_setup_sizes(unsi
 			mem_auto_no++;
 	}
 	
-	PRINT_INFO("  number of devices (partitions): %d \n", xpram_devs);
+	kmsg_info("  number of devices (partitions): %d \n", xpram_devs);
 	for (i = 0; i < xpram_devs; i++) {
 		if (xpram_sizes[i])
-			PRINT_INFO("  size of partition %d: %u kB\n",
-				   i, xpram_sizes[i]);
+			kmsg_info("  size of partition %d: %u kB\n",
+				  i, xpram_sizes[i]);
 		else
-			PRINT_INFO("  size of partition %d to be set "
-				   "automatically\n",i);
+			kmsg_info("  size of partition %d to be set "
+				  "automatically\n",i);
 	}
-	PRINT_DEBUG("  memory needed (for sized partitions): %lu kB\n",
-		    mem_needed);
-	PRINT_DEBUG("  partitions to be sized automatically: %d\n",
-		    mem_auto_no);
+	kmsg_info("  memory needed (for sized partitions): %lu kB\n",
+		  mem_needed);
+	kmsg_info("  partitions to be sized automatically: %d\n",
+		  mem_auto_no);
 
 	if (mem_needed > pages * 4) {
-		PRINT_ERR("Not enough expanded memory available\n");
+		kmsg_err("Not enough expanded memory available\n");
 		return -EINVAL;
 	}
 
@@ -321,8 +318,8 @@ static int __init xpram_setup_sizes(unsi
 	 */
 	if (mem_auto_no) {
 		mem_auto = ((pages - mem_needed / 4) / mem_auto_no) * 4;
-		PRINT_INFO("  automatically determined "
-			   "partition size: %lu kB\n", mem_auto);
+		kmsg_info("  automatically determined "
+			  "partition size: %lu kB\n", mem_auto);
 		for (i = 0; i < xpram_devs; i++)
 			if (xpram_sizes[i] == 0)
 				xpram_sizes[i] = mem_auto;
@@ -412,12 +409,12 @@ static int __init xpram_init(void)
 
 	/* Find out size of expanded memory. */
 	if (xpram_present() != 0) {
-		PRINT_WARN("No expanded memory available\n");
+		kmsg_err("No expanded memory available\n");
 		return -ENODEV;
 	}
 	xpram_pages = xpram_highest_page_index() + 1;
-	PRINT_INFO("  %u pages expanded memory found (%lu KB).\n",
-		   xpram_pages, (unsigned long) xpram_pages*4);
+	kmsg_info("  %u pages expanded memory found (%lu KB).\n",
+		  xpram_pages, (unsigned long) xpram_pages*4);
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
