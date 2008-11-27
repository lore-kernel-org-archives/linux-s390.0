Return-Path: <linux-kernel-owner+w=401wt.eu-S1756896AbYK0Kx3@vger.kernel.org>
Message-Id: <20081127103136.171738662@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 30/60] dasd: Use accessors instead of using driver_data directly.
Content-Disposition: inline; filename=129-dasd-accessors.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c
@@ -562,7 +562,7 @@ dasd_create_device(struct ccw_device *cd
 	}
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
-	cdev->dev.driver_data = device;
+	dev_set_drvdata(&cdev->dev, device);
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 
 	return device;
@@ -598,7 +598,7 @@ dasd_delete_device(struct dasd_device *d
 
 	/* Disconnect dasd_device structure from ccw_device structure. */
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	device->cdev->dev.driver_data = NULL;
+	dev_set_drvdata(&device->cdev->dev, NULL);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 
 	/*
@@ -639,7 +639,7 @@ dasd_put_device_wake(struct dasd_device 
 struct dasd_device *
 dasd_device_from_cdev_locked(struct ccw_device *cdev)
 {
-	struct dasd_device *device = cdev->dev.driver_data;
+	struct dasd_device *device = dev_get_drvdata(&cdev->dev);
 
 	if (!device)
 		return ERR_PTR(-ENODEV);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
