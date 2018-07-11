From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/10] s390/qeth: clean up Output Queue selection
Date: Wed, 11 Jul 2018 17:42:41 +0200
Message-ID: <20180711154247.5523-5-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Consolidate duplicated code, fix the misuse of RTN_UNSPEC and simplify
the handling of non-unicast traffic on IQD devices.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 15 +++++++++++++--
 drivers/s390/net/qeth_core_main.c |  8 +-------
 drivers/s390/net/qeth_core_mpc.h  |  2 ++
 drivers/s390/net/qeth_l2_main.c   | 13 ++++---------
 drivers/s390/net/qeth_l3_main.c   | 16 +++++++---------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 0ca6ea319d88..082c06d6380b 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -661,7 +661,6 @@ struct qeth_card_info {
 	int portno;
 	enum qeth_card_types type;
 	enum qeth_link_types link_type;
-	int is_multicast_different;
 	int initial_mtu;
 	int max_mtu;
 	int broadcast_capable;
@@ -934,6 +933,19 @@ static inline int qeth_send_simple_setassparms_v6(struct qeth_card *card,
 						 data, QETH_PROT_IPV6);
 }
 
+int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
+			    int ipv);
+static inline struct qeth_qdio_out_q *qeth_get_tx_queue(struct qeth_card *card,
+							struct sk_buff *skb,
+							int ipv, int cast_type)
+{
+	if (IS_IQD(card) && cast_type != RTN_UNICAST)
+		return card->qdio.out_qs[card->qdio.no_out_queues - 1];
+	if (!card->qdio.do_prio_queueing)
+		return card->qdio.out_qs[card->qdio.default_out_queue];
+	return card->qdio.out_qs[qeth_get_priority_queue(card, skb, ipv)];
+}
+
 extern struct qeth_discipline qeth_l2_discipline;
 extern struct qeth_discipline qeth_l3_discipline;
 extern const struct attribute_group *qeth_generic_attr_groups[];
@@ -1001,7 +1013,6 @@ int qeth_bridgeport_query_ports(struct qeth_card *card,
 	enum qeth_sbp_roles *role, enum qeth_sbp_states *state);
 int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role);
 int qeth_bridgeport_an_set(struct qeth_card *card, int enable);
-int qeth_get_priority_queue(struct qeth_card *, struct sk_buff *, int, int);
 int qeth_get_elements_no(struct qeth_card *card, struct sk_buff *skb,
 			 int extra_elems, int data_offset);
 int qeth_get_elements_for_frags(struct sk_buff *);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cfe68e3bfe7a..e8b18a9e07d7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1537,8 +1537,6 @@ static void qeth_determine_card_type(struct qeth_card *card)
 	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 	card->info.type = CARD_RDEV(card)->id.driver_info;
 	card->qdio.no_out_queues = QETH_MAX_QUEUES;
-	if (card->info.type == QETH_CARD_TYPE_IQD)
-		card->info.is_multicast_different = 0x0103;
 	qeth_update_from_chp_desc(card);
 }
 
@@ -3777,15 +3775,11 @@ static inline int qeth_cut_iqd_prio(struct qeth_card *card, int queue_num)
  * Note: Function assumes that we have 4 outbound queues.
  */
 int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb,
-			int ipv, int cast_type)
+			    int ipv)
 {
 	__be16 *tci;
 	u8 tos;
 
-	if (cast_type && card->info.is_multicast_different)
-		return card->info.is_multicast_different &
-			(card->qdio.no_out_queues - 1);
-
 	switch (card->qdio.do_prio_queueing) {
 	case QETH_PRIO_Q_ING_TOS:
 	case QETH_PRIO_Q_ING_PREC:
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 878e62f35169..54c35224262a 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -64,6 +64,8 @@ enum qeth_card_types {
 	QETH_CARD_TYPE_OSX     = 2,
 };
 
+#define IS_IQD(card)	((card)->info.type == QETH_CARD_TYPE_IQD)
+
 #define QETH_MPC_DIFINFO_LEN_INDICATES_LINK_TYPE 0x18
 /* only the first two bytes are looked at in qeth_get_cardname_short */
 enum qeth_link_types {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 730ab51fbac5..5910fd524872 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -185,12 +185,12 @@ static void qeth_l2_del_all_macs(struct qeth_card *card)
 static int qeth_l2_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
 {
 	if (card->info.type == QETH_CARD_TYPE_OSN)
-		return RTN_UNSPEC;
+		return RTN_UNICAST;
 	if (is_broadcast_ether_addr(skb->data))
 		return RTN_BROADCAST;
 	if (is_multicast_ether_addr(skb->data))
 		return RTN_MULTICAST;
-	return RTN_UNSPEC;
+	return RTN_UNICAST;
 }
 
 static void qeth_l2_fill_header(struct qeth_hdr *hdr, struct sk_buff *skb,
@@ -768,18 +768,13 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	int tx_bytes = skb->len;
 	int rc;
 
-	if (card->qdio.do_prio_queueing || (cast_type &&
-					card->info.is_multicast_different))
-		queue = card->qdio.out_qs[qeth_get_priority_queue(card, skb,
-					ipv, cast_type)];
-	else
-		queue = card->qdio.out_qs[card->qdio.default_out_queue];
-
 	if ((card->state != CARD_STATE_UP) || !card->lan_online) {
 		card->stats.tx_carrier_errors++;
 		goto tx_drop;
 	}
 
+	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
+
 	if (card->options.performance_stats) {
 		card->perf_stats.outbound_cnt++;
 		card->perf_stats.outbound_start_time = qeth_get_micros();
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index a54881cdda82..7b4de46bf6e3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1978,17 +1978,17 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 		    (cast_type == RTN_MULTICAST) ||
 		    (cast_type == RTN_ANYCAST))
 			return cast_type;
-		return RTN_UNSPEC;
+		return RTN_UNICAST;
 	}
 	rcu_read_unlock();
 
 	/* no neighbour (eg AF_PACKET), fall back to target's IP address ... */
 	if (be16_to_cpu(skb->protocol) == ETH_P_IPV6)
 		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) ?
-				RTN_MULTICAST : RTN_UNSPEC;
+				RTN_MULTICAST : RTN_UNICAST;
 	else if (be16_to_cpu(skb->protocol) == ETH_P_IP)
 		return ipv4_is_multicast(ip_hdr(skb)->daddr) ?
-				RTN_MULTICAST : RTN_UNSPEC;
+				RTN_MULTICAST : RTN_UNICAST;
 
 	/* ... and MAC address */
 	if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest, skb->dev->broadcast))
@@ -1997,7 +1997,7 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 		return RTN_MULTICAST;
 
 	/* default to unicast */
-	return RTN_UNSPEC;
+	return RTN_UNICAST;
 }
 
 static void qeth_l3_fill_af_iucv_hdr(struct qeth_card *card,
@@ -2168,11 +2168,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	struct sk_buff *new_skb = NULL;
 	int ipv = qeth_get_ip_version(skb);
 	int cast_type = qeth_l3_get_cast_type(skb);
-	struct qeth_qdio_out_q *queue =
-		card->qdio.out_qs[card->qdio.do_prio_queueing
-			|| (cast_type && card->info.is_multicast_different) ?
-			qeth_get_priority_queue(card, skb, ipv, cast_type) :
-			card->qdio.default_out_queue];
+	struct qeth_qdio_out_q *queue;
 	int tx_bytes = skb->len;
 	unsigned int hd_len = 0;
 	bool use_tso;
@@ -2195,6 +2191,8 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	    (card->info.broadcast_capable == 0))
 		goto tx_drop;
 
+	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
+
 	if (card->options.performance_stats) {
 		card->perf_stats.outbound_cnt++;
 		card->perf_stats.outbound_start_time = qeth_get_micros();
-- 
2.16.4
