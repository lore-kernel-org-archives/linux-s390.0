From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 1/6] fs: provide a generic compat_sys_fallocate() implementation
Date: Sun, 18 Mar 2018 17:10:51 +0100
Message-ID: <20180318161056.5377-2-linux@dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318161056.5377-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

The compat_sys_fallocate() implementations in mips, powerpc, s390, sparc
and x86 only differed based on the endianness of the u64 being passed as
parameters (3, 4) and (5, 6).

In addition, do not call sys_fallocate() from compat_sys_fallocate(), but
use a common do_fallocate() helper instead.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: x86@kernel.org
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/mips/include/asm/unistd.h         |  4 ++++
 arch/mips/kernel/linux32.c             |  7 -------
 arch/mips/kernel/scall64-o32.S         |  2 +-
 arch/powerpc/include/asm/unistd.h      |  1 +
 arch/powerpc/kernel/sys_ppc32.c        |  7 -------
 arch/s390/include/asm/unistd.h         |  1 +
 arch/s390/kernel/compat_linux.c        |  7 -------
 arch/s390/kernel/compat_linux.h        |  1 -
 arch/s390/kernel/syscalls/syscall.tbl  |  2 +-
 arch/sparc/include/asm/unistd.h        |  1 +
 arch/sparc/kernel/sys_sparc32.c        |  7 -------
 arch/sparc/kernel/systbls.h            |  2 --
 arch/x86/entry/syscalls/syscall_32.tbl |  2 +-
 arch/x86/ia32/sys_ia32.c               |  8 --------
 arch/x86/include/asm/sys_ia32.h        |  2 --
 arch/x86/include/asm/unistd.h          |  2 ++
 fs/open.c                              | 24 +++++++++++++++++++++++-
 include/linux/compat.h                 |  6 ++++++
 18 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 3c09450908aa..bec9c6f55956 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -45,6 +45,10 @@
 # endif
 # ifdef CONFIG_MIPS32_O32
 #  define __ARCH_WANT_COMPAT_SYS_TIME
+#  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
+#  ifdef __MIPSEL__
+#    define __ARCH_WANT_LE_COMPAT_SYS
+#  endif
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index b332f6fc1e72..f6e6cb41c01f 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -153,10 +153,3 @@ asmlinkage long sys32_fadvise64_64(int fd, int __pad,
 			merge_64(a2, a3), merge_64(a4, a5),
 			flags);
 }
-
-asmlinkage long sys32_fallocate(int fd, int mode, unsigned offset_a2,
-	unsigned offset_a3, unsigned len_a4, unsigned len_a5)
-{
-	return sys_fallocate(fd, mode, merge_64(offset_a2, offset_a3),
-			     merge_64(len_a4, len_a5));
-}
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 9ebe3e2403b1..da8babc2c1f5 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -536,7 +536,7 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_signalfd
 	PTR	sys_ni_syscall			/* was timerfd */
 	PTR	sys_eventfd
-	PTR	sys32_fallocate			/* 4320 */
+	PTR	compat_sys_fallocate		/* 4320 */
 	PTR	sys_timerfd_create
 	PTR	compat_sys_timerfd_gettime
 	PTR	compat_sys_timerfd_settime
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index daf1ba97a00c..46890687fb1d 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -49,6 +49,7 @@
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_SYS_NEWFSTATAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 15f216d022e2..7c6da6273367 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -97,13 +97,6 @@ asmlinkage int compat_sys_truncate64(const char __user * path, u32 reg4,
 	return sys_truncate(path, (high << 32) | low);
 }
 
-asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
-				     u32 lenhi, u32 lenlo)
-{
-	return sys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
-			     ((loff_t)lenhi << 32) | lenlo);
-}
-
 asmlinkage int compat_sys_ftruncate64(unsigned int fd, u32 reg4, unsigned long high,
 				 unsigned long low)
 {
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index fd79c0d35dc4..5e919c11c11f 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -34,6 +34,7 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_COMPAT
 #   define __ARCH_WANT_COMPAT_SYS_TIME
+#   define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 79b7a3438d54..3052f8e5ba42 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -512,10 +512,3 @@ COMPAT_SYSCALL_DEFINE6(s390_sync_file_range, int, fd, u32, offhigh, u32, offlow,
 	return sys_sync_file_range(fd, ((loff_t)offhigh << 32) + offlow,
 				   ((u64)nhigh << 32) + nlow, flags);
 }
-
-COMPAT_SYSCALL_DEFINE6(s390_fallocate, int, fd, int, mode, u32, offhigh, u32, offlow,
-		       u32, lenhigh, u32, lenlow)
-{
-	return sys_fallocate(fd, mode, ((loff_t)offhigh << 32) + offlow,
-			     ((u64)lenhigh << 32) + lenlow);
-}
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index 64509e7dbd3b..cfc3d42603a8 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -123,7 +123,6 @@ long compat_sys_s390_write(unsigned int fd, const char __user * buf, compat_size
 long compat_sys_s390_fadvise64(int fd, u32 high, u32 low, compat_size_t len, int advise);
 long compat_sys_s390_fadvise64_64(struct fadvise64_64_args __user *args);
 long compat_sys_s390_sync_file_range(int fd, u32 offhigh, u32 offlow, u32 nhigh, u32 nlow, unsigned int flags);
-long compat_sys_s390_fallocate(int fd, int mode, u32 offhigh, u32 offlow, u32 lenhigh, u32 lenlow);
 long compat_sys_sigreturn(void);
 long compat_sys_rt_sigreturn(void);
 
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index b38d48464368..652863bb7fcb 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -321,7 +321,7 @@
 311  common	getcpu			sys_getcpu			compat_sys_getcpu
 312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 313  common	utimes			sys_utimes			compat_sys_utimes
-314  common	fallocate		sys_fallocate			compat_sys_s390_fallocate
+314  common	fallocate		sys_fallocate			compat_sys_fallocate
 315  common	utimensat		sys_utimensat			compat_sys_utimensat
 316  common	signalfd		sys_signalfd			compat_sys_signalfd
 317  common	timerfd			-				-
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a955113e..0c875169a77b 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -43,6 +43,7 @@
 #else
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #endif
 
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 6d964bdefbaa..6c266582328b 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -246,10 +246,3 @@ long sys32_sync_file_range(unsigned int fd, unsigned long off_high, unsigned lon
 				   (nb_high << 32) | nb_low,
 				   flags);
 }
-
-asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
-				     u32 lenhi, u32 lenlo)
-{
-	return sys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
-			     ((loff_t)lenhi << 32) | lenlo);
-}
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index 5a01cfe19a0e..ec8b097be3fe 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -92,8 +92,6 @@ long sys32_sync_file_range(unsigned int fd,
 			   unsigned long off_high, unsigned long off_low,
 			   unsigned long nb_high, unsigned long nb_low,
 			   unsigned int flags);
-asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
-				     u32 lenhi, u32 lenlo);
 asmlinkage long compat_sys_fstat64(unsigned int fd,
 				   struct compat_stat64 __user * statbuf);
 asmlinkage long compat_sys_fstatat64(unsigned int dfd,
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2a5e99cff859..0d2a8239f63f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -330,7 +330,7 @@
 321	i386	signalfd		sys_signalfd			compat_sys_signalfd
 322	i386	timerfd_create		sys_timerfd_create
 323	i386	eventfd			sys_eventfd
-324	i386	fallocate		sys_fallocate			compat_sys_x86_fallocate
+324	i386	fallocate		sys_fallocate			compat_sys_fallocate
 325	i386	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
 326	i386	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
 327	i386	signalfd4		sys_signalfd4			compat_sys_signalfd4
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 6512498bbef6..3cc430b999a8 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -226,14 +226,6 @@ COMPAT_SYSCALL_DEFINE5(x86_fadvise64, int, fd, unsigned int, offset_lo,
 				len, advice);
 }
 
-COMPAT_SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
-		       unsigned int, offset_lo, unsigned int, offset_hi,
-		       unsigned int, len_lo, unsigned int, len_hi)
-{
-	return sys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
-			     ((u64)len_hi << 32) | len_lo);
-}
-
 /*
  * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
  */
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index 906794aa034e..e0e375b04506 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -53,8 +53,6 @@ asmlinkage long compat_sys_x86_sync_file_range(int, unsigned int, unsigned int,
 					       int);
 asmlinkage long compat_sys_x86_fadvise64(int, unsigned int, unsigned int,
 					 size_t, int);
-asmlinkage long compat_sys_x86_fallocate(int, int, unsigned int, unsigned int,
-					 unsigned int, unsigned int);
 asmlinkage long compat_sys_x86_clone(unsigned long, unsigned long, int __user *,
 				     unsigned long, int __user *);
 
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 51c4eee00732..baf24bf65d4a 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -28,6 +28,8 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
+#  define __ARCH_WANT_LE_COMPAT_SYS
+#  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 
 # endif
 
diff --git a/fs/open.c b/fs/open.c
index 7ea118471dce..4fcf95ef8baa 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -333,7 +333,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 }
 EXPORT_SYMBOL_GPL(vfs_fallocate);
 
-SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
+static int do_fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
@@ -345,6 +345,28 @@ SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
 	return error;
 }
 
+SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
+{
+	return do_fallocate(fd, mode, offset, len);
+}
+
+#ifdef __ARCH_WANT_COMPAT_SYS_FALLOCATE
+#ifdef __ARCH_WANT_LE_COMPAT_SYS
+COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
+		       unsigned int, offset_lo, unsigned int, offset_hi,
+		       unsigned int, len_lo, unsigned int, len_hi)
+#else /* __ARCH_WANT_LE_COMPAT_SYS */
+COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
+		       unsigned int, offset_hi, unsigned int, offset_lo,
+		       unsigned int, len_hi, unsigned int, len_lo)
+#endif /* __ARCH_WANT_LE_COMPAT_SYS */
+{
+	return do_fallocate(fd, mode, ((loff_t) offset_hi << 32) | offset_lo,
+			      ((loff_t) len_hi << 32) | len_lo);
+}
+#endif /* __ARCH_WANT_COMPAT_SYS_FALLOCATE */
+
+
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 16c3027074a2..978011c03075 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -840,6 +840,12 @@ asmlinkage long compat_sys_sigprocmask(int how, compat_old_sigset_t __user *nset
 				       compat_old_sigset_t __user *oset);
 #endif
 
+#ifdef __ARCH_WANT_COMPAT_SYS_FALLOCATE
+/* __ARCH_WANT_LE_COMPAT_SYS determines order of lo and hi */
+asmlinkage long compat_sys_fallocate(int, int, unsigned int, unsigned int,
+				     unsigned int, unsigned int);
+#endif
+
 int compat_restore_altstack(const compat_stack_t __user *uss);
 int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 #define compat_save_altstack_ex(uss, sp) do { \
-- 
2.16.2
