Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231462AbhA1Ll6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:41:58 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/5] net/af_iucv: don't lookup the socket on TX notification
Date: Thu, 28 Jan 2021 12:41:05 +0100
Message-Id: <20210128114108.39409-3-jwi@linux.ibm.com>
In-Reply-To: <20210128114108.39409-1-jwi@linux.ibm.com>
References: <20210128114108.39409-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Whoever called iucv_sk(sk)->sk_txnotify() must already know that they're
dealing with an af_iucv socket.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 427a1abce0a8..8683b6939f45 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2134,23 +2134,14 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 static void afiucv_hs_callback_txnotify(struct sk_buff *skb,
 					enum iucv_tx_notify n)
 {
-	struct sock *isk = skb->sk;
-	struct sock *sk = NULL;
-	struct iucv_sock *iucv = NULL;
+	struct iucv_sock *iucv = iucv_sk(skb->sk);
+	struct sock *sk = skb->sk;
 	struct sk_buff_head *list;
 	struct sk_buff *list_skb;
 	struct sk_buff *nskb;
 	unsigned long flags;
 
-	read_lock_irqsave(&iucv_sk_list.lock, flags);
-	sk_for_each(sk, &iucv_sk_list.head)
-		if (sk == isk) {
-			iucv = iucv_sk(sk);
-			break;
-		}
-	read_unlock_irqrestore(&iucv_sk_list.lock, flags);
-
-	if (!iucv || sock_flag(sk, SOCK_ZAPPED))
+	if (sock_flag(sk, SOCK_ZAPPED))
 		return;
 
 	list = &iucv->send_skb_q;
-- 
2.17.1
