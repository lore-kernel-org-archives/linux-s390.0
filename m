Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404557AbfFKQiN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGWRoT018079
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t2eqg3xut-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:10 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/13] s390/qeth: simplify DOWN state handling
Date: Tue, 11 Jun 2019 18:37:50 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When the tear down sequence in qeth_l?_stop_card() has finished, the
card is guaranteed to be in DOWN state and we don't have to check for
it again.
With this insight we can also remove the redundant setting of
card->state in qeth_l?_set_online()'s error path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 7 ++-----
 drivers/s390/net/qeth_l3_main.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ff8a6cd790b1..40e2f6bd0f09 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -292,11 +292,9 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 		qeth_clear_working_pool_list(card);
 		card->state = CARD_STATE_DOWN;
 	}
-	if (card->state == CARD_STATE_DOWN) {
-		qeth_clear_cmd_buffers(&card->read);
-		qeth_clear_cmd_buffers(&card->write);
-	}
 
+	qeth_clear_cmd_buffers(&card->read);
+	qeth_clear_cmd_buffers(&card->write);
 	flush_workqueue(card->event_wq);
 	card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 }
@@ -882,7 +880,6 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
 	qdio_free(CARD_DDEV(card));
-	card->state = CARD_STATE_DOWN;
 
 	mutex_unlock(&card->conf_mutex);
 	mutex_unlock(&card->discipline_mutex);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 13bf3e2e9cea..99ca38164b99 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1436,11 +1436,9 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 		qeth_clear_working_pool_list(card);
 		card->state = CARD_STATE_DOWN;
 	}
-	if (card->state == CARD_STATE_DOWN) {
-		qeth_clear_cmd_buffers(&card->read);
-		qeth_clear_cmd_buffers(&card->write);
-	}
 
+	qeth_clear_cmd_buffers(&card->read);
+	qeth_clear_cmd_buffers(&card->write);
 	flush_workqueue(card->event_wq);
 }
 
@@ -2420,7 +2418,6 @@ static int qeth_l3_set_online(struct ccwgroup_device *gdev)
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
 	qdio_free(CARD_DDEV(card));
-	card->state = CARD_STATE_DOWN;
 
 	mutex_unlock(&card->conf_mutex);
 	mutex_unlock(&card->discipline_mutex);
-- 
2.17.1
