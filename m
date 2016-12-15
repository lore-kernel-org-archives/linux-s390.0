Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 1/2] s390/zcore: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 15:18:23 +0100
Message-Id: <20161215141824.3297-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: maier@linux.vnet.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

drivers/s390/char/zcore.c does not contain any miscdevice so the
inclusion of linux/miscdevice.h is uncessary.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/s390/char/zcore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index f771e5e..47b54eb 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -15,7 +15,6 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/miscdevice.h>
 #include <linux/debugfs.h>
 #include <linux/memblock.h>
 
-- 
2.10.2
