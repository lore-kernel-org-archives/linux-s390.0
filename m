From: Ursula Braun <braunu@de.ibm.com>
Date: Mon, 27 Aug 2007 17:27:38 +0000
Subject: [patch 7/7] qeth: Drop ARP packages on HiperSockets interface with NOARP attribute.
Message-Id: <20070827173103.124025000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Klaus D. Wacker <kdwacker@de.ibm.com>

A network interface can get ARP packets even when the interface has
NOARP specified. In a HiperSockets environment this disturbs receiving
systems when packets are sent on the multicast queue. (E.g. TCP/IP on
z/VM issues messages reporting invalid data on the HiperSockets
interface.)
Qeth will no longer send ARP packets on HiperSockets interface when
interface has the NOARP attribute.

Signed-off-by: Klaus D. Wacker <kdwacker@de.ibm.com>
Signed-off-by: Ursula Braun <braunu@de.ibm.com>
---

 drivers/s390/net/qeth_main.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6-uschi/drivers/s390/net/qeth_main.c
===================================================================
--- linux-2.6-uschi.orig/drivers/s390/net/qeth_main.c
+++ linux-2.6-uschi/drivers/s390/net/qeth_main.c
@@ -2505,7 +2505,7 @@ qeth_rebuild_skb_fake_ll_tr(struct qeth_
 	struct iphdr *ip_hdr;
 
 	QETH_DBF_TEXT(trace,5,"skbfktr");
-	skb_set_mac_header(skb, -QETH_FAKE_LL_LEN_TR);
+	skb_set_mac_header(skb, (int)-QETH_FAKE_LL_LEN_TR);
 	/* this is a fake ethernet header */
 	fake_hdr = tr_hdr(skb);
 
@@ -4710,9 +4710,15 @@ qeth_send_packet(struct qeth_card *card,
 	if (card->info.type != QETH_CARD_TYPE_IQD)
 		rc = qeth_do_send_packet(card, queue, new_skb, hdr,
 					 elements_needed, ctx);
-	else
+	else {
+		if ((skb->protocol == htons(ETH_P_ARP)) &&
+		    (card->dev->flags & IFF_NOARP)) {
+			__qeth_free_new_skb(skb, new_skb);
+			return -EPERM;
+		}
 		rc = qeth_do_send_packet_fast(card, queue, new_skb, hdr,
 					      elements_needed, ctx);
+	}
 	if (!rc) {
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += tx_bytes;

-- 
