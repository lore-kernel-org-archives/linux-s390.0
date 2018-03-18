From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead() implementation
Date: Sun, 18 Mar 2018 17:10:54 +0100
Message-ID: <20180318161056.5377-5-linux@dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318161056.5377-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

The compat_sys_readahead() implementations in mips, powerpc, s390, sparc
and x86 only differed based on whether the u64 parameter needed padding
and on their endianness.

Oh, and some defined the parameters as u64 or "unsigned long" which
expanded to u64, though it only expected u32 in these parameters.

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
 arch/mips/include/asm/unistd.h         |  1 +
 arch/mips/kernel/linux32.c             |  6 ---
 arch/mips/kernel/scall64-o32.S         |  2 +-
 arch/powerpc/include/asm/unistd.h      |  1 +
 arch/powerpc/kernel/sys_ppc32.c        |  5 ---
 arch/s390/include/asm/unistd.h         |  1 +
 arch/s390/kernel/compat_linux.c        |  5 ---
 arch/s390/kernel/compat_linux.h        |  1 -
 arch/s390/kernel/syscalls/syscall.tbl  |  2 +-
 arch/sparc/include/asm/unistd.h        |  1 +
 arch/sparc/kernel/sys_sparc32.c        |  8 ----
 arch/sparc/kernel/systbls.h            |  4 --
 arch/x86/entry/syscalls/syscall_32.tbl |  2 +-
 arch/x86/ia32/sys_ia32.c               |  6 ---
 arch/x86/include/asm/sys_ia32.h        |  2 -
 arch/x86/include/asm/unistd.h          |  1 +
 include/linux/compat.h                 | 10 +++++
 mm/readahead.c                         | 81 ++++++++++++++++++++++++----------
 18 files changed, 76 insertions(+), 63 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 3ddc271ad77b..f8f9046164ae 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -49,6 +49,7 @@
 #  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #  define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #  define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
+#  define __ARCH_WANT_COMPAT_SYS_READAHEAD
 #  ifdef __MIPSEL__
 #    define __ARCH_WANT_LE_COMPAT_SYS
 #  endif
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 871cda53a915..c40ce08be17d 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -106,12 +106,6 @@ SYSCALL_DEFINE1(32_personality, unsigned long, personality)
 	return ret;
 }
 
-asmlinkage ssize_t sys32_readahead(int fd, u32 pad0, u64 a2, u64 a3,
-				   size_t count)
-{
-	return sys_readahead(fd, merge_64(a2, a3), count);
-}
-
 asmlinkage long sys32_sync_file_range(int fd, int __pad,
 	unsigned long a2, unsigned long a3,
 	unsigned long a4, unsigned long a5,
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index fbc463b234a1..eb4e66ba025a 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -439,7 +439,7 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_fcntl64		/* 4220 */
 	PTR	sys_ni_syscall
 	PTR	sys_gettid
-	PTR	sys32_readahead
+	PTR	compat_sys_readahead
 	PTR	sys_setxattr
 	PTR	sys_lsetxattr			/* 4225 */
 	PTR	sys_fsetxattr
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 704f2413ac30..870317a35763 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -53,6 +53,7 @@
 #define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
+#define __ARCH_WANT_COMPAT_SYS_READAHEAD
 #endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index ec896c8df968..289ae55bb4b5 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -74,11 +74,6 @@ unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
  * The 32 bit ABI passes long longs in an odd even register pair.
  */
 
-compat_ssize_t compat_sys_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 count)
-{
-	return sys_readahead(fd, ((loff_t)offhi << 32) | offlo, count);
-}
-
 asmlinkage int compat_sys_ftruncate64(unsigned int fd, u32 reg4, unsigned long high,
 				 unsigned long low)
 {
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 71e6f7d65762..685ad7944850 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -37,6 +37,7 @@
 #   define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #   define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #   define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
+#   define __ARCH_WANT_COMPAT_SYS_READAHEAD
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 8dd12a9d99a3..9f111d1f1ec2 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -305,11 +305,6 @@ COMPAT_SYSCALL_DEFINE3(s390_ftruncate64, unsigned int, fd, u32, high, u32, low)
 	return sys_ftruncate(fd, (unsigned long)high << 32 | low);
 }
 
-COMPAT_SYSCALL_DEFINE4(s390_readahead, int, fd, u32, high, u32, low, s32, count)
-{
-	return sys_readahead(fd, (unsigned long)high << 32 | low, count);
-}
-
 struct stat64_emu31 {
 	unsigned long long  st_dev;
 	unsigned int    __pad1;
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index 35fe45225185..cac6dd7bced0 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -108,7 +108,6 @@ long compat_sys_s390_geteuid16(void);
 long compat_sys_s390_getgid16(void);
 long compat_sys_s390_getegid16(void);
 long compat_sys_s390_ftruncate64(unsigned int fd, u32 high, u32 low);
-long compat_sys_s390_readahead(int fd, u32 high, u32 low, s32 count);
 long compat_sys_s390_stat64(const char __user *filename, struct stat64_emu31 __user *statbuf);
 long compat_sys_s390_lstat64(const char __user *filename, struct stat64_emu31 __user *statbuf);
 long compat_sys_s390_fstat64(unsigned int fd, struct stat64_emu31 __user *statbuf);
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index ceaf5ab6ac47..a7d989a292f7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -230,7 +230,7 @@
 219  common	madvise			sys_madvise			compat_sys_madvise
 220  common	getdents64		sys_getdents64			compat_sys_getdents64
 221  32		fcntl64			-				compat_sys_fcntl64
-222  common	readahead		sys_readahead			compat_sys_s390_readahead
+222  common	readahead		sys_readahead			compat_sys_readahead
 223  32		sendfile64		-				compat_sys_sendfile64
 224  common	setxattr		sys_setxattr			compat_sys_setxattr
 225  common	lsetxattr		sys_lsetxattr			compat_sys_lsetxattr
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index e04452be8db4..85579de64f60 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -46,6 +46,7 @@
 #define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
+#define __ARCH_WANT_COMPAT_SYS_READAHEAD
 #endif
 
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 8a4f5accf6be..cade09deff8d 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -186,14 +186,6 @@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, int, sig,
         return ret;
 }
 
-asmlinkage long compat_sys_readahead(int fd,
-				     unsigned long offhi,
-				     unsigned long offlo,
-				     compat_size_t count)
-{
-	return sys_readahead(fd, (offhi << 32) | offlo, count);
-}
-
 long compat_sys_fadvise64(int fd,
 			  unsigned long offhi,
 			  unsigned long offlo,
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index 6b5fd12e821d..aad40627ba52 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -63,10 +63,6 @@ asmlinkage long compat_sys_fstat64(unsigned int fd,
 asmlinkage long compat_sys_fstatat64(unsigned int dfd,
 				     const char __user *filename,
 				     struct compat_stat64 __user * statbuf, int flag);
-asmlinkage long compat_sys_readahead(int fd,
-				     unsigned long offhi,
-				     unsigned long offlo,
-				     compat_size_t count);
 long compat_sys_fadvise64(int fd,
 			  unsigned long offhi,
 			  unsigned long offlo,
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2f39235785d8..17b8dc7130f5 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -231,7 +231,7 @@
 # 222 is unused
 # 223 is unused
 224	i386	gettid			sys_gettid
-225	i386	readahead		sys_readahead			compat_sys_x86_readahead
+225	i386	readahead		sys_readahead			compat_sys_readahead
 226	i386	setxattr		sys_setxattr
 227	i386	lsetxattr		sys_lsetxattr
 228	i386	fsetxattr		sys_fsetxattr
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index eae207229a93..89dcb36d19da 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -181,12 +181,6 @@ COMPAT_SYSCALL_DEFINE6(x86_fadvise64_64, int, fd, __u32, offset_low,
 				advice);
 }
 
-COMPAT_SYSCALL_DEFINE4(x86_readahead, int, fd, unsigned int, off_lo,
-		       unsigned int, off_hi, size_t, count)
-{
-	return sys_readahead(fd, ((u64)off_hi << 32) | off_lo, count);
-}
-
 COMPAT_SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
 		       unsigned int, off_hi, unsigned int, n_low,
 		       unsigned int, n_hi, int, flags)
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index ded631bb33de..6a78bee5a314 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -39,8 +39,6 @@ asmlinkage long compat_sys_x86_waitpid(compat_pid_t, unsigned int __user *,
 asmlinkage long compat_sys_x86_fadvise64_64(int, __u32, __u32, __u32, __u32,
 					    int);
 
-asmlinkage ssize_t compat_sys_x86_readahead(int, unsigned int, unsigned int,
-					    size_t);
 asmlinkage long compat_sys_x86_sync_file_range(int, unsigned int, unsigned int,
 					       unsigned int, unsigned int,
 					       int);
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index be8f52494ee3..8d56e1dd71d6 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -32,6 +32,7 @@
 #  define __ARCH_WANT_COMPAT_SYS_FALLOCATE
 #  define __ARCH_WANT_COMPAT_SYS_TRUNCATE64
 #  define __ARCH_WANT_COMPAT_SYS_PREADWRITE64
+#  define __ARCH_WANT_COMPAT_SYS_READAHEAD
 
 # endif
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 95301d1a6793..96d1244b332e 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -872,6 +872,16 @@ asmlinkage long compat_sys_pread64(unsigned int, char __user *,
 #endif /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
 #endif /* __ARCH_WANT_COMPAT_SYS_PREADWRITE64 */
 
+#ifdef __ARCH_WANT_COMPAT_SYS_READAHEAD
+/* __ARCH_WANT_LE_COMPAT_SYS determines order of lo and hi */
+#ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
+asmlinkage long compat_sys_readahead(int, unsigned int, unsigned int,
+				     unsigned int, size_t);
+#else /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
+asmlinkage long compat_sys_readahead(int, unsigned int, unsigned int, size_t);
+#endif /* __ARCH_WANT_COMPAT_SYS_WITH_PADDING */
+#endif /* __ARCH_WANT_COMPAT_SYS_READAHEAD */
+
 int compat_restore_altstack(const compat_stack_t __user *uss);
 int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 #define compat_save_altstack_ex(uss, sp) do { \
diff --git a/mm/readahead.c b/mm/readahead.c
index c4ca70239233..092866309593 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -17,6 +17,7 @@
 #include <linux/pagevec.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/file.h>
 #include <linux/mm_inline.h>
 
@@ -555,40 +556,74 @@ page_cache_async_readahead(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 
-static ssize_t
-do_readahead(struct address_space *mapping, struct file *filp,
-	     pgoff_t index, unsigned long nr)
+static ssize_t do_readahead(int fd, loff_t offset, size_t count)
 {
-	if (!mapping || !mapping->a_ops)
-		return -EINVAL;
+	ssize_t ret = -EBADF;
+	struct fd f;
+	struct address_space *mapping;
+	pgoff_t start = offset >> PAGE_SHIFT;
+	pgoff_t end = (offset + count - 1) >> PAGE_SHIFT;
+	unsigned long len = end - start + 1;
+
+	f = fdget(fd);
+	if (!f.file)
+		goto out;
+
+	if (!(f.file->f_mode & FMODE_READ))
+		goto put_out;
+
+	mapping = f.file->f_mapping;
+	if (!mapping || !mapping->a_ops) {
+		ret = -EINVAL;
+		goto put_out;
+	}
 
 	/*
 	 * Readahead doesn't make sense for DAX inodes, but we don't want it
 	 * to report a failure either.  Instead, we just return success and
 	 * don't do any work.
 	 */
-	if (dax_mapping(mapping))
-		return 0;
+	if (dax_mapping(mapping)) {
+		ret = 0;
+		goto put_out;
+	}
+
+	ret = force_page_cache_readahead(mapping, f.file, start, len);
 
-	return force_page_cache_readahead(mapping, filp, index, nr);
+put_out:
+	fdput(f);
+
+out:
+	return ret;
 }
 
 SYSCALL_DEFINE3(readahead, int, fd, loff_t, offset, size_t, count)
 {
-	ssize_t ret;
-	struct fd f;
+	return do_readahead(fd, offset, count);
+}
 
-	ret = -EBADF;
-	f = fdget(fd);
-	if (f.file) {
-		if (f.file->f_mode & FMODE_READ) {
-			struct address_space *mapping = f.file->f_mapping;
-			pgoff_t start = offset >> PAGE_SHIFT;
-			pgoff_t end = (offset + count - 1) >> PAGE_SHIFT;
-			unsigned long len = end - start + 1;
-			ret = do_readahead(mapping, f.file, start, len);
-		}
-		fdput(f);
-	}
-	return ret;
+#ifdef __ARCH_WANT_COMPAT_SYS_READAHEAD
+#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
+		       unsigned int, off_lo, unsigned int, off_hi,
+		       size_t, count)
+#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	!defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
+		       unsigned int, off_hi, unsigned int, off_lo,
+		       size_t, count)
+#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
+	defined(__ARCH_WANT_LE_COMPAT_SYS)
+COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
+		       unsigned int, off_lo, unsigned int, off_hi,
+		       size_t, count)
+#else /* no padding, big endian */
+COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
+		       unsigned int, off_hi, unsigned int, off_lo,
+		       size_t, count)
+#endif
+{
+	return do_readahead(fd, ((u64) off_hi << 32) | off_lo, count);
 }
+#endif /* __ARCH_WANT_COMPAT_SYS_READAHEAD */
-- 
2.16.2
