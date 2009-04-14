Return-Path: <linux-kernel-owner+w=401wt.eu-S1756453AbZDNNy3@vger.kernel.org>
Message-Id: <20090414135346.740757712@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/14] wire up preadv/pwritev system calls
Content-Disposition: inline; filename=002-preadv-pwritev.diff
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

 arch/s390/include/asm/unistd.h    |    4 +++-
 arch/s390/kernel/compat_wrapper.S |   18 ++++++++++++++++++
 arch/s390/kernel/syscalls.S       |    2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/include/asm/unistd.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/unistd.h
+++ quilt-2.6/arch/s390/include/asm/unistd.h
@@ -265,7 +265,9 @@
 #define __NR_pipe2		325
 #define __NR_dup3		326
 #define __NR_epoll_create1	327
-#define NR_syscalls 328
+#define	__NR_preadv		328
+#define	__NR_pwritev		329
+#define NR_syscalls 330
 
 /* 
  * There are some system calls that are not present on 64 bit, some
Index: quilt-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_wrapper.S
+++ quilt-2.6/arch/s390/kernel/compat_wrapper.S
@@ -1805,3 +1805,21 @@ compat_sys_keyctl_wrapper:
 	llgfr	%r5,%r5			# u32
 	llgfr	%r6,%r6			# u32
 	jg	compat_sys_keyctl	# branch to system call
+
+	.globl	compat_sys_preadv_wrapper
+compat_sys_preadv_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgtr	%r3,%r3			# compat_iovec *
+	llgfr	%r4,%r4			# unsigned long
+	llgfr	%r5,%r5			# u32
+	llgfr	%r6,%r6			# u32
+	jg	compat_sys_preadv	# branch to system call
+
+	.globl	compat_sys_pwritev_wrapper
+compat_sys_pwritev_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgtr	%r3,%r3			# compat_iovec *
+	llgfr	%r4,%r4			# unsigned long
+	llgfr	%r5,%r5			# u32
+	llgfr	%r6,%r6			# u32
+	jg	compat_sys_pwritev	# branch to system call
Index: quilt-2.6/arch/s390/kernel/syscalls.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/syscalls.S
+++ quilt-2.6/arch/s390/kernel/syscalls.S
@@ -336,3 +336,5 @@ SYSCALL(sys_inotify_init1,sys_inotify_in
 SYSCALL(sys_pipe2,sys_pipe2,sys_pipe2_wrapper) /* 325 */
 SYSCALL(sys_dup3,sys_dup3,sys_dup3_wrapper)
 SYSCALL(sys_epoll_create1,sys_epoll_create1,sys_epoll_create1_wrapper)
+SYSCALL(sys_preadv,sys_preadv,compat_sys_preadv_wrapper)
+SYSCALL(sys_pwritev,sys_pwritev,compat_sys_pwritev_wrapper)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
