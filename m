Return-Path: <linux-kernel-owner+w=401wt.eu-S1760910AbXHVMfN@vger.kernel.org>
Message-Id: <20070822123643.247074425@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/10] vmur: fix reference counting for vmur device structure
Content-Disposition: inline; filename=006-vmur-refcount.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

When a vmur device is removed due to a detach of the device, currently the
ur device structure is freed. Unfortunately it can happen, that there is
still a user of the device structure, when the character device is open
during the detach process. To fix this, reference counting for the vmur
structure is introduced.
In addition to that, the online, offline, probe and remove functions are
serialized now using a global mutex.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/char/vmur.c |  218 ++++++++++++++++++++++++++++++++++-------------
 drivers/s390/char/vmur.h |    1 
 2 files changed, 161 insertions(+), 58 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -69,8 +69,26 @@ static struct ccw_driver ur_driver = {
 	.set_offline	= ur_set_offline,
 };
 
+static DEFINE_MUTEX(vmur_mutex);
+
 /*
  * Allocation, freeing, getting and putting of urdev structures
+ *
+ * Each ur device (urd) contains a reference to its corresponding ccw device
+ * (cdev) using the urd->cdev pointer. Each ccw device has a reference to the
+ * ur device using the cdev->dev.driver_data pointer.
+ *
+ * urd references:
+ * - ur_probe gets a urd reference, ur_remove drops the reference
+ *   (cdev->dev.driver_data)
+ * - ur_open gets a urd reference, ur_relase drops the reference
+ *   (urf->urd)
+ *
+ * cdev references:
+ * - urdev_alloc get a cdev reference (urd->cdev)
+ * - urdev_free drops the cdev reference (urd->cdev)
+ *
+ * Setting and clearing of cdev->dev.driver_data is protected by the ccwdev lock
  */
 static struct urdev *urdev_alloc(struct ccw_device *cdev)
 {
@@ -79,42 +97,61 @@ static struct urdev *urdev_alloc(struct 
 	urd = kzalloc(sizeof(struct urdev), GFP_KERNEL);
 	if (!urd)
 		return NULL;
-	urd->cdev = cdev;
 	urd->reclen = cdev->id.driver_info;
 	ccw_device_get_id(cdev, &urd->dev_id);
 	mutex_init(&urd->io_mutex);
 	mutex_init(&urd->open_mutex);
+	atomic_set(&urd->ref_count,  1);
+	urd->cdev = cdev;
+	get_device(&cdev->dev);
 	return urd;
 }
 
 static void urdev_free(struct urdev *urd)
 {
+	TRACE("urdev_free: %p\n", urd);
+	if (urd->cdev)
+		put_device(&urd->cdev->dev);
 	kfree(urd);
 }
 
-/*
- * This is how the character device driver gets a reference to a
- * ur device. When this call returns successfully, a reference has
- * been taken (by get_device) on the underlying kobject. The recipient
- * of this urdev pointer must eventually drop it with urdev_put(urd)
- * which does the corresponding put_device().
- */
+static void urdev_get(struct urdev *urd)
+{
+	atomic_inc(&urd->ref_count);
+}
+
+static struct urdev *urdev_get_from_cdev(struct ccw_device *cdev)
+{
+	struct urdev *urd;
+	unsigned long flags;
+
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	urd = cdev->dev.driver_data;
+	if (urd)
+		urdev_get(urd);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	return urd;
+}
+
 static struct urdev *urdev_get_from_devno(u16 devno)
 {
 	char bus_id[16];
 	struct ccw_device *cdev;
+	struct urdev *urd;
 
 	sprintf(bus_id, "0.0.%04x", devno);
 	cdev = get_ccwdev_by_busid(&ur_driver, bus_id);
 	if (!cdev)
 		return NULL;
-
-	return cdev->dev.driver_data;
+	urd = urdev_get_from_cdev(cdev);
+	put_device(&cdev->dev);
+	return urd;
 }
 
 static void urdev_put(struct urdev *urd)
 {
-	put_device(&urd->cdev->dev);
+	if (atomic_dec_and_test(&urd->ref_count))
+		urdev_free(urd);
 }
 
 /*
@@ -246,6 +283,7 @@ static void ur_int_handler(struct ccw_de
 		return;
 	}
 	urd = cdev->dev.driver_data;
+	BUG_ON(!urd);
 	/* On special conditions irb is an error pointer */
 	if (IS_ERR(irb))
 		urd->io_request_rc = PTR_ERR(irb);
@@ -263,9 +301,15 @@ static void ur_int_handler(struct ccw_de
 static ssize_t ur_attr_reclen_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct urdev *urd = dev->driver_data;
+	struct urdev *urd;
+	int rc;
 
-	return sprintf(buf, "%zu\n", urd->reclen);
+	urd = urdev_get_from_cdev(to_ccwdev(dev));
+	if (!urd)
+		return -ENODEV;
+	rc = sprintf(buf, "%zu\n", urd->reclen);
+	urdev_put(urd);
+	return rc;
 }
 
 static DEVICE_ATTR(reclen, 0444, ur_attr_reclen_show, NULL);
@@ -726,64 +770,63 @@ static struct file_operations ur_fops = 
 
 /*
  * ccw_device infrastructure:
- *     ur_probe gets its own ref to the device (i.e. get_device),
- *     creates the struct urdev, the device attributes, sets up
- *     the interrupt handler and validates the virtual unit record device.
- *     ur_remove removes the device attributes, frees the struct urdev
- *     and drops (put_device) the ref to the device we got in ur_probe.
+ *     ur_probe creates the struct urdev (with refcount = 1), the device
+ *     attributes, sets up the interrupt handler and validates the virtual
+ *     unit record device.
+ *     ur_remove removes the device attributes and drops the reference to
+ *     struct urdev.
+ *
+ *     ur_probe, ur_remove, ur_set_online and ur_set_offline are serialized
+ *     by the vmur_mutex lock.
+ *
+ *     urd->char_device is used as indication that the online function has
+ *     been completed successfully.
  */
 static int ur_probe(struct ccw_device *cdev)
 {
 	struct urdev *urd;
 	int rc;
 
-	TRACE("ur_probe: cdev=%p state=%d\n", cdev, *(int *) cdev->private);
-
-	if (!get_device(&cdev->dev))
-		return -ENODEV;
+	TRACE("ur_probe: cdev=%p\n", cdev);
 
+	mutex_lock(&vmur_mutex);
 	urd = urdev_alloc(cdev);
 	if (!urd) {
 		rc = -ENOMEM;
-		goto fail;
+		goto fail_unlock;
 	}
+
 	rc = ur_create_attributes(&cdev->dev);
 	if (rc) {
 		rc = -ENOMEM;
-		goto fail;
+		goto fail_urdev_put;
 	}
-	cdev->dev.driver_data = urd;
 	cdev->handler = ur_int_handler;
 
 	/* validate virtual unit record device */
 	urd->class = get_urd_class(urd);
 	if (urd->class < 0) {
 		rc = urd->class;
-		goto fail;
+		goto fail_remove_attr;
 	}
 	if ((urd->class != DEV_CLASS_UR_I) && (urd->class != DEV_CLASS_UR_O)) {
 		rc = -ENOTSUPP;
-		goto fail;
+		goto fail_remove_attr;
 	}
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	cdev->dev.driver_data = urd;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
 
+	mutex_unlock(&vmur_mutex);
 	return 0;
 
-fail:
-	urdev_free(urd);
-	put_device(&cdev->dev);
-	return rc;
-}
-
-static void ur_remove(struct ccw_device *cdev)
-{
-	struct urdev *urd = cdev->dev.driver_data;
-
-	TRACE("ur_remove\n");
-	if (cdev->online)
-		ur_set_offline(cdev);
+fail_remove_attr:
 	ur_remove_attributes(&cdev->dev);
-	urdev_free(urd);
-	put_device(&cdev->dev);
+fail_urdev_put:
+	urdev_put(urd);
+fail_unlock:
+	mutex_unlock(&vmur_mutex);
+	return rc;
 }
 
 static int ur_set_online(struct ccw_device *cdev)
@@ -792,20 +835,29 @@ static int ur_set_online(struct ccw_devi
 	int minor, major, rc;
 	char node_id[16];
 
-	TRACE("ur_set_online: cdev=%p state=%d\n", cdev,
-	      *(int *) cdev->private);
+	TRACE("ur_set_online: cdev=%p\n", cdev);
 
-	if (!try_module_get(ur_driver.owner))
-		return -EINVAL;
+	mutex_lock(&vmur_mutex);
+	urd = urdev_get_from_cdev(cdev);
+	if (!urd) {
+		/* ur_remove already deleted our urd */
+		rc = -ENODEV;
+		goto fail_unlock;
+	}
+
+	if (urd->char_device) {
+		/* Another ur_set_online was faster */
+		rc = -EBUSY;
+		goto fail_urdev_put;
+	}
 
-	urd = (struct urdev *) cdev->dev.driver_data;
 	minor = urd->dev_id.devno;
 	major = MAJOR(ur_first_dev_maj_min);
 
 	urd->char_device = cdev_alloc();
 	if (!urd->char_device) {
 		rc = -ENOMEM;
-		goto fail_module_put;
+		goto fail_urdev_put;
 	}
 
 	cdev_init(urd->char_device, &ur_fops);
@@ -834,29 +886,79 @@ static int ur_set_online(struct ccw_devi
 		TRACE("ur_set_online: device_create rc=%d\n", rc);
 		goto fail_free_cdev;
 	}
-
+	urdev_put(urd);
+	mutex_unlock(&vmur_mutex);
 	return 0;
 
 fail_free_cdev:
 	cdev_del(urd->char_device);
-fail_module_put:
-	module_put(ur_driver.owner);
-
+	urd->char_device = NULL;
+fail_urdev_put:
+	urdev_put(urd);
+fail_unlock:
+	mutex_unlock(&vmur_mutex);
 	return rc;
 }
 
-static int ur_set_offline(struct ccw_device *cdev)
+static int ur_set_offline_force(struct ccw_device *cdev, int force)
 {
 	struct urdev *urd;
+	int rc;
 
-	TRACE("ur_set_offline: cdev=%p cdev->private=%p state=%d\n",
-		cdev, cdev->private, *(int *) cdev->private);
-	urd = (struct urdev *) cdev->dev.driver_data;
+	TRACE("ur_set_offline: cdev=%p\n", cdev);
+	urd = urdev_get_from_cdev(cdev);
+	if (!urd)
+		/* ur_remove already deleted our urd */
+		return -ENODEV;
+	if (!urd->char_device) {
+		/* Another ur_set_offline was faster */
+		rc = -EBUSY;
+		goto fail_urdev_put;
+	}
+	if (!force && (atomic_read(&urd->ref_count) > 2)) {
+		/* There is still a user of urd (e.g. ur_open) */
+		TRACE("ur_set_offline: BUSY\n");
+		rc = -EBUSY;
+		goto fail_urdev_put;
+	}
 	device_destroy(vmur_class, urd->char_device->dev);
 	cdev_del(urd->char_device);
-	module_put(ur_driver.owner);
+	urd->char_device = NULL;
+	rc = 0;
 
-	return 0;
+fail_urdev_put:
+	urdev_put(urd);
+	return rc;
+}
+
+static int ur_set_offline(struct ccw_device *cdev)
+{
+	int rc;
+
+	mutex_lock(&vmur_mutex);
+	rc = ur_set_offline_force(cdev, 0);
+	mutex_unlock(&vmur_mutex);
+	return rc;
+}
+
+static void ur_remove(struct ccw_device *cdev)
+{
+	unsigned long flags;
+
+	TRACE("ur_remove\n");
+
+	mutex_lock(&vmur_mutex);
+
+	if (cdev->online)
+		ur_set_offline_force(cdev, 1);
+	ur_remove_attributes(&cdev->dev);
+
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	urdev_put(cdev->dev.driver_data);
+	cdev->dev.driver_data = NULL;
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+
+	mutex_unlock(&vmur_mutex);
 }
 
 /*
Index: quilt-2.6/drivers/s390/char/vmur.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.h
+++ quilt-2.6/drivers/s390/char/vmur.h
@@ -70,6 +70,7 @@ struct urdev {
 	size_t reclen;			/* Record length for *write* CCWs */
 	int class;			/* VM device class */
 	int io_request_rc;		/* return code from I/O request */
+	atomic_t ref_count;		/* reference counter */
 };
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
