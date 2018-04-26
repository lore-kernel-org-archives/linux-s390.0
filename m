From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/13] s390/qeth: disregard IPv4 header for RX csum offload
Date: Thu, 26 Apr 2018 09:42:18 +0200
Message-ID: <20180426074224.100432-8-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

The kernel does its own validation of the IPv4 header checksum,
drivers/HW are not required to handle this.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index a8114758075f..2cfeae485a08 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -868,7 +868,6 @@ static inline void qeth_rx_csum(struct qeth_card *card, struct sk_buff *skb,
 				u8 flags)
 {
 	if ((card->dev->features & NETIF_F_RXCSUM) &&
-	    (flags & QETH_HDR_EXT_CSUM_HDR_REQ) &&
 	    (flags & QETH_HDR_EXT_CSUM_TRANSP_REQ))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
-- 
2.13.5
