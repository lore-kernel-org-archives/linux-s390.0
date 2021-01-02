Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbhABPOy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 Jan 2021 10:14:54 -0500
Date: Sat, 2 Jan 2021 16:14:04 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.11-rc2
Message-ID: <your-ad-here.call-01609600444-ext-3658@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.11-rc2.

Thank you,
Vasily

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-3

for you to fetch changes up to 129975e75b9a2ba528d7f58be2e338cd644f6ed8:

  s390/Kconfig: sort config S390 select list once again (2020-12-30 17:08:53 +0100)

----------------------------------------------------------------
- Update defconfigs and sort config select list.

----------------------------------------------------------------
Heiko Carstens (2):
      s390: update defconfigs
      s390/Kconfig: sort config S390 select list once again

 arch/s390/Kconfig                    | 31 +++++++++++++++++--------------
 arch/s390/configs/debug_defconfig    | 12 +++++++++---
 arch/s390/configs/defconfig          | 11 +++++++----
 arch/s390/configs/zfcpdump_defconfig |  2 ++
 4 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e84bdd15150b..c72874f09741 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -54,17 +54,23 @@ config KASAN_SHADOW_OFFSET
 
 config S390
 	def_bool y
+	#
+	# Note: keep this list sorted alphabetically
+	#
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SCALED_CPUTIME
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
@@ -111,8 +117,10 @@ config S390
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
+	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select DMA_OPS if PCI
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
+	select GENERIC_ALLOCATOR
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_FIND_FIRST_BIT
@@ -126,22 +134,21 @@ config S390
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_VMALLOC
-	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_EBPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
-	select HAVE_FAST_GUP
+	select HAVE_EBPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FAST_GUP
 	select HAVE_FENTRY
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ERROR_INJECTION
@@ -163,16 +170,15 @@ config S390
 	select HAVE_KRETPROBES
 	select HAVE_KVM
 	select HAVE_LIVEPATCH
-	select HAVE_PERF_REGS
-	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_MEMBLOCK_PHYS_MAP
-	select MMU_GATHER_NO_GATHER
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NMI
 	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
-	select MMU_GATHER_RCU_TABLE_FREE
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
@@ -181,6 +187,8 @@ config S390
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
+	select MMU_GATHER_NO_GATHER
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_SG_DMA_LENGTH	if PCI
@@ -190,17 +198,12 @@ config S390
 	select PCI_MSI			if PCI
 	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
 	select SPARSE_IRQ
+	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TTY
 	select VIRT_CPU_ACCOUNTING
-	select ARCH_HAS_SCALED_CPUTIME
-	select HAVE_NMI
-	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
-	select SWIOTLB
-	select GENERIC_ALLOCATOR
-	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
-
+	# Note: keep the above list sorted alphabetically
 
 config SCHED_OMIT_FRAME_POINTER
 	def_bool y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 1be32fcf6f2e..c4f6ff98a612 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -61,7 +61,9 @@ CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_STATIC_KEYS_SELFTEST=y
+CONFIG_SECCOMP_CACHE_DEBUG=y
 CONFIG_LOCK_EVENT_COUNTS=y
+# CONFIG_GCC_PLUGINS is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
@@ -410,12 +412,12 @@ CONFIG_SCSI_ENCLOSURE=m
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SPI_ATTRS=m
-CONFIG_SCSI_FC_ATTRS=y
+CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
 CONFIG_SCSI_SRP_ATTRS=m
 CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_DEBUG=m
-CONFIG_ZFCP=y
+CONFIG_ZFCP=m
 CONFIG_SCSI_VIRTIO=m
 CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
@@ -444,6 +446,7 @@ CONFIG_DM_MULTIPATH=m
 CONFIG_DM_MULTIPATH_QL=m
 CONFIG_DM_MULTIPATH_ST=m
 CONFIG_DM_MULTIPATH_HST=m
+CONFIG_DM_MULTIPATH_IOA=m
 CONFIG_DM_DELAY=m
 CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
@@ -542,7 +545,6 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
-CONFIG_NULL_TTY=m
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
@@ -574,6 +576,7 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
+# CONFIG_SURFACE_PLATFORMS is not set
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -655,6 +658,7 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CIFS_DFS_UPCALL=y
+CONFIG_CIFS_SWN_UPCALL=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
@@ -826,6 +830,8 @@ CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_FTRACE_STARTUP_TEST=y
+# CONFIG_EVENT_TRACE_STARTUP_TEST is not set
 CONFIG_DEBUG_USER_ASCE=y
 CONFIG_NOTIFIER_ERROR_INJECTION=m
 CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index e2171a008809..51135893cffe 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -58,6 +58,7 @@ CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
+# CONFIG_GCC_PLUGINS is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
@@ -95,7 +96,6 @@ CONFIG_ZSMALLOC_STAT=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
 CONFIG_IDLE_PAGE_TRACKING=y
 CONFIG_PERCPU_STATS=y
-CONFIG_GUP_TEST=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=m
@@ -403,12 +403,12 @@ CONFIG_SCSI_ENCLOSURE=m
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SPI_ATTRS=m
-CONFIG_SCSI_FC_ATTRS=y
+CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
 CONFIG_SCSI_SRP_ATTRS=m
 CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_DEBUG=m
-CONFIG_ZFCP=y
+CONFIG_ZFCP=m
 CONFIG_SCSI_VIRTIO=m
 CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
@@ -437,6 +437,7 @@ CONFIG_DM_MULTIPATH=m
 CONFIG_DM_MULTIPATH_QL=m
 CONFIG_DM_MULTIPATH_ST=m
 CONFIG_DM_MULTIPATH_HST=m
+CONFIG_DM_MULTIPATH_IOA=m
 CONFIG_DM_DELAY=m
 CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
@@ -536,7 +537,6 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
-CONFIG_NULL_TTY=m
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
@@ -568,6 +568,7 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
+# CONFIG_SURFACE_PLATFORMS is not set
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -645,6 +646,7 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CIFS_DFS_UPCALL=y
+CONFIG_CIFS_SWN_UPCALL=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
@@ -778,6 +780,7 @@ CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_DEBUG_USER_ASCE=y
 CONFIG_LKDTM=m
 CONFIG_PERCPU_TEST=m
 CONFIG_ATOMIC64_SELFTEST=y
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index a302630341ef..1ef211dae77a 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -22,6 +22,7 @@ CONFIG_CRASH_DUMP=y
 # CONFIG_VIRTUALIZATION is not set
 # CONFIG_S390_GUEST is not set
 # CONFIG_SECCOMP is not set
+# CONFIG_GCC_PLUGINS is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IBM_PARTITION=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -58,6 +59,7 @@ CONFIG_RAW_DRIVER=y
 # CONFIG_HID is not set
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
+# CONFIG_SURFACE_PLATFORMS is not set
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
