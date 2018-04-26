From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/13] s390/net: set HW port number in netdevice
Date: Thu, 26 Apr 2018 09:42:15 +0200
Message-ID: <20180426074224.100432-5-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

struct net_device contains a dev_port field. Store the OSA port number
in this field.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/lcs.c           | 3 +++
 drivers/s390/net/qeth_core_sys.c | 2 ++
 drivers/s390/net/qeth_l2_main.c  | 1 +
 drivers/s390/net/qeth_l3_main.c  | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 0ee8f33efb54..2d9fe7e4ee40 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1928,6 +1928,8 @@ lcs_portno_store (struct device *dev, struct device_attribute *attr, const char
 		return -EINVAL;
         /* TODO: sanity checks */
         card->portno = value;
+	if (card->dev)
+		card->dev->dev_port = card->portno;
 
         return count;
 
@@ -2158,6 +2160,7 @@ lcs_new_device(struct ccwgroup_device *ccwgdev)
 	card->dev = dev;
 	card->dev->ml_priv = card;
 	card->dev->netdev_ops = &lcs_netdev_ops;
+	card->dev->dev_port = card->portno;
 	memcpy(card->dev->dev_addr, card->mac, LCS_MAC_LENGTH);
 #ifdef CONFIG_IP_MULTICAST
 	if (!lcs_check_multicast_support(card))
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index ae81534de912..c3f18afb368b 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -144,6 +144,8 @@ static ssize_t qeth_dev_portno_store(struct device *dev,
 		goto out;
 	}
 	card->info.portno = portno;
+	if (card->dev)
+		card->dev->dev_port = portno;
 out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 896c919e7658..3239b2546ac7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -984,6 +984,7 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	card->dev->mtu = card->info.initial_mtu;
 	card->dev->min_mtu = 64;
 	card->dev->max_mtu = ETH_MAX_MTU;
+	card->dev->dev_port = card->info.portno;
 	card->dev->netdev_ops = &qeth_l2_netdev_ops;
 	if (card->info.type == QETH_CARD_TYPE_OSN) {
 		card->dev->ethtool_ops = &qeth_l2_osn_ops;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 53c5470be7d5..64f27de079ca 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2576,6 +2576,7 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 	card->dev->mtu = card->info.initial_mtu;
 	card->dev->min_mtu = 64;
 	card->dev->max_mtu = ETH_MAX_MTU;
+	card->dev->dev_port = card->info.portno;
 	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
 	card->dev->features |=	NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX |
-- 
2.13.5
