Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727089AbfJaMme (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 08:42:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCclDn137847
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyxn2jwt6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:32 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 31 Oct 2019 12:42:31 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/8] s390/qeth: don't cache MAC addresses for multicast IPs
Date: Thu, 31 Oct 2019 13:42:21 +0100
In-Reply-To: <20191031124221.34028-1-jwi@linux.ibm.com>
References: <20191031124221.34028-1-jwi@linux.ibm.com>
Message-Id: <20191031124221.34028-9-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Instead of storing the multicast-mapped MAC address in an IP address
object, just calculate the MAC address when actually building a cmd
for the IP address.

While at it, also clean up some rather verbose copying of IP addresses.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_mpc.h |  4 ++--
 drivers/s390/net/qeth_l3.h       |  3 ---
 drivers/s390/net/qeth_l3_main.c  | 24 ++++++++++--------------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 6420b58cf42b..9ad0d6f9d48b 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -11,6 +11,7 @@
 
 #include <asm/qeth.h>
 #include <uapi/linux/if_ether.h>
+#include <uapi/linux/in6.h>
 
 #define IPA_PDU_HEADER_SIZE	0x40
 #define QETH_IPA_PDU_LEN_TOTAL(buffer) (buffer + 0x0e)
@@ -365,8 +366,7 @@ struct qeth_ipacmd_setdelip6 {
 struct qeth_ipacmd_setdelipm {
 	__u8 mac[6];
 	__u8 padding[2];
-	__u8 ip6[12];
-	__u8 ip4[4];
+	struct in6_addr ip;
 } __attribute__ ((packed));
 
 struct qeth_ipacmd_layer2setdelmac {
diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index b7ba404a81f9..ba913d1ab88d 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -24,7 +24,6 @@ enum qeth_ip_types {
 struct qeth_ipaddr {
 	struct hlist_node hnode;
 	enum qeth_ip_types type;
-	unsigned char mac[ETH_ALEN];
 	u8 is_multicast:1;
 	u8 in_progress:1;
 	u8 disp_flag:2;
@@ -74,12 +73,10 @@ static inline bool qeth_l3_addr_match_all(struct qeth_ipaddr *a1,
 	 * so 'proto' and 'addr' match for sure.
 	 *
 	 * For ucast:
-	 * -	'mac' is always 0.
 	 * -	'mask'/'pfxlen' for RXIP/VIPA is always 0. For NORMAL, matching
 	 *	values are required to avoid mixups in takeover eligibility.
 	 *
 	 * For mcast,
-	 * -	'mac' is mapped from the IP, and thus always matches.
 	 * -	'mask'/'pfxlen' is always 0.
 	 */
 	if (a1->type != a2->type)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8f92407bf580..70d4586dc779 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -381,12 +381,13 @@ static int qeth_l3_send_setdelmc(struct qeth_card *card,
 	if (!iob)
 		return -ENOMEM;
 	cmd = __ipa_cmd(iob);
-	ether_addr_copy(cmd->data.setdelipm.mac, addr->mac);
-	if (addr->proto == QETH_PROT_IPV6)
-		memcpy(cmd->data.setdelipm.ip6, &addr->u.a6.addr,
-		       sizeof(struct in6_addr));
-	else
-		memcpy(&cmd->data.setdelipm.ip4, &addr->u.a4.addr, 4);
+	if (addr->proto == QETH_PROT_IPV6) {
+		cmd->data.setdelipm.ip = addr->u.a6.addr;
+		ipv6_eth_mc_map(&addr->u.a6.addr, cmd->data.setdelipm.mac);
+	} else {
+		cmd->data.setdelipm.ip.s6_addr32[3] = addr->u.a4.addr;
+		ip_eth_mc_map(addr->u.a4.addr, cmd->data.setdelipm.mac);
+	}
 
 	return qeth_send_ipa_cmd(card, iob, qeth_l3_setdelip_cb, NULL);
 }
@@ -1127,7 +1128,6 @@ qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 
 	for (im4 = rcu_dereference(in4_dev->mc_list); im4 != NULL;
 	     im4 = rcu_dereference(im4->next_rcu)) {
-		ip_eth_mc_map(im4->multiaddr, tmp->mac);
 		tmp->u.a4.addr = im4->multiaddr;
 		tmp->is_multicast = 1;
 
@@ -1139,7 +1139,7 @@ qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 			ipm = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
 			if (!ipm)
 				continue;
-			ether_addr_copy(ipm->mac, tmp->mac);
+
 			ipm->u.a4.addr = im4->multiaddr;
 			ipm->is_multicast = 1;
 			ipm->disp_flag = QETH_DISP_ADDR_ADD;
@@ -1207,9 +1207,7 @@ static void qeth_l3_add_mc6_to_hash(struct qeth_card *card,
 		return;
 
 	for (im6 = in6_dev->mc_list; im6 != NULL; im6 = im6->next) {
-		ipv6_eth_mc_map(&im6->mca_addr, tmp->mac);
-		memcpy(&tmp->u.a6.addr, &im6->mca_addr.s6_addr,
-		       sizeof(struct in6_addr));
+		tmp->u.a6.addr = im6->mca_addr;
 		tmp->is_multicast = 1;
 
 		ipm = qeth_l3_find_addr_by_ip(card, tmp);
@@ -1223,9 +1221,7 @@ static void qeth_l3_add_mc6_to_hash(struct qeth_card *card,
 		if (!ipm)
 			continue;
 
-		ether_addr_copy(ipm->mac, tmp->mac);
-		memcpy(&ipm->u.a6.addr, &im6->mca_addr.s6_addr,
-		       sizeof(struct in6_addr));
+		ipm->u.a6.addr = im6->mca_addr;
 		ipm->is_multicast = 1;
 		ipm->disp_flag = QETH_DISP_ADDR_ADD;
 		hash_add(card->ip_mc_htable,
-- 
2.17.1
