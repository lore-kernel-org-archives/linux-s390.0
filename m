Return-Path: <linux-kernel-owner+w=401wt.eu-S1759110AbYFYOkX@vger.kernel.org>
Message-Id: <20080625143616.727686124@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/21] Cleanup lcs printk messages.
Content-Disposition: inline; filename=820-printk-lcs-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jeff Garzik <jgarzik@redhat.com>, "Klaus-D. Wacker" <kdwacker@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Klaus-D. Wacker <kdwacker@de.ibm.com>

Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Klaus-D. Wacker <kdwacker@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/lcs.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/net/lcs.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/lcs.c
+++ quilt-2.6/drivers/s390/net/lcs.c
@@ -1762,7 +1762,7 @@ lcs_get_control(struct lcs_card *card, s
 				netif_carrier_off(card->dev);
 			break;
 		default:
-			PRINT_INFO("UNRECOGNIZED LGW COMMAND\n");
+			LCS_DBF_TEXT(5, trace, "noLGWcmd");
 			break;
 		}
 	} else
@@ -2043,13 +2043,12 @@ lcs_probe_device(struct ccwgroup_device 
 	LCS_DBF_TEXT(2, setup, "add_dev");
         card = lcs_alloc_card();
         if (!card) {
-                PRINT_ERR("Allocation of lcs card failed\n");
+		LCS_DBF_TEXT_(2, setup, "  rc%d", -ENOMEM);
 		put_device(&ccwgdev->dev);
                 return -ENOMEM;
         }
 	ret = sysfs_create_group(&ccwgdev->dev.kobj, &lcs_attr_group);
 	if (ret) {
-                PRINT_ERR("Creating attributes failed");
 		lcs_free_card(card);
 		put_device(&ccwgdev->dev);
 		return ret;
@@ -2141,7 +2140,6 @@ lcs_new_device(struct ccwgroup_device *c
 	default:
 		LCS_DBF_TEXT(3, setup, "errinit");
 		PRINT_ERR("LCS: Initialization failed\n");
-		PRINT_ERR("LCS: No device found!\n");
 		goto out;
 	}
 	if (!dev)
@@ -2270,7 +2268,6 @@ lcs_remove_device(struct ccwgroup_device
 	if (!card)
 		return;
 
-	PRINT_INFO("Removing lcs group device ....\n");
 	LCS_DBF_TEXT(3, setup, "remdev");
 	LCS_DBF_HEX(3, setup, &card, sizeof(void*));
 	if (ccwgdev->state == CCWGROUP_ONLINE) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
