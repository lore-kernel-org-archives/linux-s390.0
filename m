Return-Path: <linux-kernel-owner+w=401wt.eu-S1758586AbYFCRKW@vger.kernel.org>
Message-Id: <20080603170519.561673859@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/14] cio: Export some symbols for modular css drivers.
Content-Disposition: inline; filename=104-cio-css-exports.diff
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

 drivers/s390/cio/chp.c |    1 +
 drivers/s390/cio/cio.c |   16 ++++++++++------
 drivers/s390/cio/css.c |    5 +++++
 3 files changed, 16 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -95,6 +95,7 @@ u8 chp_get_sch_opm(struct subchannel *sc
 	}
 	return opm;
 }
+EXPORT_SYMBOL_GPL(chp_get_sch_opm);
 
 /**
  * chp_is_registered - check if a channel-path is registered
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -387,8 +387,10 @@ cio_modify (struct subchannel *sch)
 	return ret;
 }
 
-/*
- * Enable subchannel.
+/**
+ * cio_enable_subchannel - enable a subchannel.
+ * @sch: subchannel to be enabled
+ * @intparm: interruption parameter to set
  */
 int cio_enable_subchannel(struct subchannel *sch, u32 intparm)
 {
@@ -434,12 +436,13 @@ int cio_enable_subchannel(struct subchan
 	CIO_TRACE_EVENT (2, dbf_txt);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cio_enable_subchannel);
 
-/*
- * Disable subchannel.
+/**
+ * cio_disable_subchannel - disable a subchannel.
+ * @sch: subchannel to disable
  */
-int
-cio_disable_subchannel (struct subchannel *sch)
+int cio_disable_subchannel(struct subchannel *sch)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -484,6 +487,7 @@ cio_disable_subchannel (struct subchanne
 	CIO_TRACE_EVENT (2, dbf_txt);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cio_disable_subchannel);
 
 int cio_create_sch_lock(struct subchannel *sch)
 {
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -158,12 +158,17 @@ static int css_sch_device_register(struc
 	return ret;
 }
 
+/**
+ * css_sch_device_unregister - unregister a subchannel
+ * @sch: subchannel to be unregistered
+ */
 void css_sch_device_unregister(struct subchannel *sch)
 {
 	mutex_lock(&sch->reg_mutex);
 	device_unregister(&sch->dev);
 	mutex_unlock(&sch->reg_mutex);
 }
+EXPORT_SYMBOL_GPL(css_sch_device_unregister);
 
 static void ssd_from_pmcw(struct chsc_ssd_info *ssd, struct pmcw *pmcw)
 {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
