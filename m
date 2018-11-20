From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net V4 1/5] net/smc: abort CLC connection in smc_release
Date: Tue, 20 Nov 2018 16:46:39 +0100
Message-ID: <20181120154643.24111-2-ubraun@linux.ibm.com>
References: <20181120154643.24111-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181120154643.24111-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

In case of a non-blocking SMC socket, the initial CLC handshake is
performed over a blocking TCP connection in a worker. If the SMC socket
is released, smc_release has to wait for the blocking CLC socket
operations (e.g., kernel_connect) inside the worker.

This patch aborts a CLC connection when the respective non-blocking SMC
socket is released to avoid waiting on socket operations or timeouts.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 80e2119f1c70..84f67f601838 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -127,6 +127,8 @@ static int smc_release(struct socket *sock)
 	smc = smc_sk(sk);
 
 	/* cleanup for a dangling non-blocking connect */
+	if (smc->connect_info && sk->sk_state == SMC_INIT)
+		tcp_abort(smc->clcsock->sk, ECONNABORTED);
 	flush_work(&smc->connect_work);
 	kfree(smc->connect_info);
 	smc->connect_info = NULL;
-- 
2.16.4
