Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 4/6] Revert "s390/qeth: fix using of ref counter for rxip addresses"
Date: Tue, 27 Feb 2018 18:58:15 +0100
In-Reply-To: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
References: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180227175817.84727-5-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This reverts commit cb816192d986f7596009dedcf2201fe2e5bc2aa7.

The issue this attempted to fix never actually occurs.
l3_add_rxip() checks (via l3_ip_from_hash()) if the requested address
was previously added to the card. If so, it returns -EEXIST and doesn't
call l3_add_ip().
As a result, the "address exists" path in l3_add_ip() is never taken
for rxip addresses, and this patch had no effect.

Fixes: cb816192d986 ("s390/qeth: fix using of ref counter for rxip addresses")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 77cdb4fc7721..4d8826fec6f4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -167,8 +167,7 @@ int qeth_l3_delete_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 		return -ENOENT;
 
 	addr->ref_counter--;
-	if (addr->ref_counter > 0 && (addr->type == QETH_IP_TYPE_NORMAL ||
-				      addr->type == QETH_IP_TYPE_RXIP))
+	if (addr->type == QETH_IP_TYPE_NORMAL && addr->ref_counter > 0)
 		return rc;
 	if (addr->in_progress)
 		return -EINPROGRESS;
@@ -246,9 +245,8 @@ int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 			kfree(addr);
 		}
 	} else {
-		if (addr->type == QETH_IP_TYPE_NORMAL ||
-		    addr->type == QETH_IP_TYPE_RXIP)
-			addr->ref_counter++;
+			if (addr->type == QETH_IP_TYPE_NORMAL)
+				addr->ref_counter++;
 	}
 
 	return rc;
-- 
2.13.5
