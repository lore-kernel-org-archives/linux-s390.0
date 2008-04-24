From: frank.blaschka@de.ibm.com
Subject: [patch 01/11] lcs: CCL-sequ. numbers required for protocol 802.2 only.
Date: Thu, 24 Apr 2008 10:15:18 +0200
Message-ID: <20080424081901.730124000@de.ibm.com>
References: <20080424081517.987104000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=700-lcs-ccl.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, "Klaus D. Wacker" <kdwacker@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Klaus D. Wacker <kdwacker@de.ibm.com>

Sequence numbers in skbs (Receive path) are assigned only to
802.2 packets.

Signed-off-by: Klaus D. Wacker <kdwacker@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---

 drivers/s390/net/lcs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2008-04-23 17:55:47.000000000 +0200
@@ -1793,7 +1793,8 @@ lcs_get_skb(struct lcs_card *card, char 
 	skb->protocol =	card->lan_type_trans(skb, card->dev);
 	card->stats.rx_bytes += skb_len;
 	card->stats.rx_packets++;
-	*((__u32 *)skb->cb) = ++card->pkt_seq;
+	if (skb->protocol == htons(ETH_P_802_2))
+		*((__u32 *)skb->cb) = ++card->pkt_seq;
 	netif_rx(skb);
 }
 

-- 
