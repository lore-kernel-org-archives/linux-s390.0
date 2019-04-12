Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 6/8] net/smc: code cleanup smc_listen_work
Date: Fri, 12 Apr 2019 12:57:28 +0200
In-Reply-To: <20190412105730.96245-1-ubraun@linux.ibm.com>
References: <20190412105730.96245-1-ubraun@linux.ibm.com>
Message-Id: <20190412105730.96245-7-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

In smc_listen_work() the variables rc and reason_code are defined which
have the same meaning. Eliminate reason_code in favor of the shorter
name rc. No functional changes.
Rename the functions smc_check_ism() and smc_check_rdma() into
smc_find_ism_device() and smc_find_rdma_device() to make there purpose
more clear. No functional changes.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8ec971f6d828..951af05708a7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -496,7 +496,7 @@ static int smc_connect_abort(struct smc_sock *smc, int reason_code,
 
 /* check if there is a rdma device available for this connection. */
 /* called for connect and listen */
-static int smc_check_rdma(struct smc_sock *smc, struct smc_init_info *ini)
+static int smc_find_rdma_device(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	/* PNET table look up: search active ib_device and port
 	 * within same PNETID that also contains the ethernet device
@@ -510,7 +510,7 @@ static int smc_check_rdma(struct smc_sock *smc, struct smc_init_info *ini)
 
 /* check if there is an ISM device available for this connection. */
 /* called for connect and listen */
-static int smc_check_ism(struct smc_sock *smc, struct smc_init_info *ini)
+static int smc_find_ism_device(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	/* Find ISM device with same PNETID as connecting interface  */
 	smc_pnet_find_ism_resource(smc->clcsock->sk, ini);
@@ -705,7 +705,7 @@ static int __smc_connect(struct smc_sock *smc)
 						    SMC_CLC_DECL_GETVLANERR);
 
 	/* check if there is an ism device available */
-	if (!smc_check_ism(smc, &ini) &&
+	if (!smc_find_ism_device(smc, &ini) &&
 	    !smc_connect_ism_vlan_setup(smc, &ini)) {
 		/* ISM is supported for this connection */
 		ism_supported = true;
@@ -713,7 +713,7 @@ static int __smc_connect(struct smc_sock *smc)
 	}
 
 	/* check if there is a rdma device available */
-	if (!smc_check_rdma(smc, &ini)) {
+	if (!smc_find_rdma_device(smc, &ini)) {
 		/* RDMA is supported for this connection */
 		rdma_supported = true;
 		if (ism_supported)
@@ -1228,7 +1228,6 @@ static void smc_listen_work(struct work_struct *work)
 	bool ism_supported = false;
 	u8 buf[SMC_CLC_MAX_LEN];
 	int local_contact = 0;
-	int reason_code = 0;
 	int rc = 0;
 
 	if (new_smc->use_fallback) {
@@ -1248,10 +1247,10 @@ static void smc_listen_work(struct work_struct *work)
 	 * wait for and receive SMC Proposal CLC message
 	 */
 	pclc = (struct smc_clc_msg_proposal *)&buf;
-	reason_code = smc_clc_wait_msg(new_smc, pclc, SMC_CLC_MAX_LEN,
-				       SMC_CLC_PROPOSAL, CLC_WAIT_TIME);
-	if (reason_code) {
-		smc_listen_decline(new_smc, reason_code, 0);
+	rc = smc_clc_wait_msg(new_smc, pclc, SMC_CLC_MAX_LEN,
+			      SMC_CLC_PROPOSAL, CLC_WAIT_TIME);
+	if (rc) {
+		smc_listen_decline(new_smc, rc, 0);
 		return;
 	}
 
@@ -1283,7 +1282,7 @@ static void smc_listen_work(struct work_struct *work)
 	ini.is_smcd = true;
 	/* check if ISM is available */
 	if ((pclc->hdr.path == SMC_TYPE_D || pclc->hdr.path == SMC_TYPE_B) &&
-	    !smc_check_ism(new_smc, &ini) &&
+	    !smc_find_ism_device(new_smc, &ini) &&
 	    !smc_listen_ism_init(new_smc, pclc, &ini, &local_contact)) {
 		ism_supported = true;
 	} else {
@@ -1297,7 +1296,7 @@ static void smc_listen_work(struct work_struct *work)
 	if (!ism_supported &&
 	    ((pclc->hdr.path != SMC_TYPE_R && pclc->hdr.path != SMC_TYPE_B) ||
 	     smc_vlan_by_tcpsk(new_smc->clcsock, &ini) ||
-	     smc_check_rdma(new_smc, &ini) ||
+	     smc_find_rdma_device(new_smc, &ini) ||
 	     smc_listen_rdma_init(new_smc, &ini, &local_contact) ||
 	     smc_listen_rdma_reg(new_smc, local_contact))) {
 		/* SMC not supported, decline */
@@ -1320,12 +1319,12 @@ static void smc_listen_work(struct work_struct *work)
 		mutex_unlock(&smc_server_lgr_pending);
 
 	/* receive SMC Confirm CLC message */
-	reason_code = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
-				       SMC_CLC_CONFIRM, CLC_WAIT_TIME);
-	if (reason_code) {
+	rc = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
+			      SMC_CLC_CONFIRM, CLC_WAIT_TIME);
+	if (rc) {
 		if (!ism_supported)
 			mutex_unlock(&smc_server_lgr_pending);
-		smc_listen_decline(new_smc, reason_code, local_contact);
+		smc_listen_decline(new_smc, rc, local_contact);
 		return;
 	}
 
-- 
2.16.4
