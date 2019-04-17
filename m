Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/8] s390/qeth: add TX multiqueue support for OSA devices
Date: Wed, 17 Apr 2019 18:17:33 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This adds trivial support for multiple TX queues on OSA-style devices
(both real HW and z/VM NICs). For now we expose the driver's existing
QoS mechanism via .ndo_select_queue, and adjust the number of available
TX queues when qeth_update_from_chp_desc() detects that the
HW configuration has changed.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 11 +------
 drivers/s390/net/qeth_core_main.c | 67 ++++++++++++++++++---------------------
 drivers/s390/net/qeth_l2_main.c   | 14 +++++---
 drivers/s390/net/qeth_l3_main.c   | 11 ++++++-
 4 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 836cde67f367..4989dc7b58c1 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -942,16 +942,7 @@ static inline int qeth_send_simple_setassparms_v6(struct qeth_card *card,
 						 data, QETH_PROT_IPV6);
 }
 
-int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
-			    int ipv);
-static inline struct qeth_qdio_out_q *qeth_get_tx_queue(struct qeth_card *card,
-							struct sk_buff *skb,
-							int ipv)
-{
-	if (!card->qdio.do_prio_queueing)
-		return card->qdio.out_qs[card->qdio.default_out_queue];
-	return card->qdio.out_qs[qeth_get_priority_queue(card, skb, ipv)];
-}
+int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb);
 
 extern struct qeth_discipline qeth_l2_discipline;
 extern struct qeth_discipline qeth_l3_discipline;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 68f6043f033a..6640616a8439 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1275,27 +1275,25 @@ static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 	return 0;
 }
 
-static void qeth_set_single_write_queues(struct qeth_card *card)
+static void qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 {
-	if ((atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED) &&
-	    (card->qdio.no_out_queues == 4))
-		qeth_free_qdio_queues(card);
+	unsigned int count = single ? 1 : card->dev->num_tx_queues;
 
-	card->qdio.no_out_queues = 1;
-	if (card->qdio.default_out_queue != 0)
-		dev_info(&card->gdev->dev, "Priority Queueing not supported\n");
+	rtnl_lock();
+	netif_set_real_num_tx_queues(card->dev, count);
+	rtnl_unlock();
 
-	card->qdio.default_out_queue = 0;
-}
+	if (card->qdio.no_out_queues == count)
+		return;
 
-static void qeth_set_multiple_write_queues(struct qeth_card *card)
-{
-	if ((atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED) &&
-	    (card->qdio.no_out_queues == 1)) {
+	if (atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED)
 		qeth_free_qdio_queues(card);
-		card->qdio.default_out_queue = 2;
-	}
-	card->qdio.no_out_queues = 4;
+
+	if (count == 1)
+		dev_info(&card->gdev->dev, "Priority Queueing not supported\n");
+
+	card->qdio.default_out_queue = single ? 0 : QETH_DEFAULT_QUEUE;
+	card->qdio.no_out_queues = count;
 }
 
 static int qeth_update_from_chp_desc(struct qeth_card *card)
@@ -1311,15 +1309,11 @@ static int qeth_update_from_chp_desc(struct qeth_card *card)
 		return -ENOMEM;
 
 	card->info.func_level = 0x4100 + chp_dsc->desc;
-	if (card->info.type == QETH_CARD_TYPE_IQD)
-		goto out;
 
-	/* CHPP field bit 6 == 1 -> single queue */
-	if ((chp_dsc->chpp & 0x02) == 0x02)
-		qeth_set_single_write_queues(card);
-	else
-		qeth_set_multiple_write_queues(card);
-out:
+	if (IS_OSD(card) || IS_OSX(card))
+		/* CHPP field bit 6 == 1 -> single queue */
+		qeth_osa_set_output_queues(card, chp_dsc->chpp & 0x02);
+
 	kfree(chp_dsc);
 	QETH_DBF_TEXT_(SETUP, 2, "nr:%x", card->qdio.no_out_queues);
 	QETH_DBF_TEXT_(SETUP, 2, "lvl:%02x", card->info.func_level);
@@ -1332,7 +1326,6 @@ static void qeth_init_qdio_info(struct qeth_card *card)
 	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
 	card->qdio.do_prio_queueing = QETH_PRIOQ_DEFAULT;
 	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
-	card->qdio.no_out_queues = QETH_MAX_QUEUES;
 
 	/* inbound */
 	card->qdio.no_in_queues = 1;
@@ -3414,7 +3407,7 @@ static void qeth_check_outbound_queue(struct qeth_qdio_out_q *queue)
 			 * do_send_packet. So, we check if there is a
 			 * packing buffer to be flushed here.
 			 */
-			netif_stop_queue(queue->card->dev);
+			netif_stop_subqueue(queue->card->dev, queue->queue_no);
 			index = queue->next_buf_to_fill;
 			q_was_packing = queue->do_pack;
 			/* queue->do_pack may change */
@@ -3597,7 +3590,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	if (card->info.type != QETH_CARD_TYPE_IQD)
 		qeth_check_outbound_queue(queue);
 
-	txq = IS_IQD(card) ? qeth_iqd_translate_txq(dev, __queue) : 0;
+	txq = IS_IQD(card) ? qeth_iqd_translate_txq(dev, __queue) : __queue;
 	netif_wake_subqueue(dev, txq);
 }
 
@@ -3612,8 +3605,7 @@ static inline int qeth_cut_iqd_prio(struct qeth_card *card, int queue_num)
 /**
  * Note: Function assumes that we have 4 outbound queues.
  */
-int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
-			    int ipv)
+int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb)
 {
 	__be16 *tci;
 	u8 tos;
@@ -3621,7 +3613,7 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
 	switch (card->qdio.do_prio_queueing) {
 	case QETH_PRIO_Q_ING_TOS:
 	case QETH_PRIO_Q_ING_PREC:
-		switch (ipv) {
+		switch (qeth_get_ip_version(skb)) {
 		case 4:
 			tos = ipv4_get_dsfield(ip_hdr(skb));
 			break;
@@ -5563,11 +5555,14 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 		dev = alloc_netdev_mqs(0, "hsi%d", NET_NAME_UNKNOWN,
 				       ether_setup, QETH_MAX_QUEUES, 1);
 		break;
+	case QETH_CARD_TYPE_OSM:
+		dev = alloc_etherdev(0);
+		break;
 	case QETH_CARD_TYPE_OSN:
 		dev = alloc_netdev(0, "osn%d", NET_NAME_UNKNOWN, ether_setup);
 		break;
 	default:
-		dev = alloc_etherdev(0);
+		dev = alloc_etherdev_mqs(0, QETH_MAX_QUEUES, 1);
 	}
 
 	if (!dev)
@@ -5642,16 +5637,16 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	}
 
 	qeth_setup_card(card);
-	rc = qeth_update_from_chp_desc(card);
-	if (rc)
-		goto err_chp_desc;
-
 	card->dev = qeth_alloc_netdev(card);
 	if (!card->dev) {
 		rc = -ENOMEM;
 		goto err_card;
 	}
 
+	card->qdio.no_out_queues = card->dev->num_tx_queues;
+	rc = qeth_update_from_chp_desc(card);
+	if (rc)
+		goto err_chp_desc;
 	qeth_determine_capabilities(card);
 	enforced_disc = qeth_enforce_discipline(card);
 	switch (enforced_disc) {
@@ -5678,8 +5673,8 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 err_disc:
 	qeth_core_free_discipline(card);
 err_load:
-	free_netdev(card->dev);
 err_chp_desc:
+	free_netdev(card->dev);
 err_card:
 	qeth_core_free_card(card);
 err_dev:
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 1491281600c2..7381917f76dd 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -602,7 +602,6 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 {
 	struct qeth_card *card = dev->ml_priv;
 	u16 txq = skb_get_queue_mapping(skb);
-	int ipv = qeth_get_ip_version(skb);
 	struct qeth_qdio_out_q *queue;
 	int tx_bytes = skb->len;
 	int rc;
@@ -610,14 +609,14 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	if (IS_IQD(card))
 		queue = card->qdio.out_qs[qeth_iqd_translate_txq(dev, txq)];
 	else
-		queue = qeth_get_tx_queue(card, skb, ipv);
+		queue = card->qdio.out_qs[txq];
 
 	netif_stop_subqueue(dev, txq);
 
 	if (IS_OSN(card))
 		rc = qeth_l2_xmit_osn(card, skb, queue);
 	else
-		rc = qeth_xmit(card, skb, queue, ipv,
+		rc = qeth_xmit(card, skb, queue, qeth_get_ip_version(skb),
 			       qeth_l2_get_cast_type(skb), qeth_l2_fill_header);
 
 	if (!rc) {
@@ -638,8 +637,13 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 static u16 qeth_l2_select_queue(struct net_device *dev, struct sk_buff *skb,
 				struct net_device *sb_dev)
 {
-	return qeth_iqd_select_queue(dev, skb, qeth_l2_get_cast_type(skb),
-				     sb_dev);
+	struct qeth_card *card = dev->ml_priv;
+
+	if (IS_IQD(card))
+		return qeth_iqd_select_queue(dev, skb,
+					     qeth_l2_get_cast_type(skb),
+					     sb_dev);
+	return qeth_get_priority_queue(card, skb);
 }
 
 static const struct device_type qeth_l2_devtype = {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 120193e90adb..65244da4f415 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2084,7 +2084,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		else
 			cast_type = RTN_UNICAST;
 	} else {
-		queue = qeth_get_tx_queue(card, skb, ipv);
+		queue = card->qdio.out_qs[txq];
 		cast_type = qeth_l3_get_cast_type(skb);
 	}
 
@@ -2162,6 +2162,14 @@ static u16 qeth_l3_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
 				     sb_dev);
 }
 
+static u16 qeth_l3_osa_select_queue(struct net_device *dev, struct sk_buff *skb,
+				    struct net_device *sb_dev)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	return qeth_get_priority_queue(card, skb);
+}
+
 static const struct net_device_ops qeth_l3_netdev_ops = {
 	.ndo_open		= qeth_open,
 	.ndo_stop		= qeth_stop,
@@ -2184,6 +2192,7 @@ static const struct net_device_ops qeth_l3_osa_netdev_ops = {
 	.ndo_get_stats64	= qeth_get_stats64,
 	.ndo_start_xmit		= qeth_l3_hard_start_xmit,
 	.ndo_features_check	= qeth_l3_osa_features_check,
+	.ndo_select_queue	= qeth_l3_osa_select_queue,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= qeth_l3_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
-- 
2.16.4
