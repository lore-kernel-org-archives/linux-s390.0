Return-Path: <SRS0=K4f4=Q4=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: fix smc_poll in SMC_INIT state
Date: Thu, 21 Feb 2019 12:56:54 +0100
Message-Id: <20190221115654.3889-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

smc_poll() returns with mask bit EPOLLPRI if the connection urg_state
is SMC_URG_VALID. Since SMC_URG_VALID is zero, smc_poll signals
EPOLLPRI errorneously if called in state SMC_INIT before the connection
is created, for instance in a non-blocking connect scenario.

This patch switches to non-zero values for the urg states.

Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Fixes: de8474eb9d50 ("net/smc: urgent data support")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 5721416d0605..adbdf195eb08 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -113,9 +113,9 @@ struct smc_host_cdc_msg {		/* Connection Data Control message */
 } __aligned(8);
 
 enum smc_urg_state {
-	SMC_URG_VALID,			/* data present */
-	SMC_URG_NOTYET,			/* data pending */
-	SMC_URG_READ			/* data was already read */
+	SMC_URG_VALID	= 1,			/* data present */
+	SMC_URG_NOTYET	= 2,			/* data pending */
+	SMC_URG_READ	= 3,			/* data was already read */
 };
 
 struct smc_connection {
-- 
2.16.4
