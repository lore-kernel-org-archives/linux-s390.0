Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] s390: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 22:28:11 -0500
Message-Id: <20181202032811.9875-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sth@linux.ibm.com, hoeppner@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/s390/block/dasd.c     | 15 +--------------
 drivers/s390/cio/qdio_debug.c | 16 ++--------------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 5e9ebdb0594c..397af07e4d88 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1192,20 +1192,7 @@ static int dasd_hosts_show(struct seq_file *m, void *v)
 	return rc;
 }
 
-static int dasd_hosts_open(struct inode *inode, struct file *file)
-{
-	struct dasd_device *device = inode->i_private;
-
-	return single_open(file, dasd_hosts_show, device);
-}
-
-static const struct file_operations dasd_hosts_fops = {
-	.owner		= THIS_MODULE,
-	.open		= dasd_hosts_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dasd_hosts);
 
 static void dasd_hosts_exit(struct dasd_device *device)
 {
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index 68a82f3e2e92..040061f2bfff 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -190,19 +190,7 @@ static int qstat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int qstat_seq_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, qstat_show,
-			   file_inode(filp)->i_private);
-}
-
-static const struct file_operations debugfs_fops = {
-	.owner	 = THIS_MODULE,
-	.open	 = qstat_seq_open,
-	.read	 = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(qstat);
 
 static char *qperf_names[] = {
 	"Assumed adapter interrupts",
@@ -306,7 +294,7 @@ static void setup_debugfs_entry(struct qdio_q *q)
 		 q->is_input_q ? "input" : "output",
 		 q->nr);
 	q->debugfs_q = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
-				q->irq_ptr->debugfs_dev, q, &debugfs_fops);
+				q->irq_ptr->debugfs_dev, q, &qstat_fops);
 	if (IS_ERR(q->debugfs_q))
 		q->debugfs_q = NULL;
 }
-- 
2.17.0
