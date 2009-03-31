Return-Path: <linux-kernel-owner+w=401wt.eu-S1762182AbZCaRUr@vger.kernel.org>
Date: Tue, 31 Mar 2009 19:20:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 bug fixes
Message-ID: <20090331192031.55f51c41@skybase>
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

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (2):
      sysrq: include interrupt.h instead of irq.h
      [S390] fix hypfs build failure

Sebastian Ott (5):
      [S390] cio: wake up on failed recognition
      [S390] cio: introduce ccw_device_schedule_sch_unregister
      [S390] cio: introduce notifier for boxed state
      [S390] cio: disallow online setting of device in transient state
      [S390] cio: online_store - trigger recognition for boxed devices

 arch/s390/hypfs/hypfs_diag.c  |    2 +
 arch/s390/include/asm/cio.h   |    2 +
 drivers/char/sysrq.c          |    2 +-
 drivers/s390/block/dasd.c     |    1 +
 drivers/s390/cio/device.c     |   43 +++++++++++++++++++++++++---------------
 drivers/s390/cio/device.h     |    1 +
 drivers/s390/cio/device_fsm.c |   31 ++++++++++++++++++-----------
 drivers/s390/scsi/zfcp_ccw.c  |    5 ++++
 8 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index b1e892a..704dd39 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -12,6 +12,8 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <asm/ebcdic.h>
diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 6dccb07..619bf94 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -456,6 +456,8 @@ struct ciw {
 #define CIO_OPER       0x0004
 /* Sick revalidation of device. */
 #define CIO_REVALIDATE 0x0008
+/* Device did not respond in time. */
+#define CIO_BOXED      0x0010
 
 /**
  * struct ccw_dev_id - unique identifier for ccw devices
diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index 33a9351..3df694e 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -35,7 +35,7 @@
 #include <linux/vt_kern.h>
 #include <linux/workqueue.h>
 #include <linux/kexec.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/hrtimer.h>
 #include <linux/oom.h>
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 2fd64e5..0570794 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2363,6 +2363,7 @@ int dasd_generic_notify(struct ccw_device *cdev, int event)
 	ret = 0;
 	switch (event) {
 	case CIO_GONE:
+	case CIO_BOXED:
 	case CIO_NO_PATH:
 		/* First of all call extended error reporting. */
 		dasd_eer_write(device, NULL, DASD_EER_NOPATH);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index c4d2f66..35441fa 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -310,8 +310,6 @@ static void ccw_device_remove_orphan_cb(struct work_struct *work)
 	put_device(&cdev->dev);
 }
 
-static void ccw_device_call_sch_unregister(struct work_struct *work);
-
 static void
 ccw_device_remove_disconnected(struct ccw_device *cdev)
 {
@@ -335,11 +333,10 @@ ccw_device_remove_disconnected(struct ccw_device *cdev)
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
 		PREPARE_WORK(&cdev->private->kick_work,
 				ccw_device_remove_orphan_cb);
+		queue_work(slow_path_wq, &cdev->private->kick_work);
 	} else
 		/* Deregister subchannel, which will kill the ccw device. */
-		PREPARE_WORK(&cdev->private->kick_work,
-				ccw_device_call_sch_unregister);
-	queue_work(slow_path_wq, &cdev->private->kick_work);
+		ccw_device_schedule_sch_unregister(cdev);
 }
 
 /**
@@ -471,7 +468,7 @@ static int online_store_recog_and_online(struct ccw_device *cdev)
 	int ret;
 
 	/* Do device recognition, if needed. */
-	if (cdev->id.cu_type == 0) {
+	if (cdev->private->state == DEV_STATE_BOXED) {
 		ret = ccw_device_recognition(cdev);
 		if (ret) {
 			CIO_MSG_EVENT(0, "Couldn't start recognition "
@@ -482,17 +479,21 @@ static int online_store_recog_and_online(struct ccw_device *cdev)
 		}
 		wait_event(cdev->private->wait_q,
 			   cdev->private->flags.recog_done);
+		if (cdev->private->state != DEV_STATE_OFFLINE)
+			/* recognition failed */
+			return -EAGAIN;
 	}
 	if (cdev->drv && cdev->drv->set_online)
 		ccw_device_set_online(cdev);
 	return 0;
 }
+
 static int online_store_handle_online(struct ccw_device *cdev, int force)
 {
 	int ret;
 
 	ret = online_store_recog_and_online(cdev);
-	if (ret)
+	if (ret && !force)
 		return ret;
 	if (force && cdev->private->state == DEV_STATE_BOXED) {
 		ret = ccw_device_stlck(cdev);
@@ -500,7 +501,9 @@ static int online_store_handle_online(struct ccw_device *cdev, int force)
 			return ret;
 		if (cdev->id.cu_type == 0)
 			cdev->private->state = DEV_STATE_NOT_OPER;
-		online_store_recog_and_online(cdev);
+		ret = online_store_recog_and_online(cdev);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -512,7 +515,11 @@ static ssize_t online_store (struct device *dev, struct device_attribute *attr,
 	int force, ret;
 	unsigned long i;
 
-	if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
+	if ((cdev->private->state != DEV_STATE_OFFLINE &&
+	     cdev->private->state != DEV_STATE_ONLINE &&
+	     cdev->private->state != DEV_STATE_BOXED &&
+	     cdev->private->state != DEV_STATE_DISCONNECTED) ||
+	    atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
 		return -EAGAIN;
 
 	if (cdev->drv && !try_module_get(cdev->drv->owner)) {
@@ -1014,6 +1021,13 @@ static void ccw_device_call_sch_unregister(struct work_struct *work)
 	put_device(&sch->dev);
 }
 
+void ccw_device_schedule_sch_unregister(struct ccw_device *cdev)
+{
+	PREPARE_WORK(&cdev->private->kick_work,
+		     ccw_device_call_sch_unregister);
+	queue_work(slow_path_wq, &cdev->private->kick_work);
+}
+
 /*
  * subchannel recognition done. Called from the state machine.
  */
@@ -1025,19 +1039,17 @@ io_subchannel_recog_done(struct ccw_device *cdev)
 		return;
 	}
 	switch (cdev->private->state) {
+	case DEV_STATE_BOXED:
+		/* Device did not respond in time. */
 	case DEV_STATE_NOT_OPER:
 		cdev->private->flags.recog_done = 1;
 		/* Remove device found not operational. */
 		if (!get_device(&cdev->dev))
 			break;
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister);
-		queue_work(slow_path_wq, &cdev->private->kick_work);
+		ccw_device_schedule_sch_unregister(cdev);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
 		break;
-	case DEV_STATE_BOXED:
-		/* Device did not respond in time. */
 	case DEV_STATE_OFFLINE:
 		/* 
 		 * We can't register the device in interrupt context so
@@ -1551,8 +1563,7 @@ static int purge_fn(struct device *dev, void *data)
 		goto out;
 	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", priv->dev_id.ssid,
 		      priv->dev_id.devno);
-	PREPARE_WORK(&cdev->private->kick_work, ccw_device_call_sch_unregister);
-	queue_work(slow_path_wq, &cdev->private->kick_work);
+	ccw_device_schedule_sch_unregister(cdev);
 
 out:
 	/* Abort loop in case of pending signal. */
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index 85e0184..f1cbbd9 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -87,6 +87,7 @@ int ccw_device_is_orphan(struct ccw_device *);
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
 int ccw_device_offline(struct ccw_device *);
+void ccw_device_schedule_sch_unregister(struct ccw_device *);
 int ccw_purge_blacklisted(void);
 
 /* Function prototypes for device status and basic sense stuff. */
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 87b4bfc..e460492 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -256,13 +256,12 @@ ccw_device_recog_done(struct ccw_device *cdev, int state)
 		old_lpm = 0;
 	if (sch->lpm != old_lpm)
 		__recover_lost_chpids(sch, old_lpm);
-	if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID) {
-		if (state == DEV_STATE_NOT_OPER) {
-			cdev->private->flags.recog_done = 1;
-			cdev->private->state = DEV_STATE_DISCONNECTED;
-			return;
-		}
-		/* Boxed devices don't need extra treatment. */
+	if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID &&
+	    (state == DEV_STATE_NOT_OPER || state == DEV_STATE_BOXED)) {
+		cdev->private->flags.recog_done = 1;
+		cdev->private->state = DEV_STATE_DISCONNECTED;
+		wake_up(&cdev->private->wait_q);
+		return;
 	}
 	notify = 0;
 	same_dev = 0; /* Keep the compiler quiet... */
@@ -274,7 +273,7 @@ ccw_device_recog_done(struct ccw_device *cdev, int state)
 			      sch->schid.ssid, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
-		if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID) {
+		if (cdev->online) {
 			same_dev = ccw_device_handle_oper(cdev);
 			notify = 1;
 		}
@@ -307,12 +306,17 @@ ccw_device_recog_done(struct ccw_device *cdev, int state)
 			      " subchannel 0.%x.%04x\n",
 			      cdev->private->dev_id.devno,
 			      sch->schid.ssid, sch->schid.sch_no);
+		if (cdev->id.cu_type != 0) { /* device was recognized before */
+			cdev->private->flags.recog_done = 1;
+			cdev->private->state = DEV_STATE_BOXED;
+			wake_up(&cdev->private->wait_q);
+			return;
+		}
 		break;
 	}
 	cdev->private->state = state;
 	io_subchannel_recog_done(cdev);
-	if (state != DEV_STATE_NOT_OPER)
-		wake_up(&cdev->private->wait_q);
+	wake_up(&cdev->private->wait_q);
 }
 
 /*
@@ -390,10 +394,13 @@ ccw_device_done(struct ccw_device *cdev, int state)
 
 	cdev->private->state = state;
 
-
-	if (state == DEV_STATE_BOXED)
+	if (state == DEV_STATE_BOXED) {
 		CIO_MSG_EVENT(0, "Boxed device %04x on subchannel %04x\n",
 			      cdev->private->dev_id.devno, sch->schid.sch_no);
+		if (cdev->online && !ccw_device_notify(cdev, CIO_BOXED))
+			ccw_device_schedule_sch_unregister(cdev);
+		cdev->private->flags.donotify = 0;
+	}
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
diff --git a/drivers/s390/scsi/zfcp_ccw.c b/drivers/s390/scsi/zfcp_ccw.c
index 1fe1e2e..cfb0dcb 100644
--- a/drivers/s390/scsi/zfcp_ccw.c
+++ b/drivers/s390/scsi/zfcp_ccw.c
@@ -176,6 +176,11 @@ static int zfcp_ccw_notify(struct ccw_device *ccw_device, int event)
 		zfcp_erp_adapter_reopen(adapter, ZFCP_STATUS_COMMON_ERP_FAILED,
 					"ccnoti4", NULL);
 		break;
+	case CIO_BOXED:
+		dev_warn(&adapter->ccw_device->dev,
+			 "The ccw device did not respond in time.\n");
+		zfcp_erp_adapter_shutdown(adapter, 0, "ccnoti5", NULL);
+		break;
 	}
 	return 1;
 }
