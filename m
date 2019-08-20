Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730288AbfHTOq7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 10:46:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KEZY5M077310
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugg7510qk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 15:46:56 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/9] s390/qeth: keep cmd alive after IO completion
Date: Tue, 20 Aug 2019 16:46:38 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-5-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Current code releases the cmd struct after its initial IO has completed.
Any reply processing is done independently, using a separate qeth_reply
struct.
In preparation for merging the cmd and reply structs together, take an
additional reference on the cmd object so that it stays around all the
way until qeth_send_control_data() returns.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 49e85d2e79c2..3fc14f222dc3 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1742,6 +1742,9 @@ static int qeth_send_control_data(struct qeth_card *card,
 
 	qeth_enqueue_reply(card, reply);
 
+	/* This pairs with iob->callback, and keeps the iob alive after IO: */
+	qeth_get_cmd(iob);
+
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, __ccw_from_cmd(iob),
@@ -1752,11 +1755,10 @@ static int qeth_send_control_data(struct qeth_card *card,
 				 CARD_DEVID(card), rc);
 		QETH_CARD_TEXT_(card, 2, " err%d", rc);
 		qeth_dequeue_reply(card, reply);
-		qeth_put_reply(reply);
 		qeth_put_cmd(iob);
 		atomic_set(&channel->irq_pending, 0);
 		wake_up(&card->wait_q);
-		return rc;
+		goto out;
 	}
 
 	timeout = wait_for_completion_interruptible_timeout(&reply->received,
@@ -1777,7 +1779,10 @@ static int qeth_send_control_data(struct qeth_card *card,
 
 	if (!rc)
 		rc = reply->rc;
+
+out:
 	qeth_put_reply(reply);
+	qeth_put_cmd(iob);
 	return rc;
 }
 
-- 
2.17.1
