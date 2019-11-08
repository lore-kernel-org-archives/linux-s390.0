Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload erratum to L3 devices
Date: Fri,  8 Nov 2019 06:37:51 -0500
Message-Id: <20191108113752.12502-204-sashal@kernel.org>
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]

Combined L3+L4 csum offload is only required for some L3 HW. So for
L2 devices, don't offload the IP header csum calculation.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reference-ID: JUP 394553
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h    | 5 -----
 drivers/s390/net/qeth_l3_main.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index b2657582cfcfd..41a2f901ccee5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -902,11 +902,6 @@ static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags, int ipv)
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
index 9c5e801b3f6cb..c60660cb5a031 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2054,6 +2054,11 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 
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
2.20.1
