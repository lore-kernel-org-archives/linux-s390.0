Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH 5/5] s390:block:fix up ENOIOCTLCMD error handling
Date: Mon, 27 Aug 2012 15:23:16 +0800
Message-Id: <1346052196-32682-6-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1346052196-32682-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1346052196-32682-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, "open list:S390" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

At commit 07d106d0, Linus pointed out that ENOIOCTLCMD should be
translated as ENOTTY to user mode.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org (open list:S390)
Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/s390/block/dasd_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index cceae70..809a89b 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -501,7 +501,7 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 		if (base->discipline->ioctl) {
 			rc = base->discipline->ioctl(block, cmd, argp);
 			if (rc == -ENOIOCTLCMD)
-				rc = -EINVAL;
+				rc = -ENOTTY;
 		} else
 			rc = -EINVAL;
 	}
-- 
1.7.12
