Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404508AbfFKQiN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGR8Aj102476
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2eug3vp3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:09 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/13] s390/qeth: restart pending READ cmd from callback
Date: Tue, 11 Jun 2019 18:37:51 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-5-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The completion of a pending READ cmd is processed via
qeth_issue_next_read_cb(). Let this callback also start the next READ
cmd, instead of hardcoding that step into the IRQ handler.

While at it remove the check of the channel state,
__qeth_issue_next_read() already does this.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index feb9e1c9d506..fade84112e80 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -851,6 +851,7 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 		QETH_PDU_HEADER_SEQ_NO(iob->data),
 		QETH_SEQ_NO_LENGTH);
 	qeth_release_buffer(channel, iob);
+	__qeth_issue_next_read(card);
 }
 
 static int qeth_set_thread_start_bit(struct qeth_card *card,
@@ -1115,9 +1116,6 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	}
 	if (channel == &card->data)
 		return;
-	if (channel == &card->read &&
-	    channel->state == CH_STATE_UP)
-		__qeth_issue_next_read(card);
 
 	if (iob && iob->callback)
 		iob->callback(card, iob->channel, iob);
-- 
2.17.1
