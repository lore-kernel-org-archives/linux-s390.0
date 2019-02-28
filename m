Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 9/9] s390/qeth: drop redundant state checking
Date: Thu, 28 Feb 2019 18:59:44 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-10-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that qeth always uses dev_close() to shutdown the interface, we can
trust the locking and remove some custom state checks.
qeth_l?_stop_card() is no longer called for a card in UP state, so remove
the checks there too. This basically makes the UP state obsolete, so rip
out the whole thing (except for the sysfs-visible string).

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  8 +++++---
 drivers/s390/net/qeth_core_main.c | 18 +-----------------
 drivers/s390/net/qeth_core_sys.c  |  8 ++++----
 drivers/s390/net/qeth_l2_main.c   | 11 +----------
 drivers/s390/net/qeth_l3_main.c   | 11 ++---------
 5 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 8c354cdc86c0..c851cf6e01c4 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -483,7 +483,6 @@ struct qeth_out_q_stats {
 	u64 tx_bytes;
 	u64 tx_errors;
 	u64 tx_dropped;
-	u64 tx_carrier_errors;
 };
 
 struct qeth_qdio_out_q {
@@ -552,7 +551,6 @@ enum qeth_card_states {
 	CARD_STATE_DOWN,
 	CARD_STATE_HARDSETUP,
 	CARD_STATE_SOFTSETUP,
-	CARD_STATE_UP,
 };
 
 /**
@@ -808,6 +806,11 @@ struct qeth_card {
 	struct work_struct close_dev_work;
 };
 
+static inline bool qeth_card_hw_is_reachable(struct qeth_card *card)
+{
+	return card->state == CARD_STATE_SOFTSETUP;
+}
+
 struct qeth_trap_id {
 	__u16 lparnr;
 	char vmname[8];
@@ -942,7 +945,6 @@ extern const struct attribute_group qeth_device_attr_group;
 extern const struct attribute_group qeth_device_blkt_group;
 extern const struct device_type qeth_generic_devtype;
 
-int qeth_card_hw_is_reachable(struct qeth_card *);
 const char *qeth_get_cardname_short(struct qeth_card *);
 int qeth_realloc_buffer_pool(struct qeth_card *, int);
 int qeth_core_load_discipline(struct qeth_card *, enum qeth_discipline_id);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4dcb4f91b9c0..a44a4e0d2b19 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -74,13 +74,6 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *queue,
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf);
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *, int);
 
-int qeth_card_hw_is_reachable(struct qeth_card *card)
-{
-	return (card->state == CARD_STATE_SOFTSETUP) ||
-		(card->state == CARD_STATE_UP);
-}
-EXPORT_SYMBOL_GPL(qeth_card_hw_is_reachable);
-
 static void qeth_close_dev_handler(struct work_struct *work)
 {
 	struct qeth_card *card;
@@ -6206,7 +6199,6 @@ void qeth_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		stats->tx_bytes += queue->stats.tx_bytes;
 		stats->tx_errors += queue->stats.tx_errors;
 		stats->tx_dropped += queue->stats.tx_dropped;
-		stats->tx_carrier_errors += queue->stats.tx_carrier_errors;
 	}
 }
 EXPORT_SYMBOL_GPL(qeth_get_stats64);
@@ -6216,16 +6208,11 @@ int qeth_open(struct net_device *dev)
 	struct qeth_card *card = dev->ml_priv;
 
 	QETH_CARD_TEXT(card, 4, "qethopen");
-	if (card->state == CARD_STATE_UP)
-		return 0;
-	if (card->state != CARD_STATE_SOFTSETUP)
-		return -ENODEV;
 
 	if (qdio_stop_irq(CARD_DDEV(card), 0) < 0)
 		return -EIO;
 
 	card->data.state = CH_STATE_UP;
-	card->state = CARD_STATE_UP;
 	netif_start_queue(dev);
 
 	napi_enable(&card->napi);
@@ -6243,10 +6230,7 @@ int qeth_stop(struct net_device *dev)
 
 	QETH_CARD_TEXT(card, 4, "qethstop");
 	netif_tx_disable(dev);
-	if (card->state == CARD_STATE_UP) {
-		card->state = CARD_STATE_SOFTSETUP;
-		napi_disable(&card->napi);
-	}
+	napi_disable(&card->napi);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qeth_stop);
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index fa575549d288..56deeb6f7bc0 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -29,11 +29,11 @@ static ssize_t qeth_dev_state_show(struct device *dev,
 	case CARD_STATE_HARDSETUP:
 		return sprintf(buf, "HARDSETUP\n");
 	case CARD_STATE_SOFTSETUP:
+		if (card->dev->flags & IFF_UP)
+			return sprintf(buf, "UP (LAN %s)\n",
+				       netif_carrier_ok(card->dev) ? "ONLINE" :
+								     "OFFLINE");
 		return sprintf(buf, "SOFTSETUP\n");
-	case CARD_STATE_UP:
-		return sprintf(buf, "UP (LAN %s)\n",
-			       netif_carrier_ok(card->dev) ? "ONLINE" :
-							     "OFFLINE");
 	default:
 		return sprintf(buf, "UNKNOWN\n");
 	}
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 6380d29c10f7..8efb2e8ff8f4 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -291,10 +291,7 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
 	qeth_set_allowed_threads(card, 0, 1);
-	if (card->read.state == CH_STATE_UP &&
-	    card->write.state == CH_STATE_UP &&
-	    card->state == CARD_STATE_UP)
-		card->state = CARD_STATE_SOFTSETUP;
+
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_l2_del_all_macs(card);
 		qeth_clear_ipacmd_list(card);
@@ -614,11 +611,6 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 
 	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
 
-	if (card->state != CARD_STATE_UP) {
-		QETH_TXQ_STAT_INC(queue, tx_carrier_errors);
-		goto tx_drop;
-	}
-
 	netif_stop_queue(dev);
 
 	if (IS_OSN(card))
@@ -636,7 +628,6 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	} /* else fall through */
 
-tx_drop:
 	QETH_TXQ_STAT_INC(queue, tx_dropped);
 	QETH_TXQ_STAT_INC(queue, tx_errors);
 	dev_kfree_skb_any(skb);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 375ad03ea4c5..7e68d9d16859 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1412,13 +1412,11 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
 	qeth_set_allowed_threads(card, 0, 1);
+
 	if (card->options.sniffer &&
 	    (card->info.promisc_mode == SET_PROMISC_MODE_ON))
 		qeth_diags_trace(card, QETH_DIAGS_CMD_TRACE_DISABLE);
-	if (card->read.state == CH_STATE_UP &&
-	    card->write.state == CH_STATE_UP &&
-	    card->state == CARD_STATE_UP)
-		card->state = CARD_STATE_SOFTSETUP;
+
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_l3_clear_ip_htable(card, 1);
 		qeth_clear_ipacmd_list(card);
@@ -2076,11 +2074,6 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 			goto tx_drop;
 	}
 
-	if (card->state != CARD_STATE_UP) {
-		QETH_TXQ_STAT_INC(queue, tx_carrier_errors);
-		goto tx_drop;
-	}
-
 	if (cast_type == RTN_BROADCAST && !card->info.broadcast_capable)
 		goto tx_drop;
 
-- 
2.16.4
