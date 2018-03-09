Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 12/12] s390/qeth: shrink qeth_ipaddr struct
Date: Fri,  9 Mar 2018 18:13:03 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-13-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Using up 8 bytes in every ipaddr object to store SETIP/DELIP flags is
rather wasteful. Except for takeover eligibility, the flag values all
just depend on the address type, so determine them on demand.

While at it reorder the struct to fill an alignment hole.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  6 ------
 drivers/s390/net/qeth_l3.h      | 11 +++++++---
 drivers/s390/net/qeth_l3_main.c | 46 ++++++++++++++++++++++-------------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 459ae3758f30..4326715dc13e 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -554,12 +554,6 @@ enum qeth_prot_versions {
 	QETH_PROT_IPV6 = 0x0006,
 };
 
-enum qeth_ip_types {
-	QETH_IP_TYPE_NORMAL,
-	QETH_IP_TYPE_VIPA,
-	QETH_IP_TYPE_RXIP,
-};
-
 enum qeth_cmd_buffer_state {
 	BUF_STATE_FREE,
 	BUF_STATE_LOCKED,
diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index 3fdf7fdf30c2..87659cfc9066 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -15,21 +15,26 @@
 
 #define QETH_SNIFF_AVAIL	0x0008
 
+enum qeth_ip_types {
+	QETH_IP_TYPE_NORMAL,
+	QETH_IP_TYPE_VIPA,
+	QETH_IP_TYPE_RXIP,
+};
+
 struct qeth_ipaddr {
 	struct hlist_node hnode;
 	enum qeth_ip_types type;
-	enum qeth_ipa_setdelip_flags set_flags;
-	enum qeth_ipa_setdelip_flags del_flags;
+	unsigned char mac[ETH_ALEN];
 	u8 is_multicast:1;
 	u8 in_progress:1;
 	u8 disp_flag:2;
+	u8 ipato:1;			/* ucast only */
 
 	/* is changed only for normal ip addresses
 	 * for non-normal addresses it always is  1
 	 */
 	int  ref_counter;
 	enum qeth_prot_versions proto;
-	unsigned char mac[ETH_ALEN];
 	union {
 		struct {
 			unsigned int addr;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0dfa16a03ea2..ef3f548b7d35 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -229,7 +229,7 @@ static int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 
 		if (qeth_l3_is_addr_covered_by_ipato(card, addr)) {
 			QETH_CARD_TEXT(card, 2, "tkovaddr");
-			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
+			addr->ipato = 1;
 		}
 		hash_add(card->ip_htable, &addr->hnode,
 				qeth_l3_ipaddr_hash(addr));
@@ -382,21 +382,38 @@ static void qeth_l3_fill_netmask(u8 *netmask, unsigned int len)
 	}
 }
 
+static u32 qeth_l3_get_setdelip_flags(struct qeth_ipaddr *addr, bool set)
+{
+	switch (addr->type) {
+	case QETH_IP_TYPE_RXIP:
+		return (set) ? QETH_IPA_SETIP_TAKEOVER_FLAG : 0;
+	case QETH_IP_TYPE_VIPA:
+		return (set) ? QETH_IPA_SETIP_VIPA_FLAG :
+			       QETH_IPA_DELIP_VIPA_FLAG;
+	default:
+		return (set && addr->ipato) ? QETH_IPA_SETIP_TAKEOVER_FLAG : 0;
+	}
+}
+
 static int qeth_l3_send_setdelip(struct qeth_card *card,
-		struct qeth_ipaddr *addr, int ipacmd, unsigned int flags)
+				 struct qeth_ipaddr *addr,
+				 enum qeth_ipa_cmds ipacmd)
 {
-	int rc;
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
 	__u8 netmask[16];
+	u32 flags;
 
 	QETH_CARD_TEXT(card, 4, "setdelip");
-	QETH_CARD_TEXT_(card, 4, "flags%02X", flags);
 
 	iob = qeth_get_ipacmd_buffer(card, ipacmd, addr->proto);
 	if (!iob)
 		return -ENOMEM;
 	cmd = __ipa_cmd(iob);
+
+	flags = qeth_l3_get_setdelip_flags(addr, ipacmd == IPA_CMD_SETIP);
+	QETH_CARD_TEXT_(card, 4, "flags%02X", flags);
+
 	if (addr->proto == QETH_PROT_IPV6) {
 		memcpy(cmd->data.setdelip6.ip_addr, &addr->u.a6.addr,
 		       sizeof(struct in6_addr));
@@ -410,9 +427,7 @@ static int qeth_l3_send_setdelip(struct qeth_card *card,
 		cmd->data.setdelip4.flags = flags;
 	}
 
-	rc = qeth_send_ipa_cmd(card, iob, NULL, NULL);
-
-	return rc;
+	return qeth_send_ipa_cmd(card, iob, NULL, NULL);
 }
 
 static int qeth_l3_send_setrouting(struct qeth_card *card,
@@ -528,10 +543,7 @@ void qeth_l3_update_ipato(struct qeth_card *card)
 	hash_for_each(card->ip_htable, i, addr, hnode) {
 		if (addr->type != QETH_IP_TYPE_NORMAL)
 			continue;
-		if (qeth_l3_is_addr_covered_by_ipato(card, addr))
-			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
-		else
-			addr->set_flags &= ~QETH_IPA_SETIP_TAKEOVER_FLAG;
+		addr->ipato = qeth_l3_is_addr_covered_by_ipato(card, addr);
 	}
 }
 
@@ -621,12 +633,6 @@ int qeth_l3_modify_rxip_vipa(struct qeth_card *card, bool add, const u8 *ip,
 		memcpy(&addr.u.a4.addr, ip, 4);
 	else
 		memcpy(&addr.u.a6.addr, ip, 16);
-	if (type == QETH_IP_TYPE_RXIP) {
-		addr.set_flags = QETH_IPA_SETIP_TAKEOVER_FLAG;
-	} else {
-		addr.set_flags = QETH_IPA_SETIP_VIPA_FLAG;
-		addr.del_flags = QETH_IPA_DELIP_VIPA_FLAG;
-	}
 
 	spin_lock_bh(&card->ip_lock);
 	rc = add ? qeth_l3_add_ip(card, &addr) : qeth_l3_delete_ip(card, &addr);
@@ -674,8 +680,7 @@ static int qeth_l3_register_addr_entry(struct qeth_card *card,
 		if (addr->is_multicast)
 			rc =  qeth_l3_send_setdelmc(card, addr, IPA_CMD_SETIPM);
 		else
-			rc = qeth_l3_send_setdelip(card, addr, IPA_CMD_SETIP,
-					addr->set_flags);
+			rc = qeth_l3_send_setdelip(card, addr, IPA_CMD_SETIP);
 		if (rc)
 			QETH_CARD_TEXT(card, 2, "failed");
 	} while ((--cnt > 0) && rc);
@@ -707,8 +712,7 @@ static int qeth_l3_deregister_addr_entry(struct qeth_card *card,
 	if (addr->is_multicast)
 		rc = qeth_l3_send_setdelmc(card, addr, IPA_CMD_DELIPM);
 	else
-		rc = qeth_l3_send_setdelip(card, addr, IPA_CMD_DELIP,
-					addr->del_flags);
+		rc = qeth_l3_send_setdelip(card, addr, IPA_CMD_DELIP);
 	if (rc)
 		QETH_CARD_TEXT(card, 2, "failed");
 
-- 
2.13.5
