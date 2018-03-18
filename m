From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 2/6] fs: provide a generic compat_sys_truncate64() implementation
Date: Sun, 18 Mar 2018 17:10:52 +0100
Message-ID: <20180318161056.5377-3-linux@dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318161056.5377-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

The compat_sys_truncate64() implementations in mips, powerpc, s390, sparc
and x86 only differed based on whether the u64 parameter needed padding
and on its endianness.

Oh, and some defined the parameters as "unsigned long" which expanded to
u64, though it only expected u32 in these parameters.

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
 arch/mips/include/asm/unistd.h         |  2 ++
 arch/mips/kernel/linux32.c             |  6 ------
 arch/mips/kernel/scall64-o32.S         |  2 +-
 arch/powerpc/include/asm/unistd.h      |  2 ++
 arch/powerpc/kernel/sys_ppc32.c        |  6 ------
 arch/s390/include/asm/unistd.h         |  1 +
 arch/s390/kernel/compat_linux.c        |  5 -----
 arch/s390/kernel/compat_linux.h        |  1 -
 arch/s390/kernel/syscalls/syscall.tbl  |  2 +-
 arch/sparc/include/asm/unistd.h        |  1 +
 arch/sparc/kernel/sys_sparc32.c        |  8 --------
 arch/sparc/kernel/systbls.h            |  3 ---
 arch/sparc/kernel/systbls_64.S         |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl |  2 +-
 arch/x86/ia32/sys_ia32.c               |  7 -------
 arch/x86/include/asm/sys_ia32.h        |  2 --
 arch/x86/include/asm/unistd.h          |  1 +
 fs/open.c                              | 28 +++++++++++++++++++++++++++-
 include/linux/compat.h                 | 11 +++++++++++
 19 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index bec9c6f55956..8aa5b7a19133 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -44,8 +44,10 @@
 #  define __ARCH_WANT_SYS_TIME
 # endif
 # ifdef CONFIG_MIPS32_O32
+#  define __ARCH_WANT_COMPAT_SYS_WITH_PADDING
 #  define __ARCH_WANT_COMPAT_SYS_TIME
 #  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
+#  define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #  ifdef __MIPSEL__
 #    define __ARCH_WANT_LE_COMPAT_SYS
 #  endif
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index f6e6cb41c01f..f3aad4ca5560 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -79,12 +79,6 @@ struct rlimit32 {
 	int	rlim_max;
 };
 
-SYSCALL_DEFINE4(32_truncate64, const char __user *, path,
-	unsigned long, __dummy, unsigned long, a2, unsigned long, a3)
-{
-	return sys_truncate(path, merge_64(a2, a3));
-}
-
 SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
 	unsigned long, a2, unsigned long, a3)
 {
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index da8babc2c1f5..216450516b44 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -427,7 +427,7 @@ EXPORT(sys32_call_table)
 	PTR	sys_ni_syscall
 	PTR	sys_ni_syscall
 	PTR	sys_mips_mmap2			/* 4210 */
-	PTR	sys_32_truncate64
+	PTR	compat_sys_truncate64
 	PTR	sys_32_ftruncate64
 	PTR	sys_newstat
 	PTR	sys_newlstat
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 46890687fb1d..dca76157f27e 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -46,10 +46,12 @@
 #define __ARCH_WANT_OLD_STAT
 #endif
 #ifdef CONFIG_PPC64
+#define __ARCH_WANT_COMPAT_SYS_WITH_PADDING
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_SYS_NEWFSTATAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #define __ARCH_WANT_COMPAT_SYS_FALLOCATE
+#define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 7c6da6273367..dab9eece7731 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -91,12 +91,6 @@ compat_ssize_t compat_sys_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 co
 	return sys_readahead(fd, ((loff_t)offhi << 32) | offlo, count);
 }
 
-asmlinkage int compat_sys_truncate64(const char __user * path, u32 reg4,
-				unsigned long high, unsigned long low)
-{
-	return sys_truncate(path, (high << 32) | low);
-}
-
 asmlinkage int compat_sys_ftruncate64(unsigned int fd, u32 reg4, unsigned long high,
 				 unsigned long low)
 {
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 5e919c11c11f..7667a2d0b1e1 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -35,6 +35,7 @@
 # ifdef CONFIG_COMPAT
 #   define __ARCH_WANT_COMPAT_SYS_TIME
 #   define __ARCH_WANT_COMPAT_SYS_FALLOCATE
+#   define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 3052f8e5ba42..469addfe7a85 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -300,11 +300,6 @@ COMPAT_SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, compat_ulong_t, second,
 }
 #endif
 
-COMPAT_SYSCALL_DEFINE3(s390_truncate64, const char __user *, path, u32, high, u32, low)
-{
-	return sys_truncate(path, (unsigned long)high << 32 | low);
-}
-
 COMPAT_SYSCALL_DEFINE3(s390_ftruncate64, unsigned int, fd, u32, high, u32, low)
 {
 	return sys_ftruncate(fd, (unsigned long)high << 32 | low);
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index cfc3d42603a8..17db19a91e63 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -107,7 +107,6 @@ long compat_sys_s390_getuid16(void);
 long compat_sys_s390_geteuid16(void);
 long compat_sys_s390_getgid16(void);
 long compat_sys_s390_getegid16(void);
-long compat_sys_s390_truncate64(const char __user *path, u32 high, u32 low);
 long compat_sys_s390_ftruncate64(unsigned int fd, u32 high, u32 low);
 long compat_sys_s390_pread64(unsigned int fd, char __user *ubuf, compat_size_t count, u32 high, u32 low);
 long compat_sys_s390_pwrite64(unsigned int fd, const char __user *ubuf, compat_size_t count, u32 high, u32 low);
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 652863bb7fcb..d8dec7c9d2a5 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -182,7 +182,7 @@
 191  32		ugetrlimit		-				compat_sys_getrlimit
 191  64		getrlimit		sys_getrlimit			-
 192  32		mmap2			-				compat_sys_s390_mmap2
-193  32		truncate64		-				compat_sys_s390_truncate64
+193  32		truncate64		-				compat_sys_truncate64
 194  32		ftruncate64		-				compat_sys_s390_ftruncate64
 195  32		stat64			-				compat_sys_s390_stat64
 196  32		lstat64			-				compat_sys_s390_lstat64
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 0c875169a77b..0398d9be05a5 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -44,6 +44,7 @@
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #define __ARCH_WANT_COMPAT_SYS_FALLOCATE
+#define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #endif
 
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 6c266582328b..39f8a5845285 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -52,14 +52,6 @@
 
 #include "systbls.h"
 
-asmlinkage long sys32_truncate64(const char __user * path, unsigned long high, unsigned long low)
-{
-	if ((int)high < 0)
-		return -EINVAL;
-	else
-		return sys_truncate(path, (high << 32) | low);
-}
-
 asmlinkage long sys32_ftruncate64(unsigned int fd, unsigned long high, unsigned long low)
 {
 	if ((int)high < 0)
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index ec8b097be3fe..92659147ca76 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -50,9 +50,6 @@ asmlinkage long sparc_memory_ordering(unsigned long model,
 				      struct pt_regs *regs);
 asmlinkage void sparc64_set_context(struct pt_regs *regs);
 asmlinkage void sparc64_get_context(struct pt_regs *regs);
-asmlinkage long sys32_truncate64(const char __user * path,
-				 unsigned long high,
-				 unsigned long low);
 asmlinkage long sys32_ftruncate64(unsigned int fd,
 				  unsigned long high,
 				  unsigned long low);
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 293c1cb31262..9d718a9ec52d 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -34,7 +34,7 @@ sys_call_table32:
 /*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, compat_sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
 /*70*/	.word sys_getegid, sys_mmap, sys_setreuid, sys_munmap, sys_mprotect
-	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys_getgroups16
+	.word sys_madvise, sys_vhangup, compat_sys_truncate64, sys_mincore, sys_getgroups16
 /*80*/	.word sys_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
 	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
 /*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0d2a8239f63f..c60caeac57f9 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -199,7 +199,7 @@
 190	i386	vfork			sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
 192	i386	mmap2			sys_mmap_pgoff
-193	i386	truncate64		sys_truncate64			compat_sys_x86_truncate64
+193	i386	truncate64		sys_truncate64			compat_sys_truncate64
 194	i386	ftruncate64		sys_ftruncate64			compat_sys_x86_ftruncate64
 195	i386	stat64			sys_stat64			compat_sys_x86_stat64
 196	i386	lstat64			sys_lstat64			compat_sys_x86_lstat64
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 3cc430b999a8..56e2e605892c 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -50,13 +50,6 @@
 
 #define AA(__x)		((unsigned long)(__x))
 
-
-COMPAT_SYSCALL_DEFINE3(x86_truncate64, const char __user *, filename,
-		       unsigned long, offset_low, unsigned long, offset_high)
-{
-       return sys_truncate(filename, ((loff_t) offset_high << 32) | offset_low);
-}
-
 COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
 		       unsigned long, offset_low, unsigned long, offset_high)
 {
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index e0e375b04506..9d928ec5b78a 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -20,8 +20,6 @@
 #include <asm/ia32.h>
 
 /* ia32/sys_ia32.c */
-asmlinkage long compat_sys_x86_truncate64(const char __user *, unsigned long,
-					  unsigned long);
 asmlinkage long compat_sys_x86_ftruncate64(unsigned int, unsigned long,
 					   unsigned long);
 
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index baf24bf65d4a..382b1e5272db 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -30,6 +30,7 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
 #  define __ARCH_WANT_LE_COMPAT_SYS
 #  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
+#  define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 
 # endif
 
diff --git a/fs/open.c b/fs/open.c
index 4fcf95ef8baa..1a0f46de5df5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -222,7 +222,7 @@ COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_ulong_t, length)
 }
 #endif
 
-/* LFS versions of truncate are only needed on 32 bit machines */
+/* LFS versions of truncate are only needed on 32 bit machines or for compat */
 #if BITS_PER_LONG == 32
 SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
 {
@@ -235,6 +235,32 @@ SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
 }
 #endif /* BITS_PER_LONG == 32 */
 
+#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
+#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
+		       unsigned int, offset_low, unsigned int, offset_high)
+#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	!defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
+		       unsigned int, offset_high, unsigned int, offset_low)
+#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
+		       unsigned int, offset_low, unsigned int, offset_high)
+#else /* no padding, big endian */
+COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
+		       unsigned int, offset_high, unsigned int, offset_low)
+#endif
+{
+#ifdef CONFIG_SPARC
+	if ((int) offset_high < 0)
+		return -EINVAL;
+#endif
+	return do_sys_truncate(filename,
+			       ((loff_t) offset_high << 32) | offset_low);
+}
+#endif /* __ARCH_WANT_COMPAT_SYS_TRUNCATE64 */
 
 int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 978011c03075..454ccad57d84 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -846,6 +846,17 @@ asmlinkage long compat_sys_fallocate(int, int, unsigned int, unsigned int,
 				     unsigned int, unsigned int);
 #endif
 
+#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
+/* __ARCH_WANT_LE_COMPAT_SYS determines order of lo and hi */
+#ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
+asmlinkage long compat_sys_truncate64(const char __user *, unsigned int,
+				      unsigned int, unsigned int);
+#else /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
+asmlinkage long compat_sys_truncate64(const char __user *,
+				      unsigned int, unsigned int);
+#endif /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
+#endif /* __ARCH_WANT_COMPAT_SYS_TRUNCATE64 */
+
 int compat_restore_altstack(const compat_stack_t __user *uss);
 int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 #define compat_save_altstack_ex(uss, sp) do { \
-- 
2.16.2
