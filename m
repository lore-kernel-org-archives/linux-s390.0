Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbfFRSnS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jun 2019 14:43:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IIgsZQ046881
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 14:43:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t73p7d2tw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 14:43:17 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 18 Jun 2019 19:43:15 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/3] net/af_iucv: build proper skbs for HiperTransport
Date: Tue, 18 Jun 2019 20:43:00 +0200
In-Reply-To: <20190618184301.96472-1-jwi@linux.ibm.com>
References: <20190618184301.96472-1-jwi@linux.ibm.com>
Message-Id: <20190618184301.96472-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The HiperSockets-based transport path in af_iucv is still too closely
entangled with qeth.
With commit a647a02512ca ("s390/qeth: speed-up L3 IQD xmit"), the
relevant xmit code in qeth has begun to use skb_cow_head(). So to avoid
unnecessary skb head expansions, af_iucv must learn to
1) respect dev->needed_headroom when allocating skbs, and
2) drop the header reference before cloning the skb.

While at it, also stop hard-coding the LL-header creation stage and just
use the appropriate helper.

Fixes: a647a02512ca ("s390/qeth: speed-up L3 IQD xmit")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 2ee68d2d4693..5264a182d2c3 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/errno.h>
@@ -347,14 +348,14 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	if (imsg)
 		memcpy(&phs_hdr->iucv_hdr, imsg, sizeof(struct iucv_message));
 
-	skb_push(skb, ETH_HLEN);
-	memset(skb->data, 0, ETH_HLEN);
-
 	skb->dev = iucv->hs_dev;
 	if (!skb->dev) {
 		err = -ENODEV;
 		goto err_free;
 	}
+
+	dev_hard_header(skb, skb->dev, ETH_P_AF_IUCV, NULL, NULL, skb->len);
+
 	if (!(skb->dev->flags & IFF_UP) || !netif_carrier_ok(skb->dev)) {
 		err = -ENETDOWN;
 		goto err_free;
@@ -367,6 +368,8 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 		skb_trim(skb, skb->dev->mtu);
 	}
 	skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
+
+	__skb_header_release(skb);
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (!nskb) {
 		err = -ENOMEM;
@@ -466,12 +469,14 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 /* Send controlling flags through an IUCV socket for HIPER transport */
 static int iucv_send_ctrl(struct sock *sk, u8 flags)
 {
+	struct iucv_sock *iucv = iucv_sk(sk);
 	int err = 0;
 	int blen;
 	struct sk_buff *skb;
 	u8 shutdown = 0;
 
-	blen = sizeof(struct af_iucv_trans_hdr) + ETH_HLEN;
+	blen = sizeof(struct af_iucv_trans_hdr) +
+	       LL_RESERVED_SPACE(iucv->hs_dev);
 	if (sk->sk_shutdown & SEND_SHUTDOWN) {
 		/* controlling flags should be sent anyway */
 		shutdown = sk->sk_shutdown;
@@ -1133,7 +1138,8 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	 * segmented records using the MSG_EOR flag), but
 	 * for SOCK_STREAM we might want to improve it in future */
 	if (iucv->transport == AF_IUCV_TRANS_HIPER) {
-		headroom = sizeof(struct af_iucv_trans_hdr) + ETH_HLEN;
+		headroom = sizeof(struct af_iucv_trans_hdr) +
+			   LL_RESERVED_SPACE(iucv->hs_dev);
 		linear = len;
 	} else {
 		if (len < PAGE_SIZE) {
-- 
2.17.1
