Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgCJRiL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 13:38:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AHY8Cg084223
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 13:38:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8k92d8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 13:38:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 10 Mar 2020 17:38:07 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/3] s390/qeth: handle error when backing RX buffer
Date: Tue, 10 Mar 2020 18:38:02 +0100
In-Reply-To: <20200310173803.91602-1-jwi@linux.ibm.com>
References: <20200310173803.91602-1-jwi@linux.ibm.com>
Message-Id: <20200310173803.91602-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_init_qdio_queues() fills the RX ring with an initial set of
RX buffers. If qeth_init_input_buffer() fails to back one of the RX
buffers with memory, we need to bail out and report the error.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 2a05d13a0e79..d8f0c610396e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2624,12 +2624,12 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 					       ETH_HLEN +
 					       sizeof(struct ipv6hdr));
 		if (!buf->rx_skb)
-			return 1;
+			return -ENOMEM;
 	}
 
 	pool_entry = qeth_find_free_buffer_pool_entry(card);
 	if (!pool_entry)
-		return 1;
+		return -ENOBUFS;
 
 	/*
 	 * since the buffer is accessed only from the input_tasklet
@@ -2674,10 +2674,15 @@ static int qeth_init_qdio_queues(struct qeth_card *card)
 	/* inbound queue */
 	qdio_reset_buffers(card->qdio.in_q->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
 	memset(&card->rx, 0, sizeof(struct qeth_rx));
+
 	qeth_initialize_working_pool_list(card);
 	/*give only as many buffers to hardware as we have buffer pool entries*/
-	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; ++i)
-		qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
+	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; i++) {
+		rc = qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
+		if (rc)
+			return rc;
+	}
+
 	card->qdio.in_q->next_buf_to_init =
 		card->qdio.in_buf_pool.buf_count - 1;
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,
-- 
2.17.1
