Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 7/9] s390: hypfs: make inode explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:30 -0400
Message-ID: <20161030203732.26405-8-paul.gortmaker@windriver.com>
In-Reply-To: <20161030203732.26405-1-paul.gortmaker@windriver.com>
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

arch/s390/Kconfig:config S390_HYPFS_FS
arch/s390/Kconfig:      def_bool y

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_ALIAS is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Build testing indicated the presence of module.h was masking an
implicit include of kobject.h, hence the addition of that.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/s390/hypfs/inode.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 09bccb224d03..cf8a2d92467f 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -3,6 +3,7 @@
  *
  *    Copyright IBM Corp. 2006, 2008
  *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ *    License: GPL
  */
 
 #define KMSG_COMPONENT "hypfs"
@@ -18,7 +19,8 @@
 #include <linux/time.h>
 #include <linux/parser.h>
 #include <linux/sysfs.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/seq_file.h>
 #include <linux/mount.h>
 #include <linux/uio.h>
@@ -443,7 +445,6 @@ static struct file_system_type hypfs_type = {
 	.mount		= hypfs_mount,
 	.kill_sb	= hypfs_kill_super
 };
-MODULE_ALIAS_FS("s390_hypfs");
 
 static const struct super_operations hypfs_s_ops = {
 	.statfs		= simple_statfs,
@@ -497,21 +498,4 @@ static int __init hypfs_init(void)
 	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 	return rc;
 }
-
-static void __exit hypfs_exit(void)
-{
-	unregister_filesystem(&hypfs_type);
-	sysfs_remove_mount_point(hypervisor_kobj, "s390");
-	hypfs_diag0c_exit();
-	hypfs_sprp_exit();
-	hypfs_vm_exit();
-	hypfs_diag_exit();
-	hypfs_dbfs_exit();
-}
-
-module_init(hypfs_init)
-module_exit(hypfs_exit)
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Michael Holzheu <holzheu@de.ibm.com>");
-MODULE_DESCRIPTION("s390 Hypervisor Filesystem");
+device_initcall(hypfs_init)
-- 
2.10.1
