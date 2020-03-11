Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35402 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730343AbgCKRHZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 13:07:25 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BH3a0P060173
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 13:07:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ypyphfrku-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 13:07:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 11 Mar 2020 17:07:19 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/3] s390/qeth: use page pointers to manage RX buffer pool
Date: Wed, 11 Mar 2020 18:07:09 +0100
In-Reply-To: <20200311170711.50376-1-jwi@linux.ibm.com>
References: <20200311170711.50376-1-jwi@linux.ibm.com>
Message-Id: <20200311170711.50376-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The RX buffer elements are always backed with full pages, reflect this
in the pointer type.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 35 +++++++++++++++----------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 9575a627a1e1..242b05f644eb 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -369,7 +369,7 @@ enum qeth_qdio_info_states {
 struct qeth_buffer_pool_entry {
 	struct list_head list;
 	struct list_head init_list;
-	void *elements[QDIO_MAX_ELEMENTS_PER_BUFFER];
+	struct page *elements[QDIO_MAX_ELEMENTS_PER_BUFFER];
 };
 
 struct qeth_qdio_buffer_pool {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a599801d7727..8f682fc178a9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -215,7 +215,6 @@ EXPORT_SYMBOL_GPL(qeth_clear_working_pool_list);
 static int qeth_alloc_buffer_pool(struct qeth_card *card)
 {
 	struct qeth_buffer_pool_entry *pool_entry;
-	void *ptr;
 	int i, j;
 
 	QETH_CARD_TEXT(card, 5, "alocpool");
@@ -225,17 +224,18 @@ static int qeth_alloc_buffer_pool(struct qeth_card *card)
 			qeth_free_buffer_pool(card);
 			return -ENOMEM;
 		}
+
 		for (j = 0; j < QETH_MAX_BUFFER_ELEMENTS(card); ++j) {
-			ptr = (void *) __get_free_page(GFP_KERNEL);
-			if (!ptr) {
+			struct page *page = alloc_page(GFP_KERNEL);
+
+			if (!page) {
 				while (j > 0)
-					free_page((unsigned long)
-						  pool_entry->elements[--j]);
+					__free_page(pool_entry->elements[--j]);
 				kfree(pool_entry);
 				qeth_free_buffer_pool(card);
 				return -ENOMEM;
 			}
-			pool_entry->elements[j] = ptr;
+			pool_entry->elements[j] = page;
 		}
 		list_add(&pool_entry->init_list,
 			 &card->qdio.init_pool.entry_list);
@@ -1177,7 +1177,7 @@ static void qeth_free_buffer_pool(struct qeth_card *card)
 	list_for_each_entry_safe(pool_entry, tmp,
 				 &card->qdio.init_pool.entry_list, init_list){
 		for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i)
-			free_page((unsigned long)pool_entry->elements[i]);
+			__free_page(pool_entry->elements[i]);
 		list_del(&pool_entry->init_list);
 		kfree(pool_entry);
 	}
@@ -2573,7 +2573,6 @@ static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 	struct list_head *plh;
 	struct qeth_buffer_pool_entry *entry;
 	int i, free;
-	struct page *page;
 
 	if (list_empty(&card->qdio.in_buf_pool.entry_list))
 		return NULL;
@@ -2582,7 +2581,7 @@ static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 		entry = list_entry(plh, struct qeth_buffer_pool_entry, list);
 		free = 1;
 		for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
-			if (page_count(virt_to_page(entry->elements[i])) > 1) {
+			if (page_count(entry->elements[i]) > 1) {
 				free = 0;
 				break;
 			}
@@ -2597,15 +2596,15 @@ static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 	entry = list_entry(card->qdio.in_buf_pool.entry_list.next,
 			struct qeth_buffer_pool_entry, list);
 	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
-		if (page_count(virt_to_page(entry->elements[i])) > 1) {
-			page = alloc_page(GFP_ATOMIC);
-			if (!page) {
+		if (page_count(entry->elements[i]) > 1) {
+			struct page *page = alloc_page(GFP_ATOMIC);
+
+			if (!page)
 				return NULL;
-			} else {
-				free_page((unsigned long)entry->elements[i]);
-				entry->elements[i] = page_address(page);
-				QETH_CARD_STAT_INC(card, rx_sg_alloc_page);
-			}
+
+			__free_page(entry->elements[i]);
+			entry->elements[i] = page;
+			QETH_CARD_STAT_INC(card, rx_sg_alloc_page);
 		}
 	}
 	list_del_init(&entry->list);
@@ -2641,7 +2640,7 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
 		buf->buffer->element[i].length = PAGE_SIZE;
 		buf->buffer->element[i].addr =
-			virt_to_phys(pool_entry->elements[i]);
+			page_to_phys(pool_entry->elements[i]);
 		if (i == QETH_MAX_BUFFER_ELEMENTS(card) - 1)
 			buf->buffer->element[i].eflags = SBAL_EFLAGS_LAST_ENTRY;
 		else
-- 
2.17.1
