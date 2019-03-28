Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/10] s390/qeth: defer IPv6 address notifier events
Date: Thu, 28 Mar 2019 16:39:22 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The inet6addr_chain is atomic. So instead of starting the cmd IO for
SETIP / DELIP straight from the notifier callback, run it from a
workqueue. This is the last step towards removal of cmd IO completion
polling.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c |  3 +-
 drivers/s390/net/qeth_l3_main.c   | 60 +++++++++++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index e6e365a183e9..cd1ab43321e2 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -774,6 +774,7 @@ struct qeth_card {
 	struct qeth_card_options options;
 
 	struct workqueue_struct *event_wq;
+	struct workqueue_struct *cmd_wq;
 	wait_queue_head_t wait_q;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	DECLARE_HASHTABLE(mac_htable, 4);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 717ca21dabde..5ad0942f77ae 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1450,7 +1450,8 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 	CARD_WDEV(card) = gdev->cdev[1];
 	CARD_DDEV(card) = gdev->cdev[2];
 
-	card->event_wq = alloc_ordered_workqueue("%s", 0, dev_name(&gdev->dev));
+	card->event_wq = alloc_ordered_workqueue("%s_event", 0,
+						 dev_name(&gdev->dev));
 	if (!card->event_wq)
 		goto out_wq;
 	if (qeth_setup_channel(&card->read, true))
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 509871b78313..25ed8b7ecbc4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2267,11 +2267,17 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	int rc;
 
 	hash_init(card->ip_htable);
+	card->cmd_wq = alloc_ordered_workqueue("%s_cmd", 0,
+					       dev_name(&gdev->dev));
+	if (!card->cmd_wq)
+		return -ENOMEM;
 
 	if (gdev->dev.type == &qeth_generic_devtype) {
 		rc = qeth_l3_create_device_attributes(&gdev->dev);
-		if (rc)
+		if (rc) {
+			destroy_workqueue(card->cmd_wq);
 			return rc;
+		}
 	}
 
 	hash_init(card->ip_mc_htable);
@@ -2295,6 +2301,9 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	cancel_work_sync(&card->close_dev_work);
 	if (qeth_netdev_is_registered(card->dev))
 		unregister_netdev(card->dev);
+
+	flush_workqueue(card->cmd_wq);
+	destroy_workqueue(card->cmd_wq);
 	qeth_l3_clear_ip_htable(card, 0);
 	qeth_l3_clear_ipato_list(card);
 }
@@ -2542,6 +2551,30 @@ static int qeth_l3_handle_ip_event(struct qeth_card *card,
 	}
 }
 
+struct qeth_l3_ip_event_work {
+	struct work_struct work;
+	struct qeth_card *card;
+	struct qeth_ipaddr addr;
+};
+
+#define to_ip_work(w) container_of((w), struct qeth_l3_ip_event_work, work)
+
+static void qeth_l3_add_ip_worker(struct work_struct *work)
+{
+	struct qeth_l3_ip_event_work *ip_work = to_ip_work(work);
+
+	qeth_l3_modify_ip(ip_work->card, &ip_work->addr, true);
+	kfree(work);
+}
+
+static void qeth_l3_delete_ip_worker(struct work_struct *work)
+{
+	struct qeth_l3_ip_event_work *ip_work = to_ip_work(work);
+
+	qeth_l3_modify_ip(ip_work->card, &ip_work->addr, false);
+	kfree(work);
+}
+
 static struct qeth_card *qeth_l3_get_card_from_dev(struct net_device *dev)
 {
 	if (is_vlan_dev(dev))
@@ -2586,9 +2619,12 @@ static int qeth_l3_ip6_event(struct notifier_block *this,
 {
 	struct inet6_ifaddr *ifa = (struct inet6_ifaddr *)ptr;
 	struct net_device *dev = ifa->idev->dev;
-	struct qeth_ipaddr addr;
+	struct qeth_l3_ip_event_work *ip_work;
 	struct qeth_card *card;
 
+	if (event != NETDEV_UP && event != NETDEV_DOWN)
+		return NOTIFY_DONE;
+
 	card = qeth_l3_get_card_from_dev(dev);
 	if (!card)
 		return NOTIFY_DONE;
@@ -2596,11 +2632,23 @@ static int qeth_l3_ip6_event(struct notifier_block *this,
 	if (!qeth_is_supported(card, IPA_IPV6))
 		return NOTIFY_DONE;
 
-	qeth_l3_init_ipaddr(&addr, QETH_IP_TYPE_NORMAL, QETH_PROT_IPV6);
-	addr.u.a6.addr = ifa->addr;
-	addr.u.a6.pfxlen = ifa->prefix_len;
+	ip_work = kmalloc(sizeof(*ip_work), GFP_ATOMIC);
+	if (!ip_work)
+		return NOTIFY_DONE;
 
-	return qeth_l3_handle_ip_event(card, &addr, event);
+	if (event == NETDEV_UP)
+		INIT_WORK(&ip_work->work, qeth_l3_add_ip_worker);
+	else
+		INIT_WORK(&ip_work->work, qeth_l3_delete_ip_worker);
+
+	ip_work->card = card;
+	qeth_l3_init_ipaddr(&ip_work->addr, QETH_IP_TYPE_NORMAL,
+			    QETH_PROT_IPV6);
+	ip_work->addr.u.a6.addr = ifa->addr;
+	ip_work->addr.u.a6.pfxlen = ifa->prefix_len;
+
+	queue_work(card->cmd_wq, &ip_work->work);
+	return NOTIFY_OK;
 }
 
 static struct notifier_block qeth_l3_ip6_notifier = {
-- 
2.16.4
