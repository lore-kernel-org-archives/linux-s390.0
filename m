From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 2/5] all: declare new wrappers
Date: Mon, 25 Jan 2016 19:57:24 +0300
Message-ID: <1453741047-5498-3-git-send-email-ynorov@caviumnetworks.com>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

For arches that generate syscall table in C code declarations are
needed. Conditional wrappers are also introduced.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/s390/kernel/entry.h |   2 +
 include/linux/compat.h   | 221 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sys_ni.c          |  96 ++++++++++----------
 3 files changed, 271 insertions(+), 48 deletions(-)

diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index b7019ab..484a925 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -74,5 +74,7 @@ long sys_sigreturn(void);
 long sys_s390_personality(unsigned int personality);
 long sys_s390_runtime_instr(int command, int signum);
 long sys_s390_pci_mmio_write(unsigned long, const void __user *, size_t);
+long compat_sys_s390_pci_mmio_write(unsigned long, const void __user *, size_t);
 long sys_s390_pci_mmio_read(unsigned long, void __user *, size_t);
+long compat_sys_s390_pci_mmio_read(unsigned long, void __user *, size_t);
 #endif /* _ENTRY_H */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1a761ea..9c57559 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -770,6 +770,227 @@ SYSCALL_DEFINEx(x, name, __VA_ARGS__)
 #define SYSCALL_DEFINE_WRAP5(name, ...) SYSCALL_DEFINE_WRAPx(5, _##name, __VA_ARGS__)
 #define SYSCALL_DEFINE_WRAP6(name, ...) SYSCALL_DEFINE_WRAPx(6, _##name, __VA_ARGS__)
 
+/* Compat wrappers */
+#include <linux/syscalls_structs.h>
+asmlinkage long compat_sys_creat(const char __user *pathname, umode_t mode);
+asmlinkage long compat_sys_link(const char __user *oldname,
+				const char __user *newname);
+asmlinkage long compat_sys_chdir(const char __user *filename);
+asmlinkage long compat_sys_mknod(const char __user *filename, umode_t mode,
+				unsigned dev);
+asmlinkage long compat_sys_chmod(const char __user *filename, umode_t mode);
+asmlinkage long compat_sys_oldumount(char __user *name);
+asmlinkage long compat_sys_access(const char __user *filename, int mode);
+asmlinkage long compat_sys_rename(const char __user *oldname,
+				const char __user *newname);
+asmlinkage long compat_sys_mkdir(const char __user *pathname, umode_t mode);
+asmlinkage long compat_sys_rmdir(const char __user *pathname);
+asmlinkage long compat_sys_pipe(int __user *fildes);
+asmlinkage long compat_sys_brk(unsigned long brk);
+asmlinkage long compat_sys_signal(int sig, __sighandler_t handler);
+asmlinkage long compat_sys_acct(const char __user *name);
+asmlinkage long compat_sys_umount(char __user *name, int flags);
+asmlinkage long compat_sys_chroot(const char __user *filename);
+
+#ifdef CONFIG_OLD_SIGSUSPEND
+asmlinkage long compat_sys_sigsuspend(old_sigset_t mask);
+#endif
+
+#ifdef CONFIG_OLD_SIGSUSPEND3
+asmlinkage long compat_sys_sigsuspend(int unused1, int unused2, old_sigset_t mask);
+#endif
+
+asmlinkage long compat_sys_sethostname(char __user *name, int len);
+asmlinkage long compat_sys_symlink(const char __user *old, const char __user *new);
+asmlinkage long compat_sys_readlink(const char __user *path,
+				char __user *buf, int bufsiz);
+asmlinkage long compat_sys_uselib(const char __user *library);
+asmlinkage long compat_sys_swapon(const char __user *specialfile, int swap_flags);
+asmlinkage long compat_sys_reboot(int magic1, int magic2, unsigned int cmd,
+				void __user *arg);
+asmlinkage long compat_sys_munmap(unsigned long addr, size_t len);
+asmlinkage long compat_sys_munmap(unsigned long addr, size_t len);
+asmlinkage long compat_sys_syslog(int type, char __user *buf, int len);
+asmlinkage long compat_sys_swapoff(const char __user *specialfile);
+asmlinkage long compat_sys_setdomainname(char __user *name, int len);
+asmlinkage long compat_sys_newuname(struct new_utsname __user *name);
+asmlinkage long compat_sys_mprotect(unsigned long start, size_t len,
+				unsigned long prot);
+asmlinkage long compat_sys_init_module(void __user *umod, unsigned long len,
+				const char __user *uargs);
+asmlinkage long compat_sys_delete_module(const char __user *name_user,
+				unsigned int flags);
+asmlinkage long compat_sys_quotactl(unsigned int cmd, const char __user *special,
+				qid_t id, void __user *addr);
+asmlinkage long compat_sys_bdflush(int func, long data);
+asmlinkage long compat_sys_sysfs(int option,
+				unsigned long arg1, unsigned long arg2);
+asmlinkage long compat_sys_llseek(unsigned int fd, unsigned long offset_high,
+			unsigned long offset_low, loff_t __user *result,
+			unsigned int whence);
+asmlinkage long compat_sys_msync(unsigned long start, size_t len, int flags);
+asmlinkage long compat_sys_mlock(unsigned long start, size_t len);
+asmlinkage long compat_sys_munlock(unsigned long start, size_t len);
+asmlinkage long compat_sys_sched_setparam(pid_t pid,
+					struct sched_param __user *param);
+asmlinkage long compat_sys_sched_getparam(pid_t pid,
+					struct sched_param __user *param);
+asmlinkage long compat_sys_sched_setscheduler(pid_t pid, int policy,
+					struct sched_param __user *param);
+asmlinkage long compat_sys_mremap(unsigned long addr,
+			   unsigned long old_len, unsigned long new_len,
+			   unsigned long flags, unsigned long new_addr);
+asmlinkage long compat_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
+				int timeout);
+asmlinkage long compat_sys_prctl(int option, unsigned long arg2, unsigned long arg3,
+			unsigned long arg4, unsigned long arg5);
+asmlinkage long compat_sys_getcwd(char __user *buf, unsigned long size);
+asmlinkage long compat_sys_capget(cap_user_header_t header,
+				cap_user_data_t dataptr);
+asmlinkage long compat_sys_capset(cap_user_header_t header,
+				const cap_user_data_t data);
+asmlinkage long compat_sys_lchown(const char __user *filename,
+				uid_t user, gid_t group);
+asmlinkage long compat_sys_getgroups(int gidsetsize, gid_t __user *grouplist);
+asmlinkage long compat_sys_setgroups(int gidsetsize, gid_t __user *grouplist);
+asmlinkage long compat_sys_getresuid(uid_t __user *ruid, uid_t __user *euid, uid_t __user *suid);
+asmlinkage long compat_sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid);
+asmlinkage long compat_sys_chown(const char __user *filename,
+				uid_t user, gid_t group);
+asmlinkage long compat_sys_pivot_root(const char __user *new_root,
+				const char __user *put_old);
+asmlinkage long compat_sys_mincore(unsigned long start, size_t len,
+				unsigned char __user * vec);
+asmlinkage long compat_sys_madvise(unsigned long start, size_t len, int behavior);
+asmlinkage long compat_sys_setxattr(const char __user *path, const char __user *name,
+			     const void __user *value, size_t size, int flags);
+asmlinkage long compat_sys_lsetxattr(const char __user *path, const char __user *name,
+			      const void __user *value, size_t size, int flags);
+asmlinkage long compat_sys_fsetxattr(int fd, const char __user *name,
+			      const void __user *value, size_t size, int flags);
+asmlinkage long compat_sys_getdents64(unsigned int fd,
+				struct linux_dirent64 __user *dirent,
+				unsigned int count);
+asmlinkage long compat_sys_getxattr(const char __user *path, const char __user *name,
+			     void __user *value, size_t size);
+asmlinkage long compat_sys_lgetxattr(const char __user *path, const char __user *name,
+			      void __user *value, size_t size);
+asmlinkage long compat_sys_fgetxattr(int fd, const char __user *name,
+			      void __user *value, size_t size);
+asmlinkage long compat_sys_listxattr(const char __user *path, char __user *list,
+			      size_t size);
+asmlinkage long compat_sys_llistxattr(const char __user *path, char __user *list,
+			       size_t size);
+asmlinkage long compat_sys_flistxattr(int fd, char __user *list, size_t size);
+asmlinkage long compat_sys_listxattr(const char __user *path, char __user *list,
+			      size_t size);
+asmlinkage long compat_sys_llistxattr(const char __user *path, char __user *list,
+			       size_t size);
+asmlinkage long compat_sys_flistxattr(int fd, char __user *list, size_t size);
+asmlinkage long compat_sys_removexattr(const char __user *path,
+				const char __user *name);
+asmlinkage long compat_sys_lremovexattr(const char __user *path,
+				 const char __user *name);
+asmlinkage long compat_sys_fremovexattr(int fd, const char __user *name);
+asmlinkage long compat_sys_set_tid_address(int __user *tidptr);
+asmlinkage long compat_sys_epoll_ctl(int epfd, int op, int fd,
+				struct epoll_event __user *event);
+asmlinkage long compat_sys_epoll_wait(int epfd, struct epoll_event __user *events,
+				int maxevents, int timeout);
+asmlinkage long compat_sys_io_destroy(aio_context_t ctx);
+asmlinkage long compat_sys_io_cancel(aio_context_t ctx_id, struct iocb __user *iocb,
+			      struct io_event __user *result);
+asmlinkage long compat_sys_mq_unlink(const char __user *name);
+asmlinkage long compat_sys_add_key(const char __user *_type,
+			    const char __user *_description,
+			    const void __user *_payload,
+			    size_t plen,
+			    key_serial_t destringid);
+asmlinkage long compat_sys_request_key(const char __user *_type,
+				const char __user *_description,
+				const char __user *_callout_info,
+				key_serial_t destringid);
+asmlinkage long compat_sys_remap_file_pages(unsigned long start, unsigned long size,
+			unsigned long prot, unsigned long pgoff,
+			unsigned long flags);
+asmlinkage long compat_sys_inotify_add_watch(int fd, const char __user *path,
+					u32 mask);
+asmlinkage long compat_sys_mknodat(int dfd, const char __user * filename, umode_t mode,
+			    unsigned dev);
+asmlinkage long compat_sys_mkdirat(int dfd, const char __user * pathname, umode_t mode);
+asmlinkage long compat_sys_fchownat(int dfd, const char __user *filename, uid_t user,
+			     gid_t group, int flag);
+asmlinkage long compat_sys_unlinkat(int dfd, const char __user * pathname, int flag);
+asmlinkage long compat_sys_renameat(int olddfd, const char __user * oldname,
+			     int newdfd, const char __user * newname);
+asmlinkage long compat_sys_symlinkat(const char __user * oldname,
+			      int newdfd, const char __user * newname);
+asmlinkage long compat_sys_linkat(int olddfd, const char __user *oldname,
+			   int newdfd, const char __user *newname, int flags);
+asmlinkage long compat_sys_readlinkat(int dfd, const char __user *path, char __user *buf,
+			       int bufsiz);
+asmlinkage long compat_sys_fchmodat(int dfd, const char __user * filename,
+			     umode_t mode);
+asmlinkage long compat_sys_faccessat(int dfd, const char __user *filename, int mode);
+asmlinkage long compat_sys_unshare(unsigned long unshare_flags);
+asmlinkage long compat_sys_splice(int fd_in, loff_t __user *off_in,
+			   int fd_out, loff_t __user *off_out,
+			   size_t len, unsigned int flags);
+asmlinkage long compat_sys_tee(int fdin, int fdout, size_t len, unsigned int flags);
+asmlinkage long compat_sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
+asmlinkage long compat_sys_pipe2(int __user *fildes, int flags);
+asmlinkage long compat_sys_perf_event_open(
+		struct perf_event_attr __user *attr_uptr,
+		pid_t pid, int cpu, int group_fd, unsigned long flags);
+
+#ifdef CONFIG_CLONE_BACKWARDS
+asmlinkage long compat_sys_clone(unsigned long, unsigned long, int __user *, unsigned long,
+	       int __user *);
+#else
+#ifdef CONFIG_CLONE_BACKWARDS3
+asmlinkage long compat_sys_clone(unsigned long, unsigned long, int, int __user *,
+			  int __user *, unsigned long);
+#else
+asmlinkage long compat_sys_clone(unsigned long, unsigned long, int __user *,
+	       int __user *, unsigned long);
+#endif
+#endif
+
+asmlinkage long compat_sys_prlimit64(pid_t pid, unsigned int resource,
+				const struct rlimit64 __user *new_rlim,
+				struct rlimit64 __user *old_rlim);
+asmlinkage long compat_sys_name_to_handle_at(int dfd, const char __user *name,
+				      struct file_handle __user *handle,
+				      int __user *mnt_id, int flag);
+asmlinkage long compat_sys_kcmp(pid_t pid1, pid_t pid2, int type,
+			 unsigned long idx1, unsigned long idx2);
+asmlinkage long compat_sys_finit_module(int fd, const char __user *uargs, int flags);
+asmlinkage long compat_sys_sched_setattr(pid_t pid,
+					struct sched_attr __user *attr,
+					unsigned int flags);
+asmlinkage long compat_sys_sched_getattr(pid_t pid,
+					struct sched_attr __user *attr,
+					unsigned int size,
+					unsigned int flags);
+asmlinkage long compat_sys_renameat2(int olddfd, const char __user *oldname,
+			      int newdfd, const char __user *newname,
+			      unsigned int flags);
+asmlinkage long compat_sys_seccomp(unsigned int op, unsigned int flags,
+			    const char __user *uargs);
+asmlinkage long compat_sys_getrandom(char __user *buf, size_t count,
+			      unsigned int flags);
+asmlinkage long compat_sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
+asmlinkage long compat_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
+asmlinkage long compat_sys_socketpair(int, int, int, int __user *);
+asmlinkage long compat_sys_bind(int, struct sockaddr __user *, int);
+asmlinkage long compat_sys_connect(int, struct sockaddr __user *, int);
+asmlinkage long compat_sys_accept4(int, struct sockaddr __user *, int __user *, int);
+asmlinkage long compat_sys_getsockname(int, struct sockaddr __user *, int __user *);
+asmlinkage long compat_sys_getpeername(int, struct sockaddr __user *, int __user *);
+asmlinkage long compat_sys_sendto(int, void __user *, size_t, unsigned,
+				struct sockaddr __user *, int);
+asmlinkage long compat_sys_mlock2(unsigned long start, size_t len, int flags);
+
 #else
 
 #define SYSCALL_DEFINE_WRAP1	SYSCALL_DEFINE1
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 8c99a45..fdf689b 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -24,28 +24,28 @@ asmlinkage long sys_ni_syscall(void)
 #define cond_syscall_wrapped	cond_syscall
 #endif
 
-cond_syscall(sys_quotactl);
+cond_syscall_wrapped(sys_quotactl);
 cond_syscall(sys32_quotactl);
-cond_syscall(sys_acct);
+cond_syscall_wrapped(sys_acct);
 cond_syscall(sys_lookup_dcookie);
 cond_syscall(compat_sys_lookup_dcookie);
-cond_syscall(sys_swapon);
-cond_syscall(sys_swapoff);
+cond_syscall_wrapped(sys_swapon);
+cond_syscall_wrapped(sys_swapoff);
 cond_syscall(sys_kexec_load);
 cond_syscall(compat_sys_kexec_load);
 cond_syscall(sys_kexec_file_load);
-cond_syscall(sys_init_module);
-cond_syscall(sys_finit_module);
-cond_syscall(sys_delete_module);
-cond_syscall(sys_socketpair);
-cond_syscall(sys_bind);
+cond_syscall_wrapped(sys_init_module);
+cond_syscall_wrapped(sys_finit_module);
+cond_syscall_wrapped(sys_delete_module);
+cond_syscall_wrapped(sys_socketpair);
+cond_syscall_wrapped(sys_bind);
 cond_syscall(sys_listen);
 cond_syscall(sys_accept);
-cond_syscall(sys_accept4);
-cond_syscall(sys_connect);
-cond_syscall(sys_getsockname);
-cond_syscall(sys_getpeername);
-cond_syscall(sys_sendto);
+cond_syscall_wrapped(sys_accept4);
+cond_syscall_wrapped(sys_connect);
+cond_syscall_wrapped(sys_getsockname);
+cond_syscall_wrapped(sys_getpeername);
+cond_syscall_wrapped(sys_sendto);
 cond_syscall(sys_send);
 cond_syscall(sys_recvfrom);
 cond_syscall(sys_recv);
@@ -74,8 +74,8 @@ cond_syscall(sys_get_robust_list);
 cond_syscall(compat_sys_get_robust_list);
 cond_syscall(sys_epoll_create);
 cond_syscall(sys_epoll_create1);
-cond_syscall(sys_epoll_ctl);
-cond_syscall(sys_epoll_wait);
+cond_syscall_wrapped(sys_epoll_ctl);
+cond_syscall_wrapped(sys_epoll_wait);
 cond_syscall(sys_epoll_pwait);
 cond_syscall(compat_sys_epoll_pwait);
 cond_syscall(sys_semget);
@@ -98,7 +98,7 @@ cond_syscall(sys_shmdt);
 cond_syscall(sys_shmctl);
 cond_syscall(compat_sys_shmctl);
 cond_syscall(sys_mq_open);
-cond_syscall(sys_mq_unlink);
+cond_syscall_wrapped(sys_mq_unlink);
 cond_syscall(sys_mq_timedsend);
 cond_syscall(sys_mq_timedreceive);
 cond_syscall(sys_mq_notify);
@@ -114,14 +114,14 @@ cond_syscall(sys_set_mempolicy);
 cond_syscall(compat_sys_mbind);
 cond_syscall(compat_sys_get_mempolicy);
 cond_syscall(compat_sys_set_mempolicy);
-cond_syscall(sys_add_key);
-cond_syscall(sys_request_key);
+cond_syscall_wrapped(sys_add_key);
+cond_syscall_wrapped(sys_request_key);
 cond_syscall(sys_keyctl);
 cond_syscall(compat_sys_keyctl);
 cond_syscall(compat_sys_socketcall);
 cond_syscall(sys_inotify_init);
 cond_syscall(sys_inotify_init1);
-cond_syscall(sys_inotify_add_watch);
+cond_syscall_wrapped(sys_inotify_add_watch);
 cond_syscall(sys_inotify_rm_watch);
 cond_syscall(sys_migrate_pages);
 cond_syscall(sys_move_pages);
@@ -154,12 +154,12 @@ cond_syscall(compat_sys_ipc);
 cond_syscall(compat_sys_sysctl);
 cond_syscall(sys_flock);
 cond_syscall(sys_io_setup);
-cond_syscall(sys_io_destroy);
+cond_syscall_wrapped(sys_io_destroy);
 cond_syscall(sys_io_submit);
-cond_syscall(sys_io_cancel);
+cond_syscall_wrapped(sys_io_cancel);
 cond_syscall(sys_io_getevents);
-cond_syscall(sys_sysfs);
-cond_syscall(sys_syslog);
+cond_syscall_wrapped(sys_sysfs);
+cond_syscall_wrapped(sys_syslog);
 cond_syscall(sys_process_vm_readv);
 cond_syscall(sys_process_vm_writev);
 cond_syscall(compat_sys_process_vm_readv);
@@ -173,15 +173,15 @@ cond_syscall(sys_setregid);
 cond_syscall(sys_setgid);
 cond_syscall(sys_setreuid);
 cond_syscall(sys_setresuid);
-cond_syscall(sys_getresuid);
+cond_syscall_wrapped(sys_getresuid);
 cond_syscall(sys_setresgid);
-cond_syscall(sys_getresgid);
-cond_syscall(sys_setgroups);
-cond_syscall(sys_getgroups);
+cond_syscall_wrapped(sys_getresgid);
+cond_syscall_wrapped(sys_setgroups);
+cond_syscall_wrapped(sys_getgroups);
 cond_syscall(sys_setfsuid);
 cond_syscall(sys_setfsgid);
-cond_syscall(sys_capget);
-cond_syscall(sys_capset);
+cond_syscall_wrapped(sys_capget);
+cond_syscall_wrapped(sys_capset);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
@@ -192,26 +192,26 @@ cond_syscall(ppc_rtas);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
 cond_syscall(sys_subpage_prot);
-cond_syscall(sys_s390_pci_mmio_read);
-cond_syscall(sys_s390_pci_mmio_write);
+cond_syscall_wrapped(sys_s390_pci_mmio_read);
+cond_syscall_wrapped(sys_s390_pci_mmio_write);
 
 /* mmu depending weak syscall entries */
-cond_syscall(sys_mprotect);
-cond_syscall(sys_msync);
-cond_syscall(sys_mlock);
-cond_syscall(sys_munlock);
+cond_syscall_wrapped(sys_mprotect);
+cond_syscall_wrapped(sys_msync);
+cond_syscall_wrapped(sys_mlock);
+cond_syscall_wrapped(sys_munlock);
 cond_syscall(sys_mlockall);
 cond_syscall(sys_munlockall);
-cond_syscall(sys_mlock2);
-cond_syscall(sys_mincore);
-cond_syscall(sys_madvise);
-cond_syscall(sys_mremap);
-cond_syscall(sys_remap_file_pages);
+cond_syscall_wrapped(sys_mlock2);
+cond_syscall_wrapped(sys_mincore);
+cond_syscall_wrapped(sys_madvise);
+cond_syscall_wrapped(sys_mremap);
+cond_syscall_wrapped(sys_remap_file_pages);
 cond_syscall(compat_sys_move_pages);
 cond_syscall(compat_sys_migrate_pages);
 
 /* block-layer dependent */
-cond_syscall(sys_bdflush);
+cond_syscall_wrapped(sys_bdflush);
 cond_syscall(sys_ioprio_set);
 cond_syscall(sys_ioprio_get);
 
@@ -227,11 +227,11 @@ cond_syscall(compat_sys_timerfd_settime);
 cond_syscall(compat_sys_timerfd_gettime);
 cond_syscall(sys_eventfd);
 cond_syscall(sys_eventfd2);
-cond_syscall(sys_memfd_create);
+cond_syscall_wrapped(sys_memfd_create);
 cond_syscall(sys_userfaultfd);
 
 /* performance counters: */
-cond_syscall(sys_perf_event_open);
+cond_syscall_wrapped(sys_perf_event_open);
 
 /* fanotify! */
 cond_syscall(sys_fanotify_init);
@@ -239,18 +239,18 @@ cond_syscall(sys_fanotify_mark);
 cond_syscall(compat_sys_fanotify_mark);
 
 /* open by handle */
-cond_syscall(sys_name_to_handle_at);
+cond_syscall_wrapped(sys_name_to_handle_at);
 cond_syscall(sys_open_by_handle_at);
 cond_syscall(compat_sys_open_by_handle_at);
 
 /* compare kernel pointers */
-cond_syscall(sys_kcmp);
+cond_syscall_wrapped(sys_kcmp);
 
 /* operate on Secure Computing state */
-cond_syscall(sys_seccomp);
+cond_syscall_wrapped(sys_seccomp);
 
 /* access BPF programs and maps */
-cond_syscall(sys_bpf);
+cond_syscall_wrapped(sys_bpf);
 
 /* execveat */
 cond_syscall(sys_execveat);
-- 
2.5.0
