Return-Path: <linux-kernel-owner+w=401wt.eu-S1755908AbXD0OPw@vger.kernel.org>
Message-Id: <20070427140513.601303117@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/38] cio: Channel-path configure function.
Content-Disposition: inline; filename=106-cio-chp-configure.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Add a new attribute to the channel-path sysfs directory through which
channel-path configure operations can be triggered. Also listen for
hardware events requesting channel-path configure operations and
process them accordingly.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/char/Makefile    |    2 
 drivers/s390/char/sclp_chp.c  |  196 ++++++++++++++++++++++++++++++++
 drivers/s390/cio/chp.c        |  250 +++++++++++++++++++++++++++++++++++++++++-
 drivers/s390/cio/chp.h        |   20 +++
 drivers/s390/cio/chpid.h      |   51 --------
 drivers/s390/cio/chsc.c       |   44 +++++++
 drivers/s390/cio/chsc.h       |    2 
 drivers/s390/cio/cio.c        |    1 
 drivers/s390/cio/cio.h        |    1 
 drivers/s390/cio/css.h        |    4 
 drivers/s390/cio/device_fsm.c |    2 
 drivers/s390/cio/device_ops.c |    2 
 drivers/s390/cio/ioasm.h      |    2 
 include/asm-s390/chpid.h      |   53 ++++++++
 include/asm-s390/cio.h        |    1 
 include/asm-s390/sclp.h       |   12 ++
 16 files changed, 581 insertions(+), 62 deletions(-)

Index: quilt-2.6/drivers/s390/char/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/char/Makefile	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/Makefile	2007-04-27 16:04:54.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce.o \
-	 sclp_info.o
+	 sclp_info.o sclp_chp.o
 
 obj-$(CONFIG_TN3270) += raw3270.o
 obj-$(CONFIG_TN3270_CONSOLE) += con3270.o
Index: quilt-2.6/drivers/s390/char/sclp_chp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/char/sclp_chp.c	2007-04-27 16:04:54.000000000 +0200
@@ -0,0 +1,196 @@
+/*
+ *  drivers/s390/char/sclp_chp.c
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/gfp.h>
+#include <linux/errno.h>
+#include <linux/completion.h>
+#include <asm/sclp.h>
+#include <asm/chpid.h>
+
+#include "sclp.h"
+
+#define TAG	"sclp_chp: "
+
+#define SCLP_CMDW_CONFIGURE_CHANNEL_PATH	0x000f0001
+#define SCLP_CMDW_DECONFIGURE_CHANNEL_PATH	0x000e0001
+#define SCLP_CMDW_READ_CHANNEL_PATH_INFORMATION	0x00030001
+
+static inline sclp_cmdw_t get_configure_cmdw(struct chp_id chpid)
+{
+	return SCLP_CMDW_CONFIGURE_CHANNEL_PATH | chpid.id << 8;
+}
+
+static inline sclp_cmdw_t get_deconfigure_cmdw(struct chp_id chpid)
+{
+	return SCLP_CMDW_DECONFIGURE_CHANNEL_PATH | chpid.id << 8;
+}
+
+static void chp_callback(struct sclp_req *req, void *data)
+{
+	struct completion *completion = data;
+
+	complete(completion);
+}
+
+struct chp_cfg_sccb {
+	struct sccb_header header;
+	u8 ccm;
+	u8 reserved[6];
+	u8 cssid;
+} __attribute__((packed));
+
+struct chp_cfg_data {
+	struct chp_cfg_sccb sccb;
+	struct sclp_req req;
+	struct completion completion;
+} __attribute__((packed));
+
+static int do_configure(sclp_cmdw_t cmd)
+{
+	struct chp_cfg_data *data;
+	int rc;
+
+	/* Prepare sccb. */
+	data = (struct chp_cfg_data *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!data)
+		return -ENOMEM;
+	data->sccb.header.length = sizeof(struct chp_cfg_sccb);
+	data->req.command = cmd;
+	data->req.sccb = &(data->sccb);
+	data->req.status = SCLP_REQ_FILLED;
+	data->req.callback = chp_callback;
+	data->req.callback_data = &(data->completion);
+	init_completion(&data->completion);
+
+	/* Perform sclp request. */
+	rc = sclp_add_request(&(data->req));
+	if (rc)
+		goto out;
+	wait_for_completion(&data->completion);
+
+	/* Check response .*/
+	if (data->req.status != SCLP_REQ_DONE) {
+		printk(KERN_WARNING TAG "configure channel-path request failed "
+		       "(status=0x%02x)\n", data->req.status);
+		rc = -EIO;
+		goto out;
+	}
+	switch (data->sccb.header.response_code) {
+	case 0x0020:
+	case 0x0120:
+	case 0x0440:
+	case 0x0450:
+		break;
+	default:
+		printk(KERN_WARNING TAG "configure channel-path failed "
+		       "(cmd=0x%08x, response=0x%04x)\n", cmd,
+		       data->sccb.header.response_code);
+		rc = -EIO;
+		break;
+	}
+out:
+	free_page((unsigned long) data);
+
+	return rc;
+}
+
+/**
+ * sclp_chp_configure - perform configure channel-path sclp command
+ * @chpid: channel-path ID
+ *
+ * Perform configure channel-path command sclp command for specified chpid.
+ * Return 0 after command successfully finished, non-zero otherwise.
+ */
+int sclp_chp_configure(struct chp_id chpid)
+{
+	return do_configure(get_configure_cmdw(chpid));
+}
+
+/**
+ * sclp_chp_deconfigure - perform deconfigure channel-path sclp command
+ * @chpid: channel-path ID
+ *
+ * Perform deconfigure channel-path command sclp command for specified chpid
+ * and wait for completion. On success return 0. Return non-zero otherwise.
+ */
+int sclp_chp_deconfigure(struct chp_id chpid)
+{
+	return do_configure(get_deconfigure_cmdw(chpid));
+}
+
+struct chp_info_sccb {
+	struct sccb_header header;
+	u8 recognized[SCLP_CHP_INFO_MASK_SIZE];
+	u8 standby[SCLP_CHP_INFO_MASK_SIZE];
+	u8 configured[SCLP_CHP_INFO_MASK_SIZE];
+	u8 ccm;
+	u8 reserved[6];
+	u8 cssid;
+} __attribute__((packed));
+
+struct chp_info_data {
+	struct chp_info_sccb sccb;
+	struct sclp_req req;
+	struct completion completion;
+} __attribute__((packed));
+
+/**
+ * sclp_chp_read_info - perform read channel-path information sclp command
+ * @info: resulting channel-path information data
+ *
+ * Perform read channel-path information sclp command and wait for completion.
+ * On success, store channel-path information in @info and return 0. Return
+ * non-zero otherwise.
+ */
+int sclp_chp_read_info(struct sclp_chp_info *info)
+{
+	struct chp_info_data *data;
+	int rc;
+
+	/* Prepare sccb. */
+	data = (struct chp_info_data *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!data)
+		return -ENOMEM;
+	data->sccb.header.length = sizeof(struct chp_info_sccb);
+	data->req.command = SCLP_CMDW_READ_CHANNEL_PATH_INFORMATION;
+	data->req.sccb = &(data->sccb);
+	data->req.status = SCLP_REQ_FILLED;
+	data->req.callback = chp_callback;
+	data->req.callback_data = &(data->completion);
+	init_completion(&data->completion);
+
+	/* Perform sclp request. */
+	rc = sclp_add_request(&(data->req));
+	if (rc)
+		goto out;
+	wait_for_completion(&data->completion);
+
+	/* Check response .*/
+	if (data->req.status != SCLP_REQ_DONE) {
+		printk(KERN_WARNING TAG "read channel-path info request failed "
+		       "(status=0x%02x)\n", data->req.status);
+		rc = -EIO;
+		goto out;
+	}
+	if (data->sccb.header.response_code != 0x0010) {
+		printk(KERN_WARNING TAG "read channel-path info failed "
+		       "(response=0x%04x)\n", data->sccb.header.response_code);
+		rc = -EIO;
+		goto out;
+	}
+	memcpy(info->recognized, data->sccb.recognized,
+	       SCLP_CHP_INFO_MASK_SIZE);
+	memcpy(info->standby, data->sccb.standby,
+	       SCLP_CHP_INFO_MASK_SIZE);
+	memcpy(info->configured, data->sccb.configured,
+	       SCLP_CHP_INFO_MASK_SIZE);
+out:
+	free_page((unsigned long) data);
+
+	return rc;
+}
Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chp.c	2007-04-27 16:04:54.000000000 +0200
@@ -10,9 +10,14 @@
 #include <linux/bug.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/wait.h>
+#include <linux/mutex.h>
 #include <asm/errno.h>
+#include <asm/chpid.h>
+#include <asm/sclp.h>
 
-#include "chpid.h"
 #include "cio.h"
 #include "css.h"
 #include "ioasm.h"
@@ -20,6 +25,32 @@
 #include "chp.h"
 
 #define to_channelpath(device) container_of(device, struct channel_path, dev)
+#define CHP_INFO_UPDATE_INTERVAL	1*HZ
+
+enum cfg_task_t {
+	cfg_none,
+	cfg_configure,
+	cfg_deconfigure
+};
+
+/* Map for pending configure tasks. */
+static enum cfg_task_t chp_cfg_task[__MAX_CSSID + 1][__MAX_CHPID + 1];
+static DEFINE_MUTEX(cfg_lock);
+static int cfg_busy;
+
+/* Map for channel-path status. */
+static struct sclp_chp_info chp_info;
+static DEFINE_MUTEX(info_lock);
+
+/* Time after which channel-path status may be outdated. */
+static unsigned long chp_info_expires;
+
+/* Workqueue to perform pending configure tasks. */
+static struct workqueue_struct *chp_wq;
+static struct work_struct cfg_work;
+
+/* Wait queue for configure completion events. */
+static wait_queue_head_t cfg_wait_queue;
 
 /* Return channel_path struct for given chpid. */
 static inline struct channel_path *chpid_to_chp(struct chp_id chpid)
@@ -251,6 +282,43 @@
 
 static DEVICE_ATTR(status, 0644, chp_status_show, chp_status_write);
 
+static ssize_t chp_configure_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct channel_path *cp;
+	int status;
+
+	cp = container_of(dev, struct channel_path, dev);
+	status = chp_info_get_status(cp->chpid);
+	if (status < 0)
+		return status;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+}
+
+static int cfg_wait_idle(void);
+
+static ssize_t chp_configure_write(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct channel_path *cp;
+	int val;
+	char delim;
+
+	if (sscanf(buf, "%d %c", &val, &delim) != 1)
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+	cp = container_of(dev, struct channel_path, dev);
+	chp_cfg_schedule(cp->chpid, val);
+	cfg_wait_idle();
+
+	return count;
+}
+
+static DEVICE_ATTR(configure, 0644, chp_configure_show, chp_configure_write);
+
 static ssize_t chp_type_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -293,6 +361,7 @@
 
 static struct attribute * chp_attrs[] = {
 	&dev_attr_status.attr,
+	&dev_attr_configure.attr,
 	&dev_attr_type.attr,
 	&dev_attr_cmg.attr,
 	&dev_attr_shared.attr,
@@ -323,6 +392,8 @@
 	struct channel_path *chp;
 	int ret;
 
+	if (chp_is_registered(chpid))
+		return 0;
 	chp = kzalloc(sizeof(struct channel_path), GFP_KERNEL);
 	if (!chp)
 		return -ENOMEM;
@@ -435,3 +506,180 @@
 		return 0;
 	}
 }
+
+static inline int info_bit_num(struct chp_id id)
+{
+	return id.id + id.cssid * (__MAX_CHPID + 1);
+}
+
+/* Force chp_info refresh on next call to info_validate(). */
+static void info_expire(void)
+{
+	mutex_lock(&info_lock);
+	chp_info_expires = jiffies - 1;
+	mutex_unlock(&info_lock);
+}
+
+/* Ensure that chp_info is up-to-date. */
+static int info_update(void)
+{
+	int rc;
+
+	mutex_lock(&info_lock);
+	rc = 0;
+	if (time_after(jiffies, chp_info_expires)) {
+		/* Data is too old, update. */
+		rc = sclp_chp_read_info(&chp_info);
+		chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL ;
+	}
+	mutex_unlock(&info_lock);
+
+	return rc;
+}
+
+/**
+ * chp_info_get_status - retrieve configure status of a channel-path
+ * @chpid: channel-path ID
+ *
+ * On success, return 0 for standby, 1 for configured, 2 for reserved,
+ * 3 for not recognized. Return negative error code on error.
+ */
+int chp_info_get_status(struct chp_id chpid)
+{
+	int rc;
+	int bit;
+
+	rc = info_update();
+	if (rc)
+		return rc;
+
+	bit = info_bit_num(chpid);
+	mutex_lock(&info_lock);
+	if (!chp_test_bit(chp_info.recognized, bit))
+		rc = CHP_STATUS_NOT_RECOGNIZED;
+	else if (chp_test_bit(chp_info.configured, bit))
+		rc = CHP_STATUS_CONFIGURED;
+	else if (chp_test_bit(chp_info.standby, bit))
+		rc = CHP_STATUS_STANDBY;
+	else
+		rc = CHP_STATUS_RESERVED;
+	mutex_unlock(&info_lock);
+
+	return rc;
+}
+
+/* Return configure task for chpid. */
+static enum cfg_task_t cfg_get_task(struct chp_id chpid)
+{
+	return chp_cfg_task[chpid.cssid][chpid.id];
+}
+
+/* Set configure task for chpid. */
+static void cfg_set_task(struct chp_id chpid, enum cfg_task_t cfg)
+{
+	chp_cfg_task[chpid.cssid][chpid.id] = cfg;
+}
+
+/* Perform one configure/deconfigure request. Reschedule work function until
+ * last request. */
+static void cfg_func(struct work_struct *work)
+{
+	struct chp_id chpid;
+	enum cfg_task_t t;
+
+	mutex_lock(&cfg_lock);
+	t = cfg_none;
+	chp_id_for_each(&chpid) {
+		t = cfg_get_task(chpid);
+		if (t != cfg_none) {
+			cfg_set_task(chpid, cfg_none);
+			break;
+		}
+	}
+	mutex_unlock(&cfg_lock);
+
+	switch (t) {
+	case cfg_configure:
+		sclp_chp_configure(chpid);
+		info_expire();
+		chsc_chp_online(chpid);
+		break;
+	case cfg_deconfigure:
+		sclp_chp_deconfigure(chpid);
+		info_expire();
+		chsc_chp_offline(chpid);
+		break;
+	case cfg_none:
+		/* Get updated information after last change. */
+		info_update();
+		mutex_lock(&cfg_lock);
+		cfg_busy = 0;
+		mutex_unlock(&cfg_lock);
+		wake_up_interruptible(&cfg_wait_queue);
+		return;
+	}
+	queue_work(chp_wq, &cfg_work);
+}
+
+/**
+ * chp_cfg_schedule - schedule chpid configuration request
+ * @chpid - channel-path ID
+ * @configure - Non-zero for configure, zero for deconfigure
+ *
+ * Schedule a channel-path configuration/deconfiguration request.
+ */
+void chp_cfg_schedule(struct chp_id chpid, int configure)
+{
+	CIO_MSG_EVENT(2, "chp_cfg_sched%x.%02x=%d\n", chpid.cssid, chpid.id,
+		      configure);
+	mutex_lock(&cfg_lock);
+	cfg_set_task(chpid, configure ? cfg_configure : cfg_deconfigure);
+	cfg_busy = 1;
+	mutex_unlock(&cfg_lock);
+	queue_work(chp_wq, &cfg_work);
+}
+
+/**
+ * chp_cfg_cancel_deconfigure - cancel chpid deconfiguration request
+ * @chpid - channel-path ID
+ *
+ * Cancel an active channel-path deconfiguration request if it has not yet
+ * been performed.
+ */
+void chp_cfg_cancel_deconfigure(struct chp_id chpid)
+{
+	CIO_MSG_EVENT(2, "chp_cfg_cancel:%x.%02x\n", chpid.cssid, chpid.id);
+	mutex_lock(&cfg_lock);
+	if (cfg_get_task(chpid) == cfg_deconfigure)
+		cfg_set_task(chpid, cfg_none);
+	mutex_unlock(&cfg_lock);
+}
+
+static int cfg_wait_idle(void)
+{
+	if (wait_event_interruptible(cfg_wait_queue, !cfg_busy))
+		return -ERESTARTSYS;
+	return 0;
+}
+
+static int __init chp_init(void)
+{
+	struct chp_id chpid;
+
+	chp_wq = create_singlethread_workqueue("cio_chp");
+	if (!chp_wq)
+		return -ENOMEM;
+	INIT_WORK(&cfg_work, cfg_func);
+	init_waitqueue_head(&cfg_wait_queue);
+	if (info_update())
+		return 0;
+	/* Register available channel-paths. */
+	chp_id_for_each(&chpid) {
+		if (chp_info_get_status(chpid) != CHP_STATUS_NOT_RECOGNIZED)
+			chp_new(chpid);
+	}
+
+	return 0;
+}
+
+subsys_initcall(chp_init);
Index: quilt-2.6/drivers/s390/cio/chp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.h	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chp.h	2007-04-27 16:04:54.000000000 +0200
@@ -10,10 +10,23 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
-
-#include "chpid.h"
+#include <asm/chpid.h>
 #include "chsc.h"
 
+#define CHP_STATUS_STANDBY		0
+#define CHP_STATUS_CONFIGURED		1
+#define CHP_STATUS_RESERVED		2
+#define CHP_STATUS_NOT_RECOGNIZED	3
+
+static inline int chp_test_bit(u8 *bitmap, int num)
+{
+	int byte = num >> 3;
+	int mask = 128 >> (num & 7);
+
+	return (bitmap[byte] & mask) ? 1 : 0;
+}
+
+
 struct channel_path {
 	struct chp_id chpid;
 	int state;
@@ -33,5 +46,8 @@
 void chp_remove_cmg_attr(struct channel_path *chp);
 int chp_add_cmg_attr(struct channel_path *chp);
 int chp_new(struct chp_id chpid);
+void chp_cfg_schedule(struct chp_id chpid, int configure);
+void chp_cfg_cancel_deconfigure(struct chp_id chpid);
+int chp_info_get_status(struct chp_id chpid);
 
 #endif /* S390_CHP_H */
Index: quilt-2.6/drivers/s390/cio/chpid.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chpid.h	2007-04-27 16:04:52.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,51 +0,0 @@
-/*
- *  drivers/s390/cio/chpid.h
- *
- *    Copyright IBM Corp. 2007
- *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
- */
-
-#ifndef S390_CHP_ID_H
-#define S390_CHP_ID_H S390_CHP_ID_H
-
-#include <linux/string.h>
-#include <asm/types.h>
-#include "css.h"
-
-struct chp_id {
-	u8 reserved1;
-	u8 cssid;
-	u8 reserved2;
-	u8 id;
-} __attribute__((packed));
-
-static inline void chp_id_init(struct chp_id *chpid)
-{
-	memset(chpid, 0, sizeof(struct chp_id));
-}
-
-static inline int chp_id_is_equal(struct chp_id *a, struct chp_id *b)
-{
-	return (a->id == b->id) && (a->cssid == b->cssid);
-}
-
-static inline void chp_id_next(struct chp_id *chpid)
-{
-	if (chpid->id < __MAX_CHPID)
-		chpid->id++;
-	else {
-		chpid->id = 0;
-		chpid->cssid++;
-	}
-}
-
-static inline int chp_id_is_valid(struct chp_id *chpid)
-{
-	return (chpid->cssid <= __MAX_CSSID);
-}
-
-
-#define chp_id_for_each(c) \
-	for (chp_id_init(c); chp_id_is_valid(c); chp_id_next(c))
-
-#endif /* S390_CHP_ID_H */
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.c	2007-04-27 16:04:54.000000000 +0200
@@ -15,12 +15,12 @@
 #include <linux/device.h>
 
 #include <asm/cio.h>
+#include <asm/chpid.h>
 
 #include "css.h"
 #include "cio.h"
 #include "cio_debug.h"
 #include "ioasm.h"
-#include "chpid.h"
 #include "chp.h"
 #include "chsc.h"
 
@@ -498,6 +498,45 @@
 	return rc;
 }
 
+struct chp_config_data {
+	u8 map[32];
+	u8 op;
+	u8 pc;
+};
+
+static int chsc_process_sei_chp_config(struct chsc_sei_area *sei_area)
+{
+	struct chp_config_data *data;
+	struct chp_id chpid;
+	int num;
+
+	CIO_CRW_EVENT(4, "chsc: channel-path-configuration notification\n");
+	if (sei_area->rs != 0)
+		return 0;
+	data = (struct chp_config_data *) &(sei_area->ccdf);
+	chp_id_init(&chpid);
+	for (num = 0; num <= __MAX_CHPID; num++) {
+		if (!chp_test_bit(data->map, num))
+			continue;
+		chpid.id = num;
+		printk(KERN_WARNING "cio: processing configure event %d for "
+		       "chpid %x.%02x\n", data->op, chpid.cssid, chpid.id);
+		switch (data->op) {
+		case 0:
+			chp_cfg_schedule(chpid, 1);
+			break;
+		case 1:
+			chp_cfg_schedule(chpid, 0);
+			break;
+		case 2:
+			chp_cfg_cancel_deconfigure(chpid);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int chsc_process_sei(struct chsc_sei_area *sei_area)
 {
 	int rc;
@@ -514,6 +553,9 @@
 	case 2: /* i/o resource accessibiliy */
 		rc = chsc_process_sei_res_acc(sei_area);
 		break;
+	case 8: /* channel-path-configuration notification */
+		rc = chsc_process_sei_chp_config(sei_area);
+		break;
 	default: /* other stuff */
 		CIO_CRW_EVENT(4, "chsc: unhandled sei content code %d\n",
 			      sei_area->cc);
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.h	2007-04-27 16:04:54.000000000 +0200
@@ -3,7 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
-#include "chpid.h"
+#include <asm/chpid.h>
 
 #define CHSC_SDA_OC_MSS   0x2
 
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/cio.c	2007-04-27 16:04:54.000000000 +0200
@@ -22,6 +22,7 @@
 #include <asm/setup.h>
 #include <asm/reset.h>
 #include <asm/ipl.h>
+#include <asm/chpid.h>
 #include "airq.h"
 #include "cio.h"
 #include "css.h"
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/cio.h	2007-04-27 16:04:54.000000000 +0200
@@ -3,6 +3,7 @@
 
 #include "schid.h"
 #include <linux/mutex.h>
+#include <linux/device.h>
 
 /*
  * where we put the ssd info
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/css.h	2007-04-27 16:04:54.000000000 +0200
@@ -5,8 +5,10 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
+#include <linux/types.h>
 
 #include <asm/cio.h>
+#include <asm/chpid.h>
 
 #include "schid.h"
 
@@ -149,8 +151,6 @@
 
 #define __MAX_SUBCHANNEL 65535
 #define __MAX_SSID 3
-#define __MAX_CHPID 255
-#define __MAX_CSSID 0
 
 struct channel_subsystem {
 	u8 cssid;
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:54.000000000 +0200
@@ -15,6 +15,7 @@
 
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
+#include <asm/chpid.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -22,7 +23,6 @@
 #include "device.h"
 #include "chsc.h"
 #include "ioasm.h"
-#include "chpid.h"
 #include "chp.h"
 
 int
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c	2007-04-27 16:04:53.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device_ops.c	2007-04-27 16:04:54.000000000 +0200
@@ -16,13 +16,13 @@
 
 #include <asm/ccwdev.h>
 #include <asm/idals.h>
+#include <asm/chpid.h>
 
 #include "cio.h"
 #include "cio_debug.h"
 #include "css.h"
 #include "chsc.h"
 #include "device.h"
-#include "chpid.h"
 #include "chp.h"
 
 int ccw_device_set_options_mask(struct ccw_device *cdev, unsigned long flags)
Index: quilt-2.6/drivers/s390/cio/ioasm.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ioasm.h	2007-04-27 16:04:52.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/ioasm.h	2007-04-27 16:04:54.000000000 +0200
@@ -1,8 +1,8 @@
 #ifndef S390_CIO_IOASM_H
 #define S390_CIO_IOASM_H
 
+#include <asm/chpid.h>
 #include "schid.h"
-#include "chpid.h"
 
 /*
  * TPI info structure
Index: quilt-2.6/include/asm-s390/chpid.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/include/asm-s390/chpid.h	2007-04-27 16:04:54.000000000 +0200
@@ -0,0 +1,53 @@
+/*
+ *  drivers/s390/cio/chpid.h
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_CHPID_H
+#define _ASM_S390_CHPID_H _ASM_S390_CHPID_H
+
+#include <linux/string.h>
+#include <asm/types.h>
+#include <asm/cio.h>
+
+#define __MAX_CHPID 255
+
+struct chp_id {
+	u8 reserved1;
+	u8 cssid;
+	u8 reserved2;
+	u8 id;
+} __attribute__((packed));
+
+static inline void chp_id_init(struct chp_id *chpid)
+{
+	memset(chpid, 0, sizeof(struct chp_id));
+}
+
+static inline int chp_id_is_equal(struct chp_id *a, struct chp_id *b)
+{
+	return (a->id == b->id) && (a->cssid == b->cssid);
+}
+
+static inline void chp_id_next(struct chp_id *chpid)
+{
+	if (chpid->id < __MAX_CHPID)
+		chpid->id++;
+	else {
+		chpid->id = 0;
+		chpid->cssid++;
+	}
+}
+
+static inline int chp_id_is_valid(struct chp_id *chpid)
+{
+	return (chpid->cssid <= __MAX_CSSID);
+}
+
+
+#define chp_id_for_each(c) \
+	for (chp_id_init(c); chp_id_is_valid(c); chp_id_next(c))
+
+#endif /* _ASM_S390_CHPID_H */
Index: quilt-2.6/include/asm-s390/cio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cio.h	2007-04-27 16:04:52.000000000 +0200
+++ quilt-2.6/include/asm-s390/cio.h	2007-04-27 16:04:54.000000000 +0200
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 
 #define LPM_ANYPATH 0xff
+#define __MAX_CSSID 0
 
 /*
  * subchannel status word
Index: quilt-2.6/include/asm-s390/sclp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/sclp.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/sclp.h	2007-04-27 16:04:54.000000000 +0200
@@ -9,6 +9,7 @@
 #define _ASM_S390_SCLP_H
 
 #include <linux/types.h>
+#include <asm/chpid.h>
 
 struct sccb_header {
 	u16	length;
@@ -33,7 +34,18 @@
 	u8	_reserved3[4096 - 112];	/* 112-4095 */
 } __attribute__((packed, aligned(4096)));
 
+#define SCLP_CHP_INFO_MASK_SIZE		32
+
+struct sclp_chp_info {
+	u8 recognized[SCLP_CHP_INFO_MASK_SIZE];
+	u8 standby[SCLP_CHP_INFO_MASK_SIZE];
+	u8 configured[SCLP_CHP_INFO_MASK_SIZE];
+};
+
 extern struct sclp_readinfo_sccb s390_readinfo_sccb;
 extern void sclp_readinfo_early(void);
+extern int sclp_chp_configure(struct chp_id chpid);
+extern int sclp_chp_deconfigure(struct chp_id chpid);
+extern int sclp_chp_read_info(struct sclp_chp_info *info);
 
 #endif /* _ASM_S390_SCLP_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
