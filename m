Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404101AbgKXRvP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 12:51:15 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v5 11/14] net/smc: Introduce SMCR get link command
Date: Tue, 24 Nov 2020 18:50:44 +0100
Message-Id: <20201124175047.56949-12-kgraul@linux.ibm.com>
In-Reply-To: <20201124175047.56949-1-kgraul@linux.ibm.com>
References: <20201124175047.56949-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

Introduce get link command which loops through
all available links of all available link groups. It
uses the SMC-R linkgroup list as entry point, not
the socket list, which makes linkgroup diagnosis
possible, in case linkgroup does not contain active
connections anymore.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc.h | 18 ++++++++
 net/smc/smc_core.c       | 92 +++++++++++++++++++++++++++++++++++++---
 net/smc/smc_core.h       | 14 ++++++
 net/smc/smc_diag.c       | 13 ------
 net/smc/smc_netlink.c    |  7 +++
 5 files changed, 126 insertions(+), 18 deletions(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 3ae8ca4e5256..ed638dbfff08 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -41,6 +41,7 @@ enum {				/* SMC PNET Table commands */
 enum {
 	SMC_NETLINK_GET_SYS_INFO = 1,
 	SMC_NETLINK_GET_LGR_SMCR,
+	SMC_NETLINK_GET_LINK_SMCR,
 };
 
 /* SMC_GENL_FAMILY top level attributes */
@@ -48,6 +49,7 @@ enum {
 	SMC_GEN_UNSPEC,
 	SMC_GEN_SYS_INFO,		/* nest */
 	SMC_GEN_LGR_SMCR,		/* nest */
+	SMC_GEN_LINK_SMCR,		/* nest */
 	__SMC_GEN_MAX,
 	SMC_GEN_MAX = __SMC_GEN_MAX - 1
 };
@@ -77,4 +79,20 @@ enum {
 	SMC_NLA_LGR_R_MAX = __SMC_NLA_LGR_R_MAX - 1
 };
 
+/* SMC_GEN_LINK_SMCR attributes */
+enum {
+	SMC_NLA_LINK_UNSPEC,
+	SMC_NLA_LINK_ID,		/* u8 */
+	SMC_NLA_LINK_IB_DEV,		/* string */
+	SMC_NLA_LINK_IB_PORT,		/* u8 */
+	SMC_NLA_LINK_GID,		/* string */
+	SMC_NLA_LINK_PEER_GID,		/* string */
+	SMC_NLA_LINK_CONN_CNT,		/* u32 */
+	SMC_NLA_LINK_NET_DEV,		/* u32 */
+	SMC_NLA_LINK_UID,		/* u32 */
+	SMC_NLA_LINK_PEER_UID,		/* u32 */
+	SMC_NLA_LINK_STATE,		/* u32 */
+	__SMC_NLA_LINK_MAX,
+	SMC_NLA_LINK_MAX = __SMC_NLA_LINK_MAX - 1
+};
 #endif /* _UAPI_LINUX_SMC_H */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 02ad03fd1108..1273fb29c365 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -312,11 +312,73 @@ static int smc_nl_fill_lgr(struct smc_link_group *lgr,
 	return -EMSGSIZE;
 }
 
+static int smc_nl_fill_lgr_link(struct smc_link_group *lgr,
+				struct smc_link *link,
+				struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	char smc_ibname[IB_DEVICE_NAME_MAX + 1];
+	u8 smc_gid_target[40];
+	struct nlattr *attrs;
+	u32 link_uid = 0;
+	void *nlh;
+
+	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &smc_gen_nl_family, NLM_F_MULTI,
+			  SMC_NETLINK_GET_LINK_SMCR);
+	if (!nlh)
+		goto errout;
+
+	attrs = nla_nest_start_noflag(skb, SMC_GEN_LINK_SMCR);
+	if (!attrs)
+		goto errout;
+
+	if (nla_put_u8(skb, SMC_NLA_LINK_ID, link->link_id) < 0)
+		goto errattr;
+	if (nla_put_u32(skb, SMC_NLA_LINK_STATE, link->state) < 0)
+		goto errattr;
+	if (nla_put_u32(skb, SMC_NLA_LINK_CONN_CNT,
+			atomic_read(&link->conn_cnt)) < 0)
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_LINK_IB_PORT, link->ibport) < 0)
+		goto errattr;
+	if (nla_put_u32(skb, SMC_NLA_LINK_NET_DEV, link->ndev_ifidx) < 0)
+		goto errattr;
+	memset(smc_ibname, 0, sizeof(smc_ibname));
+	snprintf(smc_ibname, sizeof(smc_ibname), "%s", link->ibname);
+	if (nla_put_string(skb, SMC_NLA_LINK_IB_DEV, smc_ibname) < 0)
+		goto errattr;
+	memcpy(&link_uid, link->link_uid, sizeof(link_uid));
+	if (nla_put_u32(skb, SMC_NLA_LINK_UID, link_uid) < 0)
+		goto errattr;
+	memcpy(&link_uid, link->peer_link_uid, sizeof(link_uid));
+	if (nla_put_u32(skb, SMC_NLA_LINK_PEER_UID, link_uid) < 0)
+		goto errattr;
+	memset(smc_gid_target, 0, sizeof(smc_gid_target));
+	smc_gid_be16_convert(smc_gid_target, link->gid);
+	if (nla_put_string(skb, SMC_NLA_LINK_GID, smc_gid_target) < 0)
+		goto errattr;
+	memset(smc_gid_target, 0, sizeof(smc_gid_target));
+	smc_gid_be16_convert(smc_gid_target, link->peer_gid);
+	if (nla_put_string(skb, SMC_NLA_LINK_PEER_GID, smc_gid_target) < 0)
+		goto errattr;
+
+	nla_nest_end(skb, attrs);
+	genlmsg_end(skb, nlh);
+	return 0;
+errattr:
+	nla_nest_cancel(skb, attrs);
+errout:
+	genlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
 static int smc_nl_handle_lgr(struct smc_link_group *lgr,
 			     struct sk_buff *skb,
-			     struct netlink_callback *cb)
+			     struct netlink_callback *cb,
+			     bool list_links)
 {
-	int rc = 0;
+	int i, rc = 0;
 	void *nlh;
 
 	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
@@ -329,6 +391,15 @@ static int smc_nl_handle_lgr(struct smc_link_group *lgr,
 		goto errout;
 
 	genlmsg_end(skb, nlh);
+	if (!list_links)
+		return rc;
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+		if (!smc_link_usable(&lgr->lnk[i]))
+			continue;
+		rc = smc_nl_fill_lgr_link(lgr, &lgr->lnk[i], skb, cb);
+		if (rc < 0)
+			goto errout;
+	}
 	return rc;
 
 errout:
@@ -338,7 +409,8 @@ static int smc_nl_handle_lgr(struct smc_link_group *lgr,
 
 static void smc_nl_fill_lgr_list(struct smc_lgr_list *smc_lgr,
 				 struct sk_buff *skb,
-				 struct netlink_callback *cb)
+				 struct netlink_callback *cb,
+				 bool list_links)
 {
 	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
 	struct smc_link_group *lgr;
@@ -349,7 +421,7 @@ static void smc_nl_fill_lgr_list(struct smc_lgr_list *smc_lgr,
 	list_for_each_entry(lgr, &smc_lgr->list, list) {
 		if (num < snum)
 			goto next;
-		if (smc_nl_handle_lgr(lgr, skb, cb) < 0)
+		if (smc_nl_handle_lgr(lgr, skb, cb, list_links) < 0)
 			goto errout;
 next:
 		num++;
@@ -361,7 +433,17 @@ static void smc_nl_fill_lgr_list(struct smc_lgr_list *smc_lgr,
 
 int smcr_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	smc_nl_fill_lgr_list(&smc_lgr_list, skb, cb);
+	bool list_links = false;
+
+	smc_nl_fill_lgr_list(&smc_lgr_list, skb, cb, list_links);
+	return skb->len;
+}
+
+int smcr_nl_get_link(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	bool list_links = true;
+
+	smc_nl_fill_lgr_list(&smc_lgr_list, skb, cb, list_links);
 	return skb->len;
 }
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 662315beb605..7995621f318d 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -367,6 +367,19 @@ static inline bool smc_link_active(struct smc_link *lnk)
 	return lnk->state == SMC_LNK_ACTIVE;
 }
 
+static inline void smc_gid_be16_convert(__u8 *buf, u8 *gid_raw)
+{
+	sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
+		be16_to_cpu(((__be16 *)gid_raw)[0]),
+		be16_to_cpu(((__be16 *)gid_raw)[1]),
+		be16_to_cpu(((__be16 *)gid_raw)[2]),
+		be16_to_cpu(((__be16 *)gid_raw)[3]),
+		be16_to_cpu(((__be16 *)gid_raw)[4]),
+		be16_to_cpu(((__be16 *)gid_raw)[5]),
+		be16_to_cpu(((__be16 *)gid_raw)[6]),
+		be16_to_cpu(((__be16 *)gid_raw)[7]));
+}
+
 struct smc_sock;
 struct smc_clc_msg_accept_confirm;
 struct smc_clc_msg_local;
@@ -416,6 +429,7 @@ void smcr_link_down_cond(struct smc_link *lnk);
 void smcr_link_down_cond_sched(struct smc_link *lnk);
 int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb);
 int smcr_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb);
+int smcr_nl_get_link(struct sk_buff *skb, struct netlink_callback *cb);
 
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index c2225231f679..c952986a6aca 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -31,19 +31,6 @@ static struct smc_diag_dump_ctx *smc_dump_context(struct netlink_callback *cb)
 	return (struct smc_diag_dump_ctx *)cb->ctx;
 }
 
-static void smc_gid_be16_convert(__u8 *buf, u8 *gid_raw)
-{
-	sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
-		be16_to_cpu(((__be16 *)gid_raw)[0]),
-		be16_to_cpu(((__be16 *)gid_raw)[1]),
-		be16_to_cpu(((__be16 *)gid_raw)[2]),
-		be16_to_cpu(((__be16 *)gid_raw)[3]),
-		be16_to_cpu(((__be16 *)gid_raw)[4]),
-		be16_to_cpu(((__be16 *)gid_raw)[5]),
-		be16_to_cpu(((__be16 *)gid_raw)[6]),
-		be16_to_cpu(((__be16 *)gid_raw)[7]));
-}
-
 static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 {
 	struct smc_sock *smc = smc_sk(sk);
diff --git a/net/smc/smc_netlink.c b/net/smc/smc_netlink.c
index 925fbd59b91a..9000d6a3b625 100644
--- a/net/smc/smc_netlink.c
+++ b/net/smc/smc_netlink.c
@@ -23,6 +23,7 @@ static const struct nla_policy smc_gen_nl_policy[SMC_GEN_MAX + 1] = {
 	[SMC_GEN_UNSPEC]	= { .type = NLA_UNSPEC, },
 	[SMC_GEN_SYS_INFO]	= { .type = NLA_NESTED, },
 	[SMC_GEN_LGR_SMCR]	= { .type = NLA_NESTED, },
+	[SMC_GEN_LINK_SMCR]	= { .type = NLA_NESTED, },
 };
 
 static int smc_nl_start(struct netlink_callback *cb)
@@ -47,6 +48,12 @@ static const struct genl_ops smc_gen_nl_ops[] = {
 		.dumpit = smcr_nl_get_lgr,
 		.start = smc_nl_start
 	},
+	{
+		.cmd = SMC_NETLINK_GET_LINK_SMCR,
+		/* can be retrieved by unprivileged users */
+		.dumpit = smcr_nl_get_link,
+		.start = smc_nl_start
+	},
 };
 
 /* SMC_GENL family definition */
-- 
2.17.1
