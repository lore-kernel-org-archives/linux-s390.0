Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404092AbgKXRvO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 12:51:14 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v5 10/14] net/smc: Introduce SMCR get linkgroup command
Date: Tue, 24 Nov 2020 18:50:43 +0100
Message-Id: <20201124175047.56949-11-kgraul@linux.ibm.com>
In-Reply-To: <20201124175047.56949-1-kgraul@linux.ibm.com>
References: <20201124175047.56949-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

Introduce get linkgroup command which loops through
all available SMCR linkgroups. It uses the SMC-R linkgroup
list as entry point, not the socket list, which makes
linkgroup diagnosis possible, in case linkgroup does not
contain active connections anymore.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc.h | 15 +++++++
 net/smc/smc_core.c       | 87 ++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_core.h       |  1 +
 net/smc/smc_netlink.c    |  7 ++++
 4 files changed, 110 insertions(+)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 1b8d4e770be9..3ae8ca4e5256 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -40,12 +40,14 @@ enum {				/* SMC PNET Table commands */
 /* SMC_GENL_FAMILY commands */
 enum {
 	SMC_NETLINK_GET_SYS_INFO = 1,
+	SMC_NETLINK_GET_LGR_SMCR,
 };
 
 /* SMC_GENL_FAMILY top level attributes */
 enum {
 	SMC_GEN_UNSPEC,
 	SMC_GEN_SYS_INFO,		/* nest */
+	SMC_GEN_LGR_SMCR,		/* nest */
 	__SMC_GEN_MAX,
 	SMC_GEN_MAX = __SMC_GEN_MAX - 1
 };
@@ -62,4 +64,17 @@ enum {
 	SMC_NLA_SYS_MAX = __SMC_NLA_SYS_MAX - 1
 };
 
+/* SMC_GEN_LGR_SMCR attributes */
+enum {
+	SMC_NLA_LGR_R_UNSPEC,
+	SMC_NLA_LGR_R_ID,		/* u32 */
+	SMC_NLA_LGR_R_ROLE,		/* u8 */
+	SMC_NLA_LGR_R_TYPE,		/* u8 */
+	SMC_NLA_LGR_R_PNETID,		/* string */
+	SMC_NLA_LGR_R_VLAN_ID,		/* u8 */
+	SMC_NLA_LGR_R_CONNS_NUM,	/* u32 */
+	__SMC_NLA_LGR_R_MAX,
+	SMC_NLA_LGR_R_MAX = __SMC_NLA_LGR_R_MAX - 1
+};
+
 #endif /* _UAPI_LINUX_SMC_H */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 59ecfdc435d8..02ad03fd1108 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -278,6 +278,93 @@ int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int smc_nl_fill_lgr(struct smc_link_group *lgr,
+			   struct sk_buff *skb,
+			   struct netlink_callback *cb)
+{
+	char smc_target[SMC_MAX_PNETID_LEN + 1];
+	struct nlattr *attrs;
+
+	attrs = nla_nest_start_noflag(skb, SMC_GEN_LGR_SMCR);
+	if (!attrs)
+		goto errout;
+
+	if (nla_put_u32(skb, SMC_NLA_LGR_R_ID, *((u32 *)&lgr->id)) < 0)
+		goto errattr;
+	if (nla_put_u32(skb, SMC_NLA_LGR_R_CONNS_NUM, lgr->conns_num) < 0)
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_LGR_R_ROLE, lgr->role) < 0)
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_LGR_R_TYPE, lgr->type) < 0)
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_LGR_R_VLAN_ID, lgr->vlan_id) < 0)
+		goto errattr;
+	memset(smc_target, 0, sizeof(smc_target));
+	snprintf(smc_target, sizeof(smc_target), "%s", lgr->pnet_id);
+	if (nla_put_string(skb, SMC_NLA_LGR_R_PNETID, smc_target) < 0)
+		goto errattr;
+
+	nla_nest_end(skb, attrs);
+	return 0;
+errattr:
+	nla_nest_cancel(skb, attrs);
+errout:
+	return -EMSGSIZE;
+}
+
+static int smc_nl_handle_lgr(struct smc_link_group *lgr,
+			     struct sk_buff *skb,
+			     struct netlink_callback *cb)
+{
+	int rc = 0;
+	void *nlh;
+
+	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &smc_gen_nl_family, NLM_F_MULTI,
+			  SMC_NETLINK_GET_LGR_SMCR);
+	if (!nlh)
+		return -EMSGSIZE;
+	rc = smc_nl_fill_lgr(lgr, skb, cb);
+	if (rc < 0)
+		goto errout;
+
+	genlmsg_end(skb, nlh);
+	return rc;
+
+errout:
+	genlmsg_cancel(skb, nlh);
+	return rc;
+}
+
+static void smc_nl_fill_lgr_list(struct smc_lgr_list *smc_lgr,
+				 struct sk_buff *skb,
+				 struct netlink_callback *cb)
+{
+	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
+	struct smc_link_group *lgr;
+	int snum = cb_ctx->pos[0];
+	int num = 0;
+
+	spin_lock_bh(&smc_lgr->lock);
+	list_for_each_entry(lgr, &smc_lgr->list, list) {
+		if (num < snum)
+			goto next;
+		if (smc_nl_handle_lgr(lgr, skb, cb) < 0)
+			goto errout;
+next:
+		num++;
+	}
+errout:
+	spin_unlock_bh(&smc_lgr->lock);
+	cb_ctx->pos[0] = num;
+}
+
+int smcr_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	smc_nl_fill_lgr_list(&smc_lgr_list, skb, cb);
+	return skb->len;
+}
+
 void smc_lgr_cleanup_early(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index eaed25d4e76b..662315beb605 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -415,6 +415,7 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 void smcr_link_down_cond(struct smc_link *lnk);
 void smcr_link_down_cond_sched(struct smc_link *lnk);
 int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb);
+int smcr_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb);
 
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
diff --git a/net/smc/smc_netlink.c b/net/smc/smc_netlink.c
index 8cb61edfaa27..925fbd59b91a 100644
--- a/net/smc/smc_netlink.c
+++ b/net/smc/smc_netlink.c
@@ -22,6 +22,7 @@
 static const struct nla_policy smc_gen_nl_policy[SMC_GEN_MAX + 1] = {
 	[SMC_GEN_UNSPEC]	= { .type = NLA_UNSPEC, },
 	[SMC_GEN_SYS_INFO]	= { .type = NLA_NESTED, },
+	[SMC_GEN_LGR_SMCR]	= { .type = NLA_NESTED, },
 };
 
 static int smc_nl_start(struct netlink_callback *cb)
@@ -40,6 +41,12 @@ static const struct genl_ops smc_gen_nl_ops[] = {
 		.dumpit = smc_nl_get_sys_info,
 		.start = smc_nl_start
 	},
+	{
+		.cmd = SMC_NETLINK_GET_LGR_SMCR,
+		/* can be retrieved by unprivileged users */
+		.dumpit = smcr_nl_get_lgr,
+		.start = smc_nl_start
+	},
 };
 
 /* SMC_GENL family definition */
-- 
2.17.1
