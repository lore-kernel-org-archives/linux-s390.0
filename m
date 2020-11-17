Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/9] s390/qeth: tolerate error when querying card info
Date: Tue, 17 Nov 2020 17:15:15 +0100
Message-Id: <20201117161520.1089-5-jwi@linux.ibm.com>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

By the time that our .get_link_ksettings() code issues a QUERY CARD INFO
cmd to get link-related information, we already set up a good amount of
static link data.

Return this data when the cmd fails, same as when the cmd is not
supported.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_ethtool.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index b5caa723326e..b843df2c14b1 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -413,7 +413,6 @@ static int qeth_get_link_ksettings(struct net_device *netdev,
 	struct qeth_card *card = netdev->ml_priv;
 	enum qeth_link_types link_type;
 	struct carrier_info carrier_info;
-	int rc;
 
 	if (IS_IQD(card) || IS_VM_NIC(card))
 		link_type = QETH_LINK_TYPE_10GBIT_ETH;
@@ -455,12 +454,8 @@ static int qeth_get_link_ksettings(struct net_device *netdev,
 	/* Check if we can obtain more accurate information.	 */
 	/* If QUERY_CARD_INFO command is not supported or fails, */
 	/* just return the heuristics that was filled above.	 */
-	rc = qeth_query_card_info(card, &carrier_info);
-	if (rc == -EOPNOTSUPP) /* for old hardware, return heuristic */
+	if (qeth_query_card_info(card, &carrier_info))
 		return 0;
-	if (rc) /* report error from the hardware operation */
-		return rc;
-	/* on success, fill in the information got from the hardware */
 
 	netdev_dbg(netdev,
 	"card info: card_type=0x%02x, port_mode=0x%04x, port_speed=0x%08x\n",
-- 
2.17.1
