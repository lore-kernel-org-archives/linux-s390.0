Return-Path: <linux-kernel-owner+w=401wt.eu-S1755832Ab0A0RWK@vger.kernel.org>
Date: Wed, 27 Jan 2010 18:22:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.33-rc5
Message-ID: <20100127182200.54941d34@mschwide.boeblingen.de.ibm.com>
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

some minor fixes for s390, please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Felix Beck (1):
      [S390] zcrypt: Do not remove coprocessor for error 8/72

Heiko Carstens (1):
      [S390] irqflags: add missing types.h include

Hendrik Brueckner (1):
      [S390] sclp_vt220: set initial terminal window size

Martin Schwidefsky (2):
      [S390] use set_current_state in sigsuspend
      [S390] fix single stepped svcs with TRACE_IRQFLAGS=y

Stefan Haberland (1):
      [S390] dasd: fix possible NULL pointer errors

 arch/s390/include/asm/irqflags.h    |    9 +++------
 arch/s390/kernel/entry.S            |    1 +
 arch/s390/kernel/entry64.S          |    1 +
 arch/s390/kernel/signal.c           |    2 +-
 drivers/s390/block/dasd.c           |    8 ++++----
 drivers/s390/block/dasd_eckd.c      |    2 +-
 drivers/s390/block/dasd_ioctl.c     |    7 ++-----
 drivers/s390/block/dasd_proc.c      |    7 ++-----
 drivers/s390/char/sclp_vt220.c      |    4 ++++
 drivers/s390/crypto/zcrypt_pcicc.c  |    2 ++
 drivers/s390/crypto/zcrypt_pcixcc.c |    2 ++
 11 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irqflags.h
index 3f26131..c2fb432 100644
--- a/arch/s390/include/asm/irqflags.h
+++ b/arch/s390/include/asm/irqflags.h
@@ -1,14 +1,12 @@
 /*
- *  include/asm-s390/irqflags.h
- *
- *    Copyright (C) IBM Corp. 2006
- *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ *    Copyright IBM Corp. 2006,2010
+ *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #ifndef __ASM_IRQFLAGS_H
 #define __ASM_IRQFLAGS_H
 
-#ifdef __KERNEL__
+#include <linux/types.h>
 
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 
@@ -102,5 +100,4 @@ static inline int raw_irqs_disabled_flags(unsigned long flags)
 /* For spinlocks etc */
 #define raw_local_irq_save(x)	((x) = raw_local_irq_disable())
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_IRQFLAGS_H */
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 48215d1..e8ef21c 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -571,6 +571,7 @@ pgm_svcper:
 	mvc	__THREAD_per+__PER_access_id(1,%r8),__LC_PER_ACCESS_ID
 	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	TRACE_IRQS_ON
+	lm	%r2,%r6,SP_R2(%r15)	# load svc arguments
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	b	BASED(sysc_do_svc)
 
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 9aff1d4..f33658f 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -549,6 +549,7 @@ pgm_svcper:
 	mvc	__THREAD_per+__PER_access_id(1,%r8),__LC_PER_ACCESS_ID
 	oi	__TI_flags+7(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	TRACE_IRQS_ON
+	lmg	%r2,%r6,SP_R2(%r15)	# load svc arguments
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	j	sysc_do_svc
 
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 1675c48..6289945 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -64,7 +64,7 @@ SYSCALL_DEFINE3(sigsuspend, int, history0, int, history1, old_sigset_t, mask)
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule();
 	set_thread_flag(TIF_RESTORE_SIGMASK);
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index fdb2e7c..5905936 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1004,8 +1004,8 @@ static void dasd_handle_killed_request(struct ccw_device *cdev,
 	if (device == NULL ||
 	    device != dasd_device_from_cdev_locked(cdev) ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
-		DBF_DEV_EVENT(DBF_DEBUG, device, "invalid device in request: "
-			      "bus_id %s", dev_name(&cdev->dev));
+		DBF_EVENT_DEVID(DBF_DEBUG, cdev, "%s",
+				"invalid device in request");
 		return;
 	}
 
@@ -1078,8 +1078,8 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	device = (struct dasd_device *) cqr->startdev;
 	if (!device ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
-		DBF_DEV_EVENT(DBF_DEBUG, device, "invalid device in request: "
-			      "bus_id %s", dev_name(&cdev->dev));
+		DBF_EVENT_DEVID(DBF_DEBUG, cdev, "%s",
+				"invalid device in request");
 		return;
 	}
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 1c500c4..1cca21a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3033,7 +3033,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " in req: %p CS: 0x%02X DS: 0x%02X CC: 0x%02X RC: %d\n",
 		       req, scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw),
-		       scsw_cc(&irb->scsw), req->intrc);
+		       scsw_cc(&irb->scsw), req ? req->intrc : 0);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       dev_name(&device->cdev->dev),
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index fc7b30b..7039d9c 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -260,7 +260,7 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	struct ccw_dev_id dev_id;
 
 	base = block->base;
-	if (!base->discipline->fill_info)
+	if (!base->discipline || !base->discipline->fill_info)
 		return -EINVAL;
 
 	dasd_info = kzalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
@@ -303,10 +303,7 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	dasd_info->features |=
 		((base->features & DASD_FEATURE_READONLY) != 0);
 
-	if (base->discipline)
-		memcpy(dasd_info->type, base->discipline->name, 4);
-	else
-		memcpy(dasd_info->type, "none", 4);
+	memcpy(dasd_info->type, base->discipline->name, 4);
 
 	if (block->request_queue->request_fn) {
 		struct list_head *l;
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 6315fbd..71f95f5 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -72,7 +72,7 @@ dasd_devices_show(struct seq_file *m, void *v)
 	/* Print device number. */
 	seq_printf(m, "%s", dev_name(&device->cdev->dev));
 	/* Print discipline string. */
-	if (device != NULL && device->discipline != NULL)
+	if (device->discipline != NULL)
 		seq_printf(m, "(%s)", device->discipline->name);
 	else
 		seq_printf(m, "(none)");
@@ -92,10 +92,7 @@ dasd_devices_show(struct seq_file *m, void *v)
 	substr = (device->features & DASD_FEATURE_READONLY) ? "(ro)" : " ";
 	seq_printf(m, "%4s: ", substr);
 	/* Print device status information. */
-	switch ((device != NULL) ? device->state : -1) {
-	case -1:
-		seq_printf(m, "unknown");
-		break;
+	switch (device->state) {
 	case DASD_STATE_NEW:
 		seq_printf(m, "new");
 		break;
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index b9d2a00..3796ffd 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -495,6 +495,10 @@ sclp_vt220_open(struct tty_struct *tty, struct file *filp)
 		if (tty->driver_data == NULL)
 			return -ENOMEM;
 		tty->low_latency = 0;
+		if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
+			tty->winsize.ws_row = 24;
+			tty->winsize.ws_col = 80;
+		}
 	}
 	return 0;
 }
diff --git a/drivers/s390/crypto/zcrypt_pcicc.c b/drivers/s390/crypto/zcrypt_pcicc.c
index a23726a..142f72a 100644
--- a/drivers/s390/crypto/zcrypt_pcicc.c
+++ b/drivers/s390/crypto/zcrypt_pcicc.c
@@ -373,6 +373,8 @@ static int convert_type86(struct zcrypt_device *zdev,
 			zdev->max_mod_size = PCICC_MAX_MOD_SIZE_OLD;
 			return -EAGAIN;
 		}
+		if (service_rc == 8 && service_rs == 72)
+			return -EINVAL;
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
diff --git a/drivers/s390/crypto/zcrypt_pcixcc.c b/drivers/s390/crypto/zcrypt_pcixcc.c
index 79c1205..68f3e62 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.c
+++ b/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -470,6 +470,8 @@ static int convert_type86_ica(struct zcrypt_device *zdev,
 		}
 		if (service_rc == 12 && service_rs == 769)
 			return -EINVAL;
+		if (service_rc == 8 && service_rs == 72)
+			return -EINVAL;
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
