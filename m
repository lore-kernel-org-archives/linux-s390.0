Return-Path: <SRS0=4yje=QW=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/7] s390/qeth: add support for ETHTOOL_GRINGPARAM
Date: Fri, 15 Feb 2019 19:22:30 +0100
In-Reply-To: <20190215182231.90709-1-jwi@linux.ibm.com>
References: <20190215182231.90709-1-jwi@linux.ibm.com>
Message-Id: <20190215182231.90709-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Implement a trivial callback that exposes the queue sizes.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_ethtool.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index 9ce5ef5fcf7a..93a53fed4cf8 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -102,6 +102,22 @@ static void qeth_get_ethtool_stats(struct net_device *dev,
 				   txq_stats, TXQ_STATS_LEN);
 }
 
+static void qeth_get_ringparam(struct net_device *dev,
+			       struct ethtool_ringparam *param)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	param->rx_max_pending = QDIO_MAX_BUFFERS_PER_Q;
+	param->rx_mini_max_pending = 0;
+	param->rx_jumbo_max_pending = 0;
+	param->tx_max_pending = QDIO_MAX_BUFFERS_PER_Q;
+
+	param->rx_pending = card->qdio.in_buf_pool.buf_count;
+	param->rx_mini_pending = 0;
+	param->rx_jumbo_pending = 0;
+	param->tx_pending = QDIO_MAX_BUFFERS_PER_Q;
+}
+
 static void qeth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct qeth_card *card = dev->ml_priv;
@@ -338,6 +354,7 @@ static int qeth_get_link_ksettings(struct net_device *netdev,
 
 const struct ethtool_ops qeth_ethtool_ops = {
 	.get_link = ethtool_op_get_link,
+	.get_ringparam = qeth_get_ringparam,
 	.get_strings = qeth_get_strings,
 	.get_ethtool_stats = qeth_get_ethtool_stats,
 	.get_sset_count = qeth_get_sset_count,
-- 
2.16.4
