Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404743AbfFKQiO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGR5af110028
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2em1vvna-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:13 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:10 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/13] s390/qeth: use mm helpers
Date: Tue, 11 Jun 2019 18:37:49 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Slightly reduce the complexity of the core xmit path, by replacing some
open-coded logic with the corresponding helpers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cd9e2f70d8f6..feb9e1c9d506 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -20,6 +20,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/mii.h>
+#include <linux/mm.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/if_vlan.h>
@@ -3723,8 +3724,8 @@ static int qeth_add_hw_header(struct qeth_qdio_out_q *queue,
 			__elements = 1 + qeth_count_elements(skb, proto_len);
 		else
 			__elements = qeth_count_elements(skb, 0);
-	} else if (!proto_len && qeth_get_elements_for_range(start, end) == 1) {
-		/* Push HW header into a new page. */
+	} else if (!proto_len && PAGE_ALIGNED(skb->data)) {
+		/* Push HW header into preceding page, flush with skb->data. */
 		push_ok = true;
 		__elements = 1 + qeth_count_elements(skb, 0);
 	} else {
@@ -3778,18 +3779,16 @@ static void __qeth_fill_buffer(struct sk_buff *skb,
 	int element = buf->next_element_to_fill;
 	int length = skb_headlen(skb) - offset;
 	char *data = skb->data + offset;
-	int length_here, cnt;
+	unsigned int elem_length, cnt;
 
 	/* map linear part into buffer element(s) */
 	while (length > 0) {
-		/* length_here is the remaining amount of data in this page */
-		length_here = PAGE_SIZE - ((unsigned long) data % PAGE_SIZE);
-		if (length < length_here)
-			length_here = length;
+		elem_length = min_t(unsigned int, length,
+				    PAGE_SIZE - offset_in_page(data));
 
 		buffer->element[element].addr = data;
-		buffer->element[element].length = length_here;
-		length -= length_here;
+		buffer->element[element].length = elem_length;
+		length -= elem_length;
 		if (is_first_elem) {
 			is_first_elem = false;
 			if (length || skb_is_nonlinear(skb))
@@ -3802,7 +3801,8 @@ static void __qeth_fill_buffer(struct sk_buff *skb,
 			buffer->element[element].eflags =
 				SBAL_EFLAGS_MIDDLE_FRAG;
 		}
-		data += length_here;
+
+		data += elem_length;
 		element++;
 	}
 
@@ -3813,17 +3813,16 @@ static void __qeth_fill_buffer(struct sk_buff *skb,
 		data = skb_frag_address(frag);
 		length = skb_frag_size(frag);
 		while (length > 0) {
-			length_here = PAGE_SIZE -
-				((unsigned long) data % PAGE_SIZE);
-			if (length < length_here)
-				length_here = length;
+			elem_length = min_t(unsigned int, length,
+					    PAGE_SIZE - offset_in_page(data));
 
 			buffer->element[element].addr = data;
-			buffer->element[element].length = length_here;
+			buffer->element[element].length = elem_length;
 			buffer->element[element].eflags =
 				SBAL_EFLAGS_MIDDLE_FRAG;
-			length -= length_here;
-			data += length_here;
+
+			length -= elem_length;
+			data += elem_length;
 			element++;
 		}
 	}
-- 
2.17.1
