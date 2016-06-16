From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 07/13] qeth: introduce linearization fail count to stats
Date: Thu, 16 Jun 2016 16:18:57 +0200
Message-ID: <1466086743-55484-8-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>

When skb data touches too many pages, skb_linearize() is called
opportunistically in the hope that less pages will be required
for a big linear buffer than for multiple fragments. This patch
intoduces a separate counter in ethtool statistics structure
representing _failed_ linearization attempts.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Lakhvich Dmitriy <ldmitriy@ru.ibm.com>
Reviewed-by: Thomas Richter <tmricht@de.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c |  6 ++++--
 drivers/s390/net/qeth_l2_main.c   | 12 +++++++++---
 drivers/s390/net/qeth_l3_main.c   | 12 +++++++++---
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c3ab956..b4f14e4 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -145,6 +145,7 @@ struct qeth_perf_stats {
 	unsigned int sg_alloc_page_rx;
 	unsigned int tx_csum;
 	unsigned int tx_lin;
+	unsigned int tx_linfail;
 };
 
 /* Routing stuff */
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a91a31d..9806ee0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5801,6 +5801,7 @@ static struct {
 	{"tx do_QDIO count"},
 	{"tx csum"},
 	{"tx lin"},
+	{"tx linfail"},
 	{"cq handler count"},
 	{"cq handler time"}
 };
@@ -5861,8 +5862,9 @@ void qeth_core_get_ethtool_stats(struct net_device *dev,
 	data[32] = card->perf_stats.outbound_do_qdio_cnt;
 	data[33] = card->perf_stats.tx_csum;
 	data[34] = card->perf_stats.tx_lin;
-	data[35] = card->perf_stats.cq_cnt;
-	data[36] = card->perf_stats.cq_time;
+	data[35] = card->perf_stats.tx_linfail;
+	data[36] = card->perf_stats.cq_cnt;
+	data[37] = card->perf_stats.cq_time;
 }
 EXPORT_SYMBOL_GPL(qeth_core_get_ethtool_stats);
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index e24627f..08b5fa9 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -898,10 +898,16 @@ static int qeth_l2_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	if ((card->info.type != QETH_CARD_TYPE_IQD) &&
 	    !qeth_get_elements_no(card, new_skb, 0)) {
-		if (skb_linearize(new_skb))
+		int lin_rc = skb_linearize(new_skb);
+
+		if (card->options.performance_stats) {
+			if (lin_rc)
+				card->perf_stats.tx_linfail++;
+			else
+				card->perf_stats.tx_lin++;
+		}
+		if (lin_rc)
 			goto tx_drop;
-		if (card->options.performance_stats)
-			card->perf_stats.tx_lin++;
 	}
 
 	if (card->info.type == QETH_CARD_TYPE_OSN)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0afdb14..51077fb 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2918,10 +2918,16 @@ static int qeth_l3_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if ((card->info.type != QETH_CARD_TYPE_IQD) &&
 	    ((use_tso && !qeth_l3_get_elements_no_tso(card, new_skb, 1)) ||
 	     (!use_tso && !qeth_get_elements_no(card, new_skb, 0)))) {
-		if (skb_linearize(new_skb))
+		int lin_rc = skb_linearize(new_skb);
+
+		if (card->options.performance_stats) {
+			if (lin_rc)
+				card->perf_stats.tx_linfail++;
+			else
+				card->perf_stats.tx_lin++;
+		}
+		if (lin_rc)
 			goto tx_drop;
-		if (card->options.performance_stats)
-			card->perf_stats.tx_lin++;
 	}
 
 	if (use_tso) {
-- 
2.6.6
