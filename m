Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgIJQtV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:21 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 07/10] net/smc: immediate freeing in smc_lgr_cleanup_early()
Date: Thu, 10 Sep 2020 18:48:26 +0200
Message-Id: <20200910164829.65426-8-kgraul@linux.ibm.com>
In-Reply-To: <20200910164829.65426-1-kgraul@linux.ibm.com>
References: <20200910164829.65426-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

smc_lgr_cleanup_early() schedules the free worker with delay. DMB
unregistering occurs in this delayed worker increasing the risk
to reach the SMCD SBA limit without need. Terminate the
linkgroup immediately, since termination means early DMB unregistering.

For SMCD the global smc_server_lgr_pending lock is given up early.
A linkgroup to be given up with smc_lgr_cleanup_early() may already
contain more than one connection. Using __smc_lgr_terminate() in
smc_lgr_cleanup_early() covers this.

And consolidate smc_ism_put_vlan() and smc_put_device() into smc_lgr_free()
only.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 23 ++++-------------------
 net/smc/smc_core.h |  1 -
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 0c6dfca7f0c7..e8711830d69e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -34,7 +34,6 @@
 #define SMC_LGR_NUM_INCR		256
 #define SMC_LGR_FREE_DELAY_SERV		(600 * HZ)
 #define SMC_LGR_FREE_DELAY_CLNT		(SMC_LGR_FREE_DELAY_SERV + 10 * HZ)
-#define SMC_LGR_FREE_DELAY_FAST		(8 * HZ)
 
 static struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 	.lock = __SPIN_LOCK_UNLOCKED(smc_lgr_list.lock),
@@ -70,7 +69,7 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 	 * creation. For client use a somewhat higher removal delay time,
 	 * otherwise there is a risk of out-of-sync link groups.
 	 */
-	if (!lgr->freeing && !lgr->freefast) {
+	if (!lgr->freeing) {
 		mod_delayed_work(system_wq, &lgr->free_work,
 				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
 						SMC_LGR_FREE_DELAY_CLNT :
@@ -78,15 +77,6 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 	}
 }
 
-void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr)
-{
-	if (!lgr->freeing && !lgr->freefast) {
-		lgr->freefast = 1;
-		mod_delayed_work(system_wq, &lgr->free_work,
-				 SMC_LGR_FREE_DELAY_FAST);
-	}
-}
-
 /* Register connection's alert token in our lookup structure.
  * To use rbtrees we have to implement our own insert core.
  * Requires @conns_lock
@@ -227,7 +217,7 @@ void smc_lgr_cleanup_early(struct smc_connection *conn)
 	if (!list_empty(lgr_list))
 		list_del_init(lgr_list);
 	spin_unlock_bh(lgr_lock);
-	smc_lgr_schedule_free_work_fast(lgr);
+	__smc_lgr_terminate(lgr, true);
 }
 
 static void smcr_lgr_link_deactivate_all(struct smc_link_group *lgr)
@@ -399,7 +389,6 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr->is_smcd = ini->is_smcd;
 	lgr->sync_err = 0;
 	lgr->terminating = 0;
-	lgr->freefast = 0;
 	lgr->freeing = 0;
 	lgr->vlan_id = ini->vlan_id;
 	mutex_init(&lgr->sndbufs_lock);
@@ -825,10 +814,8 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 
 	smc_lgr_free_bufs(lgr);
 	if (lgr->is_smcd) {
-		if (!lgr->terminating) {
-			smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
-			put_device(&lgr->smcd->dev);
-		}
+		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
+		put_device(&lgr->smcd->dev);
 		if (!atomic_dec_return(&lgr->smcd->lgr_cnt))
 			wake_up(&lgr->smcd->lgrs_deleted);
 	} else {
@@ -889,8 +876,6 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 	if (lgr->is_smcd) {
 		smc_ism_signal_shutdown(lgr);
 		smcd_unregister_all_dmbs(lgr);
-		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
-		put_device(&lgr->smcd->dev);
 	} else {
 		u32 rsn = lgr->llc_termination_rsn;
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d70da797f495..3fe985d6f4cd 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -227,7 +227,6 @@ struct smc_link_group {
 	struct work_struct	terminate_work;	/* abnormal lgr termination */
 	u8			sync_err : 1;	/* lgr no longer fits to peer */
 	u8			terminating : 1;/* lgr is terminating */
-	u8			freefast : 1;	/* free worker scheduled fast */
 	u8			freeing : 1;	/* lgr is being freed */
 
 	bool			is_smcd;	/* SMC-R or SMC-D */
-- 
2.17.1
