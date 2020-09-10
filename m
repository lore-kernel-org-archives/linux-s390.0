Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbgIJRYK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 13:24:10 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/8] s390/qeth: implement ndo_bridge_getlink for learning_sync
Date: Thu, 10 Sep 2020 19:23:50 +0200
Message-Id: <20200910172351.5622-8-jwi@linux.ibm.com>
In-Reply-To: <20200910172351.5622-1-jwi@linux.ibm.com>
References: <20200910172351.5622-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>

From: Alexandra Winter <wintera@linux.ibm.com>

Documentation/networking/switchdev.txt and 'man bridge' indicate that the
learning_sync bridge attribute is used to indicate whether a given
device will sync MAC addresses learned on its device port to a master
bridge FDB.

learning_sync attribute can not be read while interface is offline (down).
See
'commit e6e771b3d897 ("s390/qeth: detach netdevice while card is offline")'
We return EOPNOTSUPP and not EONODEV in this case, because EONOTSUPP is the
only rc that is tolerated by 'bridge -d link show'.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ef2962e03546..338bc62556cf 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -33,6 +33,7 @@ static void qeth_bridge_state_change(struct qeth_card *card,
 					struct qeth_ipa_cmd *cmd);
 static void qeth_addr_change_event(struct qeth_card *card,
 				   struct qeth_ipa_cmd *cmd);
+static bool qeth_bridgeport_is_in_use(struct qeth_card *card);
 static void qeth_l2_vnicc_set_defaults(struct qeth_card *card);
 static void qeth_l2_vnicc_init(struct qeth_card *card);
 static bool qeth_l2_vnicc_recover_timeout(struct qeth_card *card, u32 vnicc,
@@ -836,6 +837,25 @@ static int qeth_l2_dev2br_an_set(struct qeth_card *card, bool enable)
 	return rc;
 }
 
+static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
+				  struct net_device *dev, u32 filter_mask,
+				  int nlflags)
+{
+	struct qeth_priv *priv = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
+	u16 mode = BRIDGE_MODE_UNDEF;
+
+	/* Do not even show qeth devs that cannot do bridge_setlink */
+	if (!priv->brport_hw_features || !netif_device_present(dev) ||
+	    qeth_bridgeport_is_in_use(card))
+		return -EOPNOTSUPP;
+
+	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
+				       mode, priv->brport_features,
+				       priv->brport_hw_features,
+				       nlflags, filter_mask, NULL);
+}
+
 static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_open		= qeth_open,
 	.ndo_stop		= qeth_stop,
@@ -851,7 +871,8 @@ static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_vlan_rx_kill_vid   = qeth_l2_vlan_rx_kill_vid,
 	.ndo_tx_timeout	   	= qeth_tx_timeout,
 	.ndo_fix_features	= qeth_fix_features,
-	.ndo_set_features	= qeth_set_features
+	.ndo_set_features	= qeth_set_features,
+	.ndo_bridge_getlink	= qeth_l2_bridge_getlink,
 };
 
 static const struct net_device_ops qeth_osn_netdev_ops = {
-- 
2.17.1
