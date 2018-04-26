From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/13] s390/qeth: extract csum offload helpers
Date: Thu, 26 Apr 2018 09:42:17 +0200
Message-ID: <20180426074224.100432-7-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

This consolidates the checksum offload code that was duplicated
over the two qeth subdrivers.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h    | 21 +++++++++++++++++++++
 drivers/s390/net/qeth_l2_main.c | 35 ++++++-----------------------------
 drivers/s390/net/qeth_l3_main.c | 36 ++++++------------------------------
 3 files changed, 33 insertions(+), 59 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 6d7a72da71dd..a8114758075f 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -864,6 +864,27 @@ static inline int qeth_get_ip_version(struct sk_buff *skb)
 	}
 }
 
+static inline void qeth_rx_csum(struct qeth_card *card, struct sk_buff *skb,
+				u8 flags)
+{
+	if ((card->dev->features & NETIF_F_RXCSUM) &&
+	    (flags & QETH_HDR_EXT_CSUM_HDR_REQ) &&
+	    (flags & QETH_HDR_EXT_CSUM_TRANSP_REQ))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	else
+		skb->ip_summed = CHECKSUM_NONE;
+}
+
+static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags)
+{
+	*flags |= QETH_HDR_EXT_CSUM_TRANSP_REQ;
+	if (ip_hdr(skb)->protocol == IPPROTO_UDP)
+		*flags |= QETH_HDR_EXT_UDP;
+	/* some HW requires combined L3+L4 csum offload: */
+	*flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
+	ip_hdr(skb)->check = 0;
+}
+
 static inline void qeth_put_buffer_pool_entry(struct qeth_card *card,
 		struct qeth_buffer_pool_entry *entry)
 {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 3239b2546ac7..945df56434fd 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/etherdevice.h>
-#include <linux/ip.h>
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/hashtable.h>
@@ -195,23 +194,6 @@ static int qeth_l2_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
 	return RTN_UNSPEC;
 }
 
-static void qeth_l2_hdr_csum(struct qeth_card *card, struct qeth_hdr *hdr,
-			     struct sk_buff *skb)
-{
-	struct iphdr *iph = ip_hdr(skb);
-
-	/* tcph->check contains already the pseudo hdr checksum
-	 * so just set the header flags
-	 */
-	if (iph->protocol == IPPROTO_UDP)
-		hdr->hdr.l2.flags[1] |= QETH_HDR_EXT_UDP;
-	hdr->hdr.l2.flags[1] |= QETH_HDR_EXT_CSUM_TRANSP_REQ |
-		QETH_HDR_EXT_CSUM_HDR_REQ;
-	iph->check = 0;
-	if (card->options.performance_stats)
-		card->perf_stats.tx_csum++;
-}
-
 static void qeth_l2_fill_header(struct qeth_hdr *hdr, struct sk_buff *skb,
 				int cast_type, unsigned int data_len)
 {
@@ -424,15 +406,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
 		switch (hdr->hdr.l2.id) {
 		case QETH_HEADER_TYPE_LAYER2:
 			skb->protocol = eth_type_trans(skb, skb->dev);
-			if ((card->dev->features & NETIF_F_RXCSUM)
-			   && ((hdr->hdr.l2.flags[1] &
-				(QETH_HDR_EXT_CSUM_HDR_REQ |
-				   QETH_HDR_EXT_CSUM_TRANSP_REQ)) ==
-				(QETH_HDR_EXT_CSUM_HDR_REQ |
-				   QETH_HDR_EXT_CSUM_TRANSP_REQ)))
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			else
-				skb->ip_summed = CHECKSUM_NONE;
+			qeth_rx_csum(card, skb, hdr->hdr.l2.flags[1]);
 			if (skb->protocol == htons(ETH_P_802_2))
 				*((__u32 *)skb->cb) = ++card->seqno.pkt_seqno;
 			len = skb->len;
@@ -724,8 +698,11 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 		hdr_elements = 1;
 	}
 	qeth_l2_fill_header(hdr, skb, cast_type, skb->len - push_len);
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
-		qeth_l2_hdr_csum(card, hdr, skb);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		qeth_tx_csum(skb, &hdr->hdr.l2.flags[1]);
+		if (card->options.performance_stats)
+			card->perf_stats.tx_csum++;
+	}
 
 	elements = qeth_get_elements_no(card, skb, hdr_elements, 0);
 	if (!elements) {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0e8ed8787fd3..bc359e322ae7 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1367,17 +1367,7 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tag);
 	}
 
-	if (card->dev->features & NETIF_F_RXCSUM) {
-		if ((hdr->hdr.l3.ext_flags &
-		    (QETH_HDR_EXT_CSUM_HDR_REQ |
-		     QETH_HDR_EXT_CSUM_TRANSP_REQ)) ==
-		    (QETH_HDR_EXT_CSUM_HDR_REQ |
-		     QETH_HDR_EXT_CSUM_TRANSP_REQ))
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-		else
-			skb->ip_summed = CHECKSUM_NONE;
-	} else
-		skb->ip_summed = CHECKSUM_NONE;
+	qeth_rx_csum(card, skb, hdr->hdr.l3.ext_flags);
 }
 
 static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
@@ -2123,23 +2113,6 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	rcu_read_unlock();
 }
 
-static void qeth_l3_hdr_csum(struct qeth_card *card, struct qeth_hdr *hdr,
-			     struct sk_buff *skb)
-{
-	struct iphdr *iph = ip_hdr(skb);
-
-	/* tcph->check contains already the pseudo hdr checksum
-	 * so just set the header flags
-	 */
-	if (iph->protocol == IPPROTO_UDP)
-		hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_UDP;
-	hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_TRANSP_REQ |
-		QETH_HDR_EXT_CSUM_HDR_REQ;
-	iph->check = 0;
-	if (card->options.performance_stats)
-		card->perf_stats.tx_csum++;
-}
-
 static void qeth_tso_fill_header(struct qeth_card *card,
 		struct qeth_hdr *qhdr, struct sk_buff *skb)
 {
@@ -2331,8 +2304,11 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 			}
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL)
-			qeth_l3_hdr_csum(card, hdr, new_skb);
+		if (new_skb->ip_summed == CHECKSUM_PARTIAL) {
+			qeth_tx_csum(new_skb, &hdr->hdr.l3.ext_flags);
+			if (card->options.performance_stats)
+				card->perf_stats.tx_csum++;
+		}
 	}
 
 	elements = use_tso ?
-- 
2.13.5
