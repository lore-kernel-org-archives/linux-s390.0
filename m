Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44572 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbfKNKT6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:19:58 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEAIHc4007208
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92jkvke2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:55 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 14 Nov 2019 10:19:34 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/11] s390/qeth: fine-tune L3 mcast locking
Date: Thu, 14 Nov 2019 11:19:19 +0100
In-Reply-To: <20191114101924.29558-1-jwi@linux.ibm.com>
References: <20191114101924.29558-1-jwi@linux.ibm.com>
Message-Id: <20191114101924.29558-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Push the inet6_dev locking down into the helper that actually needs it
for walking the mc_list.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 3b901f3676c1..a8f18bf0c227 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1206,6 +1206,7 @@ static void qeth_l3_add_mc6_to_hash(struct qeth_card *card,
 	if (!tmp)
 		return;
 
+	read_lock_bh(&in6_dev->lock);
 	for (im6 = in6_dev->mc_list; im6 != NULL; im6 = im6->next) {
 		tmp->u.a6.addr = im6->mca_addr;
 		tmp->is_multicast = 1;
@@ -1228,6 +1229,8 @@ static void qeth_l3_add_mc6_to_hash(struct qeth_card *card,
 				&ipm->hnode, qeth_l3_ipaddr_hash(ipm));
 
 	}
+	read_unlock_bh(&in6_dev->lock);
+
 	kfree(tmp);
 }
 
@@ -1253,9 +1256,7 @@ static void qeth_l3_add_vlan_mc6(struct qeth_card *card)
 		in_dev = in6_dev_get(netdev);
 		if (!in_dev)
 			continue;
-		read_lock_bh(&in_dev->lock);
 		qeth_l3_add_mc6_to_hash(card, in_dev);
-		read_unlock_bh(&in_dev->lock);
 		in6_dev_put(in_dev);
 	}
 }
@@ -1273,10 +1274,8 @@ static void qeth_l3_add_multicast_ipv6(struct qeth_card *card)
 		return;
 
 	rcu_read_lock();
-	read_lock_bh(&in6_dev->lock);
 	qeth_l3_add_mc6_to_hash(card, in6_dev);
 	qeth_l3_add_vlan_mc6(card);
-	read_unlock_bh(&in6_dev->lock);
 	rcu_read_unlock();
 	in6_dev_put(in6_dev);
 }
-- 
2.17.1
