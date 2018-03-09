Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 09/12] s390/qeth: restructure IP notification handlers
Date: Fri,  9 Mar 2018 18:13:00 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-10-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Extract a helper that does the actual work & returns the right NOTIFY_*
responses, and start putting the temporary ipaddr container objects
on the stack rather than kmalloc'ing them. They are small, and this
reduces the confusion of which objects actually get added to qeth's
IP tables.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3.h      |  10 ++++
 drivers/s390/net/qeth_l3_main.c | 102 +++++++++++++++-------------------------
 2 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index 498fe9af2cdb..cf834cdd0d2c 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -42,6 +42,16 @@ struct qeth_ipaddr {
 	} u;
 };
 
+static inline void qeth_l3_init_ipaddr(struct qeth_ipaddr *addr,
+				       enum qeth_ip_types type,
+				       enum qeth_prot_versions proto)
+{
+	memset(addr, 0, sizeof(*addr));
+	addr->type = type;
+	addr->proto = proto;
+	addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
+}
+
 static inline bool qeth_l3_addr_match_ip(struct qeth_ipaddr *a1,
 					 struct qeth_ipaddr *a2)
 {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 17daf2047f7b..2ff8dd6d0a3e 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -67,6 +67,15 @@ void qeth_l3_ipaddr_to_string(enum qeth_prot_versions proto, const __u8 *addr,
 		qeth_l3_ipaddr6_to_string(addr, buf);
 }
 
+struct qeth_ipaddr *qeth_l3_get_addr_buffer(enum qeth_prot_versions prot)
+{
+	struct qeth_ipaddr *addr = kmalloc(sizeof(*addr), GFP_ATOMIC);
+
+	if (addr)
+		qeth_l3_init_ipaddr(addr, QETH_IP_TYPE_NORMAL, prot);
+	return addr;
+}
+
 static struct qeth_ipaddr *qeth_l3_find_addr_by_ip(struct qeth_card *card,
 						   struct qeth_ipaddr *query)
 {
@@ -251,23 +260,6 @@ int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 	return rc;
 }
 
-
-struct qeth_ipaddr *qeth_l3_get_addr_buffer(
-				enum qeth_prot_versions prot)
-{
-	struct qeth_ipaddr *addr;
-
-	addr = kzalloc(sizeof(struct qeth_ipaddr), GFP_ATOMIC);
-	if (!addr)
-		return NULL;
-
-	addr->type = QETH_IP_TYPE_NORMAL;
-	addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
-	addr->proto = prot;
-
-	return addr;
-}
-
 static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 {
 	struct qeth_ipaddr *addr;
@@ -3120,13 +3112,33 @@ struct qeth_discipline qeth_l3_discipline = {
 };
 EXPORT_SYMBOL_GPL(qeth_l3_discipline);
 
+static int qeth_l3_handle_ip_event(struct qeth_card *card,
+				   struct qeth_ipaddr *addr,
+				   unsigned long event)
+{
+	switch (event) {
+	case NETDEV_UP:
+		spin_lock_bh(&card->ip_lock);
+		qeth_l3_add_ip(card, addr);
+		spin_unlock_bh(&card->ip_lock);
+		return NOTIFY_OK;
+	case NETDEV_DOWN:
+		spin_lock_bh(&card->ip_lock);
+		qeth_l3_delete_ip(card, addr);
+		spin_unlock_bh(&card->ip_lock);
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int qeth_l3_ip_event(struct notifier_block *this,
 			    unsigned long event, void *ptr)
 {
 
 	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
 	struct net_device *dev = (struct net_device *)ifa->ifa_dev->dev;
-	struct qeth_ipaddr *addr;
+	struct qeth_ipaddr addr;
 	struct qeth_card *card;
 
 	if (dev_net(dev) != &init_net)
@@ -3137,29 +3149,11 @@ static int qeth_l3_ip_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 	QETH_CARD_TEXT(card, 3, "ipevent");
 
-	addr = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
-	if (addr) {
-		addr->u.a4.addr = be32_to_cpu(ifa->ifa_address);
-		addr->u.a4.mask = be32_to_cpu(ifa->ifa_mask);
-		addr->type = QETH_IP_TYPE_NORMAL;
-	} else
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		spin_lock_bh(&card->ip_lock);
-		qeth_l3_add_ip(card, addr);
-		spin_unlock_bh(&card->ip_lock);
-		break;
-	case NETDEV_DOWN:
-		spin_lock_bh(&card->ip_lock);
-		qeth_l3_delete_ip(card, addr);
-		spin_unlock_bh(&card->ip_lock);
-		break;
-	}
+	qeth_l3_init_ipaddr(&addr, QETH_IP_TYPE_NORMAL, QETH_PROT_IPV4);
+	addr.u.a4.addr = be32_to_cpu(ifa->ifa_address);
+	addr.u.a4.mask = be32_to_cpu(ifa->ifa_mask);
 
-	kfree(addr);
-	return NOTIFY_DONE;
+	return qeth_l3_handle_ip_event(card, &addr, event);
 }
 
 static struct notifier_block qeth_l3_ip_notifier = {
@@ -3172,7 +3166,7 @@ static int qeth_l3_ip6_event(struct notifier_block *this,
 {
 	struct inet6_ifaddr *ifa = (struct inet6_ifaddr *)ptr;
 	struct net_device *dev = (struct net_device *)ifa->idev->dev;
-	struct qeth_ipaddr *addr;
+	struct qeth_ipaddr addr;
 	struct qeth_card *card;
 
 	card = qeth_l3_get_card_from_dev(dev);
@@ -3182,29 +3176,11 @@ static int qeth_l3_ip6_event(struct notifier_block *this,
 	if (!qeth_is_supported(card, IPA_IPV6))
 		return NOTIFY_DONE;
 
-	addr = qeth_l3_get_addr_buffer(QETH_PROT_IPV6);
-	if (addr) {
-		memcpy(&addr->u.a6.addr, &ifa->addr, sizeof(struct in6_addr));
-		addr->u.a6.pfxlen = ifa->prefix_len;
-		addr->type = QETH_IP_TYPE_NORMAL;
-	} else
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		spin_lock_bh(&card->ip_lock);
-		qeth_l3_add_ip(card, addr);
-		spin_unlock_bh(&card->ip_lock);
-		break;
-	case NETDEV_DOWN:
-		spin_lock_bh(&card->ip_lock);
-		qeth_l3_delete_ip(card, addr);
-		spin_unlock_bh(&card->ip_lock);
-		break;
-	}
+	qeth_l3_init_ipaddr(&addr, QETH_IP_TYPE_NORMAL, QETH_PROT_IPV6);
+	addr.u.a6.addr = ifa->addr;
+	addr.u.a6.pfxlen = ifa->prefix_len;
 
-	kfree(addr);
-	return NOTIFY_DONE;
+	return qeth_l3_handle_ip_event(card, &addr, event);
 }
 
 static struct notifier_block qeth_l3_ip6_notifier = {
-- 
2.13.5
