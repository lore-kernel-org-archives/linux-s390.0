Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 05/13] s390: raw3270: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:36 +0530
Message-Id: <1502793344-5368-6-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/s390/char/raw3270.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 710f229..e51362c 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1267,7 +1267,7 @@ void raw3270_pm_unfreeze(struct raw3270_view *view)
 #endif
 }
 
-static struct ccw_device_id raw3270_id[] = {
+static const struct ccw_device_id raw3270_id[] = {
 	{ CCW_DEVICE(0x3270, 0) },
 	{ CCW_DEVICE(0x3271, 0) },
 	{ CCW_DEVICE(0x3272, 0) },
-- 
2.7.4
