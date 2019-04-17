Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/8] s390/qeth: handle error from qeth_update_from_chp_desc()
Date: Wed, 17 Apr 2019 18:17:29 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Subsequent code relies on the values that qeth_update_from_chp_desc()
reads from the CHP descriptor. Rather than dealing with weird errors
later on, just handle it properly here.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ca71632a4fa0..ac592d610c5e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1298,7 +1298,7 @@ static void qeth_set_multiple_write_queues(struct qeth_card *card)
 	card->qdio.no_out_queues = 4;
 }
 
-static void qeth_update_from_chp_desc(struct qeth_card *card)
+static int qeth_update_from_chp_desc(struct qeth_card *card)
 {
 	struct ccw_device *ccwdev;
 	struct channel_path_desc_fmt0 *chp_dsc;
@@ -1308,7 +1308,7 @@ static void qeth_update_from_chp_desc(struct qeth_card *card)
 	ccwdev = card->data.ccwdev;
 	chp_dsc = ccw_device_get_chp_desc(ccwdev, 0);
 	if (!chp_dsc)
-		goto out;
+		return -ENOMEM;
 
 	card->info.func_level = 0x4100 + chp_dsc->desc;
 	if (card->info.type == QETH_CARD_TYPE_IQD)
@@ -1323,6 +1323,7 @@ static void qeth_update_from_chp_desc(struct qeth_card *card)
 	kfree(chp_dsc);
 	QETH_DBF_TEXT_(SETUP, 2, "nr:%x", card->qdio.no_out_queues);
 	QETH_DBF_TEXT_(SETUP, 2, "lvl:%02x", card->info.func_level);
+	return 0;
 }
 
 static void qeth_init_qdio_info(struct qeth_card *card)
@@ -4978,7 +4979,9 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 
 	QETH_DBF_TEXT(SETUP, 2, "hrdsetup");
 	atomic_set(&card->force_alloc_skb, 0);
-	qeth_update_from_chp_desc(card);
+	rc = qeth_update_from_chp_desc(card);
+	if (rc)
+		return rc;
 retry:
 	if (retries < 3)
 		QETH_DBF_MESSAGE(2, "Retrying to do IDX activates on device %x.\n",
@@ -5635,7 +5638,9 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	}
 
 	qeth_setup_card(card);
-	qeth_update_from_chp_desc(card);
+	rc = qeth_update_from_chp_desc(card);
+	if (rc)
+		goto err_chp_desc;
 
 	card->dev = qeth_alloc_netdev(card);
 	if (!card->dev) {
@@ -5670,6 +5675,7 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	qeth_core_free_discipline(card);
 err_load:
 	free_netdev(card->dev);
+err_chp_desc:
 err_card:
 	qeth_core_free_card(card);
 err_dev:
-- 
2.16.4
