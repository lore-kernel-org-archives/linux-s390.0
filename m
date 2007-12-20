Return-Path: <linux-kernel-owner+w=401wt.eu-S937354AbXLTPoo@vger.kernel.org>
Message-Id: <20071220152104.657917362@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/47] cio: Introduce subchannel->private.
Content-Disposition: inline; filename=107-cio-private.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Introduce a private pointer in struct subchannel to store
per-subchannel type data (cannot use dev->priv since this
is already used for something else).

Create a new header io_sch.h for I/O subchannel specific structures
and instructions.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c           |   43 ++++++----
 drivers/s390/cio/cio.h           |   84 +++++++-------------
 drivers/s390/cio/css.c           |    2 
 drivers/s390/cio/css.h           |   58 --------------
 drivers/s390/cio/device.c        |   16 +++
 drivers/s390/cio/device.h        |    2 
 drivers/s390/cio/device_fsm.c    |   13 +--
 drivers/s390/cio/device_id.c     |    9 +-
 drivers/s390/cio/device_pgid.c   |    6 +
 drivers/s390/cio/device_status.c |   13 +--
 drivers/s390/cio/io_sch.h        |  161 +++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/ioasm.h         |   66 ---------------
 12 files changed, 261 insertions(+), 212 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -28,6 +28,7 @@
 #include "css.h"
 #include "chsc.h"
 #include "ioasm.h"
+#include "io_sch.h"
 #include "blacklist.h"
 #include "cio_debug.h"
 #include "chp.h"
@@ -182,33 +183,35 @@ cio_start_key (struct subchannel *sch,	/
 {
 	char dbf_txt[15];
 	int ccode;
+	struct orb *orb;
 
-	CIO_TRACE_EVENT (4, "stIO");
-	CIO_TRACE_EVENT (4, sch->dev.bus_id);
+	CIO_TRACE_EVENT(4, "stIO");
+	CIO_TRACE_EVENT(4, sch->dev.bus_id);
 
+	orb = &to_io_private(sch)->orb;
 	/* sch is always under 2G. */
-	sch->orb.intparm = (__u32)(unsigned long)sch;
-	sch->orb.fmt = 1;
+	orb->intparm = (u32)(addr_t)sch;
+	orb->fmt = 1;
 
-	sch->orb.pfch = sch->options.prefetch == 0;
-	sch->orb.spnd = sch->options.suspend;
-	sch->orb.ssic = sch->options.suspend && sch->options.inter;
-	sch->orb.lpm = (lpm != 0) ? lpm : sch->lpm;
+	orb->pfch = sch->options.prefetch == 0;
+	orb->spnd = sch->options.suspend;
+	orb->ssic = sch->options.suspend && sch->options.inter;
+	orb->lpm = (lpm != 0) ? lpm : sch->lpm;
 #ifdef CONFIG_64BIT
 	/*
 	 * for 64 bit we always support 64 bit IDAWs with 4k page size only
 	 */
-	sch->orb.c64 = 1;
-	sch->orb.i2k = 0;
+	orb->c64 = 1;
+	orb->i2k = 0;
 #endif
-	sch->orb.key = key >> 4;
+	orb->key = key >> 4;
 	/* issue "Start Subchannel" */
-	sch->orb.cpa = (__u32) __pa (cpa);
-	ccode = ssch (sch->schid, &sch->orb);
+	orb->cpa = (__u32) __pa(cpa);
+	ccode = ssch(sch->schid, orb);
 
 	/* process condition code */
-	sprintf (dbf_txt, "ccode:%d", ccode);
-	CIO_TRACE_EVENT (4, dbf_txt);
+	sprintf(dbf_txt, "ccode:%d", ccode);
+	CIO_TRACE_EVENT(4, dbf_txt);
 
 	switch (ccode) {
 	case 0:
@@ -423,7 +426,7 @@ cio_enable_subchannel (struct subchannel
 	for (retry = 5, ret = 0; retry > 0; retry--) {
 		sch->schib.pmcw.ena = 1;
 		sch->schib.pmcw.isc = isc;
-		sch->schib.pmcw.intparm = (__u32)(unsigned long)sch;
+		sch->schib.pmcw.intparm = (u32)(addr_t)sch;
 		ret = cio_modify(sch);
 		if (ret == -ENODEV)
 			break;
@@ -696,8 +699,14 @@ do_IRQ (struct pt_regs *regs)
 
 #ifdef CONFIG_CCW_CONSOLE
 static struct subchannel console_subchannel;
+static struct io_subchannel_private console_priv;
 static int console_subchannel_in_use;
 
+void *cio_get_console_priv(void)
+{
+	return &console_priv;
+}
+
 /*
  * busy wait for the next interrupt on the console
  */
@@ -802,7 +811,7 @@ cio_probe_console(void)
 	ctl_set_bit(6, 24);
 	console_subchannel.schib.pmcw.isc = 7;
 	console_subchannel.schib.pmcw.intparm =
-		(__u32)(unsigned long)&console_subchannel;
+		(u32)(addr_t)&console_subchannel;
 	ret = cio_modify(&console_subchannel);
 	if (ret) {
 		console_subchannel_in_use = 0;
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -11,32 +11,32 @@
  * path management control word
  */
 struct pmcw {
-	__u32 intparm;		/* interruption parameter */
-	__u32 qf   : 1;		/* qdio facility */
-	__u32 res0 : 1;		/* reserved zeros */
-	__u32 isc  : 3;		/* interruption sublass */
-	__u32 res5 : 3;		/* reserved zeros */
-	__u32 ena  : 1;		/* enabled */
-	__u32 lm   : 2;		/* limit mode */
-	__u32 mme  : 2;		/* measurement-mode enable */
-	__u32 mp   : 1;		/* multipath mode */
-	__u32 tf   : 1;		/* timing facility */
-	__u32 dnv  : 1;		/* device number valid */
-	__u32 dev  : 16;	/* device number */
-	__u8  lpm;		/* logical path mask */
-	__u8  pnom;		/* path not operational mask */
-	__u8  lpum;		/* last path used mask */
-	__u8  pim;		/* path installed mask */
-	__u16 mbi;		/* measurement-block index */
-	__u8  pom;		/* path operational mask */
-	__u8  pam;		/* path available mask */
-	__u8  chpid[8];		/* CHPID 0-7 (if available) */
-	__u32 unused1 : 8;	/* reserved zeros */
-	__u32 st      : 3;	/* subchannel type */
-	__u32 unused2 : 18;	/* reserved zeros */
-	__u32 mbfc    : 1;      /* measurement block format control */
-	__u32 xmwme   : 1;      /* extended measurement word mode enable */
-	__u32 csense  : 1;	/* concurrent sense; can be enabled ...*/
+	u32 intparm;		/* interruption parameter */
+	u32 qf	 : 1;		/* qdio facility */
+	u32 res0 : 1;		/* reserved zeros */
+	u32 isc  : 3;		/* interruption sublass */
+	u32 res5 : 3;		/* reserved zeros */
+	u32 ena  : 1;		/* enabled */
+	u32 lm	 : 2;		/* limit mode */
+	u32 mme  : 2;		/* measurement-mode enable */
+	u32 mp	 : 1;		/* multipath mode */
+	u32 tf	 : 1;		/* timing facility */
+	u32 dnv  : 1;		/* device number valid */
+	u32 dev  : 16;		/* device number */
+	u8  lpm;		/* logical path mask */
+	u8  pnom;		/* path not operational mask */
+	u8  lpum;		/* last path used mask */
+	u8  pim;		/* path installed mask */
+	u16 mbi;		/* measurement-block index */
+	u8  pom;		/* path operational mask */
+	u8  pam;		/* path available mask */
+	u8  chpid[8];		/* CHPID 0-7 (if available) */
+	u32 unused1 : 8;	/* reserved zeros */
+	u32 st	    : 3;	/* subchannel type */
+	u32 unused2 : 18;	/* reserved zeros */
+	u32 mbfc    : 1;	/* measurement block format control */
+	u32 xmwme   : 1;	/* extended measurement word mode enable */
+	u32 csense  : 1;	/* concurrent sense; can be enabled ...*/
 				/*  ... per MSCH, however, if facility */
 				/*  ... is not installed, this results */
 				/*  ... in an operand exception.       */
@@ -52,31 +52,6 @@ struct schib {
 	__u8 mda[4];		 /* model dependent area */
 } __attribute__ ((packed,aligned(4)));
 
-/*
- * operation request block
- */
-struct orb {
-	__u32 intparm;		/* interruption parameter */
-	__u32 key  : 4; 	/* flags, like key, suspend control, etc. */
-	__u32 spnd : 1; 	/* suspend control */
-	__u32 res1 : 1; 	/* reserved */
-	__u32 mod  : 1; 	/* modification control */
-	__u32 sync : 1; 	/* synchronize control */
-	__u32 fmt  : 1; 	/* format control */
-	__u32 pfch : 1; 	/* prefetch control */
-	__u32 isic : 1; 	/* initial-status-interruption control */
-	__u32 alcc : 1; 	/* address-limit-checking control */
-	__u32 ssic : 1; 	/* suppress-suspended-interr. control */
-	__u32 res2 : 1; 	/* reserved */
-	__u32 c64  : 1; 	/* IDAW/QDIO 64 bit control  */
-	__u32 i2k  : 1; 	/* IDAW 2/4kB block size control */
-	__u32 lpm  : 8; 	/* logical path mask */
-	__u32 ils  : 1; 	/* incorrect length */
-	__u32 zero : 6; 	/* reserved zeros */
-	__u32 orbx : 1; 	/* ORB extension control */
-	__u32 cpa;		/* channel program address */
-}  __attribute__ ((packed,aligned(4)));
-
 /* subchannel data structure used by I/O subroutines */
 struct subchannel {
 	struct subchannel_id schid;
@@ -99,11 +74,10 @@ struct subchannel {
 	__u8 lpm;		/* logical path mask */
 	__u8 opm;               /* operational path mask */
 	struct schib schib;	/* subchannel information block */
-	struct orb orb;		/* operation request block */
-	struct ccw1 sense_ccw;	/* static ccw for sense command */
 	struct chsc_ssd_info ssd_info;	/* subchannel description */
 	struct device dev;	/* entry in device tree */
 	struct css_driver *driver;
+	void *private; /* private per subchannel type data */
 } __attribute__ ((aligned(8)));
 
 #define IO_INTERRUPT_TYPE	   0 /* I/O interrupt type */
@@ -133,10 +107,12 @@ extern void cio_release_console(void);
 extern int cio_is_console(struct subchannel_id);
 extern struct subchannel *cio_get_console_subchannel(void);
 extern spinlock_t * cio_get_console_lock(void);
+extern void *cio_get_console_priv(void);
 #else
 #define cio_is_console(schid) 0
 #define cio_get_console_subchannel() NULL
-#define cio_get_console_lock() NULL;
+#define cio_get_console_lock() NULL
+#define cio_get_console_priv() NULL
 #endif
 
 extern int cio_show_msg;
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -77,7 +77,7 @@ css_alloc_subchannel(struct subchannel_i
 	 * This is fine even on 64bit since the subchannel is always located
 	 * under 2G.
 	 */
-	sch->schib.pmcw.intparm = (__u32)(unsigned long)sch;
+	sch->schib.pmcw.intparm = (u32)(addr_t)sch;
 	ret = cio_modify(sch);
 	if (ret) {
 		kfree(sch->lock);
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -58,64 +58,6 @@ struct pgid {
 	__u32 tod_high;		/* high word TOD clock */
 } __attribute__ ((packed));
 
-#define MAX_CIWS 8
-
-/*
- * sense-id response buffer layout
- */
-struct senseid {
-	/* common part */
-	__u8  reserved;     	/* always 0x'FF' */
-	__u16 cu_type;	     	/* control unit type */
-	__u8  cu_model;     	/* control unit model */
-	__u16 dev_type;     	/* device type */
-	__u8  dev_model;    	/* device model */
-	__u8  unused;	     	/* padding byte */
-	/* extended part */
-	struct ciw ciw[MAX_CIWS];	/* variable # of CIWs */
-}  __attribute__ ((packed,aligned(4)));
-
-struct ccw_device_private {
-	struct ccw_device *cdev;
-	struct subchannel *sch;
-	int state;		/* device state */
-	atomic_t onoff;
-	unsigned long registered;
-	struct ccw_dev_id dev_id;	/* device id */
-	struct subchannel_id schid;	/* subchannel number */
-	__u8 imask;		/* lpm mask for SNID/SID/SPGID */
-	int iretry;		/* retry counter SNID/SID/SPGID */
-	struct {
-		unsigned int fast:1;	/* post with "channel end" */
-		unsigned int repall:1;	/* report every interrupt status */
-		unsigned int pgroup:1;  /* do path grouping */
-		unsigned int force:1;   /* allow forced online */
-	} __attribute__ ((packed)) options;
-	struct {
-		unsigned int pgid_single:1; /* use single path for Set PGID */
-		unsigned int esid:1;        /* Ext. SenseID supported by HW */
-		unsigned int dosense:1;	    /* delayed SENSE required */
-		unsigned int doverify:1;    /* delayed path verification */
-		unsigned int donotify:1;    /* call notify function */
-		unsigned int recog_done:1;  /* dev. recog. complete */
-		unsigned int fake_irb:1;    /* deliver faked irb */
-		unsigned int intretry:1;    /* retry internal operation */
-	} __attribute__((packed)) flags;
-	unsigned long intparm;	/* user interruption parameter */
-	struct qdio_irq *qdio_data;
-	struct irb irb;		/* device status */
-	struct senseid senseid;	/* SenseID info */
-	struct pgid pgid[8];	/* path group IDs per chpid*/
-	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
-	struct work_struct kick_work;
-	wait_queue_head_t wait_q;
-	struct timer_list timer;
-	void *cmb;			/* measurement information */
-	struct list_head cmb_list;	/* list of measured devices */
-	u64 cmb_start_time;		/* clock value of cmb reset */
-	void *cmb_wait;			/* deferred cmb enable/disable */
-};
-
 /*
  * A css driver handles all subchannels of one type.
  * Currently, we only care about I/O subchannels (type 0), these
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -28,6 +28,7 @@
 #include "css.h"
 #include "device.h"
 #include "ioasm.h"
+#include "io_sch.h"
 
 /******************* bus type handling ***********************/
 
@@ -1159,10 +1160,16 @@ io_subchannel_probe (struct subchannel *
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		return 0;
 	}
+	/* Allocate I/O subchannel private data. */
+	sch->private = kzalloc(sizeof(struct io_subchannel_private),
+			       GFP_KERNEL | GFP_DMA);
+	if (!sch->private)
+		return -ENOMEM;
 	cdev = io_subchannel_create_ccwdev(sch);
-	if (IS_ERR(cdev))
+	if (IS_ERR(cdev)) {
+		kfree(sch->private);
 		return PTR_ERR(cdev);
-
+	}
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc) {
 		spin_lock_irqsave(sch->lock, flags);
@@ -1170,6 +1177,7 @@ io_subchannel_probe (struct subchannel *
 		spin_unlock_irqrestore(sch->lock, flags);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
+		kfree(sch->private);
 	}
 
 	return rc;
@@ -1191,6 +1199,7 @@ io_subchannel_remove (struct subchannel 
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 	ccw_device_unregister(cdev);
 	put_device(&cdev->dev);
+	kfree(sch->private);
 	return 0;
 }
 
@@ -1279,6 +1288,9 @@ ccw_device_console_enable (struct ccw_de
 {
 	int rc;
 
+	/* Attach subchannel private data. */
+	sch->private = cio_get_console_priv();
+	memset(sch->private, 0, sizeof(struct io_subchannel_private));
 	/* Initialize the ccw_device structure. */
 	cdev->dev.parent= &sch->dev;
 	rc = io_subchannel_recog(cdev, sch);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -96,29 +96,32 @@ static void ccw_timeout_log(struct ccw_d
 {
 	struct schib schib;
 	struct subchannel *sch;
+	struct io_subchannel_private *private;
 	int cc;
 
 	sch = to_subchannel(cdev->dev.parent);
+	private = to_io_private(sch);
 	cc = stsch(sch->schid, &schib);
 
 	printk(KERN_WARNING "cio: ccw device timeout occurred at %llx, "
 	       "device information:\n", get_clock());
 	printk(KERN_WARNING "cio: orb:\n");
 	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
-		       &sch->orb, sizeof(sch->orb), 0);
+		       &private->orb, sizeof(private->orb), 0);
 	printk(KERN_WARNING "cio: ccw device bus id: %s\n", cdev->dev.bus_id);
 	printk(KERN_WARNING "cio: subchannel bus id: %s\n", sch->dev.bus_id);
 	printk(KERN_WARNING "cio: subchannel lpm: %02x, opm: %02x, "
 	       "vpm: %02x\n", sch->lpm, sch->opm, sch->vpm);
 
-	if ((void *)(addr_t)sch->orb.cpa == &sch->sense_ccw ||
-	    (void *)(addr_t)sch->orb.cpa == cdev->private->iccws)
+	if ((void *)(addr_t)private->orb.cpa == &private->sense_ccw ||
+	    (void *)(addr_t)private->orb.cpa == cdev->private->iccws)
 		printk(KERN_WARNING "cio: last channel program (intern):\n");
 	else
 		printk(KERN_WARNING "cio: last channel program:\n");
 
 	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
-		       (void *)(addr_t)sch->orb.cpa, sizeof(struct ccw1), 0);
+		       (void *)(addr_t)private->orb.cpa,
+		       sizeof(struct ccw1), 0);
 	printk(KERN_WARNING "cio: ccw device state: %d\n",
 	       cdev->private->state);
 	printk(KERN_WARNING "cio: store subchannel returned: cc=%d\n", cc);
@@ -1078,7 +1081,7 @@ device_trigger_reprobe(struct subchannel
 	sch->schib.pmcw.ena = 0;
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
 		sch->schib.pmcw.mp = 1;
-	sch->schib.pmcw.intparm = (__u32)(unsigned long)sch;
+	sch->schib.pmcw.intparm = (u32)(addr_t)sch;
 	/* We should also udate ssd info, but this has to wait. */
 	/* Check if this is another device which appeared on the same sch. */
 	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h
+++ quilt-2.6/drivers/s390/cio/device.h
@@ -5,6 +5,8 @@
 #include <asm/atomic.h>
 #include <linux/wait.h>
 
+#include "io_sch.h"
+
 /*
  * states of the device statemachine
  */
Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -24,6 +24,7 @@
 #include "css.h"
 #include "device.h"
 #include "ioasm.h"
+#include "io_sch.h"
 
 /*
  * Input :
@@ -219,11 +220,13 @@ ccw_device_check_sense_id(struct ccw_dev
 		return -EAGAIN;
 	}
 	if (irb->scsw.cc == 3) {
-		if ((sch->orb.lpm &
-		     sch->schib.pmcw.pim & sch->schib.pmcw.pam) != 0)
+		u8 lpm;
+
+		lpm = to_io_private(sch)->orb.lpm;
+		if ((lpm & sch->schib.pmcw.pim & sch->schib.pmcw.pam) != 0)
 			CIO_MSG_EVENT(2, "SenseID : path %02X for device %04x "
 				      "on subchannel 0.%x.%04x is "
-				      "'not operational'\n", sch->orb.lpm,
+				      "'not operational'\n", lpm,
 				      cdev->private->dev_id.devno,
 				      sch->schid.ssid, sch->schid.sch_no);
 		return -EACCES;
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c
+++ quilt-2.6/drivers/s390/cio/device_pgid.c
@@ -22,6 +22,7 @@
 #include "css.h"
 #include "device.h"
 #include "ioasm.h"
+#include "io_sch.h"
 
 /*
  * Helper function called from interrupt context to decide whether an
@@ -155,10 +156,13 @@ __ccw_device_check_sense_pgid(struct ccw
 		return -EAGAIN;
 	}
 	if (irb->scsw.cc == 3) {
+		u8 lpm;
+
+		lpm = to_io_private(sch)->orb.lpm;
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
-			      sch->schid.sch_no, sch->orb.lpm);
+			      sch->schid.sch_no, lpm);
 		return -EACCES;
 	}
 	i = 8 - ffs(cdev->private->imask);
Index: quilt-2.6/drivers/s390/cio/device_status.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_status.c
+++ quilt-2.6/drivers/s390/cio/device_status.c
@@ -20,6 +20,7 @@
 #include "css.h"
 #include "device.h"
 #include "ioasm.h"
+#include "io_sch.h"
 
 /*
  * Check for any kind of channel or interface control check but don't
@@ -310,6 +311,7 @@ int
 ccw_device_do_sense(struct ccw_device *cdev, struct irb *irb)
 {
 	struct subchannel *sch;
+	struct ccw1 *sense_ccw;
 
 	sch = to_subchannel(cdev->dev.parent);
 
@@ -326,15 +328,16 @@ ccw_device_do_sense(struct ccw_device *c
 	/*
 	 * We have ending status but no sense information. Do a basic sense.
 	 */
-	sch->sense_ccw.cmd_code = CCW_CMD_BASIC_SENSE;
-	sch->sense_ccw.cda = (__u32) __pa(cdev->private->irb.ecw);
-	sch->sense_ccw.count = SENSE_MAX_COUNT;
-	sch->sense_ccw.flags = CCW_FLAG_SLI;
+	sense_ccw = &to_io_private(sch)->sense_ccw;
+	sense_ccw->cmd_code = CCW_CMD_BASIC_SENSE;
+	sense_ccw->cda = (__u32) __pa(cdev->private->irb.ecw);
+	sense_ccw->count = SENSE_MAX_COUNT;
+	sense_ccw->flags = CCW_FLAG_SLI;
 
 	/* Reset internal retry indication. */
 	cdev->private->flags.intretry = 0;
 
-	return cio_start (sch, &sch->sense_ccw, 0xff);
+	return cio_start(sch, sense_ccw, 0xff);
 }
 
 /*
Index: quilt-2.6/drivers/s390/cio/ioasm.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ioasm.h
+++ quilt-2.6/drivers/s390/cio/ioasm.h
@@ -109,72 +109,6 @@ static inline int tpi( volatile struct t
 	return ccode;
 }
 
-static inline int ssch(struct subchannel_id schid,
-			   volatile struct orb *addr)
-{
-	register struct subchannel_id reg1 asm ("1") = schid;
-	int ccode;
-
-	asm volatile(
-		"	ssch	0(%2)\n"
-		"	ipm	%0\n"
-		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
-	return ccode;
-}
-
-static inline int rsch(struct subchannel_id schid)
-{
-	register struct subchannel_id reg1 asm ("1") = schid;
-	int ccode;
-
-	asm volatile(
-		"	rsch\n"
-		"	ipm	%0\n"
-		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
-	return ccode;
-}
-
-static inline int csch(struct subchannel_id schid)
-{
-	register struct subchannel_id reg1 asm ("1") = schid;
-	int ccode;
-
-	asm volatile(
-		"	csch\n"
-		"	ipm	%0\n"
-		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
-	return ccode;
-}
-
-static inline int hsch(struct subchannel_id schid)
-{
-	register struct subchannel_id reg1 asm ("1") = schid;
-	int ccode;
-
-	asm volatile(
-		"	hsch\n"
-		"	ipm	%0\n"
-		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
-	return ccode;
-}
-
-static inline int xsch(struct subchannel_id schid)
-{
-	register struct subchannel_id reg1 asm ("1") = schid;
-	int ccode;
-
-	asm volatile(
-		"	.insn	rre,0xb2760000,%1,0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
-	return ccode;
-}
-
 static inline int chsc(void *chsc_area)
 {
 	typedef struct { char _[4096]; } addr_type;
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/io_sch.h
@@ -0,0 +1,161 @@
+#ifndef S390_IO_SCH_H
+#define S390_IO_SCH_H
+
+#include "schid.h"
+
+/*
+ * operation request block
+ */
+struct orb {
+	u32 intparm;	/* interruption parameter */
+	u32 key  : 4;	/* flags, like key, suspend control, etc. */
+	u32 spnd : 1;	/* suspend control */
+	u32 res1 : 1;	/* reserved */
+	u32 mod  : 1;	/* modification control */
+	u32 sync : 1;	/* synchronize control */
+	u32 fmt  : 1;	/* format control */
+	u32 pfch : 1;	/* prefetch control */
+	u32 isic : 1;	/* initial-status-interruption control */
+	u32 alcc : 1;	/* address-limit-checking control */
+	u32 ssic : 1;	/* suppress-suspended-interr. control */
+	u32 res2 : 1;	/* reserved */
+	u32 c64  : 1;	/* IDAW/QDIO 64 bit control  */
+	u32 i2k  : 1;	/* IDAW 2/4kB block size control */
+	u32 lpm  : 8;	/* logical path mask */
+	u32 ils  : 1;	/* incorrect length */
+	u32 zero : 6;	/* reserved zeros */
+	u32 orbx : 1;	/* ORB extension control */
+	u32 cpa;	/* channel program address */
+}  __attribute__ ((packed, aligned(4)));
+
+struct io_subchannel_private {
+	struct orb orb;		/* operation request block */
+	struct ccw1 sense_ccw;	/* static ccw for sense command */
+} __attribute__ ((aligned(8)));
+
+#define to_io_private(n) ((struct io_subchannel_private *)n->private)
+
+#define MAX_CIWS 8
+
+/*
+ * sense-id response buffer layout
+ */
+struct senseid {
+	/* common part */
+	u8  reserved;	/* always 0x'FF' */
+	u16 cu_type;	/* control unit type */
+	u8  cu_model;	/* control unit model */
+	u16 dev_type;	/* device type */
+	u8  dev_model;	/* device model */
+	u8  unused;	/* padding byte */
+	/* extended part */
+	struct ciw ciw[MAX_CIWS];	/* variable # of CIWs */
+}  __attribute__ ((packed, aligned(4)));
+
+struct ccw_device_private {
+	struct ccw_device *cdev;
+	struct subchannel *sch;
+	int state;		/* device state */
+	atomic_t onoff;
+	unsigned long registered;
+	struct ccw_dev_id dev_id;	/* device id */
+	struct subchannel_id schid;	/* subchannel number */
+	u8 imask;		/* lpm mask for SNID/SID/SPGID */
+	int iretry;		/* retry counter SNID/SID/SPGID */
+	struct {
+		unsigned int fast:1;	/* post with "channel end" */
+		unsigned int repall:1;	/* report every interrupt status */
+		unsigned int pgroup:1;	/* do path grouping */
+		unsigned int force:1;	/* allow forced online */
+	} __attribute__ ((packed)) options;
+	struct {
+		unsigned int pgid_single:1; /* use single path for Set PGID */
+		unsigned int esid:1;	    /* Ext. SenseID supported by HW */
+		unsigned int dosense:1;	    /* delayed SENSE required */
+		unsigned int doverify:1;    /* delayed path verification */
+		unsigned int donotify:1;    /* call notify function */
+		unsigned int recog_done:1;  /* dev. recog. complete */
+		unsigned int fake_irb:1;    /* deliver faked irb */
+		unsigned int intretry:1;    /* retry internal operation */
+	} __attribute__((packed)) flags;
+	unsigned long intparm;	/* user interruption parameter */
+	struct qdio_irq *qdio_data;
+	struct irb irb;		/* device status */
+	struct senseid senseid;	/* SenseID info */
+	struct pgid pgid[8];	/* path group IDs per chpid*/
+	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
+	struct work_struct kick_work;
+	wait_queue_head_t wait_q;
+	struct timer_list timer;
+	void *cmb;			/* measurement information */
+	struct list_head cmb_list;	/* list of measured devices */
+	u64 cmb_start_time;		/* clock value of cmb reset */
+	void *cmb_wait;			/* deferred cmb enable/disable */
+};
+
+static inline int ssch(struct subchannel_id schid, volatile struct orb *addr)
+{
+	register struct subchannel_id reg1 asm("1") = schid;
+	int ccode;
+
+	asm volatile(
+		"	ssch	0(%2)\n"
+		"	ipm	%0\n"
+		"	srl	%0,28"
+		: "=d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+	return ccode;
+}
+
+static inline int rsch(struct subchannel_id schid)
+{
+	register struct subchannel_id reg1 asm("1") = schid;
+	int ccode;
+
+	asm volatile(
+		"	rsch\n"
+		"	ipm	%0\n"
+		"	srl	%0,28"
+		: "=d" (ccode) : "d" (reg1) : "cc");
+	return ccode;
+}
+
+static inline int csch(struct subchannel_id schid)
+{
+	register struct subchannel_id reg1 asm("1") = schid;
+	int ccode;
+
+	asm volatile(
+		"	csch\n"
+		"	ipm	%0\n"
+		"	srl	%0,28"
+		: "=d" (ccode) : "d" (reg1) : "cc");
+	return ccode;
+}
+
+static inline int hsch(struct subchannel_id schid)
+{
+	register struct subchannel_id reg1 asm("1") = schid;
+	int ccode;
+
+	asm volatile(
+		"	hsch\n"
+		"	ipm	%0\n"
+		"	srl	%0,28"
+		: "=d" (ccode) : "d" (reg1) : "cc");
+	return ccode;
+}
+
+static inline int xsch(struct subchannel_id schid)
+{
+	register struct subchannel_id reg1 asm("1") = schid;
+	int ccode;
+
+	asm volatile(
+		"	.insn	rre,0xb2760000,%1,0\n"
+		"	ipm	%0\n"
+		"	srl	%0,28"
+		: "=d" (ccode) : "d" (reg1) : "cc");
+	return ccode;
+}
+
+#endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
