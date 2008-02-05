Return-Path: <linux-kernel-owner+w=401wt.eu-S1758858AbYBEPns@vger.kernel.org>
Message-Id: <20080205153916.234022436@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/18] dcss: Initialize workqueue before using it.
Content-Disposition: inline; filename=018-dcss-workqueue.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <geraldsc@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

In case a dcss segment cannot be loaded blk_cleanup_queue
will be called before blk_queue_make_request, leaving the
struct work unplug_work of the request queue uninitialized
before it is used.
That leads also to the lockdep message below.
To avoid that call blk_queue_make_request right after the
request_queue has been allocated. 
This makes sure that the struct work is always initialized
before it is used.

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 2 Not tainted 2.6.24 #6
Process swapper (pid: 1, task: 000000000f854038, ksp: 000000000f85f980)
040000000f85f860 000000000f85f880 0000000000000002 0000000000000000 
       000000000f85f920 000000000f85f898 000000000f85f898 000000000001622e 
       0000000000000000 000000000f85f980 0000000000000000 0000000000000000 
       000000000f85f880 000000000000000c 000000000f85f880 000000000f85f8f0 
       0000000000342908 000000000001622e 000000000f85f880 000000000f85f8d0 
Call Trace:
([<000000000001619e>] show_trace+0xda/0x104)
 [<0000000000016288>] show_stack+0xc0/0xf8
 [<00000000000163d0>] dump_stack+0xb0/0xc0
 [<000000000006e4ea>] __lock_acquire+0x47e/0x1160
 [<000000000006f27c>] lock_acquire+0xb0/0xd8
 [<000000000005a522>] __cancel_work_timer+0x9e/0x240
 [<000000000005a72e>] cancel_work_sync+0x2a/0x3c
 [<0000000000165c46>] kblockd_flush_work+0x26/0x34
 [<0000000000169034>] blk_sync_queue+0x38/0x48
 [<0000000000169080>] blk_release_queue+0x3c/0xa8
 [<000000000017bce8>] kobject_cleanup+0x58/0xac
 [<000000000017bd66>] kobject_release+0x2a/0x38
 [<000000000017d28e>] kref_put+0x6e/0x94
 [<000000000017bc80>] kobject_put+0x38/0x48
 [<00000000001653be>] blk_put_queue+0x2a/0x38
 [<0000000000168fee>] blk_cleanup_queue+0x82/0x90
 [<0000000000213e7e>] dcssblk_add_store+0x34e/0x700
 [<00000000005243b8>] dcssblk_init+0x1a0/0x308
 [<000000000050a3c2>] kernel_init+0x1b2/0x3a4
 [<000000000001ac82>] kernel_thread_starter+0x6/0xc
 [<000000000001ac7c>] kernel_thread_starter+0x0/0xc

INFO: lockdep is turned off.

Cc: Gerald Schaefer <geraldsc@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dcssblk.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dcssblk.c
+++ quilt-2.6/drivers/s390/block/dcssblk.c
@@ -415,6 +415,8 @@ dcssblk_add_store(struct device *dev, st
 	dev_info->gd->queue = dev_info->dcssblk_queue;
 	dev_info->gd->private_data = dev_info;
 	dev_info->gd->driverfs_dev = &dev_info->dev;
+	blk_queue_make_request(dev_info->dcssblk_queue, dcssblk_make_request);
+	blk_queue_hardsect_size(dev_info->dcssblk_queue, 4096);
 	/*
 	 * load the segment
 	 */
@@ -472,9 +474,6 @@ dcssblk_add_store(struct device *dev, st
 	if (rc)
 		goto unregister_dev;
 
-	blk_queue_make_request(dev_info->dcssblk_queue, dcssblk_make_request);
-	blk_queue_hardsect_size(dev_info->dcssblk_queue, 4096);
-
 	add_disk(dev_info->gd);
 
 	switch (dev_info->segment_type) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
