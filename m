From: frank.blaschka@de.ibm.com
Subject: [patch 6/6] qeth: get rid of extra argument after printk to dev_* conversion
Date: Fri, 02 Jan 2009 16:01:45 +0100
Message-ID: <20090102150256.663537000@de.ibm.com>
References: <20090102150139.830998000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=611-qeth-extra-arg.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

drivers/s390/net/qeth_l3_main.c: In function 'qeth_l3_setadapter_parms':
drivers/s390/net/qeth_l3_main.c:1049: warning: too many arguments for format

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---

diff -u -r1.42 -r1.43 linux-2.5/drivers/s390/net/qeth_l3_main.c
--- linux-2.5/drivers/s390/net/qeth_l3_main.c	3 Dec 2008 06:44:41 -0000	1.42
+++ linux-2.5/drivers/s390/net/qeth_l3_main.c	2 Jan 2009 11:24:02 -0000	1.43
@@ -1047,7 +1047,7 @@
 		rc = qeth_setadpparms_change_macaddr(card);
 		if (rc)
 			dev_warn(&card->gdev->dev, "Reading the adapter MAC"
-				" address failed\n", rc);
+				" address failed\n");
 	}

 	if ((card->info.link_type == QETH_LINK_TYPE_HSTR) ||

-- 
