From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 8/8] qeth: get rid of redundant 0-termination
Date: Fri, 11 Dec 2015 12:27:57 +0100
Message-ID: <1449833277-69012-9-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1449833277-69012-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1449833277-69012-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: ubraunu@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

0-termination is redundant, since sprintf has done that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index fe1845a..7871537 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2684,8 +2684,6 @@ void qeth_print_status_message(struct qeth_card *card)
 			sprintf(card->info.mcl_level, "%02x%02x",
 				card->info.mcl_level[2],
 				card->info.mcl_level[3]);
-
-			card->info.mcl_level[QETH_MCL_LENGTH] = 0;
 			break;
 		}
 		/* fallthrough */
-- 
2.3.9
