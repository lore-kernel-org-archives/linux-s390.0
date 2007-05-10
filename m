Return-Path: <linux-kernel-owner+w=401wt.eu-S1761869AbXEJN5M@vger.kernel.org>
Message-Id: <20070510135643.342303588@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/15] cio: Make some structures and a function static.
Content-Disposition: inline; filename=003-cio-static.diff
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

 drivers/s390/cio/css.c    |    3 +--
 drivers/s390/cio/css.h    |    2 --
 drivers/s390/cio/device.c |    4 ++--
 3 files changed, 3 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -191,8 +191,7 @@ static int css_register_subchannel(struc
 	return ret;
 }
 
-int
-css_probe_device(struct subchannel_id schid)
+static int css_probe_device(struct subchannel_id schid)
 {
 	int ret;
 	struct subchannel *sch;
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -138,9 +138,7 @@ struct css_driver {
  * all css_drivers have the css_bus_type
  */
 extern struct bus_type css_bus_type;
-extern struct css_driver io_subchannel_driver;
 
-extern int css_probe_device(struct subchannel_id);
 extern int css_sch_device_register(struct subchannel *);
 extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -129,7 +129,7 @@ static void io_subchannel_verify(struct 
 static void io_subchannel_ioterm(struct device *);
 static void io_subchannel_shutdown(struct subchannel *);
 
-struct css_driver io_subchannel_driver = {
+static struct css_driver io_subchannel_driver = {
 	.subchannel_type = SUBCHANNEL_TYPE_IO,
 	.drv = {
 		.name = "io_subchannel",
@@ -546,7 +546,7 @@ static struct attribute_group ccwdev_att
 	.attrs = ccwdev_attrs,
 };
 
-struct attribute_group *ccwdev_attr_groups[] = {
+static struct attribute_group *ccwdev_attr_groups[] = {
 	&ccwdev_attr_group,
 	NULL,
 };

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
