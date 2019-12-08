Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbfLHNyv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Dec 2019 08:54:51 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 08 Dec 2019 13:53:19 +0000
Message-ID: <lsq.1575813165.422392579@decadent.org.uk>
Subject: [PATCH 3.16 35/72] hypfs: Fix error number left in struct pointer
 member
In-Reply-To: <lsq.1575813164.154362148@decadent.org.uk>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>

3.16.79-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit b54c64f7adeb241423cd46598f458b5486b0375e upstream.

In hypfs_fill_super(), if hypfs_create_update_file() fails,
sbi->update_file is left holding an error number.  This is passed to
hypfs_kill_super() which doesn't check for this.

Fix this by not setting sbi->update_value until after we've checked for
error.

Fixes: 24bbb1faf3f0 ("[PATCH] s390_hypfs filesystem")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: linux-s390@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/hypfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -275,7 +275,7 @@ static int hypfs_show_options(struct seq
 static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *root_inode;
-	struct dentry *root_dentry;
+	struct dentry *root_dentry, *update_file;
 	int rc = 0;
 	struct hypfs_sb_info *sbi;
 
@@ -306,9 +306,10 @@ static int hypfs_fill_super(struct super
 		rc = hypfs_diag_create_files(root_dentry);
 	if (rc)
 		return rc;
-	sbi->update_file = hypfs_create_update_file(root_dentry);
-	if (IS_ERR(sbi->update_file))
-		return PTR_ERR(sbi->update_file);
+	update_file = hypfs_create_update_file(root_dentry);
+	if (IS_ERR(update_file))
+		return PTR_ERR(update_file);
+	sbi->update_file = update_file;
 	hypfs_update_update(sb);
 	pr_info("Hypervisor filesystem mounted\n");
 	return 0;
