From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 07/15] s390/qeth: use ether_addr_* helpers
Date: Wed, 20 Dec 2017 20:11:01 +0100
Message-ID: <20171220191109.90487-8-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Be a little more self-documenting, and get rid of OSA_ADDR_LEN.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 11 +++++------
 drivers/s390/net/qeth_core_mpc.h  | 13 ++++++-------
 drivers/s390/net/qeth_l2.h        |  2 +-
 drivers/s390/net/qeth_l2_main.c   | 12 ++++++------
 drivers/s390/net/qeth_l3.h        |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 29 +++++++++++++----------------
 6 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index bc4e57540a9e..a007f6249166 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4216,9 +4216,8 @@ static int qeth_setadpparms_change_macaddr_cb(struct qeth_card *card,
 	cmd = (struct qeth_ipa_cmd *) data;
 	if (!card->options.layer2 ||
 	    !(card->info.mac_bits & QETH_LAYER2_MAC_READ)) {
-		memcpy(card->dev->dev_addr,
-		       &cmd->data.setadapterparms.data.change_addr.addr,
-		       OSA_ADDR_LEN);
+		ether_addr_copy(card->dev->dev_addr,
+				cmd->data.setadapterparms.data.change_addr.addr);
 		card->info.mac_bits |= QETH_LAYER2_MAC_READ;
 	}
 	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
@@ -4240,9 +4239,9 @@ int qeth_setadpparms_change_macaddr(struct qeth_card *card)
 		return -ENOMEM;
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
 	cmd->data.setadapterparms.data.change_addr.cmd = CHANGE_ADDR_READ_MAC;
-	cmd->data.setadapterparms.data.change_addr.addr_size = OSA_ADDR_LEN;
-	memcpy(&cmd->data.setadapterparms.data.change_addr.addr,
-	       card->dev->dev_addr, OSA_ADDR_LEN);
+	cmd->data.setadapterparms.data.change_addr.addr_size = ETH_ALEN;
+	ether_addr_copy(cmd->data.setadapterparms.data.change_addr.addr,
+			card->dev->dev_addr);
 	rc = qeth_send_ipa_cmd(card, iob, qeth_setadpparms_change_macaddr_cb,
 			       NULL);
 	return rc;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index ff6877f7b6f8..619f897b4bb0 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -10,6 +10,7 @@
 #define __QETH_CORE_MPC_H__
 
 #include <asm/qeth.h>
+#include <uapi/linux/if_ether.h>
 
 #define IPA_PDU_HEADER_SIZE	0x40
 #define QETH_IPA_PDU_LEN_TOTAL(buffer) (buffer + 0x0e)
@@ -25,7 +26,6 @@ extern unsigned char IPA_PDU_HEADER[];
 #define QETH_SEQ_NO_LENGTH	4
 #define QETH_MPC_TOKEN_LENGTH	4
 #define QETH_MCL_LENGTH		4
-#define OSA_ADDR_LEN		6
 
 #define QETH_TIMEOUT		(10 * HZ)
 #define QETH_IPA_TIMEOUT	(45 * HZ)
@@ -416,12 +416,11 @@ struct qeth_query_cmds_supp {
 } __attribute__ ((packed));
 
 struct qeth_change_addr {
-	__u32 cmd;
-	__u32 addr_size;
-	__u32 no_macs;
-	__u8 addr[OSA_ADDR_LEN];
-} __attribute__ ((packed));
-
+	u32 cmd;
+	u32 addr_size;
+	u32 no_macs;
+	u8 addr[ETH_ALEN];
+};
 
 struct qeth_snmp_cmd {
 	__u8  token[16];
diff --git a/drivers/s390/net/qeth_l2.h b/drivers/s390/net/qeth_l2.h
index 3223601cc3ac..f2130051ca11 100644
--- a/drivers/s390/net/qeth_l2.h
+++ b/drivers/s390/net/qeth_l2.h
@@ -22,7 +22,7 @@ int qeth_l2_vnicc_get_timeout(struct qeth_card *card, u32 *timeout);
 bool qeth_l2_vnicc_is_in_use(struct qeth_card *card);
 
 struct qeth_mac {
-	u8 mac_addr[OSA_ADDR_LEN];
+	u8 mac_addr[ETH_ALEN];
 	u8 disp_flag:2;
 	struct hlist_node hnode;
 };
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 94079e2c462d..7c635abc79d2 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -109,8 +109,8 @@ static int qeth_l2_send_setdelmac(struct qeth_card *card, __u8 *mac,
 	if (!iob)
 		return -ENOMEM;
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	cmd->data.setdelmac.mac_length = OSA_ADDR_LEN;
-	memcpy(&cmd->data.setdelmac.mac, mac, OSA_ADDR_LEN);
+	cmd->data.setdelmac.mac_length = ETH_ALEN;
+	ether_addr_copy(cmd->data.setdelmac.mac, mac);
 	return qeth_setdelmac_makerc(card, qeth_send_ipa_cmd(card, iob,
 					   NULL, NULL));
 }
@@ -123,7 +123,7 @@ static int qeth_l2_send_setmac(struct qeth_card *card, __u8 *mac)
 	rc = qeth_l2_send_setdelmac(card, mac, IPA_CMD_SETVMAC);
 	if (rc == 0) {
 		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
-		memcpy(card->dev->dev_addr, mac, OSA_ADDR_LEN);
+		ether_addr_copy(card->dev->dev_addr, mac);
 		dev_info(&card->gdev->dev,
 			"MAC address %pM successfully registered on device %s\n",
 			card->dev->dev_addr, card->dev->name);
@@ -532,7 +532,7 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 		QETH_CARD_TEXT(card, 3, "setmcTYP");
 		return -EOPNOTSUPP;
 	}
-	QETH_CARD_HEX(card, 3, addr->sa_data, OSA_ADDR_LEN);
+	QETH_CARD_HEX(card, 3, addr->sa_data, ETH_ALEN);
 	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
 		QETH_CARD_TEXT(card, 3, "setmcREC");
 		return -ERESTARTSYS;
@@ -586,7 +586,7 @@ static void qeth_l2_add_mac(struct qeth_card *card, struct netdev_hw_addr *ha)
 	struct qeth_mac *mac;
 
 	hash_for_each_possible(card->mac_htable, mac, hnode, mac_hash) {
-		if (!memcmp(ha->addr, mac->mac_addr, OSA_ADDR_LEN)) {
+		if (ether_addr_equal_64bits(ha->addr, mac->mac_addr)) {
 			mac->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			return;
 		}
@@ -596,7 +596,7 @@ static void qeth_l2_add_mac(struct qeth_card *card, struct netdev_hw_addr *ha)
 	if (!mac)
 		return;
 
-	memcpy(mac->mac_addr, ha->addr, OSA_ADDR_LEN);
+	ether_addr_copy(mac->mac_addr, ha->addr);
 	mac->disp_flag = QETH_DISP_ADDR_ADD;
 
 	hash_add(card->mac_htable, &mac->hnode, mac_hash);
diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index e5833837b799..071c00841208 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -29,7 +29,7 @@ struct qeth_ipaddr {
 	 */
 	int  ref_counter;
 	enum qeth_prot_versions proto;
-	unsigned char mac[OSA_ADDR_LEN];
+	unsigned char mac[ETH_ALEN];
 	union {
 		struct {
 			unsigned int addr;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0404d5c61ad7..519042d6f94a 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -207,8 +207,8 @@ inline int
 qeth_l3_ipaddrs_is_equal(struct qeth_ipaddr *addr1, struct qeth_ipaddr *addr2)
 {
 	return addr1->proto == addr2->proto &&
-		!memcmp(&addr1->u, &addr2->u, sizeof(addr1->u))  &&
-		!memcmp(&addr1->mac, &addr2->mac, sizeof(addr1->mac));
+	       !memcmp(&addr1->u, &addr2->u, sizeof(addr1->u)) &&
+	       ether_addr_equal_64bits(addr1->mac, addr2->mac);
 }
 
 static struct qeth_ipaddr *
@@ -446,7 +446,7 @@ static int qeth_l3_send_setdelmc(struct qeth_card *card,
 	if (!iob)
 		return -ENOMEM;
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	memcpy(&cmd->data.setdelipm.mac, addr->mac, OSA_ADDR_LEN);
+	ether_addr_copy(cmd->data.setdelipm.mac, addr->mac);
 	if (addr->proto == QETH_PROT_IPV6)
 		memcpy(cmd->data.setdelipm.ip6, &addr->u.a6.addr,
 		       sizeof(struct in6_addr));
@@ -1168,8 +1168,8 @@ static int qeth_l3_iqd_read_initial_mac_cb(struct qeth_card *card,
 
 	cmd = (struct qeth_ipa_cmd *) data;
 	if (cmd->hdr.return_code == 0)
-		memcpy(card->dev->dev_addr,
-			cmd->data.create_destroy_addr.unique_id, ETH_ALEN);
+		ether_addr_copy(card->dev->dev_addr,
+				cmd->data.create_destroy_addr.unique_id);
 	else
 		eth_random_addr(card->dev->dev_addr);
 
@@ -1392,7 +1392,7 @@ qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 			ipm = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
 			if (!ipm)
 				continue;
-			memcpy(ipm->mac, tmp->mac, sizeof(tmp->mac));
+			ether_addr_copy(ipm->mac, tmp->mac);
 			ipm->u.a4.addr = be32_to_cpu(im4->multiaddr);
 			ipm->is_multicast = 1;
 			ipm->disp_flag = QETH_DISP_ADDR_ADD;
@@ -1475,7 +1475,7 @@ static void qeth_l3_add_mc6_to_hash(struct qeth_card *card,
 		if (!ipm)
 			continue;
 
-		memcpy(ipm->mac, tmp->mac, sizeof(tmp->mac));
+		ether_addr_copy(ipm->mac, tmp->mac);
 		memcpy(&ipm->u.a6.addr, &im6->mca_addr.s6_addr,
 		       sizeof(struct in6_addr));
 		ipm->is_multicast = 1;
@@ -1652,11 +1652,10 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 				struct qeth_hdr *hdr)
 {
-	unsigned char tg_addr[MAX_ADDR_LEN];
-
 	if (!(hdr->hdr.l3.flags & QETH_HDR_PASSTHRU)) {
 		u16 prot = (hdr->hdr.l3.flags & QETH_HDR_IPV6) ? ETH_P_IPV6 :
 								 ETH_P_IP;
+		unsigned char tg_addr[ETH_ALEN];
 
 		skb_reset_network_header(skb);
 		switch (hdr->hdr.l3.flags & QETH_HDR_CAST_MASK) {
@@ -1670,8 +1669,7 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 			skb->pkt_type = PACKET_MULTICAST;
 			break;
 		case QETH_CAST_BROADCAST:
-			memcpy(tg_addr, card->dev->broadcast,
-				card->dev->addr_len);
+			ether_addr_copy(tg_addr, card->dev->broadcast);
 			card->stats.multicast++;
 			skb->pkt_type = PACKET_BROADCAST;
 			break;
@@ -1683,8 +1681,7 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 				skb->pkt_type = PACKET_OTHERHOST;
 			else
 				skb->pkt_type = PACKET_HOST;
-			memcpy(tg_addr, card->dev->dev_addr,
-				card->dev->addr_len);
+			ether_addr_copy(tg_addr, card->dev->dev_addr);
 		}
 		if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_SRC_MAC_ADDR)
 			card->dev->header_ops->create(skb, card->dev, prot,
@@ -2411,7 +2408,7 @@ static int qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
 		return ((skb_network_header(skb)[16] & 0xf0) == 0xe0) ?
 				RTN_MULTICAST : 0;
 	/* ... */
-	if (!memcmp(skb->data, skb->dev->broadcast, 6))
+	if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest, skb->dev->broadcast))
 		return RTN_BROADCAST;
 	else {
 		u16 hdr_mac;
@@ -2504,8 +2501,8 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 			hdr->hdr.l3.flags &= ~QETH_HDR_PASSTHRU;
 		memcpy(hdr->hdr.l3.dest_addr, pkey, 16);
 	} else {
-		if (!memcmp(skb->data + sizeof(struct qeth_hdr),
-			    skb->dev->broadcast, 6)) {
+		if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
+					    skb->dev->broadcast)) {
 			/* broadcast? */
 			hdr->hdr.l3.flags = QETH_CAST_BROADCAST |
 						QETH_HDR_PASSTHRU;
-- 
2.13.5
