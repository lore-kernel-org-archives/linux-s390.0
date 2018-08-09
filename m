From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/7] s390/qeth: use true and false for boolean values
Date: Thu,  9 Aug 2018 14:48:04 +0200
Message-ID: <20180809124804.20056-8-jwi@linux.ibm.com>
References: <20180809124804.20056-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180809124804.20056-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Return statements in functions returning bool should use true or false
instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 1833e7505aca..7175086677fb 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -117,9 +117,9 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
 	int rc = 0;
 
 	if (!card->ipato.enabled)
-		return 0;
+		return false;
 	if (addr->type != QETH_IP_TYPE_NORMAL)
-		return 0;
+		return false;
 
 	qeth_l3_convert_addr_to_bits((u8 *) &addr->u, addr_bits,
 				  (addr->proto == QETH_PROT_IPV4)? 4:16);
-- 
2.16.4
