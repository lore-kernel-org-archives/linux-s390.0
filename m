Return-Path: <SRS0=t9U+=QO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/7] net/smc: unlock LGR pending lock earlier for SMC-D
Date: Thu,  7 Feb 2019 15:56:17 +0100
In-Reply-To: <20190207145620.92811-1-ubraun@linux.ibm.com>
References: <20190207145620.92811-1-ubraun@linux.ibm.com>
Message-Id: <20190207145620.92811-5-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

If SMC client and server connections are both established at the same
time, smc_connect_ism() cannot send a CLC confirm message while
smc_listen_work() is waiting for one due to lock contention. This can
result in timeouts in smc_clc_wait_msg() and failed SMC connections.

In case of SMC-D, the LGR pending lock is not needed while
smc_listen_work() is waiting for the CLC confirm message. So, this patch
releases the lock earlier for SMC-D to avoid the locking issue.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 60ccc8f50368..cf49ed05007b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1287,24 +1287,28 @@ static void smc_listen_work(struct work_struct *work)
 		return;
 	}
 
+	/* SMC-D does not need this lock any more */
+	if (ism_supported)
+		mutex_unlock(&smc_create_lgr_pending);
+
 	/* receive SMC Confirm CLC message */
 	reason_code = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
 				       SMC_CLC_CONFIRM, CLC_WAIT_TIME);
 	if (reason_code) {
-		mutex_unlock(&smc_create_lgr_pending);
+		if (!ism_supported)
+			mutex_unlock(&smc_create_lgr_pending);
 		smc_listen_decline(new_smc, reason_code, local_contact);
 		return;
 	}
 
 	/* finish worker */
 	if (!ism_supported) {
-		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact)) {
-			mutex_unlock(&smc_create_lgr_pending);
+		rc = smc_listen_rdma_finish(new_smc, &cclc, local_contact);
+		mutex_unlock(&smc_create_lgr_pending);
+		if (rc)
 			return;
-		}
 	}
 	smc_conn_save_peer_info(new_smc, &cclc);
-	mutex_unlock(&smc_create_lgr_pending);
 	smc_listen_out_connected(new_smc);
 }
 
-- 
2.16.4
