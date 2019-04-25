Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/8] s390/qeth: don't clear Output buffers on every queue init
Date: Thu, 25 Apr 2019 18:25:58 +0200
In-Reply-To: <20190425162601.91997-1-jwi@linux.ibm.com>
References: <20190425162601.91997-1-jwi@linux.ibm.com>
Message-Id: <20190425162601.91997-6-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On the first initialization of a queue, its Output Buffers are in a
clean state with no attached resources. On every subsequent
initialization, qeth_l?_stop_card() has previously put them in a clean
state via qeth_drain_output_queues(). So the call to
qeth_clear_output_buffer() is redundant and can be removed.

While at it, move the initialization of the queue's card pointer into
the queue allocation. It never changes afterwards.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index bdae99636dd4..5d8777c4d1a6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2386,6 +2386,7 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 			goto out_freeoutq;
 		QETH_DBF_TEXT_(SETUP, 2, "outq %i", i);
 		QETH_DBF_HEX(SETUP, 2, &card->qdio.out_qs[i], sizeof(void *));
+		card->qdio.out_qs[i]->card = card;
 		card->qdio.out_qs[i]->queue_no = i;
 		/* give outbound qeth_qdio_buffers their qdio_buffers */
 		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
@@ -2697,7 +2698,7 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 
 int qeth_init_qdio_queues(struct qeth_card *card)
 {
-	int i, j;
+	unsigned int i;
 	int rc;
 
 	QETH_DBF_TEXT(SETUP, 2, "initqdqs");
@@ -2728,11 +2729,6 @@ int qeth_init_qdio_queues(struct qeth_card *card)
 	for (i = 0; i < card->qdio.no_out_queues; ++i) {
 		qdio_reset_buffers(card->qdio.out_qs[i]->qdio_bufs,
 				   QDIO_MAX_BUFFERS_PER_Q);
-		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
-			qeth_clear_output_buffer(card->qdio.out_qs[i],
-						 card->qdio.out_qs[i]->bufs[j]);
-		}
-		card->qdio.out_qs[i]->card = card;
 		card->qdio.out_qs[i]->next_buf_to_fill = 0;
 		card->qdio.out_qs[i]->do_pack = 0;
 		atomic_set(&card->qdio.out_qs[i]->used_buffers, 0);
-- 
2.16.4
