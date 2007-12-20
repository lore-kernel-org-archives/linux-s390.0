Return-Path: <linux-kernel-owner+w=401wt.eu-S934871AbXLTP03@vger.kernel.org>
Message-Id: <20071220152105.784390568@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/47] cio: reduce cpu utilization during device scan
Content-Disposition: inline; filename=112-cio-scan.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Minimize calls to cpu intensive function get_subchannel_by_schid()
by introducing function for_each_subchannel_staged() which
temporarily caches the information about registered subchannels
in a bitmap.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |   96 ++++++++++++--------------------------
 drivers/s390/cio/css.c  |  120 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/s390/cio/css.h  |    3 +
 3 files changed, 136 insertions(+), 83 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -136,17 +136,13 @@ static void terminate_internal_io(struct
 		sch->driver->termination(sch);
 }
 
-static int
-s390_subchannel_remove_chpid(struct device *dev, void *data)
+static int s390_subchannel_remove_chpid(struct subchannel *sch, void *data)
 {
 	int j;
 	int mask;
-	struct subchannel *sch;
-	struct chp_id *chpid;
+	struct chp_id *chpid = data;
 	struct schib schib;
 
-	sch = to_subchannel(dev);
-	chpid = data;
 	for (j = 0; j < 8; j++) {
 		mask = 0x80 >> j;
 		if ((sch->schib.pmcw.pim & mask) &&
@@ -202,12 +198,10 @@ void chsc_chp_offline(struct chp_id chpi
 
 	if (chp_get_status(chpid) <= 0)
 		return;
-	bus_for_each_dev(&css_bus_type, NULL, &chpid,
-			 s390_subchannel_remove_chpid);
+	for_each_subchannel_staged(s390_subchannel_remove_chpid, NULL, &chpid);
 }
 
-static int
-s390_process_res_acc_new_sch(struct subchannel_id schid)
+static int s390_process_res_acc_new_sch(struct subchannel_id schid, void *data)
 {
 	struct schib schib;
 	/*
@@ -253,18 +247,10 @@ static int get_res_chpid_mask(struct chs
 	return 0;
 }
 
-static int
-__s390_process_res_acc(struct subchannel_id schid, void *data)
+static int __s390_process_res_acc(struct subchannel *sch, void *data)
 {
 	int chp_mask, old_lpm;
-	struct res_acc_data *res_data;
-	struct subchannel *sch;
-
-	res_data = data;
-	sch = get_subchannel_by_schid(schid);
-	if (!sch)
-		/* Check if a subchannel is newly available. */
-		return s390_process_res_acc_new_sch(schid);
+	struct res_acc_data *res_data = data;
 
 	spin_lock_irq(sch->lock);
 	chp_mask = get_res_chpid_mask(&sch->ssd_info, res_data);
@@ -283,7 +269,7 @@ __s390_process_res_acc(struct subchannel
 		sch->driver->verify(sch);
 out:
 	spin_unlock_irq(sch->lock);
-	put_device(&sch->dev);
+
 	return 0;
 }
 
@@ -306,7 +292,8 @@ static void s390_process_res_acc (struct
 	 * The more information we have (info), the less scanning
 	 * will we have to do.
 	 */
-	for_each_subchannel(__s390_process_res_acc, res_data);
+	for_each_subchannel_staged(__s390_process_res_acc,
+				   s390_process_res_acc_new_sch, res_data);
 }
 
 static int
@@ -500,8 +487,7 @@ void chsc_process_crw(void)
 	} while (sei_area->flags & 0x80);
 }
 
-static int
-__chp_add_new_sch(struct subchannel_id schid)
+static int __chp_add_new_sch(struct subchannel_id schid, void *data)
 {
 	struct schib schib;
 
@@ -515,35 +501,27 @@ __chp_add_new_sch(struct subchannel_id s
 }
 
 
-static int
-__chp_add(struct subchannel_id schid, void *data)
+static int __chp_add(struct subchannel *sch, void *data)
 {
 	int i, mask;
-	struct chp_id *chpid;
-	struct subchannel *sch;
+	struct chp_id *chpid = data;
 
-	chpid = data;
-	sch = get_subchannel_by_schid(schid);
-	if (!sch)
-		/* Check if the subchannel is now available. */
-		return __chp_add_new_sch(schid);
 	spin_lock_irq(sch->lock);
 	for (i=0; i<8; i++) {
 		mask = 0x80 >> i;
 		if ((sch->schib.pmcw.pim & mask) &&
-		    (sch->schib.pmcw.chpid[i] == chpid->id)) {
-			if (stsch(sch->schid, &sch->schib) != 0) {
-				/* Endgame. */
-				spin_unlock_irq(sch->lock);
-				return -ENXIO;
-			}
+		    (sch->schib.pmcw.chpid[i] == chpid->id))
 			break;
-		}
 	}
 	if (i==8) {
 		spin_unlock_irq(sch->lock);
 		return 0;
 	}
+	if (stsch(sch->schid, &sch->schib)) {
+		spin_unlock_irq(sch->lock);
+		css_schedule_eval(sch->schid);
+		return 0;
+	}
 	sch->lpm = ((sch->schib.pmcw.pim &
 		     sch->schib.pmcw.pam &
 		     sch->schib.pmcw.pom)
@@ -553,7 +531,7 @@ __chp_add(struct subchannel_id schid, vo
 		sch->driver->verify(sch);
 
 	spin_unlock_irq(sch->lock);
-	put_device(&sch->dev);
+
 	return 0;
 }
 
@@ -565,7 +543,8 @@ void chsc_chp_online(struct chp_id chpid
 	CIO_TRACE_EVENT(2, dbf_txt);
 
 	if (chp_get_status(chpid) != 0)
-		for_each_subchannel(__chp_add, &chpid);
+		for_each_subchannel_staged(__chp_add, __chp_add_new_sch,
+					   &chpid);
 }
 
 static void __s390_subchannel_vary_chpid(struct subchannel *sch,
@@ -616,25 +595,17 @@ static void __s390_subchannel_vary_chpid
 	spin_unlock_irqrestore(sch->lock, flags);
 }
 
-static int s390_subchannel_vary_chpid_off(struct device *dev, void *data)
+static int s390_subchannel_vary_chpid_off(struct subchannel *sch, void *data)
 {
-	struct subchannel *sch;
-	struct chp_id *chpid;
-
-	sch = to_subchannel(dev);
-	chpid = data;
+	struct chp_id *chpid = data;
 
 	__s390_subchannel_vary_chpid(sch, *chpid, 0);
 	return 0;
 }
 
-static int s390_subchannel_vary_chpid_on(struct device *dev, void *data)
+static int s390_subchannel_vary_chpid_on(struct subchannel *sch, void *data)
 {
-	struct subchannel *sch;
-	struct chp_id *chpid;
-
-	sch = to_subchannel(dev);
-	chpid = data;
+	struct chp_id *chpid = data;
 
 	__s390_subchannel_vary_chpid(sch, *chpid, 1);
 	return 0;
@@ -644,13 +615,7 @@ static int
 __s390_vary_chpid_on(struct subchannel_id schid, void *data)
 {
 	struct schib schib;
-	struct subchannel *sch;
 
-	sch = get_subchannel_by_schid(schid);
-	if (sch) {
-		put_device(&sch->dev);
-		return 0;
-	}
 	if (stsch_err(schid, &schib))
 		/* We're through */
 		return -ENXIO;
@@ -670,12 +635,13 @@ int chsc_chp_vary(struct chp_id chpid, i
 	 * Redo PathVerification on the devices the chpid connects to
 	 */
 
-	bus_for_each_dev(&css_bus_type, NULL, &chpid, on ?
-			 s390_subchannel_vary_chpid_on :
-			 s390_subchannel_vary_chpid_off);
 	if (on)
-		/* Scan for new devices on varied on path. */
-		for_each_subchannel(__s390_vary_chpid_on, NULL);
+		for_each_subchannel_staged(s390_subchannel_vary_chpid_on,
+					   __s390_vary_chpid_on, &chpid);
+	else
+		for_each_subchannel_staged(s390_subchannel_vary_chpid_off,
+					   NULL, &chpid);
+
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -51,6 +51,62 @@ for_each_subchannel(int(*fn)(struct subc
 	return ret;
 }
 
+struct cb_data {
+	void *data;
+	struct idset *set;
+	int (*fn_known_sch)(struct subchannel *, void *);
+	int (*fn_unknown_sch)(struct subchannel_id, void *);
+};
+
+static int call_fn_known_sch(struct device *dev, void *data)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct cb_data *cb = data;
+	int rc = 0;
+
+	idset_sch_del(cb->set, sch->schid);
+	if (cb->fn_known_sch)
+		rc = cb->fn_known_sch(sch, cb->data);
+	return rc;
+}
+
+static int call_fn_unknown_sch(struct subchannel_id schid, void *data)
+{
+	struct cb_data *cb = data;
+	int rc = 0;
+
+	if (idset_sch_contains(cb->set, schid))
+		rc = cb->fn_unknown_sch(schid, cb->data);
+	return rc;
+}
+
+int for_each_subchannel_staged(int (*fn_known)(struct subchannel *, void *),
+			       int (*fn_unknown)(struct subchannel_id,
+			       void *), void *data)
+{
+	struct cb_data cb;
+	int rc;
+
+	cb.set = idset_sch_new();
+	if (!cb.set)
+		return -ENOMEM;
+	idset_fill(cb.set);
+	cb.data = data;
+	cb.fn_known_sch = fn_known;
+	cb.fn_unknown_sch = fn_unknown;
+	/* Process registered subchannels. */
+	rc = bus_for_each_dev(&css_bus_type, NULL, &cb, call_fn_known_sch);
+	if (rc)
+		goto out;
+	/* Process unregistered subchannels. */
+	if (fn_unknown)
+		rc = for_each_subchannel(call_fn_unknown_sch, &cb);
+out:
+	idset_free(cb.set);
+
+	return rc;
+}
+
 static struct subchannel *
 css_alloc_subchannel(struct subchannel_id schid)
 {
@@ -402,20 +458,56 @@ static int __init slow_subchannel_init(v
 	return 0;
 }
 
-static void css_slow_path_func(struct work_struct *unused)
+static int slow_eval_known_fn(struct subchannel *sch, void *data)
 {
-	struct subchannel_id schid;
+	int eval;
+	int rc;
 
-	CIO_TRACE_EVENT(4, "slowpath");
 	spin_lock_irq(&slow_subchannel_lock);
-	init_subchannel_id(&schid);
-	while (idset_sch_get_first(slow_subchannel_set, &schid)) {
-		idset_sch_del(slow_subchannel_set, schid);
-		spin_unlock_irq(&slow_subchannel_lock);
-		css_evaluate_subchannel(schid, 1);
-		spin_lock_irq(&slow_subchannel_lock);
+	eval = idset_sch_contains(slow_subchannel_set, sch->schid);
+	idset_sch_del(slow_subchannel_set, sch->schid);
+	spin_unlock_irq(&slow_subchannel_lock);
+	if (eval) {
+		rc = css_evaluate_known_subchannel(sch, 1);
+		if (rc == -EAGAIN)
+			css_schedule_eval(sch->schid);
 	}
+	return 0;
+}
+
+static int slow_eval_unknown_fn(struct subchannel_id schid, void *data)
+{
+	int eval;
+	int rc = 0;
+
+	spin_lock_irq(&slow_subchannel_lock);
+	eval = idset_sch_contains(slow_subchannel_set, schid);
+	idset_sch_del(slow_subchannel_set, schid);
 	spin_unlock_irq(&slow_subchannel_lock);
+	if (eval) {
+		rc = css_evaluate_new_subchannel(schid, 1);
+		switch (rc) {
+		case -EAGAIN:
+			css_schedule_eval(schid);
+			rc = 0;
+			break;
+		case -ENXIO:
+		case -ENOMEM:
+		case -EIO:
+			/* These should abort looping */
+			break;
+		default:
+			rc = 0;
+		}
+	}
+	return rc;
+}
+
+static void css_slow_path_func(struct work_struct *unused)
+{
+	CIO_TRACE_EVENT(4, "slowpath");
+	for_each_subchannel_staged(slow_eval_known_fn, slow_eval_unknown_fn,
+				   NULL);
 }
 
 static DECLARE_WORK(slow_path_work, css_slow_path_func);
@@ -444,7 +536,6 @@ void css_schedule_eval_all(void)
 /* Reprobe subchannel if unregistered. */
 static int reprobe_subchannel(struct subchannel_id schid, void *data)
 {
-	struct subchannel *sch;
 	int ret;
 
 	CIO_MSG_EVENT(6, "cio: reprobe 0.%x.%04x\n",
@@ -452,13 +543,6 @@ static int reprobe_subchannel(struct sub
 	if (need_reprobe)
 		return -EAGAIN;
 
-	sch = get_subchannel_by_schid(schid);
-	if (sch) {
-		/* Already known. */
-		put_device(&sch->dev);
-		return 0;
-	}
-
 	ret = css_probe_device(schid);
 	switch (ret) {
 	case 0:
@@ -486,7 +570,7 @@ static void reprobe_all(struct work_stru
 	/* Make sure initial subchannel scan is done. */
 	wait_event(ccw_device_init_wq,
 		   atomic_read(&ccw_device_init_count) == 0);
-	ret = for_each_subchannel(reprobe_subchannel, NULL);
+	ret = for_each_subchannel_staged(NULL, reprobe_subchannel, NULL);
 
 	CIO_MSG_EVENT(2, "reprobe done (rc=%d, need_reprobe=%d)\n", ret,
 		      need_reprobe);
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -91,6 +91,9 @@ extern void css_driver_unregister(struct
 extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
+int for_each_subchannel_staged(int (*fn_known)(struct subchannel *, void *),
+			       int (*fn_unknown)(struct subchannel_id,
+			       void *), void *data);
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
 extern void css_process_crw(int, int);
 extern void css_reiterate_subchannels(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
