Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730072AbgGHPFZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 11:05:25 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 2/5] net/smc: fix work request handling
Date: Wed,  8 Jul 2020 17:05:12 +0200
Message-Id: <20200708150515.44938-3-kgraul@linux.ibm.com>
In-Reply-To: <20200708150515.44938-1-kgraul@linux.ibm.com>
References: <20200708150515.44938-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Wait for pending sends only when smc_switch_conns() found a link to move
the connections to. Do not wait during link freeing, this can lead to
permanent hang situations. And refuse to provide a new tx slot on an
unusable link.

Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c |  8 ++++----
 net/smc/smc_wr.c  | 10 ++++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index df164232574b..c1a038689c63 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1241,8 +1241,8 @@ static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
 	smc_llc_send_message(lnk, &qentry->msg); /* response */
 
 	if (smc_link_downing(&lnk_del->state)) {
-		smc_switch_conns(lgr, lnk_del, false);
-		smc_wr_tx_wait_no_pending_sends(lnk_del);
+		if (smc_switch_conns(lgr, lnk_del, false))
+			smc_wr_tx_wait_no_pending_sends(lnk_del);
 	}
 	smcr_link_clear(lnk_del, true);
 
@@ -1316,8 +1316,8 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
 		goto out; /* asymmetric link already deleted */
 
 	if (smc_link_downing(&lnk_del->state)) {
-		smc_switch_conns(lgr, lnk_del, false);
-		smc_wr_tx_wait_no_pending_sends(lnk_del);
+		if (smc_switch_conns(lgr, lnk_del, false))
+			smc_wr_tx_wait_no_pending_sends(lnk_del);
 	}
 	if (!list_empty(&lgr->list)) {
 		/* qentry is either a request from peer (send it back to
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 7239ba9b99dc..1e23cdd41eb1 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -169,6 +169,8 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
 static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
 {
 	*idx = link->wr_tx_cnt;
+	if (!smc_link_usable(link))
+		return -ENOLINK;
 	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
 		if (!test_and_set_bit(*idx, link->wr_tx_mask))
 			return 0;
@@ -560,15 +562,15 @@ void smc_wr_free_link(struct smc_link *lnk)
 {
 	struct ib_device *ibdev;
 
+	if (!lnk->smcibdev)
+		return;
+	ibdev = lnk->smcibdev->ibdev;
+
 	if (smc_wr_tx_wait_no_pending_sends(lnk))
 		memset(lnk->wr_tx_mask, 0,
 		       BITS_TO_LONGS(SMC_WR_BUF_CNT) *
 						sizeof(*lnk->wr_tx_mask));
 
-	if (!lnk->smcibdev)
-		return;
-	ibdev = lnk->smcibdev->ibdev;
-
 	if (lnk->wr_rx_dma_addr) {
 		ib_dma_unmap_single(ibdev, lnk->wr_rx_dma_addr,
 				    SMC_WR_BUF_SIZE * lnk->wr_rx_cnt,
-- 
2.17.1
