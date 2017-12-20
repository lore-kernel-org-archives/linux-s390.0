From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 05/15] s390/qeth: don't keep track of MAC address's cast type
Date: Wed, 20 Dec 2017 20:10:59 +0100
Message-ID: <20171220191109.90487-6-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Instead of tracking the uc/mc state in each MAC address object, just
check the multicast bit in the address itself.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2.h      |  1 -
 drivers/s390/net/qeth_l2_main.c | 27 ++++++++-------------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/net/qeth_l2.h b/drivers/s390/net/qeth_l2.h
index 09b1c4ef3dc9..3223601cc3ac 100644
--- a/drivers/s390/net/qeth_l2.h
+++ b/drivers/s390/net/qeth_l2.h
@@ -23,7 +23,6 @@ bool qeth_l2_vnicc_is_in_use(struct qeth_card *card);
 
 struct qeth_mac {
 	u8 mac_addr[OSA_ADDR_LEN];
-	u8 is_uc:1;
 	u8 disp_flag:2;
 	struct hlist_node hnode;
 };
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 5863ea170ff2..88dd92954eec 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -186,22 +186,16 @@ static int qeth_l2_send_delgroupmac(struct qeth_card *card, __u8 *mac)
 
 static int qeth_l2_write_mac(struct qeth_card *card, struct qeth_mac *mac)
 {
-	if (mac->is_uc) {
-		return qeth_l2_send_setdelmac(card, mac->mac_addr,
-						IPA_CMD_SETVMAC);
-	} else {
+	if (is_multicast_ether_addr_64bits(mac->mac_addr))
 		return qeth_l2_send_setgroupmac(card, mac->mac_addr);
-	}
+	return qeth_l2_send_setdelmac(card, mac->mac_addr, IPA_CMD_SETVMAC);
 }
 
 static int qeth_l2_remove_mac(struct qeth_card *card, struct qeth_mac *mac)
 {
-	if (mac->is_uc) {
-		return qeth_l2_send_setdelmac(card, mac->mac_addr,
-						IPA_CMD_DELVMAC);
-	} else {
+	if (is_multicast_ether_addr_64bits(mac->mac_addr))
 		return qeth_l2_send_delgroupmac(card, mac->mac_addr);
-	}
+	return qeth_l2_send_setdelmac(card, mac->mac_addr, IPA_CMD_DELVMAC);
 }
 
 static void qeth_l2_del_all_macs(struct qeth_card *card)
@@ -597,27 +591,23 @@ static void qeth_promisc_to_bridge(struct qeth_card *card)
  * only if there is not in the hash table storage already
  *
 */
-static void qeth_l2_add_mac(struct qeth_card *card, struct netdev_hw_addr *ha,
-			    u8 is_uc)
+static void qeth_l2_add_mac(struct qeth_card *card, struct netdev_hw_addr *ha)
 {
 	u32 mac_hash = get_unaligned((u32 *)(&ha->addr[2]));
 	struct qeth_mac *mac;
 
 	hash_for_each_possible(card->mac_htable, mac, hnode, mac_hash) {
-		if (is_uc == mac->is_uc &&
-		    !memcmp(ha->addr, mac->mac_addr, OSA_ADDR_LEN)) {
+		if (!memcmp(ha->addr, mac->mac_addr, OSA_ADDR_LEN)) {
 			mac->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			return;
 		}
 	}
 
 	mac = kzalloc(sizeof(struct qeth_mac), GFP_ATOMIC);
-
 	if (!mac)
 		return;
 
 	memcpy(mac->mac_addr, ha->addr, OSA_ADDR_LEN);
-	mac->is_uc = is_uc;
 	mac->disp_flag = QETH_DISP_ADDR_ADD;
 
 	hash_add(card->mac_htable, &mac->hnode, mac_hash);
@@ -643,10 +633,9 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 	spin_lock_bh(&card->mclock);
 
 	netdev_for_each_mc_addr(ha, dev)
-		qeth_l2_add_mac(card, ha, 0);
-
+		qeth_l2_add_mac(card, ha);
 	netdev_for_each_uc_addr(ha, dev)
-		qeth_l2_add_mac(card, ha, 1);
+		qeth_l2_add_mac(card, ha);
 
 	hash_for_each_safe(card->mac_htable, i, tmp, mac, hnode) {
 		if (mac->disp_flag == QETH_DISP_ADDR_DELETE) {
-- 
2.13.5
