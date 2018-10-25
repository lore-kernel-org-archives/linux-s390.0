From: Stefan Haberland <sth@linux.ibm.com>
Date: Thu, 25 Oct 2018 09:07:57 +0000
Subject: [PATCH 1/1] dasd: remove dead code
Message-Id: <20181025090757.43024-2-sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Jens Axboe <axboe@kernel.dk>

Since e443343e509a we haven't had a request_fn attached to
this driver, hence any code inside an if (q->request_fn) is
unreachable.

Fixes: e443343e509a ("s390/dasd: blk-mq conversion")
[sth: Keep and fix the dasd_info->chanq_len counter.]
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

---
 drivers/s390/block/dasd_ioctl.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 2016e0ed5865..8e26001dc11c 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -412,6 +412,7 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	struct ccw_dev_id dev_id;
 	struct dasd_device *base;
 	struct ccw_device *cdev;
+	struct list_head *l;
 	unsigned long flags;
 	int rc;
 
@@ -462,23 +463,10 @@ static int dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	if (block->request_queue->request_fn) {
-		struct list_head *l;
-#ifdef DASD_EXTENDED_PROFILING
-		{
-			struct list_head *l;
-			spin_lock_irqsave(&block->lock, flags);
-			list_for_each(l, &block->request_queue->queue_head)
-				dasd_info->req_queue_len++;
-			spin_unlock_irqrestore(&block->lock, flags);
-		}
-#endif				/* DASD_EXTENDED_PROFILING */
-		spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
-		list_for_each(l, &base->ccw_queue)
-			dasd_info->chanq_len++;
-		spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
-				       flags);
-	}
+	spin_lock_irqsave(&block->queue_lock, flags);
+	list_for_each(l, &base->ccw_queue)
+		dasd_info->chanq_len++;
+	spin_unlock_irqrestore(&block->queue_lock, flags);
 
 	rc = 0;
 	if (copy_to_user(argp, dasd_info,
-- 
2.16.4
