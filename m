Return-Path: <linux-kernel-owner+w=401wt.eu-S1755688AbYJORsX@vger.kernel.org>
Message-Id: <20081015174413.781182094@de.ibm.com>
References: <20081015174215.337001494@de.ibm.com>
Date: Wed, 15 Oct 2008 19:42:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/5] qdio: remove incorrect memset
Content-Disposition: inline; filename=002-qdio-strlen.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Remove the memset since zeroing the string is not needed and use
snprintf instead of sprintf.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_debug.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_debug.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_debug.c
+++ quilt-2.6/drivers/s390/cio/qdio_debug.c
@@ -20,6 +20,7 @@ static struct dentry *debugfs_root;
 #define MAX_DEBUGFS_QUEUES	32
 static struct dentry *debugfs_queues[MAX_DEBUGFS_QUEUES] = { NULL };
 static DEFINE_MUTEX(debugfs_mutex);
+#define QDIO_DEBUGFS_NAME_LEN	40
 
 void qdio_allocate_do_dbf(struct qdio_initialize *init_data)
 {
@@ -152,17 +153,6 @@ static int qstat_seq_open(struct inode *
 			   filp->f_path.dentry->d_inode->i_private);
 }
 
-static void get_queue_name(struct qdio_q *q, struct ccw_device *cdev, char *name)
-{
-	memset(name, 0, sizeof(name));
-	sprintf(name, "%s", dev_name(&cdev->dev));
-	if (q->is_input_q)
-		sprintf(name + strlen(name), "_input");
-	else
-		sprintf(name + strlen(name), "_output");
-	sprintf(name + strlen(name), "_%d", q->nr);
-}
-
 static void remove_debugfs_entry(struct qdio_q *q)
 {
 	int i;
@@ -189,14 +179,17 @@ static struct file_operations debugfs_fo
 static void setup_debugfs_entry(struct qdio_q *q, struct ccw_device *cdev)
 {
 	int i = 0;
-	char name[40];
+	char name[QDIO_DEBUGFS_NAME_LEN];
 
 	while (debugfs_queues[i] != NULL) {
 		i++;
 		if (i >= MAX_DEBUGFS_QUEUES)
 			return;
 	}
-	get_queue_name(q, cdev, name);
+	snprintf(name, QDIO_DEBUGFS_NAME_LEN, "%s_%s_%d",
+		 dev_name(&cdev->dev),
+		 q->is_input_q ? "input" : "output",
+		 q->nr);
 	debugfs_queues[i] = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
 						debugfs_root, q, &debugfs_fops);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
