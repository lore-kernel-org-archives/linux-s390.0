From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 1/1] s390/qeth: fix L3 next-hop in xmit qeth hdr
Date: Mon,  7 Aug 2017 13:28:39 +0200
Message-ID: <20170807112839.91254-2-ubraun@linux.vnet.ibm.com>
References: <20170807112839.91254-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170807112839.91254-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

On L3, the qeth_hdr struct needs to be filled with the next-hop
IP address.
The current code accesses rtable->rt_gateway without checking that
rtable is a valid address. The accidental access to a lowcore area
results in a random next-hop address in the qeth_hdr.
rtable (or more precisely, skb_dst(skb)) can be NULL in rare cases
(for instance together with AF_PACKET sockets).
This patch adds the missing NULL-ptr checks.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Fixes: 87e7597b5a3 qeth: Move away from using neighbour entries in qeth_l3_fill_header()
---
 drivers/s390/net/qeth_l3_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8975cd321390..d42e758518ed 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2512,7 +2512,7 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		struct rtable *rt = (struct rtable *) dst;
 		__be32 *pkey = &ip_hdr(skb)->daddr;
 
-		if (rt->rt_gateway)
+		if (rt && rt->rt_gateway)
 			pkey = &rt->rt_gateway;
 
 		/* IPv4 */
@@ -2523,7 +2523,7 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		struct rt6_info *rt = (struct rt6_info *) dst;
 		struct in6_addr *pkey = &ipv6_hdr(skb)->daddr;
 
-		if (!ipv6_addr_any(&rt->rt6i_gateway))
+		if (rt && !ipv6_addr_any(&rt->rt6i_gateway))
 			pkey = &rt->rt6i_gateway;
 
 		/* IPv6 */
-- 
2.11.2
