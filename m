From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [BUILD-FAILURE] next-20081230 - S390 - tape drive fails to build
	with !CONFIG_BLOCK
Date: Wed, 31 Dec 2008 16:51:32 +0530
Message-ID: <20081231112132.GA4268@linux.vnet.ibm.com>
References: <20081231033039.f203b59c.sfr@canb.auug.org.au>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081231033039.f203b59c.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi,

	next-20081230 randconfig build fails on S390, with CONFIG_BLOCK=n

  CC      drivers/s390/char/tape_block.o
In file included from drivers/s390/char/tape_block.c:24:
drivers/s390/char/tape.h:159: warning: 'struct request' declared inside parameter list
drivers/s390/char/tape.h:159: warning: its scope is only this definition or declaration, which is probably not what you want
drivers/s390/char/tape_block.c:53: error: variable 'tapeblock_fops' has initializer but incomplete type
drivers/s390/char/tape_block.c:54: error: unknown field 'owner' specified in initializer
drivers/s390/char/tape_block.c:54: warning: excess elements in struct initializer
drivers/s390/char/tape_block.c:54: warning: (near initialization for 'tapeblock_fops')
drivers/s390/char/tape_block.c:55: error: unknown field 'open' specified in initializer
drivers/s390/char/tape_block.c:55: warning: excess elements in struct initializer
drivers/s390/char/tape_block.c:55: warning: (near initialization for 'tapeblock_fops')
drivers/s390/char/tape_block.c:56: error: unknown field 'release' specified in initializer
drivers/s390/char/tape_block.c:56: warning: excess elements in struct initializer
drivers/s390/char/tape_block.c:56: warning: (near initialization for 'tapeblock_fops')
drivers/s390/char/tape_block.c:57: error: unknown field 'locked_ioctl' specified in initializer
drivers/s390/char/tape_block.c:57: warning: excess elements in struct initializer
drivers/s390/char/tape_block.c:57: warning: (near initialization for 'tapeblock_fops')
drivers/s390/char/tape_block.c:58: error: unknown field 'media_changed' specified in initializer
drivers/s390/char/tape_block.c:58: warning: excess elements in struct initializer
drivers/s390/char/tape_block.c:58: warning: (near initialization for 'tapeblock_fops')
drivers/s390/char/tape_block.c:59: error: unknown field 'revalidate_disk' specified in initializer
drivers/s390/char/tape_block.c:59: warning: excess elements in struct initializer
drivers/s390/char/tape_block.c:59: warning: (near initialization for 'tapeblock_fops')
drivers/s390/char/tape_block.c:77: warning: 'struct request' declared inside parameter list
drivers/s390/char/tape_block.c: In function 'tapeblock_end_request':
drivers/s390/char/tape_block.c:79: error: implicit declaration of function 'blk_end_request'
drivers/s390/char/tape_block.c:79: error: implicit declaration of function 'blk_rq_bytes'
drivers/s390/char/tape_block.c: In function '__tapeblock_end_request':
drivers/s390/char/tape_block.c:93: warning: passing argument 1 of 'tapeblock_end_request' from incompatible pointer type
drivers/s390/char/tape_block.c:97: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:97: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:103: error: implicit declaration of function 'elv_next_request'
drivers/s390/char/tape_block.c: At top level:
drivers/s390/char/tape_block.c:111: warning: 'struct request' declared inside parameter list
drivers/s390/char/tape_block.c: In function 'tapeblock_start_request':
drivers/s390/char/tape_block.c:118: warning: passing argument 2 of 'device->discipline->bread' from incompatible pointer type
drivers/s390/char/tape_block.c:121: warning: passing argument 1 of 'tapeblock_end_request' from incompatible pointer type
drivers/s390/char/tape_block.c:134: warning: passing argument 1 of 'tapeblock_end_request' from incompatible pointer type
drivers/s390/char/tape_block.c: In function 'tapeblock_requeue':
drivers/s390/char/tape_block.c:171: error: implicit declaration of function 'blk_queue_plugged'
drivers/s390/char/tape_block.c:175: warning: assignment makes pointer from integer without a cast
drivers/s390/char/tape_block.c:176: error: implicit declaration of function 'rq_data_dir'
drivers/s390/char/tape_block.c:178: error: implicit declaration of function 'blkdev_dequeue_request'
drivers/s390/char/tape_block.c:180: warning: passing argument 1 of 'tapeblock_end_request' from incompatible pointer type
drivers/s390/char/tape_block.c:187: warning: passing argument 2 of 'tapeblock_start_request' from incompatible pointer type
drivers/s390/char/tape_block.c: In function 'tapeblock_request_fn':
drivers/s390/char/tape_block.c:202: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c: In function 'tapeblock_setup_device':
drivers/s390/char/tape_block.c:223: error: implicit declaration of function 'blk_init_queue'
drivers/s390/char/tape_block.c:226: warning: assignment makes pointer from integer without a cast
drivers/s390/char/tape_block.c:230: error: implicit declaration of function 'elevator_exit'
drivers/s390/char/tape_block.c:230: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:231: error: implicit declaration of function 'elevator_init'
drivers/s390/char/tape_block.c:235: error: implicit declaration of function 'blk_queue_hardsect_size'
drivers/s390/char/tape_block.c:236: error: implicit declaration of function 'blk_queue_max_sectors'
drivers/s390/char/tape_block.c:237: error: implicit declaration of function 'blk_queue_max_phys_segments'
drivers/s390/char/tape_block.c:238: error: implicit declaration of function 'blk_queue_max_hw_segments'
drivers/s390/char/tape_block.c:239: error: implicit declaration of function 'blk_queue_max_segment_size'
drivers/s390/char/tape_block.c:240: error: implicit declaration of function 'blk_queue_segment_boundary'
drivers/s390/char/tape_block.c:242: error: implicit declaration of function 'alloc_disk'
drivers/s390/char/tape_block.c:242: warning: assignment makes pointer from integer without a cast
drivers/s390/char/tape_block.c:248: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:249: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:250: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:251: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:252: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:253: error: implicit declaration of function 'set_capacity'
drivers/s390/char/tape_block.c:254: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:259: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:261: error: implicit declaration of function 'add_disk'
drivers/s390/char/tape_block.c:269: error: implicit declaration of function 'blk_cleanup_queue'
drivers/s390/char/tape_block.c: In function 'tapeblock_cleanup_device':
drivers/s390/char/tape_block.c:287: error: implicit declaration of function 'del_gendisk'
drivers/s390/char/tape_block.c:288: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:289: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c:290: error: implicit declaration of function 'put_disk'
drivers/s390/char/tape_block.c:294: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c: In function 'tapeblock_revalidate_disk':
drivers/s390/char/tape_block.c:311: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c: In function 'tapeblock_medium_changed':
drivers/s390/char/tape_block.c:358: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c: In function 'tapeblock_open':
drivers/s390/char/tape_block.c:375: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c: In function 'tapeblock_release':
drivers/s390/char/tape_block.c:416: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c: In function 'tapeblock_ioctl':
drivers/s390/char/tape_block.c:442: error: dereferencing pointer to incomplete type
drivers/s390/char/tape_block.c: In function 'tapeblock_init':
drivers/s390/char/tape_block.c:471: error: implicit declaration of function 'register_blkdev'
drivers/s390/char/tape_block.c: In function 'tapeblock_exit':
drivers/s390/char/tape_block.c:487: error: implicit declaration of function 'unregister_blkdev'
make[2]: *** [drivers/s390/char/tape_block.o] Error 1

 Adding the dependency of CONFIG_BLOCK to CONFIG_S390_TAPE_BLOCK

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com
--
 drivers/s390/char/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
old mode 100644
new mode 100755
index 6430338..0769ced
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -100,7 +100,7 @@ comment "S/390 tape interface support"
 
 config S390_TAPE_BLOCK
 	bool "Support for tape block devices"
-	depends on S390_TAPE
+	depends on S390_TAPE && BLOCK
 	help
 	  Select this option if you want to access your channel-attached tape
 	  devices using the block device interface.  This interface is similar
--
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.28-next-20081230
# Wed Dec 31 04:35:58 2008
#
CONFIG_SCHED_MC=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_NO_IOMEM=y
CONFIG_NO_DMA=y
CONFIG_PGSTE=y
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_S390=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
# CONFIG_TASK_XACCT is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=m
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_NS=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CPUSETS is not set
# CONFIG_GROUP_SCHED is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_RESOURCE_COUNTERS=y
CONFIG_MM_OWNER=y
CONFIG_CGROUP_MEM_RES_CTLR=y
CONFIG_RELAY=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_STRIP_GENERATED=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
# CONFIG_HOTPLUG is not set
CONFIG_PRINTK=y
# CONFIG_BUG is not set
CONFIG_ELF_CORE=y
CONFIG_COMPAT_BRK=y
CONFIG_BASE_FULL=y
# CONFIG_FUTEX is not set
CONFIG_ANON_INODES=y
# CONFIG_EPOLL is not set
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
# CONFIG_EVENTFD is not set
# CONFIG_SHMEM is not set
CONFIG_AIO=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_MARKERS=y
CONFIG_OPROFILE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_KPROBES=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_USE_GENERIC_SMP_HELPERS=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_TINY_SHMEM=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_INIT_ALL_POSSIBLE=y
# CONFIG_BLOCK is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_CLASSIC_RCU=y
# CONFIG_TREE_RCU is not set
# CONFIG_PREEMPT_RCU is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_PREEMPT_RCU_TRACE is not set
# CONFIG_FREEZER is not set

#
# Base setup
#

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_64BIT=y
CONFIG_SMP=y
CONFIG_NR_CPUS=64
# CONFIG_HOTPLUG_CPU is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_AUDIT_ARCH=y
CONFIG_S390_SWITCH_AMODE=y
# CONFIG_S390_EXEC_PROTECT is not set

#
# Code generation options
#
# CONFIG_MARCH_G5 is not set
CONFIG_MARCH_Z900=y
# CONFIG_MARCH_Z990 is not set
# CONFIG_MARCH_Z9_109 is not set
# CONFIG_MARCH_Z10 is not set
# CONFIG_PACK_STACK is not set
CONFIG_CHECK_STACK=y
CONFIG_STACK_GUARD=256
CONFIG_WARN_STACK=y
CONFIG_WARN_STACK_SIZE=2048
CONFIG_ARCH_POPULATES_NODE_MAP=y

#
# Kernel preemption
#
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
# CONFIG_DISCONTIGMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_RESOURCES_64BIT=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_VIRT_TO_BUS=y
CONFIG_UNEVICTABLE_LRU=y

#
# I/O subsystem configuration
#
# CONFIG_MACHCHK_WARNING is not set
CONFIG_QDIO=m
# CONFIG_CHSC_SCH is not set

#
# Misc
#
CONFIG_IPL=y
# CONFIG_IPL_TAPE is not set
CONFIG_IPL_VM=y
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_FORCE_MAX_ZONEORDER=9
# CONFIG_PROCESS_DEBUG is not set
CONFIG_PFAULT=y
# CONFIG_SHARED_KERNEL is not set
# CONFIG_CMM is not set
CONFIG_PAGE_STATES=y
# CONFIG_APPLDATA_BASE is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_SCHED_HRTICK is not set
CONFIG_S390_HYPFS_FS=y
CONFIG_KEXEC=y
CONFIG_ZFCPDUMP=y
# CONFIG_S390_GUEST is not set
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NET_NS is not set
CONFIG_COMPAT_NET_DEV_OPS=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=m
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_IUCV=y
# CONFIG_AFIUCV is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_LRO=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
# CONFIG_TCP_CONG_CUBIC is not set
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=y
# CONFIG_TCP_CONG_HSTCP is not set
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=y
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=y
CONFIG_TCP_CONG_YEAH=y
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_DEFAULT_BIC=y
# CONFIG_DEFAULT_CUBIC is not set
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="bic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_MSG=y
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
# CONFIG_ATM_BR2684 is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=m
CONFIG_IPX=y
CONFIG_IPX_INTERN=y
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=m
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_ECONET_NATIVE=y
CONFIG_WAN_ROUTER=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
# CONFIG_NET_SCH_ATM is not set
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=m
# CONFIG_NET_SCH_TEQL is not set
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
# CONFIG_NET_CLS_TCINDEX is not set
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
CONFIG_NET_ACT_GACT=y
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_NAT=y
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=m
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_NET_TCPPROBE is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=m
CONFIG_PHONET=m
CONFIG_FIB_RULES=y
CONFIG_RFKILL=m
CONFIG_NET_9P=y
CONFIG_NET_9P_DEBUG=y
# CONFIG_PCMCIA is not set
CONFIG_CCW=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_CONNECTOR=m
CONFIG_MISC_DEVICES=y
CONFIG_EEPROM_93CX6=y
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_C2PORT=m

#
# SCSI device support
#
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_NETDEVICES=y
CONFIG_IFB=m
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
CONFIG_MACVLAN=y
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_VETH is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_NETDEV_1000 is not set
CONFIG_NETDEV_10000=y
CONFIG_TR=y
CONFIG_WAN=y
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
# CONFIG_HDLC_FR is not set
CONFIG_HDLC_PPP=m
# CONFIG_HDLC_X25 is not set
# CONFIG_DLCI is not set
CONFIG_WAN_ROUTER_DRIVERS=m
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=m
CONFIG_ATM_TCP=m

#
# S/390 network device drivers
#
CONFIG_LCS=m
CONFIG_CTCM=y
CONFIG_NETIUCV=m
# CONFIG_SMSGIUCV is not set
CONFIG_CLAW=y
CONFIG_QETH=m
CONFIG_QETH_L2=m
CONFIG_QETH_L3=m
CONFIG_QETH_IPV6=y
CONFIG_CCWGROUP=y
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# Character devices
#
CONFIG_DEVKMEM=y
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IUCV=y
CONFIG_HW_RANDOM=m
# CONFIG_R3964 is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# S/390 character device drivers
#
# CONFIG_TN3270 is not set
CONFIG_TN3215=y
# CONFIG_TN3215_CONSOLE is not set
CONFIG_SCLP_TTY=y
CONFIG_SCLP_CONSOLE=y
CONFIG_SCLP_VT220_TTY=y
CONFIG_SCLP_VT220_CONSOLE=y
# CONFIG_SCLP_CPI is not set
CONFIG_S390_TAPE=y

#
# S/390 tape interface support
#

#
# S/390 tape hardware support
#
# CONFIG_S390_TAPE_34XX is not set
CONFIG_S390_TAPE_3590=m
CONFIG_VMLOGRDR=m
# CONFIG_VMCP is not set
CONFIG_MONREADER=m
# CONFIG_MONWRITER is not set
CONFIG_S390_VMUR=y
# CONFIG_POWER_SUPPLY is not set
# CONFIG_THERMAL is not set
CONFIG_THERMAL_HWMON=y
# CONFIG_WATCHDOG is not set
# CONFIG_REGULATOR is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_NEW_LEDS is not set
CONFIG_ACCESSIBILITY=y
CONFIG_STAGING=y
# CONFIG_STAGING_EXCLUDE_BUILD is not set
CONFIG_ECHO=y

#
# File systems
#
CONFIG_FS_POSIX_ACL=y
CONFIG_DNOTIFY=y
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_GENERIC_ACL=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_SYSCTL is not set
# CONFIG_PROC_PAGE_MONITOR is not set
# CONFIG_SYSFS is not set
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set

#
# Miscellaneous filesystems
#
# CONFIG_ECRYPT_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
# CONFIG_NLS is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_KERNEL=y
CONFIG_SCHED_DEBUG=y
CONFIG_SCHEDSTATS=y
CONFIG_TIMER_STATS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_TRACE_IRQFLAGS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
CONFIG_DEBUG_KOBJECT=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_WRITECOUNT=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_FRAME_POINTER=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_DETECTOR=y
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_LATENCYTOP=y
CONFIG_SYSCTL_SYSCALL_CHECK=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_RING_BUFFER=y
CONFIG_TRACING=y

#
# Tracers
#
# CONFIG_FUNCTION_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_BOOT_TRACER=y
# CONFIG_TRACE_BRANCH_PROFILING is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BUILD_DOCSRC=y
CONFIG_DYNAMIC_PRINTK_DEBUG=y
CONFIG_SAMPLES=y
CONFIG_SAMPLE_MARKERS=m
CONFIG_SAMPLE_TRACEPOINTS=m
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
CONFIG_DEBUG_PAGEALLOC=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
CONFIG_SECURITYFS=y
CONFIG_SECURITY_FILE_CAPABILITIES=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_FIPS=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_HW=y
CONFIG_ZCRYPT=m
# CONFIG_ZCRYPT_MONOLITHIC is not set
CONFIG_CRYPTO_SHA1_S390=y
CONFIG_CRYPTO_SHA256_S390=y
CONFIG_CRYPTO_SHA512_S390=m
# CONFIG_CRYPTO_DES_S390 is not set
CONFIG_CRYPTO_AES_S390=y
CONFIG_S390_PRNG=m

#
# Library routines
#
CONFIG_BITREVERSE=m
CONFIG_GENERIC_FIND_LAST_BIT=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_VIRTIO_BALLOON is not set
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
