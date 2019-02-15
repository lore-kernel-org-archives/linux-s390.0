Return-Path: <SRS0=4yje=QW=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/7] s390/qeth: split out OSN netdev ops
Date: Fri, 15 Feb 2019 19:22:31 +0100
In-Reply-To: <20190215182231.90709-1-jwi@linux.ibm.com>
References: <20190215182231.90709-1-jwi@linux.ibm.com>
Message-Id: <20190215182231.90709-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Rather than special-casing OSN in a number of places, just give this
device type its own netdev_ops structure.

When setting up the OSN net_device, also skip the handling of the
various HW offloads (eg TSO). The device shouldn't be advertising any of
them, and the OSN code paths in qeth don't have support for them.
In particular RX VLAN filtering is not supported, so don't hook up those
callbacks in the netdev_ops.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |  3 ---
 drivers/s390/net/qeth_core_mpc.h  |  1 +
 drivers/s390/net/qeth_l2_main.c   | 32 ++++++++++++++++++++------------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6d93bb48b1d9..4708df39f129 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5850,9 +5850,6 @@ int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	if (!card)
 		return -ENODEV;
 
-	if (card->info.type == QETH_CARD_TYPE_OSN)
-		return -EPERM;
-
 	switch (cmd) {
 	case SIOC_QETH_ADP_SET_SNMP_CONTROL:
 		rc = qeth_snmp_command(card, rq->ifr_ifru.ifru_data);
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 4b1690380ebe..f8c5d4a9be13 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -81,6 +81,7 @@ enum qeth_card_types {
 #define IS_OSD(card)	((card)->info.type == QETH_CARD_TYPE_OSD)
 #define IS_OSM(card)	((card)->info.type == QETH_CARD_TYPE_OSM)
 #define IS_OSN(card)	((card)->info.type == QETH_CARD_TYPE_OSN)
+#define IS_OSX(card)	((card)->info.type == QETH_CARD_TYPE_OSX)
 #define IS_VM_NIC(card)	((card)->info.guestlan)
 
 #define QETH_MPC_DIFINFO_LEN_INDICATES_LINK_TYPE 0x18
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index b1280a155953..2c9714215775 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -425,7 +425,7 @@ static int qeth_l2_validate_addr(struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
 
-	if (IS_OSN(card) || (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
+	if (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED)
 		return eth_validate_addr(dev);
 
 	QETH_CARD_TEXT(card, 4, "nomacadr");
@@ -441,9 +441,7 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 
 	QETH_CARD_TEXT(card, 3, "setmac");
 
-	if (card->info.type == QETH_CARD_TYPE_OSN ||
-	    card->info.type == QETH_CARD_TYPE_OSM ||
-	    card->info.type == QETH_CARD_TYPE_OSX) {
+	if (IS_OSM(card) || IS_OSX(card)) {
 		QETH_CARD_TEXT(card, 3, "setmcTYP");
 		return -EOPNOTSUPP;
 	}
@@ -537,9 +535,6 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 	int i;
 	int rc;
 
-	if (card->info.type == QETH_CARD_TYPE_OSN)
-		return;
-
 	QETH_CARD_TEXT(card, 3, "setmulti");
 
 	spin_lock_bh(&card->mclock);
@@ -713,16 +708,28 @@ static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_set_features	= qeth_set_features
 };
 
+static const struct net_device_ops qeth_osn_netdev_ops = {
+	.ndo_open		= qeth_open,
+	.ndo_stop		= qeth_stop,
+	.ndo_get_stats64	= qeth_get_stats64,
+	.ndo_start_xmit		= qeth_l2_hard_start_xmit,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_tx_timeout		= qeth_tx_timeout,
+};
+
 static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 {
 	int rc;
 
-	card->dev->priv_flags |= IFF_UNICAST_FLT;
-	card->dev->netdev_ops = &qeth_l2_netdev_ops;
-	if (IS_OSN(card))
+	if (IS_OSN(card)) {
+		card->dev->netdev_ops = &qeth_osn_netdev_ops;
 		card->dev->flags |= IFF_NOARP;
-	else
-		card->dev->needed_headroom = sizeof(struct qeth_hdr);
+		goto add_napi;
+	}
+
+	card->dev->needed_headroom = sizeof(struct qeth_hdr);
+	card->dev->netdev_ops = &qeth_l2_netdev_ops;
+	card->dev->priv_flags |= IFF_UNICAST_FLT;
 
 	if (IS_OSM(card)) {
 		card->dev->features |= NETIF_F_VLAN_CHALLENGED;
@@ -764,6 +771,7 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 				       PAGE_SIZE * (QDIO_MAX_ELEMENTS_PER_BUFFER - 1));
 	}
 
+add_napi:
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
 	rc = register_netdev(card->dev);
 	if (!rc && carrier_ok)
-- 
2.16.4
