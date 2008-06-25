Return-Path: <linux-kernel-owner+w=401wt.eu-S1756622AbYFYOh7@vger.kernel.org>
Message-Id: <20080625143614.993434927@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/21] Cleanup monreader printk messages.
Content-Disposition: inline; filename=813-printk-monreader.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monreader.c |   74 +++---------------------------------------
 1 file changed, 7 insertions(+), 67 deletions(-)

Index: quilt-2.6/drivers/s390/char/monreader.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/monreader.c
+++ quilt-2.6/drivers/s390/char/monreader.c
@@ -3,9 +3,8 @@
  *
  * Character device driver for reading z/VM *MONITOR service records.
  *
- * Copyright 2004 IBM Corporation, IBM Deutschland Entwicklung GmbH.
- *
- * Author: Gerald Schaefer <geraldsc@de.ibm.com>
+ *   Copyright IBM Corp. 2004, 2008
+ *   Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
 #include <linux/module.h>
@@ -18,12 +17,11 @@
 #include <linux/ctype.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/poll.h>
+#include <net/iucv/iucv.h>
 #include <asm/uaccess.h>
 #include <asm/ebcdic.h>
 #include <asm/extmem.h>
-#include <linux/poll.h>
-#include <net/iucv/iucv.h>
-
 
 //#define MON_DEBUG			/* Debug messages on/off */
 
@@ -152,10 +150,7 @@ static int mon_check_mca(struct mon_msg 
 	    (mon_mca_end(monmsg) > mon_dcss_end) ||
 	    (mon_mca_start(monmsg) < mon_dcss_start) ||
 	    ((mon_mca_type(monmsg, 1) == 0) && (mon_mca_type(monmsg, 2) == 0)))
-	{
-		P_DEBUG("READ, IGNORED INVALID MCA\n\n");
 		return -EINVAL;
-	}
 	return 0;
 }
 
@@ -164,10 +159,6 @@ static int mon_send_reply(struct mon_msg
 {
 	int rc;
 
-	P_DEBUG("read, REPLY: pathid = 0x%04X, msgid = 0x%08X, trgcls = "
-		"0x%08X\n\n",
-		monpriv->path->pathid, monmsg->msg.id, monmsg->msg.class);
-
 	rc = iucv_message_reply(monpriv->path, &monmsg->msg,
 				IUCV_IPRMDATA, NULL, 0);
 	atomic_dec(&monpriv->msglim_count);
@@ -202,15 +193,12 @@ static struct mon_private *mon_alloc_mem
 	struct mon_private *monpriv;
 
 	monpriv = kzalloc(sizeof(struct mon_private), GFP_KERNEL);
-	if (!monpriv) {
-		P_ERROR("no memory for monpriv\n");
+	if (!monpriv)
 		return NULL;
-	}
 	for (i = 0; i < MON_MSGLIM; i++) {
 		monpriv->msg_array[i] = kzalloc(sizeof(struct mon_msg),
 						    GFP_KERNEL);
 		if (!monpriv->msg_array[i]) {
-			P_ERROR("open, no memory for msg_array\n");
 			mon_free_mem(monpriv);
 			return NULL;
 		}
@@ -218,41 +206,10 @@ static struct mon_private *mon_alloc_mem
 	return monpriv;
 }
 
-static inline void mon_read_debug(struct mon_msg *monmsg,
-				  struct mon_private *monpriv)
-{
-#ifdef MON_DEBUG
-	u8 msg_type[2], mca_type;
-	unsigned long records_len;
-
-	records_len = mon_rec_end(monmsg) - mon_rec_start(monmsg) + 1;
-
-	memcpy(msg_type, &monmsg->msg.class, 2);
-	EBCASC(msg_type, 2);
-	mca_type = mon_mca_type(monmsg, 0);
-	EBCASC(&mca_type, 1);
-
-	P_DEBUG("read, mon_read_index = %i, mon_write_index = %i\n",
-		monpriv->read_index, monpriv->write_index);
-	P_DEBUG("read, pathid = 0x%04X, msgid = 0x%08X, trgcls = 0x%08X\n",
-		monpriv->path->pathid, monmsg->msg.id, monmsg->msg.class);
-	P_DEBUG("read, msg_type = '%c%c', mca_type = '%c' / 0x%X / 0x%X\n",
-		msg_type[0], msg_type[1], mca_type ? mca_type : 'X',
-		mon_mca_type(monmsg, 1), mon_mca_type(monmsg, 2));
-	P_DEBUG("read, MCA: start = 0x%lX, end = 0x%lX\n",
-		mon_mca_start(monmsg), mon_mca_end(monmsg));
-	P_DEBUG("read, REC: start = 0x%X, end = 0x%X, len = %lu\n\n",
-		mon_rec_start(monmsg), mon_rec_end(monmsg), records_len);
-	if (mon_mca_size(monmsg) > 12)
-		P_DEBUG("READ, MORE THAN ONE MCA\n\n");
-#endif
-}
-
 static inline void mon_next_mca(struct mon_msg *monmsg)
 {
 	if (likely((mon_mca_size(monmsg) - monmsg->mca_offset) == 12))
 		return;
-	P_DEBUG("READ, NEXT MCA\n\n");
 	monmsg->mca_offset += 12;
 	monmsg->pos = 0;
 }
@@ -269,7 +226,6 @@ static struct mon_msg *mon_next_message(
 		monmsg->msglim_reached = 0;
 		monmsg->pos = 0;
 		monmsg->mca_offset = 0;
-		P_WARNING("read, message limit reached\n");
 		monpriv->read_index = (monpriv->read_index + 1) %
 				      MON_MSGLIM;
 		atomic_dec(&monpriv->read_ready);
@@ -286,10 +242,6 @@ static void mon_iucv_path_complete(struc
 {
 	struct mon_private *monpriv = path->private;
 
-	P_DEBUG("IUCV connection completed\n");
-	P_DEBUG("IUCV ACCEPT (from *MONITOR): Version = 0x%02X, Event = "
-		"0x%02X, Sample = 0x%02X\n",
-		ipuser[0], ipuser[1], ipuser[2]);
 	atomic_set(&monpriv->iucv_connected, 1);
 	wake_up(&mon_conn_wait_queue);
 }
@@ -310,7 +262,6 @@ static void mon_iucv_message_pending(str
 {
 	struct mon_private *monpriv = path->private;
 
-	P_DEBUG("IUCV message pending\n");
 	memcpy(&monpriv->msg_array[monpriv->write_index]->msg,
 	       msg, sizeof(*msg));
 	if (atomic_inc_return(&monpriv->msglim_count) == MON_MSGLIM) {
@@ -375,7 +326,6 @@ static int mon_open(struct inode *inode,
 		rc = -EIO;
 		goto out_path;
 	}
-	P_INFO("open, established connection to *MONITOR service\n\n");
 	filp->private_data = monpriv;
 	return nonseekable_open(inode, filp);
 
@@ -400,8 +350,6 @@ static int mon_close(struct inode *inode
 	rc = iucv_path_sever(monpriv->path, user_data_sever);
 	if (rc)
 		P_ERROR("close, iucv_sever failed with rc = %i\n", rc);
-	else
-		P_INFO("close, terminated connection to *MONITOR service\n");
 
 	atomic_set(&monpriv->iucv_severed, 0);
 	atomic_set(&monpriv->iucv_connected, 0);
@@ -442,10 +390,8 @@ static ssize_t mon_read(struct file *fil
 		monmsg = monpriv->msg_array[monpriv->read_index];
 	}
 
-	if (!monmsg->pos) {
+	if (!monmsg->pos)
 		monmsg->pos = mon_mca_start(monmsg) + monmsg->mca_offset;
-		mon_read_debug(monmsg, monpriv);
-	}
 	if (mon_check_mca(monmsg))
 		goto reply;
 
@@ -531,7 +477,6 @@ static int __init mon_init(void)
 		P_ERROR("failed to register with iucv driver\n");
 		return rc;
 	}
-	P_INFO("open, registered with IUCV\n");
 
 	rc = segment_type(mon_dcss_name);
 	if (rc < 0) {
@@ -555,13 +500,8 @@ static int __init mon_init(void)
 	dcss_mkname(mon_dcss_name, &user_data_connect[8]);
 
 	rc = misc_register(&mon_dev);
-	if (rc < 0 ) {
-		P_ERROR("misc_register failed, rc = %i\n", rc);
+	if (rc < 0 )
 		goto out;
-	}
-	P_INFO("Loaded segment %s from %p to %p, size = %lu Byte\n",
-		mon_dcss_name, (void *) mon_dcss_start, (void *) mon_dcss_end,
-		mon_dcss_end - mon_dcss_start + 1);
 	return 0;
 
 out:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
