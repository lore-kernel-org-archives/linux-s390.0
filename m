Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 08/12] net/smc: asymmetric link tagging
Date: Mon,  4 May 2020 14:18:44 +0200
Message-Id: <20200504121848.46585-9-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

New connections must not be assigned to asymmetric links. Add asymmetric
link tagging using new link variable link_is_asym. The new helpers
smcr_lgr_set_type() and smcr_lgr_set_type_asym() are called to set the
state of the link group, and tag all links accordingly.
smcr_lgr_conn_assign_link() respects the link tagging and will not
assign new connections to links tagged as asymmetric link.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 26 +++++++++++++++++++++++---
 net/smc/smc_core.h |  4 ++++
 net/smc/smc_llc.c  | 20 ++++++++++++++------
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9c19b9aa3719..be15b30a1234 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -132,7 +132,7 @@ static int smcr_lgr_conn_assign_link(struct smc_connection *conn, bool first)
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 		struct smc_link *lnk = &conn->lgr->lnk[i];
 
-		if (lnk->state != expected)
+		if (lnk->state != expected || lnk->link_is_asym)
 			continue;
 		if (conn->lgr->role == SMC_CLNT) {
 			conn->lnk = lnk; /* temporary, SMC server assigns link*/
@@ -143,7 +143,8 @@ static int smcr_lgr_conn_assign_link(struct smc_connection *conn, bool first)
 				struct smc_link *lnk2;
 
 				lnk2 = &conn->lgr->lnk[j];
-				if (lnk2->state == expected) {
+				if (lnk2->state == expected &&
+				    !lnk2->link_is_asym) {
 					conn->lnk = lnk2;
 					break;
 				}
@@ -1030,6 +1031,25 @@ void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 	}
 }
 
+/* set new lgr type and clear all asymmetric link tagging */
+void smcr_lgr_set_type(struct smc_link_group *lgr, enum smc_lgr_type new_type)
+{
+	int i;
+
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++)
+		if (smc_link_usable(&lgr->lnk[i]))
+			lgr->lnk[i].link_is_asym = false;
+	lgr->type = new_type;
+}
+
+/* set new lgr type and tag a link as asymmetric */
+void smcr_lgr_set_type_asym(struct smc_link_group *lgr,
+			    enum smc_lgr_type new_type, int asym_lnk_idx)
+{
+	smcr_lgr_set_type(lgr, new_type);
+	lgr->lnk[asym_lnk_idx].link_is_asym = true;
+}
+
 /* abort connection, abort_work scheduled from tasklet context */
 static void smc_conn_abort_work(struct work_struct *work)
 {
@@ -1123,7 +1143,7 @@ static void smcr_link_down(struct smc_link *lnk)
 		smcr_link_clear(lnk);
 		return;
 	}
-	lgr->type = SMC_LGR_SINGLE;
+	smcr_lgr_set_type(lgr, SMC_LGR_SINGLE);
 	del_link_id = lnk->link_id;
 
 	if (lgr->role == SMC_SERV) {
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 86eebbadc8f6..6ed7ab6d89d5 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -117,6 +117,7 @@ struct smc_link {
 	u8			peer_gid[SMC_GID_SIZE];	/* gid of peer*/
 	u8			link_id;	/* unique # within link group */
 	u8			link_idx;	/* index in lgr link array */
+	u8			link_is_asym;	/* is link asymmetric? */
 	struct smc_link_group	*lgr;		/* parent link group */
 	struct work_struct	link_down_wrk;	/* wrk to bring link down */
 
@@ -380,6 +381,9 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 void smcr_link_clear(struct smc_link *lnk);
 int smcr_buf_map_lgr(struct smc_link *lnk);
 int smcr_buf_reg_lgr(struct smc_link *lnk);
+void smcr_lgr_set_type(struct smc_link_group *lgr, enum smc_lgr_type new_type);
+void smcr_lgr_set_type_asym(struct smc_link_group *lgr,
+			    enum smc_lgr_type new_type, int asym_lnk_idx);
 int smcr_link_reg_rmb(struct smc_link *link, struct smc_buf_desc *rmb_desc);
 struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 				  struct smc_link *from_lnk, bool is_dev_err);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 0ea7ad6188ae..f65b2aac6b52 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -796,7 +796,11 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 		return -ENOLINK;
 	}
 	smc_llc_link_active(link_new);
-	lgr->type = lgr_new_t;
+	if (lgr_new_t == SMC_LGR_ASYMMETRIC_LOCAL ||
+	    lgr_new_t == SMC_LGR_ASYMMETRIC_PEER)
+		smcr_lgr_set_type_asym(lgr, lgr_new_t, link_new->link_idx);
+	else
+		smcr_lgr_set_type(lgr, lgr_new_t);
 	return 0;
 }
 
@@ -1038,7 +1042,11 @@ static int smc_llc_srv_conf_link(struct smc_link *link,
 		return -ENOLINK;
 	}
 	smc_llc_link_active(link_new);
-	lgr->type = lgr_new_t;
+	if (lgr_new_t == SMC_LGR_ASYMMETRIC_LOCAL ||
+	    lgr_new_t == SMC_LGR_ASYMMETRIC_PEER)
+		smcr_lgr_set_type_asym(lgr, lgr_new_t, link_new->link_idx);
+	else
+		smcr_lgr_set_type(lgr, lgr_new_t);
 	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 	return 0;
 }
@@ -1223,9 +1231,9 @@ static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
 	if (lnk_del == lnk_asym) {
 		/* expected deletion of asym link, don't change lgr state */
 	} else if (active_links == 1) {
-		lgr->type = SMC_LGR_SINGLE;
+		smcr_lgr_set_type(lgr, SMC_LGR_SINGLE);
 	} else if (!active_links) {
-		lgr->type = SMC_LGR_NONE;
+		smcr_lgr_set_type(lgr, SMC_LGR_NONE);
 		smc_lgr_terminate_sched(lgr);
 	}
 out_unlock:
@@ -1314,9 +1322,9 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
 
 	active_links = smc_llc_active_link_count(lgr);
 	if (active_links == 1) {
-		lgr->type = SMC_LGR_SINGLE;
+		smcr_lgr_set_type(lgr, SMC_LGR_SINGLE);
 	} else if (!active_links) {
-		lgr->type = SMC_LGR_NONE;
+		smcr_lgr_set_type(lgr, SMC_LGR_NONE);
 		smc_lgr_terminate_sched(lgr);
 	}
 
-- 
2.17.1
