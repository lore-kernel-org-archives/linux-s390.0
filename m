From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 14/15] s390/qeth: clean up drop conditions for received cmds
Date: Wed, 26 Sep 2018 18:29:15 +0200
Message-ID: <20180926162916.102720-15-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If qeth_check_ipa_data() consumed an event, there's no point in
processing it further. So drop it early, and make the surrounding code
a tiny bit more readable.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 954dc6c688e8..9cbdc6760aba 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -826,16 +826,17 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 	if (IS_IPA(iob->data)) {
 		cmd = (struct qeth_ipa_cmd *) PDU_ENCAPSULATION(iob->data);
 		cmd = qeth_check_ipa_data(card, cmd);
-	}
-	if ((cmd == NULL) && (card->state != CARD_STATE_DOWN))
-		goto out;
-	/*in case of OSN : check if cmd is set */
-	if (card->info.type == QETH_CARD_TYPE_OSN &&
-	    cmd &&
-	    cmd->hdr.command != IPA_CMD_STARTLAN &&
-	    card->osn_info.assist_cb != NULL) {
-		card->osn_info.assist_cb(card->dev, cmd);
-		goto out;
+		if (!cmd)
+			goto out;
+		if (IS_OSN(card) && card->osn_info.assist_cb &&
+		    cmd->hdr.command != IPA_CMD_STARTLAN) {
+			card->osn_info.assist_cb(card->dev, cmd);
+			goto out;
+		}
+	} else {
+		/* non-IPA commands should only flow during initialization */
+		if (card->state != CARD_STATE_DOWN)
+			goto out;
 	}
 
 	spin_lock_irqsave(&card->lock, flags);
-- 
2.16.4
