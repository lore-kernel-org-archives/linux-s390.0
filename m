Return-Path: <linux-kernel-owner+w=401wt.eu-S965861AbXCLNur@vger.kernel.org>
Date: Mon, 12 Mar 2007 14:50:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] Wire up sys_utimes.
Message-ID: <20070312135050.GC11426@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Wire up sys_utimes.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    6 ++++++
 arch/s390/kernel/syscalls.S       |    1 +
 include/asm-s390/unistd.h         |    3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2007-03-12 13:53:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2007-03-12 13:53:02.000000000 +0100
@@ -1676,3 +1676,9 @@ compat_sys_epoll_pwait_wrapper:
 	llgf	%r0,164(%r15)		# compat_size_t
 	stg	%r0,160(%r15)
 	jg	compat_sys_epoll_pwait
+
+	.globl	compat_sys_utimes_wrapper
+compat_sys_utimes_wrapper:
+	llgtr	%r2,%r2			# char *
+	llgtr	%r3,%r3			# struct compat_timeval *
+	jg	compat_sys_utimes
diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2007-03-12 13:53:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2007-03-12 13:53:02.000000000 +0100
@@ -321,3 +321,4 @@ SYSCALL(sys_vmsplice,sys_vmsplice,compat
 NI_SYSCALL							/* 310 sys_move_pages */
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
 SYSCALL(sys_epoll_pwait,sys_epoll_pwait,compat_sys_epoll_pwait_wrapper)
+SYSCALL(sys_utimes,sys_utimes,compat_sys_utimes_wrapper)
diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/unistd.h	2007-03-12 13:53:02.000000000 +0100
@@ -250,8 +250,9 @@
 /* Number 310 is reserved for new sys_move_pages */
 #define __NR_getcpu		311
 #define __NR_epoll_pwait	312
+#define __NR_utimes		313
 
-#define NR_syscalls 313
+#define NR_syscalls 314
 
 /* 
  * There are some system calls that are not present on 64 bit, some
