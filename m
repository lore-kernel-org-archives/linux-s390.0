Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 18 Jul 2018 23:50:50 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390/dasd: replace PTR_RET with PTR_ERR_OR_ZERO
Message-ID: <20180719045050.GA25103@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-s390.vger.kernel.org>

PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/s390/block/dasd_eckd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index bbf95b7..c5a5551 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3535,7 +3535,7 @@ static int prepare_itcw(struct itcw *itcw,
 
 	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
 		     &pfxdata, sizeof(pfxdata), total_data_size);
-	return PTR_RET(dcw);
+	return PTR_ERR_OR_ZERO(dcw);
 }
 
 static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
-- 
2.7.4
