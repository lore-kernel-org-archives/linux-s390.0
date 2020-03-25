Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbgCYJfS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:35:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9YrVd073933
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf3g48ge-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:35:11 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 11/11] s390/qeth: modernize two list helpers
Date: Wed, 25 Mar 2020 10:35:07 +0100
In-Reply-To: <20200325093507.20831-1-jwi@linux.ibm.com>
References: <20200325093507.20831-1-jwi@linux.ibm.com>
Message-Id: <20200325093507.20831-12-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Replace list_for_each() with list_for_each_entry(), and
list_entry(head.next) with list_first_entry().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8713f1b821c1..d06d9f847388 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2629,15 +2629,13 @@ static void qeth_initialize_working_pool_list(struct qeth_card *card)
 static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 					struct qeth_card *card)
 {
-	struct list_head *plh;
 	struct qeth_buffer_pool_entry *entry;
 	int i, free;
 
 	if (list_empty(&card->qdio.in_buf_pool.entry_list))
 		return NULL;
 
-	list_for_each(plh, &card->qdio.in_buf_pool.entry_list) {
-		entry = list_entry(plh, struct qeth_buffer_pool_entry, list);
+	list_for_each_entry(entry, &card->qdio.in_buf_pool.entry_list, list) {
 		free = 1;
 		for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
 			if (page_count(entry->elements[i]) > 1) {
@@ -2652,8 +2650,8 @@ static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 	}
 
 	/* no free buffer in pool so take first one and swap pages */
-	entry = list_entry(card->qdio.in_buf_pool.entry_list.next,
-			struct qeth_buffer_pool_entry, list);
+	entry = list_first_entry(&card->qdio.in_buf_pool.entry_list,
+				 struct qeth_buffer_pool_entry, list);
 	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
 		if (page_count(entry->elements[i]) > 1) {
 			struct page *page = dev_alloc_page();
-- 
2.17.1
