Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 4/4] s390/qeth: handle error when updating TX queue count
Date: Mon,  3 Jun 2019 17:04:46 +0200
In-Reply-To: <20190603150446.23351-1-jwi@linux.ibm.com>
References: <20190603150446.23351-1-jwi@linux.ibm.com>
Message-Id: <20190603150446.23351-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

netif_set_real_num_tx_queues() can return an error, deal with it.

Fixes: 73dc2daf110f ("s390/qeth: add TX multiqueue support for OSA devices")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 009f2c0ec504..b1823d75dd35 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1274,16 +1274,20 @@ static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 	return 0;
 }
 
-static void qeth_osa_set_output_queues(struct qeth_card *card, bool single)
+static int qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 {
 	unsigned int count = single ? 1 : card->dev->num_tx_queues;
+	int rc;
 
 	rtnl_lock();
-	netif_set_real_num_tx_queues(card->dev, count);
+	rc = netif_set_real_num_tx_queues(card->dev, count);
 	rtnl_unlock();
 
+	if (rc)
+		return rc;
+
 	if (card->qdio.no_out_queues == count)
-		return;
+		return 0;
 
 	if (atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED)
 		qeth_free_qdio_queues(card);
@@ -1293,12 +1297,14 @@ static void qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 
 	card->qdio.default_out_queue = single ? 0 : QETH_DEFAULT_QUEUE;
 	card->qdio.no_out_queues = count;
+	return 0;
 }
 
 static int qeth_update_from_chp_desc(struct qeth_card *card)
 {
 	struct ccw_device *ccwdev;
 	struct channel_path_desc_fmt0 *chp_dsc;
+	int rc = 0;
 
 	QETH_DBF_TEXT(SETUP, 2, "chp_desc");
 
@@ -1311,12 +1317,12 @@ static int qeth_update_from_chp_desc(struct qeth_card *card)
 
 	if (IS_OSD(card) || IS_OSX(card))
 		/* CHPP field bit 6 == 1 -> single queue */
-		qeth_osa_set_output_queues(card, chp_dsc->chpp & 0x02);
+		rc = qeth_osa_set_output_queues(card, chp_dsc->chpp & 0x02);
 
 	kfree(chp_dsc);
 	QETH_DBF_TEXT_(SETUP, 2, "nr:%x", card->qdio.no_out_queues);
 	QETH_DBF_TEXT_(SETUP, 2, "lvl:%02x", card->info.func_level);
-	return 0;
+	return rc;
 }
 
 static void qeth_init_qdio_info(struct qeth_card *card)
@@ -5597,8 +5603,12 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 		dev->hw_features |= NETIF_F_SG;
 		dev->vlan_features |= NETIF_F_SG;
 		if (IS_IQD(card)) {
-			netif_set_real_num_tx_queues(dev, QETH_IQD_MIN_TXQ);
 			dev->features |= NETIF_F_SG;
+			if (netif_set_real_num_tx_queues(dev,
+							 QETH_IQD_MIN_TXQ)) {
+				free_netdev(dev);
+				return NULL;
+			}
 		}
 	}
 
-- 
2.17.1
