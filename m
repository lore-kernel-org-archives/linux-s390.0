Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 09/13] net/smc: simplify link deactivation
Date: Wed, 29 Apr 2020 17:10:45 +0200
Message-Id: <20200429151049.49979-10-kgraul@linux.ibm.com>
In-Reply-To: <20200429151049.49979-1-kgraul@linux.ibm.com>
References: <20200429151049.49979-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Cancel the testlink worker during link clear processing and remove the
extra function smc_llc_link_inactive().

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c |  8 ++------
 net/smc/smc_llc.c  | 15 ++++-----------
 net/smc/smc_llc.h  |  1 -
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 57890cbd4e8a..78ccfbf6e4af 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -261,7 +261,7 @@ static void smc_lgr_free_work(struct work_struct *work)
 			struct smc_link *lnk = &lgr->lnk[i];
 
 			if (smc_link_usable(lnk))
-				smc_llc_link_inactive(lnk);
+				lnk->state = SMC_LNK_INACTIVE;
 		}
 	}
 	smc_lgr_free(lgr);
@@ -692,7 +692,7 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 			struct smc_link *lnk = &lgr->lnk[i];
 
 			if (smc_link_usable(lnk))
-				smc_llc_link_inactive(lnk);
+				lnk->state = SMC_LNK_INACTIVE;
 		}
 	}
 }
@@ -706,16 +706,12 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 	struct smc_connection *conn;
 	struct smc_sock *smc;
 	struct rb_node *node;
-	int i;
 
 	if (lgr->terminating)
 		return;	/* lgr already terminating */
 	if (!soft)
 		cancel_delayed_work_sync(&lgr->free_work);
 	lgr->terminating = 1;
-	if (!lgr->is_smcd)
-		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++)
-			smc_llc_link_inactive(&lgr->lnk[i]);
 
 	/* kill remaining link group connections */
 	read_lock_bh(&lgr->conns_lock);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 69cc0d65b437..2f03131c85fd 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -660,22 +660,15 @@ void smc_llc_link_deleting(struct smc_link *link)
 	smc_wr_wakeup_tx_wait(link);
 }
 
-/* called in tasklet context */
-void smc_llc_link_inactive(struct smc_link *link)
-{
-	if (link->state == SMC_LNK_INACTIVE)
-		return;
-	link->state = SMC_LNK_INACTIVE;
-	cancel_delayed_work_sync(&link->llc_testlink_wrk);
-	smc_wr_wakeup_reg_wait(link);
-	smc_wr_wakeup_tx_wait(link);
-}
-
 /* called in worker context */
 void smc_llc_link_clear(struct smc_link *link)
 {
 	flush_workqueue(link->llc_wq);
 	destroy_workqueue(link->llc_wq);
+	complete(&link->llc_testlink_resp);
+	cancel_delayed_work_sync(&link->llc_testlink_wrk);
+	smc_wr_wakeup_reg_wait(link);
+	smc_wr_wakeup_tx_wait(link);
 }
 
 /* register a new rtoken at the remote peer */
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 08171131110c..c2c9d48d079f 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -56,7 +56,6 @@ int smc_llc_send_delete_link(struct smc_link *link,
 int smc_llc_link_init(struct smc_link *link);
 void smc_llc_link_active(struct smc_link *link, int testlink_time);
 void smc_llc_link_deleting(struct smc_link *link);
-void smc_llc_link_inactive(struct smc_link *link);
 void smc_llc_link_clear(struct smc_link *link);
 int smc_llc_do_confirm_rkey(struct smc_link *link,
 			    struct smc_buf_desc *rmb_desc);
-- 
2.17.1
