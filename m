Return-Path: <linux-kernel-owner+w=401wt.eu-S934746AbXLTPYu@vger.kernel.org>
Message-Id: <20071220152104.005982837@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/47] cio: Reset sch->driver.
Content-Disposition: inline; filename=104-cio-reset.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

sch->driver needs to be reset to NULL on failed probe and after
remove. We also need to check for sch->driver on shutdown.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -796,32 +796,36 @@ css_bus_match (struct device *dev, struc
 	return 0;
 }
 
-static int
-css_probe (struct device *dev)
+static int css_probe(struct device *dev)
 {
 	struct subchannel *sch;
+	int ret;
 
 	sch = to_subchannel(dev);
 	sch->driver = to_cssdriver(dev->driver);
-	return (sch->driver->probe ? sch->driver->probe(sch) : 0);
+	ret = sch->driver->probe ? sch->driver->probe(sch) : 0;
+	if (ret)
+		sch->driver = NULL;
+	return ret;
 }
 
-static int
-css_remove (struct device *dev)
+static int css_remove(struct device *dev)
 {
 	struct subchannel *sch;
+	int ret;
 
 	sch = to_subchannel(dev);
-	return (sch->driver->remove ? sch->driver->remove(sch) : 0);
+	ret = sch->driver->remove ? sch->driver->remove(sch) : 0;
+	sch->driver = NULL;
+	return ret;
 }
 
-static void
-css_shutdown (struct device *dev)
+static void css_shutdown(struct device *dev)
 {
 	struct subchannel *sch;
 
 	sch = to_subchannel(dev);
-	if (sch->driver->shutdown)
+	if (sch->driver && sch->driver->shutdown)
 		sch->driver->shutdown(sch);
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
