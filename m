Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfKNKUi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:20:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEAJ6wM037241
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:20:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92b9drje-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:20:35 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 14 Nov 2019 10:19:33 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/11] s390/qeth: support per-frame invalidation
Date: Thu, 14 Nov 2019 11:19:15 +0100
In-Reply-To: <20191114101924.29558-1-jwi@linux.ibm.com>
References: <20191114101924.29558-1-jwi@linux.ibm.com>
Message-Id: <20191114101924.29558-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Each RX buffer may contain up to 64KB worth of data. In case the device
needs to discard a packet _after_ already having reserved space for it
in the buffer, the whole buffer gets set to ERROR state. As the buffer
might contain any number of good packets, this can result in collateral
packet loss.

qeth can provide relief by enabling per-frame invalidation. The RX
buffer is then presented as usual, we just need to spot & drop any
individual packet that was flagged as invalid.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 ++
 drivers/s390/net/qeth_core_main.c | 13 +++++++++++--
 drivers/s390/net/qeth_core_mpc.h  |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 14edc892f7c1..52fd3c4bb132 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -368,6 +368,7 @@ enum qeth_header_ids {
 	QETH_HEADER_TYPE_L3_TSO	= 0x03,
 	QETH_HEADER_TYPE_OSN    = 0x04,
 	QETH_HEADER_TYPE_L2_TSO	= 0x06,
+	QETH_HEADER_MASK_INVAL	= 0x80,
 };
 /* flags for qeth_hdr.ext_flags */
 #define QETH_HDR_EXT_VLAN_FRAME       0x01
@@ -485,6 +486,7 @@ struct qeth_card_stats {
 	u64 rx_bytes;
 	u64 rx_multicast;
 	u64 rx_length_errors;
+	u64 rx_frame_errors;
 	u64 rx_fifo_errors;
 };
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4e113f359be9..c52241df980b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1956,6 +1956,7 @@ static void qeth_idx_setup_activate_cmd(struct qeth_card *card,
 	ccw_device_get_id(CARD_DDEV(card), &dev_id);
 	iob->finalize = qeth_idx_finalize_cmd;
 
+	port |= QETH_IDX_ACT_INVAL_FRAME;
 	memcpy(QETH_IDX_ACT_PNO(iob->data), &port, 1);
 	memcpy(QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
 	       &card->token.issuer_rm_w, QETH_MPC_TOKEN_LENGTH);
@@ -4346,7 +4347,9 @@ static int qeth_mdio_read(struct net_device *dev, int phy_id, int regnum)
 	case MII_NWAYTEST: /* N-way auto-neg test register */
 		break;
 	case MII_RERRCOUNTER: /* rx error counter */
-		rc = card->stats.rx_length_errors + card->stats.rx_fifo_errors;
+		rc = card->stats.rx_length_errors +
+		     card->stats.rx_frame_errors +
+		     card->stats.rx_fifo_errors;
 		break;
 	case MII_SREVISION: /* silicon revision */
 		break;
@@ -5092,7 +5095,11 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 		headroom = sizeof(struct qeth_hdr);
 		break;
 	default:
-		QETH_CARD_STAT_INC(card, rx_dropped_notsupp);
+		if ((*hdr)->hdr.l2.id & QETH_HEADER_MASK_INVAL)
+			QETH_CARD_STAT_INC(card, rx_frame_errors);
+		else
+			QETH_CARD_STAT_INC(card, rx_dropped_notsupp);
+
 		break;
 	}
 
@@ -6238,11 +6245,13 @@ void qeth_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	stats->rx_packets = card->stats.rx_packets;
 	stats->rx_bytes = card->stats.rx_bytes;
 	stats->rx_errors = card->stats.rx_length_errors +
+			   card->stats.rx_frame_errors +
 			   card->stats.rx_fifo_errors;
 	stats->rx_dropped = card->stats.rx_dropped_nomem +
 			    card->stats.rx_dropped_notsupp;
 	stats->multicast = card->stats.rx_multicast;
 	stats->rx_length_errors = card->stats.rx_length_errors;
+	stats->rx_frame_errors = card->stats.rx_frame_errors;
 	stats->rx_fifo_errors = card->stats.rx_fifo_errors;
 
 	for (i = 0; i < card->qdio.no_out_queues; i++) {
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 9ad0d6f9d48b..53fcf6641154 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -900,6 +900,7 @@ extern unsigned char IDX_ACTIVATE_WRITE[];
 #define IDX_ACTIVATE_SIZE	0x22
 #define QETH_IDX_ACT_PNO(buffer) (buffer+0x0b)
 #define QETH_IDX_ACT_ISSUER_RM_TOKEN(buffer) (buffer + 0x0c)
+#define QETH_IDX_ACT_INVAL_FRAME	0x40
 #define QETH_IDX_NO_PORTNAME_REQUIRED(buffer) ((buffer)[0x0b] & 0x80)
 #define QETH_IDX_ACT_FUNC_LEVEL(buffer) (buffer + 0x10)
 #define QETH_IDX_ACT_DATASET_NAME(buffer) (buffer + 0x16)
-- 
2.17.1
