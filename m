From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/6] net/smc: make wait for work request uninterruptible
Date: Wed, 24 Jan 2018 10:28:15 +0100
Message-ID: <20180124092817.103089-5-ubraun@linux.vnet.ibm.com>
References: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Work requests are needed for every ib_post_send(), among them the
ib_post_send() to signal closing. If an smc socket program is cancelled,
the smc connections should be cleaned up, and require sending of closing
signals to the peer. This may fail, if a wait for
a free work request is needed, but is cancelled immediately due to the
cancel interrupt. To guarantee notification of the peer, the wait for
a work request is changed to uninterruptible.

And the area to receive work request completion info with
ib_poll_cq() is cleared first.
And _tx_ variable names are used in the _tx_routines for the
demultiplexing common type in the header.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_wr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index a4477b4a9c18..5ed94109d1d6 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -122,6 +122,7 @@ static void smc_wr_tx_tasklet_fn(unsigned long data)
 again:
 	polled++;
 	do {
+		memset(&wc, 0, sizeof(wc));
 		rc = ib_poll_cq(dev->roce_cq_send, SMC_WR_MAX_POLL_CQE, wc);
 		if (polled == 1) {
 			ib_req_notify_cq(dev->roce_cq_send,
@@ -185,7 +186,7 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 		if (rc)
 			return rc;
 	} else {
-		rc = wait_event_interruptible_timeout(
+		rc = wait_event_timeout(
 			link->wr_tx_wait,
 			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
 			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
@@ -198,8 +199,6 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 			smc_lgr_terminate(lgr);
 			return -EPIPE;
 		}
-		if (rc == -ERESTARTSYS)
-			return -EINTR;
 		if (idx == link->wr_tx_cnt)
 			return -EPIPE;
 	}
@@ -300,18 +299,18 @@ int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
 	return rc;
 }
 
-void smc_wr_tx_dismiss_slots(struct smc_link *link, u8 wr_rx_hdr_type,
+void smc_wr_tx_dismiss_slots(struct smc_link *link, u8 wr_tx_hdr_type,
 			     smc_wr_tx_filter filter,
 			     smc_wr_tx_dismisser dismisser,
 			     unsigned long data)
 {
 	struct smc_wr_tx_pend_priv *tx_pend;
-	struct smc_wr_rx_hdr *wr_rx;
+	struct smc_wr_rx_hdr *wr_tx;
 	int i;
 
 	for_each_set_bit(i, link->wr_tx_mask, link->wr_tx_cnt) {
-		wr_rx = (struct smc_wr_rx_hdr *)&link->wr_rx_bufs[i];
-		if (wr_rx->type != wr_rx_hdr_type)
+		wr_tx = (struct smc_wr_rx_hdr *)&link->wr_tx_bufs[i];
+		if (wr_tx->type != wr_tx_hdr_type)
 			continue;
 		tx_pend = &link->wr_tx_pends[i].priv;
 		if (filter(tx_pend, data))
-- 
2.13.5
