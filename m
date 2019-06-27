Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbfF0PBy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 11:01:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RF0ma3132578
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:01:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcwrf081h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:01:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Jun 2019 16:01:42 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/12] s390/qeth: consolidate skb RX processing in L3 driver
Date: Thu, 27 Jun 2019 17:01:31 +0200
In-Reply-To: <20190627150133.58746-1-jwi@linux.ibm.com>
References: <20190627150133.58746-1-jwi@linux.ibm.com>
Message-Id: <20190627150133.58746-11-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Use napi_gro_receive() to pass up all types of packets that a L3 device
may receive.
1) For proper L2 packets received by the IQD sniffer, this is the
   obvious thing to do.
2) For af_iucv (which doesn't provide a GRO assist), the GRO code will
   transparently fall back to netif_receive_skb(). So there's no need to
   special-case this traffic in our code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 44a602aa12ec..15351922b209 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1312,6 +1312,15 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 				struct qeth_hdr *hdr)
 {
+	struct af_iucv_trans_hdr *iucv = (struct af_iucv_trans_hdr *) skb->data;
+	struct net_device *dev = skb->dev;
+
+	if (IS_IQD(card) && iucv->magic == ETH_P_AF_IUCV) {
+		dev_hard_header(skb, dev, ETH_P_AF_IUCV, dev->dev_addr,
+				"FAKELL", skb->len);
+		return;
+	}
+
 	if (!(hdr->hdr.l3.flags & QETH_HDR_PASSTHRU)) {
 		u16 prot = (hdr->hdr.l3.flags & QETH_HDR_IPV6) ? ETH_P_IPV6 :
 								 ETH_P_IP;
@@ -1345,8 +1354,6 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 				tg_addr, "FAKELL", skb->len);
 	}
 
-	skb->protocol = eth_type_trans(skb, card->dev);
-
 	/* copy VLAN tag from hdr into skb */
 	if (!card->options.sniffer &&
 	    (hdr->hdr.l3.ext_flags & (QETH_HDR_EXT_VLAN_FRAME |
@@ -1363,12 +1370,10 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 				int budget, int *done)
 {
-	struct net_device *dev = card->dev;
 	int work_done = 0;
 	struct sk_buff *skb;
 	struct qeth_hdr *hdr;
 	unsigned int len;
-	__u16 magic;
 
 	*done = 0;
 	WARN_ON_ONCE(!budget);
@@ -1382,23 +1387,12 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 		}
 		switch (hdr->hdr.l3.id) {
 		case QETH_HEADER_TYPE_LAYER3:
-			magic = *(__u16 *)skb->data;
-			if (IS_IQD(card) && magic == ETH_P_AF_IUCV) {
-				len = skb->len;
-				dev_hard_header(skb, dev, ETH_P_AF_IUCV,
-						dev->dev_addr, "FAKELL", len);
-				skb->protocol = eth_type_trans(skb, dev);
-				netif_receive_skb(skb);
-			} else {
-				qeth_l3_rebuild_skb(card, skb, hdr);
-				len = skb->len;
-				napi_gro_receive(&card->napi, skb);
-			}
-			break;
+			qeth_l3_rebuild_skb(card, skb, hdr);
+			/* fall through */
 		case QETH_HEADER_TYPE_LAYER2: /* for HiperSockets sniffer */
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			len = skb->len;
-			netif_receive_skb(skb);
+			napi_gro_receive(&card->napi, skb);
 			break;
 		default:
 			dev_kfree_skb_any(skb);
-- 
2.17.1
