Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 08/13] s390: vmur: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:39 +0530
Message-Id: <1502793344-5368-9-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/s390/char/vmur.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index 04aceb6..3d0cf06 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -49,7 +49,7 @@ static struct class *vmur_class;
 static struct debug_info *vmur_dbf;
 
 /* We put the device's record length (for writes) in the driver_info field */
-static struct ccw_device_id ur_ids[] = {
+static const struct ccw_device_id ur_ids[] = {
 	{ CCWDEV_CU_DI(READER_PUNCH_DEVTYPE, 80) },
 	{ CCWDEV_CU_DI(PRINTER_DEVTYPE, 132) },
 	{ /* end of list */ }
-- 
2.7.4
