Return-Path: <linux-kernel-owner+w=401wt.eu-S1759500AbYFYOnJ@vger.kernel.org>
Message-Id: <20080625143612.618388443@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/21] Cleanup 3215 printk messages.
Content-Disposition: inline; filename=804-printk-con3215.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/con3215.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

Index: quilt-2.6/drivers/s390/char/con3215.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/con3215.c
+++ quilt-2.6/drivers/s390/char/con3215.c
@@ -93,9 +93,6 @@ struct raw3215_info {
 	struct raw3215_req *queued_write;/* pointer to queued write requests */
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
 	struct timer_list timer;      /* timer for delayed output */
-	char *message;		      /* pending message from raw3215_irq */
-	int msg_dstat;		      /* dstat for pending message */
-	int msg_cstat;		      /* cstat for pending message */
 	int line_pos;		      /* position on the line (for tabs) */
 	char ubuffer[80];	      /* copy_from_user buffer */
 };
@@ -359,11 +356,6 @@ raw3215_tasklet(void *data)
 	raw3215_mk_write_req(raw);
 	raw3215_try_io(raw);
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
-	/* Check for pending message from raw3215_irq */
-	if (raw->message != NULL) {
-		printk(raw->message, raw->msg_dstat, raw->msg_cstat);
-		raw->message = NULL;
-	}
 	tty = raw->tty;
 	if (tty != NULL &&
 	    RAW3215_BUFFER_SIZE - raw->count >= RAW3215_MIN_SPACE) {
@@ -387,14 +379,8 @@ raw3215_irq(struct ccw_device *cdev, uns
 	req = (struct raw3215_req *) intparm;
 	cstat = irb->scsw.cmd.cstat;
 	dstat = irb->scsw.cmd.dstat;
-	if (cstat != 0) {
-		raw->message = KERN_WARNING
-			"Got nonzero channel status in raw3215_irq "
-			"(dev sts 0x%2x, sch sts 0x%2x)";
-		raw->msg_dstat = dstat;
-		raw->msg_cstat = cstat;
+	if (cstat != 0)
 		tasklet_schedule(&raw->tasklet);
-	}
 	if (dstat & 0x01) { /* we got a unit exception */
 		dstat &= ~0x01;	 /* we can ignore it */
 	}
@@ -481,11 +467,6 @@ raw3215_irq(struct ccw_device *cdev, uns
 			raw->flags &= ~RAW3215_WORKING;
 			raw3215_free_req(req);
 		}
-		raw->message = KERN_WARNING
-			"Spurious interrupt in in raw3215_irq "
-			"(dev sts 0x%2x, sch sts 0x%2x)";
-		raw->msg_dstat = dstat;
-		raw->msg_cstat = cstat;
 		tasklet_schedule(&raw->tasklet);
 	}
 	return;
@@ -883,7 +864,6 @@ con3215_init(void)
 		free_bootmem((unsigned long) raw->buffer, RAW3215_BUFFER_SIZE);
 		free_bootmem((unsigned long) raw, sizeof(struct raw3215_info));
 		raw3215[0] = NULL;
-		printk("Couldn't find a 3215 console device\n");
 		return -ENODEV;
 	}
 	register_console(&con3215);
@@ -1157,7 +1137,6 @@ tty3215_init(void)
 	tty_set_operations(driver, &tty3215_ops);
 	ret = tty_register_driver(driver);
 	if (ret) {
-		printk("Couldn't register tty3215 driver\n");
 		put_tty_driver(driver);
 		return ret;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
