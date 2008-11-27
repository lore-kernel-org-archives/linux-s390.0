Return-Path: <linux-kernel-owner+w=401wt.eu-S1757274AbYK0Kua@vger.kernel.org>
Message-Id: <20081127103142.647962665@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:13 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 53/60] convert qeth printks to dev_xxx and pr_xxx macros.
Content-Disposition: inline; filename=168-kmsg-qeth.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/qeth_core.h      |    7 -
 drivers/s390/net/qeth_core_main.c |  149 ++++++++++++++------------
 drivers/s390/net/qeth_l2_main.c   |   37 +++---
 drivers/s390/net/qeth_l3_main.c   |  211 +++++++++++++++++++-------------------
 4 files changed, 212 insertions(+), 192 deletions(-)

Index: quilt-2.6/drivers/s390/net/qeth_core.h
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core.h
+++ quilt-2.6/drivers/s390/net/qeth_core.h
@@ -35,8 +35,6 @@
 
 #include "qeth_core_mpc.h"
 
-#define KMSG_COMPONENT "qeth"
-
 /**
  * Debug Facility stuff
  */
@@ -75,11 +73,6 @@ struct qeth_dbf_info {
 #define QETH_DBF_TEXT_(name, level, text...) \
 	qeth_dbf_longtext(QETH_DBF_##name, level, text)
 
-/**
- * some more debug stuff
- */
-#define PRINTK_HEADER	"qeth: "
-
 #define SENSE_COMMAND_REJECT_BYTE 0
 #define SENSE_COMMAND_REJECT_FLAG 0x80
 #define SENSE_RESETTING_EVENT_BYTE 1
Index: quilt-2.6/drivers/s390/net/qeth_core_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core_main.c
+++ quilt-2.6/drivers/s390/net/qeth_core_main.c
@@ -8,6 +8,9 @@
  *		 Frank Blaschka <frank.blaschka@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "qeth"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
@@ -319,7 +322,10 @@ static int qeth_issue_next_read(struct q
 		return -EIO;
 	iob = qeth_get_buffer(&card->read);
 	if (!iob) {
-		PRINT_WARN("issue_next_read failed: no iob available!\n");
+		dev_warn(&card->gdev->dev, "The qeth device driver "
+			"failed to recover an error on the device\n");
+		QETH_DBF_MESSAGE(2, "%s issue_next_read failed: no iob "
+			"available\n", dev_name(&card->gdev->dev));
 		return -ENOMEM;
 	}
 	qeth_setup_ccw(&card->read, iob->data, QETH_BUFSIZE);
@@ -327,7 +333,8 @@ static int qeth_issue_next_read(struct q
 	rc = ccw_device_start(card->read.ccwdev, &card->read.ccw,
 			      (addr_t) iob, 0, 0);
 	if (rc) {
-		PRINT_ERR("Error in starting next read ccw! rc=%i\n", rc);
+		QETH_DBF_MESSAGE(2, "%s error in starting next read ccw! "
+			"rc=%i\n", dev_name(&card->gdev->dev), rc);
 		atomic_set(&card->read.irq_pending, 0);
 		qeth_schedule_recovery(card);
 		wake_up(&card->wait_q);
@@ -393,10 +400,9 @@ static struct qeth_ipa_cmd *qeth_check_i
 		} else {
 			switch (cmd->hdr.command) {
 			case IPA_CMD_STOPLAN:
-				PRINT_WARN("Link failure on %s (CHPID 0x%X) - "
-					   "there is a network problem or "
-					   "someone pulled the cable or "
-					   "disabled the port.\n",
+				dev_warn(&card->gdev->dev,
+					   "The link for interface %s on CHPID"
+					   " 0x%X failed\n",
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
 				card->lan_online = 0;
@@ -404,9 +410,9 @@ static struct qeth_ipa_cmd *qeth_check_i
 					netif_carrier_off(card->dev);
 				return NULL;
 			case IPA_CMD_STARTLAN:
-				PRINT_INFO("Link reestablished on %s "
-					   "(CHPID 0x%X). Scheduling "
-					   "IP address reset.\n",
+				dev_info(&card->gdev->dev,
+					   "The link for %s on CHPID 0x%X has"
+					   " been restored\n",
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
 				netif_carrier_on(card->dev);
@@ -458,7 +464,7 @@ static int qeth_check_idx_response(unsig
 
 	QETH_DBF_HEX(CTRL, 2, buffer, QETH_DBF_CTRL_LEN);
 	if ((buffer[2] & 0xc0) == 0xc0) {
-		PRINT_WARN("received an IDX TERMINATE "
+		QETH_DBF_MESSAGE(2, "received an IDX TERMINATE "
 			   "with cause code 0x%02x%s\n",
 			   buffer[4],
 			   ((buffer[4] == 0x22) ?
@@ -744,8 +750,10 @@ static int qeth_get_problem(struct ccw_d
 		     SCHN_STAT_CHN_DATA_CHK | SCHN_STAT_CHAIN_CHECK |
 		     SCHN_STAT_PROT_CHECK | SCHN_STAT_PROG_CHECK)) {
 		QETH_DBF_TEXT(TRACE, 2, "CGENCHK");
-		PRINT_WARN("check on device %s, dstat=x%x, cstat=x%x ",
-			   dev_name(&cdev->dev), dstat, cstat);
+		dev_warn(&cdev->dev, "The qeth device driver "
+			"failed to recover an error on the device\n");
+		QETH_DBF_MESSAGE(2, "%s check on device dstat=x%x, cstat=x%x ",
+			dev_name(&cdev->dev), dstat, cstat);
 		print_hex_dump(KERN_WARNING, "qeth: irb ", DUMP_PREFIX_OFFSET,
 				16, 1, irb, 64, 1);
 		return 1;
@@ -784,12 +792,14 @@ static long __qeth_check_irb_error(struc
 
 	switch (PTR_ERR(irb)) {
 	case -EIO:
-		PRINT_WARN("i/o-error on device %s\n", dev_name(&cdev->dev));
+		QETH_DBF_MESSAGE(2, "%s i/o-error on device\n",
+			dev_name(&cdev->dev));
 		QETH_DBF_TEXT(TRACE, 2, "ckirberr");
 		QETH_DBF_TEXT_(TRACE, 2, "  rc%d", -EIO);
 		break;
 	case -ETIMEDOUT:
-		PRINT_WARN("timeout on device %s\n", dev_name(&cdev->dev));
+		dev_warn(&cdev->dev, "A hardware operation timed out"
+			" on the device\n");
 		QETH_DBF_TEXT(TRACE, 2, "ckirberr");
 		QETH_DBF_TEXT_(TRACE, 2, "  rc%d", -ETIMEDOUT);
 		if (intparm == QETH_RCD_PARM) {
@@ -802,8 +812,8 @@ static long __qeth_check_irb_error(struc
 		}
 		break;
 	default:
-		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
-			   dev_name(&cdev->dev));
+		QETH_DBF_MESSAGE(2, "%s unknown error %ld on device\n",
+			dev_name(&cdev->dev), PTR_ERR(irb));
 		QETH_DBF_TEXT(TRACE, 2, "ckirberr");
 		QETH_DBF_TEXT(TRACE, 2, "  rc???");
 	}
@@ -869,10 +879,12 @@ static void qeth_irq(struct ccw_device *
 	    (dstat & DEV_STAT_UNIT_CHECK) ||
 	    (cstat)) {
 		if (irb->esw.esw0.erw.cons) {
-			/* TODO: we should make this s390dbf */
-			PRINT_WARN("sense data available on channel %s.\n",
-				   CHANNEL_ID(channel));
-			PRINT_WARN(" cstat 0x%X\n dstat 0x%X\n", cstat, dstat);
+			dev_warn(&channel->ccwdev->dev,
+				"The qeth device driver failed to recover "
+				"an error on the device\n");
+			QETH_DBF_MESSAGE(2, "%s sense data available. cstat "
+				"0x%X dstat 0x%X\n",
+				dev_name(&channel->ccwdev->dev), cstat, dstat);
 			print_hex_dump(KERN_WARNING, "qeth: irb ",
 				DUMP_PREFIX_OFFSET, 16, 1, irb, 32, 1);
 			print_hex_dump(KERN_WARNING, "qeth: sense data ",
@@ -1185,8 +1197,8 @@ static int qeth_determine_card_type(stru
 			card->qdio.no_out_queues = known_devices[i][8];
 			card->info.is_multicast_different = known_devices[i][9];
 			if (qeth_is_1920_device(card)) {
-				PRINT_INFO("Priority Queueing not able "
-					   "due to hardware limitations!\n");
+				dev_info(&card->gdev->dev,
+					"Priority Queueing not supported\n");
 				card->qdio.no_out_queues = 1;
 				card->qdio.default_out_queue = 0;
 			}
@@ -1195,7 +1207,8 @@ static int qeth_determine_card_type(stru
 		i++;
 	}
 	card->info.type = QETH_CARD_TYPE_UNKNOWN;
-	PRINT_ERR("unknown card type on device %s\n", CARD_BUS_ID(card));
+	dev_err(&card->gdev->dev, "The adapter hardware is of an "
+		"unknown type\n");
 	return -ENOENT;
 }
 
@@ -1378,8 +1391,8 @@ static int qeth_get_unitaddr(struct qeth
 	QETH_DBF_TEXT(SETUP, 2, "getunit");
 	rc = qeth_read_conf_data(card, (void **) &prcd, &length);
 	if (rc) {
-		PRINT_ERR("qeth_read_conf_data for device %s returned %i\n",
-			CARD_DDEV_ID(card), rc);
+		QETH_DBF_MESSAGE(2, "%s qeth_read_conf_data returned %i\n",
+			dev_name(&card->gdev->dev), rc);
 		return rc;
 	}
 	card->info.chpid = prcd[30];
@@ -1529,7 +1542,10 @@ static int qeth_idx_activate_channel(str
 	if (rc == -ERESTARTSYS)
 		return rc;
 	if (channel->state != CH_STATE_ACTIVATING) {
-		PRINT_WARN("IDX activate timed out!\n");
+		dev_warn(&channel->ccwdev->dev, "The qeth device driver"
+			" failed to recover an error on the device\n");
+		QETH_DBF_MESSAGE(2, "%s IDX activate timed out\n",
+			dev_name(&channel->ccwdev->dev));
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", -ETIME);
 		qeth_clear_cmd_buffers(channel);
 		return -ETIME;
@@ -1562,20 +1578,21 @@ static void qeth_idx_write_cb(struct qet
 
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(iob->data))) {
 		if (QETH_IDX_ACT_CAUSE_CODE(iob->data) == 0x19)
-			PRINT_ERR("IDX_ACTIVATE on write channel device %s: "
-				"adapter exclusively used by another host\n",
-			CARD_WDEV_ID(card));
+			dev_err(&card->write.ccwdev->dev,
+				"The adapter is used exclusively by another "
+				"host\n");
 		else
-			PRINT_ERR("IDX_ACTIVATE on write channel device %s: "
-				"negative reply\n", CARD_WDEV_ID(card));
+			QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on write channel:"
+				" negative reply\n",
+				dev_name(&card->write.ccwdev->dev));
 		goto out;
 	}
 	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(iob->data), 2);
 	if ((temp & ~0x0100) != qeth_peer_func_level(card->info.func_level)) {
-		PRINT_WARN("IDX_ACTIVATE on write channel device %s: "
-			   "function level mismatch "
-			   "(sent: 0x%x, received: 0x%x)\n",
-			   CARD_WDEV_ID(card), card->info.func_level, temp);
+		QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on write channel: "
+			"function level mismatch (sent: 0x%x, received: "
+			"0x%x)\n", dev_name(&card->write.ccwdev->dev),
+			card->info.func_level, temp);
 		goto out;
 	}
 	channel->state = CH_STATE_UP;
@@ -1601,12 +1618,13 @@ static void qeth_idx_read_cb(struct qeth
 
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(iob->data))) {
 		if (QETH_IDX_ACT_CAUSE_CODE(iob->data) == 0x19)
-			PRINT_ERR("IDX_ACTIVATE on read channel device %s: "
-				"adapter exclusively used by another host\n",
-				CARD_RDEV_ID(card));
+			dev_err(&card->write.ccwdev->dev,
+				"The adapter is used exclusively by another "
+				"host\n");
 		else
-			PRINT_ERR("IDX_ACTIVATE on read channel device %s: "
-				"negative reply\n", CARD_RDEV_ID(card));
+			QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on read channel:"
+				" negative reply\n",
+				dev_name(&card->read.ccwdev->dev));
 		goto out;
 	}
 
@@ -1620,9 +1638,10 @@ static void qeth_idx_read_cb(struct qeth
 
 	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(iob->data), 2);
 	if (temp != qeth_peer_func_level(card->info.func_level)) {
-		PRINT_WARN("IDX_ACTIVATE on read channel device %s: function "
-			   "level mismatch (sent: 0x%x, received: 0x%x)\n",
-			   CARD_RDEV_ID(card), card->info.func_level, temp);
+		QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on read channel: function "
+			"level mismatch (sent: 0x%x, received: 0x%x)\n",
+			dev_name(&card->read.ccwdev->dev),
+			card->info.func_level, temp);
 		goto out;
 	}
 	memcpy(&card->token.issuer_rm_r,
@@ -1696,8 +1715,9 @@ int qeth_send_control_data(struct qeth_c
 			      (addr_t) iob, 0, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(card->write.ccwdev), flags);
 	if (rc) {
-		PRINT_WARN("qeth_send_control_data: "
-			   "ccw_device_start rc = %i\n", rc);
+		QETH_DBF_MESSAGE(2, "%s qeth_send_control_data: "
+			"ccw_device_start rc = %i\n",
+			dev_name(&card->write.ccwdev->dev), rc);
 		QETH_DBF_TEXT_(TRACE, 2, " err%d", rc);
 		spin_lock_irqsave(&card->lock, flags);
 		list_del_init(&reply->list);
@@ -2180,11 +2200,8 @@ static void qeth_print_status_with_portn
 		dbf_text[i] =
 			(char) _ebcasc[(__u8) dbf_text[i]];
 	dbf_text[8] = 0;
-	PRINT_INFO("Device %s/%s/%s is a%s card%s%s%s\n"
+	dev_info(&card->gdev->dev, "Device is a%s card%s%s%s\n"
 	       "with link type %s (portname: %s)\n",
-	       CARD_RDEV_ID(card),
-	       CARD_WDEV_ID(card),
-	       CARD_DDEV_ID(card),
 	       qeth_get_cardname(card),
 	       (card->info.mcl_level[0]) ? " (level: " : "",
 	       (card->info.mcl_level[0]) ? card->info.mcl_level : "",
@@ -2197,23 +2214,17 @@ static void qeth_print_status_with_portn
 static void qeth_print_status_no_portname(struct qeth_card *card)
 {
 	if (card->info.portname[0])
-		PRINT_INFO("Device %s/%s/%s is a%s "
+		dev_info(&card->gdev->dev, "Device is a%s "
 		       "card%s%s%s\nwith link type %s "
 		       "(no portname needed by interface).\n",
-		       CARD_RDEV_ID(card),
-		       CARD_WDEV_ID(card),
-		       CARD_DDEV_ID(card),
 		       qeth_get_cardname(card),
 		       (card->info.mcl_level[0]) ? " (level: " : "",
 		       (card->info.mcl_level[0]) ? card->info.mcl_level : "",
 		       (card->info.mcl_level[0]) ? ")" : "",
 		       qeth_get_cardname_short(card));
 	else
-		PRINT_INFO("Device %s/%s/%s is a%s "
+		dev_info(&card->gdev->dev, "Device is a%s "
 		       "card%s%s%s\nwith link type %s.\n",
-		       CARD_RDEV_ID(card),
-		       CARD_WDEV_ID(card),
-		       CARD_DDEV_ID(card),
 		       qeth_get_cardname(card),
 		       (card->info.mcl_level[0]) ? " (level: " : "",
 		       (card->info.mcl_level[0]) ? card->info.mcl_level : "",
@@ -2640,9 +2651,8 @@ void qeth_queue_input_buffer(struct qeth
 				qeth_get_micros() -
 				card->perf_stats.inbound_do_qdio_start_time;
 		if (rc) {
-			PRINT_WARN("qeth_queue_input_buffer's do_QDIO "
-				   "return %i (device %s).\n",
-				   rc, CARD_DDEV_ID(card));
+			dev_warn(&card->gdev->dev,
+				"QDIO reported an error, rc=%i\n", rc);
 			QETH_DBF_TEXT(TRACE, 2, "qinberr");
 			QETH_DBF_TEXT_(TRACE, 2, "%s", CARD_BUS_ID(card));
 		}
@@ -3777,7 +3787,8 @@ int qeth_core_hardsetup_card(struct qeth
 	atomic_set(&card->force_alloc_skb, 0);
 retry:
 	if (retries < 3) {
-		PRINT_WARN("Retrying to do IDX activates.\n");
+		QETH_DBF_MESSAGE(2, "%s Retrying to do IDX activates.\n",
+			dev_name(&card->gdev->dev));
 		ccw_device_set_offline(CARD_DDEV(card));
 		ccw_device_set_offline(CARD_WDEV(card));
 		ccw_device_set_offline(CARD_RDEV(card));
@@ -3852,7 +3863,10 @@ retry:
 	}
 	return 0;
 out:
-	PRINT_ERR("Initialization in hardsetup failed! rc=%d\n", rc);
+	dev_warn(&card->gdev->dev, "The qeth device driver failed to recover "
+		"an error on the device\n");
+	QETH_DBF_MESSAGE(2, "%s Initialization in hardsetup failed! rc=%d\n",
+		dev_name(&card->gdev->dev), rc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(qeth_core_hardsetup_card);
@@ -4072,8 +4086,8 @@ int qeth_core_load_discipline(struct qet
 		break;
 	}
 	if (!card->discipline.ccwgdriver) {
-		PRINT_ERR("Support for discipline %d not present\n",
-				discipline);
+		dev_err(&card->gdev->dev, "There is no kernel module to "
+			"support discipline %d\n", discipline);
 		rc = -EINVAL;
 	}
 	return rc;
@@ -4466,7 +4480,7 @@ static int __init qeth_core_init(void)
 {
 	int rc;
 
-	PRINT_INFO("loading core functions\n");
+	pr_info("loading core functions\n");
 	INIT_LIST_HEAD(&qeth_core_card_list.list);
 	rwlock_init(&qeth_core_card_list.rwlock);
 
@@ -4506,9 +4520,10 @@ driver_err:
 ccwgroup_err:
 	ccw_driver_unregister(&qeth_ccw_driver);
 ccw_err:
+	QETH_DBF_MESSAGE(2, "Initialization failed with code %d\n", rc);
 	qeth_unregister_dbf_views();
 out_err:
-	PRINT_ERR("Initialization failed with code %d\n", rc);
+	pr_err("Initializing the qeth device driver failed\n");
 	return rc;
 }
 
@@ -4521,7 +4536,7 @@ static void __exit qeth_core_exit(void)
 	ccw_driver_unregister(&qeth_ccw_driver);
 	kmem_cache_destroy(qeth_core_header_cache);
 	qeth_unregister_dbf_views();
-	PRINT_INFO("core functions removed\n");
+	pr_info("core functions removed\n");
 }
 
 module_init(qeth_core_init);
Index: quilt-2.6/drivers/s390/net/qeth_l2_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_l2_main.c
+++ quilt-2.6/drivers/s390/net/qeth_l2_main.c
@@ -8,6 +8,9 @@
  *		 Frank Blaschka <frank.blaschka@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "qeth"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
@@ -503,12 +506,13 @@ static int qeth_l2_send_setmac_cb(struct
 		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
 		memcpy(card->dev->dev_addr, cmd->data.setdelmac.mac,
 		       OSA_ADDR_LEN);
-		PRINT_INFO("MAC address %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
-			   "successfully registered on device %s\n",
-			   card->dev->dev_addr[0], card->dev->dev_addr[1],
-			   card->dev->dev_addr[2], card->dev->dev_addr[3],
-			   card->dev->dev_addr[4], card->dev->dev_addr[5],
-			   card->dev->name);
+		dev_info(&card->gdev->dev,
+			"MAC address %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
+			"successfully registered on device %s\n",
+			card->dev->dev_addr[0], card->dev->dev_addr[1],
+			card->dev->dev_addr[2], card->dev->dev_addr[3],
+			card->dev->dev_addr[4], card->dev->dev_addr[5],
+			card->dev->name);
 	}
 	return 0;
 }
@@ -1015,9 +1019,8 @@ static int __qeth_l2_set_online(struct c
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 		if (rc == 0xe080) {
-			PRINT_WARN("LAN on card %s if offline! "
-				   "Waiting for STARTLAN from card.\n",
-				   CARD_BUS_ID(card));
+			dev_warn(&card->gdev->dev,
+				"The LAN is offline\n");
 			card->lan_online = 0;
 		}
 		return rc;
@@ -1117,8 +1120,8 @@ static int qeth_l2_recover(void *ptr)
 	if (!qeth_do_run_thread(card, QETH_RECOVER_THREAD))
 		return 0;
 	QETH_DBF_TEXT(TRACE, 2, "recover2");
-	PRINT_WARN("Recovery of device %s started ...\n",
-		   CARD_BUS_ID(card));
+	dev_warn(&card->gdev->dev,
+		"A recovery process has been started for the device\n");
 	card->use_hard_stop = 1;
 	__qeth_l2_set_offline(card->gdev, 1);
 	rc = __qeth_l2_set_online(card->gdev, 1);
@@ -1126,27 +1129,27 @@ static int qeth_l2_recover(void *ptr)
 	qeth_clear_thread_start_bit(card, QETH_RECOVER_THREAD);
 	qeth_clear_thread_running_bit(card, QETH_RECOVER_THREAD);
 	if (!rc)
-		PRINT_INFO("Device %s successfully recovered!\n",
-			   CARD_BUS_ID(card));
+		dev_info(&card->gdev->dev,
+			"Device successfully recovered!\n");
 	else {
 		rtnl_lock();
 		dev_close(card->dev);
 		rtnl_unlock();
-		PRINT_INFO("Device %s could not be recovered!\n",
-			   CARD_BUS_ID(card));
+		dev_warn(&card->gdev->dev, "The qeth device driver "
+			"failed to recover an error on the device\n");
 	}
 	return 0;
 }
 
 static int __init qeth_l2_init(void)
 {
-	PRINT_INFO("register layer 2 discipline\n");
+	pr_info("register layer 2 discipline\n");
 	return 0;
 }
 
 static void __exit qeth_l2_exit(void)
 {
-	PRINT_INFO("unregister layer 2 discipline\n");
+	pr_info("unregister layer 2 discipline\n");
 }
 
 static void qeth_l2_shutdown(struct ccwgroup_device *gdev)
Index: quilt-2.6/drivers/s390/net/qeth_l3_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_l3_main.c
+++ quilt-2.6/drivers/s390/net/qeth_l3_main.c
@@ -8,6 +8,9 @@
  *		 Frank Blaschka <frank.blaschka@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "qeth"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
@@ -917,8 +920,8 @@ static int qeth_l3_register_addr_entry(s
 	if (rc) {
 		QETH_DBF_TEXT(TRACE, 2, "FAILED");
 		qeth_l3_ipaddr_to_string(addr->proto, (u8 *)&addr->u, buf);
-		PRINT_WARN("Could not register IP address %s (rc=0x%x/%d)\n",
-			   buf, rc, rc);
+		dev_warn(&card->gdev->dev,
+			"Registering IP address %s failed\n", buf);
 	}
 	return rc;
 }
@@ -1029,24 +1032,22 @@ static int qeth_l3_setadapter_parms(stru
 	QETH_DBF_TEXT(SETUP, 2, "setadprm");
 
 	if (!qeth_is_supported(card, IPA_SETADAPTERPARMS)) {
-		PRINT_WARN("set adapter parameters not supported "
-			   "on device %s.\n",
-			   CARD_BUS_ID(card));
+		dev_info(&card->gdev->dev,
+			"set adapter parameters not supported.\n");
 		QETH_DBF_TEXT(SETUP, 2, " notsupp");
 		return 0;
 	}
 	rc = qeth_query_setadapterparms(card);
 	if (rc) {
-		PRINT_WARN("couldn't set adapter parameters on device %s: "
-			   "x%x\n", CARD_BUS_ID(card), rc);
+		QETH_DBF_MESSAGE(2, "%s couldn't set adapter parameters: "
+			"0x%x\n", card->gdev->dev.bus_id, rc);
 		return rc;
 	}
 	if (qeth_adp_supported(card, IPA_SETADP_ALTER_MAC_ADDRESS)) {
 		rc = qeth_setadpparms_change_macaddr(card);
 		if (rc)
-			PRINT_WARN("couldn't get MAC address on "
-				   "device %s: x%x\n",
-				   CARD_BUS_ID(card), rc);
+			dev_warn(&card->gdev->dev, "Reading the adapter MAC"
+				" address failed\n", rc);
 	}
 
 	if ((card->info.link_type == QETH_LINK_TYPE_HSTR) ||
@@ -1160,16 +1161,17 @@ static int qeth_l3_start_ipa_arp_process
 	QETH_DBF_TEXT(TRACE, 3, "ipaarp");
 
 	if (!qeth_is_supported(card, IPA_ARP_PROCESSING)) {
-		PRINT_WARN("ARP processing not supported "
-			   "on %s!\n", QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"ARP processing not supported on %s!\n",
+			QETH_CARD_IFNAME(card));
 		return 0;
 	}
 	rc = qeth_l3_send_simple_setassparms(card, IPA_ARP_PROCESSING,
 					IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Could not start ARP processing "
-			   "assist on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Starting ARP processing support for %s failed\n",
+			QETH_CARD_IFNAME(card));
 	}
 	return rc;
 }
@@ -1181,19 +1183,21 @@ static int qeth_l3_start_ipa_ip_fragment
 	QETH_DBF_TEXT(TRACE, 3, "ipaipfrg");
 
 	if (!qeth_is_supported(card, IPA_IP_FRAGMENTATION)) {
-		PRINT_INFO("Hardware IP fragmentation not supported on %s\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Hardware IP fragmentation not supported on %s\n",
+			QETH_CARD_IFNAME(card));
 		return  -EOPNOTSUPP;
 	}
 
 	rc = qeth_l3_send_simple_setassparms(card, IPA_IP_FRAGMENTATION,
 					  IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Could not start Hardware IP fragmentation "
-			   "assist on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Starting IP fragmentation support for %s failed\n",
+			QETH_CARD_IFNAME(card));
 	} else
-		PRINT_INFO("Hardware IP fragmentation enabled \n");
+		dev_info(&card->gdev->dev,
+			"Hardware IP fragmentation enabled \n");
 	return rc;
 }
 
@@ -1207,17 +1211,18 @@ static int qeth_l3_start_ipa_source_mac(
 		return -EOPNOTSUPP;
 
 	if (!qeth_is_supported(card, IPA_SOURCE_MAC)) {
-		PRINT_INFO("Inbound source address not "
-			   "supported on %s\n", QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Inbound source address not supported on %s\n",
+			QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 
 	rc = qeth_l3_send_simple_setassparms(card, IPA_SOURCE_MAC,
 					  IPA_CMD_ASS_START, 0);
 	if (rc)
-		PRINT_WARN("Could not start inbound source "
-			   "assist on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Starting proxy ARP support for %s failed\n",
+			QETH_CARD_IFNAME(card));
 	return rc;
 }
 
@@ -1228,19 +1233,19 @@ static int qeth_l3_start_ipa_vlan(struct
 	QETH_DBF_TEXT(TRACE, 3, "strtvlan");
 
 	if (!qeth_is_supported(card, IPA_FULL_VLAN)) {
-		PRINT_WARN("VLAN not supported on %s\n",
-				QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"VLAN not supported on %s\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 
 	rc = qeth_l3_send_simple_setassparms(card, IPA_VLAN_PRIO,
 					  IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Could not start vlan "
-			   "assist on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Starting VLAN support for %s failed\n",
+			QETH_CARD_IFNAME(card));
 	} else {
-		PRINT_INFO("VLAN enabled \n");
+		dev_info(&card->gdev->dev, "VLAN enabled\n");
 	}
 	return rc;
 }
@@ -1252,19 +1257,20 @@ static int qeth_l3_start_ipa_multicast(s
 	QETH_DBF_TEXT(TRACE, 3, "stmcast");
 
 	if (!qeth_is_supported(card, IPA_MULTICASTING)) {
-		PRINT_WARN("Multicast not supported on %s\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Multicast not supported on %s\n",
+			QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 
 	rc = qeth_l3_send_simple_setassparms(card, IPA_MULTICASTING,
 					  IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Could not start multicast "
-			   "assist on %s: rc=%i\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Starting multicast support for %s failed\n",
+			QETH_CARD_IFNAME(card));
 	} else {
-		PRINT_INFO("Multicast enabled\n");
+		dev_info(&card->gdev->dev, "Multicast enabled\n");
 		card->dev->flags |= IFF_MULTICAST;
 	}
 	return rc;
@@ -1315,36 +1321,37 @@ static int qeth_l3_softsetup_ipv6(struct
 
 	rc = qeth_l3_query_ipassists(card, QETH_PROT_IPV6);
 	if (rc) {
-		PRINT_ERR("IPv6 query ipassist failed on %s\n",
-			  QETH_CARD_IFNAME(card));
+		dev_err(&card->gdev->dev,
+			"Activating IPv6 support for %s failed\n",
+			QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	rc = qeth_l3_send_simple_setassparms(card, IPA_IPV6,
 					  IPA_CMD_ASS_START, 3);
 	if (rc) {
-		PRINT_WARN("IPv6 start assist (version 4) failed "
-			   "on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Activating IPv6 support for %s failed\n",
+			QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	rc = qeth_l3_send_simple_setassparms_ipv6(card, IPA_IPV6,
 					       IPA_CMD_ASS_START);
 	if (rc) {
-		PRINT_WARN("IPV6 start assist (version 6) failed  "
-			   "on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Activating IPv6 support for %s failed\n",
+			 QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	rc = qeth_l3_send_simple_setassparms_ipv6(card, IPA_PASSTHRU,
 					       IPA_CMD_ASS_START);
 	if (rc) {
-		PRINT_WARN("Could not enable passthrough "
-			   "on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Enabling the passthrough mode for %s failed\n",
+			QETH_CARD_IFNAME(card));
 		return rc;
 	}
 out:
-	PRINT_INFO("IPV6 enabled \n");
+	dev_info(&card->gdev->dev, "IPV6 enabled\n");
 	return 0;
 }
 #endif
@@ -1356,8 +1363,8 @@ static int qeth_l3_start_ipa_ipv6(struct
 	QETH_DBF_TEXT(TRACE, 3, "strtipv6");
 
 	if (!qeth_is_supported(card, IPA_IPV6)) {
-		PRINT_WARN("IPv6 not supported on %s\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"IPv6 not supported on %s\n", QETH_CARD_IFNAME(card));
 		return 0;
 	}
 #ifdef CONFIG_QETH_IPV6
@@ -1373,34 +1380,35 @@ static int qeth_l3_start_ipa_broadcast(s
 	QETH_DBF_TEXT(TRACE, 3, "stbrdcst");
 	card->info.broadcast_capable = 0;
 	if (!qeth_is_supported(card, IPA_FILTERING)) {
-		PRINT_WARN("Broadcast not supported on %s\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Broadcast not supported on %s\n",
+			QETH_CARD_IFNAME(card));
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
 	rc = qeth_l3_send_simple_setassparms(card, IPA_FILTERING,
 					  IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Could not enable broadcasting filtering "
-			   "on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev, "Enabling broadcast filtering for "
+			"%s failed\n", QETH_CARD_IFNAME(card));
 		goto out;
 	}
 
 	rc = qeth_l3_send_simple_setassparms(card, IPA_FILTERING,
 					  IPA_CMD_ASS_CONFIGURE, 1);
 	if (rc) {
-		PRINT_WARN("Could not set up broadcast filtering on %s: 0x%x\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev,
+			"Setting up broadcast filtering for %s failed\n",
+			QETH_CARD_IFNAME(card));
 		goto out;
 	}
 	card->info.broadcast_capable = QETH_BROADCAST_WITH_ECHO;
-	PRINT_INFO("Broadcast enabled \n");
+	dev_info(&card->gdev->dev, "Broadcast enabled\n");
 	rc = qeth_l3_send_simple_setassparms(card, IPA_FILTERING,
 					  IPA_CMD_ASS_ENABLE, 1);
 	if (rc) {
-		PRINT_WARN("Could not set up broadcast echo filtering on "
-			   "%s: 0x%x\n", QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev, "Setting up broadcast echo "
+			"filtering for %s failed\n", QETH_CARD_IFNAME(card));
 		goto out;
 	}
 	card->info.broadcast_capable = QETH_BROADCAST_WITHOUT_ECHO;
@@ -1419,18 +1427,18 @@ static int qeth_l3_send_checksum_command
 	rc = qeth_l3_send_simple_setassparms(card, IPA_INBOUND_CHECKSUM,
 					  IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Starting Inbound HW Checksumming failed on %s: "
-			   "0x%x,\ncontinuing using Inbound SW Checksumming\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev, "Starting HW checksumming for %s "
+			"failed, using SW checksumming\n",
+			QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	rc = qeth_l3_send_simple_setassparms(card, IPA_INBOUND_CHECKSUM,
 					  IPA_CMD_ASS_ENABLE,
 					  card->info.csum_mask);
 	if (rc) {
-		PRINT_WARN("Enabling Inbound HW Checksumming failed on %s: "
-			   "0x%x,\ncontinuing using Inbound SW Checksumming\n",
-			   QETH_CARD_IFNAME(card), rc);
+		dev_warn(&card->gdev->dev, "Enabling HW checksumming for %s "
+			"failed, using SW checksumming\n",
+			QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	return 0;
@@ -1443,26 +1451,30 @@ static int qeth_l3_start_ipa_checksum(st
 	QETH_DBF_TEXT(TRACE, 3, "strtcsum");
 
 	if (card->options.checksum_type == NO_CHECKSUMMING) {
-		PRINT_WARN("Using no checksumming on %s.\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Using no checksumming on %s.\n",
+			QETH_CARD_IFNAME(card));
 		return 0;
 	}
 	if (card->options.checksum_type == SW_CHECKSUMMING) {
-		PRINT_WARN("Using SW checksumming on %s.\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Using SW checksumming on %s.\n",
+			QETH_CARD_IFNAME(card));
 		return 0;
 	}
 	if (!qeth_is_supported(card, IPA_INBOUND_CHECKSUM)) {
-		PRINT_WARN("Inbound HW Checksumming not "
-			   "supported on %s,\ncontinuing "
-			   "using Inbound SW Checksumming\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Inbound HW Checksumming not "
+			"supported on %s,\ncontinuing "
+			"using Inbound SW Checksumming\n",
+			QETH_CARD_IFNAME(card));
 		card->options.checksum_type = SW_CHECKSUMMING;
 		return 0;
 	}
 	rc = qeth_l3_send_checksum_command(card);
 	if (!rc)
-		PRINT_INFO("HW Checksumming (inbound) enabled \n");
+		dev_info(&card->gdev->dev,
+			"HW Checksumming (inbound) enabled\n");
 
 	return rc;
 }
@@ -1474,18 +1486,20 @@ static int qeth_l3_start_ipa_tso(struct 
 	QETH_DBF_TEXT(TRACE, 3, "sttso");
 
 	if (!qeth_is_supported(card, IPA_OUTBOUND_TSO)) {
-		PRINT_WARN("Outbound TSO not supported on %s\n",
-			   QETH_CARD_IFNAME(card));
+		dev_info(&card->gdev->dev,
+			"Outbound TSO not supported on %s\n",
+			QETH_CARD_IFNAME(card));
 		rc = -EOPNOTSUPP;
 	} else {
 		rc = qeth_l3_send_simple_setassparms(card, IPA_OUTBOUND_TSO,
 						IPA_CMD_ASS_START, 0);
 		if (rc)
-			PRINT_WARN("Could not start outbound TSO "
-				   "assist on %s: rc=%i\n",
-				   QETH_CARD_IFNAME(card), rc);
+			dev_warn(&card->gdev->dev, "Starting outbound TCP "
+				"segmentation offload for %s failed\n",
+				QETH_CARD_IFNAME(card));
 		else
-			PRINT_INFO("Outbound TSO enabled\n");
+			dev_info(&card->gdev->dev,
+				"Outbound TSO enabled\n");
 	}
 	if (rc && (card->options.large_send == QETH_LARGE_SEND_TSO)) {
 		card->options.large_send = QETH_LARGE_SEND_NO;
@@ -1578,12 +1592,8 @@ static int qeth_l3_get_unique_id_cb(stru
 	else {
 		card->info.unique_id =  UNIQUE_ID_IF_CREATE_ADDR_FAILED |
 					UNIQUE_ID_NOT_BY_CARD;
-		PRINT_WARN("couldn't get a unique id from the card on device "
-			   "%s (result=x%x), using default id. ipv6 "
-			   "autoconfig on other lpars may lead to duplicate "
-			   "ip addresses. please use manually "
-			   "configured ones.\n",
-			   CARD_BUS_ID(card), cmd->hdr.return_code);
+		dev_warn(&card->gdev->dev, "The network adapter failed to "
+			"generate a unique ID\n");
 	}
 	return 0;
 }
@@ -3086,9 +3096,8 @@ static int __qeth_l3_set_online(struct c
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 		if (rc == 0xe080) {
-			PRINT_WARN("LAN on card %s if offline! "
-				   "Waiting for STARTLAN from card.\n",
-				   CARD_BUS_ID(card));
+			dev_warn(&card->gdev->dev,
+				"The LAN is offline\n");
 			card->lan_online = 0;
 		}
 		return rc;
@@ -3194,8 +3203,8 @@ static int qeth_l3_recover(void *ptr)
 	if (!qeth_do_run_thread(card, QETH_RECOVER_THREAD))
 		return 0;
 	QETH_DBF_TEXT(TRACE, 2, "recover2");
-	PRINT_WARN("Recovery of device %s started ...\n",
-		   CARD_BUS_ID(card));
+	dev_warn(&card->gdev->dev,
+		"A recovery process has been started for the device\n");
 	card->use_hard_stop = 1;
 	__qeth_l3_set_offline(card->gdev, 1);
 	rc = __qeth_l3_set_online(card->gdev, 1);
@@ -3203,14 +3212,14 @@ static int qeth_l3_recover(void *ptr)
 	qeth_clear_thread_start_bit(card, QETH_RECOVER_THREAD);
 	qeth_clear_thread_running_bit(card, QETH_RECOVER_THREAD);
 	if (!rc)
-		PRINT_INFO("Device %s successfully recovered!\n",
-			   CARD_BUS_ID(card));
+		dev_info(&card->gdev->dev,
+			"Device successfully recovered!\n");
 	else {
 		rtnl_lock();
 		dev_close(card->dev);
 		rtnl_unlock();
-		PRINT_INFO("Device %s could not be recovered!\n",
-			   CARD_BUS_ID(card));
+		dev_warn(&card->gdev->dev, "The qeth device driver "
+			"failed to recover an error on the device\n");
 	}
 	return 0;
 }
@@ -3344,7 +3353,7 @@ static int qeth_l3_register_notifiers(vo
 		return rc;
 	}
 #else
-	PRINT_WARN("layer 3 discipline no IPv6 support\n");
+	pr_warning("There is no IPv6 support for the layer 3 discipline\n");
 #endif
 	return 0;
 }
@@ -3363,7 +3372,7 @@ static int __init qeth_l3_init(void)
 {
 	int rc = 0;
 
-	PRINT_INFO("register layer 3 discipline\n");
+	pr_info("register layer 3 discipline\n");
 	rc = qeth_l3_register_notifiers();
 	return rc;
 }
@@ -3371,7 +3380,7 @@ static int __init qeth_l3_init(void)
 static void __exit qeth_l3_exit(void)
 {
 	qeth_l3_unregister_notifiers();
-	PRINT_INFO("unregister layer 3 discipline\n");
+	pr_info("unregister layer 3 discipline\n");
 }
 
 module_init(qeth_l3_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
