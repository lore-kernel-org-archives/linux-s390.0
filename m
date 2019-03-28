Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/10] s390/qeth: defer RX modesetting
Date: Thu, 28 Mar 2019 16:39:19 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

.ndo_set_rx_mode gets called in process context, but while holding the
addr_list spinlock. Which means we currently can't sleep while
re-programming the HW, and need to poll for IO completion. That's bad,
in particular since receiving the cmd response can fail silently and
we're then polling until the timeout hits.

As a first step towards eliminating the IO completion polling, run the
RX modeset from a work element and only take the addr_list lock while
updating the RX mode address cache.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  1 +
 drivers/s390/net/qeth_l2_main.c | 22 +++++++++++++++++----
 drivers/s390/net/qeth_l3_main.c | 42 ++++++++++++++++++++++++++++-------------
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c851cf6e01c4..c3cf992ca985 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -780,6 +780,7 @@ struct qeth_card {
 	DECLARE_HASHTABLE(mac_htable, 4);
 	DECLARE_HASHTABLE(ip_htable, 4);
 	DECLARE_HASHTABLE(ip_mc_htable, 4);
+	struct work_struct rx_mode_work;
 	struct work_struct kernel_thread_starter;
 	spinlock_t thread_mask_lock;
 	unsigned long thread_start_mask;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c3067fd3bd9e..437a399d5557 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -149,7 +149,7 @@ static int qeth_l2_remove_mac(struct qeth_card *card, u8 *mac)
 	return rc;
 }
 
-static void qeth_l2_del_all_macs(struct qeth_card *card)
+static void qeth_l2_drain_rx_mode_cache(struct qeth_card *card)
 {
 	struct qeth_mac *mac;
 	struct hlist_node *tmp;
@@ -292,8 +292,10 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 
 	qeth_set_allowed_threads(card, 0, 1);
 
+	cancel_work_sync(&card->rx_mode_work);
+	qeth_l2_drain_rx_mode_cache(card);
+
 	if (card->state == CARD_STATE_SOFTSETUP) {
-		qeth_l2_del_all_macs(card);
 		qeth_clear_ipacmd_list(card);
 		card->state = CARD_STATE_HARDSETUP;
 	}
@@ -515,9 +517,11 @@ static void qeth_l2_add_mac(struct qeth_card *card, struct netdev_hw_addr *ha)
 	hash_add(card->mac_htable, &mac->hnode, mac_hash);
 }
 
-static void qeth_l2_set_rx_mode(struct net_device *dev)
+static void qeth_l2_rx_mode_work(struct work_struct *work)
 {
-	struct qeth_card *card = dev->ml_priv;
+	struct qeth_card *card = container_of(work, struct qeth_card,
+					      rx_mode_work);
+	struct net_device *dev = card->dev;
 	struct netdev_hw_addr *ha;
 	struct qeth_mac *mac;
 	struct hlist_node *tmp;
@@ -528,10 +532,12 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 
 	spin_lock_bh(&card->mclock);
 
+	netif_addr_lock_bh(dev);
 	netdev_for_each_mc_addr(ha, dev)
 		qeth_l2_add_mac(card, ha);
 	netdev_for_each_uc_addr(ha, dev)
 		qeth_l2_add_mac(card, ha);
+	netif_addr_unlock_bh(dev);
 
 	hash_for_each_safe(card->mac_htable, i, tmp, mac, hnode) {
 		switch (mac->disp_flag) {
@@ -653,6 +659,7 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	}
 
 	hash_init(card->mac_htable);
+	INIT_WORK(&card->rx_mode_work, qeth_l2_rx_mode_work);
 	return 0;
 }
 
@@ -673,6 +680,13 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 		unregister_netdev(card->dev);
 }
 
+static void qeth_l2_set_rx_mode(struct net_device *dev)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	schedule_work(&card->rx_mode_work);
+}
+
 static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_open		= qeth_open,
 	.ndo_stop		= qeth_stop,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 53712cf26406..b6df38f092e6 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -268,6 +268,20 @@ static int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 	return rc;
 }
 
+static void qeth_l3_drain_rx_mode_cache(struct qeth_card *card)
+{
+	struct qeth_ipaddr *addr;
+	struct hlist_node *tmp;
+	int i;
+
+	spin_lock_bh(&card->mclock);
+	hash_for_each_safe(card->ip_mc_htable, i, tmp, addr, hnode) {
+		hash_del(&addr->hnode);
+		kfree(addr);
+	}
+	spin_unlock_bh(&card->mclock);
+}
+
 static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 {
 	struct qeth_ipaddr *addr;
@@ -288,18 +302,8 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 	}
 
 	spin_unlock_bh(&card->ip_lock);
-
-	spin_lock_bh(&card->mclock);
-
-	hash_for_each_safe(card->ip_mc_htable, i, tmp, addr, hnode) {
-		hash_del(&addr->hnode);
-		kfree(addr);
-	}
-
-	spin_unlock_bh(&card->mclock);
-
-
 }
+
 static void qeth_l3_recover_ip(struct qeth_card *card)
 {
 	struct qeth_ipaddr *addr;
@@ -1413,6 +1417,9 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 
 	qeth_set_allowed_threads(card, 0, 1);
 
+	cancel_work_sync(&card->rx_mode_work);
+	qeth_l3_drain_rx_mode_cache(card);
+
 	if (card->options.sniffer &&
 	    (card->info.promisc_mode == SET_PROMISC_MODE_ON))
 		qeth_diags_trace(card, QETH_DIAGS_CMD_TRACE_DISABLE);
@@ -1466,9 +1473,10 @@ qeth_l3_handle_promisc_mode(struct qeth_card *card)
 	}
 }
 
-static void qeth_l3_set_rx_mode(struct net_device *dev)
+static void qeth_l3_rx_mode_work(struct work_struct *work)
 {
-	struct qeth_card *card = dev->ml_priv;
+	struct qeth_card *card = container_of(work, struct qeth_card,
+					      rx_mode_work);
 	struct qeth_ipaddr *addr;
 	struct hlist_node *tmp;
 	int i, rc;
@@ -2101,6 +2109,13 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static void qeth_l3_set_rx_mode(struct net_device *dev)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	schedule_work(&card->rx_mode_work);
+}
+
 /*
  * we need NOARP for IPv4 but we want neighbor solicitation for IPv6. Setting
  * NOARP on the netdevice is no option because it also turns off neighbor
@@ -2261,6 +2276,7 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	}
 
 	hash_init(card->ip_mc_htable);
+	INIT_WORK(&card->rx_mode_work, qeth_l3_rx_mode_work);
 	return 0;
 }
 
-- 
2.16.4
