Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/8] s390/qeth: remove RX seqno in skb->cb
Date: Thu, 25 Apr 2019 18:25:55 +0200
In-Reply-To: <20190425162601.91997-1-jwi@linux.ibm.com>
References: <20190425162601.91997-1-jwi@linux.ibm.com>
Message-Id: <20190425162601.91997-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

It's unclear what exact purpose this seqno may have served in the past.
But it's certainly no longer used anymore, as the following
napi_gro_receive() will straight away clear this part of the cb again.

Suggested-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    | 1 -
 drivers/s390/net/qeth_l2_main.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 86cae5e8e2c2..962e958c24f9 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -652,7 +652,6 @@ struct qeth_seqno {
 	__u32 pdu_hdr;
 	__u32 pdu_hdr_ack;
 	__u16 ipa;
-	__u32 pkt_seqno;
 };
 
 struct qeth_reply {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index e26a6dff286f..07bfb110906d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -332,8 +332,6 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
 		case QETH_HEADER_TYPE_LAYER2:
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			qeth_rx_csum(card, skb, hdr->hdr.l2.flags[1]);
-			if (skb->protocol == htons(ETH_P_802_2))
-				*((__u32 *)skb->cb) = ++card->seqno.pkt_seqno;
 			len = skb->len;
 			napi_gro_receive(&card->napi, skb);
 			break;
-- 
2.16.4
