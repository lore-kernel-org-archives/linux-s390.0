Return-Path: <linux-kernel-owner+w=401wt.eu-S1759213AbXKTLiX@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Tue, 20 Nov 2007 12:38:07 +0100
Message-Id: <1195558687.20237.1.camel@localhost>
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

 arch/s390/appldata/appldata.h         |    1 -
 arch/s390/appldata/appldata_base.c    |   74 ++++----------------
 arch/s390/appldata/appldata_mem.c     |    1 -
 arch/s390/appldata/appldata_net_sum.c |    1 -
 arch/s390/appldata/appldata_os.c      |    1 -
 arch/s390/kernel/early.c              |    2 +-
 arch/s390/kernel/entry.S              |  120 +++++++++++++++++++++-----------
 arch/s390/kernel/entry64.S            |  114 ++++++++++++++++++++-----------
 arch/s390/kernel/setup.c              |    6 ++-
 arch/s390/kernel/smp.c                |   56 ++-------------
 arch/s390/kernel/traps.c              |    1 +
 arch/s390/mm/cmm.c                    |    3 -
 drivers/s390/cio/css.c                |    2 +-
 drivers/s390/cio/device_fsm.c         |    2 +-
 drivers/s390/cio/device_id.c          |   45 +++----------
 include/asm-s390/system.h             |    5 ++
 include/linux/sysctl.h                |    6 --
 kernel/sysctl_check.c                 |   14 ----
 mm/rmap.c                             |    9 ++-
 net/iucv/iucv.c                       |  107 +++++++++++++++++-------------
 20 files changed, 263 insertions(+), 307 deletions(-)

Christian Borntraeger (2):
      [S390] magic sysrq: check for in_atomic before doing an console_unblank
      [S390] Optimize storage key handling for anonymous pages

Christoph Lameter (1):
      [S390] Explicitly code allocpercpu calls in iucv

Cornelia Huck (1):
      [S390] cio: Register/unregister subchannels only from kslowcrw.

Heiko Carstens (7):
      [S390] Fix irq tracing and lockdep_sys_exit calls.
      [S390] cmm: remove unused binary sysctls.
      [S390] appldata: remove unused binary sysctls.
      [S390] Fix kernel preemption.
      [S390] Dont overwrite lowcores on smp_send_stop().
      [S390] Fix memory detection.
      [S390] Add missing die_notifier() call to die().

Peter Oberparleiter (1):
      [S390] cio: change device sense procedure to work with pav aliases

diff --git a/arch/s390/appldata/appldata.h b/arch/s390/appldata/appldata.h
index 4069b81..db3ae85 100644
--- a/arch/s390/appldata/appldata.h
+++ b/arch/s390/appldata/appldata.h
@@ -45,7 +45,6 @@ struct appldata_ops {
 	int    active;				/* monitoring status */
 
 	/* fill in from here */
-	unsigned int ctl_nr;			/* sysctl ID */
 	char name[APPLDATA_PROC_NAME_LENGTH];	/* name of /proc fs node */
 	unsigned char record_nr;		/* Record Nr. for Product ID */
 	void (*callback)(void *data);		/* callback function */
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index ac61cf4..655d525 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -53,29 +53,26 @@ static int appldata_interval_handler(ctl_table *ctl, int write,
 static struct ctl_table_header *appldata_sysctl_header;
 static struct ctl_table appldata_table[] = {
 	{
-		.ctl_name	= CTL_APPLDATA_TIMER,
 		.procname	= "timer",
 		.mode		= S_IRUGO | S_IWUSR,
 		.proc_handler	= &appldata_timer_handler,
 	},
 	{
-		.ctl_name	= CTL_APPLDATA_INTERVAL,
 		.procname	= "interval",
 		.mode		= S_IRUGO | S_IWUSR,
 		.proc_handler	= &appldata_interval_handler,
 	},
-	{ .ctl_name = 0 }
+	{ },
 };
 
 static struct ctl_table appldata_dir_table[] = {
 	{
-		.ctl_name	= CTL_APPLDATA,
 		.procname	= appldata_proc_name,
 		.maxlen		= 0,
 		.mode		= S_IRUGO | S_IXUGO,
 		.child		= appldata_table,
 	},
-	{ .ctl_name = 0 }
+	{ },
 };
 
 /*
@@ -441,75 +438,38 @@ out:
  */
 int appldata_register_ops(struct appldata_ops *ops)
 {
-	struct list_head *lh;
-	struct appldata_ops *tmp_ops;
-	int i;
-
-	i = 0;
+	if ((ops->size > APPLDATA_MAX_REC_SIZE) || (ops->size < 0))
+		return -EINVAL;
 
-	if ((ops->size > APPLDATA_MAX_REC_SIZE) ||
-		(ops->size < 0)){
-		P_ERROR("Invalid size of %s record = %i, maximum = %i!\n",
-			ops->name, ops->size, APPLDATA_MAX_REC_SIZE);
-		return -ENOMEM;
-	}
-	if ((ops->ctl_nr == CTL_APPLDATA) ||
-	    (ops->ctl_nr == CTL_APPLDATA_TIMER) ||
-	    (ops->ctl_nr == CTL_APPLDATA_INTERVAL)) {
-		P_ERROR("ctl_nr %i already in use!\n", ops->ctl_nr);
-		return -EBUSY;
-	}
-	ops->ctl_table = kzalloc(4*sizeof(struct ctl_table), GFP_KERNEL);
-	if (ops->ctl_table == NULL) {
-		P_ERROR("Not enough memory for %s ctl_table!\n", ops->name);
+	ops->ctl_table = kzalloc(4 * sizeof(struct ctl_table), GFP_KERNEL);
+	if (!ops->ctl_table)
 		return -ENOMEM;
-	}
 
 	spin_lock(&appldata_ops_lock);
-	list_for_each(lh, &appldata_ops_list) {
-		tmp_ops = list_entry(lh, struct appldata_ops, list);
-		P_DEBUG("register_ops loop: %i) name = %s, ctl = %i\n",
-			++i, tmp_ops->name, tmp_ops->ctl_nr);
-		P_DEBUG("Comparing %s (ctl %i) with %s (ctl %i)\n",
-			tmp_ops->name, tmp_ops->ctl_nr, ops->name,
-			ops->ctl_nr);
-		if (strncmp(tmp_ops->name, ops->name,
-				APPLDATA_PROC_NAME_LENGTH) == 0) {
-			P_ERROR("Name \"%s\" already registered!\n", ops->name);
-			kfree(ops->ctl_table);
-			spin_unlock(&appldata_ops_lock);
-			return -EBUSY;
-		}
-		if (tmp_ops->ctl_nr == ops->ctl_nr) {
-			P_ERROR("ctl_nr %i already registered!\n", ops->ctl_nr);
-			kfree(ops->ctl_table);
-			spin_unlock(&appldata_ops_lock);
-			return -EBUSY;
-		}
-	}
 	list_add(&ops->list, &appldata_ops_list);
 	spin_unlock(&appldata_ops_lock);
 
-	ops->ctl_table[0].ctl_name = CTL_APPLDATA;
 	ops->ctl_table[0].procname = appldata_proc_name;
 	ops->ctl_table[0].maxlen   = 0;
 	ops->ctl_table[0].mode     = S_IRUGO | S_IXUGO;
 	ops->ctl_table[0].child    = &ops->ctl_table[2];
 
-	ops->ctl_table[1].ctl_name = 0;
-
-	ops->ctl_table[2].ctl_name = ops->ctl_nr;
 	ops->ctl_table[2].procname = ops->name;
 	ops->ctl_table[2].mode     = S_IRUGO | S_IWUSR;
 	ops->ctl_table[2].proc_handler = appldata_generic_handler;
 	ops->ctl_table[2].data = ops;
 
-	ops->ctl_table[3].ctl_name = 0;
-
 	ops->sysctl_header = register_sysctl_table(ops->ctl_table);
-
+	if (!ops->sysctl_header)
+		goto out;
 	P_INFO("%s-ops registered!\n", ops->name);
 	return 0;
+out:
+	spin_lock(&appldata_ops_lock);
+	list_del(&ops->list);
+	spin_unlock(&appldata_ops_lock);
+	kfree(ops->ctl_table);
+	return -ENOMEM;
 }
 
 /*
@@ -519,15 +479,11 @@ int appldata_register_ops(struct appldata_ops *ops)
  */
 void appldata_unregister_ops(struct appldata_ops *ops)
 {
-	void *table;
 	spin_lock(&appldata_ops_lock);
 	list_del(&ops->list);
-	/* at that point any incoming access will fail */
-	table = ops->ctl_table;
-	ops->ctl_table = NULL;
 	spin_unlock(&appldata_ops_lock);
 	unregister_sysctl_table(ops->sysctl_header);
-	kfree(table);
+	kfree(ops->ctl_table);
 	P_INFO("%s-ops unregistered!\n", ops->name);
 }
 /********************** module-ops management <END> **************************/
diff --git a/arch/s390/appldata/appldata_mem.c b/arch/s390/appldata/appldata_mem.c
index 697eb30..51181cc 100644
--- a/arch/s390/appldata/appldata_mem.c
+++ b/arch/s390/appldata/appldata_mem.c
@@ -147,7 +147,6 @@ static void appldata_get_mem_data(void *data)
 
 
 static struct appldata_ops ops = {
-	.ctl_nr    = CTL_APPLDATA_MEM,
 	.name      = "mem",
 	.record_nr = APPLDATA_RECORD_MEM_ID,
 	.size	   = sizeof(struct appldata_mem_data),
diff --git a/arch/s390/appldata/appldata_net_sum.c b/arch/s390/appldata/appldata_net_sum.c
index 6c1815a..4d83443 100644
--- a/arch/s390/appldata/appldata_net_sum.c
+++ b/arch/s390/appldata/appldata_net_sum.c
@@ -142,7 +142,6 @@ static void appldata_get_net_sum_data(void *data)
 
 
 static struct appldata_ops ops = {
-	.ctl_nr    = CTL_APPLDATA_NET_SUM,
 	.name	   = "net_sum",
 	.record_nr = APPLDATA_RECORD_NET_SUM_ID,
 	.size	   = sizeof(struct appldata_net_sum_data),
diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index 76a1552..6b3eafe 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -82,7 +82,6 @@ struct appldata_os_data {
 static struct appldata_os_data *appldata_os_data;
 
 static struct appldata_ops ops = {
-	.ctl_nr    = CTL_APPLDATA_OS,
 	.name	   = "os",
 	.record_nr = APPLDATA_RECORD_OS_ID,
 	.owner	   = THIS_MODULE,
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 8bf4ae1..1b3af7d 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -200,7 +200,7 @@ static noinline __init void find_memory_chunks(unsigned long memsize)
 		cc = __tprot(addr);
 		while (cc == old_cc) {
 			addr += CHUNK_INCR;
-			if (addr >= memsize)
+			if (memsize && addr >= memsize)
 				break;
 #ifndef CONFIG_64BIT
 			if (addr == ADDR2G)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 139ca15..b2b2edc 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -69,13 +69,31 @@ STACK_SIZE  = 1 << STACK_SHIFT
 	basr	%r14,%r1
 	.endm
 
-	.macro	LOCKDEP_SYS_EXIT
-	l	%r1,BASED(.Llockdep_sys_exit)
+	.macro	TRACE_IRQS_CHECK
+	tm	SP_PSW(%r15),0x03	# irqs enabled?
+	jz	0f
+	l	%r1,BASED(.Ltrace_irq_on)
 	basr	%r14,%r1
+	j	1f
+0:	l	%r1,BASED(.Ltrace_irq_off)
+	basr	%r14,%r1
+1:
 	.endm
 #else
 #define TRACE_IRQS_ON
 #define TRACE_IRQS_OFF
+#define TRACE_IRQS_CHECK
+#endif
+
+#ifdef CONFIG_LOCKDEP
+	.macro	LOCKDEP_SYS_EXIT
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+	jz	0f
+	l	%r1,BASED(.Llockdep_sys_exit)
+	basr	%r14,%r1
+0:
+	.endm
+#else
 #define LOCKDEP_SYS_EXIT
 #endif
 
@@ -234,8 +252,6 @@ sysc_saveall:
 	lh	%r7,0x8a	  # get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 sysc_vtime:
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	bz	BASED(sysc_do_svc)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 sysc_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
@@ -263,19 +279,34 @@ sysc_do_restart:
 
 sysc_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-	bno	BASED(sysc_leave)
+	bno	BASED(sysc_restore)
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
+sysc_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	la	%r1,BASED(sysc_restore_trace_psw)
+	lpsw	0(%r1)
+sysc_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 sysc_leave:
 	RESTORE_ALL __LC_RETURN_PSW,1
+sysc_done:
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl	sysc_restore_trace_psw
+sysc_restore_trace_psw:
+	.long	0, sysc_restore_trace + 0x80000000
+#endif
 
 #
 # recheck if there is more work to do
 #
 sysc_work_loop:
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
-	bz	BASED(sysc_leave)	# there is no work to do
+	bz	BASED(sysc_restore)	# there is no work to do
 #
 # One of the work bits is on. Find out which one.
 #
@@ -290,8 +321,8 @@ sysc_work:
 	bo	BASED(sysc_restart)
 	tm	__TI_flags+3(%r9),_TIF_SINGLE_STEP
 	bo	BASED(sysc_singlestep)
-	LOCKDEP_SYS_EXIT
-	b	BASED(sysc_leave)
+	b	BASED(sysc_restore)
+sysc_work_done:
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
@@ -458,6 +489,7 @@ pgm_check_handler:
 pgm_no_vtime:
 #endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	l	%r3,__LC_PGM_ILC	# load program interruption code
 	la	%r8,0x7f
 	nr	%r8,%r3
@@ -497,6 +529,7 @@ pgm_per_std:
 pgm_no_vtime2:
 #endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	l	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
@@ -517,15 +550,13 @@ pgm_svcper:
 	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	bz	BASED(pgm_no_vtime3)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-pgm_no_vtime3:
 #endif
 	lh	%r7,0x8a		# get svc number from lowcore
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	l	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
@@ -542,7 +573,7 @@ kernel_per:
 	mvi	SP_TRAP+1(%r15),0x28	# set trap indication to pgm check
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	l	%r1,BASED(.Lhandle_per)	# load adr. of per handler
-	la	%r14,BASED(sysc_leave)	# load adr. of system return
+	la	%r14,BASED(sysc_restore)# load adr. of system return
 	br	%r1			# branch to do_single_step
 
 /*
@@ -569,26 +600,38 @@ io_no_vtime:
 	l	%r1,BASED(.Ldo_IRQ)	# load address of do_IRQ
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	basr	%r14,%r1		# branch to standard irq handler
-	TRACE_IRQS_ON
-
 io_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
 #ifdef CONFIG_PREEMPT
 	bno	BASED(io_preempt)	# no -> check for preemptive scheduling
 #else
-	bno	BASED(io_leave) 	# no-> skip resched & signal
+	bno	BASED(io_restore)	# no-> skip resched & signal
 #endif
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bnz	BASED(io_work)		# there is work to do (signals etc.)
+io_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	la	%r1,BASED(io_restore_trace_psw)
+	lpsw	0(%r1)
+io_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 io_leave:
 	RESTORE_ALL __LC_RETURN_PSW,0
 io_done:
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl	io_restore_trace_psw
+io_restore_trace_psw:
+	.long	0, io_restore_trace + 0x80000000
+#endif
+
 #ifdef CONFIG_PREEMPT
 io_preempt:
 	icm	%r0,15,__TI_precount(%r9)
-	bnz	BASED(io_leave)
+	bnz	BASED(io_restore)
 	l	%r1,SP_R15(%r15)
 	s	%r1,BASED(.Lc_spsize)
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
@@ -596,14 +639,10 @@ io_preempt:
 	lr	%r15,%r1
 io_resume_loop:
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
-	bno	BASED(io_leave)
-	mvc	__TI_precount(4,%r9),BASED(.Lc_pactive)
-	stosm	__SF_EMPTY(%r15),0x03  # reenable interrupts
-	l	%r1,BASED(.Lschedule)
-	basr	%r14,%r1	       # call schedule
-	stnsm	__SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
-	xc	__TI_precount(4,%r9),__TI_precount(%r9)
-	b	BASED(io_resume_loop)
+	bno	BASED(io_restore)
+	l	%r1,BASED(.Lpreempt_schedule_irq)
+	la	%r14,BASED(io_resume_loop)
+	br	%r1			# call schedule
 #endif
 
 #
@@ -627,40 +666,42 @@ io_work_loop:
 	bo	BASED(io_reschedule)
 	tm	__TI_flags+3(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
 	bnz	BASED(io_sigpending)
-	LOCKDEP_SYS_EXIT
-	b	BASED(io_leave)
+	b	BASED(io_restore)
+io_work_done:
 
 #
 # _TIF_MCCK_PENDING is set, call handler
 #
 io_mcck_pending:
-	TRACE_IRQS_OFF
 	l	%r1,BASED(.Ls390_handle_mcck)
 	basr	%r14,%r1		# TIF bit will be cleared by handler
-	TRACE_IRQS_ON
 	b	BASED(io_work_loop)
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
 #
 io_reschedule:
+	TRACE_IRQS_ON
 	l	%r1,BASED(.Lschedule)
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	basr	%r14,%r1		# call scheduler
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
-	bz	BASED(io_leave) 	# there is no work to do
+	bz	BASED(io_restore)	# there is no work to do
 	b	BASED(io_work_loop)
 
 #
 # _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 io_sigpending:
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	l	%r1,BASED(.Ldo_signal)
 	basr	%r14,%r1		# call do_signal
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	b	BASED(io_work_loop)
 
 /*
@@ -688,7 +729,6 @@ ext_no_vtime:
 	lh	%r3,__LC_EXT_INT_CODE	# get interruption code
 	l	%r1,BASED(.Ldo_extint)
 	basr	%r14,%r1
-	TRACE_IRQS_ON
 	b	BASED(io_return)
 
 __critical_end:
@@ -853,15 +893,15 @@ cleanup_table_system_call:
 cleanup_table_sysc_return:
 	.long	sysc_return + 0x80000000, sysc_leave + 0x80000000
 cleanup_table_sysc_leave:
-	.long	sysc_leave + 0x80000000, sysc_work_loop + 0x80000000
+	.long	sysc_leave + 0x80000000, sysc_done + 0x80000000
 cleanup_table_sysc_work_loop:
-	.long	sysc_work_loop + 0x80000000, sysc_reschedule + 0x80000000
+	.long	sysc_work_loop + 0x80000000, sysc_work_done + 0x80000000
 cleanup_table_io_return:
 	.long	io_return + 0x80000000, io_leave + 0x80000000
 cleanup_table_io_leave:
 	.long	io_leave + 0x80000000, io_done + 0x80000000
 cleanup_table_io_work_loop:
-	.long	io_work_loop + 0x80000000, io_mcck_pending + 0x80000000
+	.long	io_work_loop + 0x80000000, io_work_done + 0x80000000
 
 cleanup_critical:
 	clc	4(4,%r12),BASED(cleanup_table_system_call)
@@ -930,8 +970,6 @@ cleanup_system_call:
 cleanup_vtime:
 	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+12)
 	bhe	BASED(cleanup_stime)
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	bz	BASED(cleanup_novtime)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 cleanup_stime:
 	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+16)
@@ -939,7 +977,6 @@ cleanup_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 cleanup_update:
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-cleanup_novtime:
 #endif
 	mvc	__LC_RETURN_PSW+4(4),BASED(cleanup_table_system_call+4)
 	la	%r12,__LC_RETURN_PSW
@@ -978,10 +1015,10 @@ cleanup_sysc_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_sysc_leave_insn:
+	.long	sysc_done - 4 + 0x80000000
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.long	sysc_leave + 14 + 0x80000000
+	.long	sysc_done - 8 + 0x80000000
 #endif
-	.long	sysc_leave + 10 + 0x80000000
 
 cleanup_io_return:
 	mvc	__LC_RETURN_PSW(4),0(%r12)
@@ -1008,10 +1045,10 @@ cleanup_io_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_io_leave_insn:
+	.long	io_done - 4 + 0x80000000
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.long	io_leave + 18 + 0x80000000
+	.long	io_done - 8 + 0x80000000
 #endif
-	.long	io_leave + 14 + 0x80000000
 
 /*
  * Integer constants
@@ -1019,7 +1056,6 @@ cleanup_io_leave_insn:
 		.align	4
 .Lc_spsize:	.long	SP_SIZE
 .Lc_overhead:	.long	STACK_FRAME_OVERHEAD
-.Lc_pactive:	.long	PREEMPT_ACTIVE
 .Lnr_syscalls:	.long	NR_syscalls
 .L0x018:	.short	0x018
 .L0x020:	.short	0x020
@@ -1043,6 +1079,8 @@ cleanup_io_leave_insn:
 .Lexecve_tail:	.long	execve_tail
 .Ljump_table:	.long	pgm_check_table
 .Lschedule:	.long	schedule
+.Lpreempt_schedule_irq:
+		.long	preempt_schedule_irq
 .Ltrace:	.long	syscall_trace
 .Lschedtail:	.long	schedule_tail
 .Lsysc_table:	.long	sys_call_table
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 05e26d1..a3e47b8 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -67,12 +67,28 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK | _TIF_NEED_RESCHED | \
 	 brasl	%r14,trace_hardirqs_off
 	.endm
 
-	.macro	LOCKDEP_SYS_EXIT
-	 brasl	%r14,lockdep_sys_exit
+	.macro TRACE_IRQS_CHECK
+	tm	SP_PSW(%r15),0x03	# irqs enabled?
+	jz	0f
+	brasl	%r14,trace_hardirqs_on
+	j	1f
+0:	brasl	%r14,trace_hardirqs_off
+1:
 	.endm
 #else
 #define TRACE_IRQS_ON
 #define TRACE_IRQS_OFF
+#define TRACE_IRQS_CHECK
+#endif
+
+#ifdef CONFIG_LOCKDEP
+	.macro	LOCKDEP_SYS_EXIT
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+	jz	0f
+	brasl	%r14,lockdep_sys_exit
+0:
+	.endm
+#else
 #define LOCKDEP_SYS_EXIT
 #endif
 
@@ -222,8 +238,6 @@ sysc_saveall:
 	llgh	%r7,__LC_SVC_INT_CODE	# get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 sysc_vtime:
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	jz	sysc_do_svc
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 sysc_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
@@ -257,19 +271,34 @@ sysc_noemu:
 
 sysc_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-	jno	sysc_leave
+	jno	sysc_restore
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jnz	sysc_work	# there is work to do (signals etc.)
+sysc_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	larl	%r1,sysc_restore_trace_psw
+	lpswe	0(%r1)
+sysc_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 sysc_leave:
 	RESTORE_ALL __LC_RETURN_PSW,1
+sysc_done:
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl sysc_restore_trace_psw
+sysc_restore_trace_psw:
+	.quad	0, sysc_restore_trace
+#endif
 
 #
 # recheck if there is more work to do
 #
 sysc_work_loop:
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
-	jz	sysc_leave	  # there is no work to do
+	jz	sysc_restore	  # there is no work to do
 #
 # One of the work bits is on. Find out which one.
 #
@@ -284,8 +313,8 @@ sysc_work:
 	jo	sysc_restart
 	tm	__TI_flags+7(%r9),_TIF_SINGLE_STEP
 	jo	sysc_singlestep
-	LOCKDEP_SYS_EXIT
-	j	sysc_leave
+	j	sysc_restore
+sysc_work_done:
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
@@ -445,6 +474,7 @@ pgm_check_handler:
 pgm_no_vtime:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	lgf	%r3,__LC_PGM_ILC	# load program interruption code
 	lghi	%r8,0x7f
 	ngr	%r8,%r3
@@ -484,6 +514,7 @@ pgm_per_std:
 pgm_no_vtime2:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	lg	%r1,__TI_task(%r9)
 	tm	SP_PSW+1(%r15),0x01	# kernel per event ?
 	jz	kernel_per
@@ -504,12 +535,9 @@ pgm_svcper:
 	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	jz	pgm_no_vtime3
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-pgm_no_vtime3:
 #endif
 	llgh	%r7,__LC_SVC_INT_CODE	# get svc number from lowcore
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
@@ -529,7 +557,7 @@ kernel_per:
 	lhi	%r0,__LC_PGM_OLD_PSW
 	sth	%r0,SP_TRAP(%r15)	# set trap indication to pgm check
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
-	larl	%r14,sysc_leave		# load adr. of system ret, no work
+	larl	%r14,sysc_restore	# load adr. of system ret, no work
 	jg	do_single_step		# branch to do_single_step
 
 /*
@@ -554,26 +582,38 @@ io_no_vtime:
 	TRACE_IRQS_OFF
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	brasl	%r14,do_IRQ		# call standard irq handler
-	TRACE_IRQS_ON
-
 io_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
 #ifdef CONFIG_PREEMPT
 	jno	io_preempt		# no -> check for preemptive scheduling
 #else
-	jno	io_leave		# no-> skip resched & signal
+	jno	io_restore		# no-> skip resched & signal
 #endif
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
 	jnz	io_work 		# there is work to do (signals etc.)
+io_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	larl	%r1,io_restore_trace_psw
+	lpswe	0(%r1)
+io_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 io_leave:
 	RESTORE_ALL __LC_RETURN_PSW,0
 io_done:
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl io_restore_trace_psw
+io_restore_trace_psw:
+	.quad	0, io_restore_trace
+#endif
+
 #ifdef CONFIG_PREEMPT
 io_preempt:
 	icm	%r0,15,__TI_precount(%r9)
-	jnz	io_leave
+	jnz	io_restore
 	# switch to kernel stack
 	lg	%r1,SP_R15(%r15)
 	aghi	%r1,-SP_SIZE
@@ -582,14 +622,9 @@ io_preempt:
 	lgr	%r15,%r1
 io_resume_loop:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
-	jno	io_leave
-	larl	%r1,.Lc_pactive
-	mvc	__TI_precount(4,%r9),0(%r1)
-	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
-	brasl	%r14,schedule		# call schedule
-	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
-	xc	__TI_precount(4,%r9),__TI_precount(%r9)
-	j	io_resume_loop
+	jno	io_restore
+	larl	%r14,io_resume_loop
+	jg	preempt_schedule_irq
 #endif
 
 #
@@ -613,37 +648,39 @@ io_work_loop:
 	jo	io_reschedule
 	tm	__TI_flags+7(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
 	jnz	io_sigpending
-	LOCKDEP_SYS_EXIT
-	j	io_leave
+	j	io_restore
+io_work_done:
 
 #
 # _TIF_MCCK_PENDING is set, call handler
 #
 io_mcck_pending:
-	TRACE_IRQS_OFF
 	brasl	%r14,s390_handle_mcck	# TIF bit will be cleared by handler
-	TRACE_IRQS_ON
 	j	io_work_loop
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
 #
 io_reschedule:
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	brasl	%r14,schedule		# call scheduler
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
-	jz	io_leave		# there is no work to do
+	jz	io_restore		# there is no work to do
 	j	io_work_loop
 
 #
 # _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 io_sigpending:
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	brasl	%r14,do_signal		# call do_signal
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	j	io_work_loop
 
 /*
@@ -669,7 +706,6 @@ ext_no_vtime:
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	llgh	%r3,__LC_EXT_INT_CODE	# get interruption code
 	brasl	%r14,do_extint
-	TRACE_IRQS_ON
 	j	io_return
 
 __critical_end:
@@ -824,15 +860,15 @@ cleanup_table_system_call:
 cleanup_table_sysc_return:
 	.quad	sysc_return, sysc_leave
 cleanup_table_sysc_leave:
-	.quad	sysc_leave, sysc_work_loop
+	.quad	sysc_leave, sysc_done
 cleanup_table_sysc_work_loop:
-	.quad	sysc_work_loop, sysc_reschedule
+	.quad	sysc_work_loop, sysc_work_done
 cleanup_table_io_return:
 	.quad	io_return, io_leave
 cleanup_table_io_leave:
 	.quad	io_leave, io_done
 cleanup_table_io_work_loop:
-	.quad	io_work_loop, io_mcck_pending
+	.quad	io_work_loop, io_work_done
 
 cleanup_critical:
 	clc	8(8,%r12),BASED(cleanup_table_system_call)
@@ -901,8 +937,6 @@ cleanup_system_call:
 cleanup_vtime:
 	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+24)
 	jhe	cleanup_stime
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	jz	cleanup_novtime
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 cleanup_stime:
 	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+32)
@@ -910,7 +944,6 @@ cleanup_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 cleanup_update:
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-cleanup_novtime:
 #endif
 	mvc	__LC_RETURN_PSW+8(8),BASED(cleanup_table_system_call+8)
 	la	%r12,__LC_RETURN_PSW
@@ -949,10 +982,10 @@ cleanup_sysc_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_sysc_leave_insn:
+	.quad	sysc_done - 4
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.quad	sysc_leave + 16
+	.quad	sysc_done - 8
 #endif
-	.quad	sysc_leave + 12
 
 cleanup_io_return:
 	mvc	__LC_RETURN_PSW(8),0(%r12)
@@ -979,17 +1012,16 @@ cleanup_io_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_io_leave_insn:
+	.quad	io_done - 4
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.quad	io_leave + 20
+	.quad	io_done - 8
 #endif
-	.quad	io_leave + 16
 
 /*
  * Integer constants
  */
 		.align	4
 .Lconst:
-.Lc_pactive:	.long	PREEMPT_ACTIVE
 .Lnr_syscalls:	.long	NR_syscalls
 .L0x0130:	.short	0x130
 .L0x0140:	.short	0x140
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 7e1bfb9..50f8f1e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -347,7 +347,7 @@ void (*_machine_power_off)(void) = do_machine_power_off_nonsmp;
 
 void machine_restart(char *command)
 {
-	if (!in_interrupt() || oops_in_progress)
+	if ((!in_interrupt() && !in_atomic()) || oops_in_progress)
 		/*
 		 * Only unblank the console if we are called in enabled
 		 * context or a bust_spinlocks cleared the way for us.
@@ -492,6 +492,10 @@ static void setup_addressing_mode(void)
 		printk("S390 address spaces switched, ");
 		set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY);
 	}
+#ifdef CONFIG_TRACE_IRQFLAGS
+	sysc_restore_trace_psw.mask = psw_kernel_bits & ~PSW_MASK_MCHECK;
+	io_restore_trace_psw.mask = psw_kernel_bits & ~PSW_MASK_MCHECK;
+#endif
 }
 
 static void __init
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index b05ae85..264ea90 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -193,72 +193,30 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-static void do_send_stop(void)
+void smp_send_stop(void)
 {
 	int cpu, rc;
 
-	/* stop all processors */
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
-		do {
-			rc = signal_processor(cpu, sigp_stop);
-		} while (rc == sigp_busy);
-	}
-}
+	/* Disable all interrupts/machine checks */
+	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
 
-static void do_store_status(void)
-{
-	int cpu, rc;
+	/* write magic number to zero page (absolute 0) */
+	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
 
-	/* store status of all processors in their lowcores (real 0) */
+	/* stop all processors */
 	for_each_online_cpu(cpu) {
 		if (cpu == smp_processor_id())
 			continue;
 		do {
-			rc = signal_processor_p(
-				(__u32)(unsigned long) lowcore_ptr[cpu], cpu,
-				sigp_store_status_at_address);
+			rc = signal_processor(cpu, sigp_stop);
 		} while (rc == sigp_busy);
-	}
-}
 
-static void do_wait_for_stop(void)
-{
-	int cpu;
-
-	/* Wait for all other cpus to enter stopped state */
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
 		while (!smp_cpu_not_running(cpu))
 			cpu_relax();
 	}
 }
 
 /*
- * this function sends a 'stop' sigp to all other CPUs in the system.
- * it goes straight through.
- */
-void smp_send_stop(void)
-{
-	/* Disable all interrupts/machine checks */
-	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
-
-	/* write magic number to zero page (absolute 0) */
-	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
-
-	/* stop other processors. */
-	do_send_stop();
-
-	/* wait until other processors are stopped */
-	do_wait_for_stop();
-
-	/* store status of other processors. */
-	do_store_status();
-}
-
-/*
  * Reboot, halt and power_off routines for SMP.
  */
 void machine_restart_smp(char *__unused)
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 8ec9def..8ed16a8 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -260,6 +260,7 @@ void die(const char * str, struct pt_regs * regs, long err)
 	bust_spinlocks(1);
 	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	print_modules();
+	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV);
 	show_regs(regs);
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE);
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index d4ed93d..413c240 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -341,19 +341,16 @@ cmm_timeout_handler(ctl_table *ctl, int write, struct file *filp,
 
 static struct ctl_table cmm_table[] = {
 	{
-		.ctl_name	= VM_CMM_PAGES,
 		.procname	= "cmm_pages",
 		.mode		= 0644,
 		.proc_handler	= &cmm_pages_handler,
 	},
 	{
-		.ctl_name	= VM_CMM_TIMED_PAGES,
 		.procname	= "cmm_timed_pages",
 		.mode		= 0644,
 		.proc_handler	= &cmm_pages_handler,
 	},
 	{
-		.ctl_name	= VM_CMM_TIMEOUT,
 		.procname	= "cmm_timeout",
 		.mode		= 0644,
 		.proc_handler	= &cmm_timeout_handler,
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 838f7ac..6db3108 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -483,7 +483,7 @@ static DECLARE_WORK(css_reprobe_work, reprobe_all);
 void css_schedule_reprobe(void)
 {
 	need_reprobe = 1;
-	queue_work(ccw_device_work, &css_reprobe_work);
+	queue_work(slow_path_wq, &css_reprobe_work);
 }
 
 EXPORT_SYMBOL_GPL(css_schedule_reprobe);
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 8867443..bfad421 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -1034,7 +1034,7 @@ device_trigger_reprobe(struct subchannel *sch)
 	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_move_to_orphanage);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(slow_path_wq, &cdev->private->kick_work);
 	} else
 		ccw_device_start_id(cdev, 0);
 }
diff --git a/drivers/s390/cio/device_id.c b/drivers/s390/cio/device_id.c
index f232832..2f6bf46 100644
--- a/drivers/s390/cio/device_id.c
+++ b/drivers/s390/cio/device_id.c
@@ -113,19 +113,10 @@ __ccw_device_sense_id_start(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
 	struct ccw1 *ccw;
-	int ret;
 
 	sch = to_subchannel(cdev->dev.parent);
 	/* Setup sense channel program. */
 	ccw = cdev->private->iccws;
-	if (sch->schib.pmcw.pim != 0x80) {
-		/* more than one path installed. */
-		ccw->cmd_code = CCW_CMD_SUSPEND_RECONN;
-		ccw->cda = 0;
-		ccw->count = 0;
-		ccw->flags = CCW_FLAG_SLI | CCW_FLAG_CC;
-		ccw++;
-	}
 	ccw->cmd_code = CCW_CMD_SENSE_ID;
 	ccw->cda = (__u32) __pa (&cdev->private->senseid);
 	ccw->count = sizeof (struct senseid);
@@ -133,25 +124,9 @@ __ccw_device_sense_id_start(struct ccw_device *cdev)
 
 	/* Reset device status. */
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
+	cdev->private->flags.intretry = 0;
 
-	/* Try on every path. */
-	ret = -ENODEV;
-	while (cdev->private->imask != 0) {
-		if ((sch->opm & cdev->private->imask) != 0 &&
-		    cdev->private->iretry > 0) {
-			cdev->private->iretry--;
-			/* Reset internal retry indication. */
-			cdev->private->flags.intretry = 0;
-			ret = cio_start (sch, cdev->private->iccws,
-					 cdev->private->imask);
-			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
-			if (ret != -EACCES)
-				return ret;
-		}
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-	}
-	return ret;
+	return cio_start(sch, ccw, LPM_ANYPATH);
 }
 
 void
@@ -161,8 +136,7 @@ ccw_device_sense_id_start(struct ccw_device *cdev)
 
 	memset (&cdev->private->senseid, 0, sizeof (struct senseid));
 	cdev->private->senseid.cu_type = 0xFFFF;
-	cdev->private->imask = 0x80;
-	cdev->private->iretry = 5;
+	cdev->private->iretry = 3;
 	ret = __ccw_device_sense_id_start(cdev);
 	if (ret && ret != -EBUSY)
 		ccw_device_sense_id_done(cdev, ret);
@@ -278,14 +252,13 @@ ccw_device_sense_id_irq(struct ccw_device *cdev, enum dev_event dev_event)
 		ccw_device_sense_id_done(cdev, ret);
 		break;
 	case -EACCES:		/* channel is not operational. */
-		sch->lpm &= ~cdev->private->imask;
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		/* fall through. */
 	case -EAGAIN:		/* try again. */
-		ret = __ccw_device_sense_id_start(cdev);
-		if (ret == 0 || ret == -EBUSY)
-			break;
+		cdev->private->iretry--;
+		if (cdev->private->iretry > 0) {
+			ret = __ccw_device_sense_id_start(cdev);
+			if (ret == 0 || ret == -EBUSY)
+				break;
+		}
 		/* fall through. */
 	default:		/* Sense ID failed. Try asking VM. */
 		if (MACHINE_IS_VM) {
diff --git a/include/asm-s390/system.h b/include/asm-s390/system.h
index d866d33..44bda78 100644
--- a/include/asm-s390/system.h
+++ b/include/asm-s390/system.h
@@ -388,6 +388,11 @@ extern void (*_machine_power_off)(void);
 
 #define arch_align_stack(x) (x)
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+extern psw_t sysc_restore_trace_psw;
+extern psw_t io_restore_trace_psw;
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e99171f..4f5047d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -70,7 +70,6 @@ enum
 	CTL_ABI=9,		/* Binary emulation */
 	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
 	CTL_ARLAN=254,		/* arlan wireless driver */
-	CTL_APPLDATA=2120,	/* s390 appldata */
 	CTL_S390DBF=5677,	/* s390 debug */
 	CTL_SUNRPC=7249,	/* sunrpc debug */
 	CTL_PM=9899,		/* frv power management */
@@ -207,11 +206,6 @@ enum
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
-
-	/* s390 vm cmm sysctls */
-	VM_CMM_PAGES=1111,
-	VM_CMM_TIMED_PAGES=1112,
-	VM_CMM_TIMEOUT=1113,
 };
 
 
diff --git a/kernel/sysctl_check.c b/kernel/sysctl_check.c
index 4abc6d2..8f5baac 100644
--- a/kernel/sysctl_check.c
+++ b/kernel/sysctl_check.c
@@ -140,9 +140,6 @@ static struct trans_ctl_table trans_vm_table[] = {
 	{ VM_PANIC_ON_OOM,		"panic_on_oom" },
 	{ VM_VDSO_ENABLED,		"vdso_enabled" },
 	{ VM_MIN_SLAB,			"min_slab_ratio" },
-	{ VM_CMM_PAGES,			"cmm_pages" },
-	{ VM_CMM_TIMED_PAGES,		"cmm_timed_pages" },
-	{ VM_CMM_TIMEOUT,		"cmm_timeout" },
 
 	{}
 };
@@ -1219,16 +1216,6 @@ static struct trans_ctl_table trans_arlan_table[] = {
 	{}
 };
 
-static struct trans_ctl_table trans_appldata_table[] = {
-	{ CTL_APPLDATA_TIMER,		"timer" },
-	{ CTL_APPLDATA_INTERVAL,	"interval" },
-	{ CTL_APPLDATA_OS,		"os" },
-	{ CTL_APPLDATA_NET_SUM,		"net_sum" },
-	{ CTL_APPLDATA_MEM,		"mem" },
-	{}
-
-};
-
 static struct trans_ctl_table trans_s390dbf_table[] = {
 	{ 5678 /* CTL_S390DBF_STOPPABLE */,	"debug_stoppable" },
 	{ 5679 /* CTL_S390DBF_ACTIVE */,	"debug_active" },
@@ -1273,7 +1260,6 @@ static struct trans_ctl_table trans_root_table[] = {
 	{ CTL_ABI,	"abi" },
 	/* CTL_CPU not used */
 	{ CTL_ARLAN,	"arlan",	trans_arlan_table },
-	{ CTL_APPLDATA,	"appldata",	trans_appldata_table },
 	{ CTL_S390DBF,	"s390dbf",	trans_s390dbf_table },
 	{ CTL_SUNRPC,	"sunrpc",	trans_sunrpc_table },
 	{ CTL_PM,	"pm",		trans_pm_table },
diff --git a/mm/rmap.c b/mm/rmap.c
index dc3be5f..dbc2ca2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -471,11 +471,12 @@ int page_mkclean(struct page *page)
 
 	if (page_mapped(page)) {
 		struct address_space *mapping = page_mapping(page);
-		if (mapping)
+		if (mapping) {
 			ret = page_mkclean_file(mapping, page);
-		if (page_test_dirty(page)) {
-			page_clear_dirty(page);
-			ret = 1;
+			if (page_test_dirty(page)) {
+				page_clear_dirty(page);
+				ret = 1;
+			}
 		}
 	}
 
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index a2f5a6e..7698f6c 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -97,7 +97,7 @@ struct iucv_irq_list {
 	struct iucv_irq_data data;
 };
 
-static struct iucv_irq_data *iucv_irq_data;
+static struct iucv_irq_data *iucv_irq_data[NR_CPUS];
 static cpumask_t iucv_buffer_cpumask = CPU_MASK_NONE;
 static cpumask_t iucv_irq_cpumask = CPU_MASK_NONE;
 
@@ -277,7 +277,7 @@ union iucv_param {
 /*
  * Anchor for per-cpu IUCV command parameter block.
  */
-static union iucv_param *iucv_param;
+static union iucv_param *iucv_param[NR_CPUS];
 
 /**
  * iucv_call_b2f0
@@ -356,7 +356,7 @@ static void iucv_allow_cpu(void *data)
 	 *	0x10 - Flag to allow priority message completion interrupts
 	 *	0x08 - Flag to allow IUCV control interrupts
 	 */
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[cpu];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->set_mask.ipmask = 0xf8;
 	iucv_call_b2f0(IUCV_SETMASK, parm);
@@ -377,7 +377,7 @@ static void iucv_block_cpu(void *data)
 	union iucv_param *parm;
 
 	/* Disable all iucv interrupts. */
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[cpu];
 	memset(parm, 0, sizeof(union iucv_param));
 	iucv_call_b2f0(IUCV_SETMASK, parm);
 
@@ -401,9 +401,9 @@ static void iucv_declare_cpu(void *data)
 		return;
 
 	/* Declare interrupt buffer. */
-	parm = percpu_ptr(iucv_param, cpu);
+	parm = iucv_param[cpu];
 	memset(parm, 0, sizeof(union iucv_param));
-	parm->db.ipbfadr1 = virt_to_phys(percpu_ptr(iucv_irq_data, cpu));
+	parm->db.ipbfadr1 = virt_to_phys(iucv_irq_data[cpu]);
 	rc = iucv_call_b2f0(IUCV_DECLARE_BUFFER, parm);
 	if (rc) {
 		char *err = "Unknown";
@@ -458,7 +458,7 @@ static void iucv_retrieve_cpu(void *data)
 	iucv_block_cpu(NULL);
 
 	/* Retrieve interrupt buffer. */
-	parm = percpu_ptr(iucv_param, cpu);
+	parm = iucv_param[cpu];
 	iucv_call_b2f0(IUCV_RETRIEVE_BUFFER, parm);
 
 	/* Clear indication that an iucv buffer exists for this cpu. */
@@ -558,22 +558,23 @@ static int __cpuinit iucv_cpu_notify(struct notifier_block *self,
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
-		if (!percpu_populate(iucv_irq_data,
-				     sizeof(struct iucv_irq_data),
-				     GFP_KERNEL|GFP_DMA, cpu))
+		iucv_irq_data[cpu] = kmalloc_node(sizeof(struct iucv_irq_data),
+					GFP_KERNEL|GFP_DMA, cpu_to_node(cpu));
+		if (!iucv_irq_data[cpu])
 			return NOTIFY_BAD;
-		if (!percpu_populate(iucv_param, sizeof(union iucv_param),
-				     GFP_KERNEL|GFP_DMA, cpu)) {
-			percpu_depopulate(iucv_irq_data, cpu);
+		iucv_param[cpu] = kmalloc_node(sizeof(union iucv_param),
+				     GFP_KERNEL|GFP_DMA, cpu_to_node(cpu));
+		if (!iucv_param[cpu])
 			return NOTIFY_BAD;
-		}
 		break;
 	case CPU_UP_CANCELED:
 	case CPU_UP_CANCELED_FROZEN:
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
-		percpu_depopulate(iucv_param, cpu);
-		percpu_depopulate(iucv_irq_data, cpu);
+		kfree(iucv_param[cpu]);
+		iucv_param[cpu] = NULL;
+		kfree(iucv_irq_data[cpu]);
+		iucv_irq_data[cpu] = NULL;
 		break;
 	case CPU_ONLINE:
 	case CPU_ONLINE_FROZEN:
@@ -612,7 +613,7 @@ static int iucv_sever_pathid(u16 pathid, u8 userdata[16])
 {
 	union iucv_param *parm;
 
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (userdata)
 		memcpy(parm->ctrl.ipuser, userdata, sizeof(parm->ctrl.ipuser));
@@ -755,7 +756,7 @@ int iucv_path_accept(struct iucv_path *path, struct iucv_handler *handler,
 
 	local_bh_disable();
 	/* Prepare parameter block. */
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->ctrl.ippathid = path->pathid;
 	parm->ctrl.ipmsglim = path->msglim;
@@ -799,7 +800,7 @@ int iucv_path_connect(struct iucv_path *path, struct iucv_handler *handler,
 	BUG_ON(in_atomic());
 	spin_lock_bh(&iucv_table_lock);
 	iucv_cleanup_queue();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->ctrl.ipmsglim = path->msglim;
 	parm->ctrl.ipflags1 = path->flags;
@@ -854,7 +855,7 @@ int iucv_path_quiesce(struct iucv_path *path, u8 userdata[16])
 	int rc;
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (userdata)
 		memcpy(parm->ctrl.ipuser, userdata, sizeof(parm->ctrl.ipuser));
@@ -881,7 +882,7 @@ int iucv_path_resume(struct iucv_path *path, u8 userdata[16])
 	int rc;
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (userdata)
 		memcpy(parm->ctrl.ipuser, userdata, sizeof(parm->ctrl.ipuser));
@@ -936,7 +937,7 @@ int iucv_message_purge(struct iucv_path *path, struct iucv_message *msg,
 	int rc;
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->purge.ippathid = path->pathid;
 	parm->purge.ipmsgid = msg->id;
@@ -1003,7 +1004,7 @@ int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 	}
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->db.ipbfadr1 = (u32)(addr_t) buffer;
 	parm->db.ipbfln1f = (u32) size;
@@ -1040,7 +1041,7 @@ int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg)
 	int rc;
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->db.ippathid = path->pathid;
 	parm->db.ipmsgid = msg->id;
@@ -1074,7 +1075,7 @@ int iucv_message_reply(struct iucv_path *path, struct iucv_message *msg,
 	int rc;
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (flags & IUCV_IPRMDATA) {
 		parm->dpl.ippathid = path->pathid;
@@ -1118,7 +1119,7 @@ int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 	int rc;
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (flags & IUCV_IPRMDATA) {
 		/* Message of 8 bytes can be placed into the parameter list. */
@@ -1172,7 +1173,7 @@ int iucv_message_send2way(struct iucv_path *path, struct iucv_message *msg,
 	int rc;
 
 	local_bh_disable();
-	parm = percpu_ptr(iucv_param, smp_processor_id());
+	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (flags & IUCV_IPRMDATA) {
 		parm->dpl.ippathid = path->pathid;
@@ -1559,7 +1560,7 @@ static void iucv_external_interrupt(u16 code)
 	struct iucv_irq_data *p;
 	struct iucv_irq_list *work;
 
-	p = percpu_ptr(iucv_irq_data, smp_processor_id());
+	p = iucv_irq_data[smp_processor_id()];
 	if (p->ippathid >= iucv_max_pathid) {
 		printk(KERN_WARNING "iucv_do_int: Got interrupt with "
 		       "pathid %d > max_connections (%ld)\n",
@@ -1598,6 +1599,7 @@ static void iucv_external_interrupt(u16 code)
 static int __init iucv_init(void)
 {
 	int rc;
+	int cpu;
 
 	if (!MACHINE_IS_VM) {
 		rc = -EPROTONOSUPPORT;
@@ -1617,19 +1619,23 @@ static int __init iucv_init(void)
 		rc = PTR_ERR(iucv_root);
 		goto out_bus;
 	}
-	/* Note: GFP_DMA used to get memory below 2G */
-	iucv_irq_data = percpu_alloc(sizeof(struct iucv_irq_data),
-				     GFP_KERNEL|GFP_DMA);
-	if (!iucv_irq_data) {
-		rc = -ENOMEM;
-		goto out_root;
-	}
-	/* Allocate parameter blocks. */
-	iucv_param = percpu_alloc(sizeof(union iucv_param),
-				  GFP_KERNEL|GFP_DMA);
-	if (!iucv_param) {
-		rc = -ENOMEM;
-		goto out_extint;
+
+	for_each_online_cpu(cpu) {
+		/* Note: GFP_DMA used to get memory below 2G */
+		iucv_irq_data[cpu] = kmalloc_node(sizeof(struct iucv_irq_data),
+				     GFP_KERNEL|GFP_DMA, cpu_to_node(cpu));
+		if (!iucv_irq_data[cpu]) {
+			rc = -ENOMEM;
+			goto out_free;
+		}
+
+		/* Allocate parameter blocks. */
+		iucv_param[cpu] = kmalloc_node(sizeof(union iucv_param),
+				  GFP_KERNEL|GFP_DMA, cpu_to_node(cpu));
+		if (!iucv_param[cpu]) {
+			rc = -ENOMEM;
+			goto out_free;
+		}
 	}
 	register_hotcpu_notifier(&iucv_cpu_notifier);
 	ASCEBC(iucv_error_no_listener, 16);
@@ -1638,9 +1644,13 @@ static int __init iucv_init(void)
 	iucv_available = 1;
 	return 0;
 
-out_extint:
-	percpu_free(iucv_irq_data);
-out_root:
+out_free:
+	for_each_possible_cpu(cpu) {
+		kfree(iucv_param[cpu]);
+		iucv_param[cpu] = NULL;
+		kfree(iucv_irq_data[cpu]);
+		iucv_irq_data[cpu] = NULL;
+	}
 	s390_root_dev_unregister(iucv_root);
 out_bus:
 	bus_unregister(&iucv_bus);
@@ -1658,6 +1668,7 @@ out:
 static void __exit iucv_exit(void)
 {
 	struct iucv_irq_list *p, *n;
+	int cpu;
 
 	spin_lock_irq(&iucv_queue_lock);
 	list_for_each_entry_safe(p, n, &iucv_task_queue, list)
@@ -1666,8 +1677,12 @@ static void __exit iucv_exit(void)
 		kfree(p);
 	spin_unlock_irq(&iucv_queue_lock);
 	unregister_hotcpu_notifier(&iucv_cpu_notifier);
-	percpu_free(iucv_param);
-	percpu_free(iucv_irq_data);
+	for_each_possible_cpu(cpu) {
+		kfree(iucv_param[cpu]);
+		iucv_param[cpu] = NULL;
+		kfree(iucv_irq_data[cpu]);
+		iucv_irq_data[cpu] = NULL;
+	}
 	s390_root_dev_unregister(iucv_root);
 	bus_unregister(&iucv_bus);
 	unregister_external_interrupt(0x4000, iucv_external_interrupt);
