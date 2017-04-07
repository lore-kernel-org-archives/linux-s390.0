From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next V2 7/7] s390/netiucv: improve endianness handling
Date: Fri,  7 Apr 2017 09:15:38 +0200
Message-ID: <20170407071538.63253-8-ubraun@linux.vnet.ibm.com>
References: <20170407071538.63253-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170407071538.63253-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.vnet.ibm.com>

Replace ntohs with endianness conversion for the SKB protocol assignment
to avoid an endianness warning reported by sparse. No functional change.

Signed-off-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/netiucv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 3f85b97..dba94b4 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -635,7 +635,7 @@ static void netiucv_unpack_skb(struct iucv_connection *conn,
 	skb_put(pskb, NETIUCV_HDRLEN);
 	pskb->dev = dev;
 	pskb->ip_summed = CHECKSUM_NONE;
-	pskb->protocol = ntohs(ETH_P_IP);
+	pskb->protocol = cpu_to_be16(ETH_P_IP);
 
 	while (1) {
 		struct sk_buff *skb;
-- 
2.10.2
