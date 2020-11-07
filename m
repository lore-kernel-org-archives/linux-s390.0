Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59390 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbgKGNAT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 7 Nov 2020 08:00:19 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v3 09/15] net/smc: Introduce SMCR get linkgroup command
Date: Sat,  7 Nov 2020 13:59:52 +0100
Message-Id: <20201107125958.16384-10-kgraul@linux.ibm.com>
In-Reply-To: <20201107125958.16384-1-kgraul@linux.ibm.com>
References: <20201107125958.16384-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

Introduce get linkgroup command which loops through
all available SMCR linkgroups. It uses the SMC-R linkgroup
list as entry point, not the socket list, which makes
linkgroup diagnosis possible, in case linkgroup does not
contain active connections anymore.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/net/smc.h             |  2 +-
 include/uapi/linux/smc.h      |  5 ++
 include/uapi/linux/smc_diag.h | 43 +++++++++++++++++
 net/smc/smc.h                 |  4 +-
 net/smc/smc_core.c            | 15 ++++++
 net/smc/smc_core.h            |  7 ++-
 net/smc/smc_diag.c            | 91 +++++++++++++++++++++++++++++++++++
 7 files changed, 162 insertions(+), 5 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index e441aa97ad61..59d25dcb8e92 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -10,8 +10,8 @@
  */
 #ifndef _SMC_H
 #define _SMC_H
+#include <linux/smc.h>
 
-#define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
 
 struct smc_hashinfo {
 	rwlock_t lock;
diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 0e11ca421ca4..635e2c2aeac5 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -3,6 +3,7 @@
  *  Shared Memory Communications over RDMA (SMC-R) and RoCE
  *
  *  Definitions for generic netlink based configuration of an SMC-R PNET table
+ *  Definitions for SMC Linkgroup and Devices.
  *
  *  Copyright IBM Corp. 2016
  *
@@ -33,4 +34,8 @@ enum {				/* SMC PNET Table commands */
 #define SMCR_GENL_FAMILY_NAME		"SMC_PNETID"
 #define SMCR_GENL_FAMILY_VERSION	1
 
+#define SMC_MAX_PNETID_LEN		16 /* Max. length of PNET id */
+#define SMC_LGR_ID_SIZE			4
+#define SMC_MAX_HOSTNAME_LEN		32 /* Max length of hostname */
+#define SMC_MAX_EID_LEN			32 /* Max length of eid */
 #endif /* _UAPI_LINUX_SMC_H */
diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 236c1c52d562..6ae028344b6d 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -4,8 +4,10 @@
 
 #include <linux/types.h>
 #include <linux/inet_diag.h>
+#include <linux/smc.h>
 #include <rdma/ib_user_verbs.h>
 
+#define SMC_DIAG_EXTS_PER_CMD 16
 /* Sequence numbers */
 enum {
 	MAGIC_SEQ = 123456,
@@ -21,6 +23,17 @@ struct smc_diag_req {
 	struct inet_diag_sockid	id;
 };
 
+/* Request structure v2 */
+struct smc_diag_req_v2 {
+	__u8	diag_family;
+	__u8	pad[2];
+	__u8	diag_ext;		/* Query extended information */
+	struct inet_diag_sockid	id;
+	__u32	cmd;
+	__u32	cmd_ext;
+	__u8	cmd_val[8];
+};
+
 /* Base info structure. It contains socket identity (addrs/ports/cookie) based
  * on the internal clcsock, and more SMC-related socket data
  */
@@ -57,7 +70,19 @@ enum {
 	__SMC_DIAG_MAX,
 };
 
+/* V2 Commands */
+enum {
+	SMC_DIAG_GET_LGR_INFO = SMC_DIAG_EXTS_PER_CMD,
+	__SMC_DIAG_EXT_MAX,
+};
+
+/* SMC_DIAG_GET_LGR_INFO command extensions */
+enum {
+	SMC_DIAG_LGR_INFO_SMCR = 1,
+};
+
 #define SMC_DIAG_MAX (__SMC_DIAG_MAX - 1)
+#define SMC_DIAG_EXT_MAX (__SMC_DIAG_EXT_MAX - 1)
 
 /* SMC_DIAG_CONNINFO */
 
@@ -88,6 +113,14 @@ struct smc_diag_conninfo {
 	struct smc_diag_cursor	tx_fin;		/* confirmed sent cursor */
 };
 
+struct smc_diag_v2_lgr_info {
+	__u8		smc_version;		/* SMC Version */
+	__u8		peer_smc_release;	/* Peer SMC Version */
+	__u8		peer_os;		/* Peer operating system */
+	__u8		negotiated_eid[SMC_MAX_EID_LEN]; /* Negotiated EID */
+	__u8		peer_hostname[SMC_MAX_HOSTNAME_LEN]; /* Peer host */
+};
+
 /* SMC_DIAG_LINKINFO */
 
 struct smc_diag_linkinfo {
@@ -116,4 +149,14 @@ struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
 	__aligned_u64	peer_token;	/* Token of remote DMBE */
 };
 
+struct smc_diag_lgr {
+	__u8		lgr_id[SMC_LGR_ID_SIZE]; /* Linkgroup identifier */
+	__u8		lgr_role;		/* Linkgroup role */
+	__u8		lgr_type;		/* Linkgroup type */
+	__u8		pnet_id[SMC_MAX_PNETID_LEN]; /* Linkgroup pnet id */
+	__u8		vlan_id;		/* Linkgroup vland id */
+	__u32		conns_num;		/* Number of connections */
+	__u8		reserved;		/* Reserved for future use */
+	struct smc_diag_v2_lgr_info v2_lgr_info; /* SMCv2 info */
+};
 #endif /* _UAPI_SMC_DIAG_H_ */
diff --git a/net/smc/smc.h b/net/smc/smc.h
index d65e15f0c944..d3bf81759285 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -14,6 +14,7 @@
 #include <linux/socket.h>
 #include <linux/types.h>
 #include <linux/compiler.h> /* __aligned */
+#include <uapi/linux/smc.h>
 #include <net/sock.h>
 
 #include "smc_ib.h"
@@ -29,9 +30,6 @@
 					 * devices
 					 */
 
-#define SMC_MAX_HOSTNAME_LEN	32
-#define SMC_MAX_EID_LEN		32
-
 extern struct proto smc_proto;
 extern struct proto smc_proto6;
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ef0aae43a209..07b7cc88f9b9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -204,6 +204,21 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	conn->lgr = NULL;
 }
 
+static struct smc_lgr_list *smc_get_lgr_list(void)
+{
+	return &smc_lgr_list;
+}
+
+static const struct smc_diag_ops smc_diag_ops = {
+	.get_lgr_list		= smc_get_lgr_list,
+};
+
+const struct smc_diag_ops *smc_get_diag_ops(void)
+{
+	return &smc_diag_ops;
+}
+EXPORT_SYMBOL_GPL(smc_get_diag_ops);
+
 void smc_lgr_cleanup_early(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index a6ba9cc8c60e..0b6951a0b2d8 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -20,6 +20,11 @@
 
 #define SMC_RMBS_PER_LGR_MAX	255	/* max. # of RMBs per link group */
 
+/* Functions which are needed for diagnostic purposes by smc_diag module */
+struct smc_diag_ops {
+	struct smc_lgr_list *(*get_lgr_list)(void);
+};
+
 struct smc_lgr_list {			/* list of link group definition */
 	struct list_head	list;
 	spinlock_t		lock;	/* protects list of link groups */
@@ -70,7 +75,6 @@ struct smc_rdma_wr {				/* work requests per message
 	struct ib_rdma_wr	wr_tx_rdma[SMC_MAX_RDMA_WRITES];
 };
 
-#define SMC_LGR_ID_SIZE		4
 
 struct smc_link {
 	struct smc_ib_device	*smcibdev;	/* ib-device */
@@ -424,6 +428,7 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 				  struct smc_link *from_lnk, bool is_dev_err);
 void smcr_link_down_cond(struct smc_link *lnk);
 void smcr_link_down_cond_sched(struct smc_link *lnk);
+const struct smc_diag_ops *smc_get_diag_ops(void);
 
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index bc2b616524ff..c958b23843e6 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -22,6 +22,8 @@
 #include "smc.h"
 #include "smc_core.h"
 
+static const struct smc_diag_ops *smc_diag_ops;
+
 struct smc_diag_dump_ctx {
 	int pos[2];
 };
@@ -203,6 +205,86 @@ static bool smc_diag_fill_dmbinfo(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
+static int smc_diag_fill_lgr(struct smc_link_group *lgr,
+			     struct sk_buff *skb,
+			     struct netlink_callback *cb,
+			     struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_lgr lgr_link;
+	int dummy = 0;
+	int rc = 0;
+
+	memset(&lgr_link, 0, sizeof(lgr_link));
+	memcpy(&lgr_link.lgr_id, lgr->id, sizeof(lgr->id));
+	lgr_link.lgr_role = lgr->role;
+	lgr_link.lgr_type = lgr->type;
+	lgr_link.conns_num = lgr->conns_num;
+	lgr_link.vlan_id = lgr->vlan_id;
+	memcpy(lgr_link.pnet_id, lgr->pnet_id, sizeof(lgr_link.pnet_id));
+
+	/* Just a command place holder to signal back the command reply type */
+	if (nla_put(skb, SMC_DIAG_GET_LGR_INFO, sizeof(dummy), &dummy) < 0)
+		goto errout;
+	if (nla_put(skb, SMC_DIAG_LGR_INFO_SMCR,
+		    sizeof(lgr_link), &lgr_link) < 0)
+		goto errout;
+
+	return rc;
+errout:
+	return -EMSGSIZE;
+}
+
+static int smc_diag_handle_lgr(struct smc_link_group *lgr,
+			       struct sk_buff *skb,
+			       struct netlink_callback *cb,
+			       struct smc_diag_req_v2 *req)
+{
+	struct nlmsghdr *nlh;
+	int rc = 0;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, MAGIC_SEQ_V2_ACK,
+			cb->nlh->nlmsg_type, 0, NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	rc = smc_diag_fill_lgr(lgr, skb, cb, req);
+	if (rc < 0)
+		goto errout;
+
+	nlmsg_end(skb, nlh);
+	return rc;
+
+errout:
+	nlmsg_cancel(skb, nlh);
+	return rc;
+}
+
+static int smc_diag_fill_lgr_list(struct smc_lgr_list *smc_lgr,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
+	struct smc_link_group *lgr;
+	int snum = cb_ctx->pos[0];
+	int rc = 0, num = 0;
+
+	spin_lock_bh(&smc_lgr->lock);
+	list_for_each_entry(lgr, &smc_lgr->list, list) {
+		if (num < snum)
+			goto next;
+		rc = smc_diag_handle_lgr(lgr, skb, cb, req);
+		if (rc < 0)
+			goto errout;
+next:
+		num++;
+	}
+errout:
+	spin_unlock_bh(&smc_lgr->lock);
+	cb_ctx->pos[0] = num;
+	return rc;
+}
+
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
 			   const struct smc_diag_req *req)
@@ -295,6 +377,14 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	struct smc_diag_req_v2 *req = nlmsg_data(cb->nlh);
+
+	if (req->cmd == SMC_DIAG_GET_LGR_INFO) {
+		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCR - 1))))
+			smc_diag_fill_lgr_list(smc_diag_ops->get_lgr_list(),
+					       skb, cb, req);
+	}
+
 	return skb->len;
 }
 
@@ -322,6 +412,7 @@ static const struct sock_diag_handler smc_diag_handler = {
 
 static int __init smc_diag_init(void)
 {
+	smc_diag_ops = smc_get_diag_ops();
 	return sock_diag_register(&smc_diag_handler);
 }
 
-- 
2.17.1
