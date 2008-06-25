Return-Path: <linux-kernel-owner+w=401wt.eu-S1758114AbYFYOjV@vger.kernel.org>
Message-Id: <20080625143614.481932042@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/21] Cleanup smsgiucv printk messages.
Content-Disposition: inline; filename=811-printk-smsgiucv.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/smsgiucv.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

Index: quilt-2.6/drivers/s390/net/smsgiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/smsgiucv.c
+++ quilt-2.6/drivers/s390/net/smsgiucv.c
@@ -156,11 +156,8 @@ static int __init smsg_init(void)
 	if (rc != 0)
 		goto out;
 	rc = iucv_register(&smsg_handler, 1);
-	if (rc) {
-		printk(KERN_ERR "SMSGIUCV: failed to register to iucv");
-		rc = -EIO;	/* better errno ? */
+	if (rc)
 		goto out_driver;
-	}
 	smsg_path = iucv_path_alloc(255, 0, GFP_KERNEL);
 	if (!smsg_path) {
 		rc = -ENOMEM;
@@ -168,11 +165,8 @@ static int __init smsg_init(void)
 	}
 	rc = iucv_path_connect(smsg_path, &smsg_handler, "*MSG    ",
 			       NULL, NULL, NULL);
-	if (rc) {
-		printk(KERN_ERR "SMSGIUCV: failed to connect to *MSG");
-		rc = -EIO;	/* better errno ? */
+	if (rc)
 		goto out_free;
-	}
 	cpcmd("SET SMSG IUCV", NULL, 0, NULL);
 	return 0;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
