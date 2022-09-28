Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A4C04A95
	for <linux-s390@archiver.kernel.org>; Wed, 28 Sep 2022 14:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiI1Oj7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiI1Oj5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Sep 2022 10:39:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C92193;
        Wed, 28 Sep 2022 07:39:54 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SELjg1006600;
        Wed, 28 Sep 2022 14:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=77RP8tZ2OPf5NGyvdylm+oH4ZflNtKI+PMweG91K4vw=;
 b=cCOemz+ERDaFyTJYK8bbmkzSiMMnuwe02eFnPCk/lPf9treXm/YGHFdu9teQEvxWgDry
 8PvjhObpJ+rTXs+2InqcyeOnsHifNqa2nZ+kNAH/JGoIp14OfH4+gLAB+rm84m7lvptd
 zMGlFk/E/wTgRVQi0m71CirUhjyCUL1tKZd45uLwGsCufNubWPE8vv5NYP5zwT8HSmtX
 jgM19wyIa2Yv/UTRtJ8ipU7MNMefgPQqPCVukZW6hJKEs0IIaHoPUSElZ2MtyTkGqyi2
 beHWlvXxknaexFDPoQBTIYa/NC9bNVm5xlHP+OWEwGh11o63sSKt9lCy4rLysLYuDgZF KQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvpcwc2s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:39:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28SEZXfw004105;
        Wed, 28 Sep 2022 14:39:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapuk1da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:39:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28SEdkka2490934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 14:39:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A7C742041;
        Wed, 28 Sep 2022 14:39:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 389BB4203F;
        Wed, 28 Sep 2022 14:39:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 28 Sep 2022 14:39:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id F23FAE06BA; Wed, 28 Sep 2022 16:39:45 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/1] s390/dasd: use blk_mq_alloc_disk
Date:   Wed, 28 Sep 2022 16:39:45 +0200
Message-Id: <20220928143945.1687114-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928143945.1687114-1-sth@linux.ibm.com>
References: <20220928143945.1687114-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cWhYUPVYcX2AKn9fMgTISI5nLOFCFe7n
X-Proofpoint-ORIG-GUID: cWhYUPVYcX2AKn9fMgTISI5nLOFCFe7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxlogscore=888 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280086
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

As far as I can tell there is no need for the staged setup in
dasd, so allocate the tagset and the disk with the queue in
dasd_gendisk_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
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
index c03f26e79f45..5a6d9c15395f 100644
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
index 2f7341412ea9..1beb596d1434 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1578,7 +1578,6 @@ dasd_timeout_store(struct device *dev, struct device_attribute *attr,
 		   const char *buf, size_t count)
 {
 	struct dasd_device *device;
-	struct request_queue *q;
 	unsigned long val;
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
@@ -1590,15 +1589,13 @@ dasd_timeout_store(struct device *dev, struct device_attribute *attr,
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
index 94ee59864971..f956a4ac9881 100644
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
index 95b0cd071cad..662730f3b027 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6844,7 +6844,7 @@ static void dasd_eckd_handle_hpf_error(struct dasd_device *device,
 static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 {
 	unsigned int logical_block_size = block->bp_block;
-	struct request_queue *q = block->request_queue;
+	struct request_queue *q = block->gdp->queue;
 	struct dasd_device *device = block->base;
 	int max;
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 60be7f7bf2d1..cddfb01a3dca 100644
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
index 5a83f0a39901..998a961e1704 100644
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
index c7223c4eba52..97adc8a7ae6b 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -642,7 +642,6 @@ struct dasd_device {
 struct dasd_block {
 	/* Block device stuff. */
 	struct gendisk *gdp;
-	struct request_queue *request_queue;
 	spinlock_t request_queue_lock;
 	struct blk_mq_tag_set tag_set;
 	struct block_device *bdev;
@@ -850,6 +849,7 @@ extern debug_info_t *dasd_debug_area;
 extern struct dasd_profile dasd_global_profile;
 extern unsigned int dasd_global_profile_level;
 extern const struct block_device_operations dasd_device_operations;
+extern struct blk_mq_ops dasd_mq_ops;
 
 extern struct kmem_cache *dasd_page_cache;
 
-- 
2.34.1

