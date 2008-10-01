Return-Path: <linux-kernel-owner+w=401wt.eu-S1754885AbYJAI6o@vger.kernel.org>
Message-Id: <20081001084128.019670987@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/21] bus_id -> dev_set_name() for css and ccw busses
Content-Disposition: inline; filename=110-cio-busid6.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Convert remaining s390 users setting bus_id to dev_set_name()
or init_name.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c    |   13 +++++++++++--
 drivers/s390/cio/cio.h    |    4 ++++
 drivers/s390/cio/device.c |   16 ++++++++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -571,8 +571,10 @@ int cio_validate_subchannel(struct subch
 	}
 	mutex_init(&sch->reg_mutex);
 	/* Set a name for the subchannel */
-	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
-		  schid.sch_no);
+	if (cio_is_console(schid))
+		sch->dev.init_name = cio_get_console_sch_name(schid);
+	else
+		dev_set_name(&sch->dev, "0.%x.%04x", schid.ssid, schid.sch_no);
 
 	/*
 	 * The first subchannel that is not-operational (ccode==3)
@@ -677,6 +679,7 @@ do_IRQ (struct pt_regs *regs)
 
 #ifdef CONFIG_CCW_CONSOLE
 static struct subchannel console_subchannel;
+static char console_sch_name[10] = "0.x.xxxx";
 static struct io_subchannel_private console_priv;
 static int console_subchannel_in_use;
 
@@ -827,6 +830,12 @@ cio_get_console_subchannel(void)
 	return &console_subchannel;
 }
 
+const char *cio_get_console_sch_name(struct subchannel_id schid)
+{
+	snprintf(console_sch_name, 10, "0.%x.%04x", schid.ssid, schid.sch_no);
+	return (const char *)console_sch_name;
+}
+
 #endif
 static int
 __disable_subchannel_easy(struct subchannel_id schid, struct schib *schib)
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -117,11 +117,15 @@ extern int cio_is_console(struct subchan
 extern struct subchannel *cio_get_console_subchannel(void);
 extern spinlock_t * cio_get_console_lock(void);
 extern void *cio_get_console_priv(void);
+extern const char *cio_get_console_sch_name(struct subchannel_id schid);
+extern const char *cio_get_console_cdev_name(struct subchannel *sch);
 #else
 #define cio_is_console(schid) 0
 #define cio_get_console_subchannel() NULL
 #define cio_get_console_lock() NULL
 #define cio_get_console_priv() NULL
+#define cio_get_console_sch_name(schid) NULL
+#define cio_get_console_cdev_name(sch) NULL
 #endif
 
 #endif
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -1035,8 +1035,11 @@ io_subchannel_recog(struct ccw_device *c
 	init_timer(&priv->timer);
 
 	/* Set an initial name for the device. */
-	snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
-		  sch->schid.ssid, sch->schib.pmcw.dev);
+	if (cio_is_console(sch->schid))
+		cdev->dev.init_name = cio_get_console_cdev_name(sch);
+	else
+		dev_set_name(&cdev->dev, "0.%x.%04x",
+			     sch->schid.ssid, sch->schib.pmcw.dev);
 
 	/* Increase counter of devices currently in recognition. */
 	atomic_inc(&ccw_device_init_count);
@@ -1625,6 +1628,7 @@ static int io_subchannel_sch_event(struc
 
 #ifdef CONFIG_CCW_CONSOLE
 static struct ccw_device console_cdev;
+static char console_cdev_name[10] = "0.x.xxxx";
 static struct ccw_device_private console_private;
 static int console_cdev_in_use;
 
@@ -1695,6 +1699,14 @@ ccw_device_probe_console(void)
 	console_cdev.online = 1;
 	return &console_cdev;
 }
+
+
+const char *cio_get_console_cdev_name(struct subchannel *sch)
+{
+	snprintf(console_cdev_name, 10, "0.%x.%04x",
+		 sch->schid.ssid, sch->schib.pmcw.dev);
+	return (const char *)console_cdev_name;
+}
 #endif
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
