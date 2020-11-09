Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731881AbgKIPS3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 10:18:29 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v4 07/15] net/smc: Refactor the netlink reply processing routine
Date: Mon,  9 Nov 2020 16:18:06 +0100
Message-Id: <20201109151814.15040-8-kgraul@linux.ibm.com>
In-Reply-To: <20201109151814.15040-1-kgraul@linux.ibm.com>
References: <20201109151814.15040-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

Refactor the netlink reply processing routine so that
it provides sub functions for specific parts of the processing.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_diag.c | 218 +++++++++++++++++++++++++++------------------
 1 file changed, 133 insertions(+), 85 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index c2225231f679..44be723c97fe 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -69,35 +69,25 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 	}
 }
 
-static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
-				   struct smc_diag_msg *r,
-				   struct user_namespace *user_ns)
+static bool smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
+				    struct smc_diag_msg *r,
+				    struct user_namespace *user_ns)
 {
-	if (nla_put_u8(skb, SMC_DIAG_SHUTDOWN, sk->sk_shutdown))
-		return 1;
+	if (nla_put_u8(skb, SMC_DIAG_SHUTDOWN, sk->sk_shutdown) < 0)
+		return false;
 
 	r->diag_uid = from_kuid_munged(user_ns, sock_i_uid(sk));
 	r->diag_inode = sock_i_ino(sk);
-	return 0;
+	return true;
 }
 
-static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
-			   struct netlink_callback *cb,
-			   const struct smc_diag_req *req,
-			   struct nlattr *bc)
+static bool smc_diag_fill_base_struct(struct sock *sk, struct sk_buff *skb,
+				      struct netlink_callback *cb,
+				      struct smc_diag_msg *r)
 {
 	struct smc_sock *smc = smc_sk(sk);
-	struct smc_diag_fallback fallback;
 	struct user_namespace *user_ns;
-	struct smc_diag_msg *r;
-	struct nlmsghdr *nlh;
 
-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			cb->nlh->nlmsg_type, sizeof(*r), NLM_F_MULTI);
-	if (!nlh)
-		return -EMSGSIZE;
-
-	r = nlmsg_data(nlh);
 	smc_diag_msg_common_fill(r, sk);
 	r->diag_state = sk->sk_state;
 	if (smc->use_fallback)
@@ -107,89 +97,148 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	else
 		r->diag_mode = SMC_DIAG_MODE_SMCR;
 	user_ns = sk_user_ns(NETLINK_CB(cb->skb).sk);
-	if (smc_diag_msg_attrs_fill(sk, skb, r, user_ns))
-		goto errout;
+	if (!smc_diag_msg_attrs_fill(sk, skb, r, user_ns))
+		return false;
 
+	return true;
+}
+
+static bool smc_diag_fill_fallback(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_diag_fallback fallback;
+	struct smc_sock *smc = smc_sk(sk);
+
+	memset(&fallback, 0, sizeof(fallback));
 	fallback.reason = smc->fallback_rsn;
 	fallback.peer_diagnosis = smc->peer_diagnosis;
 	if (nla_put(skb, SMC_DIAG_FALLBACK, sizeof(fallback), &fallback) < 0)
+		return false;
+
+	return true;
+}
+
+static bool smc_diag_fill_conninfo(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_host_cdc_msg *local_tx, *local_rx;
+	struct smc_diag_conninfo cinfo;
+	struct smc_connection *conn;
+	struct smc_sock *smc;
+
+	smc = smc_sk(sk);
+	conn = &smc->conn;
+	local_tx = &conn->local_tx_ctrl;
+	local_rx = &conn->local_rx_ctrl;
+	memset(&cinfo, 0, sizeof(cinfo));
+	cinfo.token = conn->alert_token_local;
+	cinfo.sndbuf_size = conn->sndbuf_desc ? conn->sndbuf_desc->len : 0;
+	cinfo.rmbe_size = conn->rmb_desc ? conn->rmb_desc->len : 0;
+	cinfo.peer_rmbe_size = conn->peer_rmbe_size;
+
+	cinfo.rx_prod.wrap = local_rx->prod.wrap;
+	cinfo.rx_prod.count = local_rx->prod.count;
+	cinfo.rx_cons.wrap = local_rx->cons.wrap;
+	cinfo.rx_cons.count = local_rx->cons.count;
+
+	cinfo.tx_prod.wrap = local_tx->prod.wrap;
+	cinfo.tx_prod.count = local_tx->prod.count;
+	cinfo.tx_cons.wrap = local_tx->cons.wrap;
+	cinfo.tx_cons.count = local_tx->cons.count;
+
+	cinfo.tx_prod_flags = *(u8 *)&local_tx->prod_flags;
+	cinfo.tx_conn_state_flags = *(u8 *)&local_tx->conn_state_flags;
+	cinfo.rx_prod_flags = *(u8 *)&local_rx->prod_flags;
+	cinfo.rx_conn_state_flags = *(u8 *)&local_rx->conn_state_flags;
+
+	cinfo.tx_prep.wrap = conn->tx_curs_prep.wrap;
+	cinfo.tx_prep.count = conn->tx_curs_prep.count;
+	cinfo.tx_sent.wrap = conn->tx_curs_sent.wrap;
+	cinfo.tx_sent.count = conn->tx_curs_sent.count;
+	cinfo.tx_fin.wrap = conn->tx_curs_fin.wrap;
+	cinfo.tx_fin.count = conn->tx_curs_fin.count;
+
+	if (nla_put(skb, SMC_DIAG_CONNINFO, sizeof(cinfo), &cinfo) < 0)
+		return false;
+
+	return true;
+}
+
+static bool smc_diag_fill_lgrinfo(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	struct smc_diag_lgrinfo linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.role = smc->conn.lgr->role;
+	linfo.lnk[0].ibport = smc->conn.lnk->ibport;
+	linfo.lnk[0].link_id = smc->conn.lnk->link_id;
+	memcpy(linfo.lnk[0].ibname, smc->conn.lnk->ibname,
+	       sizeof(linfo.lnk[0].ibname));
+	smc_gid_be16_convert(linfo.lnk[0].gid,
+			     smc->conn.lnk->gid);
+	smc_gid_be16_convert(linfo.lnk[0].peer_gid,
+			     smc->conn.lnk->peer_gid);
+
+	if (nla_put(skb, SMC_DIAG_LGRINFO, sizeof(linfo), &linfo) < 0)
+		return false;
+
+	return true;
+}
+
+static bool smc_diag_fill_dmbinfo(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	struct smcd_diag_dmbinfo dinfo;
+	struct smc_connection *conn;
+
+	memset(&dinfo, 0, sizeof(dinfo));
+	conn = &smc->conn;
+	dinfo.linkid = *((u32 *)conn->lgr->id);
+	dinfo.peer_gid = conn->lgr->peer_gid;
+	dinfo.my_gid = conn->lgr->smcd->local_gid;
+	dinfo.token = conn->rmb_desc->token;
+	dinfo.peer_token = conn->peer_token;
+
+	if (nla_put(skb, SMC_DIAG_DMBINFO, sizeof(dinfo), &dinfo) < 0)
+		return false;
+	return true;
+}
+
+static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
+			   struct netlink_callback *cb,
+			   const struct smc_diag_req *req)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	struct smc_diag_msg *r;
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			cb->nlh->nlmsg_type, sizeof(*r), NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	r = nlmsg_data(nlh);
+	if (!smc_diag_fill_base_struct(sk, skb, cb, r))
+		goto errout;
+
+	if (!smc_diag_fill_fallback(sk, skb))
 		goto errout;
 
 	if ((req->diag_ext & (1 << (SMC_DIAG_CONNINFO - 1))) &&
 	    smc->conn.alert_token_local) {
-		struct smc_connection *conn = &smc->conn;
-		struct smc_diag_conninfo cinfo = {
-			.token = conn->alert_token_local,
-			.sndbuf_size = conn->sndbuf_desc ?
-				conn->sndbuf_desc->len : 0,
-			.rmbe_size = conn->rmb_desc ? conn->rmb_desc->len : 0,
-			.peer_rmbe_size = conn->peer_rmbe_size,
-
-			.rx_prod.wrap = conn->local_rx_ctrl.prod.wrap,
-			.rx_prod.count = conn->local_rx_ctrl.prod.count,
-			.rx_cons.wrap = conn->local_rx_ctrl.cons.wrap,
-			.rx_cons.count = conn->local_rx_ctrl.cons.count,
-
-			.tx_prod.wrap = conn->local_tx_ctrl.prod.wrap,
-			.tx_prod.count = conn->local_tx_ctrl.prod.count,
-			.tx_cons.wrap = conn->local_tx_ctrl.cons.wrap,
-			.tx_cons.count = conn->local_tx_ctrl.cons.count,
-
-			.tx_prod_flags =
-				*(u8 *)&conn->local_tx_ctrl.prod_flags,
-			.tx_conn_state_flags =
-				*(u8 *)&conn->local_tx_ctrl.conn_state_flags,
-			.rx_prod_flags = *(u8 *)&conn->local_rx_ctrl.prod_flags,
-			.rx_conn_state_flags =
-				*(u8 *)&conn->local_rx_ctrl.conn_state_flags,
-
-			.tx_prep.wrap = conn->tx_curs_prep.wrap,
-			.tx_prep.count = conn->tx_curs_prep.count,
-			.tx_sent.wrap = conn->tx_curs_sent.wrap,
-			.tx_sent.count = conn->tx_curs_sent.count,
-			.tx_fin.wrap = conn->tx_curs_fin.wrap,
-			.tx_fin.count = conn->tx_curs_fin.count,
-		};
-
-		if (nla_put(skb, SMC_DIAG_CONNINFO, sizeof(cinfo), &cinfo) < 0)
+		if (!smc_diag_fill_conninfo(sk, skb))
 			goto errout;
 	}
 
 	if (smc->conn.lgr && !smc->conn.lgr->is_smcd &&
 	    (req->diag_ext & (1 << (SMC_DIAG_LGRINFO - 1))) &&
 	    !list_empty(&smc->conn.lgr->list)) {
-		struct smc_diag_lgrinfo linfo = {
-			.role = smc->conn.lgr->role,
-			.lnk[0].ibport = smc->conn.lnk->ibport,
-			.lnk[0].link_id = smc->conn.lnk->link_id,
-		};
-
-		memcpy(linfo.lnk[0].ibname,
-		       smc->conn.lgr->lnk[0].smcibdev->ibdev->name,
-		       sizeof(smc->conn.lnk->smcibdev->ibdev->name));
-		smc_gid_be16_convert(linfo.lnk[0].gid,
-				     smc->conn.lnk->gid);
-		smc_gid_be16_convert(linfo.lnk[0].peer_gid,
-				     smc->conn.lnk->peer_gid);
-
-		if (nla_put(skb, SMC_DIAG_LGRINFO, sizeof(linfo), &linfo) < 0)
+		if (!smc_diag_fill_lgrinfo(sk, skb))
 			goto errout;
 	}
 	if (smc->conn.lgr && smc->conn.lgr->is_smcd &&
 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
 	    !list_empty(&smc->conn.lgr->list)) {
-		struct smc_connection *conn = &smc->conn;
-		struct smcd_diag_dmbinfo dinfo;
-
-		memset(&dinfo, 0, sizeof(dinfo));
-
-		dinfo.linkid = *((u32 *)conn->lgr->id);
-		dinfo.peer_gid = conn->lgr->peer_gid;
-		dinfo.my_gid = conn->lgr->smcd->local_gid;
-		dinfo.token = conn->rmb_desc->token;
-		dinfo.peer_token = conn->peer_token;
-
-		if (nla_put(skb, SMC_DIAG_DMBINFO, sizeof(dinfo), &dinfo) < 0)
+		if (!smc_diag_fill_dmbinfo(sk, skb))
 			goto errout;
 	}
 
@@ -207,7 +256,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
 	int snum = cb_ctx->pos[p_type];
-	struct nlattr *bc = NULL;
 	struct hlist_head *head;
 	int rc = 0, num = 0;
 	struct sock *sk;
@@ -222,7 +270,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 			continue;
 		if (num < snum)
 			goto next;
-		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
+		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
 		if (rc < 0)
 			goto out;
 next:
-- 
2.17.1
