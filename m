Return-Path: <linux-kernel-owner+w=401wt.eu-S1755455AbYJAJBf@vger.kernel.org>
Message-Id: <20081001084127.013255943@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/21] bus_id -> dev_set_name() changes
Content-Disposition: inline; filename=106-cio-busid2.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Convert most s390 users setting bus_id to dev_set_name().
css and ccw busses are deferred since they need some special
treatment.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/block/dcssblk.c |    2 +-
 drivers/s390/char/vmlogrdr.c |    3 +--
 drivers/s390/cio/ccwgroup.c  |    3 +--
 drivers/s390/cio/chp.c       |    3 +--
 drivers/s390/cio/css.c       |    4 ++--
 drivers/s390/crypto/ap_bus.c |    4 ++--
 drivers/s390/net/netiucv.c   |    2 +-
 drivers/s390/s390_rdev.c     |    2 +-
 drivers/s390/scsi/zfcp_aux.c |   10 ++++------
 9 files changed, 14 insertions(+), 19 deletions(-)

Index: quilt-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dcssblk.c
+++ quilt-2.6/drivers/s390/block/dcssblk.c
@@ -343,7 +343,7 @@ dcssblk_add_store(struct device *dev, st
 	}
 
 	strcpy(dev_info->segment_name, local_buf);
-	strlcpy(dev_info->dev.bus_id, local_buf, BUS_ID_SIZE);
+	dev_set_name(&dev_info->dev, local_buf);
 	dev_info->dev.release = dcssblk_release_segment;
 	INIT_LIST_HEAD(&dev_info->lh);
 
Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c
@@ -724,8 +724,7 @@ static int vmlogrdr_register_device(stru
 
 	dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (dev) {
-		snprintf(dev->bus_id, BUS_ID_SIZE, "%s",
-			 priv->internal_name);
+		dev_set_name(dev, priv->internal_name);
 		dev->bus = &iucv_bus;
 		dev->parent = iucv_root;
 		dev->driver = &vmlogrdr_driver;
Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c
@@ -269,8 +269,7 @@ int ccwgroup_create_from_string(struct d
 		goto error;
 	}
 
-	snprintf (gdev->dev.bus_id, BUS_ID_SIZE, "%s",
-			dev_name(&gdev->cdev[0]->dev));
+	dev_set_name(&gdev->dev, "%s", dev_name(&gdev->cdev[0]->dev));
 
 	rc = device_add(&gdev->dev);
 	if (rc)
Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -393,8 +393,7 @@ int chp_new(struct chp_id chpid)
 	chp->state = 1;
 	chp->dev.parent = &channel_subsystems[chpid.cssid]->device;
 	chp->dev.release = chp_release;
-	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp%x.%02x", chpid.cssid,
-		 chpid.id);
+	dev_set_name(&chp->dev, "chp%x.%02x", chpid.cssid, chpid.id);
 
 	/* Obtain channel path description and fill it in. */
 	ret = chsc_determine_base_channel_path_desc(chpid, &chp->desc);
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -698,7 +698,7 @@ static int __init setup_css(int nr)
 		return -ENOMEM;
 	css->pseudo_subchannel->dev.parent = &css->device;
 	css->pseudo_subchannel->dev.release = css_subchannel_release;
-	sprintf(css->pseudo_subchannel->dev.bus_id, "defunct");
+	dev_set_name(&css->pseudo_subchannel->dev, "defunct");
 	ret = cio_create_sch_lock(css->pseudo_subchannel);
 	if (ret) {
 		kfree(css->pseudo_subchannel);
@@ -707,7 +707,7 @@ static int __init setup_css(int nr)
 	mutex_init(&css->mutex);
 	css->valid = 1;
 	css->cssid = nr;
-	sprintf(css->device.bus_id, "css%x", nr);
+	dev_set_name(&css->device, "css%x", nr);
 	css->device.release = channel_subsystem_release;
 	tod_high = (u32) (get_clock() >> 32);
 	css_generate_pgid(css, tod_high);
Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -892,8 +892,8 @@ static void ap_scan_bus(struct work_stru
 
 		ap_dev->device.bus = &ap_bus_type;
 		ap_dev->device.parent = ap_root_device;
-		snprintf(ap_dev->device.bus_id, BUS_ID_SIZE, "card%02x",
-			 AP_QID_DEVICE(ap_dev->qid));
+		dev_set_name(&ap_dev->device, "card%02x",
+			     AP_QID_DEVICE(ap_dev->qid));
 		ap_dev->device.release = ap_device_release;
 		rc = device_register(&ap_dev->device);
 		if (rc) {
Index: quilt-2.6/drivers/s390/net/netiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/netiucv.c
+++ quilt-2.6/drivers/s390/net/netiucv.c
@@ -1724,7 +1724,7 @@ static int netiucv_register_device(struc
 	IUCV_DBF_TEXT(trace, 3, __func__);
 
 	if (dev) {
-		snprintf(dev->bus_id, BUS_ID_SIZE, "net%s", ndev->name);
+		dev_set_name(dev, "net%s", ndev->name);
 		dev->bus = &iucv_bus;
 		dev->parent = iucv_root;
 		/*
Index: quilt-2.6/drivers/s390/s390_rdev.c
===================================================================
--- quilt-2.6.orig/drivers/s390/s390_rdev.c
+++ quilt-2.6/drivers/s390/s390_rdev.c
@@ -30,7 +30,7 @@ s390_root_dev_register(const char *name)
 	dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
-	strncpy(dev->bus_id, name, min(strlen(name), (size_t)BUS_ID_SIZE));
+	dev_set_name(dev, name);
 	dev->release = s390_root_dev_release;
 	ret = device_register(dev);
 	if (ret) {
Index: quilt-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -290,7 +290,7 @@ struct zfcp_unit *zfcp_unit_enqueue(stru
 	unit->port = port;
 	unit->fcp_lun = fcp_lun;
 
-	snprintf(unit->sysfs_device.bus_id, BUS_ID_SIZE, "0x%016llx", fcp_lun);
+	dev_set_name(&unit->sysfs_device, "0x%016llx", fcp_lun);
 	unit->sysfs_device.parent = &port->sysfs_device;
 	unit->sysfs_device.release = zfcp_sysfs_unit_release;
 	dev_set_drvdata(&unit->sysfs_device, unit);
@@ -539,8 +539,7 @@ int zfcp_adapter_enqueue(struct ccw_devi
 
 	adapter->generic_services.parent = &adapter->ccw_device->dev;
 	adapter->generic_services.release = zfcp_dummy_release;
-	snprintf(adapter->generic_services.bus_id, BUS_ID_SIZE,
-		 "generic_services");
+	dev_set_name(&adapter->generic_services, "generic_services");
 
 	if (device_register(&adapter->generic_services))
 		goto generic_services_failed;
@@ -678,11 +677,10 @@ struct zfcp_port *zfcp_port_enqueue(stru
 			kfree(port);
 			return ERR_PTR(-EINVAL);
 		}
-		snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE, "%s", bus_id);
+		dev_set_name(&port->sysfs_device, "%s", bus_id);
 		port->sysfs_device.parent = &adapter->generic_services;
 	} else {
-		snprintf(port->sysfs_device.bus_id,
-			 BUS_ID_SIZE, "0x%016llx", wwpn);
+		dev_set_name(&port->sysfs_device, "0x%016llx", wwpn);
 		port->sysfs_device.parent = &adapter->ccw_device->dev;
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
