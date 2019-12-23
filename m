Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726865AbfLWOWh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:22:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNEJxct035612
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:22:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x21kg4m4j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:22:35 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:22:33 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/3] s390/qeth: use napi_gro_frags() for SG skbs
Date: Mon, 23 Dec 2019 15:22:26 +0100
In-Reply-To: <20191223142227.19500-1-jwi@linux.ibm.com>
References: <20191223142227.19500-1-jwi@linux.ibm.com>
Message-Id: <20191223142227.19500-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

For non-linear packets, get the skb for attaching the page fragments
from napi_get_frags() so that it can be recycled during GRO.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 67 +++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8e2c0588525f..b32b50384c5c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5106,8 +5106,9 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 #endif
 
 static void qeth_receive_skb(struct qeth_card *card, struct sk_buff *skb,
-			     struct qeth_hdr *hdr)
+			     struct qeth_hdr *hdr, bool uses_frags)
 {
+	struct napi_struct *napi = &card->napi;
 	bool is_cso;
 
 	switch (hdr->hdr.l2.id) {
@@ -5130,7 +5131,10 @@ static void qeth_receive_skb(struct qeth_card *card, struct sk_buff *skb,
 		break;
 	default:
 		/* never happens */
-		dev_kfree_skb_any(skb);
+		if (uses_frags)
+			napi_free_frags(napi);
+		else
+			dev_kfree_skb_any(skb);
 		return;
 	}
 
@@ -5141,8 +5145,6 @@ static void qeth_receive_skb(struct qeth_card *card, struct sk_buff *skb,
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 
-	skb->protocol = eth_type_trans(skb, skb->dev);
-
 	QETH_CARD_STAT_ADD(card, rx_bytes, skb->len);
 	QETH_CARD_STAT_INC(card, rx_packets);
 	if (skb_is_nonlinear(skb)) {
@@ -5151,7 +5153,12 @@ static void qeth_receive_skb(struct qeth_card *card, struct sk_buff *skb,
 				   skb_shinfo(skb)->nr_frags);
 	}
 
-	napi_gro_receive(&card->napi, skb);
+	if (uses_frags) {
+		napi_gro_frags(napi);
+	} else {
+		skb->protocol = eth_type_trans(skb, skb->dev);
+		napi_gro_receive(napi, skb);
+	}
 }
 
 static void qeth_create_skb_frag(struct sk_buff *skb, char *data, int data_len)
@@ -5177,7 +5184,9 @@ static int qeth_extract_skb(struct qeth_card *card,
 {
 	struct qdio_buffer_element *element = *__element;
 	struct qdio_buffer *buffer = qethbuffer->buffer;
+	struct napi_struct *napi = &card->napi;
 	unsigned int linear_len = 0;
+	bool uses_frags = false;
 	int offset = *__offset;
 	bool use_rx_sg = false;
 	unsigned int headroom;
@@ -5253,21 +5262,42 @@ static int qeth_extract_skb(struct qeth_card *card,
 		     !atomic_read(&card->force_alloc_skb) &&
 		     !IS_OSN(card));
 
-	if (use_rx_sg && qethbuffer->rx_skb) {
+	if (use_rx_sg) {
 		/* QETH_CQ_ENABLED only: */
-		skb = qethbuffer->rx_skb;
-		qethbuffer->rx_skb = NULL;
-	} else {
-		if (!use_rx_sg)
-			linear_len = skb_len;
-		skb = napi_alloc_skb(&card->napi, linear_len + headroom);
+		if (qethbuffer->rx_skb) {
+			skb = qethbuffer->rx_skb;
+			qethbuffer->rx_skb = NULL;
+			goto use_skb;
+		}
+
+		skb = napi_get_frags(napi);
+		if (!skb) {
+			/* -ENOMEM, no point in falling back further. */
+			QETH_CARD_STAT_INC(card, rx_dropped_nomem);
+			goto walk_packet;
+		}
+
+		if (skb_tailroom(skb) >= linear_len + headroom) {
+			uses_frags = true;
+			goto use_skb;
+		}
+
+		netdev_info_once(card->dev,
+				 "Insufficient linear space in NAPI frags skb, need %u but have %u\n",
+				 linear_len + headroom, skb_tailroom(skb));
+		/* Shouldn't happen. Don't optimize, fall back to linear skb. */
 	}
 
-	if (!skb)
+	linear_len = skb_len;
+	skb = napi_alloc_skb(napi, linear_len + headroom);
+	if (!skb) {
 		QETH_CARD_STAT_INC(card, rx_dropped_nomem);
-	else if (headroom)
-		skb_reserve(skb, headroom);
+		goto walk_packet;
+	}
 
+use_skb:
+	if (headroom)
+		skb_reserve(skb, headroom);
 walk_packet:
 	while (skb_len) {
 		int data_len = min(skb_len, (int)(element->length - offset));
@@ -5300,7 +5330,10 @@ static int qeth_extract_skb(struct qeth_card *card,
 				QETH_CARD_TEXT(card, 4, "unexeob");
 				QETH_CARD_HEX(card, 2, buffer, sizeof(void *));
 				if (skb) {
-					dev_kfree_skb_any(skb);
+					if (uses_frags)
+						napi_free_frags(napi);
+					else
+						dev_kfree_skb_any(skb);
 					QETH_CARD_STAT_INC(card,
 							   rx_length_errors);
 				}
@@ -5318,7 +5351,7 @@ static int qeth_extract_skb(struct qeth_card *card,
 	*__element = element;
 	*__offset = offset;
 
-	qeth_receive_skb(card, skb, hdr);
+	qeth_receive_skb(card, skb, hdr, uses_frags);
 	return 0;
 }
 
-- 
2.17.1
