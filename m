Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 7 Mar 2018 07:53:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.16-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180307075354.3746bd5f@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Nine bug fixes for s390:

 * Three fixes for the expoline code, one of them is strictly speaking
   a cleanup but as it relates to code added with 4.16 I would like to
   include the patch.

 * Three timer related fixes in the common I/O layer

 * A fix for the handling of internal DASD request which could cause panics.

 * One correction in regard to the accounting of pud page tables vs.
   compat tasks.

 * The register scrubbing in entry.S caused spurious crashes, this is
   fixed now as well.

Christian Borntraeger (1):
      s390/entry.S: fix spurious zeroing of r0

Eugeniu Rosca (1):
      s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)

Guenter Roeck (1):
      s390: Fix runtime warning about negative pgtables_bytes

Hendrik Brueckner (1):
      s390/clean-up: use CFI_* macros in entry.S

Martin Schwidefsky (1):
      s390: do not bypass BPENTER for interrupt system calls

Sebastian Ott (3):
      s390/cio: fix ccw_device_start_timeout API
      s390/cio: fix return code after missing interrupt
      s390/cio: clear timer when terminating driver I/O

Stefan Haberland (1):
      s390/dasd: fix handling of internal requests

 arch/s390/include/asm/mmu_context.h |  1 +
 arch/s390/kernel/entry.S            | 10 +++---
 arch/s390/kernel/nospec-branch.c    |  4 +--
 drivers/s390/block/dasd.c           | 21 ++++-------
 drivers/s390/cio/device_fsm.c       |  7 ++--
 drivers/s390/cio/device_ops.c       | 72 +++++++++++++++++--------------------
 drivers/s390/cio/io_sch.h           |  1 +
 7 files changed, 54 insertions(+), 62 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 65154ea..6c8ce15 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -63,6 +63,7 @@ static inline int init_new_context(struct task_struct *tsk,
 				   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
 		/* pgd_alloc() did not account this pmd */
 		mm_inc_nr_pmds(mm);
+		mm_inc_nr_puds(mm);
 	}
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 13a133a..a5621ea 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <asm/cache.h>
 #include <asm/ctl_reg.h>
+#include <asm/dwarf.h>
 #include <asm/errno.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
@@ -230,7 +231,7 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
 	.hidden \name
 	.type \name,@function
 \name:
-	.cfi_startproc
+	CFI_STARTPROC
 #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
 	exrl	0,0f
 #else
@@ -239,7 +240,7 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
 #endif
 	j	.
 0:	br	\reg
-	.cfi_endproc
+	CFI_ENDPROC
 	.endm
 
 	GEN_BR_THUNK __s390x_indirect_jump_r1use_r9,%r9,%r1
@@ -426,13 +427,13 @@ ENTRY(system_call)
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
 	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	stmg	%r0,%r7,__PT_R0(%r11)
-	# clear user controlled register to prevent speculative use
-	xgr	%r0,%r0
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
 	stg	%r14,__PT_FLAGS(%r11)
 .Lsysc_do_svc:
+	# clear user controlled register to prevent speculative use
+	xgr	%r0,%r0
 	# load address of system call table
 	lg	%r10,__THREAD_sysc_table(%r13,%r12)
 	llgh	%r8,__PT_INT_CODE+2(%r11)
@@ -1439,6 +1440,7 @@ cleanup_critical:
 	stg	%r15,__LC_SYSTEM_TIMER
 0:	# update accounting time stamp
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	# set up saved register r11
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r9,STACK_FRAME_OVERHEAD(%r15)
diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index 69d7fcf..9aff72d 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -2,8 +2,8 @@
 #include <linux/module.h>
 #include <asm/nospec-branch.h>
 
-int nospec_call_disable = IS_ENABLED(EXPOLINE_OFF);
-int nospec_return_disable = !IS_ENABLED(EXPOLINE_FULL);
+int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
+int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
 
 static int __init nospectre_v2_setup_early(char *str)
 {
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index a7c15f0..ecef8e7 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2581,8 +2581,6 @@ int dasd_cancel_req(struct dasd_ccw_req *cqr)
 	case DASD_CQR_QUEUED:
 		/* request was not started - just set to cleared */
 		cqr->status = DASD_CQR_CLEARED;
-		if (cqr->callback_data == DASD_SLEEPON_START_TAG)
-			cqr->callback_data = DASD_SLEEPON_END_TAG;
 		break;
 	case DASD_CQR_IN_IO:
 		/* request in IO - terminate IO and release again */
@@ -3902,9 +3900,12 @@ static int dasd_generic_requeue_all_requests(struct dasd_device *device)
 		wait_event(dasd_flush_wq,
 			   (cqr->status != DASD_CQR_CLEAR_PENDING));
 
-		/* mark sleepon requests as ended */
-		if (cqr->callback_data == DASD_SLEEPON_START_TAG)
-			cqr->callback_data = DASD_SLEEPON_END_TAG;
+		/*
+		 * requeue requests to blocklayer will only work
+		 * for block device requests
+		 */
+		if (_dasd_requeue_request(cqr))
+			continue;
 
 		/* remove requests from device and block queue */
 		list_del_init(&cqr->devlist);
@@ -3917,13 +3918,6 @@ static int dasd_generic_requeue_all_requests(struct dasd_device *device)
 			cqr = refers;
 		}
 
-		/*
-		 * requeue requests to blocklayer will only work
-		 * for block device requests
-		 */
-		if (_dasd_requeue_request(cqr))
-			continue;
-
 		if (cqr->block)
 			list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
@@ -3940,8 +3934,7 @@ static int dasd_generic_requeue_all_requests(struct dasd_device *device)
 		list_splice_tail(&requeue_queue, &device->ccw_queue);
 		spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	}
-	/* wake up generic waitqueue for eventually ended sleepon requests */
-	wake_up(&generic_waitq);
+	dasd_schedule_device_bh(device);
 	return rc;
 }
 
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 1319122..9169af7 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -795,6 +795,7 @@ ccw_device_online_timeout(struct ccw_device *cdev, enum dev_event dev_event)
 
 	ccw_device_set_timeout(cdev, 0);
 	cdev->private->iretry = 255;
+	cdev->private->async_kill_io_rc = -ETIMEDOUT;
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
@@ -871,7 +872,7 @@ ccw_device_killing_irq(struct ccw_device *cdev, enum dev_event dev_event)
 	/* OK, i/o is dead now. Call interrupt handler. */
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-EIO));
+			      ERR_PTR(cdev->private->async_kill_io_rc));
 }
 
 static void
@@ -888,14 +889,16 @@ ccw_device_killing_timeout(struct ccw_device *cdev, enum dev_event dev_event)
 	ccw_device_online_verify(cdev, 0);
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-EIO));
+			      ERR_PTR(cdev->private->async_kill_io_rc));
 }
 
 void ccw_device_kill_io(struct ccw_device *cdev)
 {
 	int ret;
 
+	ccw_device_set_timeout(cdev, 0);
 	cdev->private->iretry = 255;
+	cdev->private->async_kill_io_rc = -EIO;
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 1caf6a3..75ce12a 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -159,7 +159,7 @@ int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
 }
 
 /**
- * ccw_device_start_key() - start a s390 channel program with key
+ * ccw_device_start_timeout_key() - start a s390 channel program with timeout and key
  * @cdev: target ccw device
  * @cpa: logical start address of channel program
  * @intparm: user specific interruption parameter; will be presented back to
@@ -170,10 +170,15 @@ int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
  * @key: storage key to be used for the I/O
  * @flags: additional flags; defines the action to be performed for I/O
  *	   processing.
+ * @expires: timeout value in jiffies
  *
  * Start a S/390 channel program. When the interrupt arrives, the
  * IRQ handler is called, either immediately, delayed (dev-end missing,
  * or sense required) or never (no IRQ handler registered).
+ * This function notifies the device driver if the channel program has not
+ * completed during the time specified by @expires. If a timeout occurs, the
+ * channel program is terminated via xsch, hsch or csch, and the device's
+ * interrupt handler will be called with an irb containing ERR_PTR(-%ETIMEDOUT).
  * Returns:
  *  %0, if the operation was successful;
  *  -%EBUSY, if the device is busy, or status pending;
@@ -182,9 +187,9 @@ int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
  * Context:
  *  Interrupts disabled, ccw device lock held
  */
-int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
-			 unsigned long intparm, __u8 lpm, __u8 key,
-			 unsigned long flags)
+int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
+				 unsigned long intparm, __u8 lpm, __u8 key,
+				 unsigned long flags, int expires)
 {
 	struct subchannel *sch;
 	int ret;
@@ -224,6 +229,8 @@ int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
 	switch (ret) {
 	case 0:
 		cdev->private->intparm = intparm;
+		if (expires)
+			ccw_device_set_timeout(cdev, expires);
 		break;
 	case -EACCES:
 	case -ENODEV:
@@ -234,7 +241,7 @@ int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
 }
 
 /**
- * ccw_device_start_timeout_key() - start a s390 channel program with timeout and key
+ * ccw_device_start_key() - start a s390 channel program with key
  * @cdev: target ccw device
  * @cpa: logical start address of channel program
  * @intparm: user specific interruption parameter; will be presented back to
@@ -245,15 +252,10 @@ int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
  * @key: storage key to be used for the I/O
  * @flags: additional flags; defines the action to be performed for I/O
  *	   processing.
- * @expires: timeout value in jiffies
  *
  * Start a S/390 channel program. When the interrupt arrives, the
  * IRQ handler is called, either immediately, delayed (dev-end missing,
  * or sense required) or never (no IRQ handler registered).
- * This function notifies the device driver if the channel program has not
- * completed during the time specified by @expires. If a timeout occurs, the
- * channel program is terminated via xsch, hsch or csch, and the device's
- * interrupt handler will be called with an irb containing ERR_PTR(-%ETIMEDOUT).
  * Returns:
  *  %0, if the operation was successful;
  *  -%EBUSY, if the device is busy, or status pending;
@@ -262,19 +264,12 @@ int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
  * Context:
  *  Interrupts disabled, ccw device lock held
  */
-int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
-				 unsigned long intparm, __u8 lpm, __u8 key,
-				 unsigned long flags, int expires)
+int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
+			 unsigned long intparm, __u8 lpm, __u8 key,
+			 unsigned long flags)
 {
-	int ret;
-
-	if (!cdev)
-		return -ENODEV;
-	ccw_device_set_timeout(cdev, expires);
-	ret = ccw_device_start_key(cdev, cpa, intparm, lpm, key, flags);
-	if (ret != 0)
-		ccw_device_set_timeout(cdev, 0);
-	return ret;
+	return ccw_device_start_timeout_key(cdev, cpa, intparm, lpm, key,
+					    flags, 0);
 }
 
 /**
@@ -489,18 +484,20 @@ void ccw_device_get_id(struct ccw_device *cdev, struct ccw_dev_id *dev_id)
 EXPORT_SYMBOL(ccw_device_get_id);
 
 /**
- * ccw_device_tm_start_key() - perform start function
+ * ccw_device_tm_start_timeout_key() - perform start function
  * @cdev: ccw device on which to perform the start function
  * @tcw: transport-command word to be started
  * @intparm: user defined parameter to be passed to the interrupt handler
  * @lpm: mask of paths to use
  * @key: storage key to use for storage access
+ * @expires: time span in jiffies after which to abort request
  *
  * Start the tcw on the given ccw device. Return zero on success, non-zero
  * otherwise.
  */
-int ccw_device_tm_start_key(struct ccw_device *cdev, struct tcw *tcw,
-			    unsigned long intparm, u8 lpm, u8 key)
+int ccw_device_tm_start_timeout_key(struct ccw_device *cdev, struct tcw *tcw,
+				    unsigned long intparm, u8 lpm, u8 key,
+				    int expires)
 {
 	struct subchannel *sch;
 	int rc;
@@ -527,37 +524,32 @@ int ccw_device_tm_start_key(struct ccw_device *cdev, struct tcw *tcw,
 			return -EACCES;
 	}
 	rc = cio_tm_start_key(sch, tcw, lpm, key);
-	if (rc == 0)
+	if (rc == 0) {
 		cdev->private->intparm = intparm;
+		if (expires)
+			ccw_device_set_timeout(cdev, expires);
+	}
 	return rc;
 }
-EXPORT_SYMBOL(ccw_device_tm_start_key);
+EXPORT_SYMBOL(ccw_device_tm_start_timeout_key);
 
 /**
- * ccw_device_tm_start_timeout_key() - perform start function
+ * ccw_device_tm_start_key() - perform start function
  * @cdev: ccw device on which to perform the start function
  * @tcw: transport-command word to be started
  * @intparm: user defined parameter to be passed to the interrupt handler
  * @lpm: mask of paths to use
  * @key: storage key to use for storage access
- * @expires: time span in jiffies after which to abort request
  *
  * Start the tcw on the given ccw device. Return zero on success, non-zero
  * otherwise.
  */
-int ccw_device_tm_start_timeout_key(struct ccw_device *cdev, struct tcw *tcw,
-				    unsigned long intparm, u8 lpm, u8 key,
-				    int expires)
+int ccw_device_tm_start_key(struct ccw_device *cdev, struct tcw *tcw,
+			    unsigned long intparm, u8 lpm, u8 key)
 {
-	int ret;
-
-	ccw_device_set_timeout(cdev, expires);
-	ret = ccw_device_tm_start_key(cdev, tcw, intparm, lpm, key);
-	if (ret != 0)
-		ccw_device_set_timeout(cdev, 0);
-	return ret;
+	return ccw_device_tm_start_timeout_key(cdev, tcw, intparm, lpm, key, 0);
 }
-EXPORT_SYMBOL(ccw_device_tm_start_timeout_key);
+EXPORT_SYMBOL(ccw_device_tm_start_key);
 
 /**
  * ccw_device_tm_start() - perform start function
diff --git a/drivers/s390/cio/io_sch.h b/drivers/s390/cio/io_sch.h
index af571d8..90e4e3a 100644
--- a/drivers/s390/cio/io_sch.h
+++ b/drivers/s390/cio/io_sch.h
@@ -157,6 +157,7 @@ struct ccw_device_private {
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
 	struct irb irb;		/* device status */
+	int async_kill_io_rc;
 	struct senseid senseid;	/* SenseID info */
 	struct pgid pgid[8];	/* path group IDs per chpid*/
 	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
