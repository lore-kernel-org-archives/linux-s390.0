Return-Path: <linux-kernel-owner+w=401wt.eu-S1759866AbXGQMUS@vger.kernel.org>
Message-Id: <20070717122222.948897920@de.ibm.com>
References: <20070717121747.591687140@de.ibm.com>
Date: Tue, 17 Jul 2007 14:17:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/8] Update default configuration.
Content-Disposition: inline; filename=000-defconfig.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig |  109 ++++++++++++++--------------------------------------
 1 file changed, 31 insertions(+), 78 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig
+++ quilt-2.6/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21
-# Thu May 10 15:18:19 2007
+# Linux kernel version: 2.6.22
+# Tue Jul 17 12:50:23 2007
 #
 CONFIG_MMU=y
 CONFIG_ZONE_DMA=y
@@ -32,12 +32,11 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
 CONFIG_IKCONFIG=y
@@ -61,20 +60,19 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLUB_DEBUG=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
@@ -82,12 +80,9 @@ CONFIG_MODVERSIONS=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 CONFIG_STOP_MACHINE=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_BLK_DEV_BSG=y
 
 #
 # IO Schedulers
@@ -151,6 +146,7 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_VIRT_TO_BUS=y
 CONFIG_HOLES_IN_ZONE=y
 
 #
@@ -248,25 +244,13 @@ CONFIG_IPV6_SIT=y
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 CONFIG_IP_SCTP=m
 # CONFIG_SCTP_DBG_MSG is not set
 # CONFIG_SCTP_DBG_OBJCNT is not set
 # CONFIG_SCTP_HMAC_NONE is not set
 # CONFIG_SCTP_HMAC_SHA1 is not set
 CONFIG_SCTP_HMAC_MD5=y
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -293,6 +277,7 @@ CONFIG_NET_SCH_CBQ=m
 # CONFIG_NET_SCH_HTB is not set
 # CONFIG_NET_SCH_HFSC is not set
 CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RR=m
 CONFIG_NET_SCH_RED=m
 CONFIG_NET_SCH_SFQ=m
 CONFIG_NET_SCH_TEQL=m
@@ -317,10 +302,14 @@ CONFIG_CLS_U32_MARK=y
 CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
 # CONFIG_NET_EMATCH is not set
-# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_POLICE=y
+# CONFIG_NET_ACT_GACT is not set
+# CONFIG_NET_ACT_MIRRED is not set
+# CONFIG_NET_ACT_PEDIT is not set
+# CONFIG_NET_ACT_SIMP is not set
 CONFIG_NET_CLS_POLICE=y
 # CONFIG_NET_CLS_IND is not set
-CONFIG_NET_ESTIMATOR=y
 
 #
 # Network testing
@@ -329,6 +318,7 @@ CONFIG_NET_ESTIMATOR=y
 # CONFIG_NET_TCPPROBE is not set
 # CONFIG_AF_RXRPC is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 # CONFIG_PCMCIA is not set
 CONFIG_CCW=y
 
@@ -345,15 +335,8 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 CONFIG_SYS_HYPERVISOR=y
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -376,17 +359,15 @@ CONFIG_DASD_ECKD=y
 CONFIG_DASD_FBA=y
 CONFIG_DASD_DIAG=y
 CONFIG_DASD_EER=y
-
-#
-# Misc devices
-#
-# CONFIG_BLINK is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_TGT is not set
 CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
@@ -447,40 +428,21 @@ CONFIG_DM_MIRROR=y
 CONFIG_DM_ZERO=y
 CONFIG_DM_MULTIPATH=y
 # CONFIG_DM_MULTIPATH_EMC is not set
+# CONFIG_DM_MULTIPATH_RDAC is not set
 # CONFIG_DM_DELAY is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_IFB is not set
 CONFIG_DUMMY=m
 CONFIG_BONDING=m
+# CONFIG_MACVLAN is not set
 CONFIG_EQUALIZER=m
 CONFIG_TUN=m
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 # CONFIG_MII is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-CONFIG_MLX4_DEBUG=y
-
-#
-# Token Ring devices
-#
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
 # CONFIG_TR is not set
-
-#
-# Wan interfaces
-#
 # CONFIG_WAN is not set
 
 #
@@ -511,10 +473,6 @@ CONFIG_CCWGROUP=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=m
 # CONFIG_R3964 is not set
@@ -554,6 +512,7 @@ CONFIG_S390_TAPE_34XX=m
 # CONFIG_VMCP is not set
 # CONFIG_MONREADER is not set
 CONFIG_MONWRITER=m
+# CONFIG_POWER_SUPPLY is not set
 
 #
 # File systems
@@ -655,7 +614,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -712,6 +670,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_HEADERS_CHECK=y
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_SCHED_DEBUG is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -740,10 +699,6 @@ CONFIG_FORCED_INLINING=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -782,10 +737,7 @@ CONFIG_CRYPTO_FCRYPT=m
 # CONFIG_CRYPTO_CRC32C is not set
 CONFIG_CRYPTO_CAMELLIA=m
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_HW=y
 # CONFIG_CRYPTO_SHA1_S390 is not set
 # CONFIG_CRYPTO_SHA256_S390 is not set
 # CONFIG_CRYPTO_DES_S390 is not set
@@ -800,6 +752,7 @@ CONFIG_ZCRYPT=m
 CONFIG_BITREVERSE=m
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
