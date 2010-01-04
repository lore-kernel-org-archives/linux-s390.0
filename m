Return-Path: <linux-kernel-owner+w=401wt.eu-S1753354Ab0ADIZS@vger.kernel.org>
Date: Mon, 4 Jan 2010 09:25:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.33-rc2
Message-ID: <20100104092526.7f294fd6@mschwide.boeblingen.de.ibm.com>
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

it's rather quiet right now, only three new patches for s390.
Please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Jan Glauber (1):
      [S390] qdio: convert global statistics to per-device stats

Martin Schwidefsky (1):
      [S390] Update default configuration.

Robert P. J. Day (1):
      [S390] Have param.h simply include <asm-generic/param.h>.

 arch/s390/defconfig             |   86 ++++++++++++++++++++---
 arch/s390/include/asm/param.h   |   28 +-------
 drivers/s390/cio/Makefile       |    2 +-
 drivers/s390/cio/qdio.h         |   36 +++++++++-
 drivers/s390/cio/qdio_debug.c   |  114 +++++++++++++++++++++++++++--
 drivers/s390/cio/qdio_main.c    |   71 +++++++++----------
 drivers/s390/cio/qdio_perf.c    |  149 ---------------------------------------
 drivers/s390/cio/qdio_perf.h    |   62 ----------------
 drivers/s390/cio/qdio_thinint.c |    8 +--
 9 files changed, 254 insertions(+), 302 deletions(-)
 delete mode 100644 drivers/s390/cio/qdio_perf.c
 delete mode 100644 drivers/s390/cio/qdio_perf.h

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index f4e53c6..b416aa1 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.31
-# Tue Sep 22 17:43:13 2009
+# Linux kernel version: 2.6.33-rc2
+# Mon Jan  4 09:03:07 2010
 #
 CONFIG_SCHED_MC=y
 CONFIG_MMU=y
@@ -51,6 +51,7 @@ CONFIG_AUDIT=y
 #
 CONFIG_TREE_RCU=y
 # CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
 # CONFIG_RCU_TRACE is not set
 CONFIG_RCU_FANOUT=64
 # CONFIG_RCU_FANOUT_EXACT is not set
@@ -113,7 +114,6 @@ CONFIG_HAVE_PERF_EVENTS=y
 # CONFIG_PERF_EVENTS is not set
 # CONFIG_PERF_COUNTERS is not set
 CONFIG_VM_EVENT_COUNTERS=y
-# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
@@ -149,21 +149,78 @@ CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 CONFIG_BLK_DEV_BSG=y
 # CONFIG_BLK_DEV_INTEGRITY is not set
+# CONFIG_BLK_CGROUP is not set
 CONFIG_BLOCK_COMPAT=y
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-# CONFIG_DEFAULT_AS is not set
+# CONFIG_CFQ_GROUP_IOSCHED is not set
 CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="deadline"
 CONFIG_PREEMPT_NOTIFIERS=y
+CONFIG_ARCH_INLINE_SPIN_TRYLOCK=y
+CONFIG_ARCH_INLINE_SPIN_TRYLOCK_BH=y
+CONFIG_ARCH_INLINE_SPIN_LOCK=y
+CONFIG_ARCH_INLINE_SPIN_LOCK_BH=y
+CONFIG_ARCH_INLINE_SPIN_LOCK_IRQ=y
+CONFIG_ARCH_INLINE_SPIN_LOCK_IRQSAVE=y
+CONFIG_ARCH_INLINE_SPIN_UNLOCK=y
+CONFIG_ARCH_INLINE_SPIN_UNLOCK_BH=y
+CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE=y
+CONFIG_ARCH_INLINE_READ_TRYLOCK=y
+CONFIG_ARCH_INLINE_READ_LOCK=y
+CONFIG_ARCH_INLINE_READ_LOCK_BH=y
+CONFIG_ARCH_INLINE_READ_LOCK_IRQ=y
+CONFIG_ARCH_INLINE_READ_LOCK_IRQSAVE=y
+CONFIG_ARCH_INLINE_READ_UNLOCK=y
+CONFIG_ARCH_INLINE_READ_UNLOCK_BH=y
+CONFIG_ARCH_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_ARCH_INLINE_READ_UNLOCK_IRQRESTORE=y
+CONFIG_ARCH_INLINE_WRITE_TRYLOCK=y
+CONFIG_ARCH_INLINE_WRITE_LOCK=y
+CONFIG_ARCH_INLINE_WRITE_LOCK_BH=y
+CONFIG_ARCH_INLINE_WRITE_LOCK_IRQ=y
+CONFIG_ARCH_INLINE_WRITE_LOCK_IRQSAVE=y
+CONFIG_ARCH_INLINE_WRITE_UNLOCK=y
+CONFIG_ARCH_INLINE_WRITE_UNLOCK_BH=y
+CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQ=y
+CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE=y
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_SPIN_UNLOCK is not set
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_READ_UNLOCK is not set
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_WRITE_UNLOCK is not set
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
 CONFIG_FREEZER=y
 
 #
@@ -227,14 +284,13 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_PAGEFLAGS_EXTENDED=y
-CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_SPLIT_PTLOCK_CPUS=999999
 CONFIG_MIGRATION=y
 CONFIG_PHYS_ADDR_T_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 
 #
@@ -339,6 +395,7 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_SIT_6RD is not set
 CONFIG_IPV6_NDISC_NODETYPE=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
@@ -504,6 +561,10 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 CONFIG_BLK_DEV_NBD=m
 # CONFIG_BLK_DEV_OSD is not set
 CONFIG_BLK_DEV_RAM=y
@@ -710,7 +771,6 @@ CONFIG_S390_VMUR=m
 # CONFIG_PPS is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEMSTICK is not set
@@ -864,6 +924,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
@@ -931,7 +992,6 @@ CONFIG_BRANCH_PROFILE_NONE=y
 CONFIG_SAMPLES=y
 # CONFIG_SAMPLE_KOBJECT is not set
 # CONFIG_SAMPLE_KPROBES is not set
-# CONFIG_KMEMCHECK is not set
 
 #
 # Security options
@@ -939,7 +999,11 @@ CONFIG_SAMPLES=y
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITYFS is not set
-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
 CONFIG_CRYPTO=y
 
 #
diff --git a/arch/s390/include/asm/param.h b/arch/s390/include/asm/param.h
index 34aaa46..c616821 100644
--- a/arch/s390/include/asm/param.h
+++ b/arch/s390/include/asm/param.h
@@ -1,30 +1,6 @@
-/*
- *  include/asm-s390/param.h
- *
- *  S390 version
- *
- *  Derived from "include/asm-i386/param.h"
- */
-
 #ifndef _ASMS390_PARAM_H
 #define _ASMS390_PARAM_H
 
-#ifdef __KERNEL__
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
-# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
-#endif
-
-#ifndef HZ
-#define HZ 100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
+#include <asm-generic/param.h>
 
-#endif
+#endif /* _ASMS390_PARAM_H */
diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index d033414..e1b700a 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -10,5 +10,5 @@ obj-y += ccw_device.o cmf.o
 obj-$(CONFIG_CHSC_SCH) += chsc_sch.o
 obj-$(CONFIG_CCWGROUP) += ccwgroup.o
 
-qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_perf.o qdio_setup.o
+qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index ff7748a..44f2f6a 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -182,6 +182,34 @@ struct scssc_area {
 	u32:32;
 } __attribute__ ((packed));
 
+struct qdio_dev_perf_stat {
+	unsigned int adapter_int;
+	unsigned int qdio_int;
+	unsigned int pci_request_int;
+
+	unsigned int tasklet_inbound;
+	unsigned int tasklet_inbound_resched;
+	unsigned int tasklet_inbound_resched2;
+	unsigned int tasklet_outbound;
+
+	unsigned int siga_read;
+	unsigned int siga_write;
+	unsigned int siga_sync;
+
+	unsigned int inbound_call;
+	unsigned int inbound_handler;
+	unsigned int stop_polling;
+	unsigned int inbound_queue_full;
+	unsigned int outbound_call;
+	unsigned int outbound_handler;
+	unsigned int fast_requeue;
+	unsigned int target_full;
+	unsigned int eqbs;
+	unsigned int eqbs_partial;
+	unsigned int sqbs;
+	unsigned int sqbs_partial;
+};
+
 struct qdio_input_q {
 	/* input buffer acknowledgement flag */
 	int polling;
@@ -269,6 +297,7 @@ struct qdio_irq {
 	u32 *dsci;		/* address of device state change indicator */
 	struct ccw_device *cdev;
 	struct dentry *debugfs_dev;
+	struct dentry *debugfs_perf;
 
 	unsigned long int_parm;
 	struct subchannel_id schid;
@@ -286,9 +315,10 @@ struct qdio_irq {
 	struct ciw aqueue;
 
 	struct qdio_ssqd_desc ssqd_desc;
-
 	void (*orig_handler) (struct ccw_device *, unsigned long, struct irb *);
 
+	struct qdio_dev_perf_stat perf_stat;
+	int perf_stat_enabled;
 	/*
 	 * Warning: Leave these members together at the end so they won't be
 	 * cleared in qdio_setup_irq.
@@ -311,6 +341,10 @@ struct qdio_irq {
 	(irq->qib.qfmt == QDIO_IQDIO_QFMT || \
 	 css_general_characteristics.aif_osa)
 
+#define qperf(qdev,attr)	qdev->perf_stat.attr
+#define qperf_inc(q,attr)	if (q->irq_ptr->perf_stat_enabled) \
+					q->irq_ptr->perf_stat.attr++
+
 /* the highest iqdio queue is used for multicast */
 static inline int multicast_outbound(struct qdio_q *q)
 {
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index 7676997..f49761f 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -55,13 +55,11 @@ static int qstat_show(struct seq_file *m, void *v)
 	if (!q)
 		return 0;
 
-	seq_printf(m, "device state indicator: %d\n", *(u32 *)q->irq_ptr->dsci);
-	seq_printf(m, "nr_used: %d\n", atomic_read(&q->nr_buf_used));
-	seq_printf(m, "ftc: %d\n", q->first_to_check);
-	seq_printf(m, "last_move: %d\n", q->last_move);
-	seq_printf(m, "polling: %d\n", q->u.in.polling);
-	seq_printf(m, "ack start: %d\n", q->u.in.ack_start);
-	seq_printf(m, "ack count: %d\n", q->u.in.ack_count);
+	seq_printf(m, "DSCI: %d   nr_used: %d\n",
+		   *(u32 *)q->irq_ptr->dsci, atomic_read(&q->nr_buf_used));
+	seq_printf(m, "ftc: %d  last_move: %d\n", q->first_to_check, q->last_move);
+	seq_printf(m, "polling: %d  ack start: %d  ack count: %d\n",
+		   q->u.in.polling, q->u.in.ack_start, q->u.in.ack_count);
 	seq_printf(m, "slsb buffer states:\n");
 	seq_printf(m, "|0      |8      |16     |24     |32     |40     |48     |56  63|\n");
 
@@ -110,7 +108,6 @@ static ssize_t qstat_seq_write(struct file *file, const char __user *buf,
 
 	if (!q)
 		return 0;
-
 	if (q->is_input_q)
 		xchg(q->irq_ptr->dsci, 1);
 	local_bh_disable();
@@ -134,6 +131,98 @@ static const struct file_operations debugfs_fops = {
 	.release = single_release,
 };
 
+static char *qperf_names[] = {
+	"Assumed adapter interrupts",
+	"QDIO interrupts",
+	"Requested PCIs",
+	"Inbound tasklet runs",
+	"Inbound tasklet resched",
+	"Inbound tasklet resched2",
+	"Outbound tasklet runs",
+	"SIGA read",
+	"SIGA write",
+	"SIGA sync",
+	"Inbound calls",
+	"Inbound handler",
+	"Inbound stop_polling",
+	"Inbound queue full",
+	"Outbound calls",
+	"Outbound handler",
+	"Outbound fast_requeue",
+	"Outbound target_full",
+	"QEBSM eqbs",
+	"QEBSM eqbs partial",
+	"QEBSM sqbs",
+	"QEBSM sqbs partial"
+};
+
+static int qperf_show(struct seq_file *m, void *v)
+{
+	struct qdio_irq *irq_ptr = m->private;
+	unsigned int *stat;
+	int i;
+
+	if (!irq_ptr)
+		return 0;
+	if (!irq_ptr->perf_stat_enabled) {
+		seq_printf(m, "disabled\n");
+		return 0;
+	}
+	stat = (unsigned int *)&irq_ptr->perf_stat;
+
+	for (i = 0; i < ARRAY_SIZE(qperf_names); i++)
+		seq_printf(m, "%26s:\t%u\n",
+			   qperf_names[i], *(stat + i));
+	return 0;
+}
+
+static ssize_t qperf_seq_write(struct file *file, const char __user *ubuf,
+			       size_t count, loff_t *off)
+{
+	struct seq_file *seq = file->private_data;
+	struct qdio_irq *irq_ptr = seq->private;
+	unsigned long val;
+	char buf[8];
+	int ret;
+
+	if (!irq_ptr)
+		return 0;
+	if (count >= sizeof(buf))
+		return -EINVAL;
+	if (copy_from_user(&buf, ubuf, count))
+		return -EFAULT;
+	buf[count] = 0;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	switch (val) {
+	case 0:
+		irq_ptr->perf_stat_enabled = 0;
+		memset(&irq_ptr->perf_stat, 0, sizeof(irq_ptr->perf_stat));
+		break;
+	case 1:
+		irq_ptr->perf_stat_enabled = 1;
+		break;
+	}
+	return count;
+}
+
+static int qperf_seq_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, qperf_show,
+			   filp->f_path.dentry->d_inode->i_private);
+}
+
+static struct file_operations debugfs_perf_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = qperf_seq_open,
+	.read	 = seq_read,
+	.write	 = qperf_seq_write,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
 static void setup_debugfs_entry(struct qdio_q *q, struct ccw_device *cdev)
 {
 	char name[QDIO_DEBUGFS_NAME_LEN];
@@ -156,6 +245,14 @@ void qdio_setup_debug_entries(struct qdio_irq *irq_ptr, struct ccw_device *cdev)
 						  debugfs_root);
 	if (IS_ERR(irq_ptr->debugfs_dev))
 		irq_ptr->debugfs_dev = NULL;
+
+	irq_ptr->debugfs_perf = debugfs_create_file("statistics",
+				S_IFREG | S_IRUGO | S_IWUSR,
+				irq_ptr->debugfs_dev, irq_ptr,
+				&debugfs_perf_fops);
+	if (IS_ERR(irq_ptr->debugfs_perf))
+		irq_ptr->debugfs_perf = NULL;
+
 	for_each_input_queue(irq_ptr, q, i)
 		setup_debugfs_entry(q, cdev);
 	for_each_output_queue(irq_ptr, q, i)
@@ -171,6 +268,7 @@ void qdio_shutdown_debug_entries(struct qdio_irq *irq_ptr, struct ccw_device *cd
 		debugfs_remove(q->debugfs_q);
 	for_each_output_queue(irq_ptr, q, i)
 		debugfs_remove(q->debugfs_q);
+	debugfs_remove(irq_ptr->debugfs_perf);
 	debugfs_remove(irq_ptr->debugfs_dev);
 }
 
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index b2275c5..999fe80 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -22,7 +22,6 @@
 #include "device.h"
 #include "qdio.h"
 #include "qdio_debug.h"
-#include "qdio_perf.h"
 
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>,"\
 	"Jan Glauber <jang@linux.vnet.ibm.com>");
@@ -126,7 +125,7 @@ static int qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 	int rc;
 
 	BUG_ON(!q->irq_ptr->sch_token);
-	qdio_perf_stat_inc(&perf_stats.debug_eqbs_all);
+	qperf_inc(q, eqbs);
 
 	if (!q->is_input_q)
 		nr += q->irq_ptr->nr_input_qs;
@@ -139,7 +138,7 @@ again:
 	 * buffers later.
 	 */
 	if ((ccq == 96) && (count != tmp_count)) {
-		qdio_perf_stat_inc(&perf_stats.debug_eqbs_incomplete);
+		qperf_inc(q, eqbs_partial);
 		return (count - tmp_count);
 	}
 
@@ -182,7 +181,7 @@ static int qdio_do_sqbs(struct qdio_q *q, unsigned char state, int start,
 		return 0;
 
 	BUG_ON(!q->irq_ptr->sch_token);
-	qdio_perf_stat_inc(&perf_stats.debug_sqbs_all);
+	qperf_inc(q, sqbs);
 
 	if (!q->is_input_q)
 		nr += q->irq_ptr->nr_input_qs;
@@ -191,7 +190,7 @@ again:
 	rc = qdio_check_ccq(q, ccq);
 	if (rc == 1) {
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "SQBS again:%2d", ccq);
-		qdio_perf_stat_inc(&perf_stats.debug_sqbs_incomplete);
+		qperf_inc(q, sqbs_partial);
 		goto again;
 	}
 	if (rc < 0) {
@@ -285,7 +284,7 @@ static inline int qdio_siga_sync(struct qdio_q *q, unsigned int output,
 		return 0;
 
 	DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "siga-s:%1d", q->nr);
-	qdio_perf_stat_inc(&perf_stats.siga_sync);
+	qperf_inc(q, siga_sync);
 
 	cc = do_siga_sync(q->irq_ptr->schid, output, input);
 	if (cc)
@@ -350,7 +349,7 @@ static inline int qdio_siga_input(struct qdio_q *q)
 	int cc;
 
 	DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "siga-r:%1d", q->nr);
-	qdio_perf_stat_inc(&perf_stats.siga_in);
+	qperf_inc(q, siga_read);
 
 	cc = do_siga_input(q->irq_ptr->schid, q->mask);
 	if (cc)
@@ -382,7 +381,7 @@ static inline void qdio_stop_polling(struct qdio_q *q)
 		return;
 
 	q->u.in.polling = 0;
-	qdio_perf_stat_inc(&perf_stats.debug_stop_polling);
+	qperf_inc(q, stop_polling);
 
 	/* show the card that we are not polling anymore */
 	if (is_qebsm(q)) {
@@ -400,7 +399,7 @@ static void announce_buffer_error(struct qdio_q *q, int count)
 	/* special handling for no target buffer empty */
 	if ((!q->is_input_q &&
 	    (q->sbal[q->first_to_check]->element[15].flags & 0xff) == 0x10)) {
-		qdio_perf_stat_inc(&perf_stats.outbound_target_full);
+		qperf_inc(q, target_full);
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "OUTFULL FTC:%02x",
 			      q->first_to_check);
 		return;
@@ -487,7 +486,7 @@ static int get_inbound_buffer_frontier(struct qdio_q *q)
 		inbound_primed(q, count);
 		q->first_to_check = add_buf(q->first_to_check, count);
 		if (atomic_sub(count, &q->nr_buf_used) == 0)
-			qdio_perf_stat_inc(&perf_stats.inbound_queue_full);
+			qperf_inc(q, inbound_queue_full);
 		break;
 	case SLSB_P_INPUT_ERROR:
 		announce_buffer_error(q, count);
@@ -567,9 +566,10 @@ static void qdio_kick_handler(struct qdio_q *q)
 	count = sub_buf(end, start);
 
 	if (q->is_input_q) {
-		qdio_perf_stat_inc(&perf_stats.inbound_handler);
+		qperf_inc(q, inbound_handler);
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "kih s:%02x c:%02x", start, count);
 	} else
+		qperf_inc(q, outbound_handler);
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "koh: s:%02x c:%02x",
 			      start, count);
 
@@ -583,24 +583,28 @@ static void qdio_kick_handler(struct qdio_q *q)
 
 static void __qdio_inbound_processing(struct qdio_q *q)
 {
-	qdio_perf_stat_inc(&perf_stats.tasklet_inbound);
+	qperf_inc(q, tasklet_inbound);
 again:
 	if (!qdio_inbound_q_moved(q))
 		return;
 
 	qdio_kick_handler(q);
 
-	if (!qdio_inbound_q_done(q))
+	if (!qdio_inbound_q_done(q)) {
 		/* means poll time is not yet over */
+		qperf_inc(q, tasklet_inbound_resched);
 		goto again;
+	}
 
 	qdio_stop_polling(q);
 	/*
 	 * We need to check again to not lose initiative after
 	 * resetting the ACK state.
 	 */
-	if (!qdio_inbound_q_done(q))
+	if (!qdio_inbound_q_done(q)) {
+		qperf_inc(q, tasklet_inbound_resched2);
 		goto again;
+	}
 }
 
 void qdio_inbound_processing(unsigned long data)
@@ -688,7 +692,7 @@ static int qdio_kick_outbound_q(struct qdio_q *q)
 		return 0;
 
 	DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "siga-w:%1d", q->nr);
-	qdio_perf_stat_inc(&perf_stats.siga_out);
+	qperf_inc(q, siga_write);
 
 	cc = qdio_siga_output(q, &busy_bit);
 	switch (cc) {
@@ -711,7 +715,7 @@ static int qdio_kick_outbound_q(struct qdio_q *q)
 
 static void __qdio_outbound_processing(struct qdio_q *q)
 {
-	qdio_perf_stat_inc(&perf_stats.tasklet_outbound);
+	qperf_inc(q, tasklet_outbound);
 	BUG_ON(atomic_read(&q->nr_buf_used) < 0);
 
 	if (qdio_outbound_q_moved(q))
@@ -739,12 +743,9 @@ static void __qdio_outbound_processing(struct qdio_q *q)
 	 */
 	if (qdio_outbound_q_done(q))
 		del_timer(&q->u.out.timer);
-	else {
-		if (!timer_pending(&q->u.out.timer)) {
+	else
+		if (!timer_pending(&q->u.out.timer))
 			mod_timer(&q->u.out.timer, jiffies + 10 * HZ);
-			qdio_perf_stat_inc(&perf_stats.debug_tl_out_timer);
-		}
-	}
 	return;
 
 sched:
@@ -784,7 +785,7 @@ static inline void qdio_check_outbound_after_thinint(struct qdio_q *q)
 
 static void __tiqdio_inbound_processing(struct qdio_q *q)
 {
-	qdio_perf_stat_inc(&perf_stats.thinint_inbound);
+	qperf_inc(q, tasklet_inbound);
 	qdio_sync_after_thinint(q);
 
 	/*
@@ -799,7 +800,7 @@ static void __tiqdio_inbound_processing(struct qdio_q *q)
 	qdio_kick_handler(q);
 
 	if (!qdio_inbound_q_done(q)) {
-		qdio_perf_stat_inc(&perf_stats.thinint_inbound_loop);
+		qperf_inc(q, tasklet_inbound_resched);
 		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED)) {
 			tasklet_schedule(&q->tasklet);
 			return;
@@ -812,7 +813,7 @@ static void __tiqdio_inbound_processing(struct qdio_q *q)
 	 * resetting the ACK state.
 	 */
 	if (!qdio_inbound_q_done(q)) {
-		qdio_perf_stat_inc(&perf_stats.thinint_inbound_loop2);
+		qperf_inc(q, tasklet_inbound_resched2);
 		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED))
 			tasklet_schedule(&q->tasklet);
 	}
@@ -851,8 +852,6 @@ static void qdio_int_handler_pci(struct qdio_irq *irq_ptr)
 	if (unlikely(irq_ptr->state == QDIO_IRQ_STATE_STOPPED))
 		return;
 
-	qdio_perf_stat_inc(&perf_stats.pci_int);
-
 	for_each_input_queue(irq_ptr, q, i)
 		tasklet_schedule(&q->tasklet);
 
@@ -923,8 +922,6 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
 	int cstat, dstat;
 
-	qdio_perf_stat_inc(&perf_stats.qdio_int);
-
 	if (!intparm || !irq_ptr) {
 		DBF_ERROR("qint:%4x", cdev->private->schid.sch_no);
 		return;
@@ -1383,6 +1380,8 @@ static int handle_inbound(struct qdio_q *q, unsigned int callflags,
 {
 	int used, diff;
 
+	qperf_inc(q, inbound_call);
+
 	if (!q->u.in.polling)
 		goto set;
 
@@ -1438,14 +1437,16 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 	unsigned char state;
 	int used, rc = 0;
 
-	qdio_perf_stat_inc(&perf_stats.outbound_handler);
+	qperf_inc(q, outbound_call);
 
 	count = set_buf_states(q, bufnr, SLSB_CU_OUTPUT_PRIMED, count);
 	used = atomic_add_return(count, &q->nr_buf_used);
 	BUG_ON(used > QDIO_MAX_BUFFERS_PER_Q);
 
-	if (callflags & QDIO_FLAG_PCI_OUT)
+	if (callflags & QDIO_FLAG_PCI_OUT) {
 		q->u.out.pci_out_enabled = 1;
+		qperf_inc(q, pci_request_int);
+	}
 	else
 		q->u.out.pci_out_enabled = 0;
 
@@ -1484,7 +1485,7 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 	if (state != SLSB_CU_OUTPUT_PRIMED)
 		rc = qdio_kick_outbound_q(q);
 	else
-		qdio_perf_stat_inc(&perf_stats.fast_requeue);
+		qperf_inc(q, fast_requeue);
 
 out:
 	tasklet_schedule(&q->tasklet);
@@ -1540,16 +1541,11 @@ static int __init init_QDIO(void)
 	rc = qdio_debug_init();
 	if (rc)
 		goto out_ti;
-	rc = qdio_setup_perf_stats();
-	if (rc)
-		goto out_debug;
 	rc = tiqdio_register_thinints();
 	if (rc)
-		goto out_perf;
+		goto out_debug;
 	return 0;
 
-out_perf:
-	qdio_remove_perf_stats();
 out_debug:
 	qdio_debug_exit();
 out_ti:
@@ -1563,7 +1559,6 @@ static void __exit exit_QDIO(void)
 {
 	tiqdio_unregister_thinints();
 	tiqdio_free_memory();
-	qdio_remove_perf_stats();
 	qdio_debug_exit();
 	qdio_setup_exit();
 }
diff --git a/drivers/s390/cio/qdio_perf.c b/drivers/s390/cio/qdio_perf.c
deleted file mode 100644
index 54f7c32..0000000
--- a/drivers/s390/cio/qdio_perf.c
+++ /dev/null
@@ -1,149 +0,0 @@
-/*
- *  drivers/s390/cio/qdio_perf.c
- *
- *  Copyright IBM Corp. 2008
- *
- *  Author: Jan Glauber (jang@linux.vnet.ibm.com)
- */
-#include <linux/kernel.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <asm/ccwdev.h>
-
-#include "cio.h"
-#include "css.h"
-#include "device.h"
-#include "ioasm.h"
-#include "chsc.h"
-#include "qdio_debug.h"
-#include "qdio_perf.h"
-
-int qdio_performance_stats;
-struct qdio_perf_stats perf_stats;
-
-#ifdef CONFIG_PROC_FS
-static struct proc_dir_entry *qdio_perf_pde;
-#endif
-
-/*
- * procfs functions
- */
-static int qdio_perf_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "Number of qdio interrupts\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.qdio_int));
-	seq_printf(m, "Number of PCI interrupts\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.pci_int));
-	seq_printf(m, "Number of adapter interrupts\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.thin_int));
-	seq_printf(m, "\n");
-	seq_printf(m, "Inbound tasklet runs\t\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.tasklet_inbound));
-	seq_printf(m, "Outbound tasklet runs\t\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.tasklet_outbound));
-	seq_printf(m, "Adapter interrupt tasklet runs/loops\t\t: %li/%li\n",
-		   (long)atomic_long_read(&perf_stats.tasklet_thinint),
-		   (long)atomic_long_read(&perf_stats.tasklet_thinint_loop));
-	seq_printf(m, "Adapter interrupt inbound tasklet runs/loops\t: %li/%li\n",
-		   (long)atomic_long_read(&perf_stats.thinint_inbound),
-		   (long)atomic_long_read(&perf_stats.thinint_inbound_loop));
-	seq_printf(m, "\n");
-	seq_printf(m, "Number of SIGA In issued\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.siga_in));
-	seq_printf(m, "Number of SIGA Out issued\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.siga_out));
-	seq_printf(m, "Number of SIGA Sync issued\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.siga_sync));
-	seq_printf(m, "\n");
-	seq_printf(m, "Number of inbound transfers\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.inbound_handler));
-	seq_printf(m, "Number of outbound transfers\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.outbound_handler));
-	seq_printf(m, "\n");
-	seq_printf(m, "Number of fast requeues (outg. SBAL w/o SIGA)\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.fast_requeue));
-	seq_printf(m, "Number of outbound target full condition\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.outbound_target_full));
-	seq_printf(m, "Number of inbound queue full condition\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.inbound_queue_full));
-	seq_printf(m, "Number of outbound tasklet mod_timer calls\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.debug_tl_out_timer));
-	seq_printf(m, "Number of stop polling calls\t\t\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.debug_stop_polling));
-	seq_printf(m, "AI inbound tasklet loops after stop polling\t: %li\n",
-		   (long)atomic_long_read(&perf_stats.thinint_inbound_loop2));
-	seq_printf(m, "QEBSM EQBS total/incomplete\t\t\t: %li/%li\n",
-		   (long)atomic_long_read(&perf_stats.debug_eqbs_all),
-		   (long)atomic_long_read(&perf_stats.debug_eqbs_incomplete));
-	seq_printf(m, "QEBSM SQBS total/incomplete\t\t\t: %li/%li\n",
-		   (long)atomic_long_read(&perf_stats.debug_sqbs_all),
-		   (long)atomic_long_read(&perf_stats.debug_sqbs_incomplete));
-	seq_printf(m, "\n");
-	return 0;
-}
-static int qdio_perf_seq_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, qdio_perf_proc_show, NULL);
-}
-
-static const struct file_operations qdio_perf_proc_fops = {
-	.owner	 = THIS_MODULE,
-	.open	 = qdio_perf_seq_open,
-	.read	 = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
-
-/*
- * sysfs functions
- */
-static ssize_t qdio_perf_stats_show(struct bus_type *bus, char *buf)
-{
-	return sprintf(buf, "%i\n", qdio_performance_stats ? 1 : 0);
-}
-
-static ssize_t qdio_perf_stats_store(struct bus_type *bus,
-			      const char *buf, size_t count)
-{
-	unsigned long i;
-
-	if (strict_strtoul(buf, 16, &i) != 0)
-		return -EINVAL;
-	if ((i != 0) && (i != 1))
-		return -EINVAL;
-	if (i == qdio_performance_stats)
-		return count;
-
-	qdio_performance_stats = i;
-	/* reset performance statistics */
-	if (i == 0)
-		memset(&perf_stats, 0, sizeof(struct qdio_perf_stats));
-	return count;
-}
-
-static BUS_ATTR(qdio_performance_stats, 0644, qdio_perf_stats_show,
-		qdio_perf_stats_store);
-
-int __init qdio_setup_perf_stats(void)
-{
-	int rc;
-
-	rc = bus_create_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
-	if (rc)
-		return rc;
-
-#ifdef CONFIG_PROC_FS
-	memset(&perf_stats, 0, sizeof(struct qdio_perf_stats));
-	qdio_perf_pde = proc_create("qdio_perf", S_IFREG | S_IRUGO,
-				    NULL, &qdio_perf_proc_fops);
-#endif
-	return 0;
-}
-
-void qdio_remove_perf_stats(void)
-{
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("qdio_perf", NULL);
-#endif
-	bus_remove_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
-}
diff --git a/drivers/s390/cio/qdio_perf.h b/drivers/s390/cio/qdio_perf.h
deleted file mode 100644
index 1245423..0000000
--- a/drivers/s390/cio/qdio_perf.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- *  drivers/s390/cio/qdio_perf.h
- *
- *  Copyright IBM Corp. 2008
- *
- *  Author: Jan Glauber (jang@linux.vnet.ibm.com)
- */
-#ifndef QDIO_PERF_H
-#define QDIO_PERF_H
-
-#include <linux/types.h>
-#include <asm/atomic.h>
-
-struct qdio_perf_stats {
-	/* interrupt handler calls */
-	atomic_long_t qdio_int;
-	atomic_long_t pci_int;
-	atomic_long_t thin_int;
-
-	/* tasklet runs */
-	atomic_long_t tasklet_inbound;
-	atomic_long_t tasklet_outbound;
-	atomic_long_t tasklet_thinint;
-	atomic_long_t tasklet_thinint_loop;
-	atomic_long_t thinint_inbound;
-	atomic_long_t thinint_inbound_loop;
-	atomic_long_t thinint_inbound_loop2;
-
-	/* signal adapter calls */
-	atomic_long_t siga_out;
-	atomic_long_t siga_in;
-	atomic_long_t siga_sync;
-
-	/* misc */
-	atomic_long_t inbound_handler;
-	atomic_long_t outbound_handler;
-	atomic_long_t fast_requeue;
-	atomic_long_t outbound_target_full;
-	atomic_long_t inbound_queue_full;
-
-	/* for debugging */
-	atomic_long_t debug_tl_out_timer;
-	atomic_long_t debug_stop_polling;
-	atomic_long_t debug_eqbs_all;
-	atomic_long_t debug_eqbs_incomplete;
-	atomic_long_t debug_sqbs_all;
-	atomic_long_t debug_sqbs_incomplete;
-};
-
-extern struct qdio_perf_stats perf_stats;
-extern int qdio_performance_stats;
-
-static inline void qdio_perf_stat_inc(atomic_long_t *count)
-{
-	if (qdio_performance_stats)
-		atomic_long_inc(count);
-}
-
-int qdio_setup_perf_stats(void);
-void qdio_remove_perf_stats(void);
-
-#endif
diff --git a/drivers/s390/cio/qdio_thinint.c b/drivers/s390/cio/qdio_thinint.c
index 981a77e..091d904 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -1,9 +1,7 @@
 /*
  * linux/drivers/s390/cio/thinint_qdio.c
  *
- * thin interrupt support for qdio
- *
- * Copyright 2000-2008 IBM Corp.
+ * Copyright 2000,2009 IBM Corp.
  * Author(s): Utz Bacher <utz.bacher@de.ibm.com>
  *	      Cornelia Huck <cornelia.huck@de.ibm.com>
  *	      Jan Glauber <jang@linux.vnet.ibm.com>
@@ -19,7 +17,6 @@
 #include "ioasm.h"
 #include "qdio.h"
 #include "qdio_debug.h"
-#include "qdio_perf.h"
 
 /*
  * Restriction: only 63 iqdio subchannels would have its own indicator,
@@ -132,8 +129,6 @@ static void tiqdio_thinint_handler(void *ind, void *drv_data)
 {
 	struct qdio_q *q;
 
-	qdio_perf_stat_inc(&perf_stats.thin_int);
-
 	/*
 	 * SVS only when needed: issue SVS to benefit from iqdio interrupt
 	 * avoidance (SVS clears adapter interrupt suppression overwrite)
@@ -154,6 +149,7 @@ static void tiqdio_thinint_handler(void *ind, void *drv_data)
 	list_for_each_entry_rcu(q, &tiq_list, entry)
 		/* only process queues from changed sets */
 		if (*q->irq_ptr->dsci) {
+			qperf_inc(q, adapter_int);
 
 			/* only clear it if the indicator is non-shared */
 			if (!shared_ind(q->irq_ptr))
