Return-Path: <linux-kernel-owner+w=401wt.eu-S1756452AbYK0KnT@vger.kernel.org>
Message-Id: <20081127103138.126488871@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 37/60] convert lcs printks to dev_xxx and pr_xxx macros.
Content-Disposition: inline; filename=152-kmsg-lcs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, "Klaus-D. Wacker" <kdwacker@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Klaus-D. Wacker <kdwacker@de.ibm.com>

Signed-off-by: Klaus-D. Wacker <kdwacker@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/lcs.c |   92 ++++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 39 deletions(-)

Index: quilt-2.6/drivers/s390/net/lcs.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/lcs.c
+++ quilt-2.6/drivers/s390/net/lcs.c
@@ -26,6 +26,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define KMSG_COMPONENT		"lcs"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/if.h>
 #include <linux/netdevice.h>
@@ -54,8 +57,6 @@
 #error Cannot compile lcs.c without some net devices switched on.
 #endif
 
-#define PRINTK_HEADER		" lcs: "
-
 /**
  * initialization string for output
  */
@@ -96,7 +97,7 @@ lcs_register_debug_facility(void)
 	lcs_dbf_setup = debug_register("lcs_setup", 2, 1, 8);
 	lcs_dbf_trace = debug_register("lcs_trace", 4, 1, 8);
 	if (lcs_dbf_setup == NULL || lcs_dbf_trace == NULL) {
-		PRINT_ERR("Not enough memory for debug facility.\n");
+		pr_err("Not enough memory for debug facility.\n");
 		lcs_unregister_debug_facility();
 		return -ENOMEM;
 	}
@@ -503,7 +504,9 @@ lcs_start_channel(struct lcs_channel *ch
 	if (rc) {
 		LCS_DBF_TEXT_(4,trace,"essh%s",
 			      dev_name(&channel->ccwdev->dev));
-		PRINT_ERR("Error in starting channel, rc=%d!\n", rc);
+		dev_err(&channel->ccwdev->dev,
+			"Starting an LCS device resulted in an error,"
+			" rc=%d!\n", rc);
 	}
 	return rc;
 }
@@ -640,7 +643,9 @@ __lcs_resume_channel(struct lcs_channel 
 	if (rc) {
 		LCS_DBF_TEXT_(4, trace, "ersc%s",
 			      dev_name(&channel->ccwdev->dev));
-		PRINT_ERR("Error in lcs_resume_channel: rc=%d\n",rc);
+		dev_warn(&channel->ccwdev->dev,
+			"Sending data from the LCS device to the LAN failed"
+			" with rc=%d\n",rc);
 	} else
 		channel->state = LCS_CH_STATE_RUNNING;
 	return rc;
@@ -1086,7 +1091,7 @@ lcs_check_multicast_support(struct lcs_c
 	cmd->cmd.lcs_qipassist.num_ip_pairs = 1;
 	rc = lcs_send_lancmd(card, buffer, __lcs_check_multicast_cb);
 	if (rc != 0) {
-		PRINT_ERR("Query IPAssist failed. Assuming unsupported!\n");
+		pr_err("Query IPAssist failed. Assuming unsupported!\n");
 		return -EOPNOTSUPP;
 	}
 	if (card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT)
@@ -1119,8 +1124,8 @@ list_modified:
 			rc = lcs_send_setipm(card, ipm);
 			spin_lock_irqsave(&card->ipm_lock, flags);
 			if (rc) {
-				PRINT_INFO("Adding multicast address failed. "
-					   "Table possibly full!\n");
+				pr_info("Adding multicast address failed."
+					" Table possibly full!\n");
 				/* store ipm in failed list -> will be added
 				 * to ipm_list again, so a retry will be done
 				 * during the next call of this function */
@@ -1231,8 +1236,8 @@ lcs_set_mc_addresses(struct lcs_card *ca
 		ipm = (struct lcs_ipm_list *)
 			kzalloc(sizeof(struct lcs_ipm_list), GFP_ATOMIC);
 		if (ipm == NULL) {
-			PRINT_INFO("Not enough memory to add "
-				   "new multicast entry!\n");
+			pr_info("Not enough memory to add"
+				" new multicast entry!\n");
 			break;
 		}
 		memcpy(&ipm->ipm.mac_addr, buf, LCS_MAC_LENGTH);
@@ -1306,18 +1311,21 @@ lcs_check_irb_error(struct ccw_device *c
 
 	switch (PTR_ERR(irb)) {
 	case -EIO:
-		PRINT_WARN("i/o-error on device %s\n", dev_name(&cdev->dev));
+		dev_warn(&cdev->dev,
+			"An I/O-error occurred on the LCS device\n");
 		LCS_DBF_TEXT(2, trace, "ckirberr");
 		LCS_DBF_TEXT_(2, trace, "  rc%d", -EIO);
 		break;
 	case -ETIMEDOUT:
-		PRINT_WARN("timeout on device %s\n", dev_name(&cdev->dev));
+		dev_warn(&cdev->dev,
+			"A command timed out on the LCS device\n");
 		LCS_DBF_TEXT(2, trace, "ckirberr");
 		LCS_DBF_TEXT_(2, trace, "  rc%d", -ETIMEDOUT);
 		break;
 	default:
-		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
-			   dev_name(&cdev->dev));
+		dev_warn(&cdev->dev,
+			"An error occurred on the LCS device, rc=%ld\n",
+			PTR_ERR(irb));
 		LCS_DBF_TEXT(2, trace, "ckirberr");
 		LCS_DBF_TEXT(2, trace, "  rc???");
 	}
@@ -1403,8 +1411,10 @@ lcs_irq(struct ccw_device *cdev, unsigne
 	/* Check for channel and device errors presented */
 	rc = lcs_get_problem(cdev, irb);
 	if (rc || (dstat & DEV_STAT_UNIT_EXCEP)) {
-		PRINT_WARN("check on device %s, dstat=0x%X, cstat=0x%X \n",
-			    dev_name(&cdev->dev), dstat, cstat);
+		dev_warn(&cdev->dev,
+			"The LCS device stopped because of an error,"
+			" dstat=0x%X, cstat=0x%X \n",
+			    dstat, cstat);
 		if (rc) {
 			channel->state = LCS_CH_STATE_ERROR;
 		}
@@ -1761,8 +1771,8 @@ lcs_get_control(struct lcs_card *card, s
 			lcs_schedule_recovery(card);
 			break;
 		case LCS_CMD_STOPLAN:
-			PRINT_WARN("Stoplan for %s initiated by LGW.\n",
-					card->dev->name);
+			pr_warning("Stoplan for %s initiated by LGW.\n",
+				   card->dev->name);
 			if (card->dev)
 				netif_carrier_off(card->dev);
 			break;
@@ -1790,7 +1800,8 @@ lcs_get_skb(struct lcs_card *card, char 
 
 	skb = dev_alloc_skb(skb_len);
 	if (skb == NULL) {
-		PRINT_ERR("LCS: alloc_skb failed for device=%s\n",
+		dev_err(&card->dev->dev,
+			" Allocating a socket buffer to interface %s failed\n",
 			  card->dev->name);
 		card->stats.rx_dropped++;
 		return;
@@ -1886,7 +1897,8 @@ lcs_stop_device(struct net_device *dev)
 		(card->write.state != LCS_CH_STATE_RUNNING));
 	rc = lcs_stopcard(card);
 	if (rc)
-		PRINT_ERR("Try it again!\n ");
+		dev_err(&card->dev->dev,
+			" Shutting down the LCS device failed\n ");
 	return rc;
 }
 
@@ -1905,7 +1917,7 @@ lcs_open_device(struct net_device *dev)
 	/* initialize statistics */
 	rc = lcs_detect(card);
 	if (rc) {
-		PRINT_ERR("LCS:Error in opening device!\n");
+		pr_err("Error in opening device!\n");
 
 	} else {
 		dev->flags |= IFF_UP;
@@ -2113,8 +2125,9 @@ lcs_new_device(struct ccwgroup_device *c
 	rc = lcs_detect(card);
 	if (rc) {
 		LCS_DBF_TEXT(2, setup, "dtctfail");
-		PRINT_WARN("Detection of LCS card failed with return code "
-			   "%d (0x%x)\n", rc, rc);
+		dev_warn(&card->dev->dev,
+			"Detecting a network adapter for LCS devices"
+			" failed with rc=%d (0x%x)\n", rc, rc);
 		lcs_stopcard(card);
 		goto out;
 	}
@@ -2144,7 +2157,7 @@ lcs_new_device(struct ccwgroup_device *c
 #endif
 	default:
 		LCS_DBF_TEXT(3, setup, "errinit");
-		PRINT_ERR("LCS: Initialization failed\n");
+		pr_err(" Initialization failed\n");
 		goto out;
 	}
 	if (!dev)
@@ -2176,13 +2189,13 @@ netdev_out:
 		goto out;
 
 	/* Print out supported assists: IPv6 */
-	PRINT_INFO("LCS device %s %s IPv6 support\n", card->dev->name,
-		   (card->ip_assists_supported & LCS_IPASS_IPV6_SUPPORT) ?
-		   "with" : "without");
+	pr_info("LCS device %s %s IPv6 support\n", card->dev->name,
+		(card->ip_assists_supported & LCS_IPASS_IPV6_SUPPORT) ?
+		"with" : "without");
 	/* Print out supported assist: Multicast */
-	PRINT_INFO("LCS device %s %s Multicast support\n", card->dev->name,
-		   (card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT) ?
-		   "with" : "without");
+	pr_info("LCS device %s %s Multicast support\n", card->dev->name,
+		(card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT) ?
+		"with" : "without");
 	return 0;
 out:
 
@@ -2248,15 +2261,16 @@ lcs_recovery(void *ptr)
 		return 0;
 	LCS_DBF_TEXT(4, trace, "recover2");
 	gdev = card->gdev;
-	PRINT_WARN("Recovery of device %s started...\n", dev_name(&gdev->dev));
+	dev_warn(&gdev->dev,
+		"A recovery process has been started for the LCS device\n");
 	rc = __lcs_shutdown_device(gdev, 1);
 	rc = lcs_new_device(gdev);
 	if (!rc)
-		PRINT_INFO("Device %s successfully recovered!\n",
-				card->dev->name);
+		pr_info("Device %s successfully recovered!\n",
+			card->dev->name);
 	else
-		PRINT_INFO("Device %s could not be recovered!\n",
-				card->dev->name);
+		pr_info("Device %s could not be recovered!\n",
+			card->dev->name);
 	lcs_clear_thread_running_bit(card, LCS_RECOVERY_THREAD);
 	return 0;
 }
@@ -2308,17 +2322,17 @@ __init lcs_init_module(void)
 {
 	int rc;
 
-	PRINT_INFO("Loading %s\n",version);
+	pr_info("Loading %s\n", version);
 	rc = lcs_register_debug_facility();
 	LCS_DBF_TEXT(0, setup, "lcsinit");
 	if (rc) {
-		PRINT_ERR("Initialization failed\n");
+		pr_err("Initialization failed\n");
 		return rc;
 	}
 
 	rc = register_cu3088_discipline(&lcs_group_driver);
 	if (rc) {
-		PRINT_ERR("Initialization failed\n");
+		pr_err("Initialization failed\n");
 		return rc;
 	}
 	return 0;
@@ -2331,7 +2345,7 @@ __init lcs_init_module(void)
 static void
 __exit lcs_cleanup_module(void)
 {
-	PRINT_INFO("Terminating lcs module.\n");
+	pr_info("Terminating lcs module.\n");
 	LCS_DBF_TEXT(0, trace, "cleanup");
 	unregister_cu3088_discipline(&lcs_group_driver);
 	lcs_unregister_debug_facility();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
