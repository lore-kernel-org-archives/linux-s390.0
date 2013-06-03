Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 5/9] dasd: Reduce amount of messages for specific errors
Date: Mon,  3 Jun 2013 17:03:18 +0200
Message-Id: <1370271802-30019-6-git-send-email-schwidefsky@de.ibm.com>
In-Reply-To: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
References: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Hannes Reinecke <hare@suse.de>, Stefan Weinhuber <wein@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

Whenever a request has been aborted internally by the driver
there is no sense data to be had. And printing lots of messages
stalls the system, so better to print out a short one-liner.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/block/dasd_erp.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index 3250cb4..8d11f77 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -159,6 +159,14 @@ dasd_log_sense(struct dasd_ccw_req *cqr, struct irb *irb)
 	struct dasd_device *device;
 
 	device = cqr->startdev;
+	if (cqr->intrc == -ETIMEDOUT) {
+		dev_err(&device->cdev->dev, "cqr %p timeout error", cqr);
+		return;
+	}
+	if (cqr->intrc == -ENOLINK) {
+		dev_err(&device->cdev->dev, "cqr %p transport error", cqr);
+		return;
+	}
 	/* dump sense data */
 	if (device->discipline && device->discipline->dump_sense)
 		device->discipline->dump_sense(device, cqr, irb);
-- 
1.7.9.5
