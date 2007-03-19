Return-Path: <linux-kernel-owner+w=401wt.eu-S965710AbXCSNDY@vger.kernel.org>
Date: Mon, 19 Mar 2007 14:03:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] cio: introduce separate files for channel-path related code
Message-ID: <20070319130332.GF1292@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: peter.oberparleiter@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: introduce separate files for channel-path related code

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/Makefile     |    2 
 drivers/s390/cio/chp.c        |  433 ++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/chp.h        |   37 +++
 drivers/s390/cio/chsc.c       |  473 +++---------------------------------------
 drivers/s390/cio/chsc.h       |   30 --
 drivers/s390/cio/cio.c        |    8 
 drivers/s390/cio/css.h        |    1 
 drivers/s390/cio/device_fsm.c |    6 
 drivers/s390/cio/device_ops.c |    7 
 drivers/s390/s390mach.c       |    1 
 10 files changed, 535 insertions(+), 463 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chp.c linux-2.6-patched/drivers/s390/cio/chp.c
--- linux-2.6/drivers/s390/cio/chp.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chp.c	2007-03-19 13:09:38.000000000 +0100
@@ -0,0 +1,433 @@
+/*
+ *  drivers/s390/cio/chp.c
+ *
+ *    Copyright IBM Corp. 1999,2007
+ *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
+ *		 Arnd Bergmann (arndb@de.ibm.com)
+ *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#include <linux/bug.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+#include <asm/errno.h>
+
+#include "chpid.h"
+#include "cio.h"
+#include "css.h"
+#include "ioasm.h"
+#include "cio_debug.h"
+#include "chp.h"
+
+#define to_channelpath(device) container_of(device, struct channel_path, dev)
+
+/* Return channel_path struct for given chpid. */
+static inline struct channel_path *chpid_to_chp(struct chp_id chpid)
+{
+	return css[chpid.cssid]->chps[chpid.id];
+}
+
+/* Set vary state for given chpid. */
+static void set_chp_logically_online(struct chp_id chpid, int onoff)
+{
+	chpid_to_chp(chpid)->state = onoff;
+}
+
+/* On succes return 0 if channel-path is varied offline, 1 if it is varied
+ * online. Return -ENODEV if channel-path is not registered. */
+int chp_get_status(struct chp_id chpid)
+{
+	return (chpid_to_chp(chpid) ? chpid_to_chp(chpid)->state : -ENODEV);
+}
+
+/**
+ * chp_get_sch_opm - return opm for subchannel
+ * @sch: subchannel
+ *
+ * Calculate and return the operational path mask (opm) based on the chpids
+ * used by the subchannel and the status of the associated channel-paths.
+ */
+u8 chp_get_sch_opm(struct subchannel *sch)
+{
+	struct chp_id chpid;
+	int opm;
+	int i;
+
+	opm = 0;
+	chp_id_init(&chpid);
+	for (i=0; i < 8; i++) {
+		opm <<= 1;
+		chpid.id = sch->schib.pmcw.chpid[i];
+		if (chp_get_status(chpid) != 0)
+			opm |= 1;
+	}
+	return opm;
+}
+
+/**
+ * chp_is_registered - check if a channel-path is registered
+ * @chpid: channel-path ID
+ *
+ * Return non-zero if a channel-path with the given chpid is registered,
+ * zero otherwise.
+ */
+int chp_is_registered(struct chp_id chpid)
+{
+	return chpid_to_chp(chpid) != NULL;
+}
+
+/*
+ * Function: s390_vary_chpid
+ * Varies the specified chpid online or offline
+ */
+static int s390_vary_chpid(struct chp_id chpid, int on)
+{
+	char dbf_text[15];
+	int status;
+
+	sprintf(dbf_text, on?"varyon%x.%02x":"varyoff%x.%02x", chpid.cssid,
+		chpid.id);
+	CIO_TRACE_EVENT( 2, dbf_text);
+
+	status = chp_get_status(chpid);
+	if (status < 0) {
+		printk(KERN_ERR "Can't vary unknown chpid %x.%02x\n",
+		       chpid.cssid, chpid.id);
+		return -EINVAL;
+	}
+
+	if (!on && !status) {
+		printk(KERN_ERR "chpid %x.%02x is already offline\n",
+		       chpid.cssid, chpid.id);
+		return -EINVAL;
+	}
+
+	set_chp_logically_online(chpid, on);
+	chsc_chp_vary(chpid, on);
+	return 0;
+}
+
+/*
+ * Channel measurement related functions
+ */
+static ssize_t chp_measurement_chars_read(struct kobject *kobj, char *buf,
+					  loff_t off, size_t count)
+{
+	struct channel_path *chp;
+	unsigned int size;
+
+	chp = to_channelpath(container_of(kobj, struct device, kobj));
+	if (!chp->cmg_chars)
+		return 0;
+
+	size = sizeof(struct cmg_chars);
+
+	if (off > size)
+		return 0;
+	if (off + count > size)
+		count = size - off;
+	memcpy(buf, chp->cmg_chars + off, count);
+	return count;
+}
+
+static struct bin_attribute chp_measurement_chars_attr = {
+	.attr = {
+		.name = "measurement_chars",
+		.mode = S_IRUSR,
+		.owner = THIS_MODULE,
+	},
+	.size = sizeof(struct cmg_chars),
+	.read = chp_measurement_chars_read,
+};
+
+static void chp_measurement_copy_block(struct cmg_entry *buf,
+				       struct channel_subsystem *css,
+				       struct chp_id chpid)
+{
+	void *area;
+	struct cmg_entry *entry, reference_buf;
+	int idx;
+
+	if (chpid.id < 128) {
+		area = css->cub_addr1;
+		idx = chpid.id;
+	} else {
+		area = css->cub_addr2;
+		idx = chpid.id - 128;
+	}
+	entry = area + (idx * sizeof(struct cmg_entry));
+	do {
+		memcpy(buf, entry, sizeof(*entry));
+		memcpy(&reference_buf, entry, sizeof(*entry));
+	} while (reference_buf.values[0] != buf->values[0]);
+}
+
+static ssize_t chp_measurement_read(struct kobject *kobj, char *buf,
+				    loff_t off, size_t count)
+{
+	struct channel_path *chp;
+	struct channel_subsystem *css;
+	unsigned int size;
+
+	chp = to_channelpath(container_of(kobj, struct device, kobj));
+	css = to_css(chp->dev.parent);
+
+	size = sizeof(struct cmg_entry);
+
+	/* Only allow single reads. */
+	if (off || count < size)
+		return 0;
+	chp_measurement_copy_block((struct cmg_entry *)buf, css, chp->chpid);
+	count = size;
+	return count;
+}
+
+static struct bin_attribute chp_measurement_attr = {
+	.attr = {
+		.name = "measurement",
+		.mode = S_IRUSR,
+		.owner = THIS_MODULE,
+	},
+	.size = sizeof(struct cmg_entry),
+	.read = chp_measurement_read,
+};
+
+void chp_remove_cmg_attr(struct channel_path *chp)
+{
+	device_remove_bin_file(&chp->dev, &chp_measurement_chars_attr);
+	device_remove_bin_file(&chp->dev, &chp_measurement_attr);
+}
+
+int chp_add_cmg_attr(struct channel_path *chp)
+{
+	int ret;
+
+	ret = device_create_bin_file(&chp->dev, &chp_measurement_chars_attr);
+	if (ret)
+		return ret;
+	ret = device_create_bin_file(&chp->dev, &chp_measurement_attr);
+	if (ret)
+		device_remove_bin_file(&chp->dev, &chp_measurement_chars_attr);
+	return ret;
+}
+
+/*
+ * Files for the channel path entries.
+ */
+static ssize_t chp_status_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct channel_path *chp = container_of(dev, struct channel_path, dev);
+
+	if (!chp)
+		return 0;
+	return (chp_get_status(chp->chpid) ? sprintf(buf, "online\n") :
+		sprintf(buf, "offline\n"));
+}
+
+static ssize_t chp_status_write(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct channel_path *cp = container_of(dev, struct channel_path, dev);
+	char cmd[10];
+	int num_args;
+	int error;
+
+	num_args = sscanf(buf, "%5s", cmd);
+	if (!num_args)
+		return count;
+
+	if (!strnicmp(cmd, "on", 2) || !strcmp(cmd, "1"))
+		error = s390_vary_chpid(cp->chpid, 1);
+	else if (!strnicmp(cmd, "off", 3) || !strcmp(cmd, "0"))
+		error = s390_vary_chpid(cp->chpid, 0);
+	else
+		error = -EINVAL;
+
+	return error < 0 ? error : count;
+
+}
+
+static DEVICE_ATTR(status, 0644, chp_status_show, chp_status_write);
+
+static ssize_t chp_type_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct channel_path *chp = container_of(dev, struct channel_path, dev);
+
+	if (!chp)
+		return 0;
+	return sprintf(buf, "%x\n", chp->desc.desc);
+}
+
+static DEVICE_ATTR(type, 0444, chp_type_show, NULL);
+
+static ssize_t chp_cmg_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct channel_path *chp = to_channelpath(dev);
+
+	if (!chp)
+		return 0;
+	if (chp->cmg == -1) /* channel measurements not available */
+		return sprintf(buf, "unknown\n");
+	return sprintf(buf, "%x\n", chp->cmg);
+}
+
+static DEVICE_ATTR(cmg, 0444, chp_cmg_show, NULL);
+
+static ssize_t chp_shared_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct channel_path *chp = to_channelpath(dev);
+
+	if (!chp)
+		return 0;
+	if (chp->shared == -1) /* channel measurements not available */
+		return sprintf(buf, "unknown\n");
+	return sprintf(buf, "%x\n", chp->shared);
+}
+
+static DEVICE_ATTR(shared, 0444, chp_shared_show, NULL);
+
+static struct attribute * chp_attrs[] = {
+	&dev_attr_status.attr,
+	&dev_attr_type.attr,
+	&dev_attr_cmg.attr,
+	&dev_attr_shared.attr,
+	NULL,
+};
+
+static struct attribute_group chp_attr_group = {
+	.attrs = chp_attrs,
+};
+
+static void chp_release(struct device *dev)
+{
+	struct channel_path *cp;
+
+	cp = container_of(dev, struct channel_path, dev);
+	kfree(cp);
+}
+
+/**
+ * chp_new - register a new channel-path
+ * @chpid - channel-path ID
+ *
+ * Create and register data structure representing new channel-path. Return
+ * zero on success, non-zero otherwise.
+ */
+int chp_new(struct chp_id chpid)
+{
+	struct channel_path *chp;
+	int ret;
+
+	chp = kzalloc(sizeof(struct channel_path), GFP_KERNEL);
+	if (!chp)
+		return -ENOMEM;
+
+	/* fill in status, etc. */
+	chp->chpid = chpid;
+	chp->state = 1;
+	chp->dev.parent = &css[chpid.cssid]->device;
+	chp->dev.release = chp_release;
+	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp%x.%02x", chpid.cssid,
+		 chpid.id);
+
+	/* Obtain channel path description and fill it in. */
+	ret = chsc_determine_channel_path_description(chpid, &chp->desc);
+	if (ret)
+		goto out_free;
+	/* Get channel-measurement characteristics. */
+	if (css_characteristics_avail && css_chsc_characteristics.scmc
+	    && css_chsc_characteristics.secm) {
+		ret = chsc_get_channel_measurement_chars(chp);
+		if (ret)
+			goto out_free;
+	} else {
+		static int msg_done;
+
+		if (!msg_done) {
+			printk(KERN_WARNING "cio: Channel measurements not "
+			       "available, continuing.\n");
+			msg_done = 1;
+		}
+		chp->cmg = -1;
+	}
+
+	/* make it known to the system */
+	ret = device_register(&chp->dev);
+	if (ret) {
+		printk(KERN_WARNING "%s: could not register %x.%02x\n",
+		       __func__, chpid.cssid, chpid.id);
+		goto out_free;
+	}
+	ret = sysfs_create_group(&chp->dev.kobj, &chp_attr_group);
+	if (ret) {
+		device_unregister(&chp->dev);
+		goto out_free;
+	}
+	mutex_lock(&css[chpid.cssid]->mutex);
+	if (css[chpid.cssid]->cm_enabled) {
+		ret = chp_add_cmg_attr(chp);
+		if (ret) {
+			sysfs_remove_group(&chp->dev.kobj, &chp_attr_group);
+			device_unregister(&chp->dev);
+			mutex_unlock(&css[chpid.cssid]->mutex);
+			goto out_free;
+		}
+	}
+	css[chpid.cssid]->chps[chpid.id] = chp;
+	mutex_unlock(&css[chpid.cssid]->mutex);
+	return ret;
+out_free:
+	kfree(chp);
+	return ret;
+}
+
+/**
+ * chp_get_chp_desc - return newly allocated channel-path description
+ * @chpid: channel-path ID
+ *
+ * On success return a newly allocated copy of the channel-path description
+ * data associated with the given channel-path ID. Return %NULL on error.
+ */
+void *chp_get_chp_desc(struct chp_id chpid)
+{
+	struct channel_path *chp;
+	struct channel_path_desc *desc;
+
+	chp = chpid_to_chp(chpid);
+	if (!chp)
+		return NULL;
+	desc = kmalloc(sizeof(struct channel_path_desc), GFP_KERNEL);
+	if (!desc)
+		return NULL;
+	memcpy(desc, &chp->desc, sizeof(struct channel_path_desc));
+	return desc;
+}
+
+/**
+ * chp_process_crw - process channel-path status change
+ * @id: channel-path ID number
+ * @status: non-zero if channel-path has become available, zero otherwise
+ *
+ * Handle channel-report-words indicating that the status of a channel-path
+ * has changed.
+ */
+int chp_process_crw(int id, int status)
+{
+	struct chp_id chpid;
+
+	chp_id_init(&chpid);
+	chpid.id = id;
+	if (status) {
+		if (!chp_is_registered(chpid))
+			chp_new(chpid);
+		return chsc_chp_online(chpid);
+	} else {
+		chsc_chp_offline(chpid);
+		return 0;
+	}
+}
diff -urpN linux-2.6/drivers/s390/cio/chp.h linux-2.6-patched/drivers/s390/cio/chp.h
--- linux-2.6/drivers/s390/cio/chp.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chp.h	2007-03-19 13:09:38.000000000 +0100
@@ -0,0 +1,37 @@
+/*
+ *  drivers/s390/cio/chp.h
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#ifndef S390_CHP_H
+#define S390_CHP_H S390_CHP_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+
+#include "chpid.h"
+#include "chsc.h"
+
+struct channel_path {
+	struct chp_id chpid;
+	int state;
+	struct channel_path_desc desc;
+	/* Channel-measurement related stuff: */
+	int cmg;
+	int shared;
+	void *cmg_chars;
+	struct device dev;
+};
+
+int chp_get_status(struct chp_id chpid);
+u8 chp_get_sch_opm(struct subchannel *sch);
+int chp_is_registered(struct chp_id chpid);
+void *chp_get_chp_desc(struct chp_id chpid);
+int chp_process_crw(int id, int available);
+void chp_remove_cmg_attr(struct channel_path *chp);
+int chp_add_cmg_attr(struct channel_path *chp);
+int chp_new(struct chp_id chpid);
+
+#endif /* S390_CHP_H */
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2007-03-19 13:09:38.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2007-03-19 13:09:38.000000000 +0100
@@ -21,54 +21,11 @@
 #include "cio_debug.h"
 #include "ioasm.h"
 #include "chpid.h"
+#include "chp.h"
 #include "chsc.h"
 
 static void *sei_page;
 
-static int new_channel_path(struct chp_id chpid);
-
-static inline struct channel_path *chpid_to_chp(struct chp_id chpid)
-{
-	return css[chpid.cssid]->chps[chpid.id];
-}
-
-static void set_chp_logically_online(struct chp_id chpid, int onoff)
-{
-	chpid_to_chp(chpid)->state = onoff;
-}
-
-static int get_chp_status(struct chp_id chpid)
-{
-	return (chpid_to_chp(chpid) ? chpid_to_chp(chpid)->state : -ENODEV);
-}
-
-void chsc_validate_chpids(struct subchannel *sch)
-{
-	int mask, chp;
-	struct chp_id chpid;
-
-	chp_id_init(&chpid);
-	for (chp = 0; chp <= 7; chp++) {
-		mask = 0x80 >> chp;
-		chpid.id = sch->schib.pmcw.chpid[chp];
-		if (!get_chp_status(chpid))
-			/* disable using this path */
-			sch->opm &= ~mask;
-	}
-}
-
-void chpid_is_actually_online(struct chp_id chpid)
-{
-	int state;
-
-	state = get_chp_status(chpid);
-	if (state < 0) {
-		need_rescan = 1;
-		queue_work(slow_path_wq, &slow_path_work);
-	} else
-		WARN_ON(!state);
-}
-
 /* FIXME: this is _always_ called for every subchannel. shouldn't we
  *	  process more than one at a time? */
 static int
@@ -214,8 +171,8 @@ css_get_ssd_info(struct subchannel *sch)
 			mask = 0x80 >> j;
 			chpid.id = sch->ssd_info.chpid[j];
 			if ((sch->schib.pmcw.pim & mask) &&
-			    (get_chp_status(chpid) < 0))
-			    new_channel_path(chpid);
+			    !chp_is_registered(chpid))
+				chp_new(chpid);
 		}
 	}
 	return ret;
@@ -227,7 +184,7 @@ s390_subchannel_remove_chpid(struct devi
 	int j;
 	int mask;
 	struct subchannel *sch;
-	struct channel_path *chpid;
+	struct chp_id *chpid;
 	struct schib schib;
 
 	sch = to_subchannel(dev);
@@ -235,7 +192,7 @@ s390_subchannel_remove_chpid(struct devi
 	for (j = 0; j < 8; j++) {
 		mask = 0x80 >> j;
 		if ((sch->schib.pmcw.pim & mask) &&
-		    (sch->schib.pmcw.chpid[j] == chpid->chpid.id))
+		    (sch->schib.pmcw.chpid[j] == chpid->id))
 			break;
 	}
 	if (j >= 8)
@@ -285,51 +242,48 @@ out_unreg:
 	return 0;
 }
 
-static void s390_set_chpid_offline(struct chp_id chpid)
+void chsc_chp_offline(struct chp_id chpid)
 {
 	char dbf_txt[15];
-	struct device *dev;
 
 	sprintf(dbf_txt, "chpr%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	if (get_chp_status(chpid) <= 0)
+	if (chp_get_status(chpid) <= 0)
 		return;
-	dev = get_device(&(chpid_to_chp(chpid)->dev));
-	bus_for_each_dev(&css_bus_type, NULL, to_channelpath(dev),
+	bus_for_each_dev(&css_bus_type, NULL, &chpid,
 			 s390_subchannel_remove_chpid);
 
 	if (need_rescan || css_slow_subchannels_exist())
 		queue_work(slow_path_wq, &slow_path_work);
-	put_device(dev);
 }
 
 struct res_acc_data {
-	struct channel_path *chp;
+	struct chp_id chpid;
 	u32 fla_mask;
 	u16 fla;
 };
 
-static int
-s390_process_res_acc_sch(struct res_acc_data *res_data, struct subchannel *sch)
+static int s390_process_res_acc_sch(struct res_acc_data *res_data,
+				    struct subchannel *sch)
 {
 	int found;
 	int chp;
 	int ccode;
-	
+
 	found = 0;
 	for (chp = 0; chp <= 7; chp++)
 		/*
 		 * check if chpid is in information updated by ssd
 		 */
 		if (sch->ssd_info.valid &&
-		    sch->ssd_info.chpid[chp] == res_data->chp->chpid.id &&
+		    sch->ssd_info.chpid[chp] == res_data->chpid.id &&
 		    (sch->ssd_info.fla[chp] & res_data->fla_mask)
 		    == res_data->fla) {
 			found = 1;
 			break;
 		}
-	
+
 	if (found == 0)
 		return 0;
 
@@ -416,8 +370,8 @@ s390_process_res_acc (struct res_acc_dat
 	int rc;
 	char dbf_txt[15];
 
-	sprintf(dbf_txt, "accpr%x.%02x", res_data->chp->chpid.cssid,
-		res_data->chp->chpid.id);
+	sprintf(dbf_txt, "accpr%x.%02x", res_data->chpid.cssid,
+		res_data->chpid.id);
 	CIO_TRACE_EVENT( 2, dbf_txt);
 	if (res_data->fla != 0) {
 		sprintf(dbf_txt, "fla%x", res_data->fla);
@@ -503,7 +457,7 @@ static int chsc_process_sei_link_inciden
 	else {
 		chp_id_init(&chpid);
 		chpid.id = id;
-		s390_set_chpid_offline(chpid);
+		chsc_chp_offline(chpid);
 	}
 
 	return 0;
@@ -512,7 +466,6 @@ static int chsc_process_sei_link_inciden
 static int chsc_process_sei_res_acc(struct chsc_sei_area *sei_area)
 {
 	struct res_acc_data res_data;
-	struct device *dev;
 	struct chp_id chpid;
 	int status;
 	int rc;
@@ -524,14 +477,13 @@ static int chsc_process_sei_res_acc(stru
 	chp_id_init(&chpid);
 	chpid.id = sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
-	status = get_chp_status(chpid);
+	status = chp_get_status(chpid);
 	if (status < 0)
-		new_channel_path(chpid);
+		chp_new(chpid);
 	else if (!status)
 		return 0;
-	dev = get_device(&(chpid_to_chp(chpid)->dev));
 	memset(&res_data, 0, sizeof(struct res_acc_data));
-	res_data.chp = to_channelpath(dev);
+	res_data.chpid = chpid;
 	if ((sei_area->vf & 0xc0) != 0) {
 		res_data.fla = sei_area->fla;
 		if ((sei_area->vf & 0xc0) == 0xc0)
@@ -542,7 +494,6 @@ static int chsc_process_sei_res_acc(stru
 			res_data.fla_mask = 0xff00;
 	}
 	rc = s390_process_res_acc(&res_data);
-	put_device(dev);
 
 	return rc;
 }
@@ -634,10 +585,10 @@ static int
 __chp_add(struct subchannel_id schid, void *data)
 {
 	int i, mask;
-	struct channel_path *chp;
+	struct chp_id *chpid;
 	struct subchannel *sch;
 
-	chp = data;
+	chpid = data;
 	sch = get_subchannel_by_schid(schid);
 	if (!sch)
 		/* Check if the subchannel is now available. */
@@ -646,7 +597,7 @@ __chp_add(struct subchannel_id schid, vo
 	for (i=0; i<8; i++) {
 		mask = 0x80 >> i;
 		if ((sch->schib.pmcw.pim & mask) &&
-		    (sch->schib.pmcw.chpid[i] == chp->chpid.id)) {
+		    (sch->schib.pmcw.chpid[i] == chpid->id)) {
 			if (stsch(sch->schid, &sch->schib) != 0) {
 				/* Endgame. */
 				spin_unlock_irq(sch->lock);
@@ -672,52 +623,24 @@ __chp_add(struct subchannel_id schid, vo
 	return 0;
 }
 
-static int chp_add(struct chp_id chpid)
+int chsc_chp_online(struct chp_id chpid)
 {
 	int rc;
 	char dbf_txt[15];
-	struct device *dev;
 
-	if (!get_chp_status(chpid))
-		return 0; /* no need to do the rest */
-	
 	sprintf(dbf_txt, "cadd%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	dev = get_device(&(chpid_to_chp(chpid)->dev));
-	rc = for_each_subchannel(__chp_add, to_channelpath(dev));
+	if (chp_get_status(chpid) == 0)
+		return 0;
+	rc = for_each_subchannel(__chp_add, &chpid);
 	if (css_slow_subchannels_exist())
 		rc = -EAGAIN;
 	if (rc != -EAGAIN)
 		rc = 0;
-	put_device(dev);
 	return rc;
 }
 
-/* 
- * Handling of crw machine checks with channel path source.
- */
-int chp_process_crw(int id, int on)
-{
-	struct chp_id chpid;
-
-	chp_id_init(&chpid);
-	chpid.id = id;
-	if (on == 0) {
-		/* Path has gone. We use the link incident routine.*/
-		s390_set_chpid_offline(chpid);
-		return 0; /* De-register is async anyway. */
-	}
-	/*
-	 * Path has come. Allocate a new channel path structure,
-	 * if needed.
-	 */
-	if (get_chp_status(chpid) < 0)
-		new_channel_path(chpid);
-	/* Avoid the extra overhead in process_rec_acc. */
-	return chp_add(chpid);
-}
-
 static int check_for_io_on_path(struct subchannel *sch, int index)
 {
 	int cc;
@@ -844,34 +767,13 @@ __s390_vary_chpid_on(struct subchannel_i
 	return 0;
 }
 
-/*
- * Function: s390_vary_chpid
- * Varies the specified chpid online or offline
+/**
+ * chsc_chp_vary - propagate channel-path vary operation to subchannels
+ * @chpid: channl-path ID
+ * @on: non-zero for vary online, zero for vary offline
  */
-static int s390_vary_chpid(struct chp_id chpid, int on)
+int chsc_chp_vary(struct chp_id chpid, int on)
 {
-	char dbf_text[15];
-	int status;
-
-	sprintf(dbf_text, on?"varyon%x.%02x":"varyoff%x.%02x", chpid.cssid,
-		chpid.id);
-	CIO_TRACE_EVENT( 2, dbf_text);
-
-	status = get_chp_status(chpid);
-	if (status < 0) {
-		printk(KERN_ERR "Can't vary unknown chpid %x.%02x\n",
-		       chpid.cssid, chpid.id);
-		return -EINVAL;
-	}
-
-	if (!on && !status) {
-		printk(KERN_ERR "chpid %x.%02x is already offline\n",
-		       chpid.cssid, chpid.id);
-		return -EINVAL;
-	}
-
-	set_chp_logically_online(chpid, on);
-
 	/*
 	 * Redo PathVerification on the devices the chpid connects to
 	 */
@@ -887,112 +789,6 @@ static int s390_vary_chpid(struct chp_id
 	return 0;
 }
 
-/*
- * Channel measurement related functions
- */
-static ssize_t
-chp_measurement_chars_read(struct kobject *kobj, char *buf, loff_t off,
-			   size_t count)
-{
-	struct channel_path *chp;
-	unsigned int size;
-
-	chp = to_channelpath(container_of(kobj, struct device, kobj));
-	if (!chp->cmg_chars)
-		return 0;
-
-	size = sizeof(struct cmg_chars);
-
-	if (off > size)
-		return 0;
-	if (off + count > size)
-		count = size - off;
-	memcpy(buf, chp->cmg_chars + off, count);
-	return count;
-}
-
-static struct bin_attribute chp_measurement_chars_attr = {
-	.attr = {
-		.name = "measurement_chars",
-		.mode = S_IRUSR,
-		.owner = THIS_MODULE,
-	},
-	.size = sizeof(struct cmg_chars),
-	.read = chp_measurement_chars_read,
-};
-
-static void chp_measurement_copy_block(struct cmg_entry *buf,
-			struct channel_subsystem *css, struct chp_id chpid)
-{
-	void *area;
-	struct cmg_entry *entry, reference_buf;
-	int idx;
-
-	if (chpid.id < 128) {
-		area = css->cub_addr1;
-		idx = chpid.id;
-	} else {
-		area = css->cub_addr2;
-		idx = chpid.id - 128;
-	}
-	entry = area + (idx * sizeof(struct cmg_entry));
-	do {
-		memcpy(buf, entry, sizeof(*entry));
-		memcpy(&reference_buf, entry, sizeof(*entry));
-	} while (reference_buf.values[0] != buf->values[0]);
-}
-
-static ssize_t
-chp_measurement_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	struct channel_path *chp;
-	struct channel_subsystem *css;
-	unsigned int size;
-
-	chp = to_channelpath(container_of(kobj, struct device, kobj));
-	css = to_css(chp->dev.parent);
-
-	size = sizeof(struct cmg_entry);
-
-	/* Only allow single reads. */
-	if (off || count < size)
-		return 0;
-	chp_measurement_copy_block((struct cmg_entry *)buf, css, chp->chpid);
-	count = size;
-	return count;
-}
-
-static struct bin_attribute chp_measurement_attr = {
-	.attr = {
-		.name = "measurement",
-		.mode = S_IRUSR,
-		.owner = THIS_MODULE,
-	},
-	.size = sizeof(struct cmg_entry),
-	.read = chp_measurement_read,
-};
-
-static void
-chsc_remove_chp_cmg_attr(struct channel_path *chp)
-{
-	device_remove_bin_file(&chp->dev, &chp_measurement_chars_attr);
-	device_remove_bin_file(&chp->dev, &chp_measurement_attr);
-}
-
-static int
-chsc_add_chp_cmg_attr(struct channel_path *chp)
-{
-	int ret;
-
-	ret = device_create_bin_file(&chp->dev, &chp_measurement_chars_attr);
-	if (ret)
-		return ret;
-	ret = device_create_bin_file(&chp->dev, &chp_measurement_attr);
-	if (ret)
-		device_remove_bin_file(&chp->dev, &chp_measurement_chars_attr);
-	return ret;
-}
-
 static void
 chsc_remove_cmg_attr(struct channel_subsystem *css)
 {
@@ -1001,7 +797,7 @@ chsc_remove_cmg_attr(struct channel_subs
 	for (i = 0; i <= __MAX_CHPID; i++) {
 		if (!css->chps[i])
 			continue;
-		chsc_remove_chp_cmg_attr(css->chps[i]);
+		chp_remove_cmg_attr(css->chps[i]);
 	}
 }
 
@@ -1014,7 +810,7 @@ chsc_add_cmg_attr(struct channel_subsyst
 	for (i = 0; i <= __MAX_CHPID; i++) {
 		if (!css->chps[i])
 			continue;
-		ret = chsc_add_chp_cmg_attr(css->chps[i]);
+		ret = chp_add_cmg_attr(css->chps[i]);
 		if (ret)
 			goto cleanup;
 	}
@@ -1023,12 +819,11 @@ cleanup:
 	for (--i; i >= 0; i--) {
 		if (!css->chps[i])
 			continue;
-		chsc_remove_chp_cmg_attr(css->chps[i]);
+		chp_remove_cmg_attr(css->chps[i]);
 	}
 	return ret;
 }
 
-
 static int
 __chsc_do_secm(struct channel_subsystem *css, int enable, void *page)
 {
@@ -1143,108 +938,8 @@ chsc_secm(struct channel_subsystem *css,
 	return ret;
 }
 
-/*
- * Files for the channel path entries.
- */
-static ssize_t
-chp_status_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct channel_path *chp = container_of(dev, struct channel_path, dev);
-
-	if (!chp)
-		return 0;
-	return (get_chp_status(chp->chpid) ? sprintf(buf, "online\n") :
-		sprintf(buf, "offline\n"));
-}
-
-static ssize_t
-chp_status_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct channel_path *cp = container_of(dev, struct channel_path, dev);
-	char cmd[10];
-	int num_args;
-	int error;
-
-	num_args = sscanf(buf, "%5s", cmd);
-	if (!num_args)
-		return count;
-
-	if (!strnicmp(cmd, "on", 2) || !strcmp(cmd, "1"))
-		error = s390_vary_chpid(cp->chpid, 1);
-	else if (!strnicmp(cmd, "off", 3) || !strcmp(cmd, "0"))
-		error = s390_vary_chpid(cp->chpid, 0);
-	else
-		error = -EINVAL;
-
-	return error < 0 ? error : count;
-
-}
-
-static DEVICE_ATTR(status, 0644, chp_status_show, chp_status_write);
-
-static ssize_t
-chp_type_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct channel_path *chp = container_of(dev, struct channel_path, dev);
-
-	if (!chp)
-		return 0;
-	return sprintf(buf, "%x\n", chp->desc.desc);
-}
-
-static DEVICE_ATTR(type, 0444, chp_type_show, NULL);
-
-static ssize_t
-chp_cmg_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct channel_path *chp = to_channelpath(dev);
-
-	if (!chp)
-		return 0;
-	if (chp->cmg == -1) /* channel measurements not available */
-		return sprintf(buf, "unknown\n");
-	return sprintf(buf, "%x\n", chp->cmg);
-}
-
-static DEVICE_ATTR(cmg, 0444, chp_cmg_show, NULL);
-
-static ssize_t
-chp_shared_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct channel_path *chp = to_channelpath(dev);
-
-	if (!chp)
-		return 0;
-	if (chp->shared == -1) /* channel measurements not available */
-		return sprintf(buf, "unknown\n");
-	return sprintf(buf, "%x\n", chp->shared);
-}
-
-static DEVICE_ATTR(shared, 0444, chp_shared_show, NULL);
-
-static struct attribute * chp_attrs[] = {
-	&dev_attr_status.attr,
-	&dev_attr_type.attr,
-	&dev_attr_cmg.attr,
-	&dev_attr_shared.attr,
-	NULL,
-};
-
-static struct attribute_group chp_attr_group = {
-	.attrs = chp_attrs,
-};
-
-static void
-chp_release(struct device *dev)
-{
-	struct channel_path *cp;
-	
-	cp = container_of(dev, struct channel_path, dev);
-	kfree(cp);
-}
-
-static int chsc_determine_channel_path_description(struct chp_id chpid,
-						struct channel_path_desc *desc)
+int chsc_determine_channel_path_description(struct chp_id chpid,
+					    struct channel_path_desc *desc)
 {
 	int ccode, ret;
 
@@ -1331,8 +1026,7 @@ chsc_initialize_cmg_chars(struct channel
 	}
 }
 
-static int
-chsc_get_channel_measurement_chars(struct channel_path *chp)
+int chsc_get_channel_measurement_chars(struct channel_path *chp)
 {
 	int ccode, ret;
 
@@ -1407,97 +1101,6 @@ out:
 	return ret;
 }
 
-/*
- * Entries for chpids on the system bus.
- * This replaces /proc/chpids.
- */
-static int new_channel_path(struct chp_id chpid)
-{
-	struct channel_path *chp;
-	int ret;
-
-	chp = kzalloc(sizeof(struct channel_path), GFP_KERNEL);
-	if (!chp)
-		return -ENOMEM;
-
-	/* fill in status, etc. */
-	chp->chpid = chpid;
-	chp->state = 1;
-	chp->dev.parent = &css[chpid.cssid]->device;
-	chp->dev.release = chp_release;
-	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp%x.%02x", chpid.cssid,
-		 chpid.id);
-
-	/* Obtain channel path description and fill it in. */
-	ret = chsc_determine_channel_path_description(chpid, &chp->desc);
-	if (ret)
-		goto out_free;
-	/* Get channel-measurement characteristics. */
-	if (css_characteristics_avail && css_chsc_characteristics.scmc
-	    && css_chsc_characteristics.secm) {
-		ret = chsc_get_channel_measurement_chars(chp);
-		if (ret)
-			goto out_free;
-	} else {
-		static int msg_done;
-
-		if (!msg_done) {
-			printk(KERN_WARNING "cio: Channel measurements not "
-			       "available, continuing.\n");
-			msg_done = 1;
-		}
-		chp->cmg = -1;
-	}
-
-	/* make it known to the system */
-	ret = device_register(&chp->dev);
-	if (ret) {
-		printk(KERN_WARNING "%s: could not register %x.%02x\n",
-		       __func__, chpid.cssid, chpid.id);
-		goto out_free;
-	}
-	ret = sysfs_create_group(&chp->dev.kobj, &chp_attr_group);
-	if (ret) {
-		device_unregister(&chp->dev);
-		goto out_free;
-	}
-	mutex_lock(&css[chpid.cssid]->mutex);
-	if (css[chpid.cssid]->cm_enabled) {
-		ret = chsc_add_chp_cmg_attr(chp);
-		if (ret) {
-			sysfs_remove_group(&chp->dev.kobj, &chp_attr_group);
-			device_unregister(&chp->dev);
-			mutex_unlock(&css[chpid.cssid]->mutex);
-			goto out_free;
-		}
-	}
-	css[chpid.cssid]->chps[chpid.id] = chp;
-	mutex_unlock(&css[chpid.cssid]->mutex);
-	return ret;
-out_free:
-	kfree(chp);
-	return ret;
-}
-
-void *
-chsc_get_chp_desc(struct subchannel *sch, int chp_no)
-{
-	struct channel_path *chp;
-	struct channel_path_desc *desc;
-	struct chp_id chpid;
-
-	chp_id_init(&chpid);
-	chpid.id = sch->schib.pmcw.chpid[chp_no];
-	chp = chpid_to_chp(chpid);
-	if (!chp)
-		return NULL;
-	desc = kmalloc(sizeof(struct channel_path_desc), GFP_KERNEL);
-	if (!desc)
-		return NULL;
-	memcpy(desc, &chp->desc, sizeof(struct channel_path_desc));
-	return desc;
-}
-
 static int __init
 chsc_alloc_sei_area(void)
 {
diff -urpN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-patched/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	2007-03-19 13:09:34.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.h	2007-03-19 13:09:38.000000000 +0100
@@ -5,10 +5,6 @@
 #include <linux/device.h>
 #include "chpid.h"
 
-#define CHSC_SEI_ACC_CHPID        1
-#define CHSC_SEI_ACC_LINKADDR     2
-#define CHSC_SEI_ACC_FULLLINKADDR 3
-
 #define CHSC_SDA_OC_MSS   0x2
 
 struct chsc_header {
@@ -37,23 +33,10 @@ struct channel_path_desc {
 	u8 chpp;
 } __attribute__ ((packed));
 
-struct channel_path {
-	struct chp_id chpid;
-	int state;
-	struct channel_path_desc desc;
-	/* Channel-measurement related stuff: */
-	int cmg;
-	int shared;
-	void *cmg_chars;
-	struct device dev;
-};
-
-extern void s390_process_css( void );
-extern void chsc_validate_chpids(struct subchannel *);
-extern void chpid_is_actually_online(struct chp_id);
+struct channel_path;
+
 extern int css_get_ssd_info(struct subchannel *);
 extern int chsc_process_crw(void);
-extern int chp_process_crw(int, int);
 
 struct css_general_char {
 	u64 : 41;
@@ -89,12 +72,15 @@ extern struct css_chsc_char css_chsc_cha
 extern int chsc_determine_css_characteristics(void);
 extern int css_characteristics_avail;
 
-extern void *chsc_get_chp_desc(struct subchannel*, int);
-
 extern int chsc_enable_facility(int);
 struct channel_subsystem;
 extern int chsc_secm(struct channel_subsystem *, int);
 
-#define to_channelpath(device) container_of(device, struct channel_path, dev)
+int chsc_chp_vary(struct chp_id chpid, int on);
+int chsc_determine_channel_path_description(struct chp_id chpid,
+					    struct channel_path_desc *desc);
+int chsc_chp_online(struct chp_id chpid);
+void chsc_chp_offline(struct chp_id chpid);
+int chsc_get_channel_measurement_chars(struct channel_path *chp);
 
 #endif
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2007-03-19 13:09:34.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2007-03-19 13:09:38.000000000 +0100
@@ -29,6 +29,7 @@
 #include "ioasm.h"
 #include "blacklist.h"
 #include "cio_debug.h"
+#include "chp.h"
 #include "../s390mach.h"
 
 debug_info_t *cio_debug_msg_id;
@@ -592,9 +593,10 @@ cio_validate_subchannel (struct subchann
 		err = -ENODEV;
 		goto out;
 	}
-	sch->opm = 0xff;
-	if (!cio_is_console(sch->schid))
-		chsc_validate_chpids(sch);
+	if (cio_is_console(sch->schid))
+		sch->opm = 0xff;
+	else
+		sch->opm = chp_get_sch_opm(sch);
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 
 	CIO_DEBUG(KERN_INFO, 0,
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2007-03-19 13:09:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2007-03-19 13:09:38.000000000 +0100
@@ -4,6 +4,7 @@
 #include <linux/mutex.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 
 #include <asm/cio.h>
 
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2007-03-19 13:09:34.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2007-03-19 13:09:38.000000000 +0100
@@ -23,6 +23,7 @@
 #include "chsc.h"
 #include "ioasm.h"
 #include "chpid.h"
+#include "chp.h"
 
 int
 device_is_online(struct subchannel *sch)
@@ -221,7 +222,10 @@ __recover_lost_chpids(struct subchannel 
 		if (old_lpm & mask)
 			continue;
 		chpid.id = sch->schib.pmcw.chpid[i];
-		chpid_is_actually_online(chpid);
+		if (!chp_is_registered(chpid)) {
+			need_rescan = 1;
+			queue_work(slow_path_wq, &slow_path_work);
+		}
 	}
 }
 
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2007-03-19 13:09:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2007-03-19 13:09:38.000000000 +0100
@@ -22,6 +22,8 @@
 #include "css.h"
 #include "chsc.h"
 #include "device.h"
+#include "chpid.h"
+#include "chp.h"
 
 int ccw_device_set_options_mask(struct ccw_device *cdev, unsigned long flags)
 {
@@ -606,9 +608,12 @@ void *
 ccw_device_get_chp_desc(struct ccw_device *cdev, int chp_no)
 {
 	struct subchannel *sch;
+	struct chp_id chpid;
 
 	sch = to_subchannel(cdev->dev.parent);
-	return chsc_get_chp_desc(sch, chp_no);
+	chp_id_init(&chpid);
+	chpid.id = sch->schib.pmcw.chpid[chp_no];
+	return chp_get_chp_desc(chpid);
 }
 
 // FIXME: these have to go:
diff -urpN linux-2.6/drivers/s390/cio/Makefile linux-2.6-patched/drivers/s390/cio/Makefile
--- linux-2.6/drivers/s390/cio/Makefile	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/Makefile	2007-03-19 13:09:38.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for the S/390 common i/o drivers
 #
 
-obj-y += airq.o blacklist.o chsc.o cio.o css.o
+obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2007-03-19 13:09:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390mach.c	2007-03-19 13:09:38.000000000 +0100
@@ -21,6 +21,7 @@
 #include "cio/cio.h"
 #include "cio/chsc.h"
 #include "cio/css.h"
+#include "cio/chp.h"
 #include "s390mach.h"
 
 static struct semaphore m_sem;
