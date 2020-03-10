Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36592 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgCJRiL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 13:38:11 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AHbDLA039149
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 13:38:09 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7ac6rwy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 13:38:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 10 Mar 2020 17:38:07 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/3] s390/qeth: don't reset default_out_queue
Date: Tue, 10 Mar 2020 18:38:01 +0100
In-Reply-To: <20200310173803.91602-1-jwi@linux.ibm.com>
References: <20200310173803.91602-1-jwi@linux.ibm.com>
Message-Id: <20200310173803.91602-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When an OSA device in prio-queue setup is reduced to 1 TX queue due to
HW restrictions, we reset its the default_out_queue to 0.

In the old code this was needed so that qeth_get_priority_queue() gets
the queue selection right. But with proper multiqueue support we already
reduced dev->real_num_tx_queues to 1, and so the stack puts all traffic
on txq 0 without even calling .ndo_select_queue.

Thus we can preserve the user's configuration, and apply it if the OSA
device later re-gains support for multiple TX queues.

Fixes: 73dc2daf110f ("s390/qeth: add TX multiqueue support for OSA devices")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8ca85c8a01a1..2a05d13a0e79 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1204,7 +1204,6 @@ static int qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 	if (count == 1)
 		dev_info(&card->gdev->dev, "Priority Queueing not supported\n");
 
-	card->qdio.default_out_queue = single ? 0 : QETH_DEFAULT_QUEUE;
 	card->qdio.no_out_queues = count;
 	return 0;
 }
-- 
2.17.1
