Return-Path: <linux-kernel-owner+w=401wt.eu-S1763093AbXJSRUG@vger.kernel.org>
Message-Id: <20071019171943.901580638@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:18:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/10] Update default configuration.
Content-Disposition: inline; filename=001-defconfig.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig |  108 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 33 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig
+++ quilt-2.6/arch/s390/defconfig
@@ -1,8 +1,9 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22
-# Tue Jul 17 12:50:23 2007
+# Linux kernel version: 2.6.23
+# Fri Oct 19 18:32:03 2007
 #
+CONFIG_SCHED_MC=y
 CONFIG_MMU=y
 CONFIG_ZONE_DMA=y
 CONFIG_LOCKDEP_SUPPORT=y
@@ -19,15 +20,11 @@ CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
@@ -43,6 +40,8 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CPUSETS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -63,7 +62,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -83,6 +81,7 @@ CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 CONFIG_BLK_DEV_BSG=y
+CONFIG_BLOCK_COMPAT=y
 
 #
 # IO Schedulers
@@ -108,7 +107,6 @@ CONFIG_64BIT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 CONFIG_HOTPLUG_CPU=y
-CONFIG_DEFAULT_MIGRATION_COST=1000000
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
 CONFIG_AUDIT_ARCH=y
@@ -143,9 +141,11 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
 CONFIG_HOLES_IN_ZONE=y
 
@@ -219,12 +219,14 @@ CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_LRO=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
+# CONFIG_IP_VS is not set
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
@@ -243,7 +245,48 @@ CONFIG_IPV6_SIT=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
-# CONFIG_NETFILTER is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# Core Netfilter Configuration
+#
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_NETFILTER_NETLINK_QUEUE=m
+CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NF_CONNTRACK_ENABLED=m
+CONFIG_NF_CONNTRACK=m
+# CONFIG_NF_CT_ACCT is not set
+# CONFIG_NF_CONNTRACK_MARK is not set
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CT_PROTO_UDPLITE is not set
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+# CONFIG_NF_CONNTRACK_FTP is not set
+# CONFIG_NF_CONNTRACK_H323 is not set
+# CONFIG_NF_CONNTRACK_IRC is not set
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SANE is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+# CONFIG_NF_CONNTRACK_TFTP is not set
+# CONFIG_NF_CT_NETLINK is not set
+# CONFIG_NETFILTER_XTABLES is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_NF_CONNTRACK_IPV4 is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+
+#
+# IPv6: Netfilter Configuration (EXPERIMENTAL)
+#
+# CONFIG_NF_CONNTRACK_IPV6 is not set
+# CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
 # CONFIG_IP_DCCP is not set
 CONFIG_IP_SCTP=m
 # CONFIG_SCTP_DBG_MSG is not set
@@ -306,6 +349,7 @@ CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 # CONFIG_NET_ACT_GACT is not set
 # CONFIG_NET_ACT_MIRRED is not set
+CONFIG_NET_ACT_NAT=m
 # CONFIG_NET_ACT_PEDIT is not set
 # CONFIG_NET_ACT_SIMP is not set
 CONFIG_NET_CLS_POLICE=y
@@ -329,6 +373,7 @@ CONFIG_CCW=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
@@ -400,17 +445,11 @@ CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
-
-#
-# Multi-device support (RAID and LVM)
-#
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=m
@@ -438,8 +477,13 @@ CONFIG_BONDING=m
 # CONFIG_MACVLAN is not set
 CONFIG_EQUALIZER=m
 CONFIG_TUN=m
+CONFIG_VETH=m
 CONFIG_NET_ETHERNET=y
 # CONFIG_MII is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 # CONFIG_TR is not set
@@ -473,7 +517,6 @@ CONFIG_CCWGROUP=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=m
 # CONFIG_R3964 is not set
 CONFIG_RAW_DRIVER=m
@@ -490,7 +533,6 @@ CONFIG_TN3270_CONSOLE=y
 CONFIG_TN3215=y
 CONFIG_TN3215_CONSOLE=y
 CONFIG_CCW_CONSOLE=y
-CONFIG_SCLP=y
 CONFIG_SCLP_TTY=y
 CONFIG_SCLP_CONSOLE=y
 CONFIG_SCLP_VT220_TTY=y
@@ -514,6 +556,11 @@ CONFIG_S390_TAPE_34XX=m
 CONFIG_MONWRITER=m
 CONFIG_S390_VMUR=m
 # CONFIG_POWER_SUPPLY is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
 
 #
 # File systems
@@ -569,7 +616,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 CONFIG_CONFIGFS_FS=m
 
 #
@@ -588,10 +634,7 @@ CONFIG_CONFIGFS_FS=m
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
@@ -638,15 +681,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_SYSV68_PARTITION is not set
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 CONFIG_DLM=m
 # CONFIG_DLM_DEBUG is not set
 
@@ -682,6 +717,7 @@ CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_LOCK_ALLOC is not set
 # CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -700,8 +736,10 @@ CONFIG_FORCED_INLINING=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=m
 CONFIG_CRYPTO_BLKCIPHER=y
 CONFIG_CRYPTO_HASH=m
 CONFIG_CRYPTO_MANAGER=y
@@ -720,6 +758,7 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_DES is not set
 CONFIG_CRYPTO_FCRYPT=m
@@ -733,11 +772,13 @@ CONFIG_CRYPTO_FCRYPT=m
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_KHAZAD is not set
 # CONFIG_CRYPTO_ANUBIS is not set
+CONFIG_CRYPTO_SEED=m
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 CONFIG_CRYPTO_CAMELLIA=m
 # CONFIG_CRYPTO_TEST is not set
+CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_HW=y
 # CONFIG_CRYPTO_SHA1_S390 is not set
 # CONFIG_CRYPTO_SHA256_S390 is not set
@@ -755,5 +796,6 @@ CONFIG_BITREVERSE=m
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=m
+CONFIG_CRC7=m
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
