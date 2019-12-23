Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbfLWOWh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:22:37 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNEJwtI118095
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:22:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21qpdynw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:22:35 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:22:33 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/3] s390/qeth: remove QETH_RX_PULL_LEN
Date: Mon, 23 Dec 2019 15:22:27 +0100
In-Reply-To: <20191223142227.19500-1-jwi@linux.ibm.com>
References: <20191223142227.19500-1-jwi@linux.ibm.com>
Message-Id: <20191223142227.19500-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Since commit f677fcb9aeb6 ("s390/qeth: ensure linear access to packet headers"),
the CQ-specific skbs are allocated with a slightly bigger linear part
than necessary. Shrink it down to the maximum that's needed by
qeth_extract_skb().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 4ab3be814ea7..7c37e94fb28b 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -221,7 +221,6 @@ struct qeth_vnicc_info {
 
 /* large receive scatter gather copy break */
 #define QETH_RX_SG_CB (PAGE_SIZE >> 1)
-#define QETH_RX_PULL_LEN 256
 
 struct qeth_hdr_layer3 {
 	__u8  id;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b32b50384c5c..3be3d13f8d65 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2627,7 +2627,8 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 
 	if ((card->options.cq == QETH_CQ_ENABLED) && (!buf->rx_skb)) {
 		buf->rx_skb = netdev_alloc_skb(card->dev,
-					       QETH_RX_PULL_LEN + ETH_HLEN);
+					       ETH_HLEN +
+					       sizeof(struct ipv6hdr));
 		if (!buf->rx_skb)
 			return 1;
 	}
@@ -5264,7 +5265,8 @@ static int qeth_extract_skb(struct qeth_card *card,
 
 	if (use_rx_sg) {
 		/* QETH_CQ_ENABLED only: */
-		if (qethbuffer->rx_skb) {
+		if (qethbuffer->rx_skb &&
+		    skb_tailroom(qethbuffer->rx_skb) >= linear_len + headroom) {
 			skb = qethbuffer->rx_skb;
 			qethbuffer->rx_skb = NULL;
 			goto use_skb;
-- 
2.17.1
