Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/8] s390/qeth: don't keep statistics for tx timeout
Date: Wed, 17 Apr 2019 18:17:31 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

struct netdev_queue contains a counter for tx timeouts, which gets
updated by dev_watchdog(). So let's not attempt to maintain our own
statistics, in particular not by overloading the skb-error counter.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 41e3bc4887fe..730930135aba 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -464,7 +464,6 @@ struct qeth_card_stats {
 	u64 rx_errors;
 	u64 rx_dropped;
 	u64 rx_multicast;
-	u64 tx_errors;
 };
 
 struct qeth_out_q_stats {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9e495df742cb..09ed9e04f4ca 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4340,7 +4340,6 @@ void qeth_tx_timeout(struct net_device *dev)
 
 	card = dev->ml_priv;
 	QETH_CARD_TEXT(card, 4, "txtimeo");
-	QETH_CARD_STAT_INC(card, tx_errors);
 	qeth_schedule_recovery(card);
 }
 EXPORT_SYMBOL_GPL(qeth_tx_timeout);
@@ -6192,7 +6191,6 @@ void qeth_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	stats->rx_errors = card->stats.rx_errors;
 	stats->rx_dropped = card->stats.rx_dropped;
 	stats->multicast = card->stats.rx_multicast;
-	stats->tx_errors = card->stats.tx_errors;
 
 	for (i = 0; i < card->qdio.no_out_queues; i++) {
 		queue = card->qdio.out_qs[i];
-- 
2.16.4
