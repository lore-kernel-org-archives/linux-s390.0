From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 08/15] s390/qeth: align L2 and L3 set_rx_mode() implementations
Date: Wed, 20 Dec 2017 20:11:02 +0100
Message-ID: <20171220191109.90487-9-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Once all of qeth_l3_set_rx_mode()'s single-use helpers are folded back
in, the two implementations actually look quite similar. So improve the
readability by converting both set_rx_mode() routines to a common
format.

This also allows us to walk ip_mc_htable just once, instead of three
times.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 16 ++++---
 drivers/s390/net/qeth_l3_main.c | 94 +++++++++++++++--------------------------
 2 files changed, 43 insertions(+), 67 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7c635abc79d2..7f236440483f 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -627,20 +627,24 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 		qeth_l2_add_mac(card, ha);
 
 	hash_for_each_safe(card->mac_htable, i, tmp, mac, hnode) {
-		if (mac->disp_flag == QETH_DISP_ADDR_DELETE) {
+		switch (mac->disp_flag) {
+		case QETH_DISP_ADDR_DELETE:
 			qeth_l2_remove_mac(card, mac->mac_addr);
 			hash_del(&mac->hnode);
 			kfree(mac);
-
-		} else if (mac->disp_flag == QETH_DISP_ADDR_ADD) {
+			break;
+		case QETH_DISP_ADDR_ADD:
 			rc = qeth_l2_write_mac(card, mac->mac_addr);
 			if (rc) {
 				hash_del(&mac->hnode);
 				kfree(mac);
-			} else
-				mac->disp_flag = QETH_DISP_ADDR_DELETE;
-		} else
+				break;
+			}
+			/* fall through */
+		default:
+			/* for next call to set_rx_mode(): */
 			mac->disp_flag = QETH_DISP_ADDR_DELETE;
+		}
 	}
 
 	spin_unlock_bh(&card->mclock);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 519042d6f94a..64347ee116c8 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -37,7 +37,7 @@
 
 static int qeth_l3_set_offline(struct ccwgroup_device *);
 static int qeth_l3_stop(struct net_device *);
-static void qeth_l3_set_multicast_list(struct net_device *);
+static void qeth_l3_set_rx_mode(struct net_device *dev);
 static int qeth_l3_register_addr_entry(struct qeth_card *,
 		struct qeth_ipaddr *);
 static int qeth_l3_deregister_addr_entry(struct qeth_card *,
@@ -1317,56 +1317,6 @@ qeth_diags_trace(struct qeth_card *card, enum qeth_diags_trace_cmds diags_cmd)
 	return qeth_send_ipa_cmd(card, iob, qeth_diags_trace_cb, NULL);
 }
 
-static void qeth_l3_mark_all_mc_to_be_deleted(struct qeth_card *card)
-{
-	struct qeth_ipaddr *addr;
-	int i;
-
-	hash_for_each(card->ip_mc_htable, i, addr, hnode)
-		addr->disp_flag = QETH_DISP_ADDR_DELETE;
-
-}
-
-static void qeth_l3_add_all_new_mc(struct qeth_card *card)
-{
-	struct qeth_ipaddr *addr;
-	struct hlist_node *tmp;
-	int i;
-	int rc;
-
-	hash_for_each_safe(card->ip_mc_htable, i, tmp, addr, hnode) {
-		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
-			rc = qeth_l3_register_addr_entry(card, addr);
-			if (!rc || (rc == IPA_RC_LAN_OFFLINE))
-				addr->ref_counter = 1;
-			else {
-				hash_del(&addr->hnode);
-				kfree(addr);
-			}
-		}
-	}
-
-}
-
-static void qeth_l3_delete_nonused_mc(struct qeth_card *card)
-{
-	struct qeth_ipaddr *addr;
-	struct hlist_node *tmp;
-	int i;
-	int rc;
-
-	hash_for_each_safe(card->ip_mc_htable, i, tmp, addr, hnode) {
-		if (addr->disp_flag == QETH_DISP_ADDR_DELETE) {
-			rc = qeth_l3_deregister_addr_entry(card, addr);
-			if (!rc || (rc == IPA_RC_MC_ADDR_NOT_FOUND)) {
-				hash_del(&addr->hnode);
-				kfree(addr);
-			}
-		}
-	}
-
-}
-
 static void
 qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 {
@@ -1645,7 +1595,7 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 	/* unregister IP addresses of vlan device */
 	qeth_l3_free_vlan_addresses(card, vid);
 	clear_bit(vid, card->active_vlans);
-	qeth_l3_set_multicast_list(card->dev);
+	qeth_l3_set_rx_mode(dev);
 	return 0;
 }
 
@@ -1908,24 +1858,46 @@ qeth_l3_handle_promisc_mode(struct qeth_card *card)
 	}
 }
 
-static void qeth_l3_set_multicast_list(struct net_device *dev)
+static void qeth_l3_set_rx_mode(struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
+	struct qeth_ipaddr *addr;
+	struct hlist_node *tmp;
+	int i, rc;
 
 	QETH_CARD_TEXT(card, 3, "setmulti");
 	if (qeth_threads_running(card, QETH_RECOVER_THREAD) &&
 	    (card->state != CARD_STATE_UP))
 		return;
 	if (!card->options.sniffer) {
-
 		spin_lock_bh(&card->mclock);
 
-		qeth_l3_mark_all_mc_to_be_deleted(card);
-
 		qeth_l3_add_multicast_ipv4(card);
 		qeth_l3_add_multicast_ipv6(card);
-		qeth_l3_delete_nonused_mc(card);
-		qeth_l3_add_all_new_mc(card);
+
+		hash_for_each_safe(card->ip_mc_htable, i, tmp, addr, hnode) {
+			switch (addr->disp_flag) {
+			case QETH_DISP_ADDR_DELETE:
+				rc = qeth_l3_deregister_addr_entry(card, addr);
+				if (!rc || rc == IPA_RC_MC_ADDR_NOT_FOUND) {
+					hash_del(&addr->hnode);
+					kfree(addr);
+				}
+				break;
+			case QETH_DISP_ADDR_ADD:
+				rc = qeth_l3_register_addr_entry(card, addr);
+				if (rc && rc != IPA_RC_LAN_OFFLINE) {
+					hash_del(&addr->hnode);
+					kfree(addr);
+					break;
+				}
+				addr->ref_counter = 1;
+				/* fall through */
+			default:
+				/* for next call to set_rx_mode(): */
+				addr->disp_flag = QETH_DISP_ADDR_DELETE;
+			}
+		}
 
 		spin_unlock_bh(&card->mclock);
 
@@ -2885,7 +2857,7 @@ static const struct net_device_ops qeth_l3_netdev_ops = {
 	.ndo_get_stats		= qeth_get_stats,
 	.ndo_start_xmit		= qeth_l3_hard_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= qeth_l3_set_multicast_list,
+	.ndo_set_rx_mode	= qeth_l3_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
 	.ndo_change_mtu		= qeth_change_mtu,
 	.ndo_fix_features	= qeth_fix_features,
@@ -2902,7 +2874,7 @@ static const struct net_device_ops qeth_l3_osa_netdev_ops = {
 	.ndo_start_xmit		= qeth_l3_hard_start_xmit,
 	.ndo_features_check	= qeth_features_check,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= qeth_l3_set_multicast_list,
+	.ndo_set_rx_mode	= qeth_l3_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
 	.ndo_change_mtu		= qeth_change_mtu,
 	.ndo_fix_features	= qeth_fix_features,
@@ -3100,7 +3072,7 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 			__qeth_l3_open(card->dev);
 		else
 			dev_open(card->dev);
-		qeth_l3_set_multicast_list(card->dev);
+		qeth_l3_set_rx_mode(card->dev);
 		qeth_recover_features(card->dev);
 		rtnl_unlock();
 	}
-- 
2.13.5
