Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727539AbfLRQfC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Dec 2019 11:35:02 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIGYVQk152806
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 11:35:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wyq5r1cmd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 11:35:00 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Dec 2019 16:34:58 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/9] s390/qeth: don't raise NETDEV_REBOOT event from L3 offline path
Date: Wed, 18 Dec 2019 17:34:47 +0100
In-Reply-To: <20191218163450.36731-1-jwi@linux.ibm.com>
References: <20191218163450.36731-1-jwi@linux.ibm.com>
Message-Id: <20191218163450.36731-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

This is a leftover from back when a recovery action didn't go through
dev_close(), and was meant to shoot down all remaining af_iucv sockets
on the interface.

Now that the offline path always calls dev_close(), the
NETDEV_GOING_DOWN event from __dev_close_many() is sufficient and this
hack can be removed.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index bd2273f9ca35..8bd3fc73a4fb 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2288,12 +2288,6 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	rtnl_unlock();
 
 	qeth_l3_stop_card(card);
-	if (card->options.cq == QETH_CQ_ENABLED) {
-		rtnl_lock();
-		call_netdevice_notifiers(NETDEV_REBOOT, card->dev);
-		rtnl_unlock();
-	}
-
 	rc  = qeth_stop_channel(&card->data);
 	rc2 = qeth_stop_channel(&card->write);
 	rc3 = qeth_stop_channel(&card->read);
-- 
2.17.1
