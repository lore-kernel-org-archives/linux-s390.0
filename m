Return-Path: <linux-kernel-owner+w=401wt.eu-S1753513AbYKNR2f@vger.kernel.org>
Subject: [GIT PULL] s390 patches for 2.6.28-rc4
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 14 Nov 2008 18:27:17 +0100
Message-Id: <1226683637.11775.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Christian Borntraeger (1):
      [S390] kvm_s390: Fix oops in virtio device detection with "mem="

Cornelia Huck (1):
      [S390] cio: Fix refcount after moving devices.

Gerald Schaefer (1):
      [S390] Fix range for add_active_range() in setup_memory()

Heiko Carstens (5):
      [S390] sclp: emit error message if assign storage fails
      [S390] lockdep: fix compile bug
      [S390] ftrace: disable tracing on idle psw
      [S390] ftrace: fix kernel stack backchain walking
      [S390] cpu topology: fix locking

Martin Schwidefsky (1):
      [S390] fix s390x_newuname

Stefan Haberland (1):
      [S390] dasd: log sense for fatal errors

 arch/s390/kernel/entry.S      |   20 +++++++++++++-------
 arch/s390/kernel/entry64.S    |   11 +++++++----
 arch/s390/kernel/process.c    |    3 +++
 arch/s390/kernel/setup.c      |    4 ++--
 arch/s390/kernel/sys_s390.c   |    2 +-
 arch/s390/kernel/topology.c   |   11 +++++++----
 drivers/s390/block/dasd.c     |    5 +++++
 drivers/s390/char/sclp_cmd.c  |    3 +++
 drivers/s390/cio/device.c     |    4 ++++
 drivers/s390/kvm/kvm_virtio.c |    4 ++--
 10 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index ed500ef..08844fc 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -61,22 +61,25 @@ STACK_SIZE  = 1 << STACK_SHIFT
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	.macro	TRACE_IRQS_ON
-	l	%r1,BASED(.Ltrace_irq_on)
+	basr	%r2,%r0
+	l	%r1,BASED(.Ltrace_irq_on_caller)
 	basr	%r14,%r1
 	.endm
 
 	.macro	TRACE_IRQS_OFF
-	l	%r1,BASED(.Ltrace_irq_off)
+	basr	%r2,%r0
+	l	%r1,BASED(.Ltrace_irq_off_caller)
 	basr	%r14,%r1
 	.endm
 
 	.macro	TRACE_IRQS_CHECK
+	basr	%r2,%r0
 	tm	SP_PSW(%r15),0x03	# irqs enabled?
 	jz	0f
-	l	%r1,BASED(.Ltrace_irq_on)
+	l	%r1,BASED(.Ltrace_irq_on_caller)
 	basr	%r14,%r1
 	j	1f
-0:	l	%r1,BASED(.Ltrace_irq_off)
+0:	l	%r1,BASED(.Ltrace_irq_off_caller)
 	basr	%r14,%r1
 1:
 	.endm
@@ -1113,9 +1116,12 @@ cleanup_io_leave_insn:
 .Lschedtail:	.long	schedule_tail
 .Lsysc_table:	.long	sys_call_table
 #ifdef CONFIG_TRACE_IRQFLAGS
-.Ltrace_irq_on: .long	trace_hardirqs_on
-.Ltrace_irq_off:
-		.long	trace_hardirqs_off
+.Ltrace_irq_on_caller:
+		.long	trace_hardirqs_on_caller
+.Ltrace_irq_off_caller:
+		.long	trace_hardirqs_off_caller
+#endif
+#ifdef CONFIG_LOCKDEP
 .Llockdep_sys_exit:
 		.long	lockdep_sys_exit
 #endif
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index d7ce150..41aca06 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -61,19 +61,22 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	.macro	TRACE_IRQS_ON
-	 brasl	%r14,trace_hardirqs_on
+	 basr	%r2,%r0
+	 brasl	%r14,trace_hardirqs_on_caller
 	.endm
 
 	.macro	TRACE_IRQS_OFF
-	 brasl	%r14,trace_hardirqs_off
+	 basr	%r2,%r0
+	 brasl	%r14,trace_hardirqs_off_caller
 	.endm
 
 	.macro TRACE_IRQS_CHECK
+	basr	%r2,%r0
 	tm	SP_PSW(%r15),0x03	# irqs enabled?
 	jz	0f
-	brasl	%r14,trace_hardirqs_on
+	brasl	%r14,trace_hardirqs_on_caller
 	j	1f
-0:	brasl	%r14,trace_hardirqs_off
+0:	brasl	%r14,trace_hardirqs_off_caller
 1:
 	.endm
 #else
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 3e2c05c..04f8c67 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -136,9 +136,12 @@ static void default_idle(void)
 		return;
 	}
 	trace_hardirqs_on();
+	/* Don't trace preempt off for idle. */
+	stop_critical_timings();
 	/* Wait for external, I/O or machine check interrupt. */
 	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
 			PSW_MASK_IO | PSW_MASK_EXT);
+	start_critical_timings();
 }
 
 void cpu_idle(void)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 62122ba..400b040 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -604,13 +604,13 @@ setup_memory(void)
 		if (memory_chunk[i].type != CHUNK_READ_WRITE)
 			continue;
 		start_chunk = PFN_DOWN(memory_chunk[i].addr);
-		end_chunk = start_chunk + PFN_DOWN(memory_chunk[i].size) - 1;
+		end_chunk = start_chunk + PFN_DOWN(memory_chunk[i].size);
 		end_chunk = min(end_chunk, end_pfn);
 		if (start_chunk >= end_chunk)
 			continue;
 		add_active_range(0, start_chunk, end_chunk);
 		pfn = max(start_chunk, start_pfn);
-		for (; pfn <= end_chunk; pfn++)
+		for (; pfn < end_chunk; pfn++)
 			page_set_storage_key(PFN_PHYS(pfn), PAGE_DEFAULT_KEY);
 	}
 
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 5fdb799..4fe952e 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -198,7 +198,7 @@ asmlinkage long s390x_newuname(struct new_utsname __user *name)
 {
 	int ret = sys_newuname(name);
 
-	if (current->personality == PER_LINUX32 && !ret) {
+	if (personality(current->personality) == PER_LINUX32 && !ret) {
 		ret = copy_to_user(name->machine, "s390\0\0\0\0", 8);
 		if (ret) ret = -EFAULT;
 	}
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 632b13e..a947899 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -65,18 +65,21 @@ static int machine_has_topology_irq;
 static struct timer_list topology_timer;
 static void set_topology_timer(void);
 static DECLARE_WORK(topology_work, topology_work_fn);
+/* topology_lock protects the core linked list */
+static DEFINE_SPINLOCK(topology_lock);
 
 cpumask_t cpu_core_map[NR_CPUS];
 
 cpumask_t cpu_coregroup_map(unsigned int cpu)
 {
 	struct core_info *core = &core_info;
+	unsigned long flags;
 	cpumask_t mask;
 
 	cpus_clear(mask);
 	if (!machine_has_topology)
 		return cpu_present_map;
-	mutex_lock(&smp_cpu_state_mutex);
+	spin_lock_irqsave(&topology_lock, flags);
 	while (core) {
 		if (cpu_isset(cpu, core->mask)) {
 			mask = core->mask;
@@ -84,7 +87,7 @@ cpumask_t cpu_coregroup_map(unsigned int cpu)
 		}
 		core = core->next;
 	}
-	mutex_unlock(&smp_cpu_state_mutex);
+	spin_unlock_irqrestore(&topology_lock, flags);
 	if (cpus_empty(mask))
 		mask = cpumask_of_cpu(cpu);
 	return mask;
@@ -133,7 +136,7 @@ static void tl_to_cores(struct tl_info *info)
 	union tl_entry *tle, *end;
 	struct core_info *core = &core_info;
 
-	mutex_lock(&smp_cpu_state_mutex);
+	spin_lock_irq(&topology_lock);
 	clear_cores();
 	tle = info->tle;
 	end = (union tl_entry *)((unsigned long)info + info->length);
@@ -157,7 +160,7 @@ static void tl_to_cores(struct tl_info *info)
 		}
 		tle = next_tle(tle);
 	}
-	mutex_unlock(&smp_cpu_state_mutex);
+	spin_unlock_irq(&topology_lock);
 }
 
 static void topology_update_polarization_simple(void)
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4b76fca..363bd13 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1746,6 +1746,11 @@ restart:
 			goto restart;
 		}
 
+		/* log sense for fatal error */
+		if (cqr->status == DASD_CQR_FAILED) {
+			dasd_log_sense(cqr, &cqr->irb);
+		}
+
 		/* First of all call extended error reporting. */
 		if (dasd_eer_enabled(base) &&
 		    cqr->status == DASD_CQR_FAILED) {
diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index eb5f1b8..ec9c0bc 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -324,6 +324,9 @@ static int do_assign_storage(sclp_cmdw_t cmd, u16 rn)
 	case 0x0120:
 		break;
 	default:
+		pr_warning("assign storage failed (cmd=0x%08x, "
+			   "response=0x%04x, rn=0x%04x)\n", cmd,
+			   sccb->header.response_code, rn);
 		rc = -EIO;
 		break;
 	}
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 4e78c82..4e40083 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -874,11 +874,15 @@ void ccw_device_move_to_orphanage(struct work_struct *work)
 	replacing_cdev = get_disc_ccwdev_by_dev_id(&dev_id, cdev);
 	if (replacing_cdev) {
 		sch_attach_disconnected_device(sch, replacing_cdev);
+		/* Release reference from get_disc_ccwdev_by_dev_id() */
+		put_device(&cdev->dev);
 		return;
 	}
 	replacing_cdev = get_orphaned_ccwdev_by_dev_id(css, &dev_id);
 	if (replacing_cdev) {
 		sch_attach_orphaned_device(sch, replacing_cdev);
+		/* Release reference from get_orphaned_ccwdev_by_dev_id() */
+		put_device(&cdev->dev);
 		return;
 	}
 	sch_create_and_recog_new_device(sch);
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index ff4a693..3d44244 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -322,13 +322,13 @@ static int __init kvm_devices_init(void)
 		return rc;
 	}
 
-	rc = vmem_add_mapping(PFN_PHYS(max_pfn), PAGE_SIZE);
+	rc = vmem_add_mapping(real_memory_size, PAGE_SIZE);
 	if (rc) {
 		s390_root_dev_unregister(kvm_root);
 		return rc;
 	}
 
-	kvm_devices = (void *) PFN_PHYS(max_pfn);
+	kvm_devices = (void *) real_memory_size;
 
 	ctl_set_bit(0, 9);
 	register_external_interrupt(0x2603, kvm_extint_handler);
