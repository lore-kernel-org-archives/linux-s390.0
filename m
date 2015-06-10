Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 Jun 2015 16:22:49 +0530
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] qeth: Convert use of __constant_htons to htons
Message-ID: <20150610105249.GA3212@vaishali-Ideapad-Z570>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ursula.braun@de.ibm.com>
Cc: linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

In little endian cases, the macro htons unfolds to __swab16 which
provides special case for constants. In big endian cases,
__constant_htons and htons expand directly to the same expression.
So, replace __constant_htons with htons with the goal of getting
rid of the definition of __constant_htons completely.

The semantic patch that performs this transformation is as follows:

@@expression x;@@

- __constant_htons(x)
+ htons(x)

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 drivers/s390/net/qeth_l3_main.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 0ea0869..a124f59 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -272,7 +272,7 @@ static void qeth_l2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	/* VSWITCH relies on the VLAN
 	 * information to be present in
 	 * the QDIO header */
-	if (veth->h_vlan_proto == __constant_htons(ETH_P_8021Q)) {
+	if (veth->h_vlan_proto == htons(ETH_P_8021Q)) {
 		hdr->hdr.l2.flags[2] |= QETH_LAYER2_FLAG_VLAN;
 		hdr->hdr.l2.vlan_id = ntohs(veth->h_vlan_TCI);
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 04e42c6..bd6b5a9 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1887,13 +1887,13 @@ static inline int qeth_l3_rebuild_skb(struct qeth_card *card,
 		case QETH_CAST_MULTICAST:
 			switch (prot) {
 #ifdef CONFIG_QETH_IPV6
-			case __constant_htons(ETH_P_IPV6):
+			case htons(ETH_P_IPV6):
 				ndisc_mc_map((struct in6_addr *)
 				     skb->data + 24,
 				     tg_addr, card->dev, 0);
 				break;
 #endif
-			case __constant_htons(ETH_P_IP):
+			case htons(ETH_P_IP):
 				ip_hdr = (struct iphdr *)skb->data;
 				ip_eth_mc_map(ip_hdr->daddr, tg_addr);
 				break;
@@ -3015,7 +3015,7 @@ static int qeth_l3_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			skb_copy_to_linear_data_offset(new_skb, 8,
 				new_skb->data + 12, 4);
 			tag = (u16 *)(new_skb->data + 12);
-			*tag = __constant_htons(ETH_P_8021Q);
+			*tag = htons(ETH_P_8021Q);
 			*(tag + 1) = htons(skb_vlan_tag_get(new_skb));
 		}
 	}
-- 
1.9.1
