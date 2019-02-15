Return-Path: <SRS0=4yje=QW=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/7] s390/qeth: move ethtool code into its own file
Date: Fri, 15 Feb 2019 19:22:28 +0100
In-Reply-To: <20190215182231.90709-1-jwi@linux.ibm.com>
References: <20190215182231.90709-1-jwi@linux.ibm.com>
Message-Id: <20190215182231.90709-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Most of this is self-contained code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/Makefile         |   2 +-
 drivers/s390/net/qeth_core.h      |  12 +-
 drivers/s390/net/qeth_core_main.c | 317 +-----------------------------------
 drivers/s390/net/qeth_ethtool.c   | 333 ++++++++++++++++++++++++++++++++++++++
 drivers/s390/net/qeth_l2_main.c   |  23 +--
 drivers/s390/net/qeth_l3_main.c   |  10 --
 6 files changed, 346 insertions(+), 351 deletions(-)
 create mode 100644 drivers/s390/net/qeth_ethtool.c

diff --git a/drivers/s390/net/Makefile b/drivers/s390/net/Makefile
index f2d6bbe57a6f..bc55ec316adb 100644
--- a/drivers/s390/net/Makefile
+++ b/drivers/s390/net/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_NETIUCV) += netiucv.o fsm.o
 obj-$(CONFIG_SMSGIUCV) += smsgiucv.o
 obj-$(CONFIG_SMSGIUCV_EVENT) += smsgiucv_app.o
 obj-$(CONFIG_LCS) += lcs.o
-qeth-y += qeth_core_sys.o qeth_core_main.o qeth_core_mpc.o
+qeth-y += qeth_core_sys.o qeth_core_main.o qeth_core_mpc.o qeth_ethtool.o
 obj-$(CONFIG_QETH) += qeth.o
 qeth_l2-y += qeth_l2_main.o qeth_l2_sys.o
 obj-$(CONFIG_QETH_L2) += qeth_l2.o
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 9928728649eb..5e08f112db13 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -18,7 +18,6 @@
 #include <linux/in6.h>
 #include <linux/bitops.h>
 #include <linux/seq_file.h>
-#include <linux/ethtool.h>
 #include <linux/hashtable.h>
 #include <linux/ip.h>
 #include <linux/refcount.h>
@@ -922,6 +921,8 @@ static inline struct qeth_qdio_out_q *qeth_get_tx_queue(struct qeth_card *card,
 
 extern struct qeth_discipline qeth_l2_discipline;
 extern struct qeth_discipline qeth_l3_discipline;
+extern const struct ethtool_ops qeth_ethtool_ops;
+extern const struct ethtool_ops qeth_osn_ethtool_ops;
 extern const struct attribute_group *qeth_generic_attr_groups[];
 extern const struct attribute_group *qeth_osn_attr_groups[];
 extern const struct attribute_group qeth_device_attr_group;
@@ -976,20 +977,15 @@ void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 struct qeth_cmd_buffer *qeth_wait_for_buffer(struct qeth_channel *);
 int qeth_query_switch_attributes(struct qeth_card *card,
 				  struct qeth_switch_info *sw_info);
+int qeth_query_card_info(struct qeth_card *card,
+			 struct carrier_info *carrier_info);
 unsigned int qeth_count_elements(struct sk_buff *skb, unsigned int data_offset);
 int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			struct sk_buff *skb, struct qeth_hdr *hdr,
 			unsigned int offset, unsigned int hd_len,
 			int elements_needed);
 int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-int qeth_core_get_sset_count(struct net_device *, int);
-void qeth_core_get_ethtool_stats(struct net_device *,
-				struct ethtool_stats *, u64 *);
-void qeth_core_get_strings(struct net_device *, u32, u8 *);
-void qeth_core_get_drvinfo(struct net_device *, struct ethtool_drvinfo *);
 void qeth_dbf_longtext(debug_info_t *id, int level, char *text, ...);
-int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
-					 struct ethtool_link_ksettings *cmd);
 int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback);
 int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index e3127e232fb2..96e4876a4daa 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4698,8 +4698,8 @@ static int qeth_query_card_info_cb(struct qeth_card *card,
 	return 0;
 }
 
-static int qeth_query_card_info(struct qeth_card *card,
-				struct carrier_info *carrier_info)
+int qeth_query_card_info(struct qeth_card *card,
+			 struct carrier_info *carrier_info)
 {
 	struct qeth_cmd_buffer *iob;
 
@@ -5623,7 +5623,10 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 	SET_NETDEV_DEV(dev, &card->gdev->dev);
 	netif_carrier_off(dev);
 
-	if (!IS_OSN(card)) {
+	if (IS_OSN(card)) {
+		dev->ethtool_ops = &qeth_osn_ethtool_ops;
+	} else {
+		dev->ethtool_ops = &qeth_ethtool_ops;
 		dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 		dev->hw_features |= NETIF_F_SG;
 		dev->vlan_features |= NETIF_F_SG;
@@ -5911,314 +5914,6 @@ int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(qeth_do_ioctl);
 
-static struct {
-	const char str[ETH_GSTRING_LEN];
-} qeth_ethtool_stats_keys[] = {
-/*  0 */{"rx skbs"},
-	{"rx buffers"},
-	{"tx skbs"},
-	{"tx buffers"},
-	{"tx skbs no packing"},
-	{"tx buffers no packing"},
-	{"tx skbs packing"},
-	{"tx buffers packing"},
-	{"tx sg skbs"},
-	{"tx buffer elements"},
-/* 10 */{"rx sg skbs"},
-	{"rx sg frags"},
-	{"rx sg page allocs"},
-	{"tx large kbytes"},
-	{"tx large count"},
-	{"tx pk state ch n->p"},
-	{"tx pk state ch p->n"},
-	{"tx pk watermark low"},
-	{"tx pk watermark high"},
-	{"queue 0 buffer usage"},
-/* 20 */{"queue 1 buffer usage"},
-	{"queue 2 buffer usage"},
-	{"queue 3 buffer usage"},
-	{"tx csum"},
-	{"tx lin"},
-	{"tx linfail"},
-	{"rx csum"}
-};
-
-int qeth_core_get_sset_count(struct net_device *dev, int stringset)
-{
-	switch (stringset) {
-	case ETH_SS_STATS:
-		return (sizeof(qeth_ethtool_stats_keys) / ETH_GSTRING_LEN);
-	default:
-		return -EINVAL;
-	}
-}
-EXPORT_SYMBOL_GPL(qeth_core_get_sset_count);
-
-void qeth_core_get_ethtool_stats(struct net_device *dev,
-		struct ethtool_stats *stats, u64 *data)
-{
-	struct qeth_card *card = dev->ml_priv;
-	data[0] = card->stats.rx_packets -
-				card->perf_stats.initial_rx_packets;
-	data[1] = card->perf_stats.bufs_rec;
-	data[2] = card->stats.tx_packets -
-				card->perf_stats.initial_tx_packets;
-	data[3] = card->perf_stats.bufs_sent;
-	data[4] = card->stats.tx_packets - card->perf_stats.initial_tx_packets
-			- card->perf_stats.skbs_sent_pack;
-	data[5] = card->perf_stats.bufs_sent - card->perf_stats.bufs_sent_pack;
-	data[6] = card->perf_stats.skbs_sent_pack;
-	data[7] = card->perf_stats.bufs_sent_pack;
-	data[8] = card->perf_stats.sg_skbs_sent;
-	data[9] = card->perf_stats.buf_elements_sent;
-	data[10] = card->perf_stats.sg_skbs_rx;
-	data[11] = card->perf_stats.sg_frags_rx;
-	data[12] = card->perf_stats.sg_alloc_page_rx;
-	data[13] = (card->perf_stats.large_send_bytes >> 10);
-	data[14] = card->perf_stats.large_send_cnt;
-	data[15] = card->perf_stats.sc_dp_p;
-	data[16] = card->perf_stats.sc_p_dp;
-	data[17] = QETH_LOW_WATERMARK_PACK;
-	data[18] = QETH_HIGH_WATERMARK_PACK;
-	data[19] = atomic_read(&card->qdio.out_qs[0]->used_buffers);
-	data[20] = (card->qdio.no_out_queues > 1) ?
-			atomic_read(&card->qdio.out_qs[1]->used_buffers) : 0;
-	data[21] = (card->qdio.no_out_queues > 2) ?
-			atomic_read(&card->qdio.out_qs[2]->used_buffers) : 0;
-	data[22] = (card->qdio.no_out_queues > 3) ?
-			atomic_read(&card->qdio.out_qs[3]->used_buffers) : 0;
-	data[23] = card->perf_stats.tx_csum;
-	data[24] = card->perf_stats.tx_lin;
-	data[25] = card->perf_stats.tx_linfail;
-	data[26] = card->perf_stats.rx_csum;
-}
-EXPORT_SYMBOL_GPL(qeth_core_get_ethtool_stats);
-
-void qeth_core_get_strings(struct net_device *dev, u32 stringset, u8 *data)
-{
-	switch (stringset) {
-	case ETH_SS_STATS:
-		memcpy(data, &qeth_ethtool_stats_keys,
-			sizeof(qeth_ethtool_stats_keys));
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-}
-EXPORT_SYMBOL_GPL(qeth_core_get_strings);
-
-void qeth_core_get_drvinfo(struct net_device *dev,
-		struct ethtool_drvinfo *info)
-{
-	struct qeth_card *card = dev->ml_priv;
-
-	strlcpy(info->driver, IS_LAYER2(card) ? "qeth_l2" : "qeth_l3",
-		sizeof(info->driver));
-	strlcpy(info->version, "1.0", sizeof(info->version));
-	strlcpy(info->fw_version, card->info.mcl_level,
-		sizeof(info->fw_version));
-	snprintf(info->bus_info, sizeof(info->bus_info), "%s/%s/%s",
-		 CARD_RDEV_ID(card), CARD_WDEV_ID(card), CARD_DDEV_ID(card));
-}
-EXPORT_SYMBOL_GPL(qeth_core_get_drvinfo);
-
-/* Helper function to fill 'advertising' and 'supported' which are the same. */
-/* Autoneg and full-duplex are supported and advertised unconditionally.     */
-/* Always advertise and support all speeds up to specified, and only one     */
-/* specified port type.							     */
-static void qeth_set_cmd_adv_sup(struct ethtool_link_ksettings *cmd,
-				int maxspeed, int porttype)
-{
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_zero_link_mode(cmd, lp_advertising);
-
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
-
-	switch (porttype) {
-	case PORT_TP:
-		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
-		break;
-	case PORT_FIBRE:
-		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
-		break;
-	default:
-		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
-		WARN_ON_ONCE(1);
-	}
-
-	/* partially does fall through, to also select lower speeds */
-	switch (maxspeed) {
-	case SPEED_25000:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     25000baseSR_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     25000baseSR_Full);
-		break;
-	case SPEED_10000:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10000baseT_Full);
-	case SPEED_1000:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     1000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     1000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     1000baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     1000baseT_Half);
-	case SPEED_100:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     100baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     100baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     100baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     100baseT_Half);
-	case SPEED_10:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10baseT_Half);
-		/* end fallthrough */
-		break;
-	default:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10baseT_Half);
-		WARN_ON_ONCE(1);
-	}
-}
-
-int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
-		struct ethtool_link_ksettings *cmd)
-{
-	struct qeth_card *card = netdev->ml_priv;
-	enum qeth_link_types link_type;
-	struct carrier_info carrier_info;
-	int rc;
-
-	if ((card->info.type == QETH_CARD_TYPE_IQD) || (card->info.guestlan))
-		link_type = QETH_LINK_TYPE_10GBIT_ETH;
-	else
-		link_type = card->info.link_type;
-
-	cmd->base.duplex = DUPLEX_FULL;
-	cmd->base.autoneg = AUTONEG_ENABLE;
-	cmd->base.phy_address = 0;
-	cmd->base.mdio_support = 0;
-	cmd->base.eth_tp_mdix = ETH_TP_MDI_INVALID;
-	cmd->base.eth_tp_mdix_ctrl = ETH_TP_MDI_INVALID;
-
-	switch (link_type) {
-	case QETH_LINK_TYPE_FAST_ETH:
-	case QETH_LINK_TYPE_LANE_ETH100:
-		cmd->base.speed = SPEED_100;
-		cmd->base.port = PORT_TP;
-		break;
-	case QETH_LINK_TYPE_GBIT_ETH:
-	case QETH_LINK_TYPE_LANE_ETH1000:
-		cmd->base.speed = SPEED_1000;
-		cmd->base.port = PORT_FIBRE;
-		break;
-	case QETH_LINK_TYPE_10GBIT_ETH:
-		cmd->base.speed = SPEED_10000;
-		cmd->base.port = PORT_FIBRE;
-		break;
-	case QETH_LINK_TYPE_25GBIT_ETH:
-		cmd->base.speed = SPEED_25000;
-		cmd->base.port = PORT_FIBRE;
-		break;
-	default:
-		cmd->base.speed = SPEED_10;
-		cmd->base.port = PORT_TP;
-	}
-	qeth_set_cmd_adv_sup(cmd, cmd->base.speed, cmd->base.port);
-
-	/* Check if we can obtain more accurate information.	 */
-	/* If QUERY_CARD_INFO command is not supported or fails, */
-	/* just return the heuristics that was filled above.	 */
-	rc = qeth_query_card_info(card, &carrier_info);
-	if (rc == -EOPNOTSUPP) /* for old hardware, return heuristic */
-		return 0;
-	if (rc) /* report error from the hardware operation */
-		return rc;
-	/* on success, fill in the information got from the hardware */
-
-	netdev_dbg(netdev,
-	"card info: card_type=0x%02x, port_mode=0x%04x, port_speed=0x%08x\n",
-			carrier_info.card_type,
-			carrier_info.port_mode,
-			carrier_info.port_speed);
-
-	/* Update attributes for which we've obtained more authoritative */
-	/* information, leave the rest the way they where filled above.  */
-	switch (carrier_info.card_type) {
-	case CARD_INFO_TYPE_1G_COPPER_A:
-	case CARD_INFO_TYPE_1G_COPPER_B:
-		cmd->base.port = PORT_TP;
-		qeth_set_cmd_adv_sup(cmd, SPEED_1000, cmd->base.port);
-		break;
-	case CARD_INFO_TYPE_1G_FIBRE_A:
-	case CARD_INFO_TYPE_1G_FIBRE_B:
-		cmd->base.port = PORT_FIBRE;
-		qeth_set_cmd_adv_sup(cmd, SPEED_1000, cmd->base.port);
-		break;
-	case CARD_INFO_TYPE_10G_FIBRE_A:
-	case CARD_INFO_TYPE_10G_FIBRE_B:
-		cmd->base.port = PORT_FIBRE;
-		qeth_set_cmd_adv_sup(cmd, SPEED_10000, cmd->base.port);
-		break;
-	}
-
-	switch (carrier_info.port_mode) {
-	case CARD_INFO_PORTM_FULLDUPLEX:
-		cmd->base.duplex = DUPLEX_FULL;
-		break;
-	case CARD_INFO_PORTM_HALFDUPLEX:
-		cmd->base.duplex = DUPLEX_HALF;
-		break;
-	}
-
-	switch (carrier_info.port_speed) {
-	case CARD_INFO_PORTS_10M:
-		cmd->base.speed = SPEED_10;
-		break;
-	case CARD_INFO_PORTS_100M:
-		cmd->base.speed = SPEED_100;
-		break;
-	case CARD_INFO_PORTS_1G:
-		cmd->base.speed = SPEED_1000;
-		break;
-	case CARD_INFO_PORTS_10G:
-		cmd->base.speed = SPEED_10000;
-		break;
-	case CARD_INFO_PORTS_25G:
-		cmd->base.speed = SPEED_25000;
-		break;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(qeth_core_ethtool_get_link_ksettings);
-
 static int qeth_start_csum_cb(struct qeth_card *card, struct qeth_reply *reply,
 			      unsigned long data)
 {
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
new file mode 100644
index 000000000000..a275f31150b2
--- /dev/null
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2018
+ */
+
+#define KMSG_COMPONENT "qeth"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/ethtool.h>
+#include "qeth_core.h"
+
+static struct {
+	const char str[ETH_GSTRING_LEN];
+} qeth_ethtool_stats_keys[] = {
+/*  0 */{"rx skbs"},
+	{"rx buffers"},
+	{"tx skbs"},
+	{"tx buffers"},
+	{"tx skbs no packing"},
+	{"tx buffers no packing"},
+	{"tx skbs packing"},
+	{"tx buffers packing"},
+	{"tx sg skbs"},
+	{"tx buffer elements"},
+/* 10 */{"rx sg skbs"},
+	{"rx sg frags"},
+	{"rx sg page allocs"},
+	{"tx large kbytes"},
+	{"tx large count"},
+	{"tx pk state ch n->p"},
+	{"tx pk state ch p->n"},
+	{"tx pk watermark low"},
+	{"tx pk watermark high"},
+	{"queue 0 buffer usage"},
+/* 20 */{"queue 1 buffer usage"},
+	{"queue 2 buffer usage"},
+	{"queue 3 buffer usage"},
+	{"tx csum"},
+	{"tx lin"},
+	{"tx linfail"},
+	{"rx csum"}
+};
+
+static int qeth_get_sset_count(struct net_device *dev, int stringset)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		return (sizeof(qeth_ethtool_stats_keys) / ETH_GSTRING_LEN);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void qeth_get_ethtool_stats(struct net_device *dev,
+				   struct ethtool_stats *stats, u64 *data)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	data[0] = card->stats.rx_packets -
+				card->perf_stats.initial_rx_packets;
+	data[1] = card->perf_stats.bufs_rec;
+	data[2] = card->stats.tx_packets -
+				card->perf_stats.initial_tx_packets;
+	data[3] = card->perf_stats.bufs_sent;
+	data[4] = card->stats.tx_packets - card->perf_stats.initial_tx_packets
+			- card->perf_stats.skbs_sent_pack;
+	data[5] = card->perf_stats.bufs_sent - card->perf_stats.bufs_sent_pack;
+	data[6] = card->perf_stats.skbs_sent_pack;
+	data[7] = card->perf_stats.bufs_sent_pack;
+	data[8] = card->perf_stats.sg_skbs_sent;
+	data[9] = card->perf_stats.buf_elements_sent;
+	data[10] = card->perf_stats.sg_skbs_rx;
+	data[11] = card->perf_stats.sg_frags_rx;
+	data[12] = card->perf_stats.sg_alloc_page_rx;
+	data[13] = (card->perf_stats.large_send_bytes >> 10);
+	data[14] = card->perf_stats.large_send_cnt;
+	data[15] = card->perf_stats.sc_dp_p;
+	data[16] = card->perf_stats.sc_p_dp;
+	data[17] = QETH_LOW_WATERMARK_PACK;
+	data[18] = QETH_HIGH_WATERMARK_PACK;
+	data[19] = atomic_read(&card->qdio.out_qs[0]->used_buffers);
+	data[20] = (card->qdio.no_out_queues > 1) ?
+			atomic_read(&card->qdio.out_qs[1]->used_buffers) : 0;
+	data[21] = (card->qdio.no_out_queues > 2) ?
+			atomic_read(&card->qdio.out_qs[2]->used_buffers) : 0;
+	data[22] = (card->qdio.no_out_queues > 3) ?
+			atomic_read(&card->qdio.out_qs[3]->used_buffers) : 0;
+	data[23] = card->perf_stats.tx_csum;
+	data[24] = card->perf_stats.tx_lin;
+	data[25] = card->perf_stats.tx_linfail;
+	data[26] = card->perf_stats.rx_csum;
+}
+
+static void qeth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(data, &qeth_ethtool_stats_keys,
+			sizeof(qeth_ethtool_stats_keys));
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
+static void qeth_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	strlcpy(info->driver, IS_LAYER2(card) ? "qeth_l2" : "qeth_l3",
+		sizeof(info->driver));
+	strlcpy(info->version, "1.0", sizeof(info->version));
+	strlcpy(info->fw_version, card->info.mcl_level,
+		sizeof(info->fw_version));
+	snprintf(info->bus_info, sizeof(info->bus_info), "%s/%s/%s",
+		 CARD_RDEV_ID(card), CARD_WDEV_ID(card), CARD_DDEV_ID(card));
+}
+
+/* Helper function to fill 'advertising' and 'supported' which are the same. */
+/* Autoneg and full-duplex are supported and advertised unconditionally.     */
+/* Always advertise and support all speeds up to specified, and only one     */
+/* specified port type.							     */
+static void qeth_set_cmd_adv_sup(struct ethtool_link_ksettings *cmd,
+				int maxspeed, int porttype)
+{
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+	ethtool_link_ksettings_zero_link_mode(cmd, lp_advertising);
+
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+
+	switch (porttype) {
+	case PORT_TP:
+		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+		break;
+	case PORT_FIBRE:
+		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+		break;
+	default:
+		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+		WARN_ON_ONCE(1);
+	}
+
+	/* partially does fall through, to also select lower speeds */
+	switch (maxspeed) {
+	case SPEED_25000:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     25000baseSR_Full);
+		break;
+	case SPEED_10000:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     10000baseT_Full);
+		/* fall through */
+	case SPEED_1000:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     1000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     1000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     1000baseT_Half);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     1000baseT_Half);
+		/* fall through */
+	case SPEED_100:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     100baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     100baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     100baseT_Half);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     100baseT_Half);
+		/* fall through */
+	case SPEED_10:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     10baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10baseT_Half);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     10baseT_Half);
+		break;
+	default:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     10baseT_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     10baseT_Half);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     10baseT_Half);
+		WARN_ON_ONCE(1);
+	}
+}
+
+
+static int qeth_get_link_ksettings(struct net_device *netdev,
+				   struct ethtool_link_ksettings *cmd)
+{
+	struct qeth_card *card = netdev->ml_priv;
+	enum qeth_link_types link_type;
+	struct carrier_info carrier_info;
+	int rc;
+
+	if (IS_IQD(card) || IS_VM_NIC(card))
+		link_type = QETH_LINK_TYPE_10GBIT_ETH;
+	else
+		link_type = card->info.link_type;
+
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.autoneg = AUTONEG_ENABLE;
+	cmd->base.phy_address = 0;
+	cmd->base.mdio_support = 0;
+	cmd->base.eth_tp_mdix = ETH_TP_MDI_INVALID;
+	cmd->base.eth_tp_mdix_ctrl = ETH_TP_MDI_INVALID;
+
+	switch (link_type) {
+	case QETH_LINK_TYPE_FAST_ETH:
+	case QETH_LINK_TYPE_LANE_ETH100:
+		cmd->base.speed = SPEED_100;
+		cmd->base.port = PORT_TP;
+		break;
+	case QETH_LINK_TYPE_GBIT_ETH:
+	case QETH_LINK_TYPE_LANE_ETH1000:
+		cmd->base.speed = SPEED_1000;
+		cmd->base.port = PORT_FIBRE;
+		break;
+	case QETH_LINK_TYPE_10GBIT_ETH:
+		cmd->base.speed = SPEED_10000;
+		cmd->base.port = PORT_FIBRE;
+		break;
+	case QETH_LINK_TYPE_25GBIT_ETH:
+		cmd->base.speed = SPEED_25000;
+		cmd->base.port = PORT_FIBRE;
+		break;
+	default:
+		cmd->base.speed = SPEED_10;
+		cmd->base.port = PORT_TP;
+	}
+	qeth_set_cmd_adv_sup(cmd, cmd->base.speed, cmd->base.port);
+
+	/* Check if we can obtain more accurate information.	 */
+	/* If QUERY_CARD_INFO command is not supported or fails, */
+	/* just return the heuristics that was filled above.	 */
+	rc = qeth_query_card_info(card, &carrier_info);
+	if (rc == -EOPNOTSUPP) /* for old hardware, return heuristic */
+		return 0;
+	if (rc) /* report error from the hardware operation */
+		return rc;
+	/* on success, fill in the information got from the hardware */
+
+	netdev_dbg(netdev,
+	"card info: card_type=0x%02x, port_mode=0x%04x, port_speed=0x%08x\n",
+			carrier_info.card_type,
+			carrier_info.port_mode,
+			carrier_info.port_speed);
+
+	/* Update attributes for which we've obtained more authoritative */
+	/* information, leave the rest the way they where filled above.  */
+	switch (carrier_info.card_type) {
+	case CARD_INFO_TYPE_1G_COPPER_A:
+	case CARD_INFO_TYPE_1G_COPPER_B:
+		cmd->base.port = PORT_TP;
+		qeth_set_cmd_adv_sup(cmd, SPEED_1000, cmd->base.port);
+		break;
+	case CARD_INFO_TYPE_1G_FIBRE_A:
+	case CARD_INFO_TYPE_1G_FIBRE_B:
+		cmd->base.port = PORT_FIBRE;
+		qeth_set_cmd_adv_sup(cmd, SPEED_1000, cmd->base.port);
+		break;
+	case CARD_INFO_TYPE_10G_FIBRE_A:
+	case CARD_INFO_TYPE_10G_FIBRE_B:
+		cmd->base.port = PORT_FIBRE;
+		qeth_set_cmd_adv_sup(cmd, SPEED_10000, cmd->base.port);
+		break;
+	}
+
+	switch (carrier_info.port_mode) {
+	case CARD_INFO_PORTM_FULLDUPLEX:
+		cmd->base.duplex = DUPLEX_FULL;
+		break;
+	case CARD_INFO_PORTM_HALFDUPLEX:
+		cmd->base.duplex = DUPLEX_HALF;
+		break;
+	}
+
+	switch (carrier_info.port_speed) {
+	case CARD_INFO_PORTS_10M:
+		cmd->base.speed = SPEED_10;
+		break;
+	case CARD_INFO_PORTS_100M:
+		cmd->base.speed = SPEED_100;
+		break;
+	case CARD_INFO_PORTS_1G:
+		cmd->base.speed = SPEED_1000;
+		break;
+	case CARD_INFO_PORTS_10G:
+		cmd->base.speed = SPEED_10000;
+		break;
+	case CARD_INFO_PORTS_25G:
+		cmd->base.speed = SPEED_25000;
+		break;
+	}
+
+	return 0;
+}
+
+const struct ethtool_ops qeth_ethtool_ops = {
+	.get_link = ethtool_op_get_link,
+	.get_strings = qeth_get_strings,
+	.get_ethtool_stats = qeth_get_ethtool_stats,
+	.get_sset_count = qeth_get_sset_count,
+	.get_drvinfo = qeth_get_drvinfo,
+	.get_link_ksettings = qeth_get_link_ksettings,
+};
+
+const struct ethtool_ops qeth_osn_ethtool_ops = {
+	.get_strings = qeth_get_strings,
+	.get_ethtool_stats = qeth_get_ethtool_stats,
+	.get_sset_count = qeth_get_sset_count,
+	.get_drvinfo = qeth_get_drvinfo,
+};
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8931dd6e2caa..dbcba77fd94c 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -696,22 +696,6 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 		unregister_netdev(card->dev);
 }
 
-static const struct ethtool_ops qeth_l2_ethtool_ops = {
-	.get_link = ethtool_op_get_link,
-	.get_strings = qeth_core_get_strings,
-	.get_ethtool_stats = qeth_core_get_ethtool_stats,
-	.get_sset_count = qeth_core_get_sset_count,
-	.get_drvinfo = qeth_core_get_drvinfo,
-	.get_link_ksettings = qeth_core_ethtool_get_link_ksettings,
-};
-
-static const struct ethtool_ops qeth_l2_osn_ops = {
-	.get_strings = qeth_core_get_strings,
-	.get_ethtool_stats = qeth_core_get_ethtool_stats,
-	.get_sset_count = qeth_core_get_sset_count,
-	.get_drvinfo = qeth_core_get_drvinfo,
-};
-
 static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_open		= qeth_open,
 	.ndo_stop		= qeth_stop,
@@ -735,13 +719,10 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 
 	card->dev->priv_flags |= IFF_UNICAST_FLT;
 	card->dev->netdev_ops = &qeth_l2_netdev_ops;
-	if (card->info.type == QETH_CARD_TYPE_OSN) {
-		card->dev->ethtool_ops = &qeth_l2_osn_ops;
+	if (IS_OSN(card))
 		card->dev->flags |= IFF_NOARP;
-	} else {
-		card->dev->ethtool_ops = &qeth_l2_ethtool_ops;
+	else
 		card->dev->needed_headroom = sizeof(struct qeth_hdr);
-	}
 
 	if (IS_OSM(card)) {
 		card->dev->features |= NETIF_F_VLAN_CHALLENGED;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 012a290f1f4b..40c7d53f5512 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2117,15 +2117,6 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static const struct ethtool_ops qeth_l3_ethtool_ops = {
-	.get_link = ethtool_op_get_link,
-	.get_strings = qeth_core_get_strings,
-	.get_ethtool_stats = qeth_core_get_ethtool_stats,
-	.get_sset_count = qeth_core_get_sset_count,
-	.get_drvinfo = qeth_core_get_drvinfo,
-	.get_link_ksettings = qeth_core_ethtool_get_link_ksettings,
-};
-
 /*
  * we need NOARP for IPv4 but we want neighbor solicitation for IPv6. Setting
  * NOARP on the netdevice is no option because it also turns off neighbor
@@ -2247,7 +2238,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card, bool carrier_ok)
 		return -ENODEV;
 
 	card->dev->needed_headroom = headroom;
-	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
 	card->dev->features |=	NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
-- 
2.16.4
