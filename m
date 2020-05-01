Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728620AbgEAKsc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 06:48:32 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 10/13] net/smc: remove DELETE LINK processing from smc_core.c
Date: Fri,  1 May 2020 12:48:10 +0200
Message-Id: <20200501104813.76601-11-kgraul@linux.ibm.com>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Support for multiple links makes the former DELETE LINK processing
obsolete which sent one DELETE_LINK LLC message for each single link.
Remove this processing from smc_core.c.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 849ae3f9b796..60c708f6de51 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -202,20 +202,6 @@ void smc_lgr_cleanup_early(struct smc_connection *conn)
 	smc_lgr_schedule_free_work_fast(lgr);
 }
 
-/* Send delete link, either as client to request the initiation
- * of the DELETE LINK sequence from server; or as server to
- * initiate the delete processing. See smc_llc_rx_delete_link().
- */
-static int smcr_link_send_delete(struct smc_link *lnk, bool orderly)
-{
-	if (lnk->state == SMC_LNK_ACTIVE &&
-	    !smc_llc_send_delete_link(lnk, 0, SMC_LLC_REQ, orderly,
-				      SMC_LLC_DEL_PROG_INIT_TERM)) {
-		return 0;
-	}
-	return -ENOTCONN;
-}
-
 static void smc_lgr_free(struct smc_link_group *lgr);
 
 static void smc_lgr_free_work(struct work_struct *work)
@@ -241,25 +227,6 @@ static void smc_lgr_free_work(struct work_struct *work)
 		return;
 	}
 	list_del_init(&lgr->list); /* remove from smc_lgr_list */
-
-	if (!lgr->is_smcd && !lgr->terminating)	{
-		bool do_wait = false;
-
-		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-			struct smc_link *lnk = &lgr->lnk[i];
-			/* try to send del link msg, on err free immediately */
-			if (lnk->state == SMC_LNK_ACTIVE &&
-			    !smcr_link_send_delete(lnk, true)) {
-				/* reschedule in case we never receive a resp */
-				smc_lgr_schedule_free_work(lgr);
-				do_wait = true;
-			}
-		}
-		if (do_wait) {
-			spin_unlock_bh(lgr_lock);
-			return; /* wait for resp, see smc_llc_rx_delete_link */
-		}
-	}
 	lgr->freeing = 1; /* this instance does the freeing, no new schedule */
 	spin_unlock_bh(lgr_lock);
 	cancel_delayed_work(&lgr->free_work);
-- 
2.17.1
