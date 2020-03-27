Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0LB3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 07:01:29 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RAXVRQ122988
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 07:01:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywek0shaa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 07:01:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 27 Mar 2020 11:00:43 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net] s390/qeth: support net namespaces for L3 devices
Date: Fri, 27 Mar 2020 12:00:42 +0100
Message-Id: <20200327110042.50797-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Enable the L3 driver's IPv4 address notifier to watch for events on qeth
devices that have been moved into a net namespace. We need to program
those IPs into the HW just as usual, otherwise inbound traffic won't
flow.

Fixes: 6133fb1aa137 ("[NETNS]: Disable inetaddr notifiers in namespaces other than initial.")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 82f800d1d7b3..46c212118022 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2204,9 +2204,6 @@ static int qeth_l3_ip_event(struct notifier_block *this,
 	struct qeth_ipaddr addr;
 	struct qeth_card *card;
 
-	if (dev_net(dev) != &init_net)
-		return NOTIFY_DONE;
-
 	card = qeth_l3_get_card_from_dev(dev);
 	if (!card)
 		return NOTIFY_DONE;
-- 
2.17.1
