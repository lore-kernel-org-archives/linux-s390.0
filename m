From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: restrict non-blocking connect finish
Date: Wed,  2 May 2018 16:53:56 +0200
Message-ID: <20180502145356.32913-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The smc_poll code tries to finish connect() if the socket is in
state SMC_INIT and polling of the internal CLC-socket returns with
EPOLLOUT. This makes sense for a select/poll call following a connect
call, but not without preceding connect().
With this patch smc_poll starts connect logic only, if the CLC-socket
is no longer in its initial state TCP_CLOSE.

In addition, a poll error on the internal CLC-socket is always
propagated to the SMC socket.

With this patch the code path mentioned by syzbot
https://syzkaller.appspot.com/bug?extid=03faa2dc16b8b64be396
is no longer possible.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Reported-by: syzbot+03faa2dc16b8b64be396@syzkaller.appspotmail.com
---
 net/smc/af_smc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 4470501374bf..8b4c059bd13b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1166,13 +1166,15 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 		/* delegate to CLC child sock */
 		release_sock(sk);
 		mask = smc->clcsock->ops->poll(file, smc->clcsock, wait);
-		/* if non-blocking connect finished ... */
 		lock_sock(sk);
-		if ((sk->sk_state == SMC_INIT) && (mask & EPOLLOUT)) {
-			sk->sk_err = smc->clcsock->sk->sk_err;
-			if (sk->sk_err) {
-				mask |= EPOLLERR;
-			} else {
+		sk->sk_err = smc->clcsock->sk->sk_err;
+		if (sk->sk_err) {
+			mask |= EPOLLERR;
+		} else {
+			/* if non-blocking connect finished ... */
+			if (sk->sk_state == SMC_INIT &&
+			    mask & EPOLLOUT &&
+			    smc->clcsock->sk->sk_state != TCP_CLOSE) {
 				rc = smc_connect_rdma(smc);
 				if (rc < 0)
 					mask |= EPOLLERR;
-- 
2.13.5
