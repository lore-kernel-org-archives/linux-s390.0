Return-Path: <linux-kernel-owner+w=401wt.eu-S1756101AbZBKJmr@vger.kernel.org>
Subject: [GIT PULL] s390 updates for 2.6.29-rc4
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Wed, 11 Feb 2009 10:42:27 +0100
Message-Id: <1234345347.19362.1.camel@localhost>
Mime-Version: 1.0
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

Cornelia Huck (1):
      [S390] dasd: bus_id -> dev_name() conversion.

Martin Schwidefsky (2):
      [S390] vdso: fix per cpu vdso pointer in lowcore
      [S390] Update default configuration.

Sachin Sant (1):
      [S390] Fix init irq proc build break.

Stefan Weinhuber (1):
      [S390] dasd: fix race in dasd timer handling

 arch/s390/defconfig              |   87 ++++++++++++++++++++++++++------------
 arch/s390/include/asm/lowcore.h  |    4 +-
 arch/s390/kernel/irq.c           |    2 +
 drivers/s390/block/dasd.c        |   46 +++++++-------------
 drivers/s390/block/dasd_devmap.c |    2 +-
 5 files changed, 81 insertions(+), 60 deletions(-)

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index a0e748d..31e809c 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.28-rc6
-# Thu Nov 27 11:00:49 2008
+# Linux kernel version: 2.6.29-rc4
+# Wed Feb 11 10:07:16 2009
 #
 CONFIG_SCHED_MC=y
 CONFIG_MMU=y
@@ -14,12 +14,14 @@ CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_BUG=y
 CONFIG_NO_IOMEM=y
 CONFIG_NO_DMA=y
 CONFIG_GENERIC_LOCKBREAK=y
 CONFIG_PGSTE=y
+CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -39,20 +41,29 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_TASKSTATS is not set
 CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
 CONFIG_CGROUPS=y
 # CONFIG_CGROUP_DEBUG is not set
 CONFIG_CGROUP_NS=y
 # CONFIG_CGROUP_FREEZER is not set
 # CONFIG_CGROUP_DEVICE is not set
 # CONFIG_CPUSETS is not set
-CONFIG_GROUP_SCHED=y
-CONFIG_FAIR_GROUP_SCHED=y
-# CONFIG_RT_GROUP_SCHED is not set
-CONFIG_USER_SCHED=y
-# CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUP_CPUACCT is not set
 # CONFIG_RESOURCE_COUNTERS is not set
 CONFIG_SYSFS_DEPRECATED=y
@@ -63,6 +74,7 @@ CONFIG_UTS_NS=y
 CONFIG_IPC_NS=y
 # CONFIG_USER_NS is not set
 # CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -91,17 +103,17 @@ CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 CONFIG_KPROBES=y
+CONFIG_HAVE_SYSCALL_WRAPPERS=y
 CONFIG_KRETPROBES=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_USE_GENERIC_SMP_HELPERS=y
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 # CONFIG_MODULE_FORCE_LOAD is not set
@@ -109,7 +121,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_MODVERSIONS=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
-CONFIG_KMOD=y
+CONFIG_INIT_ALL_POSSIBLE=y
 CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -130,7 +142,6 @@ CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="deadline"
 CONFIG_PREEMPT_NOTIFIERS=y
-CONFIG_CLASSIC_RCU=y
 # CONFIG_FREEZER is not set
 
 #
@@ -161,6 +172,7 @@ CONFIG_S390_EXEC_PROTECT=y
 CONFIG_MARCH_Z900=y
 # CONFIG_MARCH_Z990 is not set
 # CONFIG_MARCH_Z9_109 is not set
+# CONFIG_MARCH_Z10 is not set
 CONFIG_PACK_STACK=y
 # CONFIG_SMALL_STACK is not set
 CONFIG_CHECK_STACK=y
@@ -174,7 +186,6 @@ CONFIG_ARCH_POPULATES_NODE_MAP=y
 # CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 CONFIG_PREEMPT=y
-# CONFIG_PREEMPT_RCU is not set
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_DEFAULT=y
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
@@ -195,7 +206,6 @@ CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_MIGRATION=y
-CONFIG_RESOURCES_64BIT=y
 CONFIG_PHYS_ADDR_T_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
@@ -207,7 +217,6 @@ CONFIG_UNEVICTABLE_LRU=y
 #
 CONFIG_MACHCHK_WARNING=y
 CONFIG_QDIO=y
-# CONFIG_QDIO_DEBUG is not set
 CONFIG_CHSC_SCH=m
 
 #
@@ -227,15 +236,13 @@ CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_CMM is not set
 # CONFIG_PAGE_STATES is not set
-CONFIG_VIRT_TIMER=y
-CONFIG_VIRT_CPU_ACCOUNTING=y
 # CONFIG_APPLDATA_BASE is not set
 CONFIG_HZ_100=y
 # CONFIG_HZ_250 is not set
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=100
-# CONFIG_SCHED_HRTICK is not set
+CONFIG_SCHED_HRTICK=y
 CONFIG_S390_HYPFS_FS=y
 CONFIG_KEXEC=y
 # CONFIG_ZFCPDUMP is not set
@@ -245,6 +252,7 @@ CONFIG_NET=y
 #
 # Networking options
 #
+CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -383,6 +391,7 @@ CONFIG_NET_SCH_TBF=m
 CONFIG_NET_SCH_GRED=m
 CONFIG_NET_SCH_DSMARK=m
 # CONFIG_NET_SCH_NETEM is not set
+# CONFIG_NET_SCH_DRR is not set
 # CONFIG_NET_SCH_INGRESS is not set
 
 #
@@ -400,6 +409,7 @@ CONFIG_CLS_U32_MARK=y
 CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
 CONFIG_NET_CLS_FLOW=m
+# CONFIG_NET_CLS_CGROUP is not set
 # CONFIG_NET_EMATCH is not set
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
@@ -411,6 +421,7 @@ CONFIG_NET_ACT_NAT=m
 # CONFIG_NET_ACT_SKBEDIT is not set
 # CONFIG_NET_CLS_IND is not set
 CONFIG_NET_SCH_FIFO=y
+# CONFIG_DCB is not set
 
 #
 # Network testing
@@ -428,6 +439,7 @@ CONFIG_CAN_VCAN=m
 # CONFIG_CAN_DEBUG_DEVICES is not set
 # CONFIG_AF_RXRPC is not set
 # CONFIG_PHONET is not set
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 # CONFIG_PCMCIA is not set
@@ -475,11 +487,15 @@ CONFIG_DASD_DIAG=y
 CONFIG_DASD_EER=y
 CONFIG_VIRTIO_BLK=m
 CONFIG_MISC_DEVICES=y
-# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_C2PORT is not set
 
 #
+# EEPROM support
+#
+# CONFIG_EEPROM_93CX6 is not set
+
+#
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
@@ -520,6 +536,7 @@ CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
+# CONFIG_LIBFC is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_SCSI_DH=m
@@ -566,6 +583,10 @@ CONFIG_NET_ETHERNET=y
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 # CONFIG_TR is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
 # CONFIG_WAN is not set
 
 #
@@ -593,9 +614,11 @@ CONFIG_VIRTIO_NET=m
 #
 CONFIG_DEVKMEM=y
 CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_HVC_DRIVER=y
+CONFIG_HVC_IUCV=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=m
 CONFIG_HW_RANDOM_VIRTIO=m
@@ -645,7 +668,6 @@ CONFIG_S390_VMUR=m
 # CONFIG_NEW_LEDS is not set
 CONFIG_ACCESSIBILITY=y
 # CONFIG_STAGING is not set
-CONFIG_STAGING_EXCLUDE_BUILD=y
 
 #
 # File systems
@@ -668,6 +690,7 @@ CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -703,10 +726,7 @@ CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_CONFIGFS_FS=m
-
-#
-# Miscellaneous filesystems
-#
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
@@ -715,6 +735,7 @@ CONFIG_CONFIGFS_FS=m
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_OMFS_FS is not set
@@ -808,6 +829,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
@@ -818,15 +840,19 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_HAVE_FUNCTION_TRACER=y
 
 #
 # Tracers
 #
+# CONFIG_FUNCTION_TRACER is not set
 # CONFIG_IRQSOFF_TRACER is not set
 # CONFIG_PREEMPT_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_CONTEXT_SWITCH_TRACER is not set
 # CONFIG_BOOT_TRACER is not set
+# CONFIG_TRACE_BRANCH_PROFILING is not set
+# CONFIG_STACK_TRACER is not set
 # CONFIG_DYNAMIC_PRINTK_DEBUG is not set
 CONFIG_SAMPLES=y
 # CONFIG_SAMPLE_KOBJECT is not set
@@ -847,11 +873,17 @@ CONFIG_CRYPTO=y
 #
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_AEAD=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD=m
+CONFIG_CRYPTO_AEAD2=y
 CONFIG_CRYPTO_BLKCIPHER=y
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=m
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=m
+CONFIG_CRYPTO_RNG2=y
 CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_GF128MUL=m
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_CRYPTD is not set
@@ -885,7 +917,7 @@ CONFIG_CRYPTO_HMAC=m
 #
 # Digest
 #
-# CONFIG_CRYPTO_CRC32C is not set
+CONFIG_CRYPTO_CRC32C=m
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=m
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
@@ -942,6 +974,7 @@ CONFIG_S390_PRNG=m
 # Library routines
 #
 CONFIG_BITREVERSE=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC_T10DIF=y
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index ffdef5f..f3720de 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -384,8 +384,8 @@ struct _lowcore
         __u32        panic_magic;              /* 0xe00 */
 
 	/* Per cpu primary space access list */
-	__u8	     pad_0xe04[0xe3c-0xe04];   /* 0xe04 */
-	__u32	     vdso_per_cpu_data;	       /* 0xe3c */
+	__u8	     pad_0xe04[0xe38-0xe04];   /* 0xe04 */
+	__u64	     vdso_per_cpu_data;	       /* 0xe38 */
 	__u32	     paste[16];		       /* 0xe40 */
 
 	__u8	     pad13[0x11b8-0xe80];      /* 0xe80 */
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index e7c5bfb..026a37a 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -95,6 +95,7 @@ asmlinkage void do_softirq(void)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_PROC_FS
 void init_irq_proc(void)
 {
 	struct proc_dir_entry *root_irq_dir;
@@ -102,3 +103,4 @@ void init_irq_proc(void)
 	root_irq_dir = proc_mkdir("irq", NULL);
 	create_prof_cpu_mask(root_irq_dir);
 }
+#endif
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index bd59149..08c23a9 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -57,6 +57,8 @@ static void dasd_device_tasklet(struct dasd_device *);
 static void dasd_block_tasklet(struct dasd_block *);
 static void do_kick_device(struct work_struct *);
 static void dasd_return_cqr_cb(struct dasd_ccw_req *, void *);
+static void dasd_device_timeout(unsigned long);
+static void dasd_block_timeout(unsigned long);
 
 /*
  * SECTION: Operations on the device structure.
@@ -99,6 +101,8 @@ struct dasd_device *dasd_alloc_device(void)
 		     (unsigned long) device);
 	INIT_LIST_HEAD(&device->ccw_queue);
 	init_timer(&device->timer);
+	device->timer.function = dasd_device_timeout;
+	device->timer.data = (unsigned long) device;
 	INIT_WORK(&device->kick_work, do_kick_device);
 	device->state = DASD_STATE_NEW;
 	device->target = DASD_STATE_NEW;
@@ -138,6 +142,8 @@ struct dasd_block *dasd_alloc_block(void)
 	INIT_LIST_HEAD(&block->ccw_queue);
 	spin_lock_init(&block->queue_lock);
 	init_timer(&block->timer);
+	block->timer.function = dasd_block_timeout;
+	block->timer.data = (unsigned long) block;
 
 	return block;
 }
@@ -915,19 +921,10 @@ static void dasd_device_timeout(unsigned long ptr)
  */
 void dasd_device_set_timer(struct dasd_device *device, int expires)
 {
-	if (expires == 0) {
-		if (timer_pending(&device->timer))
-			del_timer(&device->timer);
-		return;
-	}
-	if (timer_pending(&device->timer)) {
-		if (mod_timer(&device->timer, jiffies + expires))
-			return;
-	}
-	device->timer.function = dasd_device_timeout;
-	device->timer.data = (unsigned long) device;
-	device->timer.expires = jiffies + expires;
-	add_timer(&device->timer);
+	if (expires == 0)
+		del_timer(&device->timer);
+	else
+		mod_timer(&device->timer, jiffies + expires);
 }
 
 /*
@@ -935,8 +932,7 @@ void dasd_device_set_timer(struct dasd_device *device, int expires)
  */
 void dasd_device_clear_timer(struct dasd_device *device)
 {
-	if (timer_pending(&device->timer))
-		del_timer(&device->timer);
+	del_timer(&device->timer);
 }
 
 static void dasd_handle_killed_request(struct ccw_device *cdev,
@@ -1586,19 +1582,10 @@ static void dasd_block_timeout(unsigned long ptr)
  */
 void dasd_block_set_timer(struct dasd_block *block, int expires)
 {
-	if (expires == 0) {
-		if (timer_pending(&block->timer))
-			del_timer(&block->timer);
-		return;
-	}
-	if (timer_pending(&block->timer)) {
-		if (mod_timer(&block->timer, jiffies + expires))
-			return;
-	}
-	block->timer.function = dasd_block_timeout;
-	block->timer.data = (unsigned long) block;
-	block->timer.expires = jiffies + expires;
-	add_timer(&block->timer);
+	if (expires == 0)
+		del_timer(&block->timer);
+	else
+		mod_timer(&block->timer, jiffies + expires);
 }
 
 /*
@@ -1606,8 +1593,7 @@ void dasd_block_set_timer(struct dasd_block *block, int expires)
  */
 void dasd_block_clear_timer(struct dasd_block *block)
 {
-	if (timer_pending(&block->timer))
-		del_timer(&block->timer);
+	del_timer(&block->timer);
 }
 
 /*
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 300e28a..3433990 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -677,7 +677,7 @@ static ssize_t dasd_ff_show(struct device *dev, struct device_attribute *attr,
 	struct dasd_devmap *devmap;
 	int ff_flag;
 
-	devmap = dasd_find_busid(dev->bus_id);
+	devmap = dasd_find_busid(dev_name(dev));
 	if (!IS_ERR(devmap))
 		ff_flag = (devmap->features & DASD_FEATURE_FAILFAST) != 0;
 	else
