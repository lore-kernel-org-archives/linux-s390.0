Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgICFlP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 01:41:15 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/9] target/iblock: fix holder printing in iblock_show_configfs_dev_params
Date: Thu,  3 Sep 2020 07:41:02 +0200
Message-Id: <20200903054104.228829-8-hch@lst.de>
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
References: <20200903054104.228829-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org

bd_contains is never NULL for an open block device.  In addition ibd_bd
is always set to a block device that was exclusively opened by the
target code, so the holder is guranteed to be ib_dev as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_iblock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1c181d31f4c872..f2bd2e207e0b36 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -611,9 +611,8 @@ static ssize_t iblock_show_configfs_dev_params(struct se_device *dev, char *b)
 	bl += sprintf(b + bl, "        ");
 	if (bd) {
 		bl += sprintf(b + bl, "Major: %d Minor: %d  %s\n",
-			MAJOR(bd->bd_dev), MINOR(bd->bd_dev), (!bd->bd_contains) ?
-			"" : (bd->bd_holder == ib_dev) ?
-			"CLAIMED: IBLOCK" : "CLAIMED: OS");
+			MAJOR(bd->bd_dev), MINOR(bd->bd_dev),
+			"CLAIMED: IBLOCK");
 	} else {
 		bl += sprintf(b + bl, "Major: 0 Minor: 0\n");
 	}
-- 
2.28.0
