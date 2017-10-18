From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 11/13] s390/qeth: try harder to get packets from RX buffer
Date: Wed, 18 Oct 2017 17:40:23 +0200
Message-ID: <20171018154025.73630-12-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Current code bails out when two subsequent buffer elements hold
insufficient data to contain a qeth_hdr packet descriptor.
This seems reasonable, but it would be legal for quirky hardware to
leave a few elements empty and then present packets in a subsequent
element. These packets would currently be dropped.

So make sure to check all buffer elements, until we hit the LAST_ENTRY
indication.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 23b439fb5f2c..8855bc8534d2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5214,13 +5214,11 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 	int use_rx_sg = 0;
 
 	/* qeth_hdr must not cross element boundaries */
-	if (element->length < offset + sizeof(struct qeth_hdr)) {
+	while (element->length < offset + sizeof(struct qeth_hdr)) {
 		if (qeth_is_last_sbale(element))
 			return NULL;
 		element++;
 		offset = 0;
-		if (element->length < sizeof(struct qeth_hdr))
-			return NULL;
 	}
 	*hdr = element->addr + offset;
 
-- 
2.13.5
