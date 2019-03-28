Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/10] s390/qeth: add wrapper for IP table access
Date: Thu, 28 Mar 2019 16:39:21 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Extract a little helper, so that high-level callers can manipulate the
IP table without worrying about the locking. This will make it easier
to convert the code to a different locking primitive later on.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 7e32edac627b..509871b78313 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -268,6 +268,18 @@ static int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 	return rc;
 }
 
+static int qeth_l3_modify_ip(struct qeth_card *card, struct qeth_ipaddr *addr,
+			     bool add)
+{
+	int rc;
+
+	spin_lock_bh(&card->ip_lock);
+	rc = add ? qeth_l3_add_ip(card, addr) : qeth_l3_delete_ip(card, addr);
+	spin_unlock_bh(&card->ip_lock);
+
+	return rc;
+}
+
 static void qeth_l3_drain_rx_mode_cache(struct qeth_card *card)
 {
 	struct qeth_ipaddr *addr;
@@ -636,7 +648,6 @@ int qeth_l3_modify_rxip_vipa(struct qeth_card *card, bool add, const u8 *ip,
 			     enum qeth_prot_versions proto)
 {
 	struct qeth_ipaddr addr;
-	int rc;
 
 	qeth_l3_init_ipaddr(&addr, type, proto);
 	if (proto == QETH_PROT_IPV4)
@@ -644,16 +655,13 @@ int qeth_l3_modify_rxip_vipa(struct qeth_card *card, bool add, const u8 *ip,
 	else
 		memcpy(&addr.u.a6.addr, ip, 16);
 
-	spin_lock_bh(&card->ip_lock);
-	rc = add ? qeth_l3_add_ip(card, &addr) : qeth_l3_delete_ip(card, &addr);
-	spin_unlock_bh(&card->ip_lock);
-	return rc;
+	return qeth_l3_modify_ip(card, &addr, add);
 }
 
 int qeth_l3_modify_hsuid(struct qeth_card *card, bool add)
 {
 	struct qeth_ipaddr addr;
-	int rc, i;
+	unsigned int i;
 
 	qeth_l3_init_ipaddr(&addr, QETH_IP_TYPE_NORMAL, QETH_PROT_IPV6);
 	addr.u.a6.addr.s6_addr[0] = 0xfe;
@@ -661,10 +669,7 @@ int qeth_l3_modify_hsuid(struct qeth_card *card, bool add)
 	for (i = 0; i < 8; i++)
 		addr.u.a6.addr.s6_addr[8+i] = card->options.hsuid[i];
 
-	spin_lock_bh(&card->ip_lock);
-	rc = add ? qeth_l3_add_ip(card, &addr) : qeth_l3_delete_ip(card, &addr);
-	spin_unlock_bh(&card->ip_lock);
-	return rc;
+	return qeth_l3_modify_ip(card, &addr, add);
 }
 
 static int qeth_l3_register_addr_entry(struct qeth_card *card,
@@ -2527,14 +2532,10 @@ static int qeth_l3_handle_ip_event(struct qeth_card *card,
 {
 	switch (event) {
 	case NETDEV_UP:
-		spin_lock_bh(&card->ip_lock);
-		qeth_l3_add_ip(card, addr);
-		spin_unlock_bh(&card->ip_lock);
+		qeth_l3_modify_ip(card, addr, true);
 		return NOTIFY_OK;
 	case NETDEV_DOWN:
-		spin_lock_bh(&card->ip_lock);
-		qeth_l3_delete_ip(card, addr);
-		spin_unlock_bh(&card->ip_lock);
+		qeth_l3_modify_ip(card, addr, false);
 		return NOTIFY_OK;
 	default:
 		return NOTIFY_DONE;
-- 
2.16.4
