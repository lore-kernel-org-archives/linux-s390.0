From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 3/5] all: s390: redefine wrappers in generic code
Date: Mon, 25 Jan 2016 19:57:25 +0300
Message-ID: <1453741047-5498-4-git-send-email-ynorov@caviumnetworks.com>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

With new COMPAT_SYSCALL_WRAPx macro, we declare both sys_foo(),
and compat_sys_foo() system calls. The later clears top halves of 64-bit
registers to eliminate possible damage from garbage there.

With the only exception (handled in next patch), this is mechanical work.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/s390/kernel/Makefile         |   2 +-
 arch/s390/kernel/compat_wrapper.c | 128 ----------------------
 arch/s390/pci/pci_mmio.c          |   5 +-
 drivers/char/random.c             |   3 +-
 fs/aio.c                          |   4 +-
 fs/buffer.c                       |   3 +-
 fs/dcache.c                       |   3 +-
 fs/eventpoll.c                    |   4 +-
 fs/exec.c                         |   2 +-
 fs/fhandle.c                      |   3 +-
 fs/filesystems.c                  |   3 +-
 fs/namei.c                        |  29 ++---
 fs/namespace.c                    |   7 +-
 fs/notify/inotify/inotify_user.c  |   3 +-
 fs/open.c                         |  20 ++--
 fs/pipe.c                         |   5 +-
 fs/quota/quota.c                  |   3 +-
 fs/read_write.c                   |   2 +-
 fs/select.c                       |   3 +-
 fs/splice.c                       |   4 +-
 fs/stat.c                         |   5 +-
 fs/xattr.c                        |  25 ++---
 include/uapi/asm-generic/unistd.h | 220 +++++++++++++++++++-------------------
 ipc/mqueue.c                      |   3 +-
 kernel/acct.c                     |   3 +-
 kernel/bpf/syscall.c              |   3 +-
 kernel/capability.c               |   5 +-
 kernel/events/core.c              |   2 +-
 kernel/fork.c                     |  12 +--
 kernel/groups.c                   |   5 +-
 kernel/kcmp.c                     |   3 +-
 kernel/module.c                   |   7 +-
 kernel/printk/printk.c            |   3 +-
 kernel/reboot.c                   |   3 +-
 kernel/sched/core.c               |  11 +-
 kernel/seccomp.c                  |   2 +-
 kernel/signal.c                   |   6 +-
 kernel/sys.c                      |  16 +--
 mm/madvise.c                      |   3 +-
 mm/mincore.c                      |   3 +-
 mm/mlock.c                        |   7 +-
 mm/mmap.c                         |   7 +-
 mm/mprotect.c                     |   3 +-
 mm/mremap.c                       |   3 +-
 mm/msync.c                        |   3 +-
 mm/nommu.c                        |   7 +-
 mm/shmem.c                        |   3 +-
 mm/swapfile.c                     |   5 +-
 net/socket.c                      |  14 +--
 security/keys/keyctl.c            |   5 +-
 50 files changed, 270 insertions(+), 363 deletions(-)
 delete mode 100644 arch/s390/kernel/compat_wrapper.c

diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index dc167a2..185cd88 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -55,7 +55,7 @@ obj-$(CONFIG_HIBERNATION)	+= suspend.o swsusp.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
-obj-$(CONFIG_COMPAT)		+= compat_wrapper.o $(compat-obj-y)
+obj-$(CONFIG_COMPAT)		+= $(compat-obj-y)
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
deleted file mode 100644
index 527f75d..0000000
--- a/arch/s390/kernel/compat_wrapper.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- *  Compat system call wrappers.
- *
- *    Copyright IBM Corp. 2014
- */
-
-#include <linux/syscalls.h>
-#include <linux/compat.h>
-#include "entry.h"
-
-COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP2(link, const char __user *, oldname, const char __user *, newname);
-COMPAT_SYSCALL_WRAP1(unlink, const char __user *, pathname);
-COMPAT_SYSCALL_WRAP1(chdir, const char __user *, filename);
-COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
-COMPAT_SYSCALL_WRAP2(chmod, const char __user *, filename, umode_t, mode);
-COMPAT_SYSCALL_WRAP1(oldumount, char __user *, name);
-COMPAT_SYSCALL_WRAP2(access, const char __user *, filename, int, mode);
-COMPAT_SYSCALL_WRAP2(rename, const char __user *, oldname, const char __user *, newname);
-COMPAT_SYSCALL_WRAP2(mkdir, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP1(rmdir, const char __user *, pathname);
-COMPAT_SYSCALL_WRAP1(pipe, int __user *, fildes);
-COMPAT_SYSCALL_WRAP1(brk, unsigned long, brk);
-COMPAT_SYSCALL_WRAP2(signal, int, sig, __sighandler_t, handler);
-COMPAT_SYSCALL_WRAP1(acct, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(umount, char __user *, name, int, flags);
-COMPAT_SYSCALL_WRAP1(chroot, const char __user *, filename);
-COMPAT_SYSCALL_WRAP3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask);
-COMPAT_SYSCALL_WRAP2(sethostname, char __user *, name, int, len);
-COMPAT_SYSCALL_WRAP2(symlink, const char __user *, old, const char __user *, new);
-COMPAT_SYSCALL_WRAP3(readlink, const char __user *, path, char __user *, buf, int, bufsiz);
-COMPAT_SYSCALL_WRAP1(uselib, const char __user *, library);
-COMPAT_SYSCALL_WRAP2(swapon, const char __user *, specialfile, int, swap_flags);
-COMPAT_SYSCALL_WRAP4(reboot, int, magic1, int, magic2, unsigned int, cmd, void __user *, arg);
-COMPAT_SYSCALL_WRAP2(munmap, unsigned long, addr, size_t, len);
-COMPAT_SYSCALL_WRAP3(syslog, int, type, char __user *, buf, int, len);
-COMPAT_SYSCALL_WRAP1(swapoff, const char __user *, specialfile);
-COMPAT_SYSCALL_WRAP2(setdomainname, char __user *, name, int, len);
-COMPAT_SYSCALL_WRAP1(newuname, struct new_utsname __user *, name);
-COMPAT_SYSCALL_WRAP3(mprotect, unsigned long, start, size_t, len, unsigned long, prot);
-COMPAT_SYSCALL_WRAP3(init_module, void __user *, umod, unsigned long, len, const char __user *, uargs);
-COMPAT_SYSCALL_WRAP2(delete_module, const char __user *, name_user, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(quotactl, unsigned int, cmd, const char __user *, special, qid_t, id, void __user *, addr);
-COMPAT_SYSCALL_WRAP2(bdflush, int, func, long, data);
-COMPAT_SYSCALL_WRAP3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2);
-COMPAT_SYSCALL_WRAP5(llseek, unsigned int, fd, unsigned long, high, unsigned long, low, loff_t __user *, result, unsigned int, whence);
-COMPAT_SYSCALL_WRAP3(msync, unsigned long, start, size_t, len, int, flags);
-COMPAT_SYSCALL_WRAP2(mlock, unsigned long, start, size_t, len);
-COMPAT_SYSCALL_WRAP2(munlock, unsigned long, start, size_t, len);
-COMPAT_SYSCALL_WRAP2(sched_setparam, pid_t, pid, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP2(sched_getparam, pid_t, pid, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP5(mremap, unsigned long, addr, unsigned long, old_len, unsigned long, new_len, unsigned long, flags, unsigned long, new_addr);
-COMPAT_SYSCALL_WRAP3(poll, struct pollfd __user *, ufds, unsigned int, nfds, int, timeout);
-COMPAT_SYSCALL_WRAP5(prctl, int, option, unsigned long, arg2, unsigned long, arg3, unsigned long, arg4, unsigned long, arg5);
-COMPAT_SYSCALL_WRAP2(getcwd, char __user *, buf, unsigned long, size);
-COMPAT_SYSCALL_WRAP2(capget, cap_user_header_t, header, cap_user_data_t, dataptr);
-COMPAT_SYSCALL_WRAP2(capset, cap_user_header_t, header, const cap_user_data_t, data);
-COMPAT_SYSCALL_WRAP3(lchown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP2(getgroups, int, gidsetsize, gid_t __user *, grouplist);
-COMPAT_SYSCALL_WRAP2(setgroups, int, gidsetsize, gid_t __user *, grouplist);
-COMPAT_SYSCALL_WRAP3(getresuid, uid_t __user *, ruid, uid_t __user *, euid, uid_t __user *, suid);
-COMPAT_SYSCALL_WRAP3(getresgid, gid_t __user *, rgid, gid_t __user *, egid, gid_t __user *, sgid);
-COMPAT_SYSCALL_WRAP3(chown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP2(pivot_root, const char __user *, new_root, const char __user *, put_old);
-COMPAT_SYSCALL_WRAP3(mincore, unsigned long, start, size_t, len, unsigned char __user *, vec);
-COMPAT_SYSCALL_WRAP3(madvise, unsigned long, start, size_t, len, int, behavior);
-COMPAT_SYSCALL_WRAP5(setxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP5(lsetxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP5(fsetxattr, int, fd, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP3(getdents64, unsigned int, fd, struct linux_dirent64 __user *, dirent, unsigned int, count);
-COMPAT_SYSCALL_WRAP4(getxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP4(lgetxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP4(fgetxattr, int, fd, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP3(listxattr, const char __user *, path, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP3(llistxattr, const char __user *, path, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP3(flistxattr, int, fd, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP2(removexattr, const char __user *, path, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(lremovexattr, const char __user *, path, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(fremovexattr, int, fd, const char __user *, name);
-COMPAT_SYSCALL_WRAP1(set_tid_address, int __user *, tidptr);
-COMPAT_SYSCALL_WRAP4(epoll_ctl, int, epfd, int, op, int, fd, struct epoll_event __user *, event);
-COMPAT_SYSCALL_WRAP4(epoll_wait, int, epfd, struct epoll_event __user *, events, int, maxevents, int, timeout);
-COMPAT_SYSCALL_WRAP1(io_destroy, aio_context_t, ctx);
-COMPAT_SYSCALL_WRAP3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb, struct io_event __user *, result);
-COMPAT_SYSCALL_WRAP1(mq_unlink, const char __user *, name);
-COMPAT_SYSCALL_WRAP5(add_key, const char __user *, tp, const char __user *, dsc, const void __user *, pld, size_t, len, key_serial_t, id);
-COMPAT_SYSCALL_WRAP4(request_key, const char __user *, tp, const char __user *, dsc, const char __user *, info, key_serial_t, id);
-COMPAT_SYSCALL_WRAP5(remap_file_pages, unsigned long, start, unsigned long, size, unsigned long, prot, unsigned long, pgoff, unsigned long, flags);
-COMPAT_SYSCALL_WRAP3(inotify_add_watch, int, fd, const char __user *, path, u32, mask);
-COMPAT_SYSCALL_WRAP3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP4(mknodat, int, dfd, const char __user *, filename, umode_t, mode, unsigned, dev);
-COMPAT_SYSCALL_WRAP5(fchownat, int, dfd, const char __user *, filename, uid_t, user, gid_t, group, int, flag);
-COMPAT_SYSCALL_WRAP3(unlinkat, int, dfd, const char __user *, pathname, int, flag);
-COMPAT_SYSCALL_WRAP4(renameat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname);
-COMPAT_SYSCALL_WRAP5(linkat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, int, flags);
-COMPAT_SYSCALL_WRAP3(symlinkat, const char __user *, oldname, int, newdfd, const char __user *, newname);
-COMPAT_SYSCALL_WRAP4(readlinkat, int, dfd, const char __user *, path, char __user *, buf, int, bufsiz);
-COMPAT_SYSCALL_WRAP3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode);
-COMPAT_SYSCALL_WRAP3(faccessat, int, dfd, const char __user *, filename, int, mode);
-COMPAT_SYSCALL_WRAP1(unshare, unsigned long, unshare_flags);
-COMPAT_SYSCALL_WRAP6(splice, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags);
-COMPAT_SYSCALL_WRAP3(getcpu, unsigned __user *, cpu, unsigned __user *, node, struct getcpu_cache __user *, cache);
-COMPAT_SYSCALL_WRAP2(pipe2, int __user *, fildes, int, flags);
-COMPAT_SYSCALL_WRAP5(perf_event_open, struct perf_event_attr __user *, attr_uptr, pid_t, pid, int, cpu, int, group_fd, unsigned long, flags);
-COMPAT_SYSCALL_WRAP5(clone, unsigned long, newsp, unsigned long, clone_flags, int __user *, parent_tidptr, int __user *, child_tidptr, unsigned long, tls);
-COMPAT_SYSCALL_WRAP4(prlimit64, pid_t, pid, unsigned int, resource, const struct rlimit64 __user *, new_rlim, struct rlimit64 __user *, old_rlim);
-COMPAT_SYSCALL_WRAP5(name_to_handle_at, int, dfd, const char __user *, name, struct file_handle __user *, handle, int __user *, mnt_id, int, flag);
-COMPAT_SYSCALL_WRAP5(kcmp, pid_t, pid1, pid_t, pid2, int, type, unsigned long, idx1, unsigned long, idx2);
-COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, flags);
-COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
-COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
-COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
-COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
-COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
-COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
-COMPAT_SYSCALL_WRAP3(s390_pci_mmio_write, const unsigned long, mmio_addr, const void __user *, user_buffer, const size_t, length);
-COMPAT_SYSCALL_WRAP3(s390_pci_mmio_read, const unsigned long, mmio_addr, void __user *, user_buffer, const size_t, length);
-COMPAT_SYSCALL_WRAP4(socketpair, int, family, int, type, int, protocol, int __user *, usockvec);
-COMPAT_SYSCALL_WRAP3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen);
-COMPAT_SYSCALL_WRAP3(connect, int, fd, struct sockaddr __user *, uservaddr, int, addrlen);
-COMPAT_SYSCALL_WRAP4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr, int __user *, upeer_addrlen, int, flags);
-COMPAT_SYSCALL_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
-COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
-COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
-COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index b1bb2b7..3627070 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -6,6 +6,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
@@ -31,7 +32,7 @@ out:
 	return ret;
 }
 
-SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
+SYSCALL_DEFINE_WRAP3(s390_pci_mmio_write, unsigned long, mmio_addr,
 		const void __user *, user_buffer, size_t, length)
 {
 	u8 local_buf[64];
@@ -71,7 +72,7 @@ out:
 	return ret;
 }
 
-SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
+SYSCALL_DEFINE_WRAP3(s390_pci_mmio_read, unsigned long, mmio_addr,
 		void __user *, user_buffer, size_t, length)
 {
 	u8 local_buf[64];
diff --git a/drivers/char/random.c b/drivers/char/random.c
index d0da5d8..4484cad 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -259,6 +259,7 @@
 #include <linux/workqueue.h>
 #include <linux/irq.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/completion.h>
 
 #include <asm/processor.h>
@@ -1598,7 +1599,7 @@ const struct file_operations urandom_fops = {
 	.llseek = noop_llseek,
 };
 
-SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
+SYSCALL_DEFINE_WRAP3(getrandom, char __user *, buf, size_t, count,
 		unsigned int, flags)
 {
 	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
diff --git a/fs/aio.c b/fs/aio.c
index 155f842..c6d1e70 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1349,7 +1349,7 @@ out:
  *	implemented.  May fail with -EINVAL if the context pointed to
  *	is invalid.
  */
-SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
+SYSCALL_DEFINE_WRAP1(io_destroy, aio_context_t, ctx)
 {
 	struct kioctx *ioctx = lookup_ioctx(ctx);
 	if (likely(NULL != ioctx)) {
@@ -1671,7 +1671,7 @@ lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb, u32 key)
  *	invalid.  May fail with -EAGAIN if the iocb specified was not
  *	cancelled.  Will fail with -ENOSYS if not implemented.
  */
-SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
+SYSCALL_DEFINE_WRAP3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		struct io_event __user *, result)
 {
 	struct kioctx *ctx;
diff --git a/fs/buffer.c b/fs/buffer.c
index 4f4cd95..394a365 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu.h>
@@ -3267,7 +3268,7 @@ EXPORT_SYMBOL(try_to_free_buffers);
  * Use of bdflush() is deprecated and will be removed in a future kernel.
  * The `flush-X' kernel threads fully replace bdflush daemons and this call.
  */
-SYSCALL_DEFINE2(bdflush, int, func, long, data)
+SYSCALL_DEFINE_WRAP2(bdflush, int, func, long, data)
 {
 	static int msg_count;
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 5c33aeb..6a83cc5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
@@ -3244,7 +3245,7 @@ static void get_fs_root_and_pwd_rcu(struct fs_struct *fs, struct path *root,
  *		return NULL;
  *	}
  */
-SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
+SYSCALL_DEFINE_WRAP2(getcwd, char __user *, buf, unsigned long, size)
 {
 	int error;
 	struct path pwd, root;
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1e009ca..01348a2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1817,7 +1817,7 @@ SYSCALL_DEFINE1(epoll_create, int, size)
  * the eventpoll file that enables the insertion/removal/change of
  * file descriptors inside the interest set.
  */
-SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
+SYSCALL_DEFINE_WRAP4(epoll_ctl, int, epfd, int, op, int, fd,
 		struct epoll_event __user *, event)
 {
 	int error;
@@ -1958,7 +1958,7 @@ error_return:
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
  */
-SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
+SYSCALL_DEFINE_WRAP4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout)
 {
 	int error;
diff --git a/fs/exec.c b/fs/exec.c
index b06623a..2e43e47 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -111,7 +111,7 @@ bool path_noexec(const struct path *path)
  *
  * Also note that we take the address to load from from the file itself.
  */
-SYSCALL_DEFINE1(uselib, const char __user *, library)
+SYSCALL_DEFINE_WRAP1(uselib, const char __user *, library)
 {
 	struct linux_binfmt *fmt;
 	struct file *file;
diff --git a/fs/fhandle.c b/fs/fhandle.c
index d59712d..048a4ee 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -1,4 +1,5 @@
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/file.h>
@@ -89,7 +90,7 @@ static long do_sys_name_to_handle(struct path *path,
  * enough space, the field is updated to return the minimum
  * value required.
  */
-SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
+SYSCALL_DEFINE_WRAP5(name_to_handle_at, int, dfd, const char __user *, name,
 		struct file_handle __user *, handle, int __user *, mnt_id,
 		int, flag)
 {
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 5797d45..6fcbe18 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -181,7 +182,7 @@ static int fs_maxindex(void)
 /*
  * Whee.. Weird sysv syscall. 
  */
-SYSCALL_DEFINE3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2)
+SYSCALL_DEFINE_WRAP3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2)
 {
 	int retval = -EINVAL;
 
diff --git a/fs/namei.c b/fs/namei.c
index 0c3974c..6ded831 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -26,6 +26,7 @@
 #include <linux/security.h>
 #include <linux/ima.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/capability.h>
@@ -3533,7 +3534,7 @@ static int may_mknod(umode_t mode)
 	}
 }
 
-SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
+SYSCALL_DEFINE_WRAP4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
 		unsigned, dev)
 {
 	struct dentry *dentry;
@@ -3575,7 +3576,7 @@ out:
 	return error;
 }
 
-SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev)
+SYSCALL_DEFINE_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev)
 {
 	return sys_mknodat(AT_FDCWD, filename, mode, dev);
 }
@@ -3606,7 +3607,7 @@ int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
+SYSCALL_DEFINE_WRAP3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -3631,7 +3632,7 @@ retry:
 	return error;
 }
 
-SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
+SYSCALL_DEFINE_WRAP2(mkdir, const char __user *, pathname, umode_t, mode)
 {
 	return sys_mkdirat(AT_FDCWD, pathname, mode);
 }
@@ -3759,7 +3760,7 @@ exit1:
 	return error;
 }
 
-SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
+SYSCALL_DEFINE_WRAP1(rmdir, const char __user *, pathname)
 {
 	return do_rmdir(AT_FDCWD, pathname);
 }
@@ -3901,7 +3902,7 @@ slashes:
 	goto exit2;
 }
 
-SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
+SYSCALL_DEFINE_WRAP3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
 {
 	if ((flag & ~AT_REMOVEDIR) != 0)
 		return -EINVAL;
@@ -3912,7 +3913,7 @@ SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
 	return do_unlinkat(dfd, pathname);
 }
 
-SYSCALL_DEFINE1(unlink, const char __user *, pathname)
+SYSCALL_DEFINE_WRAP1(unlink, const char __user *, pathname)
 {
 	return do_unlinkat(AT_FDCWD, pathname);
 }
@@ -3938,7 +3939,7 @@ int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 }
 EXPORT_SYMBOL(vfs_symlink);
 
-SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
+SYSCALL_DEFINE_WRAP3(symlinkat, const char __user *, oldname,
 		int, newdfd, const char __user *, newname)
 {
 	int error;
@@ -3969,7 +3970,7 @@ out_putname:
 	return error;
 }
 
-SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newname)
+SYSCALL_DEFINE_WRAP2(symlink, const char __user *, oldname, const char __user *, newname)
 {
 	return sys_symlinkat(oldname, AT_FDCWD, newname);
 }
@@ -4056,7 +4057,7 @@ EXPORT_SYMBOL(vfs_link);
  * with linux 2.0, and to avoid hard-linking to directories
  * and other special files.  --ADM
  */
-SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
+SYSCALL_DEFINE_WRAP5(linkat, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname, int, flags)
 {
 	struct dentry *new_dentry;
@@ -4121,7 +4122,7 @@ out:
 	return error;
 }
 
-SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname)
+SYSCALL_DEFINE_WRAP2(link, const char __user *, oldname, const char __user *, newname)
 {
 	return sys_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
@@ -4309,7 +4310,7 @@ out:
 }
 EXPORT_SYMBOL(vfs_rename);
 
-SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
+SYSCALL_DEFINE_WRAP5(renameat2, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname, unsigned int, flags)
 {
 	struct dentry *old_dentry, *new_dentry;
@@ -4452,13 +4453,13 @@ exit:
 	return error;
 }
 
-SYSCALL_DEFINE4(renameat, int, olddfd, const char __user *, oldname,
+SYSCALL_DEFINE_WRAP4(renameat, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname)
 {
 	return sys_renameat2(olddfd, oldname, newdfd, newname, 0);
 }
 
-SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newname)
+SYSCALL_DEFINE_WRAP2(rename, const char __user *, oldname, const char __user *, newname)
 {
 	return sys_renameat2(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index 0570729..6ba4afd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/capability.h>
 #include <linux/mnt_namespace.h>
@@ -1592,7 +1593,7 @@ static inline bool may_mount(void)
  * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
  */
 
-SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
+SYSCALL_DEFINE_WRAP2(umount, char __user *, name, int, flags)
 {
 	struct path path;
 	struct mount *mnt;
@@ -1637,7 +1638,7 @@ out:
 /*
  *	The 2.0 compatible umount. No flags.
  */
-SYSCALL_DEFINE1(oldumount, char __user *, name)
+SYSCALL_DEFINE_WRAP1(oldumount, char __user *, name)
 {
 	return sys_umount(name, 0);
 }
@@ -2974,7 +2975,7 @@ EXPORT_SYMBOL(path_is_under);
  *    though, so you may need to say mount --bind /nfs/my_root /nfs/my_root
  *    first.
  */
-SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
+SYSCALL_DEFINE_WRAP2(pivot_root, const char __user *, new_root,
 		const char __user *, put_old)
 {
 	struct path new, old, parent_path, root_parent, root;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index b8d08d0..713a670 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -33,6 +33,7 @@
 #include <linux/sched.h> /* struct user */
 #include <linux/slab.h> /* struct kmem_cache */
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/anon_inodes.h>
 #include <linux/uaccess.h>
@@ -696,7 +697,7 @@ SYSCALL_DEFINE0(inotify_init)
 	return sys_inotify_init1(0);
 }
 
-SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP3(inotify_add_watch, int, fd, const char __user *, pathname,
 		u32, mask)
 {
 	struct fsnotify_group *group;
diff --git a/fs/open.c b/fs/open.c
index b6f1e96..8dae6c7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -334,7 +334,7 @@ SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
  */
-SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
+SYSCALL_DEFINE_WRAP3(faccessat, int, dfd, const char __user *, filename, int, mode)
 {
 	const struct cred *old_cred;
 	struct cred *override_cred;
@@ -410,12 +410,12 @@ out:
 	return res;
 }
 
-SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
+SYSCALL_DEFINE_WRAP2(access, const char __user *, filename, int, mode)
 {
 	return sys_faccessat(AT_FDCWD, filename, mode);
 }
 
-SYSCALL_DEFINE1(chdir, const char __user *, filename)
+SYSCALL_DEFINE_WRAP1(chdir, const char __user *, filename)
 {
 	struct path path;
 	int error;
@@ -466,7 +466,7 @@ out:
 	return error;
 }
 
-SYSCALL_DEFINE1(chroot, const char __user *, filename)
+SYSCALL_DEFINE_WRAP1(chroot, const char __user *, filename)
 {
 	struct path path;
 	int error;
@@ -541,7 +541,7 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return err;
 }
 
-SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode)
+SYSCALL_DEFINE_WRAP3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode)
 {
 	struct path path;
 	int error;
@@ -559,7 +559,7 @@ retry:
 	return error;
 }
 
-SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
+SYSCALL_DEFINE_WRAP2(chmod, const char __user *, filename, umode_t, mode)
 {
 	return sys_fchmodat(AT_FDCWD, filename, mode);
 }
@@ -606,7 +606,7 @@ retry_deleg:
 	return error;
 }
 
-SYSCALL_DEFINE5(fchownat, int, dfd, const char __user *, filename, uid_t, user,
+SYSCALL_DEFINE_WRAP5(fchownat, int, dfd, const char __user *, filename, uid_t, user,
 		gid_t, group, int, flag)
 {
 	struct path path;
@@ -638,12 +638,12 @@ out:
 	return error;
 }
 
-SYSCALL_DEFINE3(chown, const char __user *, filename, uid_t, user, gid_t, group)
+SYSCALL_DEFINE_WRAP3(chown, const char __user *, filename, uid_t, user, gid_t, group)
 {
 	return sys_fchownat(AT_FDCWD, filename, user, group, 0);
 }
 
-SYSCALL_DEFINE3(lchown, const char __user *, filename, uid_t, user, gid_t, group)
+SYSCALL_DEFINE_WRAP3(lchown, const char __user *, filename, uid_t, user, gid_t, group)
 {
 	return sys_fchownat(AT_FDCWD, filename, user, group,
 			    AT_SYMLINK_NOFOLLOW);
@@ -1058,7 +1058,7 @@ SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
  * For backward compatibility?  Maybe this should be moved
  * into arch/i386 instead?
  */
-SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
+SYSCALL_DEFINE_WRAP2(creat, const char __user *, pathname, umode_t, mode)
 {
 	return sys_open(pathname, O_CREAT | O_WRONLY | O_TRUNC, mode);
 }
diff --git a/fs/pipe.c b/fs/pipe.c
index 42cf8dd..07ce638 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/audit.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/fcntl.h>
 
 #include <asm/uaccess.h>
@@ -776,7 +777,7 @@ int do_pipe_flags(int *fd, int flags)
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, though.
  */
-SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
+SYSCALL_DEFINE_WRAP2(pipe2, int __user *, fildes, int, flags)
 {
 	struct file *files[2];
 	int fd[2];
@@ -798,7 +799,7 @@ SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
 	return error;
 }
 
-SYSCALL_DEFINE1(pipe, int __user *, fildes)
+SYSCALL_DEFINE_WRAP1(pipe, int __user *, fildes)
 {
 	return sys_pipe2(fildes, 0);
 }
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 3746367..5738db8 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/capability.h>
 #include <linux/quotaops.h>
 #include <linux/types.h>
@@ -757,7 +758,7 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
  * calls. Maybe we need to add the process quotas etc. in the future,
  * but we probably should use rlimits for that.
  */
-SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
+SYSCALL_DEFINE_WRAP4(quotactl, unsigned int, cmd, const char __user *, special,
 		qid_t, id, void __user *, addr)
 {
 	uint cmds, type;
diff --git a/fs/read_write.c b/fs/read_write.c
index 819ef3f..7e2b232 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -299,7 +299,7 @@ COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned i
 #endif
 
 #ifdef __ARCH_WANT_SYS_LLSEEK
-SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
+SYSCALL_DEFINE_WRAP5(llseek, unsigned int, fd, unsigned long, offset_high,
 		unsigned long, offset_low, loff_t __user *, result,
 		unsigned int, whence)
 {
diff --git a/fs/select.c b/fs/select.c
index 0155473..28e1ca6 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
@@ -954,7 +955,7 @@ static long do_restart_poll(struct restart_block *restart_block)
 	return ret;
 }
 
-SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
+SYSCALL_DEFINE_WRAP3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		int, timeout_msecs)
 {
 	struct timespec end_time, *to = NULL;
diff --git a/fs/splice.c b/fs/splice.c
index 4cf700d..b0ab438 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1683,7 +1683,7 @@ COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, io
 }
 #endif
 
-SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
+SYSCALL_DEFINE_WRAP6(splice, int, fd_in, loff_t __user *, off_in,
 		int, fd_out, loff_t __user *, off_out,
 		size_t, len, unsigned int, flags)
 {
@@ -2016,7 +2016,7 @@ static long do_tee(struct file *in, struct file *out, size_t len,
 	return ret;
 }
 
-SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
+SYSCALL_DEFINE_WRAP4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
 {
 	struct fd in;
 	int error;
diff --git a/fs/stat.c b/fs/stat.c
index d4a61d8..f4ddfdb 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -13,6 +13,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
@@ -312,7 +313,7 @@ SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
 	return error;
 }
 
-SYSCALL_DEFINE4(readlinkat, int, dfd, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP4(readlinkat, int, dfd, const char __user *, pathname,
 		char __user *, buf, int, bufsiz)
 {
 	struct path path;
@@ -346,7 +347,7 @@ retry:
 	return error;
 }
 
-SYSCALL_DEFINE3(readlink, const char __user *, path, char __user *, buf,
+SYSCALL_DEFINE_WRAP3(readlink, const char __user *, path, char __user *, buf,
 		int, bufsiz)
 {
 	return sys_readlinkat(AT_FDCWD, path, buf, bufsiz);
diff --git a/fs/xattr.c b/fs/xattr.c
index 9b932b9..3a7223f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 #include <linux/evm.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/fsnotify.h>
 #include <linux/audit.h>
@@ -387,21 +388,21 @@ retry:
 	return error;
 }
 
-SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP5(setxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
 	return path_setxattr(pathname, name, value, size, flags, LOOKUP_FOLLOW);
 }
 
-SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP5(lsetxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
 	return path_setxattr(pathname, name, value, size, flags, 0);
 }
 
-SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
+SYSCALL_DEFINE_WRAP5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
 	struct fd f = fdget(fd);
@@ -487,19 +488,19 @@ retry:
 	return error;
 }
 
-SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP4(getxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
 	return path_getxattr(pathname, name, value, size, LOOKUP_FOLLOW);
 }
 
-SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP4(lgetxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
 	return path_getxattr(pathname, name, value, size, 0);
 }
 
-SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
+SYSCALL_DEFINE_WRAP4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
 	struct fd f = fdget(fd);
@@ -569,19 +570,19 @@ retry:
 	return error;
 }
 
-SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
+SYSCALL_DEFINE_WRAP3(listxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
 	return path_listxattr(pathname, list, size, LOOKUP_FOLLOW);
 }
 
-SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
+SYSCALL_DEFINE_WRAP3(llistxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
 	return path_listxattr(pathname, list, size, 0);
 }
 
-SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
+SYSCALL_DEFINE_WRAP3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
 	struct fd f = fdget(fd);
 	ssize_t error = -EBADF;
@@ -634,19 +635,19 @@ retry:
 	return error;
 }
 
-SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP2(removexattr, const char __user *, pathname,
 		const char __user *, name)
 {
 	return path_removexattr(pathname, name, LOOKUP_FOLLOW);
 }
 
-SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
+SYSCALL_DEFINE_WRAP2(lremovexattr, const char __user *, pathname,
 		const char __user *, name)
 {
 	return path_removexattr(pathname, name, 0);
 }
 
-SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
+SYSCALL_DEFINE_WRAP2(fremovexattr, int, fd, const char __user *, name)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a8380ad..705d841 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -36,43 +36,43 @@
 #define __NR_io_setup 0
 __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
 #define __NR_io_destroy 1
-__SYSCALL(__NR_io_destroy, sys_io_destroy)
+__SC_WRAP(__NR_io_destroy, sys_io_destroy)
 #define __NR_io_submit 2
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
-__SYSCALL(__NR_io_cancel, sys_io_cancel)
+__SC_WRAP(__NR_io_cancel, sys_io_cancel)
 #define __NR_io_getevents 4
 __SC_COMP(__NR_io_getevents, sys_io_getevents, compat_sys_io_getevents)
 
 /* fs/xattr.c */
 #define __NR_setxattr 5
-__SYSCALL(__NR_setxattr, sys_setxattr)
+__SC_WRAP(__NR_setxattr, sys_setxattr)
 #define __NR_lsetxattr 6
-__SYSCALL(__NR_lsetxattr, sys_lsetxattr)
+__SC_WRAP(__NR_lsetxattr, sys_lsetxattr)
 #define __NR_fsetxattr 7
-__SYSCALL(__NR_fsetxattr, sys_fsetxattr)
+__SC_WRAP(__NR_fsetxattr, sys_fsetxattr)
 #define __NR_getxattr 8
-__SYSCALL(__NR_getxattr, sys_getxattr)
+__SC_WRAP(__NR_getxattr, sys_getxattr)
 #define __NR_lgetxattr 9
-__SYSCALL(__NR_lgetxattr, sys_lgetxattr)
+__SC_WRAP(__NR_lgetxattr, sys_lgetxattr)
 #define __NR_fgetxattr 10
-__SYSCALL(__NR_fgetxattr, sys_fgetxattr)
+__SC_WRAP(__NR_fgetxattr, sys_fgetxattr)
 #define __NR_listxattr 11
-__SYSCALL(__NR_listxattr, sys_listxattr)
+__SC_WRAP(__NR_listxattr, sys_listxattr)
 #define __NR_llistxattr 12
-__SYSCALL(__NR_llistxattr, sys_llistxattr)
+__SC_WRAP(__NR_llistxattr, sys_llistxattr)
 #define __NR_flistxattr 13
-__SYSCALL(__NR_flistxattr, sys_flistxattr)
+__SC_WRAP(__NR_flistxattr, sys_flistxattr)
 #define __NR_removexattr 14
-__SYSCALL(__NR_removexattr, sys_removexattr)
+__SC_WRAP(__NR_removexattr, sys_removexattr)
 #define __NR_lremovexattr 15
-__SYSCALL(__NR_lremovexattr, sys_lremovexattr)
+__SC_WRAP(__NR_lremovexattr, sys_lremovexattr)
 #define __NR_fremovexattr 16
-__SYSCALL(__NR_fremovexattr, sys_fremovexattr)
+__SC_WRAP(__NR_fremovexattr, sys_fremovexattr)
 
 /* fs/dcache.c */
 #define __NR_getcwd 17
-__SYSCALL(__NR_getcwd, sys_getcwd)
+__SC_WRAP(__NR_getcwd, sys_getcwd)
 
 /* fs/cookies.c */
 #define __NR_lookup_dcookie 18
@@ -86,7 +86,7 @@ __SYSCALL(__NR_eventfd2, sys_eventfd2)
 #define __NR_epoll_create1 20
 __SYSCALL(__NR_epoll_create1, sys_epoll_create1)
 #define __NR_epoll_ctl 21
-__SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
+__SC_WRAP(__NR_epoll_ctl, sys_epoll_ctl)
 #define __NR_epoll_pwait 22
 __SC_COMP(__NR_epoll_pwait, sys_epoll_pwait, compat_sys_epoll_pwait)
 
@@ -102,7 +102,7 @@ __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
 #define __NR_inotify_init1 26
 __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
 #define __NR_inotify_add_watch 27
-__SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
+__SC_WRAP(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch 28
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 
@@ -122,17 +122,17 @@ __SYSCALL(__NR_flock, sys_flock)
 
 /* fs/namei.c */
 #define __NR_mknodat 33
-__SYSCALL(__NR_mknodat, sys_mknodat)
+__SC_WRAP(__NR_mknodat, sys_mknodat)
 #define __NR_mkdirat 34
-__SYSCALL(__NR_mkdirat, sys_mkdirat)
+__SC_WRAP(__NR_mkdirat, sys_mkdirat)
 #define __NR_unlinkat 35
-__SYSCALL(__NR_unlinkat, sys_unlinkat)
+__SC_WRAP(__NR_unlinkat, sys_unlinkat)
 #define __NR_symlinkat 36
-__SYSCALL(__NR_symlinkat, sys_symlinkat)
+__SC_WRAP(__NR_symlinkat, sys_symlinkat)
 #define __NR_linkat 37
-__SYSCALL(__NR_linkat, sys_linkat)
+__SC_WRAP(__NR_linkat, sys_linkat)
 #define __NR_renameat 38
-__SYSCALL(__NR_renameat, sys_renameat)
+__SC_WRAP(__NR_renameat, sys_renameat)
 
 /* fs/namespace.c */
 #define __NR_umount2 39
@@ -140,7 +140,7 @@ __SYSCALL(__NR_umount2, sys_umount)
 #define __NR_mount 40
 __SC_COMP(__NR_mount, sys_mount, compat_sys_mount)
 #define __NR_pivot_root 41
-__SYSCALL(__NR_pivot_root, sys_pivot_root)
+__SC_WRAP(__NR_pivot_root, sys_pivot_root)
 
 /* fs/nfsctl.c */
 #define __NR_nfsservctl 42
@@ -163,19 +163,19 @@ __SC_COMP_3264(__NR3264_ftruncate, sys_ftruncate64, sys_ftruncate, \
 #define __NR_fallocate 47
 __SC_COMP(__NR_fallocate, sys_fallocate, compat_sys_fallocate)
 #define __NR_faccessat 48
-__SYSCALL(__NR_faccessat, sys_faccessat)
+__SC_WRAP(__NR_faccessat, sys_faccessat)
 #define __NR_chdir 49
-__SYSCALL(__NR_chdir, sys_chdir)
+__SC_WRAP(__NR_chdir, sys_chdir)
 #define __NR_fchdir 50
 __SYSCALL(__NR_fchdir, sys_fchdir)
 #define __NR_chroot 51
-__SYSCALL(__NR_chroot, sys_chroot)
+__SC_WRAP(__NR_chroot, sys_chroot)
 #define __NR_fchmod 52
 __SYSCALL(__NR_fchmod, sys_fchmod)
 #define __NR_fchmodat 53
-__SYSCALL(__NR_fchmodat, sys_fchmodat)
+__SC_WRAP(__NR_fchmodat, sys_fchmodat)
 #define __NR_fchownat 54
-__SYSCALL(__NR_fchownat, sys_fchownat)
+__SC_WRAP(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
@@ -187,11 +187,11 @@ __SYSCALL(__NR_vhangup, sys_vhangup)
 
 /* fs/pipe.c */
 #define __NR_pipe2 59
-__SYSCALL(__NR_pipe2, sys_pipe2)
+__SC_WRAP(__NR_pipe2, sys_pipe2)
 
 /* fs/quota.c */
 #define __NR_quotactl 60
-__SYSCALL(__NR_quotactl, sys_quotactl)
+__SC_WRAP(__NR_quotactl, sys_quotactl)
 
 /* fs/readdir.c */
 #define __NR_getdents64 61
@@ -236,13 +236,13 @@ __SC_COMP(__NR_signalfd4, sys_signalfd4, compat_sys_signalfd4)
 #define __NR_vmsplice 75
 __SC_COMP(__NR_vmsplice, sys_vmsplice, compat_sys_vmsplice)
 #define __NR_splice 76
-__SYSCALL(__NR_splice, sys_splice)
+__SC_WRAP(__NR_splice, sys_splice)
 #define __NR_tee 77
-__SYSCALL(__NR_tee, sys_tee)
+__SC_WRAP(__NR_tee, sys_tee)
 
 /* fs/stat.c */
 #define __NR_readlinkat 78
-__SYSCALL(__NR_readlinkat, sys_readlinkat)
+__SC_WRAP(__NR_readlinkat, sys_readlinkat)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 #define __NR3264_fstat 80
@@ -281,13 +281,13 @@ __SC_COMP(__NR_utimensat, sys_utimensat, compat_sys_utimensat)
 
 /* kernel/acct.c */
 #define __NR_acct 89
-__SYSCALL(__NR_acct, sys_acct)
+__SC_WRAP(__NR_acct, sys_acct)
 
 /* kernel/capability.c */
 #define __NR_capget 90
-__SYSCALL(__NR_capget, sys_capget)
+__SC_WRAP(__NR_capget, sys_capget)
 #define __NR_capset 91
-__SYSCALL(__NR_capset, sys_capset)
+__SC_WRAP(__NR_capset, sys_capset)
 
 /* kernel/exec_domain.c */
 #define __NR_personality 92
@@ -303,9 +303,9 @@ __SC_COMP(__NR_waitid, sys_waitid, compat_sys_waitid)
 
 /* kernel/fork.c */
 #define __NR_set_tid_address 96
-__SYSCALL(__NR_set_tid_address, sys_set_tid_address)
+__SC_WRAP(__NR_set_tid_address, sys_set_tid_address)
 #define __NR_unshare 97
-__SYSCALL(__NR_unshare, sys_unshare)
+__SC_WRAP(__NR_unshare, sys_unshare)
 
 /* kernel/futex.c */
 #define __NR_futex 98
@@ -333,9 +333,9 @@ __SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
 
 /* kernel/module.c */
 #define __NR_init_module 105
-__SYSCALL(__NR_init_module, sys_init_module)
+__SC_WRAP(__NR_init_module, sys_init_module)
 #define __NR_delete_module 106
-__SYSCALL(__NR_delete_module, sys_delete_module)
+__SC_WRAP(__NR_delete_module, sys_delete_module)
 
 /* kernel/posix-timers.c */
 #define __NR_timer_create 107
@@ -360,7 +360,7 @@ __SC_COMP(__NR_clock_nanosleep, sys_clock_nanosleep, \
 
 /* kernel/printk.c */
 #define __NR_syslog 116
-__SYSCALL(__NR_syslog, sys_syslog)
+__SC_WRAP(__NR_syslog, sys_syslog)
 
 /* kernel/ptrace.c */
 #define __NR_ptrace 117
@@ -368,13 +368,13 @@ __SYSCALL(__NR_ptrace, sys_ptrace)
 
 /* kernel/sched/core.c */
 #define __NR_sched_setparam 118
-__SYSCALL(__NR_sched_setparam, sys_sched_setparam)
+__SC_WRAP(__NR_sched_setparam, sys_sched_setparam)
 #define __NR_sched_setscheduler 119
-__SYSCALL(__NR_sched_setscheduler, sys_sched_setscheduler)
+__SC_WRAP(__NR_sched_setscheduler, sys_sched_setscheduler)
 #define __NR_sched_getscheduler 120
 __SYSCALL(__NR_sched_getscheduler, sys_sched_getscheduler)
 #define __NR_sched_getparam 121
-__SYSCALL(__NR_sched_getparam, sys_sched_getparam)
+__SC_WRAP(__NR_sched_getparam, sys_sched_getparam)
 #define __NR_sched_setaffinity 122
 __SC_COMP(__NR_sched_setaffinity, sys_sched_setaffinity, \
 	  compat_sys_sched_setaffinity)
@@ -425,7 +425,7 @@ __SYSCALL(__NR_setpriority, sys_setpriority)
 #define __NR_getpriority 141
 __SYSCALL(__NR_getpriority, sys_getpriority)
 #define __NR_reboot 142
-__SYSCALL(__NR_reboot, sys_reboot)
+__SC_WRAP(__NR_reboot, sys_reboot)
 #define __NR_setregid 143
 __SYSCALL(__NR_setregid, sys_setregid)
 #define __NR_setgid 144
@@ -437,11 +437,11 @@ __SYSCALL(__NR_setuid, sys_setuid)
 #define __NR_setresuid 147
 __SYSCALL(__NR_setresuid, sys_setresuid)
 #define __NR_getresuid 148
-__SYSCALL(__NR_getresuid, sys_getresuid)
+__SC_WRAP(__NR_getresuid, sys_getresuid)
 #define __NR_setresgid 149
 __SYSCALL(__NR_setresgid, sys_setresgid)
 #define __NR_getresgid 150
-__SYSCALL(__NR_getresgid, sys_getresgid)
+__SC_WRAP(__NR_getresgid, sys_getresgid)
 #define __NR_setfsuid 151
 __SYSCALL(__NR_setfsuid, sys_setfsuid)
 #define __NR_setfsgid 152
@@ -457,15 +457,15 @@ __SYSCALL(__NR_getsid, sys_getsid)
 #define __NR_setsid 157
 __SYSCALL(__NR_setsid, sys_setsid)
 #define __NR_getgroups 158
-__SYSCALL(__NR_getgroups, sys_getgroups)
+__SC_WRAP(__NR_getgroups, sys_getgroups)
 #define __NR_setgroups 159
-__SYSCALL(__NR_setgroups, sys_setgroups)
+__SC_WRAP(__NR_setgroups, sys_setgroups)
 #define __NR_uname 160
-__SYSCALL(__NR_uname, sys_newuname)
+__SC_WRAP(__NR_uname, sys_newuname)
 #define __NR_sethostname 161
-__SYSCALL(__NR_sethostname, sys_sethostname)
+__SC_WRAP(__NR_sethostname, sys_sethostname)
 #define __NR_setdomainname 162
-__SYSCALL(__NR_setdomainname, sys_setdomainname)
+__SC_WRAP(__NR_setdomainname, sys_setdomainname)
 #define __NR_getrlimit 163
 __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
 #define __NR_setrlimit 164
@@ -475,9 +475,9 @@ __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
 #define __NR_umask 166
 __SYSCALL(__NR_umask, sys_umask)
 #define __NR_prctl 167
-__SYSCALL(__NR_prctl, sys_prctl)
+__SC_WRAP(__NR_prctl, sys_prctl)
 #define __NR_getcpu 168
-__SYSCALL(__NR_getcpu, sys_getcpu)
+__SC_WRAP(__NR_getcpu, sys_getcpu)
 
 /* kernel/time.c */
 #define __NR_gettimeofday 169
@@ -509,7 +509,7 @@ __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
 #define __NR_mq_open 180
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
-__SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+__SC_WRAP(__NR_mq_unlink, sys_mq_unlink)
 #define __NR_mq_timedsend 182
 __SC_COMP(__NR_mq_timedsend, sys_mq_timedsend, compat_sys_mq_timedsend)
 #define __NR_mq_timedreceive 183
@@ -554,21 +554,21 @@ __SYSCALL(__NR_shmdt, sys_shmdt)
 #define __NR_socket 198
 __SYSCALL(__NR_socket, sys_socket)
 #define __NR_socketpair 199
-__SYSCALL(__NR_socketpair, sys_socketpair)
+__SC_WRAP(__NR_socketpair, sys_socketpair)
 #define __NR_bind 200
-__SYSCALL(__NR_bind, sys_bind)
+__SC_WRAP(__NR_bind, sys_bind)
 #define __NR_listen 201
 __SYSCALL(__NR_listen, sys_listen)
 #define __NR_accept 202
 __SYSCALL(__NR_accept, sys_accept)
 #define __NR_connect 203
-__SYSCALL(__NR_connect, sys_connect)
+__SC_WRAP(__NR_connect, sys_connect)
 #define __NR_getsockname 204
-__SYSCALL(__NR_getsockname, sys_getsockname)
+__SC_WRAP(__NR_getsockname, sys_getsockname)
 #define __NR_getpeername 205
-__SYSCALL(__NR_getpeername, sys_getpeername)
+__SC_WRAP(__NR_getpeername, sys_getpeername)
 #define __NR_sendto 206
-__SYSCALL(__NR_sendto, sys_sendto)
+__SC_WRAP(__NR_sendto, sys_sendto)
 #define __NR_recvfrom 207
 __SC_COMP(__NR_recvfrom, sys_recvfrom, compat_sys_recvfrom)
 #define __NR_setsockopt 208
@@ -588,23 +588,23 @@ __SC_COMP(__NR_readahead, sys_readahead, compat_sys_readahead)
 
 /* mm/nommu.c, also with MMU */
 #define __NR_brk 214
-__SYSCALL(__NR_brk, sys_brk)
+__SC_WRAP(__NR_brk, sys_brk)
 #define __NR_munmap 215
-__SYSCALL(__NR_munmap, sys_munmap)
+__SC_WRAP(__NR_munmap, sys_munmap)
 #define __NR_mremap 216
-__SYSCALL(__NR_mremap, sys_mremap)
+__SC_WRAP(__NR_mremap, sys_mremap)
 
 /* security/keys/keyctl.c */
 #define __NR_add_key 217
-__SYSCALL(__NR_add_key, sys_add_key)
+__SC_WRAP(__NR_add_key, sys_add_key)
 #define __NR_request_key 218
-__SYSCALL(__NR_request_key, sys_request_key)
+__SC_WRAP(__NR_request_key, sys_request_key)
 #define __NR_keyctl 219
 __SC_COMP(__NR_keyctl, sys_keyctl, compat_sys_keyctl)
 
 /* arch/example/kernel/sys_example.c */
 #define __NR_clone 220
-__SYSCALL(__NR_clone, sys_clone)
+__SC_WRAP(__NR_clone, sys_clone)
 #define __NR_execve 221
 __SC_COMP(__NR_execve, sys_execve, compat_sys_execve)
 
@@ -617,27 +617,27 @@ __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
 /* mm/, CONFIG_MMU only */
 #ifndef __ARCH_NOMMU
 #define __NR_swapon 224
-__SYSCALL(__NR_swapon, sys_swapon)
+__SC_WRAP(__NR_swapon, sys_swapon)
 #define __NR_swapoff 225
-__SYSCALL(__NR_swapoff, sys_swapoff)
+__SC_WRAP(__NR_swapoff, sys_swapoff)
 #define __NR_mprotect 226
-__SYSCALL(__NR_mprotect, sys_mprotect)
+__SC_WRAP(__NR_mprotect, sys_mprotect)
 #define __NR_msync 227
-__SYSCALL(__NR_msync, sys_msync)
+__SC_WRAP(__NR_msync, sys_msync)
 #define __NR_mlock 228
-__SYSCALL(__NR_mlock, sys_mlock)
+__SC_WRAP(__NR_mlock, sys_mlock)
 #define __NR_munlock 229
-__SYSCALL(__NR_munlock, sys_munlock)
+__SC_WRAP(__NR_munlock, sys_munlock)
 #define __NR_mlockall 230
 __SYSCALL(__NR_mlockall, sys_mlockall)
 #define __NR_munlockall 231
 __SYSCALL(__NR_munlockall, sys_munlockall)
 #define __NR_mincore 232
-__SYSCALL(__NR_mincore, sys_mincore)
+__SC_WRAP(__NR_mincore, sys_mincore)
 #define __NR_madvise 233
-__SYSCALL(__NR_madvise, sys_madvise)
+__SC_WRAP(__NR_madvise, sys_madvise)
 #define __NR_remap_file_pages 234
-__SYSCALL(__NR_remap_file_pages, sys_remap_file_pages)
+__SC_WRAP(__NR_remap_file_pages, sys_remap_file_pages)
 #define __NR_mbind 235
 __SC_COMP(__NR_mbind, sys_mbind, compat_sys_mbind)
 #define __NR_get_mempolicy 236
@@ -654,9 +654,9 @@ __SC_COMP(__NR_move_pages, sys_move_pages, compat_sys_move_pages)
 __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 	  compat_sys_rt_tgsigqueueinfo)
 #define __NR_perf_event_open 241
-__SYSCALL(__NR_perf_event_open, sys_perf_event_open)
+__SC_WRAP(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
-__SYSCALL(__NR_accept4, sys_accept4)
+__SC_WRAP(__NR_accept4, sys_accept4)
 #define __NR_recvmmsg 243
 __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
 
@@ -669,13 +669,13 @@ __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
 #define __NR_prlimit64 261
-__SYSCALL(__NR_prlimit64, sys_prlimit64)
+__SC_WRAP(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
 __SYSCALL(__NR_fanotify_init, sys_fanotify_init)
 #define __NR_fanotify_mark 263
 __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
-__SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
+__SC_WRAP(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
 __SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
 	  compat_sys_open_by_handle_at)
@@ -694,23 +694,23 @@ __SC_COMP(__NR_process_vm_readv, sys_process_vm_readv, \
 __SC_COMP(__NR_process_vm_writev, sys_process_vm_writev, \
           compat_sys_process_vm_writev)
 #define __NR_kcmp 272
-__SYSCALL(__NR_kcmp, sys_kcmp)
+__SC_WRAP(__NR_kcmp, sys_kcmp)
 #define __NR_finit_module 273
-__SYSCALL(__NR_finit_module, sys_finit_module)
+__SC_WRAP(__NR_finit_module, sys_finit_module)
 #define __NR_sched_setattr 274
-__SYSCALL(__NR_sched_setattr, sys_sched_setattr)
+__SC_WRAP(__NR_sched_setattr, sys_sched_setattr)
 #define __NR_sched_getattr 275
-__SYSCALL(__NR_sched_getattr, sys_sched_getattr)
+__SC_WRAP(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 276
-__SYSCALL(__NR_renameat2, sys_renameat2)
+__SC_WRAP(__NR_renameat2, sys_renameat2)
 #define __NR_seccomp 277
-__SYSCALL(__NR_seccomp, sys_seccomp)
+__SC_WRAP(__NR_seccomp, sys_seccomp)
 #define __NR_getrandom 278
-__SYSCALL(__NR_getrandom, sys_getrandom)
+__SC_WRAP(__NR_getrandom, sys_getrandom)
 #define __NR_memfd_create 279
-__SYSCALL(__NR_memfd_create, sys_memfd_create)
+__SC_WRAP(__NR_memfd_create, sys_memfd_create)
 #define __NR_bpf 280
-__SYSCALL(__NR_bpf, sys_bpf)
+__SC_WRAP(__NR_bpf, sys_bpf)
 #define __NR_execveat 281
 __SC_COMP(__NR_execveat, sys_execveat, compat_sys_execveat)
 #define __NR_userfaultfd 282
@@ -718,7 +718,7 @@ __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 283
 __SYSCALL(__NR_membarrier, sys_membarrier)
 #define __NR_mlock2 284
-__SYSCALL(__NR_mlock2, sys_mlock2)
+__SC_WRAP(__NR_mlock2, sys_mlock2)
 
 #undef __NR_syscalls
 #define __NR_syscalls 285
@@ -735,29 +735,29 @@ __SYSCALL(__NR_mlock2, sys_mlock2)
 #define __NR_open 1024
 __SYSCALL(__NR_open, sys_open)
 #define __NR_link 1025
-__SYSCALL(__NR_link, sys_link)
+__SC_WRAP(__NR_link, sys_link)
 #define __NR_unlink 1026
-__SYSCALL(__NR_unlink, sys_unlink)
+__SC_WRAP(__NR_unlink, sys_unlink)
 #define __NR_mknod 1027
-__SYSCALL(__NR_mknod, sys_mknod)
+__SC_WRAP(__NR_mknod, sys_mknod)
 #define __NR_chmod 1028
-__SYSCALL(__NR_chmod, sys_chmod)
+__SC_WRAP(__NR_chmod, sys_chmod)
 #define __NR_chown 1029
-__SYSCALL(__NR_chown, sys_chown)
+__SC_WRAP(__NR_chown, sys_chown)
 #define __NR_mkdir 1030
-__SYSCALL(__NR_mkdir, sys_mkdir)
+__SC_WRAP(__NR_mkdir, sys_mkdir)
 #define __NR_rmdir 1031
-__SYSCALL(__NR_rmdir, sys_rmdir)
+__SC_WRAP(__NR_rmdir, sys_rmdir)
 #define __NR_lchown 1032
-__SYSCALL(__NR_lchown, sys_lchown)
+__SC_WRAP(__NR_lchown, sys_lchown)
 #define __NR_access 1033
-__SYSCALL(__NR_access, sys_access)
+__SC_WRAP(__NR_access, sys_access)
 #define __NR_rename 1034
-__SYSCALL(__NR_rename, sys_rename)
+__SC_WRAP(__NR_rename, sys_rename)
 #define __NR_readlink 1035
-__SYSCALL(__NR_readlink, sys_readlink)
+__SC_WRAP(__NR_readlink, sys_readlink)
 #define __NR_symlink 1036
-__SYSCALL(__NR_symlink, sys_symlink)
+__SC_WRAP(__NR_symlink, sys_symlink)
 #define __NR_utimes 1037
 __SYSCALL(__NR_utimes, sys_utimes)
 #define __NR3264_stat 1038
@@ -771,7 +771,7 @@ __SC_3264(__NR3264_lstat, sys_lstat64, sys_newlstat)
 
 #ifdef __ARCH_WANT_SYSCALL_NO_FLAGS
 #define __NR_pipe 1040
-__SYSCALL(__NR_pipe, sys_pipe)
+__SC_WRAP(__NR_pipe, sys_pipe)
 #define __NR_dup2 1041
 __SYSCALL(__NR_dup2, sys_dup2)
 #define __NR_epoll_create 1042
@@ -841,7 +841,7 @@ __SYSCALL(__NR_time, sys_time)
 __SYSCALL(__NR_utime, sys_utime)
 
 #define __NR_creat 1064
-__SYSCALL(__NR_creat, sys_creat)
+__SC_WRAP(__NR_creat, sys_creat)
 #define __NR_getdents 1065
 #define __ARCH_WANT_SYS_GETDENTS
 __SYSCALL(__NR_getdents, sys_getdents)
@@ -851,9 +851,9 @@ __SYSCALL(__NR_futimesat, sys_futimesat)
 #define __ARCH_WANT_SYS_SELECT
 __SYSCALL(__NR_select, sys_select)
 #define __NR_poll 1068
-__SYSCALL(__NR_poll, sys_poll)
+__SC_WRAP(__NR_poll, sys_poll)
 #define __NR_epoll_wait 1069
-__SYSCALL(__NR_epoll_wait, sys_epoll_wait)
+__SC_WRAP(__NR_epoll_wait, sys_epoll_wait)
 #define __NR_ustat 1070
 __SYSCALL(__NR_ustat, sys_ustat)
 #define __NR_vfork 1071
@@ -865,12 +865,12 @@ __SYSCALL(__NR_recv, sys_recv)
 #define __NR_send 1074
 __SYSCALL(__NR_send, sys_send)
 #define __NR_bdflush 1075
-__SYSCALL(__NR_bdflush, sys_bdflush)
+__SC_WRAP(__NR_bdflush, sys_bdflush)
 #define __NR_umount 1076
-__SYSCALL(__NR_umount, sys_oldumount)
+__SC_WRAP(__NR_umount, sys_oldumount)
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __NR_uselib 1077
-__SYSCALL(__NR_uselib, sys_uselib)
+__SC_WRAP(__NR_uselib, sys_uselib)
 #define __NR__sysctl 1078
 __SYSCALL(__NR__sysctl, sys_sysctl)
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 161a180..01b8d15 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -27,6 +27,7 @@
 #include <linux/vmalloc.h>
 #include <linux/netlink.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/audit.h>
 #include <linux/signal.h>
 #include <linux/mutex.h>
@@ -849,7 +850,7 @@ out_putname:
 	return fd;
 }
 
-SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
+SYSCALL_DEFINE_WRAP1(mq_unlink, const char __user *, u_name)
 {
 	int err;
 	struct filename *name;
diff --git a/kernel/acct.c b/kernel/acct.c
index 74963d1..76fc391 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -54,6 +54,7 @@
 #include <linux/jiffies.h>
 #include <linux/times.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/uaccess.h>
 #include <asm/div64.h>
@@ -267,7 +268,7 @@ static DEFINE_MUTEX(acct_on_mutex);
  * should be written. If the filename is NULL, accounting will be
  * shutdown.
  */
-SYSCALL_DEFINE1(acct, const char __user *, name)
+SYSCALL_DEFINE_WRAP1(acct, const char __user *, name)
 {
 	int error = 0;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b39550..bfd5e87 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -11,6 +11,7 @@
  */
 #include <linux/bpf.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
 #include <linux/file.h>
@@ -706,7 +707,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
 	return bpf_obj_get_user(u64_to_ptr(attr->pathname));
 }
 
-SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
+SYSCALL_DEFINE_WRAP3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
 {
 	union bpf_attr attr = {};
 	int err;
diff --git a/kernel/capability.c b/kernel/capability.c
index 45432b5..f353690 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <asm/uaccess.h>
@@ -146,7 +147,7 @@ static inline int cap_get_target_pid(pid_t pid, kernel_cap_t *pEp,
  *
  * Returns 0 on success and < 0 on error.
  */
-SYSCALL_DEFINE2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
+SYSCALL_DEFINE_WRAP2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
 {
 	int ret = 0;
 	pid_t pid;
@@ -220,7 +221,7 @@ SYSCALL_DEFINE2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
  *
  * Returns 0 on success and < 0 on error.
  */
-SYSCALL_DEFINE2(capset, cap_user_header_t, header, const cap_user_data_t, data)
+SYSCALL_DEFINE_WRAP2(capset, cap_user_header_t, header, const cap_user_data_t, data)
 {
 	struct __user_cap_data_struct kdata[_KERNEL_CAPABILITY_U32S];
 	unsigned i, tocopy, copybytes;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfc227c..7b35332 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8243,7 +8243,7 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
  * @cpu:		target cpu
  * @group_fd:		group leader event fd
  */
-SYSCALL_DEFINE5(perf_event_open,
+SYSCALL_DEFINE_WRAP5(perf_event_open,
 		struct perf_event_attr __user *, attr_uptr,
 		pid_t, pid, int, cpu, int, group_fd, unsigned long, flags)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 1155eac..6bd4aff 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1196,7 +1196,7 @@ static void copy_seccomp(struct task_struct *p)
 #endif
 }
 
-SYSCALL_DEFINE1(set_tid_address, int __user *, tidptr)
+SYSCALL_DEFINE_WRAP1(set_tid_address, int __user *, tidptr)
 {
 	current->clear_child_tid = tidptr;
 
@@ -1806,23 +1806,23 @@ SYSCALL_DEFINE0(vfork)
 
 #ifdef __ARCH_WANT_SYS_CLONE
 #ifdef CONFIG_CLONE_BACKWARDS
-SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
+SYSCALL_DEFINE_WRAP5(clone, unsigned long, clone_flags, unsigned long, newsp,
 		 int __user *, parent_tidptr,
 		 unsigned long, tls,
 		 int __user *, child_tidptr)
 #elif defined(CONFIG_CLONE_BACKWARDS2)
-SYSCALL_DEFINE5(clone, unsigned long, newsp, unsigned long, clone_flags,
+SYSCALL_DEFINE_WRAP5(clone, unsigned long, newsp, unsigned long, clone_flags,
 		 int __user *, parent_tidptr,
 		 int __user *, child_tidptr,
 		 unsigned long, tls)
 #elif defined(CONFIG_CLONE_BACKWARDS3)
-SYSCALL_DEFINE6(clone, unsigned long, clone_flags, unsigned long, newsp,
+SYSCALL_DEFINE_WRAP6(clone, unsigned long, clone_flags, unsigned long, newsp,
 		int, stack_size,
 		int __user *, parent_tidptr,
 		int __user *, child_tidptr,
 		unsigned long, tls)
 #else
-SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
+SYSCALL_DEFINE_WRAP5(clone, unsigned long, clone_flags, unsigned long, newsp,
 		 int __user *, parent_tidptr,
 		 int __user *, child_tidptr,
 		 unsigned long, tls)
@@ -1953,7 +1953,7 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
  * constructed. Here we are modifying the current, active,
  * task_struct.
  */
-SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
+SYSCALL_DEFINE_WRAP1(unshare, unsigned long, unshare_flags)
 {
 	struct fs_struct *fs, *new_fs = NULL;
 	struct files_struct *fd, *new_fd = NULL;
diff --git a/kernel/groups.c b/kernel/groups.c
index 74d431d..b92dd33 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/user_namespace.h>
 #include <asm/uaccess.h>
 
@@ -187,7 +188,7 @@ int set_current_groups(struct group_info *group_info)
 
 EXPORT_SYMBOL(set_current_groups);
 
-SYSCALL_DEFINE2(getgroups, int, gidsetsize, gid_t __user *, grouplist)
+SYSCALL_DEFINE_WRAP2(getgroups, int, gidsetsize, gid_t __user *, grouplist)
 {
 	const struct cred *cred = current_cred();
 	int i;
@@ -224,7 +225,7 @@ bool may_setgroups(void)
  *	without another task interfering.
  */
 
-SYSCALL_DEFINE2(setgroups, int, gidsetsize, gid_t __user *, grouplist)
+SYSCALL_DEFINE_WRAP2(setgroups, int, gidsetsize, gid_t __user *, grouplist)
 {
 	struct group_info *group_info;
 	int retval;
diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 0aa69ea..deca910 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -1,5 +1,6 @@
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/fdtable.h>
 #include <linux/string.h>
 #include <linux/random.h>
@@ -94,7 +95,7 @@ static int kcmp_lock(struct mutex *m1, struct mutex *m2)
 	return err;
 }
 
-SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
+SYSCALL_DEFINE_WRAP5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
 		unsigned long, idx1, unsigned long, idx2)
 {
 	struct task_struct *task1, *task2;
diff --git a/kernel/module.c b/kernel/module.c
index 38c7bd5..89fcca7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -32,6 +32,7 @@
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/fcntl.h>
 #include <linux/rcupdate.h>
 #include <linux/capability.h>
@@ -947,7 +948,7 @@ EXPORT_SYMBOL(module_refcount);
 /* This exists whether we can unload or not */
 static void free_module(struct module *mod);
 
-SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
+SYSCALL_DEFINE_WRAP2(delete_module, const char __user *, name_user,
 		unsigned int, flags)
 {
 	struct module *mod;
@@ -3586,7 +3587,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	return err;
 }
 
-SYSCALL_DEFINE3(init_module, void __user *, umod,
+SYSCALL_DEFINE_WRAP3(init_module, void __user *, umod,
 		unsigned long, len, const char __user *, uargs)
 {
 	int err;
@@ -3606,7 +3607,7 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	return load_module(&info, uargs, 0);
 }
 
-SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
+SYSCALL_DEFINE_WRAP3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
 	int err;
 	struct load_info info = { };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2ce8826..156f37e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -33,6 +33,7 @@
 #include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/kexec.h>
 #include <linux/kdb.h>
 #include <linux/ratelimit.h>
@@ -1420,7 +1421,7 @@ out:
 	return error;
 }
 
-SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
+SYSCALL_DEFINE_WRAP3(syslog, int, type, char __user *, buf, int, len)
 {
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index bd30a97..70e4537 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -14,6 +14,7 @@
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
 
@@ -277,7 +278,7 @@ static DEFINE_MUTEX(reboot_mutex);
  *
  * reboot doesn't sync: do that yourself before calling this.
  */
-SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
+SYSCALL_DEFINE_WRAP4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		void __user *, arg)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 732e993..1f20193 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -58,6 +58,7 @@
 #include <linux/seq_file.h>
 #include <linux/sysctl.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/times.h>
 #include <linux/tsacct_kern.h>
 #include <linux/kprobes.h>
@@ -4184,7 +4185,7 @@ err_size:
  *
  * Return: 0 on success. An error code otherwise.
  */
-SYSCALL_DEFINE3(sched_setscheduler, pid_t, pid, int, policy,
+SYSCALL_DEFINE_WRAP3(sched_setscheduler, pid_t, pid, int, policy,
 		struct sched_param __user *, param)
 {
 	/* negative values for policy are not valid */
@@ -4201,7 +4202,7 @@ SYSCALL_DEFINE3(sched_setscheduler, pid_t, pid, int, policy,
  *
  * Return: 0 on success. An error code otherwise.
  */
-SYSCALL_DEFINE2(sched_setparam, pid_t, pid, struct sched_param __user *, param)
+SYSCALL_DEFINE_WRAP2(sched_setparam, pid_t, pid, struct sched_param __user *, param)
 {
 	return do_sched_setscheduler(pid, SETPARAM_POLICY, param);
 }
@@ -4212,7 +4213,7 @@ SYSCALL_DEFINE2(sched_setparam, pid_t, pid, struct sched_param __user *, param)
  * @uattr: structure containing the extended parameters.
  * @flags: for future extension.
  */
-SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
+SYSCALL_DEFINE_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 			       unsigned int, flags)
 {
 	struct sched_attr attr;
@@ -4275,7 +4276,7 @@ SYSCALL_DEFINE1(sched_getscheduler, pid_t, pid)
  * Return: On success, 0 and the RT priority is in @param. Otherwise, an error
  * code.
  */
-SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
+SYSCALL_DEFINE_WRAP2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 {
 	struct sched_param lp = { .sched_priority = 0 };
 	struct task_struct *p;
@@ -4353,7 +4354,7 @@ static int sched_read_attr(struct sched_attr __user *uattr,
  * @size: sizeof(attr) for fwd/bwd comp.
  * @flags: for future extension.
  */
-SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
+SYSCALL_DEFINE_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		unsigned int, size, unsigned int, flags)
 {
 	struct sched_attr attr = {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 580ac2d..b9cb4f5 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -829,7 +829,7 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 	}
 }
 
-SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
+SYSCALL_DEFINE_WRAP3(seccomp, unsigned int, op, unsigned int, flags,
 			 const char __user *, uargs)
 {
 	return do_seccomp(op, flags, uargs);
diff --git a/kernel/signal.c b/kernel/signal.c
index f3f1f7a..476de6d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3475,7 +3475,7 @@ SYSCALL_DEFINE1(ssetmask, int, newmask)
 /*
  * For backwards compatibility.  Functionality superseded by sigaction.
  */
-SYSCALL_DEFINE2(signal, int, sig, __sighandler_t, handler)
+SYSCALL_DEFINE_WRAP2(signal, int, sig, __sighandler_t, handler)
 {
 	struct k_sigaction new_sa, old_sa;
 	int ret;
@@ -3556,7 +3556,7 @@ COMPAT_SYSCALL_DEFINE2(rt_sigsuspend, compat_sigset_t __user *, unewset, compat_
 #endif
 
 #ifdef CONFIG_OLD_SIGSUSPEND
-SYSCALL_DEFINE1(sigsuspend, old_sigset_t, mask)
+SYSCALL_DEFINE_WRAP1(sigsuspend, old_sigset_t, mask)
 {
 	sigset_t blocked;
 	siginitset(&blocked, mask);
@@ -3564,7 +3564,7 @@ SYSCALL_DEFINE1(sigsuspend, old_sigset_t, mask)
 }
 #endif
 #ifdef CONFIG_OLD_SIGSUSPEND3
-SYSCALL_DEFINE3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask)
+SYSCALL_DEFINE_WRAP3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask)
 {
 	sigset_t blocked;
 	siginitset(&blocked, mask);
diff --git a/kernel/sys.c b/kernel/sys.c
index 6af9212..c5689dd 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -642,7 +642,7 @@ error:
 	return retval;
 }
 
-SYSCALL_DEFINE3(getresuid, uid_t __user *, ruidp, uid_t __user *, euidp, uid_t __user *, suidp)
+SYSCALL_DEFINE_WRAP3(getresuid, uid_t __user *, ruidp, uid_t __user *, euidp, uid_t __user *, suidp)
 {
 	const struct cred *cred = current_cred();
 	int retval;
@@ -716,7 +716,7 @@ error:
 	return retval;
 }
 
-SYSCALL_DEFINE3(getresgid, gid_t __user *, rgidp, gid_t __user *, egidp, gid_t __user *, sgidp)
+SYSCALL_DEFINE_WRAP3(getresgid, gid_t __user *, rgidp, gid_t __user *, egidp, gid_t __user *, sgidp)
 {
 	const struct cred *cred = current_cred();
 	int retval;
@@ -1138,7 +1138,7 @@ static int override_release(char __user *release, size_t len)
 	return ret;
 }
 
-SYSCALL_DEFINE1(newuname, struct new_utsname __user *, name)
+SYSCALL_DEFINE_WRAP1(newuname, struct new_utsname __user *, name)
 {
 	int errno = 0;
 
@@ -1212,7 +1212,7 @@ SYSCALL_DEFINE1(olduname, struct oldold_utsname __user *, name)
 }
 #endif
 
-SYSCALL_DEFINE2(sethostname, char __user *, name, int, len)
+SYSCALL_DEFINE_WRAP2(sethostname, char __user *, name, int, len)
 {
 	int errno;
 	char tmp[__NEW_UTS_LEN];
@@ -1263,7 +1263,7 @@ SYSCALL_DEFINE2(gethostname, char __user *, name, int, len)
  * Only setdomainname; getdomainname can be implemented by calling
  * uname()
  */
-SYSCALL_DEFINE2(setdomainname, char __user *, name, int, len)
+SYSCALL_DEFINE_WRAP2(setdomainname, char __user *, name, int, len)
 {
 	int errno;
 	char tmp[__NEW_UTS_LEN];
@@ -1445,7 +1445,7 @@ static int check_prlimit_permission(struct task_struct *task)
 	return -EPERM;
 }
 
-SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
+SYSCALL_DEFINE_WRAP4(prlimit64, pid_t, pid, unsigned int, resource,
 		const struct rlimit64 __user *, new_rlim,
 		struct rlimit64 __user *, old_rlim)
 {
@@ -2072,7 +2072,7 @@ static int prctl_get_tid_address(struct task_struct *me, int __user **tid_addr)
 }
 #endif
 
-SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
+SYSCALL_DEFINE_WRAP5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
 	struct task_struct *me = current;
@@ -2273,7 +2273,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	return error;
 }
 
-SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep,
+SYSCALL_DEFINE_WRAP3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep,
 		struct getcpu_cache __user *, unused)
 {
 	int err = 0;
diff --git a/mm/madvise.c b/mm/madvise.c
index c889fcb..8390012 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -8,6 +8,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/mempolicy.h>
 #include <linux/page-isolation.h>
 #include <linux/hugetlb.h>
@@ -457,7 +458,7 @@ madvise_behavior_valid(int behavior)
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
+SYSCALL_DEFINE_WRAP3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
diff --git a/mm/mincore.c b/mm/mincore.c
index 14bb9fb..d6e4395 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/hugetlb.h>
@@ -217,7 +218,7 @@ static long do_mincore(unsigned long addr, unsigned long pages, unsigned char *v
  *		mapped
  *  -EAGAIN - A kernel resource was temporarily unavailable.
  */
-SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
+SYSCALL_DEFINE_WRAP3(mincore, unsigned long, start, size_t, len,
 		unsigned char __user *, vec)
 {
 	long retval;
diff --git a/mm/mlock.c b/mm/mlock.c
index 339d9e0..e37e60f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -14,6 +14,7 @@
 #include <linux/pagevec.h>
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/rmap.h>
@@ -640,12 +641,12 @@ static int do_mlock(unsigned long start, size_t len, vm_flags_t flags)
 	return 0;
 }
 
-SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
+SYSCALL_DEFINE_WRAP2(mlock, unsigned long, start, size_t, len)
 {
 	return do_mlock(start, len, VM_LOCKED);
 }
 
-SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
+SYSCALL_DEFINE_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags)
 {
 	vm_flags_t vm_flags = VM_LOCKED;
 
@@ -658,7 +659,7 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 	return do_mlock(start, len, vm_flags);
 }
 
-SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
+SYSCALL_DEFINE_WRAP2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 2ce04a6..9b9ae80 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -18,6 +18,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/file.h>
@@ -283,7 +284,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 
 static unsigned long do_brk(unsigned long addr, unsigned long len);
 
-SYSCALL_DEFINE1(brk, unsigned long, brk)
+SYSCALL_DEFINE_WRAP1(brk, unsigned long, brk)
 {
 	unsigned long retval;
 	unsigned long newbrk, oldbrk;
@@ -2631,7 +2632,7 @@ int vm_munmap(unsigned long start, size_t len)
 }
 EXPORT_SYMBOL(vm_munmap);
 
-SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
+SYSCALL_DEFINE_WRAP2(munmap, unsigned long, addr, size_t, len)
 {
 	profile_munmap(addr);
 	return vm_munmap(addr, len);
@@ -2641,7 +2642,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 /*
  * Emulation of deprecated remap_file_pages() syscall.
  */
-SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
+SYSCALL_DEFINE_WRAP5(remap_file_pages, unsigned long, start, unsigned long, size,
 		unsigned long, prot, unsigned long, pgoff, unsigned long, flags)
 {
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ef5be8e..eec7d57 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -18,6 +18,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mmu_notifier.h>
@@ -344,7 +345,7 @@ fail:
 	return error;
 }
 
-SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
+SYSCALL_DEFINE_WRAP3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
 	unsigned long vm_flags, nstart, end, tmp, reqprot;
diff --git a/mm/mremap.c b/mm/mremap.c
index c25bc62..b81462a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched/sysctl.h>
 #include <linux/uaccess.h>
@@ -468,7 +469,7 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
  * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
  * This option implies MREMAP_MAYMOVE.
  */
-SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
+SYSCALL_DEFINE_WRAP5(mremap, unsigned long, addr, unsigned long, old_len,
 		unsigned long, new_len, unsigned long, flags,
 		unsigned long, new_addr)
 {
diff --git a/mm/msync.c b/mm/msync.c
index 24e612f..1fd9f6a 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -12,6 +12,7 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/sched.h>
 
 /*
@@ -28,7 +29,7 @@
  * So by _not_ starting I/O in MS_ASYNC we provide complete flexibility to
  * applications.
  */
-SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
+SYSCALL_DEFINE_WRAP3(msync, unsigned long, start, size_t, len, int, flags)
 {
 	unsigned long end;
 	struct mm_struct *mm = current->mm;
diff --git a/mm/nommu.c b/mm/nommu.c
index 92be862..59c6baf 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -32,6 +32,7 @@
 #include <linux/personality.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/audit.h>
 #include <linux/sched/sysctl.h>
 #include <linux/printk.h>
@@ -526,7 +527,7 @@ EXPORT_SYMBOL(vm_insert_page);
  *  to a regular file.  in this case, the unmapping will need
  *  to invoke file system routines that need the global lock.
  */
-SYSCALL_DEFINE1(brk, unsigned long, brk)
+SYSCALL_DEFINE_WRAP1(brk, unsigned long, brk)
 {
 	struct mm_struct *mm = current->mm;
 
@@ -1684,7 +1685,7 @@ int vm_munmap(unsigned long addr, size_t len)
 }
 EXPORT_SYMBOL(vm_munmap);
 
-SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
+SYSCALL_DEFINE_WRAP2(munmap, unsigned long, addr, size_t, len)
 {
 	return vm_munmap(addr, len);
 }
@@ -1760,7 +1761,7 @@ static unsigned long do_mremap(unsigned long addr,
 	return vma->vm_start;
 }
 
-SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
+SYSCALL_DEFINE_WRAP5(mremap, unsigned long, addr, unsigned long, old_len,
 		unsigned long, new_len, unsigned long, flags,
 		unsigned long, new_addr)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 2afcdbb..154d3b7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -67,6 +67,7 @@ static struct vfsmount *shm_mnt;
 #include <linux/seq_file.h>
 #include <linux/magic.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/fcntl.h>
 #include <uapi/linux/memfd.h>
 
@@ -2921,7 +2922,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 
 #define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING)
 
-SYSCALL_DEFINE2(memfd_create,
+SYSCALL_DEFINE_WRAP2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5887731..3bb701c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/capability.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/memcontrol.h>
 #include <linux/poll.h>
 #include <linux/oom.h>
@@ -1841,7 +1842,7 @@ static void reinsert_swap_info(struct swap_info_struct *p)
 	spin_unlock(&swap_lock);
 }
 
-SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
+SYSCALL_DEFINE_WRAP1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
 	unsigned char *swap_map;
@@ -2383,7 +2384,7 @@ static bool swap_discardable(struct swap_info_struct *si)
 	return true;
 }
 
-SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
+SYSCALL_DEFINE_WRAP2(swapon, const char __user *, specialfile, int, swap_flags)
 {
 	struct swap_info_struct *p;
 	struct filename *name;
diff --git a/net/socket.c b/net/socket.c
index d730ef9..62b2769 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1251,7 +1251,7 @@ out_release:
  *	Create a pair of connected sockets.
  */
 
-SYSCALL_DEFINE4(socketpair, int, family, int, type, int, protocol,
+SYSCALL_DEFINE_WRAP4(socketpair, int, family, int, type, int, protocol,
 		int __user *, usockvec)
 {
 	struct socket *sock1, *sock2;
@@ -1360,7 +1360,7 @@ out:
  *	the protocol layer (having also checked the address is ok).
  */
 
-SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
+SYSCALL_DEFINE_WRAP3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
@@ -1422,7 +1422,7 @@ SYSCALL_DEFINE2(listen, int, fd, int, backlog)
  *	clean when we restucture accept also.
  */
 
-SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
+SYSCALL_DEFINE_WRAP4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
 		int __user *, upeer_addrlen, int, flags)
 {
 	struct socket *sock, *newsock;
@@ -1521,7 +1521,7 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
  *	include the -EINPROGRESS status for such sockets.
  */
 
-SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
+SYSCALL_DEFINE_WRAP3(connect, int, fd, struct sockaddr __user *, uservaddr,
 		int, addrlen)
 {
 	struct socket *sock;
@@ -1553,7 +1553,7 @@ out:
  *	name to user space.
  */
 
-SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
+SYSCALL_DEFINE_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
 		int __user *, usockaddr_len)
 {
 	struct socket *sock;
@@ -1584,7 +1584,7 @@ out:
  *	name to user space.
  */
 
-SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
+SYSCALL_DEFINE_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
 		int __user *, usockaddr_len)
 {
 	struct socket *sock;
@@ -1616,7 +1616,7 @@ SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
  *	the protocol.
  */
 
-SYSCALL_DEFINE6(sendto, int, fd, void __user *, buff, size_t, len,
+SYSCALL_DEFINE_WRAP6(sendto, int, fd, void __user *, buff, size_t, len,
 		unsigned int, flags, struct sockaddr __user *, addr,
 		int, addr_len)
 {
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 1c3872a..bae5a04 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/key.h>
 #include <linux/keyctl.h>
 #include <linux/fs.h>
@@ -57,7 +58,7 @@ static int key_get_type_from_user(char *type,
  * If successful, the new key's serial number is returned, otherwise an error
  * code is returned.
  */
-SYSCALL_DEFINE5(add_key, const char __user *, _type,
+SYSCALL_DEFINE_WRAP5(add_key, const char __user *, _type,
 		const char __user *, _description,
 		const void __user *, _payload,
 		size_t, plen,
@@ -155,7 +156,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
  * passed to /sbin/request-key to aid with completing the request.  If the
  * _callout_info string is "" then it will be changed to "-".
  */
-SYSCALL_DEFINE4(request_key, const char __user *, _type,
+SYSCALL_DEFINE_WRAP4(request_key, const char __user *, _type,
 		const char __user *, _description,
 		const char __user *, _callout_info,
 		key_serial_t, destringid)
-- 
2.5.0
