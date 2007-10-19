Return-Path: <linux-kernel-owner+w=401wt.eu-S934940AbXJSRUw@vger.kernel.org>
Message-Id: <20071019171944.770295839@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:19:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/10] struct class_device -> struct device conversion.
Content-Disposition: inline; filename=005-class-device.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Convert struct class_device users under drivers/s390/char to use
struct device.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/raw3270.c    |   26 +++++++++++---------------
 drivers/s390/char/tape_class.c |   19 +++++++------------
 drivers/s390/char/tape_class.h |    4 ++--
 drivers/s390/char/vmlogrdr.c   |   15 ++++++---------
 4 files changed, 26 insertions(+), 38 deletions(-)

Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -48,8 +48,8 @@ struct raw3270 {
 	struct timer_list timer;	/* Device timer. */
 
 	unsigned char *ascebc;		/* ascii -> ebcdic table */
-	struct class_device *clttydev;	/* 3270-class tty device ptr */
-	struct class_device *cltubdev;	/* 3270-class tub device ptr */
+	struct device *clttydev;	/* 3270-class tty device ptr */
+	struct device *cltubdev;	/* 3270-class tub device ptr */
 
 	struct raw3270_request init_request;
 	unsigned char init_data[256];
@@ -1107,11 +1107,9 @@ raw3270_delete_device(struct raw3270 *rp
 	/* Remove from device chain. */
 	mutex_lock(&raw3270_mutex);
 	if (rp->clttydev && !IS_ERR(rp->clttydev))
-		class_device_destroy(class3270,
-				     MKDEV(IBM_TTY3270_MAJOR, rp->minor));
+		device_destroy(class3270, MKDEV(IBM_TTY3270_MAJOR, rp->minor));
 	if (rp->cltubdev && !IS_ERR(rp->cltubdev))
-		class_device_destroy(class3270,
-				     MKDEV(IBM_FS3270_MAJOR, rp->minor));
+		device_destroy(class3270, MKDEV(IBM_FS3270_MAJOR, rp->minor));
 	list_del_init(&rp->list);
 	mutex_unlock(&raw3270_mutex);
 
@@ -1181,24 +1179,22 @@ static int raw3270_create_attributes(str
 	if (rc)
 		goto out;
 
-	rp->clttydev = class_device_create(class3270, NULL,
-					   MKDEV(IBM_TTY3270_MAJOR, rp->minor),
-					   &rp->cdev->dev, "tty%s",
-					   rp->cdev->dev.bus_id);
+	rp->clttydev = device_create(class3270, &rp->cdev->dev,
+				     MKDEV(IBM_TTY3270_MAJOR, rp->minor),
+				     "tty%s", rp->cdev->dev.bus_id);
 	if (IS_ERR(rp->clttydev)) {
 		rc = PTR_ERR(rp->clttydev);
 		goto out_ttydev;
 	}
 
-	rp->cltubdev = class_device_create(class3270, NULL,
-					   MKDEV(IBM_FS3270_MAJOR, rp->minor),
-					   &rp->cdev->dev, "tub%s",
-					   rp->cdev->dev.bus_id);
+	rp->cltubdev = device_create(class3270, &rp->cdev->dev,
+				     MKDEV(IBM_FS3270_MAJOR, rp->minor),
+				     "tub%s", rp->cdev->dev.bus_id);
 	if (!IS_ERR(rp->cltubdev))
 		goto out;
 
 	rc = PTR_ERR(rp->cltubdev);
-	class_device_destroy(class3270, MKDEV(IBM_TTY3270_MAJOR, rp->minor));
+	device_destroy(class3270, MKDEV(IBM_TTY3270_MAJOR, rp->minor));
 
 out_ttydev:
 	sysfs_remove_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
Index: quilt-2.6/drivers/s390/char/tape_class.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_class.c
+++ quilt-2.6/drivers/s390/char/tape_class.c
@@ -69,12 +69,9 @@ struct tape_class_device *register_tape_
 	if (rc)
 		goto fail_with_cdev;
 
-	tcd->class_device = class_device_create(
-				tape_class,
-				NULL,
-				tcd->char_device->dev,
-				device,
-				"%s", tcd->device_name
+	tcd->class_device = device_create(tape_class, device,
+					  tcd->char_device->dev,
+					  "%s", tcd->device_name
 			);
 	rc = IS_ERR(tcd->class_device) ? PTR_ERR(tcd->class_device) : 0;
 	if (rc)
@@ -90,7 +87,7 @@ struct tape_class_device *register_tape_
 	return tcd;
 
 fail_with_class_device:
-	class_device_destroy(tape_class, tcd->char_device->dev);
+	device_destroy(tape_class, tcd->char_device->dev);
 
 fail_with_cdev:
 	cdev_del(tcd->char_device);
@@ -105,11 +102,9 @@ EXPORT_SYMBOL(register_tape_dev);
 void unregister_tape_dev(struct tape_class_device *tcd)
 {
 	if (tcd != NULL && !IS_ERR(tcd)) {
-		sysfs_remove_link(
-			&tcd->class_device->dev->kobj,
-			tcd->mode_name
-		);
-		class_device_destroy(tape_class, tcd->char_device->dev);
+		sysfs_remove_link(&tcd->class_device->kobj,
+				  tcd->mode_name);
+		device_destroy(tape_class, tcd->char_device->dev);
 		cdev_del(tcd->char_device);
 		kfree(tcd);
 	}
Index: quilt-2.6/drivers/s390/char/tape_class.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_class.h
+++ quilt-2.6/drivers/s390/char/tape_class.h
@@ -24,8 +24,8 @@
 #define TAPECLASS_NAME_LEN	32
 
 struct tape_class_device {
-	struct cdev *		char_device;
-	struct class_device *	class_device;
+	struct cdev		*char_device;
+	struct device		*class_device;
 	char			device_name[TAPECLASS_NAME_LEN];
 	char			mode_name[TAPECLASS_NAME_LEN];
 };
Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c
@@ -74,7 +74,7 @@ struct vmlogrdr_priv_t {
 	int dev_in_use; /* 1: already opened, 0: not opened*/
 	spinlock_t priv_lock;
 	struct device  *device;
-	struct class_device  *class_device;
+	struct device  *class_device;
 	int autorecording;
 	int autopurge;
 };
@@ -762,12 +762,10 @@ static int vmlogrdr_register_device(stru
 		device_unregister(dev);
 		return ret;
 	}
-	priv->class_device = class_device_create(
-				vmlogrdr_class,
-				NULL,
-				MKDEV(vmlogrdr_major, priv->minor_num),
-				dev,
-				"%s", dev->bus_id );
+	priv->class_device = device_create(vmlogrdr_class, dev,
+					   MKDEV(vmlogrdr_major,
+						 priv->minor_num),
+					   "%s", dev->bus_id);
 	if (IS_ERR(priv->class_device)) {
 		ret = PTR_ERR(priv->class_device);
 		priv->class_device=NULL;
@@ -783,8 +781,7 @@ static int vmlogrdr_register_device(stru
 
 static int vmlogrdr_unregister_device(struct vmlogrdr_priv_t *priv)
 {
-	class_device_destroy(vmlogrdr_class,
-			     MKDEV(vmlogrdr_major, priv->minor_num));
+	device_destroy(vmlogrdr_class, MKDEV(vmlogrdr_major, priv->minor_num));
 	if (priv->device != NULL) {
 		sysfs_remove_group(&priv->device->kobj, &vmlogrdr_attr_group);
 		device_unregister(priv->device);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
