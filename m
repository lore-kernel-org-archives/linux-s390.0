Return-Path: <linux-kernel-owner+w=401wt.eu-S1755959AbZHNL2a@vger.kernel.org>
Message-Id: <20090814112614.412615291@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/34] qdio: remove limited number of debugfs entries
Content-Disposition: inline; filename=107-qdio-debugfs-limit.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

The number of qdio debugfs entries was limited. Remove this limit
and group the queue files in a per device directory.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.h       |    4 ++-
 drivers/s390/cio/qdio_debug.c |   55 +++++++++++-------------------------------
 2 files changed, 18 insertions(+), 41 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_debug.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_debug.c
+++ quilt-2.6/drivers/s390/cio/qdio_debug.c
@@ -1,14 +1,12 @@
 /*
  *  drivers/s390/cio/qdio_debug.c
  *
- *  Copyright IBM Corp. 2008
+ *  Copyright IBM Corp. 2008,2009
  *
  *  Author: Jan Glauber (jang@linux.vnet.ibm.com)
  */
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
-#include <asm/qdio.h>
 #include <asm/debug.h>
 #include "qdio_debug.h"
 #include "qdio.h"
@@ -17,10 +15,7 @@ debug_info_t *qdio_dbf_setup;
 debug_info_t *qdio_dbf_error;
 
 static struct dentry *debugfs_root;
-#define MAX_DEBUGFS_QUEUES	32
-static struct dentry *debugfs_queues[MAX_DEBUGFS_QUEUES] = { NULL };
-static DEFINE_MUTEX(debugfs_mutex);
-#define QDIO_DEBUGFS_NAME_LEN	40
+#define QDIO_DEBUGFS_NAME_LEN	10
 
 void qdio_allocate_dbf(struct qdio_initialize *init_data,
 		       struct qdio_irq *irq_ptr)
@@ -130,20 +125,6 @@ static int qstat_seq_open(struct inode *
 			   filp->f_path.dentry->d_inode->i_private);
 }
 
-static void remove_debugfs_entry(struct qdio_q *q)
-{
-	int i;
-
-	for (i = 0; i < MAX_DEBUGFS_QUEUES; i++) {
-		if (!debugfs_queues[i])
-			continue;
-		if (debugfs_queues[i]->d_inode->i_private == q) {
-			debugfs_remove(debugfs_queues[i]);
-			debugfs_queues[i] = NULL;
-		}
-	}
-}
-
 static struct file_operations debugfs_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = qstat_seq_open,
@@ -155,22 +136,15 @@ static struct file_operations debugfs_fo
 
 static void setup_debugfs_entry(struct qdio_q *q, struct ccw_device *cdev)
 {
-	int i = 0;
 	char name[QDIO_DEBUGFS_NAME_LEN];
 
-	while (debugfs_queues[i] != NULL) {
-		i++;
-		if (i >= MAX_DEBUGFS_QUEUES)
-			return;
-	}
-	snprintf(name, QDIO_DEBUGFS_NAME_LEN, "%s_%s_%d",
-		 dev_name(&cdev->dev),
+	snprintf(name, QDIO_DEBUGFS_NAME_LEN, "%s_%d",
 		 q->is_input_q ? "input" : "output",
 		 q->nr);
-	debugfs_queues[i] = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
-						debugfs_root, q, &debugfs_fops);
-	if (IS_ERR(debugfs_queues[i]))
-		debugfs_queues[i] = NULL;
+	q->debugfs_q = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
+				q->irq_ptr->debugfs_dev, q, &debugfs_fops);
+	if (IS_ERR(q->debugfs_q))
+		q->debugfs_q = NULL;
 }
 
 void qdio_setup_debug_entries(struct qdio_irq *irq_ptr, struct ccw_device *cdev)
@@ -178,12 +152,14 @@ void qdio_setup_debug_entries(struct qdi
 	struct qdio_q *q;
 	int i;
 
-	mutex_lock(&debugfs_mutex);
+	irq_ptr->debugfs_dev = debugfs_create_dir(dev_name(&cdev->dev),
+						  debugfs_root);
+	if (IS_ERR(irq_ptr->debugfs_dev))
+		irq_ptr->debugfs_dev = NULL;
 	for_each_input_queue(irq_ptr, q, i)
 		setup_debugfs_entry(q, cdev);
 	for_each_output_queue(irq_ptr, q, i)
 		setup_debugfs_entry(q, cdev);
-	mutex_unlock(&debugfs_mutex);
 }
 
 void qdio_shutdown_debug_entries(struct qdio_irq *irq_ptr, struct ccw_device *cdev)
@@ -191,17 +167,16 @@ void qdio_shutdown_debug_entries(struct 
 	struct qdio_q *q;
 	int i;
 
-	mutex_lock(&debugfs_mutex);
 	for_each_input_queue(irq_ptr, q, i)
-		remove_debugfs_entry(q);
+		debugfs_remove(q->debugfs_q);
 	for_each_output_queue(irq_ptr, q, i)
-		remove_debugfs_entry(q);
-	mutex_unlock(&debugfs_mutex);
+		debugfs_remove(q->debugfs_q);
+	debugfs_remove(irq_ptr->debugfs_dev);
 }
 
 int __init qdio_debug_init(void)
 {
-	debugfs_root = debugfs_create_dir("qdio_queues", NULL);
+	debugfs_root = debugfs_create_dir("qdio", NULL);
 
 	qdio_dbf_setup = debug_register("qdio_setup", 16, 1, 16);
 	debug_register_view(qdio_dbf_setup, &debug_hex_ascii_view);
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/s390/cio/qdio.h
  *
- * Copyright 2000,2008 IBM Corp.
+ * Copyright 2000,2009 IBM Corp.
  * Author(s): Utz Bacher <utz.bacher@de.ibm.com>
  *	      Jan Glauber <jang@linux.vnet.ibm.com>
  */
@@ -246,6 +246,7 @@ struct qdio_q {
 	atomic_t nr_buf_used;
 
 	struct qdio_irq *irq_ptr;
+	struct dentry *debugfs_q;
 	struct tasklet_struct tasklet;
 
 	/* error condition during a data transfer */
@@ -267,6 +268,7 @@ struct qdio_irq {
 	struct qib qib;
 	u32 *dsci;		/* address of device state change indicator */
 	struct ccw_device *cdev;
+	struct dentry *debugfs_dev;
 
 	unsigned long int_parm;
 	struct subchannel_id schid;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
