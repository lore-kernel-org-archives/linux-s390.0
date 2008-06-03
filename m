Return-Path: <linux-kernel-owner+w=401wt.eu-S1757762AbYFCRJR@vger.kernel.org>
Message-Id: <20080603170519.331710663@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/14] cio: Cleanup crw interface.
Content-Disposition: inline; filename=103-cio-crw-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Eliminate the need for the machine check handler to call into
the common I/O layer directly by introducing an interface to
register handlers for crws per rsc.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.c  |   49 +++++++++++++++++++----
 drivers/s390/cio/chp.h  |    1 
 drivers/s390/cio/chsc.c |   25 +++++++++--
 drivers/s390/cio/chsc.h |    2 
 drivers/s390/cio/css.c  |   31 +++++++++++---
 drivers/s390/cio/css.h  |    1 
 drivers/s390/s390mach.c |  102 +++++++++++++++++++++---------------------------
 drivers/s390/s390mach.h |    7 +++
 8 files changed, 140 insertions(+), 78 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -18,6 +18,7 @@
 #include <asm/chpid.h>
 #include <asm/sclp.h>
 
+#include "../s390mach.h"
 #include "cio.h"
 #include "css.h"
 #include "ioasm.h"
@@ -476,24 +477,52 @@ void *chp_get_chp_desc(struct chp_id chp
 
 /**
  * chp_process_crw - process channel-path status change
- * @id: channel-path ID number
- * @status: non-zero if channel-path has become available, zero otherwise
+ * @crw0: channel report-word to handler
+ * @crw1: second channel-report word (always NULL)
+ * @overflow: crw overflow indication
  *
  * Handle channel-report-words indicating that the status of a channel-path
  * has changed.
  */
-void chp_process_crw(int id, int status)
+static void chp_process_crw(struct crw *crw0, struct crw *crw1,
+			    int overflow)
 {
 	struct chp_id chpid;
 
+	if (overflow) {
+		css_schedule_eval_all();
+		return;
+	}
+	CIO_CRW_EVENT(2, "CRW reports slct=%d, oflw=%d, "
+		      "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+		      crw0->slct, crw0->oflw, crw0->chn, crw0->rsc, crw0->anc,
+		      crw0->erc, crw0->rsid);
+	/*
+	 * Check for solicited machine checks. These are
+	 * created by reset channel path and need not be
+	 * handled here.
+	 */
+	if (crw0->slct) {
+		CIO_CRW_EVENT(2, "solicited machine check for "
+			      "channel path %02X\n", crw0->rsid);
+		return;
+	}
 	chp_id_init(&chpid);
-	chpid.id = id;
-	if (status) {
+	chpid.id = crw0->rsid;
+	switch (crw0->erc) {
+	case CRW_ERC_IPARM: /* Path has come. */
 		if (!chp_is_registered(chpid))
 			chp_new(chpid);
 		chsc_chp_online(chpid);
-	} else
+		break;
+	case CRW_ERC_PERRI: /* Path has gone. */
+	case CRW_ERC_PERRN:
 		chsc_chp_offline(chpid);
+		break;
+	default:
+		CIO_CRW_EVENT(2, "Don't know how to handle erc=%x\n",
+			      crw0->erc);
+	}
 }
 
 int chp_ssd_get_mask(struct chsc_ssd_info *ssd, struct res_acc_data *data)
@@ -674,10 +703,16 @@ static int cfg_wait_idle(void)
 static int __init chp_init(void)
 {
 	struct chp_id chpid;
+	int ret;
 
+	ret = s390_register_crw_handler(CRW_RSC_CPATH, chp_process_crw);
+	if (ret)
+		return ret;
 	chp_wq = create_singlethread_workqueue("cio_chp");
-	if (!chp_wq)
+	if (!chp_wq) {
+		s390_unregister_crw_handler(CRW_RSC_CPATH);
 		return -ENOMEM;
+	}
 	INIT_WORK(&cfg_work, cfg_func);
 	init_waitqueue_head(&cfg_wait_queue);
 	if (info_update())
Index: quilt-2.6/drivers/s390/cio/chp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.h
+++ quilt-2.6/drivers/s390/cio/chp.h
@@ -54,7 +54,6 @@ int chp_get_status(struct chp_id chpid);
 u8 chp_get_sch_opm(struct subchannel *sch);
 int chp_is_registered(struct chp_id chpid);
 void *chp_get_chp_desc(struct chp_id chpid);
-void chp_process_crw(int id, int available);
 void chp_remove_cmg_attr(struct channel_path *chp);
 int chp_add_cmg_attr(struct channel_path *chp);
 int chp_new(struct chp_id chpid);
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -16,6 +16,7 @@
 #include <asm/cio.h>
 #include <asm/chpid.h>
 
+#include "../s390mach.h"
 #include "css.h"
 #include "cio.h"
 #include "cio_debug.h"
@@ -372,17 +373,25 @@ static void chsc_process_sei(struct chsc
 	}
 }
 
-void chsc_process_crw(void)
+static void chsc_process_crw(struct crw *crw0, struct crw *crw1, int overflow)
 {
 	struct chsc_sei_area *sei_area;
 
+	if (overflow) {
+		css_schedule_eval_all();
+		return;
+	}
+	CIO_CRW_EVENT(2, "CRW reports slct=%d, oflw=%d, "
+		      "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+		      crw0->slct, crw0->oflw, crw0->chn, crw0->rsc, crw0->anc,
+		      crw0->erc, crw0->rsid);
 	if (!sei_page)
 		return;
 	/* Access to sei_page is serialized through machine check handler
 	 * thread, so no need for locking. */
 	sei_area = sei_page;
 
-	CIO_TRACE_EVENT( 2, "prcss");
+	CIO_TRACE_EVENT(2, "prcss");
 	do {
 		memset(sei_area, 0, sizeof(*sei_area));
 		sei_area->request.length = 0x0010;
@@ -751,15 +760,23 @@ out:
 
 int __init chsc_alloc_sei_area(void)
 {
+	int ret;
+
 	sei_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!sei_page)
+	if (!sei_page) {
 		CIO_MSG_EVENT(0, "Can't allocate page for processing of "
 			      "chsc machine checks!\n");
-	return (sei_page ? 0 : -ENOMEM);
+		return -ENOMEM;
+	}
+	ret = s390_register_crw_handler(CRW_RSC_CSS, chsc_process_crw);
+	if (ret)
+		kfree(sei_page);
+	return ret;
 }
 
 void __init chsc_free_sei_area(void)
 {
+	s390_unregister_crw_handler(CRW_RSC_CSS);
 	kfree(sei_page);
 }
 
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h
+++ quilt-2.6/drivers/s390/cio/chsc.h
@@ -36,8 +36,6 @@ struct channel_path_desc {
 
 struct channel_path;
 
-extern void chsc_process_crw(void);
-
 struct css_general_char {
 	u64 : 41;
 	u32 aif : 1;     /* bit 41 */
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/reboot.h>
 
+#include "../s390mach.h"
 #include "css.h"
 #include "cio.h"
 #include "cio_debug.h"
@@ -530,18 +531,29 @@ EXPORT_SYMBOL_GPL(css_schedule_reprobe);
 /*
  * Called from the machine check handler for subchannel report words.
  */
-void css_process_crw(int rsid1, int rsid2)
+static void css_process_crw(struct crw *crw0, struct crw *crw1, int overflow)
 {
 	struct subchannel_id mchk_schid;
 
-	CIO_CRW_EVENT(2, "source is subchannel %04X, subsystem id %x\n",
-		      rsid1, rsid2);
+	if (overflow) {
+		css_schedule_eval_all();
+		return;
+	}
+	CIO_CRW_EVENT(2, "CRW0 reports slct=%d, oflw=%d, "
+		      "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+		      crw0->slct, crw0->oflw, crw0->chn, crw0->rsc, crw0->anc,
+		      crw0->erc, crw0->rsid);
+	if (crw1)
+		CIO_CRW_EVENT(2, "CRW1 reports slct=%d, oflw=%d, "
+			      "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+			      crw1->slct, crw1->oflw, crw1->chn, crw1->rsc,
+			      crw1->anc, crw1->erc, crw1->rsid);
 	init_subchannel_id(&mchk_schid);
-	mchk_schid.sch_no = rsid1;
-	if (rsid2 != 0)
-		mchk_schid.ssid = (rsid2 >> 8) & 3;
+	mchk_schid.sch_no = crw0->rsid;
+	if (crw1)
+		mchk_schid.ssid = (crw1->rsid >> 8) & 3;
 
-	/* 
+	/*
 	 * Since we are always presented with IPI in the CRW, we have to
 	 * use stsch() to find out if the subchannel in question has come
 	 * or gone.
@@ -740,6 +752,10 @@ init_channel_subsystem (void)
 	if (ret)
 		goto out;
 
+	ret = s390_register_crw_handler(CRW_RSC_SCH, css_process_crw);
+	if (ret)
+		goto out;
+
 	if ((ret = bus_register(&css_bus_type)))
 		goto out;
 
@@ -817,6 +833,7 @@ out_unregister:
 out_bus:
 	bus_unregister(&css_bus_type);
 out:
+	s390_unregister_crw_handler(CRW_RSC_CSS);
 	chsc_free_sei_area();
 	kfree(slow_subchannel_set);
 	printk(KERN_WARNING"cio: failed to initialize css driver (%d)!\n",
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -103,7 +103,6 @@ int for_each_subchannel_staged(int (*fn_
 			       int (*fn_unknown)(struct subchannel_id,
 			       void *), void *data);
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
-extern void css_process_crw(int, int);
 extern void css_reiterate_subchannels(void);
 void css_update_ssd_info(struct subchannel *sch);
 
Index: quilt-2.6/drivers/s390/s390mach.c
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.c
+++ quilt-2.6/drivers/s390/s390mach.c
@@ -2,10 +2,10 @@
  *  drivers/s390/s390mach.c
  *   S/390 machine check handler
  *
- *  S390 version
- *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright IBM Corp. 2000,2008
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *		 Cornelia Huck <cornelia.huck@de.ibm.com>
  */
 
 #include <linux/init.h>
@@ -18,10 +18,6 @@
 #include <asm/etr.h>
 #include <asm/lowcore.h>
 #include <asm/cio.h>
-#include "cio/cio.h"
-#include "cio/chsc.h"
-#include "cio/css.h"
-#include "cio/chp.h"
 #include "s390mach.h"
 
 static struct semaphore m_sem;
@@ -36,13 +32,40 @@ s390_handle_damage(char *msg)
 	for(;;);
 }
 
+static crw_handler_t crw_handlers[NR_RSCS];
+
+/**
+ * s390_register_crw_handler() - register a channel report word handler
+ * @rsc: reporting source code to handle
+ * @handler: handler to be registered
+ *
+ * Returns %0 on success and a negative error value otherwise.
+ */
+int s390_register_crw_handler(int rsc, crw_handler_t handler)
+{
+	if ((rsc < 0) || (rsc >= NR_RSCS))
+		return -EINVAL;
+	if (!cmpxchg(&crw_handlers[rsc], NULL, handler))
+		return 0;
+	return -EBUSY;
+}
+
+/**
+ * s390_unregister_crw_handler() - unregister a channel report word handler
+ * @rsc: reporting source code to handle
+ */
+void s390_unregister_crw_handler(int rsc)
+{
+	if ((rsc < 0) || (rsc >= NR_RSCS))
+		return;
+	xchg(&crw_handlers[rsc], NULL);
+	synchronize_sched();
+}
+
 /*
  * Retrieve CRWs and call function to handle event.
- *
- * Note : we currently process CRWs for io and chsc subchannels only
  */
-static int
-s390_collect_crw_info(void *param)
+static int s390_collect_crw_info(void *param)
 {
 	struct crw crw[2];
 	int ccode;
@@ -84,57 +107,24 @@ repeat:
 		       crw[chain].rsid);
 		/* Check for overflows. */
 		if (crw[chain].oflw) {
+			int i;
+
 			pr_debug("%s: crw overflow detected!\n", __func__);
-			css_schedule_eval_all();
+			for (i = 0; i < NR_RSCS; i++) {
+				if (crw_handlers[i])
+					crw_handlers[i](NULL, NULL, 1);
+			}
 			chain = 0;
 			continue;
 		}
-		switch (crw[chain].rsc) {
-		case CRW_RSC_SCH:
-			if (crw[0].chn && !chain)
-				break;
-			pr_debug("source is subchannel %04X\n", crw[0].rsid);
-			css_process_crw(crw[0].rsid, chain ? crw[1].rsid : 0);
-			break;
-		case CRW_RSC_MONITOR:
-			pr_debug("source is monitoring facility\n");
-			break;
-		case CRW_RSC_CPATH:
-			pr_debug("source is channel path %02X\n", crw[0].rsid);
-			/*
-			 * Check for solicited machine checks. These are
-			 * created by reset channel path and need not be
-			 * reported to the common I/O layer.
-			 */
-			if (crw[chain].slct) {
-				pr_debug("solicited machine check for "
-					 "channel path %02X\n", crw[0].rsid);
-				break;
-			}
-			switch (crw[0].erc) {
-			case CRW_ERC_IPARM: /* Path has come. */
-				chp_process_crw(crw[0].rsid, 1);
-				break;
-			case CRW_ERC_PERRI: /* Path has gone. */
-			case CRW_ERC_PERRN:
-				chp_process_crw(crw[0].rsid, 0);
-				break;
-			default:
-				pr_debug("Don't know how to handle erc=%x\n",
-					 crw[0].erc);
-			}
-			break;
-		case CRW_RSC_CONFIG:
-			pr_debug("source is configuration-alert facility\n");
-			break;
-		case CRW_RSC_CSS:
-			pr_debug("source is channel subsystem\n");
-			chsc_process_crw();
-			break;
-		default:
-			pr_debug("unknown source\n");
-			break;
+		if (crw[0].chn && !chain) {
+			chain++;
+			continue;
 		}
+		if (crw_handlers[crw[chain].rsc])
+			crw_handlers[crw[chain].rsc](&crw[0],
+						     chain ? &crw[1] : NULL,
+						     0);
 		/* chain is always 0 or 1 here. */
 		chain = crw[chain].chn ? chain + 1 : 0;
 	}
Index: quilt-2.6/drivers/s390/s390mach.h
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.h
+++ quilt-2.6/drivers/s390/s390mach.h
@@ -72,6 +72,13 @@ struct crw {
 	__u32 rsid    : 16;   /* reporting-source ID */
 } __attribute__ ((packed));
 
+typedef void (*crw_handler_t)(struct crw *, struct crw *, int);
+
+extern int s390_register_crw_handler(int rsc, crw_handler_t handler);
+extern void s390_unregister_crw_handler(int rsc);
+
+#define NR_RSCS 16
+
 #define CRW_RSC_MONITOR  0x2  /* monitoring facility */
 #define CRW_RSC_SCH      0x3  /* subchannel */
 #define CRW_RSC_CPATH    0x4  /* channel path */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
