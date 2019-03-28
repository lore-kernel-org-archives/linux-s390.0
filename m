Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/10] s390/qeth: convert IP table spinlock to mutex
Date: Thu, 28 Mar 2019 16:39:23 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-6-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

All users of the lock are running in process context now.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c |  1 -
 drivers/s390/net/qeth_l3_main.c   | 34 +++++++++++++++++-----------------
 drivers/s390/net/qeth_l3_sys.c    | 20 ++++++++++----------
 4 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index cd1ab43321e2..7dbc386fb834 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -779,6 +779,7 @@ struct qeth_card {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	DECLARE_HASHTABLE(mac_htable, 4);
 	DECLARE_HASHTABLE(ip_htable, 4);
+	struct mutex ip_lock;
 	DECLARE_HASHTABLE(ip_mc_htable, 4);
 	struct work_struct rx_mode_work;
 	struct work_struct kernel_thread_starter;
@@ -786,7 +787,6 @@ struct qeth_card {
 	unsigned long thread_start_mask;
 	unsigned long thread_allowed_mask;
 	unsigned long thread_running_mask;
-	spinlock_t ip_lock;
 	struct qeth_ipato ipato;
 	struct list_head cmd_waiter_list;
 	/* QDIO buffer handling */
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5ad0942f77ae..b12c7c6deeab 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1410,7 +1410,6 @@ static void qeth_setup_card(struct qeth_card *card)
 	card->info.type = CARD_RDEV(card)->id.driver_info;
 	card->state = CARD_STATE_DOWN;
 	spin_lock_init(&card->lock);
-	spin_lock_init(&card->ip_lock);
 	spin_lock_init(&card->thread_mask_lock);
 	mutex_init(&card->conf_mutex);
 	mutex_init(&card->discipline_mutex);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 25ed8b7ecbc4..f804d27eb569 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -246,9 +246,9 @@ static int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 		 */
 		if (addr->proto == QETH_PROT_IPV4) {
 			addr->in_progress = 1;
-			spin_unlock_bh(&card->ip_lock);
+			mutex_unlock(&card->ip_lock);
 			rc = qeth_l3_register_addr_entry(card, addr);
-			spin_lock_bh(&card->ip_lock);
+			mutex_lock(&card->ip_lock);
 			addr->in_progress = 0;
 		} else
 			rc = qeth_l3_register_addr_entry(card, addr);
@@ -273,9 +273,9 @@ static int qeth_l3_modify_ip(struct qeth_card *card, struct qeth_ipaddr *addr,
 {
 	int rc;
 
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 	rc = add ? qeth_l3_add_ip(card, addr) : qeth_l3_delete_ip(card, addr);
-	spin_unlock_bh(&card->ip_lock);
+	mutex_unlock(&card->ip_lock);
 
 	return rc;
 }
@@ -300,7 +300,7 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 
 	QETH_CARD_TEXT(card, 4, "clearip");
 
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
 		if (!recover) {
@@ -311,7 +311,7 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 		addr->disp_flag = QETH_DISP_ADDR_ADD;
 	}
 
-	spin_unlock_bh(&card->ip_lock);
+	mutex_unlock(&card->ip_lock);
 }
 
 static void qeth_l3_recover_ip(struct qeth_card *card)
@@ -323,15 +323,15 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 4, "recovrip");
 
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
 		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			if (addr->proto == QETH_PROT_IPV4) {
 				addr->in_progress = 1;
-				spin_unlock_bh(&card->ip_lock);
+				mutex_unlock(&card->ip_lock);
 				rc = qeth_l3_register_addr_entry(card, addr);
-				spin_lock_bh(&card->ip_lock);
+				mutex_lock(&card->ip_lock);
 				addr->in_progress = 0;
 			} else
 				rc = qeth_l3_register_addr_entry(card, addr);
@@ -347,8 +347,7 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 		}
 	}
 
-	spin_unlock_bh(&card->ip_lock);
-
+	mutex_unlock(&card->ip_lock);
 }
 
 static int qeth_l3_setdelip_cb(struct qeth_card *card, struct qeth_reply *reply,
@@ -573,7 +572,7 @@ static void qeth_l3_clear_ipato_list(struct qeth_card *card)
 {
 	struct qeth_ipato_entry *ipatoe, *tmp;
 
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 
 	list_for_each_entry_safe(ipatoe, tmp, &card->ipato.entries, entry) {
 		list_del(&ipatoe->entry);
@@ -581,7 +580,7 @@ static void qeth_l3_clear_ipato_list(struct qeth_card *card)
 	}
 
 	qeth_l3_update_ipato(card);
-	spin_unlock_bh(&card->ip_lock);
+	mutex_unlock(&card->ip_lock);
 }
 
 int qeth_l3_add_ipato_entry(struct qeth_card *card,
@@ -592,7 +591,7 @@ int qeth_l3_add_ipato_entry(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 2, "addipato");
 
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 
 	list_for_each_entry(ipatoe, &card->ipato.entries, entry) {
 		if (ipatoe->proto != new->proto)
@@ -610,7 +609,7 @@ int qeth_l3_add_ipato_entry(struct qeth_card *card,
 		qeth_l3_update_ipato(card);
 	}
 
-	spin_unlock_bh(&card->ip_lock);
+	mutex_unlock(&card->ip_lock);
 
 	return rc;
 }
@@ -624,7 +623,7 @@ int qeth_l3_del_ipato_entry(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 2, "delipato");
 
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 
 	list_for_each_entry_safe(ipatoe, tmp, &card->ipato.entries, entry) {
 		if (ipatoe->proto != proto)
@@ -639,7 +638,7 @@ int qeth_l3_del_ipato_entry(struct qeth_card *card,
 		}
 	}
 
-	spin_unlock_bh(&card->ip_lock);
+	mutex_unlock(&card->ip_lock);
 	return rc;
 }
 
@@ -2267,6 +2266,7 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	int rc;
 
 	hash_init(card->ip_htable);
+	mutex_init(&card->ip_lock);
 	card->cmd_wq = alloc_ordered_workqueue("%s_cmd", 0,
 					       dev_name(&gdev->dev));
 	if (!card->cmd_wq)
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index cff518b0f904..327b25f9ca4a 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -367,9 +367,9 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 
 	if (card->ipato.enabled != enable) {
 		card->ipato.enabled = enable;
-		spin_lock_bh(&card->ip_lock);
+		mutex_lock(&card->ip_lock);
 		qeth_l3_update_ipato(card);
-		spin_unlock_bh(&card->ip_lock);
+		mutex_unlock(&card->ip_lock);
 	}
 out:
 	mutex_unlock(&card->conf_mutex);
@@ -412,9 +412,9 @@ static ssize_t qeth_l3_dev_ipato_invert4_store(struct device *dev,
 
 	if (card->ipato.invert4 != invert) {
 		card->ipato.invert4 = invert;
-		spin_lock_bh(&card->ip_lock);
+		mutex_lock(&card->ip_lock);
 		qeth_l3_update_ipato(card);
-		spin_unlock_bh(&card->ip_lock);
+		mutex_unlock(&card->ip_lock);
 	}
 out:
 	mutex_unlock(&card->conf_mutex);
@@ -436,7 +436,7 @@ static ssize_t qeth_l3_dev_ipato_add_show(char *buf, struct qeth_card *card,
 	entry_len = (proto == QETH_PROT_IPV4)? 12 : 40;
 	/* add strlen for "/<mask>\n" */
 	entry_len += (proto == QETH_PROT_IPV4)? 5 : 6;
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 	list_for_each_entry(ipatoe, &card->ipato.entries, entry) {
 		if (ipatoe->proto != proto)
 			continue;
@@ -449,7 +449,7 @@ static ssize_t qeth_l3_dev_ipato_add_show(char *buf, struct qeth_card *card,
 		i += snprintf(buf + i, PAGE_SIZE - i,
 			      "%s/%i\n", addr_str, ipatoe->mask_bits);
 	}
-	spin_unlock_bh(&card->ip_lock);
+	mutex_unlock(&card->ip_lock);
 	i += snprintf(buf + i, PAGE_SIZE - i, "\n");
 
 	return i;
@@ -598,9 +598,9 @@ static ssize_t qeth_l3_dev_ipato_invert6_store(struct device *dev,
 
 	if (card->ipato.invert6 != invert) {
 		card->ipato.invert6 = invert;
-		spin_lock_bh(&card->ip_lock);
+		mutex_lock(&card->ip_lock);
 		qeth_l3_update_ipato(card);
-		spin_unlock_bh(&card->ip_lock);
+		mutex_unlock(&card->ip_lock);
 	}
 out:
 	mutex_unlock(&card->conf_mutex);
@@ -684,7 +684,7 @@ static ssize_t qeth_l3_dev_ip_add_show(struct device *dev, char *buf,
 
 	entry_len = (proto == QETH_PROT_IPV4)? 12 : 40;
 	entry_len += 2; /* \n + terminator */
-	spin_lock_bh(&card->ip_lock);
+	mutex_lock(&card->ip_lock);
 	hash_for_each(card->ip_htable, i, ipaddr, hnode) {
 		if (ipaddr->proto != proto || ipaddr->type != type)
 			continue;
@@ -698,7 +698,7 @@ static ssize_t qeth_l3_dev_ip_add_show(struct device *dev, char *buf,
 		str_len += snprintf(buf + str_len, PAGE_SIZE - str_len, "%s\n",
 				    addr_str);
 	}
-	spin_unlock_bh(&card->ip_lock);
+	mutex_unlock(&card->ip_lock);
 	str_len += snprintf(buf + str_len, PAGE_SIZE - str_len, "\n");
 
 	return str_len;
-- 
2.16.4
