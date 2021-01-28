Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/5] net/af_iucv: build SG skbs for TRANS_HIPER sockets
Date: Thu, 28 Jan 2021 12:41:08 +0100
Message-Id: <20210128114108.39409-6-jwi@linux.ibm.com>
In-Reply-To: <20210128114108.39409-1-jwi@linux.ibm.com>
References: <20210128114108.39409-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The TX path no longer falls apart when some of its SG skbs are later
linearized by lower layers of the stack. So enable the use of SG skbs
in iucv_sock_sendmsg() again.

This effectively reverts
commit dc5367bcc556 ("net/af_iucv: don't use paged skbs for TX on HiperSockets").

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 0e0656db4ae7..6092d5cb7168 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -256,7 +256,9 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 			err = -EMSGSIZE;
 			goto err_free;
 		}
-		skb_trim(skb, skb->dev->mtu);
+		err = pskb_trim(skb, skb->dev->mtu);
+		if (err)
+			goto err_free;
 	}
 	skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 
@@ -996,7 +998,7 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (iucv->transport == AF_IUCV_TRANS_HIPER) {
 		headroom = sizeof(struct af_iucv_trans_hdr) +
 			   LL_RESERVED_SPACE(iucv->hs_dev);
-		linear = len;
+		linear = min(len, PAGE_SIZE - headroom);
 	} else {
 		if (len < PAGE_SIZE) {
 			linear = len;
-- 
2.17.1
