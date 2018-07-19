From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/11] s390/qeth: remove redundant netif_carrier_ok() checks
Date: Thu, 19 Jul 2018 12:43:50 +0200
Message-ID: <20180719104358.79696-4-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

netif_carrier_off() does its own checking.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 drivers/s390/net/qeth_l2_main.c   | 2 +-
 drivers/s390/net/qeth_l3_main.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f7ddd6455638..7c3b643550f6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -653,7 +653,7 @@ static struct qeth_ipa_cmd *qeth_check_ipa_data(struct qeth_card *card,
 						cmd->hdr.return_code, card);
 				}
 				card->lan_online = 0;
-				if (card->dev && netif_carrier_ok(card->dev))
+				if (card->dev)
 					netif_carrier_off(card->dev);
 				return NULL;
 			case IPA_CMD_STARTLAN:
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8ac243de7a9e..089bde458fd5 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1163,7 +1163,7 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
-	if (card->dev && netif_carrier_ok(card->dev))
+	if (card->dev)
 		netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 062f62b49294..ee99af08b2c4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2773,7 +2773,7 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
-	if (card->dev && netif_carrier_ok(card->dev))
+	if (card->dev)
 		netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
-- 
2.16.4
