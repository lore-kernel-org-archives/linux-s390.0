Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 1/4] s390/qeth: free netdevice when removing a card
Date: Tue, 20 Mar 2018 07:59:12 +0100
In-Reply-To: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
References: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180320065915.62076-2-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On removal, a qeth card's netdevice is currently not properly freed
because the call chain looks as follows:

qeth_core_remove_device(card)
	lx_remove_device(card)
		unregister_netdev(card->dev)
		card->dev = NULL			!!!
	qeth_core_free_card(card)
		if (card->dev)				!!!
			free_netdev(card->dev)

Fix it by free'ing the netdev straight after unregistering. This also
fixes the sysfs-driven layer switch case (qeth_dev_layer2_store()),
where the need to free the current netdevice was not considered at all.

Note that free_netdev() takes care of the netif_napi_del() for us too.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 --
 drivers/s390/net/qeth_l2_main.c   | 2 +-
 drivers/s390/net/qeth_l3_main.c   | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c8b308cfabf1..4a820afececd 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5087,8 +5087,6 @@ static void qeth_core_free_card(struct qeth_card *card)
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
-	if (card->dev)
-		free_netdev(card->dev);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
 	kfree(card);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7f236440483f..5ef4c978ad19 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -915,8 +915,8 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 		qeth_l2_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 	return;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 962a04b68dd2..b6b12220da71 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2865,8 +2865,8 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 		qeth_l3_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 
-- 
2.13.5
