Return-Path: <linux-kernel-owner+w=401wt.eu-S1030949AbXDJP6g@vger.kernel.org>
Subject: [Patch] cleanup: use seq_release_private() where appropriate
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 17:58:34 +0200
Message-Id: <1176220714.5572.24.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We can save some lines of code by using seq_release_private().

Patch is against 2.6.21-rc6-mm1.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 drivers/md/md.c     |   11 +----------
 fs/proc/proc_misc.c |    9 +--------
 kernel/kallsyms.c   |    9 +--------
 net/sunrpc/cache.c  |   10 +---------
 4 files changed, 4 insertions(+), 35 deletions(-)

Index: linux/drivers/md/md.c
===================================================================
--- linux.orig/drivers/md/md.c
+++ linux/drivers/md/md.c
@@ -4943,15 +4943,6 @@ static int md_seq_open(struct inode *ino
 	return error;
 }
 
-static int md_seq_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *m = file->private_data;
-	struct mdstat_info *mi = m->private;
-	m->private = NULL;
-	kfree(mi);
-	return seq_release(inode, file);
-}
-
 static unsigned int mdstat_poll(struct file *filp, poll_table *wait)
 {
 	struct seq_file *m = filp->private_data;
@@ -4973,7 +4964,7 @@ static const struct file_operations md_s
 	.open           = md_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= md_seq_release,
+	.release	= seq_release_private,
 	.poll		= mdstat_poll,
 };
 
Index: linux/kernel/kallsyms.c
===================================================================
--- linux.orig/kernel/kallsyms.c
+++ linux/kernel/kallsyms.c
@@ -470,18 +470,11 @@ static int kallsyms_open(struct inode *i
 	return ret;
 }
 
-static int kallsyms_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *m = (struct seq_file *)file->private_data;
-	kfree(m->private);
-	return seq_release(inode, file);
-}
-
 static const struct file_operations kallsyms_operations = {
 	.open = kallsyms_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = kallsyms_release,
+	.release = seq_release_private,
 };
 
 static int __init kallsyms_init(void)
Index: linux/net/sunrpc/cache.c
===================================================================
--- linux.orig/net/sunrpc/cache.c
+++ linux/net/sunrpc/cache.c
@@ -1237,20 +1237,12 @@ static int content_open(struct inode *in
 
 	return res;
 }
-static int content_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *m = (struct seq_file *)file->private_data;
-	struct handle *han = m->private;
-	kfree(han);
-	m->private = NULL;
-	return seq_release(inode, file);
-}
 
 static const struct file_operations content_file_operations = {
 	.open		= content_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= content_release,
+	.release	= seq_release_private,
 };
 
 static ssize_t read_flush(struct file *file, char __user *buf,
Index: linux/fs/proc/proc_misc.c
===================================================================
--- linux.orig/fs/proc/proc_misc.c
+++ linux/fs/proc/proc_misc.c
@@ -430,18 +430,11 @@ static int slabstats_open(struct inode *
 	return ret;
 }
 
-static int slabstats_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *m = file->private_data;
-	kfree(m->private);
-	return seq_release(inode, file);
-}
-
 static const struct file_operations proc_slabstats_operations = {
 	.open		= slabstats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= slabstats_release,
+	.release	= seq_release_private,
 };
 #endif
 #endif
