Return-Path: <linux-kernel-owner+w=401wt.eu-S934617AbXLTPXy@vger.kernel.org>
Message-Id: <20071220152104.247774943@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:31 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/47] cio: Add css_driver_{register,unregister}.
Content-Disposition: inline; filename=105-cio-cssdrv.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Add wrapper functions for driver_register and driver_unregister so
that css drivers don't need to muck with struct device_driver
directly.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c    |   27 +++++++++++++++++++++++++++
 drivers/s390/cio/css.h    |    4 ++++
 drivers/s390/cio/device.c |   10 ++++------
 3 files changed, 35 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -837,6 +837,33 @@ struct bus_type css_bus_type = {
 	.shutdown = css_shutdown,
 };
 
+/**
+ * css_driver_register - register a css driver
+ * @cdrv: css driver to register
+ *
+ * This is mainly a wrapper around driver_register that sets name
+ * and bus_type in the embedded struct device_driver correctly.
+ */
+int css_driver_register(struct css_driver *cdrv)
+{
+	cdrv->drv.name = cdrv->name;
+	cdrv->drv.bus = &css_bus_type;
+	return driver_register(&cdrv->drv);
+}
+EXPORT_SYMBOL_GPL(css_driver_register);
+
+/**
+ * css_driver_unregister - unregister a css driver
+ * @cdrv: css driver to unregister
+ *
+ * This is a wrapper around driver_unregister.
+ */
+void css_driver_unregister(struct css_driver *cdrv)
+{
+	driver_unregister(&cdrv->drv);
+}
+EXPORT_SYMBOL_GPL(css_driver_unregister);
+
 subsys_initcall(init_channel_subsystem);
 
 MODULE_LICENSE("GPL");
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -132,6 +132,7 @@ struct css_driver {
 	int (*probe)(struct subchannel *);
 	int (*remove)(struct subchannel *);
 	void (*shutdown)(struct subchannel *);
+	const char *name;
 };
 
 #define to_cssdriver(n) container_of(n, struct css_driver, drv)
@@ -141,6 +142,9 @@ struct css_driver {
  */
 extern struct bus_type css_bus_type;
 
+extern int css_driver_register(struct css_driver *);
+extern void css_driver_unregister(struct css_driver *);
+
 extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -125,10 +125,7 @@ static void io_subchannel_shutdown(struc
 
 static struct css_driver io_subchannel_driver = {
 	.subchannel_type = SUBCHANNEL_TYPE_IO,
-	.drv = {
-		.name = "io_subchannel",
-		.bus  = &css_bus_type,
-	},
+	.name = "io_subchannel",
 	.irq = io_subchannel_irq,
 	.notify = io_subchannel_notify,
 	.verify = io_subchannel_verify,
@@ -167,7 +164,8 @@ init_ccw_bus_type (void)
 	if ((ret = bus_register (&ccw_bus_type)))
 		goto out_err;
 
-	if ((ret = driver_register(&io_subchannel_driver.drv)))
+	ret = css_driver_register(&io_subchannel_driver);
+	if (ret)
 		goto out_err;
 
 	wait_event(ccw_device_init_wq,
@@ -187,7 +185,7 @@ out_err:
 static void __exit
 cleanup_ccw_bus_type (void)
 {
-	driver_unregister(&io_subchannel_driver.drv);
+	css_driver_unregister(&io_subchannel_driver);
 	bus_unregister(&ccw_bus_type);
 	destroy_workqueue(ccw_device_notify_work);
 	destroy_workqueue(ccw_device_work);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
