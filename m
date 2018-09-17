From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/15] s390/qeth: remove qeth_hdr_chk_and_bounce()
Date: Mon, 17 Sep 2018 17:36:04 +0200
Message-ID: <20180917153609.94628-11-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Restructure the OSN xmit path to handle misaligned HW headers properly,
without shifting the packet data around.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 21 ---------------------
 drivers/s390/net/qeth_l2_main.c   | 37 ++++++++++++++++++++++++++++---------
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 1c9fce609eb9..be213b5c2552 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1021,7 +1021,6 @@ void qeth_dbf_longtext(debug_info_t *id, int level, char *text, ...);
 int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
 					 struct ethtool_link_ksettings *cmd);
 int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback);
-int qeth_hdr_chk_and_bounce(struct sk_buff *, struct qeth_hdr **, int);
 int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
 void qeth_trace_features(struct qeth_card *);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7426167eace2..c7f7061a7205 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3823,27 +3823,6 @@ unsigned int qeth_count_elements(struct sk_buff *skb, unsigned int data_offset)
 }
 EXPORT_SYMBOL_GPL(qeth_count_elements);
 
-int qeth_hdr_chk_and_bounce(struct sk_buff *skb, struct qeth_hdr **hdr, int len)
-{
-	int hroom, inpage, rest;
-
-	if (((unsigned long)skb->data & PAGE_MASK) !=
-	    (((unsigned long)skb->data + len - 1) & PAGE_MASK)) {
-		hroom = skb_headroom(skb);
-		inpage = PAGE_SIZE - ((unsigned long) skb->data % PAGE_SIZE);
-		rest = len - inpage;
-		if (rest > hroom)
-			return 1;
-		memmove(skb->data - rest, skb->data, skb_headlen(skb));
-		skb->data -= rest;
-		skb->tail -= rest;
-		*hdr = (struct qeth_hdr *)skb->data;
-		QETH_DBF_MESSAGE(2, "skb bounce len: %d rest: %d\n", len, rest);
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(qeth_hdr_chk_and_bounce);
-
 #define QETH_HDR_CACHE_OBJ_SIZE		(sizeof(struct qeth_hdr_tso) + \
 					 MAX_TCP_HEADER)
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 24b531ca2827..33b65471a68a 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -650,19 +650,38 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 static int qeth_l2_xmit_osn(struct qeth_card *card, struct sk_buff *skb,
 			    struct qeth_qdio_out_q *queue)
 {
-	unsigned int elements;
-	struct qeth_hdr *hdr;
+	struct qeth_hdr *hdr = (struct qeth_hdr *)skb->data;
+	addr_t end = (addr_t)(skb->data + sizeof(*hdr));
+	addr_t start = (addr_t)skb->data;
+	unsigned int elements = 0;
+	unsigned int hd_len = 0;
+	int rc;
 
 	if (skb->protocol == htons(ETH_P_IPV6))
 		return -EPROTONOSUPPORT;
 
-	hdr = (struct qeth_hdr *)skb->data;
-	elements = qeth_count_elements(skb, 0);
-	if (elements > QETH_MAX_BUFFER_ELEMENTS(card))
-		return -E2BIG;
-	if (qeth_hdr_chk_and_bounce(skb, &hdr, sizeof(*hdr)))
-		return -EINVAL;
-	return qeth_do_send_packet(card, queue, skb, hdr, 0, 0, elements);
+	if (qeth_get_elements_for_range(start, end) > 1) {
+		/* Misaligned HW header, move it to its own buffer element. */
+		hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
+		if (!hdr)
+			return -ENOMEM;
+		hd_len = sizeof(*hdr);
+		skb_copy_from_linear_data(skb, (char *)hdr, hd_len);
+		elements++;
+	}
+
+	elements += qeth_count_elements(skb, hd_len);
+	if (elements > QETH_MAX_BUFFER_ELEMENTS(card)) {
+		rc = -E2BIG;
+		goto out;
+	}
+
+	rc = qeth_do_send_packet(card, queue, skb, hdr, hd_len, hd_len,
+				 elements);
+out:
+	if (rc && hd_len)
+		kmem_cache_free(qeth_core_header_cache, hdr);
+	return rc;
 }
 
 static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
-- 
2.16.4
