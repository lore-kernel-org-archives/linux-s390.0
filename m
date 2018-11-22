From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 07/10] net/smc: cleanup listen worker mutex unlocking
Date: Thu, 22 Nov 2018 10:26:40 +0100
Message-ID: <20181122092643.26820-8-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

For easier reading move the unlock of mutex smc_create_lgr_pending into
smc_listen_work(), i.e. into the function the mutex has been locked.
No functional change.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 93f7ff8f6e88..7657e249f526 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1182,7 +1182,6 @@ static int smc_listen_rdma_finish(struct smc_sock *new_smc,
 	return 0;
 
 decline:
-	mutex_unlock(&smc_create_lgr_pending);
 	smc_listen_decline(new_smc, reason_code, local_contact);
 	return reason_code;
 }
@@ -1282,8 +1281,10 @@ static void smc_listen_work(struct work_struct *work)
 
 	/* finish worker */
 	if (!ism_supported) {
-		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
+		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact)) {
+			mutex_unlock(&smc_create_lgr_pending);
 			return;
+		}
 	}
 	smc_conn_save_peer_info(new_smc, &cclc);
 	mutex_unlock(&smc_create_lgr_pending);
-- 
2.16.4
