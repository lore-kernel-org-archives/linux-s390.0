Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727141AbfJaMme (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 08:42:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCeCl5000686
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyy9fhcrc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 31 Oct 2019 12:42:31 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/8] s390/qeth: use helpers for IP address hashing
Date: Thu, 31 Oct 2019 13:42:20 +0100
In-Reply-To: <20191031124221.34028-1-jwi@linux.ibm.com>
References: <20191031124221.34028-1-jwi@linux.ibm.com>
Message-Id: <20191031124221.34028-8-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Replace our custom implementations with the stack's version of IP address
hashing.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3.h      | 21 ++++++---------------
 drivers/s390/net/qeth_l3_main.c |  8 ++++----
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index 87659cfc9066..b7ba404a81f9 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -37,7 +37,7 @@ struct qeth_ipaddr {
 	enum qeth_prot_versions proto;
 	union {
 		struct {
-			unsigned int addr;
+			__be32 addr;
 			unsigned int mask;
 		} a4;
 		struct {
@@ -89,21 +89,12 @@ static inline bool qeth_l3_addr_match_all(struct qeth_ipaddr *a1,
 	return a1->u.a4.mask == a2->u.a4.mask;
 }
 
-static inline  u64 qeth_l3_ipaddr_hash(struct qeth_ipaddr *addr)
+static inline u32 qeth_l3_ipaddr_hash(struct qeth_ipaddr *addr)
 {
-	u64  ret = 0;
-	u8 *point;
-
-	if (addr->proto == QETH_PROT_IPV6) {
-		point = (u8 *) &addr->u.a6.addr;
-		ret = get_unaligned((u64 *)point) ^
-			get_unaligned((u64 *) (point + 8));
-	}
-	if (addr->proto == QETH_PROT_IPV4) {
-		point = (u8 *) &addr->u.a4.addr;
-		ret = get_unaligned((u32 *) point);
-	}
-	return ret;
+	if (addr->proto == QETH_PROT_IPV6)
+		return ipv6_addr_hash(&addr->u.a6.addr);
+	else
+		return ipv4_addr_hash(addr->u.a4.addr);
 }
 
 struct qeth_ipato_entry {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index acae44a699ad..8f92407bf580 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -76,7 +76,7 @@ static struct qeth_ipaddr *qeth_l3_get_addr_buffer(enum qeth_prot_versions prot)
 static struct qeth_ipaddr *qeth_l3_find_addr_by_ip(struct qeth_card *card,
 						   struct qeth_ipaddr *query)
 {
-	u64 key = qeth_l3_ipaddr_hash(query);
+	u32 key = qeth_l3_ipaddr_hash(query);
 	struct qeth_ipaddr *addr;
 
 	if (query->is_multicast) {
@@ -1128,7 +1128,7 @@ qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 	for (im4 = rcu_dereference(in4_dev->mc_list); im4 != NULL;
 	     im4 = rcu_dereference(im4->next_rcu)) {
 		ip_eth_mc_map(im4->multiaddr, tmp->mac);
-		tmp->u.a4.addr = be32_to_cpu(im4->multiaddr);
+		tmp->u.a4.addr = im4->multiaddr;
 		tmp->is_multicast = 1;
 
 		ipm = qeth_l3_find_addr_by_ip(card, tmp);
@@ -1140,7 +1140,7 @@ qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 			if (!ipm)
 				continue;
 			ether_addr_copy(ipm->mac, tmp->mac);
-			ipm->u.a4.addr = be32_to_cpu(im4->multiaddr);
+			ipm->u.a4.addr = im4->multiaddr;
 			ipm->is_multicast = 1;
 			ipm->disp_flag = QETH_DISP_ADDR_ADD;
 			hash_add(card->ip_mc_htable,
@@ -2548,7 +2548,7 @@ static int qeth_l3_ip_event(struct notifier_block *this,
 	QETH_CARD_TEXT(card, 3, "ipevent");
 
 	qeth_l3_init_ipaddr(&addr, QETH_IP_TYPE_NORMAL, QETH_PROT_IPV4);
-	addr.u.a4.addr = be32_to_cpu(ifa->ifa_address);
+	addr.u.a4.addr = ifa->ifa_address;
 	addr.u.a4.mask = be32_to_cpu(ifa->ifa_mask);
 
 	return qeth_l3_handle_ip_event(card, &addr, event);
-- 
2.17.1
