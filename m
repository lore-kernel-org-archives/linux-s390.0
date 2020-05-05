Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/11] s390/qeth: allow reset via ethtool
Date: Tue,  5 May 2020 18:25:58 +0200
Message-Id: <20200505162559.14138-11-jwi@linux.ibm.com>
In-Reply-To: <20200505162559.14138-1-jwi@linux.ibm.com>
References: <20200505162559.14138-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Implement the .reset callback. Only a full reset is supported.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_ethtool.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index ebdc03210608..0d12002d0615 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -193,6 +193,21 @@ static void qeth_get_drvinfo(struct net_device *dev,
 		 CARD_RDEV_ID(card), CARD_WDEV_ID(card), CARD_DDEV_ID(card));
 }
 
+static int qeth_reset(struct net_device *dev, u32 *flags)
+{
+	struct qeth_card *card = dev->ml_priv;
+	int rc;
+
+	if (*flags != ETH_RESET_ALL)
+		return -EINVAL;
+
+	rc = qeth_schedule_recovery(card);
+	if (!rc)
+		*flags = 0;
+
+	return rc;
+}
+
 static void qeth_get_channels(struct net_device *dev,
 			      struct ethtool_channels *channels)
 {
@@ -522,6 +537,7 @@ const struct ethtool_ops qeth_ethtool_ops = {
 	.get_ethtool_stats = qeth_get_ethtool_stats,
 	.get_sset_count = qeth_get_sset_count,
 	.get_drvinfo = qeth_get_drvinfo,
+	.reset = qeth_reset,
 	.get_channels = qeth_get_channels,
 	.set_channels = qeth_set_channels,
 	.get_ts_info = qeth_get_ts_info,
-- 
2.17.1
