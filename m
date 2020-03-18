Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbgCRMzX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICXrqn004208
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7wcrwp3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:20 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/11] s390/qeth: use memory reserves in TX slow path
Date: Wed, 18 Mar 2020 13:54:46 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When falling back to an allocation from the HW header cache, check if
the skb is eligible for using memory reserves.
This only makes a difference if the cache is empty and needs to be
refilled.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 6 ++++--
 drivers/s390/net/qeth_l2_main.c   | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index be3f6295309b..767cef04c9d8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3705,6 +3705,7 @@ static int qeth_add_hw_header(struct qeth_qdio_out_q *queue,
 			      unsigned int hdr_len, unsigned int proto_len,
 			      unsigned int *elements)
 {
+	gfp_t gfp = GFP_ATOMIC | (skb_pfmemalloc(skb) ? __GFP_MEMALLOC : 0);
 	const unsigned int contiguous = proto_len ? proto_len : 1;
 	const unsigned int max_elements = queue->max_elements;
 	unsigned int __elements;
@@ -3760,10 +3761,11 @@ static int qeth_add_hw_header(struct qeth_qdio_out_q *queue,
 		*hdr = skb_push(skb, hdr_len);
 		return hdr_len;
 	}
-	/* fall back */
+
+	/* Fall back to cache element with known-good alignment: */
 	if (hdr_len + proto_len > QETH_HDR_CACHE_OBJ_SIZE)
 		return -E2BIG;
-	*hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
+	*hdr = kmem_cache_alloc(qeth_core_header_cache, gfp);
 	if (!*hdr)
 		return -ENOMEM;
 	/* Copy protocol headers behind HW header: */
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 4c8e93132e08..8ba4ac2a5b47 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -499,6 +499,7 @@ static void qeth_l2_rx_mode_work(struct work_struct *work)
 static int qeth_l2_xmit_osn(struct qeth_card *card, struct sk_buff *skb,
 			    struct qeth_qdio_out_q *queue)
 {
+	gfp_t gfp = GFP_ATOMIC | (skb_pfmemalloc(skb) ? __GFP_MEMALLOC : 0);
 	struct qeth_hdr *hdr = (struct qeth_hdr *)skb->data;
 	addr_t end = (addr_t)(skb->data + sizeof(*hdr));
 	addr_t start = (addr_t)skb->data;
@@ -511,7 +512,7 @@ static int qeth_l2_xmit_osn(struct qeth_card *card, struct sk_buff *skb,
 
 	if (qeth_get_elements_for_range(start, end) > 1) {
 		/* Misaligned HW header, move it to its own buffer element. */
-		hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
+		hdr = kmem_cache_alloc(qeth_core_header_cache, gfp);
 		if (!hdr)
 			return -ENOMEM;
 		hd_len = sizeof(*hdr);
-- 
2.17.1
