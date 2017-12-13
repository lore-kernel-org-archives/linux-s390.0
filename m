From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 4/4] s390/qeth: update takeover IPs after configuration change
Date: Wed, 13 Dec 2017 18:56:32 +0100
Message-ID: <20171213175632.100561-5-jwi@linux.vnet.ibm.com>
References: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Any modification to the takeover IP-ranges requires that we re-evaluate
which IP addresses are takeover-eligible. Otherwise we might do takeover
for some addresses when we no longer should, or vice-versa.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  4 +--
 drivers/s390/net/qeth_core_main.c |  4 +--
 drivers/s390/net/qeth_l3.h        |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 31 +++++++++++++++++--
 drivers/s390/net/qeth_l3_sys.c    | 63 +++++++++++++++++++++------------------
 5 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 51c618d9fefe..badf42acbf95 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -566,8 +566,8 @@ enum qeth_cq {
 
 struct qeth_ipato {
 	bool enabled;
-	int invert4;
-	int invert6;
+	bool invert4;
+	bool invert6;
 	struct list_head entries;
 };
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8d18675e60e2..6c815207f4f5 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1481,8 +1481,8 @@ static int qeth_setup_card(struct qeth_card *card)
 	/* IP address takeover */
 	INIT_LIST_HEAD(&card->ipato.entries);
 	card->ipato.enabled = false;
-	card->ipato.invert4 = 0;
-	card->ipato.invert6 = 0;
+	card->ipato.invert4 = false;
+	card->ipato.invert6 = false;
 	/* init QDIO stuff */
 	qeth_init_qdio_info(card);
 	INIT_DELAYED_WORK(&card->buffer_reclaim_work, qeth_buffer_reclaim_work);
diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index 194ae9b577cc..e5833837b799 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -82,7 +82,7 @@ void qeth_l3_del_vipa(struct qeth_card *, enum qeth_prot_versions, const u8 *);
 int qeth_l3_add_rxip(struct qeth_card *, enum qeth_prot_versions, const u8 *);
 void qeth_l3_del_rxip(struct qeth_card *card, enum qeth_prot_versions,
 			const u8 *);
-int qeth_l3_is_addr_covered_by_ipato(struct qeth_card *, struct qeth_ipaddr *);
+void qeth_l3_update_ipato(struct qeth_card *card);
 struct qeth_ipaddr *qeth_l3_get_addr_buffer(enum qeth_prot_versions);
 int qeth_l3_add_ip(struct qeth_card *, struct qeth_ipaddr *);
 int qeth_l3_delete_ip(struct qeth_card *, struct qeth_ipaddr *);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 4a4be81800eb..ef0961e18686 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -164,8 +164,8 @@ static void qeth_l3_convert_addr_to_bits(u8 *addr, u8 *bits, int len)
 	}
 }
 
-int qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
-						struct qeth_ipaddr *addr)
+static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
+					     struct qeth_ipaddr *addr)
 {
 	struct qeth_ipato_entry *ipatoe;
 	u8 addr_bits[128] = {0, };
@@ -606,6 +606,27 @@ int qeth_l3_setrouting_v6(struct qeth_card *card)
 /*
  * IP address takeover related functions
  */
+
+/**
+ * qeth_l3_update_ipato() - Update 'takeover' property, for all NORMAL IPs.
+ *
+ * Caller must hold ip_lock.
+ */
+void qeth_l3_update_ipato(struct qeth_card *card)
+{
+	struct qeth_ipaddr *addr;
+	unsigned int i;
+
+	hash_for_each(card->ip_htable, i, addr, hnode) {
+		if (addr->type != QETH_IP_TYPE_NORMAL)
+			continue;
+		if (qeth_l3_is_addr_covered_by_ipato(card, addr))
+			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
+		else
+			addr->set_flags &= ~QETH_IPA_SETIP_TAKEOVER_FLAG;
+	}
+}
+
 static void qeth_l3_clear_ipato_list(struct qeth_card *card)
 {
 	struct qeth_ipato_entry *ipatoe, *tmp;
@@ -617,6 +638,7 @@ static void qeth_l3_clear_ipato_list(struct qeth_card *card)
 		kfree(ipatoe);
 	}
 
+	qeth_l3_update_ipato(card);
 	spin_unlock_bh(&card->ip_lock);
 }
 
@@ -641,8 +663,10 @@ int qeth_l3_add_ipato_entry(struct qeth_card *card,
 		}
 	}
 
-	if (!rc)
+	if (!rc) {
 		list_add_tail(&new->entry, &card->ipato.entries);
+		qeth_l3_update_ipato(card);
+	}
 
 	spin_unlock_bh(&card->ip_lock);
 
@@ -665,6 +689,7 @@ void qeth_l3_del_ipato_entry(struct qeth_card *card,
 			    (proto == QETH_PROT_IPV4)? 4:16) &&
 		    (ipatoe->mask_bits == mask_bits)) {
 			list_del(&ipatoe->entry);
+			qeth_l3_update_ipato(card);
 			kfree(ipatoe);
 		}
 	}
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index aa676b4090da..6ea2b528a64e 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -370,9 +370,8 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
-	struct qeth_ipaddr *addr;
-	int i, rc = 0;
 	bool enable;
+	int rc = 0;
 
 	if (!card)
 		return -EINVAL;
@@ -391,20 +390,12 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 		goto out;
 	}
 
-	if (card->ipato.enabled == enable)
-		goto out;
-	card->ipato.enabled = enable;
-
-	spin_lock_bh(&card->ip_lock);
-	hash_for_each(card->ip_htable, i, addr, hnode) {
-		if (addr->type != QETH_IP_TYPE_NORMAL)
-			continue;
-		if (!enable)
-			addr->set_flags &= ~QETH_IPA_SETIP_TAKEOVER_FLAG;
-		else if (qeth_l3_is_addr_covered_by_ipato(card, addr))
-			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
+	if (card->ipato.enabled != enable) {
+		card->ipato.enabled = enable;
+		spin_lock_bh(&card->ip_lock);
+		qeth_l3_update_ipato(card);
+		spin_unlock_bh(&card->ip_lock);
 	}
-	spin_unlock_bh(&card->ip_lock);
 out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
@@ -430,20 +421,27 @@ static ssize_t qeth_l3_dev_ipato_invert4_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
+	bool invert;
 	int rc = 0;
 
 	if (!card)
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if (sysfs_streq(buf, "toggle"))
-		card->ipato.invert4 = (card->ipato.invert4)? 0 : 1;
-	else if (sysfs_streq(buf, "1"))
-		card->ipato.invert4 = 1;
-	else if (sysfs_streq(buf, "0"))
-		card->ipato.invert4 = 0;
-	else
+	if (sysfs_streq(buf, "toggle")) {
+		invert = !card->ipato.invert4;
+	} else if (kstrtobool(buf, &invert)) {
 		rc = -EINVAL;
+		goto out;
+	}
+
+	if (card->ipato.invert4 != invert) {
+		card->ipato.invert4 = invert;
+		spin_lock_bh(&card->ip_lock);
+		qeth_l3_update_ipato(card);
+		spin_unlock_bh(&card->ip_lock);
+	}
+out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
@@ -609,20 +607,27 @@ static ssize_t qeth_l3_dev_ipato_invert6_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
+	bool invert;
 	int rc = 0;
 
 	if (!card)
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if (sysfs_streq(buf, "toggle"))
-		card->ipato.invert6 = (card->ipato.invert6)? 0 : 1;
-	else if (sysfs_streq(buf, "1"))
-		card->ipato.invert6 = 1;
-	else if (sysfs_streq(buf, "0"))
-		card->ipato.invert6 = 0;
-	else
+	if (sysfs_streq(buf, "toggle")) {
+		invert = !card->ipato.invert6;
+	} else if (kstrtobool(buf, &invert)) {
 		rc = -EINVAL;
+		goto out;
+	}
+
+	if (card->ipato.invert6 != invert) {
+		card->ipato.invert6 = invert;
+		spin_lock_bh(&card->ip_lock);
+		qeth_l3_update_ipato(card);
+		spin_unlock_bh(&card->ip_lock);
+	}
+out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
-- 
2.13.5
