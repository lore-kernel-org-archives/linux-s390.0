Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 06/12] s390/qeth: allocate skb from NAPI cache
Date: Fri,  9 Mar 2018 18:12:57 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-7-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

napi_alloc_skb() doesn't need to disable IRQs during the allocation,
and thus may save us a few cycles.
Doing so requires a small fix-up in the HiperTransport path, which
currently assumes a fixed NET_SKB_PAD headroom padding. napi_alloc_skb()
adds an additional NET_IP_ALIGN padding, so use the proper helper for
setting up the mac_header offset.

Use this opportunity to convert the non-NAPI path to netdev_alloc_skb(),
which means that skb->dev is now always set-up during allocation and
doesn't need to be assigned manually.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +++--
 drivers/s390/net/qeth_l2_main.c   | 1 -
 drivers/s390/net/qeth_l3_main.c   | 4 +---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d884b399f92a..8f427621e656 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2835,7 +2835,8 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 	int i;
 
 	if ((card->options.cq == QETH_CQ_ENABLED) && (!buf->rx_skb)) {
-		buf->rx_skb = dev_alloc_skb(QETH_RX_PULL_LEN + ETH_HLEN);
+		buf->rx_skb = netdev_alloc_skb(card->dev,
+					       QETH_RX_PULL_LEN + ETH_HLEN);
 		if (!buf->rx_skb)
 			return 1;
 	}
@@ -5325,7 +5326,7 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 	} else {
 		unsigned int linear = (use_rx_sg) ? QETH_RX_PULL_LEN : skb_len;
 
-		skb = dev_alloc_skb(linear + headroom);
+		skb = napi_alloc_skb(&card->napi, linear + headroom);
 	}
 	if (!skb)
 		goto no_mem;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c7bc80b3a979..95bf452fc51b 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -437,7 +437,6 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
 			*done = 1;
 			break;
 		}
-		skb->dev = card->dev;
 		switch (hdr->hdr.l2.id) {
 		case QETH_HEADER_TYPE_LAYER2:
 			skb->pkt_type = PACKET_HOST;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8e8818ea33e2..283cbdcc5d6b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1572,7 +1572,6 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 			*done = 1;
 			break;
 		}
-		skb->dev = card->dev;
 		switch (hdr->hdr.l3.id) {
 		case QETH_HEADER_TYPE_LAYER3:
 			magic = *(__u16 *)skb->data;
@@ -1580,11 +1579,10 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 			    (magic == ETH_P_AF_IUCV)) {
 				skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 				skb->pkt_type = PACKET_HOST;
-				skb->mac_header = NET_SKB_PAD;
-				skb->dev = card->dev;
 				len = skb->len;
 				card->dev->header_ops->create(skb, card->dev, 0,
 					card->dev->dev_addr, "FAKELL", len);
+				skb_reset_mac_header(skb);
 				netif_receive_skb(skb);
 			} else {
 				qeth_l3_rebuild_skb(card, skb, hdr);
-- 
2.13.5
