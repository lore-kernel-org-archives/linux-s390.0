Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] s390: Fix me in dasd_eer.c
Date: Tue, 22 Jul 2014 02:29:32 -0400
Message-Id: <1406010572-13217-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: wein@de.ibm.com
Cc: stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch changes return type to EMEDUIMTYPE in function, dasd_eer_enable
for when checking if the medium has no errors according to this function.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/s390/block/dasd_eer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 21ef63c..08ee040 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -462,7 +462,7 @@ int dasd_eer_enable(struct dasd_device *device)
 		return 0;
 
 	if (!device->discipline || strcmp(device->discipline->name, "ECKD"))
-		return -EPERM;	/* FIXME: -EMEDIUMTYPE ? */
+		return -EMEDIUMTYPE;	/* FIXME: -EMEDIUMTYPE ? */
 
 	cqr = dasd_kmalloc_request(DASD_ECKD_MAGIC, 1 /* SNSS */,
 				   SNSS_DATA_SIZE, device);
-- 
1.9.1
