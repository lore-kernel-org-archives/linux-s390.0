From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 11/12] s390/qeth: fix trace-messages for deleting rxip addresses
Date: Tue, 15 Aug 2017 17:02:49 +0200
Message-ID: <20170815150250.67158-12-jwi@linux.vnet.ibm.com>
References: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

change trace-messages:
- from addrxip4 to delrxip4
- from addrxip6 to delrxip6

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 140ed124d2f0..41bd00454d0f 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -784,11 +784,11 @@ void qeth_l3_del_rxip(struct qeth_card *card, enum qeth_prot_versions proto,
 	ipaddr = qeth_l3_get_addr_buffer(proto);
 	if (ipaddr) {
 		if (proto == QETH_PROT_IPV4) {
-			QETH_CARD_TEXT(card, 2, "addrxip4");
+			QETH_CARD_TEXT(card, 2, "delrxip4");
 			memcpy(&ipaddr->u.a4.addr, addr, 4);
 			ipaddr->u.a4.mask = 0;
 		} else if (proto == QETH_PROT_IPV6) {
-			QETH_CARD_TEXT(card, 2, "addrxip6");
+			QETH_CARD_TEXT(card, 2, "delrxip6");
 			memcpy(&ipaddr->u.a6.addr, addr, 16);
 			ipaddr->u.a6.pfxlen = 0;
 		}
-- 
2.11.2
