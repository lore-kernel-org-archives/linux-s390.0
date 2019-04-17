Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/8] s390/qeth: simplify QoS code
Date: Wed, 17 Apr 2019 18:17:34 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_get_priority_queue() is no longer used for IQD devices, remove the
special-casing of their mcast queue.

This effectively reverts
commit 70deb01662b1 ("qeth: omit outbound queue 3 for unicast packets in Priority Queuing on HiperSockets").

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 23 +++++++----------------
 drivers/s390/net/qeth_core_sys.c  |  4 ----
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6640616a8439..d23ad6e3bb45 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3594,20 +3594,12 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	netif_wake_subqueue(dev, txq);
 }
 
-/* We cannot use outbound queue 3 for unicast packets on HiperSockets */
-static inline int qeth_cut_iqd_prio(struct qeth_card *card, int queue_num)
-{
-	if ((card->info.type == QETH_CARD_TYPE_IQD) && (queue_num == 3))
-		return 2;
-	return queue_num;
-}
-
 /**
  * Note: Function assumes that we have 4 outbound queues.
  */
 int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb)
 {
-	__be16 *tci;
+	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
 	u8 tos;
 
 	switch (card->qdio.do_prio_queueing) {
@@ -3624,9 +3616,9 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb)
 			return card->qdio.default_out_queue;
 		}
 		if (card->qdio.do_prio_queueing == QETH_PRIO_Q_ING_PREC)
-			return qeth_cut_iqd_prio(card, ~tos >> 6 & 3);
+			return ~tos >> 6 & 3;
 		if (tos & IPTOS_MINCOST)
-			return qeth_cut_iqd_prio(card, 3);
+			return 3;
 		if (tos & IPTOS_RELIABILITY)
 			return 2;
 		if (tos & IPTOS_THROUGHPUT)
@@ -3637,12 +3629,11 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb)
 	case QETH_PRIO_Q_ING_SKB:
 		if (skb->priority > 5)
 			return 0;
-		return qeth_cut_iqd_prio(card, ~skb->priority >> 1 & 3);
+		return ~skb->priority >> 1 & 3;
 	case QETH_PRIO_Q_ING_VLAN:
-		tci = &((struct ethhdr *)skb->data)->h_proto;
-		if (be16_to_cpu(*tci) == ETH_P_8021Q)
-			return qeth_cut_iqd_prio(card,
-			~be16_to_cpu(*(tci + 1)) >> (VLAN_PRIO_SHIFT + 1) & 3);
+		if (veth->h_vlan_proto == htons(ETH_P_8021Q))
+			return ~ntohs(veth->h_vlan_TCI) >>
+			       (VLAN_PRIO_SHIFT + 1) & 3;
 		break;
 	default:
 		break;
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index b43d8bdf4c3e..cea4a0bbc303 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -242,10 +242,6 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
 		card->qdio.default_out_queue = 2;
 	} else if (sysfs_streq(buf, "no_prio_queueing:3")) {
-		if (card->info.type == QETH_CARD_TYPE_IQD) {
-			rc = -EPERM;
-			goto out;
-		}
 		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
 		card->qdio.default_out_queue = 3;
 	} else if (sysfs_streq(buf, "no_prio_queueing")) {
-- 
2.16.4
