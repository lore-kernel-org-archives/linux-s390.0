From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 12/15] s390/qeth: consume local address events
Date: Wed, 26 Sep 2018 18:29:13 +0200
Message-ID: <20180926162916.102720-13-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We have no code that is waiting for these events, so just drop them when
they arrive.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5a2b90677235..880c15647442 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -688,10 +688,10 @@ static struct qeth_ipa_cmd *qeth_check_ipa_data(struct qeth_card *card,
 				return cmd;
 			case IPA_CMD_REGISTER_LOCAL_ADDR:
 				QETH_CARD_TEXT(card, 3, "irla");
-				break;
+				return NULL;
 			case IPA_CMD_UNREGISTER_LOCAL_ADDR:
 				QETH_CARD_TEXT(card, 3, "urla");
-				break;
+				return NULL;
 			default:
 				QETH_DBF_MESSAGE(2, "Received data is IPA "
 					   "but not a reply!\n");
-- 
2.16.4
