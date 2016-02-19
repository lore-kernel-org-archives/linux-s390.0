Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 19 Feb 2016 16:42:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.5-rc5
Message-ID: <20160219164247.5f99b25b@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Several bug fixes
 * There are four different stack tracers, and three of them have bugs.
   For 4.5 the bugs are fix and we prepare a cleanup patch for the next
   merge window.
 * Three bug fixes for the dasd driver in regard to parallel access volumes
   and the new max_dev_sectors block device queue limit
 * The irq restore optimization needs a fixup for memcpy_real
 * The diagnose trace code has a conflict with lockdep

Christian Borntraeger (1):
      s390: fix DAT off memory access, e.g. on kdump

Heiko Carstens (8):
      s390/stacktrace: fix save_stack_trace_tsk() for current task
      s390/stacktrace: fix address ranges for asynchronous and panic stack
      s390/stacktrace: add missing end marker
      s390/stacktrace: save full stack traces
      s390/perf_event: fix address range for asynchronous stack
      s390/oprofile: fix address range for asynchronous stack
      s390/diag: avoid lockdep recursion
      s390/maccess: reduce stnsm instructions

Pratyush Anand (1):
      s390/stacktrace: add save_stack_trace_regs()

Stefan Haberland (3):
      s390/dasd: prevent incorrect length error under z/VM after PAV changes
      s390/dasd: fix refcount for PAV reassignment
      s390/dasd: fix performance drop

 arch/s390/kernel/perf_event.c   |  8 ++++---
 arch/s390/kernel/stacktrace.c   | 47 +++++++++++++++++++++++++++++------------
 arch/s390/kernel/trace.c        |  3 +++
 arch/s390/mm/maccess.c          | 12 +++++++----
 arch/s390/oprofile/backtrace.c  |  8 ++++---
 drivers/s390/block/dasd.c       |  1 +
 drivers/s390/block/dasd_alias.c | 23 ++++++++++++++------
 7 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index cfcba2d..0943b11 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -260,12 +260,13 @@ static unsigned long __store_trace(struct perf_callchain_entry *entry,
 void perf_callchain_kernel(struct perf_callchain_entry *entry,
 			   struct pt_regs *regs)
 {
-	unsigned long head;
+	unsigned long head, frame_size;
 	struct stack_frame *head_sf;
 
 	if (user_mode(regs))
 		return;
 
+	frame_size = STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
 	head = regs->gprs[15];
 	head_sf = (struct stack_frame *) head;
 
@@ -273,8 +274,9 @@ void perf_callchain_kernel(struct perf_callchain_entry *entry,
 		return;
 
 	head = head_sf->back_chain;
-	head = __store_trace(entry, head, S390_lowcore.async_stack - ASYNC_SIZE,
-			     S390_lowcore.async_stack);
+	head = __store_trace(entry, head,
+			     S390_lowcore.async_stack + frame_size - ASYNC_SIZE,
+			     S390_lowcore.async_stack + frame_size);
 
 	__store_trace(entry, head, S390_lowcore.thread_info,
 		      S390_lowcore.thread_info + THREAD_SIZE);
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 5acba3c..8f64ebd 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -59,26 +59,32 @@ static unsigned long save_context_stack(struct stack_trace *trace,
 	}
 }
 
-void save_stack_trace(struct stack_trace *trace)
+static void __save_stack_trace(struct stack_trace *trace, unsigned long sp)
 {
-	register unsigned long sp asm ("15");
-	unsigned long orig_sp, new_sp;
+	unsigned long new_sp, frame_size;
 
-	orig_sp = sp;
-	new_sp = save_context_stack(trace, orig_sp,
-				    S390_lowcore.panic_stack - PAGE_SIZE,
-				    S390_lowcore.panic_stack, 1);
-	if (new_sp != orig_sp)
-		return;
+	frame_size = STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
+	new_sp = save_context_stack(trace, sp,
+			S390_lowcore.panic_stack + frame_size - PAGE_SIZE,
+			S390_lowcore.panic_stack + frame_size, 1);
 	new_sp = save_context_stack(trace, new_sp,
-				    S390_lowcore.async_stack - ASYNC_SIZE,
-				    S390_lowcore.async_stack, 1);
-	if (new_sp != orig_sp)
-		return;
+			S390_lowcore.async_stack + frame_size - ASYNC_SIZE,
+			S390_lowcore.async_stack + frame_size, 1);
 	save_context_stack(trace, new_sp,
 			   S390_lowcore.thread_info,
 			   S390_lowcore.thread_info + THREAD_SIZE, 1);
 }
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	register unsigned long r15 asm ("15");
+	unsigned long sp;
+
+	sp = r15;
+	__save_stack_trace(trace, sp);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
@@ -86,6 +92,10 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	unsigned long sp, low, high;
 
 	sp = tsk->thread.ksp;
+	if (tsk == current) {
+		/* Get current stack pointer. */
+		asm volatile("la %0,0(15)" : "=a" (sp));
+	}
 	low = (unsigned long) task_stack_page(tsk);
 	high = (unsigned long) task_pt_regs(tsk);
 	save_context_stack(trace, sp, low, high, 0);
@@ -93,3 +103,14 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
+{
+	unsigned long sp;
+
+	sp = kernel_stack_pointer(regs);
+	__save_stack_trace(trace, sp);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_regs);
diff --git a/arch/s390/kernel/trace.c b/arch/s390/kernel/trace.c
index 21a5df9..dde7654 100644
--- a/arch/s390/kernel/trace.c
+++ b/arch/s390/kernel/trace.c
@@ -18,6 +18,9 @@ void trace_s390_diagnose_norecursion(int diag_nr)
 	unsigned long flags;
 	unsigned int *depth;
 
+	/* Avoid lockdep recursion. */
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		return;
 	local_irq_save(flags);
 	depth = this_cpu_ptr(&diagnose_trace_depth);
 	if (*depth == 0) {
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index fec59c0..792f9c6 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -93,15 +93,19 @@ static int __memcpy_real(void *dest, void *src, size_t count)
  */
 int memcpy_real(void *dest, void *src, size_t count)
 {
+	int irqs_disabled, rc;
 	unsigned long flags;
-	int rc;
 
 	if (!count)
 		return 0;
-	local_irq_save(flags);
-	__arch_local_irq_stnsm(0xfbUL);
+	flags = __arch_local_irq_stnsm(0xf8UL);
+	irqs_disabled = arch_irqs_disabled_flags(flags);
+	if (!irqs_disabled)
+		trace_hardirqs_off();
 	rc = __memcpy_real(dest, src, count);
-	local_irq_restore(flags);
+	if (!irqs_disabled)
+		trace_hardirqs_on();
+	__arch_local_irq_ssm(flags);
 	return rc;
 }
 
diff --git a/arch/s390/oprofile/backtrace.c b/arch/s390/oprofile/backtrace.c
index fe0bfe3..1884e17 100644
--- a/arch/s390/oprofile/backtrace.c
+++ b/arch/s390/oprofile/backtrace.c
@@ -54,12 +54,13 @@ __show_trace(unsigned int *depth, unsigned long sp,
 
 void s390_backtrace(struct pt_regs * const regs, unsigned int depth)
 {
-	unsigned long head;
+	unsigned long head, frame_size;
 	struct stack_frame* head_sf;
 
 	if (user_mode(regs))
 		return;
 
+	frame_size = STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
 	head = regs->gprs[15];
 	head_sf = (struct stack_frame*)head;
 
@@ -68,8 +69,9 @@ void s390_backtrace(struct pt_regs * const regs, unsigned int depth)
 
 	head = head_sf->back_chain;
 
-	head = __show_trace(&depth, head, S390_lowcore.async_stack - ASYNC_SIZE,
-			    S390_lowcore.async_stack);
+	head = __show_trace(&depth, head,
+			    S390_lowcore.async_stack + frame_size - ASYNC_SIZE,
+			    S390_lowcore.async_stack + frame_size);
 
 	__show_trace(&depth, head, S390_lowcore.thread_info,
 		     S390_lowcore.thread_info + THREAD_SIZE);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 41605da..c78db05 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3035,6 +3035,7 @@ static void dasd_setup_queue(struct dasd_block *block)
 		max = block->base->discipline->max_blocks << block->s2b_shift;
 	}
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, block->request_queue);
+	block->request_queue->limits.max_dev_sectors = max;
 	blk_queue_logical_block_size(block->request_queue,
 				     block->bp_block);
 	blk_queue_max_hw_sectors(block->request_queue, max);
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 184b1db..286782c 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -264,8 +264,10 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *device)
 		spin_unlock_irqrestore(&lcu->lock, flags);
 		cancel_work_sync(&lcu->suc_data.worker);
 		spin_lock_irqsave(&lcu->lock, flags);
-		if (device == lcu->suc_data.device)
+		if (device == lcu->suc_data.device) {
+			dasd_put_device(device);
 			lcu->suc_data.device = NULL;
+		}
 	}
 	was_pending = 0;
 	if (device == lcu->ruac_data.device) {
@@ -273,8 +275,10 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *device)
 		was_pending = 1;
 		cancel_delayed_work_sync(&lcu->ruac_data.dwork);
 		spin_lock_irqsave(&lcu->lock, flags);
-		if (device == lcu->ruac_data.device)
+		if (device == lcu->ruac_data.device) {
+			dasd_put_device(device);
 			lcu->ruac_data.device = NULL;
+		}
 	}
 	private->lcu = NULL;
 	spin_unlock_irqrestore(&lcu->lock, flags);
@@ -549,8 +553,10 @@ static void lcu_update_work(struct work_struct *work)
 	if ((rc && (rc != -EOPNOTSUPP)) || (lcu->flags & NEED_UAC_UPDATE)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "could not update"
 			    " alias data in lcu (rc = %d), retry later", rc);
-		schedule_delayed_work(&lcu->ruac_data.dwork, 30*HZ);
+		if (!schedule_delayed_work(&lcu->ruac_data.dwork, 30*HZ))
+			dasd_put_device(device);
 	} else {
+		dasd_put_device(device);
 		lcu->ruac_data.device = NULL;
 		lcu->flags &= ~UPDATE_PENDING;
 	}
@@ -593,8 +599,10 @@ static int _schedule_lcu_update(struct alias_lcu *lcu,
 	 */
 	if (!usedev)
 		return -EINVAL;
+	dasd_get_device(usedev);
 	lcu->ruac_data.device = usedev;
-	schedule_delayed_work(&lcu->ruac_data.dwork, 0);
+	if (!schedule_delayed_work(&lcu->ruac_data.dwork, 0))
+		dasd_put_device(usedev);
 	return 0;
 }
 
@@ -723,7 +731,7 @@ static int reset_summary_unit_check(struct alias_lcu *lcu,
 	ASCEBC((char *) &cqr->magic, 4);
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_RSCK;
-	ccw->flags = 0 ;
+	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = 16;
 	ccw->cda = (__u32)(addr_t) cqr->data;
 	((char *)cqr->data)[0] = reason;
@@ -930,6 +938,7 @@ static void summary_unit_check_handling_work(struct work_struct *work)
 	/* 3. read new alias configuration */
 	_schedule_lcu_update(lcu, device);
 	lcu->suc_data.device = NULL;
+	dasd_put_device(device);
 	spin_unlock_irqrestore(&lcu->lock, flags);
 }
 
@@ -989,6 +998,8 @@ void dasd_alias_handle_summary_unit_check(struct dasd_device *device,
 	}
 	lcu->suc_data.reason = reason;
 	lcu->suc_data.device = device;
+	dasd_get_device(device);
 	spin_unlock(&lcu->lock);
-	schedule_work(&lcu->suc_data.worker);
+	if (!schedule_work(&lcu->suc_data.worker))
+		dasd_put_device(device);
 };
