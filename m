Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 3/4] s390/qeth: lock read device while queueing next buffer
Date: Tue, 20 Mar 2018 07:59:14 +0100
In-Reply-To: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
References: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180320065915.62076-4-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

For calling ccw_device_start(), issue_next_read() needs to hold the
device's ccwlock.
This is satisfied for the IRQ handler path (where qeth_irq() gets called
under the ccwlock), but we need explicit locking for the initial call by
the MPC initialization.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 42ee8806fa53..2a9afaf8f264 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -527,8 +527,7 @@ static inline int qeth_is_cq(struct qeth_card *card, unsigned int queue)
 	    queue == card->qdio.no_in_queues - 1;
 }
 
-
-static int qeth_issue_next_read(struct qeth_card *card)
+static int __qeth_issue_next_read(struct qeth_card *card)
 {
 	int rc;
 	struct qeth_cmd_buffer *iob;
@@ -559,6 +558,17 @@ static int qeth_issue_next_read(struct qeth_card *card)
 	return rc;
 }
 
+static int qeth_issue_next_read(struct qeth_card *card)
+{
+	int ret;
+
+	spin_lock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+	ret = __qeth_issue_next_read(card);
+	spin_unlock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+
+	return ret;
+}
+
 static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 {
 	struct qeth_reply *reply;
@@ -1182,7 +1192,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		return;
 	if (channel == &card->read &&
 	    channel->state == CH_STATE_UP)
-		qeth_issue_next_read(card);
+		__qeth_issue_next_read(card);
 
 	iob = channel->iob;
 	index = channel->buf_no;
-- 
2.13.5
