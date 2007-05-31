Return-Path: <linux-kernel-owner+w=401wt.eu-S1759355AbXEaPfA@vger.kernel.org>
Message-Id: <20070531153437.206191827@de.ibm.com>
References: <20070531142024.011160634@de.ibm.com>
Date: Thu, 31 May 2007 16:20:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/7] arch/s390/kernel/debug.c: use mutex instead of semaphore
Content-Disposition: inline; filename=003-debug-mutex.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/debug.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: quilt-2.6/arch/s390/kernel/debug.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/debug.c
+++ quilt-2.6/arch/s390/kernel/debug.c
@@ -163,7 +163,7 @@ unsigned int debug_feature_version = __D
 
 static debug_info_t *debug_area_first = NULL;
 static debug_info_t *debug_area_last = NULL;
-static DECLARE_MUTEX(debug_lock);
+static DEFINE_MUTEX(debug_mutex);
 
 static int initialized;
 
@@ -576,7 +576,7 @@ debug_input(struct file *file, const cha
 	int rc = 0;
 	file_private_info_t *p_info;
 
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	p_info = ((file_private_info_t *) file->private_data);
 	if (p_info->view->input_proc)
 		rc = p_info->view->input_proc(p_info->debug_info_org,
@@ -584,7 +584,7 @@ debug_input(struct file *file, const cha
 					      length, offset);
 	else
 		rc = -EPERM;
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 	return rc;		/* number of input characters */
 }
 
@@ -602,7 +602,7 @@ debug_open(struct inode *inode, struct f
 	file_private_info_t *p_info;
 	debug_info_t *debug_info, *debug_info_snapshot;
 
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	debug_info = file->f_path.dentry->d_inode->i_private;
 	/* find debug view */
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
@@ -653,7 +653,7 @@ found:
 	file->private_data = p_info;
 	debug_info_get(debug_info);
 out:
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 	return rc;
 }
 
@@ -688,7 +688,7 @@ debug_register (char *name, int pages_pe
 
 	if (!initialized)
 		BUG();
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 
         /* create new debug_info */
 
@@ -702,7 +702,7 @@ out:
         if (!rc){
 		printk(KERN_ERR "debug: debug_register failed for %s\n",name);
         }
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 	return rc;
 }
 
@@ -716,9 +716,9 @@ debug_unregister(debug_info_t * id)
 {
 	if (!id)
 		goto out;
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	debug_info_put(id);
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 
 out:
 	return;
@@ -1054,11 +1054,11 @@ __init debug_init(void)
 	int rc = 0;
 
 	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table);
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	debug_debugfs_root_entry = debugfs_create_dir(DEBUG_DIR_ROOT,NULL);
 	printk(KERN_INFO "debug: Initialization complete\n");
 	initialized = 1;
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 
 	return rc;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
