Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgKBTjp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 14:39:45 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 11/15] net/smc: Add SMC-D Linkgroup diagnostic support
Date: Mon,  2 Nov 2020 20:34:05 +0100
Message-Id: <20201102193409.70901-12-kgraul@linux.ibm.com>
In-Reply-To: <20201102193409.70901-1-kgraul@linux.ibm.com>
References: <20201102193409.70901-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

Deliver SMCD Linkgroup information via netlink based
diagnostic interface.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc_diag.h |   7 +++
 net/smc/smc_diag.c            | 108 ++++++++++++++++++++++++++++++++++
 net/smc/smc_ism.c             |   2 +
 3 files changed, 117 insertions(+)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 16b8ea9da3d5..ee9668917aa7 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -80,6 +80,7 @@ enum {
 enum {
 	SMC_DIAG_LGR_INFO_SMCR = 1,
 	SMC_DIAG_LGR_INFO_SMCR_LINK,
+	SMC_DIAG_LGR_INFO_SMCD,
 };
 
 #define SMC_DIAG_MAX (__SMC_DIAG_MAX - 1)
@@ -154,6 +155,12 @@ struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
 	__aligned_u64	my_gid;		/* My GID */
 	__aligned_u64	token;		/* Token of DMB */
 	__aligned_u64	peer_token;	/* Token of remote DMBE */
+	/* Fields above used by legacy v1 code */
+	__u8		pnet_id[SMC_MAX_PNETID_LEN]; /* Pnet ID */
+	__u32		conns_num;	/* Number of connections */
+	__u16		chid;		/* Linkgroup CHID */
+	__u8		vlan_id;	/* Linkgroup vlan id */
+	struct smc_diag_v2_lgr_info v2_lgr_info; /* SMCv2 info */
 };
 
 struct smc_diag_lgr {
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6885814b6e4f..fcff07a9ea47 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -21,6 +21,7 @@
 
 #include "smc.h"
 #include "smc_ib.h"
+#include "smc_ism.h"
 #include "smc_core.h"
 
 struct smc_diag_dump_ctx {
@@ -252,6 +253,53 @@ static int smc_diag_fill_lgr_link(struct smc_link_group *lgr,
 	return -EMSGSIZE;
 }
 
+static int smc_diag_fill_smcd_lgr(struct smc_link_group *lgr,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct smc_diag_req_v2 *req)
+{
+	struct smcd_diag_dmbinfo smcd_lgr;
+	struct nlmsghdr *nlh;
+	int dummy = 0;
+	int rc = 0;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, MAGIC_SEQ_V2_ACK,
+			cb->nlh->nlmsg_type, 0, NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	memset(&smcd_lgr, 0, sizeof(smcd_lgr));
+	memcpy(&smcd_lgr.linkid, lgr->id, sizeof(lgr->id));
+	smcd_lgr.conns_num = lgr->conns_num;
+	smcd_lgr.vlan_id = lgr->vlan_id;
+	smcd_lgr.peer_gid = lgr->peer_gid;
+	smcd_lgr.my_gid = lgr->smcd->local_gid;
+	smcd_lgr.chid = smc_ism_get_chid(lgr->smcd);
+	memcpy(&smcd_lgr.v2_lgr_info.negotiated_eid, lgr->negotiated_eid,
+	       sizeof(smcd_lgr.v2_lgr_info.negotiated_eid));
+	memcpy(&smcd_lgr.v2_lgr_info.peer_hostname, lgr->peer_hostname,
+	       sizeof(smcd_lgr.v2_lgr_info.peer_hostname));
+	smcd_lgr.v2_lgr_info.peer_os = lgr->peer_os;
+	smcd_lgr.v2_lgr_info.peer_smc_release = lgr->peer_smc_release;
+	smcd_lgr.v2_lgr_info.smc_version = lgr->smc_version;
+	snprintf(smcd_lgr.pnet_id, sizeof(smcd_lgr.pnet_id), "%s",
+		 lgr->smcd->pnetid);
+
+	/* Just a command place holder to signal back the command reply type */
+	if (nla_put(skb, SMC_DIAG_GET_LGR_INFO, sizeof(dummy), &dummy) < 0)
+		goto errout;
+
+	if (nla_put(skb, SMC_DIAG_LGR_INFO_SMCD,
+		    sizeof(smcd_lgr), &smcd_lgr) < 0)
+		goto errout;
+
+	nlmsg_end(skb, nlh);
+	return rc;
+errout:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
 static int smc_diag_fill_lgr(struct smc_link_group *lgr,
 			     struct sk_buff *skb,
 			     struct netlink_callback *cb,
@@ -343,6 +391,63 @@ static int smc_diag_fill_lgr_list(struct smc_lgr_list *smc_lgr,
 	return rc;
 }
 
+static int smc_diag_handle_smcd_lgr(struct smcd_dev *dev,
+				    struct sk_buff *skb,
+				    struct netlink_callback *cb,
+				    struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
+	struct smc_link_group *lgr;
+	int snum = cb_ctx->pos[1];
+	int rc = 0, num = 0;
+
+	spin_lock_bh(&dev->lgr_lock);
+	list_for_each_entry(lgr, &dev->lgr_list, list) {
+		if (lgr->is_smcd) {
+			if (num < snum)
+				goto next;
+			rc = smc_diag_fill_smcd_lgr(lgr, skb, cb, req);
+			if (rc < 0)
+				goto errout;
+next:
+			num++;
+		}
+	}
+errout:
+	spin_unlock_bh(&dev->lgr_lock);
+	cb_ctx->pos[1] = num;
+	return rc;
+}
+
+static int smc_diag_fill_smcd_dev(struct smcd_dev_list *dev_list,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
+	struct smcd_dev *smcd_dev;
+	int snum = cb_ctx->pos[0];
+	int rc = 0, num = 0;
+
+	mutex_lock(&dev_list->mutex);
+	list_for_each_entry(smcd_dev, &dev_list->list, list) {
+		if (!list_empty(&smcd_dev->lgr_list)) {
+			if (num < snum)
+				goto next;
+			rc = smc_diag_handle_smcd_lgr(smcd_dev, skb,
+						      cb, req);
+			if (rc < 0)
+				goto errout;
+next:
+			num++;
+		}
+	}
+errout:
+	mutex_unlock(&dev_list->mutex);
+	cb_ctx->pos[0] = num;
+	return rc;
+}
+
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
 			   const struct smc_diag_req *req)
@@ -441,6 +546,9 @@ static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
 		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCR - 1))))
 			smc_diag_fill_lgr_list(&smc_lgr_list, skb, cb,
 					       req);
+		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCD - 1))))
+			smc_diag_fill_smcd_dev(&smcd_dev_list, skb, cb,
+					       req);
 	}
 
 	return skb->len;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 6abbdd09a580..5bb2c7fb4ea8 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -20,6 +20,7 @@ struct smcd_dev_list smcd_dev_list = {
 	.list = LIST_HEAD_INIT(smcd_dev_list.list),
 	.mutex = __MUTEX_INITIALIZER(smcd_dev_list.mutex)
 };
+EXPORT_SYMBOL_GPL(smcd_dev_list);
 
 bool smc_ism_v2_capable;
 
@@ -50,6 +51,7 @@ u16 smc_ism_get_chid(struct smcd_dev *smcd)
 {
 	return smcd->ops->get_chid(smcd);
 }
+EXPORT_SYMBOL_GPL(smc_ism_get_chid);
 
 /* Set a connection using this DMBE. */
 void smc_ism_set_conn(struct smc_connection *conn)
-- 
2.17.1
