Return-Path: <linux-kernel-owner+w=401wt.eu-S932127AbYD3MJZ@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Wed, 30 Apr 2008 14:06:27 +0200
Message-Id: <1209557187.10954.35.camel@localhost>
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

 arch/s390/Kconfig               |    8 ++
 arch/s390/defconfig             |  141 +++++++++++++++++++++---------
 arch/s390/kernel/Makefile       |    2 -
 arch/s390/kernel/early.c        |  125 ++++++++++++++++++++++++++-
 arch/s390/kernel/head31.S       |   61 -------------
 arch/s390/kernel/head64.S       |   64 +-------------
 arch/s390/kernel/process.c      |   18 ----
 arch/s390/kernel/ptrace.c       |   57 +------------
 arch/s390/kernel/setup.c        |   21 ++---
 arch/s390/kernel/smp.c          |   31 ++++---
 arch/s390/kernel/topology.c     |   35 +++++++-
 arch/s390/kernel/traps.c        |   26 +++++-
 arch/s390/kvm/priv.c            |   11 +--
 arch/s390/lib/Makefile          |    2 -
 arch/s390/lib/uaccess_mvcos.c   |    2 +
 arch/s390/math-emu/Makefile     |    1 -
 arch/s390/mm/Makefile           |    2 +-
 arch/s390/mm/extmem.c           |    8 +-
 arch/s390/mm/fault.c            |    3 +
 arch/s390/mm/hugetlbpage.c      |  134 ++++++++++++++++++++++++++++
 arch/s390/mm/init.c             |   25 +-----
 arch/s390/mm/vmem.c             |  135 +++++++++++-----------------
 drivers/s390/char/sclp_config.c |   17 ++++-
 drivers/s390/cio/ccwgroup.c     |    7 +-
 drivers/s390/cio/cio.c          |    9 +-
 drivers/s390/cio/cio.h          |    3 +-
 drivers/s390/cio/cmf.c          |   11 ++-
 drivers/s390/cio/css.c          |   10 ++-
 drivers/s390/cio/device.c       |   17 +++--
 drivers/s390/cio/device_fsm.c   |   10 +--
 drivers/s390/cio/device_ops.c   |    2 +-
 drivers/s390/cio/qdio.c         |    8 +-
 drivers/s390/kvm/kvm_virtio.c   |   23 +++---
 fs/Kconfig                      |    3 +-
 include/asm-s390/hugetlb.h      |  183 +++++++++++++++++++++++++++++++++++++++
 include/asm-s390/page.h         |   49 +++++------
 include/asm-s390/pgtable.h      |   21 +++--
 include/asm-s390/processor.h    |    9 --
 include/asm-s390/ptrace.h       |    2 -
 include/asm-s390/setup.h        |   39 ++++++--
 include/asm-s390/smp.h          |   12 ++-
 include/asm-s390/sparsemem.h    |   18 ++++
 include/asm-s390/sysinfo.h      |    5 +
 include/asm-s390/system.h       |   18 ++++
 include/asm-s390/tlbflush.h     |    1 +
 include/asm-s390/topology.h     |    4 +
 46 files changed, 892 insertions(+), 501 deletions(-)
 create mode 100644 arch/s390/mm/hugetlbpage.c
 create mode 100644 include/asm-s390/hugetlb.h
 create mode 100644 include/asm-s390/sparsemem.h

Cornelia Huck (2):
      [S390] cio: Use strict_strtoul() for attributes.
      [S390] cio: Make isc handling more robust.

Gerald Schaefer (1):
      [S390] System z large page support.

Heiko Carstens (11):
      [S390] Move show_regs to traps.c.
      [S390] Add missing ifndef/define to include/asm-s390/sysinfo.h.
      [S390] smp: Fix locking order.
      [S390] Automatically detect added cpus.
      [S390] Add topology_core_siblings to topology.h
      [S390] cpu topology: Fix possible deadlock.
      [S390] uaccess_mvcos: #ifdef config dependent code.
      [S390] Move stfl to system.h and delete duplicated version.
      [S390] vmemmap: use clear_table to initialise page tables.
      [S390] Convert machine feature detection code to C.
      [S390] Convert to SPARSEMEM & SPARSEMEM_VMEMMAP

Martin Schwidefsky (3):
      [S390] Remove self ptrace IEEE_IP hack.
      [S390] use generic sys_ptrace
      [S390] Update default configuration.

Mathieu Desnoyers (1):
      [S390] remove -traditional

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8f5f021..29a7940 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -300,6 +300,14 @@ comment "Kernel preemption"
 
 source "kernel/Kconfig.preempt"
 
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	select SPARSEMEM_VMEMMAP_ENABLE
+	select SPARSEMEM_VMEMMAP
+
+config ARCH_SPARSEMEM_DEFAULT
+	def_bool y
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index a72f208..aa341d0 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc4
-# Wed Mar  5 11:22:59 2008
+# Linux kernel version: 2.6.25
+# Wed Apr 30 11:07:45 2008
 #
 CONFIG_SCHED_MC=y
 CONFIG_MMU=y
@@ -14,10 +14,12 @@ CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_BUG=y
 CONFIG_NO_IOMEM=y
 CONFIG_NO_DMA=y
 CONFIG_GENERIC_LOCKBREAK=y
+CONFIG_PGSTE=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -43,6 +45,7 @@ CONFIG_LOG_BUF_SHIFT=17
 CONFIG_CGROUPS=y
 # CONFIG_CGROUP_DEBUG is not set
 CONFIG_CGROUP_NS=y
+# CONFIG_CGROUP_DEVICE is not set
 # CONFIG_CPUSETS is not set
 CONFIG_GROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
@@ -65,6 +68,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -92,6 +96,7 @@ CONFIG_KPROBES=y
 CONFIG_KRETPROBES=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_DMA_ATTRS is not set
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -121,8 +126,8 @@ CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="deadline"
+CONFIG_PREEMPT_NOTIFIERS=y
 CONFIG_CLASSIC_RCU=y
-# CONFIG_PREEMPT_RCU is not set
 
 #
 # Base setup
@@ -131,6 +136,10 @@ CONFIG_CLASSIC_RCU=y
 #
 # Processor type and features
 #
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 CONFIG_64BIT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
@@ -161,15 +170,20 @@ CONFIG_ARCH_POPULATES_NODE_MAP=y
 # CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 CONFIG_PREEMPT=y
-# CONFIG_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU is not set
+CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_DEFAULT=y
 CONFIG_SELECT_MEMORY_MODEL=y
-CONFIG_FLATMEM_MANUAL=y
+# CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
-# CONFIG_SPARSEMEM_MANUAL is not set
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_SPARSEMEM=y
+CONFIG_HAVE_MEMORY_PRESENT=y
 # CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPARSEMEM_EXTREME=y
+CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
+CONFIG_SPARSEMEM_VMEMMAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
@@ -205,11 +219,10 @@ CONFIG_HZ_100=y
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=100
 # CONFIG_SCHED_HRTICK is not set
-CONFIG_NO_IDLE_HZ=y
-CONFIG_NO_IDLE_HZ_INIT=y
 CONFIG_S390_HYPFS_FS=y
 CONFIG_KEXEC=y
 # CONFIG_ZFCPDUMP is not set
+CONFIG_S390_GUEST=y
 
 #
 # Networking
@@ -272,8 +285,10 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
 # CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
@@ -289,6 +304,7 @@ CONFIG_NF_CONNTRACK=m
 # CONFIG_NF_CT_ACCT is not set
 # CONFIG_NF_CONNTRACK_MARK is not set
 # CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CT_PROTO_DCCP is not set
 # CONFIG_NF_CT_PROTO_SCTP is not set
 # CONFIG_NF_CT_PROTO_UDPLITE is not set
 # CONFIG_NF_CONNTRACK_AMANDA is not set
@@ -439,6 +455,7 @@ CONFIG_DASD_ECKD=y
 CONFIG_DASD_FBA=y
 CONFIG_DASD_DIAG=y
 CONFIG_DASD_EER=y
+CONFIG_VIRTIO_BLK=m
 CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
@@ -533,7 +550,7 @@ CONFIG_NETDEV_10000=y
 # S/390 network device drivers
 #
 CONFIG_LCS=m
-CONFIG_CTC=m
+CONFIG_CTCM=m
 # CONFIG_NETIUCV is not set
 # CONFIG_SMSGIUCV is not set
 # CONFIG_CLAW is not set
@@ -547,10 +564,12 @@ CONFIG_CCWGROUP=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
+CONFIG_VIRTIO_NET=m
 
 #
 # Character devices
 #
+CONFIG_DEVKMEM=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -600,6 +619,7 @@ CONFIG_S390_VMUR=m
 # Sonics Silicon Backplane
 #
 # CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
 
 #
 # File systems
@@ -652,6 +672,7 @@ CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_CONFIGFS_FS=m
 
@@ -678,12 +699,10 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V3_ACL is not set
 # CONFIG_NFSD_V4 is not set
-CONFIG_NFSD_TCP=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
@@ -731,6 +750,7 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
@@ -754,6 +774,7 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_FRAME_POINTER is not set
@@ -775,58 +796,88 @@ CONFIG_SAMPLES=y
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_AEAD=m
 CONFIG_CRYPTO_BLKCIPHER=y
-CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_HASH=m
 CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_GF128MUL=m
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_AUTHENC=m
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_GCM=m
+CONFIG_CRYPTO_SEQIV=m
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CTR=m
+CONFIG_CRYPTO_CTS=m
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 CONFIG_CRYPTO_HMAC=m
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=m
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-CONFIG_CRYPTO_GF128MUL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-CONFIG_CRYPTO_CTR=m
-CONFIG_CRYPTO_GCM=m
-CONFIG_CRYPTO_CCM=m
-# CONFIG_CRYPTO_CRYPTD is not set
-# CONFIG_CRYPTO_DES is not set
-CONFIG_CRYPTO_FCRYPT=m
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+CONFIG_CRYPTO_CAMELLIA=m
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_DES is not set
+CONFIG_CRYPTO_FCRYPT=m
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SALSA20=m
+CONFIG_CRYPTO_SEED=m
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-CONFIG_CRYPTO_CAMELLIA=m
-# CONFIG_CRYPTO_TEST is not set
-CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_HW=y
 CONFIG_ZCRYPT=m
 # CONFIG_ZCRYPT_MONOLITHIC is not set
 # CONFIG_CRYPTO_SHA1_S390 is not set
 # CONFIG_CRYPTO_SHA256_S390 is not set
+CONFIG_CRYPTO_SHA512_S390=m
 # CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_AES_S390 is not set
 CONFIG_S390_PRNG=m
@@ -835,6 +886,8 @@ CONFIG_S390_PRNG=m
 # Library routines
 #
 CONFIG_BITREVERSE=m
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+# CONFIG_GENERIC_FIND_NEXT_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
@@ -844,3 +897,9 @@ CONFIG_LIBCRC32C=m
 CONFIG_LZO_COMPRESS=m
 CONFIG_LZO_DECOMPRESS=m
 CONFIG_PLIST=y
+CONFIG_HAVE_KVM=y
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM=m
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_RING=y
+CONFIG_VIRTIO_BALLOON=m
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 77051cd..6302f50 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -2,8 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-EXTRA_AFLAGS	:= -traditional
-
 #
 # Passing null pointers is ok for smp code, since we access the lowcore here.
 #
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 68ec408..d0e0968 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -139,15 +139,15 @@ static noinline __init void detect_machine_type(void)
 
 	/* Running under z/VM ? */
 	if (cpuinfo->cpu_id.version == 0xff)
-		machine_flags |= 1;
+		machine_flags |= MACHINE_FLAG_VM;
 
 	/* Running on a P/390 ? */
 	if (cpuinfo->cpu_id.machine == 0x7490)
-		machine_flags |= 4;
+		machine_flags |= MACHINE_FLAG_P390;
 
 	/* Running under KVM ? */
 	if (cpuinfo->cpu_id.version == 0xfe)
-		machine_flags |= 64;
+		machine_flags |= MACHINE_FLAG_KVM;
 }
 
 #ifdef CONFIG_64BIT
@@ -268,6 +268,118 @@ static noinline __init void setup_lowcore_early(void)
 	s390_base_pgm_handler_fn = early_pgm_check_handler;
 }
 
+static noinline __init void setup_hpage(void)
+{
+#ifndef CONFIG_DEBUG_PAGEALLOC
+	unsigned int facilities;
+
+	facilities = stfl();
+	if (!(facilities & (1UL << 23)) || !(facilities & (1UL << 29)))
+		return;
+	machine_flags |= MACHINE_FLAG_HPAGE;
+	__ctl_set_bit(0, 23);
+#endif
+}
+
+static __init void detect_mvpg(void)
+{
+#ifndef CONFIG_64BIT
+	int rc;
+
+	asm volatile(
+		"	la	0,0\n"
+		"	mvpg	%2,%2\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP), "a" (0) : "memory", "cc", "0");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_MVPG;
+#endif
+}
+
+static __init void detect_ieee(void)
+{
+#ifndef CONFIG_64BIT
+	int rc, tmp;
+
+	asm volatile(
+		"	efpc	%1,0\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc), "=d" (tmp): "0" (-EOPNOTSUPP) : "cc");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_IEEE;
+#endif
+}
+
+static __init void detect_csp(void)
+{
+#ifndef CONFIG_64BIT
+	int rc;
+
+	asm volatile(
+		"	la	0,0\n"
+		"	la	1,0\n"
+		"	la	2,4\n"
+		"	csp	0,2\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP) : "cc", "0", "1", "2");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_CSP;
+#endif
+}
+
+static __init void detect_diag9c(void)
+{
+	unsigned int cpu_address;
+	int rc;
+
+	cpu_address = stap();
+	asm volatile(
+		"	diag	%2,0,0x9c\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP), "d" (cpu_address) : "cc");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_DIAG9C;
+}
+
+static __init void detect_diag44(void)
+{
+#ifdef CONFIG_64BIT
+	int rc;
+
+	asm volatile(
+		"	diag	0,0,0x44\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP) : "cc");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_DIAG44;
+#endif
+}
+
+static __init void detect_machine_facilities(void)
+{
+#ifdef CONFIG_64BIT
+	unsigned int facilities;
+
+	facilities = stfl();
+	if (facilities & (1 << 28))
+		machine_flags |= MACHINE_FLAG_IDTE;
+	if (facilities & (1 << 23))
+		machine_flags |= MACHINE_FLAG_PFMF;
+	if (facilities & (1 << 4))
+		machine_flags |= MACHINE_FLAG_MVCOS;
+#endif
+}
+
 /*
  * Save ipl parameters, clear bss memory, initialize storage keys
  * and create a kernel NSS at startup if the SAVESYS= parm is defined
@@ -285,6 +397,13 @@ void __init startup_init(void)
 	create_kernel_nss();
 	sort_main_extable();
 	setup_lowcore_early();
+	detect_mvpg();
+	detect_ieee();
+	detect_csp();
+	detect_diag9c();
+	detect_diag44();
+	detect_machine_facilities();
+	setup_hpage();
 	sclp_read_info_early();
 	sclp_facilities_detect();
 	memsize = sclp_memory_detect();
diff --git a/arch/s390/kernel/head31.S b/arch/s390/kernel/head31.S
index dc364c1..a816e2d 100644
--- a/arch/s390/kernel/head31.S
+++ b/arch/s390/kernel/head31.S
@@ -57,61 +57,6 @@ startup_continue:
 #
 	l	%r14,.Lstartup_init-.LPG1(%r13)
 	basr	%r14,%r14
-
-	l	%r12,.Lmflags-.LPG1(%r13) # get address of machine_flags
-#
-# find out if we have an IEEE fpu
-#
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcfpu-.LPG1(%r13)
-	efpc	%r0,0			# test IEEE extract fpc instruction
-	oi	3(%r12),2		# set IEEE fpu flag
-.Lchkfpu:
-
-#
-# find out if we have the CSP instruction
-#
-       mvc	 __LC_PGM_NEW_PSW(8),.Lpccsp-.LPG1(%r13)
-       la	 %r0,0
-       lr	%r1,%r0
-       la	%r2,4
-       csp	%r0,%r2			# Test CSP instruction
-       oi	3(%r12),8		# set CSP flag
-.Lchkcsp:
-
-#
-# find out if we have the MVPG instruction
-#
-       mvc	__LC_PGM_NEW_PSW(8),.Lpcmvpg-.LPG1(%r13)
-       sr	%r0,%r0
-       la	%r1,0
-       la	%r2,0
-       mvpg	%r1,%r2			# Test CSP instruction
-       oi	3(%r12),16		# set MVPG flag
-.Lchkmvpg:
-
-#
-# find out if we have the IDTE instruction
-#
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcidte-.LPG1(%r13)
-	.long	0xb2b10000		# store facility list
-	tm	0xc8,0x08		# check bit for clearing-by-ASCE
-	bno	.Lchkidte-.LPG1(%r13)
-	lhi	%r1,2094
-	lhi	%r2,0
-	.long	0xb98e2001
-	oi	3(%r12),0x80		# set IDTE flag
-.Lchkidte:
-
-#
-# find out if the diag 0x9c is available
-#
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcdiag9c-.LPG1(%r13)
-	stap	__LC_CPUID+4		# store cpu address
-	lh	%r1,__LC_CPUID+4
-	diag	%r1,0,0x9c		# test diag 0x9c
-	oi	2(%r12),1		# set diag9c flag
-.Lchkdiag9c:
-
 	lpsw  .Lentry-.LPG1(13)		# jump to _stext in primary-space,
 					# virtual and never return ...
 	.align	8
@@ -132,13 +77,7 @@ startup_continue:
 	.long	0			# cr13: home space segment table
 	.long	0xc0000000		# cr14: machine check handling off
 	.long	0			# cr15: linkage stack operations
-.Lpcfpu:.long	0x00080000,0x80000000 + .Lchkfpu
-.Lpccsp:.long	0x00080000,0x80000000 + .Lchkcsp
-.Lpcmvpg:.long	0x00080000,0x80000000 + .Lchkmvpg
-.Lpcidte:.long	0x00080000,0x80000000 + .Lchkidte
-.Lpcdiag9c:.long 0x00080000,0x80000000 + .Lchkdiag9c
 .Lmchunk:.long	memory_chunk
-.Lmflags:.long	machine_flags
 .Lbss_bgn:  .long __bss_start
 .Lbss_end:  .long _end
 .Lparmaddr: .long PARMAREA
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index 79dccd2..1d06961 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -125,73 +125,11 @@ startup_continue:
 # and create a kernel NSS if the SAVESYS= parm is defined
 #
 	brasl	%r14,startup_init
-					# set program check new psw mask
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcmsk-.LPG1(%r13)
-	larl	%r12,machine_flags
-#
-# find out if we have the MVPG instruction
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	sgr	%r0,%r0
-	lghi	%r1,0
-	lghi	%r2,0
-	mvpg	%r1,%r2 		# test MVPG instruction
-	oi	7(%r12),16		# set MVPG flag
-0:
-
-#
-# find out if the diag 0x44 works in 64 bit mode
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	diag	0,0,0x44		# test diag 0x44
-	oi	7(%r12),32		# set diag44 flag
-0:
-
-#
-# find out if we have the IDTE instruction
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	.long	0xb2b10000		# store facility list
-	tm	0xc8,0x08		# check bit for clearing-by-ASCE
-	bno	0f-.LPG1(%r13)
-	lhi	%r1,2048
-	lhi	%r2,0
-	.long	0xb98e2001
-	oi	7(%r12),0x80		# set IDTE flag
-0:
-
-#
-# find out if the diag 0x9c is available
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	stap	__LC_CPUID+4		# store cpu address
-	lh	%r1,__LC_CPUID+4
-	diag	%r1,0,0x9c		# test diag 0x9c
-	oi	6(%r12),1		# set diag9c flag
-0:
-
-#
-# find out if we have the MVCOS instruction
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	.short	0xc800			# mvcos 0(%r0),0(%r0),%r0
-	.short	0x0000
-	.short	0x0000
-0:	tm	0x8f,0x13		# special-operation exception?
-	bno	1f-.LPG1(%r13)		# if yes, MVCOS is present
-	oi	6(%r12),2		# set MVCOS flag
-1:
-
 	lpswe	.Lentry-.LPG1(13)	# jump to _stext in primary-space,
 					# virtual and never return ...
 	.align	16
 .Lentry:.quad	0x0000000180000000,_stext
-.Lctl:	.quad	0x04b50002		# cr0: various things
+.Lctl:	.quad	0x04350002		# cr0: various things
 	.quad	0			# cr1: primary space segment table
 	.quad	.Lduct			# cr2: dispatchable unit control table
 	.quad	0			# cr3: instruction authorization
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index c1aff19..7920861 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -180,24 +180,6 @@ void cpu_idle(void)
 	}
 }
 
-void show_regs(struct pt_regs *regs)
-{
-	print_modules();
-	printk("CPU: %d %s %s %.*s\n",
-	       task_thread_info(current)->cpu, print_tainted(),
-	       init_utsname()->release,
-	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version);
-	printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
-	       current->comm, current->pid, current,
-	       (void *) current->thread.ksp);
-	show_registers(regs);
-	/* Show stack backtrace if pt_regs is from kernel mode */
-	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		show_trace(NULL, (unsigned long *) regs->gprs[15]);
-	show_last_breaking_event(regs);
-}
-
 extern void kernel_thread_starter(void);
 
 asm(
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 58a0642..7f42701 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -607,38 +607,8 @@ do_ptrace_emu31(struct task_struct *child, long request, long addr, long data)
 }
 #endif
 
-#define PT32_IEEE_IP 0x13c
-
-static int
-do_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	int ret;
-
-	if (request == PTRACE_ATTACH)
-		return ptrace_attach(child);
-
-	/*
-	 * Special cases to get/store the ieee instructions pointer.
-	 */
-	if (child == current) {
-		if (request == PTRACE_PEEKUSR && addr == PT_IEEE_IP)
-			return peek_user(child, addr, data);
-		if (request == PTRACE_POKEUSR && addr == PT_IEEE_IP)
-			return poke_user(child, addr, data);
-#ifdef CONFIG_COMPAT
-		if (request == PTRACE_PEEKUSR &&
-		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
-			return peek_user_emu31(child, addr, data);
-		if (request == PTRACE_POKEUSR &&
-		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
-			return poke_user_emu31(child, addr, data);
-#endif
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		return ret;
-
 	switch (request) {
 	case PTRACE_SYSCALL:
 		/* continue and stop at next (return from) syscall */
@@ -693,31 +663,6 @@ do_ptrace(struct task_struct *child, long request, long addr, long data)
 	return -EIO;
 }
 
-asmlinkage long
-sys_ptrace(long request, long pid, long addr, long data)
-{
-	struct task_struct *child;
-	int ret;
-
-	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		 ret = ptrace_traceme();
-		 goto out;
-	}
-
-	child = ptrace_get_task_struct(pid);
-	if (IS_ERR(child)) {
-		ret = PTR_ERR(child);
-		goto out;
-	}
-
-	ret = do_ptrace(child, request, addr, data);
-	put_task_struct(child);
-out:
-	unlock_kernel();
-	return ret;
-}
-
 asmlinkage void
 syscall_trace(struct pt_regs *regs, int entryexit)
 {
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a9d18aa..2bc70b6 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(uaccess);
 unsigned int console_mode = 0;
 unsigned int console_devno = -1;
 unsigned int console_irq = -1;
-unsigned long machine_flags = 0;
+unsigned long machine_flags;
 unsigned long elf_hwcap = 0;
 char elf_platform[ELF_PLATFORM_SIZE];
 
@@ -683,15 +683,6 @@ setup_memory(void)
 #endif
 }
 
-static __init unsigned int stfl(void)
-{
-	asm volatile(
-		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
-		"0:\n"
-		EX_TABLE(0b,0b));
-	return S390_lowcore.stfl_fac_list;
-}
-
 static int __init __stfle(unsigned long long *list, int doublewords)
 {
 	typedef struct { unsigned long long _[doublewords]; } addrtype;
@@ -758,6 +749,9 @@ static void __init setup_hwcaps(void)
 			elf_hwcap |= 1UL << 6;
 	}
 
+	if (MACHINE_HAS_HPAGE)
+		elf_hwcap |= 1UL << 7;
+
 	switch (cpuinfo->cpu_id.machine) {
 	case 0x9672:
 #if !defined(CONFIG_64BIT)
@@ -881,8 +875,9 @@ void __cpuinit print_cpu_info(struct cpuinfo_S390 *cpuinfo)
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	static const char *hwcap_str[7] = {
-		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp"
+	static const char *hwcap_str[8] = {
+		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp",
+		"edat"
 	};
         struct cpuinfo_S390 *cpuinfo;
 	unsigned long n = (unsigned long) v - 1;
@@ -897,7 +892,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
 		seq_puts(m, "features\t: ");
-		for (i = 0; i < 7; i++)
+		for (i = 0; i < 8; i++)
 			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
 				seq_printf(m, "%s ", hwcap_str[i]);
 		seq_puts(m, "\n");
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0dfa988..0aeb290 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -505,7 +505,7 @@ out:
 	return rc;
 }
 
-static int smp_rescan_cpus(void)
+static int __smp_rescan_cpus(void)
 {
 	cpumask_t avail;
 
@@ -570,7 +570,7 @@ out:
 	kfree(info);
 	printk(KERN_INFO "CPUs: %d configured, %d standby\n", c_cpus, s_cpus);
 	get_online_cpus();
-	smp_rescan_cpus();
+	__smp_rescan_cpus();
 	put_online_cpus();
 }
 
@@ -890,8 +890,8 @@ static ssize_t cpu_configure_store(struct sys_device *dev, const char *buf,
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
-	mutex_lock(&smp_cpu_state_mutex);
 	get_online_cpus();
+	mutex_lock(&smp_cpu_state_mutex);
 	rc = -EBUSY;
 	if (cpu_online(cpu))
 		goto out;
@@ -919,8 +919,8 @@ static ssize_t cpu_configure_store(struct sys_device *dev, const char *buf,
 		break;
 	}
 out:
-	put_online_cpus();
 	mutex_unlock(&smp_cpu_state_mutex);
+	put_online_cpus();
 	return rc ? rc : count;
 }
 static SYSDEV_ATTR(configure, 0644, cpu_configure_show, cpu_configure_store);
@@ -1088,17 +1088,17 @@ out:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static ssize_t __ref rescan_store(struct sys_device *dev,
-				  const char *buf, size_t count)
+
+int smp_rescan_cpus(void)
 {
 	cpumask_t newcpus;
 	int cpu;
 	int rc;
 
-	mutex_lock(&smp_cpu_state_mutex);
 	get_online_cpus();
+	mutex_lock(&smp_cpu_state_mutex);
 	newcpus = cpu_present_map;
-	rc = smp_rescan_cpus();
+	rc = __smp_rescan_cpus();
 	if (rc)
 		goto out;
 	cpus_andnot(newcpus, cpu_present_map, newcpus);
@@ -1109,10 +1109,19 @@ static ssize_t __ref rescan_store(struct sys_device *dev,
 	}
 	rc = 0;
 out:
-	put_online_cpus();
 	mutex_unlock(&smp_cpu_state_mutex);
+	put_online_cpus();
 	if (!cpus_empty(newcpus))
 		topology_schedule_update();
+	return rc;
+}
+
+static ssize_t __ref rescan_store(struct sys_device *dev, const char *buf,
+				  size_t count)
+{
+	int rc;
+
+	rc = smp_rescan_cpus();
 	return rc ? rc : count;
 }
 static SYSDEV_ATTR(rescan, 0200, NULL, rescan_store);
@@ -1139,16 +1148,16 @@ static ssize_t dispatching_store(struct sys_device *dev, const char *buf,
 	if (val != 0 && val != 1)
 		return -EINVAL;
 	rc = 0;
-	mutex_lock(&smp_cpu_state_mutex);
 	get_online_cpus();
+	mutex_lock(&smp_cpu_state_mutex);
 	if (cpu_management == val)
 		goto out;
 	rc = topology_set_cpu_management(val);
 	if (!rc)
 		cpu_management = val;
 out:
-	put_online_cpus();
 	mutex_unlock(&smp_cpu_state_mutex);
+	put_online_cpus();
 	return rc ? rc : count;
 }
 static SYSDEV_ATTR(dispatching, 0644, dispatching_show, dispatching_store);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 12b39b3..661a072 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/bootmem.h>
 #include <linux/sched.h>
+#include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
@@ -66,6 +67,8 @@ static struct timer_list topology_timer;
 static void set_topology_timer(void);
 static DECLARE_WORK(topology_work, topology_work_fn);
 
+cpumask_t cpu_core_map[NR_CPUS];
+
 cpumask_t cpu_coregroup_map(unsigned int cpu)
 {
 	struct core_info *core = &core_info;
@@ -199,6 +202,14 @@ int topology_set_cpu_management(int fc)
 	return rc;
 }
 
+static void update_cpu_core_map(void)
+{
+	int cpu;
+
+	for_each_present_cpu(cpu)
+		cpu_core_map[cpu] = cpu_coregroup_map(cpu);
+}
+
 void arch_update_cpu_topology(void)
 {
 	struct tl_info *info = tl_info;
@@ -206,20 +217,33 @@ void arch_update_cpu_topology(void)
 	int cpu;
 
 	if (!machine_has_topology) {
+		update_cpu_core_map();
 		topology_update_polarization_simple();
 		return;
 	}
 	stsi(info, 15, 1, 2);
 	tl_to_cores(info);
+	update_cpu_core_map();
 	for_each_online_cpu(cpu) {
 		sysdev = get_cpu_sysdev(cpu);
 		kobject_uevent(&sysdev->kobj, KOBJ_CHANGE);
 	}
 }
 
-static void topology_work_fn(struct work_struct *work)
+static int topology_kthread(void *data)
 {
 	arch_reinit_sched_domains();
+	return 0;
+}
+
+static void topology_work_fn(struct work_struct *work)
+{
+	/* We can't call arch_reinit_sched_domains() from a multi-threaded
+	 * workqueue context since it may deadlock in case of cpu hotplug.
+	 * So we have to create a kernel thread in order to call
+	 * arch_reinit_sched_domains().
+	 */
+	kthread_run(topology_kthread, NULL, "topology_update");
 }
 
 void topology_schedule_update(void)
@@ -251,20 +275,23 @@ static int __init init_topology_update(void)
 {
 	int rc;
 
+	rc = 0;
 	if (!machine_has_topology) {
 		topology_update_polarization_simple();
-		return 0;
+		goto out;
 	}
 	init_timer_deferrable(&topology_timer);
 	if (machine_has_topology_irq) {
 		rc = register_external_interrupt(0x2005, topology_interrupt);
 		if (rc)
-			return rc;
+			goto out;
 		ctl_set_bit(0, 8);
 	}
 	else
 		set_topology_timer();
-	return 0;
+out:
+	update_cpu_core_map();
+	return rc;
 }
 __initcall(init_topology_update);
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 57b607b..4584d81 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -113,7 +113,7 @@ __show_trace(unsigned long sp, unsigned long low, unsigned long high)
 	}
 }
 
-void show_trace(struct task_struct *task, unsigned long *stack)
+static void show_trace(struct task_struct *task, unsigned long *stack)
 {
 	register unsigned long __r15 asm ("15");
 	unsigned long sp;
@@ -161,14 +161,14 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	show_trace(task, sp);
 }
 
-#ifdef CONFIG_64BIT
-void show_last_breaking_event(struct pt_regs *regs)
+static void show_last_breaking_event(struct pt_regs *regs)
 {
+#ifdef CONFIG_64BIT
 	printk("Last Breaking-Event-Address:\n");
 	printk(" [<%016lx>] ", regs->args[0] & PSW_ADDR_INSN);
 	print_symbol("%s\n", regs->args[0] & PSW_ADDR_INSN);
-}
 #endif
+}
 
 /*
  * The architecture-independent dump_stack generator
@@ -223,6 +223,24 @@ void show_registers(struct pt_regs *regs)
 	show_code(regs);
 }	
 
+void show_regs(struct pt_regs *regs)
+{
+	print_modules();
+	printk("CPU: %d %s %s %.*s\n",
+	       task_thread_info(current)->cpu, print_tainted(),
+	       init_utsname()->release,
+	       (int)strcspn(init_utsname()->version, " "),
+	       init_utsname()->version);
+	printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
+	       current->comm, current->pid, current,
+	       (void *) current->thread.ksp);
+	show_registers(regs);
+	/* Show stack backtrace if pt_regs is from kernel mode */
+	if (!(regs->psw.mask & PSW_MASK_PSTATE))
+		show_trace(NULL, (unsigned long *) regs->gprs[15]);
+	show_last_breaking_event(regs);
+}
+
 /* This is called from fs/proc/array.c */
 void task_show_regs(struct seq_file *m, struct task_struct *task)
 {
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 1465946..c02286c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -151,18 +151,9 @@ static int handle_chsc(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static unsigned int kvm_stfl(void)
-{
-	asm volatile(
-		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
-		"0:\n"
-		EX_TABLE(0b, 0b));
-	return S390_lowcore.stfl_fac_list;
-}
-
 static int handle_stfl(struct kvm_vcpu *vcpu)
 {
-	unsigned int facility_list = kvm_stfl();
+	unsigned int facility_list = stfl();
 	int rc;
 
 	vcpu->stat.instruction_stfl++;
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index 5208443..ab6735d 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -2,8 +2,6 @@
 # Makefile for s390-specific library files..
 #
 
-EXTRA_AFLAGS := -traditional
-
 lib-y += delay.o string.o uaccess_std.o uaccess_pt.o
 obj-$(CONFIG_32BIT) += div64.o qrnnd.o
 lib-$(CONFIG_64BIT) += uaccess_mvcos.o
diff --git a/arch/s390/lib/uaccess_mvcos.c b/arch/s390/lib/uaccess_mvcos.c
index 6d87723..3f15aaf 100644
--- a/arch/s390/lib/uaccess_mvcos.c
+++ b/arch/s390/lib/uaccess_mvcos.c
@@ -162,6 +162,7 @@ static size_t clear_user_mvcos(size_t size, void __user *to)
 	return size;
 }
 
+#ifdef CONFIG_S390_SWITCH_AMODE
 static size_t strnlen_user_mvcos(size_t count, const char __user *src)
 {
 	char buf[256];
@@ -199,6 +200,7 @@ static size_t strncpy_from_user_mvcos(size_t count, const char __user *src,
 	} while ((len_str == len) && (done < count));
 	return done;
 }
+#endif /* CONFIG_S390_SWITCH_AMODE */
 
 struct uaccess_ops uaccess_mvcos = {
 	.copy_from_user = copy_from_user_mvcos_check,
diff --git a/arch/s390/math-emu/Makefile b/arch/s390/math-emu/Makefile
index 73b3e72..c848903 100644
--- a/arch/s390/math-emu/Makefile
+++ b/arch/s390/math-emu/Makefile
@@ -5,4 +5,3 @@
 obj-$(CONFIG_MATHEMU) := math.o
 
 EXTRA_CFLAGS := -I$(src) -Iinclude/math-emu -w
-EXTRA_AFLAGS := -traditional
diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
index 6640193..fb988a4 100644
--- a/arch/s390/mm/Makefile
+++ b/arch/s390/mm/Makefile
@@ -4,4 +4,4 @@
 
 obj-y	 := init.o fault.o extmem.o mmap.o vmem.o pgtable.o
 obj-$(CONFIG_CMM) += cmm.o
-
+obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index ed2af0a..f231f5e 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -287,7 +287,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 	if (rc < 0)
 		goto out_free;
 
-	rc = add_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 
 	if (rc)
 		goto out_free;
@@ -351,7 +351,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 	release_resource(seg->res);
 	kfree(seg->res);
  out_shared:
-	remove_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
  out_free:
 	kfree(seg);
  out:
@@ -474,7 +474,7 @@ segment_modify_shared (char *name, int do_nonshared)
 	rc = 0;
 	goto out_unlock;
  out_del:
-	remove_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 	list_del(&seg->list);
 	dcss_diag(DCSS_PURGESEG, seg->dcss_name, &dummy, &dummy);
 	kfree(seg);
@@ -508,7 +508,7 @@ segment_unload(char *name)
 		goto out_unlock;
 	release_resource(seg->res);
 	kfree(seg->res);
-	remove_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 	list_del(&seg->list);
 	dcss_diag(DCSS_PURGESEG, seg->dcss_name, &dummy, &dummy);
 	kfree(seg);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2650f46..4d53720 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -28,6 +28,7 @@
 #include <linux/hardirq.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
+#include <linux/hugetlb.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/s390_ext.h>
@@ -367,6 +368,8 @@ good_area:
 	}
 
 survive:
+	if (is_vm_hugetlb_page(vma))
+		address &= HPAGE_MASK;
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
new file mode 100644
index 0000000..f4b6124
--- /dev/null
+++ b/arch/s390/mm/hugetlbpage.c
@@ -0,0 +1,134 @@
+/*
+ *  IBM System z Huge TLB Page Support for Kernel.
+ *
+ *    Copyright 2007 IBM Corp.
+ *    Author(s): Gerald Schaefer <gerald.schaefer@de.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *pteptr, pte_t pteval)
+{
+	pmd_t *pmdp = (pmd_t *) pteptr;
+	pte_t shadow_pteval = pteval;
+	unsigned long mask;
+
+	if (!MACHINE_HAS_HPAGE) {
+		pteptr = (pte_t *) pte_page(pteval)[1].index;
+		mask = pte_val(pteval) &
+				(_SEGMENT_ENTRY_INV | _SEGMENT_ENTRY_RO);
+		pte_val(pteval) = (_SEGMENT_ENTRY + __pa(pteptr)) | mask;
+		if (mm->context.noexec) {
+			pteptr += PTRS_PER_PTE;
+			pte_val(shadow_pteval) =
+					(_SEGMENT_ENTRY + __pa(pteptr)) | mask;
+		}
+	}
+
+	pmd_val(*pmdp) = pte_val(pteval);
+	if (mm->context.noexec) {
+		pmdp = get_shadow_table(pmdp);
+		pmd_val(*pmdp) = pte_val(shadow_pteval);
+	}
+}
+
+int arch_prepare_hugepage(struct page *page)
+{
+	unsigned long addr = page_to_phys(page);
+	pte_t pte;
+	pte_t *ptep;
+	int i;
+
+	if (MACHINE_HAS_HPAGE)
+		return 0;
+
+	ptep = (pte_t *) pte_alloc_one(&init_mm, address);
+	if (!ptep)
+		return -ENOMEM;
+
+	pte = mk_pte(page, PAGE_RW);
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		set_pte_at(&init_mm, addr + i * PAGE_SIZE, ptep + i, pte);
+		pte_val(pte) += PAGE_SIZE;
+	}
+	page[1].index = (unsigned long) ptep;
+	return 0;
+}
+
+void arch_release_hugepage(struct page *page)
+{
+	pte_t *ptep;
+
+	if (MACHINE_HAS_HPAGE)
+		return;
+
+	ptep = (pte_t *) page[1].index;
+	if (!ptep)
+		return;
+	pte_free(&init_mm, ptep);
+	page[1].index = 0;
+}
+
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp = NULL;
+
+	pgdp = pgd_offset(mm, addr);
+	pudp = pud_alloc(mm, pgdp, addr);
+	if (pudp)
+		pmdp = pmd_alloc(mm, pudp, addr);
+	return (pte_t *) pmdp;
+}
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp = NULL;
+
+	pgdp = pgd_offset(mm, addr);
+	if (pgd_present(*pgdp)) {
+		pudp = pud_offset(pgdp, addr);
+		if (pud_present(*pudp))
+			pmdp = pmd_offset(pudp, addr);
+	}
+	return (pte_t *) pmdp;
+}
+
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+{
+	return 0;
+}
+
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
+			      int write)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+int pmd_huge(pmd_t pmd)
+{
+	if (!MACHINE_HAS_HPAGE)
+		return 0;
+
+	return !!(pmd_val(pmd) & _SEGMENT_ENTRY_LARGE);
+}
+
+struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+			     pmd_t *pmdp, int write)
+{
+	struct page *page;
+
+	if (!MACHINE_HAS_HPAGE)
+		return NULL;
+
+	page = pmd_page(*pmdp);
+	if (page)
+		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
+	return page;
+}
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 202c952..fa31de6 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -77,28 +77,6 @@ void show_mem(void)
 	printk("%lu pages pagetables\n", global_page_state(NR_PAGETABLE));
 }
 
-static void __init setup_ro_region(void)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	pte_t new_pte;
-	unsigned long address, end;
-
-	address = ((unsigned long)&_stext) & PAGE_MASK;
-	end = PFN_ALIGN((unsigned long)&_eshared);
-
-	for (; address < end; address += PAGE_SIZE) {
-		pgd = pgd_offset_k(address);
-		pud = pud_offset(pgd, address);
-		pmd = pmd_offset(pud, address);
-		pte = pte_offset_kernel(pmd, address);
-		new_pte = mk_pte_phys(address, __pgprot(_PAGE_RO));
-		*pte = new_pte;
-	}
-}
-
 /*
  * paging_init() sets up the page tables
  */
@@ -121,7 +99,6 @@ void __init paging_init(void)
 	clear_table((unsigned long *) init_mm.pgd, pgd_type,
 		    sizeof(unsigned long)*2048);
 	vmem_map_init();
-	setup_ro_region();
 
         /* enable virtual mapping in kernel mode */
 	__ctl_load(S390_lowcore.kernel_asce, 1, 1);
@@ -129,6 +106,8 @@ void __init paging_init(void)
 	__ctl_load(S390_lowcore.kernel_asce, 13, 13);
 	__raw_local_irq_ssm(ssm_mask);
 
+	sparse_memory_present_with_active_regions(MAX_NUMNODES);
+	sparse_init();
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 35d90a4..beccacf 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -10,10 +10,12 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
+#include <asm/sections.h>
 
 static DEFINE_MUTEX(vmem_mutex);
 
@@ -25,43 +27,6 @@ struct memory_segment {
 
 static LIST_HEAD(mem_segs);
 
-void __meminit memmap_init(unsigned long size, int nid, unsigned long zone,
-			   unsigned long start_pfn)
-{
-	struct page *start, *end;
-	struct page *map_start, *map_end;
-	int i;
-
-	start = pfn_to_page(start_pfn);
-	end = start + size;
-
-	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
-		unsigned long cstart, cend;
-
-		cstart = PFN_DOWN(memory_chunk[i].addr);
-		cend = cstart + PFN_DOWN(memory_chunk[i].size);
-
-		map_start = mem_map + cstart;
-		map_end = mem_map + cend;
-
-		if (map_start < start)
-			map_start = start;
-		if (map_end > end)
-			map_end = end;
-
-		map_start -= ((unsigned long) map_start & (PAGE_SIZE - 1))
-			/ sizeof(struct page);
-		map_end += ((PFN_ALIGN((unsigned long) map_end)
-			     - (unsigned long) map_end)
-			    / sizeof(struct page));
-
-		if (map_start < map_end)
-			memmap_init_zone((unsigned long)(map_end - map_start),
-					 nid, zone, page_to_pfn(map_start),
-					 MEMMAP_EARLY);
-	}
-}
-
 static void __ref *vmem_alloc_pages(unsigned int order)
 {
 	if (slab_is_available())
@@ -77,8 +42,7 @@ static inline pud_t *vmem_pud_alloc(void)
 	pud = vmem_alloc_pages(2);
 	if (!pud)
 		return NULL;
-	pud_val(*pud) = _REGION3_ENTRY_EMPTY;
-	memcpy(pud + 1, pud, (PTRS_PER_PUD - 1)*sizeof(pud_t));
+	clear_table((unsigned long *) pud, _REGION3_ENTRY_EMPTY, PAGE_SIZE * 4);
 #endif
 	return pud;
 }
@@ -91,7 +55,7 @@ static inline pmd_t *vmem_pmd_alloc(void)
 	pmd = vmem_alloc_pages(2);
 	if (!pmd)
 		return NULL;
-	clear_table((unsigned long *) pmd, _SEGMENT_ENTRY_EMPTY, PAGE_SIZE*4);
+	clear_table((unsigned long *) pmd, _SEGMENT_ENTRY_EMPTY, PAGE_SIZE * 4);
 #endif
 	return pmd;
 }
@@ -114,7 +78,7 @@ static pte_t __init_refok *vmem_pte_alloc(void)
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
-static int vmem_add_range(unsigned long start, unsigned long size)
+static int vmem_add_mem(unsigned long start, unsigned long size, int ro)
 {
 	unsigned long address;
 	pgd_t *pg_dir;
@@ -141,7 +105,19 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 			pud_populate_kernel(&init_mm, pu_dir, pm_dir);
 		}
 
+		pte = mk_pte_phys(address, __pgprot(ro ? _PAGE_RO : 0));
 		pm_dir = pmd_offset(pu_dir, address);
+
+#ifdef __s390x__
+		if (MACHINE_HAS_HPAGE && !(address & ~HPAGE_MASK) &&
+		    (address + HPAGE_SIZE <= start + size) &&
+		    (address >= HPAGE_SIZE)) {
+			pte_val(pte) |= _SEGMENT_ENTRY_LARGE;
+			pmd_val(*pm_dir) = pte_val(pte);
+			address += HPAGE_SIZE - PAGE_SIZE;
+			continue;
+		}
+#endif
 		if (pmd_none(*pm_dir)) {
 			pt_dir = vmem_pte_alloc();
 			if (!pt_dir)
@@ -150,7 +126,6 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 		}
 
 		pt_dir = pte_offset_kernel(pm_dir, address);
-		pte = pfn_pte(address >> PAGE_SHIFT, PAGE_KERNEL);
 		*pt_dir = pte;
 	}
 	ret = 0;
@@ -181,6 +156,13 @@ static void vmem_remove_range(unsigned long start, unsigned long size)
 		pm_dir = pmd_offset(pu_dir, address);
 		if (pmd_none(*pm_dir))
 			continue;
+
+		if (pmd_huge(*pm_dir)) {
+			pmd_clear_kernel(pm_dir);
+			address += HPAGE_SIZE - PAGE_SIZE;
+			continue;
+		}
+
 		pt_dir = pte_offset_kernel(pm_dir, address);
 		*pt_dir = pte;
 	}
@@ -190,10 +172,9 @@ static void vmem_remove_range(unsigned long start, unsigned long size)
 /*
  * Add a backed mem_map array to the virtual mem_map array.
  */
-static int vmem_add_mem_map(unsigned long start, unsigned long size)
+int __meminit vmemmap_populate(struct page *start, unsigned long nr, int node)
 {
 	unsigned long address, start_addr, end_addr;
-	struct page *map_start, *map_end;
 	pgd_t *pg_dir;
 	pud_t *pu_dir;
 	pmd_t *pm_dir;
@@ -201,11 +182,8 @@ static int vmem_add_mem_map(unsigned long start, unsigned long size)
 	pte_t  pte;
 	int ret = -ENOMEM;
 
-	map_start = VMEM_MAP + PFN_DOWN(start);
-	map_end	= VMEM_MAP + PFN_DOWN(start + size);
-
-	start_addr = (unsigned long) map_start & PAGE_MASK;
-	end_addr = PFN_ALIGN((unsigned long) map_end);
+	start_addr = (unsigned long) start;
+	end_addr = (unsigned long) (start + nr);
 
 	for (address = start_addr; address < end_addr; address += PAGE_SIZE) {
 		pg_dir = pgd_offset_k(address);
@@ -249,16 +227,6 @@ out:
 	return ret;
 }
 
-static int vmem_add_mem(unsigned long start, unsigned long size)
-{
-	int ret;
-
-	ret = vmem_add_mem_map(start, size);
-	if (ret)
-		return ret;
-	return vmem_add_range(start, size);
-}
-
 /*
  * Add memory segment to the segment list if it doesn't overlap with
  * an already present segment.
@@ -296,7 +264,7 @@ static void __remove_shared_memory(struct memory_segment *seg)
 	vmem_remove_range(seg->start, seg->size);
 }
 
-int remove_shared_memory(unsigned long start, unsigned long size)
+int vmem_remove_mapping(unsigned long start, unsigned long size)
 {
 	struct memory_segment *seg;
 	int ret;
@@ -320,11 +288,9 @@ out:
 	return ret;
 }
 
-int add_shared_memory(unsigned long start, unsigned long size)
+int vmem_add_mapping(unsigned long start, unsigned long size)
 {
 	struct memory_segment *seg;
-	struct page *page;
-	unsigned long pfn, num_pfn, end_pfn;
 	int ret;
 
 	mutex_lock(&vmem_mutex);
@@ -339,24 +305,9 @@ int add_shared_memory(unsigned long start, unsigned long size)
 	if (ret)
 		goto out_free;
 
-	ret = vmem_add_mem(start, size);
+	ret = vmem_add_mem(start, size, 0);
 	if (ret)
 		goto out_remove;
-
-	pfn = PFN_DOWN(start);
-	num_pfn = PFN_DOWN(size);
-	end_pfn = pfn + num_pfn;
-
-	page = pfn_to_page(pfn);
-	memset(page, 0, num_pfn * sizeof(struct page));
-
-	for (; pfn < end_pfn; pfn++) {
-		page = pfn_to_page(pfn);
-		init_page_count(page);
-		reset_page_mapcount(page);
-		SetPageReserved(page);
-		INIT_LIST_HEAD(&page->lru);
-	}
 	goto out;
 
 out_remove:
@@ -375,14 +326,34 @@ out:
  */
 void __init vmem_map_init(void)
 {
+	unsigned long ro_start, ro_end;
+	unsigned long start, end;
 	int i;
 
 	INIT_LIST_HEAD(&init_mm.context.crst_list);
 	INIT_LIST_HEAD(&init_mm.context.pgtable_list);
 	init_mm.context.noexec = 0;
-	NODE_DATA(0)->node_mem_map = VMEM_MAP;
-	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++)
-		vmem_add_mem(memory_chunk[i].addr, memory_chunk[i].size);
+	ro_start = ((unsigned long)&_stext) & PAGE_MASK;
+	ro_end = PFN_ALIGN((unsigned long)&_eshared);
+	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
+		start = memory_chunk[i].addr;
+		end = memory_chunk[i].addr + memory_chunk[i].size;
+		if (start >= ro_end || end <= ro_start)
+			vmem_add_mem(start, end - start, 0);
+		else if (start >= ro_start && end <= ro_end)
+			vmem_add_mem(start, end - start, 1);
+		else if (start >= ro_start) {
+			vmem_add_mem(start, ro_end - start, 1);
+			vmem_add_mem(ro_end, end - ro_end, 0);
+		} else if (end < ro_end) {
+			vmem_add_mem(start, ro_start - start, 0);
+			vmem_add_mem(ro_start, end - ro_start, 1);
+		} else {
+			vmem_add_mem(start, ro_start - start, 0);
+			vmem_add_mem(ro_start, ro_end - ro_start, 1);
+			vmem_add_mem(ro_end, end - ro_end, 0);
+		}
+	}
 }
 
 /*
diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index b8f35bc..9e784d5 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -10,6 +10,7 @@
 #include <linux/cpu.h>
 #include <linux/sysdev.h>
 #include <linux/workqueue.h>
+#include <asm/smp.h>
 #include "sclp.h"
 
 #define TAG	"sclp_config: "
@@ -19,9 +20,11 @@ struct conf_mgm_data {
 	u8 ev_qualifier;
 } __attribute__((packed));
 
+#define EV_QUAL_CPU_CHANGE	1
 #define EV_QUAL_CAP_CHANGE	3
 
 static struct work_struct sclp_cpu_capability_work;
+static struct work_struct sclp_cpu_change_work;
 
 static void sclp_cpu_capability_notify(struct work_struct *work)
 {
@@ -37,13 +40,24 @@ static void sclp_cpu_capability_notify(struct work_struct *work)
 	put_online_cpus();
 }
 
+static void sclp_cpu_change_notify(struct work_struct *work)
+{
+	smp_rescan_cpus();
+}
+
 static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
 {
 	struct conf_mgm_data *cdata;
 
 	cdata = (struct conf_mgm_data *)(evbuf + 1);
-	if (cdata->ev_qualifier == EV_QUAL_CAP_CHANGE)
+	switch (cdata->ev_qualifier) {
+	case EV_QUAL_CPU_CHANGE:
+		schedule_work(&sclp_cpu_change_work);
+		break;
+	case EV_QUAL_CAP_CHANGE:
 		schedule_work(&sclp_cpu_capability_work);
+		break;
+	}
 }
 
 static struct sclp_register sclp_conf_register =
@@ -57,6 +71,7 @@ static int __init sclp_conf_init(void)
 	int rc;
 
 	INIT_WORK(&sclp_cpu_capability_work, sclp_cpu_capability_notify);
+	INIT_WORK(&sclp_cpu_change_work, sclp_cpu_change_notify);
 
 	rc = sclp_register(&sclp_conf_register);
 	if (rc) {
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index fe1ad17..85b2e51 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -318,7 +318,7 @@ ccwgroup_online_store (struct device *dev, struct device_attribute *attr, const
 {
 	struct ccwgroup_device *gdev;
 	struct ccwgroup_driver *gdrv;
-	unsigned int value;
+	unsigned long value;
 	int ret;
 
 	gdev = to_ccwgroupdev(dev);
@@ -329,7 +329,9 @@ ccwgroup_online_store (struct device *dev, struct device_attribute *attr, const
 	if (!try_module_get(gdrv->owner))
 		return -EINVAL;
 
-	value = simple_strtoul(buf, NULL, 0);
+	ret = strict_strtoul(buf, 0, &value);
+	if (ret)
+		goto out;
 	ret = count;
 	if (value == 1)
 		ccwgroup_set_online(gdev);
@@ -337,6 +339,7 @@ ccwgroup_online_store (struct device *dev, struct device_attribute *attr, const
 		ccwgroup_set_offline(gdev);
 	else
 		ret = -EINVAL;
+out:
 	module_put(gdrv->owner);
 	return ret;
 }
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 23ffcc4..08a5781 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -407,8 +407,7 @@ cio_modify (struct subchannel *sch)
 /*
  * Enable subchannel.
  */
-int cio_enable_subchannel(struct subchannel *sch, unsigned int isc,
-			  u32 intparm)
+int cio_enable_subchannel(struct subchannel *sch, u32 intparm)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -426,7 +425,7 @@ int cio_enable_subchannel(struct subchannel *sch, unsigned int isc,
 
 	for (retry = 5, ret = 0; retry > 0; retry--) {
 		sch->schib.pmcw.ena = 1;
-		sch->schib.pmcw.isc = isc;
+		sch->schib.pmcw.isc = sch->isc;
 		sch->schib.pmcw.intparm = intparm;
 		ret = cio_modify(sch);
 		if (ret == -ENODEV)
@@ -600,6 +599,7 @@ cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
 	else
 		sch->opm = chp_get_sch_opm(sch);
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
+	sch->isc = 3;
 
 	CIO_DEBUG(KERN_INFO, 0,
 		  "Detected device %04x on subchannel 0.%x.%04X"
@@ -610,13 +610,11 @@ cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
 
 	/*
 	 * We now have to initially ...
-	 *  ... set "interruption subclass"
 	 *  ... enable "concurrent sense"
 	 *  ... enable "multipath mode" if more than one
 	 *	  CHPID is available. This is done regardless
 	 *	  whether multiple paths are available for us.
 	 */
-	sch->schib.pmcw.isc = 3;	/* could be smth. else */
 	sch->schib.pmcw.csense = 1;	/* concurrent sense */
 	sch->schib.pmcw.ena = 0;
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
@@ -812,6 +810,7 @@ cio_probe_console(void)
 	 * enable console I/O-interrupt subclass 7
 	 */
 	ctl_set_bit(6, 24);
+	console_subchannel.isc = 7;
 	console_subchannel.schib.pmcw.isc = 7;
 	console_subchannel.schib.pmcw.intparm =
 		(u32)(addr_t)&console_subchannel;
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 08f2235..3c75412 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -74,6 +74,7 @@ struct subchannel {
 	__u8 lpm;		/* logical path mask */
 	__u8 opm;               /* operational path mask */
 	struct schib schib;	/* subchannel information block */
+	int isc; /* desired interruption subclass */
 	struct chsc_ssd_info ssd_info;	/* subchannel description */
 	struct device dev;	/* entry in device tree */
 	struct css_driver *driver;
@@ -85,7 +86,7 @@ struct subchannel {
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
 extern int cio_validate_subchannel (struct subchannel *, struct subchannel_id);
-extern int cio_enable_subchannel(struct subchannel *, unsigned int, u32);
+extern int cio_enable_subchannel(struct subchannel *, u32);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
 extern int cio_clear (struct subchannel *);
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index f4c132a..2808b68 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -1219,16 +1219,21 @@ static ssize_t cmb_enable_store(struct device *dev,
 {
 	struct ccw_device *cdev;
 	int ret;
+	unsigned long val;
+
+	ret = strict_strtoul(buf, 16, &val);
+	if (ret)
+		return ret;
 
 	cdev = to_ccwdev(dev);
 
-	switch (buf[0]) {
-	case '0':
+	switch (val) {
+	case 0:
 		ret = disable_cmf(cdev);
 		if (ret)
 			dev_info(&cdev->dev, "disable_cmf failed (%d)\n", ret);
 		break;
-	case '1':
+	case 1:
 		ret = enable_cmf(cdev);
 		if (ret && ret != -EBUSY)
 			dev_info(&cdev->dev, "enable_cmf failed (%d)\n", ret);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index c1afab5..595e327 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -705,13 +705,17 @@ css_cm_enable_store(struct device *dev, struct device_attribute *attr,
 {
 	struct channel_subsystem *css = to_css(dev);
 	int ret;
+	unsigned long val;
 
+	ret = strict_strtoul(buf, 16, &val);
+	if (ret)
+		return ret;
 	mutex_lock(&css->mutex);
-	switch (buf[0]) {
-	case '0':
+	switch (val) {
+	case 0:
 		ret = css->cm_enabled ? chsc_secm(css, 0) : 0;
 		break;
-	case '1':
+	case 1:
 		ret = css->cm_enabled ? 0 : chsc_secm(css, 1);
 		break;
 	default:
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index e0c7adb..abfd601 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -512,8 +512,8 @@ static ssize_t online_store (struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	int i, force;
-	char *tmp;
+	int force, ret;
+	unsigned long i;
 
 	if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
 		return -EAGAIN;
@@ -525,25 +525,30 @@ static ssize_t online_store (struct device *dev, struct device_attribute *attr,
 	if (!strncmp(buf, "force\n", count)) {
 		force = 1;
 		i = 1;
+		ret = 0;
 	} else {
 		force = 0;
-		i = simple_strtoul(buf, &tmp, 16);
+		ret = strict_strtoul(buf, 16, &i);
 	}
-
+	if (ret)
+		goto out;
 	switch (i) {
 	case 0:
 		online_store_handle_offline(cdev);
+		ret = count;
 		break;
 	case 1:
 		online_store_handle_online(cdev, force);
+		ret = count;
 		break;
 	default:
-		count = -EINVAL;
+		ret = -EINVAL;
 	}
+out:
 	if (cdev->drv)
 		module_put(cdev->drv->owner);
 	atomic_set(&cdev->private->onoff, 0);
-	return count;
+	return ret;
 }
 
 static ssize_t
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 4b92c84..99403b0 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -555,8 +555,7 @@ ccw_device_recognition(struct ccw_device *cdev)
 	    (cdev->private->state != DEV_STATE_BOXED))
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
-	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc,
-				    (u32)(addr_t)sch);
+	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
 	if (ret != 0)
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		return ret;
@@ -667,8 +666,7 @@ ccw_device_online(struct ccw_device *cdev)
 	sch = to_subchannel(cdev->dev.parent);
 	if (css_init_done && !get_device(&cdev->dev))
 		return -ENODEV;
-	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc,
-				    (u32)(addr_t)sch);
+	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
 	if (ret != 0) {
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		if (ret == -ENODEV)
@@ -1048,8 +1046,7 @@ ccw_device_start_id(struct ccw_device *cdev, enum dev_event dev_event)
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	if (cio_enable_subchannel(sch, sch->schib.pmcw.isc,
-				  (u32)(addr_t)sch) != 0)
+	if (cio_enable_subchannel(sch, (u32)(addr_t)sch) != 0)
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		return;
 
@@ -1082,7 +1079,6 @@ device_trigger_reprobe(struct subchannel *sch)
 	 */
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 	/* Re-set some bits in the pmcw that were lost. */
-	sch->schib.pmcw.isc = 3;
 	sch->schib.pmcw.csense = 1;
 	sch->schib.pmcw.ena = 0;
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index a1718a0..f308ad5 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -508,7 +508,7 @@ ccw_device_stlck(struct ccw_device *cdev)
 		return -ENOMEM;
 	}
 	spin_lock_irqsave(sch->lock, flags);
-	ret = cio_enable_subchannel(sch, 3, (u32)(addr_t)sch);
+	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
 	if (ret)
 		goto out_unlock;
 	/*
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 43876e2..445cf36 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -3663,11 +3663,11 @@ qdio_performance_stats_show(struct bus_type *bus, char *buf)
 static ssize_t
 qdio_performance_stats_store(struct bus_type *bus, const char *buf, size_t count)
 {
-	char *tmp;
-	int i;
+	unsigned long i;
+	int ret;
 
-	i = simple_strtoul(buf, &tmp, 16);
-	if ((i == 0) || (i == 1)) {
+	ret = strict_strtoul(buf, 16, &i);
+	if (!ret && ((i == 0) || (i == 1))) {
 		if (i == qdio_performance_stats)
 			return count;
 		qdio_performance_stats = i;
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index bbef376..47a7e62 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -17,6 +17,7 @@
 #include <linux/virtio_config.h>
 #include <linux/interrupt.h>
 #include <linux/virtio_ring.h>
+#include <linux/pfn.h>
 #include <asm/io.h>
 #include <asm/kvm_para.h>
 #include <asm/kvm_virtio.h>
@@ -180,11 +181,10 @@ static struct virtqueue *kvm_find_vq(struct virtio_device *vdev,
 
 	config = kvm_vq_config(kdev->desc)+index;
 
-	if (add_shared_memory(config->address,
-				vring_size(config->num, PAGE_SIZE))) {
-		err = -ENOMEM;
+	err = vmem_add_mapping(config->address,
+			       vring_size(config->num, PAGE_SIZE));
+	if (err)
 		goto out;
-	}
 
 	vq = vring_new_virtqueue(config->num, vdev, (void *) config->address,
 				 kvm_notify, callback);
@@ -202,8 +202,8 @@ static struct virtqueue *kvm_find_vq(struct virtio_device *vdev,
 	vq->priv = config;
 	return vq;
 unmap:
-	remove_shared_memory(config->address, vring_size(config->num,
-			     PAGE_SIZE));
+	vmem_remove_mapping(config->address,
+			    vring_size(config->num, PAGE_SIZE));
 out:
 	return ERR_PTR(err);
 }
@@ -213,8 +213,8 @@ static void kvm_del_vq(struct virtqueue *vq)
 	struct kvm_vqconfig *config = vq->priv;
 
 	vring_del_virtqueue(vq);
-	remove_shared_memory(config->address,
-			     vring_size(config->num, PAGE_SIZE));
+	vmem_remove_mapping(config->address,
+			    vring_size(config->num, PAGE_SIZE));
 }
 
 /*
@@ -318,12 +318,13 @@ static int __init kvm_devices_init(void)
 		return rc;
 	}
 
-	if (add_shared_memory((max_pfn) << PAGE_SHIFT, PAGE_SIZE)) {
+	rc = vmem_add_mapping(PFN_PHYS(max_pfn), PAGE_SIZE);
+	if (rc) {
 		device_unregister(&kvm_root);
-		return -ENOMEM;
+		return rc;
 	}
 
-	kvm_devices  = (void *) (max_pfn << PAGE_SHIFT);
+	kvm_devices = (void *) PFN_PHYS(max_pfn);
 
 	ctl_set_bit(0, 9);
 	register_external_interrupt(0x2603, kvm_extint_handler);
diff --git a/fs/Kconfig b/fs/Kconfig
index 2e43d46..cf12c40 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1005,7 +1005,8 @@ config TMPFS_POSIX_ACL
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || BROKEN
+	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || \
+		   (S390 && 64BIT) || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
diff --git a/include/asm-s390/hugetlb.h b/include/asm-s390/hugetlb.h
new file mode 100644
index 0000000..600a776
--- /dev/null
+++ b/include/asm-s390/hugetlb.h
@@ -0,0 +1,183 @@
+/*
+ *  IBM System z Huge TLB Page Support for Kernel.
+ *
+ *    Copyright IBM Corp. 2008
+ *    Author(s): Gerald Schaefer <gerald.schaefer@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_HUGETLB_H
+#define _ASM_S390_HUGETLB_H
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+
+#define is_hugepage_only_range(mm, addr, len)	0
+#define hugetlb_free_pgd_range			free_pgd_range
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte);
+
+/*
+ * If the arch doesn't supply something else, assume that hugepage
+ * size aligned regions are ok without further preparation.
+ */
+static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (len & ~HPAGE_MASK)
+		return -EINVAL;
+	if (addr & ~HPAGE_MASK)
+		return -EINVAL;
+	return 0;
+}
+
+#define hugetlb_prefault_arch_hook(mm)		do { } while (0)
+
+int arch_prepare_hugepage(struct page *page);
+void arch_release_hugepage(struct page *page);
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	/*
+	 * PROT_NONE needs to be remapped from the pte type to the ste type.
+	 * The HW invalid bit is also different for pte and ste. The pte
+	 * invalid bit happens to be the same as the ste _SEGMENT_ENTRY_LARGE
+	 * bit, so we don't have to clear it.
+	 */
+	if (pte_val(pte) & _PAGE_INVALID) {
+		if (pte_val(pte) & _PAGE_SWT)
+			pte_val(pte) |= _HPAGE_TYPE_NONE;
+		pte_val(pte) |= _SEGMENT_ENTRY_INV;
+	}
+	/*
+	 * Clear SW pte bits SWT and SWX, there are no SW bits in a segment
+	 * table entry.
+	 */
+	pte_val(pte) &= ~(_PAGE_SWT | _PAGE_SWX);
+	/*
+	 * Also set the change-override bit because we don't need dirty bit
+	 * tracking for hugetlbfs pages.
+	 */
+	pte_val(pte) |= (_SEGMENT_ENTRY_LARGE | _SEGMENT_ENTRY_CO);
+	return pte;
+}
+
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_RO;
+	return pte;
+}
+
+static inline int huge_pte_none(pte_t pte)
+{
+	return (pte_val(pte) & _SEGMENT_ENTRY_INV) &&
+		!(pte_val(pte) & _SEGMENT_ENTRY_RO);
+}
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	pte_t pte = *ptep;
+	unsigned long mask;
+
+	if (!MACHINE_HAS_HPAGE) {
+		ptep = (pte_t *) (pte_val(pte) & _SEGMENT_ENTRY_ORIGIN);
+		if (ptep) {
+			mask = pte_val(pte) &
+				(_SEGMENT_ENTRY_INV | _SEGMENT_ENTRY_RO);
+			pte = pte_mkhuge(*ptep);
+			pte_val(pte) |= mask;
+		}
+	}
+	return pte;
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	pte_t pte = huge_ptep_get(ptep);
+
+	pmd_clear((pmd_t *) ptep);
+	return pte;
+}
+
+static inline void __pmd_csp(pmd_t *pmdp)
+{
+	register unsigned long reg2 asm("2") = pmd_val(*pmdp);
+	register unsigned long reg3 asm("3") = pmd_val(*pmdp) |
+					       _SEGMENT_ENTRY_INV;
+	register unsigned long reg4 asm("4") = ((unsigned long) pmdp) + 5;
+
+	asm volatile(
+		"	csp %1,%3"
+		: "=m" (*pmdp)
+		: "d" (reg2), "d" (reg3), "d" (reg4), "m" (*pmdp) : "cc");
+	pmd_val(*pmdp) = _SEGMENT_ENTRY_INV | _SEGMENT_ENTRY;
+}
+
+static inline void __pmd_idte(unsigned long address, pmd_t *pmdp)
+{
+	unsigned long sto = (unsigned long) pmdp -
+				pmd_index(address) * sizeof(pmd_t);
+
+	if (!(pmd_val(*pmdp) & _SEGMENT_ENTRY_INV)) {
+		asm volatile(
+			"	.insn	rrf,0xb98e0000,%2,%3,0,0"
+			: "=m" (*pmdp)
+			: "m" (*pmdp), "a" (sto),
+			  "a" ((address & HPAGE_MASK))
+		);
+	}
+	pmd_val(*pmdp) = _SEGMENT_ENTRY_INV | _SEGMENT_ENTRY;
+}
+
+static inline void huge_ptep_invalidate(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep)
+{
+	pmd_t *pmdp = (pmd_t *) ptep;
+
+	if (!MACHINE_HAS_IDTE) {
+		__pmd_csp(pmdp);
+		if (mm->context.noexec) {
+			pmdp = get_shadow_table(pmdp);
+			__pmd_csp(pmdp);
+		}
+		return;
+	}
+
+	__pmd_idte(address, pmdp);
+	if (mm->context.noexec) {
+		pmdp = get_shadow_table(pmdp);
+		__pmd_idte(address, pmdp);
+	}
+	return;
+}
+
+#define huge_ptep_set_access_flags(__vma, __addr, __ptep, __entry, __dirty) \
+({									    \
+	int __changed = !pte_same(huge_ptep_get(__ptep), __entry);	    \
+	if (__changed) {						    \
+		huge_ptep_invalidate((__vma)->vm_mm, __addr, __ptep);	    \
+		set_huge_pte_at((__vma)->vm_mm, __addr, __ptep, __entry);   \
+	}								    \
+	__changed;							    \
+})
+
+#define huge_ptep_set_wrprotect(__mm, __addr, __ptep)			\
+({									\
+	pte_t __pte = huge_ptep_get(__ptep);				\
+	if (pte_write(__pte)) {						\
+		if (atomic_read(&(__mm)->mm_users) > 1 ||		\
+		    (__mm) != current->active_mm)			\
+			huge_ptep_invalidate(__mm, __addr, __ptep);	\
+		set_huge_pte_at(__mm, __addr, __ptep,			\
+				huge_pte_wrprotect(__pte));		\
+	}								\
+})
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	huge_ptep_invalidate(vma->vm_mm, address, ptep);
+}
+
+#endif /* _ASM_S390_HUGETLB_H */
diff --git a/include/asm-s390/page.h b/include/asm-s390/page.h
index fe7f92b..f0f4579 100644
--- a/include/asm-s390/page.h
+++ b/include/asm-s390/page.h
@@ -19,17 +19,34 @@
 #define PAGE_DEFAULT_ACC	0
 #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
 
+#define HPAGE_SHIFT	20
+#define HPAGE_SIZE	(1UL << HPAGE_SHIFT)
+#define HPAGE_MASK	(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
+#define ARCH_HAS_HUGE_PTE_TYPE
+#define ARCH_HAS_PREPARE_HUGEPAGE
+#define ARCH_HAS_HUGEPAGE_CLEAR_FLUSH
+
 #include <asm/setup.h>
 #ifndef __ASSEMBLY__
 
 static inline void clear_page(void *page)
 {
-	register unsigned long reg1 asm ("1") = 0;
-	register void *reg2 asm ("2") = page;
-	register unsigned long reg3 asm ("3") = 4096;
-	asm volatile(
-		"	mvcl	2,0"
-		: "+d" (reg2), "+d" (reg3) : "d" (reg1) : "memory", "cc");
+	if (MACHINE_HAS_PFMF) {
+		asm volatile(
+			"	.insn	rre,0xb9af0000,%0,%1"
+			: : "d" (0x10000), "a" (page) : "memory", "cc");
+	} else {
+		register unsigned long reg1 asm ("1") = 0;
+		register void *reg2 asm ("2") = page;
+		register unsigned long reg3 asm ("3") = 4096;
+		asm volatile(
+			"	mvcl	2,0"
+			: "+d" (reg2), "+d" (reg3) : "d" (reg1)
+			: "memory", "cc");
+	}
 }
 
 static inline void copy_page(void *to, void *from)
@@ -108,26 +125,6 @@ page_get_storage_key(unsigned long addr)
 	return skey;
 }
 
-extern unsigned long max_pfn;
-
-static inline int pfn_valid(unsigned long pfn)
-{
-	unsigned long dummy;
-	int ccode;
-
-	if (pfn >= max_pfn)
-		return 0;
-
-	asm volatile(
-		"	lra	%0,0(%2)\n"
-		"	ipm	%1\n"
-		"	srl	%1,28\n"
-		: "=d" (dummy), "=d" (ccode)
-		: "a" (pfn << PAGE_SHIFT)
-		: "cc");
-	return !ccode;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
diff --git a/include/asm-s390/pgtable.h b/include/asm-s390/pgtable.h
index f8347ce..c7f4f8e 100644
--- a/include/asm-s390/pgtable.h
+++ b/include/asm-s390/pgtable.h
@@ -129,7 +129,7 @@ extern char empty_zero_page[PAGE_SIZE];
 #define VMEM_MAX_PAGES	((VMEM_MAP_END - VMALLOC_END) / sizeof(struct page))
 #define VMEM_MAX_PFN	min(VMALLOC_START >> PAGE_SHIFT, VMEM_MAX_PAGES)
 #define VMEM_MAX_PHYS	((VMEM_MAX_PFN << PAGE_SHIFT) & ~((16 << 20) - 1))
-#define VMEM_MAP	((struct page *) VMALLOC_END)
+#define vmemmap		((struct page *) VMALLOC_END)
 
 /*
  * A 31 bit pagetable entry of S390 has following format:
@@ -234,6 +234,15 @@ extern char empty_zero_page[PAGE_SIZE];
 #define _PAGE_TYPE_EX_RW	0x002
 
 /*
+ * Only four types for huge pages, using the invalid bit and protection bit
+ * of a segment table entry.
+ */
+#define _HPAGE_TYPE_EMPTY	0x020	/* _SEGMENT_ENTRY_INV */
+#define _HPAGE_TYPE_NONE	0x220
+#define _HPAGE_TYPE_RO		0x200	/* _SEGMENT_ENTRY_RO  */
+#define _HPAGE_TYPE_RW		0x000
+
+/*
  * PTE type bits are rather complicated. handle_pte_fault uses pte_present,
  * pte_none and pte_file to find out the pte type WITHOUT holding the page
  * table lock. ptep_clear_flush on the other hand uses ptep_clear_flush to
@@ -325,6 +334,9 @@ extern char empty_zero_page[PAGE_SIZE];
 #define _SEGMENT_ENTRY		(0)
 #define _SEGMENT_ENTRY_EMPTY	(_SEGMENT_ENTRY_INV)
 
+#define _SEGMENT_ENTRY_LARGE	0x400	/* STE-format control, large page   */
+#define _SEGMENT_ENTRY_CO	0x100	/* change-recording override   */
+
 #endif /* __s390x__ */
 
 /*
@@ -1063,8 +1075,8 @@ static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 
 #define kern_addr_valid(addr)   (1)
 
-extern int add_shared_memory(unsigned long start, unsigned long size);
-extern int remove_shared_memory(unsigned long start, unsigned long size);
+extern int vmem_add_mapping(unsigned long start, unsigned long size);
+extern int vmem_remove_mapping(unsigned long start, unsigned long size);
 extern int s390_enable_sie(void);
 
 /*
@@ -1072,9 +1084,6 @@ extern int s390_enable_sie(void);
  */
 #define pgtable_cache_init()	do { } while (0)
 
-#define __HAVE_ARCH_MEMMAP_INIT
-extern void memmap_init(unsigned long, int, unsigned long, unsigned long);
-
 #include <asm-generic/pgtable.h>
 
 #endif /* _S390_PAGE_H */
diff --git a/include/asm-s390/processor.h b/include/asm-s390/processor.h
index 8eaf343..a00f79d 100644
--- a/include/asm-s390/processor.h
+++ b/include/asm-s390/processor.h
@@ -172,16 +172,7 @@ extern unsigned long thread_saved_pc(struct task_struct *t);
  */
 extern void task_show_regs(struct seq_file *m, struct task_struct *task);
 
-extern void show_registers(struct pt_regs *regs);
 extern void show_code(struct pt_regs *regs);
-extern void show_trace(struct task_struct *task, unsigned long *sp);
-#ifdef CONFIG_64BIT
-extern void show_last_breaking_event(struct pt_regs *regs);
-#else
-static inline void show_last_breaking_event(struct pt_regs *regs)
-{
-}
-#endif
 
 unsigned long get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \
diff --git a/include/asm-s390/ptrace.h b/include/asm-s390/ptrace.h
index 61f6952..441d7c2 100644
--- a/include/asm-s390/ptrace.h
+++ b/include/asm-s390/ptrace.h
@@ -463,8 +463,6 @@ struct user_regs_struct
 };
 
 #ifdef __KERNEL__
-#define __ARCH_SYS_PTRACE	1
-
 /*
  * These are defined as per linux/ptrace.h, which see.
  */
diff --git a/include/asm-s390/setup.h b/include/asm-s390/setup.h
index aaf4b51..ba69674 100644
--- a/include/asm-s390/setup.h
+++ b/include/asm-s390/setup.h
@@ -59,23 +59,42 @@ extern unsigned int s390_noexec;
  */
 extern unsigned long machine_flags;
 
-#define MACHINE_IS_VM		(machine_flags & 1)
-#define MACHINE_IS_P390		(machine_flags & 4)
-#define MACHINE_HAS_MVPG	(machine_flags & 16)
-#define MACHINE_IS_KVM		(machine_flags & 64)
-#define MACHINE_HAS_IDTE	(machine_flags & 128)
-#define MACHINE_HAS_DIAG9C	(machine_flags & 256)
+#define MACHINE_FLAG_VM		(1UL << 0)
+#define MACHINE_FLAG_IEEE	(1UL << 1)
+#define MACHINE_FLAG_P390	(1UL << 2)
+#define MACHINE_FLAG_CSP	(1UL << 3)
+#define MACHINE_FLAG_MVPG	(1UL << 4)
+#define MACHINE_FLAG_DIAG44	(1UL << 5)
+#define MACHINE_FLAG_IDTE	(1UL << 6)
+#define MACHINE_FLAG_DIAG9C	(1UL << 7)
+#define MACHINE_FLAG_MVCOS	(1UL << 8)
+#define MACHINE_FLAG_KVM	(1UL << 9)
+#define MACHINE_FLAG_HPAGE	(1UL << 10)
+#define MACHINE_FLAG_PFMF	(1UL << 11)
+
+#define MACHINE_IS_VM		(machine_flags & MACHINE_FLAG_VM)
+#define MACHINE_IS_KVM		(machine_flags & MACHINE_FLAG_KVM)
+#define MACHINE_IS_P390		(machine_flags & MACHINE_FLAG_P390)
+#define MACHINE_HAS_DIAG9C	(machine_flags & MACHINE_FLAG_DIAG9C)
 
 #ifndef __s390x__
-#define MACHINE_HAS_IEEE	(machine_flags & 2)
-#define MACHINE_HAS_CSP		(machine_flags & 8)
+#define MACHINE_HAS_IEEE	(machine_flags & MACHINE_FLAG_IEEE)
+#define MACHINE_HAS_CSP		(machine_flags & MACHINE_FLAG_CSP)
+#define MACHINE_HAS_IDTE	(0)
 #define MACHINE_HAS_DIAG44	(1)
+#define MACHINE_HAS_MVPG	(machine_flags & MACHINE_FLAG_MVPG)
 #define MACHINE_HAS_MVCOS	(0)
+#define MACHINE_HAS_HPAGE	(0)
+#define MACHINE_HAS_PFMF	(0)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
-#define MACHINE_HAS_DIAG44	(machine_flags & 32)
-#define MACHINE_HAS_MVCOS	(machine_flags & 512)
+#define MACHINE_HAS_IDTE	(machine_flags & MACHINE_FLAG_IDTE)
+#define MACHINE_HAS_DIAG44	(machine_flags & MACHINE_FLAG_DIAG44)
+#define MACHINE_HAS_MVPG	(1)
+#define MACHINE_HAS_MVCOS	(machine_flags & MACHINE_FLAG_MVCOS)
+#define MACHINE_HAS_HPAGE	(machine_flags & MACHINE_FLAG_HPAGE)
+#define MACHINE_HAS_PFMF	(machine_flags & MACHINE_FLAG_PFMF)
 #endif /* __s390x__ */
 
 #define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
diff --git a/include/asm-s390/smp.h b/include/asm-s390/smp.h
index 6f3821a..ae89cf2 100644
--- a/include/asm-s390/smp.h
+++ b/include/asm-s390/smp.h
@@ -19,6 +19,7 @@
 #include <asm/lowcore.h>
 #include <asm/sigp.h>
 #include <asm/ptrace.h>
+#include <asm/system.h>
 
 /*
   s390 specific smp.c headers
@@ -53,10 +54,7 @@ extern void machine_power_off_smp(void);
 
 static inline __u16 hard_smp_processor_id(void)
 {
-        __u16 cpu_address;
- 
-	asm volatile("stap %0" : "=m" (cpu_address));
-        return cpu_address;
+	return stap();
 }
 
 /*
@@ -108,5 +106,11 @@ static inline void smp_send_stop(void)
 #define smp_cpu_not_running(cpu)	1
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int smp_rescan_cpus(void);
+#else
+static inline int smp_rescan_cpus(void) { return 0; }
+#endif
+
 extern union save_area *zfcpdump_save_areas[NR_CPUS + 1];
 #endif
diff --git a/include/asm-s390/sparsemem.h b/include/asm-s390/sparsemem.h
new file mode 100644
index 0000000..06dfdab
--- /dev/null
+++ b/include/asm-s390/sparsemem.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_S390_SPARSEMEM_H
+#define _ASM_S390_SPARSEMEM_H
+
+#define SECTION_SIZE_BITS	25
+
+#ifdef CONFIG_64BIT
+
+#define MAX_PHYSADDR_BITS	42
+#define MAX_PHYSMEM_BITS	42
+
+#else
+
+#define MAX_PHYSADDR_BITS	31
+#define MAX_PHYSMEM_BITS	31
+
+#endif /* CONFIG_64BIT */
+
+#endif /* _ASM_S390_SPARSEMEM_H */
diff --git a/include/asm-s390/sysinfo.h b/include/asm-s390/sysinfo.h
index abe10ae..79d0134 100644
--- a/include/asm-s390/sysinfo.h
+++ b/include/asm-s390/sysinfo.h
@@ -11,6 +11,9 @@
  *		 Christian Borntraeger <borntraeger@de.ibm.com>
  */
 
+#ifndef __ASM_S390_SYSINFO_H
+#define __ASM_S390_SYSINFO_H
+
 struct sysinfo_1_1_1 {
 	char reserved_0[32];
 	char manufacturer[16];
@@ -114,3 +117,5 @@ static inline int stsi(void *sysinfo, int fc, int sel1, int sel2)
 		: "cc", "memory");
 	return r0;
 }
+
+#endif /* __ASM_S390_SYSINFO_H */
diff --git a/include/asm-s390/system.h b/include/asm-s390/system.h
index 92098df..c819ae2 100644
--- a/include/asm-s390/system.h
+++ b/include/asm-s390/system.h
@@ -16,6 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/setup.h>
 #include <asm/processor.h>
+#include <asm/lowcore.h>
 
 #ifdef __KERNEL__
 
@@ -422,6 +423,23 @@ extern void smp_ctl_clear_bit(int cr, int bit);
 
 #endif /* CONFIG_SMP */
 
+static inline unsigned int stfl(void)
+{
+	asm volatile(
+		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
+		"0:\n"
+		EX_TABLE(0b,0b));
+	return S390_lowcore.stfl_fac_list;
+}
+
+static inline unsigned short stap(void)
+{
+	unsigned short cpu_address;
+
+	asm volatile("stap %0" : "=m" (cpu_address));
+	return cpu_address;
+}
+
 extern void (*_machine_restart)(char *command);
 extern void (*_machine_halt)(void);
 extern void (*_machine_power_off)(void);
diff --git a/include/asm-s390/tlbflush.h b/include/asm-s390/tlbflush.h
index 9e57a93..d60394b 100644
--- a/include/asm-s390/tlbflush.h
+++ b/include/asm-s390/tlbflush.h
@@ -2,6 +2,7 @@
 #define _S390_TLBFLUSH_H
 
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <asm/processor.h>
 #include <asm/pgalloc.h>
 
diff --git a/include/asm-s390/topology.h b/include/asm-s390/topology.h
index 8e97b06..d96c916 100644
--- a/include/asm-s390/topology.h
+++ b/include/asm-s390/topology.h
@@ -7,6 +7,10 @@
 
 cpumask_t cpu_coregroup_map(unsigned int cpu);
 
+extern cpumask_t cpu_core_map[NR_CPUS];
+
+#define topology_core_siblings(cpu)	(cpu_core_map[cpu])
+
 int topology_set_cpu_management(int fc);
 void topology_schedule_update(void);
 
