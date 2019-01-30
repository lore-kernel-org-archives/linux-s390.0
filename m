Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 7/9] net/smc: call smc_cdc_msg_send() under send_lock
Date: Wed, 30 Jan 2019 18:51:06 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-8-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Call smc_cdc_msg_send() under the connection send_lock to make sure all
send operations for one connection are serialized.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index db83332ac1c8..1c5333d494e9 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -125,7 +125,10 @@ static int smcr_cdc_get_slot_and_msg_send(struct smc_connection *conn)
 	if (rc)
 		return rc;
 
-	return smc_cdc_msg_send(conn, wr_buf, pend);
+	spin_lock_bh(&conn->send_lock);
+	rc = smc_cdc_msg_send(conn, wr_buf, pend);
+	spin_unlock_bh(&conn->send_lock);
+	return rc;
 }
 
 int smc_cdc_get_slot_and_msg_send(struct smc_connection *conn)
-- 
2.16.4
