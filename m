Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/8] s390/qeth: trust non-IP cast type in qeth_l3_fill_header()
Date: Thu, 25 Apr 2019 18:26:01 +0200
In-Reply-To: <20190425162601.91997-1-jwi@linux.ibm.com>
References: <20190425162601.91997-1-jwi@linux.ibm.com>
Message-Id: <20190425162601.91997-9-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When building the L3 HW header for non-IP packets, trust the cast type
that was passed as parameter. qeth_l3_get_cast_type() has most likely
also used h_dest to determine the cast type, so we get the same
result, and can remove that duplicated code.
In the unlikely case that we would get a _different_ cast type, then
that's based off a route lookup and should be considered authoritative.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b5d76ebb488a..0271833da6a2 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1976,19 +1976,14 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 		hdr->hdr.l3.vlan_id = ntohs(veth->h_vlan_TCI);
 	}
 
+	l3_hdr->flags = qeth_l3_cast_type_to_flag(cast_type);
+
 	/* OSA only: */
 	if (!ipv) {
-		hdr->hdr.l3.flags = QETH_HDR_PASSTHRU;
-		if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
-					    skb->dev->broadcast))
-			hdr->hdr.l3.flags |= QETH_CAST_BROADCAST;
-		else
-			hdr->hdr.l3.flags |= (cast_type == RTN_MULTICAST) ?
-				QETH_CAST_MULTICAST : QETH_CAST_UNICAST;
+		l3_hdr->flags |= QETH_HDR_PASSTHRU;
 		return;
 	}
 
-	hdr->hdr.l3.flags = qeth_l3_cast_type_to_flag(cast_type);
 	rcu_read_lock();
 	if (ipv == 4) {
 		struct rtable *rt = skb_rtable(skb);
-- 
2.16.4
