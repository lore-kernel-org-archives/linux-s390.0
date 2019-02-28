Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/9] s390/qeth: don't defer close_dev work during recovery
Date: Thu, 28 Feb 2019 18:59:41 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The recovery code already runs in a kthread, we don't have to defer the
offlining further.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 3 +--
 drivers/s390/net/qeth_l2_main.c   | 2 +-
 drivers/s390/net/qeth_l3_main.c   | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 79de890010c7..8c354cdc86c0 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1002,7 +1002,6 @@ int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback);
 int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
 void qeth_trace_features(struct qeth_card *);
-void qeth_close_dev(struct qeth_card *);
 int qeth_setassparms_cb(struct qeth_card *, struct qeth_reply *, unsigned long);
 struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *,
 						 enum qeth_ipa_funcs,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a1a66467b06b..6c2540e3247b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -92,12 +92,11 @@ static void qeth_close_dev_handler(struct work_struct *work)
 	ccwgroup_set_offline(card->gdev);
 }
 
-void qeth_close_dev(struct qeth_card *card)
+static void qeth_close_dev(struct qeth_card *card)
 {
 	QETH_CARD_TEXT(card, 2, "cldevsubm");
 	queue_work(qeth_wq, &card->close_dev_work);
 }
-EXPORT_SYMBOL_GPL(qeth_close_dev);
 
 static const char *qeth_get_cardname(struct qeth_card *card)
 {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index a42285b1daa3..f34fe983012c 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -960,7 +960,7 @@ static int qeth_l2_recover(void *ptr)
 		dev_info(&card->gdev->dev,
 			"Device successfully recovered!\n");
 	else {
-		qeth_close_dev(card);
+		ccwgroup_set_offline(card->gdev);
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 				"failed to recover an error on the device\n");
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 13d77957404c..d424a6704811 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2459,7 +2459,7 @@ static int qeth_l3_recover(void *ptr)
 		dev_info(&card->gdev->dev,
 			"Device successfully recovered!\n");
 	else {
-		qeth_close_dev(card);
+		ccwgroup_set_offline(card->gdev);
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 				"failed to recover an error on the device\n");
 	}
-- 
2.16.4
