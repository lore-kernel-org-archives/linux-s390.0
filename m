Return-Path: <linux-kernel-owner+w=401wt.eu-S934456AbXLTPXe@vger.kernel.org>
Message-Id: <20071220152103.789774292@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/47] cio: css_driver: Use consistent parameters.
Content-Disposition: inline; filename=103-cio-callbacks.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make all callbacks in css_driver take a struct subchannel (and not
a struct device).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c       |   16 ++++++++--------
 drivers/s390/cio/cio.c        |    4 ++--
 drivers/s390/cio/css.c        |    2 +-
 drivers/s390/cio/css.h        |    8 ++++----
 drivers/s390/cio/device.c     |   38 ++++++++++++++++++++++++--------------
 drivers/s390/cio/device.h     |    1 -
 drivers/s390/cio/device_fsm.c |   19 +------------------
 7 files changed, 40 insertions(+), 48 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -132,7 +132,7 @@ static void terminate_internal_io(struct
 	device_set_intretry(sch);
 	/* Call handler. */
 	if (sch->driver && sch->driver->termination)
-		sch->driver->termination(&sch->dev);
+		sch->driver->termination(sch);
 }
 
 static int
@@ -172,12 +172,12 @@ s390_subchannel_remove_chpid(struct devi
 			terminate_internal_io(sch);
 			/* Re-start path verification. */
 			if (sch->driver && sch->driver->verify)
-				sch->driver->verify(&sch->dev);
+				sch->driver->verify(sch);
 		}
 	} else {
 		/* trigger path verification. */
 		if (sch->driver && sch->driver->verify)
-			sch->driver->verify(&sch->dev);
+			sch->driver->verify(sch);
 		else if (sch->lpm == mask)
 			goto out_unreg;
 	}
@@ -279,7 +279,7 @@ __s390_process_res_acc(struct subchannel
 	if (!old_lpm && sch->lpm)
 		device_trigger_reprobe(sch);
 	else if (sch->driver && sch->driver->verify)
-		sch->driver->verify(&sch->dev);
+		sch->driver->verify(sch);
 out:
 	spin_unlock_irq(sch->lock);
 	put_device(&sch->dev);
@@ -549,7 +549,7 @@ __chp_add(struct subchannel_id schid, vo
 		    | mask) & sch->opm;
 
 	if (sch->driver && sch->driver->verify)
-		sch->driver->verify(&sch->dev);
+		sch->driver->verify(sch);
 
 	spin_unlock_irq(sch->lock);
 	put_device(&sch->dev);
@@ -589,7 +589,7 @@ static void __s390_subchannel_vary_chpid
 			if (!old_lpm)
 				device_trigger_reprobe(sch);
 			else if (sch->driver && sch->driver->verify)
-				sch->driver->verify(&sch->dev);
+				sch->driver->verify(sch);
 			break;
 		}
 		sch->opm &= ~mask;
@@ -603,13 +603,13 @@ static void __s390_subchannel_vary_chpid
 				terminate_internal_io(sch);
 				/* Re-start path verification. */
 				if (sch->driver && sch->driver->verify)
-					sch->driver->verify(&sch->dev);
+					sch->driver->verify(sch);
 			}
 		} else if (!sch->lpm) {
 			if (device_trigger_verify(sch) != 0)
 				css_schedule_eval(sch->schid);
 		} else if (sch->driver && sch->driver->verify)
-			sch->driver->verify(&sch->dev);
+			sch->driver->verify(sch);
 		break;
 	}
 	spin_unlock_irqrestore(sch->lock, flags);
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -147,7 +147,7 @@ cio_tpi(void)
 	spin_lock(sch->lock);
 	memcpy (&sch->schib.scsw, &irb->scsw, sizeof (struct scsw));
 	if (sch->driver && sch->driver->irq)
-		sch->driver->irq(&sch->dev);
+		sch->driver->irq(sch);
 	spin_unlock(sch->lock);
 	irq_exit ();
 	_local_bh_enable();
@@ -680,7 +680,7 @@ do_IRQ (struct pt_regs *regs)
 				sizeof (irb->scsw));
 			/* Call interrupt handler if there is one. */
 			if (sch->driver && sch->driver->irq)
-				sch->driver->irq(&sch->dev);
+				sch->driver->irq(sch);
 		}
 		if (sch)
 			spin_unlock(sch->lock);
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -293,7 +293,7 @@ static int css_evaluate_known_subchannel
 		action = UNREGISTER;
 		if (sch->driver && sch->driver->notify) {
 			spin_unlock_irqrestore(sch->lock, flags);
-			ret = sch->driver->notify(&sch->dev, event);
+			ret = sch->driver->notify(sch, event);
 			spin_lock_irqsave(sch->lock, flags);
 			if (ret)
 				action = NONE;
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -125,10 +125,10 @@ struct subchannel;
 struct css_driver {
 	unsigned int subchannel_type;
 	struct device_driver drv;
-	void (*irq)(struct device *);
-	int (*notify)(struct device *, int);
-	void (*verify)(struct device *);
-	void (*termination)(struct device *);
+	void (*irq)(struct subchannel *);
+	int (*notify)(struct subchannel *, int);
+	void (*verify)(struct subchannel *);
+	void (*termination)(struct subchannel *);
 	int (*probe)(struct subchannel *);
 	int (*remove)(struct subchannel *);
 	void (*shutdown)(struct subchannel *);
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -115,11 +115,12 @@ static int ccw_uevent(struct device *dev
 
 struct bus_type ccw_bus_type;
 
-static int io_subchannel_probe (struct subchannel *);
-static int io_subchannel_remove (struct subchannel *);
-static int io_subchannel_notify(struct device *, int);
-static void io_subchannel_verify(struct device *);
-static void io_subchannel_ioterm(struct device *);
+static void io_subchannel_irq(struct subchannel *);
+static int io_subchannel_probe(struct subchannel *);
+static int io_subchannel_remove(struct subchannel *);
+static int io_subchannel_notify(struct subchannel *, int);
+static void io_subchannel_verify(struct subchannel *);
+static void io_subchannel_ioterm(struct subchannel *);
 static void io_subchannel_shutdown(struct subchannel *);
 
 static struct css_driver io_subchannel_driver = {
@@ -1096,6 +1097,18 @@ out:
 	put_device(&cdev->dev);
 }
 
+static void io_subchannel_irq(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+
+	cdev = sch->dev.driver_data;
+
+	CIO_TRACE_EVENT(3, "IRQ");
+	CIO_TRACE_EVENT(3, sch->dev.bus_id);
+	if (cdev)
+		dev_fsm_event(cdev, DEV_EVENT_INTERRUPT);
+}
+
 static int
 io_subchannel_probe (struct subchannel *sch)
 {
@@ -1183,12 +1196,11 @@ io_subchannel_remove (struct subchannel 
 	return 0;
 }
 
-static int
-io_subchannel_notify(struct device *dev, int event)
+static int io_subchannel_notify(struct subchannel *sch, int event)
 {
 	struct ccw_device *cdev;
 
-	cdev = dev->driver_data;
+	cdev = sch->dev.driver_data;
 	if (!cdev)
 		return 0;
 	if (!cdev->drv)
@@ -1198,22 +1210,20 @@ io_subchannel_notify(struct device *dev,
 	return cdev->drv->notify ? cdev->drv->notify(cdev, event) : 0;
 }
 
-static void
-io_subchannel_verify(struct device *dev)
+static void io_subchannel_verify(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 
-	cdev = dev->driver_data;
+	cdev = sch->dev.driver_data;
 	if (cdev)
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
 }
 
-static void
-io_subchannel_ioterm(struct device *dev)
+static void io_subchannel_ioterm(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 
-	cdev = dev->driver_data;
+	cdev = sch->dev.driver_data;
 	if (!cdev)
 		return;
 	/* Internal I/O will be retried by the interrupt handler. */
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -399,7 +399,7 @@ ccw_device_oper_notify(struct work_struc
 	sch = to_subchannel(cdev->dev.parent);
 	if (sch->driver && sch->driver->notify) {
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		ret = sch->driver->notify(&sch->dev, CIO_OPER);
+		ret = sch->driver->notify(sch, CIO_OPER);
 		spin_lock_irqsave(cdev->ccwlock, flags);
 	} else
 		ret = 0;
@@ -1273,21 +1273,4 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 	},
 };
 
-/*
- * io_subchannel_irq is called for "real" interrupts or for status
- * pending conditions on msch.
- */
-void
-io_subchannel_irq (struct device *pdev)
-{
-	struct ccw_device *cdev;
-
-	cdev = to_subchannel(pdev)->dev.driver_data;
-
-	CIO_TRACE_EVENT (3, "IRQ");
-	CIO_TRACE_EVENT (3, pdev->bus_id);
-	if (cdev)
-		dev_fsm_event(cdev, DEV_EVENT_INTERRUPT);
-}
-
 EXPORT_SYMBOL_GPL(ccw_device_set_timeout);
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h
+++ quilt-2.6/drivers/s390/cio/device.h
@@ -74,7 +74,6 @@ extern struct workqueue_struct *ccw_devi
 extern wait_queue_head_t ccw_device_init_wq;
 extern atomic_t ccw_device_init_count;
 
-void io_subchannel_irq (struct device *pdev);
 void io_subchannel_recog_done(struct ccw_device *cdev);
 
 int ccw_device_cancel_halt_clear(struct ccw_device *);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
