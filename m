Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727262AbfLRPci (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Dec 2019 10:32:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIFSY0W084187
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wyncxbtj9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Dec 2019 15:32:35 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/3] s390/qeth: don't return -ENOTSUPP to userspace
Date: Wed, 18 Dec 2019 16:32:28 +0100
In-Reply-To: <20191218153228.29908-1-jwi@linux.ibm.com>
References: <20191218153228.29908-1-jwi@linux.ibm.com>
Message-Id: <20191218153228.29908-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

ENOTSUPP is not uapi, use EOPNOTSUPP instead.

Fixes: d66cb37e9664 ("qeth: Add new priority queueing options")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index e81170ab6d9a..7bd86027f559 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -207,7 +207,7 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 		card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 	} else if (sysfs_streq(buf, "prio_queueing_vlan")) {
 		if (IS_LAYER3(card)) {
-			rc = -ENOTSUPP;
+			rc = -EOPNOTSUPP;
 			goto out;
 		}
 		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_VLAN;
-- 
2.17.1
