From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net V4 3/5] net/smc: add SMC-D shutdown signal
Date: Tue, 20 Nov 2018 16:46:41 +0100
Message-ID: <20181120154643.24111-4-ubraun@linux.ibm.com>
References: <20181120154643.24111-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181120154643.24111-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

When a SMC-D link group is freed, a shutdown signal should be sent to
the peer to indicate that the link group is invalid. This patch adds the
shutdown signal to the SMC code.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 10 ++++++++--
 net/smc/smc_core.h |  3 ++-
 net/smc/smc_ism.c  | 43 ++++++++++++++++++++++++++++++++-----------
 net/smc/smc_ism.h  |  1 +
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3c023de58afd..1c9fa7f0261a 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -184,6 +184,8 @@ static void smc_lgr_free_work(struct work_struct *work)
 
 		if (!lgr->is_smcd && lnk->state != SMC_LNK_INACTIVE)
 			smc_llc_link_inactive(lnk);
+		if (lgr->is_smcd)
+			smc_ism_signal_shutdown(lgr);
 		smc_lgr_free(lgr);
 	}
 }
@@ -485,7 +487,7 @@ void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport)
 }
 
 /* Called when SMC-D device is terminated or peer is lost */
-void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid)
+void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 {
 	struct smc_link_group *lgr, *l;
 	LIST_HEAD(lgr_free_list);
@@ -495,7 +497,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid)
 	list_for_each_entry_safe(lgr, l, &smc_lgr_list.list, list) {
 		if (lgr->is_smcd && lgr->smcd == dev &&
 		    (!peer_gid || lgr->peer_gid == peer_gid) &&
-		    !list_empty(&lgr->list)) {
+		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
 			__smc_lgr_terminate(lgr);
 			list_move(&lgr->list, &lgr_free_list);
 		}
@@ -506,6 +508,8 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid)
 	list_for_each_entry_safe(lgr, l, &lgr_free_list, list) {
 		list_del_init(&lgr->list);
 		cancel_delayed_work_sync(&lgr->free_work);
+		if (!peer_gid && vlan == VLAN_VID_MASK) /* dev terminated? */
+			smc_ism_signal_shutdown(lgr);
 		smc_lgr_free(lgr);
 	}
 }
@@ -1026,6 +1030,8 @@ void smc_core_exit(void)
 			smc_llc_link_inactive(lnk);
 		}
 		cancel_delayed_work_sync(&lgr->free_work);
+		if (lgr->is_smcd)
+			smc_ism_signal_shutdown(lgr);
 		smc_lgr_free(lgr); /* free link group */
 	}
 }
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 5bc6cbaf0ed5..cf98f4d6093e 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -247,7 +247,8 @@ void smc_lgr_free(struct smc_link_group *lgr);
 void smc_lgr_forget(struct smc_link_group *lgr);
 void smc_lgr_terminate(struct smc_link_group *lgr);
 void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport);
-void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid);
+void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid,
+			unsigned short vlan);
 int smc_buf_create(struct smc_sock *smc, bool is_smcd);
 int smc_uncompress_bufsize(u8 compressed);
 int smc_rmb_rtoken_handling(struct smc_connection *conn,
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index e36f21ce7252..2fff79db1a59 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -187,22 +187,28 @@ struct smc_ism_event_work {
 #define ISM_EVENT_REQUEST		0x0001
 #define ISM_EVENT_RESPONSE		0x0002
 #define ISM_EVENT_REQUEST_IR		0x00000001
+#define ISM_EVENT_CODE_SHUTDOWN		0x80
 #define ISM_EVENT_CODE_TESTLINK		0x83
 
+union smcd_sw_event_info {
+	u64	info;
+	struct {
+		u8		uid[SMC_LGR_ID_SIZE];
+		unsigned short	vlan_id;
+		u16		code;
+	};
+};
+
 static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
 {
-	union {
-		u64	info;
-		struct {
-			u32		uid;
-			unsigned short	vlanid;
-			u16		code;
-		};
-	} ev_info;
+	union smcd_sw_event_info ev_info;
 
+	ev_info.info = wrk->event.info;
 	switch (wrk->event.code) {
+	case ISM_EVENT_CODE_SHUTDOWN:	/* Peer shut down DMBs */
+		smc_smcd_terminate(wrk->smcd, wrk->event.tok, ev_info.vlan_id);
+		break;
 	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
-		ev_info.info = wrk->event.info;
 		if (ev_info.code == ISM_EVENT_REQUEST) {
 			ev_info.code = ISM_EVENT_RESPONSE;
 			wrk->smcd->ops->signal_event(wrk->smcd,
@@ -215,6 +221,21 @@ static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
 	}
 }
 
+int smc_ism_signal_shutdown(struct smc_link_group *lgr)
+{
+	int rc;
+	union smcd_sw_event_info ev_info;
+
+	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
+	ev_info.vlan_id = lgr->vlan_id;
+	ev_info.code = ISM_EVENT_REQUEST;
+	rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
+					  ISM_EVENT_REQUEST_IR,
+					  ISM_EVENT_CODE_SHUTDOWN,
+					  ev_info.info);
+	return rc;
+}
+
 /* worker for SMC-D events */
 static void smc_ism_event_work(struct work_struct *work)
 {
@@ -223,7 +244,7 @@ static void smc_ism_event_work(struct work_struct *work)
 
 	switch (wrk->event.type) {
 	case ISM_EVENT_GID:	/* GID event, token is peer GID */
-		smc_smcd_terminate(wrk->smcd, wrk->event.tok);
+		smc_smcd_terminate(wrk->smcd, wrk->event.tok, VLAN_VID_MASK);
 		break;
 	case ISM_EVENT_DMB:
 		break;
@@ -289,7 +310,7 @@ void smcd_unregister_dev(struct smcd_dev *smcd)
 	spin_unlock(&smcd_dev_list.lock);
 	flush_workqueue(smcd->event_wq);
 	destroy_workqueue(smcd->event_wq);
-	smc_smcd_terminate(smcd, 0);
+	smc_smcd_terminate(smcd, 0, VLAN_VID_MASK);
 
 	device_del(&smcd->dev);
 }
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index aee45b860b79..4da946cbfa29 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -45,4 +45,5 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
 int smc_ism_write(struct smcd_dev *dev, const struct smc_ism_position *pos,
 		  void *data, size_t len);
+int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 #endif
-- 
2.16.4
