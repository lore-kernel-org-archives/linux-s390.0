Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/8] net/smc: consolidate function parameters
Date: Fri, 12 Apr 2019 12:57:26 +0200
In-Reply-To: <20190412105730.96245-1-ubraun@linux.ibm.com>
References: <20190412105730.96245-1-ubraun@linux.ibm.com>
Message-Id: <20190412105730.96245-5-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

During initialization of an SMC socket a lot of function parameters need
to get passed down the function call path. Consolidate the parameters
in a helper struct so there are less enough parameters to get all passed
by register.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   | 118 +++++++++++++++++++++++++----------------------------
 net/smc/smc_clc.c  |  10 ++---
 net/smc/smc_clc.h  |   4 +-
 net/smc/smc_core.c |  70 +++++++++++++++----------------
 net/smc/smc_core.h |  24 ++++++++---
 net/smc/smc_pnet.c |  47 ++++++++++-----------
 net/smc/smc_pnet.h |   7 ++--
 7 files changed, 139 insertions(+), 141 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index cb8bc77c75d6..b45372879a70 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -496,40 +496,34 @@ static int smc_connect_abort(struct smc_sock *smc, int reason_code,
 
 /* check if there is a rdma device available for this connection. */
 /* called for connect and listen */
-static int smc_check_rdma(struct smc_sock *smc, struct smc_ib_device **ibdev,
-			  u8 *ibport, unsigned short vlan_id, u8 gid[])
+static int smc_check_rdma(struct smc_sock *smc, struct smc_init_info *ini)
 {
-	int reason_code = 0;
-
 	/* PNET table look up: search active ib_device and port
 	 * within same PNETID that also contains the ethernet device
 	 * used for the internal TCP socket
 	 */
-	smc_pnet_find_roce_resource(smc->clcsock->sk, ibdev, ibport, vlan_id,
-				    gid);
-	if (!(*ibdev))
-		reason_code = SMC_CLC_DECL_CNFERR; /* configuration error */
-
-	return reason_code;
+	smc_pnet_find_roce_resource(smc->clcsock->sk, ini);
+	if (!(ini->ib_dev))
+		return SMC_CLC_DECL_CNFERR; /* configuration error */
+	return 0;
 }
 
 /* check if there is an ISM device available for this connection. */
 /* called for connect and listen */
-static int smc_check_ism(struct smc_sock *smc, struct smcd_dev **ismdev)
+static int smc_check_ism(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	/* Find ISM device with same PNETID as connecting interface  */
-	smc_pnet_find_ism_resource(smc->clcsock->sk, ismdev);
-	if (!(*ismdev))
+	smc_pnet_find_ism_resource(smc->clcsock->sk, ini);
+	if (!ini->ism_dev)
 		return SMC_CLC_DECL_CNFERR; /* configuration error */
 	return 0;
 }
 
 /* Check for VLAN ID and register it on ISM device just for CLC handshake */
 static int smc_connect_ism_vlan_setup(struct smc_sock *smc,
-				      struct smcd_dev *ismdev,
-				      unsigned short vlan_id)
+				      struct smc_init_info *ini)
 {
-	if (vlan_id && smc_ism_get_vlan(ismdev, vlan_id))
+	if (ini->vlan_id && smc_ism_get_vlan(ini->ism_dev, ini->vlan_id))
 		return SMC_CLC_DECL_CNFERR;
 	return 0;
 }
@@ -538,12 +532,11 @@ static int smc_connect_ism_vlan_setup(struct smc_sock *smc,
  * used, the VLAN ID will be registered again during the connection setup.
  */
 static int smc_connect_ism_vlan_cleanup(struct smc_sock *smc, bool is_smcd,
-					struct smcd_dev *ismdev,
-					unsigned short vlan_id)
+					struct smc_init_info *ini)
 {
 	if (!is_smcd)
 		return 0;
-	if (vlan_id && smc_ism_put_vlan(ismdev, vlan_id))
+	if (ini->vlan_id && smc_ism_put_vlan(ini->ism_dev, ini->vlan_id))
 		return SMC_CLC_DECL_CNFERR;
 	return 0;
 }
@@ -551,13 +544,12 @@ static int smc_connect_ism_vlan_cleanup(struct smc_sock *smc, bool is_smcd,
 /* CLC handshake during connect */
 static int smc_connect_clc(struct smc_sock *smc, int smc_type,
 			   struct smc_clc_msg_accept_confirm *aclc,
-			   struct smc_ib_device *ibdev, u8 ibport,
-			   u8 gid[], struct smcd_dev *ismdev)
+			   struct smc_init_info *ini)
 {
 	int rc = 0;
 
 	/* do inband token exchange */
-	rc = smc_clc_send_proposal(smc, smc_type, ibdev, ibport, gid, ismdev);
+	rc = smc_clc_send_proposal(smc, smc_type, ini);
 	if (rc)
 		return rc;
 	/* receive SMC Accept CLC message */
@@ -568,16 +560,19 @@ static int smc_connect_clc(struct smc_sock *smc, int smc_type,
 /* setup for RDMA connection of client */
 static int smc_connect_rdma(struct smc_sock *smc,
 			    struct smc_clc_msg_accept_confirm *aclc,
-			    struct smc_ib_device *ibdev, u8 ibport)
+			    struct smc_init_info *ini)
 {
 	int local_contact = SMC_FIRST_CONTACT;
 	struct smc_link *link;
 	int reason_code = 0;
 
+	ini->is_smcd = false;
+	ini->ib_lcl = &aclc->lcl;
+	ini->ib_clcqpn = ntoh24(aclc->qpn);
+	ini->srv_first_contact = aclc->hdr.flag;
+
 	mutex_lock(&smc_client_lgr_pending);
-	local_contact = smc_conn_create(smc, false, aclc->hdr.flag, ibdev,
-					ibport, ntoh24(aclc->qpn), &aclc->lcl,
-					NULL, 0);
+	local_contact = smc_conn_create(smc, ini);
 	if (local_contact < 0) {
 		if (local_contact == -ENOMEM)
 			reason_code = SMC_CLC_DECL_MEM;/* insufficient memory*/
@@ -643,15 +638,18 @@ static int smc_connect_rdma(struct smc_sock *smc,
 /* setup for ISM connection of client */
 static int smc_connect_ism(struct smc_sock *smc,
 			   struct smc_clc_msg_accept_confirm *aclc,
-			   struct smcd_dev *ismdev)
+			   struct smc_init_info *ini)
 {
 	int local_contact = SMC_FIRST_CONTACT;
 	int rc = 0;
 
+	ini->is_smcd = true;
+	ini->ism_gid = aclc->gid;
+	ini->srv_first_contact = aclc->hdr.flag;
+
 	/* there is only one lgr role for SMC-D; use server lock */
 	mutex_lock(&smc_server_lgr_pending);
-	local_contact = smc_conn_create(smc, true, aclc->hdr.flag, NULL, 0, 0,
-					NULL, ismdev, aclc->gid);
+	local_contact = smc_conn_create(smc, ini);
 	if (local_contact < 0) {
 		mutex_unlock(&smc_server_lgr_pending);
 		return SMC_CLC_DECL_MEM;
@@ -684,13 +682,9 @@ static int __smc_connect(struct smc_sock *smc)
 {
 	bool ism_supported = false, rdma_supported = false;
 	struct smc_clc_msg_accept_confirm aclc;
-	struct smc_ib_device *ibdev;
-	struct smcd_dev *ismdev;
-	u8 gid[SMC_GID_SIZE];
-	unsigned short vlan;
+	struct smc_init_info ini = {0};
 	int smc_type;
 	int rc = 0;
-	u8 ibport;
 
 	sock_hold(&smc->sk); /* sock put in passive closing */
 
@@ -706,19 +700,19 @@ static int __smc_connect(struct smc_sock *smc)
 		return smc_connect_decline_fallback(smc, SMC_CLC_DECL_IPSEC);
 
 	/* check for VLAN ID */
-	if (smc_vlan_by_tcpsk(smc->clcsock, &vlan))
+	if (smc_vlan_by_tcpsk(smc->clcsock, &ini))
 		return smc_connect_decline_fallback(smc, SMC_CLC_DECL_CNFERR);
 
 	/* check if there is an ism device available */
-	if (!smc_check_ism(smc, &ismdev) &&
-	    !smc_connect_ism_vlan_setup(smc, ismdev, vlan)) {
+	if (!smc_check_ism(smc, &ini) &&
+	    !smc_connect_ism_vlan_setup(smc, &ini)) {
 		/* ISM is supported for this connection */
 		ism_supported = true;
 		smc_type = SMC_TYPE_D;
 	}
 
 	/* check if there is a rdma device available */
-	if (!smc_check_rdma(smc, &ibdev, &ibport, vlan, gid)) {
+	if (!smc_check_rdma(smc, &ini)) {
 		/* RDMA is supported for this connection */
 		rdma_supported = true;
 		if (ism_supported)
@@ -732,25 +726,25 @@ static int __smc_connect(struct smc_sock *smc)
 		return smc_connect_decline_fallback(smc, SMC_CLC_DECL_NOSMCDEV);
 
 	/* perform CLC handshake */
-	rc = smc_connect_clc(smc, smc_type, &aclc, ibdev, ibport, gid, ismdev);
+	rc = smc_connect_clc(smc, smc_type, &aclc, &ini);
 	if (rc) {
-		smc_connect_ism_vlan_cleanup(smc, ism_supported, ismdev, vlan);
+		smc_connect_ism_vlan_cleanup(smc, ism_supported, &ini);
 		return smc_connect_decline_fallback(smc, rc);
 	}
 
 	/* depending on previous steps, connect using rdma or ism */
 	if (rdma_supported && aclc.hdr.path == SMC_TYPE_R)
-		rc = smc_connect_rdma(smc, &aclc, ibdev, ibport);
+		rc = smc_connect_rdma(smc, &aclc, &ini);
 	else if (ism_supported && aclc.hdr.path == SMC_TYPE_D)
-		rc = smc_connect_ism(smc, &aclc, ismdev);
+		rc = smc_connect_ism(smc, &aclc, &ini);
 	else
 		rc = SMC_CLC_DECL_MODEUNSUPP;
 	if (rc) {
-		smc_connect_ism_vlan_cleanup(smc, ism_supported, ismdev, vlan);
+		smc_connect_ism_vlan_cleanup(smc, ism_supported, &ini);
 		return smc_connect_decline_fallback(smc, rc);
 	}
 
-	smc_connect_ism_vlan_cleanup(smc, ism_supported, ismdev, vlan);
+	smc_connect_ism_vlan_cleanup(smc, ism_supported, &ini);
 	return 0;
 }
 
@@ -1119,13 +1113,10 @@ static int smc_listen_prfx_check(struct smc_sock *new_smc,
 
 /* listen worker: initialize connection and buffers */
 static int smc_listen_rdma_init(struct smc_sock *new_smc,
-				struct smc_clc_msg_proposal *pclc,
-				struct smc_ib_device *ibdev, u8 ibport,
-				int *local_contact)
+				struct smc_init_info *ini, int *local_contact)
 {
 	/* allocate connection / link group */
-	*local_contact = smc_conn_create(new_smc, false, 0, ibdev, ibport, 0,
-					 &pclc->lcl, NULL, 0);
+	*local_contact = smc_conn_create(new_smc, ini);
 	if (*local_contact < 0) {
 		if (*local_contact == -ENOMEM)
 			return SMC_CLC_DECL_MEM;/* insufficient memory*/
@@ -1142,14 +1133,14 @@ static int smc_listen_rdma_init(struct smc_sock *new_smc,
 /* listen worker: initialize connection and buffers for SMC-D */
 static int smc_listen_ism_init(struct smc_sock *new_smc,
 			       struct smc_clc_msg_proposal *pclc,
-			       struct smcd_dev *ismdev,
+			       struct smc_init_info *ini,
 			       int *local_contact)
 {
 	struct smc_clc_msg_smcd *pclc_smcd;
 
 	pclc_smcd = smc_get_clc_msg_smcd(pclc);
-	*local_contact = smc_conn_create(new_smc, true, 0, NULL, 0, 0, NULL,
-					 ismdev, pclc_smcd->gid);
+	ini->ism_gid = pclc_smcd->gid;
+	*local_contact = smc_conn_create(new_smc, ini);
 	if (*local_contact < 0) {
 		if (*local_contact == -ENOMEM)
 			return SMC_CLC_DECL_MEM;/* insufficient memory*/
@@ -1232,15 +1223,12 @@ static void smc_listen_work(struct work_struct *work)
 	struct socket *newclcsock = new_smc->clcsock;
 	struct smc_clc_msg_accept_confirm cclc;
 	struct smc_clc_msg_proposal *pclc;
-	struct smc_ib_device *ibdev;
+	struct smc_init_info ini = {0};
 	bool ism_supported = false;
-	struct smcd_dev *ismdev;
 	u8 buf[SMC_CLC_MAX_LEN];
 	int local_contact = 0;
-	unsigned short vlan;
 	int reason_code = 0;
 	int rc = 0;
-	u8 ibport;
 
 	if (new_smc->use_fallback) {
 		smc_listen_out_connected(new_smc);
@@ -1284,20 +1272,26 @@ static void smc_listen_work(struct work_struct *work)
 	smc_rx_init(new_smc);
 	smc_tx_init(new_smc);
 
+	/* prepare ISM check */
+	ini.is_smcd = true;
 	/* check if ISM is available */
 	if ((pclc->hdr.path == SMC_TYPE_D || pclc->hdr.path == SMC_TYPE_B) &&
-	    !smc_check_ism(new_smc, &ismdev) &&
-	    !smc_listen_ism_init(new_smc, pclc, ismdev, &local_contact)) {
+	    !smc_check_ism(new_smc, &ini) &&
+	    !smc_listen_ism_init(new_smc, pclc, &ini, &local_contact)) {
 		ism_supported = true;
+	} else {
+		/* prepare RDMA check */
+		memset(&ini, 0, sizeof(ini));
+		ini.is_smcd = false;
+		ini.ib_lcl = &pclc->lcl;
 	}
 
 	/* check if RDMA is available */
 	if (!ism_supported &&
 	    ((pclc->hdr.path != SMC_TYPE_R && pclc->hdr.path != SMC_TYPE_B) ||
-	     smc_vlan_by_tcpsk(new_smc->clcsock, &vlan) ||
-	     smc_check_rdma(new_smc, &ibdev, &ibport, vlan, NULL) ||
-	     smc_listen_rdma_init(new_smc, pclc, ibdev, ibport,
-				  &local_contact) ||
+	     smc_vlan_by_tcpsk(new_smc->clcsock, &ini) ||
+	     smc_check_rdma(new_smc, &ini) ||
+	     smc_listen_rdma_init(new_smc, &ini, &local_contact) ||
 	     smc_listen_rdma_reg(new_smc, local_contact))) {
 		/* SMC not supported, decline */
 		mutex_unlock(&smc_server_lgr_pending);
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index d53fd588d1f5..745afd82f281 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -385,8 +385,7 @@ int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info)
 
 /* send CLC PROPOSAL message across internal TCP socket */
 int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
-			  struct smc_ib_device *ibdev, u8 ibport, u8 gid[],
-			  struct smcd_dev *ismdev)
+			  struct smc_init_info *ini)
 {
 	struct smc_clc_ipv6_prefix ipv6_prfx[SMC_CLC_MAX_V6_PREFIX];
 	struct smc_clc_msg_proposal_prefix pclc_prfx;
@@ -416,8 +415,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
 		/* add SMC-R specifics */
 		memcpy(pclc.lcl.id_for_peer, local_systemid,
 		       sizeof(local_systemid));
-		memcpy(&pclc.lcl.gid, gid, SMC_GID_SIZE);
-		memcpy(&pclc.lcl.mac, &ibdev->mac[ibport - 1], ETH_ALEN);
+		memcpy(&pclc.lcl.gid, ini->ib_gid, SMC_GID_SIZE);
+		memcpy(&pclc.lcl.mac, &ini->ib_dev->mac[ini->ib_port - 1],
+		       ETH_ALEN);
 		pclc.iparea_offset = htons(0);
 	}
 	if (smc_type == SMC_TYPE_D || smc_type == SMC_TYPE_B) {
@@ -425,7 +425,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
 		memset(&pclc_smcd, 0, sizeof(pclc_smcd));
 		plen += sizeof(pclc_smcd);
 		pclc.iparea_offset = htons(SMC_CLC_PROPOSAL_MAX_OFFSET);
-		pclc_smcd.gid = ismdev->local_gid;
+		pclc_smcd.gid = ini->ism_dev->local_gid;
 	}
 	pclc.hdr.length = htons(plen);
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index f251bed2e7d5..0ac3b95e71a3 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -180,6 +180,7 @@ smc_get_clc_msg_smcd(struct smc_clc_msg_proposal *prop)
 }
 
 struct smcd_dev;
+struct smc_init_info;
 
 int smc_clc_prfx_match(struct socket *clcsock,
 		       struct smc_clc_msg_proposal_prefix *prop);
@@ -187,8 +188,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		     u8 expected_type, unsigned long timeout);
 int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info);
 int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
-			  struct smc_ib_device *smcibdev, u8 ibport, u8 gid[],
-			  struct smcd_dev *ismdev);
+			  struct smc_init_info *ini);
 int smc_clc_send_confirm(struct smc_sock *smc);
 int smc_clc_send_accept(struct smc_sock *smc, int srv_first_contact);
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 53a17cfa61af..a016665abba9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -195,10 +195,7 @@ static void smc_lgr_free_work(struct work_struct *work)
 }
 
 /* create a new SMC link group */
-static int smc_lgr_create(struct smc_sock *smc, bool is_smcd,
-			  struct smc_ib_device *smcibdev, u8 ibport,
-			  char *peer_systemid, unsigned short vlan_id,
-			  struct smcd_dev *smcismdev, u64 peer_gid)
+static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	struct smc_link_group *lgr;
 	struct smc_link *lnk;
@@ -206,8 +203,8 @@ static int smc_lgr_create(struct smc_sock *smc, bool is_smcd,
 	int rc = 0;
 	int i;
 
-	if (is_smcd && vlan_id) {
-		rc = smc_ism_get_vlan(smcismdev, vlan_id);
+	if (ini->is_smcd && ini->vlan_id) {
+		rc = smc_ism_get_vlan(ini->ism_dev, ini->vlan_id);
 		if (rc)
 			goto out;
 	}
@@ -217,9 +214,9 @@ static int smc_lgr_create(struct smc_sock *smc, bool is_smcd,
 		rc = -ENOMEM;
 		goto out;
 	}
-	lgr->is_smcd = is_smcd;
+	lgr->is_smcd = ini->is_smcd;
 	lgr->sync_err = 0;
-	lgr->vlan_id = vlan_id;
+	lgr->vlan_id = ini->vlan_id;
 	rwlock_init(&lgr->sndbufs_lock);
 	rwlock_init(&lgr->rmbs_lock);
 	rwlock_init(&lgr->conns_lock);
@@ -231,29 +228,32 @@ static int smc_lgr_create(struct smc_sock *smc, bool is_smcd,
 	memcpy(&lgr->id, (u8 *)&smc_lgr_list.num, SMC_LGR_ID_SIZE);
 	INIT_DELAYED_WORK(&lgr->free_work, smc_lgr_free_work);
 	lgr->conns_all = RB_ROOT;
-	if (is_smcd) {
+	if (ini->is_smcd) {
 		/* SMC-D specific settings */
-		lgr->peer_gid = peer_gid;
-		lgr->smcd = smcismdev;
+		lgr->peer_gid = ini->ism_gid;
+		lgr->smcd = ini->ism_dev;
 	} else {
 		/* SMC-R specific settings */
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
-		memcpy(lgr->peer_systemid, peer_systemid, SMC_SYSTEMID_LEN);
+		memcpy(lgr->peer_systemid, ini->ib_lcl->id_for_peer,
+		       SMC_SYSTEMID_LEN);
 
 		lnk = &lgr->lnk[SMC_SINGLE_LINK];
 		/* initialize link */
 		lnk->state = SMC_LNK_ACTIVATING;
 		lnk->link_id = SMC_SINGLE_LINK;
-		lnk->smcibdev = smcibdev;
-		lnk->ibport = ibport;
-		lnk->path_mtu = smcibdev->pattr[ibport - 1].active_mtu;
-		if (!smcibdev->initialized)
-			smc_ib_setup_per_ibdev(smcibdev);
+		lnk->smcibdev = ini->ib_dev;
+		lnk->ibport = ini->ib_port;
+		lnk->path_mtu =
+			ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
+		if (!ini->ib_dev->initialized)
+			smc_ib_setup_per_ibdev(ini->ib_dev);
 		get_random_bytes(rndvec, sizeof(rndvec));
 		lnk->psn_initial = rndvec[0] + (rndvec[1] << 8) +
 			(rndvec[2] << 16);
 		rc = smc_ib_determine_gid(lnk->smcibdev, lnk->ibport,
-					  vlan_id, lnk->gid, &lnk->sgid_index);
+					  ini->vlan_id, lnk->gid,
+					  &lnk->sgid_index);
 		if (rc)
 			goto free_lgr;
 		rc = smc_llc_link_init(lnk);
@@ -528,13 +528,13 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 /* Determine vlan of internal TCP socket.
  * @vlan_id: address to store the determined vlan id into
  */
-int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id)
+int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini)
 {
 	struct dst_entry *dst = sk_dst_get(clcsock->sk);
 	struct net_device *ndev;
 	int i, nest_lvl, rc = 0;
 
-	*vlan_id = 0;
+	ini->vlan_id = 0;
 	if (!dst) {
 		rc = -ENOTCONN;
 		goto out;
@@ -546,7 +546,7 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id)
 
 	ndev = dst->dev;
 	if (is_vlan_dev(ndev)) {
-		*vlan_id = vlan_dev_vlan_id(ndev);
+		ini->vlan_id = vlan_dev_vlan_id(ndev);
 		goto out_rel;
 	}
 
@@ -560,7 +560,7 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id)
 		lower = lower->next;
 		ndev = (struct net_device *)netdev_lower_get_next(ndev, &lower);
 		if (is_vlan_dev(ndev)) {
-			*vlan_id = vlan_dev_vlan_id(ndev);
+			ini->vlan_id = vlan_dev_vlan_id(ndev);
 			break;
 		}
 	}
@@ -594,24 +594,20 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 }
 
 /* create a new SMC connection (and a new link group if necessary) */
-int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
-		    struct smc_ib_device *smcibdev, u8 ibport, u32 clcqpn,
-		    struct smc_clc_msg_local *lcl, struct smcd_dev *smcd,
-		    u64 peer_gid)
+int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	struct smc_connection *conn = &smc->conn;
 	int local_contact = SMC_FIRST_CONTACT;
 	struct smc_link_group *lgr;
-	unsigned short vlan_id;
 	enum smc_lgr_role role;
 	int rc = 0;
 
 	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
-	rc = smc_vlan_by_tcpsk(smc->clcsock, &vlan_id);
+	rc = smc_vlan_by_tcpsk(smc->clcsock, ini);
 	if (rc)
 		return rc;
 
-	if ((role == SMC_CLNT) && srv_first_contact)
+	if (role == SMC_CLNT && ini->srv_first_contact)
 		/* create new link group as well */
 		goto create;
 
@@ -619,10 +615,11 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry(lgr, &smc_lgr_list.list, list) {
 		write_lock_bh(&lgr->conns_lock);
-		if ((is_smcd ? smcd_lgr_match(lgr, smcd, peer_gid) :
-		     smcr_lgr_match(lgr, lcl, role, clcqpn)) &&
+		if ((ini->is_smcd ?
+		     smcd_lgr_match(lgr, ini->ism_dev, ini->ism_gid) :
+		     smcr_lgr_match(lgr, ini->ib_lcl, role, ini->ib_clcqpn)) &&
 		    !lgr->sync_err &&
-		    lgr->vlan_id == vlan_id &&
+		    lgr->vlan_id == ini->vlan_id &&
 		    (role == SMC_CLNT ||
 		     lgr->conns_num < SMC_RMBS_PER_LGR_MAX)) {
 			/* link group found */
@@ -638,8 +635,8 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 	}
 	spin_unlock_bh(&smc_lgr_list.lock);
 
-	if (role == SMC_CLNT && !srv_first_contact &&
-	    (local_contact == SMC_FIRST_CONTACT)) {
+	if (role == SMC_CLNT && !ini->srv_first_contact &&
+	    local_contact == SMC_FIRST_CONTACT) {
 		/* Server reuses a link group, but Client wants to start
 		 * a new one
 		 * send out_of_sync decline, reason synchr. error
@@ -649,8 +646,7 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 
 create:
 	if (local_contact == SMC_FIRST_CONTACT) {
-		rc = smc_lgr_create(smc, is_smcd, smcibdev, ibport,
-				    lcl->id_for_peer, vlan_id, smcd, peer_gid);
+		rc = smc_lgr_create(smc, ini);
 		if (rc)
 			goto out;
 		smc_lgr_register_conn(conn); /* add smc conn to lgr */
@@ -658,7 +654,7 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
 	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
 	conn->urg_state = SMC_URG_READ;
-	if (is_smcd) {
+	if (ini->is_smcd) {
 		conn->rx_off = sizeof(struct smcd_cdc_msg);
 		smcd_cdc_rx_init(conn); /* init tasklet for this conn */
 	}
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 8806d2afa6ed..e0628cb71e16 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -229,6 +229,23 @@ struct smc_link_group {
 	};
 };
 
+struct smc_clc_msg_local;
+
+struct smc_init_info {
+	u8			is_smcd;
+	unsigned short		vlan_id;
+	int			srv_first_contact;
+	/* SMC-R */
+	struct smc_clc_msg_local *ib_lcl;
+	struct smc_ib_device	*ib_dev;
+	u8			ib_gid[SMC_GID_SIZE];
+	u8			ib_port;
+	u32			ib_clcqpn;
+	/* SMC-D */
+	u64			ism_gid;
+	struct smcd_dev		*ism_dev;
+};
+
 /* Find the connection associated with the given alert token in the link group.
  * To use rbtrees we have to implement our own search core.
  * Requires @conns_lock
@@ -281,13 +298,10 @@ void smc_sndbuf_sync_sg_for_cpu(struct smc_connection *conn);
 void smc_sndbuf_sync_sg_for_device(struct smc_connection *conn);
 void smc_rmb_sync_sg_for_cpu(struct smc_connection *conn);
 void smc_rmb_sync_sg_for_device(struct smc_connection *conn);
-int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id);
+int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini);
 
 void smc_conn_free(struct smc_connection *conn);
-int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
-		    struct smc_ib_device *smcibdev, u8 ibport, u32 clcqpn,
-		    struct smc_clc_msg_local *lcl, struct smcd_dev *smcd,
-		    u64 peer_gid);
+int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini);
 void smcd_conn_free(struct smc_connection *conn);
 void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr);
 void smc_core_exit(void);
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 3cdf81cf97a3..2b246b94a3af 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -26,6 +26,7 @@
 #include "smc_pnet.h"
 #include "smc_ib.h"
 #include "smc_ism.h"
+#include "smc_core.h"
 
 #define SMC_ASCII_BLANK 32
 
@@ -755,8 +756,7 @@ static int smc_pnet_find_ndev_pnetid_by_table(struct net_device *ndev,
  * IB device and port
  */
 static void smc_pnet_find_rdma_dev(struct net_device *netdev,
-				   struct smc_ib_device **smcibdev,
-				   u8 *ibport, unsigned short vlan_id, u8 gid[])
+				   struct smc_init_info *ini)
 {
 	struct smc_ib_device *ibdev;
 
@@ -776,10 +776,10 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
 			dev_put(ndev);
 			if (netdev == ndev &&
 			    smc_ib_port_active(ibdev, i) &&
-			    !smc_ib_determine_gid(ibdev, i, vlan_id, gid,
-						  NULL)) {
-				*smcibdev = ibdev;
-				*ibport = i;
+			    !smc_ib_determine_gid(ibdev, i, ini->vlan_id,
+						  ini->ib_gid, NULL)) {
+				ini->ib_dev = ibdev;
+				ini->ib_port = i;
 				break;
 			}
 		}
@@ -794,9 +794,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
  * If nothing found, try to use handshake device
  */
 static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
-					 struct smc_ib_device **smcibdev,
-					 u8 *ibport, unsigned short vlan_id,
-					 u8 gid[])
+					 struct smc_init_info *ini)
 {
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
 	struct smc_ib_device *ibdev;
@@ -806,7 +804,7 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
 				   ndev_pnetid) &&
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
-		smc_pnet_find_rdma_dev(ndev, smcibdev, ibport, vlan_id, gid);
+		smc_pnet_find_rdma_dev(ndev, ini);
 		return; /* pnetid could not be determined */
 	}
 
@@ -817,10 +815,10 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 				continue;
 			if (smc_pnet_match(ibdev->pnetid[i - 1], ndev_pnetid) &&
 			    smc_ib_port_active(ibdev, i) &&
-			    !smc_ib_determine_gid(ibdev, i, vlan_id, gid,
-						  NULL))  {
-				*smcibdev = ibdev;
-				*ibport = i;
+			    !smc_ib_determine_gid(ibdev, i, ini->vlan_id,
+						  ini->ib_gid, NULL)) {
+				ini->ib_dev = ibdev;
+				ini->ib_port = i;
 				goto out;
 			}
 		}
@@ -830,7 +828,7 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 }
 
 static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
-					struct smcd_dev **smcismdev)
+					struct smc_init_info *ini)
 {
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
 	struct smcd_dev *ismdev;
@@ -844,7 +842,7 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
 	spin_lock(&smcd_dev_list.lock);
 	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
 		if (smc_pnet_match(ismdev->pnetid, ndev_pnetid)) {
-			*smcismdev = ismdev;
+			ini->ism_dev = ismdev;
 			break;
 		}
 	}
@@ -855,21 +853,18 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
  * determine ib_device and port belonging to used internal TCP socket
  * ethernet interface.
  */
-void smc_pnet_find_roce_resource(struct sock *sk,
-				 struct smc_ib_device **smcibdev, u8 *ibport,
-				 unsigned short vlan_id, u8 gid[])
+void smc_pnet_find_roce_resource(struct sock *sk, struct smc_init_info *ini)
 {
 	struct dst_entry *dst = sk_dst_get(sk);
 
-	*smcibdev = NULL;
-	*ibport = 0;
-
+	ini->ib_dev = NULL;
+	ini->ib_port = 0;
 	if (!dst)
 		goto out;
 	if (!dst->dev)
 		goto out_rel;
 
-	smc_pnet_find_roce_by_pnetid(dst->dev, smcibdev, ibport, vlan_id, gid);
+	smc_pnet_find_roce_by_pnetid(dst->dev, ini);
 
 out_rel:
 	dst_release(dst);
@@ -877,17 +872,17 @@ void smc_pnet_find_roce_resource(struct sock *sk,
 	return;
 }
 
-void smc_pnet_find_ism_resource(struct sock *sk, struct smcd_dev **smcismdev)
+void smc_pnet_find_ism_resource(struct sock *sk, struct smc_init_info *ini)
 {
 	struct dst_entry *dst = sk_dst_get(sk);
 
-	*smcismdev = NULL;
+	ini->ism_dev = NULL;
 	if (!dst)
 		goto out;
 	if (!dst->dev)
 		goto out_rel;
 
-	smc_pnet_find_ism_by_pnetid(dst->dev, smcismdev);
+	smc_pnet_find_ism_by_pnetid(dst->dev, ini);
 
 out_rel:
 	dst_release(dst);
diff --git a/net/smc/smc_pnet.h b/net/smc/smc_pnet.h
index 5eac42fb45d0..4564e4d69c2e 100644
--- a/net/smc/smc_pnet.h
+++ b/net/smc/smc_pnet.h
@@ -18,6 +18,7 @@
 
 struct smc_ib_device;
 struct smcd_dev;
+struct smc_init_info;
 
 /**
  * struct smc_pnettable - SMC PNET table anchor
@@ -43,9 +44,7 @@ int smc_pnet_init(void) __init;
 int smc_pnet_net_init(struct net *net);
 void smc_pnet_exit(void);
 void smc_pnet_net_exit(struct net *net);
-void smc_pnet_find_roce_resource(struct sock *sk,
-				 struct smc_ib_device **smcibdev, u8 *ibport,
-				 unsigned short vlan_id, u8 gid[]);
-void smc_pnet_find_ism_resource(struct sock *sk, struct smcd_dev **smcismdev);
+void smc_pnet_find_roce_resource(struct sock *sk, struct smc_init_info *ini);
+void smc_pnet_find_ism_resource(struct sock *sk, struct smc_init_info *ini);
 
 #endif
-- 
2.16.4
