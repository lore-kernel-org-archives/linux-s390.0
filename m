Return-Path: <linux-kernel-owner+w=401wt.eu-S932091AbYEOPHq@vger.kernel.org>
Message-Id: <20080515150009.589155198@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/11] tape: Use ccw_dev_id to build cdev_id.
Content-Disposition: inline; filename=009-tape-devid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

To construct the integer containing the information from the bus_id,
it is easier to use the data from ccw_dev_id than to parse the bus_id.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape_core.c |   31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c
+++ quilt-2.6/drivers/s390/char/tape_core.c
@@ -76,32 +76,9 @@ const char *tape_op_verbose[TO_SIZE] =
 	[TO_KEKL_QUERY] = "KLQ",[TO_RDC] = "RDC",
 };
 
-static int
-busid_to_int(char *bus_id)
+static int devid_to_int(struct ccw_dev_id *dev_id)
 {
-	int	dec;
-	int	d;
-	char *	s;
-
-	for(s = bus_id, d = 0; *s != '\0' && *s != '.'; s++)
-		d = (d * 10) + (*s - '0');
-	dec = d;
-	for(s++, d = 0; *s != '\0' && *s != '.'; s++)
-		d = (d * 10) + (*s - '0');
-	dec = (dec << 8) + d;
-
-	for(s++; *s != '\0'; s++) {
-		if (*s >= '0' && *s <= '9') {
-			d = *s - '0';
-		} else if (*s >= 'a' && *s <= 'f') {
-			d = *s - 'a' + 10;
-		} else {
-			d = *s - 'A' + 10;
-		}
-		dec = (dec << 4) + d;
-	}
-
-	return dec;
+	return dev_id->devno + (dev_id->ssid << 16);
 }
 
 /*
@@ -551,6 +528,7 @@ tape_generic_probe(struct ccw_device *cd
 {
 	struct tape_device *device;
 	int ret;
+	struct ccw_dev_id dev_id;
 
 	device = tape_alloc_device();
 	if (IS_ERR(device))
@@ -565,7 +543,8 @@ tape_generic_probe(struct ccw_device *cd
 	cdev->dev.driver_data = device;
 	cdev->handler = __tape_do_irq;
 	device->cdev = cdev;
-	device->cdev_id = busid_to_int(cdev->dev.bus_id);
+	ccw_device_get_id(cdev, &dev_id);
+	device->cdev_id = devid_to_int(&dev_id);
 	PRINT_INFO("tape device %s found\n", cdev->dev.bus_id);
 	return ret;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
