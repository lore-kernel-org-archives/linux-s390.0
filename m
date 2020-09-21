Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgIUHUQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 03:20:16 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/14] mm: cleanup claim_swapfile
Date: Mon, 21 Sep 2020 09:19:54 +0200
Message-Id: <20200921071958.307589-11-hch@lst.de>
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-ide@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org

Use blkdev_get_by_dev instead of bdgrab + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 12f59e641b5e29..7438c4affc75fa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2920,10 +2920,10 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 	int error;
 
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev = bdgrab(I_BDEV(inode));
-		error = blkdev_get(p->bdev,
+		p->bdev = blkdev_get_by_dev(inode->i_rdev,
 				   FMODE_READ | FMODE_WRITE | FMODE_EXCL, p);
-		if (error < 0) {
+		if (IS_ERR(p->bdev)) {
+			error = PTR_ERR(p->bdev);
 			p->bdev = NULL;
 			return error;
 		}
-- 
2.28.0
