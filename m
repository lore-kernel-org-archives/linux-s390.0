Return-Path: <linux-kernel-owner+w=401wt.eu-S1754692AbYK0Kqm@vger.kernel.org>
Message-Id: <20081127103140.668360916@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 46/60] convert monreader printks to pr_xxx macros.
Content-Disposition: inline; filename=161-kmsg-monreader.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monreader.c |   41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

Index: quilt-2.6/drivers/s390/char/monreader.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/monreader.c
+++ quilt-2.6/drivers/s390/char/monreader.c
@@ -7,6 +7,9 @@
  *   Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "monreader"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -24,19 +27,6 @@
 #include <asm/ebcdic.h>
 #include <asm/extmem.h>
 
-//#define MON_DEBUG			/* Debug messages on/off */
-
-#define MON_NAME "monreader"
-
-#define P_INFO(x...)	printk(KERN_INFO MON_NAME " info: " x)
-#define P_ERROR(x...)	printk(KERN_ERR MON_NAME " error: " x)
-#define P_WARNING(x...)	printk(KERN_WARNING MON_NAME " warning: " x)
-
-#ifdef MON_DEBUG
-#define P_DEBUG(x...)   printk(KERN_DEBUG MON_NAME " debug: " x)
-#else
-#define P_DEBUG(x...)   do {} while (0)
-#endif
 
 #define MON_COLLECT_SAMPLE 0x80
 #define MON_COLLECT_EVENT  0x40
@@ -172,7 +162,7 @@ static int mon_send_reply(struct mon_msg
 	} else
 		monmsg->replied_msglim = 1;
 	if (rc) {
-		P_ERROR("read, IUCV reply failed with rc = %i\n\n", rc);
+		pr_err("Reading monitor data failed with rc=%i\n", rc);
 		return -EIO;
 	}
 	return 0;
@@ -251,7 +241,8 @@ static void mon_iucv_path_severed(struct
 {
 	struct mon_private *monpriv = path->private;
 
-	P_ERROR("IUCV connection severed with rc = 0x%X\n", ipuser[0]);
+	pr_err("z/VM *MONITOR system service disconnected with rc=%i\n",
+	       ipuser[0]);
 	iucv_path_sever(path, NULL);
 	atomic_set(&monpriv->iucv_severed, 1);
 	wake_up(&mon_conn_wait_queue);
@@ -266,8 +257,7 @@ static void mon_iucv_message_pending(str
 	memcpy(&monpriv->msg_array[monpriv->write_index]->msg,
 	       msg, sizeof(*msg));
 	if (atomic_inc_return(&monpriv->msglim_count) == MON_MSGLIM) {
-		P_WARNING("IUCV message pending, message limit (%i) reached\n",
-			  MON_MSGLIM);
+		pr_warning("The read queue for monitor data is full\n");
 		monpriv->msg_array[monpriv->write_index]->msglim_reached = 1;
 	}
 	monpriv->write_index = (monpriv->write_index + 1) % MON_MSGLIM;
@@ -311,8 +301,8 @@ static int mon_open(struct inode *inode,
 	rc = iucv_path_connect(monpriv->path, &monreader_iucv_handler,
 			       MON_SERVICE, NULL, user_data_connect, monpriv);
 	if (rc) {
-		P_ERROR("iucv connection to *MONITOR failed with "
-			"IPUSER SEVER code = %i\n", rc);
+		pr_err("Connecting to the z/VM *MONITOR system service "
+		       "failed with rc=%i\n", rc);
 		rc = -EIO;
 		goto out_path;
 	}
@@ -353,7 +343,8 @@ static int mon_close(struct inode *inode
 	 */
 	rc = iucv_path_sever(monpriv->path, user_data_sever);
 	if (rc)
-		P_ERROR("close, iucv_sever failed with rc = %i\n", rc);
+		pr_warning("Disconnecting the z/VM *MONITOR system service "
+			   "failed with rc=%i\n", rc);
 
 	atomic_set(&monpriv->iucv_severed, 0);
 	atomic_set(&monpriv->iucv_connected, 0);
@@ -469,7 +460,8 @@ static int __init mon_init(void)
 	int rc;
 
 	if (!MACHINE_IS_VM) {
-		P_ERROR("not running under z/VM, driver not loaded\n");
+		pr_err("The z/VM *MONITOR record device driver cannot be "
+		       "loaded without z/VM\n");
 		return -ENODEV;
 	}
 
@@ -478,7 +470,8 @@ static int __init mon_init(void)
 	 */
 	rc = iucv_register(&monreader_iucv_handler, 1);
 	if (rc) {
-		P_ERROR("failed to register with iucv driver\n");
+		pr_err("The z/VM *MONITOR record device driver failed to "
+		       "register with IUCV\n");
 		return rc;
 	}
 
@@ -488,8 +481,8 @@ static int __init mon_init(void)
 		goto out_iucv;
 	}
 	if (rc != SEG_TYPE_SC) {
-		P_ERROR("segment %s has unsupported type, should be SC\n",
-			mon_dcss_name);
+		pr_err("The specified *MONITOR DCSS %s does not have the "
+		       "required type SC\n", mon_dcss_name);
 		rc = -EINVAL;
 		goto out_iucv;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
