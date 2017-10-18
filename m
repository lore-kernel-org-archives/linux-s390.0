From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 07/13] s390/qeth: don't verify device when setting MAC address
Date: Wed, 18 Oct 2017 17:40:19 +0200
Message-ID: <20171018154025.73630-8-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There's no reason why l2_set_mac_address() should ever be called for
a netdevice that's not owned by qeth. It's certainly not required for
VLAN devices, which have their own netdev_ops.

Also:
1) we don't do such validation for any of the other netdev_ops routines.
2) the code in question clearly has never been actually exercised;
   it's broken. After determining that the device is not owned
   by qeth, it would still use dev->ml_priv to write a qeth trace entry.

Remove the check, and its helper that walked the global card list.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7b61c2ef4c74..87aa8c2ab5b0 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -38,24 +38,6 @@ static void qeth_l2_vnicc_init(struct qeth_card *card);
 static bool qeth_l2_vnicc_recover_timeout(struct qeth_card *card, u32 vnicc,
 					  u32 *timeout);
 
-static int qeth_l2_verify_dev(struct net_device *dev)
-{
-	struct qeth_card *card;
-	unsigned long flags;
-	int rc = 0;
-
-	read_lock_irqsave(&qeth_core_card_list.rwlock, flags);
-	list_for_each_entry(card, &qeth_core_card_list.list, list) {
-		if (card->dev == dev) {
-			rc = QETH_REAL_CARD;
-			break;
-		}
-	}
-	read_unlock_irqrestore(&qeth_core_card_list.rwlock, flags);
-
-	return rc;
-}
-
 static struct net_device *qeth_l2_netdev_by_devno(unsigned char *read_dev_no)
 {
 	struct qeth_card *card;
@@ -568,11 +550,6 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 
 	QETH_CARD_TEXT(card, 3, "setmac");
 
-	if (qeth_l2_verify_dev(dev) != QETH_REAL_CARD) {
-		QETH_CARD_TEXT(card, 3, "setmcINV");
-		return -EOPNOTSUPP;
-	}
-
 	if (card->info.type == QETH_CARD_TYPE_OSN ||
 	    card->info.type == QETH_CARD_TYPE_OSM ||
 	    card->info.type == QETH_CARD_TYPE_OSX) {
-- 
2.13.5
