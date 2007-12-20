Return-Path: <linux-kernel-owner+w=401wt.eu-S934297AbXLTPXB@vger.kernel.org>
Message-Id: <20071220152103.366033404@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:27 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/47] cio: Dump ccw device information in case of timeout.
Content-Disposition: inline; filename=101-cio-timeoutlog.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Sebastian Ott <sebott@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@de.ibm.com>

Information about a ccw device will be dumped in
case of a ccw timeout. This can be enabled with
the kernel parameter ccw_timeout_log.

Signed-off-by: Sebastian Ott <sebott@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/kernel-parameters.txt |    3 ++
 Documentation/s390/CommonIO         |    5 +++
 drivers/s390/cio/device_fsm.c       |   50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

Index: quilt-2.6/Documentation/kernel-parameters.txt
===================================================================
--- quilt-2.6.orig/Documentation/kernel-parameters.txt
+++ quilt-2.6/Documentation/kernel-parameters.txt
@@ -369,6 +369,9 @@ and is between 256 and 4096 characters. 
 			configured.  Potentially dangerous and should only be
 			used if you are entirely sure of the consequences.
 
+	ccw_timeout_log [S390]
+			See Documentation/s390/CommonIO for details.
+
 	checkreqprot	[SELINUX] Set initial checkreqprot flag value.
 			Format: { "0" | "1" }
 			See security/selinux/Kconfig help text.
Index: quilt-2.6/Documentation/s390/CommonIO
===================================================================
--- quilt-2.6.orig/Documentation/s390/CommonIO
+++ quilt-2.6/Documentation/s390/CommonIO
@@ -4,6 +4,11 @@ S/390 common I/O-Layer - command line pa
 Command line parameters
 -----------------------
 
+* ccw_timeout_log
+
+  Enable logging of debug information in case of ccw device timeouts.
+
+
 * cio_msg = yes | no
   
   Determines whether information on found devices and sensed device 
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -25,6 +25,8 @@
 #include "ioasm.h"
 #include "chp.h"
 
+static int timeout_log_enabled;
+
 int
 device_is_online(struct subchannel *sch)
 {
@@ -82,6 +84,52 @@ int device_trigger_verify(struct subchan
 	return 0;
 }
 
+static int __init ccw_timeout_log_setup(char *unused)
+{
+	timeout_log_enabled = 1;
+	return 1;
+}
+
+__setup("ccw_timeout_log", ccw_timeout_log_setup);
+
+static void ccw_timeout_log(struct ccw_device *cdev)
+{
+	struct schib schib;
+	struct subchannel *sch;
+	int cc;
+
+	sch = to_subchannel(cdev->dev.parent);
+	cc = stsch(sch->schid, &schib);
+
+	printk(KERN_WARNING "cio: ccw device timeout occurred at %llx, "
+	       "device information:\n", get_clock());
+	printk(KERN_WARNING "cio: orb:\n");
+	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
+		       &sch->orb, sizeof(sch->orb), 0);
+	printk(KERN_WARNING "cio: ccw device bus id: %s\n", cdev->dev.bus_id);
+	printk(KERN_WARNING "cio: subchannel bus id: %s\n", sch->dev.bus_id);
+	printk(KERN_WARNING "cio: subchannel lpm: %02x, opm: %02x, "
+	       "vpm: %02x\n", sch->lpm, sch->opm, sch->vpm);
+
+	if ((void *)(addr_t)sch->orb.cpa == &sch->sense_ccw ||
+	    (void *)(addr_t)sch->orb.cpa == cdev->private->iccws)
+		printk(KERN_WARNING "cio: last channel program (intern):\n");
+	else
+		printk(KERN_WARNING "cio: last channel program:\n");
+
+	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
+		       (void *)(addr_t)sch->orb.cpa, sizeof(struct ccw1), 0);
+	printk(KERN_WARNING "cio: ccw device state: %d\n",
+	       cdev->private->state);
+	printk(KERN_WARNING "cio: store subchannel returned: cc=%d\n", cc);
+	printk(KERN_WARNING "cio: schib:\n");
+	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
+		       &schib, sizeof(schib), 0);
+	printk(KERN_WARNING "cio: ccw device flags:\n");
+	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
+		       &cdev->private->flags, sizeof(cdev->private->flags), 0);
+}
+
 /*
  * Timeout function. It just triggers a DEV_EVENT_TIMEOUT.
  */
@@ -92,6 +140,8 @@ ccw_device_timeout(unsigned long data)
 
 	cdev = (struct ccw_device *) data;
 	spin_lock_irq(cdev->ccwlock);
+	if (timeout_log_enabled)
+		ccw_timeout_log(cdev);
 	dev_fsm_event(cdev, DEV_EVENT_TIMEOUT);
 	spin_unlock_irq(cdev->ccwlock);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
