From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/7] s390/qeth: do basic setup for data channel
Date: Thu,  9 Aug 2018 14:48:01 +0200
Message-ID: <20180809124804.20056-5-jwi@linux.ibm.com>
References: <20180809124804.20056-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180809124804.20056-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The data channel currently doesn't need a setup operation, because we
don't use pre-allocated cmd buffers for its IO. But subsequent changes
will introduce further setup that also applies to the data channel.
This refactors things a bit, so that the new stuff can then be
automatically applied to all channels.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 714c71e30b7f..eab8c4a182b0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -899,11 +899,19 @@ static void qeth_send_control_data_cb(struct qeth_channel *channel,
 	qeth_release_buffer(channel, iob);
 }
 
-static int qeth_setup_channel(struct qeth_channel *channel)
+static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 {
 	int cnt;
 
 	QETH_DBF_TEXT(SETUP, 2, "setupch");
+
+	channel->state = CH_STATE_DOWN;
+	atomic_set(&channel->irq_pending, 0);
+	init_waitqueue_head(&channel->wait_q);
+
+	if (!alloc_buffers)
+		return 0;
+
 	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++) {
 		channel->iob[cnt].data =
 			kzalloc(QETH_BUFSIZE, GFP_DMA|GFP_KERNEL);
@@ -920,10 +928,8 @@ static int qeth_setup_channel(struct qeth_channel *channel)
 		return -ENOMEM;
 	}
 	channel->io_buf_no = 0;
-	atomic_set(&channel->irq_pending, 0);
 	spin_lock_init(&channel->iob_lock);
 
-	init_waitqueue_head(&channel->wait_q);
 	return 0;
 }
 
@@ -1448,13 +1454,9 @@ static void qeth_start_kernel_thread(struct work_struct *work)
 static void qeth_buffer_reclaim_work(struct work_struct *);
 static int qeth_setup_card(struct qeth_card *card)
 {
-
 	QETH_DBF_TEXT(SETUP, 2, "setupcrd");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
-	card->read.state  = CH_STATE_DOWN;
-	card->write.state = CH_STATE_DOWN;
-	card->data.state  = CH_STATE_DOWN;
 	card->state = CARD_STATE_DOWN;
 	card->lan_online = 0;
 	card->read_or_write_problem = 0;
@@ -1504,15 +1506,19 @@ static struct qeth_card *qeth_alloc_card(void)
 	if (!card)
 		goto out;
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
-	if (qeth_setup_channel(&card->read))
+	if (qeth_setup_channel(&card->read, true))
 		goto out_ip;
-	if (qeth_setup_channel(&card->write))
+	if (qeth_setup_channel(&card->write, true))
 		goto out_channel;
+	if (qeth_setup_channel(&card->data, false))
+		goto out_data;
 	card->options.layer2 = -1;
 	card->qeth_service_level.seq_print = qeth_core_sl_print;
 	register_service_level(&card->qeth_service_level);
 	return card;
 
+out_data:
+	qeth_clean_channel(&card->write);
 out_channel:
 	qeth_clean_channel(&card->read);
 out_ip:
-- 
2.16.4
