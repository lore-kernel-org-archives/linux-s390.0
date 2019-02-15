Return-Path: <SRS0=4yje=QW=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/7] s390/qeth: use a static Output Queue array
Date: Fri, 15 Feb 2019 19:22:26 +0100
In-Reply-To: <20190215182231.90709-1-jwi@linux.ibm.com>
References: <20190215182231.90709-1-jwi@linux.ibm.com>
Message-Id: <20190215182231.90709-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth dynamically allocates an array for storing pointers to its
Output Queue structures. Switch this to a static array - we are
currently limited to 4 Output Queues, so shrinking the qeth_qdio_info
struct by just a few bytes doesn't justify the additional complexity.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 21 ++++++---------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 18696ffb662d..2ea5d7c0b94c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -528,7 +528,7 @@ struct qeth_qdio_info {
 
 	/* output */
 	int no_out_queues;
-	struct qeth_qdio_out_q **out_qs;
+	struct qeth_qdio_out_q *out_qs[QETH_MAX_QUEUES];
 	struct qdio_outbuf_state *out_bufstates;
 
 	/* priority queueing */
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5ca934775c42..d01a4aded4cc 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2433,12 +2433,6 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
 		goto out_freeinq;
 
 	/* outbound */
-	card->qdio.out_qs =
-		kcalloc(card->qdio.no_out_queues,
-			sizeof(struct qeth_qdio_out_q *),
-			GFP_KERNEL);
-	if (!card->qdio.out_qs)
-		goto out_freepool;
 	for (i = 0; i < card->qdio.no_out_queues; ++i) {
 		card->qdio.out_qs[i] = qeth_alloc_qdio_out_buf();
 		if (!card->qdio.out_qs[i])
@@ -2468,11 +2462,10 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
 		card->qdio.out_qs[i]->bufs[j] = NULL;
 	}
 out_freeoutq:
-	while (i > 0)
+	while (i > 0) {
 		qeth_free_output_queue(card->qdio.out_qs[--i]);
-	kfree(card->qdio.out_qs);
-	card->qdio.out_qs = NULL;
-out_freepool:
+		card->qdio.out_qs[i] = NULL;
+	}
 	qeth_free_buffer_pool(card);
 out_freeinq:
 	qeth_free_qdio_queue(card->qdio.in_q);
@@ -2501,11 +2494,9 @@ static void qeth_free_qdio_buffers(struct qeth_card *card)
 	/* inbound buffer pool */
 	qeth_free_buffer_pool(card);
 	/* free outbound qdio_qs */
-	if (card->qdio.out_qs) {
-		for (i = 0; i < card->qdio.no_out_queues; i++)
-			qeth_free_output_queue(card->qdio.out_qs[i]);
-		kfree(card->qdio.out_qs);
-		card->qdio.out_qs = NULL;
+	for (i = 0; i < card->qdio.no_out_queues; i++) {
+		qeth_free_output_queue(card->qdio.out_qs[i]);
+		card->qdio.out_qs[i] = NULL;
 	}
 }
 
-- 
2.16.4
