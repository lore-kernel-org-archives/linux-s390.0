From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/9] s390/qeth: remove unused code in qdio_establish_cq()
Date: Mon, 18 Sep 2017 21:18:17 +0200
Message-ID: <20170918191822.65142-5-jwi@linux.vnet.ibm.com>
References: <20170918191822.65142-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170918191822.65142-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Storing the number of input buffers into 'i' has no effect, it is
immediately re-assigned in the next line.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index bae7440abc01..77032801e30b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4923,7 +4923,6 @@ static void qeth_qdio_establish_cq(struct qeth_card *card,
 	if (card->options.cq == QETH_CQ_ENABLED) {
 		int offset = QDIO_MAX_BUFFERS_PER_Q *
 			     (card->qdio.no_in_queues - 1);
-		i = QDIO_MAX_BUFFERS_PER_Q * (card->qdio.no_in_queues - 1);
 		for (i = 0; i < QDIO_MAX_BUFFERS_PER_Q; ++i) {
 			in_sbal_ptrs[offset + i] = (struct qdio_buffer *)
 				virt_to_phys(card->qdio.c_q->bufs[i].buffer);
-- 
2.13.5
