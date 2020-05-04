Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728686AbgEDMTP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:15 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 07/12] net/smc: assign link to a new connection
Date: Mon,  4 May 2020 14:18:43 +0200
Message-Id: <20200504121848.46585-8-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

For new connections, assign a link from the link group, using some
simple load balancing.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 65 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 8f630b76c5a4..9c19b9aa3719 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -121,16 +121,59 @@ static void smc_lgr_add_alert_token(struct smc_connection *conn)
 	rb_insert_color(&conn->alert_node, &conn->lgr->conns_all);
 }
 
+/* assign an SMC-R link to the connection */
+static int smcr_lgr_conn_assign_link(struct smc_connection *conn, bool first)
+{
+	enum smc_link_state expected = first ? SMC_LNK_ACTIVATING :
+				       SMC_LNK_ACTIVE;
+	int i, j;
+
+	/* do link balancing */
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+		struct smc_link *lnk = &conn->lgr->lnk[i];
+
+		if (lnk->state != expected)
+			continue;
+		if (conn->lgr->role == SMC_CLNT) {
+			conn->lnk = lnk; /* temporary, SMC server assigns link*/
+			break;
+		}
+		if (conn->lgr->conns_num % 2) {
+			for (j = i + 1; j < SMC_LINKS_PER_LGR_MAX; j++) {
+				struct smc_link *lnk2;
+
+				lnk2 = &conn->lgr->lnk[j];
+				if (lnk2->state == expected) {
+					conn->lnk = lnk2;
+					break;
+				}
+			}
+		}
+		if (!conn->lnk)
+			conn->lnk = lnk;
+		break;
+	}
+	if (!conn->lnk)
+		return SMC_CLC_DECL_NOACTLINK;
+	return 0;
+}
+
 /* Register connection in link group by assigning an alert token
  * registered in a search tree.
  * Requires @conns_lock
  * Note that '0' is a reserved value and not assigned.
  */
-static int smc_lgr_register_conn(struct smc_connection *conn)
+static int smc_lgr_register_conn(struct smc_connection *conn, bool first)
 {
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	static atomic_t nexttoken = ATOMIC_INIT(0);
+	int rc;
 
+	if (!conn->lgr->is_smcd) {
+		rc = smcr_lgr_conn_assign_link(conn, first);
+		if (rc)
+			return rc;
+	}
 	/* find a new alert_token_local value not yet used by some connection
 	 * in this link group
 	 */
@@ -141,22 +184,6 @@ static int smc_lgr_register_conn(struct smc_connection *conn)
 			conn->alert_token_local = 0;
 	}
 	smc_lgr_add_alert_token(conn);
-
-	/* assign the new connection to a link */
-	if (!conn->lgr->is_smcd) {
-		struct smc_link *lnk;
-		int i;
-
-		/* tbd - link balancing */
-		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-			lnk = &conn->lgr->lnk[i];
-			if (lnk->state == SMC_LNK_ACTIVATING ||
-			    lnk->state == SMC_LNK_ACTIVE)
-				conn->lnk = lnk;
-		}
-		if (!conn->lnk)
-			return SMC_CLC_DECL_NOACTLINK;
-	}
 	conn->lgr->conns_num++;
 	return 0;
 }
@@ -1285,7 +1312,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 			/* link group found */
 			ini->cln_first_contact = SMC_REUSE_CONTACT;
 			conn->lgr = lgr;
-			rc = smc_lgr_register_conn(conn); /* add conn to lgr */
+			rc = smc_lgr_register_conn(conn, false);
 			write_unlock_bh(&lgr->conns_lock);
 			if (!rc && delayed_work_pending(&lgr->free_work))
 				cancel_delayed_work(&lgr->free_work);
@@ -1313,7 +1340,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 			goto out;
 		lgr = conn->lgr;
 		write_lock_bh(&lgr->conns_lock);
-		rc = smc_lgr_register_conn(conn); /* add smc conn to lgr */
+		rc = smc_lgr_register_conn(conn, true);
 		write_unlock_bh(&lgr->conns_lock);
 		if (rc)
 			goto out;
-- 
2.17.1
