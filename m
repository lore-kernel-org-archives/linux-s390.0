Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 3/3] net/smc: reset recv timeout after clc handshake
Date: Wed, 18 Jul 2018 15:22:51 +0200
In-Reply-To: <20180718132251.7222-1-ubraun@linux.ibm.com>
References: <20180718132251.7222-1-ubraun@linux.ibm.com>
Message-Id: <20180718132251.7222-4-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

During clc handshake the receive timeout is set to CLC_WAIT_TIME.
Remember and reset the original timeout value after the receive calls,
and remove a duplicate assignment of CLC_WAIT_TIME.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 717449b1da0b..ae5d168653ce 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -250,6 +250,7 @@ int smc_clc_prfx_match(struct socket *clcsock,
 int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		     u8 expected_type)
 {
+	long rcvtimeo = smc->clcsock->sk->sk_rcvtimeo;
 	struct sock *clc_sk = smc->clcsock->sk;
 	struct smc_clc_msg_hdr *clcm = buf;
 	struct msghdr msg = {NULL, 0};
@@ -306,7 +307,6 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	memset(&msg, 0, sizeof(struct msghdr));
 	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1, datlen);
 	krflags = MSG_WAITALL;
-	smc->clcsock->sk->sk_rcvtimeo = CLC_WAIT_TIME;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (len < datlen || !smc_clc_msg_hdr_valid(clcm)) {
 		smc->sk.sk_err = EPROTO;
@@ -322,6 +322,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	}
 
 out:
+	smc->clcsock->sk->sk_rcvtimeo = rcvtimeo;
 	return reason_code;
 }
 
-- 
2.16.4
