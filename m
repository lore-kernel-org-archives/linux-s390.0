Return-Path: <linux-kernel-owner+w=401wt.eu-S933406AbXHGLUx@vger.kernel.org>
Message-Id: <20070807111847.313429386@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/18] cio: rename css to channel_subsystems
Content-Disposition: inline; filename=100-cio-rename.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Rename css[] to channel_subsystems[] to avoid name clashes.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.c        |   14 ++++----
 drivers/s390/cio/css.c        |   69 +++++++++++++++++++++++-------------------
 drivers/s390/cio/css.h        |    2 -
 drivers/s390/cio/device_fsm.c |    3 +
 4 files changed, 49 insertions(+), 39 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -55,7 +55,7 @@ static wait_queue_head_t cfg_wait_queue;
 /* Return channel_path struct for given chpid. */
 static inline struct channel_path *chpid_to_chp(struct chp_id chpid)
 {
-	return css[chpid.cssid]->chps[chpid.id];
+	return channel_subsystems[chpid.cssid]->chps[chpid.id];
 }
 
 /* Set vary state for given chpid. */
@@ -395,7 +395,7 @@ int chp_new(struct chp_id chpid)
 	/* fill in status, etc. */
 	chp->chpid = chpid;
 	chp->state = 1;
-	chp->dev.parent = &css[chpid.cssid]->device;
+	chp->dev.parent = &channel_subsystems[chpid.cssid]->device;
 	chp->dev.release = chp_release;
 	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp%x.%02x", chpid.cssid,
 		 chpid.id);
@@ -430,18 +430,18 @@ int chp_new(struct chp_id chpid)
 		device_unregister(&chp->dev);
 		goto out_free;
 	}
-	mutex_lock(&css[chpid.cssid]->mutex);
-	if (css[chpid.cssid]->cm_enabled) {
+	mutex_lock(&channel_subsystems[chpid.cssid]->mutex);
+	if (channel_subsystems[chpid.cssid]->cm_enabled) {
 		ret = chp_add_cmg_attr(chp);
 		if (ret) {
 			sysfs_remove_group(&chp->dev.kobj, &chp_attr_group);
 			device_unregister(&chp->dev);
-			mutex_unlock(&css[chpid.cssid]->mutex);
+			mutex_unlock(&channel_subsystems[chpid.cssid]->mutex);
 			goto out_free;
 		}
 	}
-	css[chpid.cssid]->chps[chpid.id] = chp;
-	mutex_unlock(&css[chpid.cssid]->mutex);
+	channel_subsystems[chpid.cssid]->chps[chpid.id] = chp;
+	mutex_unlock(&channel_subsystems[chpid.cssid]->mutex);
 	return ret;
 out_free:
 	kfree(chp);
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -27,7 +27,7 @@ int css_init_done = 0;
 static int need_reprobe = 0;
 static int max_ssid = 0;
 
-struct channel_subsystem *css[__MAX_CSSID + 1];
+struct channel_subsystem *channel_subsystems[__MAX_CSSID + 1];
 
 int css_characteristics_avail = 0;
 
@@ -177,7 +177,7 @@ static int css_register_subchannel(struc
 	int ret;
 
 	/* Initialize the subchannel structure */
-	sch->dev.parent = &css[0]->device;
+	sch->dev.parent = &channel_subsystems[0]->device;
 	sch->dev.bus = &css_bus_type;
 	sch->dev.release = &css_subchannel_release;
 	sch->dev.groups = subch_attr_groups;
@@ -606,27 +606,29 @@ static int __init setup_css(int nr)
 {
 	u32 tod_high;
 	int ret;
+	struct channel_subsystem *css;
 
-	memset(css[nr], 0, sizeof(struct channel_subsystem));
-	css[nr]->pseudo_subchannel =
-		kzalloc(sizeof(*css[nr]->pseudo_subchannel), GFP_KERNEL);
-	if (!css[nr]->pseudo_subchannel)
+	css = channel_subsystems[nr];
+	memset(css, 0, sizeof(struct channel_subsystem));
+	css->pseudo_subchannel =
+		kzalloc(sizeof(*css->pseudo_subchannel), GFP_KERNEL);
+	if (!css->pseudo_subchannel)
 		return -ENOMEM;
-	css[nr]->pseudo_subchannel->dev.parent = &css[nr]->device;
-	css[nr]->pseudo_subchannel->dev.release = css_subchannel_release;
-	sprintf(css[nr]->pseudo_subchannel->dev.bus_id, "defunct");
-	ret = cio_create_sch_lock(css[nr]->pseudo_subchannel);
+	css->pseudo_subchannel->dev.parent = &css->device;
+	css->pseudo_subchannel->dev.release = css_subchannel_release;
+	sprintf(css->pseudo_subchannel->dev.bus_id, "defunct");
+	ret = cio_create_sch_lock(css->pseudo_subchannel);
 	if (ret) {
-		kfree(css[nr]->pseudo_subchannel);
+		kfree(css->pseudo_subchannel);
 		return ret;
 	}
-	mutex_init(&css[nr]->mutex);
-	css[nr]->valid = 1;
-	css[nr]->cssid = nr;
-	sprintf(css[nr]->device.bus_id, "css%x", nr);
-	css[nr]->device.release = channel_subsystem_release;
+	mutex_init(&css->mutex);
+	css->valid = 1;
+	css->cssid = nr;
+	sprintf(css->device.bus_id, "css%x", nr);
+	css->device.release = channel_subsystem_release;
 	tod_high = (u32) (get_clock() >> 32);
-	css_generate_pgid(css[nr], tod_high);
+	css_generate_pgid(css, tod_high);
 	return 0;
 }
 
@@ -670,25 +672,28 @@ init_channel_subsystem (void)
 	}
 	/* Setup css structure. */
 	for (i = 0; i <= __MAX_CSSID; i++) {
-		css[i] = kmalloc(sizeof(struct channel_subsystem), GFP_KERNEL);
-		if (!css[i]) {
+		struct channel_subsystem *css;
+
+		css = kmalloc(sizeof(struct channel_subsystem), GFP_KERNEL);
+		if (!css) {
 			ret = -ENOMEM;
 			goto out_unregister;
 		}
+		channel_subsystems[i] = css;
 		ret = setup_css(i);
 		if (ret)
 			goto out_free;
-		ret = device_register(&css[i]->device);
+		ret = device_register(&css->device);
 		if (ret)
 			goto out_free_all;
 		if (css_characteristics_avail &&
 		    css_chsc_characteristics.secm) {
-			ret = device_create_file(&css[i]->device,
+			ret = device_create_file(&css->device,
 						 &dev_attr_cm_enable);
 			if (ret)
 				goto out_device;
 		}
-		ret = device_register(&css[i]->pseudo_subchannel->dev);
+		ret = device_register(&css->pseudo_subchannel->dev);
 		if (ret)
 			goto out_file;
 	}
@@ -699,22 +704,26 @@ init_channel_subsystem (void)
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
 out_file:
-	device_remove_file(&css[i]->device, &dev_attr_cm_enable);
+	device_remove_file(&channel_subsystems[i]->device,
+			   &dev_attr_cm_enable);
 out_device:
-	device_unregister(&css[i]->device);
+	device_unregister(&channel_subsystems[i]->device);
 out_free_all:
-	kfree(css[i]->pseudo_subchannel->lock);
-	kfree(css[i]->pseudo_subchannel);
+	kfree(channel_subsystems[i]->pseudo_subchannel->lock);
+	kfree(channel_subsystems[i]->pseudo_subchannel);
 out_free:
-	kfree(css[i]);
+	kfree(channel_subsystems[i]);
 out_unregister:
 	while (i > 0) {
+		struct channel_subsystem *css;
+
 		i--;
-		device_unregister(&css[i]->pseudo_subchannel->dev);
+		css = channel_subsystems[i];
+		device_unregister(&css->pseudo_subchannel->dev);
 		if (css_characteristics_avail && css_chsc_characteristics.secm)
-			device_remove_file(&css[i]->device,
+			device_remove_file(&css->device,
 					   &dev_attr_cm_enable);
-		device_unregister(&css[i]->device);
+		device_unregister(&css->device);
 	}
 out_bus:
 	bus_unregister(&css_bus_type);
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -167,7 +167,7 @@ struct channel_subsystem {
 #define to_css(dev) container_of(dev, struct channel_subsystem, device)
 
 extern struct bus_type css_bus_type;
-extern struct channel_subsystem *css[];
+extern struct channel_subsystem *channel_subsystems[];
 
 /* Some helper functions for disconnected state. */
 int device_is_disconnected(struct subchannel *);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -446,7 +446,8 @@ static void __ccw_device_get_common_pgid
 	if (cdev->private->pgid[last].inf.ps.state1 ==
 	    SNID_STATE1_RESET)
 		/* No previous pgid found */
-		memcpy(&cdev->private->pgid[0], &css[0]->global_pgid,
+		memcpy(&cdev->private->pgid[0],
+		       &channel_subsystems[0]->global_pgid,
 		       sizeof(struct pgid));
 	else
 		/* Use existing pgid */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
