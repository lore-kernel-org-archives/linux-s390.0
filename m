Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 4/5] net/smc: no urgent data check for listen sockets
Date: Tue, 18 Sep 2018 15:46:37 +0200
In-Reply-To: <20180918134638.90271-1-ubraun@linux.ibm.com>
References: <20180918134638.90271-1-ubraun@linux.ibm.com>
Message-Id: <20180918134638.90271-5-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Don't check a listen socket for pending urgent data in smc_poll().

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5c6d30eb4a71..015231789ed2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1566,9 +1566,9 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 				mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 			if (sk->sk_state == SMC_APPCLOSEWAIT1)
 				mask |= EPOLLIN;
+			if (smc->conn.urg_state == SMC_URG_VALID)
+				mask |= EPOLLPRI;
 		}
-		if (smc->conn.urg_state == SMC_URG_VALID)
-			mask |= EPOLLPRI;
 	}
 
 	return mask;
-- 
2.16.4
