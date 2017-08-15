Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 07/13] s390: tape_3590: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:38 +0530
Message-Id: <1502793344-5368-8-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/s390/char/tape_3590.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index e352047..576949e 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1627,7 +1627,7 @@ static struct tape_discipline tape_discipline_3590 = {
 	.mtop_array = tape_3590_mtop
 };
 
-static struct ccw_device_id tape_3590_ids[] = {
+static const struct ccw_device_id tape_3590_ids[] = {
 	{CCW_DEVICE_DEVTYPE(0x3590, 0, 0x3590, 0), .driver_info = tape_3590},
 	{CCW_DEVICE_DEVTYPE(0x3592, 0, 0x3592, 0), .driver_info = tape_3592},
 	{ /* end of list */ }
-- 
2.7.4
