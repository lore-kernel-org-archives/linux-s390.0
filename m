Return-Path: <linux-kernel-owner+w=401wt.eu-S1756713AbYK0KpZ@vger.kernel.org>
Message-Id: <20081127103139.834503797@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 43/60] convert hypfs printks to pr_xxx macros.
Content-Disposition: inline; filename=158-kmsg-hypfs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c |   10 +++++++---
 arch/s390/hypfs/inode.c      |   14 ++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

Index: quilt-2.6/arch/s390/hypfs/hypfs_diag.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/hypfs_diag.c
+++ quilt-2.6/arch/s390/hypfs/hypfs_diag.c
@@ -3,10 +3,13 @@
  *    Hypervisor filesystem for Linux on s390. Diag 204 and 224
  *    implementation.
  *
- *    Copyright (C) IBM Corp. 2006
+ *    Copyright IBM Corp. 2006, 2008
  *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "hypfs"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -527,13 +530,14 @@ __init int hypfs_diag_init(void)
 	int rc;
 
 	if (diag204_probe()) {
-		printk(KERN_ERR "hypfs: diag 204 not working.");
+		pr_err("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
 	rc = diag224_get_name_table();
 	if (rc) {
 		diag204_free_buffer();
-		printk(KERN_ERR "hypfs: could not get name table.\n");
+		pr_err("The hardware system does not provide all "
+		       "functions required by hypfs\n");
 	}
 	return rc;
 }
Index: quilt-2.6/arch/s390/hypfs/inode.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/inode.c
+++ quilt-2.6/arch/s390/hypfs/inode.c
@@ -2,10 +2,13 @@
  *  arch/s390/hypfs/inode.c
  *    Hypervisor filesystem for Linux on s390.
  *
- *    Copyright (C) IBM Corp. 2006
+ *    Copyright IBM Corp. 2006, 2008
  *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "hypfs"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -200,7 +203,7 @@ static ssize_t hypfs_aio_write(struct ki
 	else
 		rc = hypfs_diag_create_files(sb, sb->s_root);
 	if (rc) {
-		printk(KERN_ERR "hypfs: Update failed\n");
+		pr_err("Updating the hypfs tree failed\n");
 		hypfs_delete_tree(sb->s_root);
 		goto out;
 	}
@@ -252,8 +255,7 @@ static int hypfs_parse_options(char *opt
 			break;
 		case opt_err:
 		default:
-			printk(KERN_ERR "hypfs: Unrecognized mount option "
-			       "\"%s\" or missing value\n", str);
+			pr_err("%s is not a valid mount option\n", str);
 			return -EINVAL;
 		}
 	}
@@ -317,7 +319,7 @@ static int hypfs_fill_super(struct super
 	}
 	hypfs_update_update(sb);
 	sb->s_root = root_dentry;
-	printk(KERN_INFO "hypfs: Hypervisor filesystem mounted\n");
+	pr_info("Hypervisor filesystem mounted\n");
 	return 0;
 
 err_tree:
@@ -513,7 +515,7 @@ fail_sysfs:
 	if (!MACHINE_IS_VM)
 		hypfs_diag_exit();
 fail_diag:
-	printk(KERN_ERR "hypfs: Initialization failed with rc = %i.\n", rc);
+	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 	return rc;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
