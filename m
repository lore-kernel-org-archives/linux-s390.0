Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgLGNNZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 08:13:25 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/6] s390/qeth: don't call INIT_LIST_HEAD() on iob's list entry
Date: Mon,  7 Dec 2020 14:12:28 +0100
Message-Id: <20201207131233.90383-2-jwi@linux.ibm.com>
In-Reply-To: <20201207131233.90383-1-jwi@linux.ibm.com>
References: <20201207131233.90383-1-jwi@linux.ibm.com>
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
index 0e9af2fbaa76..69b474f8735e 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -624,7 +624,7 @@ struct qeth_reply {
 };
 
 struct qeth_cmd_buffer {
-	struct list_head list;
+	struct list_head list_entry;
 	struct completion done;
 	spinlock_t lock;
 	unsigned int length;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 319190824cd2..8171b9d3a70e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -615,7 +615,7 @@ static void qeth_enqueue_cmd(struct qeth_card *card,
 			     struct qeth_cmd_buffer *iob)
 {
 	spin_lock_irq(&card->lock);
-	list_add_tail(&iob->list, &card->cmd_waiter_list);
+	list_add_tail(&iob->list_entry, &card->cmd_waiter_list);
 	spin_unlock_irq(&card->lock);
 }
 
@@ -623,7 +623,7 @@ static void qeth_dequeue_cmd(struct qeth_card *card,
 			     struct qeth_cmd_buffer *iob)
 {
 	spin_lock_irq(&card->lock);
-	list_del(&iob->list);
+	list_del(&iob->list_entry);
 	spin_unlock_irq(&card->lock);
 }
 
@@ -977,7 +977,7 @@ static void qeth_clear_ipacmd_list(struct qeth_card *card)
 	QETH_CARD_TEXT(card, 4, "clipalst");
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(iob, &card->cmd_waiter_list, list)
+	list_for_each_entry(iob, &card->cmd_waiter_list, list_entry)
 		qeth_notify_cmd(iob, -ECANCELED);
 	spin_unlock_irqrestore(&card->lock, flags);
 }
@@ -1047,7 +1047,6 @@ struct qeth_cmd_buffer *qeth_alloc_cmd(struct qeth_channel *channel,
 
 	init_completion(&iob->done);
 	spin_lock_init(&iob->lock);
-	INIT_LIST_HEAD(&iob->list);
 	refcount_set(&iob->ref_count, 1);
 	iob->channel = channel;
 	iob->timeout = timeout;
@@ -1094,7 +1093,7 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 
 	/* match against pending cmd requests */
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(tmp, &card->cmd_waiter_list, list) {
+	list_for_each_entry(tmp, &card->cmd_waiter_list, list_entry) {
 		if (tmp->match && tmp->match(tmp, iob)) {
 			request = tmp;
 			/* take the object outside the lock */
-- 
2.17.1
