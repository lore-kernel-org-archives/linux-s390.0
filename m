From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/15] s390/qeth: limit csum offload erratum to L3 devices
Date: Mon, 17 Sep 2018 17:35:59 +0200
Message-ID: <20180917153609.94628-6-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Combined L3+L4 csum offload is only required for some L3 HW. So for
L2 devices, don't offload the IP header csum calculation.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reference-ID: JUP 394553
---
 drivers/s390/net/qeth_core.h    | 5 -----
 drivers/s390/net/qeth_l3_main.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 0857b1286660..b47fb95a49e9 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -892,11 +892,6 @@ static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags, int ipv)
 	if ((ipv == 4 && ip_hdr(skb)->protocol == IPPROTO_UDP) ||
 	    (ipv == 6 && ipv6_hdr(skb)->nexthdr == IPPROTO_UDP))
 		*flags |= QETH_HDR_EXT_UDP;
-	if (ipv == 4) {
-		/* some HW requires combined L3+L4 csum offload: */
-		*flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
-		ip_hdr(skb)->check = 0;
-	}
 }
 
 static inline void qeth_put_buffer_pool_entry(struct qeth_card *card,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 1d92584e01b3..d4a967077279 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2055,6 +2055,11 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 
 	if (!skb_is_gso(skb) && skb->ip_summed == CHECKSUM_PARTIAL) {
 		qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
+		/* some HW requires combined L3+L4 csum offload: */
+		if (ipv == 4) {
+			hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
+			ip_hdr(skb)->check = 0;
+		}
 		if (card->options.performance_stats)
 			card->perf_stats.tx_csum++;
 	}
-- 
2.16.4
