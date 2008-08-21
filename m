Return-Path: <linux-kernel-owner+w=401wt.eu-S1760834AbYHUSac@vger.kernel.org>
Subject: [GIT PULL] 2.6.27-rc4 updates for s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Thu, 21 Aug 2008 20:28:10 +0200
Message-Id: <1219343290.10936.31.camel@localhost>
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

In particular the patch from Eric is noteworthy since it gets ext4
working again on s390. The shortlog:

Eric Sandeen (1):
      [S390] fix ext2_find_next_bit

Gerald Schaefer (1):
      [S390] dcssblk: fix race in dcssblk_add_store()

Heiko Carstens (1):
      [S390] Remove unneeded spinlock initialization.

Jan Glauber (3):
      [S390] qdio: prevent oopsing if qdio_establish fails
      [S390] qdio: improve s390 debug feature usage
      [S390] qdio: remove the module_get & module_put pair

Josef 'Jeff' Sipek (1):
      [S390] Fix uninitialized spinlock use

Julien Brunel (1):
      [S390] drivers/s390: Use an IS_ERR test rather than a NULL test

Martin Schwidefsky (1):
      [S390] Update default configuration.

Peter Oberparleiter (2):
      [S390] cio: fix ccw group device cleanup
      [S390] cio: call ccw driver notify function with lock held

Stefan Weinhuber (1):
      [S390] dasd: fix data size for PSF/PRSSD command

 arch/s390/defconfig             |   54 ++++++++++++++++++++--------
 arch/s390/include/asm/bitops.h  |    6 ++--
 arch/s390/kernel/process.c      |    4 ++-
 arch/s390/kernel/smp.c          |    2 -
 drivers/s390/block/dasd.c       |    5 +--
 drivers/s390/block/dasd_eckd.h  |    2 +-
 drivers/s390/block/dasd_eer.c   |    3 +-
 drivers/s390/block/dcssblk.c    |    4 ++
 drivers/s390/char/tape_char.c   |    2 +-
 drivers/s390/char/tape_std.c    |    2 +-
 drivers/s390/cio/ccwgroup.c     |   20 ++++++----
 drivers/s390/cio/css.c          |    1 -
 drivers/s390/cio/device.c       |   40 ++++++++++----------
 drivers/s390/cio/device.h       |    2 +-
 drivers/s390/cio/device_fsm.c   |   31 ++++++++++------
 drivers/s390/cio/qdio_debug.h   |    6 ++--
 drivers/s390/cio/qdio_main.c    |   74 ++++++++++++++++++---------------------
 drivers/s390/cio/qdio_setup.c   |    6 ++--
 drivers/s390/cio/qdio_thinint.c |    6 +++-
 19 files changed, 151 insertions(+), 119 deletions(-)

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index c5cdb97..9b0bc2c 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc4
-# Fri May 30 09:49:33 2008
+# Linux kernel version: 2.6.27-rc4
+# Thu Aug 21 19:43:29 2008
 #
 CONFIG_SCHED_MC=y
 CONFIG_MMU=y
@@ -68,7 +68,6 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
 CONFIG_SYSCTL_SYSCALL=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -93,11 +92,17 @@ CONFIG_SLAB=y
 # CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 CONFIG_KPROBES=y
+# CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set
 CONFIG_KRETPROBES=y
+# CONFIG_HAVE_IOREMAP_PROT is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_ARCH_TRACEHOOK is not set
 # CONFIG_HAVE_DMA_ATTRS is not set
+# CONFIG_USE_GENERIC_SMP_HELPERS is not set
+# CONFIG_HAVE_CLK is not set
 CONFIG_PROC_PAGE_MONITOR=y
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -113,6 +118,7 @@ CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 CONFIG_BLK_DEV_BSG=y
+# CONFIG_BLK_DEV_INTEGRITY is not set
 CONFIG_BLOCK_COMPAT=y
 
 #
@@ -175,6 +181,8 @@ CONFIG_PREEMPT=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_DEFAULT=y
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -185,8 +193,12 @@ CONFIG_HAVE_MEMORY_PRESENT=y
 CONFIG_SPARSEMEM_EXTREME=y
 CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
 CONFIG_SPARSEMEM_VMEMMAP=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTPLUG_SPARSE=y
+CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_MIGRATION=y
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
@@ -198,6 +210,7 @@ CONFIG_VIRT_TO_BUS=y
 CONFIG_MACHCHK_WARNING=y
 CONFIG_QDIO=y
 # CONFIG_QDIO_DEBUG is not set
+CONFIG_CHSC_SCH=m
 
 #
 # Misc
@@ -206,6 +219,7 @@ CONFIG_IPL=y
 # CONFIG_IPL_TAPE is not set
 CONFIG_IPL_VM=y
 CONFIG_BINFMT_ELF=y
+CONFIG_COMPAT_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
 CONFIG_FORCE_MAX_ZONEORDER=9
 # CONFIG_PROCESS_DEBUG is not set
@@ -226,10 +240,6 @@ CONFIG_S390_HYPFS_FS=y
 CONFIG_KEXEC=y
 # CONFIG_ZFCPDUMP is not set
 CONFIG_S390_GUEST=y
-
-#
-# Networking
-#
 CONFIG_NET=y
 
 #
@@ -364,7 +374,6 @@ CONFIG_NET_SCH_CBQ=m
 # CONFIG_NET_SCH_HTB is not set
 # CONFIG_NET_SCH_HFSC is not set
 CONFIG_NET_SCH_PRIO=m
-CONFIG_NET_SCH_RR=m
 CONFIG_NET_SCH_RED=m
 CONFIG_NET_SCH_SFQ=m
 CONFIG_NET_SCH_TEQL=m
@@ -430,7 +439,9 @@ CONFIG_CCW=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 CONFIG_SYS_HYPERVISOR=y
@@ -507,6 +518,11 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
+CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH_RDAC=m
+CONFIG_SCSI_DH_HP_SW=m
+CONFIG_SCSI_DH_EMC=m
+CONFIG_SCSI_DH_ALUA=m
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=m
@@ -522,14 +538,10 @@ CONFIG_DM_CRYPT=y
 CONFIG_DM_SNAPSHOT=y
 CONFIG_DM_MIRROR=y
 CONFIG_DM_ZERO=y
-CONFIG_DM_MULTIPATH=y
-# CONFIG_DM_MULTIPATH_EMC is not set
-# CONFIG_DM_MULTIPATH_RDAC is not set
-# CONFIG_DM_MULTIPATH_HP is not set
+CONFIG_DM_MULTIPATH=m
 # CONFIG_DM_DELAY is not set
 # CONFIG_DM_UEVENT is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_IFB is not set
 CONFIG_DUMMY=m
 CONFIG_BONDING=m
@@ -544,7 +556,6 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NETDEV_1000=y
-# CONFIG_E1000E_ENABLED is not set
 CONFIG_NETDEV_10000=y
 # CONFIG_TR is not set
 # CONFIG_WAN is not set
@@ -576,7 +587,10 @@ CONFIG_DEVKMEM=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_HVC_DRIVER=y
+CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_VIRTIO=m
 # CONFIG_R3964 is not set
 CONFIG_RAW_DRIVER=m
 CONFIG_MAX_RAW_DEVS=256
@@ -616,6 +630,7 @@ CONFIG_MONWRITER=m
 CONFIG_S390_VMUR=m
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 
 #
@@ -693,6 +708,7 @@ CONFIG_CONFIGFS_FS=m
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -712,7 +728,6 @@ CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -780,6 +795,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_WRITECOUNT is not set
+CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_FRAME_POINTER is not set
@@ -789,6 +805,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_LKDTM is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_SAMPLES=y
 # CONFIG_SAMPLE_KOBJECT is not set
 # CONFIG_SAMPLE_KPROBES is not set
@@ -847,6 +864,10 @@ CONFIG_CRYPTO_HMAC=m
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=m
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
+CONFIG_CRYPTO_RMD128=m
+CONFIG_CRYPTO_RMD160=m
+CONFIG_CRYPTO_RMD256=m
+CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
@@ -895,6 +916,7 @@ CONFIG_BITREVERSE=m
 # CONFIG_GENERIC_FIND_NEXT_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+CONFIG_CRC_T10DIF=y
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=m
 CONFIG_CRC7=m
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index b4eb24a..8e9243a 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -709,7 +709,7 @@ static inline int find_next_zero_bit (const unsigned long * addr,
 		 * __ffz_word returns __BITOPS_WORDSIZE
 		 * if no zero bit is present in the word.
 		 */
-		set = __ffz_word(0, *p >> bit) + bit;
+		set = __ffz_word(bit, *p >> bit);
 		if (set >= size)
 			return size + offset;
 		if (set < __BITOPS_WORDSIZE)
@@ -824,7 +824,7 @@ static inline int ext2_find_next_zero_bit(void *vaddr, unsigned long size,
 		 * s390 version of ffz returns __BITOPS_WORDSIZE
 		 * if no zero bit is present in the word.
 		 */
-		set = ffz(__load_ulong_le(p, 0) >> bit) + bit;
+		set = __ffz_word(bit, __load_ulong_le(p, 0) >> bit);
 		if (set >= size)
 			return size + offset;
 		if (set < __BITOPS_WORDSIZE)
@@ -865,7 +865,7 @@ static inline int ext2_find_next_bit(void *vaddr, unsigned long size,
 		 * s390 version of ffz returns __BITOPS_WORDSIZE
 		 * if no zero bit is present in the word.
 		 */
-		set = ffs(__load_ulong_le(p, 0) >> bit) + bit;
+		set = __ffs_word(0, __load_ulong_le(p, 0) & (~0UL << bit));
 		if (set >= size)
 			return size + offset;
 		if (set < __BITOPS_WORDSIZE)
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 9839767..3e2c05c 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -75,7 +75,9 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 	return sf->gprs[8];
 }
 
-DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
+DEFINE_PER_CPU(struct s390_idle_data, s390_idle) = {
+	.lock = __SPIN_LOCK_UNLOCKED(s390_idle.lock)
+};
 
 static int s390_idle_enter(void)
 {
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index b795b3e..00b9b4d 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -610,7 +610,6 @@ static void __init smp_create_idle(unsigned int cpu)
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 	current_set[cpu] = p;
-	spin_lock_init(&(&per_cpu(s390_idle, cpu))->lock);
 }
 
 static int __cpuinit smp_alloc_lowcore(int cpu)
@@ -845,7 +844,6 @@ void __init smp_prepare_boot_cpu(void)
 	current_set[0] = current;
 	smp_cpu_state[0] = CPU_STATE_CONFIGURED;
 	smp_cpu_polarization[0] = POLARIZATION_UNKNWN;
-	spin_lock_init(&(&__get_cpu_var(s390_idle))->lock);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 1b6c52e..acb7801 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2333,13 +2333,11 @@ int dasd_generic_notify(struct ccw_device *cdev, int event)
 {
 	struct dasd_device *device;
 	struct dasd_ccw_req *cqr;
-	unsigned long flags;
 	int ret;
 
-	device = dasd_device_from_cdev(cdev);
+	device = dasd_device_from_cdev_locked(cdev);
 	if (IS_ERR(device))
 		return 0;
-	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	ret = 0;
 	switch (event) {
 	case CIO_GONE:
@@ -2369,7 +2367,6 @@ int dasd_generic_notify(struct ccw_device *cdev, int event)
 		ret = 1;
 		break;
 	}
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	dasd_put_device(device);
 	return ret;
 }
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 4bf0aa5..2476f87 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -308,7 +308,7 @@ struct dasd_psf_prssd_data {
 	unsigned char flags;
 	unsigned char reserved[4];
 	unsigned char suborder;
-	unsigned char varies[9];
+	unsigned char varies[5];
 } __attribute__ ((packed));
 
 /*
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 29da441..bf512ac 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include <linux/mutex.h>
 #include <linux/smp_lock.h>
+#include <linux/err.h>
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
@@ -457,7 +458,7 @@ int dasd_eer_enable(struct dasd_device *device)
 
 	cqr = dasd_kmalloc_request("ECKD", 1 /* SNSS */,
 				   SNSS_DATA_SIZE, device);
-	if (!cqr)
+	if (IS_ERR(cqr))
 		return -ENOMEM;
 
 	cqr->startdev = device;
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 01fcdd9..db85f1f 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -384,6 +384,10 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	 * get minor, add to list
 	 */
 	down_write(&dcssblk_devices_sem);
+	if (dcssblk_get_segment_by_name(local_buf)) {
+		rc = -EEXIST;
+		goto release_gd;
+	}
 	rc = dcssblk_assign_free_minor(dev_info);
 	if (rc) {
 		up_write(&dcssblk_devices_sem);
diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index 687720b..be0ce22 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -109,7 +109,7 @@ tapechar_check_idalbuffer(struct tape_device *device, size_t block_size)
 
 	/* The current idal buffer is not correct. Allocate a new one. */
 	new = idal_buffer_alloc(block_size, 0);
-	if (new == NULL)
+	if (IS_ERR(new))
 		return -ENOMEM;
 
 	if (device->char_data.idal_buf != NULL)
diff --git a/drivers/s390/char/tape_std.c b/drivers/s390/char/tape_std.c
index 2a1af4e..cc8fd78 100644
--- a/drivers/s390/char/tape_std.c
+++ b/drivers/s390/char/tape_std.c
@@ -248,7 +248,7 @@ tape_std_mtsetblk(struct tape_device *device, int count)
 
 	/* Allocate a new idal buffer. */
 	new = idal_buffer_alloc(count, 0);
-	if (new == NULL)
+	if (IS_ERR(new))
 		return -ENOMEM;
 	if (device->char_data.idal_buf != NULL)
 		idal_buffer_free(device->char_data.idal_buf);
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 26a930e..e0ce65f 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -112,8 +112,10 @@ ccwgroup_release (struct device *dev)
 	gdev = to_ccwgroupdev(dev);
 
 	for (i = 0; i < gdev->count; i++) {
-		dev_set_drvdata(&gdev->cdev[i]->dev, NULL);
-		put_device(&gdev->cdev[i]->dev);
+		if (gdev->cdev[i]) {
+			dev_set_drvdata(&gdev->cdev[i]->dev, NULL);
+			put_device(&gdev->cdev[i]->dev);
+		}
 	}
 	kfree(gdev);
 }
@@ -221,6 +223,13 @@ int ccwgroup_create_from_string(struct device *root, unsigned int creator_id,
 	atomic_set(&gdev->onoff, 0);
 	mutex_init(&gdev->reg_mutex);
 	mutex_lock(&gdev->reg_mutex);
+	gdev->creator_id = creator_id;
+	gdev->count = num_devices;
+	gdev->dev.bus = &ccwgroup_bus_type;
+	gdev->dev.parent = root;
+	gdev->dev.release = ccwgroup_release;
+	device_initialize(&gdev->dev);
+
 	curr_buf = buf;
 	for (i = 0; i < num_devices && curr_buf; i++) {
 		rc = __get_next_bus_id(&curr_buf, tmp_bus_id);
@@ -258,16 +267,11 @@ int ccwgroup_create_from_string(struct device *root, unsigned int creator_id,
 		rc = -EINVAL;
 		goto error;
 	}
-	gdev->creator_id = creator_id;
-	gdev->count = num_devices;
-	gdev->dev.bus = &ccwgroup_bus_type;
-	gdev->dev.parent = root;
-	gdev->dev.release = ccwgroup_release;
 
 	snprintf (gdev->dev.bus_id, BUS_ID_SIZE, "%s",
 			gdev->cdev[0]->dev.bus_id);
 
-	rc = device_register(&gdev->dev);
+	rc = device_add(&gdev->dev);
 	if (rc)
 		goto error;
 	get_device(&gdev->dev);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 46c021d..51489ef 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -477,7 +477,6 @@ void css_schedule_eval_all(void)
 
 void css_wait_for_slow_path(void)
 {
-	flush_workqueue(ccw_device_notify_work);
 	flush_workqueue(slow_path_wq);
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index e818d0c..2822103 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -150,7 +150,6 @@ static struct css_driver io_subchannel_driver = {
 };
 
 struct workqueue_struct *ccw_device_work;
-struct workqueue_struct *ccw_device_notify_work;
 wait_queue_head_t ccw_device_init_wq;
 atomic_t ccw_device_init_count;
 
@@ -168,11 +167,6 @@ init_ccw_bus_type (void)
 	ccw_device_work = create_singlethread_workqueue("cio");
 	if (!ccw_device_work)
 		return -ENOMEM; /* FIXME: better errno ? */
-	ccw_device_notify_work = create_singlethread_workqueue("cio_notify");
-	if (!ccw_device_notify_work) {
-		ret = -ENOMEM; /* FIXME: better errno ? */
-		goto out_err;
-	}
 	slow_path_wq = create_singlethread_workqueue("kslowcrw");
 	if (!slow_path_wq) {
 		ret = -ENOMEM; /* FIXME: better errno ? */
@@ -192,8 +186,6 @@ init_ccw_bus_type (void)
 out_err:
 	if (ccw_device_work)
 		destroy_workqueue(ccw_device_work);
-	if (ccw_device_notify_work)
-		destroy_workqueue(ccw_device_notify_work);
 	if (slow_path_wq)
 		destroy_workqueue(slow_path_wq);
 	return ret;
@@ -204,7 +196,6 @@ cleanup_ccw_bus_type (void)
 {
 	css_driver_unregister(&io_subchannel_driver);
 	bus_unregister(&ccw_bus_type);
-	destroy_workqueue(ccw_device_notify_work);
 	destroy_workqueue(ccw_device_work);
 }
 
@@ -1496,11 +1487,22 @@ static void device_set_disconnected(struct ccw_device *cdev)
 		ccw_device_schedule_recovery();
 }
 
+void ccw_device_set_notoper(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+
+	CIO_TRACE_EVENT(2, "notoper");
+	CIO_TRACE_EVENT(2, sch->dev.bus_id);
+	ccw_device_set_timeout(cdev, 0);
+	cio_disable_subchannel(sch);
+	cdev->private->state = DEV_STATE_NOT_OPER;
+}
+
 static int io_subchannel_sch_event(struct subchannel *sch, int slow)
 {
 	int event, ret, disc;
 	unsigned long flags;
-	enum { NONE, UNREGISTER, UNREGISTER_PROBE, REPROBE } action;
+	enum { NONE, UNREGISTER, UNREGISTER_PROBE, REPROBE, DISC } action;
 	struct ccw_device *cdev;
 
 	spin_lock_irqsave(sch->lock, flags);
@@ -1535,16 +1537,11 @@ static int io_subchannel_sch_event(struct subchannel *sch, int slow)
 		}
 		/* fall through */
 	case CIO_GONE:
-		/* Prevent unwanted effects when opening lock. */
-		cio_disable_subchannel(sch);
-		device_set_disconnected(cdev);
 		/* Ask driver what to do with device. */
-		action = UNREGISTER;
-		spin_unlock_irqrestore(sch->lock, flags);
-		ret = io_subchannel_notify(sch, event);
-		spin_lock_irqsave(sch->lock, flags);
-		if (ret)
-			action = NONE;
+		if (io_subchannel_notify(sch, event))
+			action = DISC;
+		else
+			action = UNREGISTER;
 		break;
 	case CIO_REVALIDATE:
 		/* Device will be removed, so no notify necessary. */
@@ -1565,6 +1562,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int slow)
 	switch (action) {
 	case UNREGISTER:
 	case UNREGISTER_PROBE:
+		ccw_device_set_notoper(cdev);
 		/* Unregister device (will use subchannel lock). */
 		spin_unlock_irqrestore(sch->lock, flags);
 		css_sch_device_unregister(sch);
@@ -1577,6 +1575,9 @@ static int io_subchannel_sch_event(struct subchannel *sch, int slow)
 	case REPROBE:
 		ccw_device_trigger_reprobe(cdev);
 		break;
+	case DISC:
+		device_set_disconnected(cdev);
+		break;
 	default:
 		break;
 	}
@@ -1828,5 +1829,4 @@ EXPORT_SYMBOL(ccw_driver_unregister);
 EXPORT_SYMBOL(get_ccwdev_by_busid);
 EXPORT_SYMBOL(ccw_bus_type);
 EXPORT_SYMBOL(ccw_device_work);
-EXPORT_SYMBOL(ccw_device_notify_work);
 EXPORT_SYMBOL_GPL(ccw_device_get_subchannel_id);
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index 9800a83..6f5c3f2 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -72,7 +72,6 @@ dev_fsm_final_state(struct ccw_device *cdev)
 }
 
 extern struct workqueue_struct *ccw_device_work;
-extern struct workqueue_struct *ccw_device_notify_work;
 extern wait_queue_head_t ccw_device_init_wq;
 extern atomic_t ccw_device_init_count;
 
@@ -120,6 +119,7 @@ int ccw_device_stlck(struct ccw_device *);
 void ccw_device_trigger_reprobe(struct ccw_device *);
 void ccw_device_kill_io(struct ccw_device *);
 int ccw_device_notify(struct ccw_device *, int);
+void ccw_device_set_notoper(struct ccw_device *cdev);
 
 /* qdio needs this. */
 void ccw_device_set_timeout(struct ccw_device *, int);
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 8b5fe57..550508d 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -337,26 +337,34 @@ int ccw_device_notify(struct ccw_device *cdev, int event)
 		return 0;
 	if (!cdev->online)
 		return 0;
+	CIO_MSG_EVENT(2, "notify called for 0.%x.%04x, event=%d\n",
+		      cdev->private->dev_id.ssid, cdev->private->dev_id.devno,
+		      event);
 	return cdev->drv->notify ? cdev->drv->notify(cdev, event) : 0;
 }
 
-static void
-ccw_device_oper_notify(struct work_struct *work)
+static void cmf_reenable_delayed(struct work_struct *work)
 {
 	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
-	int ret;
 
 	priv = container_of(work, struct ccw_device_private, kick_work);
 	cdev = priv->cdev;
-	ret = ccw_device_notify(cdev, CIO_OPER);
-	if (ret) {
+	cmf_reenable(cdev);
+}
+
+static void ccw_device_oper_notify(struct ccw_device *cdev)
+{
+	if (ccw_device_notify(cdev, CIO_OPER)) {
 		/* Reenable channel measurements, if needed. */
-		cmf_reenable(cdev);
-		wake_up(&cdev->private->wait_q);
-	} else
-		/* Driver doesn't want device back. */
-		ccw_device_do_unreg_rereg(work);
+		PREPARE_WORK(&cdev->private->kick_work, cmf_reenable_delayed);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+		return;
+	}
+	/* Driver doesn't want device back. */
+	ccw_device_set_notoper(cdev);
+	PREPARE_WORK(&cdev->private->kick_work, ccw_device_do_unreg_rereg);
+	queue_work(ccw_device_work, &cdev->private->kick_work);
 }
 
 /*
@@ -386,8 +394,7 @@ ccw_device_done(struct ccw_device *cdev, int state)
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
-		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify);
-		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
+		ccw_device_oper_notify(cdev);
 	}
 	wake_up(&cdev->private->wait_q);
 
diff --git a/drivers/s390/cio/qdio_debug.h b/drivers/s390/cio/qdio_debug.h
index 8484b83..5a4d85b 100644
--- a/drivers/s390/cio/qdio_debug.h
+++ b/drivers/s390/cio/qdio_debug.h
@@ -61,18 +61,18 @@
 
 /* s390dbf views */
 #define QDIO_DBF_SETUP_LEN		8
-#define QDIO_DBF_SETUP_PAGES		4
+#define QDIO_DBF_SETUP_PAGES		8
 #define QDIO_DBF_SETUP_NR_AREAS		1
 
 #define QDIO_DBF_TRACE_LEN		8
 #define QDIO_DBF_TRACE_NR_AREAS		2
 
 #ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_TRACE_PAGES		16
+#define QDIO_DBF_TRACE_PAGES		32
 #define QDIO_DBF_SETUP_LEVEL		6
 #define QDIO_DBF_TRACE_LEVEL		4
 #else /* !CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_TRACE_PAGES		4
+#define QDIO_DBF_TRACE_PAGES		8
 #define QDIO_DBF_SETUP_LEVEL		2
 #define QDIO_DBF_TRACE_LEVEL		2
 #endif /* CONFIG_QDIO_DEBUG */
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index d156485..e6eabc8 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -330,6 +330,7 @@ static int qdio_siga_output(struct qdio_q *q)
 	int cc;
 	u32 busy_bit;
 	u64 start_time = 0;
+	char dbf_text[15];
 
 	QDIO_DBF_TEXT5(0, trace, "sigaout");
 	QDIO_DBF_HEX5(0, trace, &q, sizeof(void *));
@@ -338,6 +339,9 @@ static int qdio_siga_output(struct qdio_q *q)
 again:
 	cc = qdio_do_siga_output(q, &busy_bit);
 	if (queue_type(q) == QDIO_IQDIO_QFMT && cc == 2 && busy_bit) {
+		sprintf(dbf_text, "bb%4x%2x", q->irq_ptr->schid.sch_no, q->nr);
+		QDIO_DBF_TEXT3(0, trace, dbf_text);
+
 		if (!start_time)
 			start_time = get_usecs();
 		else if ((get_usecs() - start_time) < QDIO_BUSY_BIT_PATIENCE)
@@ -748,16 +752,18 @@ static void qdio_kick_outbound_q(struct qdio_q *q)
 	rc = qdio_siga_output(q);
 	switch (rc) {
 	case 0:
-		/* went smooth this time, reset timestamp */
-		q->u.out.timestamp = 0;
-
 		/* TODO: improve error handling for CC=0 case */
 #ifdef CONFIG_QDIO_DEBUG
-		QDIO_DBF_TEXT3(0, trace, "cc2reslv");
-		sprintf(dbf_text, "%4x%2x%2x", q->irq_ptr->schid.sch_no, q->nr,
-			atomic_read(&q->u.out.busy_siga_counter));
-		QDIO_DBF_TEXT3(0, trace, dbf_text);
+		if (q->u.out.timestamp) {
+			QDIO_DBF_TEXT3(0, trace, "cc2reslv");
+			sprintf(dbf_text, "%4x%2x%2x", q->irq_ptr->schid.sch_no,
+				q->nr,
+				atomic_read(&q->u.out.busy_siga_counter));
+			QDIO_DBF_TEXT3(0, trace, dbf_text);
+		}
 #endif /* CONFIG_QDIO_DEBUG */
+		/* went smooth this time, reset timestamp */
+		q->u.out.timestamp = 0;
 		break;
 	/* cc=2 and busy bit */
 	case (2 | QDIO_ERROR_SIGA_BUSY):
@@ -1066,14 +1072,12 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	if (IS_ERR(irb)) {
 		switch (PTR_ERR(irb)) {
 		case -EIO:
-			sprintf(dbf_text, "ierr%4x",
-				cdev->private->schid.sch_no);
+			sprintf(dbf_text, "ierr%4x", irq_ptr->schid.sch_no);
 			QDIO_DBF_TEXT2(1, setup, dbf_text);
 			qdio_int_error(cdev);
 			return;
 		case -ETIMEDOUT:
-			sprintf(dbf_text, "qtoh%4x",
-				cdev->private->schid.sch_no);
+			sprintf(dbf_text, "qtoh%4x", irq_ptr->schid.sch_no);
 			QDIO_DBF_TEXT2(1, setup, dbf_text);
 			qdio_int_error(cdev);
 			return;
@@ -1124,8 +1128,10 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 struct qdio_ssqd_desc *qdio_get_ssqd_desc(struct ccw_device *cdev)
 {
 	struct qdio_irq *irq_ptr;
+	char dbf_text[15];
 
-	QDIO_DBF_TEXT0(0, setup, "getssqd");
+	sprintf(dbf_text, "qssq%4x", cdev->private->schid.sch_no);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
 
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
@@ -1149,14 +1155,13 @@ int qdio_cleanup(struct ccw_device *cdev, int how)
 	char dbf_text[15];
 	int rc;
 
+	sprintf(dbf_text, "qcln%4x", cdev->private->schid.sch_no);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
 
-	sprintf(dbf_text, "qcln%4x", irq_ptr->schid.sch_no);
-	QDIO_DBF_TEXT1(0, trace, dbf_text);
-	QDIO_DBF_TEXT0(0, setup, dbf_text);
-
 	rc = qdio_shutdown(cdev, how);
 	if (rc == 0)
 		rc = qdio_free(cdev);
@@ -1191,6 +1196,9 @@ int qdio_shutdown(struct ccw_device *cdev, int how)
 	unsigned long flags;
 	char dbf_text[15];
 
+	sprintf(dbf_text, "qshu%4x", cdev->private->schid.sch_no);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
@@ -1205,10 +1213,6 @@ int qdio_shutdown(struct ccw_device *cdev, int how)
 		return 0;
 	}
 
-	sprintf(dbf_text, "qsqs%4x", irq_ptr->schid.sch_no);
-	QDIO_DBF_TEXT1(0, trace, dbf_text);
-	QDIO_DBF_TEXT0(0, setup, dbf_text);
-
 	tiqdio_remove_input_queues(irq_ptr);
 	qdio_shutdown_queues(cdev);
 	qdio_shutdown_debug_entries(irq_ptr, cdev);
@@ -1247,7 +1251,6 @@ no_cleanup:
 
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
 	mutex_unlock(&irq_ptr->setup_mutex);
-	module_put(THIS_MODULE);
 	if (rc)
 		return rc;
 	return 0;
@@ -1263,16 +1266,14 @@ int qdio_free(struct ccw_device *cdev)
 	struct qdio_irq *irq_ptr;
 	char dbf_text[15];
 
+	sprintf(dbf_text, "qfre%4x", cdev->private->schid.sch_no);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
 
 	mutex_lock(&irq_ptr->setup_mutex);
-
-	sprintf(dbf_text, "qfqs%4x", irq_ptr->schid.sch_no);
-	QDIO_DBF_TEXT1(0, trace, dbf_text);
-	QDIO_DBF_TEXT0(0, setup, dbf_text);
-
 	cdev->private->qdio_data = NULL;
 	mutex_unlock(&irq_ptr->setup_mutex);
 
@@ -1295,7 +1296,6 @@ int qdio_initialize(struct qdio_initialize *init_data)
 
 	sprintf(dbf_text, "qini%4x", init_data->cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0, setup, dbf_text);
-	QDIO_DBF_TEXT0(0, trace, dbf_text);
 
 	rc = qdio_allocate(init_data);
 	if (rc)
@@ -1319,7 +1319,6 @@ int qdio_allocate(struct qdio_initialize *init_data)
 
 	sprintf(dbf_text, "qalc%4x", init_data->cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0, setup, dbf_text);
-	QDIO_DBF_TEXT0(0, trace, dbf_text);
 
 	if ((init_data->no_input_qs && !init_data->input_handler) ||
 	    (init_data->no_output_qs && !init_data->output_handler))
@@ -1389,6 +1388,9 @@ int qdio_establish(struct qdio_initialize *init_data)
 	unsigned long saveflags;
 	int rc;
 
+	sprintf(dbf_text, "qest%4x", cdev->private->schid.sch_no);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
@@ -1396,13 +1398,6 @@ int qdio_establish(struct qdio_initialize *init_data)
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 
-	if (!try_module_get(THIS_MODULE))
-		return -EINVAL;
-
-	sprintf(dbf_text, "qest%4x", cdev->private->schid.sch_no);
-	QDIO_DBF_TEXT0(0, setup, dbf_text);
-	QDIO_DBF_TEXT0(0, trace, dbf_text);
-
 	mutex_lock(&irq_ptr->setup_mutex);
 	qdio_setup_irq(init_data);
 
@@ -1472,6 +1467,9 @@ int qdio_activate(struct ccw_device *cdev)
 	unsigned long saveflags;
 	char dbf_text[20];
 
+	sprintf(dbf_text, "qact%4x", cdev->private->schid.sch_no);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
@@ -1485,10 +1483,6 @@ int qdio_activate(struct ccw_device *cdev)
 		goto out;
 	}
 
-	sprintf(dbf_text, "qact%4x", irq_ptr->schid.sch_no);
-	QDIO_DBF_TEXT2(0, setup, dbf_text);
-	QDIO_DBF_TEXT2(0, trace, dbf_text);
-
 	irq_ptr->ccw.cmd_code = irq_ptr->aqueue.cmd;
 	irq_ptr->ccw.flags = CCW_FLAG_SLI;
 	irq_ptr->ccw.count = irq_ptr->aqueue.count;
@@ -1663,7 +1657,7 @@ int do_QDIO(struct ccw_device *cdev, unsigned int callflags,
 #ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[20];
 
-	sprintf(dbf_text, "doQD%04x", cdev->private->schid.sch_no);
+	sprintf(dbf_text, "doQD%4x", cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT3(0, trace, dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
 
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 1bd2a20..1679e2f 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -165,7 +165,7 @@ static void setup_queues(struct qdio_irq *irq_ptr,
 	void **output_sbal_array = qdio_init->output_sbal_addr_array;
 	int i;
 
-	sprintf(dbf_text, "qfqs%4x", qdio_init->cdev->private->schid.sch_no);
+	sprintf(dbf_text, "qset%4x", qdio_init->cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0, setup, dbf_text);
 
 	for_each_input_queue(irq_ptr, q, i) {
@@ -285,7 +285,7 @@ void qdio_setup_ssqd_info(struct qdio_irq *irq_ptr)
 	rc = __get_ssqd_info(irq_ptr);
 	if (rc) {
 		QDIO_DBF_TEXT2(0, setup, "ssqdasig");
-		sprintf(dbf_text, "schno%x", irq_ptr->schid.sch_no);
+		sprintf(dbf_text, "schn%4x", irq_ptr->schid.sch_no);
 		QDIO_DBF_TEXT2(0, setup, dbf_text);
 		sprintf(dbf_text, "rc:%d", rc);
 		QDIO_DBF_TEXT2(0, setup, dbf_text);
@@ -447,7 +447,7 @@ void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
 {
 	char s[80];
 
-	sprintf(s, "%s ", cdev->dev.bus_id);
+	sprintf(s, "%s sc:%x ", cdev->dev.bus_id, irq_ptr->schid.sch_no);
 
 	switch (irq_ptr->qib.qfmt) {
 	case QDIO_QETH_QFMT:
diff --git a/drivers/s390/cio/qdio_thinint.c b/drivers/s390/cio/qdio_thinint.c
index 9291a77..ea7f614 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -113,7 +113,11 @@ void tiqdio_remove_input_queues(struct qdio_irq *irq_ptr)
 	struct qdio_q *q;
 	int i;
 
-	for_each_input_queue(irq_ptr, q, i) {
+	for (i = 0; i < irq_ptr->nr_input_qs; i++) {
+		q = irq_ptr->input_qs[i];
+		/* if establish triggered an error */
+		if (!q || !q->entry.prev || !q->entry.next)
+			continue;
 		list_del_rcu(&q->entry);
 		synchronize_rcu();
 	}
