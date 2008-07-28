Return-Path: <linux-kernel-owner+w=401wt.eu-S1760245AbYG1Rzq@vger.kernel.org>
Message-Id: <20080728175513.120180800@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/15] kmsg: convert hypfs printk messages to kmsg api.
Content-Disposition: inline; filename=810-kmsg-hypfs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/hypfs |   60 ++++++++++++++++++++++++++++++++++++++++++
 arch/s390/hypfs/hypfs_diag.c  |    9 ++++--
 arch/s390/hypfs/inode.c       |   13 ++++-----
 3 files changed, 73 insertions(+), 9 deletions(-)

Index: quilt-2.6/arch/s390/hypfs/hypfs_diag.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/hypfs_diag.c
+++ quilt-2.6/arch/s390/hypfs/hypfs_diag.c
@@ -3,7 +3,7 @@
  *    Hypervisor filesystem for Linux on s390. Diag 204 and 224
  *    implementation.
  *
- *    Copyright (C) IBM Corp. 2006
+ *    Copyright IBM Corp. 2006, 2008
  *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
  */
 
@@ -12,8 +12,10 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <asm/ebcdic.h>
+#include <asm/kmsg.h>
 #include "hypfs.h"
 
+#define KMSG_COMPONENT "hypfs"
 #define LPAR_NAME_LEN 8		/* lpar name len in diag 204 data */
 #define CPU_NAME_LEN 16		/* type name len of cpus in diag224 name table */
 #define TMP_SIZE 64		/* size of temporary buffers */
@@ -527,13 +529,14 @@ __init int hypfs_diag_init(void)
 	int rc;
 
 	if (diag204_probe()) {
-		printk(KERN_ERR "hypfs: diag 204 not working.");
+		kmsg_err(1, "The hardware system does not support hypfs");
 		return -ENODATA;
 	}
 	rc = diag224_get_name_table();
 	if (rc) {
 		diag204_free_buffer();
-		printk(KERN_ERR "hypfs: could not get name table.\n");
+		kmsg_err(2, "The hardware system does not provide all "
+			 "functions required by hypfs\n");
 	}
 	return rc;
 }
Index: quilt-2.6/arch/s390/hypfs/inode.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/inode.c
+++ quilt-2.6/arch/s390/hypfs/inode.c
@@ -2,7 +2,7 @@
  *  arch/s390/hypfs/inode.c
  *    Hypervisor filesystem for Linux on s390.
  *
- *    Copyright (C) IBM Corp. 2006
+ *    Copyright IBM Corp. 2006, 2008
  *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
  */
 
@@ -20,8 +20,10 @@
 #include <linux/seq_file.h>
 #include <linux/mount.h>
 #include <asm/ebcdic.h>
+#include <asm/kmsg.h>
 #include "hypfs.h"
 
+#define KMSG_COMPONENT "hypfs"
 #define HYPFS_MAGIC 0x687970	/* ASCII 'hyp' */
 #define TMP_SIZE 64		/* size of temporary buffers */
 
@@ -200,7 +202,7 @@ static ssize_t hypfs_aio_write(struct ki
 	else
 		rc = hypfs_diag_create_files(sb, sb->s_root);
 	if (rc) {
-		printk(KERN_ERR "hypfs: Update failed\n");
+		kmsg_err(3, "Updating the hypfs tree failed\n");
 		hypfs_delete_tree(sb->s_root);
 		goto out;
 	}
@@ -252,8 +254,7 @@ static int hypfs_parse_options(char *opt
 			break;
 		case opt_err:
 		default:
-			printk(KERN_ERR "hypfs: Unrecognized mount option "
-			       "\"%s\" or missing value\n", str);
+			kmsg_err(4, "%s is not a valid mount option", str);
 			return -EINVAL;
 		}
 	}
@@ -317,7 +318,7 @@ static int hypfs_fill_super(struct super
 	}
 	hypfs_update_update(sb);
 	sb->s_root = root_dentry;
-	printk(KERN_INFO "hypfs: Hypervisor filesystem mounted\n");
+	kmsg_info(0, "Hypervisor filesystem mounted\n");
 	return 0;
 
 err_tree:
@@ -513,7 +514,7 @@ fail_sysfs:
 	if (!MACHINE_IS_VM)
 		hypfs_diag_exit();
 fail_diag:
-	printk(KERN_ERR "hypfs: Initialization failed with rc = %i.\n", rc);
+	kmsg_err(5, "Initialization of hypfs failed with rc=%i\n", rc);
 	return rc;
 }
 
Index: quilt-2.6/Documentation/s390/kmsg/hypfs
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/hypfs
@@ -0,0 +1,60 @@
+/*?
+ * Tag: hypfs.1
+ * Text: "The hardware system does not support hypfs"
+ * Severity: Error
+ * Description:
+ * hypfs requires DIAGNOSE Code X'204' but this diagnose code is not available
+ * on your hardware. You need more recent hardware to use hypfs.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: hypfs.2
+ * Text: "The hardware system does not provide all functions required by hypfs"
+ * Severity: Error
+ * Description:
+ * hypfs requires DIAGNOSE Code X'224' but this diagnode code is not available
+ * on your hardware. You need more recent hardware to use hypfs.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: hypfs.3
+ * Text: "Updating the hypfs tree failed"
+ * Severity: Error
+ * Description:
+ * There was not enough memory available to update the hypfs tree.
+ * User action:
+ * Free some memory and try again to update the hypfs tree. Consider assigning
+ * more memory to your LPAR or z/VM guest virtual machine.
+ */
+
+/*?
+ * Tag: hypfs.4
+ * Text: "%s is not a valid mount option"
+ * Severity: Error
+ * Parameter:
+ *   @1: mount option
+ * Description:
+ * hypfs has detected mount options that are not valid.
+ * User action:
+ * See "Device Drivers Features and Commands" for information about valid
+ * mount options for hypfs.
+ */
+
+/*?
+ * Tag: hypfs.5
+ * Text: "Initialization of hypfs failed with rc=%i"
+ * Severity: Error
+ * Parameter:
+ *   @1: error code
+ * Description:
+ * Initialization of hypfs failed because of resource or hardware constraints.
+ * Possible reasons for this problem are insufficient free memory or missing
+ * hardware interfaces.
+ * User action:
+ * See errno.h for information about the error codes.
+ */
+

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
