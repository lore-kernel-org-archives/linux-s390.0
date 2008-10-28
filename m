Return-Path: <linux-kernel-owner+w=401wt.eu-S1753808AbYJ1KZx@vger.kernel.org>
Subject: [GIT PULL] s390 patches for 2.6.28-rc2
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Tue, 28 Oct 2008 11:24:25 +0100
Message-Id: <1225189465.5695.1.camel@localhost>
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

Christian Borntraeger (2):
      [S390] pgtables: Fix race in enable_sie vs. page table ops
      [S390] s390: Fix build for !CONFIG_S390_GUEST + CONFIG_VIRTIO_CONSOLE

Frank Munzert (2):
      [S390] tape block: complete request with correct locking
      [S390] tape: disable interrupts in tape_open and tape_release

Heiko Carstens (3):
      [S390] Fix sysdev class file creation.
      [S390] Change default IPL method to IPL_VM.
      [S390] No more 4kb stacks.

Jan Glauber (2):
      [S390] qdio: prevent double qdio shutdown in case of I/O errors
      [S390] qdio: remove incorrect memset

Roel Kluin (1):
      [S390] appldata: unsigned ops->size cannot be negative

 arch/s390/Kconfig                   |   16 +++++++---------
 arch/s390/appldata/appldata_base.c  |    2 +-
 arch/s390/include/asm/kvm_virtio.h  |    2 +-
 arch/s390/include/asm/mmu.h         |    3 ++-
 arch/s390/include/asm/mmu_context.h |   19 ++++++++++++++++---
 arch/s390/include/asm/pgtable.h     |    8 ++++----
 arch/s390/include/asm/thread_info.h |    5 -----
 arch/s390/kernel/smp.c              |   24 +++++++++---------------
 arch/s390/mm/pgtable.c              |   16 ++++++++--------
 drivers/s390/char/tape_block.c      |    6 ++++--
 drivers/s390/char/tape_core.c       |    8 ++++----
 drivers/s390/cio/qdio_debug.c       |   19 ++++++-------------
 drivers/s390/cio/qdio_main.c        |    1 -
 13 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 70b7645..8116a33 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -241,19 +241,17 @@ config PACK_STACK
 	  Say Y if you are unsure.
 
 config SMALL_STACK
-	bool "Use 4kb/8kb for kernel stack instead of 8kb/16kb"
-	depends on PACK_STACK && !LOCKDEP
+	bool "Use 8kb for kernel stack instead of 16kb"
+	depends on PACK_STACK && 64BIT && !LOCKDEP
 	help
 	  If you say Y here and the compiler supports the -mkernel-backchain
-	  option the kernel will use a smaller kernel stack size. For 31 bit
-	  the reduced size is 4kb instead of 8kb and for 64 bit it is 8kb
-	  instead of 16kb. This allows to run more thread on a system and
-	  reduces the pressure on the memory management for higher order
-	  page allocations.
+	  option the kernel will use a smaller kernel stack size. The reduced
+	  size is 8kb instead of 16kb. This allows to run more threads on a
+	  system and reduces the pressure on the memory management for higher
+	  order page allocations.
 
 	  Say N if you are unsure.
 
-
 config CHECK_STACK
 	bool "Detect kernel stack overflow"
 	help
@@ -384,7 +382,7 @@ config IPL
 choice
 	prompt "IPL method generated into head.S"
 	depends on IPL
-	default IPL_TAPE
+	default IPL_VM
 	help
 	  Select "tape" if you want to IPL the image from a Tape.
 
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index a7f8979..a06a47c 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -424,7 +424,7 @@ out:
  */
 int appldata_register_ops(struct appldata_ops *ops)
 {
-	if ((ops->size > APPLDATA_MAX_REC_SIZE) || (ops->size < 0))
+	if (ops->size > APPLDATA_MAX_REC_SIZE)
 		return -EINVAL;
 
 	ops->ctl_table = kzalloc(4 * sizeof(struct ctl_table), GFP_KERNEL);
diff --git a/arch/s390/include/asm/kvm_virtio.h b/arch/s390/include/asm/kvm_virtio.h
index 1461002..c13568b 100644
--- a/arch/s390/include/asm/kvm_virtio.h
+++ b/arch/s390/include/asm/kvm_virtio.h
@@ -52,7 +52,7 @@ struct kvm_vqconfig {
 
 #ifdef __KERNEL__
 /* early virtio console setup */
-#ifdef CONFIG_VIRTIO_CONSOLE
+#ifdef CONFIG_S390_GUEST
 extern void s390_virtio_console_init(void);
 #else
 static inline void s390_virtio_console_init(void)
diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index 5dd5e7b..d2b4ff8 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -7,7 +7,8 @@ typedef struct {
 	unsigned long asce_bits;
 	unsigned long asce_limit;
 	int noexec;
-	int pgstes;
+	int has_pgste;	 /* The mmu context has extended page tables */
+	int alloc_pgste; /* cloned contexts will have extended page tables */
 } mm_context_t;
 
 #endif
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 4c2fbf4..28ec870 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -20,12 +20,25 @@ static inline int init_new_context(struct task_struct *tsk,
 #ifdef CONFIG_64BIT
 	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
 #endif
-	if (current->mm->context.pgstes) {
+	if (current->mm->context.alloc_pgste) {
+		/*
+		 * alloc_pgste indicates, that any NEW context will be created
+		 * with extended page tables. The old context is unchanged. The
+		 * page table allocation and the page table operations will
+		 * look at has_pgste to distinguish normal and extended page
+		 * tables. The only way to create extended page tables is to
+		 * set alloc_pgste and then create a new context (e.g. dup_mm).
+		 * The page table allocation is called after init_new_context
+		 * and if has_pgste is set, it will create extended page
+		 * tables.
+		 */
 		mm->context.noexec = 0;
-		mm->context.pgstes = 1;
+		mm->context.has_pgste = 1;
+		mm->context.alloc_pgste = 1;
 	} else {
 		mm->context.noexec = s390_noexec;
-		mm->context.pgstes = 0;
+		mm->context.has_pgste = 0;
+		mm->context.alloc_pgste = 0;
 	}
 	mm->context.asce_limit = STACK_TOP_MAX;
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1a928f8..7fc7613 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -679,7 +679,7 @@ static inline void pmd_clear(pmd_t *pmd)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	if (mm->context.pgstes)
+	if (mm->context.has_pgste)
 		ptep_rcp_copy(ptep);
 	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
 	if (mm->context.noexec)
@@ -763,7 +763,7 @@ static inline int kvm_s390_test_and_clear_page_dirty(struct mm_struct *mm,
 	struct page *page;
 	unsigned int skey;
 
-	if (!mm->context.pgstes)
+	if (!mm->context.has_pgste)
 		return -EINVAL;
 	rcp_lock(ptep);
 	pgste = (unsigned long *) (ptep + PTRS_PER_PTE);
@@ -794,7 +794,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	int young;
 	unsigned long *pgste;
 
-	if (!vma->vm_mm->context.pgstes)
+	if (!vma->vm_mm->context.has_pgste)
 		return 0;
 	physpage = pte_val(*ptep) & PAGE_MASK;
 	pgste = (unsigned long *) (ptep + PTRS_PER_PTE);
@@ -844,7 +844,7 @@ static inline void __ptep_ipte(unsigned long address, pte_t *ptep)
 static inline void ptep_invalidate(struct mm_struct *mm,
 				   unsigned long address, pte_t *ptep)
 {
-	if (mm->context.pgstes) {
+	if (mm->context.has_pgste) {
 		rcp_lock(ptep);
 		__ptep_ipte(address, ptep);
 		ptep_rcp_copy(ptep);
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index de3fad6..c1eaf96 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -15,13 +15,8 @@
  * Size of kernel stack for each process
  */
 #ifndef __s390x__
-#ifndef __SMALL_STACK
 #define THREAD_ORDER 1
 #define ASYNC_ORDER  1
-#else
-#define THREAD_ORDER 0
-#define ASYNC_ORDER  0
-#endif
 #else /* __s390x__ */
 #ifndef __SMALL_STACK
 #define THREAD_ORDER 2
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 9e8b1f9..b559568 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1119,9 +1119,7 @@ out:
 	return rc;
 }
 
-static ssize_t __ref rescan_store(struct sys_device *dev,
-				  struct sysdev_attribute *attr,
-				  const char *buf,
+static ssize_t __ref rescan_store(struct sysdev_class *class, const char *buf,
 				  size_t count)
 {
 	int rc;
@@ -1129,12 +1127,10 @@ static ssize_t __ref rescan_store(struct sys_device *dev,
 	rc = smp_rescan_cpus();
 	return rc ? rc : count;
 }
-static SYSDEV_ATTR(rescan, 0200, NULL, rescan_store);
+static SYSDEV_CLASS_ATTR(rescan, 0200, NULL, rescan_store);
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static ssize_t dispatching_show(struct sys_device *dev,
-				struct sysdev_attribute *attr,
-				char *buf)
+static ssize_t dispatching_show(struct sysdev_class *class, char *buf)
 {
 	ssize_t count;
 
@@ -1144,9 +1140,8 @@ static ssize_t dispatching_show(struct sys_device *dev,
 	return count;
 }
 
-static ssize_t dispatching_store(struct sys_device *dev,
-				 struct sysdev_attribute *attr,
-				 const char *buf, size_t count)
+static ssize_t dispatching_store(struct sysdev_class *dev, const char *buf,
+				 size_t count)
 {
 	int val, rc;
 	char delim;
@@ -1168,7 +1163,8 @@ out:
 	put_online_cpus();
 	return rc ? rc : count;
 }
-static SYSDEV_ATTR(dispatching, 0644, dispatching_show, dispatching_store);
+static SYSDEV_CLASS_ATTR(dispatching, 0644, dispatching_show,
+			 dispatching_store);
 
 static int __init topology_init(void)
 {
@@ -1178,13 +1174,11 @@ static int __init topology_init(void)
 	register_cpu_notifier(&smp_cpu_nb);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
-			       &attr_rescan.attr);
+	rc = sysdev_class_create_file(&cpu_sysdev_class, &attr_rescan);
 	if (rc)
 		return rc;
 #endif
-	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
-			       &attr_dispatching.attr);
+	rc = sysdev_class_create_file(&cpu_sysdev_class, &attr_dispatching);
 	if (rc)
 		return rc;
 	for_each_present_cpu(cpu) {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 3d98ba8..ef3635b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -169,7 +169,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	unsigned long *table;
 	unsigned long bits;
 
-	bits = (mm->context.noexec || mm->context.pgstes) ? 3UL : 1UL;
+	bits = (mm->context.noexec || mm->context.has_pgste) ? 3UL : 1UL;
 	spin_lock(&mm->page_table_lock);
 	page = NULL;
 	if (!list_empty(&mm->context.pgtable_list)) {
@@ -186,7 +186,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		pgtable_page_ctor(page);
 		page->flags &= ~FRAG_MASK;
 		table = (unsigned long *) page_to_phys(page);
-		if (mm->context.pgstes)
+		if (mm->context.has_pgste)
 			clear_table_pgstes(table);
 		else
 			clear_table(table, _PAGE_TYPE_EMPTY, PAGE_SIZE);
@@ -210,7 +210,7 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	struct page *page;
 	unsigned long bits;
 
-	bits = (mm->context.noexec || mm->context.pgstes) ? 3UL : 1UL;
+	bits = (mm->context.noexec || mm->context.has_pgste) ? 3UL : 1UL;
 	bits <<= (__pa(table) & (PAGE_SIZE - 1)) / 256 / sizeof(unsigned long);
 	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
@@ -257,7 +257,7 @@ int s390_enable_sie(void)
 	struct mm_struct *mm, *old_mm;
 
 	/* Do we have pgstes? if yes, we are done */
-	if (tsk->mm->context.pgstes)
+	if (tsk->mm->context.has_pgste)
 		return 0;
 
 	/* lets check if we are allowed to replace the mm */
@@ -269,14 +269,14 @@ int s390_enable_sie(void)
 	}
 	task_unlock(tsk);
 
-	/* we copy the mm with pgstes enabled */
-	tsk->mm->context.pgstes = 1;
+	/* we copy the mm and let dup_mm create the page tables with_pgstes */
+	tsk->mm->context.alloc_pgste = 1;
 	mm = dup_mm(tsk);
-	tsk->mm->context.pgstes = 0;
+	tsk->mm->context.alloc_pgste = 0;
 	if (!mm)
 		return -ENOMEM;
 
-	/* Now lets check again if somebody attached ptrace etc */
+	/* Now lets check again if something happened */
 	task_lock(tsk);
 	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
 	    tsk->mm != tsk->active_mm || tsk->mm->ioctx_list) {
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index 023803d..ae18baf 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -76,7 +76,7 @@ tapeblock_trigger_requeue(struct tape_device *device)
 static void
 tapeblock_end_request(struct request *req, int error)
 {
-	if (__blk_end_request(req, error, blk_rq_bytes(req)))
+	if (blk_end_request(req, error, blk_rq_bytes(req)))
 		BUG();
 }
 
@@ -166,7 +166,7 @@ tapeblock_requeue(struct work_struct *work) {
 		nr_queued++;
 	spin_unlock(get_ccwdev_lock(device->cdev));
 
-	spin_lock(&device->blk_data.request_queue_lock);
+	spin_lock_irq(&device->blk_data.request_queue_lock);
 	while (
 		!blk_queue_plugged(queue) &&
 		elv_next_request(queue)   &&
@@ -176,7 +176,9 @@ tapeblock_requeue(struct work_struct *work) {
 		if (rq_data_dir(req) == WRITE) {
 			DBF_EVENT(1, "TBLOCK: Rejecting write request\n");
 			blkdev_dequeue_request(req);
+			spin_unlock_irq(&device->blk_data.request_queue_lock);
 			tapeblock_end_request(req, -EIO);
+			spin_lock_irq(&device->blk_data.request_queue_lock);
 			continue;
 		}
 		blkdev_dequeue_request(req);
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index d7073db..f9bb51f 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -1200,7 +1200,7 @@ tape_open(struct tape_device *device)
 {
 	int rc;
 
-	spin_lock(get_ccwdev_lock(device->cdev));
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	if (device->tape_state == TS_NOT_OPER) {
 		DBF_EVENT(6, "TAPE:nodev\n");
 		rc = -ENODEV;
@@ -1218,7 +1218,7 @@ tape_open(struct tape_device *device)
 		tape_state_set(device, TS_IN_USE);
 		rc = 0;
 	}
-	spin_unlock(get_ccwdev_lock(device->cdev));
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	return rc;
 }
 
@@ -1228,11 +1228,11 @@ tape_open(struct tape_device *device)
 int
 tape_release(struct tape_device *device)
 {
-	spin_lock(get_ccwdev_lock(device->cdev));
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	if (device->tape_state == TS_IN_USE)
 		tape_state_set(device, TS_UNUSED);
 	module_put(device->discipline->owner);
-	spin_unlock(get_ccwdev_lock(device->cdev));
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	return 0;
 }
 
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index b539082..f055903 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -20,6 +20,7 @@ static struct dentry *debugfs_root;
 #define MAX_DEBUGFS_QUEUES	32
 static struct dentry *debugfs_queues[MAX_DEBUGFS_QUEUES] = { NULL };
 static DEFINE_MUTEX(debugfs_mutex);
+#define QDIO_DEBUGFS_NAME_LEN	40
 
 void qdio_allocate_do_dbf(struct qdio_initialize *init_data)
 {
@@ -152,17 +153,6 @@ static int qstat_seq_open(struct inode *inode, struct file *filp)
 			   filp->f_path.dentry->d_inode->i_private);
 }
 
-static void get_queue_name(struct qdio_q *q, struct ccw_device *cdev, char *name)
-{
-	memset(name, 0, sizeof(name));
-	sprintf(name, "%s", dev_name(&cdev->dev));
-	if (q->is_input_q)
-		sprintf(name + strlen(name), "_input");
-	else
-		sprintf(name + strlen(name), "_output");
-	sprintf(name + strlen(name), "_%d", q->nr);
-}
-
 static void remove_debugfs_entry(struct qdio_q *q)
 {
 	int i;
@@ -189,14 +179,17 @@ static struct file_operations debugfs_fops = {
 static void setup_debugfs_entry(struct qdio_q *q, struct ccw_device *cdev)
 {
 	int i = 0;
-	char name[40];
+	char name[QDIO_DEBUGFS_NAME_LEN];
 
 	while (debugfs_queues[i] != NULL) {
 		i++;
 		if (i >= MAX_DEBUGFS_QUEUES)
 			return;
 	}
-	get_queue_name(q, cdev, name);
+	snprintf(name, QDIO_DEBUGFS_NAME_LEN, "%s_%s_%d",
+		 dev_name(&cdev->dev),
+		 q->is_input_q ? "input" : "output",
+		 q->nr);
 	debugfs_queues[i] = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
 						debugfs_root, q, &debugfs_fops);
 }
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index a50682d..7c86591 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -1083,7 +1083,6 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		case -EIO:
 			sprintf(dbf_text, "ierr%4x", irq_ptr->schid.sch_no);
 			QDIO_DBF_TEXT2(1, setup, dbf_text);
-			qdio_int_error(cdev);
 			return;
 		case -ETIMEDOUT:
 			sprintf(dbf_text, "qtoh%4x", irq_ptr->schid.sch_no);
