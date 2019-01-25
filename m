Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/8] s390/qeth: remove TX disable from online path
Date: Fri, 25 Jan 2019 15:44:20 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-6-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

At best this is redundant, at worst it papers over a race in the
offline / online code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 --
 drivers/s390/net/qeth_l3_main.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 3aa11f32dcd5..0d04e5a89341 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -944,8 +944,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	if (card->info.type != QETH_CARD_TYPE_OSN)
 		qeth_l2_process_vlans(card);
 
-	netif_tx_disable(card->dev);
-
 	rc = qeth_init_qdio_queues(card);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "6err%d", rc);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b8a2493a6607..2065030e1a62 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2346,7 +2346,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		if (rc)
 			QETH_DBF_TEXT_(SETUP, 2, "5err%04x", rc);
 	}
-	netif_tx_disable(card->dev);
 
 	rc = qeth_init_qdio_queues(card);
 	if (rc) {
-- 
2.16.4
