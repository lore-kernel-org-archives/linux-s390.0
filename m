Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v2 10/15] net/smc: Introduce SMCR get link command
Date: Tue,  3 Nov 2020 11:25:26 +0100
Message-Id: <20201103102531.91710-11-kgraul@linux.ibm.com>
In-Reply-To: <20201103102531.91710-1-kgraul@linux.ibm.com>
References: <20201103102531.91710-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

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
 include/uapi/linux/smc_diag.h |  8 +++++
 net/smc/smc_diag.c            | 62 ++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 6ae028344b6d..a57df0296aa4 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/inet_diag.h>
+#include <linux/if.h>
 #include <linux/smc.h>
 #include <rdma/ib_user_verbs.h>
 
@@ -79,6 +80,7 @@ enum {
 /* SMC_DIAG_GET_LGR_INFO command extensions */
 enum {
 	SMC_DIAG_LGR_INFO_SMCR = 1,
+	SMC_DIAG_LGR_INFO_SMCR_LINK,
 };
 
 #define SMC_DIAG_MAX (__SMC_DIAG_MAX - 1)
@@ -129,6 +131,12 @@ struct smc_diag_linkinfo {
 	__u8 ibport;			/* RDMA device port number */
 	__u8 gid[40];			/* local GID */
 	__u8 peer_gid[40];		/* peer GID */
+	/* Fields above used by legacy v1 code */
+	__u32 conn_cnt;
+	__u8 netdev[IFNAMSIZ];		/* ethernet device name */
+	__u8 link_uid[4];		/* unique link id */
+	__u8 peer_link_uid[4];		/* unique peer link id */
+	__u32 link_state;		/* link state */
 };
 
 struct smc_diag_lgrinfo {
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index c53904b3f350..6885814b6e4f 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -20,6 +20,7 @@
 #include <net/smc.h>
 
 #include "smc.h"
+#include "smc_ib.h"
 #include "smc_core.h"
 
 struct smc_diag_dump_ctx {
@@ -203,6 +204,54 @@ static bool smc_diag_fill_dmbinfo(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
+static int smc_diag_fill_lgr_link(struct smc_link_group *lgr,
+				  struct smc_link *link,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_linkinfo link_info;
+	int dummy = 0, rc = 0;
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, MAGIC_SEQ_V2_ACK,
+			cb->nlh->nlmsg_type, 0, NLM_F_MULTI);
+
+	memset(&link_info, 0, sizeof(link_info));
+	link_info.link_state = link->state;
+	link_info.link_id = link->link_id;
+	link_info.conn_cnt = atomic_read(&link->conn_cnt);
+	link_info.ibport = link->ibport;
+
+	memcpy(link_info.link_uid, link->link_uid,
+	       sizeof(link_info.link_uid));
+	snprintf(link_info.ibname, sizeof(link_info.ibname), "%s",
+		 link->ibname);
+	snprintf(link_info.netdev, sizeof(link_info.netdev), "%s",
+		 link->ndevname);
+	memcpy(link_info.peer_link_uid, link->peer_link_uid,
+	       sizeof(link_info.peer_link_uid));
+
+	smc_gid_be16_convert(link_info.gid,
+			     link->gid);
+	smc_gid_be16_convert(link_info.peer_gid,
+			     link->peer_gid);
+
+	/* Just a command place holder to signal back the command reply type */
+	if (nla_put(skb, SMC_DIAG_GET_LGR_INFO, sizeof(dummy), &dummy) < 0)
+		goto errout;
+	if (nla_put(skb, SMC_DIAG_LGR_INFO_SMCR_LINK,
+		    sizeof(link_info), &link_info) < 0)
+		goto errout;
+
+	nlmsg_end(skb, nlh);
+	return rc;
+
+errout:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
 static int smc_diag_fill_lgr(struct smc_link_group *lgr,
 			     struct sk_buff *skb,
 			     struct netlink_callback *cb,
@@ -238,7 +287,7 @@ static int smc_diag_handle_lgr(struct smc_link_group *lgr,
 			       struct smc_diag_req_v2 *req)
 {
 	struct nlmsghdr *nlh;
-	int rc = 0;
+	int i, rc = 0;
 
 	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, MAGIC_SEQ_V2_ACK,
 			cb->nlh->nlmsg_type, 0, NLM_F_MULTI);
@@ -250,6 +299,17 @@ static int smc_diag_handle_lgr(struct smc_link_group *lgr,
 		goto errout;
 
 	nlmsg_end(skb, nlh);
+
+	if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCR_LINK - 1)))) {
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+			if (!smc_link_usable(&lgr->lnk[i]))
+				continue;
+			rc = smc_diag_fill_lgr_link(lgr, &lgr->lnk[i], skb,
+						    cb, req);
+			if (rc < 0)
+				goto errout;
+		}
+	}
 	return rc;
 
 errout:
-- 
2.17.1
