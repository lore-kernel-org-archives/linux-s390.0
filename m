Return-Path: <linux-kernel-owner+w=401wt.eu-S1756236AbYIYQqM@vger.kernel.org>
Message-Id: <20080925163020.899754085@de.ibm.com>
References: <20080925162827.818261893@de.ibm.com>
Date: Thu, 25 Sep 2008 18:28:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/6] kmsg: convert lcs printk messages to kmsg api.
Content-Disposition: inline; filename=805-kmsg-lcs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
Cc: "Klaus-D. Wacker" <kdwacker@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From Klaus-D. Wacker <kdwacker@de.ibm.com>

Signed-off-by: Klaus-D. Wacker <kdwacker@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/kmsg/s390/lcs |  170 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/net/lcs.c      |   78 +++++++++++---------
 2 files changed, 216 insertions(+), 32 deletions(-)

Index: kmsg-2.6/Documentation/kmsg/s390/lcs
===================================================================
--- /dev/null
+++ kmsg-2.6/Documentation/kmsg/s390/lcs
@@ -0,0 +1,170 @@
+/*?
+ * Tag: lcs.1666ed
+ * Text: "%s:  Allocating a socket buffer to interface %s failed\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ *   @2: network interface
+ * Description:
+ * LAN channel station (LCS) devices require a socket buffer (SKB) structure
+ * for storing incoming data. The LCS device driver failed to allocate an SKB
+ * structure to the LCS device. A likely cause of this problem is memory
+ * constraints.
+ * User action:
+ * Free some memory and repeat the failed operation.
+ */
+
+/*?
+ * Tag: lcs.fd3431
+ * Text: "%s:  Shutting down the LCS device failed\n "
+ * Severity: Error
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ * Description:
+ * A request to shut down a LAN channel station (LCS) device resulted in an
+ * error. The error is logged in the LCS trace at trace level 4.
+ * User action:
+ * Try again to shut down the device. If the error persists, see the LCS trace
+ * to find out what causes the error.
+ */
+
+/*?
+ * Tag: lcs.c4ca7a
+ * Text: "%s: Detecting a network adapter for LCS devices failed with rc=%d (0x%x)\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: lcs_detect return code in decimal notation
+ *   @2: lcs_detect return code in hexadecimal notation
+ * Description:
+ * The LCS device driver could not initialize a network adapter.
+ * User action:
+ * Note the return codes from the error message and contact IBM support.
+ */
+
+/*?
+ * Tag: lcs.abd525
+ * Text: "%s: A recovery process has been started for the LCS device\n"
+ * Severity: Warning
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ * Description:
+ * The LAN channel station (LCS) device is shut down and restarted. The recovery
+ * process might have been initiated by a user or started automatically as a
+ * response to a device problem.
+ * User action:
+ * Wait until a message indicates the completion of the recovery process.
+ */
+
+/*?
+ * Tag: lcs.43b3aa
+ * Text: "%s: An I/O-error occurred on the LCS device\n"
+ * Severity: Warning
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ * Description:
+ * The LAN channel station (LCS) device reported a problem that can be recovered
+ * by the LCS device driver. Repeated occurrences of this problem indicate a
+ * malfunctioning device.
+ * User action:
+ * If this problem occurs frequently, initiate a recovery process for the
+ * device, for example, by writing '1' to the 'recover' sysfs attribute of the
+ * device.
+ */
+
+/*?
+ * Tag: lcs.d96565
+ * Text: "%s: A command timed out on the LCS device\n"
+ * Severity: Warning
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ * Description:
+ * The LAN channel station (LCS) device reported a problem that can be recovered
+ * by the LCS device driver. Repeated occurrences of this problem indicate a
+ * malfunctioning device.
+ * User action:
+ * If this problem occurs frequently, initiate a recovery process for the
+ * device, for example, by writing '1' to the 'recover' sysfs attribute of the
+ * device.
+ */
+
+/*?
+ * Tag: lcs.dae31d
+ * Text: "%s: An error occurred on the LCS device, rc=%ld\n"
+ * Severity: Warning
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ *   @2: return code
+ * Description:
+ * The LAN channel station (LCS) device reported a problem that can be recovered
+ * by the LCS device driver. Repeated occurrences of this problem indicate a
+ * malfunctioning device.
+ * User action:
+ * If this problem occurs frequently, initiate a recovery process for the
+ * device, for example, by writing '1' to the 'recover' sysfs attribute of the
+ * device.
+ */
+
+/*?
+* Tag: lcs.45e59d
+ * Text: "%s: The LCS device stopped because of an error, dstat=0x%X, cstat=0x%X \n"
+ * Severity: Warning
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ *   @2: device status
+ *   @3: subchannel status
+ * Description:
+ * The LAN channel station (LCS) device reported an error. The LCS device driver
+ * might start a device recovery process.
+ * User action:
+ * If the device driver does not start a recovery process, initiate a recovery
+ * process, for example, by writing '1' to the 'recover' sysfs attribute of the
+ * device. If the problem persists, note the status information provided with
+ * the message and contact IBM support.
+ */
+
+/*?
+ * Tag: lcs.c16f9f
+ * Text: "%s: Starting an LCS device resulted in an error, rc=%d!\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ *   @2: ccw_device_start return code in decimal notation
+ * Description:
+ * The LAN channel station (LCS) device driver failed to initialize an LCS
+ * device. The device is not operational.
+ * User action:
+ * Initiate a recovery process, for example, by writing '1' to the 'recover'
+ * sysfs attribute of the device. If the problem persists, contact IBM support.
+ */
+
+/*?
+ * Tag: lcs.c5d9db
+ * Text: "%s: Sending data from the LCS device to the LAN failed with rc=%d\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: bus ID of the LCS device
+ *   @2: ccw_device_resume return code in decimal notation
+ * Description:
+ * The LAN channel station (LCS) device driver could not send data to the LAN
+ * using the LCS device. This might be a temporary problem. Operations continue
+ * on the LCS device.
+ * User action:
+ * If this problem occurs frequently, initiate a recovery process, for example,
+ * by writing '1' to the 'recover' sysfs attribute of the device. If the
+ * problem persists, contact IBM support.
+ */
+
+/*? Tag: lcs.1ba8a7 Text: "Query IPAssist failed. Assuming unsupported!\n" */
+/*? Tag: lcs.c4901b Text: "Stoplan for %s initiated by LGW.\n" */
+/*? Tag: lcs.0760e8 Text: "Not enough memory to add new multicast entry!\n" */
+/*? Tag: lcs.d6f064 Text: "Not enough memory for debug facility.\n" */
+/*? Tag: lcs.85e209 Text: "Adding multicast address failed. Table possibly full!\n" */
+/*? Tag: lcs.f3f857 Text: "Error in opening device!\n" */
+/*? Tag: lcs.0aabaa Text: "LCS device %s %s IPv6 support\n" */
+/*? Tag: lcs.453fea Text: "Device %s successfully recovered!\n" */
+/*? Tag: lcs.ea2a85 Text: "LCS device %s %s Multicast support\n" */
+/*? Tag: lcs.38cb90 Text: " Initialization failed\n" */
+/*? Tag: lcs.35862f Text: "Loading %s\n" */
+/*? Tag: lcs.f53f45 Text: "Initialization failed\n" */
+/*? Tag: lcs.c5a5fa Text: "Terminating lcs module.\n" */
+/*? Tag: lcs.535a08 Text: "Device %s could not be recovered!\n" */
Index: kmsg-2.6/drivers/s390/net/lcs.c
===================================================================
--- kmsg-2.6.orig/drivers/s390/net/lcs.c
+++ kmsg-2.6/drivers/s390/net/lcs.c
@@ -26,6 +26,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define KMSG_COMPONENT		"lcs"
+
 #include <linux/module.h>
 #include <linux/if.h>
 #include <linux/netdevice.h>
@@ -36,6 +38,7 @@
 #include <linux/in.h>
 #include <linux/igmp.h>
 #include <linux/delay.h>
+#include <linux/kmsg.h>
 #include <net/arp.h>
 #include <net/ip.h>
 
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
+		kmsg_err("Not enough memory for debug facility.\n");
 		lcs_unregister_debug_facility();
 		return -ENOMEM;
 	}
@@ -502,7 +503,9 @@ lcs_start_channel(struct lcs_channel *ch
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
 		LCS_DBF_TEXT_(4,trace,"essh%s", channel->ccwdev->dev.bus_id);
-		PRINT_ERR("Error in starting channel, rc=%d!\n", rc);
+		dev_err(&channel->ccwdev->dev,
+			"Starting an LCS device resulted in an error,"
+			" rc=%d!\n", rc);
 	}
 	return rc;
 }
@@ -636,7 +639,9 @@ __lcs_resume_channel(struct lcs_channel 
 	rc = ccw_device_resume(channel->ccwdev);
 	if (rc) {
 		LCS_DBF_TEXT_(4, trace, "ersc%s", channel->ccwdev->dev.bus_id);
-		PRINT_ERR("Error in lcs_resume_channel: rc=%d\n",rc);
+		dev_warn(&channel->ccwdev->dev,
+			"Sending data from the LCS device to the LAN failed"
+			" with rc=%d\n",rc);
 	} else
 		channel->state = LCS_CH_STATE_RUNNING;
 	return rc;
@@ -1082,7 +1087,7 @@ lcs_check_multicast_support(struct lcs_c
 	cmd->cmd.lcs_qipassist.num_ip_pairs = 1;
 	rc = lcs_send_lancmd(card, buffer, __lcs_check_multicast_cb);
 	if (rc != 0) {
-		PRINT_ERR("Query IPAssist failed. Assuming unsupported!\n");
+		kmsg_err("Query IPAssist failed. Assuming unsupported!\n");
 		return -EOPNOTSUPP;
 	}
 	if (card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT)
@@ -1115,8 +1120,8 @@ list_modified:
 			rc = lcs_send_setipm(card, ipm);
 			spin_lock_irqsave(&card->ipm_lock, flags);
 			if (rc) {
-				PRINT_INFO("Adding multicast address failed. "
-					   "Table possibly full!\n");
+				kmsg_info("Adding multicast address failed."
+					     " Table possibly full!\n");
 				/* store ipm in failed list -> will be added
 				 * to ipm_list again, so a retry will be done
 				 * during the next call of this function */
@@ -1227,8 +1232,8 @@ lcs_set_mc_addresses(struct lcs_card *ca
 		ipm = (struct lcs_ipm_list *)
 			kzalloc(sizeof(struct lcs_ipm_list), GFP_ATOMIC);
 		if (ipm == NULL) {
-			PRINT_INFO("Not enough memory to add "
-				   "new multicast entry!\n");
+			kmsg_info("Not enough memory to add"
+				   " new multicast entry!\n");
 			break;
 		}
 		memcpy(&ipm->ipm.mac_addr, buf, LCS_MAC_LENGTH);
@@ -1302,18 +1307,21 @@ lcs_check_irb_error(struct ccw_device *c
 
 	switch (PTR_ERR(irb)) {
 	case -EIO:
-		PRINT_WARN("i/o-error on device %s\n", cdev->dev.bus_id);
+		dev_warn(&cdev->dev,
+			"An I/O-error occurred on the LCS device\n");
 		LCS_DBF_TEXT(2, trace, "ckirberr");
 		LCS_DBF_TEXT_(2, trace, "  rc%d", -EIO);
 		break;
 	case -ETIMEDOUT:
-		PRINT_WARN("timeout on device %s\n", cdev->dev.bus_id);
+		dev_warn(&cdev->dev,
+			"A command timed out on the LCS device\n");
 		LCS_DBF_TEXT(2, trace, "ckirberr");
 		LCS_DBF_TEXT_(2, trace, "  rc%d", -ETIMEDOUT);
 		break;
 	default:
-		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
-			   cdev->dev.bus_id);
+		dev_warn(&cdev->dev,
+			"An error occurred on the LCS device, rc=%ld\n",
+			PTR_ERR(irb));
 		LCS_DBF_TEXT(2, trace, "ckirberr");
 		LCS_DBF_TEXT(2, trace, "  rc???");
 	}
@@ -1399,8 +1407,10 @@ lcs_irq(struct ccw_device *cdev, unsigne
 	/* Check for channel and device errors presented */
 	rc = lcs_get_problem(cdev, irb);
 	if (rc || (dstat & DEV_STAT_UNIT_EXCEP)) {
-		PRINT_WARN("check on device %s, dstat=0x%X, cstat=0x%X \n",
-			    cdev->dev.bus_id, dstat, cstat);
+		dev_warn(&cdev->dev,
+			"The LCS device stopped because of an error,"
+			" dstat=0x%X, cstat=0x%X \n",
+			    dstat, cstat);
 		if (rc) {
 			channel->state = LCS_CH_STATE_ERROR;
 		}
@@ -1757,7 +1767,7 @@ lcs_get_control(struct lcs_card *card, s
 			lcs_schedule_recovery(card);
 			break;
 		case LCS_CMD_STOPLAN:
-			PRINT_WARN("Stoplan for %s initiated by LGW.\n",
+			kmsg_warn("Stoplan for %s initiated by LGW.\n",
 					card->dev->name);
 			if (card->dev)
 				netif_carrier_off(card->dev);
@@ -1786,7 +1796,8 @@ lcs_get_skb(struct lcs_card *card, char 
 
 	skb = dev_alloc_skb(skb_len);
 	if (skb == NULL) {
-		PRINT_ERR("LCS: alloc_skb failed for device=%s\n",
+		dev_err(&card->dev->dev,
+			" Allocating a socket buffer to interface %s failed\n",
 			  card->dev->name);
 		card->stats.rx_dropped++;
 		return;
@@ -1882,7 +1893,8 @@ lcs_stop_device(struct net_device *dev)
 		(card->write.state != LCS_CH_STATE_RUNNING));
 	rc = lcs_stopcard(card);
 	if (rc)
-		PRINT_ERR("Try it again!\n ");
+		dev_err(&card->dev->dev,
+			" Shutting down the LCS device failed\n ");
 	return rc;
 }
 
@@ -1901,7 +1913,7 @@ lcs_open_device(struct net_device *dev)
 	/* initialize statistics */
 	rc = lcs_detect(card);
 	if (rc) {
-		PRINT_ERR("LCS:Error in opening device!\n");
+		kmsg_err("Error in opening device!\n");
 
 	} else {
 		dev->flags |= IFF_UP;
@@ -2109,8 +2121,9 @@ lcs_new_device(struct ccwgroup_device *c
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
@@ -2140,7 +2153,7 @@ lcs_new_device(struct ccwgroup_device *c
 #endif
 	default:
 		LCS_DBF_TEXT(3, setup, "errinit");
-		PRINT_ERR("LCS: Initialization failed\n");
+		kmsg_err(" Initialization failed\n");
 		goto out;
 	}
 	if (!dev)
@@ -2172,11 +2185,11 @@ netdev_out:
 		goto out;
 
 	/* Print out supported assists: IPv6 */
-	PRINT_INFO("LCS device %s %s IPv6 support\n", card->dev->name,
+	kmsg_info("LCS device %s %s IPv6 support\n", card->dev->name,
 		   (card->ip_assists_supported & LCS_IPASS_IPV6_SUPPORT) ?
 		   "with" : "without");
 	/* Print out supported assist: Multicast */
-	PRINT_INFO("LCS device %s %s Multicast support\n", card->dev->name,
+	kmsg_info("LCS device %s %s Multicast support\n", card->dev->name,
 		   (card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT) ?
 		   "with" : "without");
 	return 0;
@@ -2244,14 +2257,15 @@ lcs_recovery(void *ptr)
 		return 0;
 	LCS_DBF_TEXT(4, trace, "recover2");
 	gdev = card->gdev;
-	PRINT_WARN("Recovery of device %s started...\n", gdev->dev.bus_id);
+	dev_warn(&gdev->dev,
+		"A recovery process has been started for the LCS device\n");
 	rc = __lcs_shutdown_device(gdev, 1);
 	rc = lcs_new_device(gdev);
 	if (!rc)
-		PRINT_INFO("Device %s successfully recovered!\n",
+		kmsg_info("Device %s successfully recovered!\n",
 				card->dev->name);
 	else
-		PRINT_INFO("Device %s could not be recovered!\n",
+		kmsg_info("Device %s could not be recovered!\n",
 				card->dev->name);
 	lcs_clear_thread_running_bit(card, LCS_RECOVERY_THREAD);
 	return 0;
@@ -2304,17 +2318,17 @@ __init lcs_init_module(void)
 {
 	int rc;
 
-	PRINT_INFO("Loading %s\n",version);
+	kmsg_info("Loading %s\n", version);
 	rc = lcs_register_debug_facility();
 	LCS_DBF_TEXT(0, setup, "lcsinit");
 	if (rc) {
-		PRINT_ERR("Initialization failed\n");
+		kmsg_err("Initialization failed\n");
 		return rc;
 	}
 
 	rc = register_cu3088_discipline(&lcs_group_driver);
 	if (rc) {
-		PRINT_ERR("Initialization failed\n");
+		kmsg_err("Initialization failed\n");
 		return rc;
 	}
 	return 0;
@@ -2327,7 +2341,7 @@ __init lcs_init_module(void)
 static void
 __exit lcs_cleanup_module(void)
 {
-	PRINT_INFO("Terminating lcs module.\n");
+	kmsg_info("Terminating lcs module.\n");
 	LCS_DBF_TEXT(0, trace, "cleanup");
 	unregister_cu3088_discipline(&lcs_group_driver);
 	lcs_unregister_debug_facility();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
