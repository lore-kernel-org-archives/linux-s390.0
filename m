Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390965AbgKZUjc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 15:39:32 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v6 09/14] net/smc: Add support for obtaining system information
Date: Thu, 26 Nov 2020 21:39:11 +0100
Message-Id: <20201126203916.56071-10-kgraul@linux.ibm.com>
In-Reply-To: <20201126203916.56071-1-kgraul@linux.ibm.com>
References: <20201126203916.56071-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

Add new netlink command to obtain system information
of the smc module.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc.h | 18 ++++++++++++
 net/smc/smc_clc.c        |  5 ++++
 net/smc/smc_clc.h        |  1 +
 net/smc/smc_core.c       | 60 ++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_core.h       |  2 ++
 net/smc/smc_netlink.c    |  5 ++++
 net/smc/smc_netlink.h    |  9 ++++++
 7 files changed, 100 insertions(+)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index b604d64542e8..1b8d4e770be9 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -37,11 +37,29 @@ enum {				/* SMC PNET Table commands */
 #define SMC_GENL_FAMILY_NAME		"SMC_GEN_NETLINK"
 #define SMC_GENL_FAMILY_VERSION		1
 
+/* SMC_GENL_FAMILY commands */
+enum {
+	SMC_NETLINK_GET_SYS_INFO = 1,
+};
+
 /* SMC_GENL_FAMILY top level attributes */
 enum {
 	SMC_GEN_UNSPEC,
+	SMC_GEN_SYS_INFO,		/* nest */
 	__SMC_GEN_MAX,
 	SMC_GEN_MAX = __SMC_GEN_MAX - 1
 };
 
+/* SMC_GEN_SYS_INFO attributes */
+enum {
+	SMC_NLA_SYS_UNSPEC,
+	SMC_NLA_SYS_VER,		/* u8 */
+	SMC_NLA_SYS_REL,		/* u8 */
+	SMC_NLA_SYS_IS_ISM_V2,		/* u8 */
+	SMC_NLA_SYS_LOCAL_HOST,		/* string */
+	SMC_NLA_SYS_SEID,		/* string */
+	__SMC_NLA_SYS_MAX,
+	SMC_NLA_SYS_MAX = __SMC_NLA_SYS_MAX - 1
+};
+
 #endif /* _UAPI_LINUX_SMC_H */
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 696d89c2dce4..e286dafd6e88 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -772,6 +772,11 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
 	return len > 0 ? 0 : len;
 }
 
+void smc_clc_get_hostname(u8 **host)
+{
+	*host = &smc_hostname[0];
+}
+
 void __init smc_clc_init(void)
 {
 	struct new_utsname *u;
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 49752c997c51..32d37f7b70f2 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -334,5 +334,6 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
 			u8 version);
 void smc_clc_init(void) __init;
+void smc_clc_get_hostname(u8 **host);
 
 #endif
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 0088511e30bf..0524d7bbab67 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -16,6 +16,8 @@
 #include <linux/wait.h>
 #include <linux/reboot.h>
 #include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/smc.h>
 #include <net/tcp.h>
 #include <net/sock.h>
 #include <rdma/ib_verbs.h>
@@ -30,6 +32,7 @@
 #include "smc_cdc.h"
 #include "smc_close.h"
 #include "smc_ism.h"
+#include "smc_netlink.h"
 
 #define SMC_LGR_NUM_INCR		256
 #define SMC_LGR_FREE_DELAY_SERV		(600 * HZ)
@@ -214,6 +217,63 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	conn->lgr = NULL;
 }
 
+int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
+	char hostname[SMC_MAX_HOSTNAME_LEN + 1];
+	char smc_seid[SMC_MAX_EID_LEN + 1];
+	struct smcd_dev *smcd_dev;
+	struct nlattr *attrs;
+	u8 *seid = NULL;
+	u8 *host = NULL;
+	void *nlh;
+
+	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &smc_gen_nl_family, NLM_F_MULTI,
+			  SMC_NETLINK_GET_SYS_INFO);
+	if (!nlh)
+		goto errmsg;
+	if (cb_ctx->pos[0])
+		goto errout;
+	attrs = nla_nest_start_noflag(skb, SMC_GEN_SYS_INFO);
+	if (!attrs)
+		goto errout;
+	if (nla_put_u8(skb, SMC_NLA_SYS_VER, SMC_V2))
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_SYS_REL, SMC_RELEASE))
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_SYS_IS_ISM_V2, smc_ism_is_v2_capable()))
+		goto errattr;
+	smc_clc_get_hostname(&host);
+	if (host) {
+		snprintf(hostname, sizeof(hostname), "%s", host);
+		if (nla_put_string(skb, SMC_NLA_SYS_LOCAL_HOST, hostname))
+			goto errattr;
+	}
+	mutex_lock(&smcd_dev_list.mutex);
+	smcd_dev = list_first_entry_or_null(&smcd_dev_list.list,
+					    struct smcd_dev, list);
+	if (smcd_dev)
+		smc_ism_get_system_eid(smcd_dev, &seid);
+	mutex_unlock(&smcd_dev_list.mutex);
+	if (seid && smc_ism_is_v2_capable()) {
+		snprintf(smc_seid, sizeof(smc_seid), "%s", seid);
+		if (nla_put_string(skb, SMC_NLA_SYS_SEID, smc_seid))
+			goto errattr;
+	}
+	nla_nest_end(skb, attrs);
+	genlmsg_end(skb, nlh);
+	cb_ctx->pos[0] = 1;
+	return skb->len;
+
+errattr:
+	nla_nest_cancel(skb, attrs);
+errout:
+	genlmsg_cancel(skb, nlh);
+errmsg:
+	return skb->len;
+}
+
 void smc_lgr_cleanup_early(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 3a1bb8e4b81f..eaed25d4e76b 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -14,6 +14,7 @@
 
 #include <linux/atomic.h>
 #include <rdma/ib_verbs.h>
+#include <net/genetlink.h>
 
 #include "smc.h"
 #include "smc_ib.h"
@@ -413,6 +414,7 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 				  struct smc_link *from_lnk, bool is_dev_err);
 void smcr_link_down_cond(struct smc_link *lnk);
 void smcr_link_down_cond_sched(struct smc_link *lnk);
+int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb);
 
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
diff --git a/net/smc/smc_netlink.c b/net/smc/smc_netlink.c
index e9a56148e71b..b1de58a6a1c4 100644
--- a/net/smc/smc_netlink.c
+++ b/net/smc/smc_netlink.c
@@ -21,6 +21,11 @@
 
 /* SMC_GENL generic netlink operation definition */
 static const struct genl_ops smc_gen_nl_ops[] = {
+	{
+		.cmd = SMC_NETLINK_GET_SYS_INFO,
+		/* can be retrieved by unprivileged users */
+		.dumpit = smc_nl_get_sys_info,
+	},
 };
 
 /* SMC_GENL family definition */
diff --git a/net/smc/smc_netlink.h b/net/smc/smc_netlink.h
index 0c757232c0d0..3477265cba6c 100644
--- a/net/smc/smc_netlink.h
+++ b/net/smc/smc_netlink.h
@@ -17,6 +17,15 @@
 
 extern struct genl_family smc_gen_nl_family;
 
+struct smc_nl_dmp_ctx {
+	int pos[2];
+};
+
+static inline struct smc_nl_dmp_ctx *smc_nl_dmp_ctx(struct netlink_callback *c)
+{
+	return (struct smc_nl_dmp_ctx *)c->ctx;
+}
+
 int smc_nl_init(void) __init;
 void smc_nl_exit(void);
 
-- 
2.17.1
