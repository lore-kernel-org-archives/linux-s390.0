Return-Path: <linux-kernel-owner+w=401wt.eu-S933888AbXCSNQq@vger.kernel.org>
Date: Mon, 19 Mar 2007 14:16:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Please pull git390 'for-linus' branch
Message-ID: <20070319131656.GA9749@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/kernel/compat_wrapper.S |   17 +++++++++++++++++
 arch/s390/kernel/debug.c          |    2 +-
 arch/s390/kernel/early.c          |   10 ++++++++--
 arch/s390/kernel/ipl.c            |    9 ++++-----
 arch/s390/kernel/syscalls.S       |    3 ++-
 drivers/s390/cio/qdio.c           |   26 ++++++++++++++++++--------
 drivers/s390/crypto/ap_bus.c      |   30 +++++++++++++++++++++++-------
 drivers/s390/crypto/ap_bus.h      |    1 +
 drivers/s390/crypto/zcrypt_api.c  |   12 ++++++------
 include/asm-s390/ipl.h            |    5 +++++
 include/asm-s390/unistd.h         |    3 ++-
 11 files changed, 87 insertions(+), 31 deletions(-)

Heiko Carstens (3):
      [S390] memory detection: fix off by one bug.
      [S390] Wire up compat_sys_epoll_pwait.
      [S390] Wire up sys_utimes.

Jean Delvare (1):
      [S390] strlcpy is smart enough

Michael Holzheu (1):
      [S390] reboot from and dump to SCSI under z/VM fails.

Ralph Wuerthner (2):
      [S390] zcrypt: fix possible dead lock in AP bus module
      [S390] zcrypt: fix possible race when unloading zcrypt driver modules

Ursula Braun (1):
      [S390] cio: qdio slsb setup

diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 9790129..32a69a1 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1665,3 +1665,20 @@ sys_getcpu_wrapper:
 	llgtr	%r3,%r3			# unsigned *
 	llgtr	%r4,%r4			# struct getcpu_cache *
 	jg	sys_getcpu
+
+	.globl	compat_sys_epoll_pwait_wrapper
+compat_sys_epoll_pwait_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# struct compat_epoll_event *
+	lgfr	%r4,%r4			# int
+	lgfr	%r5,%r5			# int
+	llgtr	%r6,%r6			# compat_sigset_t *
+	llgf	%r0,164(%r15)		# compat_size_t
+	stg	%r0,160(%r15)
+	jg	compat_sys_epoll_pwait
+
+	.globl	compat_sys_utimes_wrapper
+compat_sys_utimes_wrapper:
+	llgtr	%r2,%r2			# char *
+	llgtr	%r3,%r3			# struct compat_timeval *
+	jg	compat_sys_utimes
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index eca3fe5..dca6eaf 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -268,7 +268,7 @@ debug_info_alloc(char *name, int pages_per_area, int nr_areas, int buf_size,
 	rc->level          = level;
 	rc->buf_size       = buf_size;
 	rc->entry_size     = sizeof(debug_entry_t) + buf_size;
-	strlcpy(rc->name, name, sizeof(rc->name)-1);
+	strlcpy(rc->name, name, sizeof(rc->name));
 	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
 	memset(rc->debugfs_entries, 0 ,DEBUG_MAX_VIEWS *
 		sizeof(struct dentry*));
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index afca1c6..5e47936 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -141,9 +141,9 @@ static noinline __init void detect_machine_type(void)
 		machine_flags |= 4;
 }
 
+#ifdef CONFIG_64BIT
 static noinline __init int memory_fast_detect(void)
 {
-
 	unsigned long val0 = 0;
 	unsigned long val1 = 0xc;
 	int ret = -ENOSYS;
@@ -161,9 +161,15 @@ static noinline __init int memory_fast_detect(void)
 	if (ret || val0 != val1)
 		return -ENOSYS;
 
-	memory_chunk[0].size = val0;
+	memory_chunk[0].size = val0 + 1;
 	return 0;
 }
+#else
+static inline int memory_fast_detect(void)
+{
+	return -ENOSYS;
+}
+#endif
 
 #define ADDR2G	(1UL << 31)
 
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index d125a4e..f731185 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -839,7 +839,7 @@ static int __init reipl_ccw_init(void)
 	}
 	reipl_block_ccw->hdr.len = IPL_PARM_BLK_CCW_LEN;
 	reipl_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
-	reipl_block_ccw->hdr.blk0_len = sizeof(reipl_block_ccw->ipl_info.ccw);
+	reipl_block_ccw->hdr.blk0_len = IPL_PARM_BLK0_CCW_LEN;
 	reipl_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
 	/* check if read scp info worked and set loadparm */
 	if (SCCB_VALID)
@@ -880,8 +880,7 @@ static int __init reipl_fcp_init(void)
 	} else {
 		reipl_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
 		reipl_block_fcp->hdr.version = IPL_PARM_BLOCK_VERSION;
-		reipl_block_fcp->hdr.blk0_len =
-			sizeof(reipl_block_fcp->ipl_info.fcp);
+		reipl_block_fcp->hdr.blk0_len = IPL_PARM_BLK0_FCP_LEN;
 		reipl_block_fcp->hdr.pbt = DIAG308_IPL_TYPE_FCP;
 		reipl_block_fcp->ipl_info.fcp.opt = DIAG308_IPL_OPT_IPL;
 	}
@@ -930,7 +929,7 @@ static int __init dump_ccw_init(void)
 	}
 	dump_block_ccw->hdr.len = IPL_PARM_BLK_CCW_LEN;
 	dump_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
-	dump_block_ccw->hdr.blk0_len = sizeof(reipl_block_ccw->ipl_info.ccw);
+	dump_block_ccw->hdr.blk0_len = IPL_PARM_BLK0_CCW_LEN;
 	dump_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
 	dump_capabilities |= IPL_TYPE_CCW;
 	return 0;
@@ -954,7 +953,7 @@ static int __init dump_fcp_init(void)
 	}
 	dump_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
 	dump_block_fcp->hdr.version = IPL_PARM_BLOCK_VERSION;
-	dump_block_fcp->hdr.blk0_len = sizeof(dump_block_fcp->ipl_info.fcp);
+	dump_block_fcp->hdr.blk0_len = IPL_PARM_BLK0_FCP_LEN;
 	dump_block_fcp->hdr.pbt = DIAG308_IPL_TYPE_FCP;
 	dump_block_fcp->ipl_info.fcp.opt = DIAG308_IPL_OPT_DUMP;
 	dump_capabilities |= IPL_TYPE_FCP;
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index a52c444..c774f10 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -320,4 +320,5 @@ SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
 NI_SYSCALL							/* 310 sys_move_pages */
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
-SYSCALL(sys_epoll_pwait,sys_epoll_pwait,sys_ni_syscall)
+SYSCALL(sys_epoll_pwait,sys_epoll_pwait,compat_sys_epoll_pwait_wrapper)
+SYSCALL(sys_utimes,sys_utimes,compat_sys_utimes_wrapper)
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 5b1e3ff..05fac07 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -210,9 +210,11 @@ again:
 		goto again;
 	}
 	if (rc < 0) {
-                QDIO_DBF_TEXT3(1,trace,"sqberr");
-                sprintf(dbf_text,"%2x,%2x,%d,%d",tmp_cnt,*cnt,ccq,q_no);
-                QDIO_DBF_TEXT3(1,trace,dbf_text);
+		QDIO_DBF_TEXT3(1,trace,"sqberr");
+		sprintf(dbf_text,"%2x,%2x",tmp_cnt,*cnt);
+		QDIO_DBF_TEXT3(1,trace,dbf_text);
+		sprintf(dbf_text,"%d,%d",ccq,q_no);
+		QDIO_DBF_TEXT3(1,trace,dbf_text);
 		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
 				QDIO_STATUS_LOOK_FOR_ERROR,
 				0, 0, 0, -1, -1, q->int_parm);
@@ -1250,7 +1252,6 @@ qdio_is_inbound_q_done(struct qdio_q *q)
 	if (!no_used) {
 		QDIO_DBF_TEXT4(0,trace,"inqisdnA");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-		QDIO_DBF_TEXT4(0,trace,dbf_text);
 		return 1;
 	}
 	if (irq->is_qebsm) {
@@ -3371,10 +3372,15 @@ qdio_do_qdio_fill_input(struct qdio_q *q, unsigned int qidx,
 			unsigned int count, struct qdio_buffer *buffers)
 {
 	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+	int tmp = 0;
+
 	qidx &= (QDIO_MAX_BUFFERS_PER_Q - 1);
 	if (irq->is_qebsm) {
-		while (count)
-			set_slsb(q, &qidx, SLSB_CU_INPUT_EMPTY, &count);
+		while (count) {
+			tmp = set_slsb(q, &qidx, SLSB_CU_INPUT_EMPTY, &count);
+			if (!tmp)
+				return;
+		}
 		return;
 	}
 	for (;;) {
@@ -3390,11 +3396,15 @@ qdio_do_qdio_fill_output(struct qdio_q *q, unsigned int qidx,
 			 unsigned int count, struct qdio_buffer *buffers)
 {
 	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+	int tmp = 0;
 
 	qidx &= (QDIO_MAX_BUFFERS_PER_Q - 1);
 	if (irq->is_qebsm) {
-		while (count)
-			set_slsb(q, &qidx, SLSB_CU_OUTPUT_PRIMED, &count);
+		while (count) {
+			tmp = set_slsb(q, &qidx, SLSB_CU_OUTPUT_PRIMED, &count);
+			if (!tmp)
+				return;
+		}
 		return;
 	}
 
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index c7d1355..181b517 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -65,6 +65,8 @@ module_param_named(poll_thread, ap_thread_flag, int, 0000);
 MODULE_PARM_DESC(poll_thread, "Turn on/off poll thread, default is 1 (on).");
 
 static struct device *ap_root_device = NULL;
+static DEFINE_SPINLOCK(ap_device_lock);
+static LIST_HEAD(ap_device_list);
 
 /**
  * Workqueue & timer for bus rescan.
@@ -457,6 +459,9 @@ static int ap_device_probe(struct device *dev)
 	int rc;
 
 	ap_dev->drv = ap_drv;
+	spin_lock_bh(&ap_device_lock);
+	list_add(&ap_dev->list, &ap_device_list);
+	spin_unlock_bh(&ap_device_lock);
 	rc = ap_drv->probe ? ap_drv->probe(ap_dev) : -ENODEV;
 	return rc;
 }
@@ -497,6 +502,9 @@ static int ap_device_remove(struct device *dev)
 	ap_flush_queue(ap_dev);
 	if (ap_drv->remove)
 		ap_drv->remove(ap_dev);
+	spin_lock_bh(&ap_device_lock);
+	list_del_init(&ap_dev->list);
+	spin_unlock_bh(&ap_device_lock);
 	return 0;
 }
 
@@ -772,6 +780,7 @@ static void ap_scan_bus(struct work_struct *unused)
 		spin_lock_init(&ap_dev->lock);
 		INIT_LIST_HEAD(&ap_dev->pendingq);
 		INIT_LIST_HEAD(&ap_dev->requestq);
+		INIT_LIST_HEAD(&ap_dev->list);
 		if (device_type == 0)
 			ap_probe_device_type(ap_dev);
 		else
@@ -1033,14 +1042,13 @@ static void ap_poll_timeout(unsigned long unused)
  * polling until bit 2^0 of the control flags is not set. If bit 2^1
  * of the control flags has been set arm the poll timer.
  */
-static int __ap_poll_all(struct device *dev, void *data)
+static int __ap_poll_all(struct ap_device *ap_dev, unsigned long *flags)
 {
-	struct ap_device *ap_dev = to_ap_dev(dev);
 	int rc;
 
 	spin_lock(&ap_dev->lock);
 	if (!ap_dev->unregistered) {
-		rc = ap_poll_queue(to_ap_dev(dev), (unsigned long *) data);
+		rc = ap_poll_queue(ap_dev, flags);
 		if (rc)
 			ap_dev->unregistered = 1;
 	} else
@@ -1054,10 +1062,15 @@ static int __ap_poll_all(struct device *dev, void *data)
 static void ap_poll_all(unsigned long dummy)
 {
 	unsigned long flags;
+	struct ap_device *ap_dev;
 
 	do {
 		flags = 0;
-		bus_for_each_dev(&ap_bus_type, NULL, &flags, __ap_poll_all);
+		spin_lock(&ap_device_lock);
+		list_for_each_entry(ap_dev, &ap_device_list, list) {
+			__ap_poll_all(ap_dev, &flags);
+		}
+		spin_unlock(&ap_device_lock);
 	} while (flags & 1);
 	if (flags & 2)
 		ap_schedule_poll_timer();
@@ -1075,6 +1088,7 @@ static int ap_poll_thread(void *data)
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	int requests;
+	struct ap_device *ap_dev;
 
 	set_user_nice(current, 19);
 	while (1) {
@@ -1092,10 +1106,12 @@ static int ap_poll_thread(void *data)
 		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&ap_poll_wait, &wait);
 
-		local_bh_disable();
 		flags = 0;
-		bus_for_each_dev(&ap_bus_type, NULL, &flags, __ap_poll_all);
-		local_bh_enable();
+		spin_lock_bh(&ap_device_lock);
+		list_for_each_entry(ap_dev, &ap_device_list, list) {
+			__ap_poll_all(ap_dev, &flags);
+		}
+		spin_unlock_bh(&ap_device_lock);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ap_poll_wait, &wait);
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 83b69c0..008559e 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -106,6 +106,7 @@ struct ap_device {
 	struct device device;
 	struct ap_driver *drv;		/* Pointer to AP device driver. */
 	spinlock_t lock;		/* Per device lock. */
+	struct list_head list;		/* private list of all AP devices. */
 
 	ap_qid_t qid;			/* AP queue id. */
 	int queue_depth;		/* AP queue depth.*/
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 9976139..e3625a4 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -298,14 +298,14 @@ static long zcrypt_rsa_modexpo(struct ica_rsa_modexpo *mex)
 		get_device(&zdev->ap_dev->device);
 		zdev->request_count++;
 		__zcrypt_decrease_preference(zdev);
-		spin_unlock_bh(&zcrypt_device_lock);
 		if (try_module_get(zdev->ap_dev->drv->driver.owner)) {
+			spin_unlock_bh(&zcrypt_device_lock);
 			rc = zdev->ops->rsa_modexpo(zdev, mex);
+			spin_lock_bh(&zcrypt_device_lock);
 			module_put(zdev->ap_dev->drv->driver.owner);
 		}
 		else
 			rc = -EAGAIN;
-		spin_lock_bh(&zcrypt_device_lock);
 		zdev->request_count--;
 		__zcrypt_increase_preference(zdev);
 		put_device(&zdev->ap_dev->device);
@@ -373,14 +373,14 @@ static long zcrypt_rsa_crt(struct ica_rsa_modexpo_crt *crt)
 		get_device(&zdev->ap_dev->device);
 		zdev->request_count++;
 		__zcrypt_decrease_preference(zdev);
-		spin_unlock_bh(&zcrypt_device_lock);
 		if (try_module_get(zdev->ap_dev->drv->driver.owner)) {
+			spin_unlock_bh(&zcrypt_device_lock);
 			rc = zdev->ops->rsa_modexpo_crt(zdev, crt);
+			spin_lock_bh(&zcrypt_device_lock);
 			module_put(zdev->ap_dev->drv->driver.owner);
 		}
 		else
 			rc = -EAGAIN;
-		spin_lock_bh(&zcrypt_device_lock);
 		zdev->request_count--;
 		__zcrypt_increase_preference(zdev);
 		put_device(&zdev->ap_dev->device);
@@ -408,14 +408,14 @@ static long zcrypt_send_cprb(struct ica_xcRB *xcRB)
 		get_device(&zdev->ap_dev->device);
 		zdev->request_count++;
 		__zcrypt_decrease_preference(zdev);
-		spin_unlock_bh(&zcrypt_device_lock);
 		if (try_module_get(zdev->ap_dev->drv->driver.owner)) {
+			spin_unlock_bh(&zcrypt_device_lock);
 			rc = zdev->ops->send_cprb(zdev, xcRB);
+			spin_lock_bh(&zcrypt_device_lock);
 			module_put(zdev->ap_dev->drv->driver.owner);
 		}
 		else
 			rc = -EAGAIN;
-		spin_lock_bh(&zcrypt_device_lock);
 		zdev->request_count--;
 		__zcrypt_increase_preference(zdev);
 		put_device(&zdev->ap_dev->device);
diff --git a/include/asm-s390/ipl.h b/include/asm-s390/ipl.h
index 660f782..0eb6408 100644
--- a/include/asm-s390/ipl.h
+++ b/include/asm-s390/ipl.h
@@ -14,9 +14,13 @@
 #define IPL_PARM_BLK_FCP_LEN (sizeof(struct ipl_list_hdr) + \
 			      sizeof(struct ipl_block_fcp))
 
+#define IPL_PARM_BLK0_FCP_LEN (sizeof(struct ipl_block_fcp) + 8)
+
 #define IPL_PARM_BLK_CCW_LEN (sizeof(struct ipl_list_hdr) + \
 			      sizeof(struct ipl_block_ccw))
 
+#define IPL_PARM_BLK0_CCW_LEN (sizeof(struct ipl_block_ccw) + 8)
+
 #define IPL_MAX_SUPPORTED_VERSION (0)
 
 #define IPL_PARMBLOCK_START	((struct ipl_parameter_block *) \
@@ -58,6 +62,7 @@ struct ipl_block_ccw {
 	u8  vm_flags;
 	u8  reserved3[3];
 	u32 vm_parm_len;
+	u8  reserved4[80];
 } __attribute__((packed));
 
 struct ipl_parameter_block {
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index fb6fef9..5c6f00d 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -250,8 +250,9 @@
 /* Number 310 is reserved for new sys_move_pages */
 #define __NR_getcpu		311
 #define __NR_epoll_pwait	312
+#define __NR_utimes		313
 
-#define NR_syscalls 313
+#define NR_syscalls 314
 
 /* 
  * There are some system calls that are not present on 64 bit, some
