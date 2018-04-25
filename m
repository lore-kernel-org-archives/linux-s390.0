From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: keep clcsock reference in smc_tcp_listen_work()
Date: Wed, 25 Apr 2018 12:48:58 +0200
Message-ID: <20180425104858.48953-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The internal CLC socket should exist till the SMC-socket is released.
Function tcp_listen_worker() releases the internal CLC socket of a
listen socket, if an smc_close_active() is called. This function
is called for the final release(), but it is called for shutdown
SHUT_RDWR as well. This opens a door for protection faults, if
socket calls using the internal CLC socket are called for a
shutdown listen socket.

With the changes of
commit 3d502067599f ("net/smc: simplify wait when closing listen socket")
there is no need anymore to release the internal CLC socket in
function tcp_listen_worker((). It is sufficient to release it in
smc_release().

Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Reported-by: syzbot+9045fc589fcd196ef522@syzkaller.appspotmail.com
Reported-by: syzbot+28a2c86cf19c81d871fa@syzkaller.appspotmail.com
Reported-by: syzbot+9605e6cace1b5efd4a0a@syzkaller.appspotmail.com
Reported-by: syzbot+cf9012c597c8379d535c@syzkaller.appspotmail.com
---
 net/smc/af_smc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f5d4b69dbabc..4470501374bf 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -978,10 +978,6 @@ static void smc_tcp_listen_work(struct work_struct *work)
 	}
 
 out:
-	if (lsmc->clcsock) {
-		sock_release(lsmc->clcsock);
-		lsmc->clcsock = NULL;
-	}
 	release_sock(lsk);
 	sock_put(&lsmc->sk); /* sock_hold in smc_listen */
 }
-- 
2.13.5
