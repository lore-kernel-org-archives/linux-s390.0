From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 09/15] s390/qeth: robustify qeth_get_ip_version()
Date: Wed, 20 Dec 2017 20:11:03 +0100
Message-ID: <20171220191109.90487-10-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Instead of assuming that skb->data points to the Ethernet header, use
the right helper and struct to access the Ethertype field.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f5ee62c98011..af9d1efd2e78 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -847,14 +847,16 @@ static inline int qeth_get_micros(void)
 
 static inline int qeth_get_ip_version(struct sk_buff *skb)
 {
-	__be16 *p = &((struct ethhdr *)skb->data)->h_proto;
+	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
+	__be16 prot = veth->h_vlan_proto;
 
-	if (be16_to_cpu(*p) == ETH_P_8021Q)
-		p += 2;
-	switch (be16_to_cpu(*p)) {
-	case ETH_P_IPV6:
+	if (prot == htons(ETH_P_8021Q))
+		prot = veth->h_vlan_encapsulated_proto;
+
+	switch (prot) {
+	case htons(ETH_P_IPV6):
 		return 6;
-	case ETH_P_IP:
+	case htons(ETH_P_IP):
 		return 4;
 	default:
 		return 0;
-- 
2.13.5
