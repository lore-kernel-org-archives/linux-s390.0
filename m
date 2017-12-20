From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 03/15] s390/qeth: use ip*_eth_mc_map helpers
Date: Wed, 20 Dec 2017 20:10:57 +0100
Message-ID: <20171220191109.90487-4-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Get rid of some wrapper indirection, and stop accessing the skb at
hard-coded offsets.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 43 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ef0961e18686..aeff11ad1de5 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1328,11 +1328,6 @@ qeth_diags_trace(struct qeth_card *card, enum qeth_diags_trace_cmds diags_cmd)
 	return qeth_send_ipa_cmd(card, iob, qeth_diags_trace_cb, NULL);
 }
 
-static void qeth_l3_get_mac_for_ipm(__be32 ipm, char *mac)
-{
-	ip_eth_mc_map(ipm, mac);
-}
-
 static void qeth_l3_mark_all_mc_to_be_deleted(struct qeth_card *card)
 {
 	struct qeth_ipaddr *addr;
@@ -1383,26 +1378,22 @@ static void qeth_l3_delete_nonused_mc(struct qeth_card *card)
 
 }
 
-
 static void
 qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 {
 	struct ip_mc_list *im4;
 	struct qeth_ipaddr *tmp, *ipm;
-	char buf[MAX_ADDR_LEN];
 
 	QETH_CARD_TEXT(card, 4, "addmc");
 
 	tmp = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
-		if (!tmp)
-			return;
+	if (!tmp)
+		return;
 
 	for (im4 = rcu_dereference(in4_dev->mc_list); im4 != NULL;
 	     im4 = rcu_dereference(im4->next_rcu)) {
-		qeth_l3_get_mac_for_ipm(im4->multiaddr, buf);
-
+		ip_eth_mc_map(im4->multiaddr, tmp->mac);
 		tmp->u.a4.addr = be32_to_cpu(im4->multiaddr);
-		memcpy(tmp->mac, buf, sizeof(tmp->mac));
 		tmp->is_multicast = 1;
 
 		ipm = qeth_l3_ip_from_hash(card, tmp);
@@ -1412,7 +1403,7 @@ qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 			ipm = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
 			if (!ipm)
 				continue;
-			memcpy(ipm->mac, buf, sizeof(tmp->mac));
+			memcpy(ipm->mac, tmp->mac, sizeof(tmp->mac));
 			ipm->u.a4.addr = be32_to_cpu(im4->multiaddr);
 			ipm->is_multicast = 1;
 			ipm->disp_flag = QETH_DISP_ADDR_ADD;
@@ -1473,18 +1464,15 @@ qeth_l3_add_mc6_to_hash(struct qeth_card *card, struct inet6_dev *in6_dev)
 	struct qeth_ipaddr *ipm;
 	struct ifmcaddr6 *im6;
 	struct qeth_ipaddr *tmp;
-	char buf[MAX_ADDR_LEN];
 
 	QETH_CARD_TEXT(card, 4, "addmc6");
 
 	tmp = qeth_l3_get_addr_buffer(QETH_PROT_IPV6);
-		if (!tmp)
-			return;
+	if (!tmp)
+		return;
 
 	for (im6 = in6_dev->mc_list; im6 != NULL; im6 = im6->next) {
-		ndisc_mc_map(&im6->mca_addr, buf, in6_dev->dev, 0);
-
-		memcpy(tmp->mac, buf, sizeof(tmp->mac));
+		ipv6_eth_mc_map(&im6->mca_addr, tmp->mac);
 		memcpy(&tmp->u.a6.addr, &im6->mca_addr.s6_addr,
 		       sizeof(struct in6_addr));
 		tmp->is_multicast = 1;
@@ -1499,7 +1487,7 @@ qeth_l3_add_mc6_to_hash(struct qeth_card *card, struct inet6_dev *in6_dev)
 		if (!ipm)
 			continue;
 
-		memcpy(ipm->mac, buf, OSA_ADDR_LEN);
+		memcpy(ipm->mac, tmp->mac, sizeof(tmp->mac));
 		memcpy(&ipm->u.a6.addr, &im6->mca_addr.s6_addr,
 		       sizeof(struct in6_addr));
 		ipm->is_multicast = 1;
@@ -1679,26 +1667,23 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 				struct qeth_hdr *hdr)
 {
-	__u16 prot;
-	struct iphdr *ip_hdr;
 	unsigned char tg_addr[MAX_ADDR_LEN];
 
 	if (!(hdr->hdr.l3.flags & QETH_HDR_PASSTHRU)) {
-		prot = (hdr->hdr.l3.flags & QETH_HDR_IPV6) ? ETH_P_IPV6 :
-			      ETH_P_IP;
+		u16 prot = (hdr->hdr.l3.flags & QETH_HDR_IPV6) ? ETH_P_IPV6 :
+								 ETH_P_IP;
+
+		skb_reset_network_header(skb);
 		switch (hdr->hdr.l3.flags & QETH_HDR_CAST_MASK) {
 		case QETH_CAST_MULTICAST:
 			switch (prot) {
 #ifdef CONFIG_QETH_IPV6
 			case ETH_P_IPV6:
-				ndisc_mc_map((struct in6_addr *)
-				     skb->data + 24,
-				     tg_addr, card->dev, 0);
+				ipv6_eth_mc_map(&ipv6_hdr(skb)->daddr, tg_addr);
 				break;
 #endif
 			case ETH_P_IP:
-				ip_hdr = (struct iphdr *)skb->data;
-				ip_eth_mc_map(ip_hdr->daddr, tg_addr);
+				ip_eth_mc_map(ip_hdr(skb)->daddr, tg_addr);
 				break;
 			default:
 				memcpy(tg_addr, card->dev->broadcast,
-- 
2.13.5
