Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/4] s390/qeth: make af_iucv TX notification call more robust
Date: Fri, 20 Nov 2020 10:09:37 +0100
Message-Id: <20201120090939.101406-3-jwi@linux.ibm.com>
In-Reply-To: <20201120090939.101406-1-jwi@linux.ibm.com>
References: <20201120090939.101406-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Calling into socket code is ugly already, at least check whether we are
dealing with the expected sk_family. Only looking at skb->protocol is
bound to cause troubles (consider eg. af_packet).

Fixes: b333293058aa ("qeth: add support for af_iucv HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 93c9b30ab17a..715f440bdc7c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -33,6 +33,7 @@
 
 #include <net/iucv/af_iucv.h>
 #include <net/dsfield.h>
+#include <net/sock.h>
 
 #include <asm/ebcdic.h>
 #include <asm/chpid.h>
@@ -1405,7 +1406,7 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *q,
 	skb_queue_walk(&buf->skb_list, skb) {
 		QETH_CARD_TEXT_(q->card, 5, "skbn%d", notification);
 		QETH_CARD_TEXT_(q->card, 5, "%lx", (long) skb);
-		if (skb->protocol == htons(ETH_P_AF_IUCV) && skb->sk)
+		if (skb->sk && skb->sk->sk_family == PF_IUCV)
 			iucv_sk(skb->sk)->sk_txnotify(skb, notification);
 	}
 }
-- 
2.17.1
