Return-Path: <linux-kernel-owner+w=401wt.eu-S1762763AbXEJOAd@vger.kernel.org>
Message-Id: <20070510135646.411964761@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:52:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/15] update default configuration.
Content-Disposition: inline; filename=106-defconfig.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig |  234 ++++++++++++++++++++++++++++------------------------
 1 file changed, 128 insertions(+), 106 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig
+++ quilt-2.6/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc1
-# Wed Feb 21 10:44:30 2007
+# Linux kernel version: 2.6.21
+# Thu May 10 15:18:19 2007
 #
 CONFIG_MMU=y
 CONFIG_ZONE_DMA=y
@@ -14,6 +14,7 @@ CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_BUG=y
 CONFIG_NO_IOMEM=y
+CONFIG_NO_DMA=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -41,9 +42,11 @@ CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CPUSETS is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -60,12 +63,14 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -128,6 +133,14 @@ CONFIG_CHECK_STACK=y
 CONFIG_STACK_GUARD=256
 # CONFIG_WARN_STACK is not set
 CONFIG_ARCH_POPULATES_NODE_MAP=y
+
+#
+# Kernel preemption
+#
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+CONFIG_PREEMPT_BKL=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -150,7 +163,6 @@ CONFIG_QDIO=y
 #
 # Misc
 #
-CONFIG_PREEMPT=y
 CONFIG_IPL=y
 # CONFIG_IPL_TAPE is not set
 CONFIG_IPL_VM=y
@@ -163,6 +175,11 @@ CONFIG_PFAULT=y
 CONFIG_VIRT_TIMER=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 # CONFIG_APPLDATA_BASE is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
 CONFIG_NO_IDLE_HZ=y
 CONFIG_NO_IDLE_HZ_INIT=y
 CONFIG_S390_HYPFS_FS=y
@@ -177,7 +194,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -216,6 +232,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
@@ -240,7 +257,12 @@ CONFIG_IPV6_SIT=y
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-# CONFIG_IP_SCTP is not set
+CONFIG_IP_SCTP=m
+# CONFIG_SCTP_DBG_MSG is not set
+# CONFIG_SCTP_DBG_OBJCNT is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+CONFIG_SCTP_HMAC_MD5=y
 
 #
 # TIPC Configuration (EXPERIMENTAL)
@@ -263,9 +285,6 @@ CONFIG_IPV6_SIT=y
 #
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_FIFO=y
-CONFIG_NET_SCH_CLK_JIFFIES=y
-# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
-# CONFIG_NET_SCH_CLK_CPU is not set
 
 #
 # Queueing/Scheduling
@@ -308,11 +327,14 @@ CONFIG_NET_ESTIMATOR=y
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_NET_TCPPROBE is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_RFKILL is not set
 # CONFIG_PCMCIA is not set
+CONFIG_CCW=y
+
+#
+# Device Drivers
+#
 
 #
 # Generic Driver Options
@@ -330,6 +352,37 @@ CONFIG_SYS_HYPERVISOR=y
 # CONFIG_CONNECTOR is not set
 
 #
+# Block devices
+#
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# S/390 block device drivers
+#
+CONFIG_BLK_DEV_XPRAM=m
+# CONFIG_DCSSBLK is not set
+CONFIG_DASD=y
+CONFIG_DASD_PROFILE=y
+CONFIG_DASD_ECKD=y
+CONFIG_DASD_FBA=y
+CONFIG_DASD_DIAG=y
+CONFIG_DASD_EER=y
+
+#
+# Misc devices
+#
+# CONFIG_BLINK is not set
+
+#
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
@@ -356,6 +409,7 @@ CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -372,34 +426,6 @@ CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
-CONFIG_CCW=y
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=m
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CDROM_PKTCDVD is not set
-
-#
-# S/390 block device drivers
-#
-CONFIG_BLK_DEV_XPRAM=m
-# CONFIG_DCSSBLK is not set
-CONFIG_DASD=y
-CONFIG_DASD_PROFILE=y
-CONFIG_DASD_ECKD=y
-CONFIG_DASD_FBA=y
-CONFIG_DASD_DIAG=y
-CONFIG_DASD_EER=y
-# CONFIG_ATA_OVER_ETH is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -421,56 +447,7 @@ CONFIG_DM_MIRROR=y
 CONFIG_DM_ZERO=y
 CONFIG_DM_MULTIPATH=y
 # CONFIG_DM_MULTIPATH_EMC is not set
-
-#
-# Character device drivers
-#
-CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=2048
-# CONFIG_HANGCHECK_TIMER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
-
-#
-# S/390 character device drivers
-#
-CONFIG_TN3270=y
-CONFIG_TN3270_TTY=y
-CONFIG_TN3270_FS=m
-CONFIG_TN3270_CONSOLE=y
-CONFIG_TN3215=y
-CONFIG_TN3215_CONSOLE=y
-CONFIG_CCW_CONSOLE=y
-CONFIG_SCLP_TTY=y
-CONFIG_SCLP_CONSOLE=y
-CONFIG_SCLP_VT220_TTY=y
-CONFIG_SCLP_VT220_CONSOLE=y
-CONFIG_SCLP_CPI=m
-CONFIG_S390_TAPE=m
-
-#
-# S/390 tape interface support
-#
-CONFIG_S390_TAPE_BLOCK=y
-
-#
-# S/390 tape hardware support
-#
-CONFIG_S390_TAPE_34XX=m
-# CONFIG_S390_TAPE_3590 is not set
-# CONFIG_VMLOGRDR is not set
-# CONFIG_VMCP is not set
-# CONFIG_MONREADER is not set
-CONFIG_MONWRITER=m
-
-#
-# Cryptographic devices
-#
-CONFIG_ZCRYPT=m
-# CONFIG_ZCRYPT_MONOLITHIC is not set
+# CONFIG_DM_DELAY is not set
 
 #
 # Network device support
@@ -482,10 +459,6 @@ CONFIG_EQUALIZER=m
 CONFIG_TUN=m
 
 #
-# PHY device support
-#
-
-#
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
@@ -498,6 +471,7 @@ CONFIG_NET_ETHERNET=y
 #
 # Ethernet (10000 Mbit)
 #
+CONFIG_MLX4_DEBUG=y
 
 #
 # Token Ring devices
@@ -505,11 +479,6 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_TR is not set
 
 #
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -537,6 +506,56 @@ CONFIG_CCWGROUP=y
 # CONFIG_NET_POLL_CONTROLLER is not set
 
 #
+# Character devices
+#
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=m
+# CONFIG_R3964 is not set
+CONFIG_RAW_DRIVER=m
+CONFIG_MAX_RAW_DEVS=256
+# CONFIG_HANGCHECK_TIMER is not set
+
+#
+# S/390 character device drivers
+#
+CONFIG_TN3270=y
+CONFIG_TN3270_TTY=y
+CONFIG_TN3270_FS=m
+CONFIG_TN3270_CONSOLE=y
+CONFIG_TN3215=y
+CONFIG_TN3215_CONSOLE=y
+CONFIG_CCW_CONSOLE=y
+CONFIG_SCLP=y
+CONFIG_SCLP_TTY=y
+CONFIG_SCLP_CONSOLE=y
+CONFIG_SCLP_VT220_TTY=y
+CONFIG_SCLP_VT220_CONSOLE=y
+CONFIG_SCLP_CPI=m
+CONFIG_S390_TAPE=m
+
+#
+# S/390 tape interface support
+#
+CONFIG_S390_TAPE_BLOCK=y
+
+#
+# S/390 tape hardware support
+#
+CONFIG_S390_TAPE_34XX=m
+# CONFIG_S390_TAPE_3590 is not set
+# CONFIG_VMLOGRDR is not set
+# CONFIG_VMCP is not set
+# CONFIG_MONREADER is not set
+CONFIG_MONWRITER=m
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -628,6 +647,7 @@ CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -658,6 +678,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
@@ -668,8 +689,6 @@ CONFIG_MSDOS_PARTITION=y
 # Distributed Lock Manager
 #
 CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
 # CONFIG_DLM_DEBUG is not set
 
 #
@@ -693,7 +712,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_HEADERS_CHECK=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -729,12 +747,13 @@ CONFIG_FORCED_INLINING=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=m
 CONFIG_CRYPTO_MANAGER=y
-# CONFIG_CRYPTO_HMAC is not set
+CONFIG_CRYPTO_HMAC=m
 # CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
-# CONFIG_CRYPTO_MD5 is not set
+CONFIG_CRYPTO_MD5=m
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
@@ -745,6 +764,7 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_DES is not set
 CONFIG_CRYPTO_FCRYPT=m
 # CONFIG_CRYPTO_BLOWFISH is not set
@@ -771,6 +791,8 @@ CONFIG_CRYPTO_CAMELLIA=m
 # CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_AES_S390 is not set
 CONFIG_S390_PRNG=m
+CONFIG_ZCRYPT=m
+# CONFIG_ZCRYPT_MONOLITHIC is not set
 
 #
 # Library routines

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
