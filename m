Return-Path: <linux-kernel-owner+w=401wt.eu-S1759260AbZFDQYh@vger.kernel.org>
Message-Id: <20090604161907.038373940@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 31/38] pm: hvc_iucv power management callbacks
Content-Disposition: inline; filename=pm_hvc_iucv.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

The patch adds supporting for suspending and resuming IUCV HVC terminal
devices from disk. The obligatory Linux device driver interfaces has
been added by registering a device driver on the IUCV bus.
For each IUCV HVC terminal device the driver creates a respective device
on the IUCV bus.

To support suspend and resume, the PM freeze callback severs any established
IUCV communication path and triggers a HVC tty hang-up when the system image
is restored.
IUCV communication path are no longer valid when the z/VM guest is halted.

The device driver initialization has been updated to register devices and
the a new routine has been extracted to facilitate the hang-up of IUCV HVC
terminal devices.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/char/hvc_iucv.c |  204 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 161 insertions(+), 43 deletions(-)

Index: linux-2.6/drivers/char/hvc_iucv.c
===================================================================
--- linux-2.6.orig/drivers/char/hvc_iucv.c
+++ linux-2.6/drivers/char/hvc_iucv.c
@@ -4,7 +4,7 @@
  * This HVC device driver provides terminal access using
  * z/VM IUCV communication paths.
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2009
  *
  * Author(s):	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
  */
@@ -15,6 +15,7 @@
 #include <asm/ebcdic.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/mempool.h>
 #include <linux/moduleparam.h>
@@ -74,6 +75,7 @@ struct hvc_iucv_private {
 	wait_queue_head_t	sndbuf_waitq;	/* wait for send completion */
 	struct list_head	tty_outqueue;	/* outgoing IUCV messages */
 	struct list_head	tty_inqueue;	/* incoming IUCV messages */
+	struct device		*dev;		/* device structure */
 };
 
 struct iucv_tty_buffer {
@@ -542,7 +544,68 @@ static void flush_sndbuf_sync(struct hvc
 
 	if (sync_wait)
 		wait_event_timeout(priv->sndbuf_waitq,
-				   tty_outqueue_empty(priv), HZ);
+				   tty_outqueue_empty(priv), HZ/10);
+}
+
+/**
+ * hvc_iucv_hangup() - Sever IUCV path and schedule hvc tty hang up
+ * @priv:	Pointer to hvc_iucv_private structure
+ *
+ * This routine severs an existing IUCV communication path and hangs
+ * up the underlying HVC terminal device.
+ * The hang-up occurs only if an IUCV communication path is established;
+ * otherwise there is no need to hang up the terminal device.
+ *
+ * The IUCV HVC hang-up is separated into two steps:
+ * 1. After the IUCV path has been severed, the iucv_state is set to
+ *    IUCV_SEVERED.
+ * 2. Later, when the HVC thread calls hvc_iucv_get_chars(), the
+ *    IUCV_SEVERED state causes the tty hang-up in the HVC layer.
+ *
+ * If the tty has not yet been opened, clean up the hvc_iucv_private
+ * structure to allow re-connects.
+ * If the tty has been opened, let get_chars() return -EPIPE to signal
+ * the HVC layer to hang up the tty and, if so, wake up the HVC thread
+ * to call get_chars()...
+ *
+ * Special notes on hanging up a HVC terminal instantiated as console:
+ * Hang-up:	1. do_tty_hangup() replaces file ops (= hung_up_tty_fops)
+ *		2. do_tty_hangup() calls tty->ops->close() for console_filp
+ *			=> no hangup notifier is called by HVC (default)
+ *		2. hvc_close() returns because of tty_hung_up_p(filp)
+ *			=> no delete notifier is called!
+ * Finally, the back-end is not being notified, thus, the tty session is
+ * kept active (TTY_OPEN) to be ready for re-connects.
+ *
+ * Locking:	spin_lock(&priv->lock) w/o disabling bh
+ */
+static void hvc_iucv_hangup(struct hvc_iucv_private *priv)
+{
+	struct iucv_path *path;
+
+	path = NULL;
+	spin_lock(&priv->lock);
+	if (priv->iucv_state == IUCV_CONNECTED) {
+		path = priv->path;
+		priv->path = NULL;
+		priv->iucv_state = IUCV_SEVERED;
+		if (priv->tty_state == TTY_CLOSED)
+			hvc_iucv_cleanup(priv);
+		else
+			/* console is special (see above) */
+			if (priv->is_console) {
+				hvc_iucv_cleanup(priv);
+				priv->tty_state = TTY_OPENED;
+			} else
+				hvc_kick();
+	}
+	spin_unlock(&priv->lock);
+
+	/* finally sever path (outside of priv->lock due to lock ordering) */
+	if (path) {
+		iucv_path_sever(path, NULL);
+		iucv_path_free(path);
+	}
 }
 
 /**
@@ -735,11 +798,8 @@ out_path_handled:
  * @ipuser:	User specified data for this path
  *		(AF_IUCV: port/service name and originator port)
  *
- * The function also severs the path (as required by the IUCV protocol) and
- * sets the iucv state to IUCV_SEVERED for the associated struct
- * hvc_iucv_private instance. Later, the IUCV_SEVERED state triggers a tty
- * hangup (hvc_iucv_get_chars() / hvc_iucv_write()).
- * If tty portion of the HVC is closed, clean up the outqueue.
+ * This function calls the hvc_iucv_hangup() function for the
+ * respective IUCV HVC terminal.
  *
  * Locking:	struct hvc_iucv_private->lock
  */
@@ -747,33 +807,7 @@ static void hvc_iucv_path_severed(struct
 {
 	struct hvc_iucv_private *priv = path->private;
 
-	spin_lock(&priv->lock);
-	priv->iucv_state = IUCV_SEVERED;
-
-	/* If the tty has not yet been opened, clean up the hvc_iucv_private
-	 * structure to allow re-connects.
-	 * This is also done for our console device because console hangups
-	 * are handled specially and no notifier is called by HVC.
-	 * The tty session is active (TTY_OPEN) and ready for re-connects...
-	 *
-	 * If it has been opened, let get_chars() return -EPIPE to signal the
-	 * HVC layer to hang up the tty.
-	 * If so, we need to wake up the HVC thread to call get_chars()...
-	 */
-	priv->path = NULL;
-	if (priv->tty_state == TTY_CLOSED)
-		hvc_iucv_cleanup(priv);
-	else
-		if (priv->is_console) {
-			hvc_iucv_cleanup(priv);
-			priv->tty_state = TTY_OPENED;
-		} else
-			hvc_kick();
-	spin_unlock(&priv->lock);
-
-	/* finally sever path (outside of priv->lock due to lock ordering) */
-	iucv_path_sever(path, ipuser);
-	iucv_path_free(path);
+	hvc_iucv_hangup(priv);
 }
 
 /**
@@ -853,6 +887,37 @@ static void hvc_iucv_msg_complete(struct
 	destroy_tty_buffer_list(&list_remove);
 }
 
+/**
+ * hvc_iucv_pm_freeze() - Freeze PM callback
+ * @dev:	IUVC HVC terminal device
+ *
+ * Sever an established IUCV communication path and
+ * trigger a hang-up of the underlying HVC terminal.
+ */
+static int hvc_iucv_pm_freeze(struct device *dev)
+{
+	struct hvc_iucv_private *priv = dev_get_drvdata(dev);
+
+	local_bh_disable();
+	hvc_iucv_hangup(priv);
+	local_bh_enable();
+
+	return 0;
+}
+
+/**
+ * hvc_iucv_pm_restore_thaw() - Thaw and restore PM callback
+ * @dev:	IUVC HVC terminal device
+ *
+ * Wake up the HVC thread to trigger hang-up and respective
+ * HVC back-end notifier invocations.
+ */
+static int hvc_iucv_pm_restore_thaw(struct device *dev)
+{
+	hvc_kick();
+	return 0;
+}
+
 
 /* HVC operations */
 static struct hv_ops hvc_iucv_ops = {
@@ -863,6 +928,20 @@ static struct hv_ops hvc_iucv_ops = {
 	.notifier_hangup = hvc_iucv_notifier_hangup,
 };
 
+/* Suspend / resume device operations */
+static struct dev_pm_ops hvc_iucv_pm_ops = {
+	.freeze	  = hvc_iucv_pm_freeze,
+	.thaw	  = hvc_iucv_pm_restore_thaw,
+	.restore  = hvc_iucv_pm_restore_thaw,
+};
+
+/* IUCV HVC device driver */
+static struct device_driver hvc_iucv_driver = {
+	.name = KMSG_COMPONENT,
+	.bus  = &iucv_bus,
+	.pm   = &hvc_iucv_pm_ops,
+};
+
 /**
  * hvc_iucv_alloc() - Allocates a new struct hvc_iucv_private instance
  * @id:			hvc_iucv_table index
@@ -897,14 +976,12 @@ static int __init hvc_iucv_alloc(int id,
 	/* set console flag */
 	priv->is_console = is_console;
 
-	/* finally allocate hvc */
+	/* allocate hvc device */
 	priv->hvc = hvc_alloc(HVC_IUCV_MAGIC + id, /*		  PAGE_SIZE */
 			      HVC_IUCV_MAGIC + id, &hvc_iucv_ops, 256);
 	if (IS_ERR(priv->hvc)) {
 		rc = PTR_ERR(priv->hvc);
-		free_page((unsigned long) priv->sndbuf);
-		kfree(priv);
-		return rc;
+		goto out_error_hvc;
 	}
 
 	/* notify HVC thread instead of using polling */
@@ -915,8 +992,45 @@ static int __init hvc_iucv_alloc(int id,
 	memcpy(priv->srv_name, name, 8);
 	ASCEBC(priv->srv_name, 8);
 
+	/* create and setup device */
+	priv->dev = kzalloc(sizeof(*priv->dev), GFP_KERNEL);
+	if (!priv->dev) {
+		rc = -ENOMEM;
+		goto out_error_dev;
+	}
+	dev_set_name(priv->dev, "hvc_iucv%d", id);
+	dev_set_drvdata(priv->dev, priv);
+	priv->dev->bus = &iucv_bus;
+	priv->dev->parent = iucv_root;
+	priv->dev->driver = &hvc_iucv_driver;
+	priv->dev->release = (void (*)(struct device *)) kfree;
+	rc = device_register(priv->dev);
+	if (rc) {
+		kfree(priv->dev);
+		goto out_error_dev;
+	}
+
 	hvc_iucv_table[id] = priv;
 	return 0;
+
+out_error_dev:
+	hvc_remove(priv->hvc);
+out_error_hvc:
+	free_page((unsigned long) priv->sndbuf);
+	kfree(priv);
+
+	return rc;
+}
+
+/**
+ * hvc_iucv_destroy() - Destroy and free hvc_iucv_private instances
+ */
+static void __init hvc_iucv_destroy(struct hvc_iucv_private *priv)
+{
+	hvc_remove(priv->hvc);
+	device_unregister(priv->dev);
+	free_page((unsigned long) priv->sndbuf);
+	kfree(priv);
 }
 
 /**
@@ -1109,6 +1223,11 @@ static int __init hvc_iucv_init(void)
 		goto out_error;
 	}
 
+	/* register IUCV HVC device driver */
+	rc = driver_register(&hvc_iucv_driver);
+	if (rc)
+		goto out_error;
+
 	/* parse hvc_iucv_allow string and create z/VM user ID filter list */
 	if (hvc_iucv_filter_string) {
 		rc = hvc_iucv_setup_filter(hvc_iucv_filter_string);
@@ -1183,15 +1302,14 @@ out_error_iucv:
 	iucv_unregister(&hvc_iucv_handler, 0);
 out_error_hvc:
 	for (i = 0; i < hvc_iucv_devices; i++)
-		if (hvc_iucv_table[i]) {
-			if (hvc_iucv_table[i]->hvc)
-				hvc_remove(hvc_iucv_table[i]->hvc);
-			kfree(hvc_iucv_table[i]);
-		}
+		if (hvc_iucv_table[i])
+			hvc_iucv_destroy(hvc_iucv_table[i]);
 out_error_memory:
 	mempool_destroy(hvc_iucv_mempool);
 	kmem_cache_destroy(hvc_iucv_buffer_cache);
 out_error:
+	if (hvc_iucv_filter)
+		kfree(hvc_iucv_filter);
 	hvc_iucv_devices = 0; /* ensure that we do not provide any device */
 	return rc;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
