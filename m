Return-Path: <linux-kernel-owner+w=401wt.eu-S1755888AbXD0ONW@vger.kernel.org>
Message-Id: <20070427140517.431891614@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/38] dasd: Add sysfs attribute status and generate uevents.
Content-Disposition: inline; filename=127-dasd-status.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Horst Hummel <horst.hummel@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Horst Hummel <horst.hummel@de.ibm.com>

This patch adds a sysfs-attribute 'status' to make the DASD device-status
accessible from user-space. In addition, the DASD driver generates an
uevent(CHANGE) for the ccw-device on each device-status change.
This enables user-space applications (e.g. udev) to do related processing.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c        |    3 ++
 drivers/s390/block/dasd_devmap.c |   41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/block/dasd.c	2007-04-27 16:04:58.000000000 +0200
@@ -398,6 +398,9 @@
 
 	if (device->state == device->target)
 		wake_up(&dasd_init_waitq);
+
+	/* let user-space know that the device status changed */
+	kobject_uevent(&device->cdev->dev.kobj, KOBJ_CHANGE);
 }
 
 /*
Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c	2007-04-27 16:04:58.000000000 +0200
@@ -829,6 +829,46 @@
 static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
 
 static ssize_t
+dasd_device_status_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
+{
+	struct dasd_device *device;
+	ssize_t len;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (!IS_ERR(device)) {
+		switch (device->state) {
+		case DASD_STATE_NEW:
+			len = snprintf(buf, PAGE_SIZE, "new\n");
+			break;
+		case DASD_STATE_KNOWN:
+			len = snprintf(buf, PAGE_SIZE, "detected\n");
+			break;
+		case DASD_STATE_BASIC:
+			len = snprintf(buf, PAGE_SIZE, "basic\n");
+			break;
+		case DASD_STATE_UNFMT:
+			len = snprintf(buf, PAGE_SIZE, "unformatted\n");
+			break;
+		case DASD_STATE_READY:
+			len = snprintf(buf, PAGE_SIZE, "ready\n");
+			break;
+		case DASD_STATE_ONLINE:
+			len = snprintf(buf, PAGE_SIZE, "online\n");
+			break;
+		default:
+			len = snprintf(buf, PAGE_SIZE, "no stat\n");
+			break;
+		}
+		dasd_put_device(device);
+	} else
+		len = snprintf(buf, PAGE_SIZE, "unknown\n");
+	return len;
+}
+
+static DEVICE_ATTR(status, 0444, dasd_device_status_show, NULL);
+
+static ssize_t
 dasd_alias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dasd_devmap *devmap;
@@ -939,6 +979,7 @@
 static struct attribute * dasd_attrs[] = {
 	&dev_attr_readonly.attr,
 	&dev_attr_discipline.attr,
+	&dev_attr_status.attr,
 	&dev_attr_alias.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_uid.attr,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
