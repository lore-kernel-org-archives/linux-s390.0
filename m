Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgAYPxP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 25 Jan 2020 10:53:15 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00PFbkOb095859
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:14 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrgvj8waq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:14 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sat, 25 Jan 2020 15:53:12 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/5] s390/qeth: consolidate QDIO queue setup
Date: Sat, 25 Jan 2020 16:53:00 +0100
In-Reply-To: <20200125155303.40971-1-jwi@linux.ibm.com>
References: <20200125155303.40971-1-jwi@linux.ibm.com>
Message-Id: <20200125155303.40971-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Move some duplicated logic into a shared code path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 9 +++++++--
 drivers/s390/net/qeth_l2_main.c   | 8 +-------
 drivers/s390/net/qeth_l3_main.c   | 8 +-------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 7c37e94fb28b..09d8211fd542 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -994,7 +994,6 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok);
 int qeth_stop_channel(struct qeth_channel *channel);
 
 void qeth_print_status_message(struct qeth_card *);
-int qeth_init_qdio_queues(struct qeth_card *);
 int qeth_send_ipa_cmd(struct qeth_card *, struct qeth_cmd_buffer *,
 		  int (*reply_cb)
 		  (struct qeth_card *, struct qeth_reply *, unsigned long),
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c19cc3978e1f..52e5f086444b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2665,7 +2665,7 @@ static unsigned int qeth_tx_select_bulk_max(struct qeth_card *card,
 	return card->ssqd.mmwc ? card->ssqd.mmwc : 1;
 }
 
-int qeth_init_qdio_queues(struct qeth_card *card)
+static int qeth_init_qdio_queues(struct qeth_card *card)
 {
 	unsigned int i;
 	int rc;
@@ -2713,7 +2713,6 @@ int qeth_init_qdio_queues(struct qeth_card *card)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qeth_init_qdio_queues);
 
 static void qeth_ipa_finalize_cmd(struct qeth_card *card,
 				  struct qeth_cmd_buffer *iob)
@@ -5026,6 +5025,12 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	if (rc)
 		goto out;
 
+	rc = qeth_init_qdio_queues(card);
+	if (rc) {
+		QETH_CARD_TEXT_(card, 2, "9err%d", rc);
+		goto out;
+	}
+
 	return 0;
 out:
 	dev_warn(&card->gdev->dev, "The qeth device driver failed to recover "
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7da306e267c9..5d9bb0597465 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -288,11 +288,11 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 	}
 	if (card->state == CARD_STATE_HARDSETUP) {
 		qeth_drain_output_queues(card);
-		qeth_clear_working_pool_list(card);
 		card->state = CARD_STATE_DOWN;
 	}
 
 	qeth_qdio_clear_card(card, 0);
+	qeth_clear_working_pool_list(card);
 	flush_workqueue(card->event_wq);
 	card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 	card->info.promisc_mode = 0;
@@ -787,12 +787,6 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 	/* softsetup */
 	QETH_CARD_TEXT(card, 2, "softsetp");
 
-	rc = qeth_init_qdio_queues(card);
-	if (rc) {
-		QETH_CARD_TEXT_(card, 2, "6err%d", rc);
-		rc = -ENODEV;
-		goto out_remove;
-	}
 	card->state = CARD_STATE_SOFTSETUP;
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 6c0bffd11138..ee1bdaaa26f6 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1184,11 +1184,11 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 	}
 	if (card->state == CARD_STATE_HARDSETUP) {
 		qeth_drain_output_queues(card);
-		qeth_clear_working_pool_list(card);
 		card->state = CARD_STATE_DOWN;
 	}
 
 	qeth_qdio_clear_card(card, 0);
+	qeth_clear_working_pool_list(card);
 	flush_workqueue(card->event_wq);
 	card->info.promisc_mode = 0;
 }
@@ -2097,12 +2097,6 @@ static int qeth_l3_set_online(struct ccwgroup_device *gdev)
 			QETH_CARD_TEXT_(card, 2, "5err%04x", rc);
 	}
 
-	rc = qeth_init_qdio_queues(card);
-	if (rc) {
-		QETH_CARD_TEXT_(card, 2, "6err%d", rc);
-		rc = -ENODEV;
-		goto out_remove;
-	}
 	card->state = CARD_STATE_SOFTSETUP;
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
-- 
2.17.1
