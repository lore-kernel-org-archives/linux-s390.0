From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/6] smc: improve smc_clc_send_decline() error handling
Date: Thu,  7 Dec 2017 13:38:45 +0100
Message-ID: <20171207123849.52910-3-ubraun@linux.vnet.ibm.com>
References: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Let smc_clc_send_decline() return with an error, if the amount
sent is smaller than the length of an smc decline message.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c  | 9 +++------
 net/smc/smc_clc.c | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6451c5013e06..d3ae0d5b1677 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -520,7 +520,7 @@ static int smc_connect_rdma(struct smc_sock *smc)
 	smc->use_fallback = true;
 	if (reason_code && (reason_code != SMC_CLC_DECL_REPLY)) {
 		rc = smc_clc_send_decline(smc, reason_code);
-		if (rc < sizeof(struct smc_clc_msg_decline))
+		if (rc < 0)
 			goto out_err;
 	}
 	goto out_connected;
@@ -879,11 +879,9 @@ static void smc_listen_work(struct work_struct *work)
 		}
 		/* QP confirmation over RoCE fabric */
 		reason_code = smc_serv_conf_first_link(new_smc);
-		if (reason_code < 0) {
+		if (reason_code < 0)
 			/* peer is not aware of a problem */
-			rc = reason_code;
 			goto out_err_unlock;
-		}
 		if (reason_code > 0)
 			goto decline_rdma_unlock;
 	}
@@ -916,8 +914,7 @@ static void smc_listen_work(struct work_struct *work)
 	smc_conn_free(&new_smc->conn);
 	new_smc->use_fallback = true;
 	if (reason_code && (reason_code != SMC_CLC_DECL_REPLY)) {
-		rc = smc_clc_send_decline(new_smc, reason_code);
-		if (rc < sizeof(struct smc_clc_msg_decline))
+		if (smc_clc_send_decline(new_smc, reason_code) < 0)
 			goto out_err;
 	}
 	goto out_connected;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 1800e16b2a02..f5e17d29112b 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -133,7 +133,7 @@ int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info)
 		smc->sk.sk_err = EPROTO;
 	if (len < 0)
 		smc->sk.sk_err = -len;
-	return len;
+	return sock_error(&smc->sk);
 }
 
 /* send CLC PROPOSAL message across internal TCP socket */
-- 
2.13.5
