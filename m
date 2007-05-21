Return-Path: <linux-kernel-owner+w=401wt.eu-S1762188AbXEULB3@vger.kernel.org>
Message-Id: <20070521110108.651341634@de.ibm.com>
References: <20070521105118.955425052@de.ibm.com>
Date: Mon, 21 May 2007 12:51:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/5] Wire up signald, timerfd and eventfd syscalls.
Content-Disposition: inline; filename=003-eventfd.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |   20 ++++++++++++++++++++
 arch/s390/kernel/syscalls.S       |    3 +++
 include/asm-s390/unistd.h         |    5 ++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_wrapper.S
+++ quilt-2.6/arch/s390/kernel/compat_wrapper.S
@@ -1690,3 +1690,23 @@ compat_sys_utimensat_wrapper:
 	llgtr	%r4,%r4			# struct compat_timespec *
 	lgfr	%r5,%r5			# int
 	jg	compat_sys_utimensat
+
+	.globl	compat_sys_signalfd_wrapper
+compat_sys_signalfd_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# compat_sigset_t *
+	llgfr	%r4,%r4			# compat_size_t
+	jg	compat_sys_signalfd
+
+	.globl	compat_sys_timerfd_wrapper
+compat_sys_timerfd_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# struct compat_itimerspec *
+	jg	compat_sys_timerfd
+
+	.globl	sys_eventfd_wrapper
+sys_eventfd_wrapper:
+	llgfr	%r2,%r2			# unsigned int
+	jg	sys_eventfd
Index: quilt-2.6/arch/s390/kernel/syscalls.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/syscalls.S
+++ quilt-2.6/arch/s390/kernel/syscalls.S
@@ -324,3 +324,6 @@ SYSCALL(sys_epoll_pwait,sys_epoll_pwait,
 SYSCALL(sys_utimes,sys_utimes,compat_sys_utimes_wrapper)
 NI_SYSCALL							/* 314 sys_fallocate */
 SYSCALL(sys_utimensat,sys_utimensat,compat_sys_utimensat_wrapper)	/* 315 */
+SYSCALL(sys_signalfd,sys_signalfd,compat_sys_signalfd_wrapper)
+SYSCALL(sys_timerfd,sys_timerfd,compat_sys_timerfd_wrapper)
+SYSCALL(sys_eventfd,sys_eventfd,sys_eventfd_wrapper)
Index: quilt-2.6/include/asm-s390/unistd.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/unistd.h
+++ quilt-2.6/include/asm-s390/unistd.h
@@ -253,7 +253,10 @@
 #define __NR_utimes		313
 /* Number 314 is reserved for new sys_fallocate */
 #define __NR_utimensat		315
-#define NR_syscalls 316
+#define __NR_signalfd		316
+#define __NR_timerfd		317
+#define __NR_eventfd		318
+#define NR_syscalls 319
 
 /* 
  * There are some system calls that are not present on 64 bit, some

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
