From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/4] s390/qeth: switch on SG by default for IQD devices
Date: Wed, 12 Sep 2018 15:31:33 +0200
Message-ID: <20180912133135.12335-3-jwi@linux.ibm.com>
References: <20180912133135.12335-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180912133135.12335-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Scatter-gather transmit brings a nice performance boost. Considering the
rather large MTU sizes at play, it's also totally the Right Thing To Do.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6b24face21d5..b60055e9cb1a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5706,6 +5706,8 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 		dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 		dev->hw_features |= NETIF_F_SG;
 		dev->vlan_features |= NETIF_F_SG;
+		if (IS_IQD(card))
+			dev->features |= NETIF_F_SG;
 	}
 
 	return dev;
-- 
2.16.4
