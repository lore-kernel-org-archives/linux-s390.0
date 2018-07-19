Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 18 Jul 2018 23:46:53 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390/tape: replace PTR_RET with PTR_ERR_OR_ZERO
Message-ID: <20180719044653.GA24968@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-s390.vger.kernel.org>

PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/s390/char/tape_class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index e403edf..b58df0d 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -77,7 +77,7 @@ struct tape_class_device *register_tape_dev(
 	tcd->class_device = device_create(tape_class, device,
 					  tcd->char_device->dev, NULL,
 					  "%s", tcd->device_name);
-	rc = PTR_RET(tcd->class_device);
+	rc = PTR_ERR_OR_ZERO(tcd->class_device);
 	if (rc)
 		goto fail_with_cdev;
 	rc = sysfs_create_link(
-- 
2.7.4
