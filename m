Return-Path: <linux-kernel-owner+w=401wt.eu-S1754923AbZDWNpb@vger.kernel.org>
Date: Thu, 23 Apr 2009 15:44:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.30-rc3
Message-ID: <20090423154436.5b0b89d8@skybase>
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

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Frank Munzert (1):
      [S390] Use tape_generic_offline directly.

Gerald Schaefer (1):
      [S390] appldata: avoid deadlock with appldata_mem

Heiko Carstens (2):
      [S390] ipl: fix compile breakage
      [S390] omit frame pointers on s390 when possible

Martin Schwidefsky (2):
      [S390] /proc/stat idle field for idle cpus
      [S390] update default configuration.

 arch/s390/appldata/appldata_base.c |   32 +++++++++---------
 arch/s390/appldata/appldata_mem.c  |    2 +-
 arch/s390/defconfig                |   63 ++++++++++++++++++++++++++++-------
 arch/s390/include/asm/cputime.h    |    4 ++
 arch/s390/kernel/ipl.c             |    1 +
 arch/s390/kernel/vtime.c           |   16 +++++++++
 drivers/s390/char/tape.h           |    2 +-
 drivers/s390/char/tape_34xx.c      |    8 +----
 drivers/s390/char/tape_3590.c      |    8 +----
 drivers/s390/char/tape_core.c      |    5 ++-
 fs/proc/stat.c                     |    5 +++
 lib/Kconfig.debug                  |    8 ++--
 12 files changed, 104 insertions(+), 50 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index aeb3cff..1dfc710 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -98,7 +98,7 @@ static DECLARE_WORK(appldata_work, appldata_work_fn);
 /*
  * Ops list
  */
-static DEFINE_SPINLOCK(appldata_ops_lock);
+static DEFINE_MUTEX(appldata_ops_mutex);
 static LIST_HEAD(appldata_ops_list);
 
 
@@ -129,14 +129,14 @@ static void appldata_work_fn(struct work_struct *work)
 
 	i = 0;
 	get_online_cpus();
-	spin_lock(&appldata_ops_lock);
+	mutex_lock(&appldata_ops_mutex);
 	list_for_each(lh, &appldata_ops_list) {
 		ops = list_entry(lh, struct appldata_ops, list);
 		if (ops->active == 1) {
 			ops->callback(ops->data);
 		}
 	}
-	spin_unlock(&appldata_ops_lock);
+	mutex_unlock(&appldata_ops_mutex);
 	put_online_cpus();
 }
 
@@ -338,7 +338,7 @@ appldata_generic_handler(ctl_table *ctl, int write, struct file *filp,
 	struct list_head *lh;
 
 	found = 0;
-	spin_lock(&appldata_ops_lock);
+	mutex_lock(&appldata_ops_mutex);
 	list_for_each(lh, &appldata_ops_list) {
 		tmp_ops = list_entry(lh, struct appldata_ops, list);
 		if (&tmp_ops->ctl_table[2] == ctl) {
@@ -346,15 +346,15 @@ appldata_generic_handler(ctl_table *ctl, int write, struct file *filp,
 		}
 	}
 	if (!found) {
-		spin_unlock(&appldata_ops_lock);
+		mutex_unlock(&appldata_ops_mutex);
 		return -ENODEV;
 	}
 	ops = ctl->data;
 	if (!try_module_get(ops->owner)) {	// protect this function
-		spin_unlock(&appldata_ops_lock);
+		mutex_unlock(&appldata_ops_mutex);
 		return -ENODEV;
 	}
-	spin_unlock(&appldata_ops_lock);
+	mutex_unlock(&appldata_ops_mutex);
 
 	if (!*lenp || *ppos) {
 		*lenp = 0;
@@ -378,11 +378,11 @@ appldata_generic_handler(ctl_table *ctl, int write, struct file *filp,
 		return -EFAULT;
 	}
 
-	spin_lock(&appldata_ops_lock);
+	mutex_lock(&appldata_ops_mutex);
 	if ((buf[0] == '1') && (ops->active == 0)) {
 		// protect work queue callback
 		if (!try_module_get(ops->owner)) {
-			spin_unlock(&appldata_ops_lock);
+			mutex_unlock(&appldata_ops_mutex);
 			module_put(ops->owner);
 			return -ENODEV;
 		}
@@ -407,7 +407,7 @@ appldata_generic_handler(ctl_table *ctl, int write, struct file *filp,
 			       "failed with rc=%d\n", ops->name, rc);
 		module_put(ops->owner);
 	}
-	spin_unlock(&appldata_ops_lock);
+	mutex_unlock(&appldata_ops_mutex);
 out:
 	*lenp = len;
 	*ppos += len;
@@ -433,9 +433,9 @@ int appldata_register_ops(struct appldata_ops *ops)
 	if (!ops->ctl_table)
 		return -ENOMEM;
 
-	spin_lock(&appldata_ops_lock);
+	mutex_lock(&appldata_ops_mutex);
 	list_add(&ops->list, &appldata_ops_list);
-	spin_unlock(&appldata_ops_lock);
+	mutex_unlock(&appldata_ops_mutex);
 
 	ops->ctl_table[0].procname = appldata_proc_name;
 	ops->ctl_table[0].maxlen   = 0;
@@ -452,9 +452,9 @@ int appldata_register_ops(struct appldata_ops *ops)
 		goto out;
 	return 0;
 out:
-	spin_lock(&appldata_ops_lock);
+	mutex_lock(&appldata_ops_mutex);
 	list_del(&ops->list);
-	spin_unlock(&appldata_ops_lock);
+	mutex_unlock(&appldata_ops_mutex);
 	kfree(ops->ctl_table);
 	return -ENOMEM;
 }
@@ -466,9 +466,9 @@ out:
  */
 void appldata_unregister_ops(struct appldata_ops *ops)
 {
-	spin_lock(&appldata_ops_lock);
+	mutex_lock(&appldata_ops_mutex);
 	list_del(&ops->list);
-	spin_unlock(&appldata_ops_lock);
+	mutex_unlock(&appldata_ops_mutex);
 	unregister_sysctl_table(ops->sysctl_header);
 	kfree(ops->ctl_table);
 }
diff --git a/arch/s390/appldata/appldata_mem.c b/arch/s390/appldata/appldata_mem.c
index 3ed56b7..4188cbe 100644
--- a/arch/s390/appldata/appldata_mem.c
+++ b/arch/s390/appldata/appldata_mem.c
@@ -78,7 +78,7 @@ static void appldata_get_mem_data(void *data)
 {
 	/*
 	 * don't put large structures on the stack, we are
-	 * serialized through the appldata_ops_lock and can use static
+	 * serialized through the appldata_ops_mutex and can use static
 	 */
 	static struct sysinfo val;
 	unsigned long ev[NR_VM_EVENT_ITEMS];
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index 31e809c..d401d56 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc4
-# Wed Feb 11 10:07:16 2009
+# Linux kernel version: 2.6.30-rc3
+# Thu Apr 23 09:29:52 2009
 #
 CONFIG_SCHED_MC=y
 CONFIG_MMU=y
@@ -22,6 +22,7 @@ CONFIG_NO_DMA=y
 CONFIG_GENERIC_LOCKBREAK=y
 CONFIG_PGSTE=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -37,6 +38,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 CONFIG_AUDIT=y
@@ -77,21 +79,24 @@ CONFIG_IPC_NS=y
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 # CONFIG_EMBEDDED is not set
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
@@ -99,10 +104,12 @@ CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 CONFIG_KPROBES=y
 CONFIG_HAVE_SYSCALL_WRAPPERS=y
@@ -111,6 +118,8 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_USE_GENERIC_SMP_HELPERS=y
+CONFIG_HAVE_DEFAULT_NO_SPIN_MUTEXES=y
+# CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -124,7 +133,6 @@ CONFIG_MODVERSIONS=y
 CONFIG_INIT_ALL_POSSIBLE=y
 CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
-# CONFIG_BLK_DEV_IO_TRACE is not set
 CONFIG_BLK_DEV_BSG=y
 # CONFIG_BLK_DEV_INTEGRITY is not set
 CONFIG_BLOCK_COMPAT=y
@@ -211,11 +219,12 @@ CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
 CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
 
 #
 # I/O subsystem configuration
 #
-CONFIG_MACHCHK_WARNING=y
 CONFIG_QDIO=y
 CONFIG_CHSC_SCH=m
 
@@ -247,12 +256,12 @@ CONFIG_S390_HYPFS_FS=y
 CONFIG_KEXEC=y
 # CONFIG_ZFCPDUMP is not set
 CONFIG_S390_GUEST=y
+CONFIG_SECCOMP=y
 CONFIG_NET=y
 
 #
 # Networking options
 #
-CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -374,6 +383,7 @@ CONFIG_SCTP_HMAC_MD5=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
 CONFIG_NET_SCHED=y
 
 #
@@ -438,7 +448,6 @@ CONFIG_CAN_BCM=m
 CONFIG_CAN_VCAN=m
 # CONFIG_CAN_DEBUG_DEVICES is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
@@ -537,6 +546,7 @@ CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_LIBFC is not set
+# CONFIG_LIBFCOE is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_SCSI_DH=m
@@ -544,6 +554,10 @@ CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_HP_SW=m
 CONFIG_SCSI_DH_EMC=m
 CONFIG_SCSI_DH_ALUA=m
+CONFIG_SCSI_OSD_INITIATOR=m
+CONFIG_SCSI_OSD_ULD=m
+CONFIG_SCSI_OSD_DPRINT_SENSE=1
+# CONFIG_SCSI_OSD_DEBUG is not set
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_AUTODETECT=y
@@ -564,6 +578,7 @@ CONFIG_DM_MULTIPATH=m
 # CONFIG_DM_DELAY is not set
 # CONFIG_DM_UEVENT is not set
 CONFIG_NETDEVICES=y
+CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_IFB is not set
 CONFIG_DUMMY=m
 CONFIG_BONDING=m
@@ -667,6 +682,7 @@ CONFIG_S390_VMUR=m
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 CONFIG_ACCESSIBILITY=y
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_STAGING is not set
 
 #
@@ -676,6 +692,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
@@ -701,6 +718,11 @@ CONFIG_INOTIFY_USER=y
 CONFIG_GENERIC_ACL=y
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -744,6 +766,8 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+# CONFIG_EXOFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -758,7 +782,6 @@ CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_REGISTER_V4 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -806,6 +829,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DETECT_HUNG_TASK is not set
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
@@ -830,7 +854,6 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_FRAME_POINTER is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_KPROBES_SANITY_TEST is not set
@@ -840,7 +863,9 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_DEBUG_PAGEALLOC is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_TRACING_SUPPORT=y
 
 #
 # Tracers
@@ -850,14 +875,17 @@ CONFIG_HAVE_FUNCTION_TRACER=y
 # CONFIG_PREEMPT_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_EVENT_TRACER is not set
 # CONFIG_BOOT_TRACER is not set
 # CONFIG_TRACE_BRANCH_PROFILING is not set
 # CONFIG_STACK_TRACER is not set
-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
 CONFIG_SAMPLES=y
 # CONFIG_SAMPLE_KOBJECT is not set
 # CONFIG_SAMPLE_KPROBES is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
 
 #
 # Security options
@@ -882,10 +910,12 @@ CONFIG_CRYPTO_HASH=m
 CONFIG_CRYPTO_HASH2=y
 CONFIG_CRYPTO_RNG=m
 CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_GF128MUL=m
 # CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
 # CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_AUTHENC=m
 # CONFIG_CRYPTO_TEST is not set
@@ -954,6 +984,7 @@ CONFIG_CRYPTO_SEED=m
 # Compression
 #
 # CONFIG_CRYPTO_DEFLATE is not set
+CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
 
 #
@@ -969,6 +1000,7 @@ CONFIG_CRYPTO_SHA512_S390=m
 # CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_AES_S390 is not set
 CONFIG_S390_PRNG=m
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
@@ -982,9 +1014,14 @@ CONFIG_CRC_T10DIF=y
 CONFIG_CRC32=m
 CONFIG_CRC7=m
 CONFIG_LIBCRC32C=m
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=m
 CONFIG_LZO_COMPRESS=m
 CONFIG_LZO_DECOMPRESS=m
-CONFIG_PLIST=y
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_DECOMPRESS_BZIP2=y
+CONFIG_DECOMPRESS_LZMA=y
+CONFIG_NLATTR=y
 CONFIG_HAVE_KVM=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index 95b0f7d..941384f 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -174,4 +174,8 @@ cputime64_to_clock_t(cputime64_t cputime)
        return __div(cputime, 4096000000ULL / USER_HZ);
 }
 
+cputime64_t s390_get_idle_time(int cpu);
+
+#define arch_idle_time(cpu) s390_get_idle_time(cpu)
+
 #endif /* _S390_CPUTIME_H */
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 6f3711a..b8bf4b1 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -23,6 +23,7 @@
 #include <asm/ebcdic.h>
 #include <asm/reset.h>
 #include <asm/sclp.h>
+#include <asm/sigp.h>
 #include <asm/checksum.h>
 
 #define IPL_PARM_BLOCK_VERSION 0
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 38ea92f..c87f59b 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -240,6 +240,22 @@ void vtime_stop_cpu(void)
 	}
 }
 
+cputime64_t s390_get_idle_time(int cpu)
+{
+	struct s390_idle_data *idle;
+	unsigned long long now, idle_time, idle_enter;
+
+	idle = &per_cpu(s390_idle, cpu);
+	spin_lock(&idle->lock);
+	now = get_clock();
+	idle_time = 0;
+	idle_enter = idle->idle_enter;
+	if (idle_enter != 0ULL && idle_enter < now)
+		idle_time = now - idle_enter;
+	spin_unlock(&idle->lock);
+	return idle_time;
+}
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/drivers/s390/char/tape.h b/drivers/s390/char/tape.h
index c07809c..5469e09 100644
--- a/drivers/s390/char/tape.h
+++ b/drivers/s390/char/tape.h
@@ -285,7 +285,7 @@ extern int tape_mtop(struct tape_device *, int, int);
 extern void tape_state_set(struct tape_device *, enum tape_state);
 
 extern int tape_generic_online(struct tape_device *, struct tape_discipline *);
-extern int tape_generic_offline(struct tape_device *device);
+extern int tape_generic_offline(struct ccw_device *);
 
 /* Externals from tape_devmap.c */
 extern int tape_generic_probe(struct ccw_device *);
diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 807ded5..5f8e8ef 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -1294,12 +1294,6 @@ tape_34xx_online(struct ccw_device *cdev)
 	);
 }
 
-static int
-tape_34xx_offline(struct ccw_device *cdev)
-{
-	return tape_generic_offline(cdev->dev.driver_data);
-}
-
 static struct ccw_driver tape_34xx_driver = {
 	.name = "tape_34xx",
 	.owner = THIS_MODULE,
@@ -1307,7 +1301,7 @@ static struct ccw_driver tape_34xx_driver = {
 	.probe = tape_generic_probe,
 	.remove = tape_generic_remove,
 	.set_online = tape_34xx_online,
-	.set_offline = tape_34xx_offline,
+	.set_offline = tape_generic_offline,
 };
 
 static int
diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index fc1d912..823b05b 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1707,19 +1707,13 @@ tape_3590_online(struct ccw_device *cdev)
 				   &tape_discipline_3590);
 }
 
-static int
-tape_3590_offline(struct ccw_device *cdev)
-{
-	return tape_generic_offline(cdev->dev.driver_data);
-}
-
 static struct ccw_driver tape_3590_driver = {
 	.name = "tape_3590",
 	.owner = THIS_MODULE,
 	.ids = tape_3590_ids,
 	.probe = tape_generic_probe,
 	.remove = tape_generic_remove,
-	.set_offline = tape_3590_offline,
+	.set_offline = tape_generic_offline,
 	.set_online = tape_3590_online,
 };
 
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 08c09d3..8a109f3 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -387,8 +387,11 @@ tape_cleanup_device(struct tape_device *device)
  * Manual offline is only allowed while the drive is not in use.
  */
 int
-tape_generic_offline(struct tape_device *device)
+tape_generic_offline(struct ccw_device *cdev)
 {
+	struct tape_device *device;
+
+	device = cdev->dev.driver_data;
 	if (!device) {
 		return -ENODEV;
 	}
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index f75efa2..81e4eb6 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -18,6 +18,9 @@
 #ifndef arch_irq_stat
 #define arch_irq_stat() 0
 #endif
+#ifndef arch_idle_time
+#define arch_idle_time(cpu) 0
+#endif
 
 static int show_stat(struct seq_file *p, void *v)
 {
@@ -40,6 +43,7 @@ static int show_stat(struct seq_file *p, void *v)
 		nice = cputime64_add(nice, kstat_cpu(i).cpustat.nice);
 		system = cputime64_add(system, kstat_cpu(i).cpustat.system);
 		idle = cputime64_add(idle, kstat_cpu(i).cpustat.idle);
+		idle = cputime64_add(idle, arch_idle_time(i));
 		iowait = cputime64_add(iowait, kstat_cpu(i).cpustat.iowait);
 		irq = cputime64_add(irq, kstat_cpu(i).cpustat.irq);
 		softirq = cputime64_add(softirq, kstat_cpu(i).cpustat.softirq);
@@ -69,6 +73,7 @@ static int show_stat(struct seq_file *p, void *v)
 		nice = kstat_cpu(i).cpustat.nice;
 		system = kstat_cpu(i).cpustat.system;
 		idle = kstat_cpu(i).cpustat.idle;
+		idle = cputime64_add(idle, arch_idle_time(i));
 		iowait = kstat_cpu(i).cpustat.iowait;
 		irq = kstat_cpu(i).cpustat.irq;
 		softirq = kstat_cpu(i).cpustat.softirq;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c6e854f..812c282 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -440,7 +440,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !X86 && !MIPS && !PPC && !ARM_UNWIND
+	select FRAME_POINTER if !X86 && !MIPS && !PPC && !ARM_UNWIND && !S390
 	select KALLSYMS
 	select KALLSYMS_ALL
 
@@ -620,7 +620,7 @@ config ARCH_WANT_FRAME_POINTERS
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && \
-		(CRIS || M68K || M68KNOMMU || FRV || UML || S390 || \
+		(CRIS || M68K || M68KNOMMU || FRV || UML || \
 		 AVR32 || SUPERH || BLACKFIN || MN10300) || \
 		ARCH_WANT_FRAME_POINTERS
 	default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
@@ -809,13 +809,13 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !PPC
+	select FRAME_POINTER if !PPC && !S390
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
 config LATENCYTOP
 	bool "Latency measuring infrastructure"
-	select FRAME_POINTER if !MIPS && !PPC
+	select FRAME_POINTER if !MIPS && !PPC && !S390
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
