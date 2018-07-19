From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/11] s390/qeth: simplify max MTU handling
Date: Thu, 19 Jul 2018 12:43:53 +0200
Message-ID: <20180719104358.79696-7-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When the MPC initialization code discovers the HW-specific max MTU,
apply the resulting changes straight to the netdevice.

If this is the device's first initialization, also set its MTU
(HiperSockets: the max MTU; else: a layer-specific default value).
Then cap the current MTU by the new max MTU.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 -
 drivers/s390/net/qeth_core_main.c | 82 +++++++++++++++++++++------------------
 drivers/s390/net/qeth_l2_main.c   |  1 -
 drivers/s390/net/qeth_l3_main.c   |  1 -
 4 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 04b900c7060d..6f02a6cbe59e 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -660,8 +660,6 @@ struct qeth_card_info {
 	int mac_bits;
 	enum qeth_card_types type;
 	enum qeth_link_types link_type;
-	int initial_mtu;
-	int max_mtu;
 	int broadcast_capable;
 	int unique_id;
 	bool layer_enforced;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 39c429787c4d..ab3d63f98779 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2278,19 +2278,42 @@ static int qeth_cm_setup(struct qeth_card *card)
 
 }
 
-static int qeth_get_initial_mtu_for_card(struct qeth_card *card)
+static int qeth_update_max_mtu(struct qeth_card *card, unsigned int max_mtu)
 {
-	switch (card->info.type) {
-	case QETH_CARD_TYPE_IQD:
-		return card->info.max_mtu;
-	case QETH_CARD_TYPE_OSD:
-	case QETH_CARD_TYPE_OSX:
-		if (!card->options.layer2)
-			return ETH_DATA_LEN - 8; /* L3: allow for LLC + SNAP */
-		/* fall through */
-	default:
-		return ETH_DATA_LEN;
+	struct net_device *dev = card->dev;
+	unsigned int new_mtu;
+
+	if (!max_mtu) {
+		/* IQD needs accurate max MTU to set up its RX buffers: */
+		if (IS_IQD(card))
+			return -EINVAL;
+		/* tolerate quirky HW: */
+		max_mtu = ETH_MAX_MTU;
+	}
+
+	rtnl_lock();
+	if (IS_IQD(card)) {
+		/* move any device with default MTU to new max MTU: */
+		new_mtu = (dev->mtu == dev->max_mtu) ? max_mtu : dev->mtu;
+
+		/* adjust RX buffer size to new max MTU: */
+		card->qdio.in_buf_size = max_mtu + 2 * PAGE_SIZE;
+		if (dev->max_mtu && dev->max_mtu != max_mtu)
+			qeth_free_qdio_buffers(card);
+	} else {
+		if (dev->mtu)
+			new_mtu = dev->mtu;
+		/* default MTUs for first setup: */
+		else if (card->options.layer2)
+			new_mtu = ETH_DATA_LEN;
+		else
+			new_mtu = ETH_DATA_LEN - 8; /* allow for LLC + SNAP */
 	}
+
+	dev->max_mtu = max_mtu;
+	dev->mtu = min(new_mtu, max_mtu);
+	rtnl_unlock();
+	return 0;
 }
 
 static int qeth_get_mtu_outof_framesize(int framesize)
@@ -2316,8 +2339,7 @@ static int qeth_mtu_is_valid(struct qeth_card *card, int mtu)
 	case QETH_CARD_TYPE_OSM:
 	case QETH_CARD_TYPE_OSX:
 	case QETH_CARD_TYPE_IQD:
-		return ((mtu >= 576) &&
-			(mtu <= card->info.max_mtu));
+		return ((mtu >= 576) && (mtu <= card->dev->max_mtu));
 	case QETH_CARD_TYPE_OSN:
 	default:
 		return 1;
@@ -2342,28 +2364,10 @@ static int qeth_ulp_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 	if (card->info.type == QETH_CARD_TYPE_IQD) {
 		memcpy(&framesize, QETH_ULP_ENABLE_RESP_MAX_MTU(iob->data), 2);
 		mtu = qeth_get_mtu_outof_framesize(framesize);
-		if (!mtu) {
-			iob->rc = -EINVAL;
-			QETH_DBF_TEXT_(SETUP, 2, "  rc%d", iob->rc);
-			return 0;
-		}
-		if (card->info.initial_mtu && (card->info.initial_mtu != mtu)) {
-			/* frame size has changed */
-			if ((card->dev->mtu == card->info.initial_mtu) ||
-			    (card->dev->mtu > mtu))
-				card->dev->mtu = mtu;
-			qeth_free_qdio_buffers(card);
-		}
-		card->info.initial_mtu = mtu;
-		card->info.max_mtu = mtu;
-		card->qdio.in_buf_size = mtu + 2 * PAGE_SIZE;
 	} else {
-		card->info.max_mtu = *(__u16 *)QETH_ULP_ENABLE_RESP_MAX_MTU(
-			iob->data);
-		card->info.initial_mtu = min(card->info.max_mtu,
-					qeth_get_initial_mtu_for_card(card));
-		card->qdio.in_buf_size = QETH_IN_BUF_SIZE_DEFAULT;
+		mtu = *(__u16 *)QETH_ULP_ENABLE_RESP_MAX_MTU(iob->data);
 	}
+	*(u16 *)reply->param = mtu;
 
 	memcpy(&len, QETH_ULP_ENABLE_RESP_DIFINFO_LEN(iob->data), 2);
 	if (len >= QETH_MPC_DIFINFO_LEN_INDICATES_LINK_TYPE) {
@@ -2382,6 +2386,7 @@ static int qeth_ulp_enable(struct qeth_card *card)
 	int rc;
 	char prot_type;
 	struct qeth_cmd_buffer *iob;
+	u16 max_mtu;
 
 	/*FIXME: trace view callbacks*/
 	QETH_DBF_TEXT(SETUP, 2, "ulpenabl");
@@ -2404,9 +2409,10 @@ static int qeth_ulp_enable(struct qeth_card *card)
 	memcpy(QETH_ULP_ENABLE_FILTER_TOKEN(iob->data),
 	       &card->token.ulp_filter_w, QETH_MPC_TOKEN_LENGTH);
 	rc = qeth_send_control_data(card, ULP_ENABLE_SIZE, iob,
-				    qeth_ulp_enable_cb, NULL);
-	return rc;
-
+				    qeth_ulp_enable_cb, &max_mtu);
+	if (rc)
+		return rc;
+	return qeth_update_max_mtu(card, max_mtu);
 }
 
 static int qeth_ulp_setup_cb(struct qeth_card *card, struct qeth_reply *reply,
@@ -5691,7 +5697,9 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 	dev->ml_priv = card;
 	dev->watchdog_timeo = QETH_TX_TIMEOUT;
 	dev->min_mtu = 64;
-	dev->max_mtu = ETH_MAX_MTU;
+	 /* initialized when device first goes online: */
+	dev->max_mtu = 0;
+	dev->mtu = 0;
 	SET_NETDEV_DEV(dev, &card->gdev->dev);
 	netif_carrier_off(dev);
 	return dev;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8392fc7e809c..00d8bb1d2a41 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -944,7 +944,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 		return 0;
 
 	card->dev->priv_flags |= IFF_UNICAST_FLT;
-	card->dev->mtu = card->info.initial_mtu;
 	card->dev->netdev_ops = &qeth_l2_netdev_ops;
 	if (card->info.type == QETH_CARD_TYPE_OSN) {
 		card->dev->ethtool_ops = &qeth_l2_osn_ops;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 72c8f323801b..e5fa8e5ac1b3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2579,7 +2579,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 	} else
 		return -ENODEV;
 
-	card->dev->mtu = card->info.initial_mtu;
 	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
 	card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
-- 
2.16.4
