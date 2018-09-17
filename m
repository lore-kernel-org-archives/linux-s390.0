From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/15] s390/qeth: fix up protocol headers early
Date: Mon, 17 Sep 2018 17:36:00 +0200
Message-ID: <20180917153609.94628-7-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When qeth_add_hw_header() falls back to the HW header cache, it also
copies over the necessary protocol headers. Thus any manipulation to
the protocol headers needs to happen before adding the HW header.

For current usage this doesn't matter, but it becomes relevant when
moving TSO transmission over to the faster code path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d4a967077279..0c085f57f7e2 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2056,10 +2056,8 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	if (!skb_is_gso(skb) && skb->ip_summed == CHECKSUM_PARTIAL) {
 		qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
 		/* some HW requires combined L3+L4 csum offload: */
-		if (ipv == 4) {
+		if (ipv == 4)
 			hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
-			ip_hdr(skb)->check = 0;
-		}
 		if (card->options.performance_stats)
 			card->perf_stats.tx_csum++;
 	}
@@ -2168,6 +2166,15 @@ static int qeth_l3_get_elements_no_tso(struct qeth_card *card,
 	return elements;
 }
 
+static void qeth_l3_fixup_headers(struct sk_buff *skb)
+{
+	struct iphdr *iph = ip_hdr(skb);
+
+	/* this is safe, IPv6 traffic takes a different path */
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		iph->check = 0;
+}
+
 static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 				struct qeth_qdio_out_q *queue, int ipv,
 				int cast_type)
@@ -2188,6 +2195,7 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	skb_pull(skb, ETH_HLEN);
 	frame_len = skb->len;
 
+	qeth_l3_fixup_headers(skb);
 	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, 0,
 				      &elements);
 	if (push_len < 0)
-- 
2.16.4
