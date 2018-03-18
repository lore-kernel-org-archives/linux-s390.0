From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 3/6] fs: provide generic compat_sys_p{read,write}64() implementations
Date: Sun, 18 Mar 2018 17:10:53 +0100
Message-ID: <20180318161056.5377-4-linux@dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318161056.5377-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

The compat_sys_{read,write}64() implementations in mips, powerpc, s390,
sparc and x86 only differed based on whether the u64 parameter needed
padding and on their endianness.

Oh, and some defined the parameters as u64 or "unsigned long" which
expanded to u64, though it only expected u32 in these parameters.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
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
 arch/mips/include/asm/unistd.h         |  1 +
 arch/mips/kernel/linux32.c             | 16 --------
 arch/mips/kernel/scall64-o32.S         |  4 +-
 arch/powerpc/include/asm/unistd.h      |  1 +
 arch/powerpc/kernel/sys_ppc32.c        | 12 ------
 arch/s390/include/asm/unistd.h         |  1 +
 arch/s390/kernel/compat_linux.c        | 16 --------
 arch/s390/kernel/compat_linux.h        |  2 -
 arch/s390/kernel/syscalls/syscall.tbl  |  4 +-
 arch/sparc/include/asm/unistd.h        |  1 +
 arch/sparc/kernel/sys_sparc32.c        | 18 ---------
 arch/sparc/kernel/systbls.h            | 10 -----
 arch/sparc/kernel/systbls_64.S         |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl |  4 +-
 arch/x86/ia32/sys_ia32.c               | 16 --------
 arch/x86/include/asm/sys_ia32.h        |  5 ---
 arch/x86/include/asm/unistd.h          |  1 +
 fs/read_write.c                        | 74 ++++++++++++++++++++++++++++++++--
 include/linux/compat.h                 | 15 +++++++
 19 files changed, 97 insertions(+), 106 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 8aa5b7a19133..3ddc271ad77b 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -48,6 +48,7 @@
 #  define __ARCH_WANT_COMPAT_SYS_TIME
 #  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #  define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
+#  define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
 #  ifdef __MIPSEL__
 #    define __ARCH_WANT_LE_COMPAT_SYS
 #  endif
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index f3aad4ca5560..871cda53a915 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -92,22 +92,6 @@ SYSCALL_DEFINE5(32_llseek, unsigned int, fd, unsigned int, offset_high,
 	return sys_llseek(fd, offset_high, offset_low, result, origin);
 }
 
-/* From the Single Unix Spec: pread & pwrite act like lseek to pos + op +
-   lseek back to original location.  They fail just like lseek does on
-   non-seekable files.	*/
-
-SYSCALL_DEFINE6(32_pread, unsigned long, fd, char __user *, buf, size_t, count,
-	unsigned long, unused, unsigned long, a4, unsigned long, a5)
-{
-	return sys_pread64(fd, buf, count, merge_64(a4, a5));
-}
-
-SYSCALL_DEFINE6(32_pwrite, unsigned int, fd, const char __user *, buf,
-	size_t, count, u32, unused, u64, a4, u64, a5)
-{
-	return sys_pwrite64(fd, buf, count, merge_64(a4, a5));
-}
-
 SYSCALL_DEFINE1(32_personality, unsigned long, personality)
 {
 	unsigned int p = personality & 0xffffffff;
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 216450516b44..fbc463b234a1 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -416,8 +416,8 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_rt_sigtimedwait
 	PTR	compat_sys_rt_sigqueueinfo
 	PTR	compat_sys_rt_sigsuspend
-	PTR	sys_32_pread			/* 4200 */
-	PTR	sys_32_pwrite
+	PTR	compat_sys_pread64		/* 4200 */
+	PTR	compat_sys_pwrite64
 	PTR	sys_chown
 	PTR	sys_getcwd
 	PTR	sys_capget
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index dca76157f27e..704f2413ac30 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -52,6 +52,7 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
+#define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
 #endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index dab9eece7731..ec896c8df968 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -74,18 +74,6 @@ unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
  * The 32 bit ABI passes long longs in an odd even register pair.
  */
 
-compat_ssize_t compat_sys_pread64(unsigned int fd, char __user *ubuf, compat_size_t count,
-			     u32 reg6, u32 poshi, u32 poslo)
-{
-	return sys_pread64(fd, ubuf, count, ((loff_t)poshi << 32) | poslo);
-}
-
-compat_ssize_t compat_sys_pwrite64(unsigned int fd, const char __user *ubuf, compat_size_t count,
-			      u32 reg6, u32 poshi, u32 poslo)
-{
-	return sys_pwrite64(fd, ubuf, count, ((loff_t)poshi << 32) | poslo);
-}
-
 compat_ssize_t compat_sys_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 count)
 {
 	return sys_readahead(fd, ((loff_t)offhi << 32) | offlo, count);
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 7667a2d0b1e1..71e6f7d65762 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -36,6 +36,7 @@
 #   define __ARCH_WANT_COMPAT_SYS_TIME
 #   define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #   define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
+#   define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 469addfe7a85..8dd12a9d99a3 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -305,22 +305,6 @@ COMPAT_SYSCALL_DEFINE3(s390_ftruncate64, unsigned int, fd, u32, high, u32, low)
 	return sys_ftruncate(fd, (unsigned long)high << 32 | low);
 }
 
-COMPAT_SYSCALL_DEFINE5(s390_pread64, unsigned int, fd, char __user *, ubuf,
-		       compat_size_t, count, u32, high, u32, low)
-{
-	if ((compat_ssize_t) count < 0)
-		return -EINVAL;
-	return sys_pread64(fd, ubuf, count, (unsigned long)high << 32 | low);
-}
-
-COMPAT_SYSCALL_DEFINE5(s390_pwrite64, unsigned int, fd, const char __user *, ubuf,
-		       compat_size_t, count, u32, high, u32, low)
-{
-	if ((compat_ssize_t) count < 0)
-		return -EINVAL;
-	return sys_pwrite64(fd, ubuf, count, (unsigned long)high << 32 | low);
-}
-
 COMPAT_SYSCALL_DEFINE4(s390_readahead, int, fd, u32, high, u32, low, s32, count)
 {
 	return sys_readahead(fd, (unsigned long)high << 32 | low, count);
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index 17db19a91e63..35fe45225185 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -108,8 +108,6 @@ long compat_sys_s390_geteuid16(void);
 long compat_sys_s390_getgid16(void);
 long compat_sys_s390_getegid16(void);
 long compat_sys_s390_ftruncate64(unsigned int fd, u32 high, u32 low);
-long compat_sys_s390_pread64(unsigned int fd, char __user *ubuf, compat_size_t count, u32 high, u32 low);
-long compat_sys_s390_pwrite64(unsigned int fd, const char __user *ubuf, compat_size_t count, u32 high, u32 low);
 long compat_sys_s390_readahead(int fd, u32 high, u32 low, s32 count);
 long compat_sys_s390_stat64(const char __user *filename, struct stat64_emu31 __user *statbuf);
 long compat_sys_s390_lstat64(const char __user *filename, struct stat64_emu31 __user *statbuf);
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index d8dec7c9d2a5..ceaf5ab6ac47 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -168,8 +168,8 @@
 177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
 178  common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179  common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-180  common	pread64			sys_pread64			compat_sys_s390_pread64
-181  common	pwrite64		sys_pwrite64			compat_sys_s390_pwrite64
+180  common	pread64			sys_pread64			compat_sys_pread64
+181  common	pwrite64		sys_pwrite64			compat_sys_pwrite64
 182  32		chown			-				compat_sys_s390_chown16
 183  common	getcwd			sys_getcwd			compat_sys_getcwd
 184  common	capget			sys_capget			compat_sys_capget
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 0398d9be05a5..e04452be8db4 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -45,6 +45,7 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
+#define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
 #endif
 
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 39f8a5845285..8a4f5accf6be 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -186,24 +186,6 @@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, int, sig,
         return ret;
 }
 
-asmlinkage compat_ssize_t sys32_pread64(unsigned int fd,
-					char __user *ubuf,
-					compat_size_t count,
-					unsigned long poshi,
-					unsigned long poslo)
-{
-	return sys_pread64(fd, ubuf, count, (poshi << 32) | poslo);
-}
-
-asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd,
-					 char __user *ubuf,
-					 compat_size_t count,
-					 unsigned long poshi,
-					 unsigned long poslo)
-{
-	return sys_pwrite64(fd, ubuf, count, (poshi << 32) | poslo);
-}
-
 asmlinkage long compat_sys_readahead(int fd,
 				     unsigned long offhi,
 				     unsigned long offlo,
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index 92659147ca76..6b5fd12e821d 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -63,16 +63,6 @@ asmlinkage long compat_sys_fstat64(unsigned int fd,
 asmlinkage long compat_sys_fstatat64(unsigned int dfd,
 				     const char __user *filename,
 				     struct compat_stat64 __user * statbuf, int flag);
-asmlinkage compat_ssize_t sys32_pread64(unsigned int fd,
-					char __user *ubuf,
-					compat_size_t count,
-					unsigned long poshi,
-					unsigned long poslo);
-asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd,
-					 char __user *ubuf,
-					 compat_size_t count,
-					 unsigned long poshi,
-					 unsigned long poslo);
 asmlinkage long compat_sys_readahead(int fd,
 				     unsigned long offhi,
 				     unsigned long offlo,
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 9d718a9ec52d..33731b4e8819 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -32,7 +32,7 @@ sys_call_table32:
 /*50*/	.word sys_getegid16, sys_acct, sys_nis_syscall, sys_getgid, compat_sys_ioctl
 	.word sys_reboot, sys32_mmap2, sys_symlink, sys_readlink, sys32_execve
 /*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, compat_sys_fstat64, sys_getpagesize
-	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
+	.word sys_msync, sys_vfork, compat_sys_pread64, compat_sys_pwrite64, sys_geteuid
 /*70*/	.word sys_getegid, sys_mmap, sys_setreuid, sys_munmap, sys_mprotect
 	.word sys_madvise, sys_vhangup, compat_sys_truncate64, sys_mincore, sys_getgroups16
 /*80*/	.word sys_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c60caeac57f9..2f39235785d8 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -186,8 +186,8 @@
 177	i386	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179	i386	rt_sigsuspend		sys_rt_sigsuspend
-180	i386	pread64			sys_pread64			compat_sys_x86_pread
-181	i386	pwrite64		sys_pwrite64			compat_sys_x86_pwrite
+180	i386	pread64			sys_pread64			compat_sys_pread64
+181	i386	pwrite64		sys_pwrite64			compat_sys_pwrite64
 182	i386	chown			sys_chown16
 183	i386	getcwd			sys_getcwd
 184	i386	capget			sys_capget
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 56e2e605892c..eae207229a93 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -167,22 +167,6 @@ COMPAT_SYSCALL_DEFINE3(x86_waitpid, compat_pid_t, pid, unsigned int __user *,
 	return compat_sys_wait4(pid, stat_addr, options, NULL);
 }
 
-/* warning: next two assume little endian */
-COMPAT_SYSCALL_DEFINE5(x86_pread, unsigned int, fd, char __user *, ubuf,
-		       u32, count, u32, poslo, u32, poshi)
-{
-	return sys_pread64(fd, ubuf, count,
-			 ((loff_t)AA(poshi) << 32) | AA(poslo));
-}
-
-COMPAT_SYSCALL_DEFINE5(x86_pwrite, unsigned int, fd, const char __user *, ubuf,
-		       u32, count, u32, poslo, u32, poshi)
-{
-	return sys_pwrite64(fd, ubuf, count,
-			  ((loff_t)AA(poshi) << 32) | AA(poslo));
-}
-
-
 /*
  * Some system calls that need sign extended arguments. This could be
  * done by a generic wrapper.
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index 9d928ec5b78a..ded631bb33de 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -36,11 +36,6 @@ asmlinkage long compat_sys_x86_mmap(struct mmap_arg_struct32 __user *);
 asmlinkage long compat_sys_x86_waitpid(compat_pid_t, unsigned int __user *,
 				       int);
 
-asmlinkage long compat_sys_x86_pread(unsigned int, char __user *, u32, u32,
-				     u32);
-asmlinkage long compat_sys_x86_pwrite(unsigned int, const char __user *, u32,
-				      u32, u32);
-
 asmlinkage long compat_sys_x86_fadvise64_64(int, __u32, __u32, __u32, __u32,
 					    int);
 
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 382b1e5272db..be8f52494ee3 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -31,6 +31,7 @@
 #  define __ARCH_WANT_LE_COMPAT_SYS
 #  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #  define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
+#  define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
 
 # endif
 
diff --git a/fs/read_write.c b/fs/read_write.c
index f8547b82dfb3..071197e856fc 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -595,8 +595,8 @@ SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
 	return ret;
 }
 
-SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
-			size_t, count, loff_t, pos)
+static ssize_t do_pread64(unsigned int fd, char __user *buf,
+			  size_t count, loff_t pos)
 {
 	struct fd f;
 	ssize_t ret = -EBADF;
@@ -615,8 +615,8 @@ SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
 	return ret;
 }
 
-SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
-			 size_t, count, loff_t, pos)
+static ssize_t do_pwrite64(unsigned int fd, const char __user *buf,
+			   size_t count, loff_t pos)
 {
 	struct fd f;
 	ssize_t ret = -EBADF;
@@ -635,6 +635,72 @@ SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
 	return ret;
 }
 
+SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
+			size_t, count, loff_t, pos)
+{
+	return do_pread64(fd, buf, count, pos);
+}
+
+SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
+			 size_t, count, loff_t, pos)
+{
+	return do_pwrite64(fd, buf, count, pos);
+}
+
+#ifdef __ARCH_WANT_COMPAT_SYS_PREADWRITE64
+#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
+		       u32, count, u32, padding, u32, poslo, u32, poshi)
+#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	!defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
+		       u32, count, u32, padding, u32, poshi, u32, poslo)
+#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
+		       u32, count, u32, poslo, u32, poshi)
+#else /* no padding, big endian */
+COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
+		       u32, count, u32, poshi, u32, poslo)
+#endif
+{
+#ifdef CONFIG_S390
+	if ((compat_ssize_t) count < 0)
+		return -EINVAL;
+#endif /* CONFIG_S390 */
+	return do_pread64(fd, ubuf, count,
+			  ((loff_t) (unsigned long) (poshi) << 32) |
+				(unsigned long) (poslo));
+}
+
+#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE6(pwrite64, unsigned int, fd, const char __user *, ubuf,
+		       u32, count, u32, padding, u32, poslo, u32, poshi)
+#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	!defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE6(pwrite64, unsigned int, fd, const char __user *, ubuf,
+		       u32, count, u32, padding, u32, poshi, u32, poslo)
+#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE5(pwrite64, unsigned int, fd, const char __user *, ubuf,
+		       u32, count, u32, poslo, u32, poshi)
+#else /* no padding, big endian */
+COMPAT_SYSCALL_DEFINE5(pwrite64, unsigned int, fd, const char __user *, ubuf,
+		       u32, count, u32, poshi, u32, poslo)
+#endif
+{
+#ifdef CONFIG_S390
+	if ((compat_ssize_t) count < 0)
+		return -EINVAL;
+#endif /* CONFIG_S390 */
+	return do_pwrite64(fd, ubuf, count,
+			   ((loff_t) (unsigned long) (poshi) << 32) |
+				(unsigned long) (poslo));
+}
+#endif /* __ARCH_WANT_COMPAT_SYS_PREADWRITE64 */
+
 static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 		loff_t *ppos, int type, rwf_t flags)
 {
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 454ccad57d84..95301d1a6793 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -857,6 +857,21 @@ asmlinkage long compat_sys_truncate64(const char __user *,
 #endif /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
 #endif /* __ARCH_WANT_COMPAT_SYS_TRUNCATE64 */
 
+#ifdef __ARCH_WANT_COMPAT_SYS_PREADWRITE64
+/* __ARCH_WANT_LE_COMPAT_SYS determines order of lo and hi */
+#ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
+asmlinkage long compat_sys_pwrite64(unsigned int, const char __user *, u32,
+				    u32, u32, u32);
+asmlinkage long compat_sys_pread64(unsigned int, char __user *, u32,
+				    u32, u32, u32);
+#else /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
+asmlinkage long compat_sys_pwrite64(unsigned int, const char __user *,
+				    u32, u32, u32);
+asmlinkage long compat_sys_pread64(unsigned int, char __user *,
+				    u32, u32, u32);
+#endif /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
+#endif /* __ARCH_WANT_COMPAT_SYS_PREADWRITE64 */
+
 int compat_restore_altstack(const compat_stack_t __user *uss);
 int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 #define compat_save_altstack_ex(uss, sp) do { \
-- 
2.16.2
