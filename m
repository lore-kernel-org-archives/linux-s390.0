From: frank.blaschka@de.ibm.com
Subject: [patch 1/4] af_iucv: recvmsg problem for SOCK_STREAM sockets
Date: Wed, 19 Mar 2014 07:57:59 +0100
Message-ID: <20140319065813.285865119@de.ibm.com>
References: <20140319065758.841490297@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=600-af-iucv-recvmsg.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Commit f9c41a62bba3f3f7ef3541b2a025e3371bcbba97 introduced
a problem for SOCK_STREAM sockets, when only part of the
incoming iucv message is received by user space. In this
case the remaining data of the iucv message is lost.
This patch makes sure an incompletely received iucv message
is queued back to the receive queue.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Reported-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 net/iucv/af_iucv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index c4b7218..a5e0311 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1382,6 +1382,7 @@ static int iucv_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 		if (sk->sk_type == SOCK_STREAM) {
 			if (copied < rlen) {
 				IUCV_SKB_CB(skb)->offset = offset + copied;
+				skb_queue_head(&sk->sk_receive_queue, skb);
 				goto done;
 			}
 		}
