Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 29 Jul 2019 09:59:47 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net/af_iucv: mark expected switch fall-throughs
Message-ID: <20190729145947.GA9494@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

net/iucv/af_iucv.c: warning: this statement may fall
through [-Wimplicit-fallthrough=]:  => 537:3, 519:6, 2246:6, 510:6

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/iucv/af_iucv.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 09e1694b6d34..ebb62a4ebe30 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -512,7 +512,9 @@ static void iucv_sock_close(struct sock *sk)
 			sk->sk_state = IUCV_DISCONN;
 			sk->sk_state_change(sk);
 		}
-	case IUCV_DISCONN:   /* fall through */
+		/* fall through */
+
+	case IUCV_DISCONN:
 		sk->sk_state = IUCV_CLOSING;
 		sk->sk_state_change(sk);
 
@@ -525,8 +527,9 @@ static void iucv_sock_close(struct sock *sk)
 					iucv_sock_in_state(sk, IUCV_CLOSED, 0),
 					timeo);
 		}
+		/* fall through */
 
-	case IUCV_CLOSING:   /* fall through */
+	case IUCV_CLOSING:
 		sk->sk_state = IUCV_CLOSED;
 		sk->sk_state_change(sk);
 
@@ -535,8 +538,9 @@ static void iucv_sock_close(struct sock *sk)
 
 		skb_queue_purge(&iucv->send_skb_q);
 		skb_queue_purge(&iucv->backlog_skb_q);
+		/* fall through */
 
-	default:   /* fall through */
+	default:
 		iucv_sever_path(sk, 1);
 	}
 
@@ -2247,10 +2251,10 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 			kfree_skb(skb);
 			break;
 		}
-		/* fall through and receive non-zero length data */
+		/* fall through - and receive non-zero length data */
 	case (AF_IUCV_FLAG_SHT):
 		/* shutdown request */
-		/* fall through and receive zero length data */
+		/* fall through - and receive zero length data */
 	case 0:
 		/* plain data frame */
 		IUCV_SKB_CB(skb)->class = trans_hdr->iucv_hdr.class;
-- 
2.22.0
