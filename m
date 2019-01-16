Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/5] s390: use generic UID16 implementation
Date: Wed, 16 Jan 2019 14:15:21 +0100
Message-Id: <20190116131527.2071570-4-arnd@arndb.de>
In-Reply-To: <20190116131527.2071570-1-arnd@arndb.de>
References: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

s390 has an almost identical copy of the code in kernel/uid16.c.

The problem here is that it requires calling the regular system calls,
which the generic implementation handles correctly, but the internal
interfaces are not declared in a global header for this.

The best way forward here seems to be to just use the generic code and
delete the s390 specific implementation.

I keep the changes to uapi/asm/posix_types.h inside of an #ifdef check
so user space does not observe any changes. As some of the system calls
pass pointers, we also need wrappers in compat_wrapper.c, which I add
for all calls with at least one argument. All those wrappers can be
removed in a later step.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig                        |   1 +
 arch/s390/include/uapi/asm/posix_types.h |   6 +
 arch/s390/kernel/compat_linux.c          | 233 -----------------------
 arch/s390/kernel/compat_wrapper.c        |  15 ++
 arch/s390/kernel/syscalls/syscall.tbl    |  38 ++--
 5 files changed, 41 insertions(+), 252 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ed554b09eb3f..41cafd245bbc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -379,6 +379,7 @@ config COMPAT
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
+	select HAVE_UID16
 	depends on MULTIUSER
 	help
 	  Select this option if you want to enable your system kernel to
diff --git a/arch/s390/include/uapi/asm/posix_types.h b/arch/s390/include/uapi/asm/posix_types.h
index 2a3fc638414b..1913613e71b6 100644
--- a/arch/s390/include/uapi/asm/posix_types.h
+++ b/arch/s390/include/uapi/asm/posix_types.h
@@ -20,6 +20,12 @@ typedef long            __kernel_ssize_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+#ifdef __KERNEL__
+typedef unsigned short __kernel_old_uid_t;
+typedef unsigned short __kernel_old_gid_t;
+#define __kernel_old_uid_t __kernel_old_uid_t
+#endif
+
 #ifndef __s390x__
 
 typedef unsigned long   __kernel_ino_t;
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index a47f6d3c6d5b..f9d418d1b619 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -34,7 +34,6 @@
 #include <linux/stat.h>
 #include <linux/filter.h>
 #include <linux/highmem.h>
-#include <linux/highuid.h>
 #include <linux/mman.h>
 #include <linux/ipv6.h>
 #include <linux/in.h>
@@ -58,238 +57,6 @@
 
 #include "compat_linux.h"
 
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
-COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
-		       u16, user, u16, group)
-{
-	return ksys_chown(filename, low2highuid(user), low2highgid(group));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_lchown16, const char __user *,
-		       filename, u16, user, u16, group)
-{
-	return ksys_lchown(filename, low2highuid(user), low2highgid(group));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_fchown16, unsigned int, fd, u16, user, u16, group)
-{
-	return ksys_fchown(fd, low2highuid(user), low2highgid(group));
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_setregid16, u16, rgid, u16, egid)
-{
-	return sys_setregid(low2highgid(rgid), low2highgid(egid));
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setgid16, u16, gid)
-{
-	return sys_setgid(low2highgid(gid));
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_setreuid16, u16, ruid, u16, euid)
-{
-	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setuid16, u16, uid)
-{
-	return sys_setuid(low2highuid(uid));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_setresuid16, u16, ruid, u16, euid, u16, suid)
-{
-	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
-			     low2highuid(suid));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_getresuid16, u16 __user *, ruidp,
-		       u16 __user *, euidp, u16 __user *, suidp)
-{
-	const struct cred *cred = current_cred();
-	int retval;
-	u16 ruid, euid, suid;
-
-	ruid = high2lowuid(from_kuid_munged(cred->user_ns, cred->uid));
-	euid = high2lowuid(from_kuid_munged(cred->user_ns, cred->euid));
-	suid = high2lowuid(from_kuid_munged(cred->user_ns, cred->suid));
-
-	if (!(retval   = put_user(ruid, ruidp)) &&
-	    !(retval   = put_user(euid, euidp)))
-		retval = put_user(suid, suidp);
-
-	return retval;
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_setresgid16, u16, rgid, u16, egid, u16, sgid)
-{
-	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
-			     low2highgid(sgid));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_getresgid16, u16 __user *, rgidp,
-		       u16 __user *, egidp, u16 __user *, sgidp)
-{
-	const struct cred *cred = current_cred();
-	int retval;
-	u16 rgid, egid, sgid;
-
-	rgid = high2lowgid(from_kgid_munged(cred->user_ns, cred->gid));
-	egid = high2lowgid(from_kgid_munged(cred->user_ns, cred->egid));
-	sgid = high2lowgid(from_kgid_munged(cred->user_ns, cred->sgid));
-
-	if (!(retval   = put_user(rgid, rgidp)) &&
-	    !(retval   = put_user(egid, egidp)))
-		retval = put_user(sgid, sgidp);
-
-	return retval;
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setfsuid16, u16, uid)
-{
-	return sys_setfsuid(low2highuid(uid));
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setfsgid16, u16, gid)
-{
-	return sys_setfsgid(low2highgid(gid));
-}
-
-static int groups16_to_user(u16 __user *grouplist, struct group_info *group_info)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	int i;
-	u16 group;
-	kgid_t kgid;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		kgid = group_info->gid[i];
-		group = (u16)from_kgid_munged(user_ns, kgid);
-		if (put_user(group, grouplist+i))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int groups16_from_user(struct group_info *group_info, u16 __user *grouplist)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	int i;
-	u16 group;
-	kgid_t kgid;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		if (get_user(group, grouplist+i))
-			return  -EFAULT;
-
-		kgid = make_kgid(user_ns, (gid_t)group);
-		if (!gid_valid(kgid))
-			return -EINVAL;
-
-		group_info->gid[i] = kgid;
-	}
-
-	return 0;
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_getgroups16, int, gidsetsize, u16 __user *, grouplist)
-{
-	const struct cred *cred = current_cred();
-	int i;
-
-	if (gidsetsize < 0)
-		return -EINVAL;
-
-	get_group_info(cred->group_info);
-	i = cred->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize) {
-			i = -EINVAL;
-			goto out;
-		}
-		if (groups16_to_user(grouplist, cred->group_info)) {
-			i = -EFAULT;
-			goto out;
-		}
-	}
-out:
-	put_group_info(cred->group_info);
-	return i;
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_setgroups16, int, gidsetsize, u16 __user *, grouplist)
-{
-	struct group_info *group_info;
-	int retval;
-
-	if (!may_setgroups())
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
-	groups_sort(group_info);
-	retval = set_current_groups(group_info);
-	put_group_info(group_info);
-
-	return retval;
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_getuid16)
-{
-	return high2lowuid(from_kuid_munged(current_user_ns(), current_uid()));
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_geteuid16)
-{
-	return high2lowuid(from_kuid_munged(current_user_ns(), current_euid()));
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_getgid16)
-{
-	return high2lowgid(from_kgid_munged(current_user_ns(), current_gid()));
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_getegid16)
-{
-	return high2lowgid(from_kgid_munged(current_user_ns(), current_egid()));
-}
-
 #ifdef CONFIG_SYSVIPC
 COMPAT_SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, compat_ulong_t, second,
 		compat_ulong_t, third, compat_uptr_t, ptr)
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index 48c4ce668244..f54b7b73f316 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -184,3 +184,18 @@ COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags
 COMPAT_SYSCALL_WRAP4(s390_sthyi, unsigned long, code, void __user *, info, u64 __user *, rc, unsigned long, flags);
 COMPAT_SYSCALL_WRAP5(kexec_file_load, int, kernel_fd, int, initrd_fd, unsigned long, cmdline_len, const char __user *, cmdline_ptr, unsigned long, flags)
 COMPAT_SYSCALL_WRAP4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
+COMPAT_SYSCALL_WRAP3(chown16, const char __user *, filename, u16, user, u16, group);
+COMPAT_SYSCALL_WRAP3(lchown16, const char __user *, filename, u16, user, u16, group);
+COMPAT_SYSCALL_WRAP3(fchown16, unsigned int, fd, u16, user, u16, group);
+COMPAT_SYSCALL_WRAP2(setregid16, u16, rgid, u16, egid);
+COMPAT_SYSCALL_WRAP1(setgid16, u16, gid);
+COMPAT_SYSCALL_WRAP2(setreuid16, u16, ruid, u16, euid);
+COMPAT_SYSCALL_WRAP1(setuid16, u16, uid);
+COMPAT_SYSCALL_WRAP3(setresuid16, u16, ruid, u16, euid, u16, suid);
+COMPAT_SYSCALL_WRAP3(getresuid16, u16 __user *, ruidp, u16 __user *, euidp, u16 __user *, suidp);
+COMPAT_SYSCALL_WRAP3(setresgid16, u16, rgid, u16, egid, u16, sgid);
+COMPAT_SYSCALL_WRAP3(getresgid16, u16 __user *, rgidp, u16 __user *, egidp, u16 __user *, sgidp);
+COMPAT_SYSCALL_WRAP1(setfsuid16, u16, uid);
+COMPAT_SYSCALL_WRAP1(setfsgid16, u16, gid);
+COMPAT_SYSCALL_WRAP2(getgroups16, int, gidsetsize, u16 __user *, grouplist);
+COMPAT_SYSCALL_WRAP2(setgroups16, int, gidsetsize, u16 __user *, grouplist);
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 022fc099b628..f878f74c42fd 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -23,13 +23,13 @@
 13   32		time			-				compat_sys_time
 14   common	mknod			sys_mknod			compat_sys_mknod
 15   common	chmod			sys_chmod			compat_sys_chmod
-16   32		lchown			-				compat_sys_s390_lchown16
+16   32		lchown			-				compat_sys_lchown16
 19   common	lseek			sys_lseek			compat_sys_lseek
 20   common	getpid			sys_getpid			sys_getpid
 21   common	mount			sys_mount			compat_sys_mount
 22   common	umount			sys_oldumount			compat_sys_oldumount
-23   32		setuid			-				compat_sys_s390_setuid16
-24   32		getuid			-				compat_sys_s390_getuid16
+23   32		setuid			-				compat_sys_setuid16
+24   32		getuid			-				sys_getuid16
 25   32		stime			-				compat_sys_stime
 26   common	ptrace			sys_ptrace			compat_sys_ptrace
 27   common	alarm			sys_alarm			sys_alarm
@@ -46,11 +46,11 @@
 42   common	pipe			sys_pipe			compat_sys_pipe
 43   common	times			sys_times			compat_sys_times
 45   common	brk			sys_brk				compat_sys_brk
-46   32		setgid			-				compat_sys_s390_setgid16
-47   32		getgid			-				compat_sys_s390_getgid16
+46   32		setgid			-				compat_sys_setgid16
+47   32		getgid			-				sys_getgid16
 48   common	signal			sys_signal			compat_sys_signal
-49   32		geteuid			-				compat_sys_s390_geteuid16
-50   32		getegid			-				compat_sys_s390_getegid16
+49   32		geteuid			-				sys_geteuid16
+50   32		getegid			-				sys_getegid16
 51   common	acct			sys_acct			compat_sys_acct
 52   common	umount2			sys_umount			compat_sys_umount
 54   common	ioctl			sys_ioctl			compat_sys_ioctl
@@ -64,8 +64,8 @@
 65   common	getpgrp			sys_getpgrp			sys_getpgrp
 66   common	setsid			sys_setsid			sys_setsid
 67   common	sigaction		sys_sigaction			compat_sys_sigaction
-70   32		setreuid		-				compat_sys_s390_setreuid16
-71   32		setregid		-				compat_sys_s390_setregid16
+70   32		setreuid		-				compat_sys_setreuid16
+71   32		setregid		-				compat_sys_setregid16
 72   common	sigsuspend		sys_sigsuspend			compat_sys_sigsuspend
 73   common	sigpending		sys_sigpending			compat_sys_sigpending
 74   common	sethostname		sys_sethostname			compat_sys_sethostname
@@ -74,8 +74,8 @@
 77   common	getrusage		sys_getrusage			compat_sys_getrusage
 78   common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
 79   common	settimeofday		sys_settimeofday		compat_sys_settimeofday
-80   32		getgroups		-				compat_sys_s390_getgroups16
-81   32		setgroups		-				compat_sys_s390_setgroups16
+80   32		getgroups		-				compat_sys_getgroups16
+81   32		setgroups		-				compat_sys_setgroups16
 83   common	symlink			sys_symlink			compat_sys_symlink
 85   common	readlink		sys_readlink			compat_sys_readlink
 86   common	uselib			sys_uselib			compat_sys_uselib
@@ -87,7 +87,7 @@
 92   common	truncate		sys_truncate			compat_sys_truncate
 93   common	ftruncate		sys_ftruncate			compat_sys_ftruncate
 94   common	fchmod			sys_fchmod			sys_fchmod
-95   32		fchown			-				compat_sys_s390_fchown16
+95   32		fchown			-				compat_sys_fchown16
 96   common	getpriority		sys_getpriority			sys_getpriority
 97   common	setpriority		sys_setpriority			sys_setpriority
 99   common	statfs			sys_statfs			compat_sys_statfs
@@ -126,8 +126,8 @@
 135  common	sysfs			sys_sysfs			compat_sys_sysfs
 136  common	personality		sys_s390_personality		sys_s390_personality
 137  common	afs_syscall		-				-
-138  32		setfsuid		-				compat_sys_s390_setfsuid16
-139  32		setfsgid		-				compat_sys_s390_setfsgid16
+138  32		setfsuid		-				compat_sys_setfsuid16
+139  32		setfsgid		-				compat_sys_setfsgid16
 140  32		_llseek			-				compat_sys_llseek
 141  common	getdents		sys_getdents			compat_sys_getdents
 142  32		_newselect		-				compat_sys_select
@@ -153,13 +153,13 @@
 161  common	sched_rr_get_interval	sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
 162  common	nanosleep		sys_nanosleep			compat_sys_nanosleep
 163  common	mremap			sys_mremap			compat_sys_mremap
-164  32		setresuid		-				compat_sys_s390_setresuid16
-165  32		getresuid		-				compat_sys_s390_getresuid16
+164  32		setresuid		-				compat_sys_setresuid16
+165  32		getresuid		-				compat_sys_getresuid16
 167  common	query_module		-				-
 168  common	poll			sys_poll			compat_sys_poll
 169  common	nfsservctl		-				-
-170  32		setresgid		-				compat_sys_s390_setresgid16
-171  32		getresgid		-				compat_sys_s390_getresgid16
+170  32		setresgid		-				compat_sys_setresgid16
+171  32		getresgid		-				compat_sys_getresgid16
 172  common	prctl			sys_prctl			compat_sys_prctl
 173  common	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
 174  common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
@@ -170,7 +170,7 @@
 179  common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 180  common	pread64			sys_pread64			compat_sys_s390_pread64
 181  common	pwrite64		sys_pwrite64			compat_sys_s390_pwrite64
-182  32		chown			-				compat_sys_s390_chown16
+182  32		chown			-				compat_sys_chown16
 183  common	getcwd			sys_getcwd			compat_sys_getcwd
 184  common	capget			sys_capget			compat_sys_capget
 185  common	capset			sys_capset			compat_sys_capset
-- 
2.20.0
