From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 1/5] qeth: HiperSockets layer-3 interface drop non IPv4 or non IPv6 packets
Date: Fri, 05 Oct 2007 16:45:44 +0200
Message-ID: <20071005144822.229143000@linux.vnet.ibm.com>
References: <20071005144543.448852000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=705-qeth-pktdrop.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Klaus D. Wacker" <kdwacker@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Klaus D. Wacker <kdwacker@de.ibm.com>

HiperSockets infrastructure (layer-3 mode) supports only IPv4 or
IPv6 packets. Sending other packet types disturbs TCP/IP on z/VM,
which issues messages about invalid packets.
Qeth send routine will detect packet type on sending over a 
HiperSockets interface (in layer-3 mode) and drop non IP packets.
The error and drop count of the interface is incremented.

Signed-off-by: Klaus D. Wacker <kdwacker@de.ibm.com>
Signed-off-by: Ursula Braun <braunu@de.ibm.com>
---

 drivers/s390/net/qeth_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-uschi/drivers/s390/net/qeth_main.c
===================================================================
--- linux-2.6-uschi.orig/drivers/s390/net/qeth_main.c
+++ linux-2.6-uschi/drivers/s390/net/qeth_main.c
@@ -4711,8 +4711,8 @@ qeth_send_packet(struct qeth_card *card,
 		rc = qeth_do_send_packet(card, queue, new_skb, hdr,
 					 elements_needed, ctx);
 	else {
-		if ((skb->protocol == htons(ETH_P_ARP)) &&
-		    (card->dev->flags & IFF_NOARP)) {
+		if ((!card->options.layer2) &&
+		    (ipv == 0)) {
 			__qeth_free_new_skb(skb, new_skb);
 			return -EPERM;
 		}

-- 
