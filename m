Return-Path: <linux-kernel-owner+w=401wt.eu-S1755961AbXD0OPv@vger.kernel.org>
Message-Id: <20070427140515.277009760@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/38] cio: cm_enable memory leak.
Content-Disposition: inline; filename=113-cio-leak.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We allocage two pages when channel path measurements are enabled
via cm_enable. We must not forget to free them again when
channel path measurements are disabled again.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c	2007-04-27 16:04:55.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.c	2007-04-27 16:04:55.000000000 +0200
@@ -818,7 +818,7 @@
 		} else
 			chsc_remove_cmg_attr(css);
 	}
-	if (enable && !css->cm_enabled) {
+	if (!css->cm_enabled) {
 		free_page((unsigned long)css->cub_addr1);
 		free_page((unsigned long)css->cub_addr2);
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
