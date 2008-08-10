Return-Path: <linux-kernel-owner+w=401wt.eu-S1754183AbYHJUmZ@vger.kernel.org>
Date: Sun, 10 Aug 2008 23:40:32 +0300
From: Adrian Bunk <bunk@kernel.org>
Subject: [RFC: 2.6 patch] s390: use kernel/uid.c
Message-ID: <20080810204031.GC8399@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Unless I missed a twist the only reason for s390 to not use the code in 
kernel/uid.c was that it copied the code from sparc64 (that is now 
being changed in a similar way by David).

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/s390/kernel/compat_linux.c   |  204 ------------------------------
 arch/s390/kernel/compat_linux.h   |   19 --
 arch/s390/kernel/compat_wrapper.S |   30 ++--
 arch/s390/kernel/syscalls.S       |    8 -
 init/Kconfig                      |    2 
 5 files changed, 20 insertions(+), 243 deletions(-)

7ace436e6294802c2c34c24581d6a2f53a0f830f 
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index d7f2222..7d90fa1 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -75,210 +75,6 @@ long psw32_user_bits	= (PSW32_BASE_BITS | PSW32_MASK_DAT | PSW32_ASC_HOME |
 			   PSW32_MASK_IO | PSW32_MASK_EXT | PSW32_MASK_MCHECK |
 			   PSW32_MASK_PSTATE);
  
-/* For this source file, we want overflow handling. */
-
-#undef high2lowuid
-#undef high2lowgid
-#undef low2highuid
-#undef low2highgid
-#undef SET_UID16
-#undef SET_GID16
-#undef NEW_TO_OLD_UID
-#undef NEW_TO_OLD_GID
-#undef SET_OLDSTAT_UID
-#undef SET_OLDSTAT_GID
-#undef SET_STAT_UID
-#undef SET_STAT_GID
-
-#define high2lowuid(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
-#define high2lowgid(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid)
-#define low2highuid(uid) ((uid) == (u16)-1) ? (uid_t)-1 : (uid_t)(uid)
-#define low2highgid(gid) ((gid) == (u16)-1) ? (gid_t)-1 : (gid_t)(gid)
-#define SET_UID16(var, uid)	var = high2lowuid(uid)
-#define SET_GID16(var, gid)	var = high2lowgid(gid)
-#define NEW_TO_OLD_UID(uid)	high2lowuid(uid)
-#define NEW_TO_OLD_GID(gid)	high2lowgid(gid)
-#define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = high2lowuid(uid)
-#define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = high2lowgid(gid)
-#define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
-#define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
-
-asmlinkage long sys32_chown16(const char __user * filename, u16 user, u16 group)
-{
-	return sys_chown(filename, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_lchown16(const char __user * filename, u16 user, u16 group)
-{
-	return sys_lchown(filename, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_fchown16(unsigned int fd, u16 user, u16 group)
-{
-	return sys_fchown(fd, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_setregid16(u16 rgid, u16 egid)
-{
-	return sys_setregid(low2highgid(rgid), low2highgid(egid));
-}
-
-asmlinkage long sys32_setgid16(u16 gid)
-{
-	return sys_setgid((gid_t)gid);
-}
-
-asmlinkage long sys32_setreuid16(u16 ruid, u16 euid)
-{
-	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
-}
-
-asmlinkage long sys32_setuid16(u16 uid)
-{
-	return sys_setuid((uid_t)uid);
-}
-
-asmlinkage long sys32_setresuid16(u16 ruid, u16 euid, u16 suid)
-{
-	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
-		low2highuid(suid));
-}
-
-asmlinkage long sys32_getresuid16(u16 __user *ruid, u16 __user *euid, u16 __user *suid)
-{
-	int retval;
-
-	if (!(retval = put_user(high2lowuid(current->uid), ruid)) &&
-	    !(retval = put_user(high2lowuid(current->euid), euid)))
-		retval = put_user(high2lowuid(current->suid), suid);
-
-	return retval;
-}
-
-asmlinkage long sys32_setresgid16(u16 rgid, u16 egid, u16 sgid)
-{
-	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
-		low2highgid(sgid));
-}
-
-asmlinkage long sys32_getresgid16(u16 __user *rgid, u16 __user *egid, u16 __user *sgid)
-{
-	int retval;
-
-	if (!(retval = put_user(high2lowgid(current->gid), rgid)) &&
-	    !(retval = put_user(high2lowgid(current->egid), egid)))
-		retval = put_user(high2lowgid(current->sgid), sgid);
-
-	return retval;
-}
-
-asmlinkage long sys32_setfsuid16(u16 uid)
-{
-	return sys_setfsuid((uid_t)uid);
-}
-
-asmlinkage long sys32_setfsgid16(u16 gid)
-{
-	return sys_setfsgid((gid_t)gid);
-}
-
-static int groups16_to_user(u16 __user *grouplist, struct group_info *group_info)
-{
-	int i;
-	u16 group;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		group = (u16)GROUP_AT(group_info, i);
-		if (put_user(group, grouplist+i))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int groups16_from_user(struct group_info *group_info, u16 __user *grouplist)
-{
-	int i;
-	u16 group;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		if (get_user(group, grouplist+i))
-			return  -EFAULT;
-		GROUP_AT(group_info, i) = (gid_t)group;
-	}
-
-	return 0;
-}
-
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 __user *grouplist)
-{
-	int i;
-
-	if (gidsetsize < 0)
-		return -EINVAL;
-
-	get_group_info(current->group_info);
-	i = current->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize) {
-			i = -EINVAL;
-			goto out;
-		}
-		if (groups16_to_user(grouplist, current->group_info)) {
-			i = -EFAULT;
-			goto out;
-		}
-	}
-out:
-	put_group_info(current->group_info);
-	return i;
-}
-
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 __user *grouplist)
-{
-	struct group_info *group_info;
-	int retval;
-
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	if ((unsigned)gidsetsize > NGROUPS_MAX)
-		return -EINVAL;
-
-	group_info = groups_alloc(gidsetsize);
-	if (!group_info)
-		return -ENOMEM;
-	retval = groups16_from_user(group_info, grouplist);
-	if (retval) {
-		put_group_info(group_info);
-		return retval;
-	}
-
-	retval = set_current_groups(group_info);
-	put_group_info(group_info);
-
-	return retval;
-}
-
-asmlinkage long sys32_getuid16(void)
-{
-	return high2lowuid(current->uid);
-}
-
-asmlinkage long sys32_geteuid16(void)
-{
-	return high2lowuid(current->euid);
-}
-
-asmlinkage long sys32_getgid16(void)
-{
-	return high2lowgid(current->gid);
-}
-
-asmlinkage long sys32_getegid16(void)
-{
-	return high2lowgid(current->egid);
-}
-
 /* 32-bit timeval and related flotsam.  */
 
 static inline long get_tv32(struct timeval *o, struct compat_timeval __user *i)
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index 20723a0..c2f5a5e 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -169,25 +169,6 @@ struct fadvise64_64_args;
 struct old_sigaction32;
 struct old_sigaction32;
 
-long sys32_chown16(const char __user * filename, u16 user, u16 group);
-long sys32_lchown16(const char __user * filename, u16 user, u16 group);
-long sys32_fchown16(unsigned int fd, u16 user, u16 group);
-long sys32_setregid16(u16 rgid, u16 egid);
-long sys32_setgid16(u16 gid);
-long sys32_setreuid16(u16 ruid, u16 euid);
-long sys32_setuid16(u16 uid);
-long sys32_setresuid16(u16 ruid, u16 euid, u16 suid);
-long sys32_getresuid16(u16 __user *ruid, u16 __user *euid, u16 __user *suid);
-long sys32_setresgid16(u16 rgid, u16 egid, u16 sgid);
-long sys32_getresgid16(u16 __user *rgid, u16 __user *egid, u16 __user *sgid);
-long sys32_setfsuid16(u16 uid);
-long sys32_setfsgid16(u16 gid);
-long sys32_getgroups16(int gidsetsize, u16 __user *grouplist);
-long sys32_setgroups16(int gidsetsize, u16 __user *grouplist);
-long sys32_getuid16(void);
-long sys32_geteuid16(void);
-long sys32_getgid16(void);
-long sys32_getegid16(void);
 long sys32_ipc(u32 call, int first, int second, int third, u32 ptr);
 long sys32_truncate64(const char __user * path, unsigned long high,
 		      unsigned long low);
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 328a20e..2b0172d 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -83,7 +83,7 @@ sys32_lchown16_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t
 	llgfr	%r4,%r4			# __kernel_old_uid_emu31_t
-	jg	sys32_lchown16		# branch to system call
+	jg	sys_lchown16		# branch to system call
 
 	.globl	sys32_lseek_wrapper
 sys32_lseek_wrapper:
@@ -111,7 +111,7 @@ sys32_oldumount_wrapper:
 	.globl	sys32_setuid16_wrapper
 sys32_setuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t
-	jg	sys32_setuid16		# branch to system call
+	jg	sys_setuid16		# branch to system call
 
 #sys32_getuid16_wrapper			# void
 
@@ -195,7 +195,7 @@ sys32_brk_wrapper:
 	.globl	sys32_setgid16_wrapper
 sys32_setgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t
-	jg	sys32_setgid16		# branch to system call
+	jg	sys_setgid16		# branch to system call
 
 #sys32_getgid16_wrapper			# void
 
@@ -279,13 +279,13 @@ sys32_sigaction_wrapper:
 sys32_setreuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t
-	jg	sys32_setreuid16	# branch to system call
+	jg	sys_setreuid16		# branch to system call
 
 	.globl	sys32_setregid16_wrapper
 sys32_setregid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t
 	llgfr	%r3,%r3			# __kernel_old_gid_emu31_t
-	jg	sys32_setregid16	# branch to system call
+	jg	sys_setregid16		# branch to system call
 
 	.globl sys_sigsuspend_wrapper
 sys_sigsuspend_wrapper:
@@ -350,13 +350,13 @@ sys32_settimeofday_wrapper:
 sys32_getgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_getgroups16	# branch to system call
+	jg	sys_getgroups16		# branch to system call
 
 	.globl	sys32_setgroups16_wrapper
 sys32_setgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_setgroups16	# branch to system call
+	jg	sys_setgroups16		# branch to system call
 
 	.globl	sys32_symlink_wrapper
 sys32_symlink_wrapper:
@@ -431,7 +431,7 @@ sys32_fchown16_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgfr	%r3,%r3			# compat_uid_t
 	llgfr	%r4,%r4			# compat_uid_t
-	jg	sys32_fchown16		# branch to system call
+	jg	sys_fchown16		# branch to system call
 
 	.globl	sys32_getpriority_wrapper
 sys32_getpriority_wrapper:
@@ -622,12 +622,12 @@ sys32_personality_wrapper:
 	.globl	sys32_setfsuid16_wrapper
 sys32_setfsuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t
-	jg	sys32_setfsuid16	# branch to system call
+	jg	sys_setfsuid16		# branch to system call
 
 	.globl	sys32_setfsgid16_wrapper
 sys32_setfsgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t
-	jg	sys32_setfsgid16	# branch to system call
+	jg	sys_setfsgid16		# branch to system call
 
 	.globl	sys32_llseek_wrapper
 sys32_llseek_wrapper:
@@ -774,14 +774,14 @@ sys32_setresuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t
 	llgfr	%r4,%r4			# __kernel_old_uid_emu31_t
-	jg	sys32_setresuid16	# branch to system call
+	jg	sys_setresuid16		# branch to system call
 
 	.globl	sys32_getresuid16_wrapper
 sys32_getresuid16_wrapper:
 	llgtr	%r2,%r2			# __kernel_old_uid_emu31_t *
 	llgtr	%r3,%r3			# __kernel_old_uid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_uid_emu31_t *
-	jg	sys32_getresuid16	# branch to system call
+	jg	sys_getresuid16		# branch to system call
 
 	.globl	sys32_poll_wrapper
 sys32_poll_wrapper:
@@ -802,14 +802,14 @@ sys32_setresgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t
 	llgfr	%r3,%r3			# __kernel_old_gid_emu31_t
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t
-	jg	sys32_setresgid16	# branch to system call
+	jg	sys_setresgid16		# branch to system call
 
 	.globl	sys32_getresgid16_wrapper
 sys32_getresgid16_wrapper:
 	llgtr	%r2,%r2			# __kernel_old_gid_emu31_t *
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_gid_emu31_t *
-	jg	sys32_getresgid16	# branch to system call
+	jg	sys_getresgid16		# branch to system call
 
 	.globl	sys32_prctl_wrapper
 sys32_prctl_wrapper:
@@ -888,7 +888,7 @@ sys32_chown16_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t
-	jg	sys32_chown16		# branch to system call
+	jg	sys_chown16		# branch to system call
 
 	.globl	sys32_getcwd_wrapper
 sys32_getcwd_wrapper:
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index c66d35e..3ed965b 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -32,7 +32,7 @@ SYSCALL(sys_getpid,sys_getpid,sys_getpid)			/* 20 */
 SYSCALL(sys_mount,sys_mount,sys32_mount_wrapper)
 SYSCALL(sys_oldumount,sys_oldumount,sys32_oldumount_wrapper)
 SYSCALL(sys_setuid16,sys_ni_syscall,sys32_setuid16_wrapper)	/* old setuid16 syscall*/
-SYSCALL(sys_getuid16,sys_ni_syscall,sys32_getuid16)		/* old getuid16 syscall*/
+SYSCALL(sys_getuid16,sys_ni_syscall,sys_getuid16)		/* old getuid16 syscall*/
 SYSCALL(sys_stime,sys_ni_syscall,sys32_stime_wrapper)		/* 25 old stime syscall */
 SYSCALL(sys_ptrace,sys_ptrace,sys32_ptrace_wrapper)
 SYSCALL(sys_alarm,sys_alarm,sys32_alarm_wrapper)
@@ -55,10 +55,10 @@ SYSCALL(sys_times,sys_times,compat_sys_times_wrapper)
 NI_SYSCALL							/* old prof syscall */
 SYSCALL(sys_brk,sys_brk,sys32_brk_wrapper)			/* 45 */
 SYSCALL(sys_setgid16,sys_ni_syscall,sys32_setgid16_wrapper)	/* old setgid16 syscall*/
-SYSCALL(sys_getgid16,sys_ni_syscall,sys32_getgid16)		/* old getgid16 syscall*/
+SYSCALL(sys_getgid16,sys_ni_syscall,sys_getgid16)		/* old getgid16 syscall*/
 SYSCALL(sys_signal,sys_signal,sys32_signal_wrapper)
-SYSCALL(sys_geteuid16,sys_ni_syscall,sys32_geteuid16)		/* old geteuid16 syscall */
-SYSCALL(sys_getegid16,sys_ni_syscall,sys32_getegid16)		/* 50 old getegid16 syscall */
+SYSCALL(sys_geteuid16,sys_ni_syscall,sys_geteuid16)		/* old geteuid16 syscall */
+SYSCALL(sys_getegid16,sys_ni_syscall,sys_getegid16)		/* 50 old getegid16 syscall */
 SYSCALL(sys_acct,sys_acct,sys32_acct_wrapper)
 SYSCALL(sys_umount,sys_umount,sys32_umount_wrapper)
 NI_SYSCALL							/* old lock syscall */
diff --git a/init/Kconfig b/init/Kconfig
index 7e6dae1..28413a9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -537,7 +537,7 @@ menuconfig EMBEDDED
 
 config UID16
 	bool "Enable 16-bit UID system calls" if EMBEDDED
-	depends on ARM || BLACKFIN || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && COMPAT) || UML || (X86_64 && IA32_EMULATION)
+	depends on ARM || BLACKFIN || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && (!64BIT || COMPAT)) || SUPERH || SPARC32 || (SPARC64 && COMPAT) || UML || (X86_64 && IA32_EMULATION)
 	default y
 	help
 	  This enables the legacy 16-bit UID syscall wrappers.
