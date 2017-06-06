From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/9] s390/qeth: log bridgeport capabilities
Date: Tue,  6 Jun 2017 14:33:45 +0200
Message-ID: <20170606123350.13781-5-jwi@linux.vnet.ibm.com>
References: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Bridgeport is a l2-specific feature, and we should write its
capabilities to a debug entry.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index bd2df62a5cdf..70b633f951ea 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1017,6 +1017,13 @@ static int qeth_l2_start_ipassists(struct qeth_card *card)
 	return 0;
 }
 
+static void qeth_l2_trace_features(struct qeth_card *card)
+{
+	QETH_CARD_TEXT(card, 2, "l2featur");
+	QETH_CARD_HEX(card, 2, &card->options.sbp.supported_funcs,
+		      sizeof(card->options.sbp.supported_funcs));
+}
+
 static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
@@ -1040,6 +1047,7 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		dev_info(&card->gdev->dev,
 		"The device represents a Bridge Capable Port\n");
 	qeth_trace_features(card);
+	qeth_l2_trace_features(card);
 
 	if (!card->dev && qeth_l2_setup_netdev(card)) {
 		rc = -ENODEV;
-- 
2.11.2
