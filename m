Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 5/8] net/smc: cleanup of get vlan id
Date: Fri, 12 Apr 2019 12:57:27 +0200
In-Reply-To: <20190412105730.96245-1-ubraun@linux.ibm.com>
References: <20190412105730.96245-1-ubraun@linux.ibm.com>
Message-Id: <20190412105730.96245-6-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

The vlan_id of the underlying CLC socket was retrieved two times
during processing of the listen handshaking. Change this to get the
vlan id one time in connect and in listen processing, and reuse the id.
And add a new CLC DECLINE return code for the case when the retrieval
of the vlan id failed.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   | 11 +++++++++--
 net/smc/smc_clc.h  |  1 +
 net/smc/smc_core.c |  4 ----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b45372879a70..8ec971f6d828 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -699,9 +699,10 @@ static int __smc_connect(struct smc_sock *smc)
 	if (using_ipsec(smc))
 		return smc_connect_decline_fallback(smc, SMC_CLC_DECL_IPSEC);
 
-	/* check for VLAN ID */
+	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(smc->clcsock, &ini))
-		return smc_connect_decline_fallback(smc, SMC_CLC_DECL_CNFERR);
+		return smc_connect_decline_fallback(smc,
+						    SMC_CLC_DECL_GETVLANERR);
 
 	/* check if there is an ism device available */
 	if (!smc_check_ism(smc, &ini) &&
@@ -1267,6 +1268,12 @@ static void smc_listen_work(struct work_struct *work)
 		return;
 	}
 
+	/* get vlan id from IP device */
+	if (smc_vlan_by_tcpsk(new_smc->clcsock, &ini)) {
+		smc_listen_decline(new_smc, SMC_CLC_DECL_GETVLANERR, 0);
+		return;
+	}
+
 	mutex_lock(&smc_server_lgr_pending);
 	smc_close_init(new_smc);
 	smc_rx_init(new_smc);
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 0ac3b95e71a3..96a9eab0a0aa 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -39,6 +39,7 @@
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
 #define SMC_CLC_DECL_DIFFPREFIX	0x03070000  /* IP prefix / subnet mismatch    */
+#define SMC_CLC_DECL_GETVLANERR	0x03080000  /* err to get vlan id of ip device*/
 #define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
 #define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
 #define SMC_CLC_DECL_INTERR	0x09990000  /* internal error		      */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a016665abba9..1574c7d7343b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -603,10 +603,6 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	int rc = 0;
 
 	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
-	rc = smc_vlan_by_tcpsk(smc->clcsock, ini);
-	if (rc)
-		return rc;
-
 	if (role == SMC_CLNT && ini->srv_first_contact)
 		/* create new link group as well */
 		goto create;
-- 
2.16.4
