Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C9C43334
	for <linux-s390@archiver.kernel.org>; Thu, 21 Jul 2022 13:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGUNdA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiGUNc5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Jul 2022 09:32:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8001E7E837
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wJWBY/AjUnEmPzzA/1NwM6wVNUag5Wc/cxaT6qa/GBU=; b=DQlMlCVg3c5HYUAcycIf/3CJAV
        sGcNfbZbg2RyNZgAeeJnNK/isuKCIInS+V85e+5m+X5GFjuukzVk/7JkljJollFo3mlZc4JHxZQlw
        HGxdHynVuDq3h7PmK9+dsrNqjweEKOPrN8XqueTsgbj7FnR5lc3wTYX+6vzK9rK0pQ81naueF0fCk
        EGu3lhRJuJz2F23Ghvd1f0ocef4Oo1WNgRtcQTrWPXPtb3zwstmXik/VeCGnM5hl3659v6BHGZLtg
        2KywIoF8j/pL9DkIPKA9IC2mJTKhLKCr3GgyNU3P34ZE5Ex99XLQCnERyrx9NWssiTXfsrHYSMJ3X
        cBiQ7wxw==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEWIP-0074uh-9X; Thu, 21 Jul 2022 13:32:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     sth@linux.ibm.com, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Subject: RFC: dasd: use blk_mq_alloc_disk
Date:   Thu, 21 Jul 2022 15:32:51 +0200
Message-Id: <20220721133251.1878402-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

As far as I can tell there is no need for the staged setup in
dasd, so allocate the tagset and the disk with the queue in
dasd_gendisk_alloc.

Warning: untested due to a lack of hardware.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c        | 83 ++++----------------------------
 drivers/s390/block/dasd_devmap.c |  7 +--
 drivers/s390/block/dasd_diag.c   |  2 +-
 drivers/s390/block/dasd_eckd.c   |  2 +-
 drivers/s390/block/dasd_fba.c    |  2 +-
 drivers/s390/block/dasd_genhd.c  | 29 +++++++++--
 drivers/s390/block/dasd_int.h    |  2 +-
 7 files changed, 39 insertions(+), 88 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4df8bf6505fca..4950b96912037 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -41,15 +41,6 @@
 
 #define DASD_DIAG_MOD		"dasd_diag_mod"
 
-static unsigned int queue_depth = 32;
-static unsigned int nr_hw_queues = 4;
-
-module_param(queue_depth, uint, 0444);
-MODULE_PARM_DESC(queue_depth, "Default queue depth for new DASD devices");
-
-module_param(nr_hw_queues, uint, 0444);
-MODULE_PARM_DESC(nr_hw_queues, "Default number of hardware queues for new DASD devices");
-
 /*
  * SECTION: exported variables of dasd.c
  */
@@ -68,8 +59,6 @@ MODULE_LICENSE("GPL");
 /*
  * SECTION: prototypes for static functions of dasd.c
  */
-static int  dasd_alloc_queue(struct dasd_block *);
-static void dasd_free_queue(struct dasd_block *);
 static int dasd_flush_block_queue(struct dasd_block *);
 static void dasd_device_tasklet(unsigned long);
 static void dasd_block_tasklet(unsigned long);
@@ -198,21 +187,11 @@ EXPORT_SYMBOL_GPL(dasd_free_block);
  */
 static int dasd_state_new_to_known(struct dasd_device *device)
 {
-	int rc;
-
 	/*
 	 * As long as the device is not in state DASD_STATE_NEW we want to
 	 * keep the reference count > 0.
 	 */
 	dasd_get_device(device);
-
-	if (device->block) {
-		rc = dasd_alloc_queue(device->block);
-		if (rc) {
-			dasd_put_device(device);
-			return rc;
-		}
-	}
 	device->state = DASD_STATE_KNOWN;
 	return 0;
 }
@@ -226,9 +205,6 @@ static int dasd_state_known_to_new(struct dasd_device *device)
 	dasd_eer_disable(device);
 	device->state = DASD_STATE_NEW;
 
-	if (device->block)
-		dasd_free_queue(device->block);
-
 	/* Give up reference we took in dasd_state_new_to_known. */
 	dasd_put_device(device);
 	return 0;
@@ -1591,9 +1567,8 @@ void dasd_generic_handle_state_change(struct dasd_device *device)
 	dasd_schedule_device_bh(device);
 	if (device->block) {
 		dasd_schedule_block_bh(device->block);
-		if (device->block->request_queue)
-			blk_mq_run_hw_queues(device->block->request_queue,
-					     true);
+		if (device->block->gdp)
+			blk_mq_run_hw_queues(device->block->gdp->queue, true);
 	}
 }
 EXPORT_SYMBOL_GPL(dasd_generic_handle_state_change);
@@ -2691,7 +2666,7 @@ static void dasd_block_timeout(struct timer_list *t)
 	dasd_device_remove_stop_bits(block->base, DASD_STOPPED_PENDING);
 	spin_unlock_irqrestore(get_ccwdev_lock(block->base->cdev), flags);
 	dasd_schedule_block_bh(block);
-	blk_mq_run_hw_queues(block->request_queue, true);
+	blk_mq_run_hw_queues(block->gdp->queue, true);
 }
 
 /*
@@ -3239,7 +3214,7 @@ static void dasd_request_done(struct request *req)
 	blk_mq_run_hw_queues(req->q, true);
 }
 
-static struct blk_mq_ops dasd_mq_ops = {
+struct blk_mq_ops dasd_mq_ops = {
 	.queue_rq = do_dasd_request,
 	.complete = dasd_request_done,
 	.timeout = dasd_times_out,
@@ -3247,45 +3222,6 @@ static struct blk_mq_ops dasd_mq_ops = {
 	.exit_hctx = dasd_exit_hctx,
 };
 
-/*
- * Allocate and initialize request queue and default I/O scheduler.
- */
-static int dasd_alloc_queue(struct dasd_block *block)
-{
-	int rc;
-
-	block->tag_set.ops = &dasd_mq_ops;
-	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
-	block->tag_set.nr_hw_queues = nr_hw_queues;
-	block->tag_set.queue_depth = queue_depth;
-	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	block->tag_set.numa_node = NUMA_NO_NODE;
-
-	rc = blk_mq_alloc_tag_set(&block->tag_set);
-	if (rc)
-		return rc;
-
-	block->request_queue = blk_mq_init_queue(&block->tag_set);
-	if (IS_ERR(block->request_queue))
-		return PTR_ERR(block->request_queue);
-
-	block->request_queue->queuedata = block;
-
-	return 0;
-}
-
-/*
- * Deactivate and free request queue.
- */
-static void dasd_free_queue(struct dasd_block *block)
-{
-	if (block->request_queue) {
-		blk_mq_destroy_queue(block->request_queue);
-		blk_mq_free_tag_set(&block->tag_set);
-		block->request_queue = NULL;
-	}
-}
-
 static int dasd_open(struct block_device *bdev, fmode_t mode)
 {
 	struct dasd_device *base;
@@ -3762,10 +3698,9 @@ int dasd_generic_path_operational(struct dasd_device *device)
 	dasd_schedule_device_bh(device);
 	if (device->block) {
 		dasd_schedule_block_bh(device->block);
-		if (device->block->request_queue)
-			blk_mq_run_hw_queues(device->block->request_queue,
-					     true);
-		}
+		if (device->block->gdp)
+			blk_mq_run_hw_queues(device->block->gdp->queue, true);
+	}
 
 	if (!device->stopped)
 		wake_up(&generic_waitq);
@@ -3916,8 +3851,8 @@ void dasd_generic_space_avail(struct dasd_device *device)
 
 	if (device->block) {
 		dasd_schedule_block_bh(device->block);
-		if (device->block->request_queue)
-			blk_mq_run_hw_queues(device->block->request_queue, true);
+		if (device->block->gdp)
+			blk_mq_run_hw_queues(device->block->gdp->queue, true);
 	}
 	if (!device->stopped)
 		wake_up(&generic_waitq);
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 811e79c9f59c8..677d6f4a98b64 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1334,7 +1334,6 @@ dasd_timeout_store(struct device *dev, struct device_attribute *attr,
 		   const char *buf, size_t count)
 {
 	struct dasd_device *device;
-	struct request_queue *q;
 	unsigned long val;
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
@@ -1346,15 +1345,13 @@ dasd_timeout_store(struct device *dev, struct device_attribute *attr,
 		dasd_put_device(device);
 		return -EINVAL;
 	}
-	q = device->block->request_queue;
-	if (!q) {
+	if (!device->block->gdp) {
 		dasd_put_device(device);
 		return -ENODEV;
 	}
 
 	device->blk_timeout = val;
-
-	blk_queue_rq_timeout(q, device->blk_timeout * HZ);
+	blk_queue_rq_timeout(device->block->gdp->queue, val * HZ);
 
 	dasd_put_device(device);
 	return count;
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index e9edf3b6ed7c0..5802aead09f36 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -627,7 +627,7 @@ dasd_diag_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 static void dasd_diag_setup_blk_queue(struct dasd_block *block)
 {
 	unsigned int logical_block_size = block->bp_block;
-	struct request_queue *q = block->request_queue;
+	struct request_queue *q = block->gdp->queue;
 	int max;
 
 	max = DIAG_MAX_BLOCKS << block->s2b_shift;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 836838f7d6867..592b92e035d53 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6602,7 +6602,7 @@ static void dasd_eckd_handle_hpf_error(struct dasd_device *device,
 static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 {
 	unsigned int logical_block_size = block->bp_block;
-	struct request_queue *q = block->request_queue;
+	struct request_queue *q = block->gdp->queue;
 	struct dasd_device *device = block->base;
 	int max;
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 60be7f7bf2d16..cddfb01a3dca1 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -767,7 +767,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 static void dasd_fba_setup_blk_queue(struct dasd_block *block)
 {
 	unsigned int logical_block_size = block->bp_block;
-	struct request_queue *q = block->request_queue;
+	struct request_queue *q = block->gdp->queue;
 	unsigned int max_bytes, max_discard_sectors;
 	int max;
 
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 5a83f0a39901b..998a961e17041 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -25,7 +25,14 @@
 
 #include "dasd_int.h"
 
-static struct lock_class_key dasd_bio_compl_lkclass;
+static unsigned int queue_depth = 32;
+static unsigned int nr_hw_queues = 4;
+
+module_param(queue_depth, uint, 0444);
+MODULE_PARM_DESC(queue_depth, "Default queue depth for new DASD devices");
+
+module_param(nr_hw_queues, uint, 0444);
+MODULE_PARM_DESC(nr_hw_queues, "Default number of hardware queues for new DASD devices");
 
 /*
  * Allocate and register gendisk structure for device.
@@ -41,10 +48,21 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (base->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
-	gdp = blk_mq_alloc_disk_for_queue(block->request_queue,
-					  &dasd_bio_compl_lkclass);
-	if (!gdp)
-		return -ENOMEM;
+	block->tag_set.ops = &dasd_mq_ops;
+	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
+	block->tag_set.nr_hw_queues = nr_hw_queues;
+	block->tag_set.queue_depth = queue_depth;
+	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	block->tag_set.numa_node = NUMA_NO_NODE;
+	rc = blk_mq_alloc_tag_set(&block->tag_set);
+	if (rc)
+		return rc;
+
+	gdp = blk_mq_alloc_disk(&block->tag_set, block);
+	if (IS_ERR(gdp)) {
+		blk_mq_free_tag_set(&block->tag_set);
+		return PTR_ERR(gdp);
+	}
 
 	/* Initialize gendisk structure. */
 	gdp->major = DASD_MAJOR;
@@ -100,6 +118,7 @@ void dasd_gendisk_free(struct dasd_block *block)
 		block->gdp->private_data = NULL;
 		put_disk(block->gdp);
 		block->gdp = NULL;
+		blk_mq_free_tag_set(&block->tag_set);
 	}
 }
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 333a399f754ec..ff04ae5cf88cd 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -588,7 +588,6 @@ struct dasd_device {
 struct dasd_block {
 	/* Block device stuff. */
 	struct gendisk *gdp;
-	struct request_queue *request_queue;
 	spinlock_t request_queue_lock;
 	struct blk_mq_tag_set tag_set;
 	struct block_device *bdev;
@@ -779,6 +778,7 @@ extern debug_info_t *dasd_debug_area;
 extern struct dasd_profile dasd_global_profile;
 extern unsigned int dasd_global_profile_level;
 extern const struct block_device_operations dasd_device_operations;
+extern struct blk_mq_ops dasd_mq_ops;
 
 extern struct kmem_cache *dasd_page_cache;
 
-- 
2.30.2

