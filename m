Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/12] s390/qeth: consolidate pm code
Date: Thu, 27 Jun 2019 17:01:30 +0200
In-Reply-To: <20190627150133.58746-1-jwi@linux.ibm.com>
References: <20190627150133.58746-1-jwi@linux.ibm.com>
Message-Id: <20190627150133.58746-10-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

De-duplicate the pm callback implementations from the two sub-drivers,
replacing them with core helpers that delegate to the .set_online and
.set_offline callbacks.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  3 ---
 drivers/s390/net/qeth_core_main.c | 36 ++++++++++++++++---------------
 drivers/s390/net/qeth_l2_main.c   | 30 --------------------------
 drivers/s390/net/qeth_l3_main.c   | 30 --------------------------
 4 files changed, 19 insertions(+), 80 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 715bff28d48e..c81d5ec26803 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -713,9 +713,6 @@ struct qeth_discipline {
 	void (*remove) (struct ccwgroup_device *);
 	int (*set_online) (struct ccwgroup_device *);
 	int (*set_offline) (struct ccwgroup_device *);
-	int (*freeze)(struct ccwgroup_device *);
-	int (*thaw) (struct ccwgroup_device *);
-	int (*restore)(struct ccwgroup_device *);
 	int (*do_ioctl)(struct net_device *dev, struct ifreq *rq, int cmd);
 	int (*control_event_handler)(struct qeth_card *card,
 					struct qeth_ipa_cmd *cmd);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index efb9a27b916e..3011cae00391 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5589,28 +5589,30 @@ static void qeth_core_shutdown(struct ccwgroup_device *gdev)
 	qdio_free(CARD_DDEV(card));
 }
 
-static int qeth_core_freeze(struct ccwgroup_device *gdev)
+static int qeth_suspend(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	if (card->discipline && card->discipline->freeze)
-		return card->discipline->freeze(gdev);
-	return 0;
-}
 
-static int qeth_core_thaw(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	if (card->discipline && card->discipline->thaw)
-		return card->discipline->thaw(gdev);
+	qeth_set_allowed_threads(card, 0, 1);
+	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
+	if (gdev->state == CCWGROUP_OFFLINE)
+		return 0;
+
+	card->discipline->set_offline(gdev);
 	return 0;
 }
 
-static int qeth_core_restore(struct ccwgroup_device *gdev)
+static int qeth_resume(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	if (card->discipline && card->discipline->restore)
-		return card->discipline->restore(gdev);
-	return 0;
+	int rc;
+
+	rc = card->discipline->set_online(gdev);
+
+	qeth_set_allowed_threads(card, 0xffffffff, 0);
+	if (rc)
+		dev_warn(&card->gdev->dev, "The qeth device driver failed to recover an error on the device\n");
+	return rc;
 }
 
 static ssize_t group_store(struct device_driver *ddrv, const char *buf,
@@ -5651,9 +5653,9 @@ static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
 	.shutdown = qeth_core_shutdown,
 	.prepare = NULL,
 	.complete = NULL,
-	.freeze = qeth_core_freeze,
-	.thaw = qeth_core_thaw,
-	.restore = qeth_core_restore,
+	.freeze = qeth_suspend,
+	.thaw = qeth_resume,
+	.restore = qeth_resume,
 };
 
 struct qeth_card *qeth_get_card_by_busid(char *bus_id)
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 03e1cd4a282a..4a2ff9d8aa5f 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -965,33 +965,6 @@ static void __exit qeth_l2_exit(void)
 	pr_info("unregister layer 2 discipline\n");
 }
 
-static int qeth_l2_pm_suspend(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-
-	qeth_set_allowed_threads(card, 0, 1);
-	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
-	if (gdev->state == CCWGROUP_OFFLINE)
-		return 0;
-
-	qeth_l2_set_offline(gdev);
-	return 0;
-}
-
-static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	int rc;
-
-	rc = qeth_l2_set_online(gdev);
-
-	qeth_set_allowed_threads(card, 0xffffffff, 0);
-	if (rc)
-		dev_warn(&card->gdev->dev, "The qeth device driver "
-			"failed to recover an error on the device\n");
-	return rc;
-}
-
 /* Returns zero if the command is successfully "consumed" */
 static int qeth_l2_control_event(struct qeth_card *card,
 					struct qeth_ipa_cmd *cmd)
@@ -1021,9 +994,6 @@ struct qeth_discipline qeth_l2_discipline = {
 	.remove = qeth_l2_remove_device,
 	.set_online = qeth_l2_set_online,
 	.set_offline = qeth_l2_set_offline,
-	.freeze = qeth_l2_pm_suspend,
-	.thaw = qeth_l2_pm_resume,
-	.restore = qeth_l2_pm_resume,
 	.do_ioctl = NULL,
 	.control_event_handler = qeth_l2_control_event,
 };
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index c36f368336a0..44a602aa12ec 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2500,33 +2500,6 @@ static int qeth_l3_recover(void *ptr)
 	return 0;
 }
 
-static int qeth_l3_pm_suspend(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-
-	qeth_set_allowed_threads(card, 0, 1);
-	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
-	if (gdev->state == CCWGROUP_OFFLINE)
-		return 0;
-
-	qeth_l3_set_offline(gdev);
-	return 0;
-}
-
-static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	int rc;
-
-	rc = qeth_l3_set_online(gdev);
-
-	qeth_set_allowed_threads(card, 0xffffffff, 0);
-	if (rc)
-		dev_warn(&card->gdev->dev, "The qeth device driver "
-			"failed to recover an error on the device\n");
-	return rc;
-}
-
 /* Returns zero if the command is successfully "consumed" */
 static int qeth_l3_control_event(struct qeth_card *card,
 					struct qeth_ipa_cmd *cmd)
@@ -2542,9 +2515,6 @@ struct qeth_discipline qeth_l3_discipline = {
 	.remove = qeth_l3_remove_device,
 	.set_online = qeth_l3_set_online,
 	.set_offline = qeth_l3_set_offline,
-	.freeze = qeth_l3_pm_suspend,
-	.thaw = qeth_l3_pm_resume,
-	.restore = qeth_l3_pm_resume,
 	.do_ioctl = qeth_l3_do_ioctl,
 	.control_event_handler = qeth_l3_control_event,
 };
-- 
2.17.1
