Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 9 Nov 2018 08:14:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.20 #2
Message-Id: <20181109081402.777716d1@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull s390 fixes for 4.20-rc2

The following changes since commit e5f6d9afa3415104e402cd69288bb03f7165eeba:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2018-10-25 18:14:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git s390-4.20-2

for you to fetch changes up to 0bb2ae1b26e1fb7543ec7474cdd374ac4b88c4da:

  s390/perf: Change CPUM_CF return code in event init function (2018-11-08 07:58:16 +0100)

----------------------------------------------------------------
s390 updates for 4.20-rc2

 - A fix for the pgtable_bytes misaccounting on s390. The patch changes
   common code part in regard to page table folding and adds extra
   checks to mm_[inc|dec]_nr_[pmds|puds].

 - Add FORCE for all build targets using if_changed

 - Use non-loadable phdr for the .vmlinux.info section to avoid
   a segment overlap that confuses kexec

 - Cleanup the attribute definition for the diagnostic sampling

 - Increase stack size for CONFIG_KASAN=y builds

 - Export __node_distance to fix a build error

 - Correct return code of a PMU event init function

 - An update for the default configs

----------------------------------------------------------------
Heiko Carstens (1):
      s390: update defconfigs

Justin M. Forbes (1):
      s390/mm: Fix ERROR: "__node_distance" undefined!

Martin Schwidefsky (4):
      mm: make the __PAGETABLE_PxD_FOLDED defines non-empty
      mm: introduce mm_[p4d|pud|pmd]_folded
      mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
      s390/mm: fix mis-accounting of pgtable_bytes

Thomas Richter (2):
      s390/cpum_sf: Rework attribute definition for diagnostic sampling
      s390/perf: Change CPUM_CF return code in event init function

Vasily Gorbik (4):
      s390/decompressor: add missing FORCE to build targets
      s390/vdso: add missing FORCE to build targets
      s390: avoid vmlinux segments overlap
      s390/kasan: increase instrumented stack size to 64k

 arch/arm/include/asm/pgtable-2level.h    |  2 +-
 arch/m68k/include/asm/pgtable_mm.h       |  4 +-
 arch/microblaze/include/asm/pgtable.h    |  2 +-
 arch/nds32/include/asm/pgtable.h         |  2 +-
 arch/parisc/include/asm/pgtable.h        |  2 +-
 arch/s390/Makefile                       |  2 +-
 arch/s390/boot/compressed/Makefile       | 16 +++----
 arch/s390/configs/debug_defconfig        | 14 ++++--
 arch/s390/configs/performance_defconfig  | 13 +++++-
 arch/s390/defconfig                      | 79 +++++++++++++++++---------------
 arch/s390/include/asm/mmu_context.h      |  5 --
 arch/s390/include/asm/pgalloc.h          |  6 +--
 arch/s390/include/asm/pgtable.h          | 18 ++++++++
 arch/s390/include/asm/thread_info.h      |  2 +-
 arch/s390/include/asm/tlb.h              |  6 +--
 arch/s390/kernel/entry.S                 |  6 +--
 arch/s390/kernel/perf_cpum_cf.c          |  2 +-
 arch/s390/kernel/perf_cpum_sf.c          | 33 +++++++++++--
 arch/s390/kernel/vdso32/Makefile         |  6 +--
 arch/s390/kernel/vdso64/Makefile         |  6 +--
 arch/s390/kernel/vmlinux.lds.S           |  4 +-
 arch/s390/mm/pgalloc.c                   |  1 +
 arch/s390/numa/numa.c                    |  1 +
 include/asm-generic/4level-fixup.h       |  2 +-
 include/asm-generic/5level-fixup.h       |  2 +-
 include/asm-generic/pgtable-nop4d-hack.h |  2 +-
 include/asm-generic/pgtable-nop4d.h      |  2 +-
 include/asm-generic/pgtable-nopmd.h      |  2 +-
 include/asm-generic/pgtable-nopud.h      |  2 +-
 include/asm-generic/pgtable.h            | 16 +++++++
 include/linux/mm.h                       |  8 ++++
 31 files changed, 175 insertions(+), 93 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8..12659ce 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -10,7 +10,7 @@
 #ifndef _ASM_PGTABLE_2LEVEL_H
 #define _ASM_PGTABLE_2LEVEL_H
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 /*
  * Hardware-wise, we have a two level page table structure, where the first
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 6181e41..fe3ddd7 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -55,12 +55,12 @@
  */
 #ifdef CONFIG_SUN3
 #define PTRS_PER_PTE   16
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define PTRS_PER_PMD   1
 #define PTRS_PER_PGD   2048
 #elif defined(CONFIG_COLDFIRE)
 #define PTRS_PER_PTE	512
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #else
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index f64ebb9..e14b662 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -63,7 +63,7 @@ extern int mem_init_done;
 
 #include <asm-generic/4level-fixup.h>
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index d3e19a5..9f52db9 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -4,7 +4,7 @@
 #ifndef _ASMNDS32_PGTABLE_H
 #define _ASMNDS32_PGTABLE_H
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #include <asm-generic/4level-fixup.h>
 #include <asm-generic/sizes.h>
 
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index b941ac7..c7bb74e 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -111,7 +111,7 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 #if CONFIG_PGTABLE_LEVELS == 3
 #define BITS_PER_PMD	(PAGE_SHIFT + PMD_ORDER - BITS_PER_PMD_ENTRY)
 #else
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define BITS_PER_PMD	0
 #endif
 #define PTRS_PER_PMD    (1UL << BITS_PER_PMD)
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 0b33577..e21053e 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -27,7 +27,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 UTS_MACHINE	:= s390x
-STACK_SIZE	:= $(if $(CONFIG_KASAN),32768,16384)
+STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,16384)
 CHECKFLAGS	+= -D__s390__ -D__s390x__
 
 export LD_BFD
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 5930396..b1bdd15 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -22,10 +22,10 @@ OBJCOPYFLAGS :=
 OBJECTS := $(addprefix $(obj)/,$(obj-y))
 
 LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup -T
-$(obj)/vmlinux: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OBJECTS)
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OBJECTS) FORCE
 	$(call if_changed,ld)
 
-OBJCOPYFLAGS_info.bin := -O binary --only-section=.vmlinux.info
+OBJCOPYFLAGS_info.bin := -O binary --only-section=.vmlinux.info --set-section-flags .vmlinux.info=load
 $(obj)/info.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
@@ -46,17 +46,17 @@ suffix-$(CONFIG_KERNEL_LZMA)  := .lzma
 suffix-$(CONFIG_KERNEL_LZO)  := .lzo
 suffix-$(CONFIG_KERNEL_XZ)  := .xz
 
-$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lz4)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzma)
-$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzo)
-$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,xzkern)
 
 OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section .data=.vmlinux.bin.compressed
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 259d169..c69cb04 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -64,6 +64,8 @@ CONFIG_NUMA=y
 CONFIG_PREEMPT=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
+CONFIG_EXPOLINE=y
+CONFIG_EXPOLINE_AUTO=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
@@ -84,9 +86,11 @@ CONFIG_PCI_DEBUG=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_CHSC_SCH=y
+CONFIG_VFIO_AP=m
 CONFIG_CRASH_DUMP=y
 CONFIG_BINFMT_MISC=m
 CONFIG_HIBERNATION=y
+CONFIG_PM_DEBUG=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=m
@@ -161,8 +165,6 @@ CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
 CONFIG_NF_CT_NETLINK_TIMEOUT=m
 CONFIG_NF_TABLES=m
-CONFIG_NFT_EXTHDR=m
-CONFIG_NFT_META=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_LOG=m
@@ -365,6 +367,8 @@ CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_ACT_CSUM=m
 CONFIG_DNS_RESOLVER=y
 CONFIG_OPENVSWITCH=m
+CONFIG_VSOCKETS=m
+CONFIG_VIRTIO_VSOCKETS=m
 CONFIG_NETLINK_DIAG=m
 CONFIG_CGROUP_NET_PRIO=y
 CONFIG_BPF_JIT=y
@@ -461,6 +465,7 @@ CONFIG_PPTP=m
 CONFIG_PPPOL2TP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
+CONFIG_ISM=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -486,9 +491,12 @@ CONFIG_MLX4_INFINIBAND=m
 CONFIG_MLX5_INFINIBAND=m
 CONFIG_VFIO=m
 CONFIG_VFIO_PCI=m
+CONFIG_VFIO_MDEV=m
+CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
+CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
@@ -615,7 +623,6 @@ CONFIG_DEBUG_CREDENTIALS=y
 CONFIG_RCU_TORTURE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=300
 CONFIG_NOTIFIER_ERROR_INJECTION=m
-CONFIG_PM_NOTIFIER_ERROR_INJECT=m
 CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAILSLAB=y
@@ -727,3 +734,4 @@ CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
 CONFIG_KVM_S390_UCONTROL=y
 CONFIG_VHOST_NET=m
+CONFIG_VHOST_VSOCK=m
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index 37fd60c..32f539d 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -65,6 +65,8 @@ CONFIG_NR_CPUS=512
 CONFIG_NUMA=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
+CONFIG_EXPOLINE=y
+CONFIG_EXPOLINE_AUTO=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
@@ -82,9 +84,11 @@ CONFIG_PCI=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_CHSC_SCH=y
+CONFIG_VFIO_AP=m
 CONFIG_CRASH_DUMP=y
 CONFIG_BINFMT_MISC=m
 CONFIG_HIBERNATION=y
+CONFIG_PM_DEBUG=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=m
@@ -159,8 +163,6 @@ CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
 CONFIG_NF_CT_NETLINK_TIMEOUT=m
 CONFIG_NF_TABLES=m
-CONFIG_NFT_EXTHDR=m
-CONFIG_NFT_META=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_LOG=m
@@ -362,6 +364,8 @@ CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_ACT_CSUM=m
 CONFIG_DNS_RESOLVER=y
 CONFIG_OPENVSWITCH=m
+CONFIG_VSOCKETS=m
+CONFIG_VIRTIO_VSOCKETS=m
 CONFIG_NETLINK_DIAG=m
 CONFIG_CGROUP_NET_PRIO=y
 CONFIG_BPF_JIT=y
@@ -458,6 +462,7 @@ CONFIG_PPTP=m
 CONFIG_PPPOL2TP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
+CONFIG_ISM=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -483,9 +488,12 @@ CONFIG_MLX4_INFINIBAND=m
 CONFIG_MLX5_INFINIBAND=m
 CONFIG_VFIO=m
 CONFIG_VFIO_PCI=m
+CONFIG_VFIO_MDEV=m
+CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
+CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
@@ -666,3 +674,4 @@ CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
 CONFIG_KVM_S390_UCONTROL=y
 CONFIG_VHOST_NET=m
+CONFIG_VHOST_VSOCK=m
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index 7cb6a52..4d58a92 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -26,14 +26,23 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
-CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_USERFAULTFD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+CONFIG_LIVEPATCH=y
+CONFIG_NR_CPUS=256
+CONFIG_NUMA=y
+CONFIG_HZ_100=y
+CONFIG_KEXEC_FILE=y
+CONFIG_CRASH_DUMP=y
+CONFIG_HIBERNATION=y
+CONFIG_PM_DEBUG=y
+CONFIG_CMM=m
 CONFIG_OPROFILE=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
@@ -44,11 +53,7 @@ CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IBM_PARTITION=y
 CONFIG_DEFAULT_DEADLINE=y
-CONFIG_LIVEPATCH=y
-CONFIG_NR_CPUS=256
-CONFIG_NUMA=y
-CONFIG_HZ_100=y
-CONFIG_KEXEC_FILE=y
+CONFIG_BINFMT_MISC=m
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
@@ -60,9 +65,6 @@ CONFIG_ZBUD=m
 CONFIG_ZSMALLOC=m
 CONFIG_ZSMALLOC_STAT=y
 CONFIG_IDLE_PAGE_TRACKING=y
-CONFIG_CRASH_DUMP=y
-CONFIG_BINFMT_MISC=m
-CONFIG_HIBERNATION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -98,6 +100,7 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_SCSI=y
+# CONFIG_SCSI_MQ_DEFAULT is not set
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
@@ -131,6 +134,7 @@ CONFIG_EQUALIZER=m
 CONFIG_TUN=m
 CONFIG_VIRTIO_NET=y
 # CONFIG_NET_VENDOR_ALACRITECH is not set
+# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_CORTINA is not set
 # CONFIG_NET_VENDOR_SOLARFLARE is not set
 # CONFIG_NET_VENDOR_SOCIONEXT is not set
@@ -157,33 +161,6 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_INFO_DWARF4=y
-CONFIG_GDB_SCRIPTS=y
-CONFIG_UNUSED_SYMBOLS=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
-CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_PAGEALLOC=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_PANIC_ON_OOPS=y
-CONFIG_PROVE_LOCKING=y
-CONFIG_LOCK_STAT=y
-CONFIG_DEBUG_LOCKDEP=y
-CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_LIST=y
-CONFIG_DEBUG_SG=y
-CONFIG_DEBUG_NOTIFIERS=y
-CONFIG_RCU_CPU_STALL_TIMEOUT=60
-CONFIG_LATENCYTOP=y
-CONFIG_SCHED_TRACER=y
-CONFIG_FTRACE_SYSCALLS=y
-CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
-CONFIG_STACK_TRACER=y
-CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_FUNCTION_PROFILER=y
-# CONFIG_RUNTIME_TESTING_MENU is not set
-CONFIG_S390_PTDUMP=y
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_TEST=m
@@ -193,6 +170,7 @@ CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_CMAC=m
@@ -231,7 +209,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_ZCRYPT=m
-CONFIG_ZCRYPT_MULTIDEVNODES=y
 CONFIG_PKEY=m
 CONFIG_CRYPTO_PAES_S390=m
 CONFIG_CRYPTO_SHA1_S390=m
@@ -247,4 +224,30 @@ CONFIG_CRC7=m
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
-CONFIG_CMM=m
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_LOCK_STAT=y
+CONFIG_DEBUG_LOCKDEP=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_LIST=y
+CONFIG_DEBUG_SG=y
+CONFIG_DEBUG_NOTIFIERS=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_LATENCYTOP=y
+CONFIG_SCHED_TRACER=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
+CONFIG_STACK_TRACER=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_FUNCTION_PROFILER=y
+# CONFIG_RUNTIME_TESTING_MENU is not set
+CONFIG_S390_PTDUMP=y
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index dbd689d..ccbb53e 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -46,8 +46,6 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.asce_limit = STACK_TOP_MAX;
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_REGION3;
-		/* pgd_alloc() did not account this pud */
-		mm_inc_nr_puds(mm);
 		break;
 	case -PAGE_SIZE:
 		/* forked 5-level task, set new asce with new_mm->pgd */
@@ -63,9 +61,6 @@ static inline int init_new_context(struct task_struct *tsk,
 		/* forked 2-level compat task, set new asce with new mm->pgd */
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
-		/* pgd_alloc() did not account this pmd */
-		mm_inc_nr_pmds(mm);
-		mm_inc_nr_puds(mm);
 	}
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index f0f9bcf..5ee7337 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -36,11 +36,11 @@ static inline void crst_table_init(unsigned long *crst, unsigned long entry)
 
 static inline unsigned long pgd_entry_type(struct mm_struct *mm)
 {
-	if (mm->context.asce_limit <= _REGION3_SIZE)
+	if (mm_pmd_folded(mm))
 		return _SEGMENT_ENTRY_EMPTY;
-	if (mm->context.asce_limit <= _REGION2_SIZE)
+	if (mm_pud_folded(mm))
 		return _REGION3_ENTRY_EMPTY;
-	if (mm->context.asce_limit <= _REGION1_SIZE)
+	if (mm_p4d_folded(mm))
 		return _REGION2_ENTRY_EMPTY;
 	return _REGION1_ENTRY_EMPTY;
 }
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 411d435..0637324 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -493,6 +493,24 @@ static inline int is_module_addr(void *addr)
 				   _REGION_ENTRY_PROTECT | \
 				   _REGION_ENTRY_NOEXEC)
 
+static inline bool mm_p4d_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION1_SIZE;
+}
+#define mm_p4d_folded(mm) mm_p4d_folded(mm)
+
+static inline bool mm_pud_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION2_SIZE;
+}
+#define mm_pud_folded(mm) mm_pud_folded(mm)
+
+static inline bool mm_pmd_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION3_SIZE;
+}
+#define mm_pmd_folded(mm) mm_pmd_folded(mm)
+
 static inline int mm_has_pgste(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 27248f4..ce4e17c 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -14,7 +14,7 @@
  * General size of kernel stacks
  */
 #ifdef CONFIG_KASAN
-#define THREAD_SIZE_ORDER 3
+#define THREAD_SIZE_ORDER 4
 #else
 #define THREAD_SIZE_ORDER 2
 #endif
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 457b7ba..b31c779 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -136,7 +136,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION3_SIZE)
+	if (mm_pmd_folded(tlb->mm))
 		return;
 	pgtable_pmd_page_dtor(virt_to_page(pmd));
 	tlb_remove_table(tlb, pmd);
@@ -152,7 +152,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION1_SIZE)
+	if (mm_p4d_folded(tlb->mm))
 		return;
 	tlb_remove_table(tlb, p4d);
 }
@@ -167,7 +167,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION2_SIZE)
+	if (mm_pud_folded(tlb->mm))
 		return;
 	tlb_remove_table(tlb, pud);
 }
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 724fba4..39191a0 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -236,10 +236,10 @@ ENTRY(__switch_to)
 	stmg	%r6,%r15,__SF_GPRS(%r15)	# store gprs of prev task
 	lghi	%r4,__TASK_stack
 	lghi	%r1,__TASK_thread
-	lg	%r5,0(%r4,%r3)			# start of kernel stack of next
+	llill	%r5,STACK_INIT
 	stg	%r15,__THREAD_ksp(%r1,%r2)	# store kernel stack of prev
-	lgr	%r15,%r5
-	aghi	%r15,STACK_INIT			# end of kernel stack of next
+	lg	%r15,0(%r4,%r3)			# start of kernel stack of next
+	agr	%r15,%r5			# end of kernel stack of next
 	stg	%r3,__LC_CURRENT		# store task struct of next
 	stg	%r15,__LC_KERNEL_STACK		# store end of kernel stack
 	lg	%r15,__THREAD_ksp(%r1,%r3)	# load kernel stack of next
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index cc085e2..74091fd 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -373,7 +373,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	if (ev > PERF_CPUM_CF_MAX_CTR)
-		return -EINVAL;
+		return -ENOENT;
 
 	/* Obtain the counter set to which the specified counter belongs */
 	set = get_counter_set(ev);
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 7bf604f..bfabeb1 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1842,10 +1842,30 @@ static void cpumsf_pmu_del(struct perf_event *event, int flags)
 CPUMF_EVENT_ATTR(SF, SF_CYCLES_BASIC, PERF_EVENT_CPUM_SF);
 CPUMF_EVENT_ATTR(SF, SF_CYCLES_BASIC_DIAG, PERF_EVENT_CPUM_SF_DIAG);
 
-static struct attribute *cpumsf_pmu_events_attr[] = {
-	CPUMF_EVENT_PTR(SF, SF_CYCLES_BASIC),
-	NULL,
-	NULL,
+/* Attribute list for CPU_SF.
+ *
+ * The availablitiy depends on the CPU_MF sampling facility authorization
+ * for basic + diagnositic samples. This is determined at initialization
+ * time by the sampling facility device driver.
+ * If the authorization for basic samples is turned off, it should be
+ * also turned off for diagnostic sampling.
+ *
+ * During initialization of the device driver, check the authorization
+ * level for diagnostic sampling and installs the attribute
+ * file for diagnostic sampling if necessary.
+ *
+ * For now install a placeholder to reference all possible attributes:
+ * SF_CYCLES_BASIC and SF_CYCLES_BASIC_DIAG.
+ * Add another entry for the final NULL pointer.
+ */
+enum {
+	SF_CYCLES_BASIC_ATTR_IDX = 0,
+	SF_CYCLES_BASIC_DIAG_ATTR_IDX,
+	SF_CYCLES_ATTR_MAX
+};
+
+static struct attribute *cpumsf_pmu_events_attr[SF_CYCLES_ATTR_MAX + 1] = {
+	[SF_CYCLES_BASIC_ATTR_IDX] = CPUMF_EVENT_PTR(SF, SF_CYCLES_BASIC)
 };
 
 PMU_FORMAT_ATTR(event, "config:0-63");
@@ -2040,7 +2060,10 @@ static int __init init_cpum_sampling_pmu(void)
 
 	if (si.ad) {
 		sfb_set_limits(CPUM_SF_MIN_SDB, CPUM_SF_MAX_SDB);
-		cpumsf_pmu_events_attr[1] =
+		/* Sampling of diagnostic data authorized,
+		 * install event into attribute list of PMU device.
+		 */
+		cpumsf_pmu_events_attr[SF_CYCLES_BASIC_DIAG_ATTR_IDX] =
 			CPUMF_EVENT_PTR(SF, SF_CYCLES_BASIC_DIAG);
 	}
 
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index eb8aebe..e76309f 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -37,7 +37,7 @@ KASAN_SANITIZE := n
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32)
+$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) FORCE
 	$(call if_changed,vdso32ld)
 
 # strip rule for the .so file
@@ -46,12 +46,12 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # assembly rules for the .S files
-$(obj-vdso32): %.o: %.S
+$(obj-vdso32): %.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
 
 # actual build commands
 quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso32ld = $(CC) $(c_flags) -Wl,-T $(filter %.lds %.o,$^) -o $@
 quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(CC) $(a_flags) -c -o $@ $<
 
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index a22b2cf..f849ac6 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -37,7 +37,7 @@ KASAN_SANITIZE := n
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64)
+$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) FORCE
 	$(call if_changed,vdso64ld)
 
 # strip rule for the .so file
@@ -46,12 +46,12 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # assembly rules for the .S files
-$(obj-vdso64): %.o: %.S
+$(obj-vdso64): %.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 
 # actual build commands
 quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $(filter %.lds %.o,$^) -o $@
 quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
 
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 21eb7407..8429ab0 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -154,14 +154,14 @@ SECTIONS
 	 * uncompressed image info used by the decompressor
 	 * it should match struct vmlinux_info
 	 */
-	.vmlinux.info 0 : {
+	.vmlinux.info 0 (INFO) : {
 		QUAD(_stext)					/* default_lma */
 		QUAD(startup_continue)				/* entry */
 		QUAD(__bss_start - _stext)			/* image_size */
 		QUAD(__bss_stop - __bss_start)			/* bss_size */
 		QUAD(__boot_data_start)				/* bootdata_off */
 		QUAD(__boot_data_end - __boot_data_start)	/* bootdata_size */
-	}
+	} :NONE
 
 	/* Debugging sections.	*/
 	STABS_DEBUG
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 76d89ee..814f265 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -101,6 +101,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 			mm->context.asce_limit = _REGION1_SIZE;
 			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+			mm_inc_nr_puds(mm);
 		} else {
 			crst_table_init(table, _REGION1_ENTRY_EMPTY);
 			pgd_populate(mm, (pgd_t *) table, (p4d_t *) pgd);
diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 5bd3744..6c151b4 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -54,6 +54,7 @@ int __node_distance(int a, int b)
 {
 	return mode->distance ? mode->distance(a, b) : 0;
 }
+EXPORT_SYMBOL(__node_distance);
 
 int numa_debug_enabled;
 
diff --git a/include/asm-generic/4level-fixup.h b/include/asm-generic/4level-fixup.h
index 89f3b03..e3667c9 100644
--- a/include/asm-generic/4level-fixup.h
+++ b/include/asm-generic/4level-fixup.h
@@ -3,7 +3,7 @@
 #define _4LEVEL_FIXUP_H
 
 #define __ARCH_HAS_4LEVEL_HACK
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 #define PUD_SHIFT			PGDIR_SHIFT
 #define PUD_SIZE			PGDIR_SIZE
diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index 9c2e070..73474bb 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -3,7 +3,7 @@
 #define _5LEVEL_FIXUP_H
 
 #define __ARCH_HAS_5LEVEL_HACK
-#define __PAGETABLE_P4D_FOLDED
+#define __PAGETABLE_P4D_FOLDED 1
 
 #define P4D_SHIFT			PGDIR_SHIFT
 #define P4D_SIZE			PGDIR_SIZE
diff --git a/include/asm-generic/pgtable-nop4d-hack.h b/include/asm-generic/pgtable-nop4d-hack.h
index 0c34215..1d6dd38 100644
--- a/include/asm-generic/pgtable-nop4d-hack.h
+++ b/include/asm-generic/pgtable-nop4d-hack.h
@@ -5,7 +5,7 @@
 #ifndef __ASSEMBLY__
 #include <asm-generic/5level-fixup.h>
 
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 /*
  * Having the pud type consist of a pgd gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 1a29b2a..04cb913 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -4,7 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define __PAGETABLE_P4D_FOLDED
+#define __PAGETABLE_P4D_FOLDED 1
 
 typedef struct { pgd_t pgd; } p4d_t;
 
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index f35f6e8..b85b827 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -8,7 +8,7 @@
 
 struct mm_struct;
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index e950b9c..9bef475 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -9,7 +9,7 @@
 #else
 #include <asm-generic/pgtable-nop4d.h>
 
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 /*
  * Having the pud type consist of a p4d gets the size right, and allows
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 88ebc61..15fd027 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1127,4 +1127,20 @@ static inline bool arch_has_pfn_modify_check(void)
 #endif
 #endif
 
+/*
+ * On some architectures it depends on the mm if the p4d/pud or pmd
+ * layer of the page table hierarchy is folded or not.
+ */
+#ifndef mm_p4d_folded
+#define mm_p4d_folded(mm)	__is_defined(__PAGETABLE_P4D_FOLDED)
+#endif
+
+#ifndef mm_pud_folded
+#define mm_pud_folded(mm)	__is_defined(__PAGETABLE_PUD_FOLDED)
+#endif
+
+#ifndef mm_pmd_folded
+#define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index daa2b8f..a3701e9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1742,11 +1742,15 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address);
 
 static inline void mm_inc_nr_puds(struct mm_struct *mm)
 {
+	if (mm_pud_folded(mm))
+		return;
 	atomic_long_add(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
 }
 
 static inline void mm_dec_nr_puds(struct mm_struct *mm)
 {
+	if (mm_pud_folded(mm))
+		return;
 	atomic_long_sub(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
 }
 #endif
@@ -1766,11 +1770,15 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address);
 
 static inline void mm_inc_nr_pmds(struct mm_struct *mm)
 {
+	if (mm_pmd_folded(mm))
+		return;
 	atomic_long_add(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
 }
 
 static inline void mm_dec_nr_pmds(struct mm_struct *mm)
 {
+	if (mm_pmd_folded(mm))
+		return;
 	atomic_long_sub(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
 }
 #endif
