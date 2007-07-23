Return-Path: <linux-kernel-owner+w=401wt.eu-S933142AbXGWI44@vger.kernel.org>
Message-Id: <20070723085708.625132482@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 7/9] cio: Remove deprecated rdc/rcd.
Content-Disposition: inline; filename=007-cio-rdc-rcd.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

http://marc.info/?l=linux-kernel&m=118481061928246&w=2 seems to
indicate disfavour of "deprecated", so let's just kill it now.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/feature-removal-schedule.txt |   16 -
 drivers/s390/cio/device_ops.c              |  250 -----------------------------
 include/asm-s390/ccwdev.h                  |    5 
 3 files changed, 271 deletions(-)

Index: quilt-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- quilt-2.6.orig/Documentation/feature-removal-schedule.txt
+++ quilt-2.6/Documentation/feature-removal-schedule.txt
@@ -211,22 +211,6 @@ Who:	Richard Purdie <rpurdie@rpsys.net>
 
 ---------------------------
 
-What:	read_dev_chars(), read_conf_data{,_lpm}() (s390 common I/O layer)
-When:	December 2007
-Why:	These functions are a leftover from 2.4 times. They have several
-	problems:
-	- Duplication of checks that are done in the device driver's
-	  interrupt handler
-	- common I/O layer can't do device specific error recovery
-	- device driver can't be notified for conditions happening during
-	  execution of the function
-	Device drivers should issue the read device characteristics and read
-	configuration data ccws and do the appropriate error handling
-	themselves.
-Who:	Cornelia Huck <cornelia.huck@de.ibm.com>
-
----------------------------
-
 What:	i2c-ixp2000, i2c-ixp4xx and scx200_i2c drivers
 When:	September 2007
 Why:	Obsolete. The new i2c-gpio driver replaces all hardware-specific
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -288,253 +288,6 @@ ccw_device_get_path_mask(struct ccw_devi
 		return sch->lpm;
 }
 
-static void
-ccw_device_wake_up(struct ccw_device *cdev, unsigned long ip, struct irb *irb)
-{
-	if (!ip)
-		/* unsolicited interrupt */
-		return;
-
-	/* Abuse intparm for error reporting. */
-	if (IS_ERR(irb))
-		cdev->private->intparm = -EIO;
-	else if (irb->scsw.cc == 1)
-		/* Retry for deferred condition code. */
-		cdev->private->intparm = -EAGAIN;
-	else if ((irb->scsw.dstat !=
-		  (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-		 (irb->scsw.cstat != 0)) {
-		/*
-		 * We didn't get channel end / device end. Check if path
-		 * verification has been started; we can retry after it has
-		 * finished. We also retry unit checks except for command reject
-		 * or intervention required. Also check for long busy
-		 * conditions.
-		 */
-		 if (cdev->private->flags.doverify ||
-			 cdev->private->state == DEV_STATE_VERIFY)
-			 cdev->private->intparm = -EAGAIN;
-		else if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
-			 !(irb->ecw[0] &
-			   (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
-			cdev->private->intparm = -EAGAIN;
-		else if ((irb->scsw.dstat & DEV_STAT_ATTENTION) &&
-			 (irb->scsw.dstat & DEV_STAT_DEV_END) &&
-			 (irb->scsw.dstat & DEV_STAT_UNIT_EXCEP))
-			cdev->private->intparm = -EAGAIN;
-		 else
-			 cdev->private->intparm = -EIO;
-			 
-	} else
-		cdev->private->intparm = 0;
-	wake_up(&cdev->private->wait_q);
-}
-
-static int
-__ccw_device_retry_loop(struct ccw_device *cdev, struct ccw1 *ccw, long magic, __u8 lpm)
-{
-	int ret;
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
-	do {
-		ccw_device_set_timeout(cdev, 60 * HZ);
-		ret = cio_start (sch, ccw, lpm);
-		if (ret != 0)
-			ccw_device_set_timeout(cdev, 0);
-		if (ret == -EBUSY) {
-			/* Try again later. */
-			spin_unlock_irq(sch->lock);
-			msleep(10);
-			spin_lock_irq(sch->lock);
-			continue;
-		}
-		if (ret != 0)
-			/* Non-retryable error. */
-			break;
-		/* Wait for end of request. */
-		cdev->private->intparm = magic;
-		spin_unlock_irq(sch->lock);
-		wait_event(cdev->private->wait_q,
-			   (cdev->private->intparm == -EIO) ||
-			   (cdev->private->intparm == -EAGAIN) ||
-			   (cdev->private->intparm == 0));
-		spin_lock_irq(sch->lock);
-		/* Check at least for channel end / device end */
-		if (cdev->private->intparm == -EIO) {
-			/* Non-retryable error. */
-			ret = -EIO;
-			break;
-		}
-		if (cdev->private->intparm == 0)
-			/* Success. */
-			break;
-		/* Try again later. */
-		spin_unlock_irq(sch->lock);
-		msleep(10);
-		spin_lock_irq(sch->lock);
-	} while (1);
-
-	return ret;
-}
-
-/**
- * read_dev_chars() - read device characteristics
- * @param cdev   target ccw device
- * @param buffer pointer to buffer for rdc data
- * @param length size of rdc data
- * @returns 0 for success, negative error value on failure
- *
- * Context:
- *   called for online device, lock not held
- **/
-int
-read_dev_chars (struct ccw_device *cdev, void **buffer, int length)
-{
-	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
-	struct subchannel *sch;
-	int ret;
-	struct ccw1 *rdc_ccw;
-
-	if (!cdev)
-		return -ENODEV;
-	if (!buffer || !length)
-		return -EINVAL;
-	sch = to_subchannel(cdev->dev.parent);
-
-	CIO_TRACE_EVENT (4, "rddevch");
-	CIO_TRACE_EVENT (4, sch->dev.bus_id);
-
-	rdc_ccw = kzalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
-	if (!rdc_ccw)
-		return -ENOMEM;
-	rdc_ccw->cmd_code = CCW_CMD_RDC;
-	rdc_ccw->count = length;
-	rdc_ccw->flags = CCW_FLAG_SLI;
-	ret = set_normalized_cda (rdc_ccw, (*buffer));
-	if (ret != 0) {
-		kfree(rdc_ccw);
-		return ret;
-	}
-
-	spin_lock_irq(sch->lock);
-	/* Save interrupt handler. */
-	handler = cdev->handler;
-	/* Temporarily install own handler. */
-	cdev->handler = ccw_device_wake_up;
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		ret = -ENODEV;
-	else if (((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
-		  !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) ||
-		 cdev->private->flags.doverify)
-		ret = -EBUSY;
-	else
-		/* 0x00D9C4C3 == ebcdic "RDC" */
-		ret = __ccw_device_retry_loop(cdev, rdc_ccw, 0x00D9C4C3, 0);
-
-	/* Restore interrupt handler. */
-	cdev->handler = handler;
-	spin_unlock_irq(sch->lock);
-
-	clear_normalized_cda (rdc_ccw);
-	kfree(rdc_ccw);
-
-	return ret;
-}
-
-/*
- *  Read Configuration data using path mask
- */
-int
-read_conf_data_lpm (struct ccw_device *cdev, void **buffer, int *length, __u8 lpm)
-{
-	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
-	struct subchannel *sch;
-	struct ciw *ciw;
-	char *rcd_buf;
-	int ret;
-	struct ccw1 *rcd_ccw;
-
-	if (!cdev)
-		return -ENODEV;
-	if (!buffer || !length)
-		return -EINVAL;
-	sch = to_subchannel(cdev->dev.parent);
-
-	CIO_TRACE_EVENT (4, "rdconf");
-	CIO_TRACE_EVENT (4, sch->dev.bus_id);
-
-	/*
-	 * scan for RCD command in extended SenseID data
-	 */
-	ciw = ccw_device_get_ciw(cdev, CIW_TYPE_RCD);
-	if (!ciw || ciw->cmd == 0)
-		return -EOPNOTSUPP;
-
-	/* Adjust requested path mask to excluded varied off paths. */
-	if (lpm) {
-		lpm &= sch->opm;
-		if (lpm == 0)
-			return -EACCES;
-	}
-
-	rcd_ccw = kzalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
-	if (!rcd_ccw)
-		return -ENOMEM;
-	rcd_buf = kzalloc(ciw->count, GFP_KERNEL | GFP_DMA);
- 	if (!rcd_buf) {
-		kfree(rcd_ccw);
-		return -ENOMEM;
-	}
-	rcd_ccw->cmd_code = ciw->cmd;
-	rcd_ccw->cda = (__u32) __pa (rcd_buf);
-	rcd_ccw->count = ciw->count;
-	rcd_ccw->flags = CCW_FLAG_SLI;
-
-	spin_lock_irq(sch->lock);
-	/* Save interrupt handler. */
-	handler = cdev->handler;
-	/* Temporarily install own handler. */
-	cdev->handler = ccw_device_wake_up;
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		ret = -ENODEV;
-	else if (((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
-		  !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) ||
-		 cdev->private->flags.doverify)
-		ret = -EBUSY;
-	else
-		/* 0x00D9C3C4 == ebcdic "RCD" */
-		ret = __ccw_device_retry_loop(cdev, rcd_ccw, 0x00D9C3C4, lpm);
-
-	/* Restore interrupt handler. */
-	cdev->handler = handler;
-	spin_unlock_irq(sch->lock);
-
- 	/*
- 	 * on success we update the user input parms
- 	 */
- 	if (ret) {
- 		kfree (rcd_buf);
- 		*buffer = NULL;
- 		*length = 0;
- 	} else {
-		*length = ciw->count;
-		*buffer = rcd_buf;
-	}
-	kfree(rcd_ccw);
-
-	return ret;
-}
-
-/*
- *  Read Configuration data
- */
-int
-read_conf_data (struct ccw_device *cdev, void **buffer, int *length)
-{
-	return read_conf_data_lpm (cdev, buffer, length, 0);
-}
-
 /*
  * Try to break the lock on a boxed device.
  */
@@ -649,8 +402,5 @@ EXPORT_SYMBOL(ccw_device_start_timeout_k
 EXPORT_SYMBOL(ccw_device_start_key);
 EXPORT_SYMBOL(ccw_device_get_ciw);
 EXPORT_SYMBOL(ccw_device_get_path_mask);
-EXPORT_SYMBOL(read_conf_data);
-EXPORT_SYMBOL(read_dev_chars);
 EXPORT_SYMBOL(_ccw_device_get_subchannel_number);
 EXPORT_SYMBOL_GPL(ccw_device_get_chp_desc);
-EXPORT_SYMBOL_GPL(read_conf_data_lpm);
Index: quilt-2.6/include/asm-s390/ccwdev.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ccwdev.h
+++ quilt-2.6/include/asm-s390/ccwdev.h
@@ -165,11 +165,6 @@ extern int ccw_device_resume(struct ccw_
 extern int ccw_device_halt(struct ccw_device *, unsigned long);
 extern int ccw_device_clear(struct ccw_device *, unsigned long);
 
-extern int __deprecated read_dev_chars(struct ccw_device *cdev, void **buffer, int length);
-extern int __deprecated read_conf_data(struct ccw_device *cdev, void **buffer, int *length);
-extern int __deprecated read_conf_data_lpm(struct ccw_device *cdev, void **buffer,
-			      int *length, __u8 lpm);
-
 extern int ccw_device_set_online(struct ccw_device *cdev);
 extern int ccw_device_set_offline(struct ccw_device *cdev);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
