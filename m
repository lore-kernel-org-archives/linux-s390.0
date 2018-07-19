From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/11] s390/qeth: allocate netdevice early
Date: Thu, 19 Jul 2018 12:43:51 +0200
Message-ID: <20180719104358.79696-5-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Allocation of the netdevice is currently delayed until a qeth card first
goes online. This complicates matters in several places, where we need
to cache values instead of applying them straight to the netdevice.

Improve on this by moving the allocation up to where the qeth card
itself is created. This is also one step in direction of eventually
placing the qeth card into netdev_priv().

In all subsequent code, remove the now redundant checks whether
card->dev is valid.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 61 ++++++++++++++++++++++++++++++++-------
 drivers/s390/net/qeth_core_sys.c  | 14 +++++++--
 drivers/s390/net/qeth_l2_main.c   | 52 +++++++++------------------------
 drivers/s390/net/qeth_l3_main.c   | 48 ++++++++++--------------------
 drivers/s390/net/qeth_l3_sys.c    |  6 ++--
 6 files changed, 94 insertions(+), 88 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index a932aac62d0e..4d6827c8aba4 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -966,6 +966,7 @@ extern struct qeth_card_list_struct qeth_core_card_list;
 extern struct kmem_cache *qeth_core_header_cache;
 extern struct qeth_dbf_info qeth_dbf[QETH_DBF_INFOS];
 
+struct net_device *qeth_clone_netdev(struct net_device *orig);
 void qeth_set_recovery_task(struct qeth_card *);
 void qeth_clear_recovery_task(struct qeth_card *);
 void qeth_set_allowed_threads(struct qeth_card *, unsigned long , int);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7c3b643550f6..6df2226417f1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -653,8 +653,7 @@ static struct qeth_ipa_cmd *qeth_check_ipa_data(struct qeth_card *card,
 						cmd->hdr.return_code, card);
 				}
 				card->lan_online = 0;
-				if (card->dev)
-					netif_carrier_off(card->dev);
+				netif_carrier_off(card->dev);
 				return NULL;
 			case IPA_CMD_STARTLAN:
 				dev_info(&card->gdev->dev,
@@ -2350,9 +2349,8 @@ static int qeth_ulp_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 		}
 		if (card->info.initial_mtu && (card->info.initial_mtu != mtu)) {
 			/* frame size has changed */
-			if (card->dev &&
-			    ((card->dev->mtu == card->info.initial_mtu) ||
-			     (card->dev->mtu > mtu)))
+			if ((card->dev->mtu == card->info.initial_mtu) ||
+			    (card->dev->mtu > mtu))
 				card->dev->mtu = mtu;
 			qeth_free_qdio_buffers(card);
 		}
@@ -3578,7 +3576,7 @@ static void qeth_qdio_start_poll(struct ccw_device *ccwdev, int queue,
 {
 	struct qeth_card *card = (struct qeth_card *)card_ptr;
 
-	if (card->dev && (card->dev->flags & IFF_UP))
+	if (card->dev->flags & IFF_UP)
 		napi_schedule(&card->napi);
 }
 
@@ -4794,9 +4792,6 @@ int qeth_vm_request_mac(struct qeth_card *card)
 
 	QETH_DBF_TEXT(SETUP, 2, "vmreqmac");
 
-	if (!card->dev)
-		return -ENODEV;
-
 	request = kzalloc(sizeof(*request), GFP_KERNEL | GFP_DMA);
 	response = kzalloc(sizeof(*response), GFP_KERNEL | GFP_DMA);
 	if (!request || !response) {
@@ -5676,6 +5671,44 @@ static void qeth_clear_dbf_list(void)
 	mutex_unlock(&qeth_dbf_list_mutex);
 }
 
+static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
+{
+	struct net_device *dev;
+
+	switch (card->info.type) {
+	case QETH_CARD_TYPE_IQD:
+		dev = alloc_netdev(0, "hsi%d", NET_NAME_UNKNOWN, ether_setup);
+		break;
+	case QETH_CARD_TYPE_OSN:
+		dev = alloc_netdev(0, "osn%d", NET_NAME_UNKNOWN, ether_setup);
+		break;
+	default:
+		dev = alloc_etherdev(0);
+	}
+
+	if (!dev)
+		return NULL;
+
+	dev->ml_priv = card;
+	dev->watchdog_timeo = QETH_TX_TIMEOUT;
+	dev->min_mtu = 64;
+	dev->max_mtu = ETH_MAX_MTU;
+	SET_NETDEV_DEV(dev, &card->gdev->dev);
+	netif_carrier_off(dev);
+	return dev;
+}
+
+struct net_device *qeth_clone_netdev(struct net_device *orig)
+{
+	struct net_device *clone = qeth_alloc_netdev(orig->ml_priv);
+
+	if (!clone)
+		return NULL;
+
+	clone->dev_port = orig->dev_port;
+	return clone;
+}
+
 static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card;
@@ -5725,6 +5758,10 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 		goto err_card;
 	}
 
+	card->dev = qeth_alloc_netdev(card);
+	if (!card->dev)
+		goto err_card;
+
 	qeth_determine_capabilities(card);
 	enforced_disc = qeth_enforce_discipline(card);
 	switch (enforced_disc) {
@@ -5735,7 +5772,7 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 		card->info.layer_enforced = true;
 		rc = qeth_core_load_discipline(card, enforced_disc);
 		if (rc)
-			goto err_card;
+			goto err_load;
 
 		gdev->dev.type = (card->info.type != QETH_CARD_TYPE_OSN)
 					? card->discipline->devtype
@@ -5753,6 +5790,8 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 
 err_disc:
 	qeth_core_free_discipline(card);
+err_load:
+	free_netdev(card->dev);
 err_card:
 	qeth_core_free_card(card);
 err_dev:
@@ -5775,10 +5814,10 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 	write_lock_irqsave(&qeth_core_card_list.rwlock, flags);
 	list_del(&card->list);
 	write_unlock_irqrestore(&qeth_core_card_list.rwlock, flags);
+	free_netdev(card->dev);
 	qeth_core_free_card(card);
 	dev_set_drvdata(&gdev->dev, NULL);
 	put_device(&gdev->dev);
-	return;
 }
 
 static int qeth_core_set_online(struct ccwgroup_device *gdev)
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index cfb659747693..9bef19ed7e04 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -144,8 +144,7 @@ static ssize_t qeth_dev_portno_store(struct device *dev,
 		goto out;
 	}
 	card->info.portno = portno;
-	if (card->dev)
-		card->dev->dev_port = portno;
+	card->dev->dev_port = portno;
 out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
@@ -388,6 +387,7 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
+	struct net_device *ndev;
 	char *tmp;
 	int i, rc = 0;
 	enum qeth_discipline_id newdis;
@@ -424,9 +424,19 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 
 	card->info.mac_bits = 0;
 	if (card->discipline) {
+		/* start with a new, pristine netdevice: */
+		ndev = qeth_clone_netdev(card->dev);
+		if (!ndev) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
 		card->discipline->remove(card->gdev);
 		qeth_core_free_discipline(card);
 		card->options.layer2 = -1;
+
+		free_netdev(card->dev);
+		card->dev = ndev;
 	}
 
 	rc = qeth_core_load_discipline(card, newdis);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 089bde458fd5..8392fc7e809c 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -899,13 +899,7 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l2_set_offline(cgdev);
-
-	if (card->dev) {
-		unregister_netdev(card->dev);
-		free_netdev(card->dev);
-		card->dev = NULL;
-	}
-	return;
+	unregister_netdev(card->dev);
 }
 
 static const struct ethtool_ops qeth_l2_ethtool_ops = {
@@ -944,29 +938,13 @@ static const struct net_device_ops qeth_l2_netdev_ops = {
 
 static int qeth_l2_setup_netdev(struct qeth_card *card)
 {
-	switch (card->info.type) {
-	case QETH_CARD_TYPE_IQD:
-		card->dev = alloc_netdev(0, "hsi%d", NET_NAME_UNKNOWN,
-					 ether_setup);
-		break;
-	case QETH_CARD_TYPE_OSN:
-		card->dev = alloc_netdev(0, "osn%d", NET_NAME_UNKNOWN,
-					 ether_setup);
-		break;
-	default:
-		card->dev = alloc_etherdev(0);
-	}
+	int rc;
 
-	if (!card->dev)
-		return -ENODEV;
+	if (card->dev->netdev_ops)
+		return 0;
 
-	card->dev->ml_priv = card;
 	card->dev->priv_flags |= IFF_UNICAST_FLT;
-	card->dev->watchdog_timeo = QETH_TX_TIMEOUT;
 	card->dev->mtu = card->info.initial_mtu;
-	card->dev->min_mtu = 64;
-	card->dev->max_mtu = ETH_MAX_MTU;
-	card->dev->dev_port = card->info.portno;
 	card->dev->netdev_ops = &qeth_l2_netdev_ops;
 	if (card->info.type == QETH_CARD_TYPE_OSN) {
 		card->dev->ethtool_ops = &qeth_l2_osn_ops;
@@ -1006,12 +984,12 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 		card->dev->vlan_features |= NETIF_F_RXCSUM;
 	}
 
-	card->info.broadcast_capable = 1;
 	qeth_l2_request_initial_mac(card);
-	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
-	netif_carrier_off(card->dev);
-	return register_netdev(card->dev);
+	rc = register_netdev(card->dev);
+	if (rc)
+		card->dev->netdev_ops = NULL;
+	return rc;
 }
 
 static int qeth_l2_start_ipassists(struct qeth_card *card)
@@ -1057,10 +1035,9 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		dev_info(&card->gdev->dev,
 		"The device represents a Bridge Capable Port\n");
 
-	if (!card->dev && qeth_l2_setup_netdev(card)) {
-		rc = -ENODEV;
+	rc = qeth_l2_setup_netdev(card);
+	if (rc)
 		goto out_remove;
-	}
 
 	if (card->info.type != QETH_CARD_TYPE_OSN &&
 	    !qeth_l2_send_setmac(card, card->dev->dev_addr))
@@ -1163,8 +1140,7 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
-	if (card->dev)
-		netif_carrier_off(card->dev);
+	netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
 		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
@@ -1237,8 +1213,7 @@ static int qeth_l2_pm_suspend(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 
-	if (card->dev)
-		netif_device_detach(card->dev);
+	netif_device_detach(card->dev);
 	qeth_set_allowed_threads(card, 0, 1);
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
 	if (gdev->state == CCWGROUP_OFFLINE)
@@ -1271,8 +1246,7 @@ static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
 		rc = __qeth_l2_set_online(card->gdev, 0);
 out:
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
-	if (card->dev)
-		netif_device_attach(card->dev);
+	netif_device_attach(card->dev);
 	if (rc)
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 			"failed to recover an error on the device\n");
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ee99af08b2c4..72c8f323801b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2536,6 +2536,9 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 {
 	int rc;
 
+	if (card->dev->netdev_ops)
+		return 0;
+
 	if (card->info.type == QETH_CARD_TYPE_OSD ||
 	    card->info.type == QETH_CARD_TYPE_OSX) {
 		if ((card->info.link_type == QETH_LINK_TYPE_LANE_TR) ||
@@ -2544,9 +2547,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 			return -ENODEV;
 		}
 
-		card->dev = alloc_etherdev(0);
-		if (!card->dev)
-			return -ENODEV;
 		card->dev->netdev_ops = &qeth_l3_osa_netdev_ops;
 
 		/*IPv6 address autoconfiguration stuff*/
@@ -2567,27 +2567,19 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 			card->dev->vlan_features |= NETIF_F_IPV6_CSUM;
 		}
 	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
-		card->dev = alloc_netdev(0, "hsi%d", NET_NAME_UNKNOWN,
-					 ether_setup);
-		if (!card->dev)
-			return -ENODEV;
 		card->dev->flags |= IFF_NOARP;
 		card->dev->netdev_ops = &qeth_l3_netdev_ops;
 
 		rc = qeth_l3_iqd_read_initial_mac(card);
 		if (rc)
-			return rc;
+			goto out;
+
 		if (card->options.hsuid[0])
 			memcpy(card->dev->perm_addr, card->options.hsuid, 9);
 	} else
 		return -ENODEV;
 
-	card->dev->ml_priv = card;
-	card->dev->watchdog_timeo = QETH_TX_TIMEOUT;
 	card->dev->mtu = card->info.initial_mtu;
-	card->dev->min_mtu = 64;
-	card->dev->max_mtu = ETH_MAX_MTU;
-	card->dev->dev_port = card->info.portno;
 	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
 	card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
@@ -2602,10 +2594,12 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 		netif_set_gso_max_size(card->dev,
 				       PAGE_SIZE * (QETH_MAX_BUFFER_ELEMENTS(card) - 1));
 
-	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
-	netif_carrier_off(card->dev);
-	return register_netdev(card->dev);
+	rc = register_netdev(card->dev);
+out:
+	if (rc)
+		card->dev->netdev_ops = NULL;
+	return rc;
 }
 
 static const struct device_type qeth_l3_devtype = {
@@ -2643,15 +2637,9 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l3_set_offline(cgdev);
 
-	if (card->dev) {
-		unregister_netdev(card->dev);
-		free_netdev(card->dev);
-		card->dev = NULL;
-	}
-
+	unregister_netdev(card->dev);
 	qeth_l3_clear_ip_htable(card, 0);
 	qeth_l3_clear_ipato_list(card);
-	return;
 }
 
 static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
@@ -2673,10 +2661,9 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		goto out_remove;
 	}
 
-	if (!card->dev && qeth_l3_setup_netdev(card)) {
-		rc = -ENODEV;
+	rc = qeth_l3_setup_netdev(card);
+	if (rc)
 		goto out_remove;
-	}
 
 	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
 		if (card->info.hwtrap &&
@@ -2773,8 +2760,7 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
-	if (card->dev)
-		netif_carrier_off(card->dev);
+	netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
 		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
@@ -2842,8 +2828,7 @@ static int qeth_l3_pm_suspend(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 
-	if (card->dev)
-		netif_device_detach(card->dev);
+	netif_device_detach(card->dev);
 	qeth_set_allowed_threads(card, 0, 1);
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
 	if (gdev->state == CCWGROUP_OFFLINE)
@@ -2876,8 +2861,7 @@ static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
 		rc = __qeth_l3_set_online(card->gdev, 0);
 out:
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
-	if (card->dev)
-		netif_device_attach(card->dev);
+	netif_device_attach(card->dev);
 	if (rc)
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 			"failed to recover an error on the device\n");
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index f61192a048f4..45ac6d8705c6 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -299,8 +299,7 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 	if (strlen(tmp) == 0) {
 		/* delete ip address only */
 		card->options.hsuid[0] = '\0';
-		if (card->dev)
-			memcpy(card->dev->perm_addr, card->options.hsuid, 9);
+		memcpy(card->dev->perm_addr, card->options.hsuid, 9);
 		qeth_configure_cq(card, QETH_CQ_DISABLED);
 		return count;
 	}
@@ -311,8 +310,7 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 	snprintf(card->options.hsuid, sizeof(card->options.hsuid),
 		 "%-8s", tmp);
 	ASCEBC(card->options.hsuid, 8);
-	if (card->dev)
-		memcpy(card->dev->perm_addr, card->options.hsuid, 9);
+	memcpy(card->dev->perm_addr, card->options.hsuid, 9);
 
 	rc = qeth_l3_modify_hsuid(card, true);
 
-- 
2.16.4
