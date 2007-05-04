Return-Path: <linux-kernel-owner+w=401wt.eu-S1031398AbXEDQy6@vger.kernel.org>
Message-Id: <20070504165242.514962947@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 7/9] qeth: New read configuration data.
Content-Disposition: inline; filename=012-cio-deprecate3.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Instead of the deprecated read_conf_data(), implement a new function
qeth_read_conf_data().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/qeth.h      |    3 +
 drivers/s390/net/qeth_main.c |   77 ++++++++++++++++++++++++++++++++++++++++---
 drivers/s390/net/qeth_mpc.h  |    1 
 3 files changed, 76 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/net/qeth.h
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/net/qeth.h	2007-05-04 18:50:16.000000000 +0200
@@ -288,6 +288,7 @@
  */
 #define IF_NAME_LEN	 	16
 #define QETH_TX_TIMEOUT		100 * HZ
+#define QETH_RCD_TIMEOUT	60 * HZ
 #define QETH_HEADER_SIZE	32
 #define MAX_PORTNO 		15
 #define QETH_FAKE_LL_LEN_ETH	ETH_HLEN
@@ -582,6 +583,8 @@
 	CH_STATE_ACTIVATING,
 	CH_STATE_HALTED,
 	CH_STATE_STOPPED,
+	CH_STATE_RCD,
+	CH_STATE_RCD_DONE,
 };
 /**
  * card state machine
Index: quilt-2.6/drivers/s390/net/qeth_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_main.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/net/qeth_main.c	2007-05-04 18:50:16.000000000 +0200
@@ -315,7 +315,8 @@
 }
 
 static long
-__qeth_check_irb_error(struct ccw_device *cdev, struct irb *irb)
+__qeth_check_irb_error(struct ccw_device *cdev, unsigned long intparm,
+		       struct irb *irb)
 {
 	if (!IS_ERR(irb))
 		return 0;
@@ -330,6 +331,14 @@
 		PRINT_WARN("timeout on device %s\n", cdev->dev.bus_id);
 		QETH_DBF_TEXT(trace, 2, "ckirberr");
 		QETH_DBF_TEXT_(trace, 2, "  rc%d", -ETIMEDOUT);
+		if (intparm == QETH_RCD_PARM) {
+			struct qeth_card *card = CARD_FROM_CDEV(cdev);
+
+			if (card && (card->data.ccwdev == cdev)) {
+				card->data.state = CH_STATE_DOWN;
+				wake_up(&card->wait_q);
+			}
+		}
 		break;
 	default:
 		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
@@ -401,7 +410,7 @@
 
 	QETH_DBF_TEXT(trace,5,"irq");
 
-	if (__qeth_check_irb_error(cdev, irb))
+	if (__qeth_check_irb_error(cdev, intparm, irb))
 		return;
 	cstat = irb->scsw.cstat;
 	dstat = irb->scsw.dstat;
@@ -429,7 +438,8 @@
 		channel->state = CH_STATE_HALTED;
 
 	/*let's wake up immediately on data channel*/
-	if ((channel == &card->data) && (intparm != 0))
+	if ((channel == &card->data) && (intparm != 0) &&
+	    (intparm != QETH_RCD_PARM))
 		goto out;
 
 	if (intparm == QETH_CLEAR_CHANNEL_PARM) {
@@ -453,6 +463,10 @@
 			HEXDUMP16(WARN,"irb: ",irb);
 			HEXDUMP16(WARN,"sense data: ",irb->ecw);
 		}
+		if (intparm == QETH_RCD_PARM) {
+			channel->state = CH_STATE_DOWN;
+			goto out;
+		}
 		rc = qeth_get_problem(cdev,irb);
 		if (rc) {
 			qeth_schedule_recovery(card);
@@ -460,6 +474,10 @@
 		}
 	}
 
+	if (intparm == QETH_RCD_PARM) {
+		channel->state = CH_STATE_RCD_DONE;
+		goto out;
+	}
 	if (intparm) {
 		buffer = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
 		buffer->state = BUF_STATE_PROCESSED;
@@ -1204,6 +1222,54 @@
 }
 
 
+static int qeth_read_conf_data(struct qeth_card *card, void **buffer,
+			       int *length)
+{
+	struct ciw *ciw;
+	char *rcd_buf;
+	int ret;
+	struct qeth_channel *channel = &card->data;
+	unsigned long flags;
+
+	/*
+	 * scan for RCD command in extended SenseID data
+	 */
+	ciw = ccw_device_get_ciw(channel->ccwdev, CIW_TYPE_RCD);
+	if (!ciw || ciw->cmd == 0)
+		return -EOPNOTSUPP;
+	rcd_buf = kzalloc(ciw->count, GFP_KERNEL | GFP_DMA);
+	if (!rcd_buf)
+		return -ENOMEM;
+
+	channel->ccw.cmd_code = ciw->cmd;
+	channel->ccw.cda = (__u32) __pa (rcd_buf);
+	channel->ccw.count = ciw->count;
+	channel->ccw.flags = CCW_FLAG_SLI;
+	channel->state = CH_STATE_RCD;
+	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	ret = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+				       QETH_RCD_PARM, LPM_ANYPATH, 0,
+				       QETH_RCD_TIMEOUT);
+	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	if (!ret)
+		wait_event(card->wait_q,
+			   (channel->state == CH_STATE_RCD_DONE ||
+			    channel->state == CH_STATE_DOWN));
+	if (channel->state == CH_STATE_DOWN)
+		ret = -EIO;
+	else
+		channel->state = CH_STATE_DOWN;
+	if (ret) {
+		kfree(rcd_buf);
+		*buffer = NULL;
+		*length = 0;
+	} else {
+		*length = ciw->count;
+		*buffer = rcd_buf;
+	}
+	return ret;
+}
+
 static int
 qeth_get_unitaddr(struct qeth_card *card)
 {
@@ -1212,9 +1278,9 @@
 	int rc;
 
 	QETH_DBF_TEXT(setup, 2, "getunit");
-	rc = read_conf_data(CARD_DDEV(card), (void **) &prcd, &length);
+	rc = qeth_read_conf_data(card, (void **) &prcd, &length);
 	if (rc) {
-		PRINT_ERR("read_conf_data for device %s returned %i\n",
+		PRINT_ERR("qeth_read_conf_data for device %s returned %i\n",
 			  CARD_DDEV_ID(card), rc);
 		return rc;
 	}
@@ -1223,6 +1289,7 @@
 	card->info.cula = prcd[63];
 	card->info.guestlan = ((prcd[0x10] == _ascebc['V']) &&
 			       (prcd[0x11] == _ascebc['M']));
+	kfree(prcd);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/net/qeth_mpc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_mpc.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/net/qeth_mpc.h	2007-05-04 18:50:16.000000000 +0200
@@ -37,6 +37,7 @@
 
 #define QETH_CLEAR_CHANNEL_PARM	-10
 #define QETH_HALT_CHANNEL_PARM	-11
+#define QETH_RCD_PARM -12
 
 /*****************************************************************************/
 /* IP Assist related definitions                                             */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
