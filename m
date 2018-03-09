Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 11/12] s390/qeth: extract helpers for managing special IPs
Date: Fri,  9 Mar 2018 18:13:02 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-12-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Reduce code duplication.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3.h      |  13 +---
 drivers/s390/net/qeth_l3_main.c | 158 +++++++++++-----------------------------
 drivers/s390/net/qeth_l3_sys.c  |  51 +++----------
 3 files changed, 57 insertions(+), 165 deletions(-)

diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index cf834cdd0d2c..3fdf7fdf30c2 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -119,15 +119,10 @@ int qeth_l3_add_ipato_entry(struct qeth_card *, struct qeth_ipato_entry *);
 int qeth_l3_del_ipato_entry(struct qeth_card *card,
 			    enum qeth_prot_versions proto, u8 *addr,
 			    int mask_bits);
-int qeth_l3_add_vipa(struct qeth_card *, enum qeth_prot_versions, const u8 *);
-int qeth_l3_del_vipa(struct qeth_card *card, enum qeth_prot_versions proto,
-		     const u8 *addr);
-int qeth_l3_add_rxip(struct qeth_card *, enum qeth_prot_versions, const u8 *);
-int qeth_l3_del_rxip(struct qeth_card *card, enum qeth_prot_versions proto,
-		     const u8 *addr);
 void qeth_l3_update_ipato(struct qeth_card *card);
-struct qeth_ipaddr *qeth_l3_get_addr_buffer(enum qeth_prot_versions);
-int qeth_l3_add_ip(struct qeth_card *, struct qeth_ipaddr *);
-int qeth_l3_delete_ip(struct qeth_card *, struct qeth_ipaddr *);
+int qeth_l3_modify_hsuid(struct qeth_card *card, bool add);
+int qeth_l3_modify_rxip_vipa(struct qeth_card *card, bool add, const u8 *ip,
+			     enum qeth_ip_types type,
+			     enum qeth_prot_versions proto);
 
 #endif /* __QETH_L3_H__ */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ccf22e749105..0dfa16a03ea2 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -67,7 +67,7 @@ void qeth_l3_ipaddr_to_string(enum qeth_prot_versions proto, const __u8 *addr,
 		qeth_l3_ipaddr6_to_string(addr, buf);
 }
 
-struct qeth_ipaddr *qeth_l3_get_addr_buffer(enum qeth_prot_versions prot)
+static struct qeth_ipaddr *qeth_l3_get_addr_buffer(enum qeth_prot_versions prot)
 {
 	struct qeth_ipaddr *addr = kmalloc(sizeof(*addr), GFP_ATOMIC);
 
@@ -147,12 +147,18 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
 	return rc;
 }
 
-int qeth_l3_delete_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
+static int qeth_l3_delete_ip(struct qeth_card *card,
+			     struct qeth_ipaddr *tmp_addr)
 {
 	int rc = 0;
 	struct qeth_ipaddr *addr;
 
-	QETH_CARD_TEXT(card, 4, "delip");
+	if (tmp_addr->type == QETH_IP_TYPE_RXIP)
+		QETH_CARD_TEXT(card, 2, "delrxip");
+	else if (tmp_addr->type == QETH_IP_TYPE_VIPA)
+		QETH_CARD_TEXT(card, 2, "delvipa");
+	else
+		QETH_CARD_TEXT(card, 2, "delip");
 
 	if (tmp_addr->proto == QETH_PROT_IPV4)
 		QETH_CARD_HEX(card, 4, &tmp_addr->u.a4.addr, 4);
@@ -180,13 +186,18 @@ int qeth_l3_delete_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 	return rc;
 }
 
-int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
+static int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 {
 	int rc = 0;
 	struct qeth_ipaddr *addr;
 	char buf[40];
 
-	QETH_CARD_TEXT(card, 4, "addip");
+	if (tmp_addr->type == QETH_IP_TYPE_RXIP)
+		QETH_CARD_TEXT(card, 2, "addrxip");
+	else if (tmp_addr->type == QETH_IP_TYPE_VIPA)
+		QETH_CARD_TEXT(card, 2, "addvipa");
+	else
+		QETH_CARD_TEXT(card, 2, "addip");
 
 	if (tmp_addr->proto == QETH_PROT_IPV4)
 		QETH_CARD_HEX(card, 4, &tmp_addr->u.a4.addr, 4);
@@ -598,132 +609,45 @@ int qeth_l3_del_ipato_entry(struct qeth_card *card,
 	return rc;
 }
 
-/*
- * VIPA related functions
- */
-int qeth_l3_add_vipa(struct qeth_card *card, enum qeth_prot_versions proto,
-	      const u8 *addr)
-{
-	struct qeth_ipaddr *ipaddr;
-	int rc;
-
-	ipaddr = qeth_l3_get_addr_buffer(proto);
-	if (ipaddr) {
-		if (proto == QETH_PROT_IPV4) {
-			QETH_CARD_TEXT(card, 2, "addvipa4");
-			memcpy(&ipaddr->u.a4.addr, addr, 4);
-			ipaddr->u.a4.mask = 0;
-		} else if (proto == QETH_PROT_IPV6) {
-			QETH_CARD_TEXT(card, 2, "addvipa6");
-			memcpy(&ipaddr->u.a6.addr, addr, 16);
-			ipaddr->u.a6.pfxlen = 0;
-		}
-		ipaddr->type = QETH_IP_TYPE_VIPA;
-		ipaddr->set_flags = QETH_IPA_SETIP_VIPA_FLAG;
-		ipaddr->del_flags = QETH_IPA_DELIP_VIPA_FLAG;
-	} else
-		return -ENOMEM;
-
-	spin_lock_bh(&card->ip_lock);
-	rc = qeth_l3_add_ip(card, ipaddr);
-	spin_unlock_bh(&card->ip_lock);
-
-	kfree(ipaddr);
-
-	return rc;
-}
-
-int qeth_l3_del_vipa(struct qeth_card *card, enum qeth_prot_versions proto,
-		     const u8 *addr)
+int qeth_l3_modify_rxip_vipa(struct qeth_card *card, bool add, const u8 *ip,
+			     enum qeth_ip_types type,
+			     enum qeth_prot_versions proto)
 {
-	struct qeth_ipaddr *ipaddr;
-	int rc;
-
-	ipaddr = qeth_l3_get_addr_buffer(proto);
-	if (ipaddr) {
-		if (proto == QETH_PROT_IPV4) {
-			QETH_CARD_TEXT(card, 2, "delvipa4");
-			memcpy(&ipaddr->u.a4.addr, addr, 4);
-			ipaddr->u.a4.mask = 0;
-		} else if (proto == QETH_PROT_IPV6) {
-			QETH_CARD_TEXT(card, 2, "delvipa6");
-			memcpy(&ipaddr->u.a6.addr, addr, 16);
-			ipaddr->u.a6.pfxlen = 0;
-		}
-		ipaddr->type = QETH_IP_TYPE_VIPA;
-	} else
-		return -ENOMEM;
-
-	spin_lock_bh(&card->ip_lock);
-	rc = qeth_l3_delete_ip(card, ipaddr);
-	spin_unlock_bh(&card->ip_lock);
-
-	kfree(ipaddr);
-	return rc;
-}
-
-/*
- * proxy ARP related functions
- */
-int qeth_l3_add_rxip(struct qeth_card *card, enum qeth_prot_versions proto,
-	      const u8 *addr)
-{
-	struct qeth_ipaddr *ipaddr;
+	struct qeth_ipaddr addr;
 	int rc;
 
-	ipaddr = qeth_l3_get_addr_buffer(proto);
-	if (ipaddr) {
-		if (proto == QETH_PROT_IPV4) {
-			QETH_CARD_TEXT(card, 2, "addrxip4");
-			memcpy(&ipaddr->u.a4.addr, addr, 4);
-			ipaddr->u.a4.mask = 0;
-		} else if (proto == QETH_PROT_IPV6) {
-			QETH_CARD_TEXT(card, 2, "addrxip6");
-			memcpy(&ipaddr->u.a6.addr, addr, 16);
-			ipaddr->u.a6.pfxlen = 0;
-		}
-
-		ipaddr->type = QETH_IP_TYPE_RXIP;
-		ipaddr->set_flags = QETH_IPA_SETIP_TAKEOVER_FLAG;
-		ipaddr->del_flags = 0;
-	} else
-		return -ENOMEM;
+	qeth_l3_init_ipaddr(&addr, type, proto);
+	if (proto == QETH_PROT_IPV4)
+		memcpy(&addr.u.a4.addr, ip, 4);
+	else
+		memcpy(&addr.u.a6.addr, ip, 16);
+	if (type == QETH_IP_TYPE_RXIP) {
+		addr.set_flags = QETH_IPA_SETIP_TAKEOVER_FLAG;
+	} else {
+		addr.set_flags = QETH_IPA_SETIP_VIPA_FLAG;
+		addr.del_flags = QETH_IPA_DELIP_VIPA_FLAG;
+	}
 
 	spin_lock_bh(&card->ip_lock);
-	rc = qeth_l3_add_ip(card, ipaddr);
+	rc = add ? qeth_l3_add_ip(card, &addr) : qeth_l3_delete_ip(card, &addr);
 	spin_unlock_bh(&card->ip_lock);
-
-	kfree(ipaddr);
-
 	return rc;
 }
 
-int qeth_l3_del_rxip(struct qeth_card *card, enum qeth_prot_versions proto,
-		     const u8 *addr)
+int qeth_l3_modify_hsuid(struct qeth_card *card, bool add)
 {
-	struct qeth_ipaddr *ipaddr;
-	int rc;
+	struct qeth_ipaddr addr;
+	int rc, i;
 
-	ipaddr = qeth_l3_get_addr_buffer(proto);
-	if (ipaddr) {
-		if (proto == QETH_PROT_IPV4) {
-			QETH_CARD_TEXT(card, 2, "delrxip4");
-			memcpy(&ipaddr->u.a4.addr, addr, 4);
-			ipaddr->u.a4.mask = 0;
-		} else if (proto == QETH_PROT_IPV6) {
-			QETH_CARD_TEXT(card, 2, "delrxip6");
-			memcpy(&ipaddr->u.a6.addr, addr, 16);
-			ipaddr->u.a6.pfxlen = 0;
-		}
-		ipaddr->type = QETH_IP_TYPE_RXIP;
-	} else
-		return -ENOMEM;
+	qeth_l3_init_ipaddr(&addr, QETH_IP_TYPE_NORMAL, QETH_PROT_IPV6);
+	addr.u.a6.addr.s6_addr[0] = 0xfe;
+	addr.u.a6.addr.s6_addr[1] = 0x80;
+	for (i = 0; i < 8; i++)
+		addr.u.a6.addr.s6_addr[8+i] = card->options.hsuid[i];
 
 	spin_lock_bh(&card->ip_lock);
-	rc = qeth_l3_delete_ip(card, ipaddr);
+	rc = add ? qeth_l3_add_ip(card, &addr) : qeth_l3_delete_ip(card, &addr);
 	spin_unlock_bh(&card->ip_lock);
-
-	kfree(ipaddr);
 	return rc;
 }
 
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index a645cfe66ddf..f61192a048f4 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -272,9 +272,8 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
-	struct qeth_ipaddr *addr;
 	char *tmp;
-	int rc, i;
+	int rc;
 
 	if (!card)
 		return -EINVAL;
@@ -293,25 +292,9 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 	if (strlen(tmp) > 8)
 		return -EINVAL;
 
-	if (card->options.hsuid[0]) {
+	if (card->options.hsuid[0])
 		/* delete old ip address */
-		addr = qeth_l3_get_addr_buffer(QETH_PROT_IPV6);
-		if (!addr)
-			return -ENOMEM;
-
-		addr->u.a6.addr.s6_addr32[0] = cpu_to_be32(0xfe800000);
-		addr->u.a6.addr.s6_addr32[1] = 0x00000000;
-		for (i = 8; i < 16; i++)
-			addr->u.a6.addr.s6_addr[i] =
-				card->options.hsuid[i - 8];
-		addr->u.a6.pfxlen = 0;
-		addr->type = QETH_IP_TYPE_NORMAL;
-
-		spin_lock_bh(&card->ip_lock);
-		qeth_l3_delete_ip(card, addr);
-		spin_unlock_bh(&card->ip_lock);
-		kfree(addr);
-	}
+		qeth_l3_modify_hsuid(card, false);
 
 	if (strlen(tmp) == 0) {
 		/* delete ip address only */
@@ -331,21 +314,7 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 	if (card->dev)
 		memcpy(card->dev->perm_addr, card->options.hsuid, 9);
 
-	addr = qeth_l3_get_addr_buffer(QETH_PROT_IPV6);
-	if (addr != NULL) {
-		addr->u.a6.addr.s6_addr32[0] = cpu_to_be32(0xfe800000);
-		addr->u.a6.addr.s6_addr32[1] = 0x00000000;
-		for (i = 8; i < 16; i++)
-			addr->u.a6.addr.s6_addr[i] = card->options.hsuid[i - 8];
-		addr->u.a6.pfxlen = 0;
-		addr->type = QETH_IP_TYPE_NORMAL;
-	} else
-		return -ENOMEM;
-
-	spin_lock_bh(&card->ip_lock);
-	rc = qeth_l3_add_ip(card, addr);
-	spin_unlock_bh(&card->ip_lock);
-	kfree(addr);
+	rc = qeth_l3_modify_hsuid(card, true);
 
 	return rc ? rc : count;
 }
@@ -767,7 +736,8 @@ static ssize_t qeth_l3_dev_vipa_add_store(const char *buf, size_t count,
 	mutex_lock(&card->conf_mutex);
 	rc = qeth_l3_parse_vipae(buf, proto, addr);
 	if (!rc)
-		rc = qeth_l3_add_vipa(card, proto, addr);
+		rc = qeth_l3_modify_rxip_vipa(card, true, addr,
+					      QETH_IP_TYPE_VIPA, proto);
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
@@ -796,7 +766,8 @@ static ssize_t qeth_l3_dev_vipa_del_store(const char *buf, size_t count,
 	mutex_lock(&card->conf_mutex);
 	rc = qeth_l3_parse_vipae(buf, proto, addr);
 	if (!rc)
-		rc = qeth_l3_del_vipa(card, proto, addr);
+		rc = qeth_l3_modify_rxip_vipa(card, false, addr,
+					      QETH_IP_TYPE_VIPA, proto);
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
@@ -908,7 +879,8 @@ static ssize_t qeth_l3_dev_rxip_add_store(const char *buf, size_t count,
 	mutex_lock(&card->conf_mutex);
 	rc = qeth_l3_parse_rxipe(buf, proto, addr);
 	if (!rc)
-		rc = qeth_l3_add_rxip(card, proto, addr);
+		rc = qeth_l3_modify_rxip_vipa(card, true, addr,
+					      QETH_IP_TYPE_RXIP, proto);
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
@@ -937,7 +909,8 @@ static ssize_t qeth_l3_dev_rxip_del_store(const char *buf, size_t count,
 	mutex_lock(&card->conf_mutex);
 	rc = qeth_l3_parse_rxipe(buf, proto, addr);
 	if (!rc)
-		rc = qeth_l3_del_rxip(card, proto, addr);
+		rc = qeth_l3_modify_rxip_vipa(card, false, addr,
+					      QETH_IP_TYPE_RXIP, proto);
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
-- 
2.13.5
