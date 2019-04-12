Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 3/8] net/smc: check for ip prefix and subnet
Date: Fri, 12 Apr 2019 12:57:25 +0200
In-Reply-To: <20190412105730.96245-1-ubraun@linux.ibm.com>
References: <20190412105730.96245-1-ubraun@linux.ibm.com>
Message-Id: <20190412105730.96245-4-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

The check for a matching ip prefix and subnet was only done for SMC-R
in smc_listen_rdma_check() but not when an SMC-D connection was
possible. Rename the function into smc_listen_prfx_check() and move its
call to a place where it is called for both SMC variants.
And add a new CLC DECLINE reason for the case when the IP prefix or
subnet check fails so the reason for the failing SMC connection can be
found out more easily.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  | 12 +++++++++---
 net/smc/smc_clc.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e1b7b5bdb440..cb8bc77c75d6 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1104,7 +1104,7 @@ static void smc_listen_decline(struct smc_sock *new_smc, int reason_code,
 }
 
 /* listen worker: check prefixes */
-static int smc_listen_rdma_check(struct smc_sock *new_smc,
+static int smc_listen_prfx_check(struct smc_sock *new_smc,
 				 struct smc_clc_msg_proposal *pclc)
 {
 	struct smc_clc_msg_proposal_prefix *pclc_prfx;
@@ -1112,7 +1112,7 @@ static int smc_listen_rdma_check(struct smc_sock *new_smc,
 
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
 	if (smc_clc_prfx_match(newclcsock, pclc_prfx))
-		return SMC_CLC_DECL_CNFERR;
+		return SMC_CLC_DECL_DIFFPREFIX;
 
 	return 0;
 }
@@ -1272,6 +1272,13 @@ static void smc_listen_work(struct work_struct *work)
 		return;
 	}
 
+	/* check for matching IP prefix and subnet length */
+	rc = smc_listen_prfx_check(new_smc, pclc);
+	if (rc) {
+		smc_listen_decline(new_smc, rc, 0);
+		return;
+	}
+
 	mutex_lock(&smc_server_lgr_pending);
 	smc_close_init(new_smc);
 	smc_rx_init(new_smc);
@@ -1289,7 +1296,6 @@ static void smc_listen_work(struct work_struct *work)
 	    ((pclc->hdr.path != SMC_TYPE_R && pclc->hdr.path != SMC_TYPE_B) ||
 	     smc_vlan_by_tcpsk(new_smc->clcsock, &vlan) ||
 	     smc_check_rdma(new_smc, &ibdev, &ibport, vlan, NULL) ||
-	     smc_listen_rdma_check(new_smc, pclc) ||
 	     smc_listen_rdma_init(new_smc, pclc, ibdev, ibport,
 				  &local_contact) ||
 	     smc_listen_rdma_reg(new_smc, local_contact))) {
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 6c94d54e7a67..f251bed2e7d5 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -38,6 +38,7 @@
 #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
+#define SMC_CLC_DECL_DIFFPREFIX	0x03070000  /* IP prefix / subnet mismatch    */
 #define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
 #define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
 #define SMC_CLC_DECL_INTERR	0x09990000  /* internal error		      */
-- 
2.16.4
