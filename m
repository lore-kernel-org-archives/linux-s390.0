Return-Path: <linux-kernel-owner+w=401wt.eu-S1759529AbZFDQ02@vger.kernel.org>
Message-Id: <20090604161900.897545208@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/38] pm: ccw bus power management callbacks
Content-Disposition: inline; filename=pm_ccw.patch
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
 arch/s390/include/asm/ccwdev.h |   18 ++-
 drivers/s390/cio/cmf.c         |    5 
 drivers/s390/cio/device.c      |  237 +++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/device.h      |    3 
 drivers/s390/cio/device_fsm.c  |   96 +++++++---------
 drivers/s390/cio/device_ops.c  |   26 +++-
 drivers/s390/cio/io_sch.h      |    1 
 7 files changed, 321 insertions(+), 65 deletions(-)

Index: linux-2.6/drivers/s390/cio/device.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/device.c
+++ linux-2.6/drivers/s390/cio/device.c
@@ -1895,6 +1895,242 @@ static void ccw_device_shutdown(struct d
 	disable_cmf(cdev);
 }
 
+static int ccw_device_pm_prepare(struct device *dev)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+
+	if (work_pending(&cdev->private->kick_work))
+		return -EAGAIN;
+	/* Fail while device is being set online/offline. */
+	if (atomic_read(&cdev->private->onoff))
+		return -EAGAIN;
+
+	if (cdev->online && cdev->drv && cdev->drv->prepare)
+		return cdev->drv->prepare(cdev);
+
+	return 0;
+}
+
+static void ccw_device_pm_complete(struct device *dev)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+
+	if (cdev->online && cdev->drv && cdev->drv->complete)
+		cdev->drv->complete(cdev);
+}
+
+static int ccw_device_pm_freeze(struct device *dev)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	int ret, cm_enabled;
+
+	/* Fail suspend while device is in transistional state. */
+	if (!dev_fsm_final_state(cdev))
+		return -EAGAIN;
+	if (!cdev->online)
+		return 0;
+	if (cdev->drv && cdev->drv->freeze) {
+		ret = cdev->drv->freeze(cdev);
+		if (ret)
+			return ret;
+	}
+
+	spin_lock_irq(sch->lock);
+	cm_enabled = cdev->private->cmb != NULL;
+	spin_unlock_irq(sch->lock);
+	if (cm_enabled) {
+		/* Don't have the css write on memory. */
+		ret = ccw_set_cmf(cdev, 0);
+		if (ret)
+			return ret;
+	}
+	/* From here on, disallow device driver I/O. */
+	spin_lock_irq(sch->lock);
+	ret = cio_disable_subchannel(sch);
+	spin_unlock_irq(sch->lock);
+
+	return ret;
+}
+
+static int ccw_device_pm_thaw(struct device *dev)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	int ret, cm_enabled;
+
+	if (!cdev->online)
+		return 0;
+
+	spin_lock_irq(sch->lock);
+	/* Allow device driver I/O again. */
+	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
+	cm_enabled = cdev->private->cmb != NULL;
+	spin_unlock_irq(sch->lock);
+	if (ret)
+		return ret;
+
+	if (cm_enabled) {
+		ret = ccw_set_cmf(cdev, 1);
+		if (ret)
+			return ret;
+	}
+
+	if (cdev->drv && cdev->drv->thaw)
+		ret = cdev->drv->thaw(cdev);
+
+	return ret;
+}
+
+static void __ccw_device_pm_restore(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	int ret;
+
+	if (cio_is_console(sch->schid))
+		goto out;
+	/*
+	 * While we were sleeping, devices may have gone or become
+	 * available again. Kick re-detection.
+	 */
+	spin_lock_irq(sch->lock);
+	cdev->private->flags.resuming = 1;
+	ret = ccw_device_recognition(cdev);
+	spin_unlock_irq(sch->lock);
+	if (ret) {
+		CIO_MSG_EVENT(0, "Couldn't start recognition for device "
+			      "%s (ret=%d)\n", dev_name(&cdev->dev), ret);
+		spin_lock_irq(sch->lock);
+		cdev->private->state = DEV_STATE_DISCONNECTED;
+		spin_unlock_irq(sch->lock);
+		/* notify driver after the resume cb */
+		goto out;
+	}
+	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev) ||
+		   cdev->private->state == DEV_STATE_DISCONNECTED);
+
+out:
+	cdev->private->flags.resuming = 0;
+}
+
+static int resume_handle_boxed(struct ccw_device *cdev)
+{
+	cdev->private->state = DEV_STATE_BOXED;
+	if (ccw_device_notify(cdev, CIO_BOXED))
+		return 0;
+	ccw_device_schedule_sch_unregister(cdev);
+	return -ENODEV;
+}
+
+static int resume_handle_disc(struct ccw_device *cdev)
+{
+	cdev->private->state = DEV_STATE_DISCONNECTED;
+	if (ccw_device_notify(cdev, CIO_GONE))
+		return 0;
+	ccw_device_schedule_sch_unregister(cdev);
+	return -ENODEV;
+}
+
+static int ccw_device_pm_restore(struct device *dev)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	int ret = 0, cm_enabled;
+
+	__ccw_device_pm_restore(cdev);
+	spin_lock_irq(sch->lock);
+	if (cio_is_console(sch->schid)) {
+		cio_enable_subchannel(sch, (u32)(addr_t)sch);
+		spin_unlock_irq(sch->lock);
+		goto out_restore;
+	}
+	cdev->private->flags.donotify = 0;
+	/* check recognition results */
+	switch (cdev->private->state) {
+	case DEV_STATE_OFFLINE:
+		break;
+	case DEV_STATE_BOXED:
+		ret = resume_handle_boxed(cdev);
+		spin_unlock_irq(sch->lock);
+		if (ret)
+			goto out;
+		goto out_restore;
+	case DEV_STATE_DISCONNECTED:
+		goto out_disc_unlock;
+	default:
+		goto out_unreg_unlock;
+	}
+	/* check if the device id has changed */
+	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
+		CIO_MSG_EVENT(0, "resume: sch %s: failed (devno changed from "
+			      "%04x to %04x)\n", dev_name(&sch->dev),
+			      cdev->private->dev_id.devno,
+			      sch->schib.pmcw.dev);
+		goto out_unreg_unlock;
+	}
+	/* check if the device type has changed */
+	if (!ccw_device_test_sense_data(cdev)) {
+		ccw_device_update_sense_data(cdev);
+		PREPARE_WORK(&cdev->private->kick_work,
+			     ccw_device_do_unbind_bind);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	if (!cdev->online) {
+		ret = 0;
+		goto out_unlock;
+	}
+	ret = ccw_device_online(cdev);
+	if (ret)
+		goto out_disc_unlock;
+
+	cm_enabled = cdev->private->cmb != NULL;
+	spin_unlock_irq(sch->lock);
+
+	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	if (cdev->private->state != DEV_STATE_ONLINE) {
+		spin_lock_irq(sch->lock);
+		goto out_disc_unlock;
+	}
+	if (cm_enabled) {
+		ret = ccw_set_cmf(cdev, 1);
+		if (ret) {
+			CIO_MSG_EVENT(2, "resume: cdev %s: cmf failed "
+				      "(rc=%d)\n", dev_name(&cdev->dev), ret);
+			ret = 0;
+		}
+	}
+
+out_restore:
+	if (cdev->online && cdev->drv && cdev->drv->restore)
+		ret = cdev->drv->restore(cdev);
+out:
+	return ret;
+
+out_disc_unlock:
+	ret = resume_handle_disc(cdev);
+	spin_unlock_irq(sch->lock);
+	if (ret)
+		return ret;
+	goto out_restore;
+
+out_unreg_unlock:
+	ccw_device_schedule_sch_unregister(cdev);
+	ret = -ENODEV;
+out_unlock:
+	spin_unlock_irq(sch->lock);
+	return ret;
+}
+
+static struct dev_pm_ops ccw_pm_ops = {
+	.prepare = ccw_device_pm_prepare,
+	.complete = ccw_device_pm_complete,
+	.freeze = ccw_device_pm_freeze,
+	.thaw = ccw_device_pm_thaw,
+	.restore = ccw_device_pm_restore,
+};
+
 struct bus_type ccw_bus_type = {
 	.name   = "ccw",
 	.match  = ccw_bus_match,
@@ -1902,6 +2138,7 @@ struct bus_type ccw_bus_type = {
 	.probe  = ccw_device_probe,
 	.remove = ccw_device_remove,
 	.shutdown = ccw_device_shutdown,
+	.pm = &ccw_pm_ops,
 };
 
 /**
Index: linux-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- linux-2.6.orig/drivers/s390/cio/io_sch.h
+++ linux-2.6/drivers/s390/cio/io_sch.h
@@ -107,6 +107,7 @@ struct ccw_device_private {
 		unsigned int recog_done:1;  /* dev. recog. complete */
 		unsigned int fake_irb:1;    /* deliver faked irb */
 		unsigned int intretry:1;    /* retry internal operation */
+		unsigned int resuming:1;    /* recognition while resume */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
Index: linux-2.6/arch/s390/include/asm/ccwdev.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/ccwdev.h
+++ linux-2.6/arch/s390/include/asm/ccwdev.h
@@ -1,11 +1,9 @@
 /*
- *  include/asm-s390/ccwdev.h
- *  include/asm-s390x/ccwdev.h
+ * Copyright  IBM Corp. 2002, 2009
  *
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Arnd Bergmann <arndb@de.ibm.com>
+ * Author(s): Arnd Bergmann <arndb@de.ibm.com>
  *
- *  Interface for CCW device drivers
+ * Interface for CCW device drivers
  */
 #ifndef _S390_CCWDEV_H_
 #define _S390_CCWDEV_H_
@@ -104,6 +102,11 @@ struct ccw_device {
  * @set_offline: called when setting device offline
  * @notify: notify driver of device state changes
  * @shutdown: called at device shutdown
+ * @prepare: prepare for pm state transition
+ * @complete: undo work done in @prepare
+ * @freeze: callback for freezing during hibernation snapshotting
+ * @thaw: undo work done in @freeze
+ * @restore: callback for restoring after hibernation
  * @driver: embedded device driver structure
  * @name: device driver name
  */
@@ -116,6 +119,11 @@ struct ccw_driver {
 	int (*set_offline) (struct ccw_device *);
 	int (*notify) (struct ccw_device *, int);
 	void (*shutdown) (struct ccw_device *);
+	int (*prepare) (struct ccw_device *);
+	void (*complete) (struct ccw_device *);
+	int (*freeze)(struct ccw_device *);
+	int (*thaw) (struct ccw_device *);
+	int (*restore)(struct ccw_device *);
 	struct device_driver driver;
 	char *name;
 };
Index: linux-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/device_ops.c
+++ linux-2.6/drivers/s390/cio/device_ops.c
@@ -1,10 +1,8 @@
 /*
- *  drivers/s390/cio/device_ops.c
+ * Copyright IBM Corp. 2002, 2009
  *
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
- *			 IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *               Cornelia Huck (cornelia.huck@de.ibm.com)
+ * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *            Cornelia Huck (cornelia.huck@de.ibm.com)
  */
 #include <linux/module.h>
 #include <linux/init.h>
@@ -116,12 +114,15 @@ int ccw_device_clear(struct ccw_device *
 
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
+	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.ena)
+		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
-	sch = to_subchannel(cdev->dev.parent);
+
 	ret = cio_clear(sch);
 	if (ret == 0)
 		cdev->private->intparm = intparm;
@@ -162,6 +163,8 @@ int ccw_device_start_key(struct ccw_devi
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.ena)
+		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_VERIFY ||
@@ -337,12 +340,15 @@ int ccw_device_halt(struct ccw_device *c
 
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
+	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.ena)
+		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
-	sch = to_subchannel(cdev->dev.parent);
+
 	ret = cio_halt(sch);
 	if (ret == 0)
 		cdev->private->intparm = intparm;
@@ -369,6 +375,8 @@ int ccw_device_resume(struct ccw_device 
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.ena)
+		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE ||
@@ -580,6 +588,8 @@ int ccw_device_tm_start_key(struct ccw_d
 	int rc;
 
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.ena)
+		return -EINVAL;
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EIO;
 	/* Adjust requested path mask to excluded varied off paths. */
@@ -669,6 +679,8 @@ int ccw_device_tm_intrg(struct ccw_devic
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
+	if (!sch->schib.pmcw.ena)
+		return -EINVAL;
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EIO;
 	if (!scsw_is_tm(&sch->schib.scsw) ||
Index: linux-2.6/drivers/s390/cio/device.h
===================================================================
--- linux-2.6.orig/drivers/s390/cio/device.h
+++ linux-2.6/drivers/s390/cio/device.h
@@ -87,6 +87,8 @@ int ccw_device_is_orphan(struct ccw_devi
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
 int ccw_device_offline(struct ccw_device *);
+void ccw_device_update_sense_data(struct ccw_device *);
+int ccw_device_test_sense_data(struct ccw_device *);
 void ccw_device_schedule_sch_unregister(struct ccw_device *);
 int ccw_purge_blacklisted(void);
 
@@ -133,5 +135,6 @@ extern struct bus_type ccw_bus_type;
 void retry_set_schib(struct ccw_device *cdev);
 void cmf_retry_copy_block(struct ccw_device *);
 int cmf_reenable(struct ccw_device *);
+int ccw_set_cmf(struct ccw_device *cdev, int enable);
 extern struct device_attribute dev_attr_cmb_enable;
 #endif
Index: linux-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/device_fsm.c
+++ linux-2.6/drivers/s390/cio/device_fsm.c
@@ -177,29 +177,21 @@ ccw_device_cancel_halt_clear(struct ccw_
 	panic("Can't stop i/o on subchannel.\n");
 }
 
-static int
-ccw_device_handle_oper(struct ccw_device *cdev)
+void ccw_device_update_sense_data(struct ccw_device *cdev)
 {
-	struct subchannel *sch;
+	memset(&cdev->id, 0, sizeof(cdev->id));
+	cdev->id.cu_type   = cdev->private->senseid.cu_type;
+	cdev->id.cu_model  = cdev->private->senseid.cu_model;
+	cdev->id.dev_type  = cdev->private->senseid.dev_type;
+	cdev->id.dev_model = cdev->private->senseid.dev_model;
+}
 
-	sch = to_subchannel(cdev->dev.parent);
-	cdev->private->flags.recog_done = 1;
-	/*
-	 * Check if cu type and device type still match. If
-	 * not, it is certainly another device and we have to
-	 * de- and re-register.
-	 */
-	if (cdev->id.cu_type != cdev->private->senseid.cu_type ||
-	    cdev->id.cu_model != cdev->private->senseid.cu_model ||
-	    cdev->id.dev_type != cdev->private->senseid.dev_type ||
-	    cdev->id.dev_model != cdev->private->senseid.dev_model) {
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unbind_bind);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
-		return 0;
-	}
-	cdev->private->flags.donotify = 1;
-	return 1;
+int ccw_device_test_sense_data(struct ccw_device *cdev)
+{
+	return cdev->id.cu_type == cdev->private->senseid.cu_type &&
+		cdev->id.cu_model == cdev->private->senseid.cu_model &&
+		cdev->id.dev_type == cdev->private->senseid.dev_type &&
+		cdev->id.dev_model == cdev->private->senseid.dev_model;
 }
 
 /*
@@ -233,7 +225,7 @@ static void
 ccw_device_recog_done(struct ccw_device *cdev, int state)
 {
 	struct subchannel *sch;
-	int notify, old_lpm, same_dev;
+	int old_lpm;
 
 	sch = to_subchannel(cdev->dev.parent);
 
@@ -263,8 +255,12 @@ ccw_device_recog_done(struct ccw_device 
 		wake_up(&cdev->private->wait_q);
 		return;
 	}
-	notify = 0;
-	same_dev = 0; /* Keep the compiler quiet... */
+	if (cdev->private->flags.resuming) {
+		cdev->private->state = state;
+		cdev->private->flags.recog_done = 1;
+		wake_up(&cdev->private->wait_q);
+		return;
+	}
 	switch (state) {
 	case DEV_STATE_NOT_OPER:
 		CIO_MSG_EVENT(2, "SenseID : unknown device %04x on "
@@ -273,34 +269,31 @@ ccw_device_recog_done(struct ccw_device 
 			      sch->schid.ssid, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
-		if (cdev->online) {
-			same_dev = ccw_device_handle_oper(cdev);
-			notify = 1;
+		if (!cdev->online) {
+			ccw_device_update_sense_data(cdev);
+			/* Issue device info message. */
+			CIO_MSG_EVENT(4, "SenseID : device 0.%x.%04x reports: "
+				      "CU  Type/Mod = %04X/%02X, Dev Type/Mod "
+				      "= %04X/%02X\n",
+				      cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno,
+				      cdev->id.cu_type, cdev->id.cu_model,
+				      cdev->id.dev_type, cdev->id.dev_model);
+			break;
 		}
-		/* fill out sense information */
-		memset(&cdev->id, 0, sizeof(cdev->id));
-		cdev->id.cu_type   = cdev->private->senseid.cu_type;
-		cdev->id.cu_model  = cdev->private->senseid.cu_model;
-		cdev->id.dev_type  = cdev->private->senseid.dev_type;
-		cdev->id.dev_model = cdev->private->senseid.dev_model;
-		if (notify) {
-			cdev->private->state = DEV_STATE_OFFLINE;
-			if (same_dev) {
-				/* Get device online again. */
-				ccw_device_online(cdev);
-				wake_up(&cdev->private->wait_q);
-			}
-			return;
+		cdev->private->state = DEV_STATE_OFFLINE;
+		cdev->private->flags.recog_done = 1;
+		if (ccw_device_test_sense_data(cdev)) {
+			cdev->private->flags.donotify = 1;
+			ccw_device_online(cdev);
+			wake_up(&cdev->private->wait_q);
+		} else {
+			ccw_device_update_sense_data(cdev);
+			PREPARE_WORK(&cdev->private->kick_work,
+				     ccw_device_do_unbind_bind);
+			queue_work(ccw_device_work, &cdev->private->kick_work);
 		}
-		/* Issue device info message. */
-		CIO_MSG_EVENT(4, "SenseID : device 0.%x.%04x reports: "
-			      "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
-			      "%04X/%02X\n",
-			      cdev->private->dev_id.ssid,
-			      cdev->private->dev_id.devno,
-			      cdev->id.cu_type, cdev->id.cu_model,
-			      cdev->id.dev_type, cdev->id.dev_model);
-		break;
+		return;
 	case DEV_STATE_BOXED:
 		CIO_MSG_EVENT(0, "SenseID : boxed device %04x on "
 			      " subchannel 0.%x.%04x\n",
@@ -502,9 +495,6 @@ ccw_device_recognition(struct ccw_device
 	struct subchannel *sch;
 	int ret;
 
-	if ((cdev->private->state != DEV_STATE_NOT_OPER) &&
-	    (cdev->private->state != DEV_STATE_BOXED))
-		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
 	if (ret != 0)
Index: linux-2.6/drivers/s390/cio/cmf.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/cmf.c
+++ linux-2.6/drivers/s390/cio/cmf.c
@@ -1204,6 +1204,11 @@ static ssize_t cmb_enable_store(struct d
 
 DEVICE_ATTR(cmb_enable, 0644, cmb_enable_show, cmb_enable_store);
 
+int ccw_set_cmf(struct ccw_device *cdev, int enable)
+{
+	return cmbops->set(cdev, enable ? 2 : 0);
+}
+
 /**
  * enable_cmf() - switch on the channel measurement for a specific device
  *  @cdev:	The ccw device to be enabled

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
