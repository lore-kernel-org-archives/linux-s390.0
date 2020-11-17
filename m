Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbgKQQPe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 11:15:34 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/9] s390/qeth: don't call INIT_LIST_HEAD() on iob's list entry
Date: Tue, 17 Nov 2020 17:15:12 +0100
Message-Id: <20201117161520.1089-2-jwi@linux.ibm.com>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

INIT_LIST_HEAD() only needs to be called on actual list heads.
While at it clarify the naming of the field.

Suggested-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 2 +-
 drivers/s390/net/qeth_core_main.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f73b4756ed5e..ec4525bd62e1 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -621,7 +621,7 @@ struct qeth_reply {
 };
 
 struct qeth_cmd_buffer {
-	struct list_head list;
+	struct list_head list_entry;
 	struct completion done;
 	spinlock_t lock;
 	unsigned int length;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 93c9b30ab17a..67e5c46e8373 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -609,7 +609,7 @@ static void qeth_enqueue_cmd(struct qeth_card *card,
 			     struct qeth_cmd_buffer *iob)
 {
 	spin_lock_irq(&card->lock);
-	list_add_tail(&iob->list, &card->cmd_waiter_list);
+	list_add_tail(&iob->list_entry, &card->cmd_waiter_list);
 	spin_unlock_irq(&card->lock);
 }
 
@@ -617,7 +617,7 @@ static void qeth_dequeue_cmd(struct qeth_card *card,
 			     struct qeth_cmd_buffer *iob)
 {
 	spin_lock_irq(&card->lock);
-	list_del(&iob->list);
+	list_del(&iob->list_entry);
 	spin_unlock_irq(&card->lock);
 }
 
@@ -971,7 +971,7 @@ static void qeth_clear_ipacmd_list(struct qeth_card *card)
 	QETH_CARD_TEXT(card, 4, "clipalst");
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(iob, &card->cmd_waiter_list, list)
+	list_for_each_entry(iob, &card->cmd_waiter_list, list_entry)
 		qeth_notify_cmd(iob, -ECANCELED);
 	spin_unlock_irqrestore(&card->lock, flags);
 }
@@ -1041,7 +1041,6 @@ struct qeth_cmd_buffer *qeth_alloc_cmd(struct qeth_channel *channel,
 
 	init_completion(&iob->done);
 	spin_lock_init(&iob->lock);
-	INIT_LIST_HEAD(&iob->list);
 	refcount_set(&iob->ref_count, 1);
 	iob->channel = channel;
 	iob->timeout = timeout;
@@ -1088,7 +1087,7 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 
 	/* match against pending cmd requests */
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(tmp, &card->cmd_waiter_list, list) {
+	list_for_each_entry(tmp, &card->cmd_waiter_list, list_entry) {
 		if (tmp->match && tmp->match(tmp, iob)) {
 			request = tmp;
 			/* take the object outside the lock */
-- 
2.17.1
