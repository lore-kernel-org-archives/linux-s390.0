Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgICFlN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 01:41:13 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/9] drbd: don't detour through bd_contains for the gendisk
Date: Thu,  3 Sep 2020 07:41:00 +0200
Message-Id: <20200903054104.228829-6-hch@lst.de>
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
References: <20200903054104.228829-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org

bd_disk is set on all block devices, including those for partitions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_worker.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 422363daa6180b..2d16fb0905999d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2789,7 +2789,7 @@ bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 
 bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 {
-	struct gendisk *disk = device->ldev->backing_bdev->bd_contains->bd_disk;
+	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
 	unsigned long db, dt, dbdt;
 	unsigned int c_min_rate;
 	int curr_events;
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 7c903de5c4e103..9107b109ba7bcb 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1672,7 +1672,7 @@ void drbd_resync_after_changed(struct drbd_device *device)
 
 void drbd_rs_controller_reset(struct drbd_device *device)
 {
-	struct gendisk *disk = device->ldev->backing_bdev->bd_contains->bd_disk;
+	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
 	struct fifo_buffer *plan;
 
 	atomic_set(&device->rs_sect_in, 0);
-- 
2.28.0
