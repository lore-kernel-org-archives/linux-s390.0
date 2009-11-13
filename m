Return-Path: <linux-kernel-owner+w=401wt.eu-S1757040AbZKMPM0@vger.kernel.org>
Message-Id: <20091113150913.151407374@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 22/52] [PATCH] dasd: improve error recovery for internal I/O
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=121-dasd-internel-io-errors.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

Most of the error conditions reported by a FICON storage server
indicate situations which can be recovered. Sometimes the host just
needs to retry an I/O request, but sometimes the recovery
is more complex and requires the device driver to wait, choose
a different path, etc.

The DASD device driver has a fully featured error recovery
for normal block layer I/O, but not for internal I/O request which
are for example used during the device bring up.
This can lead to situations where the IPL of a system fails because
DASD devices are not properly recognized.
This patch will extend the internal I/O handling to use the existing
error recovery procedures.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c          |  207 +++++++++++++++++++++++++++----------
 drivers/s390/block/dasd_3990_erp.c |   46 +++++---
 drivers/s390/block/dasd_alias.c    |   15 +-
 drivers/s390/block/dasd_eckd.c     |   72 +++++++++---
 drivers/s390/block/dasd_int.h      |    3 
 drivers/s390/block/dasd_ioctl.c    |    4 
 6 files changed, 253 insertions(+), 94 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c	2009-11-13 16:08:14.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c	2009-11-13 16:08:16.000000000 +0100
@@ -69,8 +69,7 @@
  *   processing until the started timer has expired or an related
  *   interrupt was received.
  */
-static void
-dasd_3990_erp_block_queue(struct dasd_ccw_req * erp, int expires)
+static void dasd_3990_erp_block_queue(struct dasd_ccw_req *erp, int expires)
 {
 
 	struct dasd_device *device = erp->startdev;
@@ -80,10 +79,13 @@
 		    "blocking request queue for %is", expires/HZ);
 
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	device->stopped |= DASD_STOPPED_PENDING;
+	dasd_device_set_stop_bits(device, DASD_STOPPED_PENDING);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	erp->status = DASD_CQR_FILLED;
-	dasd_block_set_timer(device->block, expires);
+	if (erp->block)
+		dasd_block_set_timer(erp->block, expires);
+	else
+		dasd_device_set_timer(device, expires);
 }
 
 /*
@@ -242,9 +244,13 @@
  * DESCRIPTION
  *   Setup ERP to do the ERP action 1 (see Reference manual).
  *   Repeat the operation on a different channel path.
- *   If all alternate paths have been tried, the request is posted with a
- *   permanent error.
- *   Note: duplex handling is not implemented (yet).
+ *   As deviation from the recommended recovery action, we reset the path mask
+ *   after we have tried each path and go through all paths a second time.
+ *   This will cover situations where only one path at a time is actually down,
+ *   but all paths fail and recover just with the same sequence and timing as
+ *   we try to use them (flapping links).
+ *   If all alternate paths have been tried twice, the request is posted with
+ *   a permanent error.
  *
  *  PARAMETER
  *   erp		pointer to the current ERP
@@ -253,17 +259,25 @@
  *   erp		pointer to the ERP
  *
  */
-static struct dasd_ccw_req *
-dasd_3990_erp_action_1(struct dasd_ccw_req * erp)
+static struct dasd_ccw_req *dasd_3990_erp_action_1_sec(struct dasd_ccw_req *erp)
 {
+	erp->function = dasd_3990_erp_action_1_sec;
+	dasd_3990_erp_alternate_path(erp);
+	return erp;
+}
 
+static struct dasd_ccw_req *dasd_3990_erp_action_1(struct dasd_ccw_req *erp)
+{
 	erp->function = dasd_3990_erp_action_1;
-
 	dasd_3990_erp_alternate_path(erp);
-
+	if (erp->status == DASD_CQR_FAILED) {
+		erp->status = DASD_CQR_FILLED;
+		erp->retries = 10;
+		erp->lpm = LPM_ANYPATH;
+		erp->function = dasd_3990_erp_action_1_sec;
+	}
 	return erp;
-
-}				/* end dasd_3990_erp_action_1 */
+}				/* end dasd_3990_erp_action_1(b) */
 
 /*
  * DASD_3990_ERP_ACTION_4
@@ -2294,6 +2308,7 @@
 		return cqr;
 	}
 
+	ccw = cqr->cpaddr;
 	if (cqr->cpmode == 1) {
 		/* make a shallow copy of the original tcw but set new tsb */
 		erp->cpmode = 1;
@@ -2302,6 +2317,9 @@
 		tsb = (struct tsb *) &tcw[1];
 		*tcw = *((struct tcw *)cqr->cpaddr);
 		tcw->tsb = (long)tsb;
+	} else if (ccw->cmd_code == DASD_ECKD_CCW_PSF) {
+		/* PSF cannot be chained from NOOP/TIC */
+		erp->cpaddr = cqr->cpaddr;
 	} else {
 		/* initialize request with default TIC to current ERP/CQR */
 		ccw = erp->cpaddr;
@@ -2486,6 +2504,8 @@
 
 		erp = dasd_3990_erp_action_1(erp);
 
+	} else if (erp->function == dasd_3990_erp_action_1_sec) {
+		erp = dasd_3990_erp_action_1_sec(erp);
 	} else if (erp->function == dasd_3990_erp_action_5) {
 
 		/* retries have not been successful */
Index: quilt-2.6/drivers/s390/block/dasd_alias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_alias.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_alias.c	2009-11-13 16:08:16.000000000 +0100
@@ -755,11 +755,11 @@
 {
 	/* If pos == device then device is already locked! */
 	if (pos == device) {
-		pos->stopped |= DASD_STOPPED_SU;
+		dasd_device_set_stop_bits(pos, DASD_STOPPED_SU);
 		return;
 	}
 	spin_lock(get_ccwdev_lock(pos->cdev));
-	pos->stopped |= DASD_STOPPED_SU;
+	dasd_device_set_stop_bits(pos, DASD_STOPPED_SU);
 	spin_unlock(get_ccwdev_lock(pos->cdev));
 }
 
@@ -793,26 +793,26 @@
 
 	list_for_each_entry(device, &lcu->active_devices, alias_list) {
 		spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-		device->stopped &= ~DASD_STOPPED_SU;
+		dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
 		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	}
 
 	list_for_each_entry(device, &lcu->inactive_devices, alias_list) {
 		spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-		device->stopped &= ~DASD_STOPPED_SU;
+		dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
 		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	}
 
 	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
 		list_for_each_entry(device, &pavgroup->baselist, alias_list) {
 			spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-			device->stopped &= ~DASD_STOPPED_SU;
+			dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
 			spin_unlock_irqrestore(get_ccwdev_lock(device->cdev),
 					       flags);
 		}
 		list_for_each_entry(device, &pavgroup->aliaslist, alias_list) {
 			spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-			device->stopped &= ~DASD_STOPPED_SU;
+			dasd_device_remove_stop_bits(device, DASD_STOPPED_SU);
 			spin_unlock_irqrestore(get_ccwdev_lock(device->cdev),
 					       flags);
 		}
@@ -836,7 +836,8 @@
 
 	/* 2. reset summary unit check */
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	device->stopped &= ~(DASD_STOPPED_SU | DASD_STOPPED_PENDING);
+	dasd_device_remove_stop_bits(device,
+				     (DASD_STOPPED_SU | DASD_STOPPED_PENDING));
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	reset_summary_unit_check(lcu, device, suc_data->reason);
 
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2009-11-13 16:08:14.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd.c	2009-11-13 16:08:16.000000000 +0100
@@ -63,6 +63,7 @@
 static void dasd_return_cqr_cb(struct dasd_ccw_req *, void *);
 static void dasd_device_timeout(unsigned long);
 static void dasd_block_timeout(unsigned long);
+static void __dasd_process_erp(struct dasd_device *, struct dasd_ccw_req *);
 
 /*
  * SECTION: Operations on the device structure.
@@ -959,7 +960,7 @@
 	device = (struct dasd_device *) ptr;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	/* re-activate request queue */
-        device->stopped &= ~DASD_STOPPED_PENDING;
+	dasd_device_remove_stop_bits(device, DASD_STOPPED_PENDING);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	dasd_schedule_device_bh(device);
 }
@@ -1022,7 +1023,7 @@
 	/* First of all start sense subsystem status request. */
 	dasd_eer_snss(device);
 
-	device->stopped &= ~DASD_STOPPED_PENDING;
+	dasd_device_remove_stop_bits(device, DASD_STOPPED_PENDING);
 	dasd_schedule_device_bh(device);
 	if (device->block)
 		dasd_schedule_block_bh(device->block);
@@ -1404,6 +1405,20 @@
 	tasklet_hi_schedule(&device->tasklet);
 }
 
+void dasd_device_set_stop_bits(struct dasd_device *device, int bits)
+{
+	device->stopped |= bits;
+}
+EXPORT_SYMBOL_GPL(dasd_device_set_stop_bits);
+
+void dasd_device_remove_stop_bits(struct dasd_device *device, int bits)
+{
+	device->stopped &= ~bits;
+	if (!device->stopped)
+		wake_up(&generic_waitq);
+}
+EXPORT_SYMBOL_GPL(dasd_device_remove_stop_bits);
+
 /*
  * Queue a request to the head of the device ccw_queue.
  * Start the I/O if possible.
@@ -1464,58 +1479,135 @@
 }
 
 /*
- * Queue a request to the tail of the device ccw_queue and wait for
- * it's completion.
+ * checks if error recovery is necessary, returns 1 if yes, 0 otherwise.
  */
-int dasd_sleep_on(struct dasd_ccw_req *cqr)
+static int __dasd_sleep_on_erp(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
-	int rc;
+	dasd_erp_fn_t erp_fn;
 
+	if (cqr->status == DASD_CQR_FILLED)
+		return 0;
 	device = cqr->startdev;
+	if (test_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags)) {
+		if (cqr->status == DASD_CQR_TERMINATED) {
+			device->discipline->handle_terminated_request(cqr);
+			return 1;
+		}
+		if (cqr->status == DASD_CQR_NEED_ERP) {
+			erp_fn = device->discipline->erp_action(cqr);
+			erp_fn(cqr);
+			return 1;
+		}
+		if (cqr->status == DASD_CQR_FAILED)
+			dasd_log_sense(cqr, &cqr->irb);
+		if (cqr->refers) {
+			__dasd_process_erp(device, cqr);
+			return 1;
+		}
+	}
+	return 0;
+}
 
-	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &generic_waitq;
-	dasd_add_request_tail(cqr);
-	wait_event(generic_waitq, _wait_for_wakeup(cqr));
+static int __dasd_sleep_on_loop_condition(struct dasd_ccw_req *cqr)
+{
+	if (test_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags)) {
+		if (cqr->refers) /* erp is not done yet */
+			return 1;
+		return ((cqr->status != DASD_CQR_DONE) &&
+			(cqr->status != DASD_CQR_FAILED));
+	} else
+		return (cqr->status == DASD_CQR_FILLED);
+}
 
-	if (cqr->status == DASD_CQR_DONE)
+static int _dasd_sleep_on(struct dasd_ccw_req *maincqr, int interruptible)
+{
+	struct dasd_device *device;
+	int rc;
+	struct list_head ccw_queue;
+	struct dasd_ccw_req *cqr;
+
+	INIT_LIST_HEAD(&ccw_queue);
+	maincqr->status = DASD_CQR_FILLED;
+	device = maincqr->startdev;
+	list_add(&maincqr->blocklist, &ccw_queue);
+	for (cqr = maincqr;  __dasd_sleep_on_loop_condition(cqr);
+	     cqr = list_first_entry(&ccw_queue,
+				    struct dasd_ccw_req, blocklist)) {
+
+		if (__dasd_sleep_on_erp(cqr))
+			continue;
+		if (cqr->status != DASD_CQR_FILLED) /* could be failed */
+			continue;
+
+		/* Non-temporary stop condition will trigger fail fast */
+		if (device->stopped & ~DASD_STOPPED_PENDING &&
+		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
+		    (!dasd_eer_enabled(device))) {
+			cqr->status = DASD_CQR_FAILED;
+			continue;
+		}
+
+		/* Don't try to start requests if device is stopped */
+		if (interruptible) {
+			rc = wait_event_interruptible(
+				generic_waitq, !(device->stopped));
+			if (rc == -ERESTARTSYS) {
+				cqr->status = DASD_CQR_FAILED;
+				maincqr->intrc = rc;
+				continue;
+			}
+		} else
+			wait_event(generic_waitq, !(device->stopped));
+
+		cqr->callback = dasd_wakeup_cb;
+		cqr->callback_data = (void *) &generic_waitq;
+		dasd_add_request_tail(cqr);
+		if (interruptible) {
+			rc = wait_event_interruptible(
+				generic_waitq, _wait_for_wakeup(cqr));
+			if (rc == -ERESTARTSYS) {
+				dasd_cancel_req(cqr);
+				/* wait (non-interruptible) for final status */
+				wait_event(generic_waitq,
+					   _wait_for_wakeup(cqr));
+				cqr->status = DASD_CQR_FAILED;
+				maincqr->intrc = rc;
+				continue;
+			}
+		} else
+			wait_event(generic_waitq, _wait_for_wakeup(cqr));
+	}
+
+	maincqr->endclk = get_clock();
+	if ((maincqr->status != DASD_CQR_DONE) &&
+	    (maincqr->intrc != -ERESTARTSYS))
+		dasd_log_sense(maincqr, &maincqr->irb);
+	if (maincqr->status == DASD_CQR_DONE)
 		rc = 0;
-	else if (cqr->intrc)
-		rc = cqr->intrc;
+	else if (maincqr->intrc)
+		rc = maincqr->intrc;
 	else
 		rc = -EIO;
 	return rc;
 }
 
 /*
+ * Queue a request to the tail of the device ccw_queue and wait for
+ * it's completion.
+ */
+int dasd_sleep_on(struct dasd_ccw_req *cqr)
+{
+	return _dasd_sleep_on(cqr, 0);
+}
+
+/*
  * Queue a request to the tail of the device ccw_queue and wait
  * interruptible for it's completion.
  */
 int dasd_sleep_on_interruptible(struct dasd_ccw_req *cqr)
 {
-	struct dasd_device *device;
-	int rc;
-
-	device = cqr->startdev;
-	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &generic_waitq;
-	dasd_add_request_tail(cqr);
-	rc = wait_event_interruptible(generic_waitq, _wait_for_wakeup(cqr));
-	if (rc == -ERESTARTSYS) {
-		dasd_cancel_req(cqr);
-		/* wait (non-interruptible) for final status */
-		wait_event(generic_waitq, _wait_for_wakeup(cqr));
-		cqr->intrc = rc;
-	}
-
-	if (cqr->status == DASD_CQR_DONE)
-		rc = 0;
-	else if (cqr->intrc)
-		rc = cqr->intrc;
-	else
-		rc = -EIO;
-	return rc;
+	return _dasd_sleep_on(cqr, 1);
 }
 
 /*
@@ -1629,7 +1721,7 @@
 	block = (struct dasd_block *) ptr;
 	spin_lock_irqsave(get_ccwdev_lock(block->base->cdev), flags);
 	/* re-activate request queue */
-	block->base->stopped &= ~DASD_STOPPED_PENDING;
+	dasd_device_remove_stop_bits(block->base, DASD_STOPPED_PENDING);
 	spin_unlock_irqrestore(get_ccwdev_lock(block->base->cdev), flags);
 	dasd_schedule_block_bh(block);
 }
@@ -1656,11 +1748,10 @@
 /*
  * Process finished error recovery ccw.
  */
-static inline void __dasd_block_process_erp(struct dasd_block *block,
-					    struct dasd_ccw_req *cqr)
+static void __dasd_process_erp(struct dasd_device *device,
+			       struct dasd_ccw_req *cqr)
 {
 	dasd_erp_fn_t erp_fn;
-	struct dasd_device *device = block->base;
 
 	if (cqr->status == DASD_CQR_DONE)
 		DBF_DEV_EVENT(DBF_NOTICE, device, "%s", "ERP successful");
@@ -1724,9 +1815,12 @@
 				 */
 				if (!list_empty(&block->ccw_queue))
 					break;
-				spin_lock_irqsave(get_ccwdev_lock(basedev->cdev), flags);
-				basedev->stopped |= DASD_STOPPED_PENDING;
-				spin_unlock_irqrestore(get_ccwdev_lock(basedev->cdev), flags);
+				spin_lock_irqsave(
+					get_ccwdev_lock(basedev->cdev), flags);
+				dasd_device_set_stop_bits(basedev,
+							  DASD_STOPPED_PENDING);
+				spin_unlock_irqrestore(
+					get_ccwdev_lock(basedev->cdev), flags);
 				dasd_block_set_timer(block, HZ/2);
 				break;
 			}
@@ -1812,7 +1906,7 @@
 			cqr->status = DASD_CQR_FILLED;
 			cqr->retries = 255;
 			spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
-			base->stopped |= DASD_STOPPED_QUIESCE;
+			dasd_device_set_stop_bits(base, DASD_STOPPED_QUIESCE);
 			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
 					       flags);
 			goto restart;
@@ -1820,7 +1914,7 @@
 
 		/* Process finished ERP request. */
 		if (cqr->refers) {
-			__dasd_block_process_erp(block, cqr);
+			__dasd_process_erp(base, cqr);
 			goto restart;
 		}
 
@@ -1951,7 +2045,7 @@
 		/* Process finished ERP request. */
 		if (cqr->refers) {
 			spin_lock_bh(&block->queue_lock);
-			__dasd_block_process_erp(block, cqr);
+			__dasd_process_erp(block->base, cqr);
 			spin_unlock_bh(&block->queue_lock);
 			/* restart list_for_xx loop since dasd_process_erp
 			 * might remove multiple elements */
@@ -2417,16 +2511,16 @@
 				cqr->status = DASD_CQR_QUEUED;
 				cqr->retries++;
 			}
-		device->stopped |= DASD_STOPPED_DC_WAIT;
+		dasd_device_set_stop_bits(device, DASD_STOPPED_DC_WAIT);
 		dasd_device_clear_timer(device);
 		dasd_schedule_device_bh(device);
 		ret = 1;
 		break;
 	case CIO_OPER:
 		/* FIXME: add a sanity check. */
-		device->stopped &= ~DASD_STOPPED_DC_WAIT;
+		dasd_device_remove_stop_bits(device, DASD_STOPPED_DC_WAIT);
 		if (device->stopped & DASD_UNRESUMED_PM) {
-			device->stopped &= ~DASD_UNRESUMED_PM;
+			dasd_device_remove_stop_bits(device, DASD_UNRESUMED_PM);
 			dasd_restore_device(device);
 			ret = 1;
 			break;
@@ -2451,7 +2545,7 @@
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 	/* disallow new I/O  */
-	device->stopped |= DASD_STOPPED_PM;
+	dasd_device_set_stop_bits(device, DASD_STOPPED_PM);
 	/* clear active requests */
 	INIT_LIST_HEAD(&freeze_queue);
 	spin_lock_irq(get_ccwdev_lock(cdev));
@@ -2503,14 +2597,18 @@
 		return PTR_ERR(device);
 
 	/* allow new IO again */
-	device->stopped &= ~DASD_STOPPED_PM;
-	device->stopped &= ~DASD_UNRESUMED_PM;
+	dasd_device_remove_stop_bits(device,
+				     (DASD_STOPPED_PM | DASD_UNRESUMED_PM));
 
 	dasd_schedule_device_bh(device);
 
-	if (device->discipline->restore)
+	/*
+	 * call discipline restore function
+	 * if device is stopped do nothing e.g. for disconnected devices
+	 */
+	if (device->discipline->restore && !(device->stopped))
 		rc = device->discipline->restore(device);
-	if (rc)
+	if (rc || device->stopped)
 		/*
 		 * if the resume failed for the DASD we put it in
 		 * an UNRESUMED stop state
@@ -2560,8 +2658,7 @@
 	cqr->startdev = device;
 	cqr->memdev = device;
 	cqr->expires = 10*HZ;
-	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
-	cqr->retries = 2;
+	cqr->retries = 256;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:16.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:16.000000000 +0100
@@ -77,6 +77,11 @@
 
 static struct ccw_driver dasd_eckd_driver; /* see below */
 
+#define INIT_CQR_OK 0
+#define INIT_CQR_UNFORMATTED 1
+#define INIT_CQR_ERROR 2
+
+
 /* initial attempt at a probe function. this can be simplified once
  * the other detection code is gone */
 static int
@@ -748,8 +753,7 @@
 	cqr->block = NULL;
 	cqr->expires = 10*HZ;
 	cqr->lpm = lpm;
-	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
-	cqr->retries = 2;
+	cqr->retries = 256;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
@@ -948,8 +952,7 @@
 	cqr->startdev = device;
 	cqr->memdev = device;
 	cqr->block = NULL;
-	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
-	cqr->retries = 5;
+	cqr->retries = 256;
 	cqr->expires = 10 * HZ;
 
 	/* Prepare for Read Subsystem Data */
@@ -1024,6 +1027,7 @@
 	cqr->startdev = device;
 	cqr->memdev = device;
 	cqr->block = NULL;
+	cqr->retries = 256;
 	cqr->expires = 10*HZ;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1067,6 +1071,7 @@
 	else
 		enable_pav = 1;
 	rc = dasd_eckd_psf_ssc(device, enable_pav);
+
 	/* may be requested feature is not available on server,
 	 * therefore just report error and go ahead */
 	private = (struct dasd_eckd_private *) device->private;
@@ -1255,12 +1260,29 @@
 	cqr->block = NULL;
 	cqr->startdev = device;
 	cqr->memdev = device;
-	cqr->retries = 0;
+	cqr->retries = 255;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
 }
 
+/* differentiate between 'no record found' and any other error */
+static int dasd_eckd_analysis_evaluation(struct dasd_ccw_req *init_cqr)
+{
+	char *sense;
+	if (init_cqr->status == DASD_CQR_DONE)
+		return INIT_CQR_OK;
+	else if (init_cqr->status == DASD_CQR_NEED_ERP ||
+		 init_cqr->status == DASD_CQR_FAILED) {
+		sense = dasd_get_sense(&init_cqr->irb);
+		if (sense && (sense[1] & SNS1_NO_REC_FOUND))
+			return INIT_CQR_UNFORMATTED;
+		else
+			return INIT_CQR_ERROR;
+	} else
+		return INIT_CQR_ERROR;
+}
+
 /*
  * This is the callback function for the init_analysis cqr. It saves
  * the status of the initial analysis ccw before it frees it and kicks
@@ -1268,21 +1290,20 @@
  * dasd_eckd_do_analysis again (if the devices has not been marked
  * for deletion in the meantime).
  */
-static void
-dasd_eckd_analysis_callback(struct dasd_ccw_req *init_cqr, void *data)
+static void dasd_eckd_analysis_callback(struct dasd_ccw_req *init_cqr,
+					void *data)
 {
 	struct dasd_eckd_private *private;
 	struct dasd_device *device;
 
 	device = init_cqr->startdev;
 	private = (struct dasd_eckd_private *) device->private;
-	private->init_cqr_status = init_cqr->status;
+	private->init_cqr_status = dasd_eckd_analysis_evaluation(init_cqr);
 	dasd_sfree_request(init_cqr, device);
 	dasd_kick_device(device);
 }
 
-static int
-dasd_eckd_start_analysis(struct dasd_block *block)
+static int dasd_eckd_start_analysis(struct dasd_block *block)
 {
 	struct dasd_eckd_private *private;
 	struct dasd_ccw_req *init_cqr;
@@ -1294,27 +1315,44 @@
 	init_cqr->callback = dasd_eckd_analysis_callback;
 	init_cqr->callback_data = NULL;
 	init_cqr->expires = 5*HZ;
+	/* first try without ERP, so we can later handle unformatted
+	 * devices as special case
+	 */
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &init_cqr->flags);
+	init_cqr->retries = 0;
 	dasd_add_request_head(init_cqr);
 	return -EAGAIN;
 }
 
-static int
-dasd_eckd_end_analysis(struct dasd_block *block)
+static int dasd_eckd_end_analysis(struct dasd_block *block)
 {
 	struct dasd_device *device;
 	struct dasd_eckd_private *private;
 	struct eckd_count *count_area;
 	unsigned int sb, blk_per_trk;
 	int status, i;
+	struct dasd_ccw_req *init_cqr;
 
 	device = block->base;
 	private = (struct dasd_eckd_private *) device->private;
 	status = private->init_cqr_status;
 	private->init_cqr_status = -1;
-	if (status != DASD_CQR_DONE) {
-		dev_warn(&device->cdev->dev,
-			    "The DASD is not formatted\n");
+	if (status == INIT_CQR_ERROR) {
+		/* try again, this time with full ERP */
+		init_cqr = dasd_eckd_analysis_ccw(device);
+		dasd_sleep_on(init_cqr);
+		status = dasd_eckd_analysis_evaluation(init_cqr);
+		dasd_sfree_request(init_cqr, device);
+	}
+
+	if (status == INIT_CQR_UNFORMATTED) {
+		dev_warn(&device->cdev->dev, "The DASD is not formatted\n");
 		return -EMEDIUMTYPE;
+	} else if (status == INIT_CQR_ERROR) {
+		dev_err(&device->cdev->dev,
+			"Detecting the DASD disk layout failed because "
+			"of an I/O error\n");
+		return -EIO;
 	}
 
 	private->uses_cdl = 1;
@@ -1606,8 +1644,7 @@
 	}
 	fcp->startdev = device;
 	fcp->memdev = device;
-	clear_bit(DASD_CQR_FLAGS_USE_ERP, &fcp->flags);
-	fcp->retries = 5;	/* set retry counter to enable default ERP */
+	fcp->retries = 256;
 	fcp->buildclk = get_clock();
 	fcp->status = DASD_CQR_FILLED;
 	return fcp;
@@ -2689,6 +2726,7 @@
 	cqr->startdev = device;
 	cqr->memdev = device;
 	cqr->retries = 0;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	cqr->expires = 10 * HZ;
 
 	/* Prepare for Read Subsystem Data */
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_int.h	2009-11-13 16:08:16.000000000 +0100
@@ -595,6 +595,9 @@
 int dasd_generic_read_dev_chars(struct dasd_device *, int, void *, int);
 char *dasd_get_sense(struct irb *);
 
+void dasd_device_set_stop_bits(struct dasd_device *, int);
+void dasd_device_remove_stop_bits(struct dasd_device *, int);
+
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;
Index: quilt-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_ioctl.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_ioctl.c	2009-11-13 16:08:16.000000000 +0100
@@ -101,7 +101,7 @@
 	pr_info("%s: The DASD has been put in the quiesce "
 		"state\n", dev_name(&base->cdev->dev));
 	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
-	base->stopped |= DASD_STOPPED_QUIESCE;
+	dasd_device_set_stop_bits(base, DASD_STOPPED_QUIESCE);
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
@@ -122,7 +122,7 @@
 	pr_info("%s: I/O operations have been resumed "
 		"on the DASD\n", dev_name(&base->cdev->dev));
 	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
-	base->stopped &= ~DASD_STOPPED_QUIESCE;
+	dasd_device_remove_stop_bits(base, DASD_STOPPED_QUIESCE);
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
