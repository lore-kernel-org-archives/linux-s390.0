Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 10/13] s390: lcs: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:41 +0530
Message-Id: <1502793344-5368-11-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/s390/net/lcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 619da81..55179ca 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -2373,7 +2373,7 @@ static int lcs_restore(struct ccwgroup_device *gdev)
 	return lcs_pm_resume(card);
 }
 
-static struct ccw_device_id lcs_ids[] = {
+static const struct ccw_device_id lcs_ids[] = {
 	{CCW_DEVICE(0x3088, 0x08), .driver_info = lcs_channel_type_parallel},
 	{CCW_DEVICE(0x3088, 0x1f), .driver_info = lcs_channel_type_2216},
 	{CCW_DEVICE(0x3088, 0x60), .driver_info = lcs_channel_type_osa2},
-- 
2.7.4
