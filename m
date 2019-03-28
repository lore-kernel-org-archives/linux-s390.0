Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/10] s390/qeth: let qeth_notify_reply() set the notify reason
Date: Thu, 28 Mar 2019 16:39:26 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-9-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As trivial cleanup before adding more users to qeth_notify_reply(),
move the setup of reply->rc from the caller into the helper.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 093464567025..fee787fbc1d4 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -577,8 +577,9 @@ static void qeth_dequeue_reply(struct qeth_card *card, struct qeth_reply *reply)
 	spin_unlock_irq(&card->lock);
 }
 
-static void qeth_notify_reply(struct qeth_reply *reply)
+static void qeth_notify_reply(struct qeth_reply *reply, int reason)
 {
+	reply->rc = reason;
 	complete(&reply->received);
 }
 
@@ -664,10 +665,8 @@ void qeth_clear_ipacmd_list(struct qeth_card *card)
 	QETH_CARD_TEXT(card, 4, "clipalst");
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(reply, &card->cmd_waiter_list, list) {
-		reply->rc = -EIO;
-		qeth_notify_reply(reply);
-	}
+	list_for_each_entry(reply, &card->cmd_waiter_list, list)
+		qeth_notify_reply(reply, -EIO);
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_ipacmd_list);
@@ -744,10 +743,8 @@ static void qeth_cancel_cmd(struct qeth_cmd_buffer *iob, int rc)
 {
 	struct qeth_reply *reply = iob->reply;
 
-	if (reply) {
-		reply->rc = rc;
-		qeth_notify_reply(reply);
-	}
+	if (reply)
+		qeth_notify_reply(reply, rc);
 	qeth_release_buffer(iob->channel, iob);
 }
 
@@ -847,11 +844,8 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 		}
 	}
 
-	if (rc <= 0) {
-		reply->rc = rc;
-		qeth_notify_reply(reply);
-	}
-
+	if (rc <= 0)
+		qeth_notify_reply(reply, rc);
 	qeth_put_reply(reply);
 
 out:
-- 
2.16.4
