From: frank.blaschka@de.ibm.com
Subject: [patch 1/6] [PATCH] qeth: struct device - replace bus_id with dev_name(), dev_set_name()
Date: Wed, 25 Mar 2009 07:57:14 +0100
Message-ID: <20090325065808.703907000@de.ibm.com>
References: <20090325065713.054133000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=605-qeth-struct-device.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kay Sievers <kay.sievers@vrfy.org>

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---

 drivers/s390/net/qeth_l3_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/net/qeth_l3_main.c linux-2.6-patched/drivers/s390/net/qeth_l3_main.c
--- linux-2.6/drivers/s390/net/qeth_l3_main.c	2009-02-18 12:06:14.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_l3_main.c	2009-02-18 12:06:31.000000000 +0100
@@ -1038,7 +1038,7 @@ static int qeth_l3_setadapter_parms(stru
 	rc = qeth_query_setadapterparms(card);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "%s couldn't set adapter parameters: "
-			"0x%x\n", card->gdev->dev.bus_id, rc);
+			"0x%x\n", dev_name(&card->gdev->dev), rc);
 		return rc;
 	}
 	if (qeth_adp_supported(card, IPA_SETADP_ALTER_MAC_ADDRESS)) {
