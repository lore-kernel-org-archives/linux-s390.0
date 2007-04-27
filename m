Return-Path: <linux-kernel-owner+w=401wt.eu-S1755869AbXD0OPu@vger.kernel.org>
Message-Id: <20070427140514.324680493@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/38] cio: replace subchannel evaluation queue with bitmap
Content-Disposition: inline; filename=109-cio-idset.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Use a bitmap for indicating which subchannels require evaluation
instead of allocating memory for each evaluation request. This
approach reduces memory consumption during recovery in case of
massive evaluation request occurrence and removes the need for
memory allocation failure handling.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/Makefile     |    2 
 drivers/s390/cio/chp.c        |    8 --
 drivers/s390/cio/chp.h        |    2 
 drivers/s390/cio/chsc.c       |  130 +++++++++---------------------------
 drivers/s390/cio/chsc.h       |    4 -
 drivers/s390/cio/css.c        |  148 +++++++++++++-----------------------------
 drivers/s390/cio/css.h        |   10 --
 drivers/s390/cio/device_fsm.c |    6 -
 drivers/s390/cio/idset.c      |  112 +++++++++++++++++++++++++++++++
 drivers/s390/cio/idset.h      |   25 +++++++
 drivers/s390/s390mach.c       |   24 +-----
 11 files changed, 235 insertions(+), 236 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chp.c	2007-04-27 16:04:54.000000000 +0200
@@ -491,7 +491,7 @@
  * Handle channel-report-words indicating that the status of a channel-path
  * has changed.
  */
-int chp_process_crw(int id, int status)
+void chp_process_crw(int id, int status)
 {
 	struct chp_id chpid;
 
@@ -500,11 +500,9 @@
 	if (status) {
 		if (!chp_is_registered(chpid))
 			chp_new(chpid);
-		return chsc_chp_online(chpid);
-	} else {
+		chsc_chp_online(chpid);
+	} else
 		chsc_chp_offline(chpid);
-		return 0;
-	}
 }
 
 static inline int info_bit_num(struct chp_id id)
Index: quilt-2.6/drivers/s390/cio/chp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.h	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chp.h	2007-04-27 16:04:54.000000000 +0200
@@ -42,7 +42,7 @@
 u8 chp_get_sch_opm(struct subchannel *sch);
 int chp_is_registered(struct chp_id chpid);
 void *chp_get_chp_desc(struct chp_id chpid);
-int chp_process_crw(int id, int available);
+void chp_process_crw(int id, int available);
 void chp_remove_cmg_attr(struct channel_path *chp);
 int chp_add_cmg_attr(struct channel_path *chp);
 int chp_new(struct chp_id chpid);
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.c	2007-04-27 16:04:54.000000000 +0200
@@ -195,12 +195,8 @@
 	if (cio_clear(sch)) {
 		/* Recheck device in case clear failed. */
 		sch->lpm = 0;
-		if (device_trigger_verify(sch) != 0) {
-			if(css_enqueue_subchannel_slow(sch->schid)) {
-				css_clear_subchannel_slow_list();
-				need_rescan = 1;
-			}
-		}
+		if (device_trigger_verify(sch) != 0)
+			css_schedule_eval(sch->schid);
 		return;
 	}
 	/* Request retry of internal operation. */
@@ -262,11 +258,8 @@
 
 out_unreg:
 	sch->lpm = 0;
-	if (css_enqueue_subchannel_slow(sch->schid)) {
-		css_clear_subchannel_slow_list();
-		need_rescan = 1;
-	}
 	spin_unlock_irq(sch->lock);
+	css_schedule_eval(sch->schid);
 	return 0;
 }
 
@@ -281,9 +274,6 @@
 		return;
 	bus_for_each_dev(&css_bus_type, NULL, &chpid,
 			 s390_subchannel_remove_chpid);
-
-	if (need_rescan || css_slow_subchannels_exist())
-		queue_work(slow_path_wq, &slow_path_work);
 }
 
 struct res_acc_data {
@@ -331,7 +321,6 @@
 s390_process_res_acc_new_sch(struct subchannel_id schid)
 {
 	struct schib schib;
-	int ret;
 	/*
 	 * We don't know the device yet, but since a path
 	 * may be available now to the device we'll have
@@ -342,15 +331,10 @@
 	 */
 	if (stsch_err(schid, &schib))
 		/* We're through */
-		return need_rescan ? -EAGAIN : -ENXIO;
+		return -ENXIO;
 
 	/* Put it on the slow path. */
-	ret = css_enqueue_subchannel_slow(schid);
-	if (ret) {
-		css_clear_subchannel_slow_list();
-		need_rescan = 1;
-		return -EAGAIN;
-	}
+	css_schedule_eval(schid);
 	return 0;
 }
 
@@ -392,10 +376,8 @@
 }
 
 
-static int
-s390_process_res_acc (struct res_acc_data *res_data)
+static void s390_process_res_acc (struct res_acc_data *res_data)
 {
-	int rc;
 	char dbf_txt[15];
 
 	sprintf(dbf_txt, "accpr%x.%02x", res_data->chpid.cssid,
@@ -413,12 +395,7 @@
 	 * The more information we have (info), the less scanning
 	 * will we have to do.
 	 */
-	rc = for_each_subchannel(__s390_process_res_acc, res_data);
-	if (css_slow_subchannels_exist())
-		rc = -EAGAIN;
-	else if (rc != -EAGAIN)
-		rc = 0;
-	return rc;
+	for_each_subchannel(__s390_process_res_acc, res_data);
 }
 
 static int
@@ -470,7 +447,7 @@
 	/* ccdf has to be big enough for a link-incident record */
 } __attribute__ ((packed));
 
-static int chsc_process_sei_link_incident(struct chsc_sei_area *sei_area)
+static void chsc_process_sei_link_incident(struct chsc_sei_area *sei_area)
 {
 	struct chp_id chpid;
 	int id;
@@ -478,7 +455,7 @@
 	CIO_CRW_EVENT(4, "chsc: link incident (rs=%02x, rs_id=%04x)\n",
 		      sei_area->rs, sei_area->rsid);
 	if (sei_area->rs != 4)
-		return 0;
+		return;
 	id = __get_chpid_from_lir(sei_area->ccdf);
 	if (id < 0)
 		CIO_CRW_EVENT(4, "chsc: link incident - invalid LIR\n");
@@ -487,21 +464,18 @@
 		chpid.id = id;
 		chsc_chp_offline(chpid);
 	}
-
-	return 0;
 }
 
-static int chsc_process_sei_res_acc(struct chsc_sei_area *sei_area)
+static void chsc_process_sei_res_acc(struct chsc_sei_area *sei_area)
 {
 	struct res_acc_data res_data;
 	struct chp_id chpid;
 	int status;
-	int rc;
 
 	CIO_CRW_EVENT(4, "chsc: resource accessibility event (rs=%02x, "
 		      "rs_id=%04x)\n", sei_area->rs, sei_area->rsid);
 	if (sei_area->rs != 4)
-		return 0;
+		return;
 	chp_id_init(&chpid);
 	chpid.id = sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
@@ -509,7 +483,7 @@
 	if (status < 0)
 		chp_new(chpid);
 	else if (!status)
-		return 0;
+		return;
 	memset(&res_data, 0, sizeof(struct res_acc_data));
 	res_data.chpid = chpid;
 	if ((sei_area->vf & 0xc0) != 0) {
@@ -521,9 +495,7 @@
 			/* link address */
 			res_data.fla_mask = 0xff00;
 	}
-	rc = s390_process_res_acc(&res_data);
-
-	return rc;
+	s390_process_res_acc(&res_data);
 }
 
 struct chp_config_data {
@@ -532,7 +504,7 @@
 	u8 pc;
 };
 
-static int chsc_process_sei_chp_config(struct chsc_sei_area *sei_area)
+static void chsc_process_sei_chp_config(struct chsc_sei_area *sei_area)
 {
 	struct chp_config_data *data;
 	struct chp_id chpid;
@@ -540,7 +512,7 @@
 
 	CIO_CRW_EVENT(4, "chsc: channel-path-configuration notification\n");
 	if (sei_area->rs != 0)
-		return 0;
+		return;
 	data = (struct chp_config_data *) &(sei_area->ccdf);
 	chp_id_init(&chpid);
 	for (num = 0; num <= __MAX_CHPID; num++) {
@@ -561,52 +533,44 @@
 			break;
 		}
 	}
-
-	return 0;
 }
 
-static int chsc_process_sei(struct chsc_sei_area *sei_area)
+static void chsc_process_sei(struct chsc_sei_area *sei_area)
 {
-	int rc;
-
 	/* Check if we might have lost some information. */
-	if (sei_area->flags & 0x40)
+	if (sei_area->flags & 0x40) {
 		CIO_CRW_EVENT(2, "chsc: event overflow\n");
+		css_schedule_eval_all();
+	}
 	/* which kind of information was stored? */
-	rc = 0;
 	switch (sei_area->cc) {
 	case 1: /* link incident*/
-		rc = chsc_process_sei_link_incident(sei_area);
+		chsc_process_sei_link_incident(sei_area);
 		break;
 	case 2: /* i/o resource accessibiliy */
-		rc = chsc_process_sei_res_acc(sei_area);
+		chsc_process_sei_res_acc(sei_area);
 		break;
 	case 8: /* channel-path-configuration notification */
-		rc = chsc_process_sei_chp_config(sei_area);
+		chsc_process_sei_chp_config(sei_area);
 		break;
 	default: /* other stuff */
 		CIO_CRW_EVENT(4, "chsc: unhandled sei content code %d\n",
 			      sei_area->cc);
 		break;
 	}
-
-	return rc;
 }
 
-int chsc_process_crw(void)
+void chsc_process_crw(void)
 {
 	struct chsc_sei_area *sei_area;
-	int ret;
-	int rc;
 
 	if (!sei_page)
-		return 0;
+		return;
 	/* Access to sei_page is serialized through machine check handler
 	 * thread, so no need for locking. */
 	sei_area = sei_page;
 
 	CIO_TRACE_EVENT( 2, "prcss");
-	ret = 0;
 	do {
 		memset(sei_area, 0, sizeof(*sei_area));
 		sei_area->request.length = 0x0010;
@@ -616,37 +580,26 @@
 
 		if (sei_area->response.code == 0x0001) {
 			CIO_CRW_EVENT(4, "chsc: sei successful\n");
-			rc = chsc_process_sei(sei_area);
-			if (rc)
-				ret = rc;
+			chsc_process_sei(sei_area);
 		} else {
 			CIO_CRW_EVENT(2, "chsc: sei failed (rc=%04x)\n",
 				      sei_area->response.code);
-			ret = 0;
 			break;
 		}
 	} while (sei_area->flags & 0x80);
-
-	return ret;
 }
 
 static int
 __chp_add_new_sch(struct subchannel_id schid)
 {
 	struct schib schib;
-	int ret;
 
 	if (stsch_err(schid, &schib))
 		/* We're through */
-		return need_rescan ? -EAGAIN : -ENXIO;
+		return -ENXIO;
 
 	/* Put it on the slow path. */
-	ret = css_enqueue_subchannel_slow(schid);
-	if (ret) {
-		css_clear_subchannel_slow_list();
-		need_rescan = 1;
-		return -EAGAIN;
-	}
+	css_schedule_eval(schid);
 	return 0;
 }
 
@@ -693,22 +646,15 @@
 	return 0;
 }
 
-int chsc_chp_online(struct chp_id chpid)
+void chsc_chp_online(struct chp_id chpid)
 {
-	int rc;
 	char dbf_txt[15];
 
 	sprintf(dbf_txt, "cadd%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	if (chp_get_status(chpid) == 0)
-		return 0;
-	rc = for_each_subchannel(__chp_add, &chpid);
-	if (css_slow_subchannels_exist())
-		rc = -EAGAIN;
-	if (rc != -EAGAIN)
-		rc = 0;
-	return rc;
+	if (chp_get_status(chpid) != 0)
+		for_each_subchannel(__chp_add, &chpid);
 }
 
 static void __s390_subchannel_vary_chpid(struct subchannel *sch,
@@ -749,12 +695,8 @@
 					sch->driver->verify(&sch->dev);
 			}
 		} else if (!sch->lpm) {
-			if (device_trigger_verify(sch) != 0) {
-				if (css_enqueue_subchannel_slow(sch->schid)) {
-					css_clear_subchannel_slow_list();
-					need_rescan = 1;
-				}
-			}
+			if (device_trigger_verify(sch) != 0)
+				css_schedule_eval(sch->schid);
 		} else if (sch->driver && sch->driver->verify)
 			sch->driver->verify(&sch->dev);
 		break;
@@ -801,11 +743,7 @@
 		/* We're through */
 		return -ENXIO;
 	/* Put it on the slow path. */
-	if (css_enqueue_subchannel_slow(schid)) {
-		css_clear_subchannel_slow_list();
-		need_rescan = 1;
-		return -EAGAIN;
-	}
+	css_schedule_eval(schid);
 	return 0;
 }
 
@@ -826,8 +764,6 @@
 	if (on)
 		/* Scan for new devices on varied on path. */
 		for_each_subchannel(__s390_vary_chpid_on, NULL);
-	if (need_rescan || css_slow_subchannels_exist())
-		queue_work(slow_path_wq, &slow_path_work);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.h	2007-04-27 16:04:54.000000000 +0200
@@ -36,7 +36,7 @@
 struct channel_path;
 
 extern int css_get_ssd_info(struct subchannel *);
-extern int chsc_process_crw(void);
+extern void chsc_process_crw(void);
 
 struct css_general_char {
 	u64 : 41;
@@ -79,7 +79,7 @@
 int chsc_chp_vary(struct chp_id chpid, int on);
 int chsc_determine_channel_path_description(struct chp_id chpid,
 					    struct channel_path_desc *desc);
-int chsc_chp_online(struct chp_id chpid);
+void chsc_chp_online(struct chp_id chpid);
 void chsc_chp_offline(struct chp_id chpid);
 int chsc_get_channel_measurement_chars(struct channel_path *chp);
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/css.c	2007-04-27 16:04:54.000000000 +0200
@@ -20,8 +20,8 @@
 #include "ioasm.h"
 #include "chsc.h"
 #include "device.h"
+#include "idset.h"
 
-int need_rescan = 0;
 int css_init_done = 0;
 static int need_reprobe = 0;
 static int max_ssid = 0;
@@ -306,7 +306,7 @@
 	return css_probe_device(schid);
 }
 
-static int css_evaluate_subchannel(struct subchannel_id schid, int slow)
+static void css_evaluate_subchannel(struct subchannel_id schid, int slow)
 {
 	struct subchannel *sch;
 	int ret;
@@ -317,53 +317,66 @@
 		put_device(&sch->dev);
 	} else
 		ret = css_evaluate_new_subchannel(schid, slow);
-
-	return ret;
+	if (ret == -EAGAIN)
+		css_schedule_eval(schid);
 }
 
-static int
-css_rescan_devices(struct subchannel_id schid, void *data)
+static struct idset *slow_subchannel_set;
+static spinlock_t slow_subchannel_lock;
+
+static int __init slow_subchannel_init(void)
 {
-	return css_evaluate_subchannel(schid, 1);
+	spin_lock_init(&slow_subchannel_lock);
+	slow_subchannel_set = idset_sch_new();
+	if (!slow_subchannel_set) {
+		printk(KERN_WARNING "cio: could not allocate slow subchannel "
+		       "set\n");
+		return -ENOMEM;
+	}
+	return 0;
 }
 
-struct slow_subchannel {
-	struct list_head slow_list;
-	struct subchannel_id schid;
-};
-
-static LIST_HEAD(slow_subchannels_head);
-static DEFINE_SPINLOCK(slow_subchannel_lock);
+subsys_initcall(slow_subchannel_init);
 
-static void
-css_trigger_slow_path(struct work_struct *unused)
+static void css_slow_path_func(struct work_struct *unused)
 {
-	CIO_TRACE_EVENT(4, "slowpath");
-
-	if (need_rescan) {
-		need_rescan = 0;
-		for_each_subchannel(css_rescan_devices, NULL);
-		return;
-	}
+	struct subchannel_id schid;
 
+	CIO_TRACE_EVENT(4, "slowpath");
 	spin_lock_irq(&slow_subchannel_lock);
-	while (!list_empty(&slow_subchannels_head)) {
-		struct slow_subchannel *slow_sch =
-			list_entry(slow_subchannels_head.next,
-				   struct slow_subchannel, slow_list);
-
-		list_del_init(slow_subchannels_head.next);
+	init_subchannel_id(&schid);
+	while (idset_sch_get_first(slow_subchannel_set, &schid)) {
+		idset_sch_del(slow_subchannel_set, schid);
 		spin_unlock_irq(&slow_subchannel_lock);
-		css_evaluate_subchannel(slow_sch->schid, 1);
+		css_evaluate_subchannel(schid, 1);
 		spin_lock_irq(&slow_subchannel_lock);
-		kfree(slow_sch);
 	}
 	spin_unlock_irq(&slow_subchannel_lock);
 }
 
-DECLARE_WORK(slow_path_work, css_trigger_slow_path);
+static DECLARE_WORK(slow_path_work, css_slow_path_func);
 struct workqueue_struct *slow_path_wq;
 
+void css_schedule_eval(struct subchannel_id schid)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&slow_subchannel_lock, flags);
+	idset_sch_add(slow_subchannel_set, schid);
+	queue_work(slow_path_wq, &slow_path_work);
+	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
+}
+
+void css_schedule_eval_all(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&slow_subchannel_lock, flags);
+	idset_fill(slow_subchannel_set);
+	queue_work(slow_path_wq, &slow_path_work);
+	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
+}
+
 /* Reprobe subchannel if unregistered. */
 static int reprobe_subchannel(struct subchannel_id schid, void *data)
 {
@@ -426,33 +439,14 @@
 EXPORT_SYMBOL_GPL(css_schedule_reprobe);
 
 /*
- * Rescan for new devices. FIXME: This is slow.
- * This function is called when we have lost CRWs due to overflows and we have
- * to do subchannel housekeeping.
- */
-void
-css_reiterate_subchannels(void)
-{
-	css_clear_subchannel_slow_list();
-	need_rescan = 1;
-}
-
-/*
  * Called from the machine check handler for subchannel report words.
  */
-int
-css_process_crw(int rsid1, int rsid2)
+void css_process_crw(int rsid1, int rsid2)
 {
-	int ret;
 	struct subchannel_id mchk_schid;
 
 	CIO_CRW_EVENT(2, "source is subchannel %04X, subsystem id %x\n",
 		      rsid1, rsid2);
-
-	if (need_rescan)
-		/* We need to iterate all subchannels anyway. */
-		return -EAGAIN;
-
 	init_subchannel_id(&mchk_schid);
 	mchk_schid.sch_no = rsid1;
 	if (rsid2 != 0)
@@ -463,14 +457,7 @@
 	 * use stsch() to find out if the subchannel in question has come
 	 * or gone.
 	 */
-	ret = css_evaluate_subchannel(mchk_schid, 0);
-	if (ret == -EAGAIN) {
-		if (css_enqueue_subchannel_slow(mchk_schid)) {
-			css_clear_subchannel_slow_list();
-			need_rescan = 1;
-		}
-	}
-	return ret;
+	css_evaluate_subchannel(mchk_schid, 0);
 }
 
 static int __init
@@ -745,47 +732,6 @@
 
 subsys_initcall(init_channel_subsystem);
 
-int
-css_enqueue_subchannel_slow(struct subchannel_id schid)
-{
-	struct slow_subchannel *new_slow_sch;
-	unsigned long flags;
-
-	new_slow_sch = kzalloc(sizeof(struct slow_subchannel), GFP_ATOMIC);
-	if (!new_slow_sch)
-		return -ENOMEM;
-	new_slow_sch->schid = schid;
-	spin_lock_irqsave(&slow_subchannel_lock, flags);
-	list_add_tail(&new_slow_sch->slow_list, &slow_subchannels_head);
-	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
-	return 0;
-}
-
-void
-css_clear_subchannel_slow_list(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&slow_subchannel_lock, flags);
-	while (!list_empty(&slow_subchannels_head)) {
-		struct slow_subchannel *slow_sch =
-			list_entry(slow_subchannels_head.next,
-				   struct slow_subchannel, slow_list);
-
-		list_del_init(slow_subchannels_head.next);
-		kfree(slow_sch);
-	}
-	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
-}
-
-
-
-int
-css_slow_subchannels_exist(void)
-{
-	return (!list_empty(&slow_subchannels_head));
-}
-
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(css_bus_type);
 EXPORT_SYMBOL_GPL(css_characteristics_avail);
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/css.h	2007-04-27 16:04:54.000000000 +0200
@@ -146,7 +146,7 @@
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
-extern int css_process_crw(int, int);
+extern void css_process_crw(int, int);
 extern void css_reiterate_subchannels(void);
 
 #define __MAX_SUBCHANNEL 65535
@@ -186,16 +186,12 @@
 void device_kill_pending_timer(struct subchannel *);
 
 /* Helper functions to build lists for the slow path. */
-extern int css_enqueue_subchannel_slow(struct subchannel_id schid);
-void css_walk_subchannel_slow_list(void (*fn)(unsigned long));
-void css_clear_subchannel_slow_list(void);
-int css_slow_subchannels_exist(void);
-extern int need_rescan;
+void css_schedule_eval(struct subchannel_id schid);
+void css_schedule_eval_all(void);
 
 int sch_is_pseudo_sch(struct subchannel *);
 
 extern struct workqueue_struct *slow_path_wq;
-extern struct work_struct slow_path_work;
 
 int subchannel_add_files (struct device *);
 extern struct attribute_group *subch_attr_groups[];
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:54.000000000 +0200
@@ -222,10 +222,8 @@
 		if (old_lpm & mask)
 			continue;
 		chpid.id = sch->schib.pmcw.chpid[i];
-		if (!chp_is_registered(chpid)) {
-			need_rescan = 1;
-			queue_work(slow_path_wq, &slow_path_work);
-		}
+		if (!chp_is_registered(chpid))
+			css_schedule_eval_all();
 	}
 }
 
Index: quilt-2.6/drivers/s390/cio/idset.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/cio/idset.c	2007-04-27 16:04:54.000000000 +0200
@@ -0,0 +1,112 @@
+/*
+ *  drivers/s390/cio/idset.c
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#include <linux/slab.h>
+#include <asm/bitops.h>
+#include "idset.h"
+#include "css.h"
+
+struct idset {
+	int num_ssid;
+	int num_id;
+	unsigned long bitmap[0];
+};
+
+static inline unsigned long bitmap_size(int num_ssid, int num_id)
+{
+	return __BITOPS_WORDS(num_ssid * num_id) * sizeof(unsigned long);
+}
+
+static struct idset *idset_new(int num_ssid, int num_id)
+{
+	struct idset *set;
+
+	set = kzalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id),
+		      GFP_KERNEL);
+	if (set) {
+		set->num_ssid = num_ssid;
+		set->num_id = num_id;
+	}
+	return set;
+}
+
+void idset_free(struct idset *set)
+{
+	kfree(set);
+}
+
+void idset_clear(struct idset *set)
+{
+	memset(set->bitmap, 0, bitmap_size(set->num_ssid, set->num_id));
+}
+
+void idset_fill(struct idset *set)
+{
+	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
+}
+
+static inline void idset_add(struct idset *set, int ssid, int id)
+{
+	set_bit(ssid * set->num_id + id, set->bitmap);
+}
+
+static inline void idset_del(struct idset *set, int ssid, int id)
+{
+	clear_bit(ssid * set->num_id + id, set->bitmap);
+}
+
+static inline int idset_contains(struct idset *set, int ssid, int id)
+{
+	return test_bit(ssid * set->num_id + id, set->bitmap);
+}
+
+static inline int idset_get_first(struct idset *set, int *ssid, int *id)
+{
+	int bitnum;
+
+	bitnum = find_first_bit(set->bitmap, set->num_ssid * set->num_id);
+	if (bitnum >= set->num_ssid * set->num_id)
+		return 0;
+	*ssid = bitnum / set->num_id;
+	*id = bitnum % set->num_id;
+	return 1;
+}
+
+struct idset *idset_sch_new(void)
+{
+	return idset_new(__MAX_SSID + 1, __MAX_SUBCHANNEL + 1);
+}
+
+void idset_sch_add(struct idset *set, struct subchannel_id schid)
+{
+	idset_add(set, schid.ssid, schid.sch_no);
+}
+
+void idset_sch_del(struct idset *set, struct subchannel_id schid)
+{
+	idset_del(set, schid.ssid, schid.sch_no);
+}
+
+int idset_sch_contains(struct idset *set, struct subchannel_id schid)
+{
+	return idset_contains(set, schid.ssid, schid.sch_no);
+}
+
+int idset_sch_get_first(struct idset *set, struct subchannel_id *schid)
+{
+	int ssid = 0;
+	int id = 0;
+	int rc;
+
+	rc = idset_get_first(set, &ssid, &id);
+	if (rc) {
+		init_subchannel_id(schid);
+		schid->ssid = ssid;
+		schid->sch_no = id;
+	}
+	return rc;
+}
Index: quilt-2.6/drivers/s390/cio/idset.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/cio/idset.h	2007-04-27 16:04:54.000000000 +0200
@@ -0,0 +1,25 @@
+/*
+ *  drivers/s390/cio/idset.h
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#ifndef S390_IDSET_H
+#define S390_IDSET_H S390_IDSET_H
+
+#include "schid.h"
+
+struct idset;
+
+void idset_free(struct idset *set);
+void idset_clear(struct idset *set);
+void idset_fill(struct idset *set);
+
+struct idset *idset_sch_new(void);
+void idset_sch_add(struct idset *set, struct subchannel_id id);
+void idset_sch_del(struct idset *set, struct subchannel_id id);
+int idset_sch_contains(struct idset *set, struct subchannel_id id);
+int idset_sch_get_first(struct idset *set, struct subchannel_id *id);
+
+#endif /* S390_IDSET_H */
Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/Makefile	2007-04-27 16:04:54.000000000 +0200
@@ -2,7 +2,7 @@
 # Makefile for the S/390 common i/o drivers
 #
 
-obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o
+obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
Index: quilt-2.6/drivers/s390/s390mach.c
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.c	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/s390mach.c	2007-04-27 16:04:54.000000000 +0200
@@ -45,14 +45,13 @@
 s390_collect_crw_info(void *param)
 {
 	struct crw crw[2];
-	int ccode, ret, slow;
+	int ccode;
 	struct semaphore *sem;
 	unsigned int chain;
 
 	sem = (struct semaphore *)param;
 repeat:
 	down_interruptible(sem);
-	slow = 0;
 	chain = 0;
 	while (1) {
 		if (unlikely(chain > 1)) {
@@ -85,9 +84,8 @@
 		/* Check for overflows. */
 		if (crw[chain].oflw) {
 			pr_debug("%s: crw overflow detected!\n", __FUNCTION__);
-			css_reiterate_subchannels();
+			css_schedule_eval_all();
 			chain = 0;
-			slow = 1;
 			continue;
 		}
 		switch (crw[chain].rsc) {
@@ -95,10 +93,7 @@
 			if (crw[0].chn && !chain)
 				break;
 			pr_debug("source is subchannel %04X\n", crw[0].rsid);
-			ret = css_process_crw (crw[0].rsid,
-					       chain ? crw[1].rsid : 0);
-			if (ret == -EAGAIN)
-				slow = 1;
+			css_process_crw(crw[0].rsid, chain ? crw[1].rsid : 0);
 			break;
 		case CRW_RSC_MONITOR:
 			pr_debug("source is monitoring facility\n");
@@ -117,28 +112,23 @@
 			}
 			switch (crw[0].erc) {
 			case CRW_ERC_IPARM: /* Path has come. */
-				ret = chp_process_crw(crw[0].rsid, 1);
+				chp_process_crw(crw[0].rsid, 1);
 				break;
 			case CRW_ERC_PERRI: /* Path has gone. */
 			case CRW_ERC_PERRN:
-				ret = chp_process_crw(crw[0].rsid, 0);
+				chp_process_crw(crw[0].rsid, 0);
 				break;
 			default:
 				pr_debug("Don't know how to handle erc=%x\n",
 					 crw[0].erc);
-				ret = 0;
 			}
-			if (ret == -EAGAIN)
-				slow = 1;
 			break;
 		case CRW_RSC_CONFIG:
 			pr_debug("source is configuration-alert facility\n");
 			break;
 		case CRW_RSC_CSS:
 			pr_debug("source is channel subsystem\n");
-			ret = chsc_process_crw();
-			if (ret == -EAGAIN)
-				slow = 1;
+			chsc_process_crw();
 			break;
 		default:
 			pr_debug("unknown source\n");
@@ -147,8 +137,6 @@
 		/* chain is always 0 or 1 here. */
 		chain = crw[chain].chn ? chain + 1 : 0;
 	}
-	if (slow)
-		queue_work(slow_path_wq, &slow_path_work);
 	goto repeat;
 	return 0;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
