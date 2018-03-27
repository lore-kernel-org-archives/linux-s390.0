From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 1/1] net/smc: use announced length in sock_recvmsg()
Date: Tue, 27 Mar 2018 10:43:50 +0200
Message-ID: <20180327084350.92847-2-ubraun@linux.vnet.ibm.com>
References: <20180327084350.92847-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180327084350.92847-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Not every CLC proposal message needs the maximum buffer length.
Due to the MSG_WAITALL flag, it is important to use the peeked
real length when receiving the message.

Fixes: d63d271ce2b5ce ("smc: switch to sock_recvmsg()")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_clc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 8ac51583a063..15c213250606 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -133,7 +133,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 
 	/* receive the complete CLC message */
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1, buflen);
+	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1, datlen);
 	krflags = MSG_WAITALL;
 	smc->clcsock->sk->sk_rcvtimeo = CLC_WAIT_TIME;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
-- 
2.13.5
