Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728842AbfJUONa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Oct 2019 10:13:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9LEDKpZ059839
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vsbkn7erf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:29 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Mon, 21 Oct 2019 15:13:27 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 6/8] net/smc: improve abnormal termination of link groups
Date: Mon, 21 Oct 2019 16:13:13 +0200
In-Reply-To: <20191021141315.58969-1-kgraul@linux.ibm.com>
References: <20191021141315.58969-1-kgraul@linux.ibm.com>
Message-Id: <20191021141315.58969-7-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

If a link group and its connections must be terminated,
* wake up socket waiters
* do not enable buffer reuse

A linkgroup might be terminated while normal connection closing
is running. Avoid buffer reuse and its related LLC DELETE RKEY
call, if linkgroup termination has started. And use the earliest
indication of linkgroup termination possible, namely the removal
from the linkgroup list.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 494288f32df6..6faaa38412b1 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -154,6 +154,7 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 		__smc_lgr_unregister_conn(conn);
 	}
 	write_unlock_bh(&lgr->conns_lock);
+	conn->lgr = NULL;
 }
 
 /* Send delete link, either as client to request the initiation
@@ -344,7 +345,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
 		conn->sndbuf_desc->used = 0;
 	if (conn->rmb_desc) {
 		if (!conn->rmb_desc->regerr) {
-			if (!lgr->is_smcd) {
+			if (!lgr->is_smcd && !list_empty(&lgr->list)) {
 				/* unregister rmb with peer */
 				smc_llc_do_delete_rkey(
 						&lgr->lnk[SMC_SINGLE_LINK],
@@ -375,9 +376,10 @@ void smc_conn_free(struct smc_connection *conn)
 	} else {
 		smc_cdc_tx_dismiss_slots(conn);
 	}
-	smc_lgr_unregister_conn(conn);
-	smc_buf_unuse(conn, lgr);		/* allow buffer reuse */
-	conn->lgr = NULL;
+	if (!list_empty(&lgr->list)) {
+		smc_lgr_unregister_conn(conn);
+		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
+	}
 
 	if (!lgr->conns_num)
 		smc_lgr_schedule_free_work(lgr);
@@ -491,6 +493,28 @@ void smc_lgr_forget(struct smc_link_group *lgr)
 	spin_unlock_bh(lgr_lock);
 }
 
+static void smc_sk_wake_ups(struct smc_sock *smc)
+{
+	smc->sk.sk_write_space(&smc->sk);
+	smc->sk.sk_data_ready(&smc->sk);
+	smc->sk.sk_state_change(&smc->sk);
+}
+
+/* kill a connection */
+static void smc_conn_kill(struct smc_connection *conn)
+{
+	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
+
+	smc_close_abort(conn);
+	conn->killed = 1;
+	smc_sk_wake_ups(smc);
+	smc_lgr_unregister_conn(conn);
+	smc->sk.sk_err = ECONNABORTED;
+	sock_hold(&smc->sk); /* sock_put in close work */
+	if (!schedule_work(&conn->close_work))
+		sock_put(&smc->sk);
+}
+
 /* terminate link group */
 static void __smc_lgr_terminate(struct smc_link_group *lgr)
 {
@@ -512,13 +536,7 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 		conn = rb_entry(node, struct smc_connection, alert_node);
 		smc = container_of(conn, struct smc_sock, conn);
 		lock_sock(&smc->sk);
-		sock_hold(&smc->sk); /* sock_put in close work */
-		smc_close_abort(conn);
-		conn->killed = 1;
-		smc_lgr_unregister_conn(conn);
-		conn->lgr = NULL;
-		if (!schedule_work(&conn->close_work))
-			sock_put(&smc->sk);
+		smc_conn_kill(conn);
 		release_sock(&smc->sk);
 		read_lock_bh(&lgr->conns_lock);
 		node = rb_first(&lgr->conns_all);
-- 
2.17.1
