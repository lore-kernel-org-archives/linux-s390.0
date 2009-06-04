Return-Path: <linux-kernel-owner+w=401wt.eu-S1759122AbZFDQY0@vger.kernel.org>
Message-Id: <20090604161901.369159107@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/38] pm: css bus power management callbacks
Content-Disposition: inline; filename=pm_css.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/cio/chsc.c |    3 
 drivers/s390/cio/chsc.h |    1 
 drivers/s390/cio/css.c  |  157 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/s390/cio/css.h  |   10 +++
 4 files changed, 164 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/s390/cio/css.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/css.c
+++ linux-2.6/drivers/s390/cio/css.c
@@ -1,10 +1,10 @@
 /*
- *  drivers/s390/cio/css.c
- *  driver for channel subsystem
+ * driver for channel subsystem
  *
- *    Copyright IBM Corp. 2002,2008
- *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
- *		 Cornelia Huck (cornelia.huck@de.ibm.com)
+ * Copyright IBM Corp. 2002, 2009
+ *
+ * Author(s): Arnd Bergmann (arndb@de.ibm.com)
+ *	      Cornelia Huck (cornelia.huck@de.ibm.com)
  */
 
 #define KMSG_COMPONENT "cio"
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/reboot.h>
+#include <linux/suspend.h>
 #include <asm/isc.h>
 #include <asm/crw.h>
 
@@ -780,6 +781,79 @@ static struct notifier_block css_reboot_
 };
 
 /*
+ * Since the css devices are neither on a bus nor have a class
+ * nor have a special device type, we cannot stop/restart channel
+ * path measurements via the normal suspend/resume callbacks, but have
+ * to use notifiers.
+ */
+static int css_power_event(struct notifier_block *this, unsigned long event,
+			   void *ptr)
+{
+	void *secm_area;
+	int ret, i;
+
+	switch (event) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		ret = NOTIFY_DONE;
+		for (i = 0; i <= __MAX_CSSID; i++) {
+			struct channel_subsystem *css;
+
+			css = channel_subsystems[i];
+			mutex_lock(&css->mutex);
+			if (!css->cm_enabled) {
+				mutex_unlock(&css->mutex);
+				continue;
+			}
+			secm_area = (void *)get_zeroed_page(GFP_KERNEL |
+							    GFP_DMA);
+			if (secm_area) {
+				if (__chsc_do_secm(css, 0, secm_area))
+					ret = NOTIFY_BAD;
+				free_page((unsigned long)secm_area);
+			} else
+				ret = NOTIFY_BAD;
+
+			mutex_unlock(&css->mutex);
+		}
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		ret = NOTIFY_DONE;
+		for (i = 0; i <= __MAX_CSSID; i++) {
+			struct channel_subsystem *css;
+
+			css = channel_subsystems[i];
+			mutex_lock(&css->mutex);
+			if (!css->cm_enabled) {
+				mutex_unlock(&css->mutex);
+				continue;
+			}
+			secm_area = (void *)get_zeroed_page(GFP_KERNEL |
+							    GFP_DMA);
+			if (secm_area) {
+				if (__chsc_do_secm(css, 1, secm_area))
+					ret = NOTIFY_BAD;
+				free_page((unsigned long)secm_area);
+			} else
+				ret = NOTIFY_BAD;
+
+			mutex_unlock(&css->mutex);
+		}
+		/* search for subchannels, which appeared during hibernation */
+		css_schedule_reprobe();
+		break;
+	default:
+		ret = NOTIFY_DONE;
+	}
+	return ret;
+
+}
+static struct notifier_block css_power_notifier = {
+	.notifier_call = css_power_event,
+};
+
+/*
  * Now that the driver core is running, we can setup our channel subsystem.
  * The struct subchannel's are created during probing (except for the
  * static console subchannel).
@@ -852,6 +926,11 @@ init_channel_subsystem (void)
 	ret = register_reboot_notifier(&css_reboot_notifier);
 	if (ret)
 		goto out_unregister;
+	ret = register_pm_notifier(&css_power_notifier);
+	if (ret) {
+		unregister_reboot_notifier(&css_reboot_notifier);
+		goto out_unregister;
+	}
 	css_init_done = 1;
 
 	/* Enable default isc for I/O subchannels. */
@@ -953,6 +1032,73 @@ static int css_uevent(struct device *dev
 	return ret;
 }
 
+static int css_pm_prepare(struct device *dev)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct css_driver *drv;
+
+	if (mutex_is_locked(&sch->reg_mutex))
+		return -EAGAIN;
+	if (!sch->dev.driver)
+		return 0;
+	drv = to_cssdriver(sch->dev.driver);
+	/* Notify drivers that they may not register children. */
+	return drv->prepare ? drv->prepare(sch) : 0;
+}
+
+static void css_pm_complete(struct device *dev)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct css_driver *drv;
+
+	if (!sch->dev.driver)
+		return;
+	drv = to_cssdriver(sch->dev.driver);
+	if (drv->complete)
+		drv->complete(sch);
+}
+
+static int css_pm_freeze(struct device *dev)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct css_driver *drv;
+
+	if (!sch->dev.driver)
+		return 0;
+	drv = to_cssdriver(sch->dev.driver);
+	return drv->freeze ? drv->freeze(sch) : 0;
+}
+
+static int css_pm_thaw(struct device *dev)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct css_driver *drv;
+
+	if (!sch->dev.driver)
+		return 0;
+	drv = to_cssdriver(sch->dev.driver);
+	return drv->thaw ? drv->thaw(sch) : 0;
+}
+
+static int css_pm_restore(struct device *dev)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct css_driver *drv;
+
+	if (!sch->dev.driver)
+		return 0;
+	drv = to_cssdriver(sch->dev.driver);
+	return drv->restore ? drv->restore(sch) : 0;
+}
+
+static struct dev_pm_ops css_pm_ops = {
+	.prepare = css_pm_prepare,
+	.complete = css_pm_complete,
+	.freeze = css_pm_freeze,
+	.thaw = css_pm_thaw,
+	.restore = css_pm_restore,
+};
+
 struct bus_type css_bus_type = {
 	.name     = "css",
 	.match    = css_bus_match,
@@ -960,6 +1106,7 @@ struct bus_type css_bus_type = {
 	.remove   = css_remove,
 	.shutdown = css_shutdown,
 	.uevent   = css_uevent,
+	.pm = &css_pm_ops,
 };
 
 /**
Index: linux-2.6/drivers/s390/cio/css.h
===================================================================
--- linux-2.6.orig/drivers/s390/cio/css.h
+++ linux-2.6/drivers/s390/cio/css.h
@@ -70,6 +70,11 @@ struct chp_link;
  * @probe: function called on probe
  * @remove: function called on remove
  * @shutdown: called at device shutdown
+ * @prepare: prepare for pm state transition
+ * @complete: undo work done in @prepare
+ * @freeze: callback for freezing during hibernation snapshotting
+ * @thaw: undo work done in @freeze
+ * @restore: callback for restoring after hibernation
  * @name: name of the device driver
  */
 struct css_driver {
@@ -82,6 +87,11 @@ struct css_driver {
 	int (*probe)(struct subchannel *);
 	int (*remove)(struct subchannel *);
 	void (*shutdown)(struct subchannel *);
+	int (*prepare) (struct subchannel *);
+	void (*complete) (struct subchannel *);
+	int (*freeze)(struct subchannel *);
+	int (*thaw) (struct subchannel *);
+	int (*restore)(struct subchannel *);
 	const char *name;
 };
 
Index: linux-2.6/drivers/s390/cio/chsc.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/chsc.c
+++ linux-2.6/drivers/s390/cio/chsc.c
@@ -549,8 +549,7 @@ cleanup:
 	return ret;
 }
 
-static int
-__chsc_do_secm(struct channel_subsystem *css, int enable, void *page)
+int __chsc_do_secm(struct channel_subsystem *css, int enable, void *page)
 {
 	struct {
 		struct chsc_header request;
Index: linux-2.6/drivers/s390/cio/chsc.h
===================================================================
--- linux-2.6.orig/drivers/s390/cio/chsc.h
+++ linux-2.6/drivers/s390/cio/chsc.h
@@ -90,6 +90,7 @@ extern void chsc_free_sei_area(void);
 extern int chsc_enable_facility(int);
 struct channel_subsystem;
 extern int chsc_secm(struct channel_subsystem *, int);
+int __chsc_do_secm(struct channel_subsystem *css, int enable, void *page);
 
 int chsc_chp_vary(struct chp_id chpid, int on);
 int chsc_determine_channel_path_desc(struct chp_id chpid, int fmt, int rfmt,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
