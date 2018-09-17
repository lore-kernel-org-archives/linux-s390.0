From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 11/15] s390/qeth: uninstall IRQ handler on device removal
Date: Mon, 17 Sep 2018 17:36:05 +0200
Message-ID: <20180917153609.94628-12-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When setting up, qeth installs its IRQ handler on the ccw devices. But
the IRQ handler is not cleared on removal - so even after qeth yields
control of the ccw devices, spurious interrupts would still be presented
to us.

Make (de-)installation of the IRQ handler part of the ccw channel
setup/removal helpers, and while at it also add the appropriate locking.
Shift around qeth_setup_channel() to avoid a forward declaration for
qeth_irq().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 102 ++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c7f7061a7205..b76e844811e1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -901,44 +901,6 @@ static void qeth_send_control_data_cb(struct qeth_channel *channel,
 	qeth_release_buffer(channel, iob);
 }
 
-static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
-{
-	int cnt;
-
-	QETH_DBF_TEXT(SETUP, 2, "setupch");
-
-	channel->ccw = kmalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
-	if (!channel->ccw)
-		return -ENOMEM;
-	channel->state = CH_STATE_DOWN;
-	atomic_set(&channel->irq_pending, 0);
-	init_waitqueue_head(&channel->wait_q);
-
-	if (!alloc_buffers)
-		return 0;
-
-	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++) {
-		channel->iob[cnt].data =
-			kzalloc(QETH_BUFSIZE, GFP_DMA|GFP_KERNEL);
-		if (channel->iob[cnt].data == NULL)
-			break;
-		channel->iob[cnt].state = BUF_STATE_FREE;
-		channel->iob[cnt].channel = channel;
-		channel->iob[cnt].callback = qeth_send_control_data_cb;
-		channel->iob[cnt].rc = 0;
-	}
-	if (cnt < QETH_CMD_BUFFER_NO) {
-		kfree(channel->ccw);
-		while (cnt-- > 0)
-			kfree(channel->iob[cnt].data);
-		return -ENOMEM;
-	}
-	channel->io_buf_no = 0;
-	spin_lock_init(&channel->iob_lock);
-
-	return 0;
-}
-
 static int qeth_set_thread_start_bit(struct qeth_card *card,
 		unsigned long thread)
 {
@@ -1337,14 +1299,61 @@ static void qeth_free_buffer_pool(struct qeth_card *card)
 
 static void qeth_clean_channel(struct qeth_channel *channel)
 {
+	struct ccw_device *cdev = channel->ccwdev;
 	int cnt;
 
 	QETH_DBF_TEXT(SETUP, 2, "freech");
+
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	cdev->handler = NULL;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+
 	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++)
 		kfree(channel->iob[cnt].data);
 	kfree(channel->ccw);
 }
 
+static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
+{
+	struct ccw_device *cdev = channel->ccwdev;
+	int cnt;
+
+	QETH_DBF_TEXT(SETUP, 2, "setupch");
+
+	channel->ccw = kmalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	if (!channel->ccw)
+		return -ENOMEM;
+	channel->state = CH_STATE_DOWN;
+	atomic_set(&channel->irq_pending, 0);
+	init_waitqueue_head(&channel->wait_q);
+
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	cdev->handler = qeth_irq;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+
+	if (!alloc_buffers)
+		return 0;
+
+	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++) {
+		channel->iob[cnt].data =
+			kzalloc(QETH_BUFSIZE, GFP_DMA|GFP_KERNEL);
+		if (channel->iob[cnt].data == NULL)
+			break;
+		channel->iob[cnt].state = BUF_STATE_FREE;
+		channel->iob[cnt].channel = channel;
+		channel->iob[cnt].callback = qeth_send_control_data_cb;
+		channel->iob[cnt].rc = 0;
+	}
+	if (cnt < QETH_CMD_BUFFER_NO) {
+		qeth_clean_channel(channel);
+		return -ENOMEM;
+	}
+	channel->io_buf_no = 0;
+	spin_lock_init(&channel->iob_lock);
+
+	return 0;
+}
+
 static void qeth_set_single_write_queues(struct qeth_card *card)
 {
 	if ((atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED) &&
@@ -1495,7 +1504,7 @@ static void qeth_core_sl_print(struct seq_file *m, struct service_level *slr)
 			CARD_BUS_ID(card), card->info.mcl_level);
 }
 
-static struct qeth_card *qeth_alloc_card(void)
+static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card;
 
@@ -1504,6 +1513,11 @@ static struct qeth_card *qeth_alloc_card(void)
 	if (!card)
 		goto out;
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
+
+	card->gdev = gdev;
+	CARD_RDEV(card) = gdev->cdev[0];
+	CARD_WDEV(card) = gdev->cdev[1];
+	CARD_DDEV(card) = gdev->cdev[2];
 	if (qeth_setup_channel(&card->read, true))
 		goto out_ip;
 	if (qeth_setup_channel(&card->write, true))
@@ -5773,7 +5787,7 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 
 	QETH_DBF_TEXT_(SETUP, 2, "%s", dev_name(&gdev->dev));
 
-	card = qeth_alloc_card();
+	card = qeth_alloc_card(gdev);
 	if (!card) {
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", -ENOMEM);
 		rc = -ENOMEM;
@@ -5789,15 +5803,7 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 			goto err_card;
 	}
 
-	card->read.ccwdev  = gdev->cdev[0];
-	card->write.ccwdev = gdev->cdev[1];
-	card->data.ccwdev  = gdev->cdev[2];
 	dev_set_drvdata(&gdev->dev, card);
-	card->gdev = gdev;
-	gdev->cdev[0]->handler = qeth_irq;
-	gdev->cdev[1]->handler = qeth_irq;
-	gdev->cdev[2]->handler = qeth_irq;
-
 	qeth_setup_card(card);
 	qeth_update_from_chp_desc(card);
 
-- 
2.16.4
