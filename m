Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgCRMzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICjX2G163834
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yukx5g98x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:20 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/11] s390/qeth: allow configuration of TX queues for z/VM NICs
Date: Wed, 18 Mar 2020 13:54:48 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-5-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Add support for ETHTOOL_SCHANNELS to change the count of active
TX queues.

Since all TX queue structs are pre-allocated and -registered, we just
need to trivially adjust dev->real_num_tx_queues.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_ethtool.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index 9052c72d5b8f..19b9c8302d36 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -175,6 +175,22 @@ static void qeth_get_channels(struct net_device *dev,
 	channels->combined_count = 0;
 }
 
+static int qeth_set_channels(struct net_device *dev,
+			     struct ethtool_channels *channels)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	if (IS_IQD(card) || !IS_VM_NIC(card))
+		return -EOPNOTSUPP;
+
+	if (channels->rx_count == 0 || channels->tx_count == 0)
+		return -EINVAL;
+	if (channels->tx_count > card->qdio.no_out_queues)
+		return -EINVAL;
+
+	return netif_set_real_num_tx_queues(dev, channels->tx_count);
+}
+
 static int qeth_get_tunable(struct net_device *dev,
 			    const struct ethtool_tunable *tuna, void *data)
 {
@@ -410,6 +426,7 @@ const struct ethtool_ops qeth_ethtool_ops = {
 	.get_sset_count = qeth_get_sset_count,
 	.get_drvinfo = qeth_get_drvinfo,
 	.get_channels = qeth_get_channels,
+	.set_channels = qeth_set_channels,
 	.get_tunable = qeth_get_tunable,
 	.set_tunable = qeth_set_tunable,
 	.get_link_ksettings = qeth_get_link_ksettings,
-- 
2.17.1
