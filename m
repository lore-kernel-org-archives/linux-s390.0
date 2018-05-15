From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 01/10] net/smc: no tx work trigger for fallback sockets
Date: Tue, 15 May 2018 17:04:54 +0200
Message-ID: <20180515150503.47265-2-ubraun@linux.ibm.com>
References: <20180515150503.47265-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515150503.47265-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If TCP_NODELAY is set or TCP_CORK is reset, setsockopt triggers the
tx worker. This does not make sense, if the SMC socket switched to
the TCP fallback when the connection is created. This patch adds
the additional check for the fallback case.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 17688a02035b..83403be46a4a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1353,14 +1353,14 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		break;
 	case TCP_NODELAY:
 		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
-			if (val)
+			if (val && !smc->use_fallback)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);
 		}
 		break;
 	case TCP_CORK:
 		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
-			if (!val)
+			if (!val && !smc->use_fallback)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);
 		}
-- 
2.16.3
