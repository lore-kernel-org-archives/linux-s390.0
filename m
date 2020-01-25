Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726260AbgAYPxO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 25 Jan 2020 10:53:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00PFbidE117114
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrjr2eyfq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:13 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sat, 25 Jan 2020 15:53:11 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/5] s390/qeth: remove HARDSETUP state
Date: Sat, 25 Jan 2020 16:53:03 +0100
In-Reply-To: <20200125155303.40971-1-jwi@linux.ibm.com>
References: <20200125155303.40971-1-jwi@linux.ibm.com>
Message-Id: <20200125155303.40971-6-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_l?_stop_card() is _never_ called while in HARDSETUP state, and
there's no other usage of the card state that relies on the
DOWN -> HARDSETUP -> SOFTSETUP transition.

As related cleanup, remove the check in qeth_realloc_buffer_pool() as it
is already done by the callers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c |  3 ---
 drivers/s390/net/qeth_core_sys.c  |  2 --
 drivers/s390/net/qeth_l2_main.c   |  4 ----
 drivers/s390/net/qeth_l3_main.c   | 14 +++-----------
 5 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 950d01551373..9575a627a1e1 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -558,7 +558,6 @@ enum qeth_channel_states {
  */
 enum qeth_card_states {
 	CARD_STATE_DOWN,
-	CARD_STATE_HARDSETUP,
 	CARD_STATE_SOFTSETUP,
 };
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 0f5f36e63823..9639938581f5 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -247,9 +247,6 @@ int qeth_realloc_buffer_pool(struct qeth_card *card, int bufcnt)
 {
 	QETH_CARD_TEXT(card, 2, "realcbp");
 
-	if (card->state != CARD_STATE_DOWN)
-		return -EPERM;
-
 	/* TODO: steel/add buffers from/to a running card's buffer pool (?) */
 	qeth_clear_working_pool_list(card);
 	qeth_free_buffer_pool(card);
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 7bd86027f559..2bd9993aa60b 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -24,8 +24,6 @@ static ssize_t qeth_dev_state_show(struct device *dev,
 	switch (card->state) {
 	case CARD_STATE_DOWN:
 		return sprintf(buf, "DOWN\n");
-	case CARD_STATE_HARDSETUP:
-		return sprintf(buf, "HARDSETUP\n");
 	case CARD_STATE_SOFTSETUP:
 		if (card->dev->flags & IFF_UP)
 			return sprintf(buf, "UP (LAN %s)\n",
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index d5ffd40937d3..692bd2623401 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -283,9 +283,6 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_clear_ipacmd_list(card);
-		card->state = CARD_STATE_HARDSETUP;
-	}
-	if (card->state == CARD_STATE_HARDSETUP) {
 		qeth_drain_output_queues(card);
 		card->state = CARD_STATE_DOWN;
 	}
@@ -776,7 +773,6 @@ static int qeth_l2_set_online(struct qeth_card *card)
 	qeth_trace_features(card);
 	qeth_l2_trace_features(card);
 
-	card->state = CARD_STATE_HARDSETUP;
 	qeth_print_status_message(card);
 
 	/* softsetup */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index eb2d9c427b10..317d56647a4a 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -901,7 +901,7 @@ static int qeth_l3_start_ipa_broadcast(struct qeth_card *card)
 	return rc;
 }
 
-static int qeth_l3_start_ipassists(struct qeth_card *card)
+static void qeth_l3_start_ipassists(struct qeth_card *card)
 {
 	QETH_CARD_TEXT(card, 3, "strtipas");
 
@@ -911,7 +911,6 @@ static int qeth_l3_start_ipassists(struct qeth_card *card)
 	qeth_l3_start_ipa_multicast(card);		/* go on*/
 	qeth_l3_start_ipa_ipv6(card);		/* go on*/
 	qeth_l3_start_ipa_broadcast(card);		/* go on*/
-	return 0;
 }
 
 static int qeth_l3_iqd_read_initial_mac_cb(struct qeth_card *card,
@@ -1178,9 +1177,6 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_l3_clear_ip_htable(card, 1);
 		qeth_clear_ipacmd_list(card);
-		card->state = CARD_STATE_HARDSETUP;
-	}
-	if (card->state == CARD_STATE_HARDSETUP) {
 		qeth_drain_output_queues(card);
 		card->state = CARD_STATE_DOWN;
 	}
@@ -2068,7 +2064,6 @@ static int qeth_l3_set_online(struct qeth_card *card)
 		goto out_remove;
 	}
 
-	card->state = CARD_STATE_HARDSETUP;
 	qeth_print_status_message(card);
 
 	/* softsetup */
@@ -2078,11 +2073,8 @@ static int qeth_l3_set_online(struct qeth_card *card)
 	if (rc)
 		QETH_CARD_TEXT_(card, 2, "2err%04x", rc);
 	if (!card->options.sniffer) {
-		rc = qeth_l3_start_ipassists(card);
-		if (rc) {
-			QETH_CARD_TEXT_(card, 2, "3err%d", rc);
-			goto out_remove;
-		}
+		qeth_l3_start_ipassists(card);
+
 		rc = qeth_l3_setrouting_v4(card);
 		if (rc)
 			QETH_CARD_TEXT_(card, 2, "4err%04x", rc);
-- 
2.17.1
