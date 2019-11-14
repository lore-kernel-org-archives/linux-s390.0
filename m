Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726949AbfKNKTi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:19:38 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEAIJw2018372
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w94yk05h9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:37 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 14 Nov 2019 10:19:35 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/11] s390/qeth: remove gratuitious RX modeset
Date: Thu, 14 Nov 2019 11:19:20 +0100
In-Reply-To: <20191114101924.29558-1-jwi@linux.ibm.com>
References: <20191114101924.29558-1-jwi@linux.ibm.com>
Message-Id: <20191114101924.29558-8-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Trust the IPv4/IPv6 code to properly remove its mcast addresses when a
VLAN device is unregistered, and then also trigger an RX modeset
whenever it's needed.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index a8f18bf0c227..0497ee46660b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -39,7 +39,6 @@
 
 
 static int qeth_l3_set_offline(struct ccwgroup_device *);
-static void qeth_l3_set_rx_mode(struct net_device *dev);
 static int qeth_l3_register_addr_entry(struct qeth_card *,
 		struct qeth_ipaddr *);
 static int qeth_l3_deregister_addr_entry(struct qeth_card *,
@@ -1297,7 +1296,6 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 	QETH_CARD_TEXT_(card, 4, "kid:%d", vid);
 
 	clear_bit(vid, card->active_vlans);
-	qeth_l3_set_rx_mode(dev);
 	return 0;
 }
 
-- 
2.17.1
