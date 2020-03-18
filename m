Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbgCRMzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICdf5m057524
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yuk25a1qw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:20 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/11] s390/qeth: balance the TX queue selection for IQD devices
Date: Wed, 18 Mar 2020 13:54:50 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

For ucast traffic, qeth_iqd_select_queue() falls back to
netdev_pick_tx(). This will potentially use skb_tx_hash() to distribute
the flow over all active TX queues - so txq 0 is a valid selection, and
qeth_iqd_select_queue() needs to check for this and put it on some other
queue. As a result, the distribution for ucast flows is unbalanced and
hits QETH_IQD_MIN_UCAST_TXQ heavier than the other queues.

Open-coding a custom variant of skb_tx_hash() isn't an option, since
netdev_pick_tx() also gives us eg. access to XPS. But we can pull a
little trick: add a single TC class that excludes the mcast txq, and
thus encourage skb_tx_hash() to not pick the mcast txq.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 45 ++++++++++++++++++++++++++++++-
 drivers/s390/net/qeth_ethtool.c   |  2 +-
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 94cd39631eee..b8b356aca674 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1061,6 +1061,7 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
 void qeth_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats);
+int qeth_set_real_num_tx_queues(struct qeth_card *card, unsigned int count);
 u16 qeth_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
 			  u8 cast_type, struct net_device *sb_dev);
 int qeth_open(struct net_device *dev);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index aa493edc0082..e1d984c29e1f 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6025,7 +6025,7 @@ int qeth_setup_netdev(struct qeth_card *card)
 		num_tx_queues = dev->real_num_tx_queues;
 	}
 
-	return netif_set_real_num_tx_queues(dev, num_tx_queues);
+	return qeth_set_real_num_tx_queues(card, num_tx_queues);
 }
 EXPORT_SYMBOL_GPL(qeth_setup_netdev);
 
@@ -6641,6 +6641,47 @@ void qeth_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 }
 EXPORT_SYMBOL_GPL(qeth_get_stats64);
 
+#define TC_IQD_UCAST   0
+static void qeth_iqd_set_prio_tc_map(struct net_device *dev,
+				     unsigned int ucast_txqs)
+{
+	unsigned int prio;
+
+	/* IQD requires mcast traffic to be placed on a dedicated queue, and
+	 * qeth_iqd_select_queue() deals with this.
+	 * For unicast traffic, we defer the queue selection to the stack.
+	 * By installing a trivial prio map that spans over only the unicast
+	 * queues, we can encourage the stack to spread the ucast traffic evenly
+	 * without selecting the mcast queue.
+	 */
+
+	/* One traffic class, spanning over all active ucast queues: */
+	netdev_set_num_tc(dev, 1);
+	netdev_set_tc_queue(dev, TC_IQD_UCAST, ucast_txqs,
+			    QETH_IQD_MIN_UCAST_TXQ);
+
+	/* Map all priorities to this traffic class: */
+	for (prio = 0; prio <= TC_BITMASK; prio++)
+		netdev_set_prio_tc_map(dev, prio, TC_IQD_UCAST);
+}
+
+int qeth_set_real_num_tx_queues(struct qeth_card *card, unsigned int count)
+{
+	struct net_device *dev = card->dev;
+	int rc;
+
+	/* Per netif_setup_tc(), adjust the mapping first: */
+	if (IS_IQD(card))
+		qeth_iqd_set_prio_tc_map(dev, count - 1);
+
+	rc = netif_set_real_num_tx_queues(dev, count);
+
+	if (rc && IS_IQD(card))
+		qeth_iqd_set_prio_tc_map(dev, dev->real_num_tx_queues - 1);
+
+	return rc;
+}
+
 u16 qeth_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
 			  u8 cast_type, struct net_device *sb_dev)
 {
@@ -6648,6 +6689,8 @@ u16 qeth_iqd_select_queue(struct net_device *dev, struct sk_buff *skb,
 
 	if (cast_type != RTN_UNICAST)
 		return QETH_IQD_MCAST_TXQ;
+	if (dev->real_num_tx_queues == QETH_IQD_MIN_TXQ)
+		return QETH_IQD_MIN_UCAST_TXQ;
 
 	txq = netdev_pick_tx(dev, skb, sb_dev);
 	return (txq == QETH_IQD_MCAST_TXQ) ? QETH_IQD_MIN_UCAST_TXQ : txq;
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index 715ee0015847..079b695032ef 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -201,7 +201,7 @@ static int qeth_set_channels(struct net_device *dev,
 			return -EOPNOTSUPP;
 	}
 
-	return netif_set_real_num_tx_queues(dev, channels->tx_count);
+	return qeth_set_real_num_tx_queues(card, channels->tx_count);
 }
 
 static int qeth_get_tunable(struct net_device *dev,
-- 
2.17.1
