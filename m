Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 09/13] net/smc: take link down instead of terminating the link group
Date: Fri,  1 May 2020 12:48:09 +0200
Message-Id: <20200501104813.76601-10-kgraul@linux.ibm.com>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Use the introduced link down processing in all places where the link
group is terminated and take down the affected link only.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c |  7 ++-----
 net/smc/smc_llc.c  |  4 ++--
 net/smc/smc_tx.c   |  2 +-
 net/smc/smc_wr.c   | 19 ++++++++-----------
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 62108e0cd529..849ae3f9b796 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -884,11 +884,8 @@ void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 	} else {
 		list_for_each_entry_safe(lgr, lg, &smc_lgr_list.list, list) {
 			for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-				if (lgr->lnk[i].smcibdev == smcibdev) {
-					list_move(&lgr->list, &lgr_free_list);
-					lgr->freeing = 1;
-					break;
-				}
+				if (lgr->lnk[i].smcibdev == smcibdev)
+					smcr_link_down_cond_sched(&lgr->lnk[i]);
 			}
 		}
 	}
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index ceed3c89926f..e478a4c11877 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -556,7 +556,7 @@ static void smc_llc_rx_delete_link(struct smc_link *link,
 		smc_llc_send_delete_link(link, 0, SMC_LLC_RESP, true,
 					 SMC_LLC_DEL_PROG_INIT_TERM);
 	}
-	smc_lgr_terminate_sched(lgr);
+	smcr_link_down_cond(link);
 }
 
 /* process a confirm_rkey request from peer, remote flow */
@@ -831,7 +831,7 @@ static void smc_llc_testlink_work(struct work_struct *work)
 	if (link->state != SMC_LNK_ACTIVE)
 		return;		/* link state changed */
 	if (rc <= 0) {
-		smc_lgr_terminate_sched(smc_get_lgr(link));
+		smcr_link_down_cond_sched(link);
 		return;
 	}
 	next_interval = link->llc_testlink_time;
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index d74bfe6a90f1..417204572a69 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -283,7 +283,7 @@ static int smc_tx_rdma_write(struct smc_connection *conn, int peer_rmbe_offset,
 	rdma_wr->rkey = lgr->rtokens[conn->rtoken_idx][link->link_idx].rkey;
 	rc = ib_post_send(link->roce_qp, &rdma_wr->wr, NULL);
 	if (rc)
-		smc_lgr_terminate_sched(lgr);
+		smcr_link_down_cond_sched(link);
 	return rc;
 }
 
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 93223628c002..031e6c9561b1 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -120,8 +120,8 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 			       sizeof(link->wr_tx_bufs[i]));
 			clear_bit(i, link->wr_tx_mask);
 		}
-		/* terminate connections of this link group abnormally */
-		smc_lgr_terminate_sched(smc_get_lgr(link));
+		/* terminate link */
+		smcr_link_down_cond_sched(link);
 	}
 	if (pnd_snd.handler)
 		pnd_snd.handler(&pnd_snd.priv, link, wc->status);
@@ -212,8 +212,8 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
 			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
 		if (!rc) {
-			/* timeout - terminate connections */
-			smc_lgr_terminate_sched(lgr);
+			/* timeout - terminate link */
+			smcr_link_down_cond_sched(link);
 			return -EPIPE;
 		}
 		if (idx == link->wr_tx_cnt)
@@ -270,7 +270,7 @@ int smc_wr_tx_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv)
 	rc = ib_post_send(link->roce_qp, &link->wr_tx_ibs[pend->idx], NULL);
 	if (rc) {
 		smc_wr_tx_put_slot(link, priv);
-		smc_lgr_terminate_sched(smc_get_lgr(link));
+		smcr_link_down_cond_sched(link);
 	}
 	return rc;
 }
@@ -294,8 +294,8 @@ int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
 					      (link->wr_reg_state != POSTED),
 					      SMC_WR_REG_MR_WAIT_TIME);
 	if (!rc) {
-		/* timeout - terminate connections */
-		smc_lgr_terminate_sched(smc_get_lgr(link));
+		/* timeout - terminate link */
+		smcr_link_down_cond_sched(link);
 		return -EPIPE;
 	}
 	if (rc == -ERESTARTSYS)
@@ -393,10 +393,7 @@ static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
 			case IB_WC_RETRY_EXC_ERR:
 			case IB_WC_RNR_RETRY_EXC_ERR:
 			case IB_WC_WR_FLUSH_ERR:
-				/* terminate connections of this link group
-				 * abnormally
-				 */
-				smc_lgr_terminate_sched(smc_get_lgr(link));
+				smcr_link_down_cond_sched(link);
 				break;
 			default:
 				smc_wr_rx_post(link); /* refill WR RX */
-- 
2.17.1
