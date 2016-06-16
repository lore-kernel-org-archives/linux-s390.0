From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 12/13] qeth: omit outbound queue 3 for unicast packets in Priority Queuing on HiperSockets
Date: Thu, 16 Jun 2016 16:19:02 +0200
Message-ID: <1466086743-55484-13-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.vnet.ibm.com>

On HiperSockets only outbound queues 0 to 2 are available for unicast
packets. Current Priority Queuing implementation in the qeth driver puts
outgoing packets in outbound queues 0 to 3.

This puts outgoing unicast packets into outbound queue 2 instead of
outbound queue 3 when using Priority Queuing on a HiperSocket.
Additionally, the default outbound queue cannot be set to outbound queue 3
on HiperSockets.

Signed-off-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 17 +++++++++++++----
 drivers/s390/net/qeth_core_sys.c  |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 44d3200..7dba6c8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3748,6 +3748,14 @@ void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 }
 EXPORT_SYMBOL_GPL(qeth_qdio_output_handler);
 
+/* We cannot use outbound queue 3 for unicast packets on HiperSockets */
+static inline int qeth_cut_iqd_prio(struct qeth_card *card, int queue_num)
+{
+	if ((card->info.type == QETH_CARD_TYPE_IQD) && (queue_num == 3))
+		return 2;
+	return queue_num;
+}
+
 /**
  * Note: Function assumes that we have 4 outbound queues.
  */
@@ -3775,9 +3783,9 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
 			return card->qdio.default_out_queue;
 		}
 		if (card->qdio.do_prio_queueing == QETH_PRIO_Q_ING_PREC)
-			return ~tos >> 6 & 3;
+			return qeth_cut_iqd_prio(card, ~tos >> 6 & 3);
 		if (tos & IPTOS_MINCOST)
-			return 3;
+			return qeth_cut_iqd_prio(card, 3);
 		if (tos & IPTOS_RELIABILITY)
 			return 2;
 		if (tos & IPTOS_THROUGHPUT)
@@ -3788,11 +3796,12 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
 	case QETH_PRIO_Q_ING_SKB:
 		if (skb->priority > 5)
 			return 0;
-		return ~skb->priority >> 1 & 3;
+		return qeth_cut_iqd_prio(card, ~skb->priority >> 1 & 3);
 	case QETH_PRIO_Q_ING_VLAN:
 		tci = &((struct ethhdr *)skb->data)->h_proto;
 		if (*tci == ETH_P_8021Q)
-			return ~*(tci + 1) >> (VLAN_PRIO_SHIFT + 1) & 3;
+			return qeth_cut_iqd_prio(card, ~*(tci + 1) >>
+			(VLAN_PRIO_SHIFT + 1) & 3);
 		break;
 	default:
 		break;
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index e6e5b96..75b29fd2 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -243,6 +243,10 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
 		card->qdio.default_out_queue = 2;
 	} else if (sysfs_streq(buf, "no_prio_queueing:3")) {
+		if (card->info.type == QETH_CARD_TYPE_IQD) {
+			rc = -EPERM;
+			goto out;
+		}
 		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
 		card->qdio.default_out_queue = 3;
 	} else if (sysfs_streq(buf, "no_prio_queueing")) {
-- 
2.6.6
