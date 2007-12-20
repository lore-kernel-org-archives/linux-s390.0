Return-Path: <linux-kernel-owner+w=401wt.eu-S934167AbXLTPWe@vger.kernel.org>
Message-Id: <20071220152103.587022017@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:28 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/47] cio: Use helpers instead of container_of().
Content-Disposition: inline; filename=102-cio-helpers.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

- Introduce to_cssdriver.
- Use to_xxx instead of container_of where possible.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c |    4 ++--
 drivers/s390/cio/css.c      |    6 +++---
 drivers/s390/cio/css.h      |    2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c
@@ -35,8 +35,8 @@ ccwgroup_bus_match (struct device * dev,
 	struct ccwgroup_device *gdev;
 	struct ccwgroup_driver *gdrv;
 
-	gdev = container_of(dev, struct ccwgroup_device, dev);
-	gdrv = container_of(drv, struct ccwgroup_driver, driver);
+	gdev = to_ccwgroupdev(dev);
+	gdrv = to_ccwgroupdrv(drv);
 
 	if (gdev->creator_id == gdrv->driver_id)
 		return 1;
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -787,8 +787,8 @@ int sch_is_pseudo_sch(struct subchannel 
 static int
 css_bus_match (struct device *dev, struct device_driver *drv)
 {
-	struct subchannel *sch = container_of (dev, struct subchannel, dev);
-	struct css_driver *driver = container_of (drv, struct css_driver, drv);
+	struct subchannel *sch = to_subchannel(dev);
+	struct css_driver *driver = to_cssdriver(drv);
 
 	if (sch->st == driver->subchannel_type)
 		return 1;
@@ -802,7 +802,7 @@ css_probe (struct device *dev)
 	struct subchannel *sch;
 
 	sch = to_subchannel(dev);
-	sch->driver = container_of (dev->driver, struct css_driver, drv);
+	sch->driver = to_cssdriver(dev->driver);
 	return (sch->driver->probe ? sch->driver->probe(sch) : 0);
 }
 
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -134,6 +134,8 @@ struct css_driver {
 	void (*shutdown)(struct subchannel *);
 };
 
+#define to_cssdriver(n) container_of(n, struct css_driver, drv)
+
 /*
  * all css_drivers have the css_bus_type
  */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
