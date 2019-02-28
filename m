Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/9] s390/qeth: remove driver-wide workqueue
Date: Thu, 28 Feb 2019 18:59:42 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The qeth-wide workqueue is now only used by a single caller to schedule
close_dev work. Just put it on a system queue instead.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6c2540e3247b..4dcb4f91b9c0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -74,8 +74,6 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *queue,
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf);
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *, int);
 
-static struct workqueue_struct *qeth_wq;
-
 int qeth_card_hw_is_reachable(struct qeth_card *card)
 {
 	return (card->state == CARD_STATE_SOFTSETUP) ||
@@ -92,12 +90,6 @@ static void qeth_close_dev_handler(struct work_struct *work)
 	ccwgroup_set_offline(card->gdev);
 }
 
-static void qeth_close_dev(struct qeth_card *card)
-{
-	QETH_CARD_TEXT(card, 2, "cldevsubm");
-	queue_work(qeth_wq, &card->close_dev_work);
-}
-
 static const char *qeth_get_cardname(struct qeth_card *card)
 {
 	if (card->info.guestlan) {
@@ -634,7 +626,7 @@ static struct qeth_ipa_cmd *qeth_check_ipa_data(struct qeth_card *card,
 			dev_err(&card->gdev->dev,
 				"Interface %s is down because the adjacent port is no longer in reflective relay mode\n",
 				QETH_CARD_IFNAME(card));
-			qeth_close_dev(card);
+			schedule_work(&card->close_dev_work);
 		} else {
 			dev_warn(&card->gdev->dev,
 				 "The link for interface %s on CHPID 0x%X failed\n",
@@ -6265,12 +6257,6 @@ static int __init qeth_core_init(void)
 
 	pr_info("loading core functions\n");
 
-	qeth_wq = create_singlethread_workqueue("qeth_wq");
-	if (!qeth_wq) {
-		rc = -ENOMEM;
-		goto out_err;
-	}
-
 	rc = qeth_register_dbf_views();
 	if (rc)
 		goto dbf_err;
@@ -6312,8 +6298,6 @@ static int __init qeth_core_init(void)
 register_err:
 	qeth_unregister_dbf_views();
 dbf_err:
-	destroy_workqueue(qeth_wq);
-out_err:
 	pr_err("Initializing the qeth device driver failed\n");
 	return rc;
 }
@@ -6321,7 +6305,6 @@ static int __init qeth_core_init(void)
 static void __exit qeth_core_exit(void)
 {
 	qeth_clear_dbf_list();
-	destroy_workqueue(qeth_wq);
 	ccwgroup_driver_unregister(&qeth_core_ccwgroup_driver);
 	ccw_driver_unregister(&qeth_ccw_driver);
 	kmem_cache_destroy(qeth_qdio_outbuf_cache);
-- 
2.16.4
