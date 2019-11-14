Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 6/8] net/smc: abnormal termination without orderly flag
Date: Thu, 14 Nov 2019 13:02:45 +0100
In-Reply-To: <20191114120247.68889-1-kgraul@linux.ibm.com>
References: <20191114120247.68889-1-kgraul@linux.ibm.com>
Message-Id: <20191114120247.68889-7-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

For abnormal termination issue an LLC DELETE_LINK without the
orderly flag.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 30854acb846c..ee44e8244d0c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -161,10 +161,10 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
  * of the DELETE LINK sequence from server; or as server to
  * initiate the delete processing. See smc_llc_rx_delete_link().
  */
-static int smc_link_send_delete(struct smc_link *lnk)
+static int smc_link_send_delete(struct smc_link *lnk, bool orderly)
 {
 	if (lnk->state == SMC_LNK_ACTIVE &&
-	    !smc_llc_send_delete_link(lnk, SMC_LLC_REQ, true)) {
+	    !smc_llc_send_delete_link(lnk, SMC_LLC_REQ, orderly)) {
 		smc_llc_link_deleting(lnk);
 		return 0;
 	}
@@ -201,7 +201,7 @@ static void smc_lgr_free_work(struct work_struct *work)
 	if (!lgr->is_smcd && !lgr->terminating)	{
 		/* try to send del link msg, on error free lgr immediately */
 		if (lnk->state == SMC_LNK_ACTIVE &&
-		    !smc_link_send_delete(lnk)) {
+		    !smc_link_send_delete(lnk, true)) {
 			/* reschedule in case we never receive a response */
 			smc_lgr_schedule_free_work(lgr);
 			spin_unlock_bh(lgr_lock);
@@ -1233,9 +1233,7 @@ static void smc_lgrs_shutdown(void)
 		if (!lgr->is_smcd) {
 			struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
 
-			if (lnk->state == SMC_LNK_ACTIVE)
-				smc_llc_send_delete_link(lnk, SMC_LLC_REQ,
-							 false);
+			smc_link_send_delete(&lgr->lnk[SMC_SINGLE_LINK], false);
 			smc_llc_link_inactive(lnk);
 		}
 		cancel_delayed_work_sync(&lgr->free_work);
-- 
2.17.1
