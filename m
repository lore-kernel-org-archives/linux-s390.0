Return-Path: <linux-kernel-owner+w=401wt.eu-S1756066AbZHNL2m@vger.kernel.org>
Message-Id: <20090814112619.611605266@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 30/34] hypfs: remove useless variable qname
Content-Disposition: inline; filename=129-hypfs-useless-variable.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vitaliy Gusev <vgusev@openvz.org>, Michael Holzheu <holzheu@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Vitaliy Gusev <vgusev@openvz.org>

Local variable 'qname' in the function hypfs_create_file() really is not
used for any purpose.

Signed-off-by: Vitaliy Gusev <vgusev@openvz.org>
Cc: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/inode.c |    4 ----
 1 file changed, 4 deletions(-)

Index: quilt-2.6/arch/s390/hypfs/inode.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/inode.c
+++ quilt-2.6/arch/s390/hypfs/inode.c
@@ -355,11 +355,7 @@ static struct dentry *hypfs_create_file(
 {
 	struct dentry *dentry;
 	struct inode *inode;
-	struct qstr qname;
 
-	qname.name = name;
-	qname.len = strlen(name);
-	qname.hash = full_name_hash(name, qname.len);
 	mutex_lock(&parent->d_inode->i_mutex);
 	dentry = lookup_one_len(name, parent, strlen(name));
 	if (IS_ERR(dentry)) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
