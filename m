Return-Path: <linux-kernel-owner+w=401wt.eu-S1762259AbXHGLPX@vger.kernel.org>
Message-Id: <20070807111845.182243298@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/18] hypfs: implement show_options
Content-Disposition: inline; filename=002-hypfs-showopt.diff
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

 arch/s390/hypfs/inode.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: quilt-2.6/arch/s390/hypfs/inode.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/inode.c
+++ quilt-2.6/arch/s390/hypfs/inode.c
@@ -17,6 +17,8 @@
 #include <linux/parser.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/mount.h>
 #include <asm/ebcdic.h>
 #include "hypfs.h"
 
@@ -256,6 +258,15 @@ static int hypfs_parse_options(char *opt
 	return 0;
 }
 
+static int hypfs_show_options(struct seq_file *s, struct vfsmount *mnt)
+{
+	struct hypfs_sb_info *hypfs_info = mnt->mnt_sb->s_fs_info;
+
+	seq_printf(s, ",uid=%u", hypfs_info->uid);
+	seq_printf(s, ",gid=%u", hypfs_info->gid);
+	return 0;
+}
+
 static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *root_inode;
@@ -459,6 +470,7 @@ static struct file_system_type hypfs_typ
 static struct super_operations hypfs_s_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= hypfs_drop_inode,
+	.show_options	= hypfs_show_options,
 };
 
 static decl_subsys(s390, NULL, NULL);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
