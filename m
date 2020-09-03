Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgICIaY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 04:30:24 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] dasd: remove the unused dasd_enable_device export
Date: Thu,  3 Sep 2020 10:30:18 +0200
Message-Id: <20200903083018.507894-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: sth@linux.ibm.com, hoeppner@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index eb17fea8075c6f..6ab992b3eed004 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -683,7 +683,6 @@ void dasd_enable_device(struct dasd_device *device)
 	if (device->discipline->kick_validate)
 		device->discipline->kick_validate(device);
 }
-EXPORT_SYMBOL(dasd_enable_device);
 
 /*
  * SECTION: device operation (interrupt handler, start i/o, term i/o ...)
-- 
2.28.0
