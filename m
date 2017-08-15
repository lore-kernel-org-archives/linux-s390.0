Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 09/13] s390: ctcm: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:40 +0530
Message-Id: <1502793344-5368-10-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/s390/net/ctcm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 1563b14..fb26206 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1737,7 +1737,7 @@ static int ctcm_pm_resume(struct ccwgroup_device *gdev)
 	return rc;
 }
 
-static struct ccw_device_id ctcm_ids[] = {
+static const struct ccw_device_id ctcm_ids[] = {
 	{CCW_DEVICE(0x3088, 0x08), .driver_info = ctcm_channel_type_parallel},
 	{CCW_DEVICE(0x3088, 0x1e), .driver_info = ctcm_channel_type_ficon},
 	{CCW_DEVICE(0x3088, 0x1f), .driver_info = ctcm_channel_type_escon},
-- 
2.7.4
