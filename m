Return-Path: <linux-kernel-owner+w=401wt.eu-S932151AbXGWIzB@vger.kernel.org>
Message-Id: <20070723085646.444431221@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/9] cio: css_sch_device_register() can be made static.
Content-Disposition: inline; filename=003-cio-static.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |    2 +-
 drivers/s390/cio/css.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -109,7 +109,7 @@ css_subchannel_release(struct device *de
 	}
 }
 
-int css_sch_device_register(struct subchannel *sch)
+static int css_sch_device_register(struct subchannel *sch)
 {
 	int ret;
 
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -139,7 +139,6 @@ struct css_driver {
  */
 extern struct bus_type css_bus_type;
 
-extern int css_sch_device_register(struct subchannel *);
 extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
