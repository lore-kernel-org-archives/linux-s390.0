Return-Path: <linux-kernel-owner+w=401wt.eu-S933095AbZJNLvP@vger.kernel.org>
Date: Wed, 14 Oct 2009 13:50:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.32-rc4
Message-ID: <20091014135031.780dff6d@mschwide.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

before everybody gets on the plane to the kernel summit in Tokyo,
here are the latest bug fixes for s390 that should go into 2.6.32.

Please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Andreas Krebbel (1):
      [S390] Add highgprs facility to /proc/cpuinfo

Heiko Carstens (1):
      [S390] call home support: fix proc handler

Michael Holzheu (3):
      [S390] hypfs: Use subcode 6 if subcode 7 is not available
      [S390] tape390: Fix request queue handling in block driver
      [S390] sclp_vt220 build fix

Peter Oberparleiter (1):
      [S390] cio: change misleading console logic

Stefan Haberland (2):
      [S390] dasd: fix locking bug
      [S390] dasd: use idal for device characteristics

 arch/s390/hypfs/hypfs_diag.c   |    2 +-
 arch/s390/kernel/processor.c   |    6 +++---
 drivers/s390/block/dasd.c      |   13 +++++++++++--
 drivers/s390/block/dasd_eckd.c |    8 +++++---
 drivers/s390/char/sclp_async.c |    4 ++--
 drivers/s390/char/sclp_vt220.c |   30 +++++++++++++++---------------
 drivers/s390/char/tape_block.c |    3 ++-
 drivers/s390/cio/device.c      |    9 ++++-----
 8 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 704dd39..77df726 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -438,7 +438,7 @@ static int diag204_probe(void)
 		}
 		if (diag204((unsigned long)SUBC_STIB6 |
 			    (unsigned long)INFO_EXT, pages, buf) >= 0) {
-			diag204_store_sc = SUBC_STIB7;
+			diag204_store_sc = SUBC_STIB6;
 			diag204_info_type = INFO_EXT;
 			goto out;
 		}
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 802c8ab..0729f36 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -31,9 +31,9 @@ void __cpuinit print_cpu_info(void)
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	static const char *hwcap_str[9] = {
+	static const char *hwcap_str[10] = {
 		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp",
-		"edat", "etf3eh"
+		"edat", "etf3eh", "highgprs"
 	};
 	struct _lowcore *lc;
 	unsigned long n = (unsigned long) v - 1;
@@ -48,7 +48,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 			   num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			   (loops_per_jiffy/(5000/HZ))%100);
 		seq_puts(m, "features\t: ");
-		for (i = 0; i < 9; i++)
+		for (i = 0; i < 10; i++)
 			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
 				seq_printf(m, "%s ", hwcap_str[i]);
 		seq_puts(m, "\n");
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 53b8c25..aaccc8e 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2533,6 +2533,7 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 {
 	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
+	unsigned long *idaw;
 
 	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device);
 
@@ -2546,9 +2547,17 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = CCW_CMD_RDC;
-	ccw->cda = (__u32)(addr_t)rdc_buffer;
-	ccw->count = rdc_buffer_size;
+	if (idal_is_needed(rdc_buffer, rdc_buffer_size)) {
+		idaw = (unsigned long *) (cqr->data);
+		ccw->cda = (__u32)(addr_t) idaw;
+		ccw->flags = CCW_FLAG_IDA;
+		idaw = idal_create_words(idaw, rdc_buffer, rdc_buffer_size);
+	} else {
+		ccw->cda = (__u32)(addr_t) rdc_buffer;
+		ccw->flags = 0;
+	}
 
+	ccw->count = rdc_buffer_size;
 	cqr->startdev = device;
 	cqr->memdev = device;
 	cqr->expires = 10*HZ;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 0be7c15..417b97c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3216,6 +3216,7 @@ int dasd_eckd_restore_device(struct dasd_device *device)
 	struct dasd_eckd_characteristics temp_rdc_data;
 	int is_known, rc;
 	struct dasd_uid temp_uid;
+	unsigned long flags;
 
 	private = (struct dasd_eckd_private *) device->private;
 
@@ -3228,7 +3229,8 @@ int dasd_eckd_restore_device(struct dasd_device *device)
 	rc = dasd_eckd_generate_uid(device, &private->uid);
 	dasd_get_uid(device->cdev, &temp_uid);
 	if (memcmp(&private->uid, &temp_uid, sizeof(struct dasd_uid)) != 0)
-		dev_err(&device->cdev->dev, "The UID of the DASD has changed\n");
+		dev_err(&device->cdev->dev, "The UID of the DASD has "
+			"changed\n");
 	if (rc)
 		goto out_err;
 	dasd_set_uid(device->cdev, &private->uid);
@@ -3256,9 +3258,9 @@ int dasd_eckd_restore_device(struct dasd_device *device)
 			  "device: %s", rc, dev_name(&device->cdev->dev));
 		goto out_err;
 	}
-	spin_lock(get_ccwdev_lock(device->cdev));
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	memcpy(&private->rdc_data, &temp_rdc_data, sizeof(temp_rdc_data));
-	spin_unlock(get_ccwdev_lock(device->cdev));
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 
 	/* add device to alias management */
 	dasd_alias_add_device(device);
diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index daaec18..a4f68e5 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -62,7 +62,7 @@ static struct notifier_block call_home_panic_nb = {
 	.priority = INT_MAX,
 };
 
-static int proc_handler_callhome(ctl_table *ctl, int write, struct file *filp,
+static int proc_handler_callhome(struct ctl_table *ctl, int write,
 				 void __user *buffer, size_t *count,
 				 loff_t *ppos)
 {
@@ -100,7 +100,7 @@ static struct ctl_table callhome_table[] = {
 	{
 		.procname	= "callhome",
 		.mode		= 0644,
-		.proc_handler	= &proc_handler_callhome,
+		.proc_handler	= proc_handler_callhome,
 	},
 	{ .ctl_name = 0 }
 };
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 178724f..b9d2a00 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -705,21 +705,6 @@ out_driver:
 }
 __initcall(sclp_vt220_tty_init);
 
-#ifdef CONFIG_SCLP_VT220_CONSOLE
-
-static void
-sclp_vt220_con_write(struct console *con, const char *buf, unsigned int count)
-{
-	__sclp_vt220_write((const unsigned char *) buf, count, 1, 1, 0);
-}
-
-static struct tty_driver *
-sclp_vt220_con_device(struct console *c, int *index)
-{
-	*index = 0;
-	return sclp_vt220_driver;
-}
-
 static void __sclp_vt220_flush_buffer(void)
 {
 	unsigned long flags;
@@ -776,6 +761,21 @@ static void sclp_vt220_pm_event_fn(struct sclp_register *reg,
 	}
 }
 
+#ifdef CONFIG_SCLP_VT220_CONSOLE
+
+static void
+sclp_vt220_con_write(struct console *con, const char *buf, unsigned int count)
+{
+	__sclp_vt220_write((const unsigned char *) buf, count, 1, 1, 0);
+}
+
+static struct tty_driver *
+sclp_vt220_con_device(struct console *c, int *index)
+{
+	*index = 0;
+	return sclp_vt220_driver;
+}
+
 static int
 sclp_vt220_notify(struct notifier_block *self,
 			  unsigned long event, void *data)
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index 64f57ef..0c0705b 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -162,9 +162,10 @@ tapeblock_requeue(struct work_struct *work) {
 	spin_lock_irq(&device->blk_data.request_queue_lock);
 	while (
 		!blk_queue_plugged(queue) &&
-		(req = blk_fetch_request(queue)) &&
+		blk_peek_request(queue) &&
 		nr_queued < TAPEBLOCK_MIN_REQUEUE
 	) {
+		req = blk_fetch_request(queue);
 		if (rq_data_dir(req) == WRITE) {
 			DBF_EVENT(1, "TBLOCK: Rejecting write request\n");
 			spin_unlock_irq(&device->blk_data.request_queue_lock);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 2ee093e..2490b74 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1250,8 +1250,7 @@ static int io_subchannel_probe(struct subchannel *sch)
 	unsigned long flags;
 	struct ccw_dev_id dev_id;
 
-	cdev = sch_get_cdev(sch);
-	if (cdev) {
+	if (cio_is_console(sch->schid)) {
 		rc = sysfs_create_group(&sch->dev.kobj,
 					&io_subchannel_attr_group);
 		if (rc)
@@ -1260,13 +1259,13 @@ static int io_subchannel_probe(struct subchannel *sch)
 				      "0.%x.%04x (rc=%d)\n",
 				      sch->schid.ssid, sch->schid.sch_no, rc);
 		/*
-		 * This subchannel already has an associated ccw_device.
+		 * The console subchannel already has an associated ccw_device.
 		 * Throw the delayed uevent for the subchannel, register
-		 * the ccw_device and exit. This happens for all early
-		 * devices, e.g. the console.
+		 * the ccw_device and exit.
 		 */
 		dev_set_uevent_suppress(&sch->dev, 0);
 		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+		cdev = sch_get_cdev(sch);
 		cdev->dev.groups = ccwdev_attr_groups;
 		device_initialize(&cdev->dev);
 		ccw_device_register(cdev);
