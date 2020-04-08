Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbgDHTpH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:45:07 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/10] block: fold bdev_unhash_inode into invalidate_partition
Date: Wed,  8 Apr 2020 21:44:39 +0200
Message-Id: <20200408194439.1580699-11-hch@lst.de>
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

invalidate_partition and bdev_unhash_inode are always paired, and
invalidate_partition already does an icache lookup for the block device
inode.  Piggy back on that to remove the inode from the hash.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c      |  8 ++++++--
 fs/block_dev.c     | 15 ---------------
 include/linux/fs.h |  1 -
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 980a4609d4a5..c05d509877fa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -888,6 +888,12 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 
 	fsync_bdev(bdev);
 	__invalidate_device(bdev, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it gets evicted as soon
+	 * as last inode reference is dropped.
+	 */
+	remove_inode_hash(bdev->bd_inode);
 	bdput(bdev);
 }
 
@@ -909,13 +915,11 @@ void del_gendisk(struct gendisk *disk)
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
 		invalidate_partition(disk, part->partno);
-		bdev_unhash_inode(part_devt(part));
 		delete_partition(disk, part);
 	}
 	disk_part_iter_exit(&piter);
 
 	invalidate_partition(disk, 0);
-	bdev_unhash_inode(disk_devt(disk));
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&disk->lookup_sem);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9c8de54fa0c9..998820174d3e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -883,21 +883,6 @@ static int bdev_set(struct inode *inode, void *data)
 
 static LIST_HEAD(all_bdevs);
 
-/*
- * If there is a bdev inode for this device, unhash it so that it gets evicted
- * as soon as last inode reference is dropped.
- */
-void bdev_unhash_inode(dev_t dev)
-{
-	struct inode *inode;
-
-	inode = ilookup5(blockdev_superblock, hash(dev), bdev_test, &dev);
-	if (inode) {
-		remove_inode_hash(inode);
-		iput(inode);
-	}
-}
-
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2b4e9f86b151..1a95e5158811 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2581,7 +2581,6 @@ extern struct kmem_cache *names_cachep;
 #ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern void unregister_blkdev(unsigned int, const char *);
-extern void bdev_unhash_inode(dev_t dev);
 extern struct block_device *bdget(dev_t);
 extern struct block_device *bdgrab(struct block_device *bdev);
 extern void bd_set_size(struct block_device *, loff_t size);
-- 
2.25.1
