From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 05/10] s390/qeth: use correct return type for hard_start_xmit()
Date: Tue, 11 Apr 2017 16:11:14 +0200
Message-ID: <20170411141119.82526-6-jwi@linux.vnet.ibm.com>
References: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

ndo_start_xmit() expects us to return netdev_tx_t here...

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 3 ++-
 drivers/s390/net/qeth_l3_main.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ab0d065a9ba2..11cf4a4b36a6 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -681,7 +681,8 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 		qeth_promisc_to_bridge(card);
 }
 
-static int qeth_l2_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
+					   struct net_device *dev)
 {
 	int rc;
 	struct qeth_hdr *hdr = NULL;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 7d902b93fd5a..bea0bae0faf7 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2655,7 +2655,8 @@ static int qeth_l3_get_elements_no_tso(struct qeth_card *card,
 	return elements;
 }
 
-static int qeth_l3_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
+					   struct net_device *dev)
 {
 	int rc;
 	__be16 *tag;
-- 
2.10.2
