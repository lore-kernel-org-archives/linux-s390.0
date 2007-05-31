Return-Path: <linux-kernel-owner+w=401wt.eu-S1759458AbXEaPj6@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Thu, 31 May 2007 17:40:29 +0200
Message-Id: <1180626029.26422.35.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/hypfs/hypfs_diag.c  |   17 +++++++++++--
 arch/s390/kernel/debug.c      |   22 +++++++++---------
 arch/s390/kernel/setup.c      |    4 +-
 arch/s390/kernel/smp.c        |    6 ++--
 drivers/s390/block/dasd_eer.c |   16 ++++++------
 drivers/s390/char/raw3270.c   |   10 ++++----
 drivers/s390/cio/device.c     |   49 +++++++++++++++++++++++++++++++---------
 drivers/s390/cio/device_fsm.c |    6 +++++
 8 files changed, 87 insertions(+), 43 deletions(-)

Christoph Hellwig (3):
      [S390] dasd_eer: use mutex instead of semaphore
      [S390] arch/s390/kernel/debug.c: use mutex instead of semaphore
      [S390] raw3270: use mutex instead of semaphore

Cornelia Huck (1):
      [S390] cio: Use device_schedule_callback() for removing disconnected devices.

Heiko Carstens (1):
      [S390] Fix section annotations.

Michael Holzheu (1):
      [S390] Add exception handler for diagnose 224

Peter Oberparleiter (1):
      [S390] cio: deregister ccw device when pgid disband failed

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 2782cf9..b9a1ce1 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -481,9 +481,17 @@ out:
 
 /* Diagnose 224 functions */
 
-static void diag224(void *ptr)
+static int diag224(void *ptr)
 {
-	asm volatile("diag %0,%1,0x224" : :"d" (0), "d"(ptr) : "memory");
+	int rc = -ENOTSUPP;
+
+	asm volatile(
+		"	diag	%1,%2,0x224\n"
+		"0:	lhi	%0,0x0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "+d" (rc) :"d" (0), "d" (ptr) : "memory");
+	return rc;
 }
 
 static int diag224_get_name_table(void)
@@ -492,7 +500,10 @@ static int diag224_get_name_table(void)
 	diag224_cpu_names = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!diag224_cpu_names)
 		return -ENOMEM;
-	diag224(diag224_cpu_names);
+	if (diag224(diag224_cpu_names)) {
+		kfree(diag224_cpu_names);
+		return -ENOTSUPP;
+	}
 	EBCASC(diag224_cpu_names + 16, (*diag224_cpu_names + 1) * 16);
 	return 0;
 }
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index dca6eaf..1b2f5ce 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -163,7 +163,7 @@ unsigned int debug_feature_version = __DEBUG_FEATURE_VERSION;
 
 static debug_info_t *debug_area_first = NULL;
 static debug_info_t *debug_area_last = NULL;
-static DECLARE_MUTEX(debug_lock);
+static DEFINE_MUTEX(debug_mutex);
 
 static int initialized;
 
@@ -576,7 +576,7 @@ debug_input(struct file *file, const char __user *user_buf, size_t length,
 	int rc = 0;
 	file_private_info_t *p_info;
 
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	p_info = ((file_private_info_t *) file->private_data);
 	if (p_info->view->input_proc)
 		rc = p_info->view->input_proc(p_info->debug_info_org,
@@ -584,7 +584,7 @@ debug_input(struct file *file, const char __user *user_buf, size_t length,
 					      length, offset);
 	else
 		rc = -EPERM;
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 	return rc;		/* number of input characters */
 }
 
@@ -602,7 +602,7 @@ debug_open(struct inode *inode, struct file *file)
 	file_private_info_t *p_info;
 	debug_info_t *debug_info, *debug_info_snapshot;
 
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	debug_info = file->f_path.dentry->d_inode->i_private;
 	/* find debug view */
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
@@ -653,7 +653,7 @@ found:
 	file->private_data = p_info;
 	debug_info_get(debug_info);
 out:
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 	return rc;
 }
 
@@ -688,7 +688,7 @@ debug_register (char *name, int pages_per_area, int nr_areas, int buf_size)
 
 	if (!initialized)
 		BUG();
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 
         /* create new debug_info */
 
@@ -702,7 +702,7 @@ out:
         if (!rc){
 		printk(KERN_ERR "debug: debug_register failed for %s\n",name);
         }
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 	return rc;
 }
 
@@ -716,9 +716,9 @@ debug_unregister(debug_info_t * id)
 {
 	if (!id)
 		goto out;
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	debug_info_put(id);
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 
 out:
 	return;
@@ -1054,11 +1054,11 @@ __init debug_init(void)
 	int rc = 0;
 
 	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table);
-	down(&debug_lock);
+	mutex_lock(&debug_mutex);
 	debug_debugfs_root_entry = debugfs_create_dir(DEBUG_DIR_ROOT,NULL);
 	printk(KERN_INFO "debug: Initialization complete\n");
 	initialized = 1;
-	up(&debug_lock);
+	mutex_unlock(&debug_mutex);
 
 	return rc;
 }
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 6bfb088..51d6309 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -102,7 +102,7 @@ static struct resource data_resource = {
 /*
  * cpu_init() initializes state that is per-CPU.
  */
-void __devinit cpu_init (void)
+void __cpuinit cpu_init(void)
 {
         int addr = hard_smp_processor_id();
 
@@ -915,7 +915,7 @@ setup_arch(char **cmdline_p)
 	setup_zfcpdump(console_devno);
 }
 
-void print_cpu_info(struct cpuinfo_S390 *cpuinfo)
+void __cpuinit print_cpu_info(struct cpuinfo_S390 *cpuinfo)
 {
    printk("cpu %d "
 #ifdef CONFIG_SMP
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 09f028a..8ff2fea 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -492,7 +492,7 @@ static unsigned int __init smp_count_cpus(void)
 /*
  *	Activate a secondary processor.
  */
-int __devinit start_secondary(void *cpuvoid)
+int __cpuinit start_secondary(void *cpuvoid)
 {
 	/* Setup the cpu */
 	cpu_init();
@@ -741,7 +741,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			smp_create_idle(cpu);
 }
 
-void __devinit smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
 
@@ -750,7 +750,7 @@ void __devinit smp_prepare_boot_cpu(void)
 	current_set[0] = current;
 }
 
-void smp_cpus_done(unsigned int max_cpus)
+void __init smp_cpus_done(unsigned int max_cpus)
 {
 	cpu_present_map = cpu_possible_map;
 }
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index a1dc8c4..0c081a6 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -14,9 +14,9 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/poll.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include <asm/atomic.h>
 #include <asm/ebcdic.h>
 
@@ -514,7 +514,7 @@ void dasd_eer_disable(struct dasd_device *device)
  * to transfer in a readbuffer, which is protected by the readbuffer_mutex.
  */
 static char readbuffer[PAGE_SIZE];
-static DECLARE_MUTEX(readbuffer_mutex);
+static DEFINE_MUTEX(readbuffer_mutex);
 
 static int dasd_eer_open(struct inode *inp, struct file *filp)
 {
@@ -579,7 +579,7 @@ static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
 	struct eerbuffer *eerb;
 
 	eerb = (struct eerbuffer *) filp->private_data;
-	if (down_interruptible(&readbuffer_mutex))
+	if (mutex_lock_interruptible(&readbuffer_mutex))
 		return -ERESTARTSYS;
 
 	spin_lock_irqsave(&bufferlock, flags);
@@ -588,7 +588,7 @@ static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
 		                  /* has been deleted             */
 		eerb->residual = 0;
 		spin_unlock_irqrestore(&bufferlock, flags);
-		up(&readbuffer_mutex);
+		mutex_unlock(&readbuffer_mutex);
 		return -EIO;
 	} else if (eerb->residual > 0) {
 		/* OK we still have a second half of a record to deliver */
@@ -602,7 +602,7 @@ static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
 			if (!tc) {
 				/* no data available */
 				spin_unlock_irqrestore(&bufferlock, flags);
-				up(&readbuffer_mutex);
+				mutex_unlock(&readbuffer_mutex);
 				if (filp->f_flags & O_NONBLOCK)
 					return -EAGAIN;
 				rc = wait_event_interruptible(
@@ -610,7 +610,7 @@ static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
 					eerb->head != eerb->tail);
 				if (rc)
 					return rc;
-				if (down_interruptible(&readbuffer_mutex))
+				if (mutex_lock_interruptible(&readbuffer_mutex))
 					return -ERESTARTSYS;
 				spin_lock_irqsave(&bufferlock, flags);
 			}
@@ -626,11 +626,11 @@ static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
 	spin_unlock_irqrestore(&bufferlock, flags);
 
 	if (copy_to_user(buf, readbuffer, effective_count)) {
-		up(&readbuffer_mutex);
+		mutex_unlock(&readbuffer_mutex);
 		return -EFAULT;
 	}
 
-	up(&readbuffer_mutex);
+	mutex_unlock(&readbuffer_mutex);
 	return effective_count;
 }
 
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index f6ef90e..743944a 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -487,7 +487,7 @@ struct raw3270_ua {	/* Query Reply structure for Usable Area */
 } __attribute__ ((packed));
 
 static struct diag210 raw3270_init_diag210;
-static DECLARE_MUTEX(raw3270_init_sem);
+static DEFINE_MUTEX(raw3270_init_mutex);
 
 static int
 raw3270_init_irq(struct raw3270_view *view, struct raw3270_request *rq,
@@ -713,7 +713,7 @@ raw3270_size_device(struct raw3270 *rp)
 {
 	int rc;
 
-	down(&raw3270_init_sem);
+	mutex_lock(&raw3270_init_mutex);
 	rp->view = &raw3270_init_view;
 	raw3270_init_view.dev = rp;
 	if (MACHINE_IS_VM)
@@ -722,7 +722,7 @@ raw3270_size_device(struct raw3270 *rp)
 		rc = __raw3270_size_device(rp);
 	raw3270_init_view.dev = NULL;
 	rp->view = NULL;
-	up(&raw3270_init_sem);
+	mutex_unlock(&raw3270_init_mutex);
 	if (rc == 0) {	/* Found something. */
 		/* Try to find a model. */
 		rp->model = 0;
@@ -749,7 +749,7 @@ raw3270_reset_device(struct raw3270 *rp)
 {
 	int rc;
 
-	down(&raw3270_init_sem);
+	mutex_lock(&raw3270_init_mutex);
 	memset(&rp->init_request, 0, sizeof(rp->init_request));
 	memset(&rp->init_data, 0, sizeof(rp->init_data));
 	/* Store reset data stream to init_data/init_request */
@@ -764,7 +764,7 @@ raw3270_reset_device(struct raw3270 *rp)
 	rc = raw3270_start_init(rp, &raw3270_init_view, &rp->init_request);
 	raw3270_init_view.dev = NULL;
 	rp->view = NULL;
-	up(&raw3270_init_sem);
+	mutex_unlock(&raw3270_init_mutex);
 	return rc;
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index a8b373f..6b264bd 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -296,30 +296,57 @@ static void ccw_device_unregister(struct ccw_device *cdev)
 		device_del(&cdev->dev);
 }
 
+static void ccw_device_remove_orphan_cb(struct device *dev)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+
+	ccw_device_unregister(cdev);
+	put_device(&cdev->dev);
+}
+
+static void ccw_device_remove_sch_cb(struct device *dev)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(dev);
+	css_sch_device_unregister(sch);
+	/* Reset intparm to zeroes. */
+	sch->schib.pmcw.intparm = 0;
+	cio_modify(sch);
+	put_device(&sch->dev);
+}
+
 static void
 ccw_device_remove_disconnected(struct ccw_device *cdev)
 {
-	struct subchannel *sch;
 	unsigned long flags;
+	int rc;
+
 	/*
 	 * Forced offline in disconnected state means
 	 * 'throw away device'.
 	 */
 	if (ccw_device_is_orphan(cdev)) {
-		/* Deregister ccw device. */
+		/*
+		 * Deregister ccw device.
+		 * Unfortunately, we cannot do this directly from the
+		 * attribute method.
+		 */
 		spin_lock_irqsave(cdev->ccwlock, flags);
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		ccw_device_unregister(cdev);
-		put_device(&cdev->dev);
-		return ;
+		rc = device_schedule_callback(&cdev->dev,
+					      ccw_device_remove_orphan_cb);
+		if (rc)
+			dev_info(&cdev->dev, "Couldn't unregister orphan\n");
+		return;
 	}
-	sch = to_subchannel(cdev->dev.parent);
-	css_sch_device_unregister(sch);
-	/* Reset intparm to zeroes. */
-	sch->schib.pmcw.intparm = 0;
-	cio_modify(sch);
-	put_device(&sch->dev);
+	/* Deregister subchannel, which will kill the ccw device. */
+	rc = device_schedule_callback(cdev->dev.parent,
+				      ccw_device_remove_sch_cb);
+	if (rc)
+		dev_info(&cdev->dev,
+			 "Couldn't unregister disconnected device\n");
 }
 
 int
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 898ec3b..6bba809 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -688,6 +688,12 @@ ccw_device_disband_done(struct ccw_device *cdev, int err)
 		ccw_device_done(cdev, DEV_STATE_BOXED);
 		break;
 	default:
+		cdev->private->flags.donotify = 0;
+		if (get_device(&cdev->dev)) {
+			PREPARE_WORK(&cdev->private->kick_work,
+				     ccw_device_call_sch_unregister);
+			queue_work(ccw_device_work, &cdev->private->kick_work);
+		}
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
 	}
