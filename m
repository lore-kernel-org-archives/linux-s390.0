From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: fix shutdown in state SMC_LISTEN
Date: Thu, 19 Apr 2018 15:56:40 +0200
Message-ID: <20180419135640.2907-2-ubraun@linux.ibm.com>
References: <20180419135640.2907-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419135640.2907-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, stephen@networkplumber.org, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>

Calling shutdown with SHUT_RD and SHUT_RDWR for a listening SMC socket
crashes, because
   commit 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
releases the internal clcsock in smc_close_active() and sets smc->clcsock
to NULL.
For SHUT_RD the smc_close_active() call is removed.
For SHUT_RDWR the kernel_sock_shutdown() call is omitted, since the
clcsock is already released.

Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/smc/af_smc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5f8046c62d90..f5d4b69dbabc 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1259,14 +1259,12 @@ static int smc_shutdown(struct socket *sock, int how)
 		rc = smc_close_shutdown_write(smc);
 		break;
 	case SHUT_RD:
-		if (sk->sk_state == SMC_LISTEN)
-			rc = smc_close_active(smc);
-		else
-			rc = 0;
-			/* nothing more to do because peer is not involved */
+		rc = 0;
+		/* nothing more to do because peer is not involved */
 		break;
 	}
-	rc1 = kernel_sock_shutdown(smc->clcsock, how);
+	if (smc->clcsock)
+		rc1 = kernel_sock_shutdown(smc->clcsock, how);
 	/* map sock_shutdown_cmd constants to sk_shutdown value range */
 	sk->sk_shutdown |= how + 1;
 
-- 
2.13.5
