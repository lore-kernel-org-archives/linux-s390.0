Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730167AbgCKRHX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 13:07:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BH0DIa027887
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 13:07:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yq04rs8hb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 13:07:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 11 Mar 2020 17:07:20 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/3] s390/qeth: refactor buffer pool code
Date: Wed, 11 Mar 2020 18:07:10 +0100
In-Reply-To: <20200311170711.50376-1-jwi@linux.ibm.com>
References: <20200311170711.50376-1-jwi@linux.ibm.com>
Message-Id: <20200311170711.50376-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

In preparation for a subsequent fix, split out helpers to allocate/free
individual pool entries.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 83 +++++++++++++++++++------------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8f682fc178a9..ceab3d0c4dfa 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -65,7 +65,6 @@ static struct lock_class_key qdio_out_skb_queue_key;
 static void qeth_issue_next_read_cb(struct qeth_card *card,
 				    struct qeth_cmd_buffer *iob,
 				    unsigned int data_length);
-static void qeth_free_buffer_pool(struct qeth_card *);
 static int qeth_qdio_establish(struct qeth_card *);
 static void qeth_free_qdio_queues(struct qeth_card *card);
 static void qeth_notify_skbs(struct qeth_qdio_out_q *queue,
@@ -212,33 +211,66 @@ void qeth_clear_working_pool_list(struct qeth_card *card)
 }
 EXPORT_SYMBOL_GPL(qeth_clear_working_pool_list);
 
+static void qeth_free_pool_entry(struct qeth_buffer_pool_entry *entry)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(entry->elements); i++) {
+		if (entry->elements[i])
+			__free_page(entry->elements[i]);
+	}
+
+	kfree(entry);
+}
+
+static void qeth_free_buffer_pool(struct qeth_card *card)
+{
+	struct qeth_buffer_pool_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &card->qdio.init_pool.entry_list,
+				 init_list) {
+		list_del(&entry->init_list);
+		qeth_free_pool_entry(entry);
+	}
+}
+
+static struct qeth_buffer_pool_entry *qeth_alloc_pool_entry(unsigned int pages)
+{
+	struct qeth_buffer_pool_entry *entry;
+	unsigned int i;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	for (i = 0; i < pages; i++) {
+		entry->elements[i] = alloc_page(GFP_KERNEL);
+
+		if (!entry->elements[i]) {
+			qeth_free_pool_entry(entry);
+			return NULL;
+		}
+	}
+
+	return entry;
+}
+
 static int qeth_alloc_buffer_pool(struct qeth_card *card)
 {
-	struct qeth_buffer_pool_entry *pool_entry;
-	int i, j;
+	unsigned int buf_elements = QETH_MAX_BUFFER_ELEMENTS(card);
+	unsigned int i;
 
 	QETH_CARD_TEXT(card, 5, "alocpool");
 	for (i = 0; i < card->qdio.init_pool.buf_count; ++i) {
-		pool_entry = kzalloc(sizeof(*pool_entry), GFP_KERNEL);
-		if (!pool_entry) {
+		struct qeth_buffer_pool_entry *entry;
+
+		entry = qeth_alloc_pool_entry(buf_elements);
+		if (!entry) {
 			qeth_free_buffer_pool(card);
 			return -ENOMEM;
 		}
 
-		for (j = 0; j < QETH_MAX_BUFFER_ELEMENTS(card); ++j) {
-			struct page *page = alloc_page(GFP_KERNEL);
-
-			if (!page) {
-				while (j > 0)
-					__free_page(pool_entry->elements[--j]);
-				kfree(pool_entry);
-				qeth_free_buffer_pool(card);
-				return -ENOMEM;
-			}
-			pool_entry->elements[j] = page;
-		}
-		list_add(&pool_entry->init_list,
-			 &card->qdio.init_pool.entry_list);
+		list_add(&entry->init_list, &card->qdio.init_pool.entry_list);
 	}
 	return 0;
 }
@@ -1170,19 +1202,6 @@ void qeth_drain_output_queues(struct qeth_card *card)
 }
 EXPORT_SYMBOL_GPL(qeth_drain_output_queues);
 
-static void qeth_free_buffer_pool(struct qeth_card *card)
-{
-	struct qeth_buffer_pool_entry *pool_entry, *tmp;
-	int i = 0;
-	list_for_each_entry_safe(pool_entry, tmp,
-				 &card->qdio.init_pool.entry_list, init_list){
-		for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i)
-			__free_page(pool_entry->elements[i]);
-		list_del(&pool_entry->init_list);
-		kfree(pool_entry);
-	}
-}
-
 static int qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 {
 	unsigned int count = single ? 1 : card->dev->num_tx_queues;
-- 
2.17.1
