Return-Path: <linux-kernel-owner+w=401wt.eu-S1752184AbZIVVDS@vger.kernel.org>
Date: Tue, 22 Sep 2009 23:03:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches
Message-ID: <20090922230310.1beedad6@mschwide.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Christian Borntraeger (1):
      [S390] ptrace: use common code for simple peek/poke operations

Felix Beck (1):
      [S390] zcrypt: Do not add/remove devices in s/r callbacks

Heiko Carstens (9):
      [S390] Convert sys_clone to function with parameters.
      [S390] Convert sys_execve to function with parameters.
      [S390] Get rid of init_module/delete_module compat functions.
      [S390] hibernation: fix guest page hinting related crash
      [S390] hibernation: reset system after resume
      [S390] Change kernel_page_present coding style.
      [S390] fix disabled_wait inline assembly clobber list
      [S390] smp: introduce LC_ORDER and simplify lowcore handling
      [S390] hibernate: make sure pfn_is_nosave handles lowcore pages

Jan Glauber (2):
      [S390] qdio: reduce per device debug messages
      [S390] qdio: change state of all primed input buffers

Martin Schwidefsky (1):
      [S390] Update default configuration.

Michael Holzheu (1):
      [S390] hibernate: Do real CPU swap at resume time

Sebastian Ott (6):
      [S390] cio: merge init calls
      [S390] cio: introduce css_eval_scheduled
      [S390] cio: introduce css_settle
      [S390] cio: dont kfree vmalloced memory
      [S390] cio: idset use actual number of ssids
      [S390] cio: introduce consistent subchannel scanning

Stefan Weinhuber (1):
      [S390] dasd: tolerate devices that have no feature codes

 arch/s390/defconfig               |   37 ++++--
 arch/s390/include/asm/lowcore.h   |    9 ++
 arch/s390/include/asm/processor.h |    2 +-
 arch/s390/kernel/asm-offsets.c    |    7 +-
 arch/s390/kernel/compat_linux.c   |   83 ++----------
 arch/s390/kernel/compat_linux.h   |    4 +-
 arch/s390/kernel/compat_wrapper.S |   27 +++-
 arch/s390/kernel/entry.h          |    6 +-
 arch/s390/kernel/process.c        |   40 +++----
 arch/s390/kernel/ptrace.c         |   19 +---
 arch/s390/kernel/sclp.S           |    5 +-
 arch/s390/kernel/smp.c            |   50 +-------
 arch/s390/kernel/suspend.c        |   24 +---
 arch/s390/kernel/swsusp_asm64.S   |  102 +++++++++++++--
 arch/s390/kernel/syscalls.S       |    8 +-
 arch/s390/mm/page-states.c        |   52 +++++++--
 arch/s390/mm/pgtable.c            |   17 +--
 drivers/s390/block/dasd_eckd.c    |   13 +-
 drivers/s390/cio/css.c            |  252 +++++++++++++++++++------------------
 drivers/s390/cio/css.h            |    3 +
 drivers/s390/cio/device.c         |   38 +++----
 drivers/s390/cio/device.h         |    1 +
 drivers/s390/cio/idset.c          |   22 +++-
 drivers/s390/cio/idset.h          |    2 +
 drivers/s390/cio/qdio_main.c      |   32 ++---
 drivers/s390/crypto/ap_bus.c      |   40 +++++--
 26 files changed, 478 insertions(+), 417 deletions(-)

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index 4e91a25..ab44644 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30
-# Mon Jun 22 11:08:16 2009
+# Linux kernel version: 2.6.31
+# Tue Sep 22 17:43:13 2009
 #
 CONFIG_SCHED_MC=y
 CONFIG_MMU=y
@@ -24,6 +24,7 @@ CONFIG_PGSTE=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_S390=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 CONFIG_CONSTRUCTORS=y
 
@@ -48,11 +49,12 @@ CONFIG_AUDIT=y
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=64
+# CONFIG_RCU_FANOUT_EXACT is not set
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
@@ -103,11 +105,12 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
-CONFIG_HAVE_PERF_COUNTERS=y
+CONFIG_HAVE_PERF_EVENTS=y
 
 #
-# Performance Counters
+# Kernel Performance Events And Counters
 #
+# CONFIG_PERF_EVENTS is not set
 # CONFIG_PERF_COUNTERS is not set
 CONFIG_VM_EVENT_COUNTERS=y
 # CONFIG_STRIP_ASM_SYMS is not set
@@ -116,7 +119,6 @@ CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 CONFIG_KPROBES=y
 CONFIG_HAVE_SYSCALL_WRAPPERS=y
@@ -176,6 +178,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 CONFIG_64BIT=y
+# CONFIG_KTIME_SCALAR is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 CONFIG_HOTPLUG_CPU=y
@@ -257,7 +260,6 @@ CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_CMM is not set
-# CONFIG_PAGE_STATES is not set
 # CONFIG_APPLDATA_BASE is not set
 CONFIG_HZ_100=y
 # CONFIG_HZ_250 is not set
@@ -280,6 +282,7 @@ CONFIG_PM_SLEEP_SMP=y
 CONFIG_PM_SLEEP=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_STD_PARTITION=""
+# CONFIG_PM_RUNTIME is not set
 CONFIG_NET=y
 
 #
@@ -394,6 +397,7 @@ CONFIG_IP_SCTP=m
 # CONFIG_SCTP_HMAC_NONE is not set
 # CONFIG_SCTP_HMAC_SHA1 is not set
 CONFIG_SCTP_HMAC_MD5=y
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -487,6 +491,7 @@ CONFIG_CCW=y
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -501,6 +506,7 @@ CONFIG_BLK_DEV=y
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_OSD is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
@@ -594,8 +600,11 @@ CONFIG_BLK_DEV_DM=y
 CONFIG_DM_CRYPT=y
 CONFIG_DM_SNAPSHOT=y
 CONFIG_DM_MIRROR=y
+# CONFIG_DM_LOG_USERSPACE is not set
 CONFIG_DM_ZERO=y
 CONFIG_DM_MULTIPATH=m
+# CONFIG_DM_MULTIPATH_QL is not set
+# CONFIG_DM_MULTIPATH_ST is not set
 # CONFIG_DM_DELAY is not set
 # CONFIG_DM_UEVENT is not set
 CONFIG_NETDEVICES=y
@@ -615,7 +624,6 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
 # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
-# CONFIG_KS8842 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 # CONFIG_TR is not set
@@ -678,6 +686,7 @@ CONFIG_SCLP_CONSOLE=y
 CONFIG_SCLP_VT220_TTY=y
 CONFIG_SCLP_VT220_CONSOLE=y
 CONFIG_SCLP_CPI=m
+CONFIG_SCLP_ASYNC=m
 CONFIG_S390_TAPE=m
 
 #
@@ -737,6 +746,7 @@ CONFIG_FS_POSIX_ACL=y
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
@@ -798,7 +808,6 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_EXOFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -885,11 +894,13 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_KPROBES_SANITY_TEST is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
 # CONFIG_LKDTM is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
@@ -979,11 +990,13 @@ CONFIG_CRYPTO_PCBC=m
 #
 CONFIG_CRYPTO_HMAC=m
 # CONFIG_CRYPTO_XCBC is not set
+CONFIG_CRYPTO_VMAC=m
 
 #
 # Digest
 #
 CONFIG_CRYPTO_CRC32C=m
+CONFIG_CRYPTO_GHASH=m
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=m
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 6bc9426..f2ef4b6 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -86,6 +86,7 @@
 #define __LC_PGM_OLD_PSW		0x0150
 #define __LC_MCK_OLD_PSW		0x0160
 #define __LC_IO_OLD_PSW			0x0170
+#define __LC_RESTART_PSW		0x01a0
 #define __LC_EXT_NEW_PSW		0x01b0
 #define __LC_SVC_NEW_PSW		0x01c0
 #define __LC_PGM_NEW_PSW		0x01d0
@@ -189,6 +190,14 @@ union save_area {
 #define SAVE_AREA_BASE SAVE_AREA_BASE_S390X
 #endif
 
+#ifndef __s390x__
+#define LC_ORDER 0
+#else
+#define LC_ORDER 1
+#endif
+
+#define LC_PAGES (1UL << LC_ORDER)
+
 struct _lowcore
 {
 #ifndef __s390x__
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index cf8eed3..b427154 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -295,7 +295,7 @@ static inline void ATTRIB_NORET disabled_wait(unsigned long code)
 		"	oi	0x384(1),0x10\n"/* fake protection bit */
 		"	lpswe	0(%1)"
 		: "=m" (ctl_buf)
-		: "a" (&dw_psw), "a" (&ctl_buf), "m" (dw_psw) : "cc", "0");
+		: "a" (&dw_psw), "a" (&ctl_buf), "m" (dw_psw) : "cc", "0", "1");
 #endif /* __s390x__ */
 	while (1);
 }
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index fa9905c..63e4643 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/kbuild.h>
 #include <asm/vdso.h>
+#include <asm/sigp.h>
 
 int main(void)
 {
@@ -59,6 +60,10 @@ int main(void)
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
 	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
-
+	/* constants for SIGP */
+	DEFINE(__SIGP_STOP, sigp_stop);
+	DEFINE(__SIGP_RESTART, sigp_restart);
+	DEFINE(__SIGP_SENSE, sigp_sense);
+	DEFINE(__SIGP_INITIAL_CPU_RESET, sigp_initial_cpu_reset);
 	return 0;
 }
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 9ab188d..5519cb7 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -443,66 +443,28 @@ sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t __user *uinfo)
  * sys32_execve() executes a new program after the asm stub has set
  * things up for us.  This should basically do what I want it to.
  */
-asmlinkage long sys32_execve(void)
+asmlinkage long sys32_execve(char __user *name, compat_uptr_t __user *argv,
+			     compat_uptr_t __user *envp)
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	char *filename;
-	unsigned long result;
-	int rc;
-
-	filename = getname(compat_ptr(regs->orig_gpr2));
-	if (IS_ERR(filename)) {
-		result = PTR_ERR(filename);
-                goto out;
-	}
-	rc = compat_do_execve(filename, compat_ptr(regs->gprs[3]),
-			      compat_ptr(regs->gprs[4]), regs);
-	if (rc) {
-		result = rc;
-		goto out_putname;
-	}
+	long rc;
+
+	filename = getname(name);
+	rc = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		return rc;
+	rc = compat_do_execve(filename, argv, envp, regs);
+	if (rc)
+		goto out;
 	current->thread.fp_regs.fpc=0;
 	asm volatile("sfpc %0,0" : : "d" (0));
-	result = regs->gprs[2];
-out_putname:
-        putname(filename);
+	rc = regs->gprs[2];
 out:
-	return result;
-}
-
-
-#ifdef CONFIG_MODULES
-
-asmlinkage long
-sys32_init_module(void __user *umod, unsigned long len,
-		const char __user *uargs)
-{
-	return sys_init_module(umod, len, uargs);
-}
-
-asmlinkage long
-sys32_delete_module(const char __user *name_user, unsigned int flags)
-{
-	return sys_delete_module(name_user, flags);
-}
-
-#else /* CONFIG_MODULES */
-
-asmlinkage long
-sys32_init_module(void __user *umod, unsigned long len,
-		const char __user *uargs)
-{
-	return -ENOSYS;
+	putname(filename);
+	return rc;
 }
 
-asmlinkage long
-sys32_delete_module(const char __user *name_user, unsigned int flags)
-{
-	return -ENOSYS;
-}
-
-#endif  /* CONFIG_MODULES */
-
 asmlinkage long sys32_pread64(unsigned int fd, char __user *ubuf,
 				size_t count, u32 poshi, u32 poslo)
 {
@@ -801,23 +763,6 @@ asmlinkage long sys32_write(unsigned int fd, char __user * buf, size_t count)
 	return sys_write(fd, buf, count);
 }
 
-asmlinkage long sys32_clone(void)
-{
-	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long clone_flags;
-	unsigned long newsp;
-	int __user *parent_tidptr, *child_tidptr;
-
-	clone_flags = regs->gprs[3] & 0xffffffffUL;
-	newsp = regs->orig_gpr2 & 0x7fffffffUL;
-	parent_tidptr = compat_ptr(regs->gprs[4]);
-	child_tidptr = compat_ptr(regs->gprs[5]);
-	if (!newsp)
-		newsp = regs->gprs[15];
-	return do_fork(clone_flags, newsp, regs, 0,
-		       parent_tidptr, child_tidptr);
-}
-
 /*
  * 31 bit emulation wrapper functions for sys_fadvise64/fadvise64_64.
  * These need to rewrite the advise values for POSIX_FADV_{DONTNEED,NOREUSE}
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index 836a288..c07f9ca 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -198,7 +198,8 @@ long sys32_rt_sigprocmask(int how, compat_sigset_t __user *set,
 			  compat_sigset_t __user *oset, size_t sigsetsize);
 long sys32_rt_sigpending(compat_sigset_t __user *set, size_t sigsetsize);
 long sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t __user *uinfo);
-long sys32_execve(void);
+long sys32_execve(char __user *name, compat_uptr_t __user *argv,
+		  compat_uptr_t __user *envp);
 long sys32_init_module(void __user *umod, unsigned long len,
 		       const char __user *uargs);
 long sys32_delete_module(const char __user *name_user, unsigned int flags);
@@ -222,7 +223,6 @@ unsigned long old32_mmap(struct mmap_arg_struct_emu31 __user *arg);
 long sys32_mmap2(struct mmap_arg_struct_emu31 __user *arg);
 long sys32_read(unsigned int fd, char __user * buf, size_t count);
 long sys32_write(unsigned int fd, char __user * buf, size_t count);
-long sys32_clone(void);
 long sys32_fadvise64(int fd, loff_t offset, size_t len, int advise);
 long sys32_fadvise64_64(struct fadvise64_64_args __user *args);
 long sys32_sigaction(int sig, const struct old_sigaction32 __user *act,
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 6247900..682fb69 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -568,18 +568,18 @@ compat_sys_sigprocmask_wrapper:
 	llgtr	%r4,%r4			# compat_old_sigset_t *
 	jg	compat_sys_sigprocmask		# branch to system call
 
-	.globl	sys32_init_module_wrapper
-sys32_init_module_wrapper:
+	.globl	sys_init_module_wrapper
+sys_init_module_wrapper:
 	llgtr	%r2,%r2			# void *
 	llgfr	%r3,%r3			# unsigned long
 	llgtr	%r4,%r4			# char *
-	jg	sys32_init_module	# branch to system call
+	jg	sys_init_module		# branch to system call
 
-	.globl	sys32_delete_module_wrapper
-sys32_delete_module_wrapper:
+	.globl	sys_delete_module_wrapper
+sys_delete_module_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# unsigned int
-	jg	sys32_delete_module	# branch to system call
+	jg	sys_delete_module	# branch to system call
 
 	.globl	sys32_quotactl_wrapper
 sys32_quotactl_wrapper:
@@ -1840,3 +1840,18 @@ sys_perf_event_open_wrapper:
 	lgfr	%r5,%r5			# int
 	llgfr	%r6,%r6			# unsigned long
 	jg	sys_perf_event_open	# branch to system call
+
+	.globl	sys_clone_wrapper
+sys_clone_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgfr	%r3,%r3			# unsigned long
+	llgtr	%r4,%r4			# int *
+	llgtr	%r5,%r5			# int *
+	jg	sys_clone		# branch to system call
+
+	.globl	sys32_execve_wrapper
+sys32_execve_wrapper:
+	llgtr	%r2,%r2			# char *
+	llgtr	%r3,%r3			# compat_uptr_t *
+	llgtr	%r4,%r4			# compat_uptr_t *
+	jg	sys32_execve		# branch to system call
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 950c59c..e1e5e76 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -42,10 +42,12 @@ long sys_s390_fadvise64_64(struct fadvise64_64_args __user *args);
 long sys_s390_fallocate(int fd, int mode, loff_t offset, u32 len_high,
 			u32 len_low);
 long sys_fork(void);
-long sys_clone(void);
+long sys_clone(unsigned long newsp, unsigned long clone_flags,
+	       int __user *parent_tidptr, int __user *child_tidptr);
 long sys_vfork(void);
 void execve_tail(void);
-long sys_execve(void);
+long sys_execve(char __user *name, char __user * __user *argv,
+		char __user * __user *envp);
 long sys_sigsuspend(int history0, int history1, old_sigset_t mask);
 long sys_sigaction(int sig, const struct old_sigaction __user *act,
 		   struct old_sigaction __user *oact);
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 5a43f27..59fe6ec 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -32,6 +32,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel_stat.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <asm/compat.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -230,17 +231,11 @@ SYSCALL_DEFINE0(fork)
 	return do_fork(SIGCHLD, regs->gprs[15], regs, 0, NULL, NULL);
 }
 
-SYSCALL_DEFINE0(clone)
+SYSCALL_DEFINE4(clone, unsigned long, newsp, unsigned long, clone_flags,
+		int __user *, parent_tidptr, int __user *, child_tidptr)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long clone_flags;
-	unsigned long newsp;
-	int __user *parent_tidptr, *child_tidptr;
 
-	clone_flags = regs->gprs[3];
-	newsp = regs->orig_gpr2;
-	parent_tidptr = (int __user *) regs->gprs[4];
-	child_tidptr = (int __user *) regs->gprs[5];
 	if (!newsp)
 		newsp = regs->gprs[15];
 	return do_fork(clone_flags, newsp, regs, 0,
@@ -274,30 +269,25 @@ asmlinkage void execve_tail(void)
 /*
  * sys_execve() executes a new program.
  */
-SYSCALL_DEFINE0(execve)
+SYSCALL_DEFINE3(execve, char __user *, name, char __user * __user *, argv,
+		char __user * __user *, envp)
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	char *filename;
-	unsigned long result;
-	int rc;
+	long rc;
 
-	filename = getname((char __user *) regs->orig_gpr2);
-	if (IS_ERR(filename)) {
-		result = PTR_ERR(filename);
+	filename = getname(name);
+	rc = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		return rc;
+	rc = do_execve(filename, argv, envp, regs);
+	if (rc)
 		goto out;
-	}
-	rc = do_execve(filename, (char __user * __user *) regs->gprs[3],
-		       (char __user * __user *) regs->gprs[4], regs);
-	if (rc) {
-		result = rc;
-		goto out_putname;
-	}
 	execve_tail();
-	result = regs->gprs[2];
-out_putname:
-	putname(filename);
+	rc = regs->gprs[2];
 out:
-	return result;
+	putname(filename);
+	return rc;
 }
 
 /*
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index f3ddd7a..a873867 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -339,24 +339,10 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 	int copied, ret;
 
 	switch (request) {
-	case PTRACE_PEEKTEXT:
-	case PTRACE_PEEKDATA:
-		/* Remove high order bit from address (only for 31 bit). */
-		addr &= PSW_ADDR_INSN;
-		/* read word at location addr. */
-		return generic_ptrace_peekdata(child, addr, data);
-
 	case PTRACE_PEEKUSR:
 		/* read the word at location addr in the USER area. */
 		return peek_user(child, addr, data);
 
-	case PTRACE_POKETEXT:
-	case PTRACE_POKEDATA:
-		/* Remove high order bit from address (only for 31 bit). */
-		addr &= PSW_ADDR_INSN;
-		/* write the word at location addr. */
-		return generic_ptrace_pokedata(child, addr, data);
-
 	case PTRACE_POKEUSR:
 		/* write the word at location addr in the USER area */
 		return poke_user(child, addr, data);
@@ -386,8 +372,11 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 			copied += sizeof(unsigned long);
 		}
 		return 0;
+	default:
+		/* Removing high order bit from addr (only for 31 bit). */
+		addr &= PSW_ADDR_INSN;
+		return ptrace_request(child, request, addr, data);
 	}
-	return ptrace_request(child, request, addr, data);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/s390/kernel/sclp.S b/arch/s390/kernel/sclp.S
index 20639df..e27ca63 100644
--- a/arch/s390/kernel/sclp.S
+++ b/arch/s390/kernel/sclp.S
@@ -24,8 +24,6 @@ LC_EXT_INT_CODE		= 0x86			# addr of ext int code
 #   R3	= external interruption parameter if R2=0
 #
 
-.section ".init.text","ax"
-
 _sclp_wait_int:
 	stm	%r6,%r15,24(%r15)		# save registers
 	basr	%r13,0				# get base register
@@ -318,9 +316,8 @@ _sclp_print_early:
 	.long	_sclp_work_area
 .Lascebc:
 	.long	_ascebc
-.previous
 
-.section ".init.data","a"
+.section .data,"aw",@progbits
 	.balign 4096
 _sclp_work_area:
 	.fill	4096
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 56c1687..b4b6396 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -475,10 +475,8 @@ static int __cpuinit smp_alloc_lowcore(int cpu)
 {
 	unsigned long async_stack, panic_stack;
 	struct _lowcore *lowcore;
-	int lc_order;
 
-	lc_order = sizeof(long) == 8 ? 1 : 0;
-	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, lc_order);
+	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, LC_ORDER);
 	if (!lowcore)
 		return -ENOMEM;
 	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
@@ -509,16 +507,14 @@ static int __cpuinit smp_alloc_lowcore(int cpu)
 out:
 	free_page(panic_stack);
 	free_pages(async_stack, ASYNC_ORDER);
-	free_pages((unsigned long) lowcore, lc_order);
+	free_pages((unsigned long) lowcore, LC_ORDER);
 	return -ENOMEM;
 }
 
 static void smp_free_lowcore(int cpu)
 {
 	struct _lowcore *lowcore;
-	int lc_order;
 
-	lc_order = sizeof(long) == 8 ? 1 : 0;
 	lowcore = lowcore_ptr[cpu];
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
@@ -528,7 +524,7 @@ static void smp_free_lowcore(int cpu)
 #endif
 	free_page(lowcore->panic_stack - PAGE_SIZE);
 	free_pages(lowcore->async_stack - ASYNC_SIZE, ASYNC_ORDER);
-	free_pages((unsigned long) lowcore, lc_order);
+	free_pages((unsigned long) lowcore, LC_ORDER);
 	lowcore_ptr[cpu] = NULL;
 }
 
@@ -664,7 +660,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	unsigned long async_stack, panic_stack;
 	struct _lowcore *lowcore;
 	unsigned int cpu;
-	int lc_order;
 
 	smp_detect_cpus();
 
@@ -674,8 +669,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	print_cpu_info();
 
 	/* Reallocate current lowcore, but keep its contents. */
-	lc_order = sizeof(long) == 8 ? 1 : 0;
-	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, lc_order);
+	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, LC_ORDER);
 	panic_stack = __get_free_page(GFP_KERNEL);
 	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
 	BUG_ON(!lowcore || !panic_stack || !async_stack);
@@ -1047,42 +1041,6 @@ out:
 static SYSDEV_CLASS_ATTR(dispatching, 0644, dispatching_show,
 			 dispatching_store);
 
-/*
- * If the resume kernel runs on another cpu than the suspended kernel,
- * we have to switch the cpu IDs in the logical map.
- */
-void smp_switch_boot_cpu_in_resume(u32 resume_phys_cpu_id,
-				   struct _lowcore *suspend_lowcore)
-{
-	int cpu, suspend_cpu_id, resume_cpu_id;
-	u32 suspend_phys_cpu_id;
-
-	suspend_phys_cpu_id = __cpu_logical_map[suspend_lowcore->cpu_nr];
-	suspend_cpu_id = suspend_lowcore->cpu_nr;
-
-	for_each_present_cpu(cpu) {
-		if (__cpu_logical_map[cpu] == resume_phys_cpu_id) {
-			resume_cpu_id = cpu;
-			goto found;
-		}
-	}
-	panic("Could not find resume cpu in logical map.\n");
-
-found:
-	printk("Resume  cpu ID: %i/%i\n", resume_phys_cpu_id, resume_cpu_id);
-	printk("Suspend cpu ID: %i/%i\n", suspend_phys_cpu_id, suspend_cpu_id);
-
-	__cpu_logical_map[resume_cpu_id] = suspend_phys_cpu_id;
-	__cpu_logical_map[suspend_cpu_id] = resume_phys_cpu_id;
-
-	lowcore_ptr[suspend_cpu_id]->cpu_addr = resume_phys_cpu_id;
-}
-
-u32 smp_get_phys_cpu_id(void)
-{
-	return __cpu_logical_map[smp_processor_id()];
-}
-
 static int __init topology_init(void)
 {
 	int cpu;
diff --git a/arch/s390/kernel/suspend.c b/arch/s390/kernel/suspend.c
index 086bee9..cf9e5c6 100644
--- a/arch/s390/kernel/suspend.c
+++ b/arch/s390/kernel/suspend.c
@@ -6,36 +6,26 @@
  * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
  */
 
-#include <linux/suspend.h>
-#include <linux/reboot.h>
 #include <linux/pfn.h>
-#include <linux/mm.h>
-#include <asm/sections.h>
 #include <asm/system.h>
-#include <asm/ipl.h>
 
 /*
  * References to section boundaries
  */
 extern const void __nosave_begin, __nosave_end;
 
-/*
- *  check if given pfn is in the 'nosave' or in the read only NSS section
- */
 int pfn_is_nosave(unsigned long pfn)
 {
-	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
-	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end))
-					>> PAGE_SHIFT;
-	unsigned long eshared_pfn = PFN_DOWN(__pa(&_eshared)) - 1;
-	unsigned long stext_pfn = PFN_DOWN(__pa(&_stext));
+	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
+	unsigned long nosave_end_pfn = PFN_DOWN(__pa(&__nosave_end));
 
+	/* Always save lowcore pages (LC protection might be enabled). */
+	if (pfn <= LC_PAGES)
+		return 0;
 	if (pfn >= nosave_begin_pfn && pfn < nosave_end_pfn)
 		return 1;
-	if (pfn >= stext_pfn && pfn <= eshared_pfn) {
-		if (ipl_info.type == IPL_TYPE_NSS)
-			return 1;
-	} else if ((tprot(pfn * PAGE_SIZE) && pfn > 0))
+	/* Skip memory holes and read-only pages (NSS, DCSS, ...). */
+	if (tprot(PFN_PHYS(pfn)))
 		return 1;
 	return 0;
 }
diff --git a/arch/s390/kernel/swsusp_asm64.S b/arch/s390/kernel/swsusp_asm64.S
index 7cd6b09..fe927d0 100644
--- a/arch/s390/kernel/swsusp_asm64.S
+++ b/arch/s390/kernel/swsusp_asm64.S
@@ -9,6 +9,7 @@
 
 #include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 
 /*
@@ -41,6 +42,9 @@ swsusp_arch_suspend:
 	/* Get pointer to save area */
 	lghi	%r1,0x1000
 
+	/* Save CPU address */
+	stap	__LC_CPU_ADDRESS(%r1)
+
 	/* Store registers */
 	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
 	stfpc	0x31c(%r1)			/* store fpu control */
@@ -102,11 +106,10 @@ swsusp_arch_resume:
 	aghi	%r15,-STACK_FRAME_OVERHEAD
 	stg	%r1,__SF_BACKCHAIN(%r15)
 
-#ifdef CONFIG_SMP
-	/* Save boot cpu number */
-	brasl	%r14,smp_get_phys_cpu_id
-	lgr	%r10,%r2
-#endif
+	/* Make all free pages stable */
+	lghi	%r2,1
+	brasl	%r14,arch_set_page_states
+
 	/* Deactivate DAT */
 	stnsm	__SF_EMPTY(%r15),0xfb
 
@@ -133,6 +136,69 @@ swsusp_arch_resume:
 2:
 	ptlb				/* flush tlb */
 
+	/* Reset System */
+	larl	%r1,restart_entry
+	larl	%r2,.Lrestart_diag308_psw
+	og	%r1,0(%r2)
+	stg	%r1,0(%r0)
+	larl	%r1,.Lnew_pgm_check_psw
+	epsw	%r2,%r3
+	stm	%r2,%r3,0(%r1)
+	mvc	__LC_PGM_NEW_PSW(16,%r0),0(%r1)
+	lghi	%r0,0
+	diag	%r0,%r0,0x308
+restart_entry:
+	lhi	%r1,1
+	sigp	%r1,%r0,0x12
+	sam64
+	larl	%r1,.Lnew_pgm_check_psw
+	lpswe	0(%r1)
+pgm_check_entry:
+
+	/* Switch to original suspend CPU */
+	larl	%r1,.Lresume_cpu		/* Resume CPU address: r2 */
+	stap	0(%r1)
+	llgh	%r2,0(%r1)
+	lghi	%r3,0x1000
+	llgh	%r1,__LC_CPU_ADDRESS(%r3)	/* Suspend CPU address: r1 */
+	cgr	%r1,%r2
+	je	restore_registers		/* r1 = r2 -> nothing to do */
+	larl	%r4,.Lrestart_suspend_psw	/* Set new restart PSW */
+	mvc	__LC_RESTART_PSW(16,%r0),0(%r4)
+3:
+	sigp	%r9,%r1,__SIGP_INITIAL_CPU_RESET
+	brc	8,4f	/* accepted */
+	brc	2,3b	/* busy, try again */
+
+	/* Suspend CPU not available -> panic */
+	larl	%r15,init_thread_union
+	ahi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER)
+	larl	%r2,.Lpanic_string
+	larl	%r3,_sclp_print_early
+	lghi	%r1,0
+	sam31
+	sigp	%r1,%r0,0x12
+	basr	%r14,%r3
+	larl	%r3,.Ldisabled_wait_31
+	lpsw	0(%r3)
+4:
+	/* Switch to suspend CPU */
+	sigp	%r9,%r1,__SIGP_RESTART	/* start suspend CPU */
+	brc	2,4b			/* busy, try again */
+5:
+	sigp	%r9,%r2,__SIGP_STOP	/* stop resume (current) CPU */
+6:	j	6b
+
+restart_suspend:
+	larl	%r1,.Lresume_cpu
+	llgh	%r2,0(%r1)
+7:
+	sigp	%r9,%r2,__SIGP_SENSE	/* Wait for resume CPU */
+	brc	2,7b			/* busy, try again */
+	tmll	%r9,0x40		/* Test if resume CPU is stopped */
+	jz	7b
+
+restore_registers:
 	/* Restore registers */
 	lghi	%r13,0x1000		/* %r1 = pointer to save arae */
 
@@ -166,19 +232,33 @@ swsusp_arch_resume:
 	/* Pointer to save area */
 	lghi	%r13,0x1000
 
-#ifdef CONFIG_SMP
-	/* Switch CPUs */
-	lgr	%r2,%r10		/* get cpu id */
-	llgf	%r3,0x318(%r13)
-	brasl	%r14,smp_switch_boot_cpu_in_resume
-#endif
 	/* Restore prefix register */
 	spx	0x318(%r13)
 
 	/* Activate DAT */
 	stosm	__SF_EMPTY(%r15),0x04
 
+	/* Make all free pages unstable */
+	lghi	%r2,0
+	brasl	%r14,arch_set_page_states
+
 	/* Return 0 */
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
 	br	%r14
+
+	.section .data.nosave,"aw",@progbits
+	.align	8
+.Ldisabled_wait_31:
+	.long  0x000a0000,0x00000000
+.Lpanic_string:
+	.asciz	"Resume not possible because suspend CPU is no longer available"
+	.align	8
+.Lrestart_diag308_psw:
+	.long	0x00080000,0x80000000
+.Lrestart_suspend_psw:
+	.quad	0x0000000180000000,restart_suspend
+.Lnew_pgm_check_psw:
+	.quad	0,pgm_check_entry
+.Lresume_cpu:
+	.byte	0,0
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 0b50836..30eca07 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -19,7 +19,7 @@ SYSCALL(sys_restart_syscall,sys_restart_syscall,sys_restart_syscall)
 SYSCALL(sys_creat,sys_creat,sys32_creat_wrapper)
 SYSCALL(sys_link,sys_link,sys32_link_wrapper)
 SYSCALL(sys_unlink,sys_unlink,sys32_unlink_wrapper)		/* 10 */
-SYSCALL(sys_execve,sys_execve,sys32_execve)
+SYSCALL(sys_execve,sys_execve,sys32_execve_wrapper)
 SYSCALL(sys_chdir,sys_chdir,sys32_chdir_wrapper)
 SYSCALL(sys_time,sys_ni_syscall,sys32_time_wrapper)		/* old time syscall */
 SYSCALL(sys_mknod,sys_mknod,sys32_mknod_wrapper)
@@ -128,7 +128,7 @@ SYSCALL(sys_sysinfo,sys_sysinfo,compat_sys_sysinfo_wrapper)
 SYSCALL(sys_ipc,sys_ipc,sys32_ipc_wrapper)
 SYSCALL(sys_fsync,sys_fsync,sys32_fsync_wrapper)
 SYSCALL(sys_sigreturn,sys_sigreturn,sys32_sigreturn)
-SYSCALL(sys_clone,sys_clone,sys32_clone)			/* 120 */
+SYSCALL(sys_clone,sys_clone,sys_clone_wrapper)			/* 120 */
 SYSCALL(sys_setdomainname,sys_setdomainname,sys32_setdomainname_wrapper)
 SYSCALL(sys_newuname,sys_s390_newuname,sys32_newuname_wrapper)
 NI_SYSCALL							/* modify_ldt for i386 */
@@ -136,8 +136,8 @@ SYSCALL(sys_adjtimex,sys_adjtimex,compat_sys_adjtimex_wrapper)
 SYSCALL(sys_mprotect,sys_mprotect,sys32_mprotect_wrapper)	/* 125 */
 SYSCALL(sys_sigprocmask,sys_sigprocmask,compat_sys_sigprocmask_wrapper)
 NI_SYSCALL							/* old "create module" */
-SYSCALL(sys_init_module,sys_init_module,sys32_init_module_wrapper)
-SYSCALL(sys_delete_module,sys_delete_module,sys32_delete_module_wrapper)
+SYSCALL(sys_init_module,sys_init_module,sys_init_module_wrapper)
+SYSCALL(sys_delete_module,sys_delete_module,sys_delete_module_wrapper)
 NI_SYSCALL							/* 130: old get_kernel_syms */
 SYSCALL(sys_quotactl,sys_quotactl,sys32_quotactl_wrapper)
 SYSCALL(sys_getpgid,sys_getpgid,sys32_getpgid_wrapper)
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index f92ec20..098923a 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -50,28 +50,64 @@ void __init cmma_init(void)
 		cmma_flag = 0;
 }
 
-void arch_free_page(struct page *page, int order)
+static inline void set_page_unstable(struct page *page, int order)
 {
 	int i, rc;
 
-	if (!cmma_flag)
-		return;
 	for (i = 0; i < (1 << order); i++)
 		asm volatile(".insn rrf,0xb9ab0000,%0,%1,%2,0"
 			     : "=&d" (rc)
-			     : "a" ((page_to_pfn(page) + i) << PAGE_SHIFT),
+			     : "a" (page_to_phys(page + i)),
 			       "i" (ESSA_SET_UNUSED));
 }
 
-void arch_alloc_page(struct page *page, int order)
+void arch_free_page(struct page *page, int order)
 {
-	int i, rc;
-
 	if (!cmma_flag)
 		return;
+	set_page_unstable(page, order);
+}
+
+static inline void set_page_stable(struct page *page, int order)
+{
+	int i, rc;
+
 	for (i = 0; i < (1 << order); i++)
 		asm volatile(".insn rrf,0xb9ab0000,%0,%1,%2,0"
 			     : "=&d" (rc)
-			     : "a" ((page_to_pfn(page) + i) << PAGE_SHIFT),
+			     : "a" (page_to_phys(page + i)),
 			       "i" (ESSA_SET_STABLE));
 }
+
+void arch_alloc_page(struct page *page, int order)
+{
+	if (!cmma_flag)
+		return;
+	set_page_stable(page, order);
+}
+
+void arch_set_page_states(int make_stable)
+{
+	unsigned long flags, order, t;
+	struct list_head *l;
+	struct page *page;
+	struct zone *zone;
+
+	if (!cmma_flag)
+		return;
+	if (make_stable)
+		drain_local_pages(NULL);
+	for_each_populated_zone(zone) {
+		spin_lock_irqsave(&zone->lock, flags);
+		for_each_migratetype_order(order, t) {
+			list_for_each(l, &zone->free_area[order].free_list[t]) {
+				page = list_entry(l, struct page, lru);
+				if (make_stable)
+					set_page_stable(page, order);
+				else
+					set_page_unstable(page, order);
+			}
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+}
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index c702152..c60bfb3 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -314,21 +314,18 @@ int s390_enable_sie(void)
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-#ifdef CONFIG_HIBERNATION
+#if defined(CONFIG_DEBUG_PAGEALLOC) && defined(CONFIG_HIBERNATION)
 bool kernel_page_present(struct page *page)
 {
 	unsigned long addr;
 	int cc;
 
 	addr = page_to_phys(page);
-	asm("lra %1,0(%1)\n"
-	    "ipm %0\n"
-	    "srl %0,28"
-	    :"=d"(cc),"+a"(addr)::"cc");
+	asm volatile(
+		"	lra	%1,0(%1)\n"
+		"	ipm	%0\n"
+		"	srl	%0,28"
+		: "=d" (cc), "+a" (addr) : : "cc");
 	return cc == 0;
 }
-
-#endif /* CONFIG_HIBERNATION */
-#endif /* CONFIG_DEBUG_PAGEALLOC */
-
+#endif /* CONFIG_HIBERNATION && CONFIG_DEBUG_PAGEALLOC */
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index a1ce573..614813f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -935,6 +935,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	struct dasd_eckd_private *private;
 
 	private = (struct dasd_eckd_private *) device->private;
+	memset(&private->features, 0, sizeof(struct dasd_rssd_features));
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_features)),
@@ -982,7 +983,9 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 		features = (struct dasd_rssd_features *) (prssdp + 1);
 		memcpy(&private->features, features,
 		       sizeof(struct dasd_rssd_features));
-	}
+	} else
+		dev_warn(&device->cdev->dev, "Reading device feature codes"
+			 " failed with rc=%d\n", rc);
 	dasd_sfree_request(cqr, cqr->memdev);
 	return rc;
 }
@@ -1144,9 +1147,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	}
 
 	/* Read Feature Codes */
-	rc = dasd_eckd_read_features(device);
-	if (rc)
-		goto out_err3;
+	dasd_eckd_read_features(device);
 
 	/* Read Device Characteristics */
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
@@ -3241,9 +3242,7 @@ int dasd_eckd_restore_device(struct dasd_device *device)
 	}
 
 	/* Read Feature Codes */
-	rc = dasd_eckd_read_features(device);
-	if (rc)
-		goto out_err;
+	dasd_eckd_read_features(device);
 
 	/* Read Device Characteristics */
 	memset(&private->rdc_data, 0, sizeof(private->rdc_data));
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 393c73c..91c2570 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -31,8 +31,7 @@
 #include "chp.h"
 
 int css_init_done = 0;
-static int need_reprobe = 0;
-static int max_ssid = 0;
+int max_ssid;
 
 struct channel_subsystem *channel_subsystems[__MAX_CSSID + 1];
 
@@ -315,12 +314,18 @@ int css_probe_device(struct subchannel_id schid)
 	int ret;
 	struct subchannel *sch;
 
-	sch = css_alloc_subchannel(schid);
-	if (IS_ERR(sch))
-		return PTR_ERR(sch);
+	if (cio_is_console(schid))
+		sch = cio_get_console_subchannel();
+	else {
+		sch = css_alloc_subchannel(schid);
+		if (IS_ERR(sch))
+			return PTR_ERR(sch);
+	}
 	ret = css_register_subchannel(sch);
-	if (ret)
-		put_device(&sch->dev);
+	if (ret) {
+		if (!cio_is_console(schid))
+			put_device(&sch->dev);
+	}
 	return ret;
 }
 
@@ -409,10 +414,14 @@ static void css_evaluate_subchannel(struct subchannel_id schid, int slow)
 
 static struct idset *slow_subchannel_set;
 static spinlock_t slow_subchannel_lock;
+static wait_queue_head_t css_eval_wq;
+static atomic_t css_eval_scheduled;
 
 static int __init slow_subchannel_init(void)
 {
 	spin_lock_init(&slow_subchannel_lock);
+	atomic_set(&css_eval_scheduled, 0);
+	init_waitqueue_head(&css_eval_wq);
 	slow_subchannel_set = idset_sch_new();
 	if (!slow_subchannel_set) {
 		CIO_MSG_EVENT(0, "could not allocate slow subchannel set\n");
@@ -468,9 +477,17 @@ static int slow_eval_unknown_fn(struct subchannel_id schid, void *data)
 
 static void css_slow_path_func(struct work_struct *unused)
 {
+	unsigned long flags;
+
 	CIO_TRACE_EVENT(4, "slowpath");
 	for_each_subchannel_staged(slow_eval_known_fn, slow_eval_unknown_fn,
 				   NULL);
+	spin_lock_irqsave(&slow_subchannel_lock, flags);
+	if (idset_is_empty(slow_subchannel_set)) {
+		atomic_set(&css_eval_scheduled, 0);
+		wake_up(&css_eval_wq);
+	}
+	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
 }
 
 static DECLARE_WORK(slow_path_work, css_slow_path_func);
@@ -482,6 +499,7 @@ void css_schedule_eval(struct subchannel_id schid)
 
 	spin_lock_irqsave(&slow_subchannel_lock, flags);
 	idset_sch_add(slow_subchannel_set, schid);
+	atomic_set(&css_eval_scheduled, 1);
 	queue_work(slow_path_wq, &slow_path_work);
 	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
 }
@@ -492,80 +510,53 @@ void css_schedule_eval_all(void)
 
 	spin_lock_irqsave(&slow_subchannel_lock, flags);
 	idset_fill(slow_subchannel_set);
+	atomic_set(&css_eval_scheduled, 1);
 	queue_work(slow_path_wq, &slow_path_work);
 	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
 }
 
-void css_wait_for_slow_path(void)
+static int __unset_registered(struct device *dev, void *data)
 {
-	flush_workqueue(slow_path_wq);
-}
-
-/* Reprobe subchannel if unregistered. */
-static int reprobe_subchannel(struct subchannel_id schid, void *data)
-{
-	int ret;
-
-	CIO_MSG_EVENT(6, "cio: reprobe 0.%x.%04x\n",
-		      schid.ssid, schid.sch_no);
-	if (need_reprobe)
-		return -EAGAIN;
-
-	ret = css_probe_device(schid);
-	switch (ret) {
-	case 0:
-		break;
-	case -ENXIO:
-	case -ENOMEM:
-	case -EIO:
-		/* These should abort looping */
-		break;
-	default:
-		ret = 0;
-	}
-
-	return ret;
-}
+	struct idset *set = data;
+	struct subchannel *sch = to_subchannel(dev);
 
-static void reprobe_after_idle(struct work_struct *unused)
-{
-	/* Make sure initial subchannel scan is done. */
-	wait_event(ccw_device_init_wq,
-		   atomic_read(&ccw_device_init_count) == 0);
-	if (need_reprobe)
-		css_schedule_reprobe();
+	idset_sch_del(set, sch->schid);
+	return 0;
 }
 
-static DECLARE_WORK(reprobe_idle_work, reprobe_after_idle);
-
-/* Work function used to reprobe all unregistered subchannels. */
-static void reprobe_all(struct work_struct *unused)
+void css_schedule_eval_all_unreg(void)
 {
-	int ret;
-
-	CIO_MSG_EVENT(4, "reprobe start\n");
+	unsigned long flags;
+	struct idset *unreg_set;
 
-	/* Make sure initial subchannel scan is done. */
-	if (atomic_read(&ccw_device_init_count) != 0) {
-		queue_work(ccw_device_work, &reprobe_idle_work);
+	/* Find unregistered subchannels. */
+	unreg_set = idset_sch_new();
+	if (!unreg_set) {
+		/* Fallback. */
+		css_schedule_eval_all();
 		return;
 	}
-	need_reprobe = 0;
-	ret = for_each_subchannel_staged(NULL, reprobe_subchannel, NULL);
-
-	CIO_MSG_EVENT(4, "reprobe done (rc=%d, need_reprobe=%d)\n", ret,
-		      need_reprobe);
+	idset_fill(unreg_set);
+	bus_for_each_dev(&css_bus_type, NULL, unreg_set, __unset_registered);
+	/* Apply to slow_subchannel_set. */
+	spin_lock_irqsave(&slow_subchannel_lock, flags);
+	idset_add_set(slow_subchannel_set, unreg_set);
+	atomic_set(&css_eval_scheduled, 1);
+	queue_work(slow_path_wq, &slow_path_work);
+	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
+	idset_free(unreg_set);
 }
 
-static DECLARE_WORK(css_reprobe_work, reprobe_all);
+void css_wait_for_slow_path(void)
+{
+	flush_workqueue(slow_path_wq);
+}
 
 /* Schedule reprobing of all unregistered subchannels. */
 void css_schedule_reprobe(void)
 {
-	need_reprobe = 1;
-	queue_work(slow_path_wq, &css_reprobe_work);
+	css_schedule_eval_all_unreg();
 }
-
 EXPORT_SYMBOL_GPL(css_schedule_reprobe);
 
 /*
@@ -601,49 +592,6 @@ static void css_process_crw(struct crw *crw0, struct crw *crw1, int overflow)
 	css_evaluate_subchannel(mchk_schid, 0);
 }
 
-static int __init
-__init_channel_subsystem(struct subchannel_id schid, void *data)
-{
-	struct subchannel *sch;
-	int ret;
-
-	if (cio_is_console(schid))
-		sch = cio_get_console_subchannel();
-	else {
-		sch = css_alloc_subchannel(schid);
-		if (IS_ERR(sch))
-			ret = PTR_ERR(sch);
-		else
-			ret = 0;
-		switch (ret) {
-		case 0:
-			break;
-		case -ENOMEM:
-			panic("Out of memory in init_channel_subsystem\n");
-		/* -ENXIO: no more subchannels. */
-		case -ENXIO:
-			return ret;
-		/* -EIO: this subchannel set not supported. */
-		case -EIO:
-			return ret;
-		default:
-			return 0;
-		}
-	}
-	/*
-	 * We register ALL valid subchannels in ioinfo, even those
-	 * that have been present before init_channel_subsystem.
-	 * These subchannels can't have been registered yet (kmalloc
-	 * not working) so we do it now. This is true e.g. for the
-	 * console subchannel.
-	 */
-	if (css_register_subchannel(sch)) {
-		if (!cio_is_console(schid))
-			put_device(&sch->dev);
-	}
-	return 0;
-}
-
 static void __init
 css_generate_pgid(struct channel_subsystem *css, u32 tod_high)
 {
@@ -854,19 +802,30 @@ static struct notifier_block css_power_notifier = {
  * The struct subchannel's are created during probing (except for the
  * static console subchannel).
  */
-static int __init
-init_channel_subsystem (void)
+static int __init css_bus_init(void)
 {
 	int ret, i;
 
 	ret = chsc_determine_css_characteristics();
 	if (ret == -ENOMEM)
-		goto out; /* No need to continue. */
+		goto out;
 
 	ret = chsc_alloc_sei_area();
 	if (ret)
 		goto out;
 
+	/* Try to enable MSS. */
+	ret = chsc_enable_facility(CHSC_SDA_OC_MSS);
+	switch (ret) {
+	case 0: /* Success. */
+		max_ssid = __MAX_SSID;
+		break;
+	case -ENOMEM:
+		goto out;
+	default:
+		max_ssid = 0;
+	}
+
 	ret = slow_subchannel_init();
 	if (ret)
 		goto out;
@@ -878,17 +837,6 @@ init_channel_subsystem (void)
 	if ((ret = bus_register(&css_bus_type)))
 		goto out;
 
-	/* Try to enable MSS. */
-	ret = chsc_enable_facility(CHSC_SDA_OC_MSS);
-	switch (ret) {
-	case 0: /* Success. */
-		max_ssid = __MAX_SSID;
-		break;
-	case -ENOMEM:
-		goto out_bus;
-	default:
-		max_ssid = 0;
-	}
 	/* Setup css structure. */
 	for (i = 0; i <= __MAX_CSSID; i++) {
 		struct channel_subsystem *css;
@@ -934,7 +882,6 @@ init_channel_subsystem (void)
 	/* Enable default isc for I/O subchannels. */
 	isc_register(IO_SCH_ISC);
 
-	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
 out_file:
 	if (css_chsc_characteristics.secm)
@@ -955,17 +902,76 @@ out_unregister:
 					   &dev_attr_cm_enable);
 		device_unregister(&css->device);
 	}
-out_bus:
 	bus_unregister(&css_bus_type);
 out:
 	crw_unregister_handler(CRW_RSC_CSS);
 	chsc_free_sei_area();
-	kfree(slow_subchannel_set);
+	idset_free(slow_subchannel_set);
 	pr_alert("The CSS device driver initialization failed with "
 		 "errno=%d\n", ret);
 	return ret;
 }
 
+static void __init css_bus_cleanup(void)
+{
+	struct channel_subsystem *css;
+	int i;
+
+	for (i = 0; i <= __MAX_CSSID; i++) {
+		css = channel_subsystems[i];
+		device_unregister(&css->pseudo_subchannel->dev);
+		css->pseudo_subchannel = NULL;
+		if (css_chsc_characteristics.secm)
+			device_remove_file(&css->device, &dev_attr_cm_enable);
+		device_unregister(&css->device);
+	}
+	bus_unregister(&css_bus_type);
+	crw_unregister_handler(CRW_RSC_CSS);
+	chsc_free_sei_area();
+	idset_free(slow_subchannel_set);
+	isc_unregister(IO_SCH_ISC);
+}
+
+static int __init channel_subsystem_init(void)
+{
+	int ret;
+
+	ret = css_bus_init();
+	if (ret)
+		return ret;
+
+	ret = io_subchannel_init();
+	if (ret)
+		css_bus_cleanup();
+
+	return ret;
+}
+subsys_initcall(channel_subsystem_init);
+
+static int css_settle(struct device_driver *drv, void *unused)
+{
+	struct css_driver *cssdrv = to_cssdriver(drv);
+
+	if (cssdrv->settle)
+		cssdrv->settle();
+	return 0;
+}
+
+/*
+ * Wait for the initialization of devices to finish, to make sure we are
+ * done with our setup if the search for the root device starts.
+ */
+static int __init channel_subsystem_init_sync(void)
+{
+	/* Start initial subchannel evaluation. */
+	css_schedule_eval_all();
+	/* Wait for the evaluation of subchannels to finish. */
+	wait_event(css_eval_wq, atomic_read(&css_eval_scheduled) == 0);
+	/* Wait for the subchannel type specific initialization to finish */
+	return bus_for_each_drv(&css_bus_type, NULL, NULL, css_settle);
+}
+subsys_initcall_sync(channel_subsystem_init_sync);
+
 int sch_is_pseudo_sch(struct subchannel *sch)
 {
 	return sch == to_css(sch->dev.parent)->pseudo_subchannel;
@@ -1135,7 +1141,5 @@ void css_driver_unregister(struct css_driver *cdrv)
 }
 EXPORT_SYMBOL_GPL(css_driver_unregister);
 
-subsys_initcall(init_channel_subsystem);
-
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(css_bus_type);
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index 9763eee..68d6b0b 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -75,6 +75,7 @@ struct chp_link;
  * @freeze: callback for freezing during hibernation snapshotting
  * @thaw: undo work done in @freeze
  * @restore: callback for restoring after hibernation
+ * @settle: wait for asynchronous work to finish
  * @name: name of the device driver
  */
 struct css_driver {
@@ -92,6 +93,7 @@ struct css_driver {
 	int (*freeze)(struct subchannel *);
 	int (*thaw) (struct subchannel *);
 	int (*restore)(struct subchannel *);
+	void (*settle)(void);
 	const char *name;
 };
 
@@ -109,6 +111,7 @@ extern void css_sch_device_unregister(struct subchannel *);
 extern int css_probe_device(struct subchannel_id);
 extern struct subchannel *get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
+extern int max_ssid;
 int for_each_subchannel_staged(int (*fn_known)(struct subchannel *, void *),
 			       int (*fn_unknown)(struct subchannel_id,
 			       void *), void *data);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6527f3f..f780bdd 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -131,6 +131,10 @@ static void io_subchannel_shutdown(struct subchannel *);
 static int io_subchannel_sch_event(struct subchannel *, int);
 static int io_subchannel_chp_event(struct subchannel *, struct chp_link *,
 				   int);
+static void recovery_func(unsigned long data);
+struct workqueue_struct *ccw_device_work;
+wait_queue_head_t ccw_device_init_wq;
+atomic_t ccw_device_init_count;
 
 static struct css_device_id io_subchannel_ids[] = {
 	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
@@ -151,6 +155,13 @@ static int io_subchannel_prepare(struct subchannel *sch)
 	return 0;
 }
 
+static void io_subchannel_settle(void)
+{
+	wait_event(ccw_device_init_wq,
+		   atomic_read(&ccw_device_init_count) == 0);
+	flush_workqueue(ccw_device_work);
+}
+
 static struct css_driver io_subchannel_driver = {
 	.owner = THIS_MODULE,
 	.subchannel_type = io_subchannel_ids,
@@ -162,16 +173,10 @@ static struct css_driver io_subchannel_driver = {
 	.remove = io_subchannel_remove,
 	.shutdown = io_subchannel_shutdown,
 	.prepare = io_subchannel_prepare,
+	.settle = io_subchannel_settle,
 };
 
-struct workqueue_struct *ccw_device_work;
-wait_queue_head_t ccw_device_init_wq;
-atomic_t ccw_device_init_count;
-
-static void recovery_func(unsigned long data);
-
-static int __init
-init_ccw_bus_type (void)
+int __init io_subchannel_init(void)
 {
 	int ret;
 
@@ -181,10 +186,10 @@ init_ccw_bus_type (void)
 
 	ccw_device_work = create_singlethread_workqueue("cio");
 	if (!ccw_device_work)
-		return -ENOMEM; /* FIXME: better errno ? */
+		return -ENOMEM;
 	slow_path_wq = create_singlethread_workqueue("kslowcrw");
 	if (!slow_path_wq) {
-		ret = -ENOMEM; /* FIXME: better errno ? */
+		ret = -ENOMEM;
 		goto out_err;
 	}
 	if ((ret = bus_register (&ccw_bus_type)))
@@ -194,9 +199,6 @@ init_ccw_bus_type (void)
 	if (ret)
 		goto out_err;
 
-	wait_event(ccw_device_init_wq,
-		   atomic_read(&ccw_device_init_count) == 0);
-	flush_workqueue(ccw_device_work);
 	return 0;
 out_err:
 	if (ccw_device_work)
@@ -206,16 +208,6 @@ out_err:
 	return ret;
 }
 
-static void __exit
-cleanup_ccw_bus_type (void)
-{
-	css_driver_unregister(&io_subchannel_driver);
-	bus_unregister(&ccw_bus_type);
-	destroy_workqueue(ccw_device_work);
-}
-
-subsys_initcall(init_ccw_bus_type);
-module_exit(cleanup_ccw_bus_type);
 
 /************************ device handling **************************/
 
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index e397510..ed39a2c 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -74,6 +74,7 @@ dev_fsm_final_state(struct ccw_device *cdev)
 extern struct workqueue_struct *ccw_device_work;
 extern wait_queue_head_t ccw_device_init_wq;
 extern atomic_t ccw_device_init_count;
+int __init io_subchannel_init(void);
 
 void io_subchannel_recog_done(struct ccw_device *cdev);
 void io_subchannel_init_config(struct subchannel *sch);
diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index cf8f24a..4d10981 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -78,7 +78,7 @@ static inline int idset_get_first(struct idset *set, int *ssid, int *id)
 
 struct idset *idset_sch_new(void)
 {
-	return idset_new(__MAX_SSID + 1, __MAX_SUBCHANNEL + 1);
+	return idset_new(max_ssid + 1, __MAX_SUBCHANNEL + 1);
 }
 
 void idset_sch_add(struct idset *set, struct subchannel_id schid)
@@ -110,3 +110,23 @@ int idset_sch_get_first(struct idset *set, struct subchannel_id *schid)
 	}
 	return rc;
 }
+
+int idset_is_empty(struct idset *set)
+{
+	int bitnum;
+
+	bitnum = find_first_bit(set->bitmap, set->num_ssid * set->num_id);
+	if (bitnum >= set->num_ssid * set->num_id)
+		return 1;
+	return 0;
+}
+
+void idset_add_set(struct idset *to, struct idset *from)
+{
+	unsigned long i, len;
+
+	len = min(__BITOPS_WORDS(to->num_ssid * to->num_id),
+		  __BITOPS_WORDS(from->num_ssid * from->num_id));
+	for (i = 0; i < len ; i++)
+		to->bitmap[i] |= from->bitmap[i];
+}
diff --git a/drivers/s390/cio/idset.h b/drivers/s390/cio/idset.h
index 528065c..7543da4 100644
--- a/drivers/s390/cio/idset.h
+++ b/drivers/s390/cio/idset.h
@@ -21,5 +21,7 @@ void idset_sch_add(struct idset *set, struct subchannel_id id);
 void idset_sch_del(struct idset *set, struct subchannel_id id);
 int idset_sch_contains(struct idset *set, struct subchannel_id id);
 int idset_sch_get_first(struct idset *set, struct subchannel_id *id);
+int idset_is_empty(struct idset *set);
+void idset_add_set(struct idset *to, struct idset *from);
 
 #endif /* S390_IDSET_H */
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 9aef402..4be6e84 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -401,7 +401,7 @@ static void announce_buffer_error(struct qdio_q *q, int count)
 	if ((!q->is_input_q &&
 	    (q->sbal[q->first_to_check]->element[15].flags & 0xff) == 0x10)) {
 		qdio_perf_stat_inc(&perf_stats.outbound_target_full);
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "OUTFULL FTC:%3d",
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "OUTFULL FTC:%02x",
 			      q->first_to_check);
 		return;
 	}
@@ -418,7 +418,7 @@ static inline void inbound_primed(struct qdio_q *q, int count)
 {
 	int new;
 
-	DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in prim: %3d", count);
+	DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in prim: %02x", count);
 
 	/* for QEBSM the ACK was already set by EQBS */
 	if (is_qebsm(q)) {
@@ -455,6 +455,8 @@ static inline void inbound_primed(struct qdio_q *q, int count)
 	count--;
 	if (!count)
 		return;
+	/* need to change ALL buffers to get more interrupts */
+	set_buf_states(q, q->first_to_check, SLSB_P_INPUT_NOT_INIT, count);
 }
 
 static int get_inbound_buffer_frontier(struct qdio_q *q)
@@ -545,7 +547,7 @@ static inline int qdio_inbound_q_done(struct qdio_q *q)
 	 * has (probably) not moved (see qdio_inbound_processing).
 	 */
 	if (get_usecs() > q->u.in.timestamp + QDIO_INPUT_THRESHOLD) {
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in done:%3d",
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in done:%02x",
 			      q->first_to_check);
 		return 1;
 	} else
@@ -565,11 +567,10 @@ static void qdio_kick_handler(struct qdio_q *q)
 
 	if (q->is_input_q) {
 		qdio_perf_stat_inc(&perf_stats.inbound_handler);
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "kih s:%3d c:%3d", start, count);
-	} else {
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "koh: nr:%1d", q->nr);
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "s:%3d c:%3d", start, count);
-	}
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "kih s:%02x c:%02x", start, count);
+	} else
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "koh: s:%02x c:%02x",
+			      start, count);
 
 	q->handler(q->irq_ptr->cdev, q->qdio_error, q->nr, start, count,
 		   q->irq_ptr->int_parm);
@@ -633,7 +634,7 @@ static int get_outbound_buffer_frontier(struct qdio_q *q)
 	switch (state) {
 	case SLSB_P_OUTPUT_EMPTY:
 		/* the adapter got it */
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "out empty:%1d %3d", q->nr, count);
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "out empty:%1d %02x", q->nr, count);
 
 		atomic_sub(count, &q->nr_buf_used);
 		q->first_to_check = add_buf(q->first_to_check, count);
@@ -1481,10 +1482,9 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 	get_buf_state(q, prev_buf(bufnr), &state, 0);
 	if (state != SLSB_CU_OUTPUT_PRIMED)
 		rc = qdio_kick_outbound_q(q);
-	else {
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "fast-req");
+	else
 		qdio_perf_stat_inc(&perf_stats.fast_requeue);
-	}
+
 out:
 	tasklet_schedule(&q->tasklet);
 	return rc;
@@ -1510,12 +1510,8 @@ int do_QDIO(struct ccw_device *cdev, unsigned int callflags,
 	if (!irq_ptr)
 		return -ENODEV;
 
-	if (callflags & QDIO_FLAG_SYNC_INPUT)
-		DBF_DEV_EVENT(DBF_INFO, irq_ptr, "doQDIO input");
-	else
-		DBF_DEV_EVENT(DBF_INFO, irq_ptr, "doQDIO output");
-	DBF_DEV_EVENT(DBF_INFO, irq_ptr, "q:%1d flag:%4x", q_nr, callflags);
-	DBF_DEV_EVENT(DBF_INFO, irq_ptr, "buf:%2d cnt:%3d", bufnr, count);
+	DBF_DEV_EVENT(DBF_INFO, irq_ptr,
+		      "do%02x b:%02x c:%02x", callflags, bufnr, count);
 
 	if (irq_ptr->state != QDIO_IRQ_STATE_ACTIVE)
 		return -EBUSY;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 090b32a..1294876 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -60,6 +60,7 @@ static int ap_device_probe(struct device *dev);
 static void ap_interrupt_handler(void *unused1, void *unused2);
 static void ap_reset(struct ap_device *ap_dev);
 static void ap_config_timeout(unsigned long ptr);
+static int ap_select_domain(void);
 
 /*
  * Module description.
@@ -109,6 +110,10 @@ static unsigned long long poll_timeout = 250000;
 
 /* Suspend flag */
 static int ap_suspend_flag;
+/* Flag to check if domain was set through module parameter domain=. This is
+ * important when supsend and resume is done in a z/VM environment where the
+ * domain might change. */
+static int user_set_domain = 0;
 static struct bus_type ap_bus_type;
 
 /**
@@ -643,6 +648,7 @@ static int ap_bus_suspend(struct device *dev, pm_message_t state)
 			destroy_workqueue(ap_work_queue);
 			ap_work_queue = NULL;
 		}
+
 		tasklet_disable(&ap_tasklet);
 	}
 	/* Poll on the device until all requests are finished. */
@@ -653,7 +659,10 @@ static int ap_bus_suspend(struct device *dev, pm_message_t state)
 		spin_unlock_bh(&ap_dev->lock);
 	} while ((flags & 1) || (flags & 2));
 
-	ap_device_remove(dev);
+	spin_lock_bh(&ap_dev->lock);
+	ap_dev->unregistered = 1;
+	spin_unlock_bh(&ap_dev->lock);
+
 	return 0;
 }
 
@@ -666,11 +675,10 @@ static int ap_bus_resume(struct device *dev)
 		ap_suspend_flag = 0;
 		if (!ap_interrupts_available())
 			ap_interrupt_indicator = NULL;
-		ap_device_probe(dev);
-		ap_reset(ap_dev);
-		setup_timer(&ap_dev->timeout, ap_request_timeout,
-			    (unsigned long) ap_dev);
-		ap_scan_bus(NULL);
+		if (!user_set_domain) {
+			ap_domain_index = -1;
+			ap_select_domain();
+		}
 		init_timer(&ap_config_timer);
 		ap_config_timer.function = ap_config_timeout;
 		ap_config_timer.data = 0;
@@ -686,12 +694,14 @@ static int ap_bus_resume(struct device *dev)
 			tasklet_schedule(&ap_tasklet);
 		if (ap_thread_flag)
 			rc = ap_poll_thread_start();
-	} else {
-		ap_device_probe(dev);
-		ap_reset(ap_dev);
-		setup_timer(&ap_dev->timeout, ap_request_timeout,
-			    (unsigned long) ap_dev);
 	}
+	if (AP_QID_QUEUE(ap_dev->qid) != ap_domain_index) {
+		spin_lock_bh(&ap_dev->lock);
+		ap_dev->qid = AP_MKQID(AP_QID_DEVICE(ap_dev->qid),
+				       ap_domain_index);
+		spin_unlock_bh(&ap_dev->lock);
+	}
+	queue_work(ap_work_queue, &ap_config_work);
 
 	return rc;
 }
@@ -1079,6 +1089,8 @@ static void ap_scan_bus(struct work_struct *unused)
 			spin_lock_bh(&ap_dev->lock);
 			if (rc || ap_dev->unregistered) {
 				spin_unlock_bh(&ap_dev->lock);
+				if (ap_dev->unregistered)
+					i--;
 				device_unregister(dev);
 				put_device(dev);
 				continue;
@@ -1586,6 +1598,12 @@ int __init ap_module_init(void)
 			   ap_domain_index);
 		return -EINVAL;
 	}
+	/* In resume callback we need to know if the user had set the domain.
+	 * If so, we can not just reset it.
+	 */
+	if (ap_domain_index >= 0)
+		user_set_domain = 1;
+
 	if (ap_instructions_available() != 0) {
 		pr_warning("The hardware system does not support "
 			   "AP instructions\n");
