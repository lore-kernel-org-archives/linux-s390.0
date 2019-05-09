Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
From: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] s390/dasd: fix build warning in dasd_eckd_build_cp_raw
Date: Thu,  9 May 2019 18:03:14 +0800
Message-Id: <20190509100314.19152-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit 72deb455b5ec619f ("block: remove CONFIG_LBDAF") changes
sector_t to u64 unconditionaly, so apply '%llu' for print
sector_t variable.

Fixes: 72deb455b5ec619f ("block: remove CONFIG_LBDAF")
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/s390/block/dasd_eckd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index f89f9d02e788..c09039eea707 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3827,7 +3827,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 	if ((start_padding_sectors || end_padding_sectors) &&
 	    (rq_data_dir(req) == WRITE)) {
 		DBF_DEV_EVENT(DBF_ERR, basedev,
-			      "raw write not track aligned (%lu,%lu) req %p",
+			      "raw write not track aligned (%llu,%llu) req %p",
 			      start_padding_sectors, end_padding_sectors, req);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.9.5
