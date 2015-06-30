Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 30 Jun 2015 17:00:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.2 merge window #2
Message-ID: <20150630170023.3fdd75d6@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

The second part of the s390 patches for the 4.2 merge window.

There is one larger patch for the AP bus code to make it work with the
longer reset periods of the latest crypto cards. 

A new default configuration, a naming cleanup for SMP and a few fixes.

Heiko Carstens (2):
      s390: new default configuration
      s390/kdump: fix compile for !SMP

Ingo Tuchscherer (1):
      s390/zcrypt: Fixed reset and interrupt handling of AP queues

Martin Schwidefsky (2):
      s390/smp: fix sigp cpu detection loop
      s390/smp: cleanup core vs. cpu in the SCLP interface

Michael Holzheu (3):
      s390/bpf: Fix backward jumps
      s390/kdump: fix REGSET_VX_LOW vector register ELF notes
      s390/kdump: fix nosmt kernel parameter

 arch/s390/configs/default_defconfig     |  15 +-
 arch/s390/configs/gcov_defconfig        |  13 +-
 arch/s390/configs/performance_defconfig |  16 +-
 arch/s390/defconfig                     |  12 +-
 arch/s390/include/asm/cpu.h             |   2 -
 arch/s390/include/asm/ipl.h             |   1 -
 arch/s390/include/asm/sclp.h            |  18 +-
 arch/s390/include/asm/smp.h             |   2 +
 arch/s390/kernel/base.S                 |  21 +-
 arch/s390/kernel/crash_dump.c           |  27 +-
 arch/s390/kernel/setup.c                |   5 +
 arch/s390/kernel/smp.c                  | 150 +++++------
 arch/s390/net/bpf_jit_comp.c            |   2 +-
 drivers/s390/char/sclp_cmd.c            |  23 +-
 drivers/s390/char/sclp_early.c          |  10 +-
 drivers/s390/char/zcore.c               |   2 +-
 drivers/s390/crypto/ap_bus.c            | 424 +++++++++++++++++---------------
 drivers/s390/crypto/ap_bus.h            |  13 +-
 drivers/s390/crypto/zcrypt_cex4.c       |   2 +-
 19 files changed, 401 insertions(+), 357 deletions(-)

diff --git a/arch/s390/configs/default_defconfig b/arch/s390/configs/default_defconfig
index 6470775..940cbdd 100644
--- a/arch/s390/configs/default_defconfig
+++ b/arch/s390/configs/default_defconfig
@@ -17,13 +17,15 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_PERF=y
 CONFIG_CFS_BANDWIDTH=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
+CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=m
@@ -44,6 +46,7 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_CFQ_GROUP_IOSCHED=y
 CONFIG_DEFAULT_DEADLINE=y
+CONFIG_LIVEPATCH=y
 CONFIG_MARCH_Z196=y
 CONFIG_TUNE_ZEC12=y
 CONFIG_NR_CPUS=256
@@ -242,9 +245,9 @@ CONFIG_NF_CONNTRACK_IPV4=m
 # CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
 CONFIG_NF_TABLES_IPV4=m
 CONFIG_NFT_CHAIN_ROUTE_IPV4=m
-CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_NF_TABLES_ARP=m
 CONFIG_NF_NAT_IPV4=m
+CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -264,8 +267,8 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_TABLES_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NF_NAT_IPV6=m
+CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -353,7 +356,6 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_OSD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_BLK_DEV_XIP=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_VIRTIO_BLK=y
@@ -458,7 +460,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
@@ -544,7 +545,6 @@ CONFIG_FRAME_WARN=1024
 CONFIG_READABLE_ASM=y
 CONFIG_UNUSED_SYMBOLS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_OBJECTS_SELFTEST=y
@@ -558,6 +558,7 @@ CONFIG_SLUB_STATS=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_RB=y
+CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
 CONFIG_DEBUG_PER_CPU_MAPS=y
 CONFIG_DEBUG_SHIRQ=y
@@ -575,7 +576,6 @@ CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_SG=y
 CONFIG_DEBUG_NOTIFIERS=y
 CONFIG_DEBUG_CREDENTIALS=y
-CONFIG_PROVE_RCU=y
 CONFIG_RCU_TORTURE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=300
 CONFIG_NOTIFIER_ERROR_INJECTION=m
@@ -611,7 +611,6 @@ CONFIG_TEST_BPF=m
 # CONFIG_STRICT_DEVMEM is not set
 CONFIG_S390_PTDUMP=y
 CONFIG_ENCRYPTED_KEYS=m
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/arch/s390/configs/gcov_defconfig b/arch/s390/configs/gcov_defconfig
index 5c30972..d793fec 100644
--- a/arch/s390/configs/gcov_defconfig
+++ b/arch/s390/configs/gcov_defconfig
@@ -17,11 +17,13 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_PERF=y
 CONFIG_BLK_CGROUP=y
+CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=m
@@ -240,9 +242,9 @@ CONFIG_NF_CONNTRACK_IPV4=m
 # CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
 CONFIG_NF_TABLES_IPV4=m
 CONFIG_NFT_CHAIN_ROUTE_IPV4=m
-CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_NF_TABLES_ARP=m
 CONFIG_NF_NAT_IPV4=m
+CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -262,8 +264,8 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_TABLES_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NF_NAT_IPV6=m
+CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -350,7 +352,6 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_OSD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_BLK_DEV_XIP=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_VIRTIO_BLK=y
@@ -455,7 +456,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
@@ -538,7 +538,7 @@ CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_WARN=1024
 CONFIG_UNUSED_SYMBOLS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_TIMER_STATS=y
@@ -558,7 +558,6 @@ CONFIG_ATOMIC64_SELFTEST=y
 # CONFIG_STRICT_DEVMEM is not set
 CONFIG_S390_PTDUMP=y
 CONFIG_ENCRYPTED_KEYS=m
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index bda70f1..38a77e9 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -17,11 +17,13 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_PERF=y
 CONFIG_BLK_CGROUP=y
+CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=m
@@ -42,9 +44,10 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_CFQ_GROUP_IOSCHED=y
 CONFIG_DEFAULT_DEADLINE=y
+CONFIG_LIVEPATCH=y
 CONFIG_MARCH_Z196=y
 CONFIG_TUNE_ZEC12=y
-CONFIG_NR_CPUS=256
+CONFIG_NR_CPUS=512
 CONFIG_HZ_100=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
@@ -238,9 +241,9 @@ CONFIG_NF_CONNTRACK_IPV4=m
 # CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
 CONFIG_NF_TABLES_IPV4=m
 CONFIG_NFT_CHAIN_ROUTE_IPV4=m
-CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_NF_TABLES_ARP=m
 CONFIG_NF_NAT_IPV4=m
+CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -260,8 +263,8 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_TABLES_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NF_NAT_IPV6=m
+CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -348,7 +351,6 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_OSD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_BLK_DEV_XIP=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_VIRTIO_BLK=y
@@ -453,7 +455,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
@@ -536,7 +537,7 @@ CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_WARN=1024
 CONFIG_UNUSED_SYMBOLS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_TIMER_STATS=y
 CONFIG_RCU_TORTURE_TEST=m
@@ -553,7 +554,6 @@ CONFIG_ATOMIC64_SELFTEST=y
 # CONFIG_STRICT_DEVMEM is not set
 CONFIG_S390_PTDUMP=y
 CONFIG_ENCRYPTED_KEYS=m
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index 83ef702..9256b48 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -8,7 +8,6 @@ CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
-CONFIG_RCU_FAST_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
@@ -31,9 +30,11 @@ CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
+CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IBM_PARTITION=y
 CONFIG_DEFAULT_DEADLINE=y
+CONFIG_LIVEPATCH=y
 CONFIG_MARCH_Z196=y
 CONFIG_NR_CPUS=256
 CONFIG_HZ_100=y
@@ -41,7 +42,6 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_CMA=y
 CONFIG_CRASH_DUMP=y
 CONFIG_BINFMT_MISC=m
 CONFIG_HIBERNATION=y
@@ -125,6 +125,7 @@ CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DETECT_HUNG_TASK=y
+CONFIG_PANIC_ON_OOPS=y
 CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_PROVE_LOCKING=y
@@ -135,12 +136,16 @@ CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_PI_LIST=y
 CONFIG_DEBUG_SG=y
 CONFIG_DEBUG_NOTIFIERS=y
-CONFIG_PROVE_RCU=y
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
+# CONFIG_RCU_CPU_STALL_INFO is not set
 CONFIG_RCU_TRACE=y
 CONFIG_LATENCYTOP=y
 CONFIG_DEBUG_STRICT_USER_COPY_CHECKS=y
+CONFIG_TRACER_SNAPSHOT=y
+CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
+CONFIG_STACK_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_UPROBE_EVENT=y
 CONFIG_KPROBES_SANITY_TEST=y
 # CONFIG_STRICT_DEVMEM is not set
 CONFIG_S390_PTDUMP=y
@@ -187,6 +192,7 @@ CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_LZ4=m
 CONFIG_CRYPTO_LZ4HC=m
+CONFIG_CRYPTO_ANSI_CPRNG=m
 CONFIG_ZCRYPT=m
 CONFIG_CRYPTO_SHA1_S390=m
 CONFIG_CRYPTO_SHA256_S390=m
diff --git a/arch/s390/include/asm/cpu.h b/arch/s390/include/asm/cpu.h
index f5a8e2f..9154100 100644
--- a/arch/s390/include/asm/cpu.h
+++ b/arch/s390/include/asm/cpu.h
@@ -8,8 +8,6 @@
 #ifndef _ASM_S390_CPU_H
 #define _ASM_S390_CPU_H
 
-#define MAX_CPU_ADDRESS 255
-
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
index ece606c..39ae6a3 100644
--- a/arch/s390/include/asm/ipl.h
+++ b/arch/s390/include/asm/ipl.h
@@ -94,7 +94,6 @@ struct dump_save_areas {
 };
 
 extern struct dump_save_areas dump_save_areas;
-struct save_area_ext *dump_save_area_create(int cpu);
 
 extern void do_reipl(void);
 extern void do_halt(void);
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index c891f41..f6ff060 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -11,6 +11,7 @@
 #include <asm/cpu.h>
 
 #define SCLP_CHP_INFO_MASK_SIZE		32
+#define SCLP_MAX_CORES			256
 
 struct sclp_chp_info {
 	u8 recognized[SCLP_CHP_INFO_MASK_SIZE];
@@ -26,7 +27,7 @@ struct sclp_ipl_info {
 	char loadparm[LOADPARM_LEN];
 };
 
-struct sclp_cpu_entry {
+struct sclp_core_entry {
 	u8 core_id;
 	u8 reserved0[2];
 	u8 : 3;
@@ -38,12 +39,11 @@ struct sclp_cpu_entry {
 	u8 reserved1;
 } __attribute__((packed));
 
-struct sclp_cpu_info {
+struct sclp_core_info {
 	unsigned int configured;
 	unsigned int standby;
 	unsigned int combined;
-	int has_cpu_type;
-	struct sclp_cpu_entry cpu[MAX_CPU_ADDRESS + 1];
+	struct sclp_core_entry core[SCLP_MAX_CORES];
 };
 
 struct sclp_info {
@@ -51,7 +51,7 @@ struct sclp_info {
 	unsigned char has_vt220 : 1;
 	unsigned char has_siif : 1;
 	unsigned char has_sigpif : 1;
-	unsigned char has_cpu_type : 1;
+	unsigned char has_core_type : 1;
 	unsigned char has_sprp : 1;
 	unsigned int ibc;
 	unsigned int mtid;
@@ -60,15 +60,15 @@ struct sclp_info {
 	unsigned long long rzm;
 	unsigned long long rnmax;
 	unsigned long long hamax;
-	unsigned int max_cpu;
+	unsigned int max_cores;
 	unsigned long hsa_size;
 	unsigned long long facilities;
 };
 extern struct sclp_info sclp;
 
-int sclp_get_cpu_info(struct sclp_cpu_info *info);
-int sclp_cpu_configure(u8 cpu);
-int sclp_cpu_deconfigure(u8 cpu);
+int sclp_get_core_info(struct sclp_core_info *info);
+int sclp_core_configure(u8 core);
+int sclp_core_deconfigure(u8 core);
 int sclp_sdias_blk_count(void);
 int sclp_sdias_copy(void *dest, int blk_num, int nr_blks);
 int sclp_chp_configure(struct chp_id chpid);
diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index b3bd028..5df26b1 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -29,6 +29,7 @@ extern void smp_call_ipl_cpu(void (*func)(void *), void *);
 
 extern int smp_find_processor_id(u16 address);
 extern int smp_store_status(int cpu);
+extern void smp_save_dump_cpus(void);
 extern int smp_vcpu_scheduled(int cpu);
 extern void smp_yield_cpu(int cpu);
 extern void smp_cpu_set_polarization(int cpu, int val);
@@ -54,6 +55,7 @@ static inline int smp_store_status(int cpu) { return 0; }
 static inline int smp_vcpu_scheduled(int cpu) { return 1; }
 static inline void smp_yield_cpu(int cpu) { }
 static inline void smp_fill_possible_mask(void) { }
+static inline void smp_save_dump_cpus(void) { }
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/s390/kernel/base.S b/arch/s390/kernel/base.S
index daed3fd..326f717 100644
--- a/arch/s390/kernel/base.S
+++ b/arch/s390/kernel/base.S
@@ -78,15 +78,20 @@ s390_base_pgm_handler_fn:
 #
 # Calls diag 308 subcode 1 and continues execution
 #
-# The following conditions must be ensured before calling this function:
-# * Prefix register = 0
-# * Lowcore protection is disabled
-#
 ENTRY(diag308_reset)
 	larl	%r4,.Lctlregs		# Save control registers
 	stctg	%c0,%c15,0(%r4)
+	lg	%r2,0(%r4)		# Disable lowcore protection
+	nilh	%r2,0xefff
+	larl	%r4,.Lctlreg0
+	stg	%r2,0(%r4)
+	lctlg	%c0,%c0,0(%r4)
 	larl	%r4,.Lfpctl		# Floating point control register
 	stfpc	0(%r4)
+	larl	%r4,.Lprefix		# Save prefix register
+	stpx	0(%r4)
+	larl	%r4,.Lprefix_zero	# Set prefix register to 0
+	spx	0(%r4)
 	larl	%r4,.Lcontinue_psw	# Save PSW flags
 	epsw	%r2,%r3
 	stm	%r2,%r3,0(%r4)
@@ -106,6 +111,8 @@ ENTRY(diag308_reset)
 	lctlg	%c0,%c15,0(%r4)
 	larl	%r4,.Lfpctl		# Restore floating point ctl register
 	lfpc	0(%r4)
+	larl	%r4,.Lprefix		# Restore prefix register
+	spx	0(%r4)
 	larl	%r4,.Lcontinue_psw	# Restore PSW flags
 	lpswe	0(%r4)
 .Lcontinue:
@@ -122,10 +129,16 @@ ENTRY(diag308_reset)
 
 	.section .bss
 .align 8
+.Lctlreg0:
+	.quad	0
 .Lctlregs:
 	.rept	16
 	.quad	0
 	.endr
 .Lfpctl:
 	.long	0
+.Lprefix:
+	.long	0
+.Lprefix_zero:
+	.long	0
 	.previous
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 7a75ad4..0c6c01e 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -45,31 +45,6 @@ static struct memblock_type oldmem_type = {
 struct dump_save_areas dump_save_areas;
 
 /*
- * Allocate and add a save area for a CPU
- */
-struct save_area_ext *dump_save_area_create(int cpu)
-{
-	struct save_area_ext **save_areas, *save_area;
-
-	save_area = kmalloc(sizeof(*save_area), GFP_KERNEL);
-	if (!save_area)
-		return NULL;
-	if (cpu + 1 > dump_save_areas.count) {
-		dump_save_areas.count = cpu + 1;
-		save_areas = krealloc(dump_save_areas.areas,
-				      dump_save_areas.count * sizeof(void *),
-				      GFP_KERNEL | __GFP_ZERO);
-		if (!save_areas) {
-			kfree(save_area);
-			return NULL;
-		}
-		dump_save_areas.areas = save_areas;
-	}
-	dump_save_areas.areas[cpu] = save_area;
-	return save_area;
-}
-
-/*
  * Return physical address for virtual address
  */
 static inline void *load_real_addr(void *addr)
@@ -416,7 +391,7 @@ static void *nt_s390_vx_low(void *ptr, __vector128 *vx_regs)
 	ptr += len;
 	/* Copy lower halves of SIMD registers 0-15 */
 	for (i = 0; i < 16; i++) {
-		memcpy(ptr, &vx_regs[i], 8);
+		memcpy(ptr, &vx_regs[i].u[2], 8);
 		ptr += 8;
 	}
 	return ptr;
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index af4f41d..ca070d2 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -868,6 +868,11 @@ void __init setup_arch(char **cmdline_p)
 
 	check_initrd();
 	reserve_crashkernel();
+	/*
+	 * Be aware that smp_save_dump_cpus() triggers a system reset.
+	 * Therefore CPU and device initialization should be done afterwards.
+	 */
+	smp_save_dump_cpus();
 
 	setup_resources();
 	setup_vmcoreinfo();
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0d9d59d..6f54c17 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -31,6 +31,7 @@
 #include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/crash_dump.h>
+#include <linux/memblock.h>
 #include <asm/asm-offsets.h>
 #include <asm/switch_to.h>
 #include <asm/facility.h>
@@ -69,7 +70,7 @@ struct pcpu {
 	u16 address;			/* physical cpu address */
 };
 
-static u8 boot_cpu_type;
+static u8 boot_core_type;
 static struct pcpu pcpu_devices[NR_CPUS];
 
 unsigned int smp_cpu_mt_shift;
@@ -531,15 +532,12 @@ EXPORT_SYMBOL(smp_ctl_clear_bit);
 
 #ifdef CONFIG_CRASH_DUMP
 
-static inline void __smp_store_cpu_state(int cpu, u16 address, int is_boot_cpu)
+static void __smp_store_cpu_state(struct save_area_ext *sa_ext, u16 address,
+				  int is_boot_cpu)
 {
-	void *lc = pcpu_devices[0].lowcore;
-	struct save_area_ext *sa_ext;
+	void *lc = (void *)(unsigned long) store_prefix();
 	unsigned long vx_sa;
 
-	sa_ext = dump_save_area_create(cpu);
-	if (!sa_ext)
-		panic("could not allocate memory for save area\n");
 	if (is_boot_cpu) {
 		/* Copy the registers of the boot CPU. */
 		copy_oldmem_page(1, (void *) &sa_ext->sa, sizeof(sa_ext->sa),
@@ -554,14 +552,33 @@ static inline void __smp_store_cpu_state(int cpu, u16 address, int is_boot_cpu)
 	if (!MACHINE_HAS_VX)
 		return;
 	/* Get the VX registers */
-	vx_sa = __get_free_page(GFP_KERNEL);
+	vx_sa = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	if (!vx_sa)
 		panic("could not allocate memory for VX save area\n");
 	__pcpu_sigp_relax(address, SIGP_STORE_ADDITIONAL_STATUS, vx_sa, NULL);
 	memcpy(sa_ext->vx_regs, (void *) vx_sa, sizeof(sa_ext->vx_regs));
-	free_page(vx_sa);
+	memblock_free(vx_sa, PAGE_SIZE);
 }
 
+int smp_store_status(int cpu)
+{
+	unsigned long vx_sa;
+	struct pcpu *pcpu;
+
+	pcpu = pcpu_devices + cpu;
+	if (__pcpu_sigp_relax(pcpu->address, SIGP_STOP_AND_STORE_STATUS,
+			      0, NULL) != SIGP_CC_ORDER_CODE_ACCEPTED)
+		return -EIO;
+	if (!MACHINE_HAS_VX)
+		return 0;
+	vx_sa = __pa(pcpu->lowcore->vector_save_area_addr);
+	__pcpu_sigp_relax(pcpu->address, SIGP_STORE_ADDITIONAL_STATUS,
+			  vx_sa, NULL);
+	return 0;
+}
+
+#endif /* CONFIG_CRASH_DUMP */
+
 /*
  * Collect CPU state of the previous, crashed system.
  * There are four cases:
@@ -589,10 +606,12 @@ static inline void __smp_store_cpu_state(int cpu, u16 address, int is_boot_cpu)
  *    old system. The ELF sections are picked up by the crash_dump code
  *    via elfcorehdr_addr.
  */
-static void __init smp_store_cpu_states(struct sclp_cpu_info *info)
+void __init smp_save_dump_cpus(void)
 {
-	unsigned int cpu, address, i, j;
-	int is_boot_cpu;
+#ifdef CONFIG_CRASH_DUMP
+	int addr, cpu, boot_cpu_addr, max_cpu_addr;
+	struct save_area_ext *sa_ext;
+	bool is_boot_cpu;
 
 	if (is_kdump_kernel())
 		/* Previous system stored the CPU states. Nothing to do. */
@@ -602,42 +621,36 @@ static void __init smp_store_cpu_states(struct sclp_cpu_info *info)
 		return;
 	/* Set multi-threading state to the previous system. */
 	pcpu_set_smt(sclp.mtid_prev);
-	/* Collect CPU states. */
-	cpu = 0;
-	for (i = 0; i < info->configured; i++) {
-		/* Skip CPUs with different CPU type. */
-		if (info->has_cpu_type && info->cpu[i].type != boot_cpu_type)
+	max_cpu_addr = SCLP_MAX_CORES << sclp.mtid_prev;
+	for (cpu = 0, addr = 0; addr <= max_cpu_addr; addr++) {
+		if (__pcpu_sigp_relax(addr, SIGP_SENSE, 0, NULL) ==
+		    SIGP_CC_NOT_OPERATIONAL)
 			continue;
-		for (j = 0; j <= smp_cpu_mtid; j++, cpu++) {
-			address = (info->cpu[i].core_id << smp_cpu_mt_shift) + j;
-			is_boot_cpu = (address == pcpu_devices[0].address);
-			if (is_boot_cpu && !OLDMEM_BASE)
-				/* Skip boot CPU for standard zfcp dump. */
-				continue;
-			/* Get state for this CPu. */
-			__smp_store_cpu_state(cpu, address, is_boot_cpu);
-		}
+		cpu += 1;
 	}
-}
-
-int smp_store_status(int cpu)
-{
-	unsigned long vx_sa;
-	struct pcpu *pcpu;
-
-	pcpu = pcpu_devices + cpu;
-	if (__pcpu_sigp_relax(pcpu->address, SIGP_STOP_AND_STORE_STATUS,
-			      0, NULL) != SIGP_CC_ORDER_CODE_ACCEPTED)
-		return -EIO;
-	if (!MACHINE_HAS_VX)
-		return 0;
-	vx_sa = __pa(pcpu->lowcore->vector_save_area_addr);
-	__pcpu_sigp_relax(pcpu->address, SIGP_STORE_ADDITIONAL_STATUS,
-			  vx_sa, NULL);
-	return 0;
-}
-
+	dump_save_areas.areas = (void *)memblock_alloc(sizeof(void *) * cpu, 8);
+	dump_save_areas.count = cpu;
+	boot_cpu_addr = stap();
+	for (cpu = 0, addr = 0; addr <= max_cpu_addr; addr++) {
+		if (__pcpu_sigp_relax(addr, SIGP_SENSE, 0, NULL) ==
+		    SIGP_CC_NOT_OPERATIONAL)
+			continue;
+		sa_ext = (void *) memblock_alloc(sizeof(*sa_ext), 8);
+		dump_save_areas.areas[cpu] = sa_ext;
+		if (!sa_ext)
+			panic("could not allocate memory for save area\n");
+		is_boot_cpu = (addr == boot_cpu_addr);
+		cpu += 1;
+		if (is_boot_cpu && !OLDMEM_BASE)
+			/* Skip boot CPU for standard zfcp dump. */
+			continue;
+		/* Get state for this CPU. */
+		__smp_store_cpu_state(sa_ext, addr, is_boot_cpu);
+	}
+	diag308_reset();
+	pcpu_set_smt(0);
 #endif /* CONFIG_CRASH_DUMP */
+}
 
 void smp_cpu_set_polarization(int cpu, int val)
 {
@@ -649,21 +662,22 @@ int smp_cpu_get_polarization(int cpu)
 	return pcpu_devices[cpu].polarization;
 }
 
-static struct sclp_cpu_info *smp_get_cpu_info(void)
+static struct sclp_core_info *smp_get_core_info(void)
 {
 	static int use_sigp_detection;
-	struct sclp_cpu_info *info;
+	struct sclp_core_info *info;
 	int address;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (info && (use_sigp_detection || sclp_get_cpu_info(info))) {
+	if (info && (use_sigp_detection || sclp_get_core_info(info))) {
 		use_sigp_detection = 1;
-		for (address = 0; address <= MAX_CPU_ADDRESS;
+		for (address = 0;
+		     address < (SCLP_MAX_CORES << smp_cpu_mt_shift);
 		     address += (1U << smp_cpu_mt_shift)) {
 			if (__pcpu_sigp_relax(address, SIGP_SENSE, 0, NULL) ==
 			    SIGP_CC_NOT_OPERATIONAL)
 				continue;
-			info->cpu[info->configured].core_id =
+			info->core[info->configured].core_id =
 				address >> smp_cpu_mt_shift;
 			info->configured++;
 		}
@@ -674,7 +688,7 @@ static struct sclp_cpu_info *smp_get_cpu_info(void)
 
 static int smp_add_present_cpu(int cpu);
 
-static int __smp_rescan_cpus(struct sclp_cpu_info *info, int sysfs_add)
+static int __smp_rescan_cpus(struct sclp_core_info *info, int sysfs_add)
 {
 	struct pcpu *pcpu;
 	cpumask_t avail;
@@ -685,9 +699,9 @@ static int __smp_rescan_cpus(struct sclp_cpu_info *info, int sysfs_add)
 	cpumask_xor(&avail, cpu_possible_mask, cpu_present_mask);
 	cpu = cpumask_first(&avail);
 	for (i = 0; (i < info->combined) && (cpu < nr_cpu_ids); i++) {
-		if (info->has_cpu_type && info->cpu[i].type != boot_cpu_type)
+		if (sclp.has_core_type && info->core[i].type != boot_core_type)
 			continue;
-		address = info->cpu[i].core_id << smp_cpu_mt_shift;
+		address = info->core[i].core_id << smp_cpu_mt_shift;
 		for (j = 0; j <= smp_cpu_mtid; j++) {
 			if (pcpu_find_address(cpu_present_mask, address + j))
 				continue;
@@ -713,41 +727,37 @@ static int __smp_rescan_cpus(struct sclp_cpu_info *info, int sysfs_add)
 static void __init smp_detect_cpus(void)
 {
 	unsigned int cpu, mtid, c_cpus, s_cpus;
-	struct sclp_cpu_info *info;
+	struct sclp_core_info *info;
 	u16 address;
 
 	/* Get CPU information */
-	info = smp_get_cpu_info();
+	info = smp_get_core_info();
 	if (!info)
 		panic("smp_detect_cpus failed to allocate memory\n");
 
 	/* Find boot CPU type */
-	if (info->has_cpu_type) {
+	if (sclp.has_core_type) {
 		address = stap();
 		for (cpu = 0; cpu < info->combined; cpu++)
-			if (info->cpu[cpu].core_id == address) {
+			if (info->core[cpu].core_id == address) {
 				/* The boot cpu dictates the cpu type. */
-				boot_cpu_type = info->cpu[cpu].type;
+				boot_core_type = info->core[cpu].type;
 				break;
 			}
 		if (cpu >= info->combined)
 			panic("Could not find boot CPU type");
 	}
 
-#ifdef CONFIG_CRASH_DUMP
-	/* Collect CPU state of previous system */
-	smp_store_cpu_states(info);
-#endif
-
 	/* Set multi-threading state for the current system */
-	mtid = boot_cpu_type ? sclp.mtid : sclp.mtid_cp;
+	mtid = boot_core_type ? sclp.mtid : sclp.mtid_cp;
 	mtid = (mtid < smp_max_threads) ? mtid : smp_max_threads - 1;
 	pcpu_set_smt(mtid);
 
 	/* Print number of CPUs */
 	c_cpus = s_cpus = 0;
 	for (cpu = 0; cpu < info->combined; cpu++) {
-		if (info->has_cpu_type && info->cpu[cpu].type != boot_cpu_type)
+		if (sclp.has_core_type &&
+		    info->core[cpu].type != boot_core_type)
 			continue;
 		if (cpu < info->configured)
 			c_cpus += smp_cpu_mtid + 1;
@@ -884,7 +894,7 @@ void __init smp_fill_possible_mask(void)
 
 	sclp_max = max(sclp.mtid, sclp.mtid_cp) + 1;
 	sclp_max = min(smp_max_threads, sclp_max);
-	sclp_max = sclp.max_cpu * sclp_max ?: nr_cpu_ids;
+	sclp_max = sclp.max_cores * sclp_max ?: nr_cpu_ids;
 	possible = setup_possible_cpus ?: nr_cpu_ids;
 	possible = min(possible, sclp_max);
 	for (cpu = 0; cpu < possible && cpu < nr_cpu_ids; cpu++)
@@ -977,7 +987,7 @@ static ssize_t cpu_configure_store(struct device *dev,
 	case 0:
 		if (pcpu->state != CPU_STATE_CONFIGURED)
 			break;
-		rc = sclp_cpu_deconfigure(pcpu->address >> smp_cpu_mt_shift);
+		rc = sclp_core_deconfigure(pcpu->address >> smp_cpu_mt_shift);
 		if (rc)
 			break;
 		for (i = 0; i <= smp_cpu_mtid; i++) {
@@ -992,7 +1002,7 @@ static ssize_t cpu_configure_store(struct device *dev,
 	case 1:
 		if (pcpu->state != CPU_STATE_STANDBY)
 			break;
-		rc = sclp_cpu_configure(pcpu->address >> smp_cpu_mt_shift);
+		rc = sclp_core_configure(pcpu->address >> smp_cpu_mt_shift);
 		if (rc)
 			break;
 		for (i = 0; i <= smp_cpu_mtid; i++) {
@@ -1107,10 +1117,10 @@ out:
 
 int __ref smp_rescan_cpus(void)
 {
-	struct sclp_cpu_info *info;
+	struct sclp_core_info *info;
 	int nr;
 
-	info = smp_get_cpu_info();
+	info = smp_get_core_info();
 	if (!info)
 		return -ENOMEM;
 	get_online_cpus();
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index d3766dd..fee782a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -250,7 +250,7 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 ({								\
 	/* Branch instruction needs 6 bytes */			\
 	int rel = (addrs[i + off + 1] - (addrs[i + 1] - 6)) / 2;\
-	_EMIT6(op1 | reg(b1, b2) << 16 | rel, op2 | mask);	\
+	_EMIT6(op1 | reg(b1, b2) << 16 | (rel & 0xffff), op2 | mask);	\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index f74c040..e9485fb 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -92,8 +92,8 @@ struct read_cpu_info_sccb {
 	u8	reserved[4096 - 16];
 } __attribute__((packed, aligned(PAGE_SIZE)));
 
-static void sclp_fill_cpu_info(struct sclp_cpu_info *info,
-			       struct read_cpu_info_sccb *sccb)
+static void sclp_fill_core_info(struct sclp_core_info *info,
+				struct read_cpu_info_sccb *sccb)
 {
 	char *page = (char *) sccb;
 
@@ -101,12 +101,11 @@ static void sclp_fill_cpu_info(struct sclp_cpu_info *info,
 	info->configured = sccb->nr_configured;
 	info->standby = sccb->nr_standby;
 	info->combined = sccb->nr_configured + sccb->nr_standby;
-	info->has_cpu_type = sclp.has_cpu_type;
-	memcpy(&info->cpu, page + sccb->offset_configured,
-	       info->combined * sizeof(struct sclp_cpu_entry));
+	memcpy(&info->core, page + sccb->offset_configured,
+	       info->combined * sizeof(struct sclp_core_entry));
 }
 
-int sclp_get_cpu_info(struct sclp_cpu_info *info)
+int sclp_get_core_info(struct sclp_core_info *info)
 {
 	int rc;
 	struct read_cpu_info_sccb *sccb;
@@ -127,7 +126,7 @@ int sclp_get_cpu_info(struct sclp_cpu_info *info)
 		rc = -EIO;
 		goto out;
 	}
-	sclp_fill_cpu_info(info, sccb);
+	sclp_fill_core_info(info, sccb);
 out:
 	free_page((unsigned long) sccb);
 	return rc;
@@ -137,7 +136,7 @@ struct cpu_configure_sccb {
 	struct sccb_header header;
 } __attribute__((packed, aligned(8)));
 
-static int do_cpu_configure(sclp_cmdw_t cmd)
+static int do_core_configure(sclp_cmdw_t cmd)
 {
 	struct cpu_configure_sccb *sccb;
 	int rc;
@@ -171,14 +170,14 @@ out:
 	return rc;
 }
 
-int sclp_cpu_configure(u8 cpu)
+int sclp_core_configure(u8 core)
 {
-	return do_cpu_configure(SCLP_CMDW_CONFIGURE_CPU | cpu << 8);
+	return do_core_configure(SCLP_CMDW_CONFIGURE_CPU | core << 8);
 }
 
-int sclp_cpu_deconfigure(u8 cpu)
+int sclp_core_deconfigure(u8 core)
 {
-	return do_cpu_configure(SCLP_CMDW_DECONFIGURE_CPU | cpu << 8);
+	return do_core_configure(SCLP_CMDW_DECONFIGURE_CPU | core << 8);
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index d7f696d..aeed796 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -98,7 +98,7 @@ static int __init sclp_read_info_early(struct read_info_sccb *sccb)
 
 static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 {
-	struct sclp_cpu_entry *cpue;
+	struct sclp_core_entry *cpue;
 	u16 boot_cpu_address, cpu;
 
 	if (sclp_read_info_early(sccb))
@@ -106,7 +106,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 
 	sclp.facilities = sccb->facilities;
 	sclp.has_sprp = !!(sccb->fac84 & 0x02);
-	sclp.has_cpu_type = !!(sccb->fac84 & 0x01);
+	sclp.has_core_type = !!(sccb->fac84 & 0x01);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
 	sclp.rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
@@ -116,11 +116,11 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 
 	if (!sccb->hcpua) {
 		if (MACHINE_IS_VM)
-			sclp.max_cpu = 64;
+			sclp.max_cores = 64;
 		else
-			sclp.max_cpu = sccb->ncpurl;
+			sclp.max_cores = sccb->ncpurl;
 	} else {
-		sclp.max_cpu = sccb->hcpua + 1;
+		sclp.max_cores = sccb->hcpua + 1;
 	}
 
 	boot_cpu_address = stap();
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 9a3dd95..823f41f 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -154,7 +154,7 @@ static int __init init_cpu_info(enum arch_id arch)
 
 	/* get info for boot cpu from lowcore, stored in the HSA */
 
-	sa_ext = dump_save_area_create(0);
+	sa_ext = dump_save_areas.areas[0];
 	if (!sa_ext)
 		return -ENOMEM;
 	if (memcpy_hsa_kernel(&sa_ext->sa, sys_info.sa_base,
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 3ba6114..559a9dc 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -60,7 +60,7 @@ static int __ap_poll_device(struct ap_device *ap_dev, unsigned long *flags);
 static int ap_device_remove(struct device *dev);
 static int ap_device_probe(struct device *dev);
 static void ap_interrupt_handler(struct airq_struct *airq);
-static void ap_reset(struct ap_device *ap_dev);
+static void ap_reset(struct ap_device *ap_dev, unsigned long *flags);
 static void ap_config_timeout(unsigned long ptr);
 static int ap_select_domain(void);
 static void ap_query_configuration(void);
@@ -310,35 +310,26 @@ static inline int __ap_query_configuration(struct ap_config_info *config)
 static int ap_query_functions(ap_qid_t qid, unsigned int *functions)
 {
 	struct ap_queue_status status;
-	int i;
+
 	status = __ap_query_functions(qid, functions);
 
-	for (i = 0; i < AP_MAX_RESET; i++) {
-		if (ap_queue_status_invalid_test(&status))
-			return -ENODEV;
+	if (ap_queue_status_invalid_test(&status))
+		return -ENODEV;
 
-		switch (status.response_code) {
-		case AP_RESPONSE_NORMAL:
-			return 0;
-		case AP_RESPONSE_RESET_IN_PROGRESS:
-		case AP_RESPONSE_BUSY:
-			break;
-		case AP_RESPONSE_Q_NOT_AVAIL:
-		case AP_RESPONSE_DECONFIGURED:
-		case AP_RESPONSE_CHECKSTOPPED:
-		case AP_RESPONSE_INVALID_ADDRESS:
-			return -ENODEV;
-		case AP_RESPONSE_OTHERWISE_CHANGED:
-			break;
-		default:
-			break;
-		}
-		if (i < AP_MAX_RESET - 1) {
-			udelay(5);
-			status = __ap_query_functions(qid, functions);
-		}
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+		return 0;
+	case AP_RESPONSE_Q_NOT_AVAIL:
+	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
+	case AP_RESPONSE_INVALID_ADDRESS:
+		return -ENODEV;
+	case AP_RESPONSE_RESET_IN_PROGRESS:
+	case AP_RESPONSE_BUSY:
+	case AP_RESPONSE_OTHERWISE_CHANGED:
+	default:
+		return -EBUSY;
 	}
-	return -EBUSY;
 }
 
 /**
@@ -350,47 +341,25 @@ static int ap_query_functions(ap_qid_t qid, unsigned int *functions)
  * on the return value it waits a while and tests the AP queue if interrupts
  * have been switched on using ap_test_queue().
  */
-static int ap_queue_enable_interruption(ap_qid_t qid, void *ind)
+static int ap_queue_enable_interruption(struct ap_device *ap_dev, void *ind)
 {
 	struct ap_queue_status status;
-	int t_depth, t_device_type, rc, i;
 
-	rc = -EBUSY;
-	status = ap_queue_interruption_control(qid, ind);
-
-	for (i = 0; i < AP_MAX_RESET; i++) {
-		switch (status.response_code) {
-		case AP_RESPONSE_NORMAL:
-			if (status.int_enabled)
-				return 0;
-			break;
-		case AP_RESPONSE_RESET_IN_PROGRESS:
-		case AP_RESPONSE_BUSY:
-			if (i < AP_MAX_RESET - 1) {
-				udelay(5);
-				status = ap_queue_interruption_control(qid,
-								       ind);
-				continue;
-			}
-			break;
-		case AP_RESPONSE_Q_NOT_AVAIL:
-		case AP_RESPONSE_DECONFIGURED:
-		case AP_RESPONSE_CHECKSTOPPED:
-		case AP_RESPONSE_INVALID_ADDRESS:
-			return -ENODEV;
-		case AP_RESPONSE_OTHERWISE_CHANGED:
-			if (status.int_enabled)
-				return 0;
-			break;
-		default:
-			break;
-		}
-		if (i < AP_MAX_RESET - 1) {
-			udelay(5);
-			status = ap_test_queue(qid, &t_depth, &t_device_type);
-		}
+	status = ap_queue_interruption_control(ap_dev->qid, ind);
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+	case AP_RESPONSE_OTHERWISE_CHANGED:
+		return 0;
+	case AP_RESPONSE_Q_NOT_AVAIL:
+	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
+	case AP_RESPONSE_INVALID_ADDRESS:
+		return -ENODEV;
+	case AP_RESPONSE_RESET_IN_PROGRESS:
+	case AP_RESPONSE_BUSY:
+	default:
+		return -EBUSY;
 	}
-	return rc;
 }
 
 /**
@@ -511,109 +480,94 @@ int ap_recv(ap_qid_t qid, unsigned long long *psmid, void *msg, size_t length)
 EXPORT_SYMBOL(ap_recv);
 
 /**
+ * __ap_schedule_poll_timer(): Schedule poll timer.
+ *
+ * Set up the timer to run the poll tasklet
+ */
+static inline void __ap_schedule_poll_timer(void)
+{
+	ktime_t hr_time;
+
+	spin_lock_bh(&ap_poll_timer_lock);
+	if (!hrtimer_is_queued(&ap_poll_timer) && !ap_suspend_flag) {
+		hr_time = ktime_set(0, poll_timeout);
+		hrtimer_forward_now(&ap_poll_timer, hr_time);
+		hrtimer_restart(&ap_poll_timer);
+	}
+	spin_unlock_bh(&ap_poll_timer_lock);
+}
+
+/**
+ * ap_schedule_poll_timer(): Schedule poll timer.
+ *
+ * Set up the timer to run the poll tasklet
+ */
+static inline void ap_schedule_poll_timer(void)
+{
+	if (ap_using_interrupts())
+		return;
+	__ap_schedule_poll_timer();
+}
+
+
+/**
  * ap_query_queue(): Check if an AP queue is available.
  * @qid: The AP queue number
  * @queue_depth: Pointer to queue depth value
  * @device_type: Pointer to device type value
- *
- * The test is repeated for AP_MAX_RESET times.
  */
 static int ap_query_queue(ap_qid_t qid, int *queue_depth, int *device_type)
 {
 	struct ap_queue_status status;
-	int t_depth, t_device_type, rc, i;
+	int t_depth, t_device_type;
 
-	rc = -EBUSY;
-	for (i = 0; i < AP_MAX_RESET; i++) {
-		status = ap_test_queue(qid, &t_depth, &t_device_type);
-		switch (status.response_code) {
-		case AP_RESPONSE_NORMAL:
-			*queue_depth = t_depth + 1;
-			*device_type = t_device_type;
-			rc = 0;
-			break;
-		case AP_RESPONSE_Q_NOT_AVAIL:
-			rc = -ENODEV;
-			break;
-		case AP_RESPONSE_RESET_IN_PROGRESS:
-			break;
-		case AP_RESPONSE_DECONFIGURED:
-			rc = -ENODEV;
-			break;
-		case AP_RESPONSE_CHECKSTOPPED:
-			rc = -ENODEV;
-			break;
-		case AP_RESPONSE_INVALID_ADDRESS:
-			rc = -ENODEV;
-			break;
-		case AP_RESPONSE_OTHERWISE_CHANGED:
-			break;
-		case AP_RESPONSE_BUSY:
-			break;
-		default:
-			BUG();
-		}
-		if (rc != -EBUSY)
-			break;
-		if (i < AP_MAX_RESET - 1)
-			udelay(5);
+	status = ap_test_queue(qid, &t_depth, &t_device_type);
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+		*queue_depth = t_depth + 1;
+		*device_type = t_device_type;
+		return 0;
+	case AP_RESPONSE_Q_NOT_AVAIL:
+	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
+	case AP_RESPONSE_INVALID_ADDRESS:
+		return -ENODEV;
+	case AP_RESPONSE_RESET_IN_PROGRESS:
+	case AP_RESPONSE_OTHERWISE_CHANGED:
+	case AP_RESPONSE_BUSY:
+		return -EBUSY;
+	default:
+		BUG();
 	}
-	return rc;
 }
 
 /**
  * ap_init_queue(): Reset an AP queue.
  * @qid: The AP queue number
  *
- * Reset an AP queue and wait for it to become available again.
+ * Submit the Reset command to an AP queue.
+ * Since the reset is asynchron set the state to 'RESET_IN_PROGRESS'
+ * and check later via ap_poll_queue() if the reset is done.
  */
-static int ap_init_queue(ap_qid_t qid)
+static int ap_init_queue(struct ap_device *ap_dev)
 {
 	struct ap_queue_status status;
-	int rc, dummy, i;
 
-	rc = -ENODEV;
-	status = ap_reset_queue(qid);
-	for (i = 0; i < AP_MAX_RESET; i++) {
-		switch (status.response_code) {
-		case AP_RESPONSE_NORMAL:
-			if (status.queue_empty)
-				rc = 0;
-			break;
-		case AP_RESPONSE_Q_NOT_AVAIL:
-		case AP_RESPONSE_DECONFIGURED:
-		case AP_RESPONSE_CHECKSTOPPED:
-			i = AP_MAX_RESET;	/* return with -ENODEV */
-			break;
-		case AP_RESPONSE_RESET_IN_PROGRESS:
-			rc = -EBUSY;
-		case AP_RESPONSE_BUSY:
-		default:
-			break;
-		}
-		if (rc != -ENODEV && rc != -EBUSY)
-			break;
-		if (i < AP_MAX_RESET - 1) {
-			/* Time we are waiting until we give up (0.7sec * 90).
-			 * Since the actual request (in progress) will not
-			 * interrupted immediately for the reset command,
-			 * we have to be patient. In worst case we have to
-			 * wait 60sec + reset time (some msec).
-			 */
-			schedule_timeout(AP_RESET_TIMEOUT);
-			status = ap_test_queue(qid, &dummy, &dummy);
-		}
-	}
-	if (rc == 0 && ap_using_interrupts()) {
-		rc = ap_queue_enable_interruption(qid, ap_airq.lsi_ptr);
-		/* If interruption mode is supported by the machine,
-		* but an AP can not be enabled for interruption then
-		* the AP will be discarded.    */
-		if (rc)
-			pr_err("Registering adapter interrupts for "
-			       "AP %d failed\n", AP_QID_DEVICE(qid));
+	status = ap_reset_queue(ap_dev->qid);
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+		ap_dev->interrupt = AP_INTR_DISABLED;
+		ap_dev->reset = AP_RESET_IN_PROGRESS;
+		return 0;
+	case AP_RESPONSE_RESET_IN_PROGRESS:
+	case AP_RESPONSE_BUSY:
+		return -EBUSY;
+	case AP_RESPONSE_Q_NOT_AVAIL:
+	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
+	default:
+		return -ENODEV;
 	}
-	return rc;
 }
 
 /**
@@ -729,10 +683,63 @@ static ssize_t ap_pendingq_count_show(struct device *dev,
 
 static DEVICE_ATTR(pendingq_count, 0444, ap_pendingq_count_show, NULL);
 
+static ssize_t ap_reset_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ap_device *ap_dev = to_ap_dev(dev);
+	int rc = 0;
+
+	spin_lock_bh(&ap_dev->lock);
+	switch (ap_dev->reset) {
+	case AP_RESET_IGNORE:
+		rc = snprintf(buf, PAGE_SIZE, "No Reset Timer set.\n");
+		break;
+	case AP_RESET_ARMED:
+		rc = snprintf(buf, PAGE_SIZE, "Reset Timer armed.\n");
+		break;
+	case AP_RESET_DO:
+		rc = snprintf(buf, PAGE_SIZE, "Reset Timer expired.\n");
+		break;
+	case AP_RESET_IN_PROGRESS:
+		rc = snprintf(buf, PAGE_SIZE, "Reset in progress.\n");
+		break;
+	default:
+		break;
+	}
+	spin_unlock_bh(&ap_dev->lock);
+	return rc;
+}
+
+static DEVICE_ATTR(reset, 0444, ap_reset_show, NULL);
+
+static ssize_t ap_interrupt_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ap_device *ap_dev = to_ap_dev(dev);
+	int rc = 0;
+
+	spin_lock_bh(&ap_dev->lock);
+	switch (ap_dev->interrupt) {
+	case AP_INTR_DISABLED:
+		rc = snprintf(buf, PAGE_SIZE, "Interrupts disabled.\n");
+		break;
+	case AP_INTR_ENABLED:
+		rc = snprintf(buf, PAGE_SIZE, "Interrupts enabled.\n");
+		break;
+	case AP_INTR_IN_PROGRESS:
+		rc = snprintf(buf, PAGE_SIZE, "Enable Interrupt pending.\n");
+		break;
+	}
+	spin_unlock_bh(&ap_dev->lock);
+	return rc;
+}
+
+static DEVICE_ATTR(interrupt, 0444, ap_interrupt_show, NULL);
+
 static ssize_t ap_modalias_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "ap:t%02X", to_ap_dev(dev)->device_type);
+	return sprintf(buf, "ap:t%02X\n", to_ap_dev(dev)->device_type);
 }
 
 static DEVICE_ATTR(modalias, 0444, ap_modalias_show, NULL);
@@ -753,6 +760,8 @@ static struct attribute *ap_dev_attrs[] = {
 	&dev_attr_request_count.attr,
 	&dev_attr_requestq_count.attr,
 	&dev_attr_pendingq_count.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_interrupt.attr,
 	&dev_attr_modalias.attr,
 	&dev_attr_ap_functions.attr,
 	NULL
@@ -926,6 +935,10 @@ static int ap_device_probe(struct device *dev)
 		spin_lock_bh(&ap_device_list_lock);
 		list_del_init(&ap_dev->list);
 		spin_unlock_bh(&ap_device_list_lock);
+	} else {
+		if (ap_dev->reset == AP_RESET_IN_PROGRESS ||
+			ap_dev->interrupt == AP_INTR_IN_PROGRESS)
+			__ap_schedule_poll_timer();
 	}
 	return rc;
 }
@@ -1411,7 +1424,7 @@ static void ap_scan_bus(struct work_struct *unused)
 	struct ap_device *ap_dev;
 	struct device *dev;
 	ap_qid_t qid;
-	int queue_depth, device_type;
+	int queue_depth = 0, device_type = 0;
 	unsigned int device_functions;
 	int rc, i;
 
@@ -1429,15 +1442,9 @@ static void ap_scan_bus(struct work_struct *unused)
 		else
 			rc = -ENODEV;
 		if (dev) {
-			if (rc == -EBUSY) {
-				set_current_state(TASK_UNINTERRUPTIBLE);
-				schedule_timeout(AP_RESET_TIMEOUT);
-				rc = ap_query_queue(qid, &queue_depth,
-						    &device_type);
-			}
 			ap_dev = to_ap_dev(dev);
 			spin_lock_bh(&ap_dev->lock);
-			if (rc || ap_dev->unregistered) {
+			if (rc == -ENODEV || ap_dev->unregistered) {
 				spin_unlock_bh(&ap_dev->lock);
 				if (ap_dev->unregistered)
 					i--;
@@ -1451,13 +1458,15 @@ static void ap_scan_bus(struct work_struct *unused)
 		}
 		if (rc)
 			continue;
-		rc = ap_init_queue(qid);
-		if (rc)
-			continue;
 		ap_dev = kzalloc(sizeof(*ap_dev), GFP_KERNEL);
 		if (!ap_dev)
 			break;
 		ap_dev->qid = qid;
+		rc = ap_init_queue(ap_dev);
+		if ((rc != 0) && (rc != -EBUSY)) {
+			kfree(ap_dev);
+			continue;
+		}
 		ap_dev->queue_depth = queue_depth;
 		ap_dev->unregistered = 1;
 		spin_lock_init(&ap_dev->lock);
@@ -1520,36 +1529,6 @@ ap_config_timeout(unsigned long ptr)
 }
 
 /**
- * __ap_schedule_poll_timer(): Schedule poll timer.
- *
- * Set up the timer to run the poll tasklet
- */
-static inline void __ap_schedule_poll_timer(void)
-{
-	ktime_t hr_time;
-
-	spin_lock_bh(&ap_poll_timer_lock);
-	if (!hrtimer_is_queued(&ap_poll_timer) && !ap_suspend_flag) {
-		hr_time = ktime_set(0, poll_timeout);
-		hrtimer_forward_now(&ap_poll_timer, hr_time);
-		hrtimer_restart(&ap_poll_timer);
-	}
-	spin_unlock_bh(&ap_poll_timer_lock);
-}
-
-/**
- * ap_schedule_poll_timer(): Schedule poll timer.
- *
- * Set up the timer to run the poll tasklet
- */
-static inline void ap_schedule_poll_timer(void)
-{
-	if (ap_using_interrupts())
-		return;
-	__ap_schedule_poll_timer();
-}
-
-/**
  * ap_poll_read(): Receive pending reply messages from an AP device.
  * @ap_dev: pointer to the AP device
  * @flags: pointer to control flags, bit 2^0 is set if another poll is
@@ -1568,6 +1547,7 @@ static int ap_poll_read(struct ap_device *ap_dev, unsigned long *flags)
 			   ap_dev->reply->message, ap_dev->reply->length);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
+		ap_dev->interrupt = status.int_enabled;
 		atomic_dec(&ap_poll_requests);
 		ap_decrease_queue_count(ap_dev);
 		list_for_each_entry(ap_msg, &ap_dev->pendingq, list) {
@@ -1582,6 +1562,7 @@ static int ap_poll_read(struct ap_device *ap_dev, unsigned long *flags)
 			*flags |= 1;
 		break;
 	case AP_RESPONSE_NO_PENDING_REPLY:
+		ap_dev->interrupt = status.int_enabled;
 		if (status.queue_empty) {
 			/* The card shouldn't forget requests but who knows. */
 			atomic_sub(ap_dev->queue_count, &ap_poll_requests);
@@ -1612,7 +1593,8 @@ static int ap_poll_write(struct ap_device *ap_dev, unsigned long *flags)
 	struct ap_message *ap_msg;
 
 	if (ap_dev->requestq_count <= 0 ||
-	    ap_dev->queue_count >= ap_dev->queue_depth)
+	    (ap_dev->queue_count >= ap_dev->queue_depth) ||
+	    (ap_dev->reset == AP_RESET_IN_PROGRESS))
 		return 0;
 	/* Start the next request on the queue. */
 	ap_msg = list_entry(ap_dev->requestq.next, struct ap_message, list);
@@ -1646,6 +1628,8 @@ static int ap_poll_write(struct ap_device *ap_dev, unsigned long *flags)
 
 /**
  * ap_poll_queue(): Poll AP device for pending replies and send new messages.
+ * Check if the queue has a pending reset. In case it's done re-enable
+ * interrupts, otherwise reschedule the poll_timer for another attempt.
  * @ap_dev: pointer to the bus device
  * @flags: pointer to control flags, bit 2^0 is set if another poll is
  *	   required, bit 2^1 is set if the poll timer needs to get armed
@@ -1656,7 +1640,51 @@ static int ap_poll_write(struct ap_device *ap_dev, unsigned long *flags)
  */
 static inline int ap_poll_queue(struct ap_device *ap_dev, unsigned long *flags)
 {
-	int rc;
+	int rc, depth, type;
+	struct ap_queue_status status;
+
+
+	if (ap_dev->reset == AP_RESET_IN_PROGRESS) {
+		status = ap_test_queue(ap_dev->qid, &depth, &type);
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			ap_dev->reset = AP_RESET_IGNORE;
+			if (ap_using_interrupts()) {
+				rc = ap_queue_enable_interruption(
+					ap_dev, ap_airq.lsi_ptr);
+				if (!rc)
+					ap_dev->interrupt = AP_INTR_IN_PROGRESS;
+				else if (rc == -ENODEV) {
+					pr_err("Registering adapter interrupts for "
+					"AP %d failed\n", AP_QID_DEVICE(ap_dev->qid));
+					return rc;
+				}
+			}
+			/* fall through */
+		case AP_RESPONSE_BUSY:
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+			*flags |= AP_POLL_AFTER_TIMEOUT;
+			break;
+		case AP_RESPONSE_Q_NOT_AVAIL:
+		case AP_RESPONSE_DECONFIGURED:
+		case AP_RESPONSE_CHECKSTOPPED:
+			return -ENODEV;
+		default:
+			break;
+		}
+	}
+
+	if ((ap_dev->reset != AP_RESET_IN_PROGRESS) &&
+		(ap_dev->interrupt == AP_INTR_IN_PROGRESS)) {
+		status = ap_test_queue(ap_dev->qid, &depth, &type);
+		if (ap_using_interrupts()) {
+			if (status.int_enabled == 1)
+				ap_dev->interrupt = AP_INTR_ENABLED;
+			else
+				*flags |= AP_POLL_AFTER_TIMEOUT;
+		} else
+			ap_dev->interrupt = AP_INTR_DISABLED;
+	}
 
 	rc = ap_poll_read(ap_dev, flags);
 	if (rc)
@@ -1676,7 +1704,8 @@ static int __ap_queue_message(struct ap_device *ap_dev, struct ap_message *ap_ms
 	struct ap_queue_status status;
 
 	if (list_empty(&ap_dev->requestq) &&
-	    ap_dev->queue_count < ap_dev->queue_depth) {
+	    (ap_dev->queue_count < ap_dev->queue_depth) &&
+	    (ap_dev->reset != AP_RESET_IN_PROGRESS)) {
 		status = __ap_send(ap_dev->qid, ap_msg->psmid,
 				   ap_msg->message, ap_msg->length,
 				   ap_msg->special);
@@ -1789,21 +1818,20 @@ static enum hrtimer_restart ap_poll_timeout(struct hrtimer *unused)
  * Reset a not responding AP device and move all requests from the
  * pending queue to the request queue.
  */
-static void ap_reset(struct ap_device *ap_dev)
+static void ap_reset(struct ap_device *ap_dev, unsigned long *flags)
 {
 	int rc;
 
-	ap_dev->reset = AP_RESET_IGNORE;
 	atomic_sub(ap_dev->queue_count, &ap_poll_requests);
 	ap_dev->queue_count = 0;
 	list_splice_init(&ap_dev->pendingq, &ap_dev->requestq);
 	ap_dev->requestq_count += ap_dev->pendingq_count;
 	ap_dev->pendingq_count = 0;
-	rc = ap_init_queue(ap_dev->qid);
+	rc = ap_init_queue(ap_dev);
 	if (rc == -ENODEV)
 		ap_dev->unregistered = 1;
 	else
-		__ap_schedule_poll_timer();
+		*flags |= AP_POLL_AFTER_TIMEOUT;
 }
 
 static int __ap_poll_device(struct ap_device *ap_dev, unsigned long *flags)
@@ -1812,7 +1840,7 @@ static int __ap_poll_device(struct ap_device *ap_dev, unsigned long *flags)
 		if (ap_poll_queue(ap_dev, flags))
 			ap_dev->unregistered = 1;
 		if (ap_dev->reset == AP_RESET_DO)
-			ap_reset(ap_dev);
+			ap_reset(ap_dev, flags);
 	}
 	return 0;
 }
@@ -1845,9 +1873,9 @@ static void ap_poll_all(unsigned long dummy)
 			spin_unlock(&ap_dev->lock);
 		}
 		spin_unlock(&ap_device_list_lock);
-	} while (flags & 1);
-	if (flags & 2)
-		ap_schedule_poll_timer();
+	} while (flags & AP_POLL_IMMEDIATELY);
+	if (flags & AP_POLL_AFTER_TIMEOUT)
+		__ap_schedule_poll_timer();
 }
 
 /**
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 2737d26..00468c8 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -32,11 +32,13 @@
 
 #define AP_DEVICES 64		/* Number of AP devices. */
 #define AP_DOMAINS 256		/* Number of AP domains. */
-#define AP_MAX_RESET 90		/* Maximum number of resets. */
 #define AP_RESET_TIMEOUT (HZ*0.7)	/* Time in ticks for reset timeouts. */
 #define AP_CONFIG_TIME 30	/* Time in seconds between AP bus rescans. */
 #define AP_POLL_TIME 1		/* Time in ticks between receive polls. */
 
+#define AP_POLL_IMMEDIATELY	1 /* continue running poll tasklet */
+#define AP_POLL_AFTER_TIMEOUT	2 /* run poll tasklet again after timout */
+
 extern int ap_domain_index;
 
 /**
@@ -135,6 +137,14 @@ static inline int ap_test_bit(unsigned int *ptr, unsigned int nr)
 #define AP_RESET_IGNORE	0	/* request timeout will be ignored */
 #define AP_RESET_ARMED	1	/* request timeout timer is active */
 #define AP_RESET_DO	2	/* AP reset required */
+#define AP_RESET_IN_PROGRESS	3	/* AP reset in progress */
+
+/*
+ * AP interrupt states
+ */
+#define AP_INTR_DISABLED	0	/* AP interrupt disabled */
+#define AP_INTR_ENABLED		1	/* AP interrupt enabled */
+#define AP_INTR_IN_PROGRESS	3	/* AP interrupt in progress */
 
 struct ap_device;
 struct ap_message;
@@ -168,6 +178,7 @@ struct ap_device {
 	struct timer_list timeout;	/* Timer for request timeouts. */
 	int reset;			/* Reset required after req. timeout. */
 
+	int interrupt;			/* indicate if interrupts are enabled */
 	int queue_count;		/* # messages currently on AP queue. */
 
 	struct list_head pendingq;	/* List of message sent to AP queue. */
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 71e698b..bb39088 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -39,7 +39,7 @@
  * But the maximum time limit managed by the stomper code is set to 60sec.
  * Hence we have to wait at least that time period.
  */
-#define CEX4_CLEANUP_TIME	(61*HZ)
+#define CEX4_CLEANUP_TIME	(900*HZ)
 
 static struct ap_device_id zcrypt_cex4_ids[] = {
 	{ AP_DEVICE(AP_DEVICE_TYPE_CEX4)  },
