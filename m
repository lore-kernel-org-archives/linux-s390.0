Return-Path: <linux-kernel-owner+w=401wt.eu-S933362AbYCEL6p@vger.kernel.org>
Message-Id: <20080305115714.450809645@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/10] zcrypt: fix ap_device_list handling
Content-Disposition: inline; filename=007-crypto-probe.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ralph Wuerthner <rwuerthn@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

In ap_device_probe() we can add the new ap device to the internal 
device list only if the device probe function successfully returns. 
Otherwise we might end up with an invalid device in the internal ap 
device list.

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -490,10 +490,12 @@ static int ap_device_probe(struct device
 	int rc;
 
 	ap_dev->drv = ap_drv;
-	spin_lock_bh(&ap_device_lock);
-	list_add(&ap_dev->list, &ap_device_list);
-	spin_unlock_bh(&ap_device_lock);
 	rc = ap_drv->probe ? ap_drv->probe(ap_dev) : -ENODEV;
+	if (!rc) {
+		spin_lock_bh(&ap_device_lock);
+		list_add(&ap_dev->list, &ap_device_list);
+		spin_unlock_bh(&ap_device_lock);
+	}
 	return rc;
 }
 
@@ -532,11 +534,11 @@ static int ap_device_remove(struct devic
 
 	ap_flush_queue(ap_dev);
 	del_timer_sync(&ap_dev->timeout);
-	if (ap_drv->remove)
-		ap_drv->remove(ap_dev);
 	spin_lock_bh(&ap_device_lock);
 	list_del_init(&ap_dev->list);
 	spin_unlock_bh(&ap_device_lock);
+	if (ap_drv->remove)
+		ap_drv->remove(ap_dev);
 	spin_lock_bh(&ap_dev->lock);
 	atomic_sub(ap_dev->queue_count, &ap_poll_requests);
 	spin_unlock_bh(&ap_dev->lock);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
