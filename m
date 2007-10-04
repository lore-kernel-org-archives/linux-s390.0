Return-Path: <linux-kernel-owner+w=401wt.eu-S1760243AbXJDLb5@vger.kernel.org>
Message-Id: <20071004112827.572861959@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/34] cio: Fix device attributes for early devices.
Content-Disposition: inline; filename=011-cio-early-attributes.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Don't forget to set dev->groups for early ccw devices like the
console device so the default attributes are created.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -1123,6 +1123,7 @@ io_subchannel_probe (struct subchannel *
 		 * device, e.g. the console.
 		 */
 		cdev = sch->dev.driver_data;
+		cdev->dev.groups = ccwdev_attr_groups;
 		device_initialize(&cdev->dev);
 		ccw_device_register(cdev);
 		/*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
