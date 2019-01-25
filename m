Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/8] s390/qeth: remove bogus netif_wake_queue()
Date: Fri, 25 Jan 2019 15:44:17 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_qdio_cq_handler() doesn't replenish the Output Queue(s), and thus
has no reason to wake the txq.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index e08b924f7454..f784d5c528a9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3558,8 +3558,6 @@ static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
 	card->qdio.c_q->next_buf_to_init = (card->qdio.c_q->next_buf_to_init
 				   + count) % QDIO_MAX_BUFFERS_PER_Q;
 
-	netif_wake_queue(card->dev);
-
 	if (card->options.performance_stats) {
 		int delta_t = qeth_get_micros();
 		delta_t -= card->perf_stats.cq_start_time;
-- 
2.16.4
