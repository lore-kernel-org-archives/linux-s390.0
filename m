From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/15] net/af_iucv: locate IUCV header via skb_network_header()
Date: Wed, 26 Sep 2018 18:29:06 +0200
Message-ID: <20180926162916.102720-6-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch attempts to untangle the TX and RX code in qeth from
af_iucv's respective HiperTransport path:
On the TX side, pointing skb_network_header() at the IUCV header
means that qeth_l3_fill_af_iucv_hdr() no longer needs a magical offset
to access the header.
On the RX side, qeth pulls the (fake) L2 header off the skb like any
normal ethernet driver would. This makes working with the IUCV header
in af_iucv easier, since we no longer have to assume a fixed skb layout.

While at it, replace the open-coded length checks in af_iucv's RX path
with pskb_may_pull().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 12 +++++-------
 include/net/iucv/af_iucv.h      |  5 +++++
 net/iucv/af_iucv.c              | 42 +++++++++++++----------------------------
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 2756795f7708..7148ef71ac78 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1348,6 +1348,7 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 				int budget, int *done)
 {
+	struct net_device *dev = card->dev;
 	int work_done = 0;
 	struct sk_buff *skb;
 	struct qeth_hdr *hdr;
@@ -1369,11 +1370,10 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 			magic = *(__u16 *)skb->data;
 			if ((card->info.type == QETH_CARD_TYPE_IQD) &&
 			    (magic == ETH_P_AF_IUCV)) {
-				skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 				len = skb->len;
-				card->dev->header_ops->create(skb, card->dev, 0,
-					card->dev->dev_addr, "FAKELL", len);
-				skb_reset_mac_header(skb);
+				dev_hard_header(skb, dev, ETH_P_AF_IUCV,
+						dev->dev_addr, "FAKELL", len);
+				skb->protocol = eth_type_trans(skb, dev);
 				netif_receive_skb(skb);
 			} else {
 				qeth_l3_rebuild_skb(card, skb, hdr);
@@ -2005,17 +2005,15 @@ static void qeth_l3_fill_af_iucv_hdr(struct qeth_hdr *hdr, struct sk_buff *skb,
 				     unsigned int data_len)
 {
 	char daddr[16];
-	struct af_iucv_trans_hdr *iucv_hdr;
 
 	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
 	hdr->hdr.l3.length = data_len;
 	hdr->hdr.l3.flags = QETH_HDR_IPV6 | QETH_CAST_UNICAST;
 
-	iucv_hdr = (struct af_iucv_trans_hdr *)(skb_mac_header(skb) + ETH_HLEN);
 	memset(daddr, 0, sizeof(daddr));
 	daddr[0] = 0xfe;
 	daddr[1] = 0x80;
-	memcpy(&daddr[8], iucv_hdr->destUserID, 8);
+	memcpy(&daddr[8], iucv_trans_hdr(skb)->destUserID, 8);
 	memcpy(hdr->hdr.l3.next_hop.ipv6_addr, daddr, 16);
 }
 
diff --git a/include/net/iucv/af_iucv.h b/include/net/iucv/af_iucv.h
index f4c21b5a1242..14a490246be9 100644
--- a/include/net/iucv/af_iucv.h
+++ b/include/net/iucv/af_iucv.h
@@ -80,6 +80,11 @@ struct af_iucv_trans_hdr {
 	u8 pad;                          /* total 104 bytes */
 } __packed;
 
+static inline struct af_iucv_trans_hdr *iucv_trans_hdr(struct sk_buff *skb)
+{
+	return (struct af_iucv_trans_hdr *)skb_network_header(skb);
+}
+
 enum iucv_tx_notify {
 	/* transmission of skb is completed and was successful */
 	TX_NOTIFY_OK = 0,
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 5b68ee908107..45115c125569 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -320,13 +320,9 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	struct sk_buff *nskb;
 	int err, confirm_recv = 0;
 
-	memset(skb->head, 0, ETH_HLEN);
-	phs_hdr = skb_push(skb, sizeof(struct af_iucv_trans_hdr));
-	skb_reset_mac_header(skb);
+	phs_hdr = skb_push(skb, sizeof(*phs_hdr));
+	memset(phs_hdr, 0, sizeof(*phs_hdr));
 	skb_reset_network_header(skb);
-	skb_push(skb, ETH_HLEN);
-	skb_reset_mac_header(skb);
-	memset(phs_hdr, 0, sizeof(struct af_iucv_trans_hdr));
 
 	phs_hdr->magic = ETH_P_AF_IUCV;
 	phs_hdr->version = 1;
@@ -350,6 +346,9 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	if (imsg)
 		memcpy(&phs_hdr->iucv_hdr, imsg, sizeof(struct iucv_message));
 
+	skb_push(skb, ETH_HLEN);
+	memset(skb->data, 0, ETH_HLEN);
+
 	skb->dev = iucv->hs_dev;
 	if (!skb->dev) {
 		err = -ENODEV;
@@ -1943,8 +1942,7 @@ static void iucv_callback_shutdown(struct iucv_path *path, u8 ipuser[16])
 /***************** HiperSockets transport callbacks ********************/
 static void afiucv_swap_src_dest(struct sk_buff *skb)
 {
-	struct af_iucv_trans_hdr *trans_hdr =
-				(struct af_iucv_trans_hdr *)skb->data;
+	struct af_iucv_trans_hdr *trans_hdr = iucv_trans_hdr(skb);
 	char tmpID[8];
 	char tmpName[8];
 
@@ -1967,13 +1965,12 @@ static void afiucv_swap_src_dest(struct sk_buff *skb)
  **/
 static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 {
+	struct af_iucv_trans_hdr *trans_hdr = iucv_trans_hdr(skb);
 	struct sock *nsk;
 	struct iucv_sock *iucv, *niucv;
-	struct af_iucv_trans_hdr *trans_hdr;
 	int err;
 
 	iucv = iucv_sk(sk);
-	trans_hdr = (struct af_iucv_trans_hdr *)skb->data;
 	if (!iucv) {
 		/* no sock - connection refused */
 		afiucv_swap_src_dest(skb);
@@ -2034,15 +2031,13 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 static int afiucv_hs_callback_synack(struct sock *sk, struct sk_buff *skb)
 {
 	struct iucv_sock *iucv = iucv_sk(sk);
-	struct af_iucv_trans_hdr *trans_hdr =
-					(struct af_iucv_trans_hdr *)skb->data;
 
 	if (!iucv)
 		goto out;
 	if (sk->sk_state != IUCV_BOUND)
 		goto out;
 	bh_lock_sock(sk);
-	iucv->msglimit_peer = trans_hdr->window;
+	iucv->msglimit_peer = iucv_trans_hdr(skb)->window;
 	sk->sk_state = IUCV_CONNECTED;
 	sk->sk_state_change(sk);
 	bh_unlock_sock(sk);
@@ -2098,8 +2093,6 @@ static int afiucv_hs_callback_fin(struct sock *sk, struct sk_buff *skb)
 static int afiucv_hs_callback_win(struct sock *sk, struct sk_buff *skb)
 {
 	struct iucv_sock *iucv = iucv_sk(sk);
-	struct af_iucv_trans_hdr *trans_hdr =
-					(struct af_iucv_trans_hdr *)skb->data;
 
 	if (!iucv)
 		return NET_RX_SUCCESS;
@@ -2107,7 +2100,7 @@ static int afiucv_hs_callback_win(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state != IUCV_CONNECTED)
 		return NET_RX_SUCCESS;
 
-	atomic_sub(trans_hdr->window, &iucv->msg_sent);
+	atomic_sub(iucv_trans_hdr(skb)->window, &iucv->msg_sent);
 	iucv_sock_wake_msglim(sk);
 	return NET_RX_SUCCESS;
 }
@@ -2170,22 +2163,13 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 	int err = NET_RX_SUCCESS;
 	char nullstring[8];
 
-	if (skb->len < (ETH_HLEN + sizeof(struct af_iucv_trans_hdr))) {
-		WARN_ONCE(1, "AF_IUCV too short skb, len=%d, min=%d",
-			  (int)skb->len,
-			  (int)(ETH_HLEN + sizeof(struct af_iucv_trans_hdr)));
+	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
+		WARN_ONCE(1, "AF_IUCV failed to receive skb, len=%u", skb->len);
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}
-	if (skb_headlen(skb) < (ETH_HLEN + sizeof(struct af_iucv_trans_hdr)))
-		if (skb_linearize(skb)) {
-			WARN_ONCE(1, "AF_IUCV skb_linearize failed, len=%d",
-				  (int)skb->len);
-			kfree_skb(skb);
-			return NET_RX_SUCCESS;
-		}
-	skb_pull(skb, ETH_HLEN);
-	trans_hdr = (struct af_iucv_trans_hdr *)skb->data;
+
+	trans_hdr = iucv_trans_hdr(skb);
 	EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
 	EBCASC(trans_hdr->destUserID, sizeof(trans_hdr->destUserID));
 	EBCASC(trans_hdr->srcAppName, sizeof(trans_hdr->srcAppName));
-- 
2.16.4
