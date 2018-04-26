From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/13] s390/qeth: don't worry about IPs on VLAN removal
Date: Thu, 26 Apr 2018 09:42:14 +0200
Message-ID: <20180426074224.100432-4-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

When removing a VLAN ID on a L3 device, the driver currently attempts to
walk and unregister the VLAN device's IP addresses.
This can be safely removed - before qeth_l3_vlan_rx_kill_vid() even gets
called, we receive an inet[6]addr event for each IP on the device and
qeth_l3_handle_ip_event() unregisters the address accordingly.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 87 -----------------------------------------
 1 file changed, 87 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index f33df82f1237..53c5470be7d5 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1293,91 +1293,6 @@ static void qeth_l3_add_multicast_ipv6(struct qeth_card *card)
 	in6_dev_put(in6_dev);
 }
 
-static void qeth_l3_free_vlan_addresses4(struct qeth_card *card,
-			unsigned short vid)
-{
-	struct in_device *in_dev;
-	struct in_ifaddr *ifa;
-	struct qeth_ipaddr *addr;
-	struct net_device *netdev;
-
-	QETH_CARD_TEXT(card, 4, "frvaddr4");
-
-	netdev = __vlan_find_dev_deep_rcu(card->dev, htons(ETH_P_8021Q), vid);
-	if (!netdev)
-		return;
-	in_dev = in_dev_get(netdev);
-	if (!in_dev)
-		return;
-
-	addr = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
-	if (!addr)
-		goto out;
-
-	spin_lock_bh(&card->ip_lock);
-
-	for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next) {
-		addr->u.a4.addr = be32_to_cpu(ifa->ifa_address);
-		addr->u.a4.mask = be32_to_cpu(ifa->ifa_mask);
-		addr->type = QETH_IP_TYPE_NORMAL;
-		qeth_l3_delete_ip(card, addr);
-	}
-
-	spin_unlock_bh(&card->ip_lock);
-
-	kfree(addr);
-out:
-	in_dev_put(in_dev);
-}
-
-static void qeth_l3_free_vlan_addresses6(struct qeth_card *card,
-					 unsigned short vid)
-{
-	struct inet6_dev *in6_dev;
-	struct inet6_ifaddr *ifa;
-	struct qeth_ipaddr *addr;
-	struct net_device *netdev;
-
-	QETH_CARD_TEXT(card, 4, "frvaddr6");
-
-	netdev = __vlan_find_dev_deep_rcu(card->dev, htons(ETH_P_8021Q), vid);
-	if (!netdev)
-		return;
-
-	in6_dev = in6_dev_get(netdev);
-	if (!in6_dev)
-		return;
-
-	addr = qeth_l3_get_addr_buffer(QETH_PROT_IPV6);
-	if (!addr)
-		goto out;
-
-	spin_lock_bh(&card->ip_lock);
-
-	list_for_each_entry(ifa, &in6_dev->addr_list, if_list) {
-		memcpy(&addr->u.a6.addr, &ifa->addr,
-		       sizeof(struct in6_addr));
-		addr->u.a6.pfxlen = ifa->prefix_len;
-		addr->type = QETH_IP_TYPE_NORMAL;
-		qeth_l3_delete_ip(card, addr);
-	}
-
-	spin_unlock_bh(&card->ip_lock);
-
-	kfree(addr);
-out:
-	in6_dev_put(in6_dev);
-}
-
-static void qeth_l3_free_vlan_addresses(struct qeth_card *card,
-			unsigned short vid)
-{
-	rcu_read_lock();
-	qeth_l3_free_vlan_addresses4(card, vid);
-	qeth_l3_free_vlan_addresses6(card, vid);
-	rcu_read_unlock();
-}
-
 static int qeth_l3_vlan_rx_add_vid(struct net_device *dev,
 				   __be16 proto, u16 vid)
 {
@@ -1398,8 +1313,6 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 		QETH_CARD_TEXT(card, 3, "kidREC");
 		return 0;
 	}
-	/* unregister IP addresses of vlan device */
-	qeth_l3_free_vlan_addresses(card, vid);
 	clear_bit(vid, card->active_vlans);
 	qeth_l3_set_rx_mode(dev);
 	return 0;
-- 
2.13.5
