From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 14/15] s390/qeth: pass full data length to l3_fill_header()
Date: Wed, 20 Dec 2017 20:11:08 +0100
Message-ID: <20171220191109.90487-15-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The TSO and IQD paths already need to fix-up the current values, and
OSA will require more flexibility in the future as well. So just let
the caller specify the data length.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 39b41e24318b..e31cc4fa544c 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2405,11 +2405,12 @@ static u8 qeth_l3_cast_type_to_flag(int cast_type)
 }
 
 static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
-				struct sk_buff *skb, int ipv, int cast_type)
+				struct sk_buff *skb, int ipv, int cast_type,
+				unsigned int data_len)
 {
 	memset(hdr, 0, sizeof(struct qeth_hdr));
 	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
-	hdr->hdr.l3.length = skb->len - sizeof(struct qeth_hdr);
+	hdr->hdr.l3.length = data_len;
 
 	/*
 	 * before we're going to overwrite this location with next hop ip.
@@ -2488,7 +2489,6 @@ static void qeth_tso_fill_header(struct qeth_card *card,
 
 	/*fix header to TSO values ...*/
 	hdr->hdr.hdr.l3.id = QETH_HEADER_TYPE_TSO;
-	hdr->hdr.hdr.l3.length = skb->len - sizeof(struct qeth_hdr_tso);
 	/*set values which are fix for the first approach ...*/
 	hdr->ext.hdr_tot_len = (__u16) sizeof(struct qeth_hdr_ext_tso);
 	hdr->ext.imb_hdr_no  = 1;
@@ -2649,21 +2649,23 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	if (use_tso) {
 		hdr = skb_push(new_skb, sizeof(struct qeth_hdr_tso));
 		memset(hdr, 0, sizeof(struct qeth_hdr_tso));
-		qeth_l3_fill_header(card, hdr, new_skb, ipv, cast_type);
+		qeth_l3_fill_header(card, hdr, new_skb, ipv, cast_type,
+				    new_skb->len - sizeof(struct qeth_hdr_tso));
 		qeth_tso_fill_header(card, hdr, new_skb);
 		hdr_elements++;
 	} else {
 		if (data_offset < 0) {
 			hdr = skb_push(new_skb, sizeof(struct qeth_hdr));
-			qeth_l3_fill_header(card, hdr, new_skb, ipv,
-						cast_type);
+			qeth_l3_fill_header(card, hdr, new_skb, ipv, cast_type,
+					    new_skb->len -
+					    sizeof(struct qeth_hdr));
 		} else {
 			if (be16_to_cpu(new_skb->protocol) == ETH_P_AF_IUCV)
 				qeth_l3_fill_af_iucv_hdr(card, hdr, new_skb);
 			else {
 				qeth_l3_fill_header(card, hdr, new_skb, ipv,
-							cast_type);
-				hdr->hdr.l3.length = new_skb->len - data_offset;
+						    cast_type,
+						    new_skb->len - data_offset);
 			}
 		}
 
-- 
2.13.5
