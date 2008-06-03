Return-Path: <linux-kernel-owner+w=401wt.eu-S1755339AbYFCRIZ@vger.kernel.org>
Message-Id: <20080603170518.866968150@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/14] cio: Introduce modalias for css bus.
Content-Disposition: inline; filename=101-cio-css-alias.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Add modalias and subchannel type attributes for all subchannels.
I/O subchannel specific attributes are now created in
io_subchannel_probe(). modalias and subchannel type are also
added to the uevent for the css bus. Also make the css modalias
known.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/ABI/testing/sysfs-bus-css |   35 ++++++++++++++++
 drivers/s390/cio/cio.h                  |    1 
 drivers/s390/cio/css.c                  |   69 +++++++++++++++++++++++++++++---
 drivers/s390/cio/css.h                  |    2 
 drivers/s390/cio/device.c               |   47 ++++++++++++++-------
 include/linux/mod_devicetable.h         |    9 ++++
 scripts/mod/file2alias.c                |   12 +++++
 7 files changed, 151 insertions(+), 24 deletions(-)

Index: quilt-2.6/Documentation/ABI/testing/sysfs-bus-css
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/ABI/testing/sysfs-bus-css
@@ -0,0 +1,35 @@
+What:		/sys/bus/css/devices/.../type
+Date:		March 2008
+Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
+		linux-s390@vger.kernel.org
+Description:	Contains the subchannel type, as reported by the hardware.
+		This attribute is present for all subchannel types.
+
+What:		/sys/bus/css/devices/.../modalias
+Date:		March 2008
+Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
+		linux-s390@vger.kernel.org
+Description:	Contains the module alias as reported with uevents.
+		It is of the format css:t<type> and present for all
+		subchannel types.
+
+What:		/sys/bus/css/drivers/io_subchannel/.../chpids
+Date:		December 2002
+Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
+		linux-s390@vger.kernel.org
+Description:	Contains the ids of the channel paths used by this
+		subchannel, as reported by the channel subsystem
+		during subchannel recognition.
+		Note: This is an I/O-subchannel specific attribute.
+Users:		s390-tools, HAL
+
+What:		/sys/bus/css/drivers/io_subchannel/.../pimpampom
+Date:		December 2002
+Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
+		linux-s390@vger.kernel.org
+Description:	Contains the PIM/PAM/POM values, as reported by the
+		channel subsystem when last queried by the common I/O
+		layer (this implies that this attribute is not neccessarily
+		in sync with the values current in the channel subsystem).
+		Note: This is an I/O-subchannel specific attribute.
+Users:		s390-tools, HAL
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -3,6 +3,7 @@
 
 #include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <asm/chpid.h>
 #include "chsc.h"
 #include "schid.h"
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -2,8 +2,7 @@
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
  *
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
- *			 IBM Corporation
+ *    Copyright IBM Corp. 2002,2008
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  */
@@ -210,6 +209,41 @@ void css_update_ssd_info(struct subchann
 	}
 }
 
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct subchannel *sch = to_subchannel(dev);
+
+	return sprintf(buf, "%01x\n", sch->st);
+}
+
+static DEVICE_ATTR(type, 0444, type_show, NULL);
+
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct subchannel *sch = to_subchannel(dev);
+
+	return sprintf(buf, "css:t%01X\n", sch->st);
+}
+
+static DEVICE_ATTR(modalias, 0444, modalias_show, NULL);
+
+static struct attribute *subch_attrs[] = {
+	&dev_attr_type.attr,
+	&dev_attr_modalias.attr,
+	NULL,
+};
+
+static struct attribute_group subch_attr_group = {
+	.attrs = subch_attrs,
+};
+
+static struct attribute_group *default_subch_attr_groups[] = {
+	&subch_attr_group,
+	NULL,
+};
+
 static int css_register_subchannel(struct subchannel *sch)
 {
 	int ret;
@@ -218,16 +252,17 @@ static int css_register_subchannel(struc
 	sch->dev.parent = &channel_subsystems[0]->device;
 	sch->dev.bus = &css_bus_type;
 	sch->dev.release = &css_subchannel_release;
-	sch->dev.groups = subch_attr_groups;
+	sch->dev.groups = default_subch_attr_groups;
 	/*
 	 * We don't want to generate uevents for I/O subchannels that don't
 	 * have a working ccw device behind them since they will be
 	 * unregistered before they can be used anyway, so we delay the add
 	 * uevent until after device recognition was successful.
+	 * Note that we suppress the uevent for all subchannel types;
+	 * the subchannel driver can decide itself when it wants to inform
+	 * userspace of its existence.
 	 */
-	if (!cio_is_console(sch->schid))
-		/* Console is special, no need to suppress. */
-		sch->dev.uevent_suppress = 1;
+	sch->dev.uevent_suppress = 1;
 	css_update_ssd_info(sch);
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
@@ -236,6 +271,15 @@ static int css_register_subchannel(struc
 			      sch->schid.ssid, sch->schid.sch_no, ret);
 		return ret;
 	}
+	if (!sch->driver) {
+		/*
+		 * No driver matched. Generate the uevent now so that
+		 * a fitting driver module may be loaded based on the
+		 * modalias.
+		 */
+		sch->dev.uevent_suppress = 0;
+		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+	}
 	return ret;
 }
 
@@ -926,12 +970,25 @@ static void css_shutdown(struct device *
 		sch->driver->shutdown(sch);
 }
 
+static int css_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	int ret;
+
+	ret = add_uevent_var(env, "ST=%01X", sch->st);
+	if (ret)
+		return ret;
+	ret = add_uevent_var(env, "MODALIAS=css:t%01X", sch->st);
+	return ret;
+}
+
 struct bus_type css_bus_type = {
 	.name     = "css",
 	.match    = css_bus_match,
 	.probe    = css_probe,
 	.remove   = css_remove,
 	.shutdown = css_shutdown,
+	.uevent   = css_uevent,
 };
 
 /**
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -143,6 +143,4 @@ int css_sch_is_valid(struct schib *);
 
 extern struct workqueue_struct *slow_path_wq;
 void css_wait_for_slow_path(void);
-
-extern struct attribute_group *subch_attr_groups[];
 #endif
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -585,19 +585,14 @@ static DEVICE_ATTR(modalias, 0444, modal
 static DEVICE_ATTR(online, 0644, online_show, online_store);
 static DEVICE_ATTR(availability, 0444, available_show, NULL);
 
-static struct attribute * subch_attrs[] = {
+static struct attribute *io_subchannel_attrs[] = {
 	&dev_attr_chpids.attr,
 	&dev_attr_pimpampom.attr,
 	NULL,
 };
 
-static struct attribute_group subch_attr_group = {
-	.attrs = subch_attrs,
-};
-
-struct attribute_group *subch_attr_groups[] = {
-	&subch_attr_group,
-	NULL,
+static struct attribute_group io_subchannel_attr_group = {
+	.attrs = io_subchannel_attrs,
 };
 
 static struct attribute * ccwdev_attrs[] = {
@@ -1157,11 +1152,21 @@ static int io_subchannel_probe(struct su
 
 	cdev = sch_get_cdev(sch);
 	if (cdev) {
+		rc = sysfs_create_group(&sch->dev.kobj,
+					&io_subchannel_attr_group);
+		if (rc)
+			CIO_MSG_EVENT(0, "Failed to create io subchannel "
+				      "attributes for subchannel "
+				      "0.%x.%04x (rc=%d)\n",
+				      sch->schid.ssid, sch->schid.sch_no, rc);
 		/*
 		 * This subchannel already has an associated ccw_device.
-		 * Register it and exit. This happens for all early
-		 * device, e.g. the console.
+		 * Throw the delayed uevent for the subchannel, register
+		 * the ccw_device and exit. This happens for all early
+		 * devices, e.g. the console.
 		 */
+		sch->dev.uevent_suppress = 0;
+		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
 		cdev->dev.groups = ccwdev_attr_groups;
 		device_initialize(&cdev->dev);
 		ccw_device_register(cdev);
@@ -1184,11 +1189,17 @@ static int io_subchannel_probe(struct su
 	 */
 	dev_id.devno = sch->schib.pmcw.dev;
 	dev_id.ssid = sch->schid.ssid;
+	rc = sysfs_create_group(&sch->dev.kobj,
+				&io_subchannel_attr_group);
+	if (rc)
+		return rc;
 	/* Allocate I/O subchannel private data. */
 	sch->private = kzalloc(sizeof(struct io_subchannel_private),
 			       GFP_KERNEL | GFP_DMA);
-	if (!sch->private)
-		return -ENOMEM;
+	if (!sch->private) {
+		rc = -ENOMEM;
+		goto out_err;
+	}
 	cdev = get_disc_ccwdev_by_dev_id(&dev_id, NULL);
 	if (!cdev)
 		cdev = get_orphaned_ccwdev_by_dev_id(to_css(sch->dev.parent),
@@ -1207,8 +1218,8 @@ static int io_subchannel_probe(struct su
 	}
 	cdev = io_subchannel_create_ccwdev(sch);
 	if (IS_ERR(cdev)) {
-		kfree(sch->private);
-		return PTR_ERR(cdev);
+		rc = PTR_ERR(cdev);
+		goto out_err;
 	}
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc) {
@@ -1217,9 +1228,12 @@ static int io_subchannel_probe(struct su
 		spin_unlock_irqrestore(sch->lock, flags);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
-		kfree(sch->private);
+		goto out_err;
 	}
-
+	return 0;
+out_err:
+	kfree(sch->private);
+	sysfs_remove_group(&sch->dev.kobj, &io_subchannel_attr_group);
 	return rc;
 }
 
@@ -1240,6 +1254,7 @@ io_subchannel_remove (struct subchannel 
 	ccw_device_unregister(cdev);
 	put_device(&cdev->dev);
 	kfree(sch->private);
+	sysfs_remove_group(&sch->dev.kobj, &io_subchannel_attr_group);
 	return 0;
 }
 
Index: quilt-2.6/include/linux/mod_devicetable.h
===================================================================
--- quilt-2.6.orig/include/linux/mod_devicetable.h
+++ quilt-2.6/include/linux/mod_devicetable.h
@@ -159,6 +159,15 @@ struct ap_device_id {
 
 #define AP_DEVICE_ID_MATCH_DEVICE_TYPE		0x01
 
+/* s390 css bus devices (subchannels) */
+struct css_device_id {
+	__u8 type; /* subchannel type */
+	__u8 pad1;
+	__u16 pad2;
+	__u32 pad3;
+	kernel_ulong_t driver_data;
+};
+
 #define ACPI_ID_LEN	16 /* only 9 bytes needed here, 16 bytes are used */
 			   /* to workaround crosscompile issues */
 
Index: quilt-2.6/scripts/mod/file2alias.c
===================================================================
--- quilt-2.6.orig/scripts/mod/file2alias.c
+++ quilt-2.6/scripts/mod/file2alias.c
@@ -304,6 +304,14 @@ static int do_ap_entry(const char *filen
 	return 1;
 }
 
+/* looks like: "css:tN" */
+static int do_css_entry(const char *filename,
+			struct css_device_id *id, char *alias)
+{
+	sprintf(alias, "css:t%01X", id->type);
+	return 1;
+}
+
 /* Looks like: "serio:tyNprNidNexN" */
 static int do_serio_entry(const char *filename,
 			  struct serio_device_id *id, char *alias)
@@ -680,6 +688,10 @@ void handle_moddevtable(struct module *m
 		do_table(symval, sym->st_size,
 			 sizeof(struct ap_device_id), "ap",
 			 do_ap_entry, mod);
+	else if (sym_is(symname, "__mod_css_device_table"))
+		do_table(symval, sym->st_size,
+			 sizeof(struct css_device_id), "css",
+			 do_css_entry, mod);
 	else if (sym_is(symname, "__mod_serio_device_table"))
 		do_table(symval, sym->st_size,
 			 sizeof(struct serio_device_id), "serio",

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
