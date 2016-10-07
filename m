From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 1/2] Subject: [PATCH] af_iucv: enable control sends in case of SEND_SHUTDOWN
Date: Fri,  7 Oct 2016 15:51:47 +0200
Message-ID: <88ab8b08bdcf2f35fd04e9d0c67b250999d7da33.1475846599.git.ursula.braun@de.ibm.com>
References: <cover.1475846599.git.ursula.braun@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1475846599.git.ursula.braun@de.ibm.com>
In-Reply-To: <cover.1475846599.git.ursula.braun@de.ibm.com>
References: <cover.1475846599.git.ursula.braun@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If a socket program has shut down the socket for sending, it can still
receive an undetermined number of packets. The AF_IUCV protocol for
HIPER transport requires sending of a WIN flag from time to time
from the receiver to the sender, otherwise the peer cannot continue
sending. That means sending of control flags must still work, even
though the AF_IUCV socket is shutdown for sending data.
sock_alloc_send_skb() returns with error EPIPE, if socket sk_shutdown
is SEND_SHUTDOWN. Thus this patch temporarily removes the send
shutdown attribute from the socket to enable transfer of control
flags.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/iucv/af_iucv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 02b45a8..88d0eaa 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -453,19 +453,27 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 	}
 }
 
-/* Send FIN through an IUCV socket for HIPER transport */
+/* Send controlling flags through an IUCV socket for HIPER transport */
 static int iucv_send_ctrl(struct sock *sk, u8 flags)
 {
 	int err = 0;
 	int blen;
 	struct sk_buff *skb;
+	u8 shutdown = 0;
 
 	blen = sizeof(struct af_iucv_trans_hdr) + ETH_HLEN;
+	if (sk->sk_shutdown & SEND_SHUTDOWN) {
+		/* controlling flags should be sent anyway */
+		shutdown = sk->sk_shutdown;
+		sk->sk_shutdown &= RCV_SHUTDOWN;
+	}
 	skb = sock_alloc_send_skb(sk, blen, 1, &err);
 	if (skb) {
 		skb_reserve(skb, blen);
 		err = afiucv_hs_send(NULL, sk, skb, flags);
 	}
+	if (shutdown)
+		sk->sk_shutdown = shutdown;
 	return err;
 }
 
-- 
2.8.4
