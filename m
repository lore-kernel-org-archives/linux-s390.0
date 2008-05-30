Return-Path: <linux-kernel-owner+w=401wt.eu-S1754595AbYE3IyL@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 30 May 2008 10:41:05 +0200
Message-Id: <1212136866.23167.1.camel@localhost>
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

 arch/s390/Kconfig                  |    3 ++
 arch/s390/appldata/appldata_base.c |    8 ++++++
 arch/s390/defconfig                |   11 ++++++--
 arch/s390/kernel/dis.c             |    2 +-
 arch/s390/kernel/smp.c             |    2 +-
 arch/s390/mm/init.c                |   49 +++++++++++++++++-------------------
 arch/s390/mm/vmem.c                |   18 +++++++++---
 drivers/s390/block/dasd.c          |   28 ++++++++++----------
 drivers/s390/char/raw3270.c        |    9 +++---
 drivers/s390/char/sclp_config.c    |    2 +-
 drivers/s390/char/sclp_vt220.c     |   27 +++++--------------
 drivers/s390/char/tape.h           |    3 ++
 drivers/s390/char/tape_block.c     |    4 +-
 drivers/s390/char/tape_core.c      |   16 +++++------
 include/asm-s390/types.h           |    6 ++++
 15 files changed, 101 insertions(+), 87 deletions(-)

Christian Borntraeger (1):
      [S390] s390 types: make dma_addr_t 64 bit capable

Gerald Schaefer (1):
      [S390] appldata: prevent cpu hotplug when walking cpu_online_map.

Hans-Joachim Picht (1):
      [S390] fix sparsemem related compile error with allnoconfig on s390

Heiko Carstens (3):
      [S390] Fix section mismatch warnings.
      [S390] showmem: Only walk spanned pages.
      [S390] sclp_vt220: fix scheduling while atomic bug.

Martin Schwidefsky (4):
      [S390] 3270: fix race with stack local wait_queue_head_t.
      [S390] tape: fix race with stack local wait_queue_head_t.
      [S390] disassembler: fix idte instruction format.
      [S390] Update default configuration.

Michael Holzheu (1):
      [S390] tape: Fix race condition in tape block device driver

Stefan Haberland (1):
      [S390] dasd: use a generic wait_queue for sleep_on

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1d03508..93acb3c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -308,6 +308,9 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
+config ARCH_SELECT_MEMORY_MODEL
+       def_bool y
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 655d525..ad40729 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -130,6 +130,7 @@ static void appldata_work_fn(struct work_struct *work)
 
 	P_DEBUG("  -= Work Queue =-\n");
 	i = 0;
+	get_online_cpus();
 	spin_lock(&appldata_ops_lock);
 	list_for_each(lh, &appldata_ops_list) {
 		ops = list_entry(lh, struct appldata_ops, list);
@@ -140,6 +141,7 @@ static void appldata_work_fn(struct work_struct *work)
 		}
 	}
 	spin_unlock(&appldata_ops_lock);
+	put_online_cpus();
 }
 
 /*
@@ -266,12 +268,14 @@ appldata_timer_handler(ctl_table *ctl, int write, struct file *filp,
 	len = *lenp;
 	if (copy_from_user(buf, buffer, len > sizeof(buf) ? sizeof(buf) : len))
 		return -EFAULT;
+	get_online_cpus();
 	spin_lock(&appldata_timer_lock);
 	if (buf[0] == '1')
 		__appldata_vtimer_setup(APPLDATA_ADD_TIMER);
 	else if (buf[0] == '0')
 		__appldata_vtimer_setup(APPLDATA_DEL_TIMER);
 	spin_unlock(&appldata_timer_lock);
+	put_online_cpus();
 out:
 	*lenp = len;
 	*ppos += len;
@@ -314,10 +318,12 @@ appldata_interval_handler(ctl_table *ctl, int write, struct file *filp,
 		return -EINVAL;
 	}
 
+	get_online_cpus();
 	spin_lock(&appldata_timer_lock);
 	appldata_interval = interval;
 	__appldata_vtimer_setup(APPLDATA_MOD_TIMER);
 	spin_unlock(&appldata_timer_lock);
+	put_online_cpus();
 
 	P_INFO("Monitoring CPU interval set to %u milliseconds.\n",
 		 interval);
@@ -556,8 +562,10 @@ static int __init appldata_init(void)
 		return -ENOMEM;
 	}
 
+	get_online_cpus();
 	for_each_online_cpu(i)
 		appldata_online_cpu(i);
+	put_online_cpus();
 
 	/* Register cpu hotplug notifier */
 	register_hotcpu_notifier(&appldata_nb);
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index aa341d0..c5cdb97 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25
-# Wed Apr 30 11:07:45 2008
+# Linux kernel version: 2.6.26-rc4
+# Fri May 30 09:49:33 2008
 #
 CONFIG_SCHED_MC=y
 CONFIG_MMU=y
@@ -103,6 +103,7 @@ CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_MODVERSIONS=y
@@ -173,6 +174,7 @@ CONFIG_PREEMPT=y
 # CONFIG_PREEMPT_RCU is not set
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_DEFAULT=y
+CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -210,6 +212,7 @@ CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_CMM is not set
+# CONFIG_PAGE_STATES is not set
 CONFIG_VIRT_TIMER=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 # CONFIG_APPLDATA_BASE is not set
@@ -620,6 +623,7 @@ CONFIG_S390_VMUR=m
 #
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+CONFIG_ACCESSIBILITY=y
 
 #
 # File systems
@@ -754,11 +758,12 @@ CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
-CONFIG_HEADERS_CHECK=y
+# CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_RT_MUTEXES is not set
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index c14a336..d2f270c 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -208,7 +208,7 @@ static const unsigned char formats[][7] = {
 	[INSTR_RRF_F0FF]  = { 0xff, F_16,F_24,F_28,0,0,0 },    /* e.g. madbr */
 	[INSTR_RRF_FUFF]  = { 0xff, F_24,F_16,F_28,U4_20,0,0 },/* e.g. didbr */
 	[INSTR_RRF_RURR]  = { 0xff, R_24,R_28,R_16,U4_20,0,0 },/* e.g. .insn */
-	[INSTR_RRF_R0RR]  = { 0xff, R_24,R_28,R_16,0,0,0 },    /* e.g. idte  */
+	[INSTR_RRF_R0RR]  = { 0xff, R_24,R_16,R_28,0,0,0 },    /* e.g. idte  */
 	[INSTR_RRF_U0FF]  = { 0xff, F_24,U4_16,F_28,0,0,0 },   /* e.g. fixr  */
 	[INSTR_RRF_U0RF]  = { 0xff, R_24,U4_16,F_28,0,0,0 },   /* e.g. cfebr */
 	[INSTR_RRF_M0RR]  = { 0xff, R_24,R_28,M_16,0,0,0 },    /* e.g. sske  */
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 1f42289..42b1d12 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1089,7 +1089,7 @@ out:
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-int smp_rescan_cpus(void)
+int __ref smp_rescan_cpus(void)
 {
 	cpumask_t newcpus;
 	int cpu;
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 29f3a63..0559864 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -44,37 +44,34 @@ char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
 void show_mem(void)
 {
-	int i, total = 0, reserved = 0;
-	int shared = 0, cached = 0;
+	unsigned long i, total = 0, reserved = 0;
+	unsigned long shared = 0, cached = 0;
+	unsigned long flags;
 	struct page *page;
+	pg_data_t *pgdat;
 
 	printk("Mem-info:\n");
 	show_free_areas();
-	i = max_mapnr;
-	while (i-- > 0) {
-		if (!pfn_valid(i))
-			continue;
-		page = pfn_to_page(i);
-		total++;
-		if (PageReserved(page))
-			reserved++;
-		else if (PageSwapCache(page))
-			cached++;
-		else if (page_count(page))
-			shared += page_count(page) - 1;
+	for_each_online_pgdat(pgdat) {
+		pgdat_resize_lock(pgdat, &flags);
+		for (i = 0; i < pgdat->node_spanned_pages; i++) {
+			if (!pfn_valid(pgdat->node_start_pfn + i))
+				continue;
+			page = pfn_to_page(pgdat->node_start_pfn + i);
+			total++;
+			if (PageReserved(page))
+				reserved++;
+			else if (PageSwapCache(page))
+				cached++;
+			else if (page_count(page))
+				shared += page_count(page) - 1;
+		}
+		pgdat_resize_unlock(pgdat, &flags);
 	}
-	printk("%d pages of RAM\n", total);
-	printk("%d reserved pages\n", reserved);
-	printk("%d pages shared\n", shared);
-	printk("%d pages swap cached\n", cached);
-
-	printk("%lu pages dirty\n", global_page_state(NR_FILE_DIRTY));
-	printk("%lu pages writeback\n", global_page_state(NR_WRITEBACK));
-	printk("%lu pages mapped\n", global_page_state(NR_FILE_MAPPED));
-	printk("%lu pages slab\n",
-	       global_page_state(NR_SLAB_RECLAIMABLE) +
-	       global_page_state(NR_SLAB_UNRECLAIMABLE));
-	printk("%lu pages pagetables\n", global_page_state(NR_PAGETABLE));
+	printk("%ld pages of RAM\n", total);
+	printk("%ld reserved pages\n", reserved);
+	printk("%ld pages shared\n", shared);
+	printk("%ld pages swap cached\n", cached);
 }
 
 /*
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index ea28048..f591188 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -27,12 +27,19 @@ struct memory_segment {
 
 static LIST_HEAD(mem_segs);
 
-static pud_t *vmem_pud_alloc(void)
+static void __ref *vmem_alloc_pages(unsigned int order)
+{
+	if (slab_is_available())
+		return (void *)__get_free_pages(GFP_KERNEL, order);
+	return alloc_bootmem_pages((1 << order) * PAGE_SIZE);
+}
+
+static inline pud_t *vmem_pud_alloc(void)
 {
 	pud_t *pud = NULL;
 
 #ifdef CONFIG_64BIT
-	pud = vmemmap_alloc_block(PAGE_SIZE * 4, 0);
+	pud = vmem_alloc_pages(2);
 	if (!pud)
 		return NULL;
 	clear_table((unsigned long *) pud, _REGION3_ENTRY_EMPTY, PAGE_SIZE * 4);
@@ -40,12 +47,12 @@ static pud_t *vmem_pud_alloc(void)
 	return pud;
 }
 
-static pmd_t *vmem_pmd_alloc(void)
+static inline pmd_t *vmem_pmd_alloc(void)
 {
 	pmd_t *pmd = NULL;
 
 #ifdef CONFIG_64BIT
-	pmd = vmemmap_alloc_block(PAGE_SIZE * 4, 0);
+	pmd = vmem_alloc_pages(2);
 	if (!pmd)
 		return NULL;
 	clear_table((unsigned long *) pmd, _SEGMENT_ENTRY_EMPTY, PAGE_SIZE * 4);
@@ -207,13 +214,14 @@ int __meminit vmemmap_populate(struct page *start, unsigned long nr, int node)
 		if (pte_none(*pt_dir)) {
 			unsigned long new_page;
 
-			new_page =__pa(vmemmap_alloc_block(PAGE_SIZE, 0));
+			new_page =__pa(vmem_alloc_pages(0));
 			if (!new_page)
 				goto out;
 			pte = pfn_pte(new_page >> PAGE_SHIFT, PAGE_KERNEL);
 			*pt_dir = pte;
 		}
 	}
+	memset(start, 0, nr * sizeof(struct page));
 	ret = 0;
 out:
 	flush_tlb_kernel_range(start_addr, end_addr);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8ba3f13..1a40256 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -63,6 +63,7 @@ static void dasd_return_cqr_cb(struct dasd_ccw_req *, void *);
  */
 static wait_queue_head_t dasd_init_waitq;
 static wait_queue_head_t dasd_flush_wq;
+static wait_queue_head_t generic_waitq;
 
 /*
  * Allocate memory for a new device structure.
@@ -1151,11 +1152,15 @@ static void __dasd_device_process_final_queue(struct dasd_device *device,
 	struct list_head *l, *n;
 	struct dasd_ccw_req *cqr;
 	struct dasd_block *block;
+	void (*callback)(struct dasd_ccw_req *, void *data);
+	void *callback_data;
 
 	list_for_each_safe(l, n, final_queue) {
 		cqr = list_entry(l, struct dasd_ccw_req, devlist);
 		list_del_init(&cqr->devlist);
 		block = cqr->block;
+		callback = cqr->callback;
+		callback_data = cqr->callback_data;
 		if (block)
 			spin_lock_bh(&block->queue_lock);
 		switch (cqr->status) {
@@ -1176,7 +1181,7 @@ static void __dasd_device_process_final_queue(struct dasd_device *device,
 			BUG();
 		}
 		if (cqr->callback != NULL)
-			(cqr->callback)(cqr, cqr->callback_data);
+			(callback)(cqr, callback_data);
 		if (block)
 			spin_unlock_bh(&block->queue_lock);
 	}
@@ -1406,17 +1411,15 @@ static inline int _wait_for_wakeup(struct dasd_ccw_req *cqr)
  */
 int dasd_sleep_on(struct dasd_ccw_req *cqr)
 {
-	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
 	device = cqr->startdev;
 
-	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &wait_q;
+	cqr->callback_data = (void *) &generic_waitq;
 	dasd_add_request_tail(cqr);
-	wait_event(wait_q, _wait_for_wakeup(cqr));
+	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
 	/* Request status is either done or failed. */
 	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
@@ -1429,20 +1432,18 @@ int dasd_sleep_on(struct dasd_ccw_req *cqr)
  */
 int dasd_sleep_on_interruptible(struct dasd_ccw_req *cqr)
 {
-	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
 	device = cqr->startdev;
-	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &wait_q;
+	cqr->callback_data = (void *) &generic_waitq;
 	dasd_add_request_tail(cqr);
-	rc = wait_event_interruptible(wait_q, _wait_for_wakeup(cqr));
+	rc = wait_event_interruptible(generic_waitq, _wait_for_wakeup(cqr));
 	if (rc == -ERESTARTSYS) {
 		dasd_cancel_req(cqr);
 		/* wait (non-interruptible) for final status */
-		wait_event(wait_q, _wait_for_wakeup(cqr));
+		wait_event(generic_waitq, _wait_for_wakeup(cqr));
 	}
 	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
 	return rc;
@@ -1466,7 +1467,6 @@ static inline int _dasd_term_running_cqr(struct dasd_device *device)
 
 int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 {
-	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
@@ -1478,9 +1478,8 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 		return rc;
 	}
 
-	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &wait_q;
+	cqr->callback_data = (void *) &generic_waitq;
 	cqr->status = DASD_CQR_QUEUED;
 	list_add(&cqr->devlist, &device->ccw_queue);
 
@@ -1489,7 +1488,7 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 
-	wait_event(wait_q, _wait_for_wakeup(cqr));
+	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
 	/* Request status is either done or failed. */
 	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
@@ -2430,6 +2429,7 @@ static int __init dasd_init(void)
 
 	init_waitqueue_head(&dasd_init_waitq);
 	init_waitqueue_head(&dasd_flush_wq);
+	init_waitqueue_head(&generic_waitq);
 
 	/* register 'common' DASD debug area, used for all DBF_XXX calls */
 	dasd_debug_area = debug_register("dasd", 1, 1, 8 * sizeof(long));
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 0d98f1f..848ef7e 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -549,7 +549,6 @@ raw3270_start_init(struct raw3270 *rp, struct raw3270_view *view,
 		   struct raw3270_request *rq)
 {
 	unsigned long flags;
-	wait_queue_head_t wq;
 	int rc;
 
 #ifdef CONFIG_TN3270_CONSOLE
@@ -566,20 +565,20 @@ raw3270_start_init(struct raw3270 *rp, struct raw3270_view *view,
 		return rq->rc;
 	}
 #endif
-	init_waitqueue_head(&wq);
 	rq->callback = raw3270_wake_init;
-	rq->callback_data = &wq;
+	rq->callback_data = &raw3270_wait_queue;
 	spin_lock_irqsave(get_ccwdev_lock(view->dev->cdev), flags);
 	rc = __raw3270_start(rp, view, rq);
 	spin_unlock_irqrestore(get_ccwdev_lock(view->dev->cdev), flags);
 	if (rc)
 		return rc;
 	/* Now wait for the completion. */
-	rc = wait_event_interruptible(wq, raw3270_request_final(rq));
+	rc = wait_event_interruptible(raw3270_wait_queue,
+				      raw3270_request_final(rq));
 	if (rc == -ERESTARTSYS) {	/* Interrupted by a signal. */
 		raw3270_halt_io(view->dev, rq);
 		/* No wait for the halt to complete. */
-		wait_event(wq, raw3270_request_final(rq));
+		wait_event(raw3270_wait_queue, raw3270_request_final(rq));
 		return -ERESTARTSYS;
 	}
 	return rq->rc;
diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 9e784d5..ad05a87 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -40,7 +40,7 @@ static void sclp_cpu_capability_notify(struct work_struct *work)
 	put_online_cpus();
 }
 
-static void sclp_cpu_change_notify(struct work_struct *work)
+static void __ref sclp_cpu_change_notify(struct work_struct *work)
 {
 	smp_rescan_cpus();
 }
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 35707c0..62576af 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -71,9 +71,6 @@ static struct list_head sclp_vt220_outqueue;
 /* Number of requests in outqueue */
 static int sclp_vt220_outqueue_count;
 
-/* Wait queue used to delay write requests while we've run out of buffers */
-static wait_queue_head_t sclp_vt220_waitq;
-
 /* Timer used for delaying write requests to merge subsequent messages into
  * a single buffer */
 static struct timer_list sclp_vt220_timer;
@@ -133,7 +130,6 @@ sclp_vt220_process_queue(struct sclp_vt220_request *request)
 	} while (request && __sclp_vt220_emit(request));
 	if (request == NULL && sclp_vt220_flush_later)
 		sclp_vt220_emit_current();
-	wake_up(&sclp_vt220_waitq);
 	/* Check if the tty needs a wake up call */
 	if (sclp_vt220_tty != NULL) {
 		tty_wakeup(sclp_vt220_tty);
@@ -383,7 +379,7 @@ sclp_vt220_timeout(unsigned long data)
  */
 static int
 __sclp_vt220_write(const unsigned char *buf, int count, int do_schedule,
-		   int convertlf, int may_schedule)
+		   int convertlf, int may_fail)
 {
 	unsigned long flags;
 	void *page;
@@ -395,15 +391,14 @@ __sclp_vt220_write(const unsigned char *buf, int count, int do_schedule,
 	overall_written = 0;
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
 	do {
-		/* Create a sclp output buffer if none exists yet */
+		/* Create an sclp output buffer if none exists yet */
 		if (sclp_vt220_current_request == NULL) {
 			while (list_empty(&sclp_vt220_empty)) {
 				spin_unlock_irqrestore(&sclp_vt220_lock, flags);
-				if (in_interrupt() || !may_schedule)
-					sclp_sync_wait();
+				if (may_fail)
+					goto out;
 				else
-					wait_event(sclp_vt220_waitq,
-						!list_empty(&sclp_vt220_empty));
+					sclp_sync_wait();
 				spin_lock_irqsave(&sclp_vt220_lock, flags);
 			}
 			page = (void *) sclp_vt220_empty.next;
@@ -437,6 +432,7 @@ __sclp_vt220_write(const unsigned char *buf, int count, int do_schedule,
 		add_timer(&sclp_vt220_timer);
 	}
 	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+out:
 	return overall_written;
 }
 
@@ -520,19 +516,11 @@ sclp_vt220_close(struct tty_struct *tty, struct file *filp)
  * character to the tty device.  If the kernel uses this routine,
  * it must call the flush_chars() routine (if defined) when it is
  * done stuffing characters into the driver.
- *
- * NOTE: include/linux/tty_driver.h specifies that a character should be
- * ignored if there is no room in the queue. This driver implements a different
- * semantic in that it will block when there is no more room left.
- *
- * FIXME: putchar can currently be called from BH and other non blocking
- * handlers so  this semantic isn't a good idea.
  */
 static int
 sclp_vt220_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	__sclp_vt220_write(&ch, 1, 0, 0, 1);
-	return 1;
+	return __sclp_vt220_write(&ch, 1, 0, 0, 1);
 }
 
 /*
@@ -653,7 +641,6 @@ static int __init __sclp_vt220_init(void)
 	spin_lock_init(&sclp_vt220_lock);
 	INIT_LIST_HEAD(&sclp_vt220_empty);
 	INIT_LIST_HEAD(&sclp_vt220_outqueue);
-	init_waitqueue_head(&sclp_vt220_waitq);
 	init_timer(&sclp_vt220_timer);
 	sclp_vt220_current_request = NULL;
 	sclp_vt220_buffered_chars = 0;
diff --git a/drivers/s390/char/tape.h b/drivers/s390/char/tape.h
index dddf8d6..d0d565a 100644
--- a/drivers/s390/char/tape.h
+++ b/drivers/s390/char/tape.h
@@ -231,6 +231,9 @@ struct tape_device {
 	/* Request queue. */
 	struct list_head		req_queue;
 
+	/* Request wait queue. */
+	wait_queue_head_t		wait_queue;
+
 	/* Each tape device has (currently) two minor numbers. */
 	int				first_minor;
 
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index ddc4a11..95da72b 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -179,11 +179,11 @@ tapeblock_requeue(struct work_struct *work) {
 			tapeblock_end_request(req, -EIO);
 			continue;
 		}
+		blkdev_dequeue_request(req);
+		nr_queued++;
 		spin_unlock_irq(&device->blk_data.request_queue_lock);
 		rc = tapeblock_start_request(device, req);
 		spin_lock_irq(&device->blk_data.request_queue_lock);
-		blkdev_dequeue_request(req);
-		nr_queued++;
 	}
 	spin_unlock_irq(&device->blk_data.request_queue_lock);
 	atomic_set(&device->blk_data.requeue_scheduled, 0);
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 76e44eb..c20e3c5 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -449,6 +449,7 @@ tape_alloc_device(void)
 	INIT_LIST_HEAD(&device->req_queue);
 	INIT_LIST_HEAD(&device->node);
 	init_waitqueue_head(&device->state_change_wq);
+	init_waitqueue_head(&device->wait_queue);
 	device->tape_state = TS_INIT;
 	device->medium_state = MS_UNKNOWN;
 	*device->modeset_byte = 0;
@@ -954,21 +955,19 @@ __tape_wake_up(struct tape_request *request, void *data)
 int
 tape_do_io(struct tape_device *device, struct tape_request *request)
 {
-	wait_queue_head_t wq;
 	int rc;
 
-	init_waitqueue_head(&wq);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* Setup callback */
 	request->callback = __tape_wake_up;
-	request->callback_data = &wq;
+	request->callback_data = &device->wait_queue;
 	/* Add request to request queue and try to start it. */
 	rc = __tape_start_request(device, request);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	if (rc)
 		return rc;
 	/* Request added to the queue. Wait for its completion. */
-	wait_event(wq, (request->callback == NULL));
+	wait_event(device->wait_queue, (request->callback == NULL));
 	/* Get rc from request */
 	return request->rc;
 }
@@ -989,20 +988,19 @@ int
 tape_do_io_interruptible(struct tape_device *device,
 			 struct tape_request *request)
 {
-	wait_queue_head_t wq;
 	int rc;
 
-	init_waitqueue_head(&wq);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* Setup callback */
 	request->callback = __tape_wake_up_interruptible;
-	request->callback_data = &wq;
+	request->callback_data = &device->wait_queue;
 	rc = __tape_start_request(device, request);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	if (rc)
 		return rc;
 	/* Request added to the queue. Wait for its completion. */
-	rc = wait_event_interruptible(wq, (request->callback == NULL));
+	rc = wait_event_interruptible(device->wait_queue,
+				      (request->callback == NULL));
 	if (rc != -ERESTARTSYS)
 		/* Request finished normally. */
 		return request->rc;
@@ -1015,7 +1013,7 @@ tape_do_io_interruptible(struct tape_device *device,
 		/* Wait for the interrupt that acknowledges the halt. */
 		do {
 			rc = wait_event_interruptible(
-				wq,
+				device->wait_queue,
 				(request->callback == NULL)
 			);
 		} while (rc == -ERESTARTSYS);
diff --git a/include/asm-s390/types.h b/include/asm-s390/types.h
index 0e959e2..41c5476 100644
--- a/include/asm-s390/types.h
+++ b/include/asm-s390/types.h
@@ -40,7 +40,13 @@ typedef __signed__ long saddr_t;
 
 #ifndef __ASSEMBLY__
 
+typedef u64 dma64_addr_t;
+#ifdef __s390x__
+/* DMA addresses come in 32-bit and 64-bit flavours. */
+typedef u64 dma_addr_t;
+#else
 typedef u32 dma_addr_t;
+#endif
 
 #ifndef __s390x__
 typedef union {
