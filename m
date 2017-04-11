From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 06/10] s390/qeth: use and remove some defines
Date: Tue, 11 Apr 2017 16:11:15 +0200
Message-ID: <20170411141119.82526-7-jwi@linux.vnet.ibm.com>
References: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

1. a buffer has 16 is_header flags, because that's its # of elements
2. replace the last occurrence of QETH_HEADER_SIZE, and remove it

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h    | 3 +--
 drivers/s390/net/qeth_l2_main.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f575c7a566c8..760f752034e4 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -240,7 +240,6 @@ static inline int qeth_is_ipa_enabled(struct qeth_ipa_info *ipa,
 #define QETH_TX_TIMEOUT		100 * HZ
 #define QETH_RCD_TIMEOUT	60 * HZ
 #define QETH_RECLAIM_WORK_TIME	HZ
-#define QETH_HEADER_SIZE	32
 #define QETH_MAX_PORTNO		15
 
 /*IPv6 address autoconfiguration stuff*/
@@ -447,7 +446,7 @@ struct qeth_qdio_out_buffer {
 	atomic_t state;
 	int next_element_to_fill;
 	struct sk_buff_head skb_list;
-	int is_header[16];
+	int is_header[QDIO_MAX_ELEMENTS_PER_BUFFER];
 
 	struct qaob *aob;
 	struct qeth_qdio_out_q *q;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 11cf4a4b36a6..22f8eb007aa1 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -280,7 +280,7 @@ static void qeth_l2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	else
 		hdr->hdr.l2.flags[2] |= QETH_LAYER2_FLAG_UNICAST;
 
-	hdr->hdr.l2.pkt_length = skb->len-QETH_HEADER_SIZE;
+	hdr->hdr.l2.pkt_length = skb->len - sizeof(struct qeth_hdr);
 	/* VSWITCH relies on the VLAN
 	 * information to be present in
 	 * the QDIO header */
-- 
2.10.2
