From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 3/4] net/smc: handle ioctls SIOCINQ, SIOCOUTQ, and SIOCOUTQNSD
Date: Mon, 30 Apr 2018 16:51:18 +0200
Message-ID: <20180430145119.72479-4-ubraun@linux.ibm.com>
References: <20180430145119.72479-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180430145119.72479-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

SIOCINQ returns the amount of unread data in the RMB.
SIOCOUTQ returns the amount of unsent or unacked sent data in the send
buffer.
SIOCOUTQNSD returns the amount of data prepared for sending, but
not yet sent.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 961b8eff9553..823ea3371575 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -29,6 +29,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/smc.h>
+#include <asm/ioctls.h>
 
 #include "smc.h"
 #include "smc_clc.h"
@@ -1389,12 +1390,38 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		     unsigned long arg)
 {
 	struct smc_sock *smc;
+	int answ;
 
 	smc = smc_sk(sock->sk);
-	if (smc->use_fallback)
+	if (smc->use_fallback) {
+		if (!smc->clcsock)
+			return -EBADF;
 		return smc->clcsock->ops->ioctl(smc->clcsock, cmd, arg);
-	else
-		return sock_no_ioctl(sock, cmd, arg);
+	}
+	switch (cmd) {
+	case SIOCINQ: /* same as FIONREAD */
+		if (smc->sk.sk_state == SMC_LISTEN)
+			return -EINVAL;
+		answ = atomic_read(&smc->conn.bytes_to_rcv);
+		break;
+	case SIOCOUTQ:
+		/* output queue size (not send + not acked) */
+		if (smc->sk.sk_state == SMC_LISTEN)
+			return -EINVAL;
+		answ = smc->conn.sndbuf_size -
+					atomic_read(&smc->conn.sndbuf_space);
+		break;
+	case SIOCOUTQNSD:
+		/* output queue size (not send only) */
+		if (smc->sk.sk_state == SMC_LISTEN)
+			return -EINVAL;
+		answ = smc_tx_prepared_sends(&smc->conn);
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return put_user(answ, (int __user *)arg);
 }
 
 static ssize_t smc_sendpage(struct socket *sock, struct page *page,
-- 
2.13.5
