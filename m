Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbgCRMzZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:25 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICWeGt166639
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8ad6pkq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:24 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:22 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/11] s390/qeth: remove gratuitous NULL checks
Date: Wed, 18 Mar 2020 13:54:54 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-11-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_do_ioctl() is only reached through our own net_device_ops, so we
can trust that dev->ml_priv still contains what we put there earlier.

qeth_bridgeport_an_set() is an internal function that doesn't require
such sanity checks.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 3 ---
 drivers/s390/net/qeth_l2_main.c   | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 3f0b13ff580e..bd3adbb6ad50 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6264,9 +6264,6 @@ int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	struct mii_ioctl_data *mii_data;
 	int rc = 0;
 
-	if (!card)
-		return -ENODEV;
-
 	switch (cmd) {
 	case SIOC_QETH_ADP_SET_SNMP_CONTROL:
 		rc = qeth_snmp_command(card, rq->ifr_ifru.ifru_data);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 71eb2d9bfbb7..2aaf5e3779ce 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1519,8 +1519,6 @@ int qeth_bridgeport_an_set(struct qeth_card *card, int enable)
 	struct ccw_device *ddev;
 	struct subchannel_id schid;
 
-	if (!card)
-		return -EINVAL;
 	if (!card->options.sbp.supported_funcs)
 		return -EOPNOTSUPP;
 	ddev = CARD_DDEV(card);
-- 
2.17.1
