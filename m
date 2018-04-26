From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/13] s390/qeth: add stats counter for RX csum offload
Date: Thu, 26 Apr 2018 09:42:19 +0200
Message-ID: <20180426074224.100432-9-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

This matches the statistics we gather for the TX offload path.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 8 ++++++--
 drivers/s390/net/qeth_core_main.c | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 2cfeae485a08..e8108f6891b2 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -148,6 +148,7 @@ struct qeth_perf_stats {
 	unsigned int tx_csum;
 	unsigned int tx_lin;
 	unsigned int tx_linfail;
+	unsigned int rx_csum;
 };
 
 /* Routing stuff */
@@ -868,10 +869,13 @@ static inline void qeth_rx_csum(struct qeth_card *card, struct sk_buff *skb,
 				u8 flags)
 {
 	if ((card->dev->features & NETIF_F_RXCSUM) &&
-	    (flags & QETH_HDR_EXT_CSUM_TRANSP_REQ))
+	    (flags & QETH_HDR_EXT_CSUM_TRANSP_REQ)) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
-	else
+		if (card->options.performance_stats)
+			card->perf_stats.rx_csum++;
+	} else {
 		skb->ip_summed = CHECKSUM_NONE;
+	}
 }
 
 static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags)
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7feb50ac0a8b..b90f38d78ad9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6005,7 +6005,8 @@ static struct {
 	{"tx lin"},
 	{"tx linfail"},
 	{"cq handler count"},
-	{"cq handler time"}
+	{"cq handler time"},
+	{"rx csum"}
 };
 
 int qeth_core_get_sset_count(struct net_device *dev, int stringset)
@@ -6067,6 +6068,7 @@ void qeth_core_get_ethtool_stats(struct net_device *dev,
 	data[35] = card->perf_stats.tx_linfail;
 	data[36] = card->perf_stats.cq_cnt;
 	data[37] = card->perf_stats.cq_time;
+	data[38] = card->perf_stats.rx_csum;
 }
 EXPORT_SYMBOL_GPL(qeth_core_get_ethtool_stats);
 
-- 
2.13.5
