Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 05/12] s390/qeth: pass correct length to header_ops->create()
Date: Fri,  9 Mar 2018 18:12:56 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-6-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We need to pass the *payload* length, not the L2 address length.
For qeth (using eth_header()) this is merely a cosmetic change:
the parameter only matters when building headers for ETH_P_802_2
or ETH_P_802_3, whereas our fake headers are built with
ETH_P_IP / ETH_P_IPV6 / 0.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index e933a273d543..8e8818ea33e2 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1522,10 +1522,10 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 		if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_SRC_MAC_ADDR)
 			card->dev->header_ops->create(skb, card->dev, prot,
 				tg_addr, &hdr->hdr.l3.next_hop.rx.src_mac,
-				card->dev->addr_len);
+				skb->len);
 		else
 			card->dev->header_ops->create(skb, card->dev, prot,
-				tg_addr, "FAKELL", card->dev->addr_len);
+				tg_addr, "FAKELL", skb->len);
 	}
 
 	skb->protocol = eth_type_trans(skb, card->dev);
@@ -1584,8 +1584,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 				skb->dev = card->dev;
 				len = skb->len;
 				card->dev->header_ops->create(skb, card->dev, 0,
-					card->dev->dev_addr, "FAKELL",
-					card->dev->addr_len);
+					card->dev->dev_addr, "FAKELL", len);
 				netif_receive_skb(skb);
 			} else {
 				qeth_l3_rebuild_skb(card, skb, hdr);
-- 
2.13.5
