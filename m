From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 05/10] net/smc: move link llc initialization to llc layer
Date: Tue, 15 May 2018 17:04:58 +0200
Message-ID: <20180515150503.47265-6-ubraun@linux.ibm.com>
References: <20180515150503.47265-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515150503.47265-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Move the llc layer specific initialization and cleanup out of smc_core.c
into smc_llc.c (smc_llc_link_init and smc_llc_link_clear). Move all
initialization of a link into the new init function.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c |  6 +-----
 net/smc/smc_llc.c  | 11 ++++++++++-
 net/smc/smc_llc.h  |  1 +
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 29ae077b0ec9..ba7dae819ac8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -194,6 +194,7 @@ static int smc_lgr_create(struct smc_sock *smc,
 		smc_ib_setup_per_ibdev(smcibdev);
 	get_random_bytes(rndvec, sizeof(rndvec));
 	lnk->psn_initial = rndvec[0] + (rndvec[1] << 8) + (rndvec[2] << 16);
+	smc_llc_link_init(lnk);
 	rc = smc_wr_alloc_link_mem(lnk);
 	if (rc)
 		goto free_lgr;
@@ -206,11 +207,6 @@ static int smc_lgr_create(struct smc_sock *smc,
 	rc = smc_wr_create_link(lnk);
 	if (rc)
 		goto destroy_qp;
-	init_completion(&lnk->llc_confirm);
-	init_completion(&lnk->llc_confirm_resp);
-	init_completion(&lnk->llc_add);
-	init_completion(&lnk->llc_add_resp);
-	init_completion(&lnk->llc_confirm_rkey);
 
 	smc->conn.lgr = lgr;
 	rwlock_init(&lgr->conns_lock);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 229e967c7940..5dbeced6cea5 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -562,10 +562,19 @@ static void smc_llc_testlink_work(struct work_struct *work)
 	schedule_delayed_work(&link->llc_testlink_wrk, next_interval);
 }
 
-void smc_llc_link_active(struct smc_link *link, int testlink_time)
+void smc_llc_link_init(struct smc_link *link)
 {
+	init_completion(&link->llc_confirm);
+	init_completion(&link->llc_confirm_resp);
+	init_completion(&link->llc_add);
+	init_completion(&link->llc_add_resp);
+	init_completion(&link->llc_confirm_rkey);
 	init_completion(&link->llc_testlink_resp);
 	INIT_DELAYED_WORK(&link->llc_testlink_wrk, smc_llc_testlink_work);
+}
+
+void smc_llc_link_active(struct smc_link *link, int testlink_time)
+{
 	link->state = SMC_LNK_ACTIVE;
 	if (testlink_time) {
 		link->llc_testlink_time = testlink_time * HZ;
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index fb137f24aa6b..d7f52a60c8d6 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -42,6 +42,7 @@ int smc_llc_send_add_link(struct smc_link *link, u8 mac[], union ib_gid *gid,
 			  enum smc_llc_reqresp reqresp);
 int smc_llc_send_delete_link(struct smc_link *link,
 			     enum smc_llc_reqresp reqresp);
+void smc_llc_link_init(struct smc_link *link);
 void smc_llc_link_active(struct smc_link *link, int testlink_time);
 void smc_llc_link_inactive(struct smc_link *link);
 void smc_llc_link_flush(struct smc_link *link);
-- 
2.16.3
