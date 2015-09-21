Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 21 Sep 2015 12:48:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.3-rc3
Message-ID: <20150921124827.639d2e21@mschwide>
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

A couple of system call updates. The two new system calls userfaultfd
and membarrier have been added, as well as the 17 direct calls for the
multiplexed socket system calls.

In addition the system call compat wrappers have been flagged as
notrace functions and a few wrappers could be removed.

And bug fixes for the vector register handling, cpu_mf, suspend/resume,
compat signals, SMT cputime accounting and the zfcp dumper.

Heiko Carstens (5):
      s390: fix floating point register corruption
      s390: wire up userfaultfd system call
      s390/compat: do not trace compat wrapper functions
      s390/compat: remove superfluous compat wrappers
      s390: wire up separate socketcalls system calls

Hendrik Brueckner (1):
      s390/cpum_cf: Corrected return code for unauthorized counter sets

Martin Schwidefsky (3):
      s390/hibernate: fix save and restore of vector registers
      s390/compat: correct uc_sigmask of the compat signal frame
      s390/vtime: correct scaled cputime for SMT

Mathieu Desnoyers (1):
      s390/s390x: allocate sys_membarrier system call number

Michael Holzheu (1):
      s390/configs//zfcpdump_defconfig: Remove CONFIG_MEMSTICK

 arch/s390/configs/zfcpdump_defconfig     |   5 --
 arch/s390/include/asm/unistd.h           |  20 -----
 arch/s390/include/uapi/asm/unistd.h      |  21 +++++-
 arch/s390/kernel/compat_signal.c         |  27 ++++++-
 arch/s390/kernel/compat_wrapper.c        |  70 ++++--------------
 arch/s390/kernel/entry.S                 |   2 +
 arch/s390/kernel/perf_cpum_cf.c          |  12 ++-
 arch/s390/kernel/swsusp.S                |  38 +---------
 arch/s390/kernel/syscalls.S              | 121 ++++++++++++++++++-------------
 arch/s390/kernel/vtime.c                 |  12 ++-
 tools/testing/selftests/vm/userfaultfd.c |   2 +
 11 files changed, 149 insertions(+), 181 deletions(-)

diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 1b0184a..92805d6 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -1,7 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_RCU_FAST_NO_HZ=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_COMPAT_BRK is not set
@@ -54,10 +53,6 @@ CONFIG_RAW_DRIVER=y
 # CONFIG_MONWRITER is not set
 # CONFIG_S390_VMUR is not set
 # CONFIG_HID is not set
-CONFIG_MEMSTICK=y
-CONFIG_MEMSTICK_DEBUG=y
-CONFIG_MEMSTICK_UNSAFE_RESUME=y
-CONFIG_MSPRO_BLOCK=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 525cef7..02613ba 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -8,28 +8,8 @@
 
 #include <uapi/asm/unistd.h>
 
-
 #define __IGNORE_time
 
-/* Ignore system calls that are also reachable via sys_socketcall */
-#define __IGNORE_recvmmsg
-#define __IGNORE_sendmmsg
-#define __IGNORE_socket
-#define __IGNORE_socketpair
-#define __IGNORE_bind
-#define __IGNORE_connect
-#define __IGNORE_listen
-#define __IGNORE_accept4
-#define __IGNORE_getsockopt
-#define __IGNORE_setsockopt
-#define __IGNORE_getsockname
-#define __IGNORE_getpeername
-#define __IGNORE_sendto
-#define __IGNORE_sendmsg
-#define __IGNORE_recvfrom
-#define __IGNORE_recvmsg
-#define __IGNORE_shutdown
-
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index 59d2bb4..a848adb 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -290,7 +290,26 @@
 #define __NR_s390_pci_mmio_write	352
 #define __NR_s390_pci_mmio_read		353
 #define __NR_execveat		354
-#define NR_syscalls 355
+#define __NR_userfaultfd	355
+#define __NR_membarrier		356
+#define __NR_recvmmsg		357
+#define __NR_sendmmsg		358
+#define __NR_socket		359
+#define __NR_socketpair		360
+#define __NR_bind		361
+#define __NR_connect		362
+#define __NR_listen		363
+#define __NR_accept4		364
+#define __NR_getsockopt		365
+#define __NR_setsockopt		366
+#define __NR_getsockname	367
+#define __NR_getpeername	368
+#define __NR_sendto		369
+#define __NR_sendmsg		370
+#define __NR_recvfrom		371
+#define __NR_recvmsg		372
+#define __NR_shutdown		373
+#define NR_syscalls 374
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index eb46642..e0f9d27 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -48,6 +48,19 @@ typedef struct
 	struct ucontext32 uc;
 } rt_sigframe32;
 
+static inline void sigset_to_sigset32(unsigned long *set64,
+				      compat_sigset_word *set32)
+{
+	set32[0] = (compat_sigset_word) set64[0];
+	set32[1] = (compat_sigset_word)(set64[0] >> 32);
+}
+
+static inline void sigset32_to_sigset(compat_sigset_word *set32,
+				      unsigned long *set64)
+{
+	set64[0] = (unsigned long) set32[0] | ((unsigned long) set32[1] << 32);
+}
+
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 {
 	int err;
@@ -281,10 +294,12 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	sigframe32 __user *frame = (sigframe32 __user *)regs->gprs[15];
+	compat_sigset_t cset;
 	sigset_t set;
 
-	if (__copy_from_user(&set.sig, &frame->sc.oldmask, _SIGMASK_COPY_SIZE32))
+	if (__copy_from_user(&cset.sig, &frame->sc.oldmask, _SIGMASK_COPY_SIZE32))
 		goto badframe;
+	sigset32_to_sigset(cset.sig, set.sig);
 	set_current_blocked(&set);
 	save_fpu_regs();
 	if (restore_sigregs32(regs, &frame->sregs))
@@ -302,10 +317,12 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	rt_sigframe32 __user *frame = (rt_sigframe32 __user *)regs->gprs[15];
+	compat_sigset_t cset;
 	sigset_t set;
 
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (__copy_from_user(&cset, &frame->uc.uc_sigmask, sizeof(cset)))
 		goto badframe;
+	sigset32_to_sigset(cset.sig, set.sig);
 	set_current_blocked(&set);
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
@@ -377,7 +394,7 @@ static int setup_frame32(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 
 	/* Create struct sigcontext32 on the signal stack */
-	memcpy(&sc.oldmask, &set->sig, _SIGMASK_COPY_SIZE32);
+	sigset_to_sigset32(set->sig, sc.oldmask);
 	sc.sregs = (__u32)(unsigned long __force) &frame->sregs;
 	if (__copy_to_user(&frame->sc, &sc, sizeof(frame->sc)))
 		return -EFAULT;
@@ -438,6 +455,7 @@ static int setup_frame32(struct ksignal *ksig, sigset_t *set,
 static int setup_rt_frame32(struct ksignal *ksig, sigset_t *set,
 			    struct pt_regs *regs)
 {
+	compat_sigset_t cset;
 	rt_sigframe32 __user *frame;
 	unsigned long restorer;
 	size_t frame_size;
@@ -485,11 +503,12 @@ static int setup_rt_frame32(struct ksignal *ksig, sigset_t *set,
 	store_sigregs();
 
 	/* Create ucontext on the signal stack. */
+	sigset_to_sigset32(set->sig, cset.sig);
 	if (__put_user(uc_flags, &frame->uc.uc_flags) ||
 	    __put_user(0, &frame->uc.uc_link) ||
 	    __compat_save_altstack(&frame->uc.uc_stack, regs->gprs[15]) ||
 	    save_sigregs32(regs, &frame->uc.uc_mcontext) ||
-	    __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set)) ||
+	    __copy_to_user(&frame->uc.uc_sigmask, &cset, sizeof(cset)) ||
 	    save_sigregs_ext32(regs, &frame->uc.uc_mcontext_ext))
 		return -EFAULT;
 
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index f8498dd..09f1940 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -52,15 +52,13 @@
  * the regular system call wrappers.
  */
 #define COMPAT_SYSCALL_WRAPx(x, name, ...)					\
-	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));		\
-	asmlinkage long compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));\
-	asmlinkage long compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))	\
-	{									\
-		return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));	\
-	}
+asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));			\
+asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));\
+asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))	\
+{										\
+	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));		\
+}
 
-COMPAT_SYSCALL_WRAP1(exit, int, error_code);
-COMPAT_SYSCALL_WRAP1(close, unsigned int, fd);
 COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
 COMPAT_SYSCALL_WRAP2(link, const char __user *, oldname, const char __user *, newname);
 COMPAT_SYSCALL_WRAP1(unlink, const char __user *, pathname);
@@ -68,23 +66,16 @@ COMPAT_SYSCALL_WRAP1(chdir, const char __user *, filename);
 COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
 COMPAT_SYSCALL_WRAP2(chmod, const char __user *, filename, umode_t, mode);
 COMPAT_SYSCALL_WRAP1(oldumount, char __user *, name);
-COMPAT_SYSCALL_WRAP1(alarm, unsigned int, seconds);
 COMPAT_SYSCALL_WRAP2(access, const char __user *, filename, int, mode);
-COMPAT_SYSCALL_WRAP1(nice, int, increment);
-COMPAT_SYSCALL_WRAP2(kill, int, pid, int, sig);
 COMPAT_SYSCALL_WRAP2(rename, const char __user *, oldname, const char __user *, newname);
 COMPAT_SYSCALL_WRAP2(mkdir, const char __user *, pathname, umode_t, mode);
 COMPAT_SYSCALL_WRAP1(rmdir, const char __user *, pathname);
-COMPAT_SYSCALL_WRAP1(dup, unsigned int, fildes);
 COMPAT_SYSCALL_WRAP1(pipe, int __user *, fildes);
 COMPAT_SYSCALL_WRAP1(brk, unsigned long, brk);
 COMPAT_SYSCALL_WRAP2(signal, int, sig, __sighandler_t, handler);
 COMPAT_SYSCALL_WRAP1(acct, const char __user *, name);
 COMPAT_SYSCALL_WRAP2(umount, char __user *, name, int, flags);
-COMPAT_SYSCALL_WRAP2(setpgid, pid_t, pid, pid_t, pgid);
-COMPAT_SYSCALL_WRAP1(umask, int, mask);
 COMPAT_SYSCALL_WRAP1(chroot, const char __user *, filename);
-COMPAT_SYSCALL_WRAP2(dup2, unsigned int, oldfd, unsigned int, newfd);
 COMPAT_SYSCALL_WRAP3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask);
 COMPAT_SYSCALL_WRAP2(sethostname, char __user *, name, int, len);
 COMPAT_SYSCALL_WRAP2(symlink, const char __user *, old, const char __user *, new);
@@ -93,37 +84,23 @@ COMPAT_SYSCALL_WRAP1(uselib, const char __user *, library);
 COMPAT_SYSCALL_WRAP2(swapon, const char __user *, specialfile, int, swap_flags);
 COMPAT_SYSCALL_WRAP4(reboot, int, magic1, int, magic2, unsigned int, cmd, void __user *, arg);
 COMPAT_SYSCALL_WRAP2(munmap, unsigned long, addr, size_t, len);
-COMPAT_SYSCALL_WRAP2(fchmod, unsigned int, fd, umode_t, mode);
-COMPAT_SYSCALL_WRAP2(getpriority, int, which, int, who);
-COMPAT_SYSCALL_WRAP3(setpriority, int, which, int, who, int, niceval);
 COMPAT_SYSCALL_WRAP3(syslog, int, type, char __user *, buf, int, len);
 COMPAT_SYSCALL_WRAP1(swapoff, const char __user *, specialfile);
-COMPAT_SYSCALL_WRAP1(fsync, unsigned int, fd);
 COMPAT_SYSCALL_WRAP2(setdomainname, char __user *, name, int, len);
 COMPAT_SYSCALL_WRAP1(newuname, struct new_utsname __user *, name);
 COMPAT_SYSCALL_WRAP3(mprotect, unsigned long, start, size_t, len, unsigned long, prot);
 COMPAT_SYSCALL_WRAP3(init_module, void __user *, umod, unsigned long, len, const char __user *, uargs);
 COMPAT_SYSCALL_WRAP2(delete_module, const char __user *, name_user, unsigned int, flags);
 COMPAT_SYSCALL_WRAP4(quotactl, unsigned int, cmd, const char __user *, special, qid_t, id, void __user *, addr);
-COMPAT_SYSCALL_WRAP1(getpgid, pid_t, pid);
-COMPAT_SYSCALL_WRAP1(fchdir, unsigned int, fd);
 COMPAT_SYSCALL_WRAP2(bdflush, int, func, long, data);
 COMPAT_SYSCALL_WRAP3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2);
-COMPAT_SYSCALL_WRAP1(s390_personality, unsigned int, personality);
 COMPAT_SYSCALL_WRAP5(llseek, unsigned int, fd, unsigned long, high, unsigned long, low, loff_t __user *, result, unsigned int, whence);
-COMPAT_SYSCALL_WRAP2(flock, unsigned int, fd, unsigned int, cmd);
 COMPAT_SYSCALL_WRAP3(msync, unsigned long, start, size_t, len, int, flags);
-COMPAT_SYSCALL_WRAP1(getsid, pid_t, pid);
-COMPAT_SYSCALL_WRAP1(fdatasync, unsigned int, fd);
 COMPAT_SYSCALL_WRAP2(mlock, unsigned long, start, size_t, len);
 COMPAT_SYSCALL_WRAP2(munlock, unsigned long, start, size_t, len);
-COMPAT_SYSCALL_WRAP1(mlockall, int, flags);
 COMPAT_SYSCALL_WRAP2(sched_setparam, pid_t, pid, struct sched_param __user *, param);
 COMPAT_SYSCALL_WRAP2(sched_getparam, pid_t, pid, struct sched_param __user *, param);
 COMPAT_SYSCALL_WRAP3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP1(sched_getscheduler, pid_t, pid);
-COMPAT_SYSCALL_WRAP1(sched_get_priority_max, int, policy);
-COMPAT_SYSCALL_WRAP1(sched_get_priority_min, int, policy);
 COMPAT_SYSCALL_WRAP5(mremap, unsigned long, addr, unsigned long, old_len, unsigned long, new_len, unsigned long, flags, unsigned long, new_addr);
 COMPAT_SYSCALL_WRAP3(poll, struct pollfd __user *, ufds, unsigned int, nfds, int, timeout);
 COMPAT_SYSCALL_WRAP5(prctl, int, option, unsigned long, arg2, unsigned long, arg3, unsigned long, arg4, unsigned long, arg5);
@@ -131,20 +108,11 @@ COMPAT_SYSCALL_WRAP2(getcwd, char __user *, buf, unsigned long, size);
 COMPAT_SYSCALL_WRAP2(capget, cap_user_header_t, header, cap_user_data_t, dataptr);
 COMPAT_SYSCALL_WRAP2(capset, cap_user_header_t, header, const cap_user_data_t, data);
 COMPAT_SYSCALL_WRAP3(lchown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP2(setreuid, uid_t, ruid, uid_t, euid);
-COMPAT_SYSCALL_WRAP2(setregid, gid_t, rgid, gid_t, egid);
 COMPAT_SYSCALL_WRAP2(getgroups, int, gidsetsize, gid_t __user *, grouplist);
 COMPAT_SYSCALL_WRAP2(setgroups, int, gidsetsize, gid_t __user *, grouplist);
-COMPAT_SYSCALL_WRAP3(fchown, unsigned int, fd, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP3(setresuid, uid_t, ruid, uid_t, euid, uid_t, suid);
 COMPAT_SYSCALL_WRAP3(getresuid, uid_t __user *, ruid, uid_t __user *, euid, uid_t __user *, suid);
-COMPAT_SYSCALL_WRAP3(setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid);
 COMPAT_SYSCALL_WRAP3(getresgid, gid_t __user *, rgid, gid_t __user *, egid, gid_t __user *, sgid);
 COMPAT_SYSCALL_WRAP3(chown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP1(setuid, uid_t, uid);
-COMPAT_SYSCALL_WRAP1(setgid, gid_t, gid);
-COMPAT_SYSCALL_WRAP1(setfsuid, uid_t, uid);
-COMPAT_SYSCALL_WRAP1(setfsgid, gid_t, gid);
 COMPAT_SYSCALL_WRAP2(pivot_root, const char __user *, new_root, const char __user *, put_old);
 COMPAT_SYSCALL_WRAP3(mincore, unsigned long, start, size_t, len, unsigned char __user *, vec);
 COMPAT_SYSCALL_WRAP3(madvise, unsigned long, start, size_t, len, int, behavior);
@@ -161,23 +129,16 @@ COMPAT_SYSCALL_WRAP3(flistxattr, int, fd, char __user *, list, size_t, size);
 COMPAT_SYSCALL_WRAP2(removexattr, const char __user *, path, const char __user *, name);
 COMPAT_SYSCALL_WRAP2(lremovexattr, const char __user *, path, const char __user *, name);
 COMPAT_SYSCALL_WRAP2(fremovexattr, int, fd, const char __user *, name);
-COMPAT_SYSCALL_WRAP1(exit_group, int, error_code);
 COMPAT_SYSCALL_WRAP1(set_tid_address, int __user *, tidptr);
-COMPAT_SYSCALL_WRAP1(epoll_create, int, size);
 COMPAT_SYSCALL_WRAP4(epoll_ctl, int, epfd, int, op, int, fd, struct epoll_event __user *, event);
 COMPAT_SYSCALL_WRAP4(epoll_wait, int, epfd, struct epoll_event __user *, events, int, maxevents, int, timeout);
-COMPAT_SYSCALL_WRAP1(timer_getoverrun, timer_t, timer_id);
-COMPAT_SYSCALL_WRAP1(timer_delete, compat_timer_t, compat_timer_id);
 COMPAT_SYSCALL_WRAP1(io_destroy, aio_context_t, ctx);
 COMPAT_SYSCALL_WRAP3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb, struct io_event __user *, result);
 COMPAT_SYSCALL_WRAP1(mq_unlink, const char __user *, name);
 COMPAT_SYSCALL_WRAP5(add_key, const char __user *, tp, const char __user *, dsc, const void __user *, pld, size_t, len, key_serial_t, id);
 COMPAT_SYSCALL_WRAP4(request_key, const char __user *, tp, const char __user *, dsc, const char __user *, info, key_serial_t, id);
 COMPAT_SYSCALL_WRAP5(remap_file_pages, unsigned long, start, unsigned long, size, unsigned long, prot, unsigned long, pgoff, unsigned long, flags);
-COMPAT_SYSCALL_WRAP3(ioprio_set, int, which, int, who, int, ioprio);
-COMPAT_SYSCALL_WRAP2(ioprio_get, int, which, int, who);
 COMPAT_SYSCALL_WRAP3(inotify_add_watch, int, fd, const char __user *, path, u32, mask);
-COMPAT_SYSCALL_WRAP2(inotify_rm_watch, int, fd, __s32, wd);
 COMPAT_SYSCALL_WRAP3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode);
 COMPAT_SYSCALL_WRAP4(mknodat, int, dfd, const char __user *, filename, umode_t, mode, unsigned, dev);
 COMPAT_SYSCALL_WRAP5(fchownat, int, dfd, const char __user *, filename, uid_t, user, gid_t, group, int, flag);
@@ -192,23 +153,11 @@ COMPAT_SYSCALL_WRAP1(unshare, unsigned long, unshare_flags);
 COMPAT_SYSCALL_WRAP6(splice, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
 COMPAT_SYSCALL_WRAP4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags);
 COMPAT_SYSCALL_WRAP3(getcpu, unsigned __user *, cpu, unsigned __user *, node, struct getcpu_cache __user *, cache);
-COMPAT_SYSCALL_WRAP1(eventfd, unsigned int, count);
-COMPAT_SYSCALL_WRAP2(timerfd_create, int, clockid, int, flags);
-COMPAT_SYSCALL_WRAP2(eventfd2, unsigned int, count, int, flags);
-COMPAT_SYSCALL_WRAP1(inotify_init1, int, flags);
 COMPAT_SYSCALL_WRAP2(pipe2, int __user *, fildes, int, flags);
-COMPAT_SYSCALL_WRAP3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags);
-COMPAT_SYSCALL_WRAP1(epoll_create1, int, flags);
-COMPAT_SYSCALL_WRAP2(tkill, int, pid, int, sig);
-COMPAT_SYSCALL_WRAP3(tgkill, int, tgid, int, pid, int, sig);
 COMPAT_SYSCALL_WRAP5(perf_event_open, struct perf_event_attr __user *, attr_uptr, pid_t, pid, int, cpu, int, group_fd, unsigned long, flags);
 COMPAT_SYSCALL_WRAP5(clone, unsigned long, newsp, unsigned long, clone_flags, int __user *, parent_tidptr, int __user *, child_tidptr, unsigned long, tls);
-COMPAT_SYSCALL_WRAP2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags);
 COMPAT_SYSCALL_WRAP4(prlimit64, pid_t, pid, unsigned int, resource, const struct rlimit64 __user *, new_rlim, struct rlimit64 __user *, old_rlim);
 COMPAT_SYSCALL_WRAP5(name_to_handle_at, int, dfd, const char __user *, name, struct file_handle __user *, handle, int __user *, mnt_id, int, flag);
-COMPAT_SYSCALL_WRAP1(syncfs, int, fd);
-COMPAT_SYSCALL_WRAP2(setns, int, fd, int, nstype);
-COMPAT_SYSCALL_WRAP2(s390_runtime_instr, int, command, int, signum);
 COMPAT_SYSCALL_WRAP5(kcmp, pid_t, pid1, pid_t, pid2, int, type, unsigned long, idx1, unsigned long, idx2);
 COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, flags);
 COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
@@ -220,3 +169,10 @@ COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, fla
 COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
 COMPAT_SYSCALL_WRAP3(s390_pci_mmio_write, const unsigned long, mmio_addr, const void __user *, user_buffer, const size_t, length);
 COMPAT_SYSCALL_WRAP3(s390_pci_mmio_read, const unsigned long, mmio_addr, void __user *, user_buffer, const size_t, length);
+COMPAT_SYSCALL_WRAP4(socketpair, int, family, int, type, int, protocol, int __user *, usockvec);
+COMPAT_SYSCALL_WRAP3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen);
+COMPAT_SYSCALL_WRAP3(connect, int, fd, struct sockaddr __user *, uservaddr, int, addrlen);
+COMPAT_SYSCALL_WRAP4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr, int __user *, upeer_addrlen, int, flags);
+COMPAT_SYSCALL_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
+COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
+COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 247b7aa..09b039d 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1191,6 +1191,7 @@ cleanup_critical:
 	clg	%r9,BASED(.Lcleanup_save_fpu_fpc_end)
 	jhe	1f
 	lg	%r2,__LC_CURRENT
+	aghi	%r2,__TASK_thread
 0:	# Store floating-point controls
 	stfpc	__THREAD_FPU_fpc(%r2)
 1:	# Load register save area and check if VX is active
@@ -1252,6 +1253,7 @@ cleanup_critical:
 	clg	%r9,BASED(.Lcleanup_load_fpu_regs_vx_ctl)
 	jhe	6f
 	lg	%r4,__LC_CURRENT
+	aghi	%r4,__TASK_thread
 	lfpc	__THREAD_FPU_fpc(%r4)
 	tm	__THREAD_FPU_flags+3(%r4),FPU_USE_VX	# VX-enabled task ?
 	lg	%r4,__THREAD_FPU_regs(%r4)	# %r4 <- reg save area
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 56fdad4..a956340 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -157,10 +157,14 @@ static int validate_ctr_auth(const struct hw_perf_event *hwc)
 
 	cpuhw = &get_cpu_var(cpu_hw_events);
 
-	/* check authorization for cpu counter sets */
+	/* Check authorization for cpu counter sets.
+	 * If the particular CPU counter set is not authorized,
+	 * return with -ENOENT in order to fall back to other
+	 * PMUs that might suffice the event request.
+	 */
 	ctrs_state = cpumf_state_ctl[hwc->config_base];
 	if (!(ctrs_state & cpuhw->info.auth_ctl))
-		err = -EPERM;
+		err = -ENOENT;
 
 	put_cpu_var(cpu_hw_events);
 	return err;
@@ -536,7 +540,7 @@ static int cpumf_pmu_add(struct perf_event *event, int flags)
 	 */
 	if (!(cpuhw->flags & PERF_EVENT_TXN))
 		if (validate_ctr_auth(&event->hw))
-			return -EPERM;
+			return -ENOENT;
 
 	ctr_set_enable(&cpuhw->state, event->hw.config_base);
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
@@ -611,7 +615,7 @@ static int cpumf_pmu_commit_txn(struct pmu *pmu)
 	state = cpuhw->state & ~((1 << CPUMF_LCCTL_ENABLE_SHIFT) - 1);
 	state >>= CPUMF_LCCTL_ENABLE_SHIFT;
 	if ((state & cpuhw->info.auth_ctl) != state)
-		return -EPERM;
+		return -ENOENT;
 
 	cpuhw->flags &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
index ca62946..2d6b6e8 100644
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -30,6 +30,9 @@ ENTRY(swsusp_arch_suspend)
 	aghi	%r15,-STACK_FRAME_OVERHEAD
 	stg	%r1,__SF_BACKCHAIN(%r15)
 
+	/* Store FPU registers */
+	brasl	%r14,save_fpu_regs
+
 	/* Deactivate DAT */
 	stnsm	__SF_EMPTY(%r15),0xfb
 
@@ -47,23 +50,6 @@ ENTRY(swsusp_arch_suspend)
 
 	/* Store registers */
 	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
-	stfpc	0x31c(%r1)			/* store fpu control */
-	std	0,0x200(%r1)			/* store f0 */
-	std	1,0x208(%r1)			/* store f1 */
-	std	2,0x210(%r1)			/* store f2 */
-	std	3,0x218(%r1)			/* store f3 */
-	std	4,0x220(%r1)			/* store f4 */
-	std	5,0x228(%r1)			/* store f5 */
-	std	6,0x230(%r1)			/* store f6 */
-	std	7,0x238(%r1)			/* store f7 */
-	std	8,0x240(%r1)			/* store f8 */
-	std	9,0x248(%r1)			/* store f9 */
-	std	10,0x250(%r1)			/* store f10 */
-	std	11,0x258(%r1)			/* store f11 */
-	std	12,0x260(%r1)			/* store f12 */
-	std	13,0x268(%r1)			/* store f13 */
-	std	14,0x270(%r1)			/* store f14 */
-	std	15,0x278(%r1)			/* store f15 */
 	stam	%a0,%a15,0x340(%r1)		/* store access registers */
 	stctg	%c0,%c15,0x380(%r1)		/* store control registers */
 	stmg	%r0,%r15,0x280(%r1)		/* store general registers */
@@ -249,24 +235,6 @@ restore_registers:
 	lctlg	%c0,%c15,0x380(%r13)	/* load control registers */
 	lam	%a0,%a15,0x340(%r13)	/* load access registers */
 
-	lfpc	0x31c(%r13)		/* load fpu control */
-	ld	0,0x200(%r13)		/* load f0 */
-	ld	1,0x208(%r13)		/* load f1 */
-	ld	2,0x210(%r13)		/* load f2 */
-	ld	3,0x218(%r13)		/* load f3 */
-	ld	4,0x220(%r13)		/* load f4 */
-	ld	5,0x228(%r13)		/* load f5 */
-	ld	6,0x230(%r13)		/* load f6 */
-	ld	7,0x238(%r13)		/* load f7 */
-	ld	8,0x240(%r13)		/* load f8 */
-	ld	9,0x248(%r13)		/* load f9 */
-	ld	10,0x250(%r13)		/* load f10 */
-	ld	11,0x258(%r13)		/* load f11 */
-	ld	12,0x260(%r13)		/* load f12 */
-	ld	13,0x268(%r13)		/* load f13 */
-	ld	14,0x270(%r13)		/* load f14 */
-	ld	15,0x278(%r13)		/* load f15 */
-
 	/* Load old stack */
 	lg	%r15,0x2f8(%r13)
 
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index f3f4a13..8c56929 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -9,12 +9,12 @@
 #define NI_SYSCALL SYSCALL(sys_ni_syscall,sys_ni_syscall)
 
 NI_SYSCALL						/* 0 */
-SYSCALL(sys_exit,compat_sys_exit)
+SYSCALL(sys_exit,sys_exit)
 SYSCALL(sys_fork,sys_fork)
 SYSCALL(sys_read,compat_sys_s390_read)
 SYSCALL(sys_write,compat_sys_s390_write)
 SYSCALL(sys_open,compat_sys_open)			/* 5 */
-SYSCALL(sys_close,compat_sys_close)
+SYSCALL(sys_close,sys_close)
 SYSCALL(sys_restart_syscall,sys_restart_syscall)
 SYSCALL(sys_creat,compat_sys_creat)
 SYSCALL(sys_link,compat_sys_link)
@@ -35,21 +35,21 @@ SYSCALL(sys_ni_syscall,compat_sys_s390_setuid16)	/* old setuid16 syscall*/
 SYSCALL(sys_ni_syscall,compat_sys_s390_getuid16)	/* old getuid16 syscall*/
 SYSCALL(sys_ni_syscall,compat_sys_stime)		/* 25 old stime syscall */
 SYSCALL(sys_ptrace,compat_sys_ptrace)
-SYSCALL(sys_alarm,compat_sys_alarm)
+SYSCALL(sys_alarm,sys_alarm)
 NI_SYSCALL						/* old fstat syscall */
 SYSCALL(sys_pause,sys_pause)
 SYSCALL(sys_utime,compat_sys_utime)			/* 30 */
 NI_SYSCALL						/* old stty syscall */
 NI_SYSCALL						/* old gtty syscall */
 SYSCALL(sys_access,compat_sys_access)
-SYSCALL(sys_nice,compat_sys_nice)
+SYSCALL(sys_nice,sys_nice)
 NI_SYSCALL						/* 35 old ftime syscall */
 SYSCALL(sys_sync,sys_sync)
-SYSCALL(sys_kill,compat_sys_kill)
+SYSCALL(sys_kill,sys_kill)
 SYSCALL(sys_rename,compat_sys_rename)
 SYSCALL(sys_mkdir,compat_sys_mkdir)
 SYSCALL(sys_rmdir,compat_sys_rmdir)			/* 40 */
-SYSCALL(sys_dup,compat_sys_dup)
+SYSCALL(sys_dup,sys_dup)
 SYSCALL(sys_pipe,compat_sys_pipe)
 SYSCALL(sys_times,compat_sys_times)
 NI_SYSCALL						/* old prof syscall */
@@ -65,13 +65,13 @@ NI_SYSCALL						/* old lock syscall */
 SYSCALL(sys_ioctl,compat_sys_ioctl)
 SYSCALL(sys_fcntl,compat_sys_fcntl)			/* 55 */
 NI_SYSCALL						/* intel mpx syscall */
-SYSCALL(sys_setpgid,compat_sys_setpgid)
+SYSCALL(sys_setpgid,sys_setpgid)
 NI_SYSCALL						/* old ulimit syscall */
 NI_SYSCALL						/* old uname syscall */
-SYSCALL(sys_umask,compat_sys_umask)			/* 60 */
+SYSCALL(sys_umask,sys_umask)				/* 60 */
 SYSCALL(sys_chroot,compat_sys_chroot)
 SYSCALL(sys_ustat,compat_sys_ustat)
-SYSCALL(sys_dup2,compat_sys_dup2)
+SYSCALL(sys_dup2,sys_dup2)
 SYSCALL(sys_getppid,sys_getppid)
 SYSCALL(sys_getpgrp,sys_getpgrp)			/* 65 */
 SYSCALL(sys_setsid,sys_setsid)
@@ -102,10 +102,10 @@ SYSCALL(sys_old_mmap,compat_sys_s390_old_mmap)		/* 90 */
 SYSCALL(sys_munmap,compat_sys_munmap)
 SYSCALL(sys_truncate,compat_sys_truncate)
 SYSCALL(sys_ftruncate,compat_sys_ftruncate)
-SYSCALL(sys_fchmod,compat_sys_fchmod)
+SYSCALL(sys_fchmod,sys_fchmod)
 SYSCALL(sys_ni_syscall,compat_sys_s390_fchown16)	/* 95 old fchown16 syscall*/
-SYSCALL(sys_getpriority,compat_sys_getpriority)
-SYSCALL(sys_setpriority,compat_sys_setpriority)
+SYSCALL(sys_getpriority,sys_getpriority)
+SYSCALL(sys_setpriority,sys_setpriority)
 NI_SYSCALL						/* old profil syscall */
 SYSCALL(sys_statfs,compat_sys_statfs)
 SYSCALL(sys_fstatfs,compat_sys_fstatfs)			/* 100 */
@@ -126,7 +126,7 @@ SYSCALL(sys_wait4,compat_sys_wait4)
 SYSCALL(sys_swapoff,compat_sys_swapoff)			/* 115 */
 SYSCALL(sys_sysinfo,compat_sys_sysinfo)
 SYSCALL(sys_s390_ipc,compat_sys_s390_ipc)
-SYSCALL(sys_fsync,compat_sys_fsync)
+SYSCALL(sys_fsync,sys_fsync)
 SYSCALL(sys_sigreturn,compat_sys_sigreturn)
 SYSCALL(sys_clone,compat_sys_clone)			/* 120 */
 SYSCALL(sys_setdomainname,compat_sys_setdomainname)
@@ -140,35 +140,35 @@ SYSCALL(sys_init_module,compat_sys_init_module)
 SYSCALL(sys_delete_module,compat_sys_delete_module)
 NI_SYSCALL						/* 130: old get_kernel_syms */
 SYSCALL(sys_quotactl,compat_sys_quotactl)
-SYSCALL(sys_getpgid,compat_sys_getpgid)
-SYSCALL(sys_fchdir,compat_sys_fchdir)
+SYSCALL(sys_getpgid,sys_getpgid)
+SYSCALL(sys_fchdir,sys_fchdir)
 SYSCALL(sys_bdflush,compat_sys_bdflush)
 SYSCALL(sys_sysfs,compat_sys_sysfs)			/* 135 */
-SYSCALL(sys_s390_personality,compat_sys_s390_personality)
+SYSCALL(sys_s390_personality,sys_s390_personality)
 NI_SYSCALL						/* for afs_syscall */
 SYSCALL(sys_ni_syscall,compat_sys_s390_setfsuid16)	/* old setfsuid16 syscall */
 SYSCALL(sys_ni_syscall,compat_sys_s390_setfsgid16)	/* old setfsgid16 syscall */
 SYSCALL(sys_llseek,compat_sys_llseek)			/* 140 */
 SYSCALL(sys_getdents,compat_sys_getdents)
 SYSCALL(sys_select,compat_sys_select)
-SYSCALL(sys_flock,compat_sys_flock)
+SYSCALL(sys_flock,sys_flock)
 SYSCALL(sys_msync,compat_sys_msync)
 SYSCALL(sys_readv,compat_sys_readv)			/* 145 */
 SYSCALL(sys_writev,compat_sys_writev)
-SYSCALL(sys_getsid,compat_sys_getsid)
-SYSCALL(sys_fdatasync,compat_sys_fdatasync)
+SYSCALL(sys_getsid,sys_getsid)
+SYSCALL(sys_fdatasync,sys_fdatasync)
 SYSCALL(sys_sysctl,compat_sys_sysctl)
 SYSCALL(sys_mlock,compat_sys_mlock)			/* 150 */
 SYSCALL(sys_munlock,compat_sys_munlock)
-SYSCALL(sys_mlockall,compat_sys_mlockall)
+SYSCALL(sys_mlockall,sys_mlockall)
 SYSCALL(sys_munlockall,sys_munlockall)
 SYSCALL(sys_sched_setparam,compat_sys_sched_setparam)
 SYSCALL(sys_sched_getparam,compat_sys_sched_getparam)	/* 155 */
 SYSCALL(sys_sched_setscheduler,compat_sys_sched_setscheduler)
-SYSCALL(sys_sched_getscheduler,compat_sys_sched_getscheduler)
+SYSCALL(sys_sched_getscheduler,sys_sched_getscheduler)
 SYSCALL(sys_sched_yield,sys_sched_yield)
-SYSCALL(sys_sched_get_priority_max,compat_sys_sched_get_priority_max)
-SYSCALL(sys_sched_get_priority_min,compat_sys_sched_get_priority_min)	/* 160 */
+SYSCALL(sys_sched_get_priority_max,sys_sched_get_priority_max)
+SYSCALL(sys_sched_get_priority_min,sys_sched_get_priority_min)	/* 160 */
 SYSCALL(sys_sched_rr_get_interval,compat_sys_sched_rr_get_interval)
 SYSCALL(sys_nanosleep,compat_sys_nanosleep)
 SYSCALL(sys_mremap,compat_sys_mremap)
@@ -211,20 +211,20 @@ SYSCALL(sys_getuid,sys_getuid)
 SYSCALL(sys_getgid,sys_getgid)				/* 200 */
 SYSCALL(sys_geteuid,sys_geteuid)
 SYSCALL(sys_getegid,sys_getegid)
-SYSCALL(sys_setreuid,compat_sys_setreuid)
-SYSCALL(sys_setregid,compat_sys_setregid)
+SYSCALL(sys_setreuid,sys_setreuid)
+SYSCALL(sys_setregid,sys_setregid)
 SYSCALL(sys_getgroups,compat_sys_getgroups)		/* 205 */
 SYSCALL(sys_setgroups,compat_sys_setgroups)
-SYSCALL(sys_fchown,compat_sys_fchown)
-SYSCALL(sys_setresuid,compat_sys_setresuid)
+SYSCALL(sys_fchown,sys_fchown)
+SYSCALL(sys_setresuid,sys_setresuid)
 SYSCALL(sys_getresuid,compat_sys_getresuid)
-SYSCALL(sys_setresgid,compat_sys_setresgid)		/* 210 */
+SYSCALL(sys_setresgid,sys_setresgid)			/* 210 */
 SYSCALL(sys_getresgid,compat_sys_getresgid)
 SYSCALL(sys_chown,compat_sys_chown)
-SYSCALL(sys_setuid,compat_sys_setuid)
-SYSCALL(sys_setgid,compat_sys_setgid)
-SYSCALL(sys_setfsuid,compat_sys_setfsuid)		/* 215 */
-SYSCALL(sys_setfsgid,compat_sys_setfsgid)
+SYSCALL(sys_setuid,sys_setuid)
+SYSCALL(sys_setgid,sys_setgid)
+SYSCALL(sys_setfsuid,sys_setfsuid)			/* 215 */
+SYSCALL(sys_setfsgid,sys_setfsgid)
 SYSCALL(sys_pivot_root,compat_sys_pivot_root)
 SYSCALL(sys_mincore,compat_sys_mincore)
 SYSCALL(sys_madvise,compat_sys_madvise)
@@ -245,19 +245,19 @@ SYSCALL(sys_removexattr,compat_sys_removexattr)
 SYSCALL(sys_lremovexattr,compat_sys_lremovexattr)
 SYSCALL(sys_fremovexattr,compat_sys_fremovexattr)	/* 235 */
 SYSCALL(sys_gettid,sys_gettid)
-SYSCALL(sys_tkill,compat_sys_tkill)
+SYSCALL(sys_tkill,sys_tkill)
 SYSCALL(sys_futex,compat_sys_futex)
 SYSCALL(sys_sched_setaffinity,compat_sys_sched_setaffinity)
 SYSCALL(sys_sched_getaffinity,compat_sys_sched_getaffinity)	/* 240 */
-SYSCALL(sys_tgkill,compat_sys_tgkill)
+SYSCALL(sys_tgkill,sys_tgkill)
 NI_SYSCALL						/* reserved for TUX */
 SYSCALL(sys_io_setup,compat_sys_io_setup)
 SYSCALL(sys_io_destroy,compat_sys_io_destroy)
 SYSCALL(sys_io_getevents,compat_sys_io_getevents)	/* 245 */
 SYSCALL(sys_io_submit,compat_sys_io_submit)
 SYSCALL(sys_io_cancel,compat_sys_io_cancel)
-SYSCALL(sys_exit_group,compat_sys_exit_group)
-SYSCALL(sys_epoll_create,compat_sys_epoll_create)
+SYSCALL(sys_exit_group,sys_exit_group)
+SYSCALL(sys_epoll_create,sys_epoll_create)
 SYSCALL(sys_epoll_ctl,compat_sys_epoll_ctl)		/* 250 */
 SYSCALL(sys_epoll_wait,compat_sys_epoll_wait)
 SYSCALL(sys_set_tid_address,compat_sys_set_tid_address)
@@ -265,8 +265,8 @@ SYSCALL(sys_fadvise64_64,compat_sys_s390_fadvise64)
 SYSCALL(sys_timer_create,compat_sys_timer_create)
 SYSCALL(sys_timer_settime,compat_sys_timer_settime)	/* 255 */
 SYSCALL(sys_timer_gettime,compat_sys_timer_gettime)
-SYSCALL(sys_timer_getoverrun,compat_sys_timer_getoverrun)
-SYSCALL(sys_timer_delete,compat_sys_timer_delete)
+SYSCALL(sys_timer_getoverrun,sys_timer_getoverrun)
+SYSCALL(sys_timer_delete,sys_timer_delete)
 SYSCALL(sys_clock_settime,compat_sys_clock_settime)
 SYSCALL(sys_clock_gettime,compat_sys_clock_gettime)	/* 260 */
 SYSCALL(sys_clock_getres,compat_sys_clock_getres)
@@ -290,11 +290,11 @@ SYSCALL(sys_add_key,compat_sys_add_key)
 SYSCALL(sys_request_key,compat_sys_request_key)
 SYSCALL(sys_keyctl,compat_sys_keyctl)			/* 280 */
 SYSCALL(sys_waitid,compat_sys_waitid)
-SYSCALL(sys_ioprio_set,compat_sys_ioprio_set)
-SYSCALL(sys_ioprio_get,compat_sys_ioprio_get)
+SYSCALL(sys_ioprio_set,sys_ioprio_set)
+SYSCALL(sys_ioprio_get,sys_ioprio_get)
 SYSCALL(sys_inotify_init,sys_inotify_init)
 SYSCALL(sys_inotify_add_watch,compat_sys_inotify_add_watch)	/* 285 */
-SYSCALL(sys_inotify_rm_watch,compat_sys_inotify_rm_watch)
+SYSCALL(sys_inotify_rm_watch,sys_inotify_rm_watch)
 SYSCALL(sys_migrate_pages,compat_sys_migrate_pages)
 SYSCALL(sys_openat,compat_sys_openat)
 SYSCALL(sys_mkdirat,compat_sys_mkdirat)
@@ -326,31 +326,31 @@ SYSCALL(sys_fallocate,compat_sys_s390_fallocate)
 SYSCALL(sys_utimensat,compat_sys_utimensat)		/* 315 */
 SYSCALL(sys_signalfd,compat_sys_signalfd)
 NI_SYSCALL						/* 317 old sys_timer_fd */
-SYSCALL(sys_eventfd,compat_sys_eventfd)
-SYSCALL(sys_timerfd_create,compat_sys_timerfd_create)
+SYSCALL(sys_eventfd,sys_eventfd)
+SYSCALL(sys_timerfd_create,sys_timerfd_create)
 SYSCALL(sys_timerfd_settime,compat_sys_timerfd_settime) /* 320 */
 SYSCALL(sys_timerfd_gettime,compat_sys_timerfd_gettime)
 SYSCALL(sys_signalfd4,compat_sys_signalfd4)
-SYSCALL(sys_eventfd2,compat_sys_eventfd2)
-SYSCALL(sys_inotify_init1,compat_sys_inotify_init1)
+SYSCALL(sys_eventfd2,sys_eventfd2)
+SYSCALL(sys_inotify_init1,sys_inotify_init1)
 SYSCALL(sys_pipe2,compat_sys_pipe2)			/* 325 */
-SYSCALL(sys_dup3,compat_sys_dup3)
-SYSCALL(sys_epoll_create1,compat_sys_epoll_create1)
+SYSCALL(sys_dup3,sys_dup3)
+SYSCALL(sys_epoll_create1,sys_epoll_create1)
 SYSCALL(sys_preadv,compat_sys_preadv)
 SYSCALL(sys_pwritev,compat_sys_pwritev)
 SYSCALL(sys_rt_tgsigqueueinfo,compat_sys_rt_tgsigqueueinfo) /* 330 */
 SYSCALL(sys_perf_event_open,compat_sys_perf_event_open)
-SYSCALL(sys_fanotify_init,compat_sys_fanotify_init)
+SYSCALL(sys_fanotify_init,sys_fanotify_init)
 SYSCALL(sys_fanotify_mark,compat_sys_fanotify_mark)
 SYSCALL(sys_prlimit64,compat_sys_prlimit64)
 SYSCALL(sys_name_to_handle_at,compat_sys_name_to_handle_at) /* 335 */
 SYSCALL(sys_open_by_handle_at,compat_sys_open_by_handle_at)
 SYSCALL(sys_clock_adjtime,compat_sys_clock_adjtime)
-SYSCALL(sys_syncfs,compat_sys_syncfs)
-SYSCALL(sys_setns,compat_sys_setns)
+SYSCALL(sys_syncfs,sys_syncfs)
+SYSCALL(sys_setns,sys_setns)
 SYSCALL(sys_process_vm_readv,compat_sys_process_vm_readv) /* 340 */
 SYSCALL(sys_process_vm_writev,compat_sys_process_vm_writev)
-SYSCALL(sys_s390_runtime_instr,compat_sys_s390_runtime_instr)
+SYSCALL(sys_s390_runtime_instr,sys_s390_runtime_instr)
 SYSCALL(sys_kcmp,compat_sys_kcmp)
 SYSCALL(sys_finit_module,compat_sys_finit_module)
 SYSCALL(sys_sched_setattr,compat_sys_sched_setattr)	/* 345 */
@@ -363,3 +363,22 @@ SYSCALL(sys_bpf,compat_sys_bpf)
 SYSCALL(sys_s390_pci_mmio_write,compat_sys_s390_pci_mmio_write)
 SYSCALL(sys_s390_pci_mmio_read,compat_sys_s390_pci_mmio_read)
 SYSCALL(sys_execveat,compat_sys_execveat)
+SYSCALL(sys_userfaultfd,sys_userfaultfd)		/* 355 */
+SYSCALL(sys_membarrier,sys_membarrier)
+SYSCALL(sys_recvmmsg,compat_sys_recvmmsg)
+SYSCALL(sys_sendmmsg,compat_sys_sendmmsg)
+SYSCALL(sys_socket,sys_socket)
+SYSCALL(sys_socketpair,compat_sys_socketpair)		/* 360 */
+SYSCALL(sys_bind,sys_bind)
+SYSCALL(sys_connect,sys_connect)
+SYSCALL(sys_listen,sys_listen)
+SYSCALL(sys_accept4,sys_accept4)
+SYSCALL(sys_getsockopt,compat_sys_getsockopt)		/* 365 */
+SYSCALL(sys_setsockopt,compat_sys_setsockopt)
+SYSCALL(sys_getsockname,compat_sys_getsockname)
+SYSCALL(sys_getpeername,compat_sys_getpeername)
+SYSCALL(sys_sendto,compat_sys_sendto)
+SYSCALL(sys_sendmsg,compat_sys_sendmsg)			/* 370 */
+SYSCALL(sys_recvfrom,compat_sys_recvfrom)
+SYSCALL(sys_recvmsg,compat_sys_recvmsg)
+SYSCALL(sys_shutdown,sys_shutdown)
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index b9ce650..c865343 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -89,17 +89,21 @@ static int do_account_vtime(struct task_struct *tsk, int hardirq_offset)
 	if (smp_cpu_mtid &&
 	    time_after64(jiffies_64, __this_cpu_read(mt_scaling_jiffies))) {
 		u64 cycles_new[32], *cycles_old;
-		u64 delta, mult, div;
+		u64 delta, fac, mult, div;
 
 		cycles_old = this_cpu_ptr(mt_cycles);
 		if (stcctm5(smp_cpu_mtid + 1, cycles_new) < 2) {
+			fac = 1;
 			mult = div = 0;
 			for (i = 0; i <= smp_cpu_mtid; i++) {
 				delta = cycles_new[i] - cycles_old[i];
-				mult += delta;
-				div += (i + 1) * delta;
+				div += delta;
+				mult *= i + 1;
+				mult += delta * fac;
+				fac *= i + 1;
 			}
-			if (mult > 0) {
+			div *= fac;
+			if (div > 0) {
 				/* Update scaling factor */
 				__this_cpu_write(mt_scaling_mult, mult);
 				__this_cpu_write(mt_scaling_div, div);
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 2c7cca6..7c1d958 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -72,6 +72,8 @@
 #define __NR_userfaultfd 374
 #elif defined(__powewrpc__)
 #define __NR_userfaultfd 364
+#elif defined(__s390__)
+#define __NR_userfaultfd 355
 #else
 #error "missing __NR_userfaultfd definition"
 #endif
