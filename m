From: frank.blaschka@de.ibm.com
Subject: [patch 2/2] [PATCH] qeth: fix race condition during device startup
Date: Mon, 08 Nov 2010 14:03:49 +0100
Message-ID: <20101108130427.518691409@de.ibm.com>
References: <20101108130347.973708765@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=603-qeth-startup-race.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

QDIO is running independent from netdevice state. We are not
allowed to schedule NAPI in case the netdevice is not open.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---

 drivers/s390/net/qeth_core_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/net/qeth_core_main.c linux-2.6-patched/drivers/s390/net/qeth_core_main.c
--- linux-2.6/drivers/s390/net/qeth_core_main.c	2010-11-08 09:41:13.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_core_main.c	2010-11-08 09:41:13.000000000 +0100
@@ -2903,7 +2903,7 @@ void qeth_qdio_start_poll(struct ccw_dev
 {
 	struct qeth_card *card = (struct qeth_card *)card_ptr;
 
-	if (card->dev)
+	if (card->dev && (card->dev->flags & IFF_UP))
 		napi_schedule(&card->napi);
 }
 EXPORT_SYMBOL_GPL(qeth_qdio_start_poll);
