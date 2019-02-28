Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/9] s390/qeth: unconditionally clear MAC_REGISTERED flag
Date: Thu, 28 Feb 2019 18:59:38 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

In its attempt to run only the minimal amount of tear down steps,
qeth_l2_stop_card() fails to reset the "is dev_addr registered?" flag
in some rare scenarios. But a future change to the tear down sequence
would cause us to _always_ hit this issue, so patch it up before that
code lands.

Fix it by unconditionally clearing the flag bit. This also allows us to
remove the additional cleanup step in qeth_dev_layer2_store().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_sys.c | 1 -
 drivers/s390/net/qeth_l2_main.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index e24d204b780a..fa575549d288 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -416,7 +416,6 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 		goto out;
 	}
 
-	card->info.mac_bits = 0;
 	if (card->discipline) {
 		/* start with a new, pristine netdevice: */
 		ndev = qeth_clone_netdev(card->dev);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 72e6d08444a7..f71d45ea30da 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -301,7 +301,6 @@ static void qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
 			dev_close(card->dev);
 			rtnl_unlock();
 		}
-		card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 		card->state = CARD_STATE_SOFTSETUP;
 	}
 	if (card->state == CARD_STATE_SOFTSETUP) {
@@ -321,6 +320,7 @@ static void qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
 	}
 
 	flush_workqueue(card->event_wq);
+	card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 }
 
 static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
-- 
2.16.4
