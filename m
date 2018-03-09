Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 07/12] s390/qeth: reduce RX skb setup
Date: Fri,  9 Mar 2018 18:12:58 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-8-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Newly-allocated skbs default to PACKET_HOST, and eth_type_trans() is
smart enough to determine any other packet type from the frame's
destination address.
So except for the IQD sniffer case, there is no need to set up
skb->pkt_type manually.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c |  1 -
 drivers/s390/net/qeth_l3_main.c | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 95bf452fc51b..09768677222b 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -439,7 +439,6 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
 		}
 		switch (hdr->hdr.l2.id) {
 		case QETH_HEADER_TYPE_LAYER2:
-			skb->pkt_type = PACKET_HOST;
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			if ((card->dev->features & NETIF_F_RXCSUM)
 			   && ((hdr->hdr.l2.flags[1] &
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 283cbdcc5d6b..c302274bab22 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1502,23 +1502,17 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 				ipv6_eth_mc_map(&ipv6_hdr(skb)->daddr, tg_addr);
 
 			card->stats.multicast++;
-			skb->pkt_type = PACKET_MULTICAST;
 			break;
 		case QETH_CAST_BROADCAST:
 			ether_addr_copy(tg_addr, card->dev->broadcast);
 			card->stats.multicast++;
-			skb->pkt_type = PACKET_BROADCAST;
 			break;
-		case QETH_CAST_UNICAST:
-		case QETH_CAST_ANYCAST:
-		case QETH_CAST_NOCAST:
 		default:
 			if (card->options.sniffer)
 				skb->pkt_type = PACKET_OTHERHOST;
-			else
-				skb->pkt_type = PACKET_HOST;
 			ether_addr_copy(tg_addr, card->dev->dev_addr);
 		}
+
 		if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_SRC_MAC_ADDR)
 			card->dev->header_ops->create(skb, card->dev, prot,
 				tg_addr, &hdr->hdr.l3.next_hop.rx.src_mac,
@@ -1578,7 +1572,6 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 			if ((card->info.type == QETH_CARD_TYPE_IQD) &&
 			    (magic == ETH_P_AF_IUCV)) {
 				skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
-				skb->pkt_type = PACKET_HOST;
 				len = skb->len;
 				card->dev->header_ops->create(skb, card->dev, 0,
 					card->dev->dev_addr, "FAKELL", len);
@@ -1591,7 +1584,6 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 			}
 			break;
 		case QETH_HEADER_TYPE_LAYER2: /* for HiperSockets sniffer */
-			skb->pkt_type = PACKET_HOST;
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			len = skb->len;
 			netif_receive_skb(skb);
-- 
2.13.5
