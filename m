Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/10] s390/qeth: clarify default cmd callback
Date: Thu, 28 Mar 2019 16:39:25 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Current code makes it look like qeth_send_control_data_cb() is some
sort of default callback for all cmds. But in practice, it is only used
for half of the cmd buffers we issue.
Reduce the confusion by only setting this callback for cmds that
actually want it, and while at it give the callback a name that matches
the established naming scheme.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b6c9861108ce..093464567025 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -61,9 +61,9 @@ static struct kmem_cache *qeth_qdio_outbuf_cache;
 static struct device *qeth_core_root_dev;
 static struct lock_class_key qdio_out_skb_queue_key;
 
-static void qeth_send_control_data_cb(struct qeth_card *card,
-				      struct qeth_channel *channel,
-				      struct qeth_cmd_buffer *iob);
+static void qeth_issue_next_read_cb(struct qeth_card *card,
+				    struct qeth_channel *channel,
+				    struct qeth_cmd_buffer *iob);
 static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *);
 static void qeth_free_buffer_pool(struct qeth_card *);
 static int qeth_qdio_establish(struct qeth_card *);
@@ -511,7 +511,9 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 				 CARD_DEVID(card));
 		return -ENOMEM;
 	}
+
 	qeth_setup_ccw(channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
+	iob->callback = qeth_issue_next_read_cb;
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
 	rc = ccw_device_start(channel->ccwdev, channel->ccw,
 			      (addr_t) iob, 0, 0);
@@ -721,7 +723,7 @@ void qeth_release_buffer(struct qeth_channel *channel,
 
 	spin_lock_irqsave(&channel->iob_lock, flags);
 	iob->state = BUF_STATE_FREE;
-	iob->callback = qeth_send_control_data_cb;
+	iob->callback = NULL;
 	if (iob->reply) {
 		qeth_put_reply(iob->reply);
 		iob->reply = NULL;
@@ -779,9 +781,9 @@ void qeth_clear_cmd_buffers(struct qeth_channel *channel)
 }
 EXPORT_SYMBOL_GPL(qeth_clear_cmd_buffers);
 
-static void qeth_send_control_data_cb(struct qeth_card *card,
-				      struct qeth_channel *channel,
-				      struct qeth_cmd_buffer *iob)
+static void qeth_issue_next_read_cb(struct qeth_card *card,
+				    struct qeth_channel *channel,
+				    struct qeth_cmd_buffer *iob)
 {
 	struct qeth_ipa_cmd *cmd = NULL;
 	struct qeth_reply *reply = NULL;
@@ -1272,7 +1274,6 @@ static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 			break;
 		channel->iob[cnt].state = BUF_STATE_FREE;
 		channel->iob[cnt].channel = channel;
-		channel->iob[cnt].callback = qeth_send_control_data_cb;
 	}
 	if (cnt < QETH_CMD_BUFFER_NO) {
 		qeth_clean_channel(channel);
-- 
2.16.4
