Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 4/9] net/smc: don't wait for send buffer space when data was already sent
Date: Wed, 30 Jan 2019 18:51:03 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-5-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When there is no more send buffer space and at least 1 byte was already
sent then return to user space. The wait is only done when no data was
sent by the sendmsg() call.
This fixes smc_tx_sendmsg() which tried to always send all user data and
started to wait for free send buffer space when needed. During this wait
the user space program was blocked in the sendmsg() call and hence not
able to receive incoming data. When both sides were in such a situation
then the connection stalled forever.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_tx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index d8366ed51757..f99951f3f7fd 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -165,12 +165,11 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 			conn->local_tx_ctrl.prod_flags.urg_data_pending = 1;
 
 		if (!atomic_read(&conn->sndbuf_space) || conn->urg_tx_pend) {
+			if (send_done)
+				return send_done;
 			rc = smc_tx_wait(smc, msg->msg_flags);
-			if (rc) {
-				if (send_done)
-					return send_done;
+			if (rc)
 				goto out_err;
-			}
 			continue;
 		}
 
-- 
2.16.4
