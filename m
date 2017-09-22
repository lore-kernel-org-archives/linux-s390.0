Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Sep 2017 11:40:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.14-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170922114049.5deab435@mschwideX1>
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

 - A couple of bug fixes: memory management, perf, cio, dasd and scm_blk.

 - A larger change in regard to the CPU topology to improve performance
   for systems running under z/VM or KVM.

The shortlog:

Gerald Schaefer (2):
      s390/mm: make pmdp_invalidate() do invalidation only
      s390/mm: fix write access check in gup_huge_pmd()

Heiko Carstens (2):
      s390/topology: alternative topology for topology-less machines
      s390/topology: enable / disable topology dynamically

Pu Hou (1):
      s390/perf: fix bug when creating per-thread event

Sebastian Ott (2):
      s390/scm_blk: consistently use blk_status_t as error type
      s390/cio: recover from bad paths

Stefan Haberland (1):
      s390/dasd: fix race during dasd initialization

 arch/s390/include/asm/pgtable.h |   4 +-
 arch/s390/kernel/early.c        |  12 ----
 arch/s390/kernel/perf_cpum_sf.c |   9 ++-
 arch/s390/kernel/topology.c     | 148 ++++++++++++++++++++++++++++++++++++----
 arch/s390/mm/gup.c              |   7 +-
 drivers/s390/block/dasd.c       |  12 +++-
 drivers/s390/block/scm_blk.c    |   6 +-
 drivers/s390/cio/device.c       |  12 +++-
 drivers/s390/cio/device.h       |   1 +
 drivers/s390/cio/device_fsm.c   |  12 ++++
 drivers/s390/cio/io_sch.h       |   2 +
 11 files changed, 183 insertions(+), 42 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index dce708e..20e75a2 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1507,7 +1507,9 @@ static inline pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
 static inline void pmdp_invalidate(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmdp)
 {
-	pmdp_xchg_direct(vma->vm_mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_EMPTY));
+	pmd_t pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
+
+	pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
 }
 
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index ca8cd80..60181ca 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -404,18 +404,6 @@ static inline void save_vector_registers(void)
 #endif
 }
 
-static int __init topology_setup(char *str)
-{
-	bool enabled;
-	int rc;
-
-	rc = kstrtobool(str, &enabled);
-	if (!rc && !enabled)
-		S390_lowcore.machine_flags &= ~MACHINE_FLAG_TOPOLOGY;
-	return rc;
-}
-early_param("topology", topology_setup);
-
 static int __init disable_vector_extension(char *str)
 {
 	S390_lowcore.machine_flags &= ~MACHINE_FLAG_VX;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index c1bf75f..7e1e403 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -823,9 +823,12 @@ static int cpumsf_pmu_event_init(struct perf_event *event)
 	}
 
 	/* Check online status of the CPU to which the event is pinned */
-	if ((unsigned int)event->cpu >= nr_cpumask_bits ||
-	    (event->cpu >= 0 && !cpu_online(event->cpu)))
-		return -ENODEV;
+	if (event->cpu >= 0) {
+		if ((unsigned int)event->cpu >= nr_cpumask_bits)
+			return -ENODEV;
+		if (!cpu_online(event->cpu))
+			return -ENODEV;
+	}
 
 	/* Force reset of idle/hv excludes regardless of what the
 	 * user requested.
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index bb47c92..ed0bdd2 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -8,6 +8,8 @@
 
 #include <linux/workqueue.h>
 #include <linux/bootmem.h>
+#include <linux/uaccess.h>
+#include <linux/sysctl.h>
 #include <linux/cpuset.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -29,12 +31,20 @@
 #define PTF_VERTICAL	(1UL)
 #define PTF_CHECK	(2UL)
 
+enum {
+	TOPOLOGY_MODE_HW,
+	TOPOLOGY_MODE_SINGLE,
+	TOPOLOGY_MODE_PACKAGE,
+	TOPOLOGY_MODE_UNINITIALIZED
+};
+
 struct mask_info {
 	struct mask_info *next;
 	unsigned char id;
 	cpumask_t mask;
 };
 
+static int topology_mode = TOPOLOGY_MODE_UNINITIALIZED;
 static void set_topology_timer(void);
 static void topology_work_fn(struct work_struct *work);
 static struct sysinfo_15_1_x *tl_info;
@@ -59,11 +69,26 @@ static cpumask_t cpu_group_map(struct mask_info *info, unsigned int cpu)
 	cpumask_t mask;
 
 	cpumask_copy(&mask, cpumask_of(cpu));
-	if (!MACHINE_HAS_TOPOLOGY)
-		return mask;
-	for (; info; info = info->next) {
-		if (cpumask_test_cpu(cpu, &info->mask))
-			return info->mask;
+	switch (topology_mode) {
+	case TOPOLOGY_MODE_HW:
+		while (info) {
+			if (cpumask_test_cpu(cpu, &info->mask)) {
+				mask = info->mask;
+				break;
+			}
+			info = info->next;
+		}
+		if (cpumask_empty(&mask))
+			cpumask_copy(&mask, cpumask_of(cpu));
+		break;
+	case TOPOLOGY_MODE_PACKAGE:
+		cpumask_copy(&mask, cpu_present_mask);
+		break;
+	default:
+		/* fallthrough */
+	case TOPOLOGY_MODE_SINGLE:
+		cpumask_copy(&mask, cpumask_of(cpu));
+		break;
 	}
 	return mask;
 }
@@ -74,7 +99,7 @@ static cpumask_t cpu_thread_map(unsigned int cpu)
 	int i;
 
 	cpumask_copy(&mask, cpumask_of(cpu));
-	if (!MACHINE_HAS_TOPOLOGY)
+	if (topology_mode != TOPOLOGY_MODE_HW)
 		return mask;
 	cpu -= cpu % (smp_cpu_mtid + 1);
 	for (i = 0; i <= smp_cpu_mtid; i++)
@@ -184,10 +209,8 @@ static void topology_update_polarization_simple(void)
 {
 	int cpu;
 
-	mutex_lock(&smp_cpu_state_mutex);
 	for_each_possible_cpu(cpu)
 		smp_cpu_set_polarization(cpu, POLARIZATION_HRZ);
-	mutex_unlock(&smp_cpu_state_mutex);
 }
 
 static int ptf(unsigned long fc)
@@ -223,7 +246,7 @@ int topology_set_cpu_management(int fc)
 static void update_cpu_masks(void)
 {
 	struct cpu_topology_s390 *topo;
-	int cpu;
+	int cpu, id;
 
 	for_each_possible_cpu(cpu) {
 		topo = &cpu_topology[cpu];
@@ -231,12 +254,13 @@ static void update_cpu_masks(void)
 		topo->core_mask = cpu_group_map(&socket_info, cpu);
 		topo->book_mask = cpu_group_map(&book_info, cpu);
 		topo->drawer_mask = cpu_group_map(&drawer_info, cpu);
-		if (!MACHINE_HAS_TOPOLOGY) {
+		if (topology_mode != TOPOLOGY_MODE_HW) {
+			id = topology_mode == TOPOLOGY_MODE_PACKAGE ? 0 : cpu;
 			topo->thread_id = cpu;
 			topo->core_id = cpu;
-			topo->socket_id = cpu;
-			topo->book_id = cpu;
-			topo->drawer_id = cpu;
+			topo->socket_id = id;
+			topo->book_id = id;
+			topo->drawer_id = id;
 			if (cpu_present(cpu))
 				cpumask_set_cpu(cpu, &cpus_with_topology);
 		}
@@ -254,6 +278,7 @@ static int __arch_update_cpu_topology(void)
 	struct sysinfo_15_1_x *info = tl_info;
 	int rc = 0;
 
+	mutex_lock(&smp_cpu_state_mutex);
 	cpumask_clear(&cpus_with_topology);
 	if (MACHINE_HAS_TOPOLOGY) {
 		rc = 1;
@@ -263,6 +288,7 @@ static int __arch_update_cpu_topology(void)
 	update_cpu_masks();
 	if (!MACHINE_HAS_TOPOLOGY)
 		topology_update_polarization_simple();
+	mutex_unlock(&smp_cpu_state_mutex);
 	return rc;
 }
 
@@ -289,6 +315,11 @@ void topology_schedule_update(void)
 	schedule_work(&topology_work);
 }
 
+static void topology_flush_work(void)
+{
+	flush_work(&topology_work);
+}
+
 static void topology_timer_fn(unsigned long ignored)
 {
 	if (ptf(PTF_CHECK))
@@ -459,6 +490,12 @@ void __init topology_init_early(void)
 	struct sysinfo_15_1_x *info;
 
 	set_sched_topology(s390_topology);
+	if (topology_mode == TOPOLOGY_MODE_UNINITIALIZED) {
+		if (MACHINE_HAS_TOPOLOGY)
+			topology_mode = TOPOLOGY_MODE_HW;
+		else
+			topology_mode = TOPOLOGY_MODE_SINGLE;
+	}
 	if (!MACHINE_HAS_TOPOLOGY)
 		goto out;
 	tl_info = memblock_virt_alloc(PAGE_SIZE, PAGE_SIZE);
@@ -474,12 +511,97 @@ void __init topology_init_early(void)
 	__arch_update_cpu_topology();
 }
 
+static inline int topology_get_mode(int enabled)
+{
+	if (!enabled)
+		return TOPOLOGY_MODE_SINGLE;
+	return MACHINE_HAS_TOPOLOGY ? TOPOLOGY_MODE_HW : TOPOLOGY_MODE_PACKAGE;
+}
+
+static inline int topology_is_enabled(void)
+{
+	return topology_mode != TOPOLOGY_MODE_SINGLE;
+}
+
+static int __init topology_setup(char *str)
+{
+	bool enabled;
+	int rc;
+
+	rc = kstrtobool(str, &enabled);
+	if (rc)
+		return rc;
+	topology_mode = topology_get_mode(enabled);
+	return 0;
+}
+early_param("topology", topology_setup);
+
+static int topology_ctl_handler(struct ctl_table *ctl, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned int len;
+	int new_mode;
+	char buf[2];
+
+	if (!*lenp || *ppos) {
+		*lenp = 0;
+		return 0;
+	}
+	if (!write) {
+		strncpy(buf, topology_is_enabled() ? "1\n" : "0\n",
+			ARRAY_SIZE(buf));
+		len = strnlen(buf, ARRAY_SIZE(buf));
+		if (len > *lenp)
+			len = *lenp;
+		if (copy_to_user(buffer, buf, len))
+			return -EFAULT;
+		goto out;
+	}
+	len = *lenp;
+	if (copy_from_user(buf, buffer, len > sizeof(buf) ? sizeof(buf) : len))
+		return -EFAULT;
+	if (buf[0] != '0' && buf[0] != '1')
+		return -EINVAL;
+	mutex_lock(&smp_cpu_state_mutex);
+	new_mode = topology_get_mode(buf[0] == '1');
+	if (topology_mode != new_mode) {
+		topology_mode = new_mode;
+		topology_schedule_update();
+	}
+	mutex_unlock(&smp_cpu_state_mutex);
+	topology_flush_work();
+out:
+	*lenp = len;
+	*ppos += len;
+	return 0;
+}
+
+static struct ctl_table topology_ctl_table[] = {
+	{
+		.procname	= "topology",
+		.mode		= 0644,
+		.proc_handler	= topology_ctl_handler,
+	},
+	{ },
+};
+
+static struct ctl_table topology_dir_table[] = {
+	{
+		.procname	= "s390",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= topology_ctl_table,
+	},
+	{ },
+};
+
 static int __init topology_init(void)
 {
 	if (MACHINE_HAS_TOPOLOGY)
 		set_topology_timer();
 	else
 		topology_update_polarization_simple();
+	register_sysctl_table(topology_dir_table);
 	return device_create_file(cpu_subsys.dev_root, &dev_attr_dispatching);
 }
 device_initcall(topology_init);
diff --git a/arch/s390/mm/gup.c b/arch/s390/mm/gup.c
index 8ecc25e..98ffe3e 100644
--- a/arch/s390/mm/gup.c
+++ b/arch/s390/mm/gup.c
@@ -56,13 +56,12 @@ static inline int gup_pte_range(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 static inline int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 		unsigned long end, int write, struct page **pages, int *nr)
 {
-	unsigned long mask, result;
 	struct page *head, *page;
+	unsigned long mask;
 	int refs;
 
-	result = write ? 0 : _SEGMENT_ENTRY_PROTECT;
-	mask = result | _SEGMENT_ENTRY_INVALID;
-	if ((pmd_val(pmd) & mask) != result)
+	mask = (write ? _SEGMENT_ENTRY_PROTECT : 0) | _SEGMENT_ENTRY_INVALID;
+	if ((pmd_val(pmd) & mask) != 0)
 		return 0;
 	VM_BUG_ON(!pfn_valid(pmd_val(pmd) >> PAGE_SHIFT));
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ea19b4f..29f35e2 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1644,7 +1644,9 @@ void dasd_generic_handle_state_change(struct dasd_device *device)
 	dasd_schedule_device_bh(device);
 	if (device->block) {
 		dasd_schedule_block_bh(device->block);
-		blk_mq_run_hw_queues(device->block->request_queue, true);
+		if (device->block->request_queue)
+			blk_mq_run_hw_queues(device->block->request_queue,
+					     true);
 	}
 }
 EXPORT_SYMBOL_GPL(dasd_generic_handle_state_change);
@@ -3759,7 +3761,9 @@ int dasd_generic_path_operational(struct dasd_device *device)
 	dasd_schedule_device_bh(device);
 	if (device->block) {
 		dasd_schedule_block_bh(device->block);
-		blk_mq_run_hw_queues(device->block->request_queue, true);
+		if (device->block->request_queue)
+			blk_mq_run_hw_queues(device->block->request_queue,
+					     true);
 		}
 
 	if (!device->stopped)
@@ -4025,7 +4029,9 @@ int dasd_generic_restore_device(struct ccw_device *cdev)
 
 	if (device->block) {
 		dasd_schedule_block_bh(device->block);
-		blk_mq_run_hw_queues(device->block->request_queue, true);
+		if (device->block->request_queue)
+			blk_mq_run_hw_queues(device->block->request_queue,
+					     true);
 	}
 
 	clear_bit(DASD_FLAG_SUSPENDED, &device->flags);
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 2e7fd96..eb51893 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -249,7 +249,7 @@ static void scm_request_requeue(struct scm_request *scmrq)
 static void scm_request_finish(struct scm_request *scmrq)
 {
 	struct scm_blk_dev *bdev = scmrq->bdev;
-	int *error;
+	blk_status_t *error;
 	int i;
 
 	for (i = 0; i < nr_requests_per_io && scmrq->request[i]; i++) {
@@ -415,7 +415,7 @@ void scm_blk_irq(struct scm_device *scmdev, void *data, blk_status_t error)
 
 static void scm_blk_request_done(struct request *req)
 {
-	int *error = blk_mq_rq_to_pdu(req);
+	blk_status_t *error = blk_mq_rq_to_pdu(req);
 
 	blk_mq_end_request(req, *error);
 }
@@ -450,7 +450,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	atomic_set(&bdev->queued_reqs, 0);
 
 	bdev->tag_set.ops = &scm_mq_ops;
-	bdev->tag_set.cmd_size = sizeof(int);
+	bdev->tag_set.cmd_size = sizeof(blk_status_t);
 	bdev->tag_set.nr_hw_queues = nr_requests;
 	bdev->tag_set.queue_depth = nr_requests_per_io * nr_requests;
 	bdev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 489b583..e5c32f4 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1225,10 +1225,16 @@ static int device_is_disconnected(struct ccw_device *cdev)
 static int recovery_check(struct device *dev, void *data)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
+	struct subchannel *sch;
 	int *redo = data;
 
 	spin_lock_irq(cdev->ccwlock);
 	switch (cdev->private->state) {
+	case DEV_STATE_ONLINE:
+		sch = to_subchannel(cdev->dev.parent);
+		if ((sch->schib.pmcw.pam & sch->opm) == sch->vpm)
+			break;
+		/* fall through */
 	case DEV_STATE_DISCONNECTED:
 		CIO_MSG_EVENT(3, "recovery: trigger 0.%x.%04x\n",
 			      cdev->private->dev_id.ssid,
@@ -1260,7 +1266,7 @@ static void recovery_work_func(struct work_struct *unused)
 		}
 		spin_unlock_irq(&recovery_lock);
 	} else
-		CIO_MSG_EVENT(4, "recovery: end\n");
+		CIO_MSG_EVENT(3, "recovery: end\n");
 }
 
 static DECLARE_WORK(recovery_work, recovery_work_func);
@@ -1274,11 +1280,11 @@ static void recovery_func(unsigned long data)
 	schedule_work(&recovery_work);
 }
 
-static void ccw_device_schedule_recovery(void)
+void ccw_device_schedule_recovery(void)
 {
 	unsigned long flags;
 
-	CIO_MSG_EVENT(4, "recovery: schedule\n");
+	CIO_MSG_EVENT(3, "recovery: schedule\n");
 	spin_lock_irqsave(&recovery_lock, flags);
 	if (!timer_pending(&recovery_timer) || (recovery_phase != 0)) {
 		recovery_phase = 0;
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index ec497af..69cb70f 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -134,6 +134,7 @@ void ccw_device_set_disconnected(struct ccw_device *cdev);
 void ccw_device_set_notoper(struct ccw_device *cdev);
 
 void ccw_device_set_timeout(struct ccw_device *, int);
+void ccw_device_schedule_recovery(void);
 
 /* Channel measurement facility related */
 void retry_set_schib(struct ccw_device *cdev);
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 12016e3..f98ea67 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -476,6 +476,17 @@ static void create_fake_irb(struct irb *irb, int type)
 	}
 }
 
+static void ccw_device_handle_broken_paths(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	u8 broken_paths = (sch->schib.pmcw.pam & sch->opm) ^ sch->vpm;
+
+	if (broken_paths && (cdev->private->path_broken_mask != broken_paths))
+		ccw_device_schedule_recovery();
+
+	cdev->private->path_broken_mask = broken_paths;
+}
+
 void ccw_device_verify_done(struct ccw_device *cdev, int err)
 {
 	struct subchannel *sch;
@@ -508,6 +519,7 @@ void ccw_device_verify_done(struct ccw_device *cdev, int err)
 			memset(&cdev->private->irb, 0, sizeof(struct irb));
 		}
 		ccw_device_report_path_events(cdev);
+		ccw_device_handle_broken_paths(cdev);
 		break;
 	case -ETIME:
 	case -EUSERS:
diff --git a/drivers/s390/cio/io_sch.h b/drivers/s390/cio/io_sch.h
index 220f491..9a1b56b 100644
--- a/drivers/s390/cio/io_sch.h
+++ b/drivers/s390/cio/io_sch.h
@@ -131,6 +131,8 @@ struct ccw_device_private {
 				   not operable */
 	u8 path_gone_mask;	/* mask of paths, that became unavailable */
 	u8 path_new_mask;	/* mask of paths, that became available */
+	u8 path_broken_mask;	/* mask of paths, which were found to be
+				   unusable */
 	struct {
 		unsigned int fast:1;	/* post with "channel end" */
 		unsigned int repall:1;	/* report every interrupt status */
