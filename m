Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfKNKTt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:19:49 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEAIfWh112668
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w91m7ejv5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:46 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 14 Nov 2019 10:19:34 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/11] s390/qeth: handle skb allocation error gracefully
Date: Thu, 14 Nov 2019 11:19:17 +0100
In-Reply-To: <20191114101924.29558-1-jwi@linux.ibm.com>
References: <20191114101924.29558-1-jwi@linux.ibm.com>
Message-Id: <20191114101924.29558-5-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When current code fails to allocate an skb in the RX path, it drops the
whole RX buffer. Considering the large number of packets that a single
RX buffer might contain, this is quite drastic.

Skip over the packet instead, and try to extract the next packet from
the RX buffer.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 467a9173058c..08185f76a727 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5065,12 +5065,12 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 	struct qdio_buffer_element *element = *__element;
 	struct qdio_buffer *buffer = qethbuffer->buffer;
 	int offset = *__offset;
+	bool use_rx_sg = false;
+	unsigned int headroom;
 	struct sk_buff *skb;
 	int skb_len = 0;
 	void *data_ptr;
 	int data_len;
-	int headroom = 0;
-	int use_rx_sg = 0;
 
 next_packet:
 	/* qeth_hdr must not cross element boundaries */
@@ -5086,6 +5086,7 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 	switch ((*hdr)->hdr.l2.id) {
 	case QETH_HEADER_TYPE_LAYER2:
 		skb_len = (*hdr)->hdr.l2.pkt_length;
+		headroom = 0;
 		break;
 	case QETH_HEADER_TYPE_LAYER3:
 		skb_len = (*hdr)->hdr.l3.length;
@@ -5120,11 +5121,10 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 	if (!skb_len)
 		return NULL;
 
-	if (((skb_len >= card->options.rx_sg_cb) &&
-	     !IS_OSN(card) &&
-	     (!atomic_read(&card->force_alloc_skb))) ||
-	    (card->options.cq == QETH_CQ_ENABLED))
-		use_rx_sg = 1;
+	use_rx_sg = (card->options.cq == QETH_CQ_ENABLED) ||
+		    ((skb_len >= card->options.rx_sg_cb) &&
+		     !atomic_read(&card->force_alloc_skb) &&
+		     !IS_OSN(card));
 
 	if (use_rx_sg && qethbuffer->rx_skb) {
 		/* QETH_CQ_ENABLED only: */
@@ -5135,9 +5135,10 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 
 		skb = napi_alloc_skb(&card->napi, linear + headroom);
 	}
+
 	if (!skb)
-		goto no_mem;
-	if (headroom)
+		QETH_CARD_STAT_INC(card, rx_dropped_nomem);
+	else if (headroom)
 		skb_reserve(skb, headroom);
 
 walk_packet:
@@ -5184,12 +5185,6 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 				   skb_shinfo(skb)->nr_frags);
 	}
 	return skb;
-no_mem:
-	if (net_ratelimit()) {
-		QETH_CARD_TEXT(card, 2, "noskbmem");
-	}
-	QETH_CARD_STAT_INC(card, rx_dropped_nomem);
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(qeth_core_get_next_skb);
 
-- 
2.17.1
