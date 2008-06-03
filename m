Return-Path: <linux-kernel-owner+w=401wt.eu-S1758387AbYFCRJj@vger.kernel.org>
Message-Id: <20080603170519.092182269@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/14] cio: Rework css driver.
Content-Disposition: inline; filename=102-cio-css-rework.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Rework the css driver methods to provide sane callbacks for
subchannels of all types.

As a bonus, this cleans up and simplyfies the machine check
handling for I/O subchannels a lot.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.c        |   20 ++
 drivers/s390/cio/chp.h        |   13 +
 drivers/s390/cio/chsc.c       |  218 +------------------------
 drivers/s390/cio/cio.c        |    1 
 drivers/s390/cio/css.c        |  123 +-------------
 drivers/s390/cio/css.h        |   38 +---
 drivers/s390/cio/device.c     |  365 ++++++++++++++++++++++++++++++++----------
 drivers/s390/cio/device.h     |    7 
 drivers/s390/cio/device_fsm.c |  106 +-----------
 9 files changed, 381 insertions(+), 510 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -496,6 +496,26 @@ void chp_process_crw(int id, int status)
 		chsc_chp_offline(chpid);
 }
 
+int chp_ssd_get_mask(struct chsc_ssd_info *ssd, struct res_acc_data *data)
+{
+	int i;
+	int mask;
+
+	for (i = 0; i < 8; i++) {
+		mask = 0x80 >> i;
+		if (!(ssd->path_mask & mask))
+			continue;
+		if (!chp_id_is_equal(&ssd->chpid[i], &data->chpid))
+			continue;
+		if ((ssd->fla_valid_mask & mask) &&
+		    ((ssd->fla[i] & data->fla_mask) != data->fla))
+			continue;
+		return mask;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(chp_ssd_get_mask);
+
 static inline int info_bit_num(struct chp_id id)
 {
 	return id.id + id.cssid * (__MAX_CHPID + 1);
Index: quilt-2.6/drivers/s390/cio/chp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.h
+++ quilt-2.6/drivers/s390/cio/chp.h
@@ -19,6 +19,17 @@
 #define CHP_STATUS_RESERVED		2
 #define CHP_STATUS_NOT_RECOGNIZED	3
 
+#define CHP_ONLINE 0
+#define CHP_OFFLINE 1
+#define CHP_VARY_ON 2
+#define CHP_VARY_OFF 3
+
+struct res_acc_data {
+	struct chp_id chpid;
+	u32 fla_mask;
+	u16 fla;
+};
+
 static inline int chp_test_bit(u8 *bitmap, int num)
 {
 	int byte = num >> 3;
@@ -50,5 +61,5 @@ int chp_new(struct chp_id chpid);
 void chp_cfg_schedule(struct chp_id chpid, int configure);
 void chp_cfg_cancel_deconfigure(struct chp_id chpid);
 int chp_info_get_status(struct chp_id chpid);
-
+int chp_ssd_get_mask(struct chsc_ssd_info *, struct res_acc_data *);
 #endif /* S390_CHP_H */
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -2,8 +2,7 @@
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
  *
- *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
- *			      IBM Corporation
+ *    Copyright IBM Corp. 1999,2008
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Arnd Bergmann (arndb@de.ibm.com)
@@ -127,77 +126,12 @@ out_free:
 	return ret;
 }
 
-static int check_for_io_on_path(struct subchannel *sch, int mask)
-{
-	int cc;
-
-	cc = stsch(sch->schid, &sch->schib);
-	if (cc)
-		return 0;
-	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == mask)
-		return 1;
-	return 0;
-}
-
-static void terminate_internal_io(struct subchannel *sch)
-{
-	if (cio_clear(sch)) {
-		/* Recheck device in case clear failed. */
-		sch->lpm = 0;
-		if (device_trigger_verify(sch) != 0)
-			css_schedule_eval(sch->schid);
-		return;
-	}
-	/* Request retry of internal operation. */
-	device_set_intretry(sch);
-	/* Call handler. */
-	if (sch->driver && sch->driver->termination)
-		sch->driver->termination(sch);
-}
-
 static int s390_subchannel_remove_chpid(struct subchannel *sch, void *data)
 {
-	int j;
-	int mask;
-	struct chp_id *chpid = data;
-	struct schib schib;
-
-	for (j = 0; j < 8; j++) {
-		mask = 0x80 >> j;
-		if ((sch->schib.pmcw.pim & mask) &&
-		    (sch->schib.pmcw.chpid[j] == chpid->id))
-			break;
-	}
-	if (j >= 8)
-		return 0;
-
 	spin_lock_irq(sch->lock);
-
-	stsch(sch->schid, &schib);
-	if (!css_sch_is_valid(&schib))
-		goto out_unreg;
-	memcpy(&sch->schib, &schib, sizeof(struct schib));
-	/* Check for single path devices. */
-	if (sch->schib.pmcw.pim == 0x80)
-		goto out_unreg;
-
-	if (check_for_io_on_path(sch, mask)) {
-		if (device_is_online(sch))
-			device_kill_io(sch);
-		else {
-			terminate_internal_io(sch);
-			/* Re-start path verification. */
-			if (sch->driver && sch->driver->verify)
-				sch->driver->verify(sch);
-		}
-	} else {
-		/* trigger path verification. */
-		if (sch->driver && sch->driver->verify)
-			sch->driver->verify(sch);
-		else if (sch->lpm == mask)
+	if (sch->driver && sch->driver->chp_event)
+		if (sch->driver->chp_event(sch, data, CHP_OFFLINE) != 0)
 			goto out_unreg;
-	}
-
 	spin_unlock_irq(sch->lock);
 	return 0;
 
@@ -242,53 +176,11 @@ static int s390_process_res_acc_new_sch(
 	return 0;
 }
 
-struct res_acc_data {
-	struct chp_id chpid;
-	u32 fla_mask;
-	u16 fla;
-};
-
-static int get_res_chpid_mask(struct chsc_ssd_info *ssd,
-			      struct res_acc_data *data)
-{
-	int i;
-	int mask;
-
-	for (i = 0; i < 8; i++) {
-		mask = 0x80 >> i;
-		if (!(ssd->path_mask & mask))
-			continue;
-		if (!chp_id_is_equal(&ssd->chpid[i], &data->chpid))
-			continue;
-		if ((ssd->fla_valid_mask & mask) &&
-		    ((ssd->fla[i] & data->fla_mask) != data->fla))
-			continue;
-		return mask;
-	}
-	return 0;
-}
-
 static int __s390_process_res_acc(struct subchannel *sch, void *data)
 {
-	int chp_mask, old_lpm;
-	struct res_acc_data *res_data = data;
-
 	spin_lock_irq(sch->lock);
-	chp_mask = get_res_chpid_mask(&sch->ssd_info, res_data);
-	if (chp_mask == 0)
-		goto out;
-	if (stsch(sch->schid, &sch->schib))
-		goto out;
-	old_lpm = sch->lpm;
-	sch->lpm = ((sch->schib.pmcw.pim &
-		     sch->schib.pmcw.pam &
-		     sch->schib.pmcw.pom)
-		    | chp_mask) & sch->opm;
-	if (!old_lpm && sch->lpm)
-		device_trigger_reprobe(sch);
-	else if (sch->driver && sch->driver->verify)
-		sch->driver->verify(sch);
-out:
+	if (sch->driver && sch->driver->chp_event)
+		sch->driver->chp_event(sch, data, CHP_ONLINE);
 	spin_unlock_irq(sch->lock);
 
 	return 0;
@@ -509,114 +401,36 @@ void chsc_process_crw(void)
 	} while (sei_area->flags & 0x80);
 }
 
-static int __chp_add_new_sch(struct subchannel_id schid, void *data)
-{
-	struct schib schib;
-
-	if (stsch_err(schid, &schib))
-		/* We're through */
-		return -ENXIO;
-
-	/* Put it on the slow path. */
-	css_schedule_eval(schid);
-	return 0;
-}
-
-
-static int __chp_add(struct subchannel *sch, void *data)
-{
-	int i, mask;
-	struct chp_id *chpid = data;
-
-	spin_lock_irq(sch->lock);
-	for (i=0; i<8; i++) {
-		mask = 0x80 >> i;
-		if ((sch->schib.pmcw.pim & mask) &&
-		    (sch->schib.pmcw.chpid[i] == chpid->id))
-			break;
-	}
-	if (i==8) {
-		spin_unlock_irq(sch->lock);
-		return 0;
-	}
-	if (stsch(sch->schid, &sch->schib)) {
-		spin_unlock_irq(sch->lock);
-		css_schedule_eval(sch->schid);
-		return 0;
-	}
-	sch->lpm = ((sch->schib.pmcw.pim &
-		     sch->schib.pmcw.pam &
-		     sch->schib.pmcw.pom)
-		    | mask) & sch->opm;
-
-	if (sch->driver && sch->driver->verify)
-		sch->driver->verify(sch);
-
-	spin_unlock_irq(sch->lock);
-
-	return 0;
-}
-
 void chsc_chp_online(struct chp_id chpid)
 {
 	char dbf_txt[15];
+	struct res_acc_data res_data;
 
 	sprintf(dbf_txt, "cadd%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
 	if (chp_get_status(chpid) != 0) {
+		memset(&res_data, 0, sizeof(struct res_acc_data));
+		res_data.chpid = chpid;
 		/* Wait until previous actions have settled. */
 		css_wait_for_slow_path();
-		for_each_subchannel_staged(__chp_add, __chp_add_new_sch,
-					   &chpid);
+		for_each_subchannel_staged(__s390_process_res_acc, NULL,
+					   &res_data);
 	}
 }
 
 static void __s390_subchannel_vary_chpid(struct subchannel *sch,
 					 struct chp_id chpid, int on)
 {
-	int chp, old_lpm;
-	int mask;
 	unsigned long flags;
+	struct res_acc_data res_data;
 
+	memset(&res_data, 0, sizeof(struct res_acc_data));
+	res_data.chpid = chpid;
 	spin_lock_irqsave(sch->lock, flags);
-	old_lpm = sch->lpm;
-	for (chp = 0; chp < 8; chp++) {
-		mask = 0x80 >> chp;
-		if (!(sch->ssd_info.path_mask & mask))
-			continue;
-		if (!chp_id_is_equal(&sch->ssd_info.chpid[chp], &chpid))
-			continue;
-
-		if (on) {
-			sch->opm |= mask;
-			sch->lpm |= mask;
-			if (!old_lpm)
-				device_trigger_reprobe(sch);
-			else if (sch->driver && sch->driver->verify)
-				sch->driver->verify(sch);
-			break;
-		}
-		sch->opm &= ~mask;
-		sch->lpm &= ~mask;
-		if (check_for_io_on_path(sch, mask)) {
-			if (device_is_online(sch))
-				/* Path verification is done after killing. */
-				device_kill_io(sch);
-			else {
-				/* Kill and retry internal I/O. */
-				terminate_internal_io(sch);
-				/* Re-start path verification. */
-				if (sch->driver && sch->driver->verify)
-					sch->driver->verify(sch);
-			}
-		} else if (!sch->lpm) {
-			if (device_trigger_verify(sch) != 0)
-				css_schedule_eval(sch->schid);
-		} else if (sch->driver && sch->driver->verify)
-			sch->driver->verify(sch);
-		break;
-	}
+	if (sch->driver && sch->driver->chp_event)
+		sch->driver->chp_event(sch, &res_data,
+				       on ? CHP_VARY_ON : CHP_VARY_OFF);
 	spin_unlock_irqrestore(sch->lock, flags);
 }
 
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -564,6 +564,7 @@ int cio_validate_subchannel(struct subch
 	}
 	/* Copy subchannel type from path management control word. */
 	sch->st = sch->schib.pmcw.st;
+
 	switch (sch->st) {
 	case SUBCHANNEL_TYPE_IO:
 		err = cio_validate_io_subchannel(sch);
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -283,7 +283,7 @@ static int css_register_subchannel(struc
 	return ret;
 }
 
-static int css_probe_device(struct subchannel_id schid)
+int css_probe_device(struct subchannel_id schid)
 {
 	int ret;
 	struct subchannel *sch;
@@ -330,112 +330,6 @@ int css_sch_is_valid(struct schib *schib
 }
 EXPORT_SYMBOL_GPL(css_sch_is_valid);
 
-static int css_get_subchannel_status(struct subchannel *sch)
-{
-	struct schib schib;
-
-	if (stsch(sch->schid, &schib))
-		return CIO_GONE;
-	if (!css_sch_is_valid(&schib))
-		return CIO_GONE;
-	if (sch->schib.pmcw.dnv && (schib.pmcw.dev != sch->schib.pmcw.dev))
-		return CIO_REVALIDATE;
-	if (!sch->lpm)
-		return CIO_NO_PATH;
-	return CIO_OPER;
-}
-
-static int css_evaluate_known_subchannel(struct subchannel *sch, int slow)
-{
-	int event, ret, disc;
-	unsigned long flags;
-	enum { NONE, UNREGISTER, UNREGISTER_PROBE, REPROBE } action;
-
-	spin_lock_irqsave(sch->lock, flags);
-	disc = device_is_disconnected(sch);
-	if (disc && slow) {
-		/* Disconnected devices are evaluated directly only.*/
-		spin_unlock_irqrestore(sch->lock, flags);
-		return 0;
-	}
-	/* No interrupt after machine check - kill pending timers. */
-	device_kill_pending_timer(sch);
-	if (!disc && !slow) {
-		/* Non-disconnected devices are evaluated on the slow path. */
-		spin_unlock_irqrestore(sch->lock, flags);
-		return -EAGAIN;
-	}
-	event = css_get_subchannel_status(sch);
-	CIO_MSG_EVENT(4, "Evaluating schid 0.%x.%04x, event %d, %s, %s path.\n",
-		      sch->schid.ssid, sch->schid.sch_no, event,
-		      disc ? "disconnected" : "normal",
-		      slow ? "slow" : "fast");
-	/* Analyze subchannel status. */
-	action = NONE;
-	switch (event) {
-	case CIO_NO_PATH:
-		if (disc) {
-			/* Check if paths have become available. */
-			action = REPROBE;
-			break;
-		}
-		/* fall through */
-	case CIO_GONE:
-		/* Prevent unwanted effects when opening lock. */
-		cio_disable_subchannel(sch);
-		device_set_disconnected(sch);
-		/* Ask driver what to do with device. */
-		action = UNREGISTER;
-		if (sch->driver && sch->driver->notify) {
-			spin_unlock_irqrestore(sch->lock, flags);
-			ret = sch->driver->notify(sch, event);
-			spin_lock_irqsave(sch->lock, flags);
-			if (ret)
-				action = NONE;
-		}
-		break;
-	case CIO_REVALIDATE:
-		/* Device will be removed, so no notify necessary. */
-		if (disc)
-			/* Reprobe because immediate unregister might block. */
-			action = REPROBE;
-		else
-			action = UNREGISTER_PROBE;
-		break;
-	case CIO_OPER:
-		if (disc)
-			/* Get device operational again. */
-			action = REPROBE;
-		break;
-	}
-	/* Perform action. */
-	ret = 0;
-	switch (action) {
-	case UNREGISTER:
-	case UNREGISTER_PROBE:
-		/* Unregister device (will use subchannel lock). */
-		spin_unlock_irqrestore(sch->lock, flags);
-		css_sch_device_unregister(sch);
-		spin_lock_irqsave(sch->lock, flags);
-
-		/* Reset intparm to zeroes. */
-		sch->schib.pmcw.intparm = 0;
-		cio_modify(sch);
-		break;
-	case REPROBE:
-		device_trigger_reprobe(sch);
-		break;
-	default:
-		break;
-	}
-	spin_unlock_irqrestore(sch->lock, flags);
-	/* Probe if necessary. */
-	if (action == UNREGISTER_PROBE)
-		ret = css_probe_device(sch->schid);
-
-	return ret;
-}
-
 static int css_evaluate_new_subchannel(struct subchannel_id schid, int slow)
 {
 	struct schib schib;
@@ -454,6 +348,21 @@ static int css_evaluate_new_subchannel(s
 	return css_probe_device(schid);
 }
 
+static int css_evaluate_known_subchannel(struct subchannel *sch, int slow)
+{
+	int ret = 0;
+
+	if (sch->driver) {
+		if (sch->driver->sch_event)
+			ret = sch->driver->sch_event(sch, slow);
+		else
+			dev_dbg(&sch->dev,
+				"Got subchannel machine check but "
+				"no sch_event handler provided.\n");
+	}
+	return ret;
+}
+
 static void css_evaluate_subchannel(struct subchannel_id schid, int slow)
 {
 	struct subchannel *sch;
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -58,18 +58,27 @@ struct pgid {
 	__u32 tod_high;		/* high word TOD clock */
 } __attribute__ ((packed));
 
-/*
- * A css driver handles all subchannels of one type.
- */
 struct subchannel;
+/**
+ * struct css_driver - device driver for subchannels
+ * @owner: owning module
+ * @subchannel_type: subchannel type supported by this driver
+ * @drv: embedded device driver structure
+ * @irq: called on interrupts
+ * @chp_event: called for events affecting a channel path
+ * @sch_event: called for events affecting the subchannel
+ * @probe: function called on probe
+ * @remove: function called on remove
+ * @shutdown: called at device shutdown
+ * @name: name of the device driver
+ */
 struct css_driver {
 	struct module *owner;
 	unsigned int subchannel_type;
 	struct device_driver drv;
 	void (*irq)(struct subchannel *);
-	int (*notify)(struct subchannel *, int);
-	void (*verify)(struct subchannel *);
-	void (*termination)(struct subchannel *);
+	int (*chp_event)(struct subchannel *, void *, int);
+	int (*sch_event)(struct subchannel *, int);
 	int (*probe)(struct subchannel *);
 	int (*remove)(struct subchannel *);
 	void (*shutdown)(struct subchannel *);
@@ -87,7 +96,8 @@ extern int css_driver_register(struct cs
 extern void css_driver_unregister(struct css_driver *);
 
 extern void css_sch_device_unregister(struct subchannel *);
-extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
+extern int css_probe_device(struct subchannel_id);
+extern struct subchannel *get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
 int for_each_subchannel_staged(int (*fn_known)(struct subchannel *, void *),
 			       int (*fn_unknown)(struct subchannel_id,
@@ -119,20 +129,6 @@ struct channel_subsystem {
 extern struct bus_type css_bus_type;
 extern struct channel_subsystem *channel_subsystems[];
 
-/* Some helper functions for disconnected state. */
-int device_is_disconnected(struct subchannel *);
-void device_set_disconnected(struct subchannel *);
-void device_trigger_reprobe(struct subchannel *);
-
-/* Helper functions for vary on/off. */
-int device_is_online(struct subchannel *);
-void device_kill_io(struct subchannel *);
-void device_set_intretry(struct subchannel *sch);
-int device_trigger_verify(struct subchannel *sch);
-
-/* Machine check helper function. */
-void device_kill_pending_timer(struct subchannel *);
-
 /* Helper functions to build lists for the slow path. */
 void css_schedule_eval(struct subchannel_id schid);
 void css_schedule_eval_all(void);
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -2,8 +2,7 @@
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
  *
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
- *			 IBM Corporation
+ *    Copyright IBM Corp. 2002,2008
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
@@ -126,19 +125,17 @@ struct bus_type ccw_bus_type;
 static void io_subchannel_irq(struct subchannel *);
 static int io_subchannel_probe(struct subchannel *);
 static int io_subchannel_remove(struct subchannel *);
-static int io_subchannel_notify(struct subchannel *, int);
-static void io_subchannel_verify(struct subchannel *);
-static void io_subchannel_ioterm(struct subchannel *);
 static void io_subchannel_shutdown(struct subchannel *);
+static int io_subchannel_sch_event(struct subchannel *, int);
+static int io_subchannel_chp_event(struct subchannel *, void *, int);
 
 static struct css_driver io_subchannel_driver = {
 	.owner = THIS_MODULE,
 	.subchannel_type = SUBCHANNEL_TYPE_IO,
 	.name = "io_subchannel",
 	.irq = io_subchannel_irq,
-	.notify = io_subchannel_notify,
-	.verify = io_subchannel_verify,
-	.termination = io_subchannel_ioterm,
+	.sch_event = io_subchannel_sch_event,
+	.chp_event = io_subchannel_chp_event,
 	.probe = io_subchannel_probe,
 	.remove = io_subchannel_remove,
 	.shutdown = io_subchannel_shutdown,
@@ -786,7 +783,7 @@ static void sch_attach_device(struct sub
 	sch_set_cdev(sch, cdev);
 	cdev->private->schid = sch->schid;
 	cdev->ccwlock = sch->lock;
-	device_trigger_reprobe(sch);
+	ccw_device_trigger_reprobe(cdev);
 	spin_unlock_irq(sch->lock);
 }
 
@@ -1265,11 +1262,7 @@ static int io_subchannel_notify(struct s
 	cdev = sch_get_cdev(sch);
 	if (!cdev)
 		return 0;
-	if (!cdev->drv)
-		return 0;
-	if (!cdev->online)
-		return 0;
-	return cdev->drv->notify ? cdev->drv->notify(cdev, event) : 0;
+	return ccw_device_notify(cdev, event);
 }
 
 static void io_subchannel_verify(struct subchannel *sch)
@@ -1281,22 +1274,98 @@ static void io_subchannel_verify(struct 
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
 }
 
-static void io_subchannel_ioterm(struct subchannel *sch)
+static int check_for_io_on_path(struct subchannel *sch, int mask)
 {
-	struct ccw_device *cdev;
+	int cc;
 
-	cdev = sch_get_cdev(sch);
-	if (!cdev)
-		return;
-	/* Internal I/O will be retried by the interrupt handler. */
-	if (cdev->private->flags.intretry)
+	cc = stsch(sch->schid, &sch->schib);
+	if (cc)
+		return 0;
+	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == mask)
+		return 1;
+	return 0;
+}
+
+static void terminate_internal_io(struct subchannel *sch,
+				  struct ccw_device *cdev)
+{
+	if (cio_clear(sch)) {
+		/* Recheck device in case clear failed. */
+		sch->lpm = 0;
+		if (cdev->online)
+			dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+		else
+			css_schedule_eval(sch->schid);
 		return;
+	}
 	cdev->private->state = DEV_STATE_CLEAR_VERIFY;
+	/* Request retry of internal operation. */
+	cdev->private->flags.intretry = 1;
+	/* Call handler. */
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
 			      ERR_PTR(-EIO));
 }
 
+static void io_subchannel_terminate_path(struct subchannel *sch, u8 mask)
+{
+	struct ccw_device *cdev;
+
+	cdev = sch_get_cdev(sch);
+	if (!cdev)
+		return;
+	if (check_for_io_on_path(sch, mask)) {
+		if (cdev->private->state == DEV_STATE_ONLINE)
+			ccw_device_kill_io(cdev);
+		else {
+			terminate_internal_io(sch, cdev);
+			/* Re-start path verification. */
+			dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+		}
+	} else
+		/* trigger path verification. */
+		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+
+}
+
+static int io_subchannel_chp_event(struct subchannel *sch, void *data,
+				   int event)
+{
+	int mask;
+	struct res_acc_data *res_data;
+
+	res_data = data;
+	mask = chp_ssd_get_mask(&sch->ssd_info, res_data);
+	if (!mask)
+		return 0;
+	switch (event) {
+	case CHP_VARY_OFF:
+		sch->opm &= ~mask;
+		sch->lpm &= ~mask;
+		io_subchannel_terminate_path(sch, mask);
+		break;
+	case CHP_VARY_ON:
+		sch->opm |= mask;
+		sch->lpm |= mask;
+		io_subchannel_verify(sch);
+		break;
+	case CHP_OFFLINE:
+		if (stsch(sch->schid, &sch->schib))
+			return -ENXIO;
+		if (!css_sch_is_valid(&sch->schib))
+			return -ENODEV;
+		io_subchannel_terminate_path(sch, mask);
+		break;
+	case CHP_ONLINE:
+		if (stsch(sch->schid, &sch->schib))
+			return -ENXIO;
+		sch->lpm |= mask & sch->opm;
+		io_subchannel_verify(sch);
+		break;
+	}
+	return 0;
+}
+
 static void
 io_subchannel_shutdown(struct subchannel *sch)
 {
@@ -1326,6 +1395,195 @@ io_subchannel_shutdown(struct subchannel
 	cio_disable_subchannel(sch);
 }
 
+static int io_subchannel_get_status(struct subchannel *sch)
+{
+	struct schib schib;
+
+	if (stsch(sch->schid, &schib) || !schib.pmcw.dnv)
+		return CIO_GONE;
+	if (sch->schib.pmcw.dnv && (schib.pmcw.dev != sch->schib.pmcw.dev))
+		return CIO_REVALIDATE;
+	if (!sch->lpm)
+		return CIO_NO_PATH;
+	return CIO_OPER;
+}
+
+static int device_is_disconnected(struct ccw_device *cdev)
+{
+	if (!cdev)
+		return 0;
+	return (cdev->private->state == DEV_STATE_DISCONNECTED ||
+		cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID);
+}
+
+static int recovery_check(struct device *dev, void *data)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+	int *redo = data;
+
+	spin_lock_irq(cdev->ccwlock);
+	switch (cdev->private->state) {
+	case DEV_STATE_DISCONNECTED:
+		CIO_MSG_EVENT(3, "recovery: trigger 0.%x.%04x\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
+		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+		*redo = 1;
+		break;
+	case DEV_STATE_DISCONNECTED_SENSE_ID:
+		*redo = 1;
+		break;
+	}
+	spin_unlock_irq(cdev->ccwlock);
+
+	return 0;
+}
+
+static void recovery_work_func(struct work_struct *unused)
+{
+	int redo = 0;
+
+	bus_for_each_dev(&ccw_bus_type, NULL, &redo, recovery_check);
+	if (redo) {
+		spin_lock_irq(&recovery_lock);
+		if (!timer_pending(&recovery_timer)) {
+			if (recovery_phase < ARRAY_SIZE(recovery_delay) - 1)
+				recovery_phase++;
+			mod_timer(&recovery_timer, jiffies +
+				  recovery_delay[recovery_phase] * HZ);
+		}
+		spin_unlock_irq(&recovery_lock);
+	} else
+		CIO_MSG_EVENT(4, "recovery: end\n");
+}
+
+static DECLARE_WORK(recovery_work, recovery_work_func);
+
+static void recovery_func(unsigned long data)
+{
+	/*
+	 * We can't do our recovery in softirq context and it's not
+	 * performance critical, so we schedule it.
+	 */
+	schedule_work(&recovery_work);
+}
+
+static void ccw_device_schedule_recovery(void)
+{
+	unsigned long flags;
+
+	CIO_MSG_EVENT(4, "recovery: schedule\n");
+	spin_lock_irqsave(&recovery_lock, flags);
+	if (!timer_pending(&recovery_timer) || (recovery_phase != 0)) {
+		recovery_phase = 0;
+		mod_timer(&recovery_timer, jiffies + recovery_delay[0] * HZ);
+	}
+	spin_unlock_irqrestore(&recovery_lock, flags);
+}
+
+static void device_set_disconnected(struct ccw_device *cdev)
+{
+	if (!cdev)
+		return;
+	ccw_device_set_timeout(cdev, 0);
+	cdev->private->flags.fake_irb = 0;
+	cdev->private->state = DEV_STATE_DISCONNECTED;
+	if (cdev->online)
+		ccw_device_schedule_recovery();
+}
+
+static int io_subchannel_sch_event(struct subchannel *sch, int slow)
+{
+	int event, ret, disc;
+	unsigned long flags;
+	enum { NONE, UNREGISTER, UNREGISTER_PROBE, REPROBE } action;
+	struct ccw_device *cdev;
+
+	spin_lock_irqsave(sch->lock, flags);
+	cdev = sch_get_cdev(sch);
+	disc = device_is_disconnected(cdev);
+	if (disc && slow) {
+		/* Disconnected devices are evaluated directly only.*/
+		spin_unlock_irqrestore(sch->lock, flags);
+		return 0;
+	}
+	/* No interrupt after machine check - kill pending timers. */
+	if (cdev)
+		ccw_device_set_timeout(cdev, 0);
+	if (!disc && !slow) {
+		/* Non-disconnected devices are evaluated on the slow path. */
+		spin_unlock_irqrestore(sch->lock, flags);
+		return -EAGAIN;
+	}
+	event = io_subchannel_get_status(sch);
+	CIO_MSG_EVENT(4, "Evaluating schid 0.%x.%04x, event %d, %s, %s path.\n",
+		      sch->schid.ssid, sch->schid.sch_no, event,
+		      disc ? "disconnected" : "normal",
+		      slow ? "slow" : "fast");
+	/* Analyze subchannel status. */
+	action = NONE;
+	switch (event) {
+	case CIO_NO_PATH:
+		if (disc) {
+			/* Check if paths have become available. */
+			action = REPROBE;
+			break;
+		}
+		/* fall through */
+	case CIO_GONE:
+		/* Prevent unwanted effects when opening lock. */
+		cio_disable_subchannel(sch);
+		device_set_disconnected(cdev);
+		/* Ask driver what to do with device. */
+		action = UNREGISTER;
+		spin_unlock_irqrestore(sch->lock, flags);
+		ret = io_subchannel_notify(sch, event);
+		spin_lock_irqsave(sch->lock, flags);
+		if (ret)
+			action = NONE;
+		break;
+	case CIO_REVALIDATE:
+		/* Device will be removed, so no notify necessary. */
+		if (disc)
+			/* Reprobe because immediate unregister might block. */
+			action = REPROBE;
+		else
+			action = UNREGISTER_PROBE;
+		break;
+	case CIO_OPER:
+		if (disc)
+			/* Get device operational again. */
+			action = REPROBE;
+		break;
+	}
+	/* Perform action. */
+	ret = 0;
+	switch (action) {
+	case UNREGISTER:
+	case UNREGISTER_PROBE:
+		/* Unregister device (will use subchannel lock). */
+		spin_unlock_irqrestore(sch->lock, flags);
+		css_sch_device_unregister(sch);
+		spin_lock_irqsave(sch->lock, flags);
+
+		/* Reset intparm to zeroes. */
+		sch->schib.pmcw.intparm = 0;
+		cio_modify(sch);
+		break;
+	case REPROBE:
+		ccw_device_trigger_reprobe(cdev);
+		break;
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	/* Probe if necessary. */
+	if (action == UNREGISTER_PROBE)
+		ret = css_probe_device(sch->schid);
+
+	return ret;
+}
+
 #ifdef CONFIG_CCW_CONSOLE
 static struct ccw_device console_cdev;
 static struct ccw_device_private console_private;
@@ -1558,71 +1816,6 @@ ccw_device_get_subchannel_id(struct ccw_
 	return sch->schid;
 }
 
-static int recovery_check(struct device *dev, void *data)
-{
-	struct ccw_device *cdev = to_ccwdev(dev);
-	int *redo = data;
-
-	spin_lock_irq(cdev->ccwlock);
-	switch (cdev->private->state) {
-	case DEV_STATE_DISCONNECTED:
-		CIO_MSG_EVENT(4, "recovery: trigger 0.%x.%04x\n",
-			      cdev->private->dev_id.ssid,
-			      cdev->private->dev_id.devno);
-		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
-		*redo = 1;
-		break;
-	case DEV_STATE_DISCONNECTED_SENSE_ID:
-		*redo = 1;
-		break;
-	}
-	spin_unlock_irq(cdev->ccwlock);
-
-	return 0;
-}
-
-static void recovery_work_func(struct work_struct *unused)
-{
-	int redo = 0;
-
-	bus_for_each_dev(&ccw_bus_type, NULL, &redo, recovery_check);
-	if (redo) {
-		spin_lock_irq(&recovery_lock);
-		if (!timer_pending(&recovery_timer)) {
-			if (recovery_phase < ARRAY_SIZE(recovery_delay) - 1)
-				recovery_phase++;
-			mod_timer(&recovery_timer, jiffies +
-				  recovery_delay[recovery_phase] * HZ);
-		}
-		spin_unlock_irq(&recovery_lock);
-	} else
-		CIO_MSG_EVENT(4, "recovery: end\n");
-}
-
-static DECLARE_WORK(recovery_work, recovery_work_func);
-
-static void recovery_func(unsigned long data)
-{
-	/*
-	 * We can't do our recovery in softirq context and it's not
-	 * performance critical, so we schedule it.
-	 */
-	schedule_work(&recovery_work);
-}
-
-void ccw_device_schedule_recovery(void)
-{
-	unsigned long flags;
-
-	CIO_MSG_EVENT(4, "recovery: schedule\n");
-	spin_lock_irqsave(&recovery_lock, flags);
-	if (!timer_pending(&recovery_timer) || (recovery_phase != 0)) {
-		recovery_phase = 0;
-		mod_timer(&recovery_timer, jiffies + recovery_delay[0] * HZ);
-	}
-	spin_unlock_irqrestore(&recovery_lock, flags);
-}
-
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_online);
 EXPORT_SYMBOL(ccw_device_set_offline);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -2,8 +2,7 @@
  * drivers/s390/cio/device_fsm.c
  * finite state machine for device handling
  *
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
- *			 IBM Corporation
+ *    Copyright IBM Corp. 2002,2008
  *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
@@ -27,65 +26,6 @@
 
 static int timeout_log_enabled;
 
-int
-device_is_online(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	cdev = sch_get_cdev(sch);
-	if (!cdev)
-		return 0;
-	return (cdev->private->state == DEV_STATE_ONLINE);
-}
-
-int
-device_is_disconnected(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	cdev = sch_get_cdev(sch);
-	if (!cdev)
-		return 0;
-	return (cdev->private->state == DEV_STATE_DISCONNECTED ||
-		cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID);
-}
-
-void
-device_set_disconnected(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	cdev = sch_get_cdev(sch);
-	if (!cdev)
-		return;
-	ccw_device_set_timeout(cdev, 0);
-	cdev->private->flags.fake_irb = 0;
-	cdev->private->state = DEV_STATE_DISCONNECTED;
-	if (cdev->online)
-		ccw_device_schedule_recovery();
-}
-
-void device_set_intretry(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	cdev = sch_get_cdev(sch);
-	if (!cdev)
-		return;
-	cdev->private->flags.intretry = 1;
-}
-
-int device_trigger_verify(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	cdev = sch_get_cdev(sch);
-	if (!cdev || !cdev->online)
-		return -EINVAL;
-	dev_fsm_event(cdev, DEV_EVENT_VERIFY);
-	return 0;
-}
-
 static int __init ccw_timeout_log_setup(char *unused)
 {
 	timeout_log_enabled = 1;
@@ -171,18 +111,6 @@ ccw_device_set_timeout(struct ccw_device
 	add_timer(&cdev->private->timer);
 }
 
-/* Kill any pending timers after machine check. */
-void
-device_kill_pending_timer(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	cdev = sch_get_cdev(sch);
-	if (!cdev)
-		return;
-	ccw_device_set_timeout(cdev, 0);
-}
-
 /*
  * Cancel running i/o. This is called repeatedly since halt/clear are
  * asynchronous operations. We do one try with cio_cancel, two tries
@@ -388,25 +316,27 @@ ccw_device_sense_id_done(struct ccw_devi
 	}
 }
 
+int ccw_device_notify(struct ccw_device *cdev, int event)
+{
+	if (!cdev->drv)
+		return 0;
+	if (!cdev->online)
+		return 0;
+	return cdev->drv->notify ? cdev->drv->notify(cdev, event) : 0;
+}
+
 static void
 ccw_device_oper_notify(struct work_struct *work)
 {
 	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
-	struct subchannel *sch;
 	int ret;
 	unsigned long flags;
 
 	priv = container_of(work, struct ccw_device_private, kick_work);
 	cdev = priv->cdev;
+	ret = ccw_device_notify(cdev, CIO_OPER);
 	spin_lock_irqsave(cdev->ccwlock, flags);
-	sch = to_subchannel(cdev->dev.parent);
-	if (sch->driver && sch->driver->notify) {
-		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		ret = sch->driver->notify(sch, CIO_OPER);
-		spin_lock_irqsave(cdev->ccwlock, flags);
-	} else
-		ret = 0;
 	if (ret) {
 		/* Reenable channel measurements, if needed. */
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
@@ -986,12 +916,10 @@ ccw_device_killing_timeout(struct ccw_de
 			      ERR_PTR(-EIO));
 }
 
-void device_kill_io(struct subchannel *sch)
+void ccw_device_kill_io(struct ccw_device *cdev)
 {
 	int ret;
-	struct ccw_device *cdev;
 
-	cdev = sch_get_cdev(sch);
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
@@ -1055,17 +983,14 @@ ccw_device_start_id(struct ccw_device *c
 	ccw_device_sense_id_start(cdev);
 }
 
-void
-device_trigger_reprobe(struct subchannel *sch)
+void ccw_device_trigger_reprobe(struct ccw_device *cdev)
 {
-	struct ccw_device *cdev;
+	struct subchannel *sch;
 
-	cdev = sch_get_cdev(sch);
-	if (!cdev)
-		return;
 	if (cdev->private->state != DEV_STATE_DISCONNECTED)
 		return;
 
+	sch = to_subchannel(cdev->dev.parent);
 	/* Update some values. */
 	if (stsch(sch->schid, &sch->schib))
 		return;
@@ -1081,7 +1006,6 @@ device_trigger_reprobe(struct subchannel
 	sch->schib.pmcw.ena = 0;
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
 		sch->schib.pmcw.mp = 1;
-	sch->schib.pmcw.intparm = (u32)(addr_t)sch;
 	/* We should also udate ssd info, but this has to wait. */
 	/* Check if this is another device which appeared on the same sch. */
 	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h
+++ quilt-2.6/drivers/s390/cio/device.h
@@ -88,8 +88,6 @@ int ccw_device_recognition(struct ccw_de
 int ccw_device_online(struct ccw_device *);
 int ccw_device_offline(struct ccw_device *);
 
-void ccw_device_schedule_recovery(void);
-
 /* Function prototypes for device status and basic sense stuff. */
 void ccw_device_accumulate_irb(struct ccw_device *, struct irb *);
 void ccw_device_accumulate_basic_sense(struct ccw_device *, struct irb *);
@@ -118,6 +116,11 @@ int ccw_device_call_handler(struct ccw_d
 
 int ccw_device_stlck(struct ccw_device *);
 
+/* Helper function for machine check handling. */
+void ccw_device_trigger_reprobe(struct ccw_device *);
+void ccw_device_kill_io(struct ccw_device *);
+int ccw_device_notify(struct ccw_device *, int);
+
 /* qdio needs this. */
 void ccw_device_set_timeout(struct ccw_device *, int);
 extern struct subchannel_id ccw_device_get_subchannel_id(struct ccw_device *);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
