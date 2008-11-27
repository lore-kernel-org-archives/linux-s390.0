Return-Path: <linux-kernel-owner+w=401wt.eu-S1757369AbYK0Ksh@vger.kernel.org>
Message-Id: <20081127103144.056735666@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:18 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 58/60] convert ctcm printks to dev_xxx and pr_xxx macros.
Content-Disposition: inline; filename=173-kmsg-ctcm.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Tiedemann <ptiedem@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Tiedemann <ptiedem@de.ibm.com>

Signed-off-by: Peter Tiedemann <ptiedem@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/ctcm_fsms.c  |   46 ++++++++++++++++----------
 drivers/s390/net/ctcm_main.c  |   72 ++++++++++++++++++++++++++----------------
 drivers/s390/net/ctcm_main.h  |    6 ---
 drivers/s390/net/ctcm_mpc.c   |   15 +++++---
 drivers/s390/net/ctcm_sysfs.c |    3 +
 5 files changed, 86 insertions(+), 56 deletions(-)

Index: quilt-2.6/drivers/s390/net/ctcm_fsms.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_fsms.c
+++ quilt-2.6/drivers/s390/net/ctcm_fsms.c
@@ -13,6 +13,9 @@
 #undef DEBUGDATA
 #undef DEBUGCCW
 
+#define KMSG_COMPONENT "ctcm"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -190,21 +193,22 @@ static void ctcmpc_chx_send_sweep(fsm_in
 void ctcm_ccw_check_rc(struct channel *ch, int rc, char *msg)
 {
 	CTCM_DBF_TEXT_(ERROR, CTC_DBF_ERROR,
-			"%s(%s): %s: %04x\n",
-				CTCM_FUNTAIL, ch->id, msg, rc);
+		"%s(%s): %s: %04x\n",
+		CTCM_FUNTAIL, ch->id, msg, rc);
 	switch (rc) {
 	case -EBUSY:
-		ctcm_pr_warn("%s (%s): Busy !\n", ch->id, msg);
+		pr_info("%s: The communication peer is busy\n",
+			ch->id);
 		fsm_event(ch->fsm, CTC_EVENT_IO_EBUSY, ch);
 		break;
 	case -ENODEV:
-		ctcm_pr_emerg("%s (%s): Invalid device called for IO\n",
-			     ch->id, msg);
+		pr_err("%s: The specified target device is not valid\n",
+		       ch->id);
 		fsm_event(ch->fsm, CTC_EVENT_IO_ENODEV, ch);
 		break;
 	default:
-		ctcm_pr_emerg("%s (%s): Unknown error in do_IO %04x\n",
-			     ch->id, msg, rc);
+		pr_err("An I/O operation resulted in error %04x\n",
+		       rc);
 		fsm_event(ch->fsm, CTC_EVENT_IO_UNKNOWN, ch);
 	}
 }
@@ -886,8 +890,15 @@ static void ctcm_chx_rxiniterr(fsm_insta
 			fsm_newstate(fi, CTC_STATE_RXERR);
 			fsm_event(priv->fsm, DEV_EVENT_RXDOWN, dev);
 		}
-	} else
-		ctcm_pr_warn("%s: Error during RX init handshake\n", dev->name);
+	} else {
+		CTCM_DBF_TEXT_(ERROR, CTC_DBF_ERROR,
+			"%s(%s): %s in %s", CTCM_FUNTAIL, ch->id,
+			ctc_ch_event_names[event], fsm_getstate_str(fi));
+
+		dev_warn(&dev->dev,
+			"Initialization failed with RX/TX init handshake "
+			"error %s\n", ctc_ch_event_names[event]);
+	}
 }
 
 /**
@@ -969,7 +980,9 @@ static void ctcm_chx_txiniterr(fsm_insta
 			"%s(%s): %s in %s", CTCM_FUNTAIL, ch->id,
 			ctc_ch_event_names[event], fsm_getstate_str(fi));
 
-		ctcm_pr_warn("%s: Error during TX init handshake\n", dev->name);
+		dev_warn(&dev->dev,
+			"Initialization failed with RX/TX init handshake "
+			"error %s\n", ctc_ch_event_names[event]);
 	}
 }
 
@@ -2101,14 +2114,11 @@ static void dev_action_restart(fsm_insta
 	CTCMY_DBF_DEV_NAME(TRACE, dev, "");
 
 	if (IS_MPC(priv)) {
-		ctcm_pr_info("ctcm: %s Restarting Device and "
-		       "MPC Group in 5 seconds\n",
-		       dev->name);
 		restart_timer = CTCM_TIME_1_SEC;
 	} else {
-		ctcm_pr_info("%s: Restarting\n", dev->name);
 		restart_timer = CTCM_TIME_5_SEC;
 	}
+	dev_info(&dev->dev, "Restarting device\n");
 
 	dev_action_stop(fi, event, arg);
 	fsm_event(priv->fsm, DEV_EVENT_STOP, dev);
@@ -2150,16 +2160,16 @@ static void dev_action_chup(fsm_instance
 	case DEV_STATE_STARTWAIT_RX:
 		if (event == DEV_EVENT_RXUP) {
 			fsm_newstate(fi, DEV_STATE_RUNNING);
-			ctcm_pr_info("%s: connected with remote side\n",
-				    dev->name);
+			dev_info(&dev->dev,
+				"Connected with remote side\n");
 			ctcm_clear_busy(dev);
 		}
 		break;
 	case DEV_STATE_STARTWAIT_TX:
 		if (event == DEV_EVENT_TXUP) {
 			fsm_newstate(fi, DEV_STATE_RUNNING);
-			ctcm_pr_info("%s: connected with remote side\n",
-				    dev->name);
+			dev_info(&dev->dev,
+				"Connected with remote side\n");
 			ctcm_clear_busy(dev);
 		}
 		break;
Index: quilt-2.6/drivers/s390/net/ctcm_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_main.c
+++ quilt-2.6/drivers/s390/net/ctcm_main.c
@@ -21,6 +21,9 @@
 #undef DEBUGDATA
 #undef DEBUGCCW
 
+#define KMSG_COMPONENT "ctcm"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -281,14 +284,16 @@ static long ctcm_check_irb_error(struct 
 
 	switch (PTR_ERR(irb)) {
 	case -EIO:
-		ctcm_pr_warn("i/o-error on device %s\n", dev_name(&cdev->dev));
+		dev_err(&cdev->dev,
+			"An I/O-error occurred on the CTCM device\n");
 		break;
 	case -ETIMEDOUT:
-		ctcm_pr_warn("timeout on device %s\n", dev_name(&cdev->dev));
+		dev_err(&cdev->dev,
+			"An adapter hardware operation timed out\n");
 		break;
 	default:
-		ctcm_pr_warn("unknown error %ld on device %s\n",
-				PTR_ERR(irb), dev_name(&cdev->dev));
+		dev_err(&cdev->dev,
+			"An error occurred on the adapter hardware\n");
 	}
 	return PTR_ERR(irb);
 }
@@ -309,15 +314,17 @@ static inline void ccw_unit_check(struct
 	if (sense & SNS0_INTERVENTION_REQ) {
 		if (sense & 0x01) {
 			if (ch->sense_rc != 0x01) {
-				ctcm_pr_debug("%s: Interface disc. or Sel. "
-					      "reset (remote)\n", ch->id);
+				pr_notice(
+					"%s: The communication peer has "
+					"disconnected\n", ch->id);
 				ch->sense_rc = 0x01;
 			}
 			fsm_event(ch->fsm, CTC_EVENT_UC_RCRESET, ch);
 		} else {
 			if (ch->sense_rc != SNS0_INTERVENTION_REQ) {
-				ctcm_pr_debug("%s: System reset (remote)\n",
-					      ch->id);
+				pr_notice(
+					"%s: The remote operating system is "
+					"not available\n", ch->id);
 				ch->sense_rc = SNS0_INTERVENTION_REQ;
 			}
 			fsm_event(ch->fsm, CTC_EVENT_UC_RSRESET, ch);
@@ -1194,8 +1201,11 @@ static void ctcm_irq_handler(struct ccw_
 
 	/* Check for unsolicited interrupts. */
 	if (cgdev == NULL) {
-		ctcm_pr_warn("ctcm: Got unsolicited irq: c-%02x d-%02x\n",
-			     cstat, dstat);
+		CTCM_DBF_TEXT_(TRACE, CTC_DBF_ERROR,
+			"%s(%s) unsolicited irq: c-%02x d-%02x\n",
+			CTCM_FUNTAIL, dev_name(&cdev->dev), cstat, dstat);
+		dev_warn(&cdev->dev,
+			"The adapter received a non-specific IRQ\n");
 		return;
 	}
 
@@ -1207,31 +1217,34 @@ static void ctcm_irq_handler(struct ccw_
 	else if (priv->channel[WRITE]->cdev == cdev)
 		ch = priv->channel[WRITE];
 	else {
-		ctcm_pr_err("ctcm: Can't determine channel for interrupt, "
-			   "device %s\n", dev_name(&cdev->dev));
+		dev_err(&cdev->dev,
+			"%s: Internal error: Can't determine channel for "
+			"interrupt device %s\n",
+			__func__, dev_name(&cdev->dev));
+			/* Explain: inconsistent internal structures */
 		return;
 	}
 
 	dev = ch->netdev;
 	if (dev == NULL) {
-		ctcm_pr_crit("ctcm: %s dev=NULL bus_id=%s, ch=0x%p\n",
-				__func__, dev_name(&cdev->dev), ch);
+		dev_err(&cdev->dev,
+			"%s Internal error: net_device is NULL, ch = 0x%p\n",
+			__func__, ch);
+			/* Explain: inconsistent internal structures */
 		return;
 	}
 
-	CTCM_DBF_TEXT_(TRACE, CTC_DBF_DEBUG,
-		"%s(%s): int. for %s: cstat=%02x dstat=%02x",
-			CTCM_FUNTAIL, dev->name, ch->id, cstat, dstat);
-
 	/* Copy interruption response block. */
 	memcpy(ch->irb, irb, sizeof(struct irb));
 
+	/* Issue error message and return on subchannel error code */
 	if (irb->scsw.cmd.cstat) {
-	/* Check for good subchannel return code, otherwise error message */
 		fsm_event(ch->fsm, CTC_EVENT_SC_UNKNOWN, ch);
-		ctcm_pr_warn("%s: subchannel check for dev: %s - %02x %02x\n",
-			    dev->name, ch->id, irb->scsw.cmd.cstat,
-			    irb->scsw.cmd.dstat);
+		CTCM_DBF_TEXT_(TRACE, CTC_DBF_WARN,
+			"%s(%s): sub-ch check %s: cs=%02x ds=%02x",
+				CTCM_FUNTAIL, dev->name, ch->id, cstat, dstat);
+		dev_warn(&cdev->dev,
+				"A check occurred on the subchannel\n");
 		return;
 	}
 
@@ -1239,7 +1252,7 @@ static void ctcm_irq_handler(struct ccw_
 	if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) {
 		if ((irb->ecw[0] & ch->sense_rc) == 0)
 			/* print it only once */
-			CTCM_DBF_TEXT_(TRACE, CTC_DBF_INFO,
+			CTCM_DBF_TEXT_(TRACE, CTC_DBF_WARN,
 				"%s(%s): sense=%02x, ds=%02x",
 				CTCM_FUNTAIL, ch->id, irb->ecw[0], dstat);
 		ccw_unit_check(ch, irb->ecw[0]);
@@ -1574,6 +1587,11 @@ static int ctcm_new_device(struct ccwgro
 
 	strlcpy(priv->fsm->name, dev->name, sizeof(priv->fsm->name));
 
+	dev_info(&dev->dev,
+		"setup OK : r/w = %s/%s, protocol : %d\n",
+			priv->channel[READ]->id,
+			priv->channel[WRITE]->id, priv->protocol);
+
 	CTCM_DBF_TEXT_(SETUP, CTC_DBF_INFO,
 		"setup(%s) OK : r/w = %s/%s, protocol : %d", dev->name,
 			priv->channel[READ]->id,
@@ -1687,7 +1705,7 @@ static void __exit ctcm_exit(void)
 {
 	unregister_cu3088_discipline(&ctcm_group_driver);
 	ctcm_unregister_dbf_views();
-	ctcm_pr_info("CTCM driver unloaded\n");
+	pr_info("CTCM driver unloaded\n");
 }
 
 /*
@@ -1695,7 +1713,7 @@ static void __exit ctcm_exit(void)
  */
 static void print_banner(void)
 {
-	printk(KERN_INFO "CTCM driver initialized\n");
+	pr_info("CTCM driver initialized\n");
 }
 
 /**
@@ -1717,8 +1735,8 @@ static int __init ctcm_init(void)
 	ret = register_cu3088_discipline(&ctcm_group_driver);
 	if (ret) {
 		ctcm_unregister_dbf_views();
-		ctcm_pr_crit("ctcm_init failed with register_cu3088_discipline "
-				"(rc = %d)\n", ret);
+		pr_err("%s / register_cu3088_discipline failed, ret = %d\n",
+			__func__, ret);
 		return ret;
 	}
 	print_banner();
Index: quilt-2.6/drivers/s390/net/ctcm_main.h
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_main.h
+++ quilt-2.6/drivers/s390/net/ctcm_main.h
@@ -41,12 +41,6 @@
 #define LOG_FLAG_NOMEM		8
 
 #define ctcm_pr_debug(fmt, arg...) printk(KERN_DEBUG fmt, ##arg)
-#define ctcm_pr_info(fmt, arg...) printk(KERN_INFO fmt, ##arg)
-#define ctcm_pr_notice(fmt, arg...) printk(KERN_NOTICE fmt, ##arg)
-#define ctcm_pr_warn(fmt, arg...) printk(KERN_WARNING fmt, ##arg)
-#define ctcm_pr_emerg(fmt, arg...) printk(KERN_EMERG fmt, ##arg)
-#define ctcm_pr_err(fmt, arg...) printk(KERN_ERR fmt, ##arg)
-#define ctcm_pr_crit(fmt, arg...) printk(KERN_CRIT fmt, ##arg)
 
 #define CTCM_PR_DEBUG(fmt, arg...) \
 	do { \
Index: quilt-2.6/drivers/s390/net/ctcm_mpc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_mpc.c
+++ quilt-2.6/drivers/s390/net/ctcm_mpc.c
@@ -19,6 +19,9 @@
 #undef DEBUGDATA
 #undef DEBUGCCW
 
+#define KMSG_COMPONENT "ctcm"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -386,7 +389,7 @@ int ctc_mpc_alloc_channel(int port_num, 
 		if (grp->allocchan_callback_retries < 4) {
 			if (grp->allochanfunc)
 				grp->allochanfunc(grp->port_num,
-					      grp->group_max_buflen);
+						  grp->group_max_buflen);
 		} else {
 			/* there are problems...bail out	    */
 			/* there may be a state mismatch so restart */
@@ -1232,8 +1235,9 @@ done:
 
 	dev_kfree_skb_any(pskb);
 	if (sendrc == NET_RX_DROP) {
-		printk(KERN_WARNING "%s %s() NETWORK BACKLOG EXCEEDED"
-		       " - PACKET DROPPED\n", dev->name, __func__);
+		dev_warn(&dev->dev,
+			"The network backlog for %s is exceeded, "
+			"package dropped\n", __func__);
 		fsm_event(grp->fsm, MPCG_EVENT_INOP, dev);
 	}
 
@@ -1670,10 +1674,11 @@ static int mpc_validate_xid(struct mpcg_
 					CTCM_FUNTAIL, ch->id);
 		}
 	}
-
 done:
 	if (rc) {
-		ctcm_pr_info("ctcmpc	   :  %s() failed\n", __func__);
+		dev_warn(&dev->dev,
+			"The XID used in the MPC protocol is not valid, "
+			"rc = %d\n", rc);
 		priv->xid->xid2_flag2 = 0x40;
 		grp->saved_xid2->xid2_flag2 = 0x40;
 	}
Index: quilt-2.6/drivers/s390/net/ctcm_sysfs.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_sysfs.c
+++ quilt-2.6/drivers/s390/net/ctcm_sysfs.c
@@ -10,6 +10,9 @@
 #undef DEBUGDATA
 #undef DEBUGCCW
 
+#define KMSG_COMPONENT "ctcm"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/sysfs.h>
 #include "ctcm_main.h"
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
