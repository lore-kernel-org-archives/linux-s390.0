Return-Path: <linux-kernel-owner+w=401wt.eu-S933258AbXGWI5m@vger.kernel.org>
Message-Id: <20070723085721.219481719@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 9/9] Wire up sys_fallocate.
Content-Disposition: inline; filename=009-fallocate.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This patch implements support of fallocate system call on s390(x)
platform.  A wrapper is added to address the issue which s390 ABI has with
the arguments of this system call.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |   10 ++++++++++
 arch/s390/kernel/sys_s390.c       |   20 ++++++++++++++++++++
 arch/s390/kernel/syscalls.S       |    2 +-
 include/asm-s390/unistd.h         |    2 +-
 4 files changed, 32 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_wrapper.S
+++ quilt-2.6/arch/s390/kernel/compat_wrapper.S
@@ -1710,3 +1710,13 @@ compat_sys_timerfd_wrapper:
 sys_eventfd_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	jg	sys_eventfd
+
+	.globl	sys_fallocate_wrapper
+sys_fallocate_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	sllg	%r4,%r4,32		# get high word of 64bit loff_t
+	lr	%r4,%r5			# get low word of 64bit loff_t
+	sllg	%r5,%r6,32		# get high word of 64bit loff_t
+	l	%r5,164(%r15)		# get low word of 64bit loff_t
+	jg	sys_fallocate
Index: quilt-2.6/arch/s390/kernel/syscalls.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/syscalls.S
+++ quilt-2.6/arch/s390/kernel/syscalls.S
@@ -322,7 +322,7 @@ NI_SYSCALL							/* 310 sys_move_pages *
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
 SYSCALL(sys_epoll_pwait,sys_epoll_pwait,compat_sys_epoll_pwait_wrapper)
 SYSCALL(sys_utimes,sys_utimes,compat_sys_utimes_wrapper)
-NI_SYSCALL							/* 314 sys_fallocate */
+SYSCALL(s390_fallocate,sys_fallocate,sys_fallocate_wrapper)
 SYSCALL(sys_utimensat,sys_utimensat,compat_sys_utimensat_wrapper)	/* 315 */
 SYSCALL(sys_signalfd,sys_signalfd,compat_sys_signalfd_wrapper)
 SYSCALL(sys_timerfd,sys_timerfd,compat_sys_timerfd_wrapper)
Index: quilt-2.6/arch/s390/kernel/sys_s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/sys_s390.c
+++ quilt-2.6/arch/s390/kernel/sys_s390.c
@@ -265,3 +265,23 @@ s390_fadvise64_64(struct fadvise64_64_ar
 		return -EFAULT;
 	return sys_fadvise64_64(a.fd, a.offset, a.len, a.advice);
 }
+
+#ifndef CONFIG_64BIT
+/*
+ * This is a wrapper to call sys_fallocate(). For 31 bit s390 the last
+ * 64 bit argument "len" is split into the upper and lower 32 bits. The
+ * system call wrapper in the user space loads the value to %r6/%r7.
+ * The code in entry.S keeps the values in %r2 - %r6 where they are and
+ * stores %r7 to 96(%r15). But the standard C linkage requires that
+ * the whole 64 bit value for len is stored on the stack and doesn't
+ * use %r6 at all. So s390_fallocate has to convert the arguments from
+ *   %r2: fd, %r3: mode, %r4/%r5: offset, %r6/96(%r15)-99(%r15): len
+ * to
+ *   %r2: fd, %r3: mode, %r4/%r5: offset, 96(%r15)-103(%r15): len
+ */
+asmlinkage long s390_fallocate(int fd, int mode, loff_t offset,
+			       u32 len_high, u32 len_low)
+{
+	return sys_fallocate(fd, mode, offset, ((u64)len_high << 32) | len_low);
+}
+#endif
Index: quilt-2.6/include/asm-s390/unistd.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/unistd.h
+++ quilt-2.6/include/asm-s390/unistd.h
@@ -251,7 +251,7 @@
 #define __NR_getcpu		311
 #define __NR_epoll_pwait	312
 #define __NR_utimes		313
-/* Number 314 is reserved for new sys_fallocate */
+#define __NR_fallocate		314
 #define __NR_utimensat		315
 #define __NR_signalfd		316
 #define __NR_timerfd		317

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
