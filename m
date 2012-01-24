Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Jan 2012 13:35:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3/5] cio: remove {get,put}_driver
Message-ID: <Pine.LNX.4.44L0.1201241315180.1200-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Remove useless {get,put}_driver - the caller of the functions
has to ensure valid driver pointers.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/ccwgroup.c |    2 --
 drivers/s390/cio/device.c   |    8 +-------
 2 files changed, 1 insertion(+), 9 deletions(-)

Index: usb-3.3/drivers/s390/cio/ccwgroup.c
===================================================================
--- usb-3.3.orig/drivers/s390/cio/ccwgroup.c
+++ usb-3.3/drivers/s390/cio/ccwgroup.c
@@ -580,7 +580,6 @@ void ccwgroup_driver_unregister(struct c
 	struct device *dev;
 
 	/* We don't want ccwgroup devices to live longer than their driver. */
-	get_driver(&cdriver->driver);
 	while ((dev = driver_find_device(&cdriver->driver, NULL, NULL,
 					 __ccwgroup_match_all))) {
 		struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
@@ -592,7 +591,6 @@ void ccwgroup_driver_unregister(struct c
 		mutex_unlock(&gdev->reg_mutex);
 		put_device(dev);
 	}
-	put_driver(&cdriver->driver);
 	driver_unregister(&cdriver->driver);
 }
 EXPORT_SYMBOL(ccwgroup_driver_unregister);
Index: usb-3.3/drivers/s390/cio/device.c
===================================================================
--- usb-3.3.orig/drivers/s390/cio/device.c
+++ usb-3.3/drivers/s390/cio/device.c
@@ -1676,15 +1676,9 @@ struct ccw_device *get_ccwdev_by_busid(s
 				       const char *bus_id)
 {
 	struct device *dev;
-	struct device_driver *drv;
 
-	drv = get_driver(&cdrv->driver);
-	if (!drv)
-		return NULL;
-
-	dev = driver_find_device(drv, NULL, (void *)bus_id,
+	dev = driver_find_device(&cdrv->driver, NULL, (void *)bus_id,
 				 __ccwdev_check_busid);
-	put_driver(drv);
 
 	return dev ? to_ccwdev(dev) : NULL;
 }
