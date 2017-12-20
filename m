From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 04/15] s390/qeth: drop CONFIG_QETH_IPV6
Date: Wed, 20 Dec 2017 20:10:58 +0100
Message-ID: <20171220191109.90487-5-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit "s390/qeth: use ip*_eth_mc_map helpers" removed the last
occurrence of CONFIG_IPV6-dependent code.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/Kconfig        |  3 ---
 drivers/s390/net/qeth_l3_main.c | 60 +++++++----------------------------------
 2 files changed, 9 insertions(+), 54 deletions(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index a782a207ad31..c7e484f70654 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -91,9 +91,6 @@ config QETH_L3
 	  To compile as a module choose M. The module name is qeth_l3.
 	  If unsure, choose Y.
 
-config QETH_IPV6
-	def_bool y if (QETH_L3 = IPV6) || (QETH_L3 && IPV6 = 'y')
-
 config CCWGROUP
 	tristate
 	default (LCS || CTCM || QETH)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index aeff11ad1de5..0404d5c61ad7 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -582,7 +582,6 @@ int qeth_l3_setrouting_v6(struct qeth_card *card)
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 3, "setrtg6");
-#ifdef CONFIG_QETH_IPV6
 
 	if (!qeth_is_supported(card, IPA_IPV6))
 		return 0;
@@ -599,7 +598,6 @@ int qeth_l3_setrouting_v6(struct qeth_card *card)
 			" on %s. Type set to 'no router'.\n", rc,
 			QETH_CARD_IFNAME(card));
 	}
-#endif
 	return rc;
 }
 
@@ -933,7 +931,6 @@ static int qeth_l3_setadapter_parms(struct qeth_card *card)
 	return rc;
 }
 
-#ifdef CONFIG_QETH_IPV6
 static int qeth_l3_send_simple_setassparms_ipv6(struct qeth_card *card,
 		enum qeth_ipa_funcs ipa_func, __u16 cmd_code)
 {
@@ -949,7 +946,6 @@ static int qeth_l3_send_simple_setassparms_ipv6(struct qeth_card *card,
 				   qeth_setassparms_cb, NULL);
 	return rc;
 }
-#endif
 
 static int qeth_l3_start_ipa_arp_processing(struct qeth_card *card)
 {
@@ -1045,7 +1041,6 @@ static int qeth_l3_start_ipa_multicast(struct qeth_card *card)
 	return rc;
 }
 
-#ifdef CONFIG_QETH_IPV6
 static int qeth_l3_softsetup_ipv6(struct qeth_card *card)
 {
 	int rc;
@@ -1091,12 +1086,9 @@ static int qeth_l3_softsetup_ipv6(struct qeth_card *card)
 	dev_info(&card->gdev->dev, "IPV6 enabled\n");
 	return 0;
 }
-#endif
 
 static int qeth_l3_start_ipa_ipv6(struct qeth_card *card)
 {
-	int rc = 0;
-
 	QETH_CARD_TEXT(card, 3, "strtipv6");
 
 	if (!qeth_is_supported(card, IPA_IPV6)) {
@@ -1104,10 +1096,7 @@ static int qeth_l3_start_ipa_ipv6(struct qeth_card *card)
 			"IPv6 not supported on %s\n", QETH_CARD_IFNAME(card));
 		return 0;
 	}
-#ifdef CONFIG_QETH_IPV6
-	rc = qeth_l3_softsetup_ipv6(card);
-#endif
-	return rc ;
+	return qeth_l3_softsetup_ipv6(card);
 }
 
 static int qeth_l3_start_ipa_broadcast(struct qeth_card *card)
@@ -1457,9 +1446,8 @@ static void qeth_l3_add_multicast_ipv4(struct qeth_card *card)
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_QETH_IPV6
-static void
-qeth_l3_add_mc6_to_hash(struct qeth_card *card, struct inet6_dev *in6_dev)
+static void qeth_l3_add_mc6_to_hash(struct qeth_card *card,
+				    struct inet6_dev *in6_dev)
 {
 	struct qeth_ipaddr *ipm;
 	struct ifmcaddr6 *im6;
@@ -1548,7 +1536,6 @@ static void qeth_l3_add_multicast_ipv6(struct qeth_card *card)
 	rcu_read_unlock();
 	in6_dev_put(in6_dev);
 }
-#endif /* CONFIG_QETH_IPV6 */
 
 static void qeth_l3_free_vlan_addresses4(struct qeth_card *card,
 			unsigned short vid)
@@ -1588,9 +1575,8 @@ static void qeth_l3_free_vlan_addresses4(struct qeth_card *card,
 }
 
 static void qeth_l3_free_vlan_addresses6(struct qeth_card *card,
-			unsigned short vid)
+					 unsigned short vid)
 {
-#ifdef CONFIG_QETH_IPV6
 	struct inet6_dev *in6_dev;
 	struct inet6_ifaddr *ifa;
 	struct qeth_ipaddr *addr;
@@ -1625,7 +1611,6 @@ static void qeth_l3_free_vlan_addresses6(struct qeth_card *card,
 	kfree(addr);
 out:
 	in6_dev_put(in6_dev);
-#endif /* CONFIG_QETH_IPV6 */
 }
 
 static void qeth_l3_free_vlan_addresses(struct qeth_card *card,
@@ -1676,19 +1661,11 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 		skb_reset_network_header(skb);
 		switch (hdr->hdr.l3.flags & QETH_HDR_CAST_MASK) {
 		case QETH_CAST_MULTICAST:
-			switch (prot) {
-#ifdef CONFIG_QETH_IPV6
-			case ETH_P_IPV6:
-				ipv6_eth_mc_map(&ipv6_hdr(skb)->daddr, tg_addr);
-				break;
-#endif
-			case ETH_P_IP:
+			if (prot == ETH_P_IP)
 				ip_eth_mc_map(ip_hdr(skb)->daddr, tg_addr);
-				break;
-			default:
-				memcpy(tg_addr, card->dev->broadcast,
-					card->dev->addr_len);
-			}
+			else
+				ipv6_eth_mc_map(&ipv6_hdr(skb)->daddr, tg_addr);
+
 			card->stats.multicast++;
 			skb->pkt_type = PACKET_MULTICAST;
 			break;
@@ -1949,9 +1926,7 @@ static void qeth_l3_set_multicast_list(struct net_device *dev)
 		qeth_l3_mark_all_mc_to_be_deleted(card);
 
 		qeth_l3_add_multicast_ipv4(card);
-#ifdef CONFIG_QETH_IPV6
 		qeth_l3_add_multicast_ipv6(card);
-#endif
 		qeth_l3_delete_nonused_mc(card);
 		qeth_l3_add_all_new_mc(card);
 
@@ -2222,12 +2197,10 @@ static int qeth_l3_arp_query(struct qeth_card *card, char __user *udata)
 			rc = -EFAULT;
 		goto free_and_out;
 	}
-#ifdef CONFIG_QETH_IPV6
 	if (qinfo.mask_bits & QETH_QARP_WITH_IPV6) {
 		/* fails in case of GuestLAN QDIO mode */
 		qeth_l3_query_arp_cache_info(card, QETH_PROT_IPV6, &qinfo);
 	}
-#endif
 	if (copy_to_user(udata, qinfo.udata, qinfo.udata_len)) {
 		QETH_CARD_TEXT(card, 4, "qactf");
 		rc = -EFAULT;
@@ -3356,10 +3329,6 @@ static struct notifier_block qeth_l3_ip_notifier = {
 	NULL,
 };
 
-#ifdef CONFIG_QETH_IPV6
-/**
- * IPv6 event handler
- */
 static int qeth_l3_ip6_event(struct notifier_block *this,
 			     unsigned long event, void *ptr)
 {
@@ -3404,7 +3373,6 @@ static struct notifier_block qeth_l3_ip6_notifier = {
 	qeth_l3_ip6_event,
 	NULL,
 };
-#endif
 
 static int qeth_l3_register_notifiers(void)
 {
@@ -3414,35 +3382,25 @@ static int qeth_l3_register_notifiers(void)
 	rc = register_inetaddr_notifier(&qeth_l3_ip_notifier);
 	if (rc)
 		return rc;
-#ifdef CONFIG_QETH_IPV6
 	rc = register_inet6addr_notifier(&qeth_l3_ip6_notifier);
 	if (rc) {
 		unregister_inetaddr_notifier(&qeth_l3_ip_notifier);
 		return rc;
 	}
-#else
-	pr_warn("There is no IPv6 support for the layer 3 discipline\n");
-#endif
 	return 0;
 }
 
 static void qeth_l3_unregister_notifiers(void)
 {
-
 	QETH_DBF_TEXT(SETUP, 5, "unregnot");
 	WARN_ON(unregister_inetaddr_notifier(&qeth_l3_ip_notifier));
-#ifdef CONFIG_QETH_IPV6
 	WARN_ON(unregister_inet6addr_notifier(&qeth_l3_ip6_notifier));
-#endif /* QETH_IPV6 */
 }
 
 static int __init qeth_l3_init(void)
 {
-	int rc = 0;
-
 	pr_info("register layer 3 discipline\n");
-	rc = qeth_l3_register_notifiers();
-	return rc;
+	return qeth_l3_register_notifiers();
 }
 
 static void __exit qeth_l3_exit(void)
-- 
2.13.5
