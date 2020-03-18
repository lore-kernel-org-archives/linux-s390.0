Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbgCRMzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICds98070860
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yuk25a1r8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:21 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/11] s390/qeth: remove prio-queueing support for z/VM NICs
Date: Wed, 18 Mar 2020 13:54:47 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

z/VM NICs don't offer HW QoS for TX rings. So just use netdev_pick_tx()
to distribute the connections equally over all enabled TX queues.

We start with just 1 enabled TX queue (this matches the typical
configuration without prio-queueing). A follow-on patch will allow users
to enable additional TX queues.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 56 +++++++++++++++++++------------
 drivers/s390/net/qeth_core_sys.c  |  2 +-
 drivers/s390/net/qeth_l2_main.c   |  8 ++++-
 drivers/s390/net/qeth_l3_main.c   |  7 +++-
 5 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 962be94ed3ca..94cd39631eee 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1053,6 +1053,7 @@ int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
 void qeth_trace_features(struct qeth_card *);
 int qeth_setassparms_cb(struct qeth_card *, struct qeth_reply *, unsigned long);
+int qeth_setup_netdev(struct qeth_card *card);
 int qeth_set_features(struct net_device *, netdev_features_t);
 void qeth_enable_hw_features(struct net_device *dev);
 netdev_features_t qeth_fix_features(struct net_device *, netdev_features_t);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 767cef04c9d8..f13495d9209b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1244,9 +1244,12 @@ EXPORT_SYMBOL_GPL(qeth_drain_output_queues);
 
 static int qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 {
-	unsigned int count = single ? 1 : card->dev->num_tx_queues;
+	unsigned int max = single ? 1 : card->dev->num_tx_queues;
+	unsigned int count;
 	int rc;
 
+	count = IS_VM_NIC(card) ? min(max, card->dev->real_num_tx_queues) : max;
+
 	rtnl_lock();
 	rc = netif_set_real_num_tx_queues(card->dev, count);
 	rtnl_unlock();
@@ -1254,16 +1257,16 @@ static int qeth_osa_set_output_queues(struct qeth_card *card, bool single)
 	if (rc)
 		return rc;
 
-	if (card->qdio.no_out_queues == count)
+	if (card->qdio.no_out_queues == max)
 		return 0;
 
 	if (atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED)
 		qeth_free_qdio_queues(card);
 
-	if (count == 1)
+	if (max == 1 && card->qdio.do_prio_queueing != QETH_PRIOQ_DEFAULT)
 		dev_info(&card->gdev->dev, "Priority Queueing not supported\n");
 
-	card->qdio.no_out_queues = count;
+	card->qdio.no_out_queues = max;
 	return 0;
 }
 
@@ -5987,22 +5990,8 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 	SET_NETDEV_DEV(dev, &card->gdev->dev);
 	netif_carrier_off(dev);
 
-	if (IS_OSN(card)) {
-		dev->ethtool_ops = &qeth_osn_ethtool_ops;
-	} else {
-		dev->ethtool_ops = &qeth_ethtool_ops;
-		dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-		dev->hw_features |= NETIF_F_SG;
-		dev->vlan_features |= NETIF_F_SG;
-		if (IS_IQD(card)) {
-			dev->features |= NETIF_F_SG;
-			if (netif_set_real_num_tx_queues(dev,
-							 QETH_IQD_MIN_TXQ)) {
-				free_netdev(dev);
-				return NULL;
-			}
-		}
-	}
+	dev->ethtool_ops = IS_OSN(card) ? &qeth_osn_ethtool_ops :
+					  &qeth_ethtool_ops;
 
 	return dev;
 }
@@ -6018,6 +6007,28 @@ struct net_device *qeth_clone_netdev(struct net_device *orig)
 	return clone;
 }
 
+int qeth_setup_netdev(struct qeth_card *card)
+{
+	struct net_device *dev = card->dev;
+	unsigned int num_tx_queues;
+
+	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+	dev->hw_features |= NETIF_F_SG;
+	dev->vlan_features |= NETIF_F_SG;
+
+	if (IS_IQD(card)) {
+		dev->features |= NETIF_F_SG;
+		num_tx_queues = QETH_IQD_MIN_TXQ;
+	} else if (IS_VM_NIC(card)) {
+		num_tx_queues = 1;
+	} else {
+		num_tx_queues = dev->real_num_tx_queues;
+	}
+
+	return netif_set_real_num_tx_queues(dev, num_tx_queues);
+}
+EXPORT_SYMBOL_GPL(qeth_setup_netdev);
+
 static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card;
@@ -6057,12 +6068,13 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 		goto err_card;
 	}
 
+	qeth_determine_capabilities(card);
+	qeth_set_blkt_defaults(card);
+
 	card->qdio.no_out_queues = card->dev->num_tx_queues;
 	rc = qeth_update_from_chp_desc(card);
 	if (rc)
 		goto err_chp_desc;
-	qeth_determine_capabilities(card);
-	qeth_set_blkt_defaults(card);
 
 	enforced_disc = qeth_enforce_discipline(card);
 	switch (enforced_disc) {
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 78cae61bc924..533a7f26dbe1 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -176,7 +176,7 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 	struct qeth_card *card = dev_get_drvdata(dev);
 	int rc = 0;
 
-	if (IS_IQD(card))
+	if (IS_IQD(card) || IS_VM_NIC(card))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&card->conf_mutex);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8ba4ac2a5b47..71eb2d9bfbb7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -571,7 +571,9 @@ static u16 qeth_l2_select_queue(struct net_device *dev, struct sk_buff *skb,
 		return qeth_iqd_select_queue(dev, skb,
 					     qeth_get_ether_cast_type(skb),
 					     sb_dev);
-	return qeth_get_priority_queue(card, skb);
+
+	return IS_VM_NIC(card) ? netdev_pick_tx(dev, skb, sb_dev) :
+				 qeth_get_priority_queue(card, skb);
 }
 
 static const struct device_type qeth_l2_devtype = {
@@ -659,6 +661,10 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 		goto add_napi;
 	}
 
+	rc = qeth_setup_netdev(card);
+	if (rc)
+		return rc;
+
 	card->dev->needed_headroom = sizeof(struct qeth_hdr);
 	card->dev->netdev_ops = &qeth_l2_netdev_ops;
 	card->dev->priv_flags |= IFF_UNICAST_FLT;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8a803d6c9357..81ec0d2b7ea5 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1880,7 +1880,8 @@ static u16 qeth_l3_osa_select_queue(struct net_device *dev, struct sk_buff *skb,
 {
 	struct qeth_card *card = dev->ml_priv;
 
-	return qeth_get_priority_queue(card, skb);
+	return IS_VM_NIC(card) ? netdev_pick_tx(dev, skb, sb_dev) :
+				 qeth_get_priority_queue(card, skb);
 }
 
 static const struct net_device_ops qeth_l3_netdev_ops = {
@@ -1922,6 +1923,10 @@ static int qeth_l3_setup_netdev(struct qeth_card *card, bool carrier_ok)
 	unsigned int headroom;
 	int rc;
 
+	rc = qeth_setup_netdev(card);
+	if (rc)
+		return rc;
+
 	if (IS_OSD(card) || IS_OSX(card)) {
 		if ((card->info.link_type == QETH_LINK_TYPE_LANE_TR) ||
 		    (card->info.link_type == QETH_LINK_TYPE_HSTR)) {
-- 
2.17.1
