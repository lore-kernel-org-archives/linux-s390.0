Return-Path: <linux-kernel-owner+w=401wt.eu-S1757355AbYGAMvA@vger.kernel.org>
Message-Id: <20080701124959.143130207@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/14] css: Use css_device_id for bus matching.
Content-Disposition: inline; filename=126-cio-matching.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

css_device_id exists, so use it for determining the right driver
(and add a match_flags which is always 1 for valid types).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c          |   15 ++++++---------
 drivers/s390/cio/css.h          |    2 +-
 drivers/s390/cio/device.c       |    8 +++++++-
 include/linux/mod_devicetable.h |    2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -850,19 +850,16 @@ int sch_is_pseudo_sch(struct subchannel 
 	return sch == to_css(sch->dev.parent)->pseudo_subchannel;
 }
 
-/*
- * find a driver for a subchannel. They identify by the subchannel
- * type with the exception that the console subchannel driver has its own
- * subchannel type although the device is an i/o subchannel
- */
-static int
-css_bus_match (struct device *dev, struct device_driver *drv)
+static int css_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct subchannel *sch = to_subchannel(dev);
 	struct css_driver *driver = to_cssdriver(drv);
+	struct css_device_id *id;
 
-	if (sch->st == driver->subchannel_type)
-		return 1;
+	for (id = driver->subchannel_type; id->match_flags; id++) {
+		if (sch->st == id->type)
+			return 1;
+	}
 
 	return 0;
 }
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -75,7 +75,7 @@ struct chp_link;
  */
 struct css_driver {
 	struct module *owner;
-	unsigned int subchannel_type;
+	struct css_device_id *subchannel_type;
 	struct device_driver drv;
 	void (*irq)(struct subchannel *);
 	int (*chp_event)(struct subchannel *, struct chp_link *, int);
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -131,9 +131,15 @@ static int io_subchannel_sch_event(struc
 static int io_subchannel_chp_event(struct subchannel *, struct chp_link *,
 				   int);
 
+static struct css_device_id io_subchannel_ids[] = {
+	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(css, io_subchannel_ids);
+
 static struct css_driver io_subchannel_driver = {
 	.owner = THIS_MODULE,
-	.subchannel_type = SUBCHANNEL_TYPE_IO,
+	.subchannel_type = io_subchannel_ids,
 	.name = "io_subchannel",
 	.irq = io_subchannel_irq,
 	.sch_event = io_subchannel_sch_event,
Index: quilt-2.6/include/linux/mod_devicetable.h
===================================================================
--- quilt-2.6.orig/include/linux/mod_devicetable.h
+++ quilt-2.6/include/linux/mod_devicetable.h
@@ -161,8 +161,8 @@ struct ap_device_id {
 
 /* s390 css bus devices (subchannels) */
 struct css_device_id {
+	__u8 match_flags;
 	__u8 type; /* subchannel type */
-	__u8 pad1;
 	__u16 pad2;
 	__u32 pad3;
 	kernel_ulong_t driver_data;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
