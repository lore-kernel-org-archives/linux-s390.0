Return-Path: <linux-kernel-owner+w=401wt.eu-S932223AbYEOPD6@vger.kernel.org>
Message-Id: <20080515150008.316487133@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/11] vmlogrdr: module initialization function should return negative errors
Content-Disposition: inline; filename=004-vmlogrdr-rc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Marcin Slusarz <marcin.slusarz@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Marcin Slusarz <marcin.slusarz@gmail.com>

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmlogrdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c
@@ -858,7 +858,7 @@ static int __init vmlogrdr_init(void)
 	for (i=0; i < MAXMINOR; ++i ) {
 		sys_ser[i].buffer = (char *) get_zeroed_page(GFP_KERNEL);
 		if (!sys_ser[i].buffer) {
-			rc = ENOMEM;
+			rc = -ENOMEM;
 			break;
 		}
 		sys_ser[i].current_position = sys_ser[i].buffer;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
