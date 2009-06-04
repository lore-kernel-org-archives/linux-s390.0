Return-Path: <linux-kernel-owner+w=401wt.eu-S1758038AbZFDQXM@vger.kernel.org>
Message-Id: <20090604161905.824614656@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 26/38] pm: power management support for SCLP drivers.
Content-Disposition: inline; filename=pm_sclp.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

The SCLP base driver defines a new notifier call back for all upper level SCLP
drivers, like the SCLP console, etc. This guarantees that in suspend first the
upper level drivers are suspended and afterwards the SCLP base driver. For
resume it is the other way round. The SCLP base driver itself registers a
new platform device at the platform bus and gets PM notifications via
the dev_pm_ops.

In suspend, the SCLP base driver switches off the receiver and sender mask 
This is done in sclp_deactivate(). After suspend all new requests will be
rejected with -EIO and no more interrupts will be received, because the masks
are switched off. For resume the sender and receiver masks are reset in
the sclp_reactivate() function.

When the SCLP console is suspended, all new messages are cached in the
sclp console buffers. In resume, all the cached messages are written to the
console. In addition to that we have an early resume function that removes
the cached messages from the suspend image.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/char/sclp.c       |  248 ++++++++++++++++++++++++++++++++++++-----
 drivers/s390/char/sclp.h       |   23 ++-
 drivers/s390/char/sclp_con.c   |  139 ++++++++++++++++------
 drivers/s390/char/sclp_rw.c    |   20 ++-
 drivers/s390/char/sclp_rw.h    |   12 -
 drivers/s390/char/sclp_vt220.c |  118 +++++++++++++------
 6 files changed, 432 insertions(+), 128 deletions(-)

Index: linux-2.6/drivers/s390/char/sclp.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp.c
+++ linux-2.6/drivers/s390/char/sclp.c
@@ -1,11 +1,10 @@
 /*
- *  drivers/s390/char/sclp.c
- *     core function to access sclp interface
+ * core function to access sclp interface
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
- *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ * Copyright IBM Corp. 1999, 2009
+ *
+ * Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #include <linux/module.h>
@@ -16,6 +15,9 @@
 #include <linux/reboot.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
+#include <linux/suspend.h>
+#include <linux/completion.h>
+#include <linux/platform_device.h>
 #include <asm/types.h>
 #include <asm/s390_ext.h>
 
@@ -47,6 +49,16 @@ static struct sclp_req sclp_init_req;
 static char sclp_read_sccb[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 static char sclp_init_sccb[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
+/* Suspend request */
+static DECLARE_COMPLETION(sclp_request_queue_flushed);
+
+static void sclp_suspend_req_cb(struct sclp_req *req, void *data)
+{
+	complete(&sclp_request_queue_flushed);
+}
+
+static struct sclp_req sclp_suspend_req;
+
 /* Timer for request retries. */
 static struct timer_list sclp_request_timer;
 
@@ -84,6 +96,12 @@ static volatile enum sclp_mask_state_t {
 	sclp_mask_state_initializing
 } sclp_mask_state = sclp_mask_state_idle;
 
+/* Internal state: is the driver suspended? */
+static enum sclp_suspend_state_t {
+	sclp_suspend_state_running,
+	sclp_suspend_state_suspended,
+} sclp_suspend_state = sclp_suspend_state_running;
+
 /* Maximum retry counts */
 #define SCLP_INIT_RETRY		3
 #define SCLP_MASK_RETRY		3
@@ -211,6 +229,8 @@ sclp_process_queue(void)
 	del_timer(&sclp_request_timer);
 	while (!list_empty(&sclp_req_queue)) {
 		req = list_entry(sclp_req_queue.next, struct sclp_req, list);
+		if (!req->sccb)
+			goto do_post;
 		rc = __sclp_start_request(req);
 		if (rc == 0)
 			break;
@@ -222,6 +242,7 @@ sclp_process_queue(void)
 						 sclp_request_timeout, 0);
 			break;
 		}
+do_post:
 		/* Post-processing for aborted request */
 		list_del(&req->list);
 		if (req->callback) {
@@ -233,6 +254,19 @@ sclp_process_queue(void)
 	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
+static int __sclp_can_add_request(struct sclp_req *req)
+{
+	if (req == &sclp_suspend_req || req == &sclp_init_req)
+		return 1;
+	if (sclp_suspend_state != sclp_suspend_state_running)
+		return 0;
+	if (sclp_init_state != sclp_init_state_initialized)
+		return 0;
+	if (sclp_activation_state != sclp_activation_state_active)
+		return 0;
+	return 1;
+}
+
 /* Queue a new request. Return zero on success, non-zero otherwise. */
 int
 sclp_add_request(struct sclp_req *req)
@@ -241,9 +275,7 @@ sclp_add_request(struct sclp_req *req)
 	int rc;
 
 	spin_lock_irqsave(&sclp_lock, flags);
-	if ((sclp_init_state != sclp_init_state_initialized ||
-	     sclp_activation_state != sclp_activation_state_active) &&
-	    req != &sclp_init_req) {
+	if (!__sclp_can_add_request(req)) {
 		spin_unlock_irqrestore(&sclp_lock, flags);
 		return -EIO;
 	}
@@ -254,10 +286,16 @@ sclp_add_request(struct sclp_req *req)
 	/* Start if request is first in list */
 	if (sclp_running_state == sclp_running_state_idle &&
 	    req->list.prev == &sclp_req_queue) {
+		if (!req->sccb) {
+			list_del(&req->list);
+			rc = -ENODATA;
+			goto out;
+		}
 		rc = __sclp_start_request(req);
 		if (rc)
 			list_del(&req->list);
 	}
+out:
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	return rc;
 }
@@ -560,6 +598,7 @@ sclp_register(struct sclp_register *reg)
 	/* Trigger initial state change callback */
 	reg->sclp_receive_mask = 0;
 	reg->sclp_send_mask = 0;
+	reg->pm_event_posted = 0;
 	list_add(&reg->list, &sclp_reg_list);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	rc = sclp_init_mask(1);
@@ -880,20 +919,134 @@ static struct notifier_block sclp_reboot
 	.notifier_call = sclp_reboot_event
 };
 
+/*
+ * Suspend/resume SCLP notifier implementation
+ */
+
+static void sclp_pm_event(enum sclp_pm_event sclp_pm_event, int rollback)
+{
+	struct sclp_register *reg;
+	unsigned long flags;
+
+	if (!rollback) {
+		spin_lock_irqsave(&sclp_lock, flags);
+		list_for_each_entry(reg, &sclp_reg_list, list)
+			reg->pm_event_posted = 0;
+		spin_unlock_irqrestore(&sclp_lock, flags);
+	}
+	do {
+		spin_lock_irqsave(&sclp_lock, flags);
+		list_for_each_entry(reg, &sclp_reg_list, list) {
+			if (rollback && reg->pm_event_posted)
+				goto found;
+			if (!rollback && !reg->pm_event_posted)
+				goto found;
+		}
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return;
+found:
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		if (reg->pm_event_fn)
+			reg->pm_event_fn(reg, sclp_pm_event);
+		reg->pm_event_posted = rollback ? 0 : 1;
+	} while (1);
+}
+
+/*
+ * Susend/resume callbacks for platform device
+ */
+
+static int sclp_freeze(struct device *dev)
+{
+	unsigned long flags;
+	int rc;
+
+	sclp_pm_event(SCLP_PM_EVENT_FREEZE, 0);
+
+	spin_lock_irqsave(&sclp_lock, flags);
+	sclp_suspend_state = sclp_suspend_state_suspended;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+
+	/* Init supend data */
+	memset(&sclp_suspend_req, 0, sizeof(sclp_suspend_req));
+	sclp_suspend_req.callback = sclp_suspend_req_cb;
+	sclp_suspend_req.status = SCLP_REQ_FILLED;
+	init_completion(&sclp_request_queue_flushed);
+
+	rc = sclp_add_request(&sclp_suspend_req);
+	if (rc == 0)
+		wait_for_completion(&sclp_request_queue_flushed);
+	else if (rc != -ENODATA)
+		goto fail_thaw;
+
+	rc = sclp_deactivate();
+	if (rc)
+		goto fail_thaw;
+	return 0;
+
+fail_thaw:
+	spin_lock_irqsave(&sclp_lock, flags);
+	sclp_suspend_state = sclp_suspend_state_running;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	sclp_pm_event(SCLP_PM_EVENT_THAW, 1);
+	return rc;
+}
+
+static int sclp_undo_suspend(enum sclp_pm_event event)
+{
+	unsigned long flags;
+	int rc;
+
+	rc = sclp_reactivate();
+	if (rc)
+		return rc;
+
+	spin_lock_irqsave(&sclp_lock, flags);
+	sclp_suspend_state = sclp_suspend_state_running;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+
+	sclp_pm_event(event, 0);
+	return 0;
+}
+
+static int sclp_thaw(struct device *dev)
+{
+	return sclp_undo_suspend(SCLP_PM_EVENT_THAW);
+}
+
+static int sclp_restore(struct device *dev)
+{
+	return sclp_undo_suspend(SCLP_PM_EVENT_RESTORE);
+}
+
+static struct dev_pm_ops sclp_pm_ops = {
+	.freeze		= sclp_freeze,
+	.thaw		= sclp_thaw,
+	.restore	= sclp_restore,
+};
+
+static struct platform_driver sclp_pdrv = {
+	.driver = {
+		.name	= "sclp",
+		.owner	= THIS_MODULE,
+		.pm	= &sclp_pm_ops,
+	},
+};
+
+static struct platform_device *sclp_pdev;
+
 /* Initialize SCLP driver. Return zero if driver is operational, non-zero
  * otherwise. */
 static int
 sclp_init(void)
 {
 	unsigned long flags;
-	int rc;
+	int rc = 0;
 
 	spin_lock_irqsave(&sclp_lock, flags);
 	/* Check for previous or running initialization */
-	if (sclp_init_state != sclp_init_state_uninitialized) {
-		spin_unlock_irqrestore(&sclp_lock, flags);
-		return 0;
-	}
+	if (sclp_init_state != sclp_init_state_uninitialized)
+		goto fail_unlock;
 	sclp_init_state = sclp_init_state_initializing;
 	/* Set up variables */
 	INIT_LIST_HEAD(&sclp_req_queue);
@@ -904,27 +1057,17 @@ sclp_init(void)
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	rc = sclp_check_interface();
 	spin_lock_irqsave(&sclp_lock, flags);
-	if (rc) {
-		sclp_init_state = sclp_init_state_uninitialized;
-		spin_unlock_irqrestore(&sclp_lock, flags);
-		return rc;
-	}
+	if (rc)
+		goto fail_init_state_uninitialized;
 	/* Register reboot handler */
 	rc = register_reboot_notifier(&sclp_reboot_notifier);
-	if (rc) {
-		sclp_init_state = sclp_init_state_uninitialized;
-		spin_unlock_irqrestore(&sclp_lock, flags);
-		return rc;
-	}
+	if (rc)
+		goto fail_init_state_uninitialized;
 	/* Register interrupt handler */
 	rc = register_early_external_interrupt(0x2401, sclp_interrupt_handler,
 					       &ext_int_info_hwc);
-	if (rc) {
-		unregister_reboot_notifier(&sclp_reboot_notifier);
-		sclp_init_state = sclp_init_state_uninitialized;
-		spin_unlock_irqrestore(&sclp_lock, flags);
-		return rc;
-	}
+	if (rc)
+		goto fail_unregister_reboot_notifier;
 	sclp_init_state = sclp_init_state_initialized;
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	/* Enable service-signal external interruption - needs to happen with
@@ -932,11 +1075,56 @@ sclp_init(void)
 	ctl_set_bit(0, 9);
 	sclp_init_mask(1);
 	return 0;
+
+fail_unregister_reboot_notifier:
+	unregister_reboot_notifier(&sclp_reboot_notifier);
+fail_init_state_uninitialized:
+	sclp_init_state = sclp_init_state_uninitialized;
+fail_unlock:
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	return rc;
 }
 
+/*
+ * SCLP panic notifier: If we are suspended, we thaw SCLP in order to be able
+ * to print the panic message.
+ */
+static int sclp_panic_notify(struct notifier_block *self,
+			     unsigned long event, void *data)
+{
+	if (sclp_suspend_state == sclp_suspend_state_suspended)
+		sclp_undo_suspend(SCLP_PM_EVENT_THAW);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sclp_on_panic_nb = {
+	.notifier_call = sclp_panic_notify,
+	.priority = SCLP_PANIC_PRIO,
+};
+
 static __init int sclp_initcall(void)
 {
+	int rc;
+
+	rc = platform_driver_register(&sclp_pdrv);
+	if (rc)
+		return rc;
+	sclp_pdev = platform_device_register_simple("sclp", -1, NULL, 0);
+	rc = IS_ERR(sclp_pdev) ? PTR_ERR(sclp_pdev) : 0;
+	if (rc)
+		goto fail_platform_driver_unregister;
+	rc = atomic_notifier_chain_register(&panic_notifier_list,
+					    &sclp_on_panic_nb);
+	if (rc)
+		goto fail_platform_device_unregister;
+
 	return sclp_init();
+
+fail_platform_device_unregister:
+	platform_device_unregister(sclp_pdev);
+fail_platform_driver_unregister:
+	platform_driver_unregister(&sclp_pdrv);
+	return rc;
 }
 
 arch_initcall(sclp_initcall);
Index: linux-2.6/drivers/s390/char/sclp.h
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp.h
+++ linux-2.6/drivers/s390/char/sclp.h
@@ -1,10 +1,8 @@
 /*
- *  drivers/s390/char/sclp.h
+ * Copyright IBM Corp. 1999, 2009
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
- *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ * Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #ifndef __SCLP_H__
@@ -17,7 +15,7 @@
 
 /* maximum number of pages concerning our own memory management */
 #define MAX_KMEM_PAGES (sizeof(unsigned long) << 3)
-#define MAX_CONSOLE_PAGES	4
+#define MAX_CONSOLE_PAGES	6
 
 #define EVTYP_OPCMD		0x01
 #define EVTYP_MSG		0x02
@@ -68,6 +66,15 @@ typedef unsigned int sclp_cmdw_t;
 
 #define GDS_KEY_SELFDEFTEXTMSG	0x31
 
+enum sclp_pm_event {
+	SCLP_PM_EVENT_FREEZE,
+	SCLP_PM_EVENT_THAW,
+	SCLP_PM_EVENT_RESTORE,
+};
+
+#define SCLP_PANIC_PRIO		1
+#define SCLP_PANIC_PRIO_CLIENT	0
+
 typedef u32 sccb_mask_t;	/* ATTENTION: assumes 32bit mask !!! */
 
 struct sccb_header {
@@ -134,6 +141,10 @@ struct sclp_register {
 	void (*state_change_fn)(struct sclp_register *);
 	/* called for events in cp_receive_mask/sclp_receive_mask */
 	void (*receiver_fn)(struct evbuf_header *);
+	/* called for power management events */
+	void (*pm_event_fn)(struct sclp_register *, enum sclp_pm_event);
+	/* pm event posted flag */
+	int pm_event_posted;
 };
 
 /* externals from sclp.c */
Index: linux-2.6/drivers/s390/char/sclp_con.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp_con.c
+++ linux-2.6/drivers/s390/char/sclp_con.c
@@ -1,11 +1,9 @@
 /*
- *  drivers/s390/char/sclp_con.c
- *    SCLP line mode console driver
+ * SCLP line mode console driver
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
- *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ * Copyright IBM Corp. 1999, 2009
+ * Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #include <linux/kmod.h>
@@ -32,13 +30,14 @@ static spinlock_t sclp_con_lock;
 static struct list_head sclp_con_pages;
 /* List of full struct sclp_buffer structures ready for output */
 static struct list_head sclp_con_outqueue;
-/* Counter how many buffers are emitted (max 1) and how many */
-/* are on the output queue. */
-static int sclp_con_buffer_count;
 /* Pointer to current console buffer */
 static struct sclp_buffer *sclp_conbuf;
 /* Timer for delayed output of console messages */
 static struct timer_list sclp_con_timer;
+/* Suspend mode flag */
+static int sclp_con_suspended;
+/* Flag that output queue is currently running */
+static int sclp_con_queue_running;
 
 /* Output format for console messages */
 static unsigned short sclp_con_columns;
@@ -53,42 +52,71 @@ sclp_conbuf_callback(struct sclp_buffer 
 	do {
 		page = sclp_unmake_buffer(buffer);
 		spin_lock_irqsave(&sclp_con_lock, flags);
+
 		/* Remove buffer from outqueue */
 		list_del(&buffer->list);
-		sclp_con_buffer_count--;
 		list_add_tail((struct list_head *) page, &sclp_con_pages);
+
 		/* Check if there is a pending buffer on the out queue. */
 		buffer = NULL;
 		if (!list_empty(&sclp_con_outqueue))
-			buffer = list_entry(sclp_con_outqueue.next,
-					    struct sclp_buffer, list);
+			buffer = list_first_entry(&sclp_con_outqueue,
+						  struct sclp_buffer, list);
+		if (!buffer || sclp_con_suspended) {
+			sclp_con_queue_running = 0;
+			spin_unlock_irqrestore(&sclp_con_lock, flags);
+			break;
+		}
 		spin_unlock_irqrestore(&sclp_con_lock, flags);
-	} while (buffer && sclp_emit_buffer(buffer, sclp_conbuf_callback));
+	} while (sclp_emit_buffer(buffer, sclp_conbuf_callback));
 }
 
-static void
-sclp_conbuf_emit(void)
+/*
+ * Finalize and emit first pending buffer.
+ */
+static void sclp_conbuf_emit(void)
 {
 	struct sclp_buffer* buffer;
 	unsigned long flags;
-	int count;
 	int rc;
 
 	spin_lock_irqsave(&sclp_con_lock, flags);
-	buffer = sclp_conbuf;
+	if (sclp_conbuf)
+		list_add_tail(&sclp_conbuf->list, &sclp_con_outqueue);
 	sclp_conbuf = NULL;
-	if (buffer == NULL) {
-		spin_unlock_irqrestore(&sclp_con_lock, flags);
-		return;
-	}
-	list_add_tail(&buffer->list, &sclp_con_outqueue);
-	count = sclp_con_buffer_count++;
+	if (sclp_con_queue_running || sclp_con_suspended)
+		goto out_unlock;
+	if (list_empty(&sclp_con_outqueue))
+		goto out_unlock;
+	buffer = list_first_entry(&sclp_con_outqueue, struct sclp_buffer,
+				  list);
+	sclp_con_queue_running = 1;
 	spin_unlock_irqrestore(&sclp_con_lock, flags);
-	if (count)
-		return;
+
 	rc = sclp_emit_buffer(buffer, sclp_conbuf_callback);
 	if (rc)
 		sclp_conbuf_callback(buffer, rc);
+	return;
+out_unlock:
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
+}
+
+/*
+ * Wait until out queue is empty
+ */
+static void sclp_console_sync_queue(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_con_lock, flags);
+	if (timer_pending(&sclp_con_timer))
+		del_timer_sync(&sclp_con_timer);
+	while (sclp_con_queue_running) {
+		spin_unlock_irqrestore(&sclp_con_lock, flags);
+		sclp_sync_wait();
+		spin_lock_irqsave(&sclp_con_lock, flags);
+	}
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
 }
 
 /*
@@ -123,6 +151,8 @@ sclp_console_write(struct console *conso
 		/* make sure we have a console output buffer */
 		if (sclp_conbuf == NULL) {
 			while (list_empty(&sclp_con_pages)) {
+				if (sclp_con_suspended)
+					goto out;
 				spin_unlock_irqrestore(&sclp_con_lock, flags);
 				sclp_sync_wait();
 				spin_lock_irqsave(&sclp_con_lock, flags);
@@ -157,6 +187,7 @@ sclp_console_write(struct console *conso
 		sclp_con_timer.expires = jiffies + HZ/10;
 		add_timer(&sclp_con_timer);
 	}
+out:
 	spin_unlock_irqrestore(&sclp_con_lock, flags);
 }
 
@@ -168,30 +199,43 @@ sclp_console_device(struct console *c, i
 }
 
 /*
- * This routine is called from panic when the kernel
- * is going to give up. We have to make sure that all buffers
- * will be flushed to the SCLP.
+ * Make sure that all buffers will be flushed to the SCLP.
  */
 static void
 sclp_console_flush(void)
 {
+	sclp_conbuf_emit();
+	sclp_console_sync_queue();
+}
+
+/*
+ * Resume console: If there are cached messages, emit them.
+ */
+static void sclp_console_resume(void)
+{
 	unsigned long flags;
 
+	spin_lock_irqsave(&sclp_con_lock, flags);
+	sclp_con_suspended = 0;
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
 	sclp_conbuf_emit();
+}
+
+/*
+ * Suspend console: Set suspend flag and flush console
+ */
+static void sclp_console_suspend(void)
+{
+	unsigned long flags;
+
 	spin_lock_irqsave(&sclp_con_lock, flags);
-	if (timer_pending(&sclp_con_timer))
-		del_timer(&sclp_con_timer);
-	while (sclp_con_buffer_count > 0) {
-		spin_unlock_irqrestore(&sclp_con_lock, flags);
-		sclp_sync_wait();
-		spin_lock_irqsave(&sclp_con_lock, flags);
-	}
+	sclp_con_suspended = 1;
 	spin_unlock_irqrestore(&sclp_con_lock, flags);
+	sclp_console_flush();
 }
 
-static int
-sclp_console_notify(struct notifier_block *self,
-			  unsigned long event, void *data)
+static int sclp_console_notify(struct notifier_block *self,
+			       unsigned long event, void *data)
 {
 	sclp_console_flush();
 	return NOTIFY_OK;
@@ -199,7 +243,7 @@ sclp_console_notify(struct notifier_bloc
 
 static struct notifier_block on_panic_nb = {
 	.notifier_call = sclp_console_notify,
-	.priority = 1,
+	.priority = SCLP_PANIC_PRIO_CLIENT,
 };
 
 static struct notifier_block on_reboot_nb = {
@@ -221,6 +265,22 @@ static struct console sclp_console =
 };
 
 /*
+ * This function is called for SCLP suspend and resume events.
+ */
+void sclp_console_pm_event(enum sclp_pm_event sclp_pm_event)
+{
+	switch (sclp_pm_event) {
+	case SCLP_PM_EVENT_FREEZE:
+		sclp_console_suspend();
+		break;
+	case SCLP_PM_EVENT_RESTORE:
+	case SCLP_PM_EVENT_THAW:
+		sclp_console_resume();
+		break;
+	}
+}
+
+/*
  * called by console_init() in drivers/char/tty_io.c at boot-time.
  */
 static int __init
@@ -243,7 +303,6 @@ sclp_console_init(void)
 	}
 	INIT_LIST_HEAD(&sclp_con_outqueue);
 	spin_lock_init(&sclp_con_lock);
-	sclp_con_buffer_count = 0;
 	sclp_conbuf = NULL;
 	init_timer(&sclp_con_timer);
 
Index: linux-2.6/drivers/s390/char/sclp_rw.h
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp_rw.h
+++ linux-2.6/drivers/s390/char/sclp_rw.h
@@ -1,11 +1,10 @@
 /*
- *  drivers/s390/char/sclp_rw.h
- *    interface to the SCLP-read/write driver
+ * interface to the SCLP-read/write driver
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
- *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ * Copyright IBM Corporation 1999, 2009
+ *
+ * Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #ifndef __SCLP_RW_H__
@@ -93,4 +92,5 @@ void sclp_set_columns(struct sclp_buffer
 void sclp_set_htab(struct sclp_buffer *, unsigned short);
 int sclp_chars_in_buffer(struct sclp_buffer *);
 
+void sclp_console_pm_event(enum sclp_pm_event sclp_pm_event);
 #endif	/* __SCLP_RW_H__ */
Index: linux-2.6/drivers/s390/char/sclp_rw.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp_rw.c
+++ linux-2.6/drivers/s390/char/sclp_rw.c
@@ -1,11 +1,10 @@
 /*
- *  drivers/s390/char/sclp_rw.c
- *     driver: reading from and writing to system console on S/390 via SCLP
+ * driver: reading from and writing to system console on S/390 via SCLP
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
- *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ * Copyright IBM Corp. 1999, 2009
+ *
+ * Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #include <linux/kmod.h>
@@ -26,9 +25,16 @@
  */
 #define MAX_SCCB_ROOM (PAGE_SIZE - sizeof(struct sclp_buffer))
 
+static void sclp_rw_pm_event(struct sclp_register *reg,
+			     enum sclp_pm_event sclp_pm_event)
+{
+	sclp_console_pm_event(sclp_pm_event);
+}
+
 /* Event type structure for write message and write priority message */
 static struct sclp_register sclp_rw_event = {
-	.send_mask = EVTYP_MSG_MASK | EVTYP_PMSGCMD_MASK
+	.send_mask = EVTYP_MSG_MASK | EVTYP_PMSGCMD_MASK,
+	.pm_event_fn = sclp_rw_pm_event,
 };
 
 /*
Index: linux-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ linux-2.6/drivers/s390/char/sclp_vt220.c
@@ -1,10 +1,9 @@
 /*
- *  drivers/s390/char/sclp_vt220.c
- *    SCLP VT220 terminal driver.
+ * SCLP VT220 terminal driver.
  *
- *  S390 version
- *    Copyright IBM Corp. 2003,2008
- *    Author(s): Peter Oberparleiter <Peter.Oberparleiter@de.ibm.com>
+ * Copyright IBM Corp. 2003, 2009
+ *
+ * Author(s): Peter Oberparleiter <Peter.Oberparleiter@de.ibm.com>
  */
 
 #include <linux/module.h>
@@ -69,8 +68,11 @@ static struct list_head sclp_vt220_empty
 /* List of pending requests */
 static struct list_head sclp_vt220_outqueue;
 
-/* Number of requests in outqueue */
-static int sclp_vt220_outqueue_count;
+/* Suspend mode flag */
+static int sclp_vt220_suspended;
+
+/* Flag that output queue is currently running */
+static int sclp_vt220_queue_running;
 
 /* Timer used for delaying write requests to merge subsequent messages into
  * a single buffer */
@@ -92,6 +94,8 @@ static int __initdata sclp_vt220_init_co
 static int sclp_vt220_flush_later;
 
 static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf);
+static void sclp_vt220_pm_event_fn(struct sclp_register *reg,
+				   enum sclp_pm_event sclp_pm_event);
 static int __sclp_vt220_emit(struct sclp_vt220_request *request);
 static void sclp_vt220_emit_current(void);
 
@@ -100,7 +104,8 @@ static struct sclp_register sclp_vt220_r
 	.send_mask		= EVTYP_VT220MSG_MASK,
 	.receive_mask		= EVTYP_VT220MSG_MASK,
 	.state_change_fn	= NULL,
-	.receiver_fn		= sclp_vt220_receiver_fn
+	.receiver_fn		= sclp_vt220_receiver_fn,
+	.pm_event_fn		= sclp_vt220_pm_event_fn,
 };
 
 
@@ -120,15 +125,19 @@ sclp_vt220_process_queue(struct sclp_vt2
 		spin_lock_irqsave(&sclp_vt220_lock, flags);
 		/* Move request from outqueue to empty queue */
 		list_del(&request->list);
-		sclp_vt220_outqueue_count--;
 		list_add_tail((struct list_head *) page, &sclp_vt220_empty);
 		/* Check if there is a pending buffer on the out queue. */
 		request = NULL;
 		if (!list_empty(&sclp_vt220_outqueue))
 			request = list_entry(sclp_vt220_outqueue.next,
 					     struct sclp_vt220_request, list);
+		if (!request || sclp_vt220_suspended) {
+			sclp_vt220_queue_running = 0;
+			spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+			break;
+		}
 		spin_unlock_irqrestore(&sclp_vt220_lock, flags);
-	} while (request && __sclp_vt220_emit(request));
+	} while (__sclp_vt220_emit(request));
 	if (request == NULL && sclp_vt220_flush_later)
 		sclp_vt220_emit_current();
 	/* Check if the tty needs a wake up call */
@@ -212,26 +221,7 @@ __sclp_vt220_emit(struct sclp_vt220_requ
 }
 
 /*
- * Queue and emit given request.
- */
-static void
-sclp_vt220_emit(struct sclp_vt220_request *request)
-{
-	unsigned long flags;
-	int count;
-
-	spin_lock_irqsave(&sclp_vt220_lock, flags);
-	list_add_tail(&request->list, &sclp_vt220_outqueue);
-	count = sclp_vt220_outqueue_count++;
-	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
-	/* Emit only the first buffer immediately - callback takes care of
-	 * the rest */
-	if (count == 0 && __sclp_vt220_emit(request))
-		sclp_vt220_process_queue(request);
-}
-
-/*
- * Queue and emit current request. Return zero on success, non-zero otherwise.
+ * Queue and emit current request.
  */
 static void
 sclp_vt220_emit_current(void)
@@ -241,22 +231,33 @@ sclp_vt220_emit_current(void)
 	struct sclp_vt220_sccb *sccb;
 
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
-	request = NULL;
-	if (sclp_vt220_current_request != NULL) {
+	if (sclp_vt220_current_request) {
 		sccb = (struct sclp_vt220_sccb *) 
 				sclp_vt220_current_request->sclp_req.sccb;
 		/* Only emit buffers with content */
 		if (sccb->header.length != sizeof(struct sclp_vt220_sccb)) {
-			request = sclp_vt220_current_request;
+			list_add_tail(&sclp_vt220_current_request->list,
+				      &sclp_vt220_outqueue);
 			sclp_vt220_current_request = NULL;
 			if (timer_pending(&sclp_vt220_timer))
 				del_timer(&sclp_vt220_timer);
 		}
 		sclp_vt220_flush_later = 0;
 	}
+	if (sclp_vt220_queue_running || sclp_vt220_suspended)
+		goto out_unlock;
+	if (list_empty(&sclp_vt220_outqueue))
+		goto out_unlock;
+	request = list_first_entry(&sclp_vt220_outqueue,
+				   struct sclp_vt220_request, list);
+	sclp_vt220_queue_running = 1;
+	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+
+	if (__sclp_vt220_emit(request))
+		sclp_vt220_process_queue(request);
+	return;
+out_unlock:
 	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
-	if (request != NULL)
-		sclp_vt220_emit(request);
 }
 
 #define SCLP_NORMAL_WRITE	0x00
@@ -396,7 +397,7 @@ __sclp_vt220_write(const unsigned char *
 		if (sclp_vt220_current_request == NULL) {
 			while (list_empty(&sclp_vt220_empty)) {
 				spin_unlock_irqrestore(&sclp_vt220_lock, flags);
-				if (may_fail)
+				if (may_fail || sclp_vt220_suspended)
 					goto out;
 				else
 					sclp_sync_wait();
@@ -531,7 +532,7 @@ sclp_vt220_put_char(struct tty_struct *t
 static void
 sclp_vt220_flush_chars(struct tty_struct *tty)
 {
-	if (sclp_vt220_outqueue_count == 0)
+	if (!sclp_vt220_queue_running)
 		sclp_vt220_emit_current();
 	else
 		sclp_vt220_flush_later = 1;
@@ -635,7 +636,6 @@ static int __init __sclp_vt220_init(int 
 	init_timer(&sclp_vt220_timer);
 	sclp_vt220_current_request = NULL;
 	sclp_vt220_buffered_chars = 0;
-	sclp_vt220_outqueue_count = 0;
 	sclp_vt220_tty = NULL;
 	sclp_vt220_flush_later = 0;
 
@@ -736,7 +736,7 @@ static void __sclp_vt220_flush_buffer(vo
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
 	if (timer_pending(&sclp_vt220_timer))
 		del_timer(&sclp_vt220_timer);
-	while (sclp_vt220_outqueue_count > 0) {
+	while (sclp_vt220_queue_running) {
 		spin_unlock_irqrestore(&sclp_vt220_lock, flags);
 		sclp_sync_wait();
 		spin_lock_irqsave(&sclp_vt220_lock, flags);
@@ -744,6 +744,46 @@ static void __sclp_vt220_flush_buffer(vo
 	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
 }
 
+/*
+ * Resume console: If there are cached messages, emit them.
+ */
+static void sclp_vt220_resume(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_vt220_lock, flags);
+	sclp_vt220_suspended = 0;
+	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+	sclp_vt220_emit_current();
+}
+
+/*
+ * Suspend console: Set suspend flag and flush console
+ */
+static void sclp_vt220_suspend(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_vt220_lock, flags);
+	sclp_vt220_suspended = 1;
+	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+	__sclp_vt220_flush_buffer();
+}
+
+static void sclp_vt220_pm_event_fn(struct sclp_register *reg,
+				   enum sclp_pm_event sclp_pm_event)
+{
+	switch (sclp_pm_event) {
+	case SCLP_PM_EVENT_FREEZE:
+		sclp_vt220_suspend();
+		break;
+	case SCLP_PM_EVENT_RESTORE:
+	case SCLP_PM_EVENT_THAW:
+		sclp_vt220_resume();
+		break;
+	}
+}
+
 static int
 sclp_vt220_notify(struct notifier_block *self,
 			  unsigned long event, void *data)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
