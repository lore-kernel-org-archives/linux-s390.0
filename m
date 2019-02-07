Return-Path: <SRS0=t9U+=QO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 3/7] net/smc: use smc_curs_copy() for SMC-D
Date: Thu,  7 Feb 2019 15:56:16 +0100
In-Reply-To: <20190207145620.92811-1-ubraun@linux.ibm.com>
References: <20190207145620.92811-1-ubraun@linux.ibm.com>
Message-Id: <20190207145620.92811-4-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

SMC already provides a wrapper for atomic64 calls to be
architecture independent. Use this wrapper for SMC-D as well.

Reported-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index b5bfe38c7f9b..e8c214b992b6 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -245,17 +245,18 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 }
 
 static inline void smcd_cdc_msg_to_host(struct smc_host_cdc_msg *local,
-					struct smcd_cdc_msg *peer)
+					struct smcd_cdc_msg *peer,
+					struct smc_connection *conn)
 {
 	union smc_host_cursor temp;
 
 	temp.wrap = peer->prod.wrap;
 	temp.count = peer->prod.count;
-	atomic64_set(&local->prod.acurs, atomic64_read(&temp.acurs));
+	smc_curs_copy(&local->prod, &temp, conn);
 
 	temp.wrap = peer->cons.wrap;
 	temp.count = peer->cons.count;
-	atomic64_set(&local->cons.acurs, atomic64_read(&temp.acurs));
+	smc_curs_copy(&local->cons, &temp, conn);
 	local->prod_flags = peer->cons.prod_flags;
 	local->conn_state_flags = peer->cons.conn_state_flags;
 }
@@ -265,7 +266,7 @@ static inline void smc_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 				       struct smc_connection *conn)
 {
 	if (conn->lgr->is_smcd)
-		smcd_cdc_msg_to_host(local, (struct smcd_cdc_msg *)peer);
+		smcd_cdc_msg_to_host(local, (struct smcd_cdc_msg *)peer, conn);
 	else
 		smcr_cdc_msg_to_host(local, peer, conn);
 }
-- 
2.16.4
