Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbgCRMzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICaDEO065265
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yua2avcf4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:22 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/11] s390/qeth: allow configuration of TX queues for IQD devices
Date: Wed, 18 Mar 2020 13:54:49 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-6-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Similar to the support for z/VM NICs, but we need to take extra care
about the dedicated mcast queue:

1. netdev_pick_tx() is unaware of this limitation and might select the
   mcast txq. Catch this.
2. require at least _two_ TX queues - one for ucast, one for mcast.
3. when reducing the number of TX queues, there's a potential race
   where netdev_cap_txqueue() over-rules the selected txq index and
   falls back to index 0. This would place ucast traffic on the mcast
   queue, and result in TX errors.
   So for IQD, reject a reduction while the interface is running.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |  6 +++++-
 drivers/s390/net/qeth_ethtool.c   | 19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f13495d9209b..aa493edc0082 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6644,9 +6644,13 @@ EXPORT_SYMBOL_GPL(qeth_get_stats64);
 u16 qeth_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
 			  u8 cast_type, struct net_device *sb_dev)
 {
+	u16 txq;
+
 	if (cast_type != RTN_UNICAST)
 		return QETH_IQD_MCAST_TXQ;
-	return QETH_IQD_MIN_UCAST_TXQ;
+
+	txq = netdev_pick_tx(dev, skb, sb_dev);
+	return (txq == QETH_IQD_MCAST_TXQ) ? QETH_IQD_MIN_UCAST_TXQ : txq;
 }
 EXPORT_SYMBOL_GPL(qeth_iqd_select_queue);
 
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index 19b9c8302d36..715ee0015847 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -180,14 +180,27 @@ static int qeth_set_channels(struct net_device *dev,
 {
 	struct qeth_card *card = dev->ml_priv;
 
-	if (IS_IQD(card) || !IS_VM_NIC(card))
-		return -EOPNOTSUPP;
-
 	if (channels->rx_count == 0 || channels->tx_count == 0)
 		return -EINVAL;
 	if (channels->tx_count > card->qdio.no_out_queues)
 		return -EINVAL;
 
+	if (IS_IQD(card)) {
+		if (channels->tx_count < QETH_IQD_MIN_TXQ)
+			return -EINVAL;
+
+		/* Reject downgrade while running. It could push displaced
+		 * ucast flows onto txq0, which is reserved for mcast.
+		 */
+		if (netif_running(dev) &&
+		    channels->tx_count < dev->real_num_tx_queues)
+			return -EPERM;
+	} else {
+		/* OSA still uses the legacy prio-queue mechanism: */
+		if (!IS_VM_NIC(card))
+			return -EOPNOTSUPP;
+	}
+
 	return netif_set_real_num_tx_queues(dev, channels->tx_count);
 }
 
-- 
2.17.1
