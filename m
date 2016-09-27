Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] s390/dasd: add missing \n to end of dev_err messages
Date: Tue, 27 Sep 2016 12:13:18 -0700
Message-Id: <20160927191318.15264-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/s390/block/dasd_erp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index e1e8848..d138d01 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -169,12 +169,12 @@ dasd_log_sense(struct dasd_ccw_req *cqr, struct irb *irb)
 	device = cqr->startdev;
 	if (cqr->intrc == -ETIMEDOUT) {
 		dev_err(&device->cdev->dev,
-			"A timeout error occurred for cqr %p", cqr);
+			"A timeout error occurred for cqr %p\n", cqr);
 		return;
 	}
 	if (cqr->intrc == -ENOLINK) {
 		dev_err(&device->cdev->dev,
-			"A transport error occurred for cqr %p", cqr);
+			"A transport error occurred for cqr %p\n", cqr);
 		return;
 	}
 	/* dump sense data */
-- 
2.9.3
