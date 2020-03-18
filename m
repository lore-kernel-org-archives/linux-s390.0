Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2617 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbgCRMzX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICWlhx093609
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:22 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu98t60jn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:22 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:20 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/11] s390/qeth: use memory reserves to back RX buffers
Date: Wed, 18 Mar 2020 13:54:45 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Use dev_alloc_page() for backing the RX buffers with pages. This way we
pick up __GFP_MEMALLOC.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6caa78d51bd1..be3f6295309b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -244,7 +244,7 @@ static struct qeth_buffer_pool_entry *qeth_alloc_pool_entry(unsigned int pages)
 		return NULL;
 
 	for (i = 0; i < pages; i++) {
-		entry->elements[i] = alloc_page(GFP_KERNEL);
+		entry->elements[i] = __dev_alloc_page(GFP_KERNEL);
 
 		if (!entry->elements[i]) {
 			qeth_free_pool_entry(entry);
@@ -2654,7 +2654,7 @@ static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 			struct qeth_buffer_pool_entry, list);
 	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
 		if (page_count(entry->elements[i]) > 1) {
-			struct page *page = alloc_page(GFP_ATOMIC);
+			struct page *page = dev_alloc_page();
 
 			if (!page)
 				return NULL;
-- 
2.17.1
