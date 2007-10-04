Return-Path: <linux-kernel-owner+w=401wt.eu-S1760317AbXJDLe6@vger.kernel.org>
Message-Id: <20071004112831.509745968@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 25/34] is_power_of_2 in drivers/s390/block/dasd_int.h
Content-Disposition: inline; filename=025-power2-dasd.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: vignesh babu <vignesh.babu@wipro.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: vignesh babu <vignesh.babu@wipro.com>

Replacing n & (n - 1) for power of 2 check by is_power_of_2(n)

Signed-off-by: vignesh babu <vignesh.babu@wipro.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd_int.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h
+++ quilt-2.6/drivers/s390/block/dasd_int.h
@@ -53,6 +53,7 @@
 #include <linux/genhd.h>
 #include <linux/hdreg.h>
 #include <linux/interrupt.h>
+#include <linux/log2.h>
 #include <asm/ccwdev.h>
 #include <linux/workqueue.h>
 #include <asm/debug.h>
@@ -456,7 +457,7 @@ dasd_free_chunk(struct list_head *chunk_
 static inline int
 dasd_check_blocksize(int bsize)
 {
-	if (bsize < 512 || bsize > 4096 || (bsize & (bsize - 1)) != 0)
+	if (bsize < 512 || bsize > 4096 || !is_power_of_2(bsize))
 		return -EMEDIUMTYPE;
 	return 0;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
