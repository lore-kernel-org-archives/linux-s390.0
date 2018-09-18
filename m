Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/5] net/smc: fix non-blocking connect problem
Date: Tue, 18 Sep 2018 15:46:34 +0200
In-Reply-To: <20180918134638.90271-1-ubraun@linux.ibm.com>
References: <20180918134638.90271-1-ubraun@linux.ibm.com>
Message-Id: <20180918134638.90271-2-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In state SMC_INIT smc_poll() delegates polling to the internal
CLC socket. This means, once the connect worker has finished
its kernel_connect() step, the poll wake-up may occur. This is not
intended. The wake-up should occur from the wake up call in
smc_connect_work() after __smc_connect() has finished.
Thus in state SMC_INIT this patch now calls sock_poll_wait() on the
main SMC socket.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 2d8a1e15e4f9..9c3976bcde46 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -742,7 +742,10 @@ static void smc_connect_work(struct work_struct *work)
 		smc->sk.sk_err = -rc;
 
 out:
-	smc->sk.sk_state_change(&smc->sk);
+	if (smc->sk.sk_err)
+		smc->sk.sk_state_change(&smc->sk);
+	else
+		smc->sk.sk_write_space(&smc->sk);
 	kfree(smc->connect_info);
 	smc->connect_info = NULL;
 	release_sock(&smc->sk);
@@ -1529,7 +1532,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 		return EPOLLNVAL;
 
 	smc = smc_sk(sock->sk);
-	if ((sk->sk_state == SMC_INIT) || smc->use_fallback) {
+	if (smc->use_fallback) {
 		/* delegate to CLC child sock */
 		mask = smc->clcsock->ops->poll(file, smc->clcsock, wait);
 		sk->sk_err = smc->clcsock->sk->sk_err;
-- 
2.16.4
