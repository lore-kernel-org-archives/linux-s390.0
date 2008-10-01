Return-Path: <linux-kernel-owner+w=401wt.eu-S1754632AbYJAJEY@vger.kernel.org>
Message-Id: <20081001084128.764462323@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/21] s390: use sys_pause for 31bit pause entry point
Content-Disposition: inline; filename=113-sys-pause.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

sys32_pause is a useless copy of the generic sys_pause.                         
(and it's certainly not there for old sparc32 binaries..)

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_linux.c   |    8 --------
 arch/s390/kernel/compat_linux.h   |    1 -
 arch/s390/kernel/compat_wrapper.S |    2 --
 arch/s390/kernel/syscalls.S       |    2 +-
 4 files changed, 1 insertion(+), 12 deletions(-)

Index: quilt-2.6/arch/s390/kernel/compat_linux.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_linux.c
+++ quilt-2.6/arch/s390/kernel/compat_linux.c
@@ -608,14 +608,6 @@ asmlinkage long sys32_settimeofday(struc
 	return do_sys_settimeofday(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
 
-/* These are here just in case some old sparc32 binary calls it. */
-asmlinkage long sys32_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
 asmlinkage long sys32_pread64(unsigned int fd, char __user *ubuf,
 				size_t count, u32 poshi, u32 poslo)
 {
Index: quilt-2.6/arch/s390/kernel/compat_linux.h
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_linux.h
+++ quilt-2.6/arch/s390/kernel/compat_linux.h
@@ -206,7 +206,6 @@ long sys32_gettimeofday(struct compat_ti
 			struct timezone __user *tz);
 long sys32_settimeofday(struct compat_timeval __user *tv,
 			struct timezone __user *tz);
-long sys32_pause(void);
 long sys32_pread64(unsigned int fd, char __user *ubuf, size_t count,
 		   u32 poshi, u32 poslo);
 long sys32_pwrite64(unsigned int fd, const char __user *ubuf,
Index: quilt-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_wrapper.S
+++ quilt-2.6/arch/s390/kernel/compat_wrapper.S
@@ -128,8 +128,6 @@ sys32_alarm_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	jg	sys_alarm		# branch to system call
 
-#sys32_pause_wrapper			# void
-
 	.globl	compat_sys_utime_wrapper
 compat_sys_utime_wrapper:
 	llgtr	%r2,%r2			# char *
Index: quilt-2.6/arch/s390/kernel/syscalls.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/syscalls.S
+++ quilt-2.6/arch/s390/kernel/syscalls.S
@@ -37,7 +37,7 @@ SYSCALL(sys_stime,sys_ni_syscall,sys32_s
 SYSCALL(sys_ptrace,sys_ptrace,sys32_ptrace_wrapper)
 SYSCALL(sys_alarm,sys_alarm,sys32_alarm_wrapper)
 NI_SYSCALL							/* old fstat syscall */
-SYSCALL(sys_pause,sys_pause,sys32_pause)
+SYSCALL(sys_pause,sys_pause,sys_pause)
 SYSCALL(sys_utime,sys_utime,compat_sys_utime_wrapper)		/* 30 */
 NI_SYSCALL							/* old stty syscall */
 NI_SYSCALL							/* old gtty syscall */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
