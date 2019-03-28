Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/10] s390/qeth: remove locking for RX modeset cache
Date: Thu, 28 Mar 2019 16:39:20 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The L2 and L3 .ndo_set_rx_mode callbacks maintain an address cache
to decide which addresses have changed since the last modeset.

When the card is set offline, qeth_l?_stop_card() drains this cache.
This happens only after 1) the net_device has been detached, and
2) any pending RX modeset has completed. Consequently we can access the
cache lock-free.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 1 -
 drivers/s390/net/qeth_l2_main.c   | 6 ------
 drivers/s390/net/qeth_l3_main.c   | 6 ------
 4 files changed, 14 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c3cf992ca985..e6e365a183e9 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -775,7 +775,6 @@ struct qeth_card {
 
 	struct workqueue_struct *event_wq;
 	wait_queue_head_t wait_q;
-	spinlock_t mclock;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	DECLARE_HASHTABLE(mac_htable, 4);
 	DECLARE_HASHTABLE(ip_htable, 4);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 44bd6f04c145..717ca21dabde 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1409,7 +1409,6 @@ static void qeth_setup_card(struct qeth_card *card)
 
 	card->info.type = CARD_RDEV(card)->id.driver_info;
 	card->state = CARD_STATE_DOWN;
-	spin_lock_init(&card->mclock);
 	spin_lock_init(&card->lock);
 	spin_lock_init(&card->ip_lock);
 	spin_lock_init(&card->thread_mask_lock);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 437a399d5557..918c3e2e2c3d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -155,12 +155,10 @@ static void qeth_l2_drain_rx_mode_cache(struct qeth_card *card)
 	struct hlist_node *tmp;
 	int i;
 
-	spin_lock_bh(&card->mclock);
 	hash_for_each_safe(card->mac_htable, i, tmp, mac, hnode) {
 		hash_del(&mac->hnode);
 		kfree(mac);
 	}
-	spin_unlock_bh(&card->mclock);
 }
 
 static int qeth_l2_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
@@ -530,8 +528,6 @@ static void qeth_l2_rx_mode_work(struct work_struct *work)
 
 	QETH_CARD_TEXT(card, 3, "setmulti");
 
-	spin_lock_bh(&card->mclock);
-
 	netif_addr_lock_bh(dev);
 	netdev_for_each_mc_addr(ha, dev)
 		qeth_l2_add_mac(card, ha);
@@ -560,8 +556,6 @@ static void qeth_l2_rx_mode_work(struct work_struct *work)
 		}
 	}
 
-	spin_unlock_bh(&card->mclock);
-
 	if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
 		qeth_setadp_promisc_mode(card);
 	else
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b6df38f092e6..7e32edac627b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -274,12 +274,10 @@ static void qeth_l3_drain_rx_mode_cache(struct qeth_card *card)
 	struct hlist_node *tmp;
 	int i;
 
-	spin_lock_bh(&card->mclock);
 	hash_for_each_safe(card->ip_mc_htable, i, tmp, addr, hnode) {
 		hash_del(&addr->hnode);
 		kfree(addr);
 	}
-	spin_unlock_bh(&card->mclock);
 }
 
 static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
@@ -1484,8 +1482,6 @@ static void qeth_l3_rx_mode_work(struct work_struct *work)
 	QETH_CARD_TEXT(card, 3, "setmulti");
 
 	if (!card->options.sniffer) {
-		spin_lock_bh(&card->mclock);
-
 		qeth_l3_add_multicast_ipv4(card);
 		qeth_l3_add_multicast_ipv6(card);
 
@@ -1513,8 +1509,6 @@ static void qeth_l3_rx_mode_work(struct work_struct *work)
 			}
 		}
 
-		spin_unlock_bh(&card->mclock);
-
 		if (!qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
 			return;
 	}
-- 
2.16.4
