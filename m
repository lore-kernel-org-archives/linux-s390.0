Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/9] s390/qeth: only handle IRQs while device is online
Date: Wed, 18 Dec 2019 17:34:42 +0100
In-Reply-To: <20191218163450.36731-1-jwi@linux.ibm.com>
References: <20191218163450.36731-1-jwi@linux.ibm.com>
Message-Id: <20191218163450.36731-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

A qeth device that's offline should not be receiving any IRQs - all
pending IOs have been terminated, and we avoid starting any new ones.

So rather than immediately registering the IRQ handler when the device
is probed, only register it while the device is online.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 68 ++++++++++++++-----------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ce7ff1abbef3..3d2374801308 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -972,8 +972,6 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	/* while we hold the ccwdev lock, this stays valid: */
 	gdev = dev_get_drvdata(&cdev->dev);
 	card = dev_get_drvdata(&gdev->dev);
-	if (!card)
-		return;
 
 	QETH_CARD_TEXT(card, 5, "irq");
 
@@ -1198,31 +1196,6 @@ static void qeth_free_buffer_pool(struct qeth_card *card)
 	}
 }
 
-static void qeth_clean_channel(struct qeth_channel *channel)
-{
-	struct ccw_device *cdev = channel->ccwdev;
-
-	QETH_DBF_TEXT(SETUP, 2, "freech");
-
-	spin_lock_irq(get_ccwdev_lock(cdev));
-	cdev->handler = NULL;
-	spin_unlock_irq(get_ccwdev_lock(cdev));
-}
-
-static void qeth_setup_channel(struct qeth_channel *channel)
-{
-	struct ccw_device *cdev = channel->ccwdev;
-
-	QETH_DBF_TEXT(SETUP, 2, "setupch");
-
-	channel->state = CH_STATE_DOWN;
-	atomic_set(&channel->irq_pending, 0);
-
-	spin_lock_irq(get_ccwdev_lock(cdev));
-	cdev->handler = qeth_irq;
-	spin_unlock_irq(get_ccwdev_lock(cdev));
-}
-
 static int qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 {
 	unsigned int count = single ? 1 : card->dev->num_tx_queues;
@@ -1395,9 +1368,6 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 	if (!card->read_cmd)
 		goto out_read_cmd;
 
-	qeth_setup_channel(&card->read);
-	qeth_setup_channel(&card->write);
-	qeth_setup_channel(&card->data);
 	card->qeth_service_level.seq_print = qeth_core_sl_print;
 	register_service_level(&card->qeth_service_level);
 	return card;
@@ -1467,12 +1437,38 @@ int qeth_stop_channel(struct qeth_channel *channel)
 			channel->active_cmd);
 		channel->active_cmd = NULL;
 	}
+	cdev->handler = NULL;
 	spin_unlock_irq(get_ccwdev_lock(cdev));
 
 	return rc;
 }
 EXPORT_SYMBOL_GPL(qeth_stop_channel);
 
+static int qeth_start_channel(struct qeth_channel *channel)
+{
+	struct ccw_device *cdev = channel->ccwdev;
+	int rc;
+
+	channel->state = CH_STATE_DOWN;
+	atomic_set(&channel->irq_pending, 0);
+
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	cdev->handler = qeth_irq;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+
+	rc = ccw_device_set_online(cdev);
+	if (rc)
+		goto err;
+
+	return 0;
+
+err:
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	cdev->handler = NULL;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+	return rc;
+}
+
 static int qeth_halt_channels(struct qeth_card *card)
 {
 	int rc1 = 0, rc2 = 0, rc3 = 0;
@@ -4706,7 +4702,7 @@ static void qeth_determine_capabilities(struct qeth_card *card)
 	QETH_CARD_TEXT(card, 2, "detcapab");
 	if (!ddev->online) {
 		ddev_offline = 1;
-		rc = ccw_device_set_online(ddev);
+		rc = qeth_start_channel(channel);
 		if (rc) {
 			QETH_CARD_TEXT_(card, 2, "3err%d", rc);
 			goto out;
@@ -4881,9 +4877,6 @@ static int qeth_qdio_establish(struct qeth_card *card)
 static void qeth_core_free_card(struct qeth_card *card)
 {
 	QETH_CARD_TEXT(card, 2, "freecrd");
-	qeth_clean_channel(&card->read);
-	qeth_clean_channel(&card->write);
-	qeth_clean_channel(&card->data);
 	qeth_put_cmd(card->read_cmd);
 	destroy_workqueue(card->event_wq);
 	unregister_service_level(&card->qeth_service_level);
@@ -4946,13 +4939,14 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	qeth_stop_channel(&card->write);
 	qeth_stop_channel(&card->read);
 	qdio_free(CARD_DDEV(card));
-	rc = ccw_device_set_online(CARD_RDEV(card));
+
+	rc = qeth_start_channel(&card->read);
 	if (rc)
 		goto retriable;
-	rc = ccw_device_set_online(CARD_WDEV(card));
+	rc = qeth_start_channel(&card->write);
 	if (rc)
 		goto retriable;
-	rc = ccw_device_set_online(CARD_DDEV(card));
+	rc = qeth_start_channel(&card->data);
 	if (rc)
 		goto retriable;
 retriable:
-- 
2.17.1
