Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390787AbgDNH3Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:25 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/10] block: remove hd_struct_kill
Date: Tue, 14 Apr 2020 09:28:56 +0200
Message-Id: <20200414072902.324936-5-hch@lst.de>
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>

The function has a single caller, so just open code it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk.h             | 5 -----
 block/partitions/core.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index b1a0b8cd87f0..204963bb03e8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -413,11 +413,6 @@ static inline void hd_struct_put(struct hd_struct *part)
 	percpu_ref_put(&part->ref);
 }
 
-static inline void hd_struct_kill(struct hd_struct *part)
-{
-	percpu_ref_kill(&part->ref);
-}
-
 static inline void hd_free_part(struct hd_struct *part)
 {
 	free_part_stats(part);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index c5b47627210a..7d062599aa33 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -321,7 +321,7 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
 	 * "in-use" until we really free the gendisk.
 	 */
 	blk_invalidate_devt(part_devt(part));
-	hd_struct_kill(part);
+	percpu_ref_kill(&part->ref);
 }
 
 static ssize_t whole_disk_show(struct device *dev,
-- 
2.25.1
