From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/4] s390/qeth: use common helper to display rxip/vipa
Date: Wed, 27 Dec 2017 17:44:29 +0100
Message-ID: <20171227164431.17118-3-jwi@linux.vnet.ibm.com>
References: <20171227164431.17118-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171227164431.17118-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

By parameterising the address type, we need just one helper that walks
the IP table and builds up the response string.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_sys.c | 90 +++++++++++-------------------------------
 1 file changed, 24 insertions(+), 66 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index f8e74b384980..a645cfe66ddf 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -705,22 +705,25 @@ static const struct attribute_group qeth_device_ipato_group = {
 	.attrs = qeth_ipato_device_attrs,
 };
 
-static ssize_t qeth_l3_dev_vipa_add_show(char *buf, struct qeth_card *card,
-			enum qeth_prot_versions proto)
+static ssize_t qeth_l3_dev_ip_add_show(struct device *dev, char *buf,
+				       enum qeth_prot_versions proto,
+				       enum qeth_ip_types type)
 {
+	struct qeth_card *card = dev_get_drvdata(dev);
 	struct qeth_ipaddr *ipaddr;
 	char addr_str[40];
 	int str_len = 0;
 	int entry_len; /* length of 1 entry string, differs between v4 and v6 */
 	int i;
 
+	if (!card)
+		return -EINVAL;
+
 	entry_len = (proto == QETH_PROT_IPV4)? 12 : 40;
 	entry_len += 2; /* \n + terminator */
 	spin_lock_bh(&card->ip_lock);
 	hash_for_each(card->ip_htable, i, ipaddr, hnode) {
-		if (ipaddr->proto != proto)
-			continue;
-		if (ipaddr->type != QETH_IP_TYPE_VIPA)
+		if (ipaddr->proto != proto || ipaddr->type != type)
 			continue;
 		/* String must not be longer than PAGE_SIZE. So we check if
 		 * string length gets near PAGE_SIZE. Then we can savely display
@@ -739,14 +742,11 @@ static ssize_t qeth_l3_dev_vipa_add_show(char *buf, struct qeth_card *card,
 }
 
 static ssize_t qeth_l3_dev_vipa_add4_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+					  struct device_attribute *attr,
+					  char *buf)
 {
-	struct qeth_card *card = dev_get_drvdata(dev);
-
-	if (!card)
-		return -EINVAL;
-
-	return qeth_l3_dev_vipa_add_show(buf, card, QETH_PROT_IPV4);
+	return qeth_l3_dev_ip_add_show(dev, buf, QETH_PROT_IPV4,
+				       QETH_IP_TYPE_VIPA);
 }
 
 static int qeth_l3_parse_vipae(const char *buf, enum qeth_prot_versions proto,
@@ -816,14 +816,11 @@ static QETH_DEVICE_ATTR(vipa_del4, del4, 0200, NULL,
 			qeth_l3_dev_vipa_del4_store);
 
 static ssize_t qeth_l3_dev_vipa_add6_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					  struct device_attribute *attr,
+					  char *buf)
 {
-	struct qeth_card *card = dev_get_drvdata(dev);
-
-	if (!card)
-		return -EINVAL;
-
-	return qeth_l3_dev_vipa_add_show(buf, card, QETH_PROT_IPV6);
+	return qeth_l3_dev_ip_add_show(dev, buf, QETH_PROT_IPV6,
+				       QETH_IP_TYPE_VIPA);
 }
 
 static ssize_t qeth_l3_dev_vipa_add6_store(struct device *dev,
@@ -868,48 +865,12 @@ static const struct attribute_group qeth_device_vipa_group = {
 	.attrs = qeth_vipa_device_attrs,
 };
 
-static ssize_t qeth_l3_dev_rxip_add_show(char *buf, struct qeth_card *card,
-		       enum qeth_prot_versions proto)
-{
-	struct qeth_ipaddr *ipaddr;
-	char addr_str[40];
-	int str_len = 0;
-	int entry_len; /* length of 1 entry string, differs between v4 and v6 */
-	int i;
-
-	entry_len = (proto == QETH_PROT_IPV4)? 12 : 40;
-	entry_len += 2; /* \n + terminator */
-	spin_lock_bh(&card->ip_lock);
-	hash_for_each(card->ip_htable, i, ipaddr, hnode) {
-		if (ipaddr->proto != proto)
-			continue;
-		if (ipaddr->type != QETH_IP_TYPE_RXIP)
-			continue;
-		/* String must not be longer than PAGE_SIZE. So we check if
-		 * string length gets near PAGE_SIZE. Then we can savely display
-		 * the next IPv6 address (worst case, compared to IPv4) */
-		if ((PAGE_SIZE - str_len) <= entry_len)
-			break;
-		qeth_l3_ipaddr_to_string(proto, (const u8 *)&ipaddr->u,
-			addr_str);
-		str_len += snprintf(buf + str_len, PAGE_SIZE - str_len, "%s\n",
-				    addr_str);
-	}
-	spin_unlock_bh(&card->ip_lock);
-	str_len += snprintf(buf + str_len, PAGE_SIZE - str_len, "\n");
-
-	return str_len;
-}
-
 static ssize_t qeth_l3_dev_rxip_add4_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+					  struct device_attribute *attr,
+					  char *buf)
 {
-	struct qeth_card *card = dev_get_drvdata(dev);
-
-	if (!card)
-		return -EINVAL;
-
-	return qeth_l3_dev_rxip_add_show(buf, card, QETH_PROT_IPV4);
+	return qeth_l3_dev_ip_add_show(dev, buf, QETH_PROT_IPV4,
+				       QETH_IP_TYPE_RXIP);
 }
 
 static int qeth_l3_parse_rxipe(const char *buf, enum qeth_prot_versions proto,
@@ -996,14 +957,11 @@ static QETH_DEVICE_ATTR(rxip_del4, del4, 0200, NULL,
 			qeth_l3_dev_rxip_del4_store);
 
 static ssize_t qeth_l3_dev_rxip_add6_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+					  struct device_attribute *attr,
+					  char *buf)
 {
-	struct qeth_card *card = dev_get_drvdata(dev);
-
-	if (!card)
-		return -EINVAL;
-
-	return qeth_l3_dev_rxip_add_show(buf, card, QETH_PROT_IPV6);
+	return qeth_l3_dev_ip_add_show(dev, buf, QETH_PROT_IPV6,
+				       QETH_IP_TYPE_RXIP);
 }
 
 static ssize_t qeth_l3_dev_rxip_add6_store(struct device *dev,
-- 
2.13.5
