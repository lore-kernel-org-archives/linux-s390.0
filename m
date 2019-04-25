Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/8] s390/qeth: extract helper to determine L2 cast type
Date: Thu, 25 Apr 2019 18:26:00 +0200
In-Reply-To: <20190425162601.91997-1-jwi@linux.ibm.com>
References: <20190425162601.91997-1-jwi@linux.ibm.com>
Message-Id: <20190425162601.91997-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This de-duplicates the L2 and L3 cast-type code, and makes the L2 code
a bit more robust by removing the fragile assumption that skb->data
always points to the Ethernet Header. This would break in code paths
where we pushed the HW header onto the skb.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    | 10 ++++++++++
 drivers/s390/net/qeth_l2_main.c | 14 +++-----------
 drivers/s390/net/qeth_l3_main.c |  8 +-------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 73afbb8b69e5..784a2e76a1b0 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -881,6 +881,16 @@ static inline int qeth_get_ip_version(struct sk_buff *skb)
 	}
 }
 
+static inline int qeth_get_ether_cast_type(struct sk_buff *skb)
+{
+	u8 *addr = eth_hdr(skb)->h_dest;
+
+	if (is_multicast_ether_addr(addr))
+		return is_broadcast_ether_addr(addr) ? RTN_BROADCAST :
+						       RTN_MULTICAST;
+	return RTN_UNICAST;
+}
+
 static inline void qeth_rx_csum(struct qeth_card *card, struct sk_buff *skb,
 				u8 flags)
 {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index cee9a99dd463..218801232ca2 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -161,15 +161,6 @@ static void qeth_l2_drain_rx_mode_cache(struct qeth_card *card)
 	}
 }
 
-static int qeth_l2_get_cast_type(struct sk_buff *skb)
-{
-	if (is_broadcast_ether_addr(skb->data))
-		return RTN_BROADCAST;
-	if (is_multicast_ether_addr(skb->data))
-		return RTN_MULTICAST;
-	return RTN_UNICAST;
-}
-
 static void qeth_l2_fill_header(struct qeth_qdio_out_q *queue,
 				struct qeth_hdr *hdr, struct sk_buff *skb,
 				int ipv, int cast_type, unsigned int data_len)
@@ -611,7 +602,8 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 		rc = qeth_l2_xmit_osn(card, skb, queue);
 	else
 		rc = qeth_xmit(card, skb, queue, qeth_get_ip_version(skb),
-			       qeth_l2_get_cast_type(skb), qeth_l2_fill_header);
+			       qeth_get_ether_cast_type(skb),
+			       qeth_l2_fill_header);
 
 	if (!rc) {
 		QETH_TXQ_STAT_INC(queue, tx_packets);
@@ -631,7 +623,7 @@ static u16 qeth_l2_select_queue(struct net_device *dev, struct sk_buff *skb,
 
 	if (IS_IQD(card))
 		return qeth_iqd_select_queue(dev, skb,
-					     qeth_l2_get_cast_type(skb),
+					     qeth_get_ether_cast_type(skb),
 					     sb_dev);
 	return qeth_get_priority_queue(card, skb);
 }
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8fd634229871..b5d76ebb488a 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1918,13 +1918,7 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 				RTN_MULTICAST : RTN_UNICAST;
 	default:
 		/* ... and MAC address */
-		if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
-					    skb->dev->broadcast))
-			return RTN_BROADCAST;
-		if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
-			return RTN_MULTICAST;
-		/* default to unicast */
-		return RTN_UNICAST;
+		return qeth_get_ether_cast_type(skb);
 	}
 }
 
-- 
2.16.4
