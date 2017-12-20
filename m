From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 06/15] s390/qeth: consolidate qeth MAC address helpers
Date: Wed, 20 Dec 2017 20:11:00 +0100
Message-ID: <20171220191109.90487-7-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

For adding/removing a MAC address, use just one helper each that
handles both unicast and multicast.
Saves one level of indirection for multicast addresses, while improving
the error reporting for unicast addresses.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 47 ++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 88dd92954eec..94079e2c462d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -156,48 +156,37 @@ static int qeth_l2_send_delmac(struct qeth_card *card, __u8 *mac)
 	return rc;
 }
 
-static int qeth_l2_send_setgroupmac(struct qeth_card *card, __u8 *mac)
+static int qeth_l2_write_mac(struct qeth_card *card, u8 *mac)
 {
+	enum qeth_ipa_cmds cmd = is_multicast_ether_addr_64bits(mac) ?
+					IPA_CMD_SETGMAC : IPA_CMD_SETVMAC;
 	int rc;
 
-	QETH_CARD_TEXT(card, 2, "L2Sgmac");
-	rc = qeth_l2_send_setdelmac(card, mac, IPA_CMD_SETGMAC);
+	QETH_CARD_TEXT(card, 2, "L2Wmac");
+	rc = qeth_l2_send_setdelmac(card, mac, cmd);
 	if (rc == -EEXIST)
-		QETH_DBF_MESSAGE(2, "Group MAC %pM already existing on %s\n",
-			mac, QETH_CARD_IFNAME(card));
+		QETH_DBF_MESSAGE(2, "MAC %pM already registered on %s\n",
+				 mac, QETH_CARD_IFNAME(card));
 	else if (rc)
-		QETH_DBF_MESSAGE(2, "Could not set group MAC %pM on %s: %d\n",
-			mac, QETH_CARD_IFNAME(card), rc);
+		QETH_DBF_MESSAGE(2, "Failed to register MAC %pM on %s: %d\n",
+				 mac, QETH_CARD_IFNAME(card), rc);
 	return rc;
 }
 
-static int qeth_l2_send_delgroupmac(struct qeth_card *card, __u8 *mac)
+static int qeth_l2_remove_mac(struct qeth_card *card, u8 *mac)
 {
+	enum qeth_ipa_cmds cmd = is_multicast_ether_addr_64bits(mac) ?
+					IPA_CMD_DELGMAC : IPA_CMD_DELVMAC;
 	int rc;
 
-	QETH_CARD_TEXT(card, 2, "L2Dgmac");
-	rc = qeth_l2_send_setdelmac(card, mac, IPA_CMD_DELGMAC);
+	QETH_CARD_TEXT(card, 2, "L2Rmac");
+	rc = qeth_l2_send_setdelmac(card, mac, cmd);
 	if (rc)
-		QETH_DBF_MESSAGE(2,
-			"Could not delete group MAC %pM on %s: %d\n",
-			mac, QETH_CARD_IFNAME(card), rc);
+		QETH_DBF_MESSAGE(2, "Failed to delete MAC %pM on %s: %d\n",
+				 mac, QETH_CARD_IFNAME(card), rc);
 	return rc;
 }
 
-static int qeth_l2_write_mac(struct qeth_card *card, struct qeth_mac *mac)
-{
-	if (is_multicast_ether_addr_64bits(mac->mac_addr))
-		return qeth_l2_send_setgroupmac(card, mac->mac_addr);
-	return qeth_l2_send_setdelmac(card, mac->mac_addr, IPA_CMD_SETVMAC);
-}
-
-static int qeth_l2_remove_mac(struct qeth_card *card, struct qeth_mac *mac)
-{
-	if (is_multicast_ether_addr_64bits(mac->mac_addr))
-		return qeth_l2_send_delgroupmac(card, mac->mac_addr);
-	return qeth_l2_send_setdelmac(card, mac->mac_addr, IPA_CMD_DELVMAC);
-}
-
 static void qeth_l2_del_all_macs(struct qeth_card *card)
 {
 	struct qeth_mac *mac;
@@ -639,12 +628,12 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 
 	hash_for_each_safe(card->mac_htable, i, tmp, mac, hnode) {
 		if (mac->disp_flag == QETH_DISP_ADDR_DELETE) {
-			qeth_l2_remove_mac(card, mac);
+			qeth_l2_remove_mac(card, mac->mac_addr);
 			hash_del(&mac->hnode);
 			kfree(mac);
 
 		} else if (mac->disp_flag == QETH_DISP_ADDR_ADD) {
-			rc = qeth_l2_write_mac(card, mac);
+			rc = qeth_l2_write_mac(card, mac->mac_addr);
 			if (rc) {
 				hash_del(&mac->hnode);
 				kfree(mac);
-- 
2.13.5
