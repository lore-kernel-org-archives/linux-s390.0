Return-Path: <linux-kernel-owner+w=401wt.eu-S1756540AbZHNLde@vger.kernel.org>
Message-Id: <20090814112617.235991976@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/34] proper use of device register
Content-Disposition: inline; filename=119-device-register.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Don't use kfree directly after device registration started.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/char/hvc_iucv.c       |    2 +-
 drivers/s390/char/monreader.c |    2 +-
 drivers/s390/char/vmlogrdr.c  |    4 +++-
 drivers/s390/cio/chp.c        |    3 ++-
 drivers/s390/cio/css.c        |   23 ++++++++---------------
 drivers/s390/crypto/ap_bus.c  |    2 +-
 drivers/s390/net/netiucv.c    |    9 ++++++---
 drivers/s390/net/smsgiucv.c   |    6 +++---
 drivers/s390/scsi/zfcp_aux.c  |   12 ++++++++----
 9 files changed, 33 insertions(+), 30 deletions(-)

Index: quilt-2.6/drivers/char/hvc_iucv.c
===================================================================
--- quilt-2.6.orig/drivers/char/hvc_iucv.c
+++ quilt-2.6/drivers/char/hvc_iucv.c
@@ -1006,7 +1006,7 @@ static int __init hvc_iucv_alloc(int id,
 	priv->dev->release = (void (*)(struct device *)) kfree;
 	rc = device_register(priv->dev);
 	if (rc) {
-		kfree(priv->dev);
+		put_device(priv->dev);
 		goto out_error_dev;
 	}
 
Index: quilt-2.6/drivers/s390/char/monreader.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/monreader.c
+++ quilt-2.6/drivers/s390/char/monreader.c
@@ -581,7 +581,7 @@ static int __init mon_init(void)
 	monreader_device->release = (void (*)(struct device *))kfree;
 	rc = device_register(monreader_device);
 	if (rc) {
-		kfree(monreader_device);
+		put_device(monreader_device);
 		goto out_driver;
 	}
 
Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c
@@ -765,8 +765,10 @@ static int vmlogrdr_register_device(stru
 	} else
 		return -ENOMEM;
 	ret = device_register(dev);
-	if (ret)
+	if (ret) {
+		put_device(dev);
 		return ret;
+	}
 
 	ret = sysfs_create_group(&dev->kobj, &vmlogrdr_attr_group);
 	if (ret) {
Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -417,7 +417,8 @@ int chp_new(struct chp_id chpid)
 	if (ret) {
 		CIO_MSG_EVENT(0, "Could not register chp%x.%02x: %d\n",
 			      chpid.cssid, chpid.id, ret);
-		goto out_free;
+		put_device(&chp->dev);
+		goto out;
 	}
 	ret = sysfs_create_group(&chp->dev.kobj, &chp_attr_group);
 	if (ret) {
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -152,18 +152,6 @@ css_alloc_subchannel(struct subchannel_i
 }
 
 static void
-css_free_subchannel(struct subchannel *sch)
-{
-	if (sch) {
-		/* Reset intparm to zeroes. */
-		sch->config.intparm = 0;
-		cio_commit_config(sch);
-		kfree(sch->lock);
-		kfree(sch);
-	}
-}
-
-static void
 css_subchannel_release(struct device *dev)
 {
 	struct subchannel *sch;
@@ -330,7 +318,7 @@ int css_probe_device(struct subchannel_i
 		return PTR_ERR(sch);
 	ret = css_register_subchannel(sch);
 	if (ret)
-		css_free_subchannel(sch);
+		put_device(&sch->dev);
 	return ret;
 }
 
@@ -647,7 +635,10 @@ __init_channel_subsystem(struct subchann
 	 * not working) so we do it now. This is true e.g. for the
 	 * console subchannel.
 	 */
-	css_register_subchannel(sch);
+	if (css_register_subchannel(sch)) {
+		if (!cio_is_console(schid))
+			put_device(&sch->dev);
+	}
 	return 0;
 }
 
@@ -923,8 +914,10 @@ init_channel_subsystem (void)
 				goto out_device;
 		}
 		ret = device_register(&css->pseudo_subchannel->dev);
-		if (ret)
+		if (ret) {
+			put_device(&css->pseudo_subchannel->dev);
 			goto out_file;
+		}
 	}
 	ret = register_reboot_notifier(&css_reboot_notifier);
 	if (ret)
Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -1114,7 +1114,7 @@ static void ap_scan_bus(struct work_stru
 		ap_dev->device.release = ap_device_release;
 		rc = device_register(&ap_dev->device);
 		if (rc) {
-			kfree(ap_dev);
+			put_device(&ap_dev->device);
 			continue;
 		}
 		/* Add device attributes. */
Index: quilt-2.6/drivers/s390/net/netiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/netiucv.c
+++ quilt-2.6/drivers/s390/net/netiucv.c
@@ -1839,9 +1839,10 @@ static int netiucv_register_device(struc
 		return -ENOMEM;
 
 	ret = device_register(dev);
-
-	if (ret)
+	if (ret) {
+		put_device(dev);
 		return ret;
+	}
 	ret = netiucv_add_files(dev);
 	if (ret)
 		goto out_unreg;
@@ -2226,8 +2227,10 @@ static int __init netiucv_init(void)
 	netiucv_dev->release = (void (*)(struct device *))kfree;
 	netiucv_dev->driver = &netiucv_driver;
 	rc = device_register(netiucv_dev);
-	if (rc)
+	if (rc) {
+		put_device(netiucv_dev);
 		goto out_driver;
+	}
 	netiucv_banner();
 	return rc;
 
Index: quilt-2.6/drivers/s390/net/smsgiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/smsgiucv.c
+++ quilt-2.6/drivers/s390/net/smsgiucv.c
@@ -219,13 +219,13 @@ static int __init smsg_init(void)
 	smsg_dev->driver = &smsg_driver;
 	rc = device_register(smsg_dev);
 	if (rc)
-		goto out_free_dev;
+		goto out_put;
 
 	cpcmd("SET SMSG IUCV", NULL, 0, NULL);
 	return 0;
 
-out_free_dev:
-	kfree(smsg_dev);
+out_put:
+	put_device(smsg_dev);
 out_free_path:
 	iucv_path_free(smsg_path);
 	smsg_path = NULL;
Index: quilt-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -306,8 +306,10 @@ struct zfcp_unit *zfcp_unit_enqueue(stru
 	}
 	read_unlock_irq(&zfcp_data.config_lock);
 
-	if (device_register(&unit->sysfs_device))
-		goto err_out_free;
+	if (device_register(&unit->sysfs_device)) {
+		put_device(&unit->sysfs_device);
+		return ERR_PTR(-EINVAL);
+	}
 
 	if (sysfs_create_group(&unit->sysfs_device.kobj,
 			       &zfcp_sysfs_unit_attrs)) {
@@ -637,8 +639,10 @@ struct zfcp_port *zfcp_port_enqueue(stru
 	}
 	read_unlock_irq(&zfcp_data.config_lock);
 
-	if (device_register(&port->sysfs_device))
-		goto err_out_free;
+	if (device_register(&port->sysfs_device)) {
+		put_device(&port->sysfs_device);
+		goto err_out;
+	}
 
 	retval = sysfs_create_group(&port->sysfs_device.kobj,
 				    &zfcp_sysfs_port_attrs);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
