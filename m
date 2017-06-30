From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 18:31:36 +0000
Subject: [CRIU][PATCH v3 01/15] s390:compel/arch/s390: Add architecture support to compel tool and libraries
Message-Id: <20170630183150.76021-2-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch only adds the support but does not enable it for building.

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 compel/arch/s390/plugins/include/asm/prologue.h    |   1 +
 .../arch/s390/plugins/include/asm/syscall-types.h  |  34 ++
 compel/arch/s390/plugins/std/parasite-head.S       |  26 +
 .../s390/plugins/std/syscalls/Makefile.syscalls    |  58 +++
 .../plugins/std/syscalls/syscall-common-s390.S     |  37 ++
 .../s390/plugins/std/syscalls/syscall-s390.tbl     | 108 ++++
 .../arch/s390/plugins/std/syscalls/syscalls-s390.c |  26 +
 compel/arch/s390/scripts/compel-pack.lds.S         |  40 ++
 compel/arch/s390/src/lib/cpu.c                     |  42 ++
 compel/arch/s390/src/lib/handle-elf-host.c         |   1 +
 compel/arch/s390/src/lib/handle-elf.c              |  22 +
 compel/arch/s390/src/lib/include/handle-elf.h      |  13 +
 compel/arch/s390/src/lib/include/syscall.h         |   8 +
 .../s390/src/lib/include/uapi/asm/breakpoints.h    |  15 +
 compel/arch/s390/src/lib/include/uapi/asm/cpu.h    |  10 +
 compel/arch/s390/src/lib/include/uapi/asm/fpu.h    |  14 +
 .../s390/src/lib/include/uapi/asm/infect-types.h   |  75 +++
 .../arch/s390/src/lib/include/uapi/asm/sigframe.h  |  75 +++
 compel/arch/s390/src/lib/infect.c                  | 559 +++++++++++++++++++++
 include/common/arch/s390/asm/atomic.h              |  67 +++
 include/common/arch/s390/asm/atomic_ops.h          |  74 +++
 include/common/arch/s390/asm/bitops.h              | 164 ++++++
 include/common/arch/s390/asm/bitsperlong.h         |   6 +
 include/common/arch/s390/asm/linkage.h             |  22 +
 include/common/arch/s390/asm/page.h                |  19 +
 25 files changed, 1516 insertions(+)
 create mode 120000 compel/arch/s390/plugins/include/asm/prologue.h
 create mode 100644 compel/arch/s390/plugins/include/asm/syscall-types.h
 create mode 100644 compel/arch/s390/plugins/std/parasite-head.S
 create mode 100644 compel/arch/s390/plugins/std/syscalls/Makefile.syscalls
 create mode 100644 compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S
 create mode 100644 compel/arch/s390/plugins/std/syscalls/syscall-s390.tbl
 create mode 100644 compel/arch/s390/plugins/std/syscalls/syscalls-s390.c
 create mode 100644 compel/arch/s390/scripts/compel-pack.lds.S
 create mode 100644 compel/arch/s390/src/lib/cpu.c
 create mode 120000 compel/arch/s390/src/lib/handle-elf-host.c
 create mode 100644 compel/arch/s390/src/lib/handle-elf.c
 create mode 100644 compel/arch/s390/src/lib/include/handle-elf.h
 create mode 100644 compel/arch/s390/src/lib/include/syscall.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/breakpoints.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/cpu.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/fpu.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/infect-types.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/sigframe.h
 create mode 100644 compel/arch/s390/src/lib/infect.c
 create mode 100644 include/common/arch/s390/asm/atomic.h
 create mode 100644 include/common/arch/s390/asm/atomic_ops.h
 create mode 100644 include/common/arch/s390/asm/bitops.h
 create mode 100644 include/common/arch/s390/asm/bitsperlong.h
 create mode 100644 include/common/arch/s390/asm/linkage.h
 create mode 100644 include/common/arch/s390/asm/page.h

diff --git a/compel/arch/s390/plugins/include/asm/prologue.h b/compel/arch/s390/plugins/include/asm/prologue.h
new file mode 120000
index 0000000..e0275e3
--- /dev/null
+++ b/compel/arch/s390/plugins/include/asm/prologue.h
@@ -0,0 +1 @@
+../../../../../arch/x86/plugins/include/asm/prologue.h
\ No newline at end of file
diff --git a/compel/arch/s390/plugins/include/asm/syscall-types.h b/compel/arch/s390/plugins/include/asm/syscall-types.h
new file mode 100644
index 0000000..55d7ddb
--- /dev/null
+++ b/compel/arch/s390/plugins/include/asm/syscall-types.h
@@ -0,0 +1,34 @@
+#ifndef COMPEL_ARCH_SYSCALL_TYPES_H__
+#define COMPEL_ARCH_SYSCALL_TYPES_H__
+
+#define SA_RESTORER     0x04000000U
+
+typedef void rt_signalfn_t(int, siginfo_t *, void *);
+typedef rt_signalfn_t *rt_sighandler_t;
+
+typedef void rt_restorefn_t(void);
+typedef rt_restorefn_t *rt_sigrestore_t;
+
+#define _KNSIG		64
+#define _NSIG_BPW	64
+
+#define _KNSIG_WORDS	(_KNSIG / _NSIG_BPW)
+
+typedef struct {
+	unsigned long	sig[_KNSIG_WORDS];
+} k_rtsigset_t;
+
+/*
+ * Used for rt_sigaction() system call - see kernel "struct sigaction" in
+ * include/linux/signal.h.
+ */
+typedef struct {
+	rt_sighandler_t	rt_sa_handler;
+	unsigned long	rt_sa_flags;
+	rt_sigrestore_t	rt_sa_restorer;
+	k_rtsigset_t	rt_sa_mask;
+} rt_sigaction_t;
+
+struct mmap_arg_struct;
+
+#endif /* COMPEL_ARCH_SYSCALL_TYPES_H__ */
diff --git a/compel/arch/s390/plugins/std/parasite-head.S b/compel/arch/s390/plugins/std/parasite-head.S
new file mode 100644
index 0000000..f4cb372
--- /dev/null
+++ b/compel/arch/s390/plugins/std/parasite-head.S
@@ -0,0 +1,26 @@
+#include "common/asm/linkage.h"
+
+	.section .head.text, "ax"
+
+/*
+ * Entry point for parasite_service()
+ *
+ * Addresses of symbols are exported in auto-generated criu/pie/parasite-blob.h
+ *
+ * Function is called via parasite_run(). The command for parasite_service()
+ * is stored in global variable __export_parasite_cmd.
+ *
+ * Load parameters for parasite_service(unsigned int cmd, void *args):
+ *
+ *  - Parameter 1 (cmd) : %r2 = *(uint32 *)(__export_parasite_cmd + pc)
+ *  - Parameter 2 (args): %r3 = __export_parasite_args + pc
+ */
+ENTRY(__export_parasite_head_start)
+	larl	%r14,__export_parasite_cmd
+	llgf	%r2,0(%r14)
+	larl	%r3,__export_parasite_args
+	brasl	%r14,parasite_service
+	.long 0x00010001	/* S390_BREAKPOINT_U16: Generates SIGTRAP */
+__export_parasite_cmd:
+	.long 0
+END(__export_parasite_head_start)
diff --git a/compel/arch/s390/plugins/std/syscalls/Makefile.syscalls b/compel/arch/s390/plugins/std/syscalls/Makefile.syscalls
new file mode 100644
index 0000000..f03b7cc
--- /dev/null
+++ b/compel/arch/s390/plugins/std/syscalls/Makefile.syscalls
@@ -0,0 +1,58 @@
+ccflags-y		+= -iquote $(PLUGIN_ARCH_DIR)/std/syscalls/
+asflags-y		+= -iquote $(PLUGIN_ARCH_DIR)/std/syscalls/
+
+sys-types		:= $(obj)/include/uapi/std/syscall-types.h
+sys-codes		:= $(obj)/include/uapi/std/syscall-codes.h
+sys-proto		:= $(obj)/include/uapi/std/syscall.h
+
+sys-def			:= $(PLUGIN_ARCH_DIR)/std/syscalls/syscall-s390.tbl
+sys-asm-common-name	:= std/syscalls/syscall-common-s390.S
+sys-asm-common		:= $(PLUGIN_ARCH_DIR)/$(sys-asm-common-name)
+sys-asm-types		:= $(obj)/include/uapi/std/asm/syscall-types.h
+sys-exec-tbl		 = $(PLUGIN_ARCH_DIR)/std/sys-exec-tbl.c
+
+sys-asm			:= ./$(PLUGIN_ARCH_DIR)/std/syscalls/syscalls.S
+std-lib-y		+= $(sys-asm:.S=).o
+std-lib-y		+= ./$(PLUGIN_ARCH_DIR)/std/syscalls/syscalls-s390.o
+
+$(sys-codes): $(sys-def)
+	$(E) "  GEN     " $@
+	$(Q) echo "/* Autogenerated, don't edit */"							>  $@
+	$(Q) echo "#ifndef __ASM_CR_SYSCALL_CODES_H__"							>> $@
+	$(Q) echo "#define __ASM_CR_SYSCALL_CODES_H__"							>> $@
+	$(Q) cat $< | awk '/^__NR/{SYSN=$$1; sub("^__NR", "SYS", SYSN);'\
+	'print "\n#ifndef ", $$1, "\n#define", $$1, $$2, "\n#endif";'\
+	'print "#ifndef ", SYSN, "\n#define ", SYSN, $$1, "\n#endif"}'					>> $@
+	$(Q) echo "#endif /* __ASM_CR_SYSCALL_CODES_H__ */"						>> $@
+
+$(sys-proto): $(sys-def)
+	$(E) "  GEN     " $@
+	$(Q) echo "/* Autogenerated, don't edit */"							>  $@
+	$(Q) echo "#ifndef __ASM_CR_SYSCALL_PROTO_H__"							>> $@
+	$(Q) echo "#define __ASM_CR_SYSCALL_PROTO_H__"							>> $@
+	$(Q) echo "#include <compel/plugins/std/syscall-codes.h>"					>> $@
+	$(Q) echo "#include <compel/plugins/std/syscall-types.h>"					>> $@
+	$(Q) cat $< | awk  '/^__NR/{print "extern long", $$3, substr($$0, index($$0,$$4)), ";"}'	>> $@
+	$(Q) echo "#endif /* __ASM_CR_SYSCALL_PROTO_H__ */"						>> $@
+
+$(sys-asm): $(sys-def) $(sys-asm-common) $(sys-codes) $(sys-proto)
+	$(E) "  GEN     " $@
+	$(Q) echo "/* Autogenerated, don't edit */"							>  $@
+	$(Q) echo "#include <compel/plugins/std/syscall-codes.h>"						>> $@
+	$(Q) echo "#include \"$(sys-asm-common-name)\""							>> $@
+	$(Q) cat $< | awk '/^__NR/{print "SYSCALL(", $$3, ",", $$2, ")"}'				>> $@
+
+$(sys-exec-tbl): $(sys-def) $(sys-codes) $(sys-proto)
+	$(E) "  GEN     " $@
+	$(Q) echo "/* Autogenerated, don't edit */"							>  $@
+	$(Q) echo "static struct syscall_exec_desc sc_exec_table[] = {"					>> $@
+	$(Q) cat $< | awk '/^__NR/{print "SYSCALL(", substr($$3, 5), ",", $$2, ")"}'			>> $@
+	$(Q) echo "	{ }, /* terminator */"								>> $@
+	$(Q) echo "};"											>> $@
+
+$(sys-asm-types): $(PLUGIN_ARCH_DIR)/include/asm/syscall-types.h
+	$(call msg-gen, $@)
+	$(Q) ln -s ../../../../../../$(PLUGIN_ARCH_DIR)/include/asm/syscall-types.h $(sys-asm-types)
+
+std-headers-deps	+= $(sys-asm) $(sys-codes) $(sys-proto) $(sys-asm-types)
+mrproper-y		+= $(std-headers-deps)
diff --git a/compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S b/compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S
new file mode 100644
index 0000000..79e3b8e
--- /dev/null
+++ b/compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S
@@ -0,0 +1,37 @@
+#include "common/asm/linkage.h"
+
+/*
+ * Define a system call
+ *
+ * C-ABI on s390:
+ * - Parameters 1-5 are passed in %r2-%r6
+ * - Parameter 6 is passed on the stack 160(%r15)
+ * - Return value is in %r2
+ * - Return address is in %r14
+ * - Registers %r0-%r6,%r14 are call-clobbered
+ * - Registers %r7-%r13,%r15 are call-saved
+ *
+ * SVC ABI on s390:
+ * - For SVC 0 the system call number is passed in %r1
+ * - Parameters 1-6 are passed in %r2-%r7
+ * - Return value is passed in %r2
+ * - Besides of %r2 all registers are call-saved
+ */
+#define SYSCALL(name, opcode)						\
+ENTRY(name);								\
+	lgr	%r0,%r7;		/* Save %r7 */			\
+	lg	%r7,160(%r15);		/* Load 6th parameter */	\
+	lghi	%r1,opcode;		/* Load SVC number */		\
+	svc	0;			/* Issue SVC 0 */		\
+	lgr	%r7,%r0;		/* Restore %r7 */		\
+	br	%r14;			/* Return to caller */		\
+END(name)								\
+
+/*
+ * Issue rt_sigreturn system call for sa_restorer
+ */
+ENTRY(__cr_restore_rt)
+	lghi	%r1,__NR_rt_sigreturn
+	svc	0
+END(__cr_restore_rt)
+
diff --git a/compel/arch/s390/plugins/std/syscalls/syscall-s390.tbl b/compel/arch/s390/plugins/std/syscalls/syscall-s390.tbl
new file mode 100644
index 0000000..1670450
--- /dev/null
+++ b/compel/arch/s390/plugins/std/syscalls/syscall-s390.tbl
@@ -0,0 +1,108 @@
+#
+# System calls table, please make sure the table consists of only the syscalls
+# really used somewhere in the project.
+#
+# The template is (name and arguments are optional if you need only __NR_x
+# defined, but no real entry point in syscalls lib).
+#
+# name			code		name			arguments
+# -----------------------------------------------------------------------
+#
+__NR_read		3		sys_read		(int fd, void *buf, unsigned long count)
+__NR_write		4		sys_write		(int fd, const void *buf, unsigned long count)
+__NR_open		5		sys_open		(const char *filename, unsigned long flags, unsigned long mode)
+__NR_close		6		sys_close		(int fd)
+__NR_lseek		19		sys_lseek		(int fd, unsigned long offset, unsigned long origin)
+__NR_mmap		90		sys_old_mmap		(struct mmap_arg_struct *)
+__NR_mprotect		125		sys_mprotect		(const void *addr, unsigned long len, unsigned long prot)
+__NR_munmap		91		sys_munmap		(void *addr, unsigned long len)
+__NR_brk		45		sys_brk			(void *addr)
+__NR_rt_sigaction	174		sys_sigaction		(int signum, const rt_sigaction_t *act, rt_sigaction_t *oldact, size_t sigsetsize)
+__NR_rt_sigprocmask	175		sys_sigprocmask		(int how, k_rtsigset_t *set, k_rtsigset_t *old, size_t sigsetsize)
+__NR_rt_sigreturn	173		sys_rt_sigreturn	(void)
+__NR_ioctl		54		sys_ioctl		(unsigned int fd, unsigned int cmd, unsigned long arg)
+__NR_pread64		180		sys_pread		(unsigned int fd, char *buf, size_t count, loff_t pos)
+__NR_ptrace		26		sys_ptrace		(long request, pid_t pid, void *addr, void *data)
+__NR_mremap		163		sys_mremap		(unsigned long addr, unsigned long old_len, unsigned long new_len, unsigned long flags, unsigned long new_addr)
+__NR_mincore		218		sys_mincore		(void *addr, unsigned long size, unsigned char *vec)
+__NR_madvise		219		sys_madvise		(unsigned long start, size_t len, int behavior)
+__NR_pause		29		sys_pause		(void)
+__NR_nanosleep		162		sys_nanosleep		(struct timespec *req, struct timespec *rem)
+__NR_getitimer		105		sys_getitimer		(int which, const struct itimerval *val)
+__NR_setitimer		104		sys_setitimer		(int which, const struct itimerval *val, struct itimerval *old)
+__NR_getpid		20		sys_getpid		(void)
+__NR_socket		359		sys_socket		(int domain, int type, int protocol)
+__NR_connect		362		sys_connect		(int sockfd, struct sockaddr *addr, int addrlen)
+__NR_sendto		369		sys_sendto		(int sockfd, void *buff, size_t len, unsigned int flags, struct sockaddr *addr, int addr_len)
+__NR_recvfrom		371		sys_recvfrom		(int sockfd, void *ubuf, size_t size, unsigned int flags, struct sockaddr *addr, int *addr_len)
+__NR_sendmsg		370		sys_sendmsg		(int sockfd, const struct msghdr *msg, int flags)
+__NR_recvmsg		372		sys_recvmsg		(int sockfd, struct msghdr *msg, int flags)
+__NR_shutdown		373		sys_shutdown		(int sockfd, int how)
+__NR_bind		361		sys_bind		(int sockfd, const struct sockaddr *addr, int addrlen)
+__NR_setsockopt		366		sys_setsockopt		(int sockfd, int level, int optname, const void *optval, socklen_t optlen)
+__NR_getsockopt		365		sys_getsockopt		(int sockfd, int level, int optname, const void *optval, socklen_t *optlen)
+__NR_clone		120		sys_clone		(unsigned long flags, void *child_stack, void *parent_tid, void *child_tid, void *tls)
+__NR_exit		1		sys_exit		(unsigned long error_code)
+__NR_wait4		114		sys_wait4		(int pid, int *status, int options, struct rusage *ru)
+__NR_kill		37		sys_kill		(long pid, int sig)
+__NR_fcntl		55		sys_fcntl		(int fd, int type, long arg)
+__NR_flock		143		sys_flock		(int fd, unsigned long cmd)
+__NR_mkdir		39		sys_mkdir		(const char *name, int mode)
+__NR_rmdir		40		sys_rmdir		(const char *name)
+__NR_unlink		10		sys_unlink		(char *pathname)
+__NR_readlinkat		298		sys_readlinkat		(int fd, const char *path, char *buf, int bufsize)
+__NR_umask		60		sys_umask		(int mask)
+__NR_getgroups		205		sys_getgroups		(int gsize, unsigned int *groups)
+__NR_setgroups		206		sys_setgroups		(int gsize, unsigned int *groups)
+__NR_setresuid		208		sys_setresuid		(int uid, int euid, int suid)
+__NR_getresuid		209		sys_getresuid		(int *uid, int *euid, int *suid)
+__NR_setresgid		210		sys_setresgid		(int gid, int egid, int sgid)
+__NR_getresgid		211		sys_getresgid		(int *gid, int *egid, int *sgid)
+__NR_getpgid		132		sys_getpgid		(pid_t pid)
+__NR_setfsuid		215		sys_setfsuid		(int fsuid)
+__NR_setfsgid		216		sys_setfsgid		(int fsgid)
+__NR_getsid		147		sys_getsid		(void)
+__NR_capget		184		sys_capget		(struct cap_header *h, struct cap_data *d)
+__NR_capset		185		sys_capset		(struct cap_header *h, struct cap_data *d)
+__NR_rt_sigqueueinfo	178		sys_rt_sigqueueinfo	(pid_t pid, int sig, siginfo_t *info)
+__NR_sigaltstack	186		sys_sigaltstack		(const void *uss, void *uoss)
+__NR_personality	136		sys_personality		(unsigned int personality)
+__NR_setpriority	97		sys_setpriority		(int which, int who, int nice)
+__NR_sched_setscheduler	156		sys_sched_setscheduler	(int pid, int policy, struct sched_param *p)
+__NR_prctl		172		sys_prctl		(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5)
+__NR_setrlimit		75		sys_setrlimit		(int resource, struct krlimit *rlim)
+__NR_mount		21		sys_mount		(char *dev_nmae, char *dir_name, char *type, unsigned long flags, void *data)
+__NR_umount2		52		sys_umount2		(char *name, int flags)
+__NR_gettid		236		sys_gettid		(void)
+__NR_futex		238		sys_futex		(uint32_t *uaddr, int op, uint32_t val, struct timespec *utime, uint32_t *uaddr2, uint32_t val3)
+__NR_set_tid_address	252		sys_set_tid_address	(int *tid_addr)
+__NR_restart_syscall	7		sys_restart_syscall	(void)
+__NR_sys_timer_create	254		sys_timer_create	(clockid_t which_clock, struct sigevent *timer_event_spec, kernel_timer_t *created_timer_id)
+__NR_sys_timer_settime	255		sys_timer_settime	(kernel_timer_t timer_id, int flags, const struct itimerspec *new_setting, struct itimerspec *old_setting)
+__NR_sys_timer_gettime	256		sys_timer_gettime	(int timer_id, const struct itimerspec *setting)
+__NR_sys_timer_getoverrun	257		sys_timer_getoverrun	(int timer_id)
+__NR_sys_timer_delete	258		sys_timer_delete	(kernel_timer_t timer_id)
+__NR_clock_gettime	260		sys_clock_gettime	(const clockid_t which_clock, const struct timespec *tp)
+__NR_exit_group		248		sys_exit_group		(int error_code)
+__NR_waitid		281		sys_waitid		(int which, pid_t pid, struct siginfo *infop, int options, struct rusage *ru)
+__NR_set_robust_list	304		sys_set_robust_list	(struct robust_list_head *head, size_t len)
+__NR_get_robust_list	305		sys_get_robust_list	(int pid, struct robust_list_head **head_ptr, size_t *len_ptr)
+__NR_vmsplice		309		sys_vmsplice		(int fd, const struct iovec *iov, unsigned long nr_segs, unsigned int flags)
+__NR_openat		288		sys_openat		(int dfd, const char *filename, int flags, int mode)
+__NR_timerfd_settime	320		sys_timerfd_settime	(int ufd, int flags, const struct itimerspec *utmr, struct itimerspec *otmr)
+__NR_signalfd4		322		sys_signalfd		(int fd, k_rtsigset_t *mask, size_t sizemask, int flags)
+__NR_rt_tgsigqueueinfo	330		sys_rt_tgsigqueueinfo	(pid_t tgid, pid_t pid, int sig, siginfo_t *info)
+__NR_fanotify_init	332		sys_fanotify_init	(unsigned int flags, unsigned int event_f_flags)
+__NR_fanotify_mark	333		sys_fanotify_mark	(int fanotify_fd, unsigned int flags, uint64_t mask, int dfd, const char *pathname)
+__NR_open_by_handle_at	336		sys_open_by_handle_at	(int mountdirfd, struct file_handle *handle, int flags)
+__NR_setns		339		sys_setns		(int fd, int nstype)
+__NR_kcmp		343		sys_kcmp		(pid_t pid1, pid_t pid2, int type, unsigned long idx1, unsigned long idx2)
+__NR_seccomp		348		sys_seccomp		(unsigned int op, unsigned int flags, const char *uargs)
+__NR_memfd_create	350		sys_memfd_create	(const char *name, unsigned int flags)
+__NR_io_setup		243		sys_io_setup		(unsigned nr_events, aio_context_t *ctx_idp)
+__NR_io_getevents	245		sys_io_getevents	(aio_context_t ctx_id, long min_nr, long nr, struct io_event *events, struct timespec *timeout)
+__NR_io_submit		246		sys_io_submit		(aio_context_t ctx_id, long nr, struct iocb **iocbpp)
+__NR_ipc		117		sys_ipc			(unsigned int call, int first, unsigned long second, unsigned long third, const void *ptr, long fifth)
+__NR_userfaultfd	355		sys_userfaultfd		(int flags)
+__NR_preadv		328		sys_preadv		(int fd, struct iovec *iov, unsigned long nr, loff_t off)
+__NR_gettimeofday	78		sys_gettimeofday	(struct timeval *tv, struct timezone *tz)
diff --git a/compel/arch/s390/plugins/std/syscalls/syscalls-s390.c b/compel/arch/s390/plugins/std/syscalls/syscalls-s390.c
new file mode 100644
index 0000000..2b35cca
--- /dev/null
+++ b/compel/arch/s390/plugins/std/syscalls/syscalls-s390.c
@@ -0,0 +1,26 @@
+#include "asm/infect-types.h"
+
+/*
+ * Define prototype because of compile error if we include uapi/std/syscall.h
+ */
+long sys_old_mmap (struct mmap_arg_struct *);
+
+/*
+ * On s390 we have defined __ARCH_WANT_SYS_OLD_MMAP - Therefore implement
+ * system call with one parameter "mmap_arg_struct".
+ */
+unsigned long sys_mmap(void *addr, unsigned long len, unsigned long prot,
+		       unsigned long flags, unsigned long fd,
+		       unsigned long offset)
+{
+	struct mmap_arg_struct arg_struct;
+
+	arg_struct.addr = (unsigned long)addr;
+	arg_struct.len = len;
+	arg_struct.prot = prot;
+	arg_struct.flags = flags;
+	arg_struct.fd = fd;
+	arg_struct.offset = offset;
+
+	return sys_old_mmap(&arg_struct);
+}
diff --git a/compel/arch/s390/scripts/compel-pack.lds.S b/compel/arch/s390/scripts/compel-pack.lds.S
new file mode 100644
index 0000000..91ffbda
--- /dev/null
+++ b/compel/arch/s390/scripts/compel-pack.lds.S
@@ -0,0 +1,40 @@
+OUTPUT_ARCH(s390:64-bit)
+EXTERN(__export_parasite_head_start)
+
+SECTIONS
+{
+	.text : {
+		*(.head.text)
+		ASSERT(DEFINED(__export_parasite_head_start),
+			"Symbol __export_parasite_head_start is missing");
+		*(.text*)
+		*(.compel.exit)
+		*(.compel.init)
+	}
+
+	.data : {
+		*(.data*)
+		*(.bss*)
+	}
+
+	.rodata : {
+		*(.rodata*)
+		*(.got*)
+	}
+
+	.toc : ALIGN(8) {
+		*(.toc*)
+	}
+
+	/DISCARD/ : {
+		*(.debug*)
+		*(.comment*)
+		*(.note*)
+		*(.group*)
+		*(.eh_frame*)
+	}
+
+/* Parasite args should have 4 bytes align, as we have futex inside. */
+. = ALIGN(4);
+__export_parasite_args = .;
+}
diff --git a/compel/arch/s390/src/lib/cpu.c b/compel/arch/s390/src/lib/cpu.c
new file mode 100644
index 0000000..174575f
--- /dev/null
+++ b/compel/arch/s390/src/lib/cpu.c
@@ -0,0 +1,42 @@
+#include <sys/auxv.h>
+
+#include <string.h>
+#include <stdbool.h>
+
+#include "compel-cpu.h"
+#include "common/bitops.h"
+#include "common/compiler.h"
+
+#include "log.h"
+
+#undef	LOG_PREFIX
+#define LOG_PREFIX "cpu: "
+
+static compel_cpuinfo_t rt_info;
+static bool rt_info_done = false;
+
+void compel_set_cpu_cap(compel_cpuinfo_t *c, unsigned int feature) { }
+void compel_clear_cpu_cap(compel_cpuinfo_t *c, unsigned int feature) { }
+int compel_test_cpu_cap(compel_cpuinfo_t *c, unsigned int feature) { return 0; }
+
+int compel_cpuid(compel_cpuinfo_t *info)
+{
+	info->hwcap[0] = getauxval(AT_HWCAP);
+	info->hwcap[1] = getauxval(AT_HWCAP2);
+
+	if (!info->hwcap[0]) {
+		pr_err("Can't read the hardware capabilities");
+		return -1;
+	}
+
+	return 0;
+}
+
+bool cpu_has_feature(unsigned int feature)
+{
+	if (!rt_info_done) {
+		compel_cpuid(&rt_info);
+		rt_info_done = true;
+	}
+	return compel_test_cpu_cap(&rt_info, feature);
+}
diff --git a/compel/arch/s390/src/lib/handle-elf-host.c b/compel/arch/s390/src/lib/handle-elf-host.c
new file mode 120000
index 0000000..fe46118
--- /dev/null
+++ b/compel/arch/s390/src/lib/handle-elf-host.c
@@ -0,0 +1 @@
+handle-elf.c
\ No newline at end of file
diff --git a/compel/arch/s390/src/lib/handle-elf.c b/compel/arch/s390/src/lib/handle-elf.c
new file mode 100644
index 0000000..01a8bf4
--- /dev/null
+++ b/compel/arch/s390/src/lib/handle-elf.c
@@ -0,0 +1,22 @@
+#include <string.h>
+
+#include "uapi/compel.h"
+
+#include "handle-elf.h"
+#include "piegen.h"
+#include "log.h"
+
+static const unsigned char __maybe_unused
+elf_ident_64[EI_NIDENT] = {
+	0x7f, 0x45, 0x4c, 0x46, 0x02, 0x02, 0x01, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+int handle_binary(void *mem, size_t size)
+{
+	if (memcmp(mem, elf_ident_64, sizeof(elf_ident_64)) == 0)
+		return handle_elf_s390(mem, size);
+
+	pr_err("Unsupported Elf format detected\n");
+	return -EINVAL;
+}
diff --git a/compel/arch/s390/src/lib/include/handle-elf.h b/compel/arch/s390/src/lib/include/handle-elf.h
new file mode 100644
index 0000000..cd13574
--- /dev/null
+++ b/compel/arch/s390/src/lib/include/handle-elf.h
@@ -0,0 +1,13 @@
+#ifndef COMPEL_HANDLE_ELF_H__
+#define COMPEL_HANDLE_ELF_H__
+
+#include "elf64-types.h"
+
+#define ELF_S390
+
+#define __handle_elf				handle_elf_s390
+#define arch_is_machine_supported(e_machine)	(e_machine == EM_S390)
+
+int handle_elf_s390(void *mem, size_t size);
+
+#endif /* COMPEL_HANDLE_ELF_H__ */
diff --git a/compel/arch/s390/src/lib/include/syscall.h b/compel/arch/s390/src/lib/include/syscall.h
new file mode 100644
index 0000000..57d4912
--- /dev/null
+++ b/compel/arch/s390/src/lib/include/syscall.h
@@ -0,0 +1,8 @@
+#ifndef __COMPEL_SYSCALL_H__
+#define __COMPEL_SYSCALL_H__
+
+unsigned long sys_mmap(void *addr, unsigned long len, unsigned long prot,
+		       unsigned long flags, unsigned long fd,
+		       unsigned long offset);
+
+#endif
diff --git a/compel/arch/s390/src/lib/include/uapi/asm/breakpoints.h b/compel/arch/s390/src/lib/include/uapi/asm/breakpoints.h
new file mode 100644
index 0000000..5f09049
--- /dev/null
+++ b/compel/arch/s390/src/lib/include/uapi/asm/breakpoints.h
@@ -0,0 +1,15 @@
+#ifndef __COMPEL_BREAKPOINTS_H__
+#define __COMPEL_BREAKPOINTS_H__
+#define ARCH_SI_TRAP TRAP_BRKPT
+
+static inline int ptrace_set_breakpoint(pid_t pid, void *addr)
+{
+	return 0;
+}
+
+static inline int ptrace_flush_breakpoints(pid_t pid)
+{
+	return 0;
+}
+
+#endif
diff --git a/compel/arch/s390/src/lib/include/uapi/asm/cpu.h b/compel/arch/s390/src/lib/include/uapi/asm/cpu.h
new file mode 100644
index 0000000..b01db51
--- /dev/null
+++ b/compel/arch/s390/src/lib/include/uapi/asm/cpu.h
@@ -0,0 +1,10 @@
+#ifndef UAPI_COMPEL_ASM_CPU_H__
+#define UAPI_COMPEL_ASM_CPU_H__
+
+#include <stdint.h>
+
+typedef struct {
+	uint64_t		hwcap[2];
+} compel_cpuinfo_t;
+
+#endif /* __CR_ASM_CPU_H__ */
diff --git a/compel/arch/s390/src/lib/include/uapi/asm/fpu.h b/compel/arch/s390/src/lib/include/uapi/asm/fpu.h
new file mode 100644
index 0000000..49c9078
--- /dev/null
+++ b/compel/arch/s390/src/lib/include/uapi/asm/fpu.h
@@ -0,0 +1,14 @@
+#ifndef __CR_ASM_FPU_H__
+#define __CR_ASM_FPU_H__
+
+#include <sys/types.h>
+#include <stdbool.h>
+
+/*
+ * This one is used in restorer
+ */
+typedef struct {
+	bool has_fpu;
+} fpu_state_t;
+
+#endif /* __CR_ASM_FPU_H__ */
diff --git a/compel/arch/s390/src/lib/include/uapi/asm/infect-types.h b/compel/arch/s390/src/lib/include/uapi/asm/infect-types.h
new file mode 100644
index 0000000..84edea5
--- /dev/null
+++ b/compel/arch/s390/src/lib/include/uapi/asm/infect-types.h
@@ -0,0 +1,75 @@
+#ifndef UAPI_COMPEL_ASM_TYPES_H__
+#define UAPI_COMPEL_ASM_TYPES_H__
+
+#include <stdint.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <asm/ptrace.h>
+#include "common/page.h"
+
+#define SIGMAX			64
+#define SIGMAX_OLD		31
+
+/*
+ * Definitions from /usr/include/asm/ptrace.h:
+ *
+ * typedef struct
+ * {
+ *       __u32   fpc;
+ *       freg_t  fprs[NUM_FPRS];
+ * } s390_fp_regs;
+ *
+ * typedef struct
+ * {
+ *       psw_t psw;
+ *       unsigned long gprs[NUM_GPRS];
+ *       unsigned int  acrs[NUM_ACRS];
+ *       unsigned long orig_gpr2;
+ * } s390_regs;
+ */
+typedef struct {
+	uint64_t part1;
+	uint64_t part2;
+} vector128_t;
+
+struct prfpreg {
+	uint32_t	fpc;
+	uint64_t	fprs[16];
+};
+
+#define USER_FPREGS_VXRS	0x000000001
+
+typedef struct {
+	uint32_t	flags;
+	struct prfpreg	prfpreg;
+	uint64_t	vxrs_low[16];
+	vector128_t	vxrs_high[16];
+} user_fpregs_struct_t;
+
+typedef struct {
+	s390_regs prstatus;
+	uint32_t system_call;
+} user_regs_struct_t;
+
+#define REG_RES(r)			((uint64_t)(r).prstatus.gprs[2])
+#define REG_IP(r)			((uint64_t)(r).prstatus.psw.addr)
+/*
+ * We assume that REG_SYSCALL_NR() is only used for pie code where we
+ * always use svc 0 with opcode in %r1.
+ */
+#define REG_SYSCALL_NR(r)		((uint64_t)(r).prstatus.gprs[1])
+
+#define user_regs_native(pregs)		true
+
+#define __NR(syscall, compat)	__NR_##syscall
+
+struct mmap_arg_struct {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flags;
+	unsigned long fd;
+	unsigned long offset;
+};
+
+#endif /* UAPI_COMPEL_ASM_TYPES_H__ */
diff --git a/compel/arch/s390/src/lib/include/uapi/asm/sigframe.h b/compel/arch/s390/src/lib/include/uapi/asm/sigframe.h
new file mode 100644
index 0000000..d043202
--- /dev/null
+++ b/compel/arch/s390/src/lib/include/uapi/asm/sigframe.h
@@ -0,0 +1,75 @@
+
+#ifndef UAPI_COMPEL_ASM_SIGFRAME_H__
+#define UAPI_COMPEL_ASM_SIGFRAME_H__
+
+#include <asm/ptrace.h>
+#include <asm/types.h>
+
+#include <signal.h>
+#include <stdint.h>
+
+// XXX: the identifier rt_sigcontext is expected to be struct by the CRIU code
+#define rt_sigcontext sigcontext
+
+#include <compel/sigframe-common.h>
+
+#define RT_SIGFRAME_OFFSET(rt_sigframe) 0
+
+/*
+ * From /usr/include/asm/sigcontext.h
+ *
+ * Redefine _sigregs_ext to be able to compile on older systems
+ */
+#ifndef __NUM_VXRS_LOW
+typedef struct {
+	__u32 u[4];
+} __vector128;
+
+typedef struct {
+	unsigned long long vxrs_low[16];
+	__vector128 vxrs_high[16];
+	unsigned char __reserved[128];
+} _sigregs_ext;
+#endif
+
+/*
+ * From /usr/include/uapi/asm/ucontext.h
+ */
+struct ucontext_extended {
+	unsigned long     uc_flags;
+	struct ucontext  *uc_link;
+	stack_t           uc_stack;
+	_sigregs          uc_mcontext;
+	sigset_t          uc_sigmask;
+	/* Allow for uc_sigmask growth.  Glibc uses a 1024-bit sigset_t.  */
+	unsigned char     __unused[128 - sizeof(sigset_t)];
+	_sigregs_ext      uc_mcontext_ext;
+};
+
+/*
+ * Signal stack frame for RT sigreturn
+ */
+struct rt_sigframe {
+	uint8_t callee_used_stack[160];
+	uint8_t retcode[2];
+	siginfo_t info;
+	struct ucontext_extended uc;
+};
+
+/*
+ * Do rt_sigreturn SVC
+ */
+#define ARCH_RT_SIGRETURN(new_sp, rt_sigframe)			\
+	asm volatile(						\
+		"lgr	%%r15,%0\n"				\
+		"lghi	%%r1,173\n"				\
+		"svc	0\n"					\
+		:						\
+		: "d" (new_sp)					\
+		: "15", "memory")
+
+#define RT_SIGFRAME_UC(rt_sigframe) (&rt_sigframe->uc)
+#define RT_SIGFRAME_REGIP(rt_sigframe) (rt_sigframe)->uc.uc_mcontext.regs.psw.addr
+#define RT_SIGFRAME_HAS_FPU(rt_sigframe)	(1)
+
+#endif /* UAPI_COMPEL_ASM_SIGFRAME_H__ */
diff --git a/compel/arch/s390/src/lib/infect.c b/compel/arch/s390/src/lib/infect.c
new file mode 100644
index 0000000..fcad338
--- /dev/null
+++ b/compel/arch/s390/src/lib/infect.c
@@ -0,0 +1,559 @@
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/user.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <elf.h>
+#include <compel/plugins/std/syscall-codes.h>
+#include "uapi/compel/asm/infect-types.h"
+#include "errno.h"
+#include "log.h"
+#include "common/bug.h"
+#include "infect.h"
+#include "ptrace.h"
+#include "infect-priv.h"
+
+#define NT_PRFPREG		2
+#define NT_S390_VXRS_LOW	0x309
+#define NT_S390_VXRS_HIGH	0x30a
+
+/*
+ * Print general purpose and access registers
+ */
+static void print_user_regs_struct(const char *msg, int pid,
+				   user_regs_struct_t *regs)
+{
+	int i;
+
+	pr_debug("%s: Registers for pid=%d\n", msg, pid);
+	pr_debug("system_call %08lx\n", (unsigned long) regs->system_call);
+	pr_debug("       psw %016lx %016lx\n", regs->prstatus.psw.mask,
+		 regs->prstatus.psw.addr);
+	pr_debug(" orig_gpr2 %016lx\n", regs->prstatus.orig_gpr2);
+	for (i = 0; i < 16; i++)
+		pr_debug("       g%02d %016lx\n", i, regs->prstatus.gprs[i]);
+	for (i = 0; i < 16; i++)
+		pr_debug("       a%02d %08x\n", i, regs->prstatus.acrs[i]);
+}
+
+/*
+ * Print floating point and vector registers
+ */
+static void print_user_fpregs_struct(const char *msg, int pid,
+				     user_fpregs_struct_t *fpregs)
+{
+	int i;
+
+	pr_debug("%s: FP registers for pid=%d\n", msg, pid);
+	pr_debug("       fpc %08x\n", fpregs->prfpreg.fpc);
+	for (i = 0; i < 16; i++)
+		pr_debug("       f%02d %016lx\n", i, fpregs->prfpreg.fprs[i]);
+	if (!(fpregs->flags & USER_FPREGS_VXRS)) {
+		pr_debug("       No VXRS\n");
+		return;
+	}
+	for (i = 0; i < 16; i++)
+		pr_debug("  vx_low%02d %016lx\n", i, fpregs->vxrs_low[i]);
+	for (i = 0; i < 16; i++)
+		pr_debug(" vx_high%02d %016lx %016lx\n", i,
+			 fpregs->vxrs_high[i].part1,
+			 fpregs->vxrs_high[i].part2);
+}
+
+int sigreturn_prep_regs_plain(struct rt_sigframe *sigframe,
+			      user_regs_struct_t *regs,
+			      user_fpregs_struct_t *fpregs)
+{
+	_sigregs_ext *dst_ext = &sigframe->uc.uc_mcontext_ext;
+	_sigregs *dst = &sigframe->uc.uc_mcontext;
+
+	memcpy(dst->regs.gprs, regs->prstatus.gprs,
+	       sizeof(regs->prstatus.gprs));
+	memcpy(dst->regs.acrs, regs->prstatus.acrs,
+	       sizeof(regs->prstatus.acrs));
+	memcpy(&dst->regs.psw, &regs->prstatus.psw,
+	       sizeof(regs->prstatus.psw));
+	memcpy(&dst->fpregs.fpc, &fpregs->prfpreg.fpc,
+	       sizeof(fpregs->prfpreg.fpc));
+	memcpy(&dst->fpregs.fprs, &fpregs->prfpreg.fprs,
+	       sizeof(fpregs->prfpreg.fprs));
+	if (fpregs->flags & USER_FPREGS_VXRS) {
+		memcpy(&dst_ext->vxrs_low, &fpregs->vxrs_low,
+		       sizeof(fpregs->vxrs_low));
+		memcpy(&dst_ext->vxrs_high, &fpregs->vxrs_high,
+		       sizeof(fpregs->vxrs_high));
+	} else {
+		memset(&dst_ext->vxrs_low, 0,
+		       sizeof(sizeof(fpregs->vxrs_low)));
+		memset(&dst_ext->vxrs_high, 0,
+		       sizeof(sizeof(fpregs->vxrs_high)));
+	}
+	return 0;
+}
+
+int sigreturn_prep_fpu_frame_plain(struct rt_sigframe *sigframe,
+				   struct rt_sigframe *rsigframe)
+{
+	return 0;
+}
+
+/*
+ * Rewind the psw for 'bytes' bytes
+ */
+static inline void rewind_psw(psw_t *psw, unsigned long bytes)
+{
+	unsigned long mask;
+
+	pr_debug("Rewind psw: %016lx bytes=%lu\n", psw->addr, bytes);
+	mask = (psw->mask & PSW_MASK_EA) ? -1UL :
+		(psw->mask & PSW_MASK_BA) ? (1UL << 31) - 1 :
+		(1UL << 24) - 1;
+	psw->addr = (psw->addr - bytes) & mask;
+}
+
+/*
+ * Get vector registers
+ */
+int get_vx_regs(pid_t pid, user_fpregs_struct_t *fpregs)
+{
+	struct iovec iov;
+
+	fpregs->flags &= ~USER_FPREGS_VXRS;
+	iov.iov_base = &fpregs->vxrs_low;
+	iov.iov_len = sizeof(fpregs->vxrs_low);
+	if (ptrace(PTRACE_GETREGSET, pid, NT_S390_VXRS_LOW, &iov) < 0) {
+		/*
+		 * If the kernel does not support vector registers, we get
+		 * EINVAL. With kernel support and old hardware, we get ENODEV.
+		 */
+		if (errno == EINVAL || errno == ENODEV) {
+			memset(fpregs->vxrs_low, 0, sizeof(fpregs->vxrs_low));
+			memset(fpregs->vxrs_high, 0, sizeof(fpregs->vxrs_high));
+			pr_debug("VXRS registers not supported\n");
+			return 0;
+		}
+		pr_perror("Couldn't get VXRS_LOW\n");
+		return -1;
+	}
+	iov.iov_base = &fpregs->vxrs_high;
+	iov.iov_len = sizeof(fpregs->vxrs_high);
+	if (ptrace(PTRACE_GETREGSET, pid, NT_S390_VXRS_HIGH, &iov) < 0) {
+		pr_perror("Couldn't get VXRS_HIGH\n");
+		return -1;
+	}
+	fpregs->flags |= USER_FPREGS_VXRS;
+	return 0;
+}
+
+/*
+ * Set vector registers
+ */
+int set_vx_regs(pid_t pid, user_fpregs_struct_t *fpregs)
+{
+	struct iovec iov;
+	int rc;
+
+	if (!(fpregs->flags & USER_FPREGS_VXRS))
+		return 0;
+
+	iov.iov_base = &fpregs->vxrs_low;
+	iov.iov_len = sizeof(fpregs->vxrs_low);
+	rc = ptrace(PTRACE_SETREGSET, pid, NT_S390_VXRS_LOW, &iov);
+	if (rc) {
+		pr_perror("Couldn't set VXRS_LOW registers\n");
+		return rc;
+	}
+
+	iov.iov_base = &fpregs->vxrs_high;
+	iov.iov_len = sizeof(fpregs->vxrs_high);
+	rc = ptrace(PTRACE_SETREGSET, pid, NT_S390_VXRS_HIGH, &iov);
+	if (rc)
+		pr_perror("Couldn't set VXRS_HIGH registers\n");
+	return rc;
+}
+
+/*
+ * Prepare task registers for restart
+ */
+int get_task_regs(pid_t pid, user_regs_struct_t *regs, save_regs_t save,
+		  void *arg)
+{
+	user_fpregs_struct_t fpregs;
+	struct iovec iov;
+	int rewind;
+
+	print_user_regs_struct("get_task_regs", pid, regs);
+
+	memset(&fpregs, 0, sizeof(fpregs));
+	iov.iov_base = &fpregs.prfpreg;
+	iov.iov_len = sizeof(fpregs.prfpreg);
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRFPREG, &iov) < 0) {
+		pr_perror("Couldn't get floating-point registers");
+		return -1;
+	}
+	if (get_vx_regs(pid, &fpregs)) {
+		pr_perror("Couldn't get vector registers");
+		return -1;
+	}
+	print_user_fpregs_struct("get_task_regs", pid, &fpregs);
+	/* Check for system call restarting. */
+	if (regs->system_call) {
+		rewind = regs->system_call >> 16;
+		/* see arch/s390/kernel/signal.c: do_signal() */
+		switch ((long)regs->prstatus.gprs[2]) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			regs->prstatus.gprs[2] = regs->prstatus.orig_gpr2;
+			rewind_psw(&regs->prstatus.psw, rewind);
+			pr_debug("New gpr2: %016lx\n", regs->prstatus.gprs[2]);
+			break;
+		case -ERESTART_RESTARTBLOCK:
+			pr_warn("Will restore %d with interrupted system call\n", pid);
+			regs->prstatus.gprs[2] = -EINTR;
+			break;
+		}
+	}
+	/* Call save_task_regs() */
+	return save(arg, regs, &fpregs);
+}
+
+/*
+ * Injected syscall instruction
+ */
+const char code_syscall[] = {
+	0x0a, 0x00,		/* sc 0 */
+	0x00, 0x01,		/* S390_BREAKPOINT_U16 */
+	0x00, 0x01,		/* S390_BREAKPOINT_U16 */
+	0x00, 0x01,		/* S390_BREAKPOINT_U16 */
+};
+
+static inline void __check_code_syscall(void)
+{
+	BUILD_BUG_ON(sizeof(code_syscall) != BUILTIN_SYSCALL_SIZE);
+	BUILD_BUG_ON(!is_log2(sizeof(code_syscall)));
+}
+
+/*
+ * Issue s390 system call
+ */
+int compel_syscall(struct parasite_ctl *ctl, int nr, long *ret,
+		unsigned long arg1,
+		unsigned long arg2,
+		unsigned long arg3,
+		unsigned long arg4,
+		unsigned long arg5,
+		unsigned long arg6)
+{
+	user_regs_struct_t regs = ctl->orig.regs;
+	int err;
+
+	/* Load syscall number into %r1 */
+	regs.prstatus.gprs[1] = (unsigned long) nr;
+	/* Load parameter registers %r2-%r7 */
+	regs.prstatus.gprs[2] = arg1;
+	regs.prstatus.gprs[3] = arg2;
+	regs.prstatus.gprs[4] = arg3;
+	regs.prstatus.gprs[5] = arg4;
+	regs.prstatus.gprs[6] = arg5;
+	regs.prstatus.gprs[7] = arg6;
+
+	err = compel_execute_syscall(ctl, &regs, (char *) code_syscall);
+
+	/* Return code from system is in %r2 */
+	if (ret)
+		*ret = regs.prstatus.gprs[2];
+	return err;
+}
+
+/*
+ * Issue s390 mmap call
+ */
+void *remote_mmap(struct parasite_ctl *ctl,
+		  void *addr, size_t length, int prot,
+		  int flags, int fd, off_t offset)
+{
+	void *where = (void *)ctl->ictx.syscall_ip + BUILTIN_SYSCALL_SIZE;
+	struct mmap_arg_struct arg_struct;
+	pid_t pid = ctl->rpid;
+	long map = 0;
+	int err;
+
+	/* Setup s390 mmap data */
+	arg_struct.addr = (unsigned long)addr;
+	arg_struct.len = length;
+	arg_struct.prot = prot;
+	arg_struct.flags = flags;
+	arg_struct.fd = fd;
+	arg_struct.offset = offset;
+
+	/* Move args to process */
+	if (ptrace_swap_area(pid, where, &arg_struct, sizeof(arg_struct))) {
+		pr_err("Can't inject memfd args (pid: %d)\n", pid);
+		return NULL;
+	}
+
+	/* Do syscall */
+	err = compel_syscall(ctl, __NR_mmap, &map, (unsigned long) where,
+			     0, 0, 0, 0, 0);
+	if (err < 0 || (long)map < 0)
+		map = 0;
+
+	/* Restore data */
+	if (ptrace_poke_area(pid, &arg_struct, where, sizeof(arg_struct))) {
+		pr_err("Can't restore mmap args (pid: %d)\n", pid);
+		if (map != 0) {
+			err = compel_syscall(ctl, __NR_munmap, NULL, map,
+					     length, 0, 0, 0, 0);
+			map = 0;
+		}
+	}
+
+	return (void *)map;
+}
+
+/*
+ * Setup registers for parasite call
+ */
+void parasite_setup_regs(unsigned long new_ip, void *stack,
+			 user_regs_struct_t *regs)
+{
+	regs->prstatus.psw.addr = new_ip;
+	if (!stack)
+		return;
+	regs->prstatus.gprs[15] = ((unsigned long) stack) -
+		STACK_FRAME_OVERHEAD;
+}
+
+/*
+ * We don't support 24 and 31 bit mode - only 64 bit
+ */
+bool arch_can_dump_task(struct parasite_ctl *ctl)
+{
+	user_regs_struct_t regs;
+	pid_t pid = ctl->rpid;
+	char str[8];
+	psw_t *psw;
+
+	if (ptrace_get_regs(pid, &regs))
+		return false;
+	psw = &regs.prstatus.psw;
+	if (psw->mask & PSW_MASK_EA) {
+		if (psw->mask & PSW_MASK_BA)
+			return true;
+		else
+			sprintf(str, "??");
+	} else {
+		if (psw->mask & PSW_MASK_BA)
+			sprintf(str, "31");
+		else
+			sprintf(str, "24");
+	}
+	pr_err("Pid %d is %s bit: Only 64 bit tasks are supported\n", pid, str);
+	return false;
+}
+
+/*
+ * Return current alternate signal stack
+ */
+int arch_fetch_sas(struct parasite_ctl *ctl, struct rt_sigframe *s)
+{
+	long ret;
+	int err;
+
+	err = compel_syscall(ctl, __NR_sigaltstack,
+			     &ret, 0, (unsigned long)&s->uc.uc_stack,
+			     0, 0, 0, 0);
+	return err ? err : ret;
+}
+
+/*
+ * Find last mapped address of current process
+ */
+static unsigned long max_mapped_addr(void)
+{
+	unsigned long addr_end, addr_max = 0;
+	char line[128];
+	FILE *fp;
+
+	fp = fopen("/proc/self/maps", "r");
+	if (!fp)
+		goto out;
+
+	/* Parse lines like: 3fff415f000-3fff4180000 rw-p 00000000 00:00 0 */
+	while (fgets(line, sizeof(line), fp)) {
+		char *ptr;
+		/* First skip start address */
+		strtoul(&line[0], &ptr, 16);
+		addr_end = strtoul(ptr + 1, NULL, 16);
+		addr_max = max(addr_max, addr_end);
+	}
+	fclose(fp);
+out:
+	return addr_max;
+}
+
+/*
+ * Kernel task size level
+ *
+ * We have (dynamic) 4 level page tables for 64 bit since linux 2.6.25:
+ *
+ *  5a216a2083 ("[S390] Add four level page tables for CONFIG_64BIT=y.")
+ *  6252d702c5 ("[S390] dynamic page tables.")
+ *
+ * The code below is already prepared for future (dynamic) 5 level page tables.
+ *
+ * Besides that there is one problematic kernel bug that has been fixed for
+ * linux 4.11 by the following commit:
+ *
+ *  ee71d16d22 ("s390/mm: make TASK_SIZE independent from the number
+ *              of page table levels")
+ *
+ * A 64 bit process on s390x always starts with 3 levels and upgrades to 4
+ * levels for mmap(> 4 TB) and to 5 levels for mmap(> 16 EB).
+ *
+ * Unfortunately before fix ee71d16d22 for a 3 level process munmap()
+ * and mremap() fail for addresses > 4 TB. CRIU uses the task size,
+ * to unmap() all memory from a starting point to task size to get rid of
+ * unwanted mappings. CRIU uses mremap() to establish the final mappings
+ * which also fails if we want to restore mappings > 4 TB and the initial
+ * restore process still runs with 3 levels.
+ *
+ * To support the current CRIU design on s390 we return task size = 4 TB when
+ * a kernel without fix ee71d16d22 is detected. In this case we can dump at
+ * least processes with < 4 TB which is the most likely case anyway.
+ *
+ * For kernels with fix ee71d16d22 we are fully functional.
+ */
+enum kernel_ts_level {
+	/* Kernel with 4 level page tables without fix ee71d16d22 */
+	KERNEL_TS_LEVEL_4_FIX_NO,
+	/* Kernel with 4 level page tables with fix ee71d16d22 */
+	KERNEL_TS_LEVEL_4_FIX_YES,
+	/* Kernel with 4 level page tables with or without fix ee71d16d22 */
+	KERNEL_TS_LEVEL_4_FIX_UNKN,
+	/* Kernel with 5 level page tables */
+	KERNEL_TS_LEVEL_5,
+};
+
+/* See arch/s390/include/asm/processor.h */
+#define TASK_SIZE_LEVEL_3	0x40000000000UL		/* 4 TB */
+#define TASK_SIZE_LEVEL_4	0x20000000000000UL	/* 8 PB */
+#define TASK_SIZE_LEVEL_5	0xffffffffffffefffUL	/* 16 EB - 0x1000 */
+
+/*
+ * Return detected kernel version regarding task size level
+ *
+ * We use unmap() to probe the maximum possible page table level of kernel
+ */
+static enum kernel_ts_level get_kernel_ts_level(void)
+{
+	unsigned long criu_end_addr = max_mapped_addr();
+
+	/* Check for 5 levels */
+	if (criu_end_addr > TASK_SIZE_LEVEL_4)
+		return KERNEL_TS_LEVEL_5;
+	else if (munmap((void *) TASK_SIZE_LEVEL_4, 0x1000) == 0)
+		return KERNEL_TS_LEVEL_5;
+
+	if (criu_end_addr < TASK_SIZE_LEVEL_3) {
+		/* Check for 4 level kernel with fix */
+		if (munmap((void *) TASK_SIZE_LEVEL_3, 0x1000) == 0)
+			return KERNEL_TS_LEVEL_4_FIX_YES;
+		else
+			return KERNEL_TS_LEVEL_4_FIX_NO;
+	}
+	/* We can't find out if kernel has the fix */
+	return KERNEL_TS_LEVEL_4_FIX_UNKN;
+}
+
+/*
+ * Log detected level
+ */
+static void pr_levels(const char *str)
+{
+	pr_debug("Max user page table levels (task size): %s\n", str);
+}
+
+/*
+ * Return last address (+1) of biggest possible user address space for
+ * current kernel
+ */
+unsigned long compel_task_size(void)
+{
+	switch (get_kernel_ts_level()) {
+	case KERNEL_TS_LEVEL_4_FIX_NO:
+		pr_levels("KERNEL_TS_LEVEL_4_FIX_NO");
+		return TASK_SIZE_LEVEL_3;
+	case KERNEL_TS_LEVEL_4_FIX_YES:
+		pr_levels("KERNEL_TS_LEVEL_4_FIX_YES");
+		return TASK_SIZE_LEVEL_4;
+	case KERNEL_TS_LEVEL_4_FIX_UNKN:
+		pr_levels("KERNEL_TS_LEVEL_4_FIX_UNKN");
+		return TASK_SIZE_LEVEL_3;
+	default: /* KERNEL_TS_LEVEL_5 */
+		pr_levels("KERNEL_TS_LEVEL_5");
+		return TASK_SIZE_LEVEL_5;
+	}
+}
+
+/*
+ * Get task registers (overwrites weak function)
+ *
+ * We don't store floating point and vector registers here because we
+ * assue that compel/pie code does not change them.
+ *
+ * For verification issue:
+ *
+ * $ objdump -S criu/pie/parasite.built-in.bin.o | grep "%f"
+ * $ objdump -S criu/pie/restorer.built-in.bin.o | grep "%f"
+ */
+int ptrace_get_regs(int pid, user_regs_struct_t *regs)
+{
+	struct iovec iov;
+	int rc;
+
+	pr_debug("ptrace_get_regs: pid=%d\n", pid);
+
+	iov.iov_base = &regs->prstatus;
+	iov.iov_len = sizeof(regs->prstatus);
+	rc = ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov);
+	if (rc != 0)
+		return rc;
+
+	iov.iov_base = &regs->system_call;
+	iov.iov_len = sizeof(regs->system_call);
+	return ptrace(PTRACE_GETREGSET, pid, NT_S390_SYSTEM_CALL, &iov);
+}
+
+/*
+ * Set task registers (overwrites weak function)
+ */
+int ptrace_set_regs(int pid, user_regs_struct_t *regs)
+{
+	uint32_t system_call = 0;
+	struct iovec iov;
+	int rc;
+
+	pr_debug("ptrace_set_regs: pid=%d\n", pid);
+
+	iov.iov_base = &regs->prstatus;
+	iov.iov_len = sizeof(regs->prstatus);
+	rc = ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov);
+	if (rc)
+		return rc;
+
+	/*
+	 * If we attached to an inferior that is sleeping in a restarting
+	 * system call like futex_wait(), we have to reset the system_call
+	 * to 0. Otherwise the kernel would try to finish the interrupted
+	 * system call after PTRACE_CONT and we could not run the
+	 * parasite code.
+	 */
+	iov.iov_base = &system_call;
+	iov.iov_len = sizeof(system_call);
+	return ptrace(PTRACE_SETREGSET, pid, NT_S390_SYSTEM_CALL, &iov);
+}
diff --git a/include/common/arch/s390/asm/atomic.h b/include/common/arch/s390/asm/atomic.h
new file mode 100644
index 0000000..dfdba12
--- /dev/null
+++ b/include/common/arch/s390/asm/atomic.h
@@ -0,0 +1,67 @@
+#ifndef __ARCH_S390_ATOMIC__
+#define __ARCH_S390_ATOMIC__
+
+#include "common/arch/s390/asm/atomic_ops.h"
+#include "common/compiler.h"
+
+#define ATOMIC_INIT(i)  { (i) }
+
+typedef struct {
+	int counter;
+} atomic_t;
+
+static inline int atomic_read(const atomic_t *v)
+{
+	int c;
+
+	asm volatile(
+		"	l	%0,%1\n"
+		: "=d" (c) : "Q" (v->counter));
+	return c;
+}
+
+static inline void atomic_set(atomic_t *v, int i)
+{
+	asm volatile(
+		"	st	%1,%0\n"
+		: "=Q" (v->counter) : "d" (i));
+}
+
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	return __atomic_add_barrier(i, &v->counter) + i;
+}
+
+
+static inline void atomic_add(int i, atomic_t *v)
+{
+	__atomic_add(i, &v->counter);
+}
+
+#define atomic_inc(_v)			atomic_add(1, _v)
+#define atomic_inc_return(_v)		atomic_add_return(1, _v)
+#define atomic_sub(_i, _v)		atomic_add(-(int)(_i), _v)
+#define atomic_sub_return(_i, _v)	atomic_add_return(-(int)(_i), _v)
+#define atomic_dec(_v)			atomic_sub(1, _v)
+#define atomic_dec_return(_v)		atomic_sub_return(1, _v)
+#define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
+
+#define ATOMIC_OPS(op)							\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	__atomic_##op(i, &v->counter);					\
+}									\
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
+
+#undef ATOMIC_OPS
+
+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	return __atomic_cmpxchg(&v->counter, old, new);
+}
+
+#endif /* __ARCH_S390_ATOMIC__  */
+
diff --git a/include/common/arch/s390/asm/atomic_ops.h b/include/common/arch/s390/asm/atomic_ops.h
new file mode 100644
index 0000000..ff0e1e3
--- /dev/null
+++ b/include/common/arch/s390/asm/atomic_ops.h
@@ -0,0 +1,74 @@
+#ifndef __ARCH_S390_ATOMIC_OPS__
+#define __ARCH_S390_ATOMIC_OPS__
+
+#define __ATOMIC_OP(op_name, op_string)					\
+static inline int op_name(int val, int *ptr)				\
+{									\
+	int old, new;							\
+									\
+	asm volatile(							\
+		"0:	lr	%[new],%[old]\n"			\
+		op_string "	%[new],%[val]\n"			\
+		"	cs	%[old],%[new],%[ptr]\n"			\
+		"	jl	0b"					\
+		: [old] "=d" (old), [new] "=&d" (new), [ptr] "+Q" (*ptr)\
+		: [val] "d" (val), "0" (*ptr) : "cc", "memory");	\
+	return old;							\
+}
+
+#define __ATOMIC_OPS(op_name, op_string)				\
+	__ATOMIC_OP(op_name, op_string)					\
+	__ATOMIC_OP(op_name##_barrier, op_string)
+
+__ATOMIC_OPS(__atomic_add, "ar")
+__ATOMIC_OPS(__atomic_and, "nr")
+__ATOMIC_OPS(__atomic_or,  "or")
+__ATOMIC_OPS(__atomic_xor, "xr")
+
+#undef __ATOMIC_OPS
+
+#define __ATOMIC64_OP(op_name, op_string)				\
+static inline long op_name(long val, long *ptr)				\
+{									\
+	long old, new;							\
+									\
+	asm volatile(							\
+		"0:	lgr	%[new],%[old]\n"			\
+		op_string "	%[new],%[val]\n"			\
+		"	csg	%[old],%[new],%[ptr]\n"			\
+		"	jl	0b"					\
+		: [old] "=d" (old), [new] "=&d" (new), [ptr] "+Q" (*ptr)\
+		: [val] "d" (val), "0" (*ptr) : "cc", "memory");	\
+	return old;							\
+}
+
+#define __ATOMIC64_OPS(op_name, op_string)				\
+	__ATOMIC64_OP(op_name, op_string)				\
+	__ATOMIC64_OP(op_name##_barrier, op_string)
+
+__ATOMIC64_OPS(__atomic64_add, "agr")
+__ATOMIC64_OPS(__atomic64_and, "ngr")
+__ATOMIC64_OPS(__atomic64_or,  "ogr")
+__ATOMIC64_OPS(__atomic64_xor, "xgr")
+
+#undef __ATOMIC64_OPS
+
+static inline int __atomic_cmpxchg(int *ptr, int old, int new)
+{
+	asm volatile(
+		"	cs	%[old],%[new],%[ptr]"
+		: [old] "+d" (old), [ptr] "+Q" (*ptr)
+		: [new] "d" (new) : "cc", "memory");
+	return old;
+}
+
+static inline long __atomic64_cmpxchg(long *ptr, long old, long new)
+{
+	asm volatile(
+		"	csg	%[old],%[new],%[ptr]"
+		: [old] "+d" (old), [ptr] "+Q" (*ptr)
+		: [new] "d" (new) : "cc", "memory");
+	return old;
+}
+
+#endif /* __ARCH_S390_ATOMIC_OPS__  */
diff --git a/include/common/arch/s390/asm/bitops.h b/include/common/arch/s390/asm/bitops.h
new file mode 100644
index 0000000..13d8323
--- /dev/null
+++ b/include/common/arch/s390/asm/bitops.h
@@ -0,0 +1,164 @@
+#ifndef _S390_BITOPS_H
+#define _S390_BITOPS_H
+
+#include "common/asm/bitsperlong.h"
+#include "common/compiler.h"
+#include "common/arch/s390/asm/atomic_ops.h"
+
+#define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
+#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_LONG)
+#define __BITOPS_WORDS(bits)	(((bits) + BITS_PER_LONG - 1) / BITS_PER_LONG)
+
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[BITS_TO_LONGS(bits)]
+
+static inline unsigned long *
+__bitops_word(unsigned long nr, volatile unsigned long *ptr)
+{
+	unsigned long addr;
+
+	addr = (unsigned long)ptr + ((nr ^ (nr & (BITS_PER_LONG - 1))) >> 3);
+	return (unsigned long *)addr;
+}
+
+static inline unsigned char *
+__bitops_byte(unsigned long nr, volatile unsigned long *ptr)
+{
+	return ((unsigned char *)ptr) + ((nr ^ (BITS_PER_LONG - 8)) >> 3);
+}
+
+static inline void set_bit(unsigned long nr, volatile unsigned long *ptr)
+{
+	unsigned long *addr = __bitops_word(nr, ptr);
+	unsigned long mask;
+
+	mask = 1UL << (nr & (BITS_PER_LONG - 1));
+	__atomic64_or((long) mask, (long *) addr);
+}
+
+static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
+{
+	unsigned long *addr = __bitops_word(nr, ptr);
+	unsigned long mask;
+
+	mask = ~(1UL << (nr & (BITS_PER_LONG - 1)));
+	__atomic64_and((long) mask, (long *) addr);
+}
+
+static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
+{
+	unsigned long *addr = __bitops_word(nr, ptr);
+	unsigned long mask;
+
+	mask = 1UL << (nr & (BITS_PER_LONG - 1));
+	__atomic64_xor((long) mask, (long *) addr);
+}
+
+static inline int
+test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
+{
+	unsigned long *addr = __bitops_word(nr, ptr);
+	unsigned long old, mask;
+
+	mask = 1UL << (nr & (BITS_PER_LONG - 1));
+	old = __atomic64_or_barrier((long) mask, (long *) addr);
+	return (old & mask) != 0;
+}
+
+static inline int test_bit(unsigned long nr, const volatile unsigned long *ptr)
+{
+	const volatile unsigned char *addr;
+
+	addr = ((const volatile unsigned char *)ptr);
+	addr += (nr ^ (BITS_PER_LONG - 8)) >> 3;
+	return (*addr >> (nr & 7)) & 1;
+}
+
+static inline unsigned char __flogr(unsigned long word)
+{
+	if (__builtin_constant_p(word)) {
+		unsigned long bit = 0;
+
+		if (!word)
+			return 64;
+		if (!(word & 0xffffffff00000000UL)) {
+			word <<= 32;
+			bit += 32;
+		}
+		if (!(word & 0xffff000000000000UL)) {
+			word <<= 16;
+			bit += 16;
+		}
+		if (!(word & 0xff00000000000000UL)) {
+			word <<= 8;
+			bit += 8;
+		}
+		if (!(word & 0xf000000000000000UL)) {
+			word <<= 4;
+			bit += 4;
+		}
+		if (!(word & 0xc000000000000000UL)) {
+			word <<= 2;
+			bit += 2;
+		}
+		if (!(word & 0x8000000000000000UL)) {
+			word <<= 1;
+			bit += 1;
+		}
+		return bit;
+	} else {
+		register unsigned long bit asm("4") = word;
+		register unsigned long out asm("5");
+
+		asm volatile(
+			"       flogr   %[bit],%[bit]\n"
+			: [bit] "+d" (bit), [out] "=d" (out) : : "cc");
+		return bit;
+	}
+}
+
+static inline unsigned long __ffs(unsigned long word)
+{
+	return __flogr(-word & word) ^ (BITS_PER_LONG - 1);
+}
+
+#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+
+static inline unsigned long _find_next_bit(const unsigned long *addr,
+				    unsigned long nbits, unsigned long start,
+				    unsigned long invert)
+{
+	unsigned long tmp;
+
+	if (!nbits || start >= nbits)
+		return nbits;
+
+	tmp = addr[start / BITS_PER_LONG] ^ invert;
+
+	tmp &= BITMAP_FIRST_WORD_MASK(start);
+	start = round_down(start, BITS_PER_LONG);
+
+	while (!tmp) {
+		start += BITS_PER_LONG;
+		if (start >= nbits)
+			return nbits;
+
+		tmp = addr[start / BITS_PER_LONG] ^ invert;
+	}
+
+	return min(start + __ffs(tmp), nbits);
+}
+
+static inline unsigned long find_next_bit(const unsigned long *addr,
+					  unsigned long size,
+					  unsigned long offset)
+{
+	return _find_next_bit(addr, size, offset, 0UL);
+}
+
+#define for_each_bit(i, bitmask)				\
+	for (i = find_next_bit(bitmask, sizeof(bitmask), 0);	\
+	     i < sizeof(bitmask);				\
+	     i = find_next_bit(bitmask, sizeof(bitmask), i + 1))
+
+#endif /* _S390_BITOPS_H */
diff --git a/include/common/arch/s390/asm/bitsperlong.h b/include/common/arch/s390/asm/bitsperlong.h
new file mode 100644
index 0000000..d95727d
--- /dev/null
+++ b/include/common/arch/s390/asm/bitsperlong.h
@@ -0,0 +1,6 @@
+#ifndef __CR_BITSPERLONG_H__
+#define __CR_BITSPERLONG_H__
+
+#define BITS_PER_LONG 64
+
+#endif /* __CR_BITSPERLONG_H__ */
diff --git a/include/common/arch/s390/asm/linkage.h b/include/common/arch/s390/asm/linkage.h
new file mode 100644
index 0000000..99895ce
--- /dev/null
+++ b/include/common/arch/s390/asm/linkage.h
@@ -0,0 +1,22 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#ifdef __ASSEMBLY__
+
+#define __ALIGN .align 4, 0x07
+
+#define GLOBAL(name)		\
+	.globl name;		\
+	name:
+
+#define ENTRY(name)		\
+	.globl name;		\
+	.type name, @function;	\
+	__ALIGN;		\
+	name:
+
+#define END(name)		\
+	.size name, . - name
+
+#endif /* __ASSEMBLY__ */
+#endif
diff --git a/include/common/arch/s390/asm/page.h b/include/common/arch/s390/asm/page.h
new file mode 100644
index 0000000..8e8c649
--- /dev/null
+++ b/include/common/arch/s390/asm/page.h
@@ -0,0 +1,19 @@
+#ifndef __CR_ASM_PAGE_H__
+#define __CR_ASM_PAGE_H__
+
+#ifndef PAGE_SHIFT
+#define PAGE_SHIFT	12
+#endif
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#endif
+
+#ifndef PAGE_MASK
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#endif
+
+#define PAGE_PFN(addr)	((addr) / PAGE_SIZE)
+#define page_size()	PAGE_SIZE
+
+#endif /* __CR_ASM_PAGE_H__ */
-- 
2.7.4
