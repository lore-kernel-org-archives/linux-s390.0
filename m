From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 5/7] qeth: do not limit number of gso segments
Date: Thu, 15 Sep 2016 14:39:25 +0200
Message-ID: <20160915123927.86579-6-ubraun@linux.vnet.ibm.com>
References: <20160915123927.86579-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20160915123927.86579-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

To reduce the need of skb_linearize() calls, gso_max_segs of qeth
net_devices had been limited according to the maximum number of qdio SBAL
elements. But a gso segment cannot be larger than the mtu-size, while an
SBAL element can contain up to 4096 bytes. The gso_max_segs limitation
limits the maximum packet size given to the qeth driver. Performance
measurements with tso-enabled qeth network interfaces and mtu-size 1500
showed, that the disadvantage of smaller packets is much more severe than
the advantage of fewer skb_linearize() calls.
This patch gets rid of the gso_max_segs limitations in the qeth driver.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 1 -
 drivers/s390/net/qeth_l3_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 54fd891..2081c18 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1131,7 +1131,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	qeth_l2_request_initial_mac(card);
 	card->dev->gso_max_size = (QETH_MAX_BUFFER_ELEMENTS(card) - 1) *
 				  PAGE_SIZE;
-	card->dev->gso_max_segs = (QETH_MAX_BUFFER_ELEMENTS(card) - 1);
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_l2_poll, QETH_NAPI_WEIGHT);
 	netif_carrier_off(card->dev);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 4ba82e1..0cbbc80 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3148,7 +3148,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 	netif_keep_dst(card->dev);
 	card->dev->gso_max_size = (QETH_MAX_BUFFER_ELEMENTS(card) - 1) *
 				  PAGE_SIZE;
-	card->dev->gso_max_segs = (QETH_MAX_BUFFER_ELEMENTS(card) - 1);
 
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_l3_poll, QETH_NAPI_WEIGHT);
-- 
2.8.4
