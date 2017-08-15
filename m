Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 03/13] s390: dasd_fba: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:34 +0530
Message-Id: <1502793344-5368-4-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1502793344-5368-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502793344-5368-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com, jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, maier@linux.vnet.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

ccw_device_id are not supposed to change at runtime. All functions
working with ccw_device_id provided by <asm/ccwdev.h> work with
const ccw_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/s390/block/dasd_fba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 462cab5..2f7c044 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -44,7 +44,7 @@ struct dasd_fba_private {
 	struct dasd_fba_characteristics rdc_data;
 };
 
-static struct ccw_device_id dasd_fba_ids[] = {
+static const struct ccw_device_id dasd_fba_ids[] = {
 	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), .driver_info = 0x1},
 	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), .driver_info = 0x2},
 	{ /* end of list */ },
-- 
2.7.4
