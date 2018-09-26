From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 11/15] s390/qeth: remove various redundant code
Date: Wed, 26 Sep 2018 18:29:12 +0200
Message-ID: <20180926162916.102720-12-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

1. tracing iob->rc makes no sense when it hasn't been modified by the
   callback,
2. the qeth_dbf_list is declared with LIST_HEAD, which also initializes
   the list,
3. the ccwgroup core only calls the thaw/restore callbacks if the gdev
   is online, so we don't have to check for it again.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 7 -------
 drivers/s390/net/qeth_l2_main.c   | 5 +----
 drivers/s390/net/qeth_l3_main.c   | 5 +----
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index caa5d109841c..5a2b90677235 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2167,7 +2167,6 @@ static int qeth_cm_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 	memcpy(&card->token.cm_filter_r,
 	       QETH_CM_ENABLE_RESP_FILTER_TOKEN(iob->data),
 	       QETH_MPC_TOKEN_LENGTH);
-	QETH_DBF_TEXT_(SETUP, 2, "  rc%d", iob->rc);
 	return 0;
 }
 
@@ -2193,7 +2192,6 @@ static int qeth_cm_enable(struct qeth_card *card)
 static int qeth_cm_setup_cb(struct qeth_card *card, struct qeth_reply *reply,
 		unsigned long data)
 {
-
 	struct qeth_cmd_buffer *iob;
 
 	QETH_DBF_TEXT(SETUP, 2, "cmsetpcb");
@@ -2202,7 +2200,6 @@ static int qeth_cm_setup_cb(struct qeth_card *card, struct qeth_reply *reply,
 	memcpy(&card->token.cm_connection_r,
 	       QETH_CM_SETUP_RESP_DEST_ADDR(iob->data),
 	       QETH_MPC_TOKEN_LENGTH);
-	QETH_DBF_TEXT_(SETUP, 2, "  rc%d", iob->rc);
 	return 0;
 }
 
@@ -2224,7 +2221,6 @@ static int qeth_cm_setup(struct qeth_card *card)
 	rc = qeth_send_control_data(card, CM_SETUP_SIZE, iob,
 				    qeth_cm_setup_cb, NULL);
 	return rc;
-
 }
 
 static int qeth_update_max_mtu(struct qeth_card *card, unsigned int max_mtu)
@@ -2284,7 +2280,6 @@ static int qeth_get_mtu_outof_framesize(int framesize)
 static int qeth_ulp_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 		unsigned long data)
 {
-
 	__u16 mtu, framesize;
 	__u16 len;
 	__u8 link_type;
@@ -2312,7 +2307,6 @@ static int qeth_ulp_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 	} else
 		card->info.link_type = 0;
 	QETH_DBF_TEXT_(SETUP, 2, "link%d", card->info.link_type);
-	QETH_DBF_TEXT_(SETUP, 2, "  rc%d", iob->rc);
 	return 0;
 }
 
@@ -6584,7 +6578,6 @@ static int __init qeth_core_init(void)
 
 	pr_info("loading core functions\n");
 	INIT_LIST_HEAD(&qeth_core_card_list.list);
-	INIT_LIST_HEAD(&qeth_dbf_list);
 	rwlock_init(&qeth_core_card_list.rwlock);
 
 	qeth_wq = create_singlethread_workqueue("qeth_wq");
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 02566af7e23d..ed475b4ddd3e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1146,9 +1146,6 @@ static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc = 0;
 
-	if (gdev->state == CCWGROUP_OFFLINE)
-		goto out;
-
 	if (card->state == CARD_STATE_RECOVER) {
 		rc = __qeth_l2_set_online(card->gdev, 1);
 		if (rc) {
@@ -1158,7 +1155,7 @@ static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
 		}
 	} else
 		rc = __qeth_l2_set_online(card->gdev, 0);
-out:
+
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	netif_device_attach(card->dev);
 	if (rc)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 7148ef71ac78..86c89338b1a2 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2714,9 +2714,6 @@ static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc = 0;
 
-	if (gdev->state == CCWGROUP_OFFLINE)
-		goto out;
-
 	if (card->state == CARD_STATE_RECOVER) {
 		rc = __qeth_l3_set_online(card->gdev, 1);
 		if (rc) {
@@ -2726,7 +2723,7 @@ static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
 		}
 	} else
 		rc = __qeth_l3_set_online(card->gdev, 0);
-out:
+
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	netif_device_attach(card->dev);
 	if (rc)
-- 
2.16.4
