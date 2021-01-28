Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhA1L0o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:26:44 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/5] s390/qeth: pass proto to qeth_l3_get_cast_type()
Date: Thu, 28 Jan 2021 12:25:49 +0100
Message-Id: <20210128112551.18780-4-jwi@linux.ibm.com>
In-Reply-To: <20210128112551.18780-1-jwi@linux.ibm.com>
References: <20210128112551.18780-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_l3_hard_start_xmit() already determined the skb's proto. Avoid
doing so a second time when it calls qeth_l3_get_cast_type().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 7a7465376e29..4921afb51a1c 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1610,9 +1610,8 @@ static int qeth_l3_get_cast_type_rcu(struct sk_buff *skb, struct dst_entry *dst,
 	}
 }
 
-static int qeth_l3_get_cast_type(struct sk_buff *skb)
+static int qeth_l3_get_cast_type(struct sk_buff *skb, __be16 proto)
 {
-	__be16 proto = vlan_get_protocol(skb);
 	struct dst_entry *dst;
 	int cast_type;
 
@@ -1771,7 +1770,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	}
 
 	if (!(dev->flags & IFF_BROADCAST) &&
-	    qeth_l3_get_cast_type(skb) == RTN_BROADCAST)
+	    qeth_l3_get_cast_type(skb, proto) == RTN_BROADCAST)
 		goto tx_drop;
 
 	if (proto == htons(ETH_P_IP) || IS_IQD(card))
@@ -1831,8 +1830,10 @@ static netdev_features_t qeth_l3_osa_features_check(struct sk_buff *skb,
 static u16 qeth_l3_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
 				    struct net_device *sb_dev)
 {
-	return qeth_iqd_select_queue(dev, skb, qeth_l3_get_cast_type(skb),
-				     sb_dev);
+	__be16 proto = vlan_get_protocol(skb);
+
+	return qeth_iqd_select_queue(dev, skb,
+				     qeth_l3_get_cast_type(skb, proto), sb_dev);
 }
 
 static u16 qeth_l3_osa_select_queue(struct net_device *dev, struct sk_buff *skb,
-- 
2.17.1
