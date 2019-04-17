Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/8] s390/qeth: add TX multiqueue support for IQD devices
Date: Wed, 17 Apr 2019 18:17:32 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-6-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth has been supporting multiple HW Output Queues for a long time. But
rather than exposing those queues to the stack, it uses its own queue
selection logic in .ndo_start_xmit... with all the drawbacks that
entails.
Start off by switching IQD devices over to a proper mqs net_device,
and converting all the netdev_queue management code.

One oddity with IQD devices is the requirement to place all mcast
traffic on the _highest_ established HW queue. Doing so via
.ndo_select_queue seems straight-forward - but that won't work if only
some of the HW queues are active
(ie. when dev->real_num_tx_queues < dev->num_tx_queues), since
netdev_cap_txqueue() will not allow us to put skbs on the higher queues.

To make this work, we
1. let .ndo_select_queue() map all mcast traffic to netdev_queue 0, and
2. later re-map the netdev_queue and HW queue indices in
   .ndo_start_xmit and the TX completion handler.

With this patch we default to a fixed set of 1 ucast and 1 mcast queue.
Support for dynamic reconfiguration is added at a later time.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 18 +++++++++++++++---
 drivers/s390/net/qeth_core_main.c | 27 +++++++++++++++++++++------
 drivers/s390/net/qeth_core_sys.c  |  3 +++
 drivers/s390/net/qeth_ethtool.c   | 16 ++++++++++++++++
 drivers/s390/net/qeth_l2_main.c   | 29 +++++++++++++++++++----------
 drivers/s390/net/qeth_l3_main.c   | 30 +++++++++++++++++++++++-------
 6 files changed, 97 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 730930135aba..836cde67f367 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -219,6 +219,9 @@ static inline int qeth_is_ipa_enabled(struct qeth_ipa_info *ipa,
 /* QDIO queue and buffer handling                                            */
 /*****************************************************************************/
 #define QETH_MAX_QUEUES 4
+#define QETH_IQD_MIN_TXQ	2	/* One for ucast, one for mcast. */
+#define QETH_IQD_MCAST_TXQ	0
+#define QETH_IQD_MIN_UCAST_TXQ	1
 #define QETH_IN_BUF_SIZE_DEFAULT 65536
 #define QETH_IN_BUF_COUNT_DEFAULT 64
 #define QETH_IN_BUF_COUNT_HSDEFAULT 128
@@ -835,6 +838,15 @@ static inline bool qeth_netdev_is_registered(struct net_device *dev)
 	return dev->netdev_ops != NULL;
 }
 
+static inline u16 qeth_iqd_translate_txq(struct net_device *dev, u16 txq)
+{
+	if (txq == QETH_IQD_MCAST_TXQ)
+		return dev->num_tx_queues - 1;
+	if (txq == dev->num_tx_queues - 1)
+		return QETH_IQD_MCAST_TXQ;
+	return txq;
+}
+
 static inline void qeth_scrub_qdio_buffer(struct qdio_buffer *buf,
 					  unsigned int elements)
 {
@@ -934,10 +946,8 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
 			    int ipv);
 static inline struct qeth_qdio_out_q *qeth_get_tx_queue(struct qeth_card *card,
 							struct sk_buff *skb,
-							int ipv, int cast_type)
+							int ipv)
 {
-	if (IS_IQD(card) && cast_type != RTN_UNICAST)
-		return card->qdio.out_qs[card->qdio.no_out_queues - 1];
 	if (!card->qdio.do_prio_queueing)
 		return card->qdio.out_qs[card->qdio.default_out_queue];
 	return card->qdio.out_qs[qeth_get_priority_queue(card, skb, ipv)];
@@ -1022,6 +1032,8 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
 void qeth_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats);
+u16 qeth_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
+			  u8 cast_type, struct net_device *sb_dev);
 int qeth_open(struct net_device *dev);
 int qeth_stop(struct net_device *dev);
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 09ed9e04f4ca..68f6043f033a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3485,7 +3485,7 @@ static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
 	QETH_CARD_TEXT_(card, 5, "qcqherr%d", qdio_err);
 
 	if (qdio_err) {
-		netif_stop_queue(card->dev);
+		netif_tx_stop_all_queues(card->dev);
 		qeth_schedule_recovery(card);
 		return;
 	}
@@ -3541,12 +3541,14 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	struct qeth_card *card        = (struct qeth_card *) card_ptr;
 	struct qeth_qdio_out_q *queue = card->qdio.out_qs[__queue];
 	struct qeth_qdio_out_buffer *buffer;
+	struct net_device *dev = card->dev;
+	u16 txq;
 	int i;
 
 	QETH_CARD_TEXT(card, 6, "qdouhdl");
 	if (qdio_error & QDIO_ERROR_FATAL) {
 		QETH_CARD_TEXT(card, 2, "achkcond");
-		netif_stop_queue(card->dev);
+		netif_tx_stop_all_queues(dev);
 		qeth_schedule_recovery(card);
 		return;
 	}
@@ -3595,7 +3597,8 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	if (card->info.type != QETH_CARD_TYPE_IQD)
 		qeth_check_outbound_queue(queue);
 
-	netif_wake_queue(queue->card->dev);
+	txq = IS_IQD(card) ? qeth_iqd_translate_txq(dev, __queue) : 0;
+	netif_wake_subqueue(dev, txq);
 }
 
 /* We cannot use outbound queue 3 for unicast packets on HiperSockets */
@@ -5557,7 +5560,8 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 
 	switch (card->info.type) {
 	case QETH_CARD_TYPE_IQD:
-		dev = alloc_netdev(0, "hsi%d", NET_NAME_UNKNOWN, ether_setup);
+		dev = alloc_netdev_mqs(0, "hsi%d", NET_NAME_UNKNOWN,
+				       ether_setup, QETH_MAX_QUEUES, 1);
 		break;
 	case QETH_CARD_TYPE_OSN:
 		dev = alloc_netdev(0, "osn%d", NET_NAME_UNKNOWN, ether_setup);
@@ -5585,8 +5589,10 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 		dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 		dev->hw_features |= NETIF_F_SG;
 		dev->vlan_features |= NETIF_F_SG;
-		if (IS_IQD(card))
+		if (IS_IQD(card)) {
+			netif_set_real_num_tx_queues(dev, QETH_IQD_MIN_TXQ);
 			dev->features |= NETIF_F_SG;
+		}
 	}
 
 	return dev;
@@ -6203,6 +6209,15 @@ void qeth_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 }
 EXPORT_SYMBOL_GPL(qeth_get_stats64);
 
+u16 qeth_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
+			  u8 cast_type, struct net_device *sb_dev)
+{
+	if (cast_type != RTN_UNICAST)
+		return QETH_IQD_MCAST_TXQ;
+	return QETH_IQD_MIN_UCAST_TXQ;
+}
+EXPORT_SYMBOL_GPL(qeth_iqd_select_queue);
+
 int qeth_open(struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
@@ -6213,7 +6228,7 @@ int qeth_open(struct net_device *dev)
 		return -EIO;
 
 	card->data.state = CH_STATE_UP;
-	netif_start_queue(dev);
+	netif_tx_start_all_queues(dev);
 
 	napi_enable(&card->napi);
 	local_bh_disable();
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 56deeb6f7bc0..b43d8bdf4c3e 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -198,6 +198,9 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
+	if (IS_IQD(card))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&card->conf_mutex);
 	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index 93a53fed4cf8..a443e5f86ab7 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -154,6 +154,21 @@ static void qeth_get_drvinfo(struct net_device *dev,
 		 CARD_RDEV_ID(card), CARD_WDEV_ID(card), CARD_DDEV_ID(card));
 }
 
+static void qeth_get_channels(struct net_device *dev,
+			      struct ethtool_channels *channels)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	channels->max_rx = dev->num_rx_queues;
+	channels->max_tx = card->qdio.no_out_queues;
+	channels->max_other = 0;
+	channels->max_combined = 0;
+	channels->rx_count = dev->real_num_rx_queues;
+	channels->tx_count = dev->real_num_tx_queues;
+	channels->other_count = 0;
+	channels->combined_count = 0;
+}
+
 /* Helper function to fill 'advertising' and 'supported' which are the same. */
 /* Autoneg and full-duplex are supported and advertised unconditionally.     */
 /* Always advertise and support all speeds up to specified, and only one     */
@@ -359,6 +374,7 @@ const struct ethtool_ops qeth_ethtool_ops = {
 	.get_ethtool_stats = qeth_get_ethtool_stats,
 	.get_sset_count = qeth_get_sset_count,
 	.get_drvinfo = qeth_get_drvinfo,
+	.get_channels = qeth_get_channels,
 	.get_link_ksettings = qeth_get_link_ksettings,
 };
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 641dc17e3b79..1491281600c2 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -161,10 +161,8 @@ static void qeth_l2_drain_rx_mode_cache(struct qeth_card *card)
 	}
 }
 
-static int qeth_l2_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
+static int qeth_l2_get_cast_type(struct sk_buff *skb)
 {
-	if (card->info.type == QETH_CARD_TYPE_OSN)
-		return RTN_UNICAST;
 	if (is_broadcast_ether_addr(skb->data))
 		return RTN_BROADCAST;
 	if (is_multicast_ether_addr(skb->data))
@@ -603,26 +601,29 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 					   struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
-	int cast_type = qeth_l2_get_cast_type(card, skb);
+	u16 txq = skb_get_queue_mapping(skb);
 	int ipv = qeth_get_ip_version(skb);
 	struct qeth_qdio_out_q *queue;
 	int tx_bytes = skb->len;
 	int rc;
 
-	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
+	if (IS_IQD(card))
+		queue = card->qdio.out_qs[qeth_iqd_translate_txq(dev, txq)];
+	else
+		queue = qeth_get_tx_queue(card, skb, ipv);
 
-	netif_stop_queue(dev);
+	netif_stop_subqueue(dev, txq);
 
 	if (IS_OSN(card))
 		rc = qeth_l2_xmit_osn(card, skb, queue);
 	else
-		rc = qeth_xmit(card, skb, queue, ipv, cast_type,
-			       qeth_l2_fill_header);
+		rc = qeth_xmit(card, skb, queue, ipv,
+			       qeth_l2_get_cast_type(skb), qeth_l2_fill_header);
 
 	if (!rc) {
 		QETH_TXQ_STAT_INC(queue, tx_packets);
 		QETH_TXQ_STAT_ADD(queue, tx_bytes, tx_bytes);
-		netif_wake_queue(dev);
+		netif_wake_subqueue(dev, txq);
 		return NETDEV_TX_OK;
 	} else if (rc == -EBUSY) {
 		return NETDEV_TX_BUSY;
@@ -630,10 +631,17 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 
 	QETH_TXQ_STAT_INC(queue, tx_dropped);
 	kfree_skb(skb);
-	netif_wake_queue(dev);
+	netif_wake_subqueue(dev, txq);
 	return NETDEV_TX_OK;
 }
 
+static u16 qeth_l2_select_queue(struct net_device *dev, struct sk_buff *skb,
+				struct net_device *sb_dev)
+{
+	return qeth_iqd_select_queue(dev, skb, qeth_l2_get_cast_type(skb),
+				     sb_dev);
+}
+
 static const struct device_type qeth_l2_devtype = {
 	.name = "qeth_layer2",
 	.groups = qeth_l2_attr_groups,
@@ -687,6 +695,7 @@ static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_get_stats64	= qeth_get_stats64,
 	.ndo_start_xmit		= qeth_l2_hard_start_xmit,
 	.ndo_features_check	= qeth_features_check,
+	.ndo_select_queue	= qeth_l2_select_queue,
 	.ndo_validate_addr	= qeth_l2_validate_addr,
 	.ndo_set_rx_mode	= qeth_l2_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 102be697f5db..120193e90adb 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2062,28 +2062,36 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 					   struct net_device *dev)
 {
-	int cast_type = qeth_l3_get_cast_type(skb);
 	struct qeth_card *card = dev->ml_priv;
+	u16 txq = skb_get_queue_mapping(skb);
 	int ipv = qeth_get_ip_version(skb);
 	struct qeth_qdio_out_q *queue;
 	int tx_bytes = skb->len;
-	int rc;
-
-	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
+	int cast_type, rc;
 
 	if (IS_IQD(card)) {
+		queue = card->qdio.out_qs[qeth_iqd_translate_txq(dev, txq)];
+
 		if (card->options.sniffer)
 			goto tx_drop;
 		if ((card->options.cq != QETH_CQ_ENABLED && !ipv) ||
 		    (card->options.cq == QETH_CQ_ENABLED &&
 		     skb->protocol != htons(ETH_P_AF_IUCV)))
 			goto tx_drop;
+
+		if (txq == QETH_IQD_MCAST_TXQ)
+			cast_type = qeth_l3_get_cast_type(skb);
+		else
+			cast_type = RTN_UNICAST;
+	} else {
+		queue = qeth_get_tx_queue(card, skb, ipv);
+		cast_type = qeth_l3_get_cast_type(skb);
 	}
 
 	if (cast_type == RTN_BROADCAST && !card->info.broadcast_capable)
 		goto tx_drop;
 
-	netif_stop_queue(dev);
+	netif_stop_subqueue(dev, txq);
 
 	if (ipv == 4 || IS_IQD(card))
 		rc = qeth_l3_xmit(card, skb, queue, ipv, cast_type);
@@ -2094,7 +2102,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	if (!rc) {
 		QETH_TXQ_STAT_INC(queue, tx_packets);
 		QETH_TXQ_STAT_ADD(queue, tx_bytes, tx_bytes);
-		netif_wake_queue(dev);
+		netif_wake_subqueue(dev, txq);
 		return NETDEV_TX_OK;
 	} else if (rc == -EBUSY) {
 		return NETDEV_TX_BUSY;
@@ -2103,7 +2111,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 tx_drop:
 	QETH_TXQ_STAT_INC(queue, tx_dropped);
 	kfree_skb(skb);
-	netif_wake_queue(dev);
+	netif_wake_subqueue(dev, txq);
 	return NETDEV_TX_OK;
 }
 
@@ -2147,11 +2155,19 @@ static netdev_features_t qeth_l3_osa_features_check(struct sk_buff *skb,
 	return qeth_features_check(skb, dev, features);
 }
 
+static u16 qeth_l3_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
+				    struct net_device *sb_dev)
+{
+	return qeth_iqd_select_queue(dev, skb, qeth_l3_get_cast_type(skb),
+				     sb_dev);
+}
+
 static const struct net_device_ops qeth_l3_netdev_ops = {
 	.ndo_open		= qeth_open,
 	.ndo_stop		= qeth_stop,
 	.ndo_get_stats64	= qeth_get_stats64,
 	.ndo_start_xmit		= qeth_l3_hard_start_xmit,
+	.ndo_select_queue	= qeth_l3_iqd_select_queue,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= qeth_l3_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
-- 
2.16.4
