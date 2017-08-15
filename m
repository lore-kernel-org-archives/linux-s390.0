Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 04/13] s390: con3215: constify ccw_device_id
Date: Tue, 15 Aug 2017 16:05:35 +0530
Message-Id: <1502793344-5368-5-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/s390/char/con3215.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 9ec4ae0..632874d 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -791,7 +791,7 @@ static int raw3215_pm_start(struct ccw_device *cdev)
 	return 0;
 }
 
-static struct ccw_device_id raw3215_id[] = {
+static const struct ccw_device_id raw3215_id[] = {
 	{ CCW_DEVICE(0x3215, 0) },
 	{ /* end of list */ },
 };
-- 
2.7.4
