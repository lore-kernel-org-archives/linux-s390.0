From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 01/12] s390/qeth: don't access skb after transmission
Date: Tue, 15 Aug 2017 17:02:39 +0200
Message-ID: <20170815150250.67158-2-jwi@linux.vnet.ibm.com>
References: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

After transmitting a skb via send_packet[_fast](), the statistics
code accesses the skb once more to account for transmitted page frags.
This has a (theoretical?) race against the TX completion - if the TX
completion is processed and frees the skb before hard_start_xmit()
gets to the statistics part, we access random memory.

Fix this by caching the # of page frags, before the skb is transmitted.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 14 ++++++--------
 drivers/s390/net/qeth_l3_main.c |  4 ++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ad110abfdd47..28c9a7eda507 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -707,7 +707,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	int data_offset = -1;
 	int elements_needed = 0;
 	int hd_len = 0;
-	int nr_frags;
+	unsigned int nr_frags;
 
 	if (card->qdio.do_prio_queueing || (cast_type &&
 					card->info.is_multicast_different))
@@ -747,6 +747,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 		if (lin_rc)
 			goto tx_drop;
 	}
+	nr_frags = skb_shinfo(new_skb)->nr_frags;
 
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		hdr = (struct qeth_hdr *)skb->data;
@@ -799,13 +800,10 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	if (!rc) {
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += tx_bytes;
-		if (card->options.performance_stats) {
-			nr_frags = skb_shinfo(new_skb)->nr_frags;
-			if (nr_frags) {
-				card->perf_stats.sg_skbs_sent++;
-				/* nr_frags + skb->data */
-				card->perf_stats.sg_frags_sent += nr_frags + 1;
-			}
+		if (card->options.performance_stats && nr_frags) {
+			card->perf_stats.sg_skbs_sent++;
+			/* nr_frags + skb->data */
+			card->perf_stats.sg_frags_sent += nr_frags + 1;
 		}
 		if (new_skb != skb)
 			dev_kfree_skb_any(skb);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d42e758518ed..6648f02d61ea 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2650,7 +2650,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	int tx_bytes = skb->len;
 	bool use_tso;
 	int data_offset = -1;
-	int nr_frags;
+	unsigned int nr_frags;
 
 	if (((card->info.type == QETH_CARD_TYPE_IQD) &&
 	     (((card->options.cq != QETH_CQ_ENABLED) && !ipv) ||
@@ -2727,6 +2727,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		if (lin_rc)
 			goto tx_drop;
 	}
+	nr_frags = skb_shinfo(new_skb)->nr_frags;
 
 	if (use_tso) {
 		hdr = skb_push(new_skb, sizeof(struct qeth_hdr_tso));
@@ -2786,7 +2787,6 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		if (new_skb != skb)
 			dev_kfree_skb_any(skb);
 		if (card->options.performance_stats) {
-			nr_frags = skb_shinfo(new_skb)->nr_frags;
 			if (use_tso) {
 				card->perf_stats.large_send_bytes += tx_bytes;
 				card->perf_stats.large_send_cnt++;
-- 
2.11.2
