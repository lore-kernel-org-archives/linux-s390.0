Return-Path: <SRS0=el7m=UC=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/4] s390/qeth: handle limited IPv4 broadcast in L3 TX path
Date: Mon,  3 Jun 2019 17:04:43 +0200
In-Reply-To: <20190603150446.23351-1-jwi@linux.ibm.com>
References: <20190603150446.23351-1-jwi@linux.ibm.com>
Message-Id: <20190603150446.23351-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When selecting the cast type of a neighbourless IPv4 skb (eg. on a raw
socket), qeth_l3 falls back to the packet's destination IP address.
For this case we should classify traffic sent to 255.255.255.255 as
broadcast.
This fixes DHCP requests, which were misclassified as unicast
(and for IQD interfaces thus ended up on the wrong HW queue).

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0271833da6a2..2df67abdfde7 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1911,6 +1911,8 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 	/* no neighbour (eg AF_PACKET), fall back to target's IP address ... */
 	switch (qeth_get_ip_version(skb)) {
 	case 4:
+		if (ipv4_is_lbcast(ip_hdr(skb)->daddr))
+			return RTN_BROADCAST;
 		return ipv4_is_multicast(ip_hdr(skb)->daddr) ?
 				RTN_MULTICAST : RTN_UNICAST;
 	case 6:
-- 
2.17.1
