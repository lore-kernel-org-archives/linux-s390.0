Return-Path: <SRS0=qdCo=R6=vger.kernel.org=linux-fsdevel-owner@kernel.org>
Subject: [RFC PATCH 59/68] vfs: Convert hypfs to use the new mount API
From: David Howells <dhowells@redhat.com>
Date: Wed, 27 Mar 2019 23:48:03 +0000
Message-ID: <155373048388.7602.7989128950745899462.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: viro@zeniv.linux.org.uk
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Convert the hypfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: linux-s390@vger.kernel.org
---

 arch/s390/hypfs/inode.c |  128 ++++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 58 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index b5cfcad953c2..d1b5f75334af 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -12,17 +12,17 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/namei.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/time.h>
-#include <linux/parser.h>
 #include <linux/sysfs.h>
 #include <linux/init.h>
 #include <linux/kobject.h>
 #include <linux/seq_file.h>
-#include <linux/mount.h>
 #include <linux/uio.h>
 #include <asm/ebcdic.h>
 #include "hypfs.h"
@@ -207,52 +207,44 @@ static int hypfs_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-enum { opt_uid, opt_gid, opt_err };
+enum { Opt_uid, Opt_gid, };
 
-static const match_table_t hypfs_tokens = {
-	{opt_uid, "uid=%u"},
-	{opt_gid, "gid=%u"},
-	{opt_err, NULL}
+static const struct fs_parameter_spec hypfs_param_specs[] = {
+	fsparam_u32("gid", Opt_gid),
+	fsparam_u32("uid", Opt_uid),
+	{}
 };
 
-static int hypfs_parse_options(char *options, struct super_block *sb)
+static const struct fs_parameter_description hypfs_fs_parameters = {
+	.name		= "hypfs",
+	.specs		= hypfs_param_specs,
+};
+
+static int hypfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *str;
-	substring_t args[MAX_OPT_ARGS];
+	struct hypfs_sb_info *hypfs_info = fc->s_fs_info;
+	struct fs_parse_result result;
 	kuid_t uid;
 	kgid_t gid;
-
-	if (!options)
-		return 0;
-	while ((str = strsep(&options, ",")) != NULL) {
-		int token, option;
-		struct hypfs_sb_info *hypfs_info = sb->s_fs_info;
-
-		if (!*str)
-			continue;
-		token = match_token(str, hypfs_tokens, args);
-		switch (token) {
-		case opt_uid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid))
-				return -EINVAL;
-			hypfs_info->uid = uid;
-			break;
-		case opt_gid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid))
-				return -EINVAL;
-			hypfs_info->gid = gid;
-			break;
-		case opt_err:
-		default:
-			pr_err("%s is not a valid mount option\n", str);
-			return -EINVAL;
-		}
+	int opt;
+
+	opt = fs_parse(fc, &hypfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return invalf(fc, "Unknown uid");
+		hypfs_info->uid = uid;
+		break;
+	case Opt_gid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return invalf(fc, "Unknown gid");
+		hypfs_info->gid = gid;
+		break;
 	}
 	return 0;
 }
@@ -266,26 +258,18 @@ static int hypfs_show_options(struct seq_file *s, struct dentry *root)
 	return 0;
 }
 
-static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
+static int hypfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct hypfs_sb_info *sbi = sb->s_fs_info;
 	struct inode *root_inode;
 	struct dentry *root_dentry, *update_file;
-	int rc = 0;
-	struct hypfs_sb_info *sbi;
+	int rc;
 
-	sbi = kzalloc(sizeof(struct hypfs_sb_info), GFP_KERNEL);
-	if (!sbi)
-		return -ENOMEM;
-	mutex_init(&sbi->lock);
-	sbi->uid = current_uid();
-	sbi->gid = current_gid();
-	sb->s_fs_info = sbi;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = HYPFS_MAGIC;
 	sb->s_op = &hypfs_s_ops;
-	if (hypfs_parse_options(data, sb))
-		return -EINVAL;
+
 	root_inode = hypfs_make_inode(sb, S_IFDIR | 0755);
 	if (!root_inode)
 		return -ENOMEM;
@@ -309,10 +293,37 @@ static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static struct dentry *hypfs_mount(struct file_system_type *fst, int flags,
-			const char *devname, void *data)
+static int hypfs_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_single_super, hypfs_fill_super);
+}
+
+static void hypfs_free_fc(struct fs_context *fc)
 {
-	return mount_single(fst, flags, data, hypfs_fill_super);
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations hypfs_context_ops = {
+	.free		= hypfs_free_fc,
+	.parse_param	= hypfs_parse_param,
+	.get_tree	= hypfs_get_tree,
+};
+
+static int hypfs_init_fs_context(struct fs_context *fc)
+{
+	struct hypfs_sb_info *sbi;
+
+	sbi = kzalloc(sizeof(struct hypfs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+
+	mutex_init(&sbi->lock);
+	sbi->uid = current_uid();
+	sbi->gid = current_gid();
+
+	fc->s_fs_info = sbi;
+	fc->ops = &hypfs_context_ops;
+	return 0;
 }
 
 static void hypfs_kill_super(struct super_block *sb)
@@ -443,7 +454,8 @@ static const struct file_operations hypfs_file_ops = {
 static struct file_system_type hypfs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "s390_hypfs",
-	.mount		= hypfs_mount,
+	.init_fs_context = hypfs_init_fs_context,
+	.parameters	= &hypfs_fs_parameters,
 	.kill_sb	= hypfs_kill_super
 };
 
