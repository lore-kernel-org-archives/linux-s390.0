Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 8/8] net/smc: improve smc_conn_create reason codes
Date: Fri, 12 Apr 2019 12:57:30 +0200
In-Reply-To: <20190412105730.96245-1-ubraun@linux.ibm.com>
References: <20190412105730.96245-1-ubraun@linux.ibm.com>
Message-Id: <20190412105730.96245-9-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Rework smc_conn_create() to always return a valid DECLINE reason code.
This removes the need to translate the return codes on 4 different
places and allows to easily add more detailed return codes by changing
smc_conn_create() only.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   | 90 ++++++++++++++++++++++++------------------------------
 net/smc/smc_clc.h  |  1 +
 net/smc/smc_core.c | 25 +++++++++------
 net/smc/smc_core.h |  1 +
 4 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5e38b16c327b..e066899de72d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -524,7 +524,7 @@ static int smc_connect_ism_vlan_setup(struct smc_sock *smc,
 				      struct smc_init_info *ini)
 {
 	if (ini->vlan_id && smc_ism_get_vlan(ini->ism_dev, ini->vlan_id))
-		return SMC_CLC_DECL_CNFERR;
+		return SMC_CLC_DECL_ISMVLANERR;
 	return 0;
 }
 
@@ -562,7 +562,6 @@ static int smc_connect_rdma(struct smc_sock *smc,
 			    struct smc_clc_msg_accept_confirm *aclc,
 			    struct smc_init_info *ini)
 {
-	int local_contact = SMC_FIRST_CONTACT;
 	struct smc_link *link;
 	int reason_code = 0;
 
@@ -572,14 +571,8 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	ini->srv_first_contact = aclc->hdr.flag;
 
 	mutex_lock(&smc_client_lgr_pending);
-	local_contact = smc_conn_create(smc, ini);
-	if (local_contact < 0) {
-		if (local_contact == -ENOMEM)
-			reason_code = SMC_CLC_DECL_MEM;/* insufficient memory*/
-		else if (local_contact == -ENOLINK)
-			reason_code = SMC_CLC_DECL_SYNCERR; /* synchr. error */
-		else
-			reason_code = SMC_CLC_DECL_INTERR; /* other error */
+	reason_code = smc_conn_create(smc, ini);
+	if (reason_code) {
 		mutex_unlock(&smc_client_lgr_pending);
 		return reason_code;
 	}
@@ -589,41 +582,43 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	/* create send buffer and rmb */
 	if (smc_buf_create(smc, false))
-		return smc_connect_abort(smc, SMC_CLC_DECL_MEM, local_contact);
+		return smc_connect_abort(smc, SMC_CLC_DECL_MEM,
+					 ini->cln_first_contact);
 
-	if (local_contact == SMC_FIRST_CONTACT)
+	if (ini->cln_first_contact == SMC_FIRST_CONTACT)
 		smc_link_save_peer_info(link, aclc);
 
 	if (smc_rmb_rtoken_handling(&smc->conn, aclc))
 		return smc_connect_abort(smc, SMC_CLC_DECL_ERR_RTOK,
-					 local_contact);
+					 ini->cln_first_contact);
 
 	smc_close_init(smc);
 	smc_rx_init(smc);
 
-	if (local_contact == SMC_FIRST_CONTACT) {
+	if (ini->cln_first_contact == SMC_FIRST_CONTACT) {
 		if (smc_ib_ready_link(link))
 			return smc_connect_abort(smc, SMC_CLC_DECL_ERR_RDYLNK,
-						 local_contact);
+						 ini->cln_first_contact);
 	} else {
 		if (smc_reg_rmb(link, smc->conn.rmb_desc, true))
 			return smc_connect_abort(smc, SMC_CLC_DECL_ERR_REGRMB,
-						 local_contact);
+						 ini->cln_first_contact);
 	}
 	smc_rmb_sync_sg_for_device(&smc->conn);
 
 	reason_code = smc_clc_send_confirm(smc);
 	if (reason_code)
-		return smc_connect_abort(smc, reason_code, local_contact);
+		return smc_connect_abort(smc, reason_code,
+					 ini->cln_first_contact);
 
 	smc_tx_init(smc);
 
-	if (local_contact == SMC_FIRST_CONTACT) {
+	if (ini->cln_first_contact == SMC_FIRST_CONTACT) {
 		/* QP confirmation over RoCE fabric */
 		reason_code = smc_clnt_conf_first_link(smc);
 		if (reason_code)
 			return smc_connect_abort(smc, reason_code,
-						 local_contact);
+						 ini->cln_first_contact);
 	}
 	mutex_unlock(&smc_client_lgr_pending);
 
@@ -640,7 +635,6 @@ static int smc_connect_ism(struct smc_sock *smc,
 			   struct smc_clc_msg_accept_confirm *aclc,
 			   struct smc_init_info *ini)
 {
-	int local_contact = SMC_FIRST_CONTACT;
 	int rc = 0;
 
 	ini->is_smcd = true;
@@ -649,15 +643,16 @@ static int smc_connect_ism(struct smc_sock *smc,
 
 	/* there is only one lgr role for SMC-D; use server lock */
 	mutex_lock(&smc_server_lgr_pending);
-	local_contact = smc_conn_create(smc, ini);
-	if (local_contact < 0) {
+	rc = smc_conn_create(smc, ini);
+	if (rc) {
 		mutex_unlock(&smc_server_lgr_pending);
-		return SMC_CLC_DECL_MEM;
+		return rc;
 	}
 
 	/* Create send and receive buffers */
 	if (smc_buf_create(smc, true))
-		return smc_connect_abort(smc, SMC_CLC_DECL_MEM, local_contact);
+		return smc_connect_abort(smc, SMC_CLC_DECL_MEM,
+					 ini->cln_first_contact);
 
 	smc_conn_save_peer_info(smc, aclc);
 	smc_close_init(smc);
@@ -666,7 +661,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 
 	rc = smc_clc_send_confirm(smc);
 	if (rc)
-		return smc_connect_abort(smc, rc, local_contact);
+		return smc_connect_abort(smc, rc, ini->cln_first_contact);
 	mutex_unlock(&smc_server_lgr_pending);
 
 	smc_copy_sock_settings_to_clc(smc);
@@ -1114,15 +1109,14 @@ static int smc_listen_prfx_check(struct smc_sock *new_smc,
 
 /* listen worker: initialize connection and buffers */
 static int smc_listen_rdma_init(struct smc_sock *new_smc,
-				struct smc_init_info *ini, int *local_contact)
+				struct smc_init_info *ini)
 {
+	int rc;
+
 	/* allocate connection / link group */
-	*local_contact = smc_conn_create(new_smc, ini);
-	if (*local_contact < 0) {
-		if (*local_contact == -ENOMEM)
-			return SMC_CLC_DECL_MEM;/* insufficient memory*/
-		return SMC_CLC_DECL_INTERR; /* other error */
-	}
+	rc = smc_conn_create(new_smc, ini);
+	if (rc)
+		return rc;
 
 	/* create send buffer and rmb */
 	if (smc_buf_create(new_smc, false))
@@ -1134,25 +1128,22 @@ static int smc_listen_rdma_init(struct smc_sock *new_smc,
 /* listen worker: initialize connection and buffers for SMC-D */
 static int smc_listen_ism_init(struct smc_sock *new_smc,
 			       struct smc_clc_msg_proposal *pclc,
-			       struct smc_init_info *ini,
-			       int *local_contact)
+			       struct smc_init_info *ini)
 {
 	struct smc_clc_msg_smcd *pclc_smcd;
+	int rc;
 
 	pclc_smcd = smc_get_clc_msg_smcd(pclc);
 	ini->ism_gid = pclc_smcd->gid;
-	*local_contact = smc_conn_create(new_smc, ini);
-	if (*local_contact < 0) {
-		if (*local_contact == -ENOMEM)
-			return SMC_CLC_DECL_MEM;/* insufficient memory*/
-		return SMC_CLC_DECL_INTERR; /* other error */
-	}
+	rc = smc_conn_create(new_smc, ini);
+	if (rc)
+		return rc;
 
 	/* Check if peer can be reached via ISM device */
 	if (smc_ism_cantalk(new_smc->conn.lgr->peer_gid,
 			    new_smc->conn.lgr->vlan_id,
 			    new_smc->conn.lgr->smcd)) {
-		if (*local_contact == SMC_FIRST_CONTACT)
+		if (ini->cln_first_contact == SMC_FIRST_CONTACT)
 			smc_lgr_forget(new_smc->conn.lgr);
 		smc_conn_free(&new_smc->conn);
 		return SMC_CLC_DECL_SMCDNOTALK;
@@ -1160,7 +1151,7 @@ static int smc_listen_ism_init(struct smc_sock *new_smc,
 
 	/* Create send and receive buffers */
 	if (smc_buf_create(new_smc, true)) {
-		if (*local_contact == SMC_FIRST_CONTACT)
+		if (ini->cln_first_contact == SMC_FIRST_CONTACT)
 			smc_lgr_forget(new_smc->conn.lgr);
 		smc_conn_free(&new_smc->conn);
 		return SMC_CLC_DECL_MEM;
@@ -1227,7 +1218,6 @@ static void smc_listen_work(struct work_struct *work)
 	struct smc_init_info ini = {0};
 	bool ism_supported = false;
 	u8 buf[SMC_CLC_MAX_LEN];
-	int local_contact = 0;
 	int rc = 0;
 
 	if (new_smc->use_fallback) {
@@ -1279,8 +1269,7 @@ static void smc_listen_work(struct work_struct *work)
 		ini.is_smcd = true; /* prepare ISM check */
 		rc = smc_find_ism_device(new_smc, &ini);
 		if (!rc)
-			rc = smc_listen_ism_init(new_smc, pclc, &ini,
-						 &local_contact);
+			rc = smc_listen_ism_init(new_smc, pclc, &ini);
 		if (!rc)
 			ism_supported = true;
 		else if (pclc->hdr.path == SMC_TYPE_D)
@@ -1301,16 +1290,16 @@ static void smc_listen_work(struct work_struct *work)
 				rc = SMC_CLC_DECL_NOSMCDEV;
 			goto out_unlock;
 		}
-		rc = smc_listen_rdma_init(new_smc, &ini, &local_contact);
+		rc = smc_listen_rdma_init(new_smc, &ini);
 		if (rc)
 			goto out_unlock;
-		rc = smc_listen_rdma_reg(new_smc, local_contact);
+		rc = smc_listen_rdma_reg(new_smc, ini.cln_first_contact);
 		if (rc)
 			goto out_unlock;
 	}
 
 	/* send SMC Accept CLC message */
-	rc = smc_clc_send_accept(new_smc, local_contact);
+	rc = smc_clc_send_accept(new_smc, ini.cln_first_contact);
 	if (rc)
 		goto out_unlock;
 
@@ -1329,7 +1318,8 @@ static void smc_listen_work(struct work_struct *work)
 
 	/* finish worker */
 	if (!ism_supported) {
-		rc = smc_listen_rdma_finish(new_smc, &cclc, local_contact);
+		rc = smc_listen_rdma_finish(new_smc, &cclc,
+					    ini.cln_first_contact);
 		mutex_unlock(&smc_server_lgr_pending);
 		if (rc)
 			return;
@@ -1341,7 +1331,7 @@ static void smc_listen_work(struct work_struct *work)
 out_unlock:
 	mutex_unlock(&smc_server_lgr_pending);
 out_decl:
-	smc_listen_decline(new_smc, rc, local_contact);
+	smc_listen_decline(new_smc, rc, ini.cln_first_contact);
 }
 
 static void smc_tcp_listen_work(struct work_struct *work)
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 39f06da31d5e..ca209272e5fa 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -43,6 +43,7 @@
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
 #define SMC_CLC_DECL_DIFFPREFIX	0x03070000  /* IP prefix / subnet mismatch    */
 #define SMC_CLC_DECL_GETVLANERR	0x03080000  /* err to get vlan id of ip device*/
+#define SMC_CLC_DECL_ISMVLANERR	0x03090000  /* err to reg vlan id on ism dev  */
 #define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
 #define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
 #define SMC_CLC_DECL_INTERR	0x09990000  /* internal error		      */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 1574c7d7343b..2d2850adc2a3 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -204,14 +204,15 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	int i;
 
 	if (ini->is_smcd && ini->vlan_id) {
-		rc = smc_ism_get_vlan(ini->ism_dev, ini->vlan_id);
-		if (rc)
+		if (smc_ism_get_vlan(ini->ism_dev, ini->vlan_id)) {
+			rc = SMC_CLC_DECL_ISMVLANERR;
 			goto out;
+		}
 	}
 
 	lgr = kzalloc(sizeof(*lgr), GFP_KERNEL);
 	if (!lgr) {
-		rc = -ENOMEM;
+		rc = SMC_CLC_DECL_MEM;
 		goto out;
 	}
 	lgr->is_smcd = ini->is_smcd;
@@ -289,6 +290,12 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 free_lgr:
 	kfree(lgr);
 out:
+	if (rc < 0) {
+		if (rc == -ENOMEM)
+			rc = SMC_CLC_DECL_MEM;
+		else
+			rc = SMC_CLC_DECL_INTERR;
+	}
 	return rc;
 }
 
@@ -597,11 +604,11 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	struct smc_connection *conn = &smc->conn;
-	int local_contact = SMC_FIRST_CONTACT;
 	struct smc_link_group *lgr;
 	enum smc_lgr_role role;
 	int rc = 0;
 
+	ini->cln_first_contact = SMC_FIRST_CONTACT;
 	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 	if (role == SMC_CLNT && ini->srv_first_contact)
 		/* create new link group as well */
@@ -619,7 +626,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		    (role == SMC_CLNT ||
 		     lgr->conns_num < SMC_RMBS_PER_LGR_MAX)) {
 			/* link group found */
-			local_contact = SMC_REUSE_CONTACT;
+			ini->cln_first_contact = SMC_REUSE_CONTACT;
 			conn->lgr = lgr;
 			smc_lgr_register_conn(conn); /* add smc conn to lgr */
 			if (delayed_work_pending(&lgr->free_work))
@@ -632,16 +639,16 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	spin_unlock_bh(&smc_lgr_list.lock);
 
 	if (role == SMC_CLNT && !ini->srv_first_contact &&
-	    local_contact == SMC_FIRST_CONTACT) {
+	    ini->cln_first_contact == SMC_FIRST_CONTACT) {
 		/* Server reuses a link group, but Client wants to start
 		 * a new one
 		 * send out_of_sync decline, reason synchr. error
 		 */
-		return -ENOLINK;
+		return SMC_CLC_DECL_SYNCERR;
 	}
 
 create:
-	if (local_contact == SMC_FIRST_CONTACT) {
+	if (ini->cln_first_contact == SMC_FIRST_CONTACT) {
 		rc = smc_lgr_create(smc, ini);
 		if (rc)
 			goto out;
@@ -659,7 +666,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 #endif
 
 out:
-	return rc ? rc : local_contact;
+	return rc;
 }
 
 /* convert the RMB size into the compressed notation - minimum 16K.
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index e0628cb71e16..c00ac61dc129 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -235,6 +235,7 @@ struct smc_init_info {
 	u8			is_smcd;
 	unsigned short		vlan_id;
 	int			srv_first_contact;
+	int			cln_first_contact;
 	/* SMC-R */
 	struct smc_clc_msg_local *ib_lcl;
 	struct smc_ib_device	*ib_dev;
-- 
2.16.4
