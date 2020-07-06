Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729321AbgGFPoi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jul 2020 11:44:38 -0400
Date: Mon, 6 Jul 2020 17:44:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 5.8-rc5
Message-ID: <20200706154417.GH4707@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hi Linus,

please pull s390 updates for 5.8-rc5.

Thanks,
Heiko

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-4

for you to fetch changes up to 075ebfe19fa3fa8838d2afdde5e87c86b7953b1e:

  Merge tag 'vfio-ccw-20200703' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into fixes (2020-07-03 18:02:09 +0200)

----------------------------------------------------------------
- Initialize jump labels before early command line parsing in order to make
  init_on_alloc and init_on_free options work.

- Fix vfio-ccw build error due to missing include.

- Prevent callchain data collection with hardware sampling, since the
  callchains simply do not exist.

- Prevent multiple registrations of the same zPCI function.

- Update defconfigs.

----------------------------------------------------------------
Heiko Carstens (2):
      s390: update defconfigs
      Merge tag 'vfio-ccw-20200703' of https://git.kernel.org/.../kvms390/vfio-ccw into fixes

Niklas Schnelle (1):
      s390/pci: fix enabling a reserved PCI function

Sean Christopherson (1):
      vfio-ccw: Fix a build error due to missing include of linux/slab.h

Thomas Richter (1):
      s390/cpum_sf: prohibit callchain data collection

Vasily Gorbik (2):
      s390/maccess: add no DAT mode to kernel_write
      s390/setup: init jump labels before command line parsing

 arch/s390/configs/debug_defconfig    | 44 ++++++++++++++++++++++++++++--------
 arch/s390/configs/defconfig          | 43 +++++++++++++++++++++++++++--------
 arch/s390/configs/zfcpdump_defconfig |  5 ++++
 arch/s390/kernel/perf_cpum_sf.c      | 11 ++++++++-
 arch/s390/kernel/setup.c             |  1 +
 arch/s390/mm/maccess.c               | 14 ++++++++----
 arch/s390/pci/pci_event.c            | 13 ++++++++++-
 drivers/s390/cio/vfio_ccw_chp.c      |  1 +
 8 files changed, 106 insertions(+), 26 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 46038bc58c9e..0cf9a82326a8 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -1,5 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_WATCH_QUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -14,7 +15,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NUMA_BALANCING=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CFS_BANDWIDTH=y
 CONFIG_RT_GROUP_SCHED=y
@@ -31,9 +31,9 @@ CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_SCHED_AUTOGROUP=y
-CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_BPF_LSM=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_USERFAULTFD=y
 # CONFIG_COMPAT_BRK is not set
@@ -51,14 +51,11 @@ CONFIG_CHSC_SCH=y
 CONFIG_VFIO_CCW=m
 CONFIG_VFIO_AP=m
 CONFIG_CRASH_DUMP=y
-CONFIG_HIBERNATION=y
-CONFIG_PM_DEBUG=y
 CONFIG_PROTECTED_VIRTUALIZATION_GUEST=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
-CONFIG_VHOST_NET=m
-CONFIG_VHOST_VSOCK=m
+CONFIG_S390_UNWIND_SELFTEST=y
 CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
@@ -77,6 +74,8 @@ CONFIG_BLK_DEV_THROTTLING=y
 CONFIG_BLK_WBT=y
 CONFIG_BLK_CGROUP_IOLATENCY=y
 CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_INLINE_ENCRYPTION=y
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IBM_PARTITION=y
 CONFIG_BSD_DISKLABEL=y
@@ -96,7 +95,6 @@ CONFIG_CMA_DEBUG=y
 CONFIG_CMA_DEBUGFS=y
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_ZSWAP=y
-CONFIG_ZBUD=m
 CONFIG_ZSMALLOC=m
 CONFIG_ZSMALLOC_STAT=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
@@ -130,6 +128,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_NET_IPVTI=m
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
+CONFIG_INET_ESPINTCP=y
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
@@ -144,6 +143,7 @@ CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
+CONFIG_INET6_ESPINTCP=y
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
 CONFIG_IPV6_VTI=m
@@ -151,7 +151,10 @@ CONFIG_IPV6_SIT=m
 CONFIG_IPV6_GRE=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_RPL_LWTUNNEL=y
+CONFIG_MPTCP=y
 CONFIG_NETFILTER=y
+CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -317,6 +320,7 @@ CONFIG_L2TP_V3=y
 CONFIG_L2TP_IP=m
 CONFIG_L2TP_ETH=m
 CONFIG_BRIDGE=m
+CONFIG_BRIDGE_MRP=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_NET_SCHED=y
@@ -341,6 +345,7 @@ CONFIG_NET_SCH_CODEL=m
 CONFIG_NET_SCH_FQ_CODEL=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_PLUG=m
+CONFIG_NET_SCH_ETS=m
 CONFIG_NET_CLS_BASIC=m
 CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
@@ -364,6 +369,7 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_ACT_CSUM=m
+CONFIG_NET_ACT_GATE=m
 CONFIG_DNS_RESOLVER=y
 CONFIG_OPENVSWITCH=m
 CONFIG_VSOCKETS=m
@@ -374,6 +380,7 @@ CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
 # CONFIG_NET_DROP_MONITOR is not set
 CONFIG_PCI=y
+# CONFIG_PCIEASPM is not set
 CONFIG_PCI_DEBUG=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
@@ -435,6 +442,7 @@ CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
 CONFIG_DM_MULTIPATH_QL=m
 CONFIG_DM_MULTIPATH_ST=m
+CONFIG_DM_MULTIPATH_HST=m
 CONFIG_DM_DELAY=m
 CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
@@ -448,6 +456,8 @@ CONFIG_EQUALIZER=m
 CONFIG_IFB=m
 CONFIG_MACVLAN=m
 CONFIG_MACVTAP=m
+CONFIG_VXLAN=m
+CONFIG_BAREUDP=m
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
@@ -481,7 +491,6 @@ CONFIG_NLMON=m
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
-# CONFIG_MLXFW is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
@@ -514,6 +523,7 @@ CONFIG_MLX5_CORE_EN=y
 # CONFIG_NET_VENDOR_TI is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
@@ -561,6 +571,8 @@ CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
+CONFIG_VHOST_NET=m
+CONFIG_VHOST_VSOCK=m
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -608,6 +620,7 @@ CONFIG_ZISOFS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_EXFAT_FS=m
 CONFIG_NTFS_FS=m
 CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
@@ -650,8 +663,8 @@ CONFIG_NLS_UTF8=m
 CONFIG_DLM=m
 CONFIG_UNICODE=y
 CONFIG_PERSISTENT_KEYRINGS=y
-CONFIG_BIG_KEYS=y
 CONFIG_ENCRYPTED_KEYS=m
+CONFIG_KEY_NOTIFICATIONS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_FORTIFY_SOURCE=y
@@ -675,8 +688,11 @@ CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECRDSA=m
+CONFIG_CRYPTO_CURVE25519=m
+CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_AEGIS128=m
+CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
@@ -685,6 +701,7 @@ CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_CRC32=m
+CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
@@ -701,6 +718,7 @@ CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
+CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SALSA20=m
@@ -719,6 +737,9 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_STATS=y
+CONFIG_CRYPTO_LIB_BLAKE2S=m
+CONFIG_CRYPTO_LIB_CURVE25519=m
+CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 CONFIG_ZCRYPT=m
 CONFIG_PKEY=m
 CONFIG_CRYPTO_PAES_S390=m
@@ -774,6 +795,7 @@ CONFIG_DEBUG_SHIRQ=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_WQ_WATCHDOG=y
+CONFIG_TEST_LOCKUP=m
 CONFIG_DEBUG_TIMEKEEPING=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_LOCK_STAT=y
@@ -786,7 +808,9 @@ CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_DEBUG_CREDENTIALS=y
 CONFIG_RCU_TORTURE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=300
+# CONFIG_RCU_TRACE is not set
 CONFIG_LATENCYTOP=y
+CONFIG_BOOTTIME_TRACING=y
 CONFIG_FUNCTION_PROFILER=y
 CONFIG_STACK_TRACER=y
 CONFIG_IRQSOFF_TRACER=y
@@ -808,10 +832,12 @@ CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
 CONFIG_LKDTM=m
 CONFIG_TEST_LIST_SORT=y
+CONFIG_TEST_MIN_HEAP=y
 CONFIG_TEST_SORT=y
 CONFIG_KPROBES_SANITY_TEST=y
 CONFIG_RBTREE_TEST=y
 CONFIG_INTERVAL_TREE_TEST=m
 CONFIG_PERCPU_TEST=m
 CONFIG_ATOMIC64_SELFTEST=y
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_BPF=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 7cd0648c1f4e..5df9759e8ff6 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -1,5 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_WATCH_QUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -13,7 +14,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NUMA_BALANCING=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CFS_BANDWIDTH=y
 CONFIG_RT_GROUP_SCHED=y
@@ -30,9 +30,9 @@ CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_SCHED_AUTOGROUP=y
-CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_BPF_LSM=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_USERFAULTFD=y
 # CONFIG_COMPAT_BRK is not set
@@ -41,7 +41,6 @@ CONFIG_LIVEPATCH=y
 CONFIG_TUNE_ZEC12=y
 CONFIG_NR_CPUS=512
 CONFIG_NUMA=y
-# CONFIG_NUMA_EMU is not set
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
 CONFIG_KEXEC_SIG=y
@@ -51,14 +50,11 @@ CONFIG_CHSC_SCH=y
 CONFIG_VFIO_CCW=m
 CONFIG_VFIO_AP=m
 CONFIG_CRASH_DUMP=y
-CONFIG_HIBERNATION=y
-CONFIG_PM_DEBUG=y
 CONFIG_PROTECTED_VIRTUALIZATION_GUEST=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
-CONFIG_VHOST_NET=m
-CONFIG_VHOST_VSOCK=m
+CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
@@ -74,6 +70,8 @@ CONFIG_BLK_DEV_THROTTLING=y
 CONFIG_BLK_WBT=y
 CONFIG_BLK_CGROUP_IOLATENCY=y
 CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_INLINE_ENCRYPTION=y
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IBM_PARTITION=y
 CONFIG_BSD_DISKLABEL=y
@@ -91,7 +89,6 @@ CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_ZSWAP=y
-CONFIG_ZBUD=m
 CONFIG_ZSMALLOC=m
 CONFIG_ZSMALLOC_STAT=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
@@ -125,6 +122,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_NET_IPVTI=m
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
+CONFIG_INET_ESPINTCP=y
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
@@ -139,6 +137,7 @@ CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
+CONFIG_INET6_ESPINTCP=y
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
 CONFIG_IPV6_VTI=m
@@ -146,7 +145,10 @@ CONFIG_IPV6_SIT=m
 CONFIG_IPV6_GRE=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_RPL_LWTUNNEL=y
+CONFIG_MPTCP=y
 CONFIG_NETFILTER=y
+CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -311,6 +313,7 @@ CONFIG_L2TP_V3=y
 CONFIG_L2TP_IP=m
 CONFIG_L2TP_ETH=m
 CONFIG_BRIDGE=m
+CONFIG_BRIDGE_MRP=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_NET_SCHED=y
@@ -335,6 +338,7 @@ CONFIG_NET_SCH_CODEL=m
 CONFIG_NET_SCH_FQ_CODEL=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_PLUG=m
+CONFIG_NET_SCH_ETS=m
 CONFIG_NET_CLS_BASIC=m
 CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
@@ -358,6 +362,7 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_ACT_CSUM=m
+CONFIG_NET_ACT_GATE=m
 CONFIG_DNS_RESOLVER=y
 CONFIG_OPENVSWITCH=m
 CONFIG_VSOCKETS=m
@@ -368,6 +373,7 @@ CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
 # CONFIG_NET_DROP_MONITOR is not set
 CONFIG_PCI=y
+# CONFIG_PCIEASPM is not set
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_UEVENT_HELPER=y
@@ -430,6 +436,7 @@ CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
 CONFIG_DM_MULTIPATH_QL=m
 CONFIG_DM_MULTIPATH_ST=m
+CONFIG_DM_MULTIPATH_HST=m
 CONFIG_DM_DELAY=m
 CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
@@ -444,6 +451,8 @@ CONFIG_EQUALIZER=m
 CONFIG_IFB=m
 CONFIG_MACVLAN=m
 CONFIG_MACVTAP=m
+CONFIG_VXLAN=m
+CONFIG_BAREUDP=m
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
@@ -477,7 +486,6 @@ CONFIG_NLMON=m
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
-# CONFIG_MLXFW is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
@@ -510,6 +518,7 @@ CONFIG_MLX5_CORE_EN=y
 # CONFIG_NET_VENDOR_TI is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
@@ -557,6 +566,8 @@ CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
+CONFIG_VHOST_NET=m
+CONFIG_VHOST_VSOCK=m
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -600,6 +611,7 @@ CONFIG_ZISOFS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_EXFAT_FS=m
 CONFIG_NTFS_FS=m
 CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
@@ -642,8 +654,8 @@ CONFIG_NLS_UTF8=m
 CONFIG_DLM=m
 CONFIG_UNICODE=y
 CONFIG_PERSISTENT_KEYRINGS=y
-CONFIG_BIG_KEYS=y
 CONFIG_ENCRYPTED_KEYS=m
+CONFIG_KEY_NOTIFICATIONS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
@@ -667,8 +679,11 @@ CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECRDSA=m
+CONFIG_CRYPTO_CURVE25519=m
+CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_AEGIS128=m
+CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_OFB=m
@@ -678,6 +693,7 @@ CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_CRC32=m
+CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
@@ -694,6 +710,7 @@ CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
+CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SALSA20=m
@@ -712,6 +729,9 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_STATS=y
+CONFIG_CRYPTO_LIB_BLAKE2S=m
+CONFIG_CRYPTO_LIB_CURVE25519=m
+CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 CONFIG_ZCRYPT=m
 CONFIG_PKEY=m
 CONFIG_CRYPTO_PAES_S390=m
@@ -725,6 +745,7 @@ CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
 CONFIG_CRYPTO_CRC32_S390=y
 CONFIG_CORDIC=m
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC4=m
 CONFIG_CRC7=m
 CONFIG_CRC8=m
@@ -739,10 +760,12 @@ CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_PANIC_ON_OOPS=y
+CONFIG_TEST_LOCKUP=m
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_RCU_TORTURE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 CONFIG_LATENCYTOP=y
+CONFIG_BOOTTIME_TRACING=y
 CONFIG_FUNCTION_PROFILER=y
 CONFIG_STACK_TRACER=y
 CONFIG_SCHED_TRACER=y
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 20c51e5d9353..4091c50449cd 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -30,6 +30,7 @@ CONFIG_IBM_PARTITION=y
 # CONFIG_BOUNCE is not set
 CONFIG_NET=y
 # CONFIG_IUCV is not set
+# CONFIG_ETHTOOL_NETLINK is not set
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_BLK_DEV_XPRAM is not set
@@ -55,6 +56,8 @@ CONFIG_RAW_DRIVER=y
 # CONFIG_MONWRITER is not set
 # CONFIG_S390_VMUR is not set
 # CONFIG_HID is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
@@ -62,7 +65,9 @@ CONFIG_CONFIGFS_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_LSM="yama,loadpin,safesetid,integrity"
+# CONFIG_ZLIB_DFLTCC is not set
 CONFIG_PRINTK_TIME=y
+# CONFIG_SYMBOLIC_ERRNAME is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 85a711d783eb..4f9e4626df55 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -881,12 +881,21 @@ static int __hw_perf_event_init(struct perf_event *event)
 	return err;
 }
 
+static bool is_callchain_event(struct perf_event *event)
+{
+	u64 sample_type = event->attr.sample_type;
+
+	return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER |
+			      PERF_SAMPLE_STACK_USER);
+}
+
 static int cpumsf_pmu_event_init(struct perf_event *event)
 {
 	int err;
 
 	/* No support for taken branch sampling */
-	if (has_branch_stack(event))
+	/* No support for callchain, stacks and registers */
+	if (has_branch_stack(event) || is_callchain_event(event))
 		return -EOPNOTSUPP;
 
 	switch (event->attr.type) {
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 5853c9872dfe..07aa15ba43b3 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1100,6 +1100,7 @@ void __init setup_arch(char **cmdline_p)
 	if (IS_ENABLED(CONFIG_EXPOLINE_AUTO))
 		nospec_auto_detect();
 
+	jump_label_init();
 	parse_early_param();
 #ifdef CONFIG_CRASH_DUMP
 	/* Deactivate elfcorehdr= kernel parameter */
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index 22a0be655f27..1d17413b319a 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -62,11 +62,15 @@ notrace void *s390_kernel_write(void *dst, const void *src, size_t size)
 	long copied;
 
 	spin_lock_irqsave(&s390_kernel_write_lock, flags);
-	while (size) {
-		copied = s390_kernel_write_odd(tmp, src, size);
-		tmp += copied;
-		src += copied;
-		size -= copied;
+	if (!(flags & PSW_MASK_DAT)) {
+		memcpy(dst, src, size);
+	} else {
+		while (size) {
+			copied = s390_kernel_write_odd(tmp, src, size);
+			tmp += copied;
+			src += copied;
+			size -= copied;
+		}
 	}
 	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 08e1d619398e..fdebd286f402 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -94,7 +94,18 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 		}
 		zdev->fh = ccdf->fh;
 		zdev->state = ZPCI_FN_STATE_CONFIGURED;
-		zpci_create_device(zdev);
+		ret = zpci_enable_device(zdev);
+		if (ret)
+			break;
+
+		pdev = pci_scan_single_device(zdev->zbus->bus, zdev->devfn);
+		if (!pdev)
+			break;
+
+		pci_bus_add_device(pdev);
+		pci_lock_rescan_remove();
+		pci_bus_add_devices(zdev->zbus->bus);
+		pci_unlock_rescan_remove();
 		break;
 	case 0x0302: /* Reserved -> Standby */
 		if (!zdev) {
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index a646fc81c872..13b26a1c7988 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -8,6 +8,7 @@
  *            Eric Farman <farman@linux.ibm.com>
  */
 
+#include <linux/slab.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
 
