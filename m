Return-Path: <linux-kernel-owner+w=401wt.eu-S1756280AbYBSOue@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Tue, 19 Feb 2008 15:46:27 +0100
Message-Id: <1203432387.2887.1.camel@localhost>
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

 arch/s390/Kconfig                |    3 +-
 arch/s390/kernel/process.c       |   15 ++++++----
 arch/s390/kernel/smp.c           |   53 +++++++++++++++++++++++++++----------
 arch/s390/kernel/time.c          |    2 -
 arch/s390/lib/uaccess_std.c      |    8 +++---
 drivers/s390/block/dasd.c        |   12 ++++----
 drivers/s390/block/dcssblk.c     |    2 +-
 drivers/s390/char/sclp.c         |   12 ++++----
 drivers/s390/char/sclp.h         |    6 +++-
 drivers/s390/char/sclp_config.c  |    2 +-
 drivers/s390/char/sclp_cpi_sys.c |    2 +-
 drivers/s390/char/sclp_rw.c      |    4 +-
 drivers/s390/char/sclp_vt220.c   |    2 +-
 drivers/s390/cio/device.c        |   15 +++++++++-
 drivers/s390/cio/qdio.c          |   13 +--------
 drivers/s390/cio/qdio.h          |    2 +-
 include/asm-s390/bitops.h        |   20 ++++++++-----
 17 files changed, 103 insertions(+), 70 deletions(-)

Cornelia Huck (2):
      [S390] cio: Remember to initialize recovery_lock.
      [S390] cio: Do timed recovery on workqueue.

Heiko Carstens (6):
      [S390] Let NR_CPUS default to 32/64 on s390/s390x.
      [S390] Make sure enabled wait psw is loaded in default_idle.
      [S390] Initialize per cpu lowcores on cpu hotplug.
      [S390] qdio: fix qdio_activate timeout handling.
      [S390] etr: fix compile error on !SMP
      [S390] Fix futex_atomic_cmpxchg_std inline assembly.

Martin Schwidefsky (1):
      [S390] find bit corner case.

Peter Oberparleiter (1):
      [S390] sclp: clean up send/receive naming scheme

Roel Kluin (1):
      [S390] dcss: Fix Unlikely(x) != y

Stefan Weinhuber (1):
      [S390] dasd: fix locking in __dasd_device_process_final_queue

Ursula Braun (1):
      [S390] qdio: FCP/SCSI write I/O stagnates on LPAR

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 92a4f7b..b21444b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -100,7 +100,8 @@ config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
 	range 2 64
 	depends on SMP
-	default "32"
+	default "32" if !64BIT
+	default "64" if 64BIT
 	help
 	  This allows you to specify the maximum number of CPUs which this
 	  kernel will support.  The maximum supported value is 64 and the
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index a6a4729..1c59ec1 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -114,24 +114,27 @@ extern void s390_handle_mcck(void);
 static void default_idle(void)
 {
 	int cpu, rc;
+	int nr_calls = 0;
+	void *hcpu;
 #ifdef CONFIG_SMP
 	struct s390_idle_data *idle;
 #endif
 
 	/* CPU is going idle. */
 	cpu = smp_processor_id();
-
+	hcpu = (void *)(long)cpu;
 	local_irq_disable();
 	if (need_resched()) {
 		local_irq_enable();
 		return;
 	}
 
-	rc = atomic_notifier_call_chain(&idle_chain,
-					S390_CPU_IDLE, (void *)(long) cpu);
-	if (rc != NOTIFY_OK && rc != NOTIFY_DONE)
-		BUG();
-	if (rc != NOTIFY_OK) {
+	rc = __atomic_notifier_call_chain(&idle_chain, S390_CPU_IDLE, hcpu, -1,
+					  &nr_calls);
+	if (rc == NOTIFY_BAD) {
+		nr_calls--;
+		__atomic_notifier_call_chain(&idle_chain, S390_CPU_NOT_IDLE,
+					     hcpu, nr_calls, NULL);
 		local_irq_enable();
 		return;
 	}
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 8506065..818bd09 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -626,13 +626,17 @@ static int __cpuinit smp_alloc_lowcore(int cpu)
 	if (!lowcore)
 		return -ENOMEM;
 	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
-	if (!async_stack)
-		goto out_async_stack;
 	panic_stack = __get_free_page(GFP_KERNEL);
-	if (!panic_stack)
-		goto out_panic_stack;
-
-	*lowcore = S390_lowcore;
+	if (!panic_stack || !async_stack)
+		goto out;
+	/*
+	 * Only need to copy the first 512 bytes from address 0. But since
+	 * the compiler emits a warning if src == NULL for memcpy use copy_page
+	 * instead. Copies more than needed but this code is not performance
+	 * critical.
+	 */
+	copy_page(lowcore, &S390_lowcore);
+	memset((void *)lowcore + 512, 0, sizeof(*lowcore) - 512);
 	lowcore->async_stack = async_stack + ASYNC_SIZE;
 	lowcore->panic_stack = panic_stack + PAGE_SIZE;
 
@@ -653,9 +657,8 @@ static int __cpuinit smp_alloc_lowcore(int cpu)
 out_save_area:
 	free_page(panic_stack);
 #endif
-out_panic_stack:
+out:
 	free_pages(async_stack, ASYNC_ORDER);
-out_async_stack:
 	free_pages((unsigned long) lowcore, lc_order);
 	return -ENOMEM;
 }
@@ -719,8 +722,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	cpu_lowcore->percpu_offset = __per_cpu_offset[cpu];
 	cpu_lowcore->current_task = (unsigned long) idle;
 	cpu_lowcore->cpu_data.cpu_nr = cpu;
-	cpu_lowcore->softirq_pending = 0;
-	cpu_lowcore->ext_call_fast = 0;
+	cpu_lowcore->kernel_asce = S390_lowcore.kernel_asce;
+	cpu_lowcore->ipl_device = S390_lowcore.ipl_device;
 	eieio();
 
 	while (signal_processor(cpu, sigp_restart) == sigp_busy)
@@ -797,23 +800,43 @@ void cpu_die(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+#ifndef CONFIG_64BIT
+	unsigned long save_area = 0;
+#endif
+	unsigned long async_stack, panic_stack;
+	struct _lowcore *lowcore;
 	unsigned int cpu;
+	int lc_order;
 
 	smp_detect_cpus();
 
 	/* request the 0x1201 emergency signal external interrupt */
 	if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
 		panic("Couldn't request external interrupt 0x1201");
-	memset(lowcore_ptr, 0, sizeof(lowcore_ptr));
 	print_cpu_info(&S390_lowcore.cpu_data);
-	smp_alloc_lowcore(smp_processor_id());
 
+	/* Reallocate current lowcore, but keep its contents. */
+	lc_order = sizeof(long) == 8 ? 1 : 0;
+	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, lc_order);
+	panic_stack = __get_free_page(GFP_KERNEL);
+	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
-		ctl_set_bit(14, 29); /* enable extended save area */
+		save_area = get_zeroed_page(GFP_KERNEL);
 #endif
-	set_prefix((u32)(unsigned long) lowcore_ptr[smp_processor_id()]);
-
+	local_irq_disable();
+	local_mcck_disable();
+	lowcore_ptr[smp_processor_id()] = lowcore;
+	*lowcore = S390_lowcore;
+	lowcore->panic_stack = panic_stack + PAGE_SIZE;
+	lowcore->async_stack = async_stack + ASYNC_SIZE;
+#ifndef CONFIG_64BIT
+	if (MACHINE_HAS_IEEE)
+		lowcore->extended_save_area_addr = (u32) save_area;
+#endif
+	set_prefix((u32)(unsigned long) lowcore);
+	local_mcck_enable();
+	local_irq_enable();
 	for_each_possible_cpu(cpu)
 		if (cpu != smp_processor_id())
 			smp_create_idle(cpu);
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 3bbac12..76a5dd1 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -744,7 +744,6 @@ static void etr_adjust_time(unsigned long long clock, unsigned long long delay)
 	}
 }
 
-#ifdef CONFIG_SMP
 static void etr_sync_cpu_start(void *dummy)
 {
 	int *in_sync = dummy;
@@ -777,7 +776,6 @@ static void etr_sync_cpu_start(void *dummy)
 static void etr_sync_cpu_end(void *dummy)
 {
 }
-#endif /* CONFIG_SMP */
 
 /*
  * Sync the TOD clock using the port refered to by aibp. This port
diff --git a/arch/s390/lib/uaccess_std.c b/arch/s390/lib/uaccess_std.c
index 28c4500..d2ffbad 100644
--- a/arch/s390/lib/uaccess_std.c
+++ b/arch/s390/lib/uaccess_std.c
@@ -293,10 +293,10 @@ int futex_atomic_cmpxchg_std(int __user *uaddr, int oldval, int newval)
 
 	asm volatile(
 		"   sacf 256\n"
-		"   cs   %1,%4,0(%5)\n"
-		"0: lr   %0,%1\n"
-		"1: sacf 0\n"
-		EX_TABLE(0b,1b)
+		"0: cs   %1,%4,0(%5)\n"
+		"1: lr   %0,%1\n"
+		"2: sacf 0\n"
+		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
 		: "=d" (ret), "+d" (oldval), "=m" (*uaddr)
 		: "0" (-EFAULT), "d" (newval), "a" (uaddr), "m" (*uaddr)
 		: "cc", "memory" );
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d984e0f..ccf46c9 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1149,12 +1149,14 @@ static void __dasd_device_process_final_queue(struct dasd_device *device,
 {
 	struct list_head *l, *n;
 	struct dasd_ccw_req *cqr;
+	struct dasd_block *block;
 
 	list_for_each_safe(l, n, final_queue) {
 		cqr = list_entry(l, struct dasd_ccw_req, devlist);
 		list_del_init(&cqr->devlist);
-		if (cqr->block)
-			spin_lock_bh(&cqr->block->queue_lock);
+		block = cqr->block;
+		if (block)
+			spin_lock_bh(&block->queue_lock);
 		switch (cqr->status) {
 		case DASD_CQR_SUCCESS:
 			cqr->status = DASD_CQR_DONE;
@@ -1172,15 +1174,13 @@ static void __dasd_device_process_final_queue(struct dasd_device *device,
 				    cqr, cqr->status);
 			BUG();
 		}
-		if (cqr->block)
-			spin_unlock_bh(&cqr->block->queue_lock);
 		if (cqr->callback != NULL)
 			(cqr->callback)(cqr, cqr->callback_data);
+		if (block)
+			spin_unlock_bh(&block->queue_lock);
 	}
 }
 
-
-
 /*
  * Take a look at the first request on the ccw queue and check
  * if it reached its expire time. If so, terminate the IO.
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 3faf053..e6c94db 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -666,7 +666,7 @@ dcssblk_make_request(struct request_queue *q, struct bio *bio)
 		page_addr = (unsigned long)
 			page_address(bvec->bv_page) + bvec->bv_offset;
 		source_addr = dev_info->start + (index<<12) + bytes_done;
-		if (unlikely(page_addr & 4095) != 0 || (bvec->bv_len & 4095) != 0)
+		if (unlikely((page_addr & 4095) != 0) || (bvec->bv_len & 4095) != 0)
 			// More paranoia.
 			goto fail;
 		if (bio_data_dir(bio) == READ) {
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 25629b9..2c7a1ee 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -29,10 +29,10 @@ static ext_int_info_t ext_int_info_hwc;
 /* Lock to protect internal data consistency. */
 static DEFINE_SPINLOCK(sclp_lock);
 
-/* Mask of events that we can receive from the sclp interface. */
+/* Mask of events that we can send to the sclp interface. */
 static sccb_mask_t sclp_receive_mask;
 
-/* Mask of events that we can send to the sclp interface. */
+/* Mask of events that we can receive from the sclp interface. */
 static sccb_mask_t sclp_send_mask;
 
 /* List of registered event listeners and senders. */
@@ -380,7 +380,7 @@ sclp_interrupt_handler(__u16 code)
 		}
 		sclp_running_state = sclp_running_state_idle;
 	}
-	if (evbuf_pending && sclp_receive_mask != 0 &&
+	if (evbuf_pending &&
 	    sclp_activation_state == sclp_activation_state_active)
 		__sclp_queue_read_req();
 	spin_unlock(&sclp_lock);
@@ -459,8 +459,8 @@ sclp_dispatch_state_change(void)
 		reg = NULL;
 		list_for_each(l, &sclp_reg_list) {
 			reg = list_entry(l, struct sclp_register, list);
-			receive_mask = reg->receive_mask & sclp_receive_mask;
-			send_mask = reg->send_mask & sclp_send_mask;
+			receive_mask = reg->send_mask & sclp_receive_mask;
+			send_mask = reg->receive_mask & sclp_send_mask;
 			if (reg->sclp_receive_mask != receive_mask ||
 			    reg->sclp_send_mask != send_mask) {
 				reg->sclp_receive_mask = receive_mask;
@@ -615,8 +615,8 @@ struct init_sccb {
 	u16 mask_length;
 	sccb_mask_t receive_mask;
 	sccb_mask_t send_mask;
-	sccb_mask_t sclp_send_mask;
 	sccb_mask_t sclp_receive_mask;
+	sccb_mask_t sclp_send_mask;
 } __attribute__((packed));
 
 /* Prepare init mask request. Called while sclp_lock is locked. */
diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index aa8186d..bac80e8 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -122,11 +122,13 @@ struct sclp_req {
 /* of some routines it wants to be called from the low level driver */
 struct sclp_register {
 	struct list_head list;
-	/* event masks this user is registered for */
+	/* User wants to receive: */
 	sccb_mask_t receive_mask;
+	/* User wants to send: */
 	sccb_mask_t send_mask;
-	/* actually present events */
+	/* H/W can receive: */
 	sccb_mask_t sclp_receive_mask;
+	/* H/W can send: */
 	sccb_mask_t sclp_send_mask;
 	/* called if event type availability changes */
 	void (*state_change_fn)(struct sclp_register *);
diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 9dc77f1..b8f35bc 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -64,7 +64,7 @@ static int __init sclp_conf_init(void)
 		return rc;
 	}
 
-	if (!(sclp_conf_register.sclp_receive_mask & EVTYP_CONFMGMDATA_MASK)) {
+	if (!(sclp_conf_register.sclp_send_mask & EVTYP_CONFMGMDATA_MASK)) {
 		printk(KERN_WARNING TAG "no configuration management.\n");
 		sclp_unregister(&sclp_conf_register);
 		rc = -ENOSYS;
diff --git a/drivers/s390/char/sclp_cpi_sys.c b/drivers/s390/char/sclp_cpi_sys.c
index 4161703..9f37456 100644
--- a/drivers/s390/char/sclp_cpi_sys.c
+++ b/drivers/s390/char/sclp_cpi_sys.c
@@ -129,7 +129,7 @@ static int cpi_req(void)
 			"to hardware console.\n");
 		goto out;
 	}
-	if (!(sclp_cpi_event.sclp_send_mask & EVTYP_CTLPROGIDENT_MASK)) {
+	if (!(sclp_cpi_event.sclp_receive_mask & EVTYP_CTLPROGIDENT_MASK)) {
 		printk(KERN_WARNING "cpi: no control program "
 			"identification support\n");
 		rc = -EOPNOTSUPP;
diff --git a/drivers/s390/char/sclp_rw.c b/drivers/s390/char/sclp_rw.c
index ad7195d..da09781 100644
--- a/drivers/s390/char/sclp_rw.c
+++ b/drivers/s390/char/sclp_rw.c
@@ -452,10 +452,10 @@ sclp_emit_buffer(struct sclp_buffer *buffer,
 		return -EIO;
 
 	sccb = buffer->sccb;
-	if (sclp_rw_event.sclp_send_mask & EVTYP_MSG_MASK)
+	if (sclp_rw_event.sclp_receive_mask & EVTYP_MSG_MASK)
 		/* Use normal write message */
 		sccb->msg_buf.header.type = EVTYP_MSG;
-	else if (sclp_rw_event.sclp_send_mask & EVTYP_PMSGCMD_MASK)
+	else if (sclp_rw_event.sclp_receive_mask & EVTYP_PMSGCMD_MASK)
 		/* Use write priority message */
 		sccb->msg_buf.header.type = EVTYP_PMSGCMD;
 	else
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index f47f4a7..92f5272 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -202,7 +202,7 @@ sclp_vt220_callback(struct sclp_req *request, void *data)
 static int
 __sclp_vt220_emit(struct sclp_vt220_request *request)
 {
-	if (!(sclp_vt220_register.sclp_send_mask & EVTYP_VT220MSG_MASK)) {
+	if (!(sclp_vt220_register.sclp_receive_mask & EVTYP_VT220MSG_MASK)) {
 		request->sclp_req.status = SCLP_REQ_FAILED;
 		return -EIO;
 	}
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index d35dc3f..fec004f 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -32,7 +32,7 @@
 #include "io_sch.h"
 
 static struct timer_list recovery_timer;
-static spinlock_t recovery_lock;
+static DEFINE_SPINLOCK(recovery_lock);
 static int recovery_phase;
 static const unsigned long recovery_delay[] = { 3, 30, 300 };
 
@@ -1535,7 +1535,7 @@ static int recovery_check(struct device *dev, void *data)
 	return 0;
 }
 
-static void recovery_func(unsigned long data)
+static void recovery_work_func(struct work_struct *unused)
 {
 	int redo = 0;
 
@@ -1553,6 +1553,17 @@ static void recovery_func(unsigned long data)
 		CIO_MSG_EVENT(2, "recovery: end\n");
 }
 
+static DECLARE_WORK(recovery_work, recovery_work_func);
+
+static void recovery_func(unsigned long data)
+{
+	/*
+	 * We can't do our recovery in softirq context and it's not
+	 * performance critical, so we schedule it.
+	 */
+	schedule_work(&recovery_work);
+}
+
 void ccw_device_schedule_recovery(void)
 {
 	unsigned long flags;
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 097fc09..2b5bfb7 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -32,7 +32,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
@@ -1215,9 +1215,6 @@ tiqdio_is_inbound_q_done(struct qdio_q *q)
 
 	if (!no_used)
 		return 1;
-	if (!q->siga_sync && !irq->is_qebsm)
-		/* we'll check for more primed buffers in qeth_stop_polling */
-		return 0;
 	if (irq->is_qebsm) {
 		count = 1;
 		start_buf = q->first_to_check;
@@ -3332,13 +3329,7 @@ qdio_activate(struct ccw_device *cdev, int flags)
 		}
 	}
 
-	wait_event_interruptible_timeout(cdev->private->wait_q,
-					 ((irq_ptr->state ==
-					  QDIO_IRQ_STATE_STOPPED) ||
-					  (irq_ptr->state ==
-					   QDIO_IRQ_STATE_ERR)),
-					 QDIO_ACTIVATE_TIMEOUT);
-
+	msleep(QDIO_ACTIVATE_TIMEOUT);
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_STOPPED:
 	case QDIO_IRQ_STATE_ERR:
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 37870e4..da8a272 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -57,10 +57,10 @@
 					    of the queue to 0 */
 
 #define QDIO_ESTABLISH_TIMEOUT (1*HZ)
-#define QDIO_ACTIVATE_TIMEOUT (5*HZ)
 #define QDIO_CLEANUP_CLEAR_TIMEOUT (20*HZ)
 #define QDIO_CLEANUP_HALT_TIMEOUT (10*HZ)
 #define QDIO_FORCE_CHECK_TIMEOUT (10*HZ)
+#define QDIO_ACTIVATE_TIMEOUT (5) /* 5 ms */
 
 enum qdio_irq_states {
 	QDIO_IRQ_STATE_INACTIVE,
diff --git a/include/asm-s390/bitops.h b/include/asm-s390/bitops.h
index ab83c84..965394e 100644
--- a/include/asm-s390/bitops.h
+++ b/include/asm-s390/bitops.h
@@ -456,16 +456,18 @@ static inline unsigned long __ffz_word_loop(const unsigned long *addr,
 
 	asm volatile(
 #ifndef __s390x__
-		"	ahi	%1,31\n"
-		"	srl	%1,5\n"
+		"	ahi	%1,-1\n"
+		"	sra	%1,5\n"
+		"	jz	1f\n"
 		"0:	c	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,4(%0)\n"
 		"	brct	%1,0b\n"
 		"1:\n"
 #else
-		"	aghi	%1,63\n"
-		"	srlg	%1,%1,6\n"
+		"	aghi	%1,-1\n"
+		"	srag	%1,%1,6\n"
+		"	jz	1f\n"
 		"0:	cg	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,8(%0)\n"
@@ -491,16 +493,18 @@ static inline unsigned long __ffs_word_loop(const unsigned long *addr,
 
 	asm volatile(
 #ifndef __s390x__
-		"	ahi	%1,31\n"
-		"	srl	%1,5\n"
+		"	ahi	%1,-1\n"
+		"	sra	%1,5\n"
+		"	jz	1f\n"
 		"0:	c	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,4(%0)\n"
 		"	brct	%1,0b\n"
 		"1:\n"
 #else
-		"	aghi	%1,63\n"
-		"	srlg	%1,%1,6\n"
+		"	aghi	%1,-1\n"
+		"	srag	%1,%1,6\n"
+		"	jz	1f\n"
 		"0:	cg	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,8(%0)\n"
