Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMkN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 08:40:13 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] partitions/ibm: fix non-DASD devices
Date: Wed,  7 Oct 2020 14:40:09 +0200
Message-Id: <20201007124009.1438269-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, sth@linux.ibm.com, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>

Don't error out if the dasd_biodasdinfo symbol is not available.

Fixes: 26d7e28e3820 ("s390/dasd: remove ioctl_by_bdev calls")
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 block/partitions/ibm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index d6e18df9c53c6d..4b044e620d3534 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -305,8 +305,6 @@ int ibm_partition(struct parsed_partitions *state)
 	if (!disk->fops->getgeo)
 		goto out_exit;
 	fn = symbol_get(dasd_biodasdinfo);
-	if (!fn)
-		goto out_exit;
 	blocksize = bdev_logical_block_size(bdev);
 	if (blocksize <= 0)
 		goto out_symbol;
@@ -326,7 +324,7 @@ int ibm_partition(struct parsed_partitions *state)
 	geo->start = get_start_sect(bdev);
 	if (disk->fops->getgeo(bdev, geo))
 		goto out_freeall;
-	if (fn(disk, info)) {
+	if (!fn || fn(disk, info)) {
 		kfree(info);
 		info = NULL;
 	}
@@ -370,7 +368,8 @@ int ibm_partition(struct parsed_partitions *state)
 out_nogeo:
 	kfree(info);
 out_symbol:
-	symbol_put(dasd_biodasdinfo);
+	if (fn)
+		symbol_put(dasd_biodasdinfo);
 out_exit:
 	return res;
 }
-- 
2.28.0
