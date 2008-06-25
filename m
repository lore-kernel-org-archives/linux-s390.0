Return-Path: <linux-kernel-owner+w=401wt.eu-S1759309AbYFYOjf@vger.kernel.org>
Message-Id: <20080625143616.492222559@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/21] Cleanup qeth print messages.
Content-Disposition: inline; filename=819-printk-qeth.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jeff Garzik <jgarzik@redhat.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/qeth_core_main.c |    3 +--
 drivers/s390/net/qeth_l3_main.c   |    9 +--------
 2 files changed, 2 insertions(+), 10 deletions(-)

Index: quilt-2.6/drivers/s390/net/qeth_core_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core_main.c
+++ quilt-2.6/drivers/s390/net/qeth_core_main.c
@@ -420,7 +420,7 @@ static struct qeth_ipa_cmd *qeth_check_i
 				QETH_DBF_TEXT(TRACE, 3, "urla");
 				break;
 			default:
-				PRINT_WARN("Received data is IPA "
+				QETH_DBF_MESSAGE(2, "Received data is IPA "
 					   "but not a reply!\n");
 				break;
 			}
@@ -4092,7 +4092,6 @@ static int qeth_core_probe_device(struct
 
 	rc = qeth_determine_card_type(card);
 	if (rc) {
-		PRINT_WARN("%s: not a valid card type\n", __func__);
 		QETH_DBF_TEXT_(SETUP, 2, "3err%d", rc);
 		goto err_card;
 	}
Index: quilt-2.6/drivers/s390/net/qeth_l3_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_l3_main.c
+++ quilt-2.6/drivers/s390/net/qeth_l3_main.c
@@ -944,15 +944,8 @@ static int qeth_l3_deregister_addr_entry
 	else
 		rc = qeth_l3_send_setdelip(card, addr, IPA_CMD_DELIP,
 					addr->del_flags);
-	if (rc) {
+	if (rc)
 		QETH_DBF_TEXT(TRACE, 2, "failed");
-		/* TODO: re-activate this warning as soon as we have a
-		 * clean mirco code
-		qeth_ipaddr_to_string(addr->proto, (u8 *)&addr->u, buf);
-		PRINT_WARN("Could not deregister IP address %s (rc=%x)\n",
-			   buf, rc);
-		*/
-	}
 
 	return rc;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
