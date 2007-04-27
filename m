Return-Path: <linux-kernel-owner+w=401wt.eu-S1755909AbXD0OPx@vger.kernel.org>
Message-Id: <20070427140514.566899721@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/38] cio: fix subchannel channel-path data usage
Content-Disposition: inline; filename=110-cio-chpid-data.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Ensure that channel-path related subchannel data is only retrieved and
used when it is valid and that it is updated when it may have changed.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c       |  303 ++++++++++++++----------------------------
 drivers/s390/cio/chsc.h       |   10 +
 drivers/s390/cio/cio.h        |   16 --
 drivers/s390/cio/css.c        |   53 ++++++-
 drivers/s390/cio/css.h        |    1 
 drivers/s390/cio/device.c     |   12 +
 drivers/s390/cio/device_fsm.c |    1 
 7 files changed, 179 insertions(+), 217 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.c	2007-04-27 16:04:55.000000000 +0200
@@ -26,155 +26,84 @@
 
 static void *sei_page;
 
-/* FIXME: this is _always_ called for every subchannel. shouldn't we
- *	  process more than one at a time? */
-static int
-chsc_get_sch_desc_irq(struct subchannel *sch, void *page)
-{
-	int ccode, j;
-
-	struct {
-		struct chsc_header request;
-		u16 reserved1a:10;
-		u16 ssid:2;
-		u16 reserved1b:4;
-		u16 f_sch;	  /* first subchannel */
-		u16 reserved2;
-		u16 l_sch;	  /* last subchannel */
-		u32 reserved3;
-		struct chsc_header response;
-		u32 reserved4;
-		u8 sch_valid : 1;
-		u8 dev_valid : 1;
-		u8 st	     : 3; /* subchannel type */
-		u8 zeroes    : 3;
-		u8  unit_addr;	  /* unit address */
-		u16 devno;	  /* device number */
-		u8 path_mask;
-		u8 fla_valid_mask;
-		u16 sch;	  /* subchannel */
-		u8 chpid[8];	  /* chpids 0-7 */
-		u16 fla[8];	  /* full link addresses 0-7 */
-	} __attribute__ ((packed)) *ssd_area;
+struct chsc_ssd_area {
+	struct chsc_header request;
+	u16 :10;
+	u16 ssid:2;
+	u16 :4;
+	u16 f_sch;	  /* first subchannel */
+	u16 :16;
+	u16 l_sch;	  /* last subchannel */
+	u32 :32;
+	struct chsc_header response;
+	u32 :32;
+	u8 sch_valid : 1;
+	u8 dev_valid : 1;
+	u8 st	     : 3; /* subchannel type */
+	u8 zeroes    : 3;
+	u8  unit_addr;	  /* unit address */
+	u16 devno;	  /* device number */
+	u8 path_mask;
+	u8 fla_valid_mask;
+	u16 sch;	  /* subchannel */
+	u8 chpid[8];	  /* chpids 0-7 */
+	u16 fla[8];	  /* full link addresses 0-7 */
+} __attribute__ ((packed));
 
-	ssd_area = page;
+int chsc_get_ssd_info(struct subchannel_id schid, struct chsc_ssd_info *ssd)
+{
+	unsigned long page;
+	struct chsc_ssd_area *ssd_area;
+	int ccode;
+	int ret;
+	int i;
+	int mask;
 
+	page = get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!page)
+		return -ENOMEM;
+	ssd_area = (struct chsc_ssd_area *) page;
 	ssd_area->request.length = 0x0010;
 	ssd_area->request.code = 0x0004;
-
-	ssd_area->ssid = sch->schid.ssid;
-	ssd_area->f_sch = sch->schid.sch_no;
-	ssd_area->l_sch = sch->schid.sch_no;
+	ssd_area->ssid = schid.ssid;
+	ssd_area->f_sch = schid.sch_no;
+	ssd_area->l_sch = schid.sch_no;
 
 	ccode = chsc(ssd_area);
+	/* Check response. */
 	if (ccode > 0) {
-		pr_debug("chsc returned with ccode = %d\n", ccode);
-		return (ccode == 3) ? -ENODEV : -EBUSY;
+		ret = (ccode == 3) ? -ENODEV : -EBUSY;
+		goto out_free;
 	}
-
-	switch (ssd_area->response.code) {
-	case 0x0001: /* everything ok */
-		break;
-	case 0x0002:
-		CIO_CRW_EVENT(2, "Invalid command!\n");
-		return -EINVAL;
-	case 0x0003:
-		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
-		return -EINVAL;
-	case 0x0004:
-		CIO_CRW_EVENT(2, "Model does not provide ssd\n");
-		return -EOPNOTSUPP;
-	default:
-		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
+	if (ssd_area->response.code != 0x0001) {
+		CIO_MSG_EVENT(2, "chsc: ssd failed for 0.%x.%04x (rc=%04x)\n",
+			      schid.ssid, schid.sch_no,
 			      ssd_area->response.code);
-		return -EIO;
+		ret = -EIO;
+		goto out_free;
 	}
-
-	/*
-	 * ssd_area->st stores the type of the detected
-	 * subchannel, with the following definitions:
-	 *
-	 * 0: I/O subchannel:	  All fields have meaning
-	 * 1: CHSC subchannel:	  Only sch_val, st and sch
-	 *			  have meaning
-	 * 2: Message subchannel: All fields except unit_addr
-	 *			  have meaning
-	 * 3: ADM subchannel:	  Only sch_val, st and sch
-	 *			  have meaning
-	 *
-	 * Other types are currently undefined.
-	 */
-	if (ssd_area->st > 3) { /* uhm, that looks strange... */
-		CIO_CRW_EVENT(0, "Strange subchannel type %d"
-			      " for sch 0.%x.%04x\n", ssd_area->st,
-			      sch->schid.ssid, sch->schid.sch_no);
-		/*
-		 * There may have been a new subchannel type defined in the
-		 * time since this code was written; since we don't know which
-		 * fields have meaning and what to do with it we just jump out
-		 */
-		return 0;
-	} else {
-		const char *type[4] = {"I/O", "chsc", "message", "ADM"};
-		CIO_CRW_EVENT(6, "ssd: sch 0.%x.%04x is %s subchannel\n",
-			      sch->schid.ssid, sch->schid.sch_no,
-			      type[ssd_area->st]);
-
-		sch->ssd_info.valid = 1;
-		sch->ssd_info.type = ssd_area->st;
-	}
-
-	if (ssd_area->st == 0 || ssd_area->st == 2) {
-		for (j = 0; j < 8; j++) {
-			if (!((0x80 >> j) & ssd_area->path_mask &
-			      ssd_area->fla_valid_mask))
-				continue;
-			sch->ssd_info.chpid[j] = ssd_area->chpid[j];
-			sch->ssd_info.fla[j]   = ssd_area->fla[j];
-		}
+	if (!ssd_area->sch_valid) {
+		ret = -ENODEV;
+		goto out_free;
 	}
-	return 0;
-}
-
-int
-css_get_ssd_info(struct subchannel *sch)
-{
-	int ret;
-	void *page;
-
-	page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!page)
-		return -ENOMEM;
-	spin_lock_irq(sch->lock);
-	ret = chsc_get_sch_desc_irq(sch, page);
-	if (ret) {
-		static int cio_chsc_err_msg;
-		
-		if (!cio_chsc_err_msg) {
-			printk(KERN_ERR
-			       "chsc_get_sch_descriptions:"
-			       " Error %d while doing chsc; "
-			       "processing some machine checks may "
-			       "not work\n", ret);
-			cio_chsc_err_msg = 1;
-		}
-	}
-	spin_unlock_irq(sch->lock);
-	free_page((unsigned long)page);
-	if (!ret) {
-		int j, mask;
-		struct chp_id chpid;
-
-		chp_id_init(&chpid);
-		/* Allocate channel path structures, if needed. */
-		for (j = 0; j < 8; j++) {
-			mask = 0x80 >> j;
-			chpid.id = sch->ssd_info.chpid[j];
-			if ((sch->schib.pmcw.pim & mask) &&
-			    !chp_is_registered(chpid))
-				chp_new(chpid);
+	/* Copy data */
+	ret = 0;
+	memset(ssd, 0, sizeof(struct chsc_ssd_info));
+	if ((ssd_area->st != 0) && (ssd_area->st != 2))
+		goto out_free;
+	ssd->path_mask = ssd_area->path_mask;
+	ssd->fla_valid_mask = ssd_area->fla_valid_mask;
+	for (i = 0; i < 8; i++) {
+		mask = 0x80 >> i;
+		if (ssd_area->path_mask & mask) {
+			chp_id_init(&ssd->chpid[i]);
+			ssd->chpid[i].id = ssd_area->chpid[i];
 		}
+		if (ssd_area->fla_valid_mask & mask)
+			ssd->fla[i] = ssd_area->fla[i];
 	}
+out_free:
+	free_page(page);
 	return ret;
 }
 
@@ -276,47 +205,6 @@
 			 s390_subchannel_remove_chpid);
 }
 
-struct res_acc_data {
-	struct chp_id chpid;
-	u32 fla_mask;
-	u16 fla;
-};
-
-static int s390_process_res_acc_sch(struct res_acc_data *res_data,
-				    struct subchannel *sch)
-{
-	int found;
-	int chp;
-	int ccode;
-
-	found = 0;
-	for (chp = 0; chp <= 7; chp++)
-		/*
-		 * check if chpid is in information updated by ssd
-		 */
-		if (sch->ssd_info.valid &&
-		    sch->ssd_info.chpid[chp] == res_data->chpid.id &&
-		    (sch->ssd_info.fla[chp] & res_data->fla_mask)
-		    == res_data->fla) {
-			found = 1;
-			break;
-		}
-
-	if (found == 0)
-		return 0;
-
-	/*
-	 * Do a stsch to update our subchannel structure with the
-	 * new path information and eventually check for logically
-	 * offline chpids.
-	 */
-	ccode = stsch(sch->schid, &sch->schib);
-	if (ccode > 0)
-		return 0;
-
-	return 0x80 >> chp;
-}
-
 static int
 s390_process_res_acc_new_sch(struct subchannel_id schid)
 {
@@ -338,6 +226,32 @@
 	return 0;
 }
 
+struct res_acc_data {
+	struct chp_id chpid;
+	u32 fla_mask;
+	u16 fla;
+};
+
+static int get_res_chpid_mask(struct chsc_ssd_info *ssd,
+			      struct res_acc_data *data)
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
+
 static int
 __s390_process_res_acc(struct subchannel_id schid, void *data)
 {
@@ -352,14 +266,11 @@
 		return s390_process_res_acc_new_sch(schid);
 
 	spin_lock_irq(sch->lock);
-
-	chp_mask = s390_process_res_acc_sch(res_data, sch);
-
-	if (chp_mask == 0) {
-		spin_unlock_irq(sch->lock);
-		put_device(&sch->dev);
-		return 0;
-	}
+	chp_mask = get_res_chpid_mask(&sch->ssd_info, res_data);
+	if (chp_mask == 0)
+		goto out;
+	if (stsch(sch->schid, &sch->schib))
+		goto out;
 	old_lpm = sch->lpm;
 	sch->lpm = ((sch->schib.pmcw.pim &
 		     sch->schib.pmcw.pam &
@@ -369,13 +280,12 @@
 		device_trigger_reprobe(sch);
 	else if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
-
+out:
 	spin_unlock_irq(sch->lock);
 	put_device(&sch->dev);
 	return 0;
 }
 
-
 static void s390_process_res_acc (struct res_acc_data *res_data)
 {
 	char dbf_txt[15];
@@ -661,29 +571,30 @@
 					 struct chp_id chpid, int on)
 {
 	int chp, old_lpm;
+	int mask;
 	unsigned long flags;
 
-	if (!sch->ssd_info.valid)
-		return;
-	
 	spin_lock_irqsave(sch->lock, flags);
 	old_lpm = sch->lpm;
 	for (chp = 0; chp < 8; chp++) {
-		if (sch->ssd_info.chpid[chp] != chpid.id)
+		mask = 0x80 >> chp;
+		if (!(sch->ssd_info.path_mask & mask))
+			continue;
+		if (!chp_id_is_equal(&sch->ssd_info.chpid[chp], &chpid))
 			continue;
 
 		if (on) {
-			sch->opm |= (0x80 >> chp);
-			sch->lpm |= (0x80 >> chp);
+			sch->opm |= mask;
+			sch->lpm |= mask;
 			if (!old_lpm)
 				device_trigger_reprobe(sch);
 			else if (sch->driver && sch->driver->verify)
 				sch->driver->verify(&sch->dev);
 			break;
 		}
-		sch->opm &= ~(0x80 >> chp);
-		sch->lpm &= ~(0x80 >> chp);
-		if (check_for_io_on_path(sch, (0x80 >> chp))) {
+		sch->opm &= ~mask;
+		sch->lpm &= ~mask;
+		if (check_for_io_on_path(sch, mask)) {
 			if (device_is_online(sch))
 				/* Path verification is done after killing. */
 				device_kill_io(sch);
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.h	2007-04-27 16:04:55.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <asm/chpid.h>
+#include "schid.h"
 
 #define CHSC_SDA_OC_MSS   0x2
 
@@ -35,7 +36,6 @@
 
 struct channel_path;
 
-extern int css_get_ssd_info(struct subchannel *);
 extern void chsc_process_crw(void);
 
 struct css_general_char {
@@ -69,6 +69,14 @@
 extern struct css_general_char css_general_characteristics;
 extern struct css_chsc_char css_chsc_characteristics;
 
+struct chsc_ssd_info {
+	u8 path_mask;
+	u8 fla_valid_mask;
+	struct chp_id chpid[8];
+	u16 fla[8];
+};
+extern int chsc_get_ssd_info(struct subchannel_id schid,
+			     struct chsc_ssd_info *ssd);
 extern int chsc_determine_css_characteristics(void);
 extern int css_characteristics_avail;
 
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/cio.h	2007-04-27 16:04:55.000000000 +0200
@@ -1,19 +1,11 @@
 #ifndef S390_CIO_H
 #define S390_CIO_H
 
-#include "schid.h"
 #include <linux/mutex.h>
 #include <linux/device.h>
-
-/*
- * where we put the ssd info
- */
-struct ssd_info {
-	__u8  valid:1;
-	__u8  type:7;		/* subchannel type */
-	__u8  chpid[8];		/* chpids */
-	__u16 fla[8];		/* full link addresses */
-} __attribute__ ((packed));
+#include <asm/chpid.h>
+#include "chsc.h"
+#include "schid.h"
 
 /*
  * path management control word
@@ -109,7 +101,7 @@
 	struct schib schib;	/* subchannel information block */
 	struct orb orb;		/* operation request block */
 	struct ccw1 sense_ccw;	/* static ccw for sense command */
-	struct ssd_info ssd_info;	/* subchannel description */
+	struct chsc_ssd_info ssd_info;	/* subchannel description */
 	struct device dev;	/* entry in device tree */
 	struct css_driver *driver;
 } __attribute__ ((aligned(8)));
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/css.c	2007-04-27 16:04:55.000000000 +0200
@@ -21,6 +21,7 @@
 #include "chsc.h"
 #include "device.h"
 #include "idset.h"
+#include "chp.h"
 
 int css_init_done = 0;
 static int need_reprobe = 0;
@@ -125,8 +126,52 @@
 	mutex_unlock(&sch->reg_mutex);
 }
 
-static int
-css_register_subchannel(struct subchannel *sch)
+static void ssd_from_pmcw(struct chsc_ssd_info *ssd, struct pmcw *pmcw)
+{
+	int i;
+	int mask;
+
+	memset(ssd, 0, sizeof(struct chsc_ssd_info));
+	ssd->path_mask = pmcw->pim;
+	for (i = 0; i < 8; i++) {
+		mask = 0x80 >> i;
+		if (pmcw->pim & mask) {
+			chp_id_init(&ssd->chpid[i]);
+			ssd->chpid[i].id = pmcw->chpid[i];
+		}
+	}
+}
+
+static void ssd_register_chpids(struct chsc_ssd_info *ssd)
+{
+	int i;
+	int mask;
+
+	for (i = 0; i < 8; i++) {
+		mask = 0x80 >> i;
+		if (ssd->path_mask & mask)
+			if (!chp_is_registered(ssd->chpid[i]))
+				chp_new(ssd->chpid[i]);
+	}
+}
+
+void css_update_ssd_info(struct subchannel *sch)
+{
+	int ret;
+
+	if (cio_is_console(sch->schid)) {
+		/* Console is initialized too early for functions requiring
+		 * memory allocation. */
+		ssd_from_pmcw(&sch->ssd_info, &sch->schib.pmcw);
+	} else {
+		ret = chsc_get_ssd_info(sch->schid, &sch->ssd_info);
+		if (ret)
+			ssd_from_pmcw(&sch->ssd_info, &sch->schib.pmcw);
+		ssd_register_chpids(&sch->ssd_info);
+	}
+}
+
+static int css_register_subchannel(struct subchannel *sch)
 {
 	int ret;
 
@@ -135,9 +180,7 @@
 	sch->dev.bus = &css_bus_type;
 	sch->dev.release = &css_subchannel_release;
 	sch->dev.groups = subch_attr_groups;
-
-	css_get_ssd_info(sch);
-
+	css_update_ssd_info(sch);
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
 	if (ret) {
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/css.h	2007-04-27 16:04:55.000000000 +0200
@@ -148,6 +148,7 @@
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
 extern void css_process_crw(int, int);
 extern void css_reiterate_subchannels(void);
+void css_update_ssd_info(struct subchannel *sch);
 
 #define __MAX_SUBCHANNEL 65535
 #define __MAX_SSID 3
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device.c	2007-04-27 16:04:55.000000000 +0200
@@ -216,12 +216,18 @@
 chpids_show (struct device * dev, struct device_attribute *attr, char * buf)
 {
 	struct subchannel *sch = to_subchannel(dev);
-	struct ssd_info *ssd = &sch->ssd_info;
+	struct chsc_ssd_info *ssd = &sch->ssd_info;
 	ssize_t ret = 0;
 	int chp;
+	int mask;
 
-	for (chp = 0; chp < 8; chp++)
-		ret += sprintf (buf+ret, "%02x ", ssd->chpid[chp]);
+	for (chp = 0; chp < 8; chp++) {
+		mask = 0x80 >> chp;
+		if (ssd->path_mask & mask)
+			ret += sprintf(buf + ret, "%02x ", ssd->chpid[chp].id);
+		else
+			ret += sprintf(buf + ret, "00 ");
+	}
 	ret += sprintf (buf+ret, "\n");
 	return min((ssize_t)PAGE_SIZE, ret);
 }
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:55.000000000 +0200
@@ -246,6 +246,7 @@
 	 */
 	old_lpm = sch->lpm;
 	stsch(sch->schid, &sch->schib);
+	css_update_ssd_info(sch);
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 	/* Check since device may again have become not operational. */
 	if (!sch->schib.pmcw.dnv)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
