Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/3] s390/qeth: fix L2 header access in qeth_l3_osa_features_check()
Date: Thu,  7 Jan 2021 18:24:42 +0100
Message-Id: <20210107172442.1737-4-jwi@linux.ibm.com>
In-Reply-To: <20210107172442.1737-1-jwi@linux.ibm.com>
References: <20210107172442.1737-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

ip_finish_output_gso() may call .ndo_features_check() even before the
skb has a L2 header. This conflicts with qeth_get_ip_version()'s attempt
to inspect the L2 header via vlan_eth_hdr().

Switch to vlan_get_protocol(), as already used further down in the
common qeth_features_check() path.

Fixes: f13ade199391 ("s390/qeth: run non-offload L3 traffic over common xmit path")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 6970597bc885..4c2cae7ae9a7 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1813,7 +1813,7 @@ static netdev_features_t qeth_l3_osa_features_check(struct sk_buff *skb,
 						    struct net_device *dev,
 						    netdev_features_t features)
 {
-	if (qeth_get_ip_version(skb) != 4)
+	if (vlan_get_protocol(skb) != htons(ETH_P_IP))
 		features &= ~NETIF_F_HW_VLAN_CTAG_TX;
 	return qeth_features_check(skb, dev, features);
 }
-- 
2.17.1
