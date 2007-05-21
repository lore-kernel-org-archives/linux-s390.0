Return-Path: <linux-kernel-owner+w=401wt.eu-S1762979AbXEULBD@vger.kernel.org>
Message-Id: <20070521110108.423904782@de.ibm.com>
References: <20070521105118.955425052@de.ibm.com>
Date: Mon, 21 May 2007 12:51:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/5] Wire up sys_utimensat.
Content-Disposition: inline; filename=002-utimensat.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Wire up sys_utimensat, reserve syscall number for sys_fallocate and
add a couple of syscalls to the ignore list to get rid of warings.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    8 ++++++++
 arch/s390/kernel/syscalls.S       |    2 ++
 include/asm-s390/unistd.h         |   18 ++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_wrapper.S
+++ quilt-2.6/arch/s390/kernel/compat_wrapper.S
@@ -1682,3 +1682,11 @@ compat_sys_utimes_wrapper:
 	llgtr	%r2,%r2			# char *
 	llgtr	%r3,%r3			# struct compat_timeval *
 	jg	compat_sys_utimes
+
+	.globl	compat_sys_utimensat_wrapper
+compat_sys_utimensat_wrapper:
+	llgfr	%r2,%r2			# unsigned int
+	llgtr	%r3,%r3			# char *
+	llgtr	%r4,%r4			# struct compat_timespec *
+	lgfr	%r5,%r5			# int
+	jg	compat_sys_utimensat
Index: quilt-2.6/arch/s390/kernel/syscalls.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/syscalls.S
+++ quilt-2.6/arch/s390/kernel/syscalls.S
@@ -322,3 +322,5 @@ NI_SYSCALL							/* 310 sys_move_pages *
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
 SYSCALL(sys_epoll_pwait,sys_epoll_pwait,compat_sys_epoll_pwait_wrapper)
 SYSCALL(sys_utimes,sys_utimes,compat_sys_utimes_wrapper)
+NI_SYSCALL							/* 314 sys_fallocate */
+SYSCALL(sys_utimensat,sys_utimensat,compat_sys_utimensat_wrapper)	/* 315 */
Index: quilt-2.6/include/asm-s390/unistd.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/unistd.h
+++ quilt-2.6/include/asm-s390/unistd.h
@@ -251,8 +251,9 @@
 #define __NR_getcpu		311
 #define __NR_epoll_pwait	312
 #define __NR_utimes		313
-
-#define NR_syscalls 314
+/* Number 314 is reserved for new sys_fallocate */
+#define __NR_utimensat		315
+#define NR_syscalls 316
 
 /* 
  * There are some system calls that are not present on 64 bit, some
@@ -346,6 +347,19 @@
 
 #ifdef __KERNEL__
 
+#ifndef CONFIG_64BIT
+#define __IGNORE_select
+#else
+#define __IGNORE_time
+#endif
+
+/* Ignore NUMA system calls. Not wired up on s390. */
+#define __IGNORE_mbind
+#define __IGNORE_get_mempolicy
+#define __IGNORE_set_mempolicy
+#define __IGNORE_migrate_pages
+#define __IGNORE_move_pages
+
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
