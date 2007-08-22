Return-Path: <linux-kernel-owner+w=401wt.eu-S1763341AbXHVMgf@vger.kernel.org>
Message-Id: <20070822123643.731305505@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/10] hypfs: inode corruption due to missing locking
Content-Disposition: inline; filename=008-hypfs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

hypfs removes the whole hypfs directory tree and creates a new one, when a
process triggers an update by writing to the "update" attribute. When removing
and creating files, it is necessary to lock the inode of the parent directory
where the files live. Currently hypfs does not lock the parent inode, which
can lead to inode corruption. This patch:
 * Introduces correct locking
 * Fixes i_nlink reference counting for inodes, when creating directories
 * Adds info printk, when hypfs filesystem has been mounted

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/hypfs/inode.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

Index: quilt-2.6/arch/s390/hypfs/inode.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/inode.c
+++ quilt-2.6/arch/s390/hypfs/inode.c
@@ -60,17 +60,28 @@ static void hypfs_add_dentry(struct dent
 	hypfs_last_dentry = dentry;
 }
 
+static inline int hypfs_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
 static void hypfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
 
 	parent = dentry->d_parent;
-	if (S_ISDIR(dentry->d_inode->i_mode))
-		simple_rmdir(parent->d_inode, dentry);
-	else
-		simple_unlink(parent->d_inode, dentry);
+	if (!parent || !parent->d_inode)
+		return;
+	mutex_lock(&parent->d_inode->i_mutex);
+	if (hypfs_positive(dentry)) {
+		if (S_ISDIR(dentry->d_inode->i_mode))
+			simple_rmdir(parent->d_inode, dentry);
+		else
+			simple_unlink(parent->d_inode, dentry);
+	}
 	d_delete(dentry);
 	dput(dentry);
+	mutex_unlock(&parent->d_inode->i_mutex);
 }
 
 static void hypfs_delete_tree(struct dentry *root)
@@ -315,6 +326,7 @@ static int hypfs_fill_super(struct super
 	}
 	hypfs_update_update(sb);
 	sb->s_root = root_dentry;
+	printk(KERN_INFO "hypfs: Hypervisor filesystem mounted\n");
 	return 0;
 
 err_tree:
@@ -356,13 +368,17 @@ static struct dentry *hypfs_create_file(
 	qname.name = name;
 	qname.len = strlen(name);
 	qname.hash = full_name_hash(name, qname.len);
+	mutex_lock(&parent->d_inode->i_mutex);
 	dentry = lookup_one_len(name, parent, strlen(name));
-	if (IS_ERR(dentry))
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(dentry)) {
+		dentry = ERR_PTR(-ENOMEM);
+		goto fail;
+	}
 	inode = hypfs_make_inode(sb, mode);
 	if (!inode) {
 		dput(dentry);
-		return ERR_PTR(-ENOMEM);
+		dentry = ERR_PTR(-ENOMEM);
+		goto fail;
 	}
 	if (mode & S_IFREG) {
 		inode->i_fop = &hypfs_file_ops;
@@ -379,6 +395,8 @@ static struct dentry *hypfs_create_file(
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	dget(dentry);
+fail:
+	mutex_unlock(&parent->d_inode->i_mutex);
 	return dentry;
 }
 
@@ -391,7 +409,6 @@ struct dentry *hypfs_mkdir(struct super_
 	if (IS_ERR(dentry))
 		return dentry;
 	hypfs_add_dentry(dentry);
-	parent->d_inode->i_nlink++;
 	return dentry;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
