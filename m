Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbgCRUzq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:46 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 30/37] s390/qeth: handle error when backing RX buffer
Date: Wed, 18 Mar 2020 16:55:02 -0400
Message-Id: <20200318205509.17053-30-sashal@kernel.org>
In-Reply-To: <20200318205509.17053-1-sashal@kernel.org>
References: <20200318205509.17053-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 17413852804d7e86e6f0576cca32c1541817800e ]

qeth_init_qdio_queues() fills the RX ring with an initial set of
RX buffers. If qeth_init_input_buffer() fails to back one of the RX
buffers with memory, we need to bail out and report the error.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d99bfbfcafb76..5f59e2dfc7db9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2811,12 +2811,12 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 		buf->rx_skb = netdev_alloc_skb(card->dev,
 					       QETH_RX_PULL_LEN + ETH_HLEN);
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
@@ -2848,10 +2848,15 @@ int qeth_init_qdio_queues(struct qeth_card *card)
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
2.20.1
