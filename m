Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgESTJS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 15:09:18 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/2] s390/net: remove pm ops from ccwgroup drivers
Date: Tue, 19 May 2020 21:09:03 +0200
Message-Id: <20200519190904.64217-2-jwi@linux.ibm.com>
In-Reply-To: <20200519190904.64217-1-jwi@linux.ibm.com>
References: <20200519190904.64217-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>

commit 5e1fb45ec8e2 ("s390/ccwgroup: remove pm support") removed power
management support from the ccwgroup bus driver. So remove the
associated callbacks from all ccwgroup drivers.

CC: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 arch/s390/include/asm/ccwgroup.h  | 10 ------
 drivers/s390/net/ctcm_main.c      | 40 ---------------------
 drivers/s390/net/lcs.c            | 59 -------------------------------
 drivers/s390/net/qeth_core_main.c | 31 ----------------
 4 files changed, 140 deletions(-)

diff --git a/arch/s390/include/asm/ccwgroup.h b/arch/s390/include/asm/ccwgroup.h
index 7293c139dd79..ad3acb1e882b 100644
--- a/arch/s390/include/asm/ccwgroup.h
+++ b/arch/s390/include/asm/ccwgroup.h
@@ -36,11 +36,6 @@ struct ccwgroup_device {
  * @set_online: function called when device is set online
  * @set_offline: function called when device is set offline
  * @shutdown: function called when device is shut down
- * @prepare: prepare for pm state transition
- * @complete: undo work done in @prepare
- * @freeze: callback for freezing during hibernation snapshotting
- * @thaw: undo work done in @freeze
- * @restore: callback for restoring after hibernation
  * @driver: embedded driver structure
  * @ccw_driver: supported ccw_driver (optional)
  */
@@ -50,11 +45,6 @@ struct ccwgroup_driver {
 	int (*set_online) (struct ccwgroup_device *);
 	int (*set_offline) (struct ccwgroup_device *);
 	void (*shutdown)(struct ccwgroup_device *);
-	int (*prepare) (struct ccwgroup_device *);
-	void (*complete) (struct ccwgroup_device *);
-	int (*freeze)(struct ccwgroup_device *);
-	int (*thaw) (struct ccwgroup_device *);
-	int (*restore)(struct ccwgroup_device *);
 
 	struct device_driver driver;
 	struct ccw_driver *ccw_driver;
diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 437a6d822105..d06809eac16d 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1698,43 +1698,6 @@ static void ctcm_remove_device(struct ccwgroup_device *cgdev)
 	put_device(&cgdev->dev);
 }
 
-static int ctcm_pm_suspend(struct ccwgroup_device *gdev)
-{
-	struct ctcm_priv *priv = dev_get_drvdata(&gdev->dev);
-
-	if (gdev->state == CCWGROUP_OFFLINE)
-		return 0;
-	netif_device_detach(priv->channel[CTCM_READ]->netdev);
-	ctcm_close(priv->channel[CTCM_READ]->netdev);
-	if (!wait_event_timeout(priv->fsm->wait_q,
-	    fsm_getstate(priv->fsm) == DEV_STATE_STOPPED, CTCM_TIME_5_SEC)) {
-		netif_device_attach(priv->channel[CTCM_READ]->netdev);
-		return -EBUSY;
-	}
-	ccw_device_set_offline(gdev->cdev[1]);
-	ccw_device_set_offline(gdev->cdev[0]);
-	return 0;
-}
-
-static int ctcm_pm_resume(struct ccwgroup_device *gdev)
-{
-	struct ctcm_priv *priv = dev_get_drvdata(&gdev->dev);
-	int rc;
-
-	if (gdev->state == CCWGROUP_OFFLINE)
-		return 0;
-	rc = ccw_device_set_online(gdev->cdev[1]);
-	if (rc)
-		goto err_out;
-	rc = ccw_device_set_online(gdev->cdev[0]);
-	if (rc)
-		goto err_out;
-	ctcm_open(priv->channel[CTCM_READ]->netdev);
-err_out:
-	netif_device_attach(priv->channel[CTCM_READ]->netdev);
-	return rc;
-}
-
 static struct ccw_device_id ctcm_ids[] = {
 	{CCW_DEVICE(0x3088, 0x08), .driver_info = ctcm_channel_type_parallel},
 	{CCW_DEVICE(0x3088, 0x1e), .driver_info = ctcm_channel_type_ficon},
@@ -1764,9 +1727,6 @@ static struct ccwgroup_driver ctcm_group_driver = {
 	.remove      = ctcm_remove_device,
 	.set_online  = ctcm_new_device,
 	.set_offline = ctcm_shutdown_device,
-	.freeze	     = ctcm_pm_suspend,
-	.thaw	     = ctcm_pm_resume,
-	.restore     = ctcm_pm_resume,
 };
 
 static ssize_t group_store(struct device_driver *ddrv, const char *buf,
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 8f08b0a2917c..440219bcaa2b 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -2296,60 +2296,6 @@ lcs_remove_device(struct ccwgroup_device *ccwgdev)
 	put_device(&ccwgdev->dev);
 }
 
-static int lcs_pm_suspend(struct lcs_card *card)
-{
-	if (card->dev)
-		netif_device_detach(card->dev);
-	lcs_set_allowed_threads(card, 0);
-	lcs_wait_for_threads(card, 0xffffffff);
-	if (card->state != DEV_STATE_DOWN)
-		__lcs_shutdown_device(card->gdev, 1);
-	return 0;
-}
-
-static int lcs_pm_resume(struct lcs_card *card)
-{
-	int rc = 0;
-
-	if (card->state == DEV_STATE_RECOVER)
-		rc = lcs_new_device(card->gdev);
-	if (card->dev)
-		netif_device_attach(card->dev);
-	if (rc) {
-		dev_warn(&card->gdev->dev, "The lcs device driver "
-			"failed to recover the device\n");
-	}
-	return rc;
-}
-
-static int lcs_prepare(struct ccwgroup_device *gdev)
-{
-	return 0;
-}
-
-static void lcs_complete(struct ccwgroup_device *gdev)
-{
-	return;
-}
-
-static int lcs_freeze(struct ccwgroup_device *gdev)
-{
-	struct lcs_card *card = dev_get_drvdata(&gdev->dev);
-	return lcs_pm_suspend(card);
-}
-
-static int lcs_thaw(struct ccwgroup_device *gdev)
-{
-	struct lcs_card *card = dev_get_drvdata(&gdev->dev);
-	return lcs_pm_resume(card);
-}
-
-static int lcs_restore(struct ccwgroup_device *gdev)
-{
-	struct lcs_card *card = dev_get_drvdata(&gdev->dev);
-	return lcs_pm_resume(card);
-}
-
 static struct ccw_device_id lcs_ids[] = {
 	{CCW_DEVICE(0x3088, 0x08), .driver_info = lcs_channel_type_parallel},
 	{CCW_DEVICE(0x3088, 0x1f), .driver_info = lcs_channel_type_2216},
@@ -2382,11 +2328,6 @@ static struct ccwgroup_driver lcs_group_driver = {
 	.remove      = lcs_remove_device,
 	.set_online  = lcs_new_device,
 	.set_offline = lcs_shutdown_device,
-	.prepare     = lcs_prepare,
-	.complete    = lcs_complete,
-	.freeze	     = lcs_freeze,
-	.thaw	     = lcs_thaw,
-	.restore     = lcs_restore,
 };
 
 static ssize_t group_store(struct device_driver *ddrv, const char *buf,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index db8e069be3a0..18a0fb75a710 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6434,32 +6434,6 @@ static void qeth_core_shutdown(struct ccwgroup_device *gdev)
 	qdio_free(CARD_DDEV(card));
 }
 
-static int qeth_suspend(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-
-	qeth_set_allowed_threads(card, 0, 1);
-	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
-	if (gdev->state == CCWGROUP_OFFLINE)
-		return 0;
-
-	qeth_set_offline(card, false);
-	return 0;
-}
-
-static int qeth_resume(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	int rc;
-
-	rc = qeth_set_online(card);
-
-	qeth_set_allowed_threads(card, 0xffffffff, 0);
-	if (rc)
-		dev_warn(&card->gdev->dev, "The qeth device driver failed to recover an error on the device\n");
-	return rc;
-}
-
 static ssize_t group_store(struct device_driver *ddrv, const char *buf,
 			   size_t count)
 {
@@ -6496,11 +6470,6 @@ static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
 	.set_online = qeth_core_set_online,
 	.set_offline = qeth_core_set_offline,
 	.shutdown = qeth_core_shutdown,
-	.prepare = NULL,
-	.complete = NULL,
-	.freeze = qeth_suspend,
-	.thaw = qeth_resume,
-	.restore = qeth_resume,
 };
 
 struct qeth_card *qeth_get_card_by_busid(char *bus_id)
-- 
2.17.1
