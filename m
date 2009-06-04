Return-Path: <linux-kernel-owner+w=401wt.eu-S1758048AbZFDQUz@vger.kernel.org>
Message-Id: <20090604161902.061771877@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/38] pm: dasd power management callbacks.
Content-Disposition: inline; filename=pm_dasd.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

Introduce the power management callbacks to the dasd driver. On suspend
the dasd devices are stopped and removed from the focus of alias 
management.
On resume they are reinitialized by rereading the device characteristics
and adding the device to the alias management.
In case the device has gone away during suspend it will caught in the 
suspend state with stopped flag set to UNRESUMED. After it appears again
the restore function is called again.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/block/dasd.c      |  102 ++++++++++++++++++++++++++++++++++-
 drivers/s390/block/dasd_eckd.c |  118 ++++++++++++++++++++++++++++++++++++-----
 drivers/s390/block/dasd_fba.c  |    6 +-
 drivers/s390/block/dasd_int.h  |    9 ++-
 4 files changed, 216 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/s390/block/dasd.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd.c
+++ linux-2.6/drivers/s390/block/dasd.c
@@ -5,8 +5,7 @@
  *		    Carsten Otte <Cotte@de.ibm.com>
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
- *
+ * Copyright IBM Corp. 1999, 2009
  */
 
 #define KMSG_COMPONENT "dasd"
@@ -61,6 +60,7 @@ static int dasd_flush_block_queue(struct
 static void dasd_device_tasklet(struct dasd_device *);
 static void dasd_block_tasklet(struct dasd_block *);
 static void do_kick_device(struct work_struct *);
+static void do_restore_device(struct work_struct *);
 static void dasd_return_cqr_cb(struct dasd_ccw_req *, void *);
 static void dasd_device_timeout(unsigned long);
 static void dasd_block_timeout(unsigned long);
@@ -109,6 +109,7 @@ struct dasd_device *dasd_alloc_device(vo
 	device->timer.function = dasd_device_timeout;
 	device->timer.data = (unsigned long) device;
 	INIT_WORK(&device->kick_work, do_kick_device);
+	INIT_WORK(&device->restore_device, do_restore_device);
 	device->state = DASD_STATE_NEW;
 	device->target = DASD_STATE_NEW;
 
@@ -512,6 +513,25 @@ void dasd_kick_device(struct dasd_device
 }
 
 /*
+ * dasd_restore_device will schedule a call do do_restore_device to the kernel
+ * event daemon.
+ */
+static void do_restore_device(struct work_struct *work)
+{
+	struct dasd_device *device = container_of(work, struct dasd_device,
+						  restore_device);
+	device->cdev->drv->restore(device->cdev);
+	dasd_put_device(device);
+}
+
+void dasd_restore_device(struct dasd_device *device)
+{
+	dasd_get_device(device);
+	/* queue call to dasd_restore_device to the kernel event daemon. */
+	schedule_work(&device->restore_device);
+}
+
+/*
  * Set the target state for a device and starts the state change.
  */
 void dasd_set_target_state(struct dasd_device *device, int target)
@@ -908,6 +928,12 @@ int dasd_start_IO(struct dasd_ccw_req *c
 		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
 			      "start_IO: -EIO device gone, retry");
 		break;
+	case -EINVAL:
+		/* most likely caused in power management context */
+		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
+			      "start_IO: -EINVAL device currently "
+			      "not accessible");
+		break;
 	default:
 		/* internal error 11 - unknown rc */
 		snprintf(errorstring, ERRORLENGTH, "11 %d", rc);
@@ -2413,6 +2439,12 @@ int dasd_generic_notify(struct ccw_devic
 		ret = 1;
 		break;
 	case CIO_OPER:
+		if (device->stopped & DASD_UNRESUMED_PM) {
+			device->stopped &= ~DASD_UNRESUMED_PM;
+			dasd_restore_device(device);
+			ret = 1;
+			break;
+		}
 		/* FIXME: add a sanity check. */
 		device->stopped &= ~DASD_STOPPED_DC_WAIT;
 		dasd_schedule_device_bh(device);
@@ -2425,6 +2457,72 @@ int dasd_generic_notify(struct ccw_devic
 	return ret;
 }
 
+int dasd_generic_pm_freeze(struct ccw_device *cdev)
+{
+	struct dasd_ccw_req *cqr, *n;
+	int rc;
+	struct list_head freeze_queue;
+	struct dasd_device *device = dasd_device_from_cdev(cdev);
+
+	if (IS_ERR(device))
+		return PTR_ERR(device);
+	/* disallow new I/O  */
+	device->stopped |= DASD_STOPPED_PM;
+	/* clear active requests */
+	INIT_LIST_HEAD(&freeze_queue);
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	rc = 0;
+	list_for_each_entry_safe(cqr, n, &device->ccw_queue, devlist) {
+		/* Check status and move request to flush_queue */
+		if (cqr->status == DASD_CQR_IN_IO) {
+			rc = device->discipline->term_IO(cqr);
+			if (rc) {
+				/* unable to terminate requeust */
+				dev_err(&device->cdev->dev,
+					"Unable to terminate request %p\n",
+					cqr);
+				spin_unlock_irq(get_ccwdev_lock(cdev));
+				dasd_put_device(device);
+				return rc;
+			}
+		}
+		list_move_tail(&cqr->devlist, &freeze_queue);
+	}
+
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+
+	list_for_each_entry_safe(cqr, n, &freeze_queue, devlist) {
+		wait_event(dasd_flush_wq,
+			   (cqr->status != DASD_CQR_CLEAR_PENDING));
+		if (cqr->status == DASD_CQR_CLEARED)
+			cqr->status = DASD_CQR_QUEUED;
+	}
+	/* move freeze_queue to start of the ccw_queue */
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	list_splice_tail(&freeze_queue, &device->ccw_queue);
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+
+	dasd_put_device(device);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dasd_generic_pm_freeze);
+
+int dasd_generic_restore_device(struct ccw_device *cdev)
+{
+	struct dasd_device *device = dasd_device_from_cdev(cdev);
+
+	if (IS_ERR(device))
+		return PTR_ERR(device);
+
+	dasd_schedule_device_bh(device);
+	if (device->block)
+		dasd_schedule_block_bh(device->block);
+
+	dasd_put_device(device);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dasd_generic_restore_device);
+
 static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 						   void *rdc_buffer,
 						   int rdc_buffer_size,
Index: linux-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ linux-2.6/drivers/s390/block/dasd_eckd.c
@@ -5,10 +5,9 @@
  *		    Carsten Otte <Cotte@de.ibm.com>
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
+ * Copyright IBM Corp. 1999, 2009
  * EMC Symmetrix ioctl Copyright EMC Corporation, 2008
  * Author.........: Nigel Hislop <hislop_nigel@emc.com>
- *
  */
 
 #define KMSG_COMPONENT "dasd"
@@ -104,17 +103,6 @@ dasd_eckd_set_online(struct ccw_device *
 	return dasd_generic_set_online(cdev, &dasd_eckd_discipline);
 }
 
-static struct ccw_driver dasd_eckd_driver = {
-	.name        = "dasd-eckd",
-	.owner       = THIS_MODULE,
-	.ids         = dasd_eckd_ids,
-	.probe       = dasd_eckd_probe,
-	.remove      = dasd_generic_remove,
-	.set_offline = dasd_generic_set_offline,
-	.set_online  = dasd_eckd_set_online,
-	.notify      = dasd_generic_notify,
-};
-
 static const int sizes_trk0[] = { 28, 148, 84 };
 #define LABEL_SIZE 140
 
@@ -3236,6 +3224,110 @@ static void dasd_eckd_dump_sense(struct 
 		dasd_eckd_dump_sense_ccw(device, req, irb);
 }
 
+int dasd_eckd_pm_freeze(struct ccw_device *cdev)
+{
+	struct dasd_device *device = dasd_device_from_cdev(cdev);
+	/*
+	 * the device should be disconnected from our LCU structure
+	 * on restore we will reconnect it and reread LCU specific
+	 * information like PAV support that might have changed
+	 */
+	dasd_alias_remove_device(device);
+	dasd_alias_disconnect_device_from_lcu(device);
+	dasd_put_device(device);
+	return dasd_generic_pm_freeze(cdev);
+}
+
+int dasd_eckd_restore_device(struct ccw_device *cdev)
+{
+	struct dasd_eckd_private *private;
+	struct dasd_device *device;
+	int is_known, rc;
+
+	device = dasd_device_from_cdev(cdev);
+
+	/* allow new IO again */
+	device->stopped &= ~DASD_STOPPED_PM;
+
+	private = (struct dasd_eckd_private *) device->private;
+
+	/* Read Configuration Data */
+	rc = dasd_eckd_read_conf(device);
+	if (rc)
+		goto out_err;
+
+	/* Generate device unique id and register in devmap */
+	rc = dasd_eckd_generate_uid(device, &private->uid);
+	if (rc)
+		goto out_err;
+	dasd_set_uid(device->cdev, &private->uid);
+
+	/* register lcu with alias handling, enable PAV if this is a new lcu */
+	is_known = dasd_alias_make_device_known_to_lcu(device);
+	if (is_known < 0)
+		return is_known;
+	if (!is_known) {
+		/* new lcu found */
+		rc = dasd_eckd_validate_server(device); /* will switch pav on */
+		if (rc)
+			goto out_err;
+	}
+
+	/* Read Feature Codes */
+	rc = dasd_eckd_read_features(device);
+	if (rc)
+		goto out_err;
+
+	/* Read Device Characteristics */
+	memset(&private->rdc_data, 0, sizeof(private->rdc_data));
+	rc = dasd_generic_read_dev_chars(device, "ECKD",
+					 &private->rdc_data, 64);
+	if (rc) {
+		DBF_EVENT(DBF_WARNING,
+			  "Read device characteristics failed, rc=%d for "
+			  "device: %s", rc, dev_name(&device->cdev->dev));
+		goto out_err;
+	}
+
+	/* add device to alias management */
+	dasd_alias_add_device(device);
+
+	dasd_put_device(device);
+
+	return dasd_generic_restore_device(cdev);
+
+out_err:
+	/*
+	 * we expect -EINVAL if device is not accessible during resume
+	 * we will keep the device in UNRESUMED stop state
+	 * CIO will inform us later weather to restore or to throw away
+	 * the device
+	 */
+	if (rc == -EINVAL) {
+		/* just disallow new IO and save state unresumed */
+		device->stopped |= DASD_UNRESUMED_PM;
+		return 0;
+	} else {
+		/* in any other case we do nothing for now */
+		dasd_put_device(device);
+
+		return 0;
+	}
+}
+
+static struct ccw_driver dasd_eckd_driver = {
+	.name        = "dasd-eckd",
+	.owner       = THIS_MODULE,
+	.ids         = dasd_eckd_ids,
+	.probe       = dasd_eckd_probe,
+	.remove      = dasd_generic_remove,
+	.set_offline = dasd_generic_set_offline,
+	.set_online  = dasd_eckd_set_online,
+	.notify      = dasd_generic_notify,
+	.freeze      = dasd_eckd_pm_freeze,
+	.thaw        = dasd_eckd_restore_device,
+	.restore     = dasd_eckd_restore_device,
+};
 
 /*
  * max_blocks is dependent on the amount of storage that is available
Index: linux-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_fba.c
+++ linux-2.6/drivers/s390/block/dasd_fba.c
@@ -2,8 +2,7 @@
  * File...........: linux/drivers/s390/block/dasd_fba.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
- *
+ * Copyright IBM Corp. 1999, 2009
  */
 
 #define KMSG_COMPONENT "dasd"
@@ -75,6 +74,9 @@ static struct ccw_driver dasd_fba_driver
 	.set_offline = dasd_generic_set_offline,
 	.set_online  = dasd_fba_set_online,
 	.notify      = dasd_generic_notify,
+	.freeze      = dasd_generic_pm_freeze,
+	.thaw        = dasd_generic_restore_device,
+	.restore     = dasd_generic_restore_device,
 };
 
 static void
Index: linux-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_int.h
+++ linux-2.6/drivers/s390/block/dasd_int.h
@@ -4,8 +4,7 @@
  *		    Horst Hummel <Horst.Hummel@de.ibm.com>
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
- *
+ * Copyright IBM Corp. 1999, 2009
  */
 
 #ifndef DASD_INT_H
@@ -367,6 +366,7 @@ struct dasd_device {
 	atomic_t tasklet_scheduled;
         struct tasklet_struct tasklet;
 	struct work_struct kick_work;
+	struct work_struct restore_device;
 	struct timer_list timer;
 
 	debug_info_t *debug_area;
@@ -410,6 +410,8 @@ struct dasd_block {
 #define DASD_STOPPED_PENDING 4         /* long busy */
 #define DASD_STOPPED_DC_WAIT 8         /* disconnected, wait */
 #define DASD_STOPPED_SU      16        /* summary unit check handling */
+#define DASD_STOPPED_PM      32        /* pm state transition */
+#define DASD_UNRESUMED_PM    64        /* pm resume failed state */
 
 /* per device flags */
 #define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
@@ -556,6 +558,7 @@ void dasd_free_block(struct dasd_block *
 void dasd_enable_device(struct dasd_device *);
 void dasd_set_target_state(struct dasd_device *, int);
 void dasd_kick_device(struct dasd_device *);
+void dasd_restore_device(struct dasd_device *);
 
 void dasd_add_request_head(struct dasd_ccw_req *);
 void dasd_add_request_tail(struct dasd_ccw_req *);
@@ -578,6 +581,8 @@ int dasd_generic_set_online(struct ccw_d
 int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
 void dasd_generic_handle_state_change(struct dasd_device *);
+int dasd_generic_pm_freeze(struct ccw_device *);
+int dasd_generic_restore_device(struct ccw_device *);
 
 int dasd_generic_read_dev_chars(struct dasd_device *, char *, void *, int);
 char *dasd_get_sense(struct irb *);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
