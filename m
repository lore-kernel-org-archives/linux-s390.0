Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/3] net/smc: allow sysctl rmem and wmem defaults for servers
Date: Wed,  8 Aug 2018 14:13:20 +0200
In-Reply-To: <20180808121321.516-1-ubraun@linux.ibm.com>
References: <20180808121321.516-1-ubraun@linux.ibm.com>
Message-Id: <20180808121321.516-3-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Without setsockopt SO_SNDBUF and SO_RCVBUF settings, the sysctl
defaults net.ipv4.tcp_wmem and net.ipv4.tcp_rmem should be the base
for the sizes of the SMC sndbuf and rcvbuf. Any TCP buffer size
optimizations for servers should be ignored.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1288c7bf40d5..0ee7721afbe5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1122,6 +1122,8 @@ static void smc_tcp_listen_work(struct work_struct *work)
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
+		new_smc->sk.sk_sndbuf = lsmc->sk.sk_sndbuf;
+		new_smc->sk.sk_rcvbuf = lsmc->sk.sk_rcvbuf;
 		sock_hold(&new_smc->sk); /* sock_put in passive closing */
 		if (!schedule_work(&new_smc->smc_listen_work))
 			sock_put(&new_smc->sk);
-- 
2.16.4
