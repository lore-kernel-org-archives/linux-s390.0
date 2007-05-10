Return-Path: <linux-kernel-owner+w=401wt.eu-S1762287AbXEJN57@vger.kernel.org>
Message-Id: <20070510135643.836311002@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/15] dasd: Fix modular build.
Content-Disposition: inline; filename=005-dasd-modular.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Add missing export of dasd_generic_read_dev_chars().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -2219,6 +2219,7 @@ int dasd_generic_read_dev_chars(struct d
 	dasd_sfree_request(cqr, cqr->device);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dasd_generic_read_dev_chars);
 
 static int __init
 dasd_init(void)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
