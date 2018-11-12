From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/5] net/smc: use queue pair number when matching link group
Date: Mon, 12 Nov 2018 17:01:30 +0100
Message-ID: <20181112160133.16058-3-ubraun@linux.ibm.com>
References: <20181112160133.16058-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112160133.16058-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When searching for an existing link group the queue pair number is also
to be taken into consideration. When the SMC server sends a new number
in a CLC packet (keeping all other values equal) then a new link group
is to be created on the SMC client side.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   |  9 +++++----
 net/smc/smc_core.c | 10 ++++++----
 net/smc/smc_core.h |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 84f67f601838..5fbaf1901571 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -549,7 +549,8 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	mutex_lock(&smc_create_lgr_pending);
 	local_contact = smc_conn_create(smc, false, aclc->hdr.flag, ibdev,
-					ibport, &aclc->lcl, NULL, 0);
+					ibport, ntoh24(aclc->qpn), &aclc->lcl,
+					NULL, 0);
 	if (local_contact < 0) {
 		if (local_contact == -ENOMEM)
 			reason_code = SMC_CLC_DECL_MEM;/* insufficient memory*/
@@ -620,7 +621,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 	int rc = 0;
 
 	mutex_lock(&smc_create_lgr_pending);
-	local_contact = smc_conn_create(smc, true, aclc->hdr.flag, NULL, 0,
+	local_contact = smc_conn_create(smc, true, aclc->hdr.flag, NULL, 0, 0,
 					NULL, ismdev, aclc->gid);
 	if (local_contact < 0)
 		return smc_connect_abort(smc, SMC_CLC_DECL_MEM, 0);
@@ -1085,7 +1086,7 @@ static int smc_listen_rdma_init(struct smc_sock *new_smc,
 				int *local_contact)
 {
 	/* allocate connection / link group */
-	*local_contact = smc_conn_create(new_smc, false, 0, ibdev, ibport,
+	*local_contact = smc_conn_create(new_smc, false, 0, ibdev, ibport, 0,
 					 &pclc->lcl, NULL, 0);
 	if (*local_contact < 0) {
 		if (*local_contact == -ENOMEM)
@@ -1109,7 +1110,7 @@ static int smc_listen_ism_init(struct smc_sock *new_smc,
 	struct smc_clc_msg_smcd *pclc_smcd;
 
 	pclc_smcd = smc_get_clc_msg_smcd(pclc);
-	*local_contact = smc_conn_create(new_smc, true, 0, NULL, 0, NULL,
+	*local_contact = smc_conn_create(new_smc, true, 0, NULL, 0, 0, NULL,
 					 ismdev, pclc_smcd->gid);
 	if (*local_contact < 0) {
 		if (*local_contact == -ENOMEM)
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 18daebcef181..3c023de58afd 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -559,7 +559,7 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id)
 
 static bool smcr_lgr_match(struct smc_link_group *lgr,
 			   struct smc_clc_msg_local *lcl,
-			   enum smc_lgr_role role)
+			   enum smc_lgr_role role, u32 clcqpn)
 {
 	return !memcmp(lgr->peer_systemid, lcl->id_for_peer,
 		       SMC_SYSTEMID_LEN) &&
@@ -567,7 +567,9 @@ static bool smcr_lgr_match(struct smc_link_group *lgr,
 			SMC_GID_SIZE) &&
 		!memcmp(lgr->lnk[SMC_SINGLE_LINK].peer_mac, lcl->mac,
 			sizeof(lcl->mac)) &&
-		lgr->role == role;
+		lgr->role == role &&
+		(lgr->role == SMC_SERV ||
+		 lgr->lnk[SMC_SINGLE_LINK].peer_qpn == clcqpn);
 }
 
 static bool smcd_lgr_match(struct smc_link_group *lgr,
@@ -578,7 +580,7 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 
 /* create a new SMC connection (and a new link group if necessary) */
 int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
-		    struct smc_ib_device *smcibdev, u8 ibport,
+		    struct smc_ib_device *smcibdev, u8 ibport, u32 clcqpn,
 		    struct smc_clc_msg_local *lcl, struct smcd_dev *smcd,
 		    u64 peer_gid)
 {
@@ -603,7 +605,7 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 	list_for_each_entry(lgr, &smc_lgr_list.list, list) {
 		write_lock_bh(&lgr->conns_lock);
 		if ((is_smcd ? smcd_lgr_match(lgr, smcd, peer_gid) :
-		     smcr_lgr_match(lgr, lcl, role)) &&
+		     smcr_lgr_match(lgr, lcl, role, clcqpn)) &&
 		    !lgr->sync_err &&
 		    lgr->vlan_id == vlan_id &&
 		    (role == SMC_CLNT ||
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index c156674733c9..5bc6cbaf0ed5 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -262,7 +262,7 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id);
 
 void smc_conn_free(struct smc_connection *conn);
 int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
-		    struct smc_ib_device *smcibdev, u8 ibport,
+		    struct smc_ib_device *smcibdev, u8 ibport, u32 clcqpn,
 		    struct smc_clc_msg_local *lcl, struct smcd_dev *smcd,
 		    u64 peer_gid);
 void smcd_conn_free(struct smc_connection *conn);
-- 
2.16.4
