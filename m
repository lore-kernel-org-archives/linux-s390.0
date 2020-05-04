Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728747AbgEDMTQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:16 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 10/12] net/smc: improve termination processing
Date: Mon,  4 May 2020 14:18:46 +0200
Message-Id: <20200504121848.46585-11-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Add helper smcr_lgr_link_deactivate_all() and eliminate duplicate code.
In smc_lgr_free(), clear the smc-r links before smc_lgr_free_bufs() is
called so buffers are already prepared for free. The usage of the soft
parameter in __smc_lgr_terminate() is no longer needed, smc_lgr_free()
can be called directly. smc_lgr_terminate_sched() and
smc_smcd_terminate() set lgr->freeing to indicate that the link group
will be freed soon to avoid unnecessary schedules of the free worker.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 61 +++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index b6f93b44f9c7..fb391bc6781e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -237,6 +237,19 @@ void smc_lgr_cleanup_early(struct smc_connection *conn)
 	smc_lgr_schedule_free_work_fast(lgr);
 }
 
+static void smcr_lgr_link_deactivate_all(struct smc_link_group *lgr)
+{
+	int i;
+
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+		struct smc_link *lnk = &lgr->lnk[i];
+
+		if (smc_link_usable(lnk))
+			lnk->state = SMC_LNK_INACTIVE;
+	}
+	wake_up_interruptible_all(&lgr->llc_waiter);
+}
+
 static void smc_lgr_free(struct smc_link_group *lgr);
 
 static void smc_lgr_free_work(struct work_struct *work)
@@ -246,7 +259,6 @@ static void smc_lgr_free_work(struct work_struct *work)
 						  free_work);
 	spinlock_t *lgr_lock;
 	bool conns;
-	int i;
 
 	smc_lgr_list_head(lgr, &lgr_lock);
 	spin_lock_bh(lgr_lock);
@@ -271,15 +283,8 @@ static void smc_lgr_free_work(struct work_struct *work)
 					     SMC_LLC_DEL_PROG_INIT_TERM);
 	if (lgr->is_smcd && !lgr->terminating)
 		smc_ism_signal_shutdown(lgr);
-	if (!lgr->is_smcd) {
-		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-			struct smc_link *lnk = &lgr->lnk[i];
-
-			if (smc_link_usable(lnk))
-				lnk->state = SMC_LNK_INACTIVE;
-		}
-		wake_up_interruptible_all(&lgr->llc_waiter);
-	}
+	if (!lgr->is_smcd)
+		smcr_lgr_link_deactivate_all(lgr);
 	smc_lgr_free(lgr);
 }
 
@@ -802,6 +807,16 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 {
 	int i;
 
+	if (!lgr->is_smcd) {
+		mutex_lock(&lgr->llc_conf_mutex);
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+			if (lgr->lnk[i].state != SMC_LNK_UNUSED)
+				smcr_link_clear(&lgr->lnk[i]);
+		}
+		mutex_unlock(&lgr->llc_conf_mutex);
+		smc_llc_lgr_clear(lgr);
+	}
+
 	smc_lgr_free_bufs(lgr);
 	if (lgr->is_smcd) {
 		if (!lgr->terminating) {
@@ -811,11 +826,6 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 		if (!atomic_dec_return(&lgr->smcd->lgr_cnt))
 			wake_up(&lgr->smcd->lgrs_deleted);
 	} else {
-		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-			if (lgr->lnk[i].state != SMC_LNK_UNUSED)
-				smcr_link_clear(&lgr->lnk[i]);
-		}
-		smc_llc_lgr_clear(lgr);
 		if (!atomic_dec_return(&lgr_cnt))
 			wake_up(&lgrs_deleted);
 	}
@@ -870,8 +880,6 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
 
 static void smc_lgr_cleanup(struct smc_link_group *lgr)
 {
-	int i;
-
 	if (lgr->is_smcd) {
 		smc_ism_signal_shutdown(lgr);
 		smcd_unregister_all_dmbs(lgr);
@@ -883,13 +891,7 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 		if (!rsn)
 			rsn = SMC_LLC_DEL_PROG_INIT_TERM;
 		smc_llc_send_link_delete_all(lgr, false, rsn);
-		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-			struct smc_link *lnk = &lgr->lnk[i];
-
-			if (smc_link_usable(lnk))
-				lnk->state = SMC_LNK_INACTIVE;
-		}
-		wake_up_interruptible_all(&lgr->llc_waiter);
+		smcr_lgr_link_deactivate_all(lgr);
 	}
 }
 
@@ -905,8 +907,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 
 	if (lgr->terminating)
 		return;	/* lgr already terminating */
-	if (!soft)
-		cancel_delayed_work_sync(&lgr->free_work);
+	/* cancel free_work sync, will terminate when lgr->freeing is set */
+	cancel_delayed_work_sync(&lgr->free_work);
 	lgr->terminating = 1;
 
 	/* kill remaining link group connections */
@@ -926,10 +928,7 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 	}
 	read_unlock_bh(&lgr->conns_lock);
 	smc_lgr_cleanup(lgr);
-	if (soft)
-		smc_lgr_schedule_free_work_fast(lgr);
-	else
-		smc_lgr_free(lgr);
+	smc_lgr_free(lgr);
 }
 
 /* unlink link group and schedule termination */
@@ -944,6 +943,7 @@ void smc_lgr_terminate_sched(struct smc_link_group *lgr)
 		return;	/* lgr already terminating */
 	}
 	list_del_init(&lgr->list);
+	lgr->freeing = 1;
 	spin_unlock_bh(lgr_lock);
 	schedule_work(&lgr->terminate_work);
 }
@@ -962,6 +962,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 			if (peer_gid) /* peer triggered termination */
 				lgr->peer_shutdown = 1;
 			list_move(&lgr->list, &lgr_free_list);
+			lgr->freeing = 1;
 		}
 	}
 	spin_unlock_bh(&dev->lgr_lock);
-- 
2.17.1
