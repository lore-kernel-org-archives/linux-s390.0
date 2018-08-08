Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/3] net/smc: no shutdown in state SMC_LISTEN
Date: Wed,  8 Aug 2018 14:13:19 +0200
In-Reply-To: <20180808121321.516-1-ubraun@linux.ibm.com>
References: <20180808121321.516-1-ubraun@linux.ibm.com>
Message-Id: <20180808121321.516-2-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Invoking shutdown for a socket in state SMC_LISTEN does not make
sense. Nevertheless programs like syzbot fuzzing the kernel may
try to do this. For SMC this means a socket refcounting problem.
This patch makes sure a shutdown call for an SMC socket in state
SMC_LISTEN simply returns with -ENOTCONN.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 05e4ffe5aabd..1288c7bf40d5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1397,8 +1397,7 @@ static int smc_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 
 	rc = -ENOTCONN;
-	if ((sk->sk_state != SMC_LISTEN) &&
-	    (sk->sk_state != SMC_ACTIVE) &&
+	if ((sk->sk_state != SMC_ACTIVE) &&
 	    (sk->sk_state != SMC_PEERCLOSEWAIT1) &&
 	    (sk->sk_state != SMC_PEERCLOSEWAIT2) &&
 	    (sk->sk_state != SMC_APPCLOSEWAIT1) &&
-- 
2.16.4
