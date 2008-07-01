Return-Path: <linux-kernel-owner+w=401wt.eu-S1759018AbYGAMyf@vger.kernel.org>
Message-Id: <20080701124959.686695069@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/14] cio: Add chsc subchannel driver.
Content-Disposition: inline; filename=128-cio-chsc-driver.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

This patch adds a driver for subchannels of type chsc.

A device /dev/chsc is created which may be used to issue ioctls to:
- obtain information about the machine's I/O configuration
- dynamically change the machine's I/O configuration via
  asynchronous chsc commands

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/ioctl-number.txt |    1 
 arch/s390/Kconfig              |   16 
 drivers/s390/cio/Makefile      |    1 
 drivers/s390/cio/chp.c         |    2 
 drivers/s390/cio/chsc.c        |   48 ++
 drivers/s390/cio/chsc.h        |   21 -
 drivers/s390/cio/chsc_sch.c    |  820 +++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/chsc_sch.h    |   13 
 drivers/s390/cio/cio.c         |    9 
 drivers/s390/cio/cio.h         |    2 
 drivers/s390/cio/css.h         |    3 
 drivers/s390/cio/idset.h       |    2 
 drivers/s390/cio/io_sch.h      |    2 
 drivers/s390/cio/ioasm.h       |    2 
 drivers/s390/cio/qdio.h        |    3 
 drivers/s390/cio/schid.h       |   26 -
 include/asm-s390/Kbuild        |    3 
 include/asm-s390/chpid.h       |    5 
 include/asm-s390/chsc.h        |  127 ++++++
 include/asm-s390/isc.h         |    1 
 include/asm-s390/schid.h       |   28 +
 21 files changed, 1086 insertions(+), 49 deletions(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -345,6 +345,22 @@ config QDIO_DEBUG
 
 	  If unsure, say N.
 
+config CHSC_SCH
+	tristate "Support for CHSC subchannels"
+	help
+	  This driver allows usage of CHSC subchannels. A CHSC subchannel
+	  is usually present on LPAR only.
+	  The driver creates a device /dev/chsc, which may be used to
+	  obtain I/O configuration information about the machine and
+	  to issue asynchronous chsc commands (DANGEROUS).
+	  You will usually only want to use this interface on a special
+	  LPAR designated for system management.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called chsc_sch.
+
+	  If unsure, say N.
+
 comment "Misc"
 
 config IPL
Index: quilt-2.6/Documentation/ioctl-number.txt
===================================================================
--- quilt-2.6.orig/Documentation/ioctl-number.txt
+++ quilt-2.6/Documentation/ioctl-number.txt
@@ -117,6 +117,7 @@ Code	Seq#	Include File		Comments
 					<mailto:natalia@nikhefk.nikhef.nl>
 'c'	00-7F	linux/comstats.h	conflict!
 'c'	00-7F	linux/coda.h		conflict!
+'c'	80-9F	asm-s390/chsc.h
 'd'	00-FF	linux/char/drm/drm/h	conflict!
 'd'	00-DF	linux/video_decoder.h	conflict!
 'd'	F0-FF	linux/digi1.h
Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -407,7 +407,7 @@ int chp_new(struct chp_id chpid)
 		 chpid.id);
 
 	/* Obtain channel path description and fill it in. */
-	ret = chsc_determine_channel_path_description(chpid, &chp->desc);
+	ret = chsc_determine_base_channel_path_desc(chpid, &chp->desc);
 	if (ret)
 		goto out_free;
 	if ((chp->desc.flags & 0x80) == 0) {
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -15,6 +15,7 @@
 
 #include <asm/cio.h>
 #include <asm/chpid.h>
+#include <asm/chsc.h>
 
 #include "../s390mach.h"
 #include "css.h"
@@ -627,23 +628,33 @@ chsc_secm(struct channel_subsystem *css,
 	return ret;
 }
 
-int chsc_determine_channel_path_description(struct chp_id chpid,
-					    struct channel_path_desc *desc)
+int chsc_determine_channel_path_desc(struct chp_id chpid, int fmt, int rfmt,
+				     int c, int m,
+				     struct chsc_response_struct *resp)
 {
 	int ccode, ret;
 
 	struct {
 		struct chsc_header request;
-		u32 : 24;
+		u32 : 2;
+		u32 m : 1;
+		u32 c : 1;
+		u32 fmt : 4;
+		u32 cssid : 8;
+		u32 : 4;
+		u32 rfmt : 4;
 		u32 first_chpid : 8;
 		u32 : 24;
 		u32 last_chpid : 8;
 		u32 zeroes1;
 		struct chsc_header response;
-		u32 zeroes2;
-		struct channel_path_desc desc;
+		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *scpd_area;
 
+	if ((rfmt == 1) && !css_general_characteristics.fcs)
+		return -EINVAL;
+	if ((rfmt == 2) && !css_general_characteristics.cib)
+		return -EINVAL;
 	scpd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scpd_area)
 		return -ENOMEM;
@@ -651,8 +662,13 @@ int chsc_determine_channel_path_descript
 	scpd_area->request.length = 0x0010;
 	scpd_area->request.code = 0x0002;
 
+	scpd_area->cssid = chpid.cssid;
 	scpd_area->first_chpid = chpid.id;
 	scpd_area->last_chpid = chpid.id;
+	scpd_area->m = m;
+	scpd_area->c = c;
+	scpd_area->fmt = fmt;
+	scpd_area->rfmt = rfmt;
 
 	ccode = chsc(scpd_area);
 	if (ccode > 0) {
@@ -663,8 +679,7 @@ int chsc_determine_channel_path_descript
 	ret = chsc_error_from_response(scpd_area->response.code);
 	if (ret == 0)
 		/* Success. */
-		memcpy(desc, &scpd_area->desc,
-		       sizeof(struct channel_path_desc));
+		memcpy(resp, &scpd_area->response, scpd_area->response.length);
 	else
 		CIO_CRW_EVENT(2, "chsc: scpd failed (rc=%04x)\n",
 			      scpd_area->response.code);
@@ -672,6 +687,25 @@ out:
 	free_page((unsigned long)scpd_area);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(chsc_determine_channel_path_desc);
+
+int chsc_determine_base_channel_path_desc(struct chp_id chpid,
+					  struct channel_path_desc *desc)
+{
+	struct chsc_response_struct *chsc_resp;
+	int ret;
+
+	chsc_resp = kzalloc(sizeof(*chsc_resp), GFP_KERNEL);
+	if (!chsc_resp)
+		return -ENOMEM;
+	ret = chsc_determine_channel_path_desc(chpid, 0, 0, 0, 0, chsc_resp);
+	if (ret)
+		goto out_free;
+	memcpy(desc, &chsc_resp->data, chsc_resp->length);
+out_free:
+	kfree(chsc_resp);
+	return ret;
+}
 
 static void
 chsc_initialize_cmg_chars(struct channel_path *chp, u8 cmcv,
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h
+++ quilt-2.6/drivers/s390/cio/chsc.h
@@ -4,7 +4,8 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <asm/chpid.h>
-#include "schid.h"
+#include <asm/chsc.h>
+#include <asm/schid.h>
 
 #define CHSC_SDA_OC_MSS   0x2
 
@@ -37,11 +38,14 @@ struct channel_path_desc {
 struct channel_path;
 
 struct css_general_char {
-	u64 : 41;
+	u64 : 12;
+	u32 dynio : 1;	 /* bit 12 */
+	u32 : 28;
 	u32 aif : 1;     /* bit 41 */
 	u32 : 3;
 	u32 mcss : 1;    /* bit 45 */
-	u32 : 2;
+	u32 fcs : 1;	 /* bit 46 */
+	u32 : 1;
 	u32 ext_mb : 1;  /* bit 48 */
 	u32 : 7;
 	u32 aif_tdd : 1; /* bit 56 */
@@ -49,7 +53,9 @@ struct css_general_char {
 	u32 qebsm : 1;   /* bit 58 */
 	u32 : 8;
 	u32 aif_osa : 1; /* bit 67 */
-	u32 : 20;
+	u32 : 14;
+	u32 cib : 1;	 /* bit 82 */
+	u32 : 5;
 	u32 fcx : 1;	 /* bit 88 */
 	u32 : 7;
 }__attribute__((packed));
@@ -86,8 +92,11 @@ struct channel_subsystem;
 extern int chsc_secm(struct channel_subsystem *, int);
 
 int chsc_chp_vary(struct chp_id chpid, int on);
-int chsc_determine_channel_path_description(struct chp_id chpid,
-					    struct channel_path_desc *desc);
+int chsc_determine_channel_path_desc(struct chp_id chpid, int fmt, int rfmt,
+				     int c, int m,
+				     struct chsc_response_struct *resp);
+int chsc_determine_base_channel_path_desc(struct chp_id chpid,
+					  struct channel_path_desc *desc);
 void chsc_chp_online(struct chp_id chpid);
 void chsc_chp_offline(struct chp_id chpid);
 int chsc_get_channel_measurement_chars(struct channel_path *chp);
Index: quilt-2.6/drivers/s390/cio/chsc_sch.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/chsc_sch.c
@@ -0,0 +1,820 @@
+/*
+ * Driver for s390 chsc subchannels
+ *
+ * Copyright IBM Corp. 2008
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+
+#include <asm/cio.h>
+#include <asm/chsc.h>
+#include <asm/isc.h>
+
+#include "cio.h"
+#include "cio_debug.h"
+#include "css.h"
+#include "chsc_sch.h"
+#include "ioasm.h"
+
+static debug_info_t *chsc_debug_msg_id;
+static debug_info_t *chsc_debug_log_id;
+
+#define CHSC_MSG(imp, args...) do {					\
+		debug_sprintf_event(chsc_debug_msg_id, imp , ##args);	\
+	} while (0)
+
+#define CHSC_LOG(imp, txt) do {					\
+		debug_text_event(chsc_debug_log_id, imp , txt);	\
+	} while (0)
+
+static void CHSC_LOG_HEX(int level, void *data, int length)
+{
+	while (length > 0) {
+		debug_event(chsc_debug_log_id, level, data, length);
+		length -= chsc_debug_log_id->buf_size;
+		data += chsc_debug_log_id->buf_size;
+	}
+}
+
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("driver for s390 chsc subchannels");
+MODULE_LICENSE("GPL");
+
+static void chsc_subchannel_irq(struct subchannel *sch)
+{
+	struct chsc_private *private = sch->private;
+	struct chsc_request *request = private->request;
+	struct irb *irb = (struct irb *)__LC_IRB;
+
+	CHSC_LOG(4, "irb");
+	CHSC_LOG_HEX(4, irb, sizeof(*irb));
+	/* Copy irb to provided request and set done. */
+	if (!request) {
+		CHSC_MSG(0, "Interrupt on sch 0.%x.%04x with no request\n",
+			 sch->schid.ssid, sch->schid.sch_no);
+		return;
+	}
+	private->request = NULL;
+	memcpy(&request->irb, irb, sizeof(*irb));
+	stsch(sch->schid, &sch->schib);
+	complete(&request->completion);
+	put_device(&sch->dev);
+}
+
+static int chsc_subchannel_probe(struct subchannel *sch)
+{
+	struct chsc_private *private;
+	int ret;
+
+	CHSC_MSG(6, "Detected chsc subchannel 0.%x.%04x\n",
+		 sch->schid.ssid, sch->schid.sch_no);
+	sch->isc = CHSC_SCH_ISC;
+	private = kzalloc(sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
+	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+	if (ret) {
+		CHSC_MSG(0, "Failed to enable 0.%x.%04x: %d\n",
+			 sch->schid.ssid, sch->schid.sch_no, ret);
+		kfree(private);
+	} else {
+		sch->private = private;
+		if (sch->dev.uevent_suppress) {
+			sch->dev.uevent_suppress = 0;
+			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+		}
+	}
+	return ret;
+}
+
+static int chsc_subchannel_remove(struct subchannel *sch)
+{
+	struct chsc_private *private;
+
+	cio_disable_subchannel(sch);
+	private = sch->private;
+	sch->private = NULL;
+	if (private->request) {
+		complete(&private->request->completion);
+		put_device(&sch->dev);
+	}
+	kfree(private);
+	return 0;
+}
+
+static void chsc_subchannel_shutdown(struct subchannel *sch)
+{
+	cio_disable_subchannel(sch);
+}
+
+static struct css_device_id chsc_subchannel_ids[] = {
+	{ .match_flags = 0x1, .type =SUBCHANNEL_TYPE_CHSC, },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(css, chsc_subchannel_ids);
+
+static struct css_driver chsc_subchannel_driver = {
+	.owner = THIS_MODULE,
+	.subchannel_type = chsc_subchannel_ids,
+	.irq = chsc_subchannel_irq,
+	.probe = chsc_subchannel_probe,
+	.remove = chsc_subchannel_remove,
+	.shutdown = chsc_subchannel_shutdown,
+	.name = "chsc_subchannel",
+};
+
+static int __init chsc_init_dbfs(void)
+{
+	chsc_debug_msg_id = debug_register("chsc_msg", 16, 1,
+					   16 * sizeof(long));
+	if (!chsc_debug_msg_id)
+		goto out;
+	debug_register_view(chsc_debug_msg_id, &debug_sprintf_view);
+	debug_set_level(chsc_debug_msg_id, 2);
+	chsc_debug_log_id = debug_register("chsc_log", 16, 1, 16);
+	if (!chsc_debug_log_id)
+		goto out;
+	debug_register_view(chsc_debug_log_id, &debug_hex_ascii_view);
+	debug_set_level(chsc_debug_log_id, 2);
+	return 0;
+out:
+	if (chsc_debug_msg_id)
+		debug_unregister(chsc_debug_msg_id);
+	return -ENOMEM;
+}
+
+static void chsc_remove_dbfs(void)
+{
+	debug_unregister(chsc_debug_log_id);
+	debug_unregister(chsc_debug_msg_id);
+}
+
+static int __init chsc_init_sch_driver(void)
+{
+	return css_driver_register(&chsc_subchannel_driver);
+}
+
+static void chsc_cleanup_sch_driver(void)
+{
+	css_driver_unregister(&chsc_subchannel_driver);
+}
+
+static DEFINE_SPINLOCK(chsc_lock);
+
+static int chsc_subchannel_match_next_free(struct device *dev, void *data)
+{
+	struct subchannel *sch = to_subchannel(dev);
+
+	return sch->schib.pmcw.ena && !scsw_fctl(&sch->schib.scsw);
+}
+
+static struct subchannel *chsc_get_next_subchannel(struct subchannel *sch)
+{
+	struct device *dev;
+
+	dev = driver_find_device(&chsc_subchannel_driver.drv,
+				 sch ? &sch->dev : NULL, NULL,
+				 chsc_subchannel_match_next_free);
+	return dev ? to_subchannel(dev) : NULL;
+}
+
+/**
+ * chsc_async() - try to start a chsc request asynchronously
+ * @chsc_area: request to be started
+ * @request: request structure to associate
+ *
+ * Tries to start a chsc request on one of the existing chsc subchannels.
+ * Returns:
+ *  %0 if the request was performed synchronously
+ *  %-EINPROGRESS if the request was successfully started
+ *  %-EBUSY if all chsc subchannels are busy
+ *  %-ENODEV if no chsc subchannels are available
+ * Context:
+ *  interrupts disabled, chsc_lock held
+ */
+static int chsc_async(struct chsc_async_area *chsc_area,
+		      struct chsc_request *request)
+{
+	int cc;
+	struct chsc_private *private;
+	struct subchannel *sch = NULL;
+	int ret = -ENODEV;
+	char dbf[10];
+
+	chsc_area->header.key = PAGE_DEFAULT_KEY;
+	while ((sch = chsc_get_next_subchannel(sch))) {
+		spin_lock(sch->lock);
+		private = sch->private;
+		if (private->request) {
+			spin_unlock(sch->lock);
+			ret = -EBUSY;
+			continue;
+		}
+		chsc_area->header.sid = sch->schid;
+		CHSC_LOG(2, "schid");
+		CHSC_LOG_HEX(2, &sch->schid, sizeof(sch->schid));
+		cc = chsc(chsc_area);
+		sprintf(dbf, "cc:%d", cc);
+		CHSC_LOG(2, dbf);
+		switch (cc) {
+		case 0:
+			ret = 0;
+			break;
+		case 1:
+			sch->schib.scsw.cmd.fctl |= SCSW_FCTL_START_FUNC;
+			ret = -EINPROGRESS;
+			private->request = request;
+			break;
+		case 2:
+			ret = -EBUSY;
+			break;
+		default:
+			ret = -ENODEV;
+		}
+		spin_unlock(sch->lock);
+		CHSC_MSG(2, "chsc on 0.%x.%04x returned cc=%d\n",
+			 sch->schid.ssid, sch->schid.sch_no, cc);
+		if (ret == -EINPROGRESS)
+			return -EINPROGRESS;
+		put_device(&sch->dev);
+		if (ret == 0)
+			return 0;
+	}
+	return ret;
+}
+
+static void chsc_log_command(struct chsc_async_area *chsc_area)
+{
+	char dbf[10];
+
+	sprintf(dbf, "CHSC:%x", chsc_area->header.code);
+	CHSC_LOG(0, dbf);
+	CHSC_LOG_HEX(0, chsc_area, 32);
+}
+
+static int chsc_examine_irb(struct chsc_request *request)
+{
+	int backed_up;
+
+	if (!scsw_stctl(&request->irb.scsw) & SCSW_STCTL_STATUS_PEND)
+		return -EIO;
+	backed_up = scsw_cstat(&request->irb.scsw) & SCHN_STAT_CHAIN_CHECK;
+	request->irb.scsw.cmd.cstat &= ~SCHN_STAT_CHAIN_CHECK;
+	if (scsw_cstat(&request->irb.scsw) == 0)
+		return 0;
+	if (!backed_up)
+		return 0;
+	if (scsw_cstat(&request->irb.scsw) & SCHN_STAT_PROG_CHECK)
+		return -EIO;
+	if (scsw_cstat(&request->irb.scsw) & SCHN_STAT_PROT_CHECK)
+		return -EPERM;
+	if (scsw_cstat(&request->irb.scsw) & SCHN_STAT_CHN_DATA_CHK)
+		return -EAGAIN;
+	if (scsw_cstat(&request->irb.scsw) & SCHN_STAT_CHN_CTRL_CHK)
+		return -EAGAIN;
+	return -EIO;
+}
+
+static int chsc_ioctl_start(void __user *user_area)
+{
+	struct chsc_request *request;
+	struct chsc_async_area *chsc_area;
+	int ret;
+	char dbf[10];
+
+	if (!css_general_characteristics.dynio)
+		/* It makes no sense to try. */
+		return -EOPNOTSUPP;
+	chsc_area = (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
+	if (!chsc_area)
+		return -ENOMEM;
+	request = kzalloc(sizeof(*request), GFP_KERNEL);
+	if (!request) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	init_completion(&request->completion);
+	if (copy_from_user(chsc_area, user_area, PAGE_SIZE)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	chsc_log_command(chsc_area);
+	spin_lock_irq(&chsc_lock);
+	ret = chsc_async(chsc_area, request);
+	spin_unlock_irq(&chsc_lock);
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&request->completion);
+		ret = chsc_examine_irb(request);
+	}
+	/* copy area back to user */
+	if (!ret)
+		if (copy_to_user(user_area, chsc_area, PAGE_SIZE))
+			ret = -EFAULT;
+out_free:
+	sprintf(dbf, "ret:%d", ret);
+	CHSC_LOG(0, dbf);
+	kfree(request);
+	free_page((unsigned long)chsc_area);
+	return ret;
+}
+
+static int chsc_ioctl_info_channel_path(void __user *user_cd)
+{
+	struct chsc_chp_cd *cd;
+	int ret, ccode;
+	struct {
+		struct chsc_header request;
+		u32 : 2;
+		u32 m : 1;
+		u32 : 1;
+		u32 fmt1 : 4;
+		u32 cssid : 8;
+		u32 : 8;
+		u32 first_chpid : 8;
+		u32 : 24;
+		u32 last_chpid : 8;
+		u32 : 32;
+		struct chsc_header response;
+		u8 data[PAGE_SIZE - 20];
+	} __attribute__ ((packed)) *scpcd_area;
+
+	scpcd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!scpcd_area)
+		return -ENOMEM;
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (copy_from_user(cd, user_cd, sizeof(*cd))) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	scpcd_area->request.length = 0x0010;
+	scpcd_area->request.code = 0x0028;
+	scpcd_area->m = cd->m;
+	scpcd_area->fmt1 = cd->fmt;
+	scpcd_area->cssid = cd->chpid.cssid;
+	scpcd_area->first_chpid = cd->chpid.id;
+	scpcd_area->last_chpid = cd->chpid.id;
+
+	ccode = chsc(scpcd_area);
+	if (ccode != 0) {
+		ret = -EIO;
+		goto out_free;
+	}
+	if (scpcd_area->response.code != 0x0001) {
+		ret = -EIO;
+		CHSC_MSG(0, "scpcd: response code=%x\n",
+			 scpcd_area->response.code);
+		goto out_free;
+	}
+	memcpy(&cd->cpcb, &scpcd_area->response, scpcd_area->response.length);
+	if (copy_to_user(user_cd, cd, sizeof(*cd)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+out_free:
+	kfree(cd);
+	free_page((unsigned long)scpcd_area);
+	return ret;
+}
+
+static int chsc_ioctl_info_cu(void __user *user_cd)
+{
+	struct chsc_cu_cd *cd;
+	int ret, ccode;
+	struct {
+		struct chsc_header request;
+		u32 : 2;
+		u32 m : 1;
+		u32 : 1;
+		u32 fmt1 : 4;
+		u32 cssid : 8;
+		u32 : 8;
+		u32 first_cun : 8;
+		u32 : 24;
+		u32 last_cun : 8;
+		u32 : 32;
+		struct chsc_header response;
+		u8 data[PAGE_SIZE - 20];
+	} __attribute__ ((packed)) *scucd_area;
+
+	scucd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!scucd_area)
+		return -ENOMEM;
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (copy_from_user(cd, user_cd, sizeof(*cd))) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	scucd_area->request.length = 0x0010;
+	scucd_area->request.code = 0x0028;
+	scucd_area->m = cd->m;
+	scucd_area->fmt1 = cd->fmt;
+	scucd_area->cssid = cd->cssid;
+	scucd_area->first_cun = cd->cun;
+	scucd_area->last_cun = cd->cun;
+
+	ccode = chsc(scucd_area);
+	if (ccode != 0) {
+		ret = -EIO;
+		goto out_free;
+	}
+	if (scucd_area->response.code != 0x0001) {
+		ret = -EIO;
+		CHSC_MSG(0, "scucd: response code=%x\n",
+			 scucd_area->response.code);
+		goto out_free;
+	}
+	memcpy(&cd->cucb, &scucd_area->response, scucd_area->response.length);
+	if (copy_to_user(user_cd, cd, sizeof(*cd)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+out_free:
+	kfree(cd);
+	free_page((unsigned long)scucd_area);
+	return ret;
+}
+
+static int chsc_ioctl_info_sch_cu(void __user *user_cud)
+{
+	struct chsc_sch_cud *cud;
+	int ret, ccode;
+	struct {
+		struct chsc_header request;
+		u32 : 2;
+		u32 m : 1;
+		u32 : 5;
+		u32 fmt1 : 4;
+		u32 : 2;
+		u32 ssid : 2;
+		u32 first_sch : 16;
+		u32 : 8;
+		u32 cssid : 8;
+		u32 last_sch : 16;
+		u32 : 32;
+		struct chsc_header response;
+		u8 data[PAGE_SIZE - 20];
+	} __attribute__ ((packed)) *sscud_area;
+
+	sscud_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sscud_area)
+		return -ENOMEM;
+	cud = kzalloc(sizeof(*cud), GFP_KERNEL);
+	if (!cud) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (copy_from_user(cud, user_cud, sizeof(*cud))) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	sscud_area->request.length = 0x0010;
+	sscud_area->request.code = 0x0006;
+	sscud_area->m = cud->schid.m;
+	sscud_area->fmt1 = cud->fmt;
+	sscud_area->ssid = cud->schid.ssid;
+	sscud_area->first_sch = cud->schid.sch_no;
+	sscud_area->cssid = cud->schid.cssid;
+	sscud_area->last_sch = cud->schid.sch_no;
+
+	ccode = chsc(sscud_area);
+	if (ccode != 0) {
+		ret = -EIO;
+		goto out_free;
+	}
+	if (sscud_area->response.code != 0x0001) {
+		ret = -EIO;
+		CHSC_MSG(0, "sscud: response code=%x\n",
+			 sscud_area->response.code);
+		goto out_free;
+	}
+	memcpy(&cud->scub, &sscud_area->response, sscud_area->response.length);
+	if (copy_to_user(user_cud, cud, sizeof(*cud)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+out_free:
+	kfree(cud);
+	free_page((unsigned long)sscud_area);
+	return ret;
+}
+
+static int chsc_ioctl_conf_info(void __user *user_ci)
+{
+	struct chsc_conf_info *ci;
+	int ret, ccode;
+	struct {
+		struct chsc_header request;
+		u32 : 2;
+		u32 m : 1;
+		u32 : 1;
+		u32 fmt1 : 4;
+		u32 cssid : 8;
+		u32 : 6;
+		u32 ssid : 2;
+		u32 : 8;
+		u64 : 64;
+		struct chsc_header response;
+		u8 data[PAGE_SIZE - 20];
+	} __attribute__ ((packed)) *sci_area;
+
+	sci_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sci_area)
+		return -ENOMEM;
+	ci = kzalloc(sizeof(*ci), GFP_KERNEL);
+	if (!ci) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (copy_from_user(ci, user_ci, sizeof(*ci))) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	sci_area->request.length = 0x0010;
+	sci_area->request.code = 0x0012;
+	sci_area->m = ci->id.m;
+	sci_area->fmt1 = ci->fmt;
+	sci_area->cssid = ci->id.cssid;
+	sci_area->ssid = ci->id.ssid;
+
+	ccode = chsc(sci_area);
+	if (ccode != 0) {
+		ret = -EIO;
+		goto out_free;
+	}
+	if (sci_area->response.code != 0x0001) {
+		ret = -EIO;
+		CHSC_MSG(0, "sci: response code=%x\n",
+			 sci_area->response.code);
+		goto out_free;
+	}
+	memcpy(&ci->scid, &sci_area->response, sci_area->response.length);
+	if (copy_to_user(user_ci, ci, sizeof(*ci)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+out_free:
+	kfree(ci);
+	free_page((unsigned long)sci_area);
+	return ret;
+}
+
+static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
+{
+	struct chsc_comp_list *ccl;
+	int ret, ccode;
+	struct {
+		struct chsc_header request;
+		u32 ctype : 8;
+		u32 : 4;
+		u32 fmt : 4;
+		u32 : 16;
+		u64 : 64;
+		u32 list_parm[2];
+		u64 : 64;
+		struct chsc_header response;
+		u8 data[PAGE_SIZE - 36];
+	} __attribute__ ((packed)) *sccl_area;
+	struct {
+		u32 m : 1;
+		u32 : 31;
+		u32 cssid : 8;
+		u32 : 16;
+		u32 chpid : 8;
+	} __attribute__ ((packed)) *chpid_parm;
+	struct {
+		u32 f_cssid : 8;
+		u32 l_cssid : 8;
+		u32 : 16;
+		u32 res;
+	} __attribute__ ((packed)) *cssids_parm;
+
+	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sccl_area)
+		return -ENOMEM;
+	ccl = kzalloc(sizeof(*ccl), GFP_KERNEL);
+	if (!ccl) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (copy_from_user(ccl, user_ccl, sizeof(*ccl))) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	sccl_area->request.length = 0x0020;
+	sccl_area->request.code = 0x0030;
+	sccl_area->fmt = ccl->req.fmt;
+	sccl_area->ctype = ccl->req.ctype;
+	switch (sccl_area->ctype) {
+	case CCL_CU_ON_CHP:
+	case CCL_IOP_CHP:
+		chpid_parm = (void *)&sccl_area->list_parm;
+		chpid_parm->m = ccl->req.chpid.m;
+		chpid_parm->cssid = ccl->req.chpid.chp.cssid;
+		chpid_parm->chpid = ccl->req.chpid.chp.id;
+		break;
+	case CCL_CSS_IMG:
+	case CCL_CSS_IMG_CONF_CHAR:
+		cssids_parm = (void *)&sccl_area->list_parm;
+		cssids_parm->f_cssid = ccl->req.cssids.f_cssid;
+		cssids_parm->l_cssid = ccl->req.cssids.l_cssid;
+		break;
+	}
+	ccode = chsc(sccl_area);
+	if (ccode != 0) {
+		ret = -EIO;
+		goto out_free;
+	}
+	if (sccl_area->response.code != 0x0001) {
+		ret = -EIO;
+		CHSC_MSG(0, "sccl: response code=%x\n",
+			 sccl_area->response.code);
+		goto out_free;
+	}
+	memcpy(&ccl->sccl, &sccl_area->response, sccl_area->response.length);
+	if (copy_to_user(user_ccl, ccl, sizeof(*ccl)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+out_free:
+	kfree(ccl);
+	free_page((unsigned long)sccl_area);
+	return ret;
+}
+
+static int chsc_ioctl_chpd(void __user *user_chpd)
+{
+	struct chsc_cpd_info *chpd;
+	int ret;
+
+	chpd = kzalloc(sizeof(*chpd), GFP_KERNEL);
+	if (!chpd)
+		return -ENOMEM;
+	if (copy_from_user(chpd, user_chpd, sizeof(*chpd))) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	ret = chsc_determine_channel_path_desc(chpd->chpid, chpd->fmt,
+					       chpd->rfmt, chpd->c, chpd->m,
+					       &chpd->chpdb);
+	if (ret)
+		goto out_free;
+	if (copy_to_user(user_chpd, chpd, sizeof(*chpd)))
+		ret = -EFAULT;
+out_free:
+	kfree(chpd);
+	return ret;
+}
+
+static int chsc_ioctl_dcal(void __user *user_dcal)
+{
+	struct chsc_dcal *dcal;
+	int ret, ccode;
+	struct {
+		struct chsc_header request;
+		u32 atype : 8;
+		u32 : 4;
+		u32 fmt : 4;
+		u32 : 16;
+		u32 res0[2];
+		u32 list_parm[2];
+		u32 res1[2];
+		struct chsc_header response;
+		u8 data[PAGE_SIZE - 36];
+	} __attribute__ ((packed)) *sdcal_area;
+
+	sdcal_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sdcal_area)
+		return -ENOMEM;
+	dcal = kzalloc(sizeof(*dcal), GFP_KERNEL);
+	if (!dcal) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (copy_from_user(dcal, user_dcal, sizeof(*dcal))) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	sdcal_area->request.length = 0x0020;
+	sdcal_area->request.code = 0x0034;
+	sdcal_area->atype = dcal->req.atype;
+	sdcal_area->fmt = dcal->req.fmt;
+	memcpy(&sdcal_area->list_parm, &dcal->req.list_parm,
+	       sizeof(sdcal_area->list_parm));
+
+	ccode = chsc(sdcal_area);
+	if (ccode != 0) {
+		ret = -EIO;
+		goto out_free;
+	}
+	if (sdcal_area->response.code != 0x0001) {
+		ret = -EIO;
+		CHSC_MSG(0, "sdcal: response code=%x\n",
+			 sdcal_area->response.code);
+		goto out_free;
+	}
+	memcpy(&dcal->sdcal, &sdcal_area->response,
+	       sdcal_area->response.length);
+	if (copy_to_user(user_dcal, dcal, sizeof(*dcal)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+out_free:
+	kfree(dcal);
+	free_page((unsigned long)sdcal_area);
+	return ret;
+}
+
+static long chsc_ioctl(struct file *filp, unsigned int cmd,
+		       unsigned long arg)
+{
+	CHSC_MSG(2, "chsc_ioctl called, cmd=%x\n", cmd);
+	switch (cmd) {
+	case CHSC_START:
+		return chsc_ioctl_start((void __user *)arg);
+	case CHSC_INFO_CHANNEL_PATH:
+		return chsc_ioctl_info_channel_path((void __user *)arg);
+	case CHSC_INFO_CU:
+		return chsc_ioctl_info_cu((void __user *)arg);
+	case CHSC_INFO_SCH_CU:
+		return chsc_ioctl_info_sch_cu((void __user *)arg);
+	case CHSC_INFO_CI:
+		return chsc_ioctl_conf_info((void __user *)arg);
+	case CHSC_INFO_CCL:
+		return chsc_ioctl_conf_comp_list((void __user *)arg);
+	case CHSC_INFO_CPD:
+		return chsc_ioctl_chpd((void __user *)arg);
+	case CHSC_INFO_DCAL:
+		return chsc_ioctl_dcal((void __user *)arg);
+	default: /* unknown ioctl number */
+		return -ENOIOCTLCMD;
+	}
+}
+
+static const struct file_operations chsc_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = chsc_ioctl,
+	.compat_ioctl = chsc_ioctl,
+};
+
+static struct miscdevice chsc_misc_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "chsc",
+	.fops = &chsc_fops,
+};
+
+static int __init chsc_misc_init(void)
+{
+	return misc_register(&chsc_misc_device);
+}
+
+static void chsc_misc_cleanup(void)
+{
+	misc_deregister(&chsc_misc_device);
+}
+
+static int __init chsc_sch_init(void)
+{
+	int ret;
+
+	ret = chsc_init_dbfs();
+	if (ret)
+		return ret;
+	isc_register(CHSC_SCH_ISC);
+	ret = chsc_init_sch_driver();
+	if (ret)
+		goto out_dbf;
+	ret = chsc_misc_init();
+	if (ret)
+		goto out_driver;
+	return ret;
+out_driver:
+	chsc_cleanup_sch_driver();
+out_dbf:
+	isc_unregister(CHSC_SCH_ISC);
+	chsc_remove_dbfs();
+	return ret;
+}
+
+static void __exit chsc_sch_exit(void)
+{
+	chsc_misc_cleanup();
+	chsc_cleanup_sch_driver();
+	isc_unregister(CHSC_SCH_ISC);
+	chsc_remove_dbfs();
+}
+
+module_init(chsc_sch_init);
+module_exit(chsc_sch_exit);
Index: quilt-2.6/drivers/s390/cio/chsc_sch.h
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/chsc_sch.h
@@ -0,0 +1,13 @@
+#ifndef _CHSC_SCH_H
+#define _CHSC_SCH_H
+
+struct chsc_request {
+	struct completion completion;
+	struct irb irb;
+};
+
+struct chsc_private {
+	struct chsc_request *request;
+};
+
+#endif
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -877,6 +877,12 @@ __clear_io_subchannel_easy(struct subcha
 	return -EBUSY;
 }
 
+static void __clear_chsc_subchannel_easy(void)
+{
+	/* It seems we can only wait for a bit here :/ */
+	udelay_reset(100);
+}
+
 static int pgm_check_occured;
 
 static void cio_reset_pgm_check_handler(void)
@@ -920,6 +926,9 @@ static int __shutdown_subchannel_easy(st
 			if (__clear_io_subchannel_easy(schid))
 				goto out; /* give up... */
 			break;
+		case SUBCHANNEL_TYPE_CHSC:
+			__clear_chsc_subchannel_easy();
+			break;
 		default:
 			/* No default clear strategy */
 			break;
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -7,8 +7,8 @@
 #include <asm/chpid.h>
 #include <asm/cio.h>
 #include <asm/fcx.h>
+#include <asm/schid.h>
 #include "chsc.h"
-#include "schid.h"
 
 /*
  * path management control word
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -9,8 +9,7 @@
 
 #include <asm/cio.h>
 #include <asm/chpid.h>
-
-#include "schid.h"
+#include <asm/schid.h>
 
 /*
  * path grouping stuff
Index: quilt-2.6/drivers/s390/cio/idset.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/idset.h
+++ quilt-2.6/drivers/s390/cio/idset.h
@@ -8,7 +8,7 @@
 #ifndef S390_IDSET_H
 #define S390_IDSET_H S390_IDSET_H
 
-#include "schid.h"
+#include <asm/schid.h>
 
 struct idset;
 
Index: quilt-2.6/drivers/s390/cio/ioasm.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ioasm.h
+++ quilt-2.6/drivers/s390/cio/ioasm.h
@@ -2,7 +2,7 @@
 #define S390_CIO_IOASM_H
 
 #include <asm/chpid.h>
-#include "schid.h"
+#include <asm/schid.h>
 
 /*
  * TPI info structure
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h
+++ quilt-2.6/drivers/s390/cio/io_sch.h
@@ -1,7 +1,7 @@
 #ifndef S390_IO_SCH_H
 #define S390_IO_SCH_H
 
-#include "schid.h"
+#include <asm/schid.h>
 
 /*
  * command-mode operation request block
Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile
+++ quilt-2.6/drivers/s390/cio/Makefile
@@ -7,5 +7,6 @@ obj-y += airq.o blacklist.o chsc.o cio.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
+obj-$(CONFIG_CHSC_SCH) += chsc_sch.o
 obj-$(CONFIG_CCWGROUP) += ccwgroup.o
 obj-$(CONFIG_QDIO) += qdio.o
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -3,8 +3,7 @@
 
 #include <asm/page.h>
 #include <asm/isc.h>
-
-#include "schid.h"
+#include <asm/schid.h>
 
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_VERBOSE_LEVEL 9
Index: quilt-2.6/drivers/s390/cio/schid.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/schid.h
+++ /dev/null
@@ -1,26 +0,0 @@
-#ifndef S390_SCHID_H
-#define S390_SCHID_H
-
-struct subchannel_id {
-	__u32 reserved:13;
-	__u32 ssid:2;
-	__u32 one:1;
-	__u32 sch_no:16;
-} __attribute__ ((packed,aligned(4)));
-
-
-/* Helper function for sane state of pre-allocated subchannel_id. */
-static inline void
-init_subchannel_id(struct subchannel_id *schid)
-{
-	memset(schid, 0, sizeof(struct subchannel_id));
-	schid->one = 1;
-}
-
-static inline int
-schid_equal(struct subchannel_id *schid1, struct subchannel_id *schid2)
-{
-	return !memcmp(schid1, schid2, sizeof(struct subchannel_id));
-}
-
-#endif /* S390_SCHID_H */
Index: quilt-2.6/include/asm-s390/chpid.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/chpid.h
+++ quilt-2.6/include/asm-s390/chpid.h
@@ -10,7 +10,6 @@
 
 #include <linux/string.h>
 #include <asm/types.h>
-#include <asm/cio.h>
 
 #define __MAX_CHPID 255
 
@@ -41,6 +40,9 @@ static inline void chp_id_next(struct ch
 	}
 }
 
+#ifdef __KERNEL__
+#include <asm/cio.h>
+
 static inline int chp_id_is_valid(struct chp_id *chpid)
 {
 	return (chpid->cssid <= __MAX_CSSID);
@@ -49,5 +51,6 @@ static inline int chp_id_is_valid(struct
 
 #define chp_id_for_each(c) \
 	for (chp_id_init(c); chp_id_is_valid(c); chp_id_next(c))
+#endif /* __KERNEL */
 
 #endif /* _ASM_S390_CHPID_H */
Index: quilt-2.6/include/asm-s390/chsc.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/chsc.h
@@ -0,0 +1,127 @@
+/*
+ * ioctl interface for /dev/chsc
+ *
+ * Copyright 2008 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ */
+
+#ifndef _ASM_CHSC_H
+#define _ASM_CHSC_H
+
+#include <asm/chpid.h>
+#include <asm/schid.h>
+
+struct chsc_async_header {
+	__u16 length;
+	__u16 code;
+	__u32 cmd_dependend;
+	__u32 key : 4;
+	__u32 : 28;
+	struct subchannel_id sid;
+} __attribute__ ((packed));
+
+struct chsc_async_area {
+	struct chsc_async_header header;
+	__u8 data[PAGE_SIZE - 16 /* size of chsc_async_header */];
+} __attribute__ ((packed));
+
+
+struct chsc_response_struct {
+	__u16 length;
+	__u16 code;
+	__u32 parms;
+	__u8 data[PAGE_SIZE - 8];
+} __attribute__ ((packed));
+
+struct chsc_chp_cd {
+	struct chp_id chpid;
+	int m;
+	int fmt;
+	struct chsc_response_struct cpcb;
+};
+
+struct chsc_cu_cd {
+	__u16 cun;
+	__u8 cssid;
+	int m;
+	int fmt;
+	struct chsc_response_struct cucb;
+};
+
+struct chsc_sch_cud {
+	struct subchannel_id schid;
+	int fmt;
+	struct chsc_response_struct scub;
+};
+
+struct conf_id {
+	int m;
+	__u8 cssid;
+	__u8 ssid;
+};
+
+struct chsc_conf_info {
+	struct conf_id id;
+	int fmt;
+	struct chsc_response_struct scid;
+};
+
+struct ccl_parm_chpid {
+	int m;
+	struct chp_id chp;
+};
+
+struct ccl_parm_cssids {
+	__u8 f_cssid;
+	__u8 l_cssid;
+};
+
+struct chsc_comp_list {
+	struct {
+		enum {
+			CCL_CU_ON_CHP = 1,
+			CCL_CHP_TYPE_CAP = 2,
+			CCL_CSS_IMG = 4,
+			CCL_CSS_IMG_CONF_CHAR = 5,
+			CCL_IOP_CHP = 6,
+		} ctype;
+		int fmt;
+		struct ccl_parm_chpid chpid;
+		struct ccl_parm_cssids cssids;
+	} req;
+	struct chsc_response_struct sccl;
+};
+
+struct chsc_dcal {
+	struct {
+		enum {
+			DCAL_CSS_IID_PN = 4,
+		} atype;
+		__u32 list_parm[2];
+		int fmt;
+	} req;
+	struct chsc_response_struct sdcal;
+};
+
+struct chsc_cpd_info {
+	struct chp_id chpid;
+	int m;
+	int fmt;
+	int rfmt;
+	int c;
+	struct chsc_response_struct chpdb;
+};
+
+#define CHSC_IOCTL_MAGIC 'c'
+
+#define CHSC_START _IOWR(CHSC_IOCTL_MAGIC, 0x81, struct chsc_async_area)
+#define CHSC_INFO_CHANNEL_PATH _IOWR(CHSC_IOCTL_MAGIC, 0x82, \
+				    struct chsc_chp_cd)
+#define CHSC_INFO_CU _IOWR(CHSC_IOCTL_MAGIC, 0x83, struct chsc_cu_cd)
+#define CHSC_INFO_SCH_CU _IOWR(CHSC_IOCTL_MAGIC, 0x84, struct chsc_sch_cud)
+#define CHSC_INFO_CI _IOWR(CHSC_IOCTL_MAGIC, 0x85, struct chsc_conf_info)
+#define CHSC_INFO_CCL _IOWR(CHSC_IOCTL_MAGIC, 0x86, struct chsc_comp_list)
+#define CHSC_INFO_CPD _IOWR(CHSC_IOCTL_MAGIC, 0x87, struct chsc_cpd_info)
+#define CHSC_INFO_DCAL _IOWR(CHSC_IOCTL_MAGIC, 0x88, struct chsc_dcal)
+
+#endif
Index: quilt-2.6/include/asm-s390/isc.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/isc.h
+++ quilt-2.6/include/asm-s390/isc.h
@@ -14,6 +14,7 @@
 /* Regular I/O interrupts. */
 #define IO_SCH_ISC 3			/* regular I/O subchannels */
 #define CONSOLE_ISC 1			/* console I/O subchannel */
+#define CHSC_SCH_ISC 7			/* CHSC subchannels */
 /* Adapter interrupts. */
 #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
 
Index: quilt-2.6/include/asm-s390/Kbuild
===================================================================
--- quilt-2.6.orig/include/asm-s390/Kbuild
+++ quilt-2.6/include/asm-s390/Kbuild
@@ -8,6 +8,9 @@ header-y += ucontext.h
 header-y += vtoc.h
 header-y += zcrypt.h
 header-y += kvm.h
+header-y += schid.h
+header-y += chsc.h
 
 unifdef-y += cmb.h
 unifdef-y += debug.h
+unifdef-y += chpid.h
Index: quilt-2.6/include/asm-s390/schid.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/schid.h
@@ -0,0 +1,28 @@
+#ifndef ASM_SCHID_H
+#define ASM_SCHID_H
+
+struct subchannel_id {
+	__u32 cssid : 8;
+	__u32 : 4;
+	__u32 m : 1;
+	__u32 ssid : 2;
+	__u32 one : 1;
+	__u32 sch_no : 16;
+} __attribute__ ((packed, aligned(4)));
+
+
+/* Helper function for sane state of pre-allocated subchannel_id. */
+static inline void
+init_subchannel_id(struct subchannel_id *schid)
+{
+	memset(schid, 0, sizeof(struct subchannel_id));
+	schid->one = 1;
+}
+
+static inline int
+schid_equal(struct subchannel_id *schid1, struct subchannel_id *schid2)
+{
+	return !memcmp(schid1, schid2, sizeof(struct subchannel_id));
+}
+
+#endif /* ASM_SCHID_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
