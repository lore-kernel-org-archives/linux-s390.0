Return-Path: <linux-kernel-owner+w=401wt.eu-S1758101AbXJDL3h@vger.kernel.org>
Message-Id: <20071004112825.043551769@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/34] cio: remove subchannel_add_files()
Content-Disposition: inline; filename=002-cio-remove.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

subchannel_add_files() no longer exists, remove from header.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/css.h |    1 -
 1 file changed, 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -191,6 +191,5 @@ int sch_is_pseudo_sch(struct subchannel 
 
 extern struct workqueue_struct *slow_path_wq;
 
-int subchannel_add_files (struct device *);
 extern struct attribute_group *subch_attr_groups[];
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
