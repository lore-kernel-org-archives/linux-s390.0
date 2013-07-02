Return-Path: <brueckner@linux.vnet.ibm.com>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 2/2] tty/hvc_iucv: Disconnect IUCV connection when lowering DTR
Date: Tue,  2 Jul 2013 17:07:15 +0200
Message-Id: <1372777635-10423-3-git-send-email-brueckner@linux.vnet.ibm.com>
In-Reply-To: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: benh@kernel.crashing.org, jslaby@suse.cz, gregkh@linuxfoundation.org
Cc: linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, brueckner@linux.vnet.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Implement the dtr_rts() hvc console callback to improve control when to
disconnect the IUCV connection.  Previously, the IUCV connection was
disconnected during the notifier_del() callback, i.e., when the last file
descriptor to the hvc terminal device was closed.

Recent changes in login programs caused undesired disconnects during the
login phase.  To prevent these kind of disconnects, implement the dtr_rts
callback to implicitly handle the HUPCL termios control via the hvc_console
driver.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvc_iucv.c |   64 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index b6f7d52..bb08676 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -656,21 +656,64 @@ static void hvc_iucv_notifier_hangup(struct hvc_struct *hp, int id)
 }
 
 /**
+ * hvc_iucv_dtr_rts() - HVC notifier for handling DTR/RTS
+ * @hp:		Pointer the HVC device (struct hvc_struct)
+ * @raise:	Non-zero to raise or zero to lower DTR/RTS lines
+ *
+ * This routine notifies the HVC back-end to raise or lower DTR/RTS
+ * lines.  Raising DTR/RTS is ignored.  Lowering DTR/RTS indicates to
+ * drop the IUCV connection (similar to hang up the modem).
+ */
+static void hvc_iucv_dtr_rts(struct hvc_struct *hp, int raise)
+{
+	struct hvc_iucv_private *priv;
+	struct iucv_path        *path;
+
+	/* Raising the DTR/RTS is ignored as IUCV connections can be
+	 * established at any times.
+	 */
+	if (raise)
+		return;
+
+	priv = hvc_iucv_get_private(hp->vtermno);
+	if (!priv)
+		return;
+
+	/* Lowering the DTR/RTS lines disconnects an established IUCV
+	 * connection.
+	 */
+	flush_sndbuf_sync(priv);
+
+	spin_lock_bh(&priv->lock);
+	path = priv->path;		/* save reference to IUCV path */
+	priv->path = NULL;
+	priv->iucv_state = IUCV_DISCONN;
+	spin_unlock_bh(&priv->lock);
+
+	/* Sever IUCV path outside of priv->lock due to lock ordering of:
+	 * priv->lock <--> iucv_table_lock */
+	if (path) {
+		iucv_path_sever(path, NULL);
+		iucv_path_free(path);
+	}
+}
+
+/**
  * hvc_iucv_notifier_del() - HVC notifier for closing a TTY for the last time.
  * @hp:		Pointer to the HVC device (struct hvc_struct)
  * @id:		Additional data (originally passed to hvc_alloc):
  *		the index of an struct hvc_iucv_private instance.
  *
  * This routine notifies the HVC back-end that the last tty device fd has been
- * closed.  The function calls hvc_iucv_cleanup() to clean up the struct
- * hvc_iucv_private instance.
+ * closed.  The function cleans up tty resources.  The clean-up of the IUCV
+ * connection is done in hvc_iucv_dtr_rts() and depends on the HUPCL termios
+ * control setting.
  *
  * Locking:	struct hvc_iucv_private->lock
  */
 static void hvc_iucv_notifier_del(struct hvc_struct *hp, int id)
 {
 	struct hvc_iucv_private *priv;
-	struct iucv_path	*path;
 
 	priv = hvc_iucv_get_private(id);
 	if (!priv)
@@ -679,17 +722,11 @@ static void hvc_iucv_notifier_del(struct hvc_struct *hp, int id)
 	flush_sndbuf_sync(priv);
 
 	spin_lock_bh(&priv->lock);
-	path = priv->path;		/* save reference to IUCV path */
-	priv->path = NULL;
-	hvc_iucv_cleanup(priv);
+	destroy_tty_buffer_list(&priv->tty_outqueue);
+	destroy_tty_buffer_list(&priv->tty_inqueue);
+	priv->tty_state = TTY_CLOSED;
+	priv->sndbuf_len = 0;
 	spin_unlock_bh(&priv->lock);
-
-	/* sever IUCV path outside of priv->lock due to lock ordering of:
-	 * priv->lock <--> iucv_table_lock */
-	if (path) {
-		iucv_path_sever(path, NULL);
-		iucv_path_free(path);
-	}
 }
 
 /**
@@ -931,6 +968,7 @@ static const struct hv_ops hvc_iucv_ops = {
 	.notifier_add = hvc_iucv_notifier_add,
 	.notifier_del = hvc_iucv_notifier_del,
 	.notifier_hangup = hvc_iucv_notifier_hangup,
+	.dtr_rts = hvc_iucv_dtr_rts,
 };
 
 /* Suspend / resume device operations */
-- 
1.7.5.4
