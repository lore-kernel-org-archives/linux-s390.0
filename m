Return-Path: <linux-kernel-owner+w=401wt.eu-S1756072AbYFCRG6@vger.kernel.org>
Message-Id: <20080603170520.526263777@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/14] cio: provide functions for fcx enabled I/O
Content-Disposition: inline; filename=108-fcx.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Provide functions for assembling and starting fcx enabled I/O request
blocks.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/Makefile      |    2 
 drivers/s390/cio/cio.c         |   81 ++++++++-
 drivers/s390/cio/cio.h         |    4 
 drivers/s390/cio/device_fsm.c  |   49 +++--
 drivers/s390/cio/device_id.c   |    2 
 drivers/s390/cio/device_ops.c  |  117 +++++++++++++
 drivers/s390/cio/device_pgid.c |    2 
 drivers/s390/cio/fcx.c         |  350 +++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/io_sch.h      |   46 ++++-
 include/asm-s390/ccwdev.h      |   12 +
 include/asm-s390/fcx.h         |  311 ++++++++++++++++++++++++++++++++++++
 11 files changed, 938 insertions(+), 38 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -25,6 +25,7 @@
 #include <asm/chpid.h>
 #include <asm/airq.h>
 #include <asm/cpu.h>
+#include <asm/fcx.h>
 #include "cio.h"
 #include "css.h"
 #include "chsc.h"
@@ -167,30 +168,30 @@ cio_start_key (struct subchannel *sch,	/
 {
 	char dbf_txt[15];
 	int ccode;
-	struct orb *orb;
+	union orb *orb;
 
 	CIO_TRACE_EVENT(4, "stIO");
 	CIO_TRACE_EVENT(4, sch->dev.bus_id);
 
 	orb = &to_io_private(sch)->orb;
 	/* sch is always under 2G. */
-	orb->intparm = (u32)(addr_t)sch;
-	orb->fmt = 1;
+	orb->cmd.intparm = (u32)(addr_t)sch;
+	orb->cmd.fmt = 1;
 
-	orb->pfch = sch->options.prefetch == 0;
-	orb->spnd = sch->options.suspend;
-	orb->ssic = sch->options.suspend && sch->options.inter;
-	orb->lpm = (lpm != 0) ? lpm : sch->lpm;
+	orb->cmd.pfch = sch->options.prefetch == 0;
+	orb->cmd.spnd = sch->options.suspend;
+	orb->cmd.ssic = sch->options.suspend && sch->options.inter;
+	orb->cmd.lpm = (lpm != 0) ? lpm : sch->lpm;
 #ifdef CONFIG_64BIT
 	/*
 	 * for 64 bit we always support 64 bit IDAWs with 4k page size only
 	 */
-	orb->c64 = 1;
-	orb->i2k = 0;
+	orb->cmd.c64 = 1;
+	orb->cmd.i2k = 0;
 #endif
-	orb->key = key >> 4;
+	orb->cmd.key = key >> 4;
 	/* issue "Start Subchannel" */
-	orb->cpa = (__u32) __pa(cpa);
+	orb->cmd.cpa = (__u32) __pa(cpa);
 	ccode = ssch(sch->schid, orb);
 
 	/* process condition code */
@@ -1067,3 +1068,61 @@ int __init cio_get_iplinfo(struct cio_ip
 	iplinfo->is_qdio = schib.pmcw.qf;
 	return 0;
 }
+
+/**
+ * cio_tm_start_key - perform start function
+ * @sch: subchannel on which to perform the start function
+ * @tcw: transport-command word to be started
+ * @lpm: mask of paths to use
+ * @key: storage key to use for storage access
+ *
+ * Start the tcw on the given subchannel. Return zero on success, non-zero
+ * otherwise.
+ */
+int cio_tm_start_key(struct subchannel *sch, struct tcw *tcw, u8 lpm, u8 key)
+{
+	int cc;
+	union orb *orb = &to_io_private(sch)->orb;
+
+	memset(orb, 0, sizeof(union orb));
+	orb->tm.intparm = (u32) (addr_t) sch;
+	orb->tm.key = key >> 4;
+	orb->tm.b = 1;
+	orb->tm.lpm = lpm ? lpm : sch->lpm;
+	orb->tm.tcw = (u32) (addr_t) tcw;
+	cc = ssch(sch->schid, orb);
+	switch (cc) {
+	case 0:
+		return 0;
+	case 1:
+	case 2:
+		return -EBUSY;
+	default:
+		return cio_start_handle_notoper(sch, lpm);
+	}
+}
+
+/**
+ * cio_tm_intrg - perform interrogate function
+ * @sch - subchannel on which to perform the interrogate function
+ *
+ * If the specified subchannel is running in transport-mode, perform the
+ * interrogate function. Return zero on success, non-zero otherwie.
+ */
+int cio_tm_intrg(struct subchannel *sch)
+{
+	int cc;
+
+	if (!to_io_private(sch)->orb.tm.b)
+		return -EINVAL;
+	cc = xsch(sch->schid);
+	switch (cc) {
+	case 0:
+	case 2:
+		return 0;
+	case 1:
+		return -EBUSY;
+	default:
+		return -ENODEV;
+	}
+}
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -6,6 +6,7 @@
 #include <linux/mod_devicetable.h>
 #include <asm/chpid.h>
 #include <asm/cio.h>
+#include <asm/fcx.h>
 #include "chsc.h"
 #include "schid.h"
 
@@ -101,6 +102,9 @@ extern int cio_set_options (struct subch
 extern int cio_get_options (struct subchannel *);
 extern int cio_modify (struct subchannel *);
 
+int cio_tm_start_key(struct subchannel *sch, struct tcw *tcw, u8 lpm, u8 key);
+int cio_tm_intrg(struct subchannel *sch);
+
 int cio_create_sch_lock(struct subchannel *);
 void do_adapter_IO(void);
 void do_IRQ(struct pt_regs *);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -39,31 +39,43 @@ static void ccw_timeout_log(struct ccw_d
 	struct schib schib;
 	struct subchannel *sch;
 	struct io_subchannel_private *private;
+	union orb *orb;
 	int cc;
 
 	sch = to_subchannel(cdev->dev.parent);
 	private = to_io_private(sch);
+	orb = &private->orb;
 	cc = stsch(sch->schid, &schib);
 
 	printk(KERN_WARNING "cio: ccw device timeout occurred at %llx, "
 	       "device information:\n", get_clock());
 	printk(KERN_WARNING "cio: orb:\n");
 	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
-		       &private->orb, sizeof(private->orb), 0);
+		       orb, sizeof(*orb), 0);
 	printk(KERN_WARNING "cio: ccw device bus id: %s\n", cdev->dev.bus_id);
 	printk(KERN_WARNING "cio: subchannel bus id: %s\n", sch->dev.bus_id);
 	printk(KERN_WARNING "cio: subchannel lpm: %02x, opm: %02x, "
 	       "vpm: %02x\n", sch->lpm, sch->opm, sch->vpm);
 
-	if ((void *)(addr_t)private->orb.cpa == &private->sense_ccw ||
-	    (void *)(addr_t)private->orb.cpa == cdev->private->iccws)
-		printk(KERN_WARNING "cio: last channel program (intern):\n");
-	else
-		printk(KERN_WARNING "cio: last channel program:\n");
-
-	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
-		       (void *)(addr_t)private->orb.cpa,
-		       sizeof(struct ccw1), 0);
+	if (orb->tm.b) {
+		printk(KERN_WARNING "cio: orb indicates transport mode\n");
+		printk(KERN_WARNING "cio: last tcw:\n");
+		print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
+			       (void *)(addr_t)orb->tm.tcw,
+			       sizeof(struct tcw), 0);
+	} else {
+		printk(KERN_WARNING "cio: orb indicates command mode\n");
+		if ((void *)(addr_t)orb->cmd.cpa == &private->sense_ccw ||
+		    (void *)(addr_t)orb->cmd.cpa == cdev->private->iccws)
+			printk(KERN_WARNING "cio: last channel program "
+			       "(intern):\n");
+		else
+			printk(KERN_WARNING "cio: last channel program:\n");
+
+		print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
+			       (void *)(addr_t)orb->cmd.cpa,
+			       sizeof(struct ccw1), 0);
+	}
 	printk(KERN_WARNING "cio: ccw device state: %d\n",
 	       cdev->private->state);
 	printk(KERN_WARNING "cio: store subchannel returned: cc=%d\n", cc);
@@ -135,10 +147,13 @@ ccw_device_cancel_halt_clear(struct ccw_
 	/* Stage 1: cancel io. */
 	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_HALT_PEND) &&
 	    !(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
-		ret = cio_cancel(sch);
-		if (ret != -EINVAL)
-			return ret;
-		/* cancel io unsuccessful. From now on it is asynchronous. */
+		if (!scsw_is_tm(&sch->schib.scsw)) {
+			ret = cio_cancel(sch);
+			if (ret != -EINVAL)
+				return ret;
+		}
+		/* cancel io unsuccessful or not applicable (transport mode).
+		 * Continue with asynchronous instructions. */
 		cdev->private->iretry = 3;	/* 3 halt retries. */
 	}
 	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
@@ -751,11 +766,13 @@ static void
 ccw_device_irq(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	struct irb *irb;
+	int is_cmd;
 
 	irb = (struct irb *) __LC_IRB;
+	is_cmd = !scsw_is_tm(&irb->scsw);
 	/* Check for unsolicited interrupt. */
 	if (!scsw_is_solicited(&irb->scsw)) {
-		if ((irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) &&
+		if (is_cmd && (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) &&
 		    !irb->esw.esw0.erw.cons) {
 			/* Unit check but no sense data. Need basic sense. */
 			if (ccw_device_do_sense(cdev, irb) != 0)
@@ -774,7 +791,7 @@ call_handler_unsol:
 	}
 	/* Accumulate status and find out if a basic sense is needed. */
 	ccw_device_accumulate_irb(cdev, irb);
-	if (cdev->private->flags.dosense) {
+	if (is_cmd && cdev->private->flags.dosense) {
 		if (ccw_device_do_sense(cdev, irb) == 0) {
 			cdev->private->state = DEV_STATE_W4SENSE;
 		}
Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -237,7 +237,7 @@ ccw_device_check_sense_id(struct ccw_dev
 	if (irb->scsw.cmd.cc == 3) {
 		u8 lpm;
 
-		lpm = to_io_private(sch)->orb.lpm;
+		lpm = to_io_private(sch)->orb.cmd.lpm;
 		if ((lpm & sch->schib.pmcw.pim & sch->schib.pmcw.pam) != 0)
 			CIO_MSG_EVENT(4, "SenseID : path %02X for device %04x "
 				      "on subchannel 0.%x.%04x is "
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -17,6 +17,7 @@
 #include <asm/ccwdev.h>
 #include <asm/idals.h>
 #include <asm/chpid.h>
+#include <asm/fcx.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -569,6 +570,122 @@ void ccw_device_get_id(struct ccw_device
 }
 EXPORT_SYMBOL(ccw_device_get_id);
 
+/**
+ * ccw_device_tm_start_key - perform start function
+ * @cdev: ccw device on which to perform the start function
+ * @tcw: transport-command word to be started
+ * @intparm: user defined parameter to be passed to the interrupt handler
+ * @lpm: mask of paths to use
+ * @key: storage key to use for storage access
+ *
+ * Start the tcw on the given ccw device. Return zero on success, non-zero
+ * otherwise.
+ */
+int ccw_device_tm_start_key(struct ccw_device *cdev, struct tcw *tcw,
+			    unsigned long intparm, u8 lpm, u8 key)
+{
+	struct subchannel *sch;
+	int rc;
+
+	sch = to_subchannel(cdev->dev.parent);
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		return -EIO;
+	/* Adjust requested path mask to excluded varied off paths. */
+	if (lpm) {
+		lpm &= sch->opm;
+		if (lpm == 0)
+			return -EACCES;
+	}
+	rc = cio_tm_start_key(sch, tcw, lpm, key);
+	if (rc == 0)
+		cdev->private->intparm = intparm;
+	return rc;
+}
+EXPORT_SYMBOL(ccw_device_tm_start_key);
+
+/**
+ * ccw_device_tm_start_timeout_key - perform start function
+ * @cdev: ccw device on which to perform the start function
+ * @tcw: transport-command word to be started
+ * @intparm: user defined parameter to be passed to the interrupt handler
+ * @lpm: mask of paths to use
+ * @key: storage key to use for storage access
+ * @expires: time span in jiffies after which to abort request
+ *
+ * Start the tcw on the given ccw device. Return zero on success, non-zero
+ * otherwise.
+ */
+int ccw_device_tm_start_timeout_key(struct ccw_device *cdev, struct tcw *tcw,
+				    unsigned long intparm, u8 lpm, u8 key,
+				    int expires)
+{
+	int ret;
+
+	ccw_device_set_timeout(cdev, expires);
+	ret = ccw_device_tm_start_key(cdev, tcw, intparm, lpm, key);
+	if (ret != 0)
+		ccw_device_set_timeout(cdev, 0);
+	return ret;
+}
+EXPORT_SYMBOL(ccw_device_tm_start_timeout_key);
+
+/**
+ * ccw_device_tm_start - perform start function
+ * @cdev: ccw device on which to perform the start function
+ * @tcw: transport-command word to be started
+ * @intparm: user defined parameter to be passed to the interrupt handler
+ * @lpm: mask of paths to use
+ *
+ * Start the tcw on the given ccw device. Return zero on success, non-zero
+ * otherwise.
+ */
+int ccw_device_tm_start(struct ccw_device *cdev, struct tcw *tcw,
+			unsigned long intparm, u8 lpm)
+{
+	return ccw_device_tm_start_key(cdev, tcw, intparm, lpm,
+				       PAGE_DEFAULT_KEY);
+}
+EXPORT_SYMBOL(ccw_device_tm_start);
+
+/**
+ * ccw_device_tm_start_timeout - perform start function
+ * @cdev: ccw device on which to perform the start function
+ * @tcw: transport-command word to be started
+ * @intparm: user defined parameter to be passed to the interrupt handler
+ * @lpm: mask of paths to use
+ * @expires: time span in jiffies after which to abort request
+ *
+ * Start the tcw on the given ccw device. Return zero on success, non-zero
+ * otherwise.
+ */
+int ccw_device_tm_start_timeout(struct ccw_device *cdev, struct tcw *tcw,
+			       unsigned long intparm, u8 lpm, int expires)
+{
+	return ccw_device_tm_start_timeout_key(cdev, tcw, intparm, lpm,
+					       PAGE_DEFAULT_KEY, expires);
+}
+EXPORT_SYMBOL(ccw_device_tm_start_timeout);
+
+/**
+ * ccw_device_tm_intrg - perform interrogate function
+ * @cdev: ccw device on which to perform the interrogate function
+ *
+ * Perform an interrogate function on the given ccw device. Return zero on
+ * success, non-zero otherwise.
+ */
+int ccw_device_tm_intrg(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		return -EIO;
+	if (!scsw_is_tm(&sch->schib.scsw) ||
+	    !(scsw_actl(&sch->schib.scsw) | SCSW_ACTL_START_PEND))
+		return -EINVAL;
+	return cio_tm_intrg(sch);
+}
+EXPORT_SYMBOL(ccw_device_tm_intrg);
+
 // FIXME: these have to go:
 
 int
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c
+++ quilt-2.6/drivers/s390/cio/device_pgid.c
@@ -158,7 +158,7 @@ __ccw_device_check_sense_pgid(struct ccw
 	if (irb->scsw.cmd.cc == 3) {
 		u8 lpm;
 
-		lpm = to_io_private(sch)->orb.lpm;
+		lpm = to_io_private(sch)->orb.cmd.lpm;
 		CIO_MSG_EVENT(3, "SNID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
Index: quilt-2.6/drivers/s390/cio/fcx.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/fcx.c
@@ -0,0 +1,350 @@
+/*
+ *  Functions for assembling fcx enabled I/O control blocks.
+ *
+ *    Copyright IBM Corp. 2008
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <asm/fcx.h>
+#include "cio.h"
+
+/**
+ * tcw_get_intrg - return pointer to associated interrogate tcw
+ * @tcw: pointer to the original tcw
+ *
+ * Return a pointer to the interrogate tcw associated with the specified tcw
+ * or %NULL if there is no associated interrogate tcw.
+ */
+struct tcw *tcw_get_intrg(struct tcw *tcw)
+{
+	return (struct tcw *) ((addr_t) tcw->intrg);
+}
+EXPORT_SYMBOL(tcw_get_intrg);
+
+/**
+ * tcw_get_data - return pointer to input/output data associated with tcw
+ * @tcw: pointer to the tcw
+ *
+ * Return the input or output data address specified in the tcw depending
+ * on whether the r-bit or the w-bit is set. If neither bit is set, return
+ * %NULL.
+ */
+void *tcw_get_data(struct tcw *tcw)
+{
+	if (tcw->r)
+		return (void *) ((addr_t) tcw->input);
+	if (tcw->w)
+		return (void *) ((addr_t) tcw->output);
+	return NULL;
+}
+EXPORT_SYMBOL(tcw_get_data);
+
+/**
+ * tcw_get_tccb - return pointer to tccb associated with tcw
+ * @tcw: pointer to the tcw
+ *
+ * Return pointer to the tccb associated with this tcw.
+ */
+struct tccb *tcw_get_tccb(struct tcw *tcw)
+{
+	return (struct tccb *) ((addr_t) tcw->tccb);
+}
+EXPORT_SYMBOL(tcw_get_tccb);
+
+/**
+ * tcw_get_tsb - return pointer to tsb associated with tcw
+ * @tcw: pointer to the tcw
+ *
+ * Return pointer to the tsb associated with this tcw.
+ */
+struct tsb *tcw_get_tsb(struct tcw *tcw)
+{
+	return (struct tsb *) ((addr_t) tcw->tsb);
+}
+EXPORT_SYMBOL(tcw_get_tsb);
+
+/**
+ * tcw_init - initialize tcw data structure
+ * @tcw: pointer to the tcw to be initialized
+ * @r: initial value of the r-bit
+ * @w: initial value of the w-bit
+ *
+ * Initialize all fields of the specified tcw data structure with zero and
+ * fill in the format, flags, r and w fields.
+ */
+void tcw_init(struct tcw *tcw, int r, int w)
+{
+	memset(tcw, 0, sizeof(struct tcw));
+	tcw->format = TCW_FORMAT_DEFAULT;
+	tcw->flags = TCW_FLAGS_TIDAW_FORMAT(TCW_TIDAW_FORMAT_DEFAULT);
+	if (r)
+		tcw->r = 1;
+	if (w)
+		tcw->w = 1;
+}
+EXPORT_SYMBOL(tcw_init);
+
+static inline size_t tca_size(struct tccb *tccb)
+{
+	return tccb->tcah.tcal - 12;
+}
+
+static u32 calc_dcw_count(struct tccb *tccb)
+{
+	int offset;
+	struct dcw *dcw;
+	u32 count = 0;
+	size_t size;
+
+	size = tca_size(tccb);
+	for (offset = 0; offset < size;) {
+		dcw = (struct dcw *) &tccb->tca[offset];
+		count += dcw->count;
+		if (!(dcw->flags & DCW_FLAGS_CC))
+			break;
+		offset += sizeof(struct dcw) + ALIGN((int) dcw->cd_count, 4);
+	}
+	return count;
+}
+
+static u32 calc_cbc_size(struct tidaw *tidaw, int num)
+{
+	int i;
+	u32 cbc_data;
+	u32 cbc_count = 0;
+	u64 data_count = 0;
+
+	for (i = 0; i < num; i++) {
+		if (tidaw[i].flags & TIDAW_FLAGS_LAST)
+			break;
+		/* TODO: find out if padding applies to total of data
+		 * transferred or data transferred by this tidaw. Assumption:
+		 * applies to total. */
+		data_count += tidaw[i].count;
+		if (tidaw[i].flags & TIDAW_FLAGS_INSERT_CBC) {
+			cbc_data = 4 + ALIGN(data_count, 4) - data_count;
+			cbc_count += cbc_data;
+			data_count += cbc_data;
+		}
+	}
+	return cbc_count;
+}
+
+/**
+ * tcw_finalize - finalize tcw length fields and tidaw list
+ * @tcw: pointer to the tcw
+ * @num_tidaws: the number of tidaws used to address input/output data or zero
+ * if no tida is used
+ *
+ * Calculate the input-/output-count and tccbl field in the tcw, add a
+ * tcat the tccb and terminate the data tidaw list if used.
+ *
+ * Note: in case input- or output-tida is used, the tidaw-list must be stored
+ * in contiguous storage (no ttic). The tcal field in the tccb must be
+ * up-to-date.
+ */
+void tcw_finalize(struct tcw *tcw, int num_tidaws)
+{
+	struct tidaw *tidaw;
+	struct tccb *tccb;
+	struct tccb_tcat *tcat;
+	u32 count;
+
+	/* Terminate tidaw list. */
+	tidaw = tcw_get_data(tcw);
+	if (num_tidaws > 0)
+		tidaw[num_tidaws - 1].flags |= TIDAW_FLAGS_LAST;
+	/* Add tcat to tccb. */
+	tccb = tcw_get_tccb(tcw);
+	tcat = (struct tccb_tcat *) &tccb->tca[tca_size(tccb)];
+	memset(tcat, 0, sizeof(tcat));
+	/* Calculate tcw input/output count and tcat transport count. */
+	count = calc_dcw_count(tccb);
+	if (tcw->w && (tcw->flags & TCW_FLAGS_OUTPUT_TIDA))
+		count += calc_cbc_size(tidaw, num_tidaws);
+	if (tcw->r)
+		tcw->input_count = count;
+	else if (tcw->w)
+		tcw->output_count = count;
+	tcat->count = ALIGN(count, 4) + 4;
+	/* Calculate tccbl. */
+	tcw->tccbl = (sizeof(struct tccb) + tca_size(tccb) +
+		      sizeof(struct tccb_tcat) - 20) >> 2;
+}
+EXPORT_SYMBOL(tcw_finalize);
+
+/**
+ * tcw_set_intrg - set the interrogate tcw address of a tcw
+ * @tcw: the tcw address
+ * @intrg_tcw: the address of the interrogate tcw
+ *
+ * Set the address of the interrogate tcw in the specified tcw.
+ */
+void tcw_set_intrg(struct tcw *tcw, struct tcw *intrg_tcw)
+{
+	tcw->intrg = (u32) ((addr_t) intrg_tcw);
+}
+EXPORT_SYMBOL(tcw_set_intrg);
+
+/**
+ * tcw_set_data - set data address and tida flag of a tcw
+ * @tcw: the tcw address
+ * @data: the data address
+ * @use_tidal: zero of the data address specifies a contiguous block of data,
+ * non-zero if it specifies a list if tidaws.
+ *
+ * Set the input/output data address of a tcw (depending on the value of the
+ * r-flag and w-flag). If @use_tidal is non-zero, the corresponding tida flag
+ * is set as well.
+ */
+void tcw_set_data(struct tcw *tcw, void *data, int use_tidal)
+{
+	if (tcw->r) {
+		tcw->input = (u64) ((addr_t) data);
+		if (use_tidal)
+			tcw->flags |= TCW_FLAGS_INPUT_TIDA;
+	} else if (tcw->w) {
+		tcw->output = (u64) ((addr_t) data);
+		if (use_tidal)
+			tcw->flags |= TCW_FLAGS_OUTPUT_TIDA;
+	}
+}
+EXPORT_SYMBOL(tcw_set_data);
+
+/**
+ * tcw_set_tccb - set tccb address of a tcw
+ * @tcw: the tcw address
+ * @tccb: the tccb address
+ *
+ * Set the address of the tccb in the specified tcw.
+ */
+void tcw_set_tccb(struct tcw *tcw, struct tccb *tccb)
+{
+	tcw->tccb = (u64) ((addr_t) tccb);
+}
+EXPORT_SYMBOL(tcw_set_tccb);
+
+/**
+ * tcw_set_tsb - set tsb address of a tcw
+ * @tcw: the tcw address
+ * @tsb: the tsb address
+ *
+ * Set the address of the tsb in the specified tcw.
+ */
+void tcw_set_tsb(struct tcw *tcw, struct tsb *tsb)
+{
+	tcw->tsb = (u64) ((addr_t) tsb);
+}
+EXPORT_SYMBOL(tcw_set_tsb);
+
+/**
+ * tccb_init - initialize tccb
+ * @tccb: the tccb address
+ * @size: the maximum size of the tccb
+ * @sac: the service-action-code to be user
+ *
+ * Initialize the header of the specified tccb by resetting all values to zero
+ * and filling in defaults for format, sac and initial tcal fields.
+ */
+void tccb_init(struct tccb *tccb, size_t size, u32 sac)
+{
+	memset(tccb, 0, size);
+	tccb->tcah.format = TCCB_FORMAT_DEFAULT;
+	tccb->tcah.sac = sac;
+	tccb->tcah.tcal = 12;
+}
+EXPORT_SYMBOL(tccb_init);
+
+/**
+ * tsb_init - initialize tsb
+ * @tsb: the tsb address
+ *
+ * Initialize the specified tsb by resetting all values to zero.
+ */
+void tsb_init(struct tsb *tsb)
+{
+	memset(tsb, 0, sizeof(tsb));
+}
+EXPORT_SYMBOL(tsb_init);
+
+/**
+ * tccb_add_dcw - add a dcw to the tccb
+ * @tccb: the tccb address
+ * @tccb_size: the maximum tccb size
+ * @cmd: the dcw command
+ * @flags: flags for the dcw
+ * @cd: pointer to control data for this dcw or NULL if none is required
+ * @cd_count: number of control data bytes for this dcw
+ * @count: number of data bytes for this dcw
+ *
+ * Add a new dcw to the specified tccb by writing the dcw information specified
+ * by @cmd, @flags, @cd, @cd_count and @count to the tca of the tccb. Return
+ * a pointer to the newly added dcw on success or -%ENOSPC if the new dcw
+ * would exceed the available space as defined by @tccb_size.
+ *
+ * Note: the tcal field of the tccb header will be updates to reflect added
+ * content.
+ */
+struct dcw *tccb_add_dcw(struct tccb *tccb, size_t tccb_size, u8 cmd, u8 flags,
+			 void *cd, u8 cd_count, u32 count)
+{
+	struct dcw *dcw;
+	int size;
+	int tca_offset;
+
+	/* Check for space. */
+	tca_offset = tca_size(tccb);
+	size = ALIGN(sizeof(struct dcw) + cd_count, 4);
+	if (sizeof(struct tccb_tcah) + tca_offset + size +
+	    sizeof(struct tccb_tcat) > tccb_size)
+		return ERR_PTR(-ENOSPC);
+	/* Add dcw to tca. */
+	dcw = (struct dcw *) &tccb->tca[tca_offset];
+	memset(dcw, 0, size);
+	dcw->cmd = cmd;
+	dcw->flags = flags;
+	dcw->count = count;
+	dcw->cd_count = cd_count;
+	if (cd)
+		memcpy(&dcw->cd[0], cd, cd_count);
+	tccb->tcah.tcal += size;
+	return dcw;
+}
+EXPORT_SYMBOL(tccb_add_dcw);
+
+/**
+ * tcw_add_tidaw - add a tidaw to a tcw
+ * @tcw: the tcw address
+ * @num_tidaws: the current number of tidaws
+ * @flags: flags for the new tidaw
+ * @addr: address value for the new tidaw
+ * @count: count value for the new tidaw
+ *
+ * Add a new tidaw to the input/output data tidaw-list of the specified tcw
+ * (depending on the value of the r-flag and w-flag) and return a pointer to
+ * the new tidaw.
+ *
+ * Note: the tidaw-list is assumed to be contiguous with no ttics. The caller
+ * must ensure that there is enough space for the new tidaw. The last-tidaw
+ * flag for the last tidaw in the list will be set by tcw_finalize.
+ */
+struct tidaw *tcw_add_tidaw(struct tcw *tcw, int num_tidaws, u8 flags,
+			    void *addr, u32 count)
+{
+	struct tidaw *tidaw;
+
+	/* Add tidaw to tidaw-list. */
+	tidaw = ((struct tidaw *) tcw_get_data(tcw)) + num_tidaws;
+	memset(tidaw, 0, sizeof(struct tidaw));
+	tidaw->flags = flags;
+	tidaw->count = count;
+	tidaw->addr = (u64) ((addr_t) addr);
+	return tidaw;
+}
+EXPORT_SYMBOL(tcw_add_tidaw);
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h
+++ quilt-2.6/drivers/s390/cio/io_sch.h
@@ -4,9 +4,9 @@
 #include "schid.h"
 
 /*
- * operation request block
+ * command-mode operation request block
  */
-struct orb {
+struct cmd_orb {
 	u32 intparm;	/* interruption parameter */
 	u32 key  : 4;	/* flags, like key, suspend control, etc. */
 	u32 spnd : 1;	/* suspend control */
@@ -28,8 +28,36 @@ struct orb {
 	u32 cpa;	/* channel program address */
 }  __attribute__ ((packed, aligned(4)));
 
+/*
+ * transport-mode operation request block
+ */
+struct tm_orb {
+	u32 intparm;
+	u32 key:4;
+	u32 :9;
+	u32 b:1;
+	u32 :2;
+	u32 lpm:8;
+	u32 :7;
+	u32 x:1;
+	u32 tcw;
+	u32 prio:8;
+	u32 :8;
+	u32 rsvpgm:8;
+	u32 :8;
+	u32 :32;
+	u32 :32;
+	u32 :32;
+	u32 :32;
+}  __attribute__ ((packed, aligned(4)));
+
+union orb {
+	struct cmd_orb cmd;
+	struct tm_orb tm;
+}  __attribute__ ((packed, aligned(4)));
+
 struct io_subchannel_private {
-	struct orb orb;		/* operation request block */
+	union orb orb;		/* operation request block */
 	struct ccw1 sense_ccw;	/* static ccw for sense command */
 } __attribute__ ((aligned(8)));
 
@@ -95,16 +123,18 @@ struct ccw_device_private {
 	void *cmb_wait;			/* deferred cmb enable/disable */
 };
 
-static inline int ssch(struct subchannel_id schid, volatile struct orb *addr)
+static inline int ssch(struct subchannel_id schid, volatile union orb *addr)
 {
 	register struct subchannel_id reg1 asm("1") = schid;
-	int ccode;
+	int ccode = -EIO;
 
 	asm volatile(
 		"	ssch	0(%2)\n"
-		"	ipm	%0\n"
-		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "+d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
 	return ccode;
 }
 
Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile
+++ quilt-2.6/drivers/s390/cio/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the S/390 common i/o drivers
 #
 
-obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o scsw.o
+obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o scsw.o fcx.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
Index: quilt-2.6/include/asm-s390/ccwdev.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ccwdev.h
+++ quilt-2.6/include/asm-s390/ccwdev.h
@@ -12,6 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <asm/fcx.h>
 
 /* structs from asm/cio.h */
 struct irb;
@@ -157,6 +158,17 @@ extern int ccw_device_start_timeout_key(
 extern int ccw_device_resume(struct ccw_device *);
 extern int ccw_device_halt(struct ccw_device *, unsigned long);
 extern int ccw_device_clear(struct ccw_device *, unsigned long);
+int ccw_device_tm_start_key(struct ccw_device *cdev, struct tcw *tcw,
+			    unsigned long intparm, u8 lpm, u8 key);
+int ccw_device_tm_start_key(struct ccw_device *, struct tcw *,
+			    unsigned long, u8, u8);
+int ccw_device_tm_start_timeout_key(struct ccw_device *, struct tcw *,
+			    unsigned long, u8, u8, int);
+int ccw_device_tm_start(struct ccw_device *, struct tcw *,
+			    unsigned long, u8);
+int ccw_device_tm_start_timeout(struct ccw_device *, struct tcw *,
+			    unsigned long, u8, int);
+int ccw_device_tm_intrg(struct ccw_device *cdev);
 
 extern int ccw_device_set_online(struct ccw_device *cdev);
 extern int ccw_device_set_offline(struct ccw_device *cdev);
Index: quilt-2.6/include/asm-s390/fcx.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/fcx.h
@@ -0,0 +1,311 @@
+/*
+ *  Functions for assembling fcx enabled I/O control blocks.
+ *
+ *    Copyright IBM Corp. 2008
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_FCX_H
+#define _ASM_S390_FCX_H _ASM_S390_FCX_H
+
+#include <linux/types.h>
+
+#define TCW_FORMAT_DEFAULT		0
+#define TCW_TIDAW_FORMAT_DEFAULT	0
+#define TCW_FLAGS_INPUT_TIDA		1 << (23 - 5)
+#define TCW_FLAGS_TCCB_TIDA		1 << (23 - 6)
+#define TCW_FLAGS_OUTPUT_TIDA		1 << (23 - 7)
+#define TCW_FLAGS_TIDAW_FORMAT(x)	((x) & 3) << (23 - 9)
+#define TCW_FLAGS_GET_TIDAW_FORMAT(x)	(((x) >> (23 - 9)) & 3)
+
+/**
+ * struct tcw - Transport Control Word (TCW)
+ * @format: TCW format
+ * @flags: TCW flags
+ * @tccbl: Transport-Command-Control-Block Length
+ * @r: Read Operations
+ * @w: Write Operations
+ * @output: Output-Data Address
+ * @input: Input-Data Address
+ * @tsb: Transport-Status-Block Address
+ * @tccb: Transport-Command-Control-Block Address
+ * @output_count: Output Count
+ * @input_count: Input Count
+ * @intrg: Interrogate TCW Address
+ */
+struct tcw {
+	u32 format:2;
+	u32 :6;
+	u32 flags:24;
+	u32 :8;
+	u32 tccbl:6;
+	u32 r:1;
+	u32 w:1;
+	u32 :16;
+	u64 output;
+	u64 input;
+	u64 tsb;
+	u64 tccb;
+	u32 output_count;
+	u32 input_count;
+	u32 :32;
+	u32 :32;
+	u32 :32;
+	u32 intrg;
+} __attribute__ ((packed, aligned(64)));
+
+#define TIDAW_FLAGS_LAST		1 << (7 - 0)
+#define TIDAW_FLAGS_SKIP		1 << (7 - 1)
+#define TIDAW_FLAGS_DATA_INT		1 << (7 - 2)
+#define TIDAW_FLAGS_TTIC		1 << (7 - 3)
+#define TIDAW_FLAGS_INSERT_CBC		1 << (7 - 4)
+
+/**
+ * struct tidaw - Transport-Indirect-Addressing Word (TIDAW)
+ * @flags: TIDAW flags. Can be an arithmetic OR of the following constants:
+ * %TIDAW_FLAGS_LAST, %TIDAW_FLAGS_SKIP, %TIDAW_FLAGS_DATA_INT,
+ * %TIDAW_FLAGS_TTIC, %TIDAW_FLAGS_INSERT_CBC
+ * @count: Count
+ * @addr: Address
+ */
+struct tidaw {
+	u32 flags:8;
+	u32 :24;
+	u32 count;
+	u64 addr;
+} __attribute__ ((packed, aligned(16)));
+
+/**
+ * struct tsa_iostat - I/O-Status Transport-Status Area (IO-Stat TSA)
+ * @dev_time: Device Time
+ * @def_time: Defer Time
+ * @queue_time: Queue Time
+ * @dev_busy_time: Device-Busy Time
+ * @dev_act_time: Device-Active-Only Time
+ * @sense: Sense Data (if present)
+ */
+struct tsa_iostat {
+	u32 dev_time;
+	u32 def_time;
+	u32 queue_time;
+	u32 dev_busy_time;
+	u32 dev_act_time;
+	u8 sense[32];
+} __attribute__ ((packed));
+
+/**
+ * struct tsa_ddpcs - Device-Detected-Program-Check Transport-Status Area (DDPC TSA)
+ * @rc: Reason Code
+ * @rcq: Reason Code Qualifier
+ * @sense: Sense Data (if present)
+ */
+struct tsa_ddpc {
+	u32 :24;
+	u32 rc:8;
+	u8 rcq[16];
+	u8 sense[32];
+} __attribute__ ((packed));
+
+#define TSA_INTRG_FLAGS_CU_STATE_VALID		1 << (7 - 0)
+#define TSA_INTRG_FLAGS_DEV_STATE_VALID		1 << (7 - 1)
+#define TSA_INTRG_FLAGS_OP_STATE_VALID		1 << (7 - 2)
+
+/**
+ * struct tsa_intrg - Interrogate Transport-Status Area (Intrg. TSA)
+ * @format: Format
+ * @flags: Flags. Can be an arithmetic OR of the following constants:
+ * %TSA_INTRG_FLAGS_CU_STATE_VALID, %TSA_INTRG_FLAGS_DEV_STATE_VALID,
+ * %TSA_INTRG_FLAGS_OP_STATE_VALID
+ * @cu_state: Controle-Unit State
+ * @dev_state: Device State
+ * @op_state: Operation State
+ * @sd_info: State-Dependent Information
+ * @dl_id: Device-Level Identifier
+ * @dd_data: Device-Dependent Data
+ */
+struct tsa_intrg {
+	u32 format:8;
+	u32 flags:8;
+	u32 cu_state:8;
+	u32 dev_state:8;
+	u32 op_state:8;
+	u32 :24;
+	u8 sd_info[12];
+	u32 dl_id;
+	u8 dd_data[28];
+} __attribute__ ((packed));
+
+#define TSB_FORMAT_NONE		0
+#define TSB_FORMAT_IOSTAT	1
+#define TSB_FORMAT_DDPC		2
+#define TSB_FORMAT_INTRG	3
+
+#define TSB_FLAGS_DCW_OFFSET_VALID	1 << (7 - 0)
+#define TSB_FLAGS_COUNT_VALID		1 << (7 - 1)
+#define TSB_FLAGS_CACHE_MISS		1 << (7 - 2)
+#define TSB_FLAGS_TIME_VALID		1 << (7 - 3)
+#define TSB_FLAGS_FORMAT(x)		((x) & 7)
+#define TSB_FORMAT(t)			((t)->flags & 7)
+
+/**
+ * struct tsb - Transport-Status Block (TSB)
+ * @length: Length
+ * @flags: Flags. Can be an arithmetic OR of the following constants:
+ * %TSB_FLAGS_DCW_OFFSET_VALID, %TSB_FLAGS_COUNT_VALID, %TSB_FLAGS_CACHE_MISS,
+ * %TSB_FLAGS_TIME_VALID
+ * @dcw_offset: DCW Offset
+ * @count: Count
+ * @tsa: Transport-Status-Area
+ */
+struct tsb {
+	u32 length:8;
+	u32 flags:8;
+	u32 dcw_offset:16;
+	u32 count;
+	u32 :32;
+	union {
+		struct tsa_iostat iostat;
+		struct tsa_ddpc ddpc;
+		struct tsa_intrg intrg;
+	} __attribute__ ((packed)) tsa;
+} __attribute__ ((packed, aligned(8)));
+
+#define DCW_INTRG_FORMAT_DEFAULT	0
+
+#define DCW_INTRG_RC_UNSPECIFIED	0
+#define DCW_INTRG_RC_TIMEOUT		1
+
+#define DCW_INTRG_RCQ_UNSPECIFIED	0
+#define DCW_INTRG_RCQ_PRIMARY		1
+#define DCW_INTRG_RCQ_SECONDARY		2
+
+#define DCW_INTRG_FLAGS_MPM		1 < (7 - 0)
+#define DCW_INTRG_FLAGS_PPR		1 < (7 - 1)
+#define DCW_INTRG_FLAGS_CRIT		1 < (7 - 2)
+
+/**
+ * struct dcw_intrg_data - Interrogate DCW data
+ * @format: Format. Should be %DCW_INTRG_FORMAT_DEFAULT
+ * @rc: Reason Code. Can be one of %DCW_INTRG_RC_UNSPECIFIED,
+ * %DCW_INTRG_RC_TIMEOUT
+ * @rcq: Reason Code Qualifier: Can be one of %DCW_INTRG_RCQ_UNSPECIFIED,
+ * %DCW_INTRG_RCQ_PRIMARY, %DCW_INTRG_RCQ_SECONDARY
+ * @lpm: Logical-Path Mask
+ * @pam: Path-Available Mask
+ * @pim: Path-Installed Mask
+ * @timeout: Timeout
+ * @flags: Flags. Can be an arithmetic OR of %DCW_INTRG_FLAGS_MPM,
+ * %DCW_INTRG_FLAGS_PPR, %DCW_INTRG_FLAGS_CRIT
+ * @time: Time
+ * @prog_id: Program Identifier
+ * @prog_data: Program-Dependent Data
+ */
+struct dcw_intrg_data {
+	u32 format:8;
+	u32 rc:8;
+	u32 rcq:8;
+	u32 lpm:8;
+	u32 pam:8;
+	u32 pim:8;
+	u32 timeout:16;
+	u32 flags:8;
+	u32 :24;
+	u32 :32;
+	u64 time;
+	u64 prog_id;
+	u8  prog_data[0];
+} __attribute__ ((packed));
+
+#define DCW_FLAGS_CC		1 << (7 - 1)
+
+#define DCW_CMD_WRITE		0x01
+#define DCW_CMD_READ		0x02
+#define DCW_CMD_CONTROL		0x03
+#define DCW_CMD_SENSE		0x04
+#define DCW_CMD_SENSE_ID	0xe4
+#define DCW_CMD_INTRG		0x40
+
+/**
+ * struct dcw - Device-Command Word (DCW)
+ * @cmd: Command Code. Can be one of %DCW_CMD_WRITE, %DCW_CMD_READ,
+ * %DCW_CMD_CONTROL, %DCW_CMD_SENSE, %DCW_CMD_SENSE_ID, %DCW_CMD_INTRG
+ * @flags: Flags. Can be an arithmetic OR of %DCW_FLAGS_CC
+ * @cd_count: Control-Data Count
+ * @count: Count
+ * @cd: Control Data
+ */
+struct dcw {
+	u32 cmd:8;
+	u32 flags:8;
+	u32 :8;
+	u32 cd_count:8;
+	u32 count;
+	u8 cd[0];
+} __attribute__ ((packed));
+
+#define TCCB_FORMAT_DEFAULT	0x7f
+#define TCCB_MAX_DCW		30
+#define TCCB_MAX_SIZE		(sizeof(struct tccb_tcah) + \
+				 TCCB_MAX_DCW * sizeof(struct dcw) + \
+				 sizeof(struct tccb_tcat))
+#define TCCB_SAC_DEFAULT	0xf901
+#define TCCB_SAC_INTRG		0xf902
+
+/**
+ * struct tccb_tcah - Transport-Command-Area Header (TCAH)
+ * @format: Format. Should be %TCCB_FORMAT_DEFAULT
+ * @tcal: Transport-Command-Area Length
+ * @sac: Service-Action Code. Can be one of %TCCB_SAC_DEFAULT, %TCCB_SAC_INTRG
+ * @prio: Priority
+ */
+struct tccb_tcah {
+	u32 format:8;
+	u32 :24;
+	u32 :24;
+	u32 tcal:8;
+	u32 sac:16;
+	u32 :8;
+	u32 prio:8;
+	u32 :32;
+} __attribute__ ((packed));
+
+/**
+ * struct tccb_tcat - Transport-Command-Area Trailer (TCAT)
+ * @count: Transport Count
+ */
+struct tccb_tcat {
+	u32 :32;
+	u32 count;
+} __attribute__ ((packed));
+
+/**
+ * struct tccb - (partial) Transport-Command-Control Block (TCCB)
+ * @tcah: TCAH
+ * @tca: Transport-Command Area
+ */
+struct tccb {
+	struct tccb_tcah tcah;
+	u8 tca[0];
+} __attribute__ ((packed, aligned(8)));
+
+struct tcw *tcw_get_intrg(struct tcw *tcw);
+void *tcw_get_data(struct tcw *tcw);
+struct tccb *tcw_get_tccb(struct tcw *tcw);
+struct tsb *tcw_get_tsb(struct tcw *tcw);
+
+void tcw_init(struct tcw *tcw, int r, int w);
+void tcw_finalize(struct tcw *tcw, int num_tidaws);
+
+void tcw_set_intrg(struct tcw *tcw, struct tcw *intrg_tcw);
+void tcw_set_data(struct tcw *tcw, void *data, int use_tidal);
+void tcw_set_tccb(struct tcw *tcw, struct tccb *tccb);
+void tcw_set_tsb(struct tcw *tcw, struct tsb *tsb);
+
+void tccb_init(struct tccb *tccb, size_t tccb_size, u32 sac);
+void tsb_init(struct tsb *tsb);
+struct dcw *tccb_add_dcw(struct tccb *tccb, size_t tccb_size, u8 cmd, u8 flags,
+			 void *cd, u8 cd_count, u32 count);
+struct tidaw *tcw_add_tidaw(struct tcw *tcw, int num_tidaws, u8 flags,
+			    void *addr, u32 count);
+
+#endif /* _ASM_S390_FCX_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
