Return-Path: <linux-kernel-owner+w=401wt.eu-S1759292AbXGQMWl@vger.kernel.org>
Message-Id: <20070717122314.604910917@de.ibm.com>
References: <20070717121747.591687140@de.ibm.com>
Date: Tue, 17 Jul 2007 14:17:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 7/8] cio: Dont print trailing \0 in modalias_show().
Content-Disposition: inline; filename=006-cio-modalias.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -272,7 +272,7 @@ modalias_show (struct device *dev, struc
 	struct ccw_device_id *id = &(cdev->id);
 	int len;
 
-	len = snprint_alias(buf, PAGE_SIZE, id, "\n") + 1;
+	len = snprint_alias(buf, PAGE_SIZE, id, "\n");
 
 	return len > PAGE_SIZE ? PAGE_SIZE : len;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
