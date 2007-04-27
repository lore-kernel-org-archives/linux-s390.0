Return-Path: <linux-kernel-owner+w=401wt.eu-S1755900AbXD0OPz@vger.kernel.org>
Message-Id: <20070427140512.389264958@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/38] cio: Introduce struct chp_id.
Content-Disposition: inline; filename=101-cio-chpid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Introduce data type for channel-path IDs. 

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/chpid.h      |   51 ++++++++++++
 drivers/s390/cio/chsc.c       |  178 +++++++++++++++++++++++-------------------
 drivers/s390/cio/chsc.h       |    8 +
 drivers/s390/cio/cio.c        |    5 -
 drivers/s390/cio/device_fsm.c |    6 +
 drivers/s390/cio/ioasm.h      |    5 -
 6 files changed, 167 insertions(+), 86 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chpid.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/cio/chpid.h	2007-04-27 16:04:52.000000000 +0200
@@ -0,0 +1,51 @@
+/*
+ *  drivers/s390/cio/chpid.h
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#ifndef S390_CHP_ID_H
+#define S390_CHP_ID_H S390_CHP_ID_H
+
+#include <linux/string.h>
+#include <asm/types.h>
+#include "css.h"
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
+#endif /* S390_CHP_ID_H */
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.c	2007-04-27 16:04:52.000000000 +0200
@@ -20,43 +20,48 @@
 #include "cio.h"
 #include "cio_debug.h"
 #include "ioasm.h"
+#include "chpid.h"
 #include "chsc.h"
 
 static void *sei_page;
 
-static int new_channel_path(int chpid);
+static int new_channel_path(struct chp_id chpid);
 
-static inline void
-set_chp_logically_online(int chp, int onoff)
+static inline struct channel_path *chpid_to_chp(struct chp_id chpid)
 {
-	css[0]->chps[chp]->state = onoff;
+	return css[chpid.cssid]->chps[chpid.id];
 }
 
-static int
-get_chp_status(int chp)
+static void set_chp_logically_online(struct chp_id chpid, int onoff)
 {
-	return (css[0]->chps[chp] ? css[0]->chps[chp]->state : -ENODEV);
+	chpid_to_chp(chpid)->state = onoff;
 }
 
-void
-chsc_validate_chpids(struct subchannel *sch)
+static int get_chp_status(struct chp_id chpid)
+{
+	return (chpid_to_chp(chpid) ? chpid_to_chp(chpid)->state : -ENODEV);
+}
+
+void chsc_validate_chpids(struct subchannel *sch)
 {
 	int mask, chp;
+	struct chp_id chpid;
 
+	chp_id_init(&chpid);
 	for (chp = 0; chp <= 7; chp++) {
 		mask = 0x80 >> chp;
-		if (!get_chp_status(sch->schib.pmcw.chpid[chp]))
+		chpid.id = sch->schib.pmcw.chpid[chp];
+		if (!get_chp_status(chpid))
 			/* disable using this path */
 			sch->opm &= ~mask;
 	}
 }
 
-void
-chpid_is_actually_online(int chp)
+void chpid_is_actually_online(struct chp_id chpid)
 {
 	int state;
 
-	state = get_chp_status(chp);
+	state = get_chp_status(chpid);
 	if (state < 0) {
 		need_rescan = 1;
 		queue_work(slow_path_wq, &slow_path_work);
@@ -200,11 +205,14 @@
 	spin_unlock_irq(sch->lock);
 	free_page((unsigned long)page);
 	if (!ret) {
-		int j, chpid, mask;
+		int j, mask;
+		struct chp_id chpid;
+
+		chp_id_init(&chpid);
 		/* Allocate channel path structures, if needed. */
 		for (j = 0; j < 8; j++) {
 			mask = 0x80 >> j;
-			chpid = sch->ssd_info.chpid[j];
+			chpid.id = sch->ssd_info.chpid[j];
 			if ((sch->schib.pmcw.pim & mask) &&
 			    (get_chp_status(chpid) < 0))
 			    new_channel_path(chpid);
@@ -227,7 +235,7 @@
 	for (j = 0; j < 8; j++) {
 		mask = 0x80 >> j;
 		if ((sch->schib.pmcw.pim & mask) &&
-		    (sch->schib.pmcw.chpid[j] == chpid->id))
+		    (sch->schib.pmcw.chpid[j] == chpid->chpid.id))
 			break;
 	}
 	if (j >= 8)
@@ -277,18 +285,17 @@
 	return 0;
 }
 
-static void
-s390_set_chpid_offline( __u8 chpid)
+static void s390_set_chpid_offline(struct chp_id chpid)
 {
 	char dbf_txt[15];
 	struct device *dev;
 
-	sprintf(dbf_txt, "chpr%x", chpid);
+	sprintf(dbf_txt, "chpr%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
 	if (get_chp_status(chpid) <= 0)
 		return;
-	dev = get_device(&css[0]->chps[chpid]->dev);
+	dev = get_device(&(chpid_to_chp(chpid)->dev));
 	bus_for_each_dev(&css_bus_type, NULL, to_channelpath(dev),
 			 s390_subchannel_remove_chpid);
 
@@ -316,7 +323,7 @@
 		 * check if chpid is in information updated by ssd
 		 */
 		if (sch->ssd_info.valid &&
-		    sch->ssd_info.chpid[chp] == res_data->chp->id &&
+		    sch->ssd_info.chpid[chp] == res_data->chp->chpid.id &&
 		    (sch->ssd_info.fla[chp] & res_data->fla_mask)
 		    == res_data->fla) {
 			found = 1;
@@ -409,7 +416,8 @@
 	int rc;
 	char dbf_txt[15];
 
-	sprintf(dbf_txt, "accpr%x", res_data->chp->id);
+	sprintf(dbf_txt, "accpr%x.%02x", res_data->chp->chpid.cssid,
+		res_data->chp->chpid.id);
 	CIO_TRACE_EVENT( 2, dbf_txt);
 	if (res_data->fla != 0) {
 		sprintf(dbf_txt, "fla%x", res_data->fla);
@@ -482,17 +490,21 @@
 
 static int chsc_process_sei_link_incident(struct chsc_sei_area *sei_area)
 {
-	int chpid;
+	struct chp_id chpid;
+	int id;
 
 	CIO_CRW_EVENT(4, "chsc: link incident (rs=%02x, rs_id=%04x)\n",
 		      sei_area->rs, sei_area->rsid);
 	if (sei_area->rs != 4)
 		return 0;
-	chpid = __get_chpid_from_lir(sei_area->ccdf);
-	if (chpid < 0)
+	id = __get_chpid_from_lir(sei_area->ccdf);
+	if (id < 0)
 		CIO_CRW_EVENT(4, "chsc: link incident - invalid LIR\n");
-	else
+	else {
+		chp_id_init(&chpid);
+		chpid.id = id;
 		s390_set_chpid_offline(chpid);
+	}
 
 	return 0;
 }
@@ -501,6 +513,7 @@
 {
 	struct res_acc_data res_data;
 	struct device *dev;
+	struct chp_id chpid;
 	int status;
 	int rc;
 
@@ -508,13 +521,15 @@
 		      "rs_id=%04x)\n", sei_area->rs, sei_area->rsid);
 	if (sei_area->rs != 4)
 		return 0;
+	chp_id_init(&chpid);
+	chpid.id = sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
-	status = get_chp_status(sei_area->rsid);
+	status = get_chp_status(chpid);
 	if (status < 0)
-		new_channel_path(sei_area->rsid);
+		new_channel_path(chpid);
 	else if (!status)
 		return 0;
-	dev = get_device(&css[0]->chps[sei_area->rsid]->dev);
+	dev = get_device(&(chpid_to_chp(chpid)->dev));
 	memset(&res_data, 0, sizeof(struct res_acc_data));
 	res_data.chp = to_channelpath(dev);
 	if ((sei_area->vf & 0xc0) != 0) {
@@ -631,7 +646,7 @@
 	for (i=0; i<8; i++) {
 		mask = 0x80 >> i;
 		if ((sch->schib.pmcw.pim & mask) &&
-		    (sch->schib.pmcw.chpid[i] == chp->id)) {
+		    (sch->schib.pmcw.chpid[i] == chp->chpid.id)) {
 			if (stsch(sch->schid, &sch->schib) != 0) {
 				/* Endgame. */
 				spin_unlock_irq(sch->lock);
@@ -657,8 +672,7 @@
 	return 0;
 }
 
-static int
-chp_add(int chpid)
+static int chp_add(struct chp_id chpid)
 {
 	int rc;
 	char dbf_txt[15];
@@ -667,10 +681,10 @@
 	if (!get_chp_status(chpid))
 		return 0; /* no need to do the rest */
 	
-	sprintf(dbf_txt, "cadd%x", chpid);
+	sprintf(dbf_txt, "cadd%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	dev = get_device(&css[0]->chps[chpid]->dev);
+	dev = get_device(&(chpid_to_chp(chpid)->dev));
 	rc = for_each_subchannel(__chp_add, to_channelpath(dev));
 	if (css_slow_subchannels_exist())
 		rc = -EAGAIN;
@@ -683,9 +697,12 @@
 /* 
  * Handling of crw machine checks with channel path source.
  */
-int
-chp_process_crw(int chpid, int on)
+int chp_process_crw(int id, int on)
 {
+	struct chp_id chpid;
+
+	chp_id_init(&chpid);
+	chpid.id = id;
 	if (on == 0) {
 		/* Path has gone. We use the link incident routine.*/
 		s390_set_chpid_offline(chpid);
@@ -733,8 +750,8 @@
 		sch->driver->termination(&sch->dev);
 }
 
-static void
-__s390_subchannel_vary_chpid(struct subchannel *sch, __u8 chpid, int on)
+static void __s390_subchannel_vary_chpid(struct subchannel *sch,
+					 struct chp_id chpid, int on)
 {
 	int chp, old_lpm;
 	unsigned long flags;
@@ -745,7 +762,7 @@
 	spin_lock_irqsave(sch->lock, flags);
 	old_lpm = sch->lpm;
 	for (chp = 0; chp < 8; chp++) {
-		if (sch->ssd_info.chpid[chp] != chpid)
+		if (sch->ssd_info.chpid[chp] != chpid.id)
 			continue;
 
 		if (on) {
@@ -780,11 +797,10 @@
 	spin_unlock_irqrestore(sch->lock, flags);
 }
 
-static int
-s390_subchannel_vary_chpid_off(struct device *dev, void *data)
+static int s390_subchannel_vary_chpid_off(struct device *dev, void *data)
 {
 	struct subchannel *sch;
-	__u8 *chpid;
+	struct chp_id *chpid;
 
 	sch = to_subchannel(dev);
 	chpid = data;
@@ -793,11 +809,10 @@
 	return 0;
 }
 
-static int
-s390_subchannel_vary_chpid_on(struct device *dev, void *data)
+static int s390_subchannel_vary_chpid_on(struct device *dev, void *data)
 {
 	struct subchannel *sch;
-	__u8 *chpid;
+	struct chp_id *chpid;
 
 	sch = to_subchannel(dev);
 	chpid = data;
@@ -833,23 +848,25 @@
  * Function: s390_vary_chpid
  * Varies the specified chpid online or offline
  */
-static int
-s390_vary_chpid( __u8 chpid, int on)
+static int s390_vary_chpid(struct chp_id chpid, int on)
 {
 	char dbf_text[15];
 	int status;
 
-	sprintf(dbf_text, on?"varyon%x":"varyoff%x", chpid);
+	sprintf(dbf_text, on?"varyon%x.%02x":"varyoff%x.%02x", chpid.cssid,
+		chpid.id);
 	CIO_TRACE_EVENT( 2, dbf_text);
 
 	status = get_chp_status(chpid);
 	if (status < 0) {
-		printk(KERN_ERR "Can't vary unknown chpid %02X\n", chpid);
+		printk(KERN_ERR "Can't vary unknown chpid %x.%02x\n",
+		       chpid.cssid, chpid.id);
 		return -EINVAL;
 	}
 
 	if (!on && !status) {
-		printk(KERN_ERR "chpid %x is already offline\n", chpid);
+		printk(KERN_ERR "chpid %x.%02x is already offline\n",
+		       chpid.cssid, chpid.id);
 		return -EINVAL;
 	}
 
@@ -904,20 +921,19 @@
 	.read = chp_measurement_chars_read,
 };
 
-static void
-chp_measurement_copy_block(struct cmg_entry *buf,
-			   struct channel_subsystem *css, int chpid)
+static void chp_measurement_copy_block(struct cmg_entry *buf,
+			struct channel_subsystem *css, struct chp_id chpid)
 {
 	void *area;
 	struct cmg_entry *entry, reference_buf;
 	int idx;
 
-	if (chpid < 128) {
+	if (chpid.id < 128) {
 		area = css->cub_addr1;
-		idx = chpid;
+		idx = chpid.id;
 	} else {
 		area = css->cub_addr2;
-		idx = chpid - 128;
+		idx = chpid.id - 128;
 	}
 	entry = area + (idx * sizeof(struct cmg_entry));
 	do {
@@ -941,7 +957,7 @@
 	/* Only allow single reads. */
 	if (off || count < size)
 		return 0;
-	chp_measurement_copy_block((struct cmg_entry *)buf, css, chp->id);
+	chp_measurement_copy_block((struct cmg_entry *)buf, css, chp->chpid);
 	count = size;
 	return count;
 }
@@ -1137,7 +1153,7 @@
 
 	if (!chp)
 		return 0;
-	return (get_chp_status(chp->id) ? sprintf(buf, "online\n") :
+	return (get_chp_status(chp->chpid) ? sprintf(buf, "online\n") :
 		sprintf(buf, "offline\n"));
 }
 
@@ -1154,9 +1170,9 @@
 		return count;
 
 	if (!strnicmp(cmd, "on", 2))
-		error = s390_vary_chpid(cp->id, 1);
+		error = s390_vary_chpid(cp->chpid, 1);
 	else if (!strnicmp(cmd, "off", 3))
-		error = s390_vary_chpid(cp->id, 0);
+		error = s390_vary_chpid(cp->chpid, 0);
 	else
 		error = -EINVAL;
 
@@ -1227,9 +1243,8 @@
 	kfree(cp);
 }
 
-static int
-chsc_determine_channel_path_description(int chpid,
-					struct channel_path_desc *desc)
+static int chsc_determine_channel_path_description(struct chp_id chpid,
+						struct channel_path_desc *desc)
 {
 	int ccode, ret;
 
@@ -1252,8 +1267,8 @@
 	scpd_area->request.length = 0x0010;
 	scpd_area->request.code = 0x0002;
 
-	scpd_area->first_chpid = chpid;
-	scpd_area->last_chpid = chpid;
+	scpd_area->first_chpid = chpid.id;
+	scpd_area->last_chpid = chpid.id;
 
 	ccode = chsc(scpd_area);
 	if (ccode > 0) {
@@ -1349,8 +1364,8 @@
 	scmc_area->request.length = 0x0010;
 	scmc_area->request.code = 0x0022;
 
-	scmc_area->first_chpid = chp->id;
-	scmc_area->last_chpid = chp->id;
+	scmc_area->first_chpid = chp->chpid.id;
+	scmc_area->last_chpid = chp->chpid.id;
 
 	ccode = chsc(scmc_area);
 	if (ccode > 0) {
@@ -1396,8 +1411,7 @@
  * Entries for chpids on the system bus.
  * This replaces /proc/chpids.
  */
-static int
-new_channel_path(int chpid)
+static int new_channel_path(struct chp_id chpid)
 {
 	struct channel_path *chp;
 	int ret;
@@ -1407,11 +1421,12 @@
 		return -ENOMEM;
 
 	/* fill in status, etc. */
-	chp->id = chpid;
+	chp->chpid = chpid;
 	chp->state = 1;
-	chp->dev.parent = &css[0]->device;
+	chp->dev.parent = &css[chpid.cssid]->device;
 	chp->dev.release = chp_release;
-	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp0.%x", chpid);
+	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp%x.%02x", chpid.cssid,
+		 chpid.id);
 
 	/* Obtain channel path description and fill it in. */
 	ret = chsc_determine_channel_path_description(chpid, &chp->desc);
@@ -1437,8 +1452,8 @@
 	/* make it known to the system */
 	ret = device_register(&chp->dev);
 	if (ret) {
-		printk(KERN_WARNING "%s: could not register %02x\n",
-		       __func__, chpid);
+		printk(KERN_WARNING "%s: could not register %x.%02x\n",
+		       __func__, chpid.cssid, chpid.id);
 		goto out_free;
 	}
 	ret = sysfs_create_group(&chp->dev.kobj, &chp_attr_group);
@@ -1446,18 +1461,18 @@
 		device_unregister(&chp->dev);
 		goto out_free;
 	}
-	mutex_lock(&css[0]->mutex);
-	if (css[0]->cm_enabled) {
+	mutex_lock(&css[chpid.cssid]->mutex);
+	if (css[chpid.cssid]->cm_enabled) {
 		ret = chsc_add_chp_cmg_attr(chp);
 		if (ret) {
 			sysfs_remove_group(&chp->dev.kobj, &chp_attr_group);
 			device_unregister(&chp->dev);
-			mutex_unlock(&css[0]->mutex);
+			mutex_unlock(&css[chpid.cssid]->mutex);
 			goto out_free;
 		}
 	}
-	css[0]->chps[chpid] = chp;
-	mutex_unlock(&css[0]->mutex);
+	css[chpid.cssid]->chps[chpid.id] = chp;
+	mutex_unlock(&css[chpid.cssid]->mutex);
 	return ret;
 out_free:
 	kfree(chp);
@@ -1469,8 +1484,11 @@
 {
 	struct channel_path *chp;
 	struct channel_path_desc *desc;
+	struct chp_id chpid;
 
-	chp = css[0]->chps[sch->schib.pmcw.chpid[chp_no]];
+	chp_id_init(&chpid);
+	chpid.id = sch->schib.pmcw.chpid[chp_no];
+	chp = chpid_to_chp(chpid);
 	if (!chp)
 		return NULL;
 	desc = kmalloc(sizeof(struct channel_path_desc), GFP_KERNEL);
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.h	2007-04-27 16:04:52.000000000 +0200
@@ -1,6 +1,10 @@
 #ifndef S390_CHSC_H
 #define S390_CHSC_H
 
+#include <linux/types.h>
+#include <linux/device.h>
+#include "chpid.h"
+
 #define CHSC_SEI_ACC_CHPID        1
 #define CHSC_SEI_ACC_LINKADDR     2
 #define CHSC_SEI_ACC_FULLLINKADDR 3
@@ -34,7 +38,7 @@
 } __attribute__ ((packed));
 
 struct channel_path {
-	int id;
+	struct chp_id chpid;
 	int state;
 	struct channel_path_desc desc;
 	/* Channel-measurement related stuff: */
@@ -46,7 +50,7 @@
 
 extern void s390_process_css( void );
 extern void chsc_validate_chpids(struct subchannel *);
-extern void chpid_is_actually_online(int);
+extern void chpid_is_actually_online(struct chp_id);
 extern int css_get_ssd_info(struct subchannel *);
 extern int chsc_process_crw(void);
 extern int chp_process_crw(int, int);
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c	2007-04-27 16:04:52.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/cio.c	2007-04-27 16:04:52.000000000 +0200
@@ -954,6 +954,7 @@
 {
 	int i, ret;
 	unsigned long long timeout;
+	struct chp_id chpid;
 
 	/* Reset subchannels. */
 	for_each_subchannel(__shutdown_subchannel_easy,  NULL);
@@ -963,8 +964,10 @@
 	__ctl_set_bit(14, 28);
 	/* Temporarily reenable machine checks. */
 	local_mcck_enable();
+	chp_id_init(&chpid);
 	for (i = 0; i <= __MAX_CHPID; i++) {
-		ret = rchp(i);
+		chpid.id = i;
+		ret = rchp(chpid);
 		if ((ret == 0) || (ret == 2))
 			/*
 			 * rchp either succeeded, or another rchp is already
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:52.000000000 +0200
@@ -22,6 +22,7 @@
 #include "device.h"
 #include "chsc.h"
 #include "ioasm.h"
+#include "chpid.h"
 
 int
 device_is_online(struct subchannel *sch)
@@ -210,14 +211,17 @@
 __recover_lost_chpids(struct subchannel *sch, int old_lpm)
 {
 	int mask, i;
+	struct chp_id chpid;
 
+	chp_id_init(&chpid);
 	for (i = 0; i<8; i++) {
 		mask = 0x80 >> i;
 		if (!(sch->lpm & mask))
 			continue;
 		if (old_lpm & mask)
 			continue;
-		chpid_is_actually_online(sch->schib.pmcw.chpid[i]);
+		chpid.id = sch->schib.pmcw.chpid[i];
+		chpid_is_actually_online(chpid);
 	}
 }
 
Index: quilt-2.6/drivers/s390/cio/ioasm.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ioasm.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/ioasm.h	2007-04-27 16:04:52.000000000 +0200
@@ -2,6 +2,7 @@
 #define S390_CIO_IOASM_H
 
 #include "schid.h"
+#include "chpid.h"
 
 /*
  * TPI info structure
@@ -189,9 +190,9 @@
 	return cc;
 }
 
-static inline int rchp(int chpid)
+static inline int rchp(struct chp_id chpid)
 {
-	register unsigned int reg1 asm ("1") = chpid;
+	register struct chp_id reg1 asm ("1") = chpid;
 	int ccode;
 
 	asm volatile(

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
