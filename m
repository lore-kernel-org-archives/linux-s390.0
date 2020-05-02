Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 12/13] net/smc: enqueue local LLC messages
Date: Sat,  2 May 2020 14:35:51 +0200
Message-Id: <20200502123552.17204-13-kgraul@linux.ibm.com>
In-Reply-To: <20200502123552.17204-1-kgraul@linux.ibm.com>
References: <20200502123552.17204-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

As SMC server, when a second link was deleted, trigger the setup of an
asymmetric link. Do this by enqueueing a local ADD_LINK message which
is processed by the LLC layer as if it were received from peer. Do the
same when a new IB port became active and a new link could be created.
smc_llc_srv_add_link_local() enqueues a local ADD_LINK message.
And smc_llc_srv_delete_link_local() is used the same way to enqueue a
local DELETE_LINK message. This is used when an IB port is no longer
active.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c |  3 ++-
 net/smc/smc_llc.c  | 30 +++++++++++++++++++++++++++++-
 net/smc/smc_llc.h  |  2 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a964304283fa..32a6cadc5c1f 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -883,7 +883,7 @@ static void smcr_link_up(struct smc_link_group *lgr,
 		link = smc_llc_usable_link(lgr);
 		if (!link)
 			return;
-		/* tbd: call smc_llc_srv_add_link_local(link); */
+		smc_llc_srv_add_link_local(link);
 	} else {
 		/* invite server to start add link processing */
 		u8 gid[SMC_GID_SIZE];
@@ -954,6 +954,7 @@ static void smcr_link_down(struct smc_link *lnk)
 
 	if (lgr->role == SMC_SERV) {
 		/* trigger local delete link processing */
+		smc_llc_srv_delete_link_local(to_lnk, del_link_id);
 	} else {
 		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
 			/* another llc task is ongoing */
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index ac065f6d60dc..7675ccd6f3c3 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -159,6 +159,8 @@ struct smc_llc_qentry {
 	union smc_llc_msg msg;
 };
 
+static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc);
+
 struct smc_llc_qentry *smc_llc_flow_qentry_clr(struct smc_llc_flow *flow)
 {
 	struct smc_llc_qentry *qentry = flow->qentry;
@@ -1110,6 +1112,17 @@ static void smc_llc_process_srv_add_link(struct smc_link_group *lgr)
 	mutex_unlock(&lgr->llc_conf_mutex);
 }
 
+/* enqueue a local add_link req to trigger a new add_link flow, only as SERV */
+void smc_llc_srv_add_link_local(struct smc_link *link)
+{
+	struct smc_llc_msg_add_link add_llc = {0};
+
+	add_llc.hd.length = sizeof(add_llc);
+	add_llc.hd.common.type = SMC_LLC_ADD_LINK;
+	/* no dev and port needed, we as server ignore client data anyway */
+	smc_llc_enqueue(link, (union smc_llc_msg *)&add_llc);
+}
+
 /* worker to process an add link message */
 static void smc_llc_add_link_work(struct work_struct *work)
 {
@@ -1130,6 +1143,21 @@ static void smc_llc_add_link_work(struct work_struct *work)
 	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 }
 
+/* enqueue a local del_link msg to trigger a new del_link flow,
+ * called only for role SMC_SERV
+ */
+void smc_llc_srv_delete_link_local(struct smc_link *link, u8 del_link_id)
+{
+	struct smc_llc_msg_del_link del_llc = {0};
+
+	del_llc.hd.length = sizeof(del_llc);
+	del_llc.hd.common.type = SMC_LLC_DELETE_LINK;
+	del_llc.link_num = del_link_id;
+	del_llc.reason = htonl(SMC_LLC_DEL_LOST_PATH);
+	del_llc.hd.flags |= SMC_LLC_FLAG_DEL_LINK_ORDERLY;
+	smc_llc_enqueue(link, (union smc_llc_msg *)&del_llc);
+}
+
 static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
 {
 	struct smc_link *lnk_del = NULL, *lnk_asym, *lnk;
@@ -1250,7 +1278,7 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
 
 	if (lgr->type == SMC_LGR_SINGLE && !list_empty(&lgr->list)) {
 		/* trigger setup of asymm alt link */
-		/* tbd: call smc_llc_srv_add_link_local(lnk); */
+		smc_llc_srv_add_link_local(lnk);
 	}
 out:
 	mutex_unlock(&lgr->llc_conf_mutex);
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 1a7748d0541f..c335fc5f363c 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -69,6 +69,7 @@ int smc_llc_send_add_link(struct smc_link *link, u8 mac[], u8 gid[],
 int smc_llc_send_delete_link(struct smc_link *link, u8 link_del_id,
 			     enum smc_llc_reqresp reqresp, bool orderly,
 			     u32 reason);
+void smc_llc_srv_delete_link_local(struct smc_link *link, u8 del_link_id);
 void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc);
 void smc_llc_lgr_clear(struct smc_link_group *lgr);
 int smc_llc_link_init(struct smc_link *link);
@@ -90,6 +91,7 @@ struct smc_llc_qentry *smc_llc_flow_qentry_clr(struct smc_llc_flow *flow);
 void smc_llc_flow_qentry_del(struct smc_llc_flow *flow);
 int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry);
 int smc_llc_srv_add_link(struct smc_link *link);
+void smc_llc_srv_add_link_local(struct smc_link *link);
 int smc_llc_init(void) __init;
 
 #endif /* SMC_LLC_H */
-- 
2.17.1
