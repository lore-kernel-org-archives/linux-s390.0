From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH 6/7] qeth: repair SBAL elements calculation
Date: Fri, 11 Dec 2015 11:38:56 +0100
Message-ID: <1449830337-26091-7-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1449830337-26091-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1449830337-26091-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: ubraunu@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

When sending skbs, qeth determines the number of qdio SBAL elements
required. If qeth sends a fragmented skb, the SBAL element number
calculation is wrong, because the fragmented data part is added
twice in qeth_l3_tso_elements(). This patch makes sure fragmented
data is handled in qeth_elements_for_frags() only, while
qeth_l3_tso_elements() starts calculation of qdio SBAL elements just
with the linear data part of the skb.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 9541167..b9d8ea4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2818,7 +2818,7 @@ static inline int qeth_l3_tso_elements(struct sk_buff *skb)
 {
 	unsigned long tcpd = (unsigned long)tcp_hdr(skb) +
 		tcp_hdr(skb)->doff * 4;
-	int tcpd_len = skb->len - (tcpd - (unsigned long)skb->data);
+	int tcpd_len = skb_headlen(skb) - (tcpd - (unsigned long)skb->data);
 	int elements = PFN_UP(tcpd + tcpd_len - 1) - PFN_DOWN(tcpd);
 
 	elements += qeth_get_elements_for_frags(skb);
-- 
2.3.9
